<?php

namespace App\Services;

use App\Models\BaseModel;
use Exception;
use Illuminate\Support\Collection;
use Psr\Container\ContainerExceptionInterface;
use Psr\Container\NotFoundExceptionInterface;

class XmlFormHandlingService
{
    /**
     * Build an array of value-text options for a select input
     *
     * @param Collection $data
     * @return Collection
     */
    public static function buildSelectOptions(Collection $data): Collection
    {
        $firstItem = $data->first();

        if (
            $firstItem
            && is_object($firstItem)
            && isset($firstItem->value)
            && isset($firstItem->text)
        ) {
            return $data->sortBy('text');
        }

        $data->transform(
            function ($item, $key) {
                $item = (array)$item;
                $keys = array_keys($item);
                $tmp = new \stdClass();
                $tmp->value = $item[$keys[0]];
                $tmp->text = count($keys) > 1 ? $item[$keys[1]] : $tmp->value;

                return $item = $tmp;
            }
        );

        return $data->sortBy('text');
    }

    /**
     * Check the actual document list for certain controller
     * @param $name
     * @param $modal
     * @param $docList
     * @return void
     */
    public static function checkDocList($name, &$modal, &$docList)
    {
        $docPath = config('app.xml_form_path.doc');

        if (
            isset($docPath[$name])
            && $docs = app('files')->files($docPath[$name])
        ) {
            foreach ($docs as $doc) {
                $docName = $doc->getBasename('.' . $doc->getExtension());
                $modal[$docName] = false;
                $docList[$docName] = new \stdClass();
            }
        }
    }

    /**
     * Get form fields from XML-file.
     * @param string $dir
     * @param string $name
     * @param int $id
     * @return array[]
     * @throws ContainerExceptionInterface
     * @throws NotFoundExceptionInterface
     */
    public static function getFormFields(string $dir, string $name, int $id = 0): array
    {
        $dir = explode('.', $dir);
        $path = array_reduce(
            $dir,
            function ($carry, $item) {
                return $carry = $carry[$item];
            },
            config('app.xml_form_path')
        );
        $xmlFile = $path . to_pascal_case($name) . '.xml';

        return XmlFormHandlingService::parseFormFields($xmlFile, $id);
    }

    /**
     * Parse XML-form file to get array of form fields
     * @param string $xmlFile
     * @param int $id
     * @return array[]
     * @throws ContainerExceptionInterface
     * @throws NotFoundExceptionInterface
     * @throws Exception
     */
    public static function parseFormFields(string $xmlFile, int $id = 0): array
    {
        $formFields = [
            'requiredFields' => [],
        ];
        $fileSystem = app('files');

        if (!$fileSystem->missing($xmlFile)) {
            $xmlString = $fileSystem->get($xmlFile);
            $root = new \SimpleXMLElement($xmlString);

            if ($root->getName() != 'root') {
                return $formFields;
            }

            foreach ($root->attributes() as $key => $value) {
                $formFields[(string)$key]['name'] = $key;
                $formFields[(string)$key]['value'] = validate_boolean((string)$value);
                $formFields[(string)$key]['type'] = 'hidden';
            }

            $fields = $root->xpath('descendant-or-self::field');
            $hasTabs = false;

            foreach ($fields as $field) {
                $hasFieldGroup = false;
                $hasFieldSet = false;
                $fieldAttributes = $field->attributes();
                $fieldName = preg_replace('~[^\w\s]~', '', (string)$fieldAttributes['name']);
                $tmpField = [];

                foreach ($fieldAttributes as $key => $value) {
                    $key = (string)$key;
                    $value = validate_boolean((string)$value);
                    $tmpField[$key] = $value;
                    $tmpField['label'] = $tmpField['label'] ?? $tmpField['name'];

                    if ($key == 'required' && $value === true) {
                        $formFields['requiredFields'][] = $fieldName;
                    }
                }

                if ($id) {
                    static::parseFieldByModel($fieldAttributes, $id, $tmpField);
                }

                static::parseFieldByOptions($field, $fieldAttributes, $tmpField);
                static::addFieldToCollection($field, $fieldName, $formFields, $tmpField, $hasFieldGroup, $hasFieldSet);

                if (!$hasFieldGroup && !$hasFieldSet) {
                    $formFields[$fieldName] = $tmpField;
                }

                $hasTabs = $hasTabs ?: !!$hasFieldGroup;
            }

            $formFields['has_tabs'] = $hasTabs;
        }
        dd($formFields);
        return $formFields;
    }

    /**
     * Get field options|value using "model" attribute
     *
     * @param \SimpleXMLElement $fieldAttributes
     * @param int $id
     * @param array $tmp
     * @return void
     */
    public static function parseFieldByModel($fieldAttributes, $id, &$tmp)
    {
        if ($fieldAttributes['model']) {
            if ($fieldAttributes['type'] == 'select') {
                $tmp['options'] = BaseModel::getSingleSelectOptions($fieldAttributes['model']);
            } else {
                $tmp['value'] = BaseModel::getSingleValue($fieldAttributes['model'], $id);
            }
        }
    }

    /**
     * Get field options by "option" attribute
     *
     * @param \SimpleXMLElement $field
     * @param \SimpleXMLElement $fieldAttributes
     * @param array $tmp
     * @return void
     */
    public static function parseFieldByOptions($field, $fieldAttributes, &$tmp)
    {
        $options = $field->xpath('descendant::option');

        if ($options && $fieldAttributes['type'] == 'select') {
            foreach ($options as $option) {
                $optionAttributes = $option->attributes();
                $tmpOption = new \stdClass();
                $tmpOption->value = (string)$optionAttributes['value'];
                $tmpOption->text = (string)$optionAttributes['text'] ?: $tmpOption->value;
                $tmp['options'][] = $tmpOption;
            }

            $tmp['options'] = collect($tmp['options']);
        }
    }

    /**
     * Add field to collection
     *
     * @param \SimpleXMLElement $field
     * @param string $fieldName
     * @param array $formFields
     * @param array $tmpField
     * @param bool $hasAncestor
     * @return void
     */
    public static function addFieldToCollection($field,
                                                $fieldName,
                                                &$formFields,
                                                &$tmpField,
                                                &$hasFieldGroup,
                                                &$hasFieldSet)
    {
        $hasFieldGroup = $field->xpath('ancestor::fieldgroup[@name]/@name');
        $hasFieldSet = $field->xpath('ancestor::fieldset[@name]/@name');

        $fieldGroupName = null;
        $fieldGroupShow = null;
        $fieldSetName = null;
        $fieldSetShow = null;
        $fieldSetRepeatable = null;
        $tmpSet = [];

        if ($hasFieldSet) {
            $fieldSetName = strval($hasFieldSet[0]);
            $tmpSet[$fieldName] = $tmpField;
            $fieldSetShow = $field->xpath('ancestor::fieldset[@name]/@show');
            $fieldSetShow = $fieldSetShow ? validate_boolean((string)$fieldSetShow[0], true) : false;
            $fieldSetRepeatable = $field->xpath('ancestor::fieldset[@name]/@repeatable');
            $fieldSetRepeatable = $fieldSetRepeatable ? validate_boolean((string)$fieldSetRepeatable[0], true) : false;
        }

        if ($hasFieldGroup) {
            $fieldGroupName = strval($hasFieldGroup[0]);
            $fieldGroupShow = $field->xpath('ancestor::fieldgroup[@name]/@show');
            $fieldGroupShow = $fieldGroupShow ? validate_boolean((string)$fieldGroupShow[0], true) : false;
            $formFields[$fieldGroupName]['type'] = 'fieldgroup';
            $formFields[$fieldGroupName]['show'] = $fieldGroupShow;

            if ($tmpSet) {
                $formFields[$fieldGroupName][$fieldSetName]['type'] = 'fieldset';
                $formFields[$fieldGroupName][$fieldSetName]['show'] = $fieldSetShow;
                $formFields[$fieldGroupName][$fieldSetName]['repeatable'] = $fieldSetRepeatable;
                $formFields[$fieldGroupName][$fieldSetName] =
                    array_merge_recursive($formFields[$fieldGroupName][$fieldSetName], $tmpSet);
                $tmpSet = [];
            } else {
                $formFields[$fieldGroupName][$fieldName] = $tmpField;
            }
        }

        if ($tmpSet) {
            $formFields[$fieldSetName]['type'] = 'fieldset';
            $formFields[$fieldSetName]['show'] = $fieldSetShow;
            $formFields[$fieldSetName]['repeatable'] = $fieldSetRepeatable;
            $formFields[$fieldSetName] = array_merge_recursive($formFields[$fieldSetName], $tmpSet);
        }
    }
}
