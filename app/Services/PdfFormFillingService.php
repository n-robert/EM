<?php

namespace App\Services;

use App\Models\Address;
use App\Models\Country;
use App\Models\Employee;
use App\Models\Employer;
use App\Models\Occupation;
use App\Models\Permit;
use App\Models\Type;
use Carbon\Carbon;
use Illuminate\Support\Arr;
use mikehaertl\pdftk\Pdf;

class PdfFormFillingService
{
    static $actions = [
        'RENEW'  => 'renew',
        'ISSUE'  => 'issue',
        'EXTEND' => 'extend'
    ];

    static $visaTypes = [
        'MULTI'     => 'multi',
        'DOUBLE'    => 'double',
        'SINGLE'    => 'single',
        'RESIDENT'  => 'resident',
        'TRANSIT'   => 'transit',
        'COMMON'    => 'common',
        'PRIVATE'   => 'private',
        'BUSINESS'  => 'business',
        'STUDY'     => 'study',
        'WORK'      => 'work',
        'HUMAN'     => 'human',
        'TOURIST'   => 'tourist',
        'GROUP'     => 'group',
        'IMMIGRANT' => 'immigrant',
        'SERVICE'   => 'service',
        'OTHER'     => 'other'
    ];

    static $residenceTypes = [
        'RESIDENT_CARD'              => 'residence',
        'TEMPORARY_RESIDENT_LICENSE' => 'temporary_residence'
    ];

    static $genders = [
        'MALE'   => 'male',
        'FEMALE' => 'female'
    ];

    static $employerTypes = [
        'LEGAL_RUS'      => 'legal',
        'LEGAL_SEMI'     => 'legal',
        'INDIVIDUAL'     => 'individual',
        'FOREIGN_REP'    => 'foreign_rep',
        'LAWYER'         => 'lawyer',
        'FOREIGN_BRANCH' => 'foreign_branch',
        'PRIVATE'        => 'russian_individual',
        'NOTARY'         => 'notary',
        'OTHER'          => 'other'
    ];

    static $hostTypes = [
        'LEGAL_RUS'      => 'legal',
        'LEGAL_SEMI'     => 'legal',
        'INDIVIDUAL'     => 'individual',
        'FOREIGN_REP'    => 'legal',
        'LAWYER'         => 'legal',
        'FOREIGN_BRANCH' => 'legal',
        'PRIVATE'        => 'individual',
        'NOTARY'         => 'legal',
        'OTHER'          => 'legal'
    ];

    static $CIS = [
        15,
        140,
        209,
        229
    ];

    static $EACU = [
        11,
        20,
        109,
        115
    ];

    /**
     * @param $user_ids
     * @param $main_user
     * @param $limited_users
     * @param $tables
     * @return bool|void
     */
    public static function addRelatedRecords($user_ids, $main_user, $limited_users, $tables)
    {
        if (!is_array($user_ids)) {
            $user_ids = [$user_ids];
        }

        if (empty($user_ids) || empty($tables)) {
            return;
        }

        $db = Factory::getDbo();
        $addrress_column =
            [
                'addresses' => 'id',
                'employee'  => 'reg_address'
            ];
        $employer_column =
            [
                'employers' => 'id',
                'employee'  => 'employer_id'
            ];

        foreach ($user_ids as $user_id) {
            $limited_addresses = [];
            $limited_employers = [];
            $user_tables = $tables;

            if (!empty($limited_users)) {
                foreach ($limited_users as $limited_user) {
                    if ($limited_user['user_id'] == $user_id) {
                        $limited_addresses =
                            isset($limited_user['limited_addresses']) ? $limited_user['limited_addresses'] :
                                $limited_addresses;
                        $limited_employers =
                            isset($limited_user['limited_employers']) ? $limited_user['limited_employers'] :
                                $limited_employers;
                        break;
                    }
                }
            }

            if (!empty($limited_addresses) || !empty($limited_employers)) {
                $user_tables = ['addresses', 'employee', 'employers'];
            }

            foreach ($user_tables as $table) {
                $query = $db->getQuery(true);

                $where_pattern_1 = '"';
                $where_pattern_1 .= '^' . $main_user . '$';
                $where_pattern_1 .= '|';
                $where_pattern_1 .= '^' . $main_user . ',';
                $where_pattern_1 .= '|';
                $where_pattern_1 .= ',' . $main_user . ',';
                $where_pattern_1 .= '|';
                $where_pattern_1 .= ',' . $main_user . '$';
                $where_pattern_1 .= '"';

                $concat = $db->QuoteName('user_ids');
                $concat .= ', ';
                $concat .= '"';
                $concat .= ',' . $user_id;
                $concat .= '"';

                $where_pattern_2 = '"';
                $where_pattern_2 .= '^' . $user_id . '$';
                $where_pattern_2 .= '|';
                $where_pattern_2 .= '^' . $user_id . ',';
                $where_pattern_2 .= '|';
                $where_pattern_2 .= ',' . $user_id . ',';
                $where_pattern_2 .= '|';
                $where_pattern_2 .= ',' . $user_id . '$';
                $where_pattern_2 .= '"';

                $query
                    ->update($db->QuoteName('#__fmsdocs_' . $table))
                    ->set(
                        $db->QuoteName('user_ids') . ' = CONCAT(' . $concat . ')'
                    )
                    ->where($db->QuoteName('user_ids') . ' REGEXP ' . $where_pattern_1)
                    ->where($db->QuoteName('user_ids') . ' NOT REGEXP ' . $where_pattern_2);

                if (!empty($limited_addresses) && isset($addrress_column[$table])) {
                    $query->where(
                        $db->QuoteName($addrress_column[$table]) . 'IN(' . implode(', ', $limited_addresses) . ')'
                    );
                }

                if (!empty($limited_employers) && isset($employer_column[$table])) {
                    $query->where(
                        $db->QuoteName($employer_column[$table]) . 'IN(' . implode(', ', $limited_employers) . ')'
                    );
                }

                $db->setQuery($query)->execute();
            }
        }

        return true;
    }

    public static function checkRequiredValues()
    {
        $args = func_get_args();

        for ($i = 4; $i < count($args); $i++) {
            if (!($args[$i])) {
                $url = 'index.php?option=com_fmsdocs&view=' . $args[1] . '&mode=' . $args[3] . '&id=' . $args[2];
                $url = $args[0]->isClient('administrator') ? $url : Route::_($url);
                $args[0]->redirect($url);
            }
        }
    }

    /**
     * Method to decline word suffix
     * @param String $string
     * @param Integer $case (2, 3, 4, 5, 6)
     * @param String $gender (MALE, FEMALE)
     * @param String $type (empty, name)
     * @param Integer $affected - how many words will be declined
     * @param Boolean $uc - whether to decline uppercase words
     * @return String
     */
    public static function declension($string, $case, $gender = '', $type = '', $affected = 0, $uc = false)
    {
        if ($case < 2 || $case > 6) {
            return $string;
        }

        $type = strtoupper($type);
        $patterns = [];
        $suffixes = [];
        $string = explode(' ', trim($string));
        $affected = $affected ?: count($string);
        $n = 0;

        if ($string[0] == __('REPUBLIC')) {
            $gender = 'FEMALE';
            $affected = 1;
        }

        if (!empty($gender)) {
            $gender = strtoupper($gender);
            $patterns[$gender] = explode(',', __($gender . '_SUFFIXES_' . $type . '1'));
            $suffixes[$gender] = explode(',', __($gender . '_SUFFIXES_' . $type . $case));
        } else {
            $patterns['FEMALE'] = explode(',', __('FEMALE_SUFFIXES_' . $type . '1'));
            $patterns['MALE'] = explode(',', __('MALE_SUFFIXES_' . $type . '1'));
            $suffixes['FEMALE'] = explode(',', __('FEMALE_SUFFIXES_' . $type . $case));
            $suffixes['MALE'] = explode(',', __('MALE_SUFFIXES_' . $type . $case));
        }

        while ($n < $affected) {
            if (!$uc && mb_strtoupper($string[$n]) == $string[$n]) {
                $n++;
                continue;
            }

            foreach ($patterns as $gender => $array) {
                foreach ($array as $key => $value) {
                    $pattern = '#^(.+)(' . trim($value) . ')$#u';
                    $replacement = '$1' . trim($suffixes[$gender][$key]);

                    if (preg_match($pattern, $string[$n])) {
                        $string[$n] = preg_replace($pattern, $replacement, $string[$n]);
                        $patterns = [$gender => $patterns[$gender]];
                        $suffixes = [$gender => $suffixes[$gender]];
                        break 2;
                    }
                }
            }

            $n++;
        }

        return implode(' ', $string);
    }

    public static function deleteFile($app, $input, $model, $view, $id, $template)
    {
        $file_name = $input->get('file_name', '');
        $file = JPATH_ROOT . '/components/com_fmsdocs/files/' . $view . '/' . $id . '/' . $file_name;

        try {
            if (!File::delete($file)) {
                throw new Exception(Text::sprintf('FILE_NOT_DELETED', $file_name));
            }

            $db = Factory::getDbo();
            $query = $db->getQuery(true);

            $query
                ->delete('#__fmsdocs_files')
                ->where('file_folder = "' . $view . '"')
                ->where('item_id = ' . $id)
                ->where('file_name = "' . $file_name . '"');
            $db->setQuery($query)->execute();

            $app->enqueueMessage(Text::sprintf('FILE_DELETE_SUCCEED', $file_name));
        } catch (Exception $e) {
            $app->enqueueMessage($e->getMessage(), 'error');
        }
    }

    public static function downloadFile($app, $input, $model, $view, $id, $template)
    {
        $file_name = $input->get('file_name', '');
        $extension = pathinfo($file_name)['extension'];
        $mime_types =
            [
                'zip'  => 'application/zip',
                'doc'  => 'application/msword',
                'docx' => 'application/msword',
                'pdf'  => 'application/pdf',
                'gif'  => 'image/gif',
                'png'  => 'image/png',
                'jpg'  => 'image/jpg',
                'jpeg' => 'image/jpg'
            ];
        $file = JPATH_ROOT . '/components/com_fmsdocs/files/' . $view . '/' . $id . '/' . $file_name;

        ob_end_clean();
        header('Content-Description: File Transfer');
        header('Content-Type: ' . $mime_types[$extension]);
        header('Content-Transfer-Encoding: Binary');
        header('Content-Disposition: attachment; filename="' . $file_name . '"');

        try {
            echo File::read($file);
        } catch (Exception $e) {
            $app->enqueueMessage($e->getMessage(), 'error');
        }
    }

    public static function formzRu($url, $input, $id, $model, $shipment_model, $app)
    {
        $company = $model->getItem($id, true);
//		echo '<pre>', print_r($company), '</pre>'; exit;
        $director_name =
            $company->director_last_name_ru . ' ' .
            mb_substr($company->director_first_name_ru, 0, 1) . '.' .
            mb_substr($company->director_middle_name_ru, 0, 1) . '.';
        $booker_name =
            $company->booker_last_name_ru . ' ' .
            mb_substr($company->booker_first_name_ru, 0, 1) . '.' .
            mb_substr($company->booker_middle_name_ru, 0, 1) . '.';
        $client = $model->getItem($input->post->get('client_id', null, 'int'), true);

        $raw_data = file_get_contents('php://input');
        $data = $raw_data;
        $data .= '&company_name=' . $company->name_ru;
        $data .= '&company_inn=' . $company->taxpayer_id;
        $data .= '&company_kpp=' . $company->taxpayer_code;
        $data .= '&company_address=' . $company->address_name;
        $data .= '&company_director=' . $director_name;
        $data .= '&company_glavbuh=' . $booker_name;
        $data .= '&doc_nds_value=0';
        $data .= '&client_name=' . $client->name_ru;
        $data .= '&client_inn=' . $client->taxpayer_id;
        $data .= '&client_kpp=' . $client->taxpayer_code;
        $data .= '&client_address=' . $client->address_name;

        $ch = curl_init();
        $url .= $input->post->get('doc_type', '', 'string');

        curl_setopt($ch, CURLOPT_URL, $url);
        curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
        curl_setopt($ch, CURLOPT_POSTFIELDS, $data);

        if ($result = curl_exec($ch)) {
            curl_close($ch);

            $raw_data = preg_replace('~(items\..+?)=~', '$1[]=', $raw_data);
            parse_str($raw_data, $output);
            $items = [];

            foreach ($output['items_name'] as $k => $v) {
                $items[$k]['items_name'] = $v;
                $items[$k]['items_units'] = $output['items_units'][$k];
                $items[$k]['items_quantity'] = $output['items_quantity'][$k];
                $items[$k]['items_price'] = $output['items_price'][$k];
                $items[$k]['items_total_price'] = $output['items_total_price'][$k];
            }

            $data = [];
            $data['data'] = json_encode($items);
            $keys = ['doc_number', 'doc_date', 'company_id', 'client_id'];

            foreach ($keys as $key) {
                $data[$key] = $input->post->get($key);
            }

            $shipment_model->save($data);

            header('Cache-Control: public');
            header('Content-type: application/pdf');
            header('Content-Length: ' . strlen($result));
            exit($result);
        }

        curl_close($ch);
    }

    /**
     * Get available actions for current user
     * @return CMSObject
     */
    public static function getActions()
    {
        $user = Factory::getUser();
        $result = new CMSObject;
        $assetName = 'com_fmsdocs';
        $file = JPATH_ADMINISTRATOR . '/components/' . $assetName . '/access.xml';
        $actions = Access::getActionsFromFile($file);

        foreach ($actions as $action) {
            $result->set($action->name, $user->authorise($action->name, $assetName));
        }

        return $result;
    }

    public static function getAllUsers()
    {
        $db = Factory::getDbo();
        $query = $db->getQuery(true);
        $query
            ->select($db->QuoteName('id'))
            ->from($db->QuoteName('#__users'))
            ->where($db->QuoteName('block') . ' = 0');
        $db->setQuery($query);

        return $db->loadColumn();
    }

    /**
     * Get data fields
     * @param string $doc
     * @return array
     */
    public static function getDataFields($doc)
    {
        $pdf = new Pdf(static::getTemplate($doc));
        $dataFields = $pdf->getDataFields()->__toArray();

        foreach ($dataFields as $key => $field) {
            $dataFields[$field['FieldName']] = $field;
            unset($dataFields[$key]);
        }

        return $dataFields;
    }

    public static function getEmailRecipientsByEmployee($employee)
    {
        $this_user = Factory::getUser();
        $user_ids = is_array($employee->user_ids) ? $employee->user_ids : explode(',', $employee->user_ids);
        $user_ids = array_diff($user_ids, [$this_user->id]);
        $recipients = [];
        $recipient_names = [];
        $recipient_emails = [];

        foreach ($user_ids as $user_id) {
            $user = Factory::getUser($user_id);
            $recipient_names[] = $user->name;
            $recipient_emails[] = trim($user->email);
        }

        $recipients['recipient_names'] = $recipient_names;
        $recipients['recipient_emails'] = $recipient_emails;

        return $recipients;
    }

    public static function getEmailRecipientsByUser($user = null)
    {
        $user = !is_null($user) ? $user : Factory::getUser();
        $recipients = [];
        $recipient_ids = [];
        $recipient_names = [];
        $recipient_emails = [];

        if ($user->authorise('core.admin')) {
            $recipient_ids = self::getAllUsers();
        } else {
            $related_groups = self::getRelatedGroups();
            $limited_users = self::getLimitedUsers();
            $tmp = [];

            if (!empty($limited_users)) {
                foreach ($limited_users as $limited_user) {
                    $tmp[] = $limited_user['user_id'];
                }
            }

            $limited_users = $tmp;

            foreach ($related_groups as $group) {
                if (
                    isset($group['related']) &&
                    ($user->id == $group['main'] || in_array($user->id, $group['related']))
                ) {
                    $recipient_ids =
                        in_array($user->id, $group['related']) ?
                            array_diff($group['related'], $limited_users) :
                            $group['related'];
                    $recipient_ids[] = $group['main'];

                    break;
                }
            }
        }

        $key = array_search($user->id, $recipient_ids);

        if ($key !== false) {
            unset($recipient_ids[$key]);
        }

        if (!empty($recipient_ids)) {
            foreach ($recipient_ids as $recipient_id) {
                $recipient = Factory::getUser($recipient_id);
                $recipient_names[] = $recipient->name;
                $recipient_emails[] = trim($recipient->email);
            }
        }

        $recipients['recipient_names'] = $recipient_names;
        $recipients['recipient_emails'] = $recipient_emails;

        return $recipients;
    }

    public static function getFileName($item, $template, $lowercase = false)
    {
        $file_name = $item->last_name_ru . ' ' . $item->first_name_ru;
        $file_name .= '_' . __('APPLY_' . strtoupper($template));
        $file_name .= '_' . date('dmy_His', time());

        return ($lowercase ? str_replace(' ', '_', mb_strtolower($file_name)) : $file_name) . '.pdf';
    }

    public static function getOccupations()
    {
        $db = Factory::getDbo();
        $query = $db->getQuery(true);
        $query
            ->select($db->QuoteName('id'))
            ->select($db->QuoteName('name'))
            ->from($db->QuoteName('#__fmsdocs_occupations'));
        $occupations = $db
            ->setQuery($query)
            ->loadAssocList('id', 'name');

        return $occupations;
    }

    /**
     * Get splited fields
     * @param string $doc
     * @param array $data
     * @return array
     */
    public static function getSplitFields($doc, $data, $docData = null)
    {
        $options = [];
        $options['justify'] = $docData['justify'] ?? true;
        $options['split_word'] = $docData['split_word'] ?? false;
        $options['cells'] = $docData['cells'] ?? false;

        $dataFields = static::getDataFields($doc);
        $splitFields = array_intersect_ukey(
            $data,
            $dataFields,
            function ($dataKey, $dataFieldKey) {
                if (preg_match('~^' . $dataKey . '_\d$~', $dataFieldKey)) {
                    return 0;
                } elseif ($dataKey > $dataFieldKey) {
                    return 1;
                } else {
                    return -1;
                }
            }
        );

        array_walk(
            $splitFields,
            function (&$value, $key) use ($options) {
                $value = ['text' => $value, 'options' => $options];
            }
        );

        return $splitFields;
    }

    public static function getTemplate($doc)
    {
        return config('app.pdf_template_path') . $doc . '.pdf';
    }

    public static function handlePhones($phones, $code = '', $key = null, $no_spaces = true, $delimiter = ',')
    {
        if (!is_array($phones)) {
            $phones = explode($delimiter, $phones);
        }

        foreach ($phones as &$phone) {
            $phone = $no_spaces ? str_replace(' ', '', $phone) : trim($phone);
            $phone = preg_replace('#^\s*(\+7|8)\s*(.*)$#', $code . '$2', $phone);
        }

        $result = !is_null($key) ? $phones[$key] : implode($delimiter . ' ', $phones);

        return $result;
    }

    public static function loadModalTemplate($layout, $view = null, $input = null)
    {
        try {
            ob_start();
            include __DIR__ . '/layouts/' . $layout . '.php';
            $output = ob_get_contents();
            ob_end_clean();
        } catch (\Exception $e) {
            $output = $e->getMessage();
        }

        return $output;
    }

    public static function parseAddress($address, $typeRequired = true)
    {
        $parts = explode(',', $address);

        $patterns = [
            'region'      => __('REGEXP_REGION'),
            'city'        => __('REGEXP_CITY'),
            'district'    => __('REGEXP_DISTRICT'),
            'street'      => __('REGEXP_STREET'),
            'house'       => __('REGEXP_HOUSE_1') . '|' . __('REGEXP_HOUSE_2') . '|' . __('REGEXP_HOUSE_3'),
            'building'    => __('REGEXP_BUILDING'),
            'subBuilding' => __('REGEXP_SUB_BUILDING'),
            'room'        => __('REGEXP_ROOM_1') . '|' . __('REGEXP_ROOM_2') . '|' . __('REGEXP_ROOM_3'),
        ];

        $houseVariants = [
            'HOUSE_1' => 'REGEXP_HOUSE_1',
            'HOUSE_2' => 'REGEXP_HOUSE_2',
            'HOUSE_3' => 'REGEXP_HOUSE_3',
        ];

        $roomVariants = [
            'ROOM_1' => 'REGEXP_ROOM_1',
            'ROOM_2' => 'REGEXP_ROOM_2',
            'ROOM_3' => 'REGEXP_ROOM_3',
        ];

        $result = [
            'region'      => '',
            'city'        => '',
            'district'    => '',
            'street'      => '',
            'house'       => '',
            'building'    => '',
            'subBuilding' => '',
            'room'        => '',
            'houseType'   => '',
            'roomType'    => '',
        ];

        foreach ($parts as $key => $string) {
            $string = trim($string);

            foreach ($patterns as $varName => $expr) {
                $expr = '#(?:^|\s)(' . $expr . ')(?:$|\s*)#ui';

                if (preg_match($expr, $string, $matches)) {
                    if ($varName == 'house' || $varName == 'room') {
                        $varVariants = $varName . 'Variants';
                        $varType = $varName . 'Type';

                        foreach ($$varVariants as $type => $variants) {
                            $type = __($type);
                            $variants = str_replace(['\.', '\s'], ['.', ''], __($variants));
                            $variants = explode('|', $variants);

                            $found = array_intersect($matches, $variants);

                            if (in_array($matches[1], $found)) {
                                $result[$varType] = $typeRequired ? $type : trim($matches[1]);
                                $result[$varName] = trim(str_replace($matches[1], '', $string));
                                break;
                            }
                        }
                    } elseif ($varName == 'building' || $varName == 'subBuilding') {
                        $result[$varName] = trim(str_replace($matches[1], '', $string));
                    } else {
                        $result[$varName] = $string;
                    }

                    unset($parts[$key]);
                    unset($patterns[$varName]);
                    break;
                }
            }

            if (isset($parts[$key]) && is_numeric($string)) {
                $result['zip_code'] = $string;
                unset($parts[$key]);
                unset($patterns[$varName]);
            }
        }

        $result['locality'] = trim(implode(', ', $parts));

        return $result;
    }

    public static function parseDate($date, $full_format_month = false, $format = 'd-m-Y', $delimiter = '-')
    {
        $date = str_replace(['.', '/'], '-', $date);
        $tmp = explode($delimiter, $date);
        $format_array = explode('-', strtolower($format));
        $format_array = array_flip($format_array);

        $date
            = !empty(array_sum($tmp)) ?
            explode($delimiter, date($format, strtotime($date))) :
            ['', '', ''];
        $date[$format_array['m']] =
            (!empty(array_sum($tmp)) && $full_format_month) ?
                __('MONTH_' . $date[$format_array['m']]) : $date[$format_array['m']];

        return $date;
    }

    /**
     * Split fields to fit rows
     * @param string $doc
     * @param $docData
     * @param array $data
     * @return array $data
     */
    public static function populateSplitFields($doc, $docData, $data)
    {
        if (isset($docData['upper_case']) && validate_boolean($docData['upper_case'], true)) {
            $data = to_upper_case($data);
        }

        $splitFields = static::getSplitFields($doc, $data, $docData);
        $dataFields = static::getDataFields($doc);

        foreach ($splitFields as $key => $value) {
            $count = 1;
            $rows = [];

            while (isset($dataFields[$key . '_' . $count])) {
                $rows[] = $dataFields[$key . '_' . $count]['FieldMaxLength'];
                $count++;
            }

            $options = $value['options'];

            static::splitText(
                $value['text'],
                $key,
                $data,
                $options['justify'],
                $options['split_word'],
                $options['cells'],
                $count - 1,
                $rows
            );
        }

        return $data;
    }

    public static function printArrivalNotice($docData, $doc, $id)
    {
        $employee = Employee::find($id);
        $citizenship = Country::find($employee->citizenship_id);
        $birthPlace = implode(' ', array_filter([$citizenship->name_ru, $employee->birth_place]));
        $occupation = Occupation::find($employee->occupation_id);
        $occupation = $occupation ? $occupation->nam_ru : '';

        $employer = Employer::find($employee->employer_id);
        $employerType = Type::find($employer->type_id)->name_ru;
        $employerAddress = Address::find($employer->address_id)->name_ru;
        $director = Employee::find($employer->director_id);

        $regAddress = Address::find($employee->reg_address_id);
        $usage_permit = '';
        $ownershipCertificates = json_decode($regAddress->ownership_certificate, true);

        if ($ownershipCertificates && $ownershipCertificates['employer_id'] && $ownershipCertificates['certificate']) {
            $ownershipCertificates =
                array_combine($ownershipCertificates['employer_id'], $ownershipCertificates['certificate']);
            $usage_permit = $ownershipCertificates[$employer->id];
        }

        $regAddress = self::parseAddress($regAddress->name_ru);
        $destinationCity = implode(', ', array_filter([$regAddress['city'], $regAddress['locality']]));

        $directorAddress = self::parseAddress($director->address);
        $directorCity = array_filter([$directorAddress['city'], $directorAddress['locality']]);

        $passport = __('PASSPORT');

        $representatives = '';
        $existingAddress = '';

        $history = json_decode($employee->history, true);
        $prevValues = $history['prev_value'];

        for ($n = count($prevValues) - 1; $n > -1; $n--) {
            foreach (explode(PHP_EOL, $prevValues[$n]) as $prevValue) {
                if (strpos($prevValue, 'reg_address_name') === 0) {
                    $existingAddress = explode(':', $prevValue)[1];
                    break;
                }
            }

            if (!empty($existingAddress)) {
                break;
            }
        }

        $data =
            [
                'last_name_ru'                               => $employee->last_name_ru,
                'first_name_ru'                              => $employee->first_name_ru,
                'middle_name_ru'                             => $employee->middle_name_ru,
                'guest_last_name_ru'                         => $employee->last_name_ru,
                'guest_first_name_ru'                        => $employee->first_name_ru,
                'guest_middle_name_ru'                       => $employee->middle_name_ru,
                'citizenship'                                => $citizenship->name_ru,
                'guest_citizenship'                          => $citizenship->name_ru,
                self::$genders[$employee->gender]            => 'X',
                'guest_' . self::$genders[$employee->gender] => 'X',
                'passport'                                   => $passport,
                'guest_passport'                             => $passport,
                'passport_serie'                             => $employee->passport_serie,
                'guest_passport_serie'                       => $employee->passport_serie,
                'passport_number'                            => $employee->passport_number,
                'guest_passport_number'                      => $employee->passport_number,
                'phone'                                      => self::handlePhones($employee->phone),
                'occupation'                                 => $occupation,
                'migr_card_serie'                            => $employee->migr_card_serie,
                'migr_card_number'                           => $employee->migr_card_number,
                'destination_district'                       => $regAddress['district'],
                'actual_destination_district'                => $regAddress['district'],
                'guest_destination_district'                 => $regAddress['district'],
                'destination_city'                           => $destinationCity,
                'actual_destination_city'                    => $destinationCity,
                'guest_destination_city'                     => $destinationCity,
                'destination_street'                         => $regAddress['street'],
                'guest_destination_street'                   => $regAddress['street'],
                'destination_house_type'                     => $regAddress['houseType'],
                'guest_destination_house_type'               => $regAddress['houseType'],
                'destination_house'                          => $regAddress['house'],
                'guest_destination_house'                    => $regAddress['house'],
                'destination_building'                       => $regAddress['building'],
                'guest_destination_building'                 => $regAddress['building'],
                'destination_sub_building'                   => $regAddress['subBuilding'],
                'guest_destination_sub_building'             => $regAddress['subBuilding'],
                'destination_room_type'                      => $regAddress['roomType'],
                'guest_destination_room_type'                => $regAddress['roomType'],
                'destination_room'                           => $regAddress['room'],
                'guest_destination_room'                     => $regAddress['room'],
                self::$hostTypes[$employerType]              => 'X',
                'director_last_name'                         => $director->last_name_ru,
                'director_first_name'                        => $director->first_name_ru,
                'director_middle_name'                       => $director->middle_name_ru,
                'host_last_name'                             => $director->last_name_ru,
                'host_first_name'                            => $director->first_name_ru,
                'host_middle_name'                           => $director->middle_name_ru,
                'director_passport'                          => $passport,
                'director_passport_serie'                    => $director->passport_serie,
                'director_passport_number'                   => $director->passport_number,
                'director_district'                          => $directorAddress['district'],
                'director_city'                              => implode(', ', $directorCity),
                'director_street'                            => $directorAddress['street'],
                'director_house'                             => $directorAddress['house'],
                'director_building'                          => $directorAddress['building'],
                'director_sub_building'                      => $directorAddress['subBuilding'],
                'director_room'                              => $directorAddress['room'],
                'director_phone'                             => self::handlePhones($director->phone),
                'employer_taxpayer_id'                       => $employer->taxpayer_id,
                'birth_place'                                => $birthPlace,
                'guest_birth_place'                          => $birthPlace,
                'destination_region'                         => $regAddress['region'],
                'actual_destination_region'                  => $regAddress['region'],
                'guest_destination_region'                   => $regAddress['region'],
                'usage_permit'                               => $usage_permit,
                'representatives'                            => $representatives,
                'existing_address'                           => $existingAddress,
                'director_region'                            => $directorAddress['region'],
                'employer_name'                              => $employer->name_ru,
                'employer_address'                           => $employerAddress,
            ];

        $visaCategory = 'WORK';

        if ($employee->resident_document) {
            $data[self::$residenceTypes[$employee->resident_document]] = 'X';
            $data['resident_permit_serie'] = $employee->resident_document_serie;
            $data['resident_permit_number'] = $employee->resident_document_number;
        }

        if ($employee->visa_number) {
            $data['visa'] = 'X';
            $visaCategory = $employee->visa_category ?: $visaCategory;
            $data['resident_permit_serie'] = $employee->visa_serie;
            $data['resident_permit_number'] = $employee->visa_number;
        }


        $data[self::$visaTypes[$visaCategory]] = 'X';

        $dates =
            [
                'birth'                     => $employee->birth_date,
                'guest_birth'               => $employee->birth_date,
                'passport_issued'           => $employee->passport_issued_date,
                'guest_passport_issued'     => $employee->passport_issued_date,
                'passport_expired'          => $employee->passport_expired_date,
                'guest_passport_expired'    => $employee->passport_expired_date,
                'visa_issued'               => $employee->visa_issued_date,
                'visa_expired'              => $employee->visa_expired_date,
                'entry'                     => $employee->entry_date,
                'stay_until'                => $employee->visa_expired_date,
                'guest_stay_until'          => $employee->visa_expired_date,
                'director_passport_issued'  => $director->passport_issued_date,
                'director_passport_expired' => $director->passport_expired_date,
            ];

        self::splitDate($dates, $data);

        return static::populateSplitFields($doc, $docData, $data);
    }

    public static function printDepartureNotice($app, $input, $model, $view, $id, $template = 'departurenotice')
    {
        $departure_date = $input->post->get('departure_date', '', 'string');

        self::checkRequiredValues($app, $view, $id, $template, $departure_date);

        $item = $model->getItem($id, true, false, true);
        $file_name = self::getFileName($item, $template);
        $first_middle_name_ru = implode(' ', array_filter([$item->first_name_ru, $item->middle_name_ru]));

        $director = $model->getItem($item->director);
        $director_first_middle_name = implode(' ', array_filter([$director->first_name_ru, $director->middle_name_ru]));
        $rep_id = $input->post->get('rep_id', '', 'int') ?: $item->director;
        $rep = $model->getItem($rep_id);

        $reg_address = self::parseAddress($item->reg_address_name);
        $city = array_filter([$reg_address['city'], $reg_address['locality']]);

        $fields =
            [
                'file_name'                       => $file_name,
                'last_name_ru_1'                  => $item->last_name_ru,
                'last_name_ru_2'                  => $item->last_name_ru,
                'first_middle_name_ru_1'          => $first_middle_name_ru,
                'first_middle_name_ru_2'          => $first_middle_name_ru,
                'region_1'                        => $reg_address['region'],
                'district_1'                      => $reg_address['district'],
                'city_1'                          => implode(', ', $city),
                'street_1'                        => $reg_address['street'],
                'house_1'                         => $reg_address['house'],
                'building_1'                      => $reg_address['building'],
                'sub_building_1'                  => $reg_address['subBuilding'],
                'room_1'                          => $reg_address['room'],
                'director_last_name_ru_1'         => $director->last_name_ru,
                'director_first_middle_name_ru_1' => $director_first_middle_name,
                'director_passport'               => __('PASSPORT'),
                'director_passport_serie'         => $director->passport_serie,
                'director_passport_number'        => $director->passport_number,
                'director_phone'                  => $director->phone,
                'employer_taxpayer_id'            => $item->employer_taxpayer_id,
                'rep_passport_1'                  => __('PASSPORT'),
                'rep_passport_serie'              => $rep->passport_serie,
                'rep_passport_number'             => $rep->passport_number,
            ];

        $dates =
            [
                'birth_1'                   => $item->birth_date,
                'birth_2'                   => $item->birth_date,
                'departure'                 => $departure_date,
                'director_passport_issued'  => $director->passport_issued,
                'director_passport_expired' => $director->passport_expired,
                'rep_passport_issued'       => $rep->passport_issued,
                'rep_passport_expired'      => $rep->passport_expired
            ];

        self::splitDate($dates, $fields);

        self::splitText($item->employer_name, 'employer_name', $fields, false, false, true, 3, 33, 38, 21);
        self::splitText($item->employer_address, 'employer_address', $fields, false, false, true, 2, 34, 38);

        self::output($template, $fields, true);
    }

    public static function printDoc($doc, $id, $docData)
    {
        $method = 'print' . to_pascal_case($doc);
        $data = call_user_func_array(
            [static::class, $method],
            [array_map('validate_boolean', $docData), $doc, $id]
        );
        $pdf = new Pdf(static::getTemplate($doc));
        $pdf->fillForm($data)->needAppearances();

        if (!$pdf->send()) {
            abort($pdf->getError());
        }
    }

    public static function printFiringNotice($docData, $doc, $id)
    {
        return self::printHiringOrFiringNotice($docData, $doc, $id);
    }

    public static function printHiringNotice($docData, $doc, $id)
    {
        return self::printHiringOrFiringNotice($docData, $doc, $id);
    }

    public static function printHiringOrFiringNotice($docData, $doc, $id)
    {
        $recipient = Employer::find($docData['authority_id']);
        $employee = Employee::find($id);
        $agent = (isset($docData['agent_id']) && $docData['agent_id']) ? Employee::find($docData['agent_id']) : null;
        $employer = Employer::find($employee->employer_id);

        $employerType = Type::find($employer->type_id)->name_ru;
        $accRegInfo = array_filter(
            [
                $employer->acc_reg_number,
                $employer->employer_taxpayer_id,
                $employer->taxpayer_code
            ]
        );
        $accRegInfo = implode(',', $accRegInfo);

        $employerPhone = self::handlePhones($employer->phone, '8');

        $citizenship = Country::find($employee->citizenship_id);
        $birthPlace = trim($citizenship->name_ru . ', ' . $employee->birth_place, ', ');

        $director = Employee::find($employer->director_id);
        $director_name = [
            $director->last_name_ru,
            mb_substr($director->first_name_ru, 0, 1) . '.',
            mb_substr($director->middle_name_ru, 0, 1) . '.'
        ];
        $director_name = implode(' ', $director_name);

        $regInfo = array_filter(
            [$employer->uni_reg_number, $employer->prime_reg_number]
        );
        $regInfo = implode(',', $regInfo);

        $data =
            [
                self::$employerTypes[$employerType] => 'X',
                'active_business_type'              => preg_replace(
                    '~(\d+)(.\d+)*(\D)*~',
                    '$1$2',
                    $employer->active_business_type
                ),
                'acc_reg_info'                      => $accRegInfo,
                'employer_phone'                    => $employerPhone,
                'last_name_ru'                      => $employee->last_name_ru,
                'first_name_ru'                     => $employee->first_name_ru,
                'middle_name_ru'                    => $employee->middle_name_ru,
                'citizenship'                       => $citizenship->name_ru,
                'passport'                          => __('PASSPORT'),
                'passport_serie'                    => $employee->passport_serie,
                'passport_number'                   => $employee->passport_number,
                'director'                          => __('GENERAL_DIRECTOR'),
                'director_name'                     => $director_name,
                'recipient'                         => $recipient->name_ru,
                'employer_name'                     => $employer->full_name_ru,
                'reg_info'                          => $regInfo,
                'employer_address'                  => Address::find($employer->address_id)->name_ru,
                'birth_place'                       => $birthPlace,
                'issuer'                            => $employee->passport_issuer,
                'occupation'                        => Occupation::find($employee->occupation_id)->name_ru,
            ];

//		$data[self::$genders[$item->gender]] = 'Х';

        if (isset($docData['work_contract']) && $docData['work_contract']) {
            $data['work_contract'] = 'X';
        } else {
            $data['partner_contract'] = 'X';
        }

        if ($citizenship->no_work_licences) {
            $data['resident_info'] = __('EEU_AGREEMENT');
        } elseif ($employee->resident_document) {
            $data['subparagraph'] = '1';
            $data['paragraph'] = '4';
            $data['article'] = '13';
            $workPermitInfo = [];

            $workPermitInfo[] = __($employee->resident_document);
            $workPermitInfo[] =
                !empty($employee->resident_document_serie) ?
                    __('SERIE') . ' ' . $employee->resident_document_serie :
                    '';
            $workPermitInfo[] =
                !empty($employee->resident_document_number) ?
                    __('NUMBER') . ' ' . $employee->resident_document_number :
                    '';
            $workPermitInfo[] = __('ISSUED_BY_1');
            $workPermitInfo[] =
                $employee->resident_document_issuer ?
                    ' ' . $employee->resident_document_issuer :
                    (
                    $employee->resident_document_issued_date ?
                        Carbon::parse($employee->resident_document_issued_date)->isoFormat('DD.MM.YYYY') :
                        ''
                    );
            $workPermitInfo[] =
                !empty($employee->resident_document_expired_date) ?
                    __('TILL_DATE') . ' ' .
                    Carbon::parse($employee->resident_document_expired_date)->isoFormat('DD.MM.YYYY') :
                    '';

            $data['resident_info'] = implode(' ', array_filter($workPermitInfo));
        } else {
            $data['work_permit'] = $citizenship->no_visas ? __('WORK_PATENT') : __('WORK_PERMIT');
            $data['work_permit_serie'] = $employee->work_permit_serie;
            $data['work_permit_number'] = $employee->work_permit_number;
            $data['work_permit_issuer'] = Employer::find($employee->work_permit_issuer_id)->name_ru;
        }

        $dates =
            [
                'birth'           => $employee->birth_date,
                'passport_issued' => $employee->passport_issued_date,
            ];

        if ($doc == 'hiring-notice') {
            $dates['hired'] = $employee->hired_date;

            $address = Address::find($employee->reg_address_id);
            $data['work_place'] = $address->name_ru;
        } else {
            $dates['fired'] = $docData['fired_date'];

            $data['yes'] = $docData['voluntary_firing'] ? 'X' : '';
        }

        if (!$employee->resident_document_number) {
            $dates['work_permit_issued'] = $employee->work_permit_issued_date;
            $dates['work_permit_started'] = $employee->work_permit_started_date;
            $dates['work_permit_expired'] = $employee->work_permit_expired_date;
        }

        static::splitDate($dates, $data);
        static::splitDate(['date' => $docData['date']], $data, true, true);

        if ($agent) {
            $data['proxy_number'] = $docData['proxy_number'];

            $agentName = implode(
                ' ',
                array_filter(
                    [$agent->last_name_ru, $agent->first_name_ru, $agent->middle_name_ru]
                )
            );
            $data['agent_name'] = $agentName;
            $data['agent_passport_serie'] = $agent->passport_serie;
            $data['agent_passport_number'] = $agent->passport_number;
            $data['agent_passport_issuer'] = $agent->passport_issuer;

            static::splitDate(
                ['agent_passport_issued' => $agent->passport_issued_date],
                $data,
                true
            );
            static::splitDate(['proxy' => $docData['proxy_date']], $data, true, true);
        }

        return static::populateSplitFields($doc, $docData, $data);
    }

    public static function printInvite($app, $input, $model, $view, $id, $template = 'invite')
    {
        $invite_form = $input->post->get('invite_form', '', 'string');
        $employer_id = $input->post->get('employer_id', '', 'string');
        $trip_purpose = $input->post->get('trip_purpose', '', 'string');
        $destination_address = $input->post->get('destination_address', 0, 'int');

        self::checkRequiredValues(
            $app,
            $view,
            $id,
            $template,
            $invite_form,
            $employer_id,
            $trip_purpose,
            $destination_address
        );

        $form = ['INVITE_FORM_FORM' => 'form', 'INVITE_FORM_DOC' => 'doc'];
        $multiplicity = $input->post->get('multiplicity', 'MULTI', 'string');
        $base = !$input->post->get('date') ? date('d.m.Y', time()) : $input->post->get('date');
        $date = date('dmy', strtotime($base));
        $desired_date = date('dmy', (strtotime($base) + 60 * 60 * 24 * 30));
        $supposed_entry_date = $desired_date;
        $upto = date('dmy', (strtotime($base) + 60 * 60 * 24 * 120));

        $item = $model->getItem($id);

        $file_name = self::getFileName($item, $template);

        $passport_issued = date('dmy', strtotime($item->passport_issued));
        $passport_expired = date('dmy', strtotime($item->passport_expired));
        $birth_date = date('dmY', strtotime($item->birth_date));
        $gender = mb_substr(__($item->gender), 0, 1);

        if (strpos($item->visa_issuer, ',') !== false) {
            $visa_issuer = explode(',', $item->visa_issuer);
            $visa_issued_country = $visa_issuer[0];
            $visa_issued_region = $visa_issuer[1];
        } else {
            $visa_issued_country = $item->citizenship_name;
            $visa_issued_region = $item->visa_issuer;
        }

        $employer_model = BaseDatabaseModel::getInstance('Employer', 'FMSDocsModel');
        $employer = $employer_model->getItem($employer_id, true);
        $uni_reg_date = date('dmy', strtotime($employer->uni_reg_date));
        $employer_phone = self::handlePhones($employer->phone, '8', 0);
        $director_name =
            $employer->director_last_name_ru .
            ' ' .
            mb_substr($employer->director_first_name_ru, 0, 1) .
            '.' .
            mb_substr($employer->director_middle_name_ru, 0, 1) .
            '.';

        $employer_address = self::parseAddress($employer->address_name);
        $trip_stops = [];
        $trip_stops[] = __('RUSSIA');
        $tmp = array_filter([$employer_address['region'], $employer_address['city'], $employer_address['locality']]);
        $trip_stops = array_merge($trip_stops, $tmp);
        $trip_stops = implode(', ', $trip_stops);

        $address_model = BaseDatabaseModel::getInstance('Address', 'FMSDocsModel');
        $address = $address_model->getItem($destination_address);
        $destination_address = $address->name_ru;

        $special_pass_issuer = '';
        $special_pass_number = '';
        $special_pass_date_from = '';
        $special_pass_date_to = '';
        $work_place = __('NO');
        $work_address = __('NO');
        $occupation = '';

        $fields =
            [
                'file_name'                     => $file_name,
                $form[$invite_form]             => 'Х',
                'date'                          => $date,
                'taxpayer_id'                   => $employer->taxpayer_id,
                'prime_reg_number'              => $employer->prime_reg_number,
                'uni_reg_date'                  => $uni_reg_date,
                'phone'                         => $employer_phone,
                'desired_date'                  => $desired_date,
                'director'                      => $director_name,
                'trip_purpose'                  => __($trip_purpose),
                'duration'                      => __('DURATION'),
                'supposed_entry_date'           => $supposed_entry_date,
                'up_to'                         => $upto,
                self::$visaTypes[$multiplicity] => 'Х',
                self::$visaTypes[$trip_purpose] => 'Х',
                'special_pass_number'           => '',
                'special_pass_date_from'        => '',
                'special_pass_date_to'          => '',
                'last_name_ru'                  => $item->last_name_ru,
                'last_name_en'                  => $item->last_name_en,
                'first_name_ru'                 => $item->first_name_ru,
                'first_name_en'                 => $item->first_name_en,
                'middle_name_ru'                => $item->middle_name_ru,
                'birth_date'                    => $birth_date,
                'gender'                        => $gender,
                'citizenship_name'              => $item->citizenship_name,
                'birth_place_country'           => $item->citizenship_name,
                'birth_place_region'            => $item->birth_place,
                'address_country'               => $item->citizenship_name,
                'address_region'                => $item->birth_place,
                'visa_issued_country'           => $visa_issued_country,
                'visa_issued_region'            => $visa_issued_region,
                'work_place'                    => $work_place,
                'occupation'                    => $occupation,
                'passport_serie'                => $item->passport_serie,
                'passport_number'               => $item->passport_number,
                'passport_issued'               => $passport_issued,
                'passport_expired'              => $passport_expired,
                'host_phone'                    => $employer_phone
            ];

        self::splitText($employer->full_name_ru, 'full_name', $fields, true, false, false, 2, 16, 62);
        self::splitText($employer->address_name, 'address_name', $fields, true, false, false, 2, 22, 62);
        self::splitText($trip_stops, 'trip_stops', $fields, true, false, false, 2, 40, 62);
        self::splitText($destination_address, 'destination_address', $fields, true, false, false, 3, 42, 62, 28);
        self::splitText($special_pass_issuer, 'special_pass_issuer', $fields, false, false, false, 2, 5, 25);
        self::splitText($work_address, 'work_address', $fields, true, false, false, 2, 52, 28);

        self::output($template, $fields);
    }

    public static function printVisa($app, $input, $model, $view, $id, $template = 'visa')
    {
        $action = $input->post->get('action', '', 'string');
        $trip_purpose = $input->post->get('trip_purpose', '', 'string');
        $reason = $input->post->get('reason', '', 'string');
        $inviter_id = $input->post->get('inviter_id', '', 'string');
        $destination_address = $input->post->get('destination_address', 0, 'int');

        self::checkRequiredValues(
            $app,
            $view,
            $id,
            $template,
            $action,
            $trip_purpose,
            $reason,
            $inviter_id,
            $destination_address
        );

        $item = $model->getItem($id, true);
        $file_name = self::getFileName($item, $template);
        $multiplicity = $input->post->get('multiplicity', 'MULTI', 'string');
        $category = $input->post->get('category', 'COMMON', 'string');
        $date = !$input->post->get('date') ? date('d.m.Y', time()) : $input->post->get('date');
        $date = date('d/m/Y', strtotime($date));

        $home_address
            = !empty($item->citizenship_name) ?
            $item->citizenship_name . ', ' . $item->birth_place :
            $item->birth_place;

        $birth_place = $item->birth_place;

        $dates =
            [
                'birth_date',
                'passport_issued',
                'passport_expired',
                'visa_started',
                'visa_expired'
            ];

        foreach ($dates as $var) {
            $$var = !$item->$var ? '' : date('d/m/Y', strtotime($item->$var));
        }

        switch ($reason) {
            case 'EXPIRED_VISA':
                $visa_info = trim($input->post->get('visa', '', 'string'));

                if (
                    strpos(strtolower($visa_info), strtolower(__('SERIE'))) !== false ||
                    strpos(strtolower($visa_info), strtolower(__('SHORT_NUMBER'))) !== false
                ) {
                    $reason = __($reason) . ' ' . $visa_info;
                    break;
                }

                $visa_info = explode(' ', $visa_info);
                $reason
                    =
                    __($reason) . Text::sprintf('SERIE_NUMBER_SPRINTF', $visa_info[0], $visa_info[1]);
                break;
            case 'NEW_PASSPORT':
                $passport_info = trim($input->post->get('passport', '', 'string'));

                if (
                    strpos(strtolower($passport_info), strtolower(__('SERIE'))) !== false ||
                    strpos(strtolower($passport_info), strtolower(__('SHORT_NUMBER'))) !== false
                ) {
                    $reason = __($reason) . ' ' . $passport_info;
                    break;
                }

                $reason = __($reason) . Text::sprintf('NUMBER_SPRINTF', $passport_info);
                break;
            case 'NEW_WORK_PERMIT':
            default:
                $work_permit_info = trim($input->post->get('work_permit', '', 'string'));

                if (
                    strpos(strtolower($work_permit_info), strtolower(__('SERIE'))) !== false ||
                    strpos(strtolower($work_permit_info), strtolower(__('SHORT_NUMBER'))) !== false
                ) {
                    $reason = __($reason) . ' ' . $work_permit_info;
                    break;
                }

                $reason = __($reason) . Text::sprintf('NUMBER_SPRINTF', $work_permit_info);
        }


        $employer_model = BaseDatabaseModel::getInstance('Employer', 'FMSDocsModel');

        $inviter = $employer_model->getItem($inviter_id, true);
        $inviter_phone = self::handlePhones($inviter->phone, '8');
        $inviter_taxpayer_id = __('TAXPAYER_ID') . ' ' . $inviter->taxpayer_id;
        $inviter_info = [$inviter->full_name_ru, $inviter_taxpayer_id, $inviter->address_name, $inviter_phone];
        $inviter_info = array_filter($inviter_info);
        $inviter_info = !empty($inviter_info) ? implode(', ', $inviter_info) : '';

        $employer_phone = self::handlePhones($item->employer_phone, '8');
        $employer_taxpayer_id = __('TAXPAYER_ID') . ' ' . $item->employer_taxpayer_id;

        $host_info
            = [$item->employer_name, $employer_taxpayer_id, $item->employer_address, $employer_phone];
        $host_info = array_filter($host_info);
        $host_info = !empty($host_info) ? implode(', ', $host_info) : $inviter_info;

        $work_info
            = [$item->employer_name, $item->occupation_name, $item->employer_address, $employer_phone];
        $work_info = array_filter($work_info);
        $work_info = !empty($work_info) ? implode(', ', $work_info) : '';

        $address_model = BaseDatabaseModel::getInstance('Address', 'FMSDocsModel');
        $address = $address_model->getItem($destination_address);
        $destination_address = $address->name_ru;
        $relatives = __('NO');

        $inviter_address = self::parseAddress($inviter->address_name);
        $trip_stops = [];
        $trip_stops[] = __('RUSSIA');
        $tmp = array_filter([$inviter_address['region'], $inviter_address['city'], $inviter_address['locality']]);
        $trip_stops = array_merge($trip_stops, $tmp);
        $trip_stops = implode(', ', $trip_stops);

        $fields =
            [
                'file_name'                     => $file_name,
                'date'                          => $date,
                self::$actions[$action]         => '',
                self::$visaTypes[$multiplicity] => 'Х',
                self::$visaTypes[$category]     => 'Х',
                self::$visaTypes[$trip_purpose] => 'Х',
                'last_name_ru'                  => $item->last_name_ru,
                'last_name_en'                  => $item->last_name_en,
                'first_name_ru'                 => $item->first_name_ru,
                'first_name_en'                 => $item->first_name_en,
                'middle_name_ru'                => $item->middle_name_ru,
                'birth_date'                    => $birth_date,
                self::$genders[$item->gender]   => 'Х',
                'citizenship_name'              => $item->citizenship_name,
                'birth_place'                   => $birth_place,
                'passport'                      => __('PASSPORT'),
                'passport_serie'                => $item->passport_serie,
                'passport_number'               => $item->passport_number,
                'passport_issued'               => $passport_issued,
                'passport_expired'              => $passport_expired,
                'existing_visa_serie'           => $item->visa_serie,
                'existing_visa_number'          => $item->visa_number,
                'existing_visa_started'         => $visa_started,
                'existing_visa_expired'         => $visa_expired,
                'existing_invitation_number'    => $item->invitation_number
            ];

        self::splitText($reason, 'reason', $fields, false, false, false, 2, 60, 75);
        self::splitText($inviter_info, 'inviter', $fields, true, false, false, 3, 44, 70);
        self::splitText($host_info, 'host', $fields, true, false, false, 3, 44, 70);
        self::splitText($destination_address, 'destination_address', $fields, true, false, false, 3, 42, 70);
        self::splitText($trip_stops, 'trip_stops', $fields, true, false, false, 2, 42, 70);
        self::splitText($home_address, 'home_address', $fields, true, false, false, 2, 42, 70);
        self::splitText($work_info, 'work_info', $fields, true, false, false, 2, 44, 70);
        self::splitText($relatives, 'relatives', $fields, true, false, false, 3, 24, 70);

        self::output($template, $fields);
    }

    public static function printVisaMotion($app, $input, $model, $view, $id, $template = 'visamotion')
    {
        $recipient_id = $input->post->get('recipient_id', '', 'string');

        self::checkRequiredValues($app, $view, $id, $template, $recipient_id);

        $item = $model->getItem($id, true);
        $file_name = self::getFileName($item, $template);

        $recipient = $item->recipient[$recipient_id];
        $recipient_person_id = $input->post->get('recipient_person_id', $recipient->director, 'int');
        $recipient_director = $model->getItem($recipient_person_id);
        $recipient_director = [
            self::declension($recipient_director->last_name_ru, 3, $recipient_director->gender, 'name'),
            mb_substr($recipient_director->first_name_ru, 0, 1) . '.',
            mb_substr($recipient_director->middle_name_ru, 0, 1) . '.'
        ];
        $recipient_director = implode(' ', $recipient_director);

        $host_info = [
            $item->employer_name,
            __('TAXPAYER_ID') . ' ' . $item->employer_taxpayer_id,
            $item->employer_address,
            $item->employer_phone
        ];
        $host_info = implode(', ', $host_info);

        $action = $input->post->get('action', '0', 'string');
        $actions = ['extend', 'renew'];
        $gender = ['MALE' => 'male', 'FEMALE' => 'female'];
        $birth_date = '';

        if (trim($item->birth_date) != '0000-00-00') {
            $birth_date = date('d/m/Y', strtotime($item->birth_date));
        }

        $documents = [
            'WORKCONTRACT_EXTEND' => 'work_contract',
            'NEW_WORK_PERMIT'     => 'work_permit',
            'EXPIRED_VISA'        => 'visa'
        ];
        $reasons = [];
        $reason = $input->post->get('reason', '', 'string');
        $reasons[] = __($reason);
        $reasons[] = __('SHORT_NUMBER');
        $reasons[] = $input->post->get($documents[$reason]);
        $reasons[] = __('VALID_FROM_LC');
        $from = $input->post->get($documents[$reason] . '_from');
        $reasons[] = date('d/m/Y', strtotime($from));
        $reasons[] = __('VALID_UNTIL_LC');
        $until = $input->post->get($documents[$reason] . '_until');
        $reasons[] = date('d/m/Y', strtotime($until));
        $reasons = implode(' ', $reasons);

        $date = $input->post->get('date', '', 'string');
        $date = $date ? date('d/m/Y', strtotime($date)) : '';

        $director = __('GENERAL_DIRECTOR');
        $director_name = [
            $item->director_last_name_ru,
            mb_substr($item->director_first_name_ru, 0, 1) . '.',
            $item->director_middle_name_ru ? mb_substr($item->director_middle_name_ru, 0, 1) . '.' : ''
        ];

        $fields =
            [
                'file_name'            => $file_name,
                'recipient_director'   => $recipient_director,
                $actions[$action]      => '',
                'last_name_ru'         => $item->last_name_ru,
                'first_name_ru'        => $item->first_name_ru,
                'middle_name_ru'       => $item->middle_name_ru,
                'last_name_en'         => $item->last_name_en,
                'first_name_en'        => $item->first_name_en,
                'middle_name_en'       => $item->middle_name_en,
                'birth_date'           => $birth_date,
                'citizenship_name'     => $item->citizenship_name,
                $gender[$item->gender] => 'X',
                'passport_serie'       => $item->passport_serie,
                'passport_number'      => $item->passport_number,
                'passport_issued'      => date('d/m/Y', strtotime($item->passport_issued)),
                'passport_expired'     => date('d/m/Y', strtotime($item->passport_expired)),
                'visa_serie'           => $item->visa_serie,
                'visa_number'          => $item->visa_number,
                'visa_started'         => date('d/m/Y', strtotime($item->visa_started)),
                'visa_expired'         => date('d/m/Y', strtotime($item->visa_expired)),
                'date'                 => $date,
                'director'             => $director,
                'director_name'        => implode(' ', $director_name)
            ];

        self::splitText(
            self::declension($recipient->name_ru, 2, '', '', 1),
            'recipient',
            $fields,
            true,
            false,
            false,
            2,
            45
        );
        self::splitText($host_info, 'host_info', $fields, true, false, false, 4, 35, 45);
        self::splitText($reasons, 'reason', $fields, true, false, false, 2, 85, 95);

        self::output($template, $fields, false, false);
    }

    public static function printWarranty($app, $input, $model, $view, $id, $template = 'warranty')
    {
        $recipient_id = $input->post->get('recipient_id', '', 'string');
        $employer_id = $input->post->get('employer_id', '', 'string');
        $destination_address = $input->post->get('destination_address', 0, 'int');

        self::checkRequiredValues($app, $view, $id, $template, $recipient_id, $employer_id, $destination_address);

        $item = $model->getItem($id);
        $file_name = self::getFileName($item, $template);

        $recipient = $item->recipient[$recipient_id];
        $recipient_person_id = $input->post->get('recipient_person_id', $recipient->director, 'int');
        $recipient_person = $model->getItem($recipient_person_id);
        $recipient_person_name = [
            self::declension($recipient_person->last_name_ru, 3, $recipient_person->gender, 'name'),
            mb_substr($recipient_person->first_name_ru, 0, 1) . '.',
            mb_substr($recipient_person->middle_name_ru, 0, 1) . '.'
        ];
        $recipient_person_name = implode(' ', $recipient_person_name);

        $date = $input->post->get('date', '', 'string');
        $date = $date ? $date : date('Y-m-d', time());
        $reg_num = $input->post->get('reg_num', '', 'string');

        $employer_model = BaseDatabaseModel::getInstance('Employer', 'FMSDocsModel');
        $employer = $employer_model->getItem($employer_id, true);
        $taxpayer_id = __('TAXPAYER_ID') . ' ' . $employer->taxpayer_id;
        $prime_reg_number = __('PRIME_REG_NUMBER') . ' ' . $employer->prime_reg_number;
        $taxpayer_code = __('TAXPAYER_CODE') . ' ' . $employer->taxpayer_code;
        $employer_phone = self::handlePhones($employer->phone, '8');
        $phone = __('PHONE_LC') . ': ' . $employer_phone;

        $host_info = [
            $employer->full_name_ru,
            $employer->address_name,
            $taxpayer_id . '/' . $prime_reg_number . '/' . $taxpayer_code,
            $phone
        ];
        $host_info = implode(', ', $host_info);

        if (!empty($item->citizenship)) {
            $state = ['foreigner_1' => '', 'foreigner_2' => ''];
        } else {
            $state = ['stateless' => ''];
        }

        $director = $model->getItem($employer->director);
        $director_name = [
            $director->last_name_ru,
            mb_substr($director->first_name_ru, 0, 1) . '.',
            mb_substr($director->middle_name_ru, 0, 1) . '.'
        ];
        $director_name = implode(' ', $director_name);

        if (!empty($item->citizenship)) {
            $country_model = BaseDatabaseModel::getInstance('Country', 'FMSDocsModel');
            $country = $country_model->getItem($item->citizenship);
            $citizenship = self::declension($country->name_ru, 2, '', 'name');
        } else {
            $citizenship = '';
        }

        $name = $item->last_name_ru . ' ' . $item->first_name_ru;
        $name .= $item->middle_name_ru ? (' ' . $item->middle_name_ru) : '';

        $birth_date = explode('-', $item->birth_date);
        $birth_date = !empty(array_sum($birth_date)) ? $birth_date : ['', '', ''];
        $birth_date
            = $birth_date[2] . '/' . $birth_date[1] . '/' . $birth_date[0] . __('BIRTH_DATE_SUFFIX');

        $passport_issued = explode('-', $item->passport_issued);
        $passport_issued = $passport_issued[2] . '/' . $passport_issued[1] . '/' . $passport_issued[0];
        $passport_expired = explode('-', $item->passport_expired);
        $passport_expired = $passport_expired[2] . '/' . $passport_expired[1] . '/' . $passport_expired[0];

        $passport_info = [
            __('PASSPORT_LC'),
            ' ' . $item->passport_number,
            __('ISSUED_BY_LC'),
            $passport_issued,
            ' ' . $item->passport_issuer,
            __('VALID_UNTIL_LC'),
            $passport_expired
        ];

        $guest_info = [
            $citizenship . ':  ' . $name,
            $birth_date,
            implode($passport_info)
        ];
        $guest_info = implode(', ', array_filter($guest_info));

        $address_model = BaseDatabaseModel::getInstance('Address', 'FMSDocsModel');
        $address = $address_model->getItem($destination_address);
        $address = $address->name_ru;

        $fields =
            [
                'file_name'          => $file_name,
                'recipient_director' => $recipient_person_name,
                'date'               => date('d/m/Y', strtotime($date)),
                'host_name'          => $employer->name_ru,
                'director'           => $director_name
            ];

        if (!empty($reg_num)) {
            $fields['reg_num'] = $reg_num;
        }

        $fields = array_merge($fields, $state);

        self::splitDate(array('date' => $date), $fields, true, 'y-m-d');

        self::splitText(
            self::declension($recipient->name_ru, 2, '', '', 1),
            'recipient',
            $fields,
            true,
            false,
            false,
            2,
            48
        );
        self::splitText($host_info, 'host_info', $fields, true, false, false, 3, 84);
        self::splitText($guest_info, 'guest_info', $fields, true, false, false, 3, 46, 84);
        self::splitText($address, 'address', $fields, true, false, false, 2, 84);

        self::output($template, $fields);
    }

    public static function printWorkContract($app, $input, $model, $view, $id, $template = 'workcontract')
    {
        $item = $model->getItem($id, true);

        $employer_id = $input->post->get('employer_id', $item->employer_id, 'int');
        $date_from = $input->post->get('date_from', date('d.m.Y', time()), 'string');
        $work_permit_expired = !empty($item->work_permit_expired) ?
            date('d.m.Y', strtotime($item->work_permit_expired)) : '';
        $date_to = $input->post->get('date_to', $work_permit_expired, 'string');
        $salary = $input->post->get('salary', '', 'int');

        $preserved_values = [];
        $preserved_values['employer_id'] = $employer_id;
        $preserved_values['date_from'] = $date_from;
        $preserved_values['date_to'] = $date_to;

        foreach ($preserved_values as $key => $value) {
            $app->setUserState('com_fmsdocs.workcontrack.' . $key . $id, $value);
        }

        self::checkRequiredValues($app, $view, $id, $template, $employer_id, $date_from, $date_to, $salary);

        $file_name = self::getFileName($item, $template);
        $contract_number = $input->post->get('contract_number', '', 'string');

        $employer_model = BaseDatabaseModel::getInstance('Employer', 'FMSDocsModel');
        $employer = $employer_model->getItem($employer_id, true);

        $address = self::parseAddress($employer->address_name);
        $title = array_filter([$address['region'], $address['city'], $address['locality']]);
        $title[] = implode(' ', self::parseDate($date_from, true)) . __('YEAR_SUFFIX');
        $title = implode(', ', $title);

        $director1 = [];
        $director1[] = self::declension($employer->director_last_name_ru, 2, $employer->director_gender, 'name');
        $director1[] = self::declension($employer->director_first_name_ru, 2, $employer->director_gender, 'name');
        $director1[] = self::declension($employer->director_middle_name_ru, 2, $employer->director_gender, 'name');
        $director1 = implode(' ', $director1);

        $director2 = $employer->director_last_name_ru;

        $initials = $employer->director_first_name_ru ?
            ' ' . mb_substr($employer->director_first_name_ru, 0, 1) . '.' : '';
        $initials .= $employer->director_middle_name_ru ?
            ' ' . mb_substr($employer->director_middle_name_ru, 0, 1) . '.' : '';

        $director2 .= $initials;

        $employee_name = $item->last_name_ru .
                         ' ' .
                         $item->first_name_ru .
                         ($item->middle_name_ru ? ' ' . $item->middle_name_ru : '');
        $employee = $employee_name;
        $citizenship = self::declension($item->citizenship_name, 2, '', 'name');

        $employer_info = [];
        $employer_info[] = $employer->full_name_ru;
        $employer_info[] = $employer->address_name;
        $employer_info[] = __('TAXPAYER_ID') . ' ' . $employer->taxpayer_id;
        $employer_info[] = __('TAXPAYER_CODE') . ' ' . $employer->taxpayer_code;
        $employer_info[] = __('PRIME_REG_NUMBER') . ' ' . $employer->prime_reg_number;
        $employer_info = implode(', ', $employer_info);

        $employee_info = [];
        $employee_info[] = $employee_name;
        $employee_info[] = __('BIRTH_DATE') . ' ' . date('d/m/Y', strtotime($item->birth_date));
        $employee_info[] = __('PASSPORT_LC') .
                           ' ' .
                           $item->passport_number .
                           ' ' .
                           __('ISSUED_BY_1_LC') .
                           ' ' .
                           date('d/m/Y', strtotime($item->passport_issued)) .
                           ' ' .
                           $item->passport_issuer;
        $employee_info[] = __('REG_ADDR_LC') . ': ' . $item->reg_address_name;
        $employee_info = implode(', ', $employee_info);

        $fields =
            [
                'file_name'   => $file_name,
                'title'       => $title,
                'director1'   => $director1,
                'employee'    => $employee,
                'citizenship' => $citizenship,
                'address'     => $item->work_address_name,
                'date_from'   => date('d/m/Y', strtotime($date_from)),
                'date_to'     => date('d/m/Y', strtotime($date_to)),
                'salary'      => $salary,
                'director2'   => $director2
            ];

        if ($contract_number) {
            $fields['contract_number'] = $contract_number;
        }

        if ($item->work_permit_number) {
            $work_permit_name = in_array($item->citizenship, self::$CIS) ? __('WORK_PATENT') :
                __('WORK_PERMIT');
            $fields['occation'] = mb_strtolower($work_permit_name);
            $fields['occation'] .=
                Text::sprintf('SERIE_NUMBER_SPRINTF', $item->work_permit_serie, $item->work_permit_number);
            $fields['occation'] .= __('SINCE') . date('d/m/Y', strtotime($item->work_permit_issued));
        }

        $occupation = self::declension($item->occupation_name, 2, '', '', 1);

        self::splitText($employer->full_name_ru, 'employer', $fields, true, false, false, 2, 66, 46);
        self::splitText($occupation, 'occupation1', $fields, true, false, false, 2, 34, 66);
        self::splitText($occupation, 'occupation2', $fields, true, false, false, 2, 41, 66);
        self::splitText($employer_info, 'employer_info', $fields, true, false, false, 7, 32);
        self::splitText($employee_info, 'employee_info', $fields, true, false, false, 9, 32);

        self::output($template, $fields);
    }

    public static function printWorkPermit($docData, $doc, $id)
    {
        $recipient = Employer::find($docData['authority_id']);
        $permit = Permit::find($docData['employ_permit_id']);
        $permit_issued = Carbon::parse($permit->issued_date)->isoFormat('DD.MM.YYYY');

        $permit_info =
            __('SHORT_PERMIT_NUMBER') .
            $permit->number .
            __('SINCE') .
            $permit_issued;

        $employee = Employee::find($id);
        $citizenship = Country::find($employee->citizenship_id)->name_ru;
        $birth_place = !empty($citizenship) ? ($citizenship . ', ' . $employee->birth_place) : $employee->birth_place;
        $address = $employee->address ?: $birth_place;
        $reg_address = Address::find($employee->reg_address_id)->name_ru;
        $occupation = Occupation::find($employee->occupation_id)->name_ru;
        $passport = __('PASSPORT');

        $employer = Employer::find($employee->employer_id);
        $employer_phone = self::handlePhones($employer->phone, '8', 0);
        $employer_address = Address::find($employer->address_id)->name_ru;
        $employer_info = $employer->uni_reg_number . ', ' . $permit_info;

        $data =
            [
                'recipient'                       => $recipient->name_ru,
                self::$genders[$employee->gender] => 'Х',
                'passport'                        => $passport,
                'passport_number'                 => $employee->passport_number,
                'taxpayer_id'                     => $employee->taxpayer_id,
                'employer_taxpayer_id'            => $employee->employer_taxpayer_id,
                'employer_info'                   => $employer_info,
                'permit_info'                     => $permit_info,
                'employer_phone'                  => $employer_phone,
                'last_name'                       => $employee->last_name_ru,
                'first_name'                      => $employee->first_name_ru,
                'middle_name'                     => $employee->middle_name_ru,
                'citizenship'                     => $citizenship,
                'birth_place'                     => $birth_place,
                'address'                         => $address,
                'issuer'                          => $employee->passport_issuer,
                'reg_address'                     => $reg_address,
                'occupation'                      => $occupation,
                'employer_name'                   => $employer->full_name_ru,
                'employer_address'                => $employer_address,
                'active_business_type'            => preg_replace(
                    '~(\d+)(.\d+)*(\D)*~',
                    '$1$2',
                    $employer->active_business_type
                ),
            ];

        $dates =
            [
                'from'               => $docData['date'],
                'to'                 => $permit->expired_date,
                'birth'              => $employee->birth_date,
                'issued'             => $employee->passport_issued_date,
                'taxpayer_id_issued' => $employee->taxpayer_id_issued_date
            ];

        self::splitDate($dates, $data);

        return static::populateSplitFields($doc, $docData, $data);
    }

    public static function printWorkPermitMotion($docData, $doc, $id)
    {
        $employee = Employee::find($id);
        $recipient = Employer::find($docData['authority_id']);
        $recipientDirectorId = $docData['officer_id'] ?: $recipient->director_id;
        $recipientDirector = Employee::find($recipientDirectorId);
        $recipientDirector =
            [
                self::declension($recipientDirector->last_name_ru, 3, $recipientDirector->gender, 'name'),
                mb_substr($recipientDirector->first_name_ru, 0, 1) . '.',
                mb_substr($recipientDirector->middle_name_ru, 0, 1) . '.'
            ];
        $recipientDirector = implode(' ', $recipientDirector);

        $employer = Employer::find($employee->employer_id);

        $address = Address::find($employer->address_id);
        $address = self::parseAddress($address->name_ru);
        $title = array_filter([$address['region'], $address['city']]);
        $title[] = Carbon::parse($docData['date'])->isoFormat('DD MMMM YYYY') . __('YEAR_SUFFIX');
        $title = implode(', ', $title);

        $guestInfo = [];

        $guestName = array_filter(
            [$employee->last_name_ru, $employee->first_name_ru, $employee->middle_name_ru]
        );
        $guestName = implode(' ', $guestName);

        $guestCitizenship = Country::find($employee->citizenship_id)->name_ru;
        $guestInfo[] = self::declension($guestCitizenship, 2, '', 'name') . ': ' . $guestName;

        if ($employee->birth_date) {
            $guestInfo[] = Carbon::parse($employee->birth_date)->isoFormat('DD/MM/YYYY') . __('BIRTH_DATE_SUFFIX');
        }

        $guestInfo[] = implode(
            ' ',
            [
                __('PASSPORT_LC'),
                $employee->passport_number,
                __('ISSUED_BY_1_LC'),
                Carbon::parse($employee->passport_issued_date)->isoFormat('DD/MM/YYYY') . __('YEAR_SUFFIX'),
                $employee->passport_issuer
            ]
        );

        $guestInfo = implode(', ', $guestInfo);

        $director = Employee::find($employer->director_id);
        $director =
            implode(
                ' ',
                [
                    $director->last_name_ru,
                    mb_substr($director->first_name_ru, 0, 1) . '.',
                    $director->middle_name_ru ? mb_substr($director->middle_name_ru, 0, 1) . '.' : ''
                ]
            );

        $data =
            [
                'recipient'          => self::declension($recipient->name_ru, 2, '', '', 1),
                'recipient_director' => $recipientDirector,
                'title'              => $title,
                'employer'           => $employer->name_ru,
                'guest_name'         => $guestName,
                'guest_info'         => $guestInfo,
                'director'           => $director
            ];

        return static::populateSplitFields($doc, $docData, $data);
    }

    /**
     * @param $user_ids
     * @param $main_user
     * @param $tables
     * @return bool|void
     */
    public static function removeRelatedRecords($user_ids, $main_user, $tables)
    {
        if (!is_array($user_ids)) {
            $user_ids = [$user_ids];
        }

        if (empty($user_ids) || empty($tables)) {
            return;
        }

        $db = Factory::getDbo();

        foreach ($user_ids as $user_id) {
            foreach ($tables as $table) {
                $query = $db->getQuery(true);

                $where_pattern_1 = '"';
                $where_pattern_1 .= '^' . $main_user . '$';
                $where_pattern_1 .= '|';
                $where_pattern_1 .= '^' . $main_user . ',';
                $where_pattern_1 .= '|';
                $where_pattern_1 .= ',' . $main_user . ',';
                $where_pattern_1 .= '|';
                $where_pattern_1 .= ',' . $main_user . '$';
                $where_pattern_1 .= '"';

                $when_pattern_1 = '"';
                $when_pattern_1 .= '^' . $user_id . ',';
                $when_pattern_1 .= '|';
                $when_pattern_1 .= ',' . $user_id . ',';
                $when_pattern_1 .= '"';

                $when_pattern_2 = '"';
                $when_pattern_2 .= ',' . $user_id . '$';
                $when_pattern_2 .= '"';

                $replacement_start = $db->QuoteName('user_ids');
                $replacement_start .= ', ';
                $replacement_start .= '"';

                $replacement_end = '"';
                $replacement_end .= ', ';
                $replacement_end .= '""';

                $replacement_1 = $replacement_start;
                $replacement_1 .= $user_id . ',';
                $replacement_1 .= $replacement_end;

                $replacement_2 = $replacement_start;
                $replacement_2 .= ',' . $user_id;
                $replacement_2 .= $replacement_end;

                $set_statement = ' WHEN ' . $db->QuoteName('user_ids') . ' REGEXP ' . $when_pattern_1;
                $set_statement .= ' THEN REPLACE(' . $replacement_1 . ')';
                $set_statement .= ' WHEN ' . $db->QuoteName('user_ids') . ' REGEXP ' . $when_pattern_2;
                $set_statement .= ' THEN REPLACE(' . $replacement_2 . ')';
                $set_statement .= ' ELSE ' . $db->QuoteName('user_ids');

                $query
                    ->update($db->QuoteName('#__fmsdocs_' . $table))
                    ->set($db->QuoteName('user_ids') . ' = CASE' . $set_statement . ' END')
                    ->where($db->QuoteName('user_ids') . ' REGEXP ' . $where_pattern_1);

                $db->setQuery($query)->execute();
            }
        }

        return true;
    }

    public static function sendMessage($post = null, $url = null, $redirect = true)
    {
        $app = Factory::getApplication();
        $user = Factory::getUser();
        $post = !is_null($post) ? $post : $app->input->post;
        $recipient = $post->get('recipient_emails', [], 'array');
        $url = !is_null($url) ? $url : $_SERVER['REQUEST_URI'];

        if (empty($recipient)) {
            $app->enqueueMessage(__('NO_RECIPIENTS', 'warning'));

            if ($redirect) {
                $app->redirect($url);
            }
        }

        $subject = __($post->get('theme', 'OTHER_THEME', 'string'));
        $time = $post->get('time', '', 'string');
        $user_names = $post->get('user_names', [], 'array');
        $text = $post->get('text', '', 'string');
        $config = Factory::getConfig();
        $fromname = $user->get('name') . ', ' . $config->get('fromname');
        $mailfrom = $config->get('mailfrom');
        $body = [];

        $body[] = mb_strtoupper($subject);

        if (!empty($time)) {
            $time = explode(' ', $time);
            $body[] = '';
            $body[] = __('DATE') . ': ' . $time[0];
            $body[] = __('TIME') . ': ' . $time[1];
        }

        if (!empty($user_names)) {
            $body[] = '';
            $body[] = __('THESE_USERS');

            foreach ($user_names as $key => $user_name) {
                $body[] = '&nbsp;' . ($key + 1) . '. ' . trim($user_name);
            }
        }

        if (!empty($text)) {
            $body[] = '';
            $body[] = $text;
        }

        $body[] = '';
        $body[] = __('BEST_REGARDS');
        $body[] = $fromname;
        $body = nl2br(implode(PHP_EOL, $body));

        $result = Factory::getMailer()->sendMail($mailfrom, $fromname, $recipient, $subject, $body, true);
        $message =
            $result ? ['type' => 'notice', 'text' => 'MESSAGE_SENT'] :
                ['type' => 'warning', 'text' => 'MESSAGE_NOT_SENT'];

        $app->enqueueMessage(__($message['text']), $message['type']);

        if ($redirect) {
            $app->redirect($url);
        }
    }

    public static function setDocument($title = '', $metaDesc = '', $metaKey = '')
    {
        $baseUrl = Uri::base();
        $doc = Factory::getDocument();
        $doc->addScript($baseUrl . 'components/com_fmsdocs/assets/scripts/fmsdocs.js')
            ->addStyleSheet($baseUrl . 'components/com_fmsdocs/assets/styles/fmsdocs.css');
        $app = Factory::getApplication();

        if (empty($title)) {
            $title = $app->get('sitename');
        } elseif ($app->get('sitename_pagetitles', 0) == 1) {
            $title = Text::sprintf('JPAGETITLE', $app->get('sitename'), $title);
        } elseif ($app->get('sitename_pagetitles', 0) == 2) {
            $title = Text::sprintf('JPAGETITLE', $title, $app->get('sitename'));
        }

        $doc->setTitle($title);

        if (trim($metaDesc)) {
            $doc->setDescription($metaDesc);
        }

        if (trim($metaKey)) {
            $doc->setMetaData('keywords', $metaKey);
        }
    }

    public static function shipmentDocs($app, $input, $model, $view, $id, $template)
    {
        $params = ComponentHelper::getParams('com_fmsdocs');
        $url = $params->get('host', '');
        $host = parse_url($url)['host'];
        $host = explode('.', $host);
        $shipment_model = BaseDatabaseModel::getInstance('Shipment', 'FMSDocsModel', ['ignore_request' => true]);
        $method = 'apply' . ucfirst($host[0]) . ucfirst($host[1]);

        self::$method($url, $input, $id, $model, $shipment_model, $app);
    }

    public static function shortenAddresses($addresses, $type_required = true)
    {
        foreach ($addresses as &$address) {
            $parts = self::parseAddress($address, $type_required);

            if (isset($parts['region'])) {
                unset($parts['region']);
            }

            if (isset($parts['district'])) {
                unset($parts['district']);
            }

            $tmp = [];

            if (isset($parts['city'])) {
                $tmp['city'] = $parts['city'];
                unset($parts['city']);
            }

            if (isset($parts['locality'])) {
                $tmp['locality'] = $parts['locality'];
                unset($parts['locality']);
            }

            if (isset($parts['houseType'])) {
                $parts['house'] = $parts['houseType'] . ' ' . $parts['house'];
                unset($parts['houseType']);
            }

            if (isset($parts['roomType'])) {
                $parts['room'] = $parts['roomType'] . ' ' . $parts['room'];
                unset($parts['roomType']);
            }

            $tmp = array_merge($tmp, $parts);
            $address = implode(', ', array_filter($tmp));
        }

        return $addresses;
    }

    public static function splitDate($dates, &$data, $fullMonthFormat = false, $shortYear = false)
    {
        foreach ($dates as $key => $date) {
            $date = Carbon::parse($date);
            $key = ($key == 'date') ? '' : ($key . '_');

            $data[$key . 'day'] = $date->isoFormat('DD');
            $data[$key . 'month'] =
                $fullMonthFormat ? $date->getTranslatedMonthName('MMMM', '_full') : $date->isoFormat('MM');
            $data[$key . 'year'] = $shortYear ? $date->isoFormat('YY') : $date->isoFormat('YYYY');
        }
    }

    /**
     * Split text to fit rows
     * @param string $value
     * @param string $key
     * @param array $data
     * @param boolean $justify
     * @param boolean $splitWord
     * @param boolean $cells
     * @param int $total
     * @param mixed $rows
     * @return boolean
     */
    public static function splitText($value, $key, &$data, $justify, $splitWord, $cells, $total, $rows)
    {
        if (isset($data[$key])) {
            unset($data[$key]);
        }

        // Row count
        $n = 0;

        if (mb_strlen($value, 'UTF-8') == 0) {
            // Empty string
            $n++;
            $data[$key . '_' . $n] = '';

            return true;
        }

        // Not empty string
        $rows = Arr::wrap($rows);
        $newRow = true;
        // Word count
        $k = 0;
        $words = explode(' ', $value);
        // Character count
        $i = 0;
        $tmp = '';
        $count = count($words);

        while ($k < $count && $n < $total) {
            // Should we add space after comma?
            $noSpace =
                $newRow ||
                (
                    $cells &&
                    mb_strpos($words[$k - 1], ',', 0, 'UTF-8') === (mb_strlen($words[$k - 1], 'UTF-8') - 1)
                );
            // Checking current row length
            $i += $noSpace ? 0 : 1;
            $i += mb_strlen($words[$k], 'UTF-8');
            $rowLength = $n < count($rows) ? $rows[$n] : $rows[count($rows) - 1];

            if (!($i > $rowLength)) {
                // Row length maximum not exceeded, adding new word
                $tmp .= $noSpace ? '' : ' ';
                $tmp .= $words[$k];

                if ($count == 1 || $k == ($count - 1)) {
                    // The only word or the last word? Let's finish the job
                    $n++;
                    $data[$key . '_' . $n] = $tmp;
                    break;
                }

                // Keep building current row
                $newRow = false;
                $k++;
            } else {
                // Row length maximum exceeded.
                $n++;

                // We may want to justify current row
                $extra = $rowLength - mb_strlen($tmp, 'UTF-8');

                if ($n < $total && $extra > 0) {
                    if ($justify) {
                        $tmpWords = explode(' ', $tmp);
                        $separators = count($tmpWords) - 1;

                        while ($extra > 0) {
                            $min = ($separators - $extra) > 0 ? ($separators - $extra) : 0;

                            for ($j = $separators; $j > $min; $j--) {
                                $tmpWords[$j] = ' ' . $tmpWords[$j];
                                $extra--;
                            }
                        }

                        $tmp = implode(' ', $tmpWords);
                    } elseif ($splitWord) {
                        $tmp .= ' ' . mb_substr($words[$k], 0, $extra - 1);
                        $words[$k] = mb_substr($words[$k], $extra - 1, mb_strlen($words[$k], 'UTF-8'));
                    }
                }

                // Add current row to $fields
                $data[$key . '_' . $n] = $tmp;
                // Let's go to a new row
                $tmp = '';
                $i = 0;
                $newRow = true;
            }
        }

        return true;
    }

    public static function tamaliNet($url, $input, $id, $model, $shipment_model, $app)
    {
        $company = $model->getItem($id, true);
//		echo '<pre>', print_r($company), '</pre>'; exit;
        $director_name =
            $company->director_last_name_ru . ' ' .
            mb_substr($company->director_first_name_ru, 0, 1) . '.' .
            mb_substr($company->director_middle_name_ru, 0, 1) . '.';
        $booker_name =
            $company->booker_last_name_ru . ' ' .
            mb_substr($company->booker_first_name_ru, 0, 1) . '.' .
            mb_substr($company->booker_middle_name_ru, 0, 1) . '.';
        $client = $model->getItem($input->post->get('client_id', null, 'int'), true);
        $client_director_name =
            $client->director_last_name_ru . ' ' .
            mb_substr($client->director_first_name_ru, 0, 1) . '.' .
            mb_substr($client->director_middle_name_ru, 0, 1) . '.';

        $raw_data = file_get_contents('php://input');
        $data = [];
        $data['DocNo'] = $input->post->get('doc_number', '', 'string');
        $data['DocDate'] = $input->post->get('doc_date', '00.00.0000', 'string');
        $data['Name'] = $company->name_ru;
        $data['PayeeINN'] = $company->taxpayer_id;
        $data['KPP'] = $company->taxpayer_code;
        $data['PayeeAddress'] = $company->address_name;
        $data['Director'] = $director_name;
        $data['NDS'] = '0';
        $data['LastName'] = $client->name_ru;
        $data['PayerINN'] = $client->taxpayer_id;
        $data['PayerKPP'] = $client->taxpayer_code;
        $data['PayerAddress'] = $client->address_name;
        $data['PayerDirector'] = $client_director_name;

        $raw_data = preg_replace('~(items\..+?)=~', '$1[]=', $raw_data);
        parse_str($raw_data, $output);
        $items = [];

        foreach ($output['items_name'] as $k => $v) {
            $data['goods_name[' . $k . ']'] = $items[$k]['items_name'] = $v;
            $data['okei[' . $k . ']'] = $items[$k]['items_units'] = $output['items_units'][$k];
            $data['goods_quantity[' . $k . ']'] = $items[$k]['items_quantity'] = $output['items_quantity'][$k];
            $data['price[' . $k . ']'] = $items[$k]['items_price'] = $output['items_price'][$k];
            $data['goods_Sum[' . $k . ']'] = $items[$k]['items_total_price'] = $output['items_total_price'][$k];
        }

        $ch = curl_init();
        $url .= $input->post->get('doc_type', '', 'string') . '/blank/';

        curl_setopt($ch, CURLOPT_URL, $url);
        curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
        curl_setopt($ch, CURLOPT_POSTFIELDS, $data);

        if ($result = curl_exec($ch)) {
            curl_close($ch);

            $data = [];
            $data['data'] = json_encode($items);
            $keys = ['doc_number', 'doc_date', 'company_id', 'client_id'];

            foreach ($keys as $key) {
                $data[$key] = $input->post->get($key);
            }

            $shipment_model->save($data);

            preg_match('~<div class="info".+?<a href="(.+?)"~s', $result, $matches);
            $result = file_get_contents($matches[1]);
            $url = parse_url($matches[1]);

            preg_match('~<div class="pdf"><object><embed src="(.+?)"~s', $result, $matches);
            $app->redirect($url['scheme'] . '://' . $url['host'] . $matches[1]);
        }

        curl_close($ch);
    }

    public static function taxRegistration($app, $input, $model, $view, $id, $template = 'taxregistration')
    {
        $submit = $input->post->get('submit', '', 'string');

        self::checkRequiredValues(
            $app,
            $view,
            $id,
            $template,
            $submit
        );

        $taxpayer_id = $input->post->get('taxpayer_id', '', 'int');
        $inspection_code = $input->post->get('inspection_code', '', 'int');
        $pages_total = $input->post->get('pages_total', '', 'int');
        $rep_id = $input->post->get('rep_id', '', 'int');
        $phone = $input->post->get('phone', '', 'string');
        $email = $input->post->get('email', '', 'string');
        $date = $input->post->get('date', '', 'string');
        $rep_id = $input->post->get('rep_id', '', 'int');
        $rep_document = '';
        $rep_document_date = '';

        $item = $model->getItem($id, true);
        $file_name = self::getFileName($item, $template);

        $no_middle_name = !empty($item->middle_name_ru) ? '' : '1';
        $status = '5';
        $rep_fullname = '';

        if (!empty($rep_id)) {
            $rep = $model->getItem($rep_id);
            $status = '6';
            $rep_fullname = $rep->last_name_ru . ' ' . $rep->first_name_ru . ' ' . $rep->middle_name_ru;
            $rep_taxpayer_id = $rep->taxpayer_id;
            $phone = !empty($rep->phone) ? $rep->phone : $phone;
            $rep_document = $input->post->get('rep_document', '', 'string');
            $rep_document_date = $input->post->get('rep_document_date', '', 'string');
            $rep_document .= ' ' . __('FROM_DATE') . ' ' . $rep_document_date;
        }

        $birth_place = !empty($item->citizenship_name) ? $item->citizenship_name . ' ' : '';
        $birth_place .= $item->birth_place;
        $genders = ['MALE' => '1', 'FEMALE' => '2'];
        $document_code = '10';
        $document_code_2 = $document_code;
        $document_serie_number = $item->passport_serie ? $item->passport_serie . ' ' : '';
        $document_serie_number .= $item->passport_number;
        $document_serie_number_2 = $document_serie_number;
        $document_issuer = $item->passport_issuer;
        $document_issuer_2 = $document_issuer;
        $document_issuer_code_1 = '';
        $document_issuer_code_2 = '';
        $document_issued = $item->passport_issued;
        $document_issued_2 = $document_issued;
        $has_citizenship = $item->citizenship ? '1' : '2';
        $country_code = $item->country_code;
        $country_code_2 = $country_code;
        $is_resident = ($item->citizenship == '177' || $item->resident_document) ? '1' : '2';
        $reg_adrress = self::parseAddress($item->reg_address_name, false);

        if ($item->citizenship == '177') {
            $document_code = '21';
            $passport_issuer_code = explode('-', $item->passport_issuer_code);
            $document_issuer_code_1 = $passport_issuer_code[0];
            $document_issuer_code_2 = $passport_issuer_code[1];
            $document_code_2 = '';
            $document_serie_number_2 = '';
            $document_issuer_2 = '';
            $country_code_2 = '';
            $document_issued_2 = '';
        } elseif ($item->resident_document == 'RESIDENT_CARD') {
            $document_code = '12';
            $document_code_2 = $document_code;
            $document_serie_number = $item->resident_document_serie ? $item->resident_document_serie . ' ' : '';
            $document_serie_number .= $item->resident_document_number;
            $document_serie_number_2 = $document_serie_number;
            $document_issuer = $item->resident_document_issuer;
            $document_issuer_2 = $document_issuer;
            $document_issued = $item->resident_document_issued;
            $document_issued_2 = $document_issued;
        }

        $fields =
            [
                'file_name'               => $file_name,
                'taxpayer_id'             => $taxpayer_id,
                'inspection_code'         => $inspection_code,
                'last_name_ru'            => $item->last_name_ru,
                'first_name_ru'           => $item->first_name_ru,
                'middle_name_ru'          => $item->middle_name_ru,
                'no_middle_name'          => $no_middle_name,
                'status'                  => $status,
                'pages_total'             => $pages_total,
                'rep_taxpayer_id'         => $rep_taxpayer_id,
                'rep_last_name_ru'        => $rep->last_name_ru,
                'rep_first_name_ru'       => $rep->first_name_ru,
                'rep_middle_name_ru'      => $rep->middle_name_ru,
                'phone'                   => $phone,
                'email'                   => $email,
                'taxpayer_id_3'           => $taxpayer_id,
                'last_name_ru_2'          => $item->last_name_ru,
                'first_name_initial'      => mb_substr($item->first_name_ru, 0, 1),
                'middle_name_initial'     => mb_substr($item->middle_name_ru, 0, 1),
                'gender'                  => $genders[$item->gender],
                'document_code'           => $document_code,
                'document_serie_number'   => $document_serie_number,
                'document_issuer'         => $document_issuer,
                'document_issuer_code_1'  => $document_issuer_code_1,
                'document_issuer_code_2'  => $document_issuer_code_2,
                'has_citizenship'         => $has_citizenship,
                'country_code'            => $country_code,
                'is_resident'             => $is_resident,
                'zip_code'                => $reg_adrress['zip_code'],
                'district'                => $reg_adrress['district'],
                'city'                    => $reg_adrress['city'],
                'locality'                => $reg_adrress['locality'],
                'street'                  => $reg_adrress['street'],
                'house'                   => $reg_adrress['house'],
                'building'                => $reg_adrress['building'],
                'room'                    => $reg_adrress['room'],
                'taxpayer_id_4'           => $taxpayer_id,
                'last_name_ru_3'          => $item->last_name_ru,
                'first_name_initial_2'    => mb_substr($item->first_name_ru, 0, 1),
                'middle_name_initial_2'   => mb_substr($item->middle_name_ru, 0, 1),
                'document_code_2'         => $document_code_2,
                'document_serie_number_2' => $document_serie_number_2,
                'document_issuer_2'       => $document_issuer_2,
                'country_code_2'          => $country_code_2
            ];

        $dates =
            [
                'app'                  => $date,
                'birth_date'           => $item->birth_date,
                'document_issued'      => $document_issued,
                'document_issued_2'    => $document_issued_2,
                'registration_date'    => $item->reg_date,
                'registration_expired' => $item->visa_expired
            ];

        self::splitDate($dates, $fields);

        self::splitText($rep_document, 'rep_document', $fields, false, false, true, 2, 20);
        self::splitText($birth_place, 'birth_place', $fields, false, false, true, 2, 40);

        self::output($template, $fields, true);
    }

    public static function updateRelatedUsers($user, &$data, $table_name)
    {
        if ($user->authorise('core.admin')) {
            return;
        }

        $data['user_ids'] = [];
        $data['user_ids'][] = $user->id;
        $table_name .= 's';

        $related_groups = self::getRelatedGroups();
        $limited_users = self::getLimitedUsers();

        $addrress_column =
            [
                'addresses' => 'id',
                'employee'  => 'reg_address'
            ];
        $employer_column =
            [
                'employers' => 'id',
                'employee'  => 'employer_id'
            ];

        $limited_address = !empty($addrress_column[$table_name]) ? $data[$addrress_column[$table_name]] : '';
        $limited_employer = !empty($employer_column[$table_name]) ? $data[$employer_column[$table_name]] : '';

        $related_users = [];

        if (!empty($related_groups)) {
            foreach ($related_groups as $related_group) {
                if ($user->id == $related_group['main']) {
                    $related_users = !empty($related_group['related']) ? $related_group['related'] : $related_users;
                    break;
                }
            }
        }

        if (!empty($related_users)) {
            foreach ($related_users as $k => $related_user) {
                if (
                    !empty($limited_users[$related_user]['exclusive_employees']) &&
                    in_array($data['id'], $limited_users[$related_user]['exclusive_employees'])
                ) {
                    continue;
                }

                if (
                    (
                        !empty($limited_users[$related_user]) &&
                        !in_array($table_name, ['addresses', 'employee', 'employers'])
                    ) ||
                    (
                        !empty($limited_address) &&
                        !empty($limited_users[$related_user]['limited_addresses']) &&
                        !in_array($limited_address, $limited_users[$related_user]['limited_addresses'])
                    ) ||
                    (
                        !empty($limited_employer) &&
                        !empty($limited_users[$related_user]['limited_employers']) &&
                        !in_array($limited_employer, $limited_users[$related_user]['limited_employers'])
                    )
                ) {
                    unset($related_users[$k]);
                }
            }
        }

        $data['user_ids'] = array_unique(array_merge($data['user_ids'], $related_users));
    }

    public static function updateStaff($years = [], $months = [])
    {
        $types =
            [
                'russians'                          => ['is_russian'],
                'vietnamese_has_residency'          => ['is_vietnamese', 'has_residency'],
                'vietnamese_residents'              => ['is_vietnamese', 'is_resident', 'no_residency'],
                'vietnamese_no_residents'           => ['is_vietnamese', 'no_resident', 'no_residency'],
                'cis_has_residency'                 => ['no_visas', 'has_residency'],
                'cis_no_work_licences_residents'    => ['no_work_licences', 'is_resident'],
                'cis_no_work_licences_no_residents' => ['no_work_licences', 'no_resident'],
                'cis_work_licences_residents'       => ['no_visas', 'work_licences', 'is_resident'],
                'cis_work_licences_no_residents'    => ['no_visas', 'work_licences', 'no_resident']
            ];

        $app = Factory::getApplication();
        $app->input->set('cron', 1);
        $app->input->set('view', 'employee');
        $app->input->set('layout', 'countbyparams_modal');
        $app->input->set('tmpl', 'component');
        $app->input->set('limit', 0);
        $msg = [];

        if ($years == []) {
            $now = Factory::getDate('first day of last month');
            $year = $now->format('Y');
            $years[] = $year;

            if ($months == []) {
                $month = $now->format('m');
                $months[] = $month;
            }
        } else {
            if ($months == []) {
                $months = ['01', '02', '03', '04', '05', '06', '07', '08', '09', '10', '11', '12'];
            }
        }

        try {
            foreach ($years as $year) {
                foreach ($months as $month) {
                    $month = strlen($month) == 1 ? '0' . $month : $month;
                    $app->input->set('filter_date', $year . '-' . $month);
                    $msg[] = $year . '-' . $month;
                    $month = 'm' . $month;
                    $data = new CMSObject;

                    foreach ($types as $type => $filters) {
                        $data->{$type} = [];
                        $app->input->set($type, 1);

                        foreach ($filters as $filter) {
                            $app->input->set($filter, 1);
                        }

                        $model = BaseDatabaseModel::getInstance('Employees', 'FMSDocsModel');
                        $tmp = $model->getItems();

                        if (!empty($tmp)) {
                            foreach ($tmp as $obj) {
                                $data->{$type}[] = $obj->id;
                            }
                        }

                        $app->input->set($type, 0);

                        foreach ($filters as $filter) {
                            $app->input->set($filter, 0);
                        }
                    }

                    $model = BaseDatabaseModel::getInstance('Staff', 'FMSDocsModel');

                    $row_data = [];
                    $row_data['year'] = $year;
                    $row_data[$month] = json_encode($data);
//                    echo '<pre>', print_r($data), '</pre>';
//                    exit();
                    $model->save($row_data);
                }
            }
        } catch (Exception $e) {
            $msg[] = $e->getMessage();
        }

        echo implode(PHP_EOL, $msg);
        exit();
    }

    public static function uploadFiles($app, $input, $model, $view, $id, $template)
    {
        $allowed_extensions = ['jpg', 'jpeg', 'png', 'gif', 'pdf', 'doc', 'docx'];
        $files = $input->files->get('files', [], 'array');
        $post = $input->post->get('files', [], 'array');
        $folder = JPATH_ROOT . '/components/com_fmsdocs/files/' . $view . '/' . $id;
        $file_info = [];
        $new_invite = '';

        foreach ($files as $key => $file) {
            $file = $file['file'];
            $file['name'] = str_replace(' ', '_', Ru_RULocalise::transliterate($file['name']));

            try {
                if ($file['error'] == 4) {
                    throw new Exception(__('NO_FILES'));
                }

                $extension = pathinfo($file['name'])['extension'];

                if (!in_array($extension, $allowed_extensions)) {
                    throw new Exception(Text::sprintf('FILE_NOT_ALLOWED', $extension));
                }

                if (!File::upload($file['tmp_name'], $folder . '/' . $file['name'])) {
                    throw new Exception(__('FILE_NOT_UPLOADED'));
                }

                $file_info[] = [
                    $view,
                    $id,
                    $file['name'],
                    $post[$key]['type']
                ];

                if ($post[$key]['type'] == 'INVITE') {
                    $new_invite = $file['name'];
                }

                $app->enqueueMessage(
                    Text::sprintf('FILE_UPLOAD_SUCCEED', $file['name'], __($post[$key]['type']))
                );
            } catch (Exception $e) {
                $app->enqueueMessage($e->getMessage(), 'error');
            }
        }

        if (!empty($file_info)) {
            try {
                $db = Factory::getDbo();

                foreach ($file_info as &$value) {
                    $value = '(' . implode(', ', $db->quote($value)) . ')';
                }

                $query =
                    'INSERT INTO #__fmsdocs_files' .
                    ' (file_folder, item_id, file_name, file_type)' .
                    ' VALUES ' . implode(', ', $file_info) .
                    ' ON DUPLICATE KEY UPDATE created = NOW()';

                $db->setQuery($query)->execute();
            } catch (Exception $e) {
                $app->enqueueMessage($e->getMessage(), 'error');
            }
        }

        if (!empty($new_invite)) {
            try {
                $employee_model = BaseDatabaseModel::getInstance('Employee', 'FMSDocsModel');
                $employee = $employee_model->getItem($id);
                $employee_name = $employee->last_name_ru . ' ' . $employee->first_name_ru;
                $employee_name .= $employee->middle_name_ru ? ' ' . $employee->middle_name_ru : '';
                $recipients = FMSDocsSiteHelper::getEmailRecipientsByEmployee($employee);
                $link = Uri::root() . 'components/com_fmsdocs/files/' . $view . '/' . $id . '/' . $new_invite;

                $post = new CMSObject();
                $post->recipient_emails = $recipients['recipient_emails'];
                $post->theme = Text::sprintf('NEW_INVITE', $employee_name);
                $post->text = Text::sprintf('DOWNLOAD_INVITE', $link, $new_invite);
//				echo '<pre>', print_r($post), '</pre>'; exit;
                self::sendMessage($post);
            } catch (Exception $e) {
                $app->enqueueMessage($e->getMessage(), 'error');
            }
        }
    }
}