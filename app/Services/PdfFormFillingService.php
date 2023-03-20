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
    static $legalEmployers = ['LEGAL_RUS', 'LEGAL_SEMI'];

    static $individualHosts = ['INDIVIDUAL', 'PRIVATE'];

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
     * Method to decline word suffix
     *
     * @param string $string
     * @param int $case
     * @param string $gender
     * @param string $type
     * @param int $affected
     * @param bool $uc
     * @return string
     */
    public static function declension(string $string,
                                      int    $case,
                                      string $gender = '',
                                      string $type = '',
                                      int    $affected = 0,
                                      bool   $uc = false): string
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

    /**
     * Get data fields
     *
     * @param string $doc
     * @param array $data
     * @param array|null $docData
     * @return array
     */
    public static function getDataFields(string $doc, array $data, array $docData = null): array
    {
        $pdf = new Pdf(static::getTemplate($doc));
        $allFields = $pdf->getDataFields()->__toArray();

        foreach ($allFields as $key => $field) {
            $allFields[$field['FieldName']] = $field;
            unset($allFields[$key]);
        }

        $splitFields = array_intersect_ukey(
            $data,
            $allFields,
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

        if ($splitFields) {
            $options = [];
            $options['justify'] = $docData['justify'] ?? true;
            $options['split_word'] = $docData['split_word'] ?? false;
            $options['cells'] = $docData['cells'] ?? false;

            array_walk(
                $splitFields,
                function (&$value, $key) use ($options) {
                    $value = ['text' => $value, 'options' => $options];
                }
            );
        }

        return ['all' => $allFields, 'split' => $splitFields];
    }

    /**
     * Get the file name for PDF output
     *
     * @param int $id
     * @param string $doc
     * @param bool $lowercase
     * @return string
     */
    public static function getFileName(int $id, string $doc, bool $lowercase = false): string
    {
        $employee = Employee::find($id);
        $fileName = implode('-', [
            str_replace(' ', '-', $employee->full_name_en),
            __($doc),
            date('dmy-His', time()),
        ]);

        return ($lowercase ? str_replace(' ', '_', mb_strtolower($fileName)) : $fileName) . '.pdf';
    }

    /**
     * Get the PDF-form template
     *
     * @param string $doc
     * @return string
     */
    public static function getTemplate(string $doc): string
    {
        return config('app.pdf_template_path') . $doc . '.pdf';
    }

    public static function handlePhones($phones, $code = '', $keys = [], $no_spaces = true, $delimiter = ',')
    {
        if (!is_array($phones)) {
            $phones = array_filter([$phones]);
        }

        if (!$phones) {
            return '';
        }

        $patterns = ['#^\s*(\+7|8)(.*)$#'];
        $patterns[] = $no_spaces ? '#\D#' : '#[^\d\s]#';
        $result = [];

        foreach ($phones as $key => $phone) {
            if (in_array(-($key + 1), $keys)) {
                unset($phones[$key]);
                unset($keys[array_search(-($key + 1), $keys)]);
                continue;
            }

            if (in_array($key + 1, $keys) || !$keys) {
                $result[] = preg_replace($patterns, [$code . '$2', ''], trim($phone['phone']));
            }
        }

        return implode($delimiter . ' ', $result);
    }

    public static function parseAddress($address, $typeRequired = true)
    {
        $parts = explode(',', $address);

        $patterns = [
            'region'      => __('REGEXP_REGION'),
            'city'        => __('REGEXP_CITY'),
            'district'    => __('REGEXP_DISTRICT'),
            'street'      => __('REGEXP_STREET'),
            'house'       => __('REGEXP_HOUSE_1') . '|' . __('REGEXP_HOUSE_2') . '|' . __('REGEXP_HOUSE_3') . '|' .
                             __('REGEXP_HOUSE_4'),
            'building'    => __('REGEXP_BUILDING'),
            'subBuilding' => __('REGEXP_SUB_BUILDING'),
            'room'        => __('REGEXP_ROOM_1') . '|' . __('REGEXP_ROOM_2') . '|' . __('REGEXP_ROOM_3'),
        ];

        $houseVariants = [
            'HOUSE_1' => 'REGEXP_HOUSE_1',
            'HOUSE_2' => 'REGEXP_HOUSE_2',
            'HOUSE_3' => 'REGEXP_HOUSE_3',
            'HOUSE_4' => 'REGEXP_HOUSE_4',
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

    public static function parseDate(
        $date,
        $fullMonthFormat = false,
        $fullYear = true
    )
    {
        if ($date == '') {
            return ['d' => '', 'm' => '', 'y' => ''];
        }

        $date = Carbon::parse($date);

        $result['d'] = $date->isoFormat('DD');
        $result['m'] =
            $fullMonthFormat ? $date->getTranslatedMonthName('MMMM', '_full') : $date->isoFormat('MM');
        $result['y'] = $fullYear ? $date->isoFormat('YYYY') : $date->isoFormat('YY');

        return $result;
    }

    /**
     * Prepare data for PDF-form
     *
     * @param $doc
     * @param array $docData
     * @param array $data
     * @return array|array[]|false|false[]|string|string[]|string[][]|null
     */
    public static function prepareData($doc, array $docData, array $data)
    {
        if (isset($docData['upper_case']) && validate_boolean($docData['upper_case'], true)) {
            $data = to_upper_case($data);
        }

        $dataFields = static::getDataFields($doc, $data, $docData);
        $allFields = $dataFields['all'];
        $splitFields = $dataFields['split'];

        if (!$splitFields) {
            return $data;
        }

        # Split fields to fit rows
        foreach ($splitFields as $key => $value) {
            $count = 1;
            $rows = [];

            while (isset($allFields[$key . '_' . $count])) {
                try {
                    $rows[] = $allFields[$key . '_' . $count]['FieldMaxLength'];
                    $count++;
                } catch(\Exception $exception) {
                    dd($key . ': ' . $exception->getMessage());
                }
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

    public static function printArrivalNotice($docData, $doc, $id): array
    {
        $employee = Employee::find($id);
        $citizenship = Country::find($employee->citizenship_id);
        $birthPlace = implode(' ', array_filter([$citizenship->name_ru, $employee->birth_place]));
        $occupation = Occupation::find($employee->last_job->occupation_id);
        $occupation = $occupation ? $occupation->nam_ru : '';

        $employer = Employer::find($employee->last_job->employer_id);
        $employerType = Type::find($employer->type_id)->code;

        if (in_array($employerType, static::$individualHosts)) {
            $employerType = 'INDIVIDUAL';
        }

        $employerAddress = Address::find($employer->address_id)->name_ru;
        $director = Employee::find($employer->director_id);

        $regAddress = Address::find($employee->reg_address_id);

        if (!empty($regAddress->usage_permits[$employer->id])) {
            $obj = $regAddress->usage_permits[$employer->id];
            $signing_date = static::parseDate($obj->signing_date);
            $usage_permit = $obj->name_ru . __('SINCE') .
                            $signing_date['d'] . '-' . $signing_date['m'] . '-' . $signing_date['y'];
        } else {
            $usage_permit = '';
        }

        $regAddress = static::parseAddress($regAddress->name_ru);
        $destinationCity = implode(', ', array_filter([$regAddress['city'], $regAddress['locality']]));

        $directorAddress = static::parseAddress($director->address);
        $directorCity = array_filter([$directorAddress['city'], $directorAddress['locality']]);

        $passport = __('PASSPORT');

        $representatives = '';
        $existingAddress = '';

        if ($employee->history) {
            foreach (array_reverse($employee->history) as $item) {
                $existingAddress = $item['prev_value']['reg_address_name'] ?? $existingAddress;

                if ($existingAddress) {
                    break;
                }
            }
        }

        $data =
            [
                'last_name_ru'                           => $employee->last_name_ru,
                'first_name_ru'                          => $employee->first_name_ru,
                'middle_name_ru'                         => $employee->middle_name_ru,
                'guest_last_name_ru'                     => $employee->last_name_ru,
                'guest_first_name_ru'                    => $employee->first_name_ru,
                'guest_middle_name_ru'                   => $employee->middle_name_ru,
                'citizenship'                            => $citizenship->name_ru,
                'guest_citizenship'                      => $citizenship->name_ru,
                strtolower($employee->gender)            => 'X',
                'guest_' . strtolower($employee->gender) => 'X',
                'passport'                               => $passport,
                'guest_passport'                         => $passport,
                'passport_serie'                         => $employee->passport_serie,
                'guest_passport_serie'                   => $employee->passport_serie,
                'passport_number'                        => $employee->passport_number,
                'guest_passport_number'                  => $employee->passport_number,
                'phone'                                  => static::handlePhones($employee->phone, '8', [1]),
                'occupation'                             => $occupation,
                'migr_card_serie'                        => $employee->migr_card_serie,
                'migr_card_number'                       => $employee->migr_card_number,
                'destination_district'                   => $regAddress['district'],
                'actual_destination_district'            => $regAddress['district'],
                'guest_destination_district'             => $regAddress['district'],
                'destination_city'                       => $destinationCity,
                'actual_destination_city'                => $destinationCity,
                'guest_destination_city'                 => $destinationCity,
                'destination_street'                     => $regAddress['street'],
                'guest_destination_street'               => $regAddress['street'],
                'destination_house_type'                 => $regAddress['houseType'],
                'guest_destination_house_type'           => $regAddress['houseType'],
                'destination_house'                      => $regAddress['house'],
                'guest_destination_house'                => $regAddress['house'],
                'destination_building'                   => $regAddress['building'],
                'guest_destination_building'             => $regAddress['building'],
                'destination_sub_building'               => $regAddress['subBuilding'],
                'guest_destination_sub_building'         => $regAddress['subBuilding'],
                'destination_room_type'                  => $regAddress['roomType'],
                'guest_destination_room_type'            => $regAddress['roomType'],
                'destination_room'                       => $regAddress['room'],
                'guest_destination_room'                 => $regAddress['room'],
                strtolower($employerType)                => 'X',
                'director_last_name'                     => $director->last_name_ru,
                'director_first_name'                    => $director->first_name_ru,
                'director_middle_name'                   => $director->middle_name_ru,
                'host_last_name'                         => $director->last_name_ru,
                'host_first_name'                        => $director->first_name_ru,
                'host_middle_name'                       => $director->middle_name_ru,
                'director_passport'                      => $passport,
                'director_passport_serie'                => $director->passport_serie,
                'director_passport_number'               => $director->passport_number,
                'director_district'                      => $directorAddress['district'],
                'director_city'                          => implode(', ', $directorCity),
                'director_street'                        => $directorAddress['street'],
                'director_house'                         => $directorAddress['house'],
                'director_building'                      => $directorAddress['building'],
                'director_sub_building'                  => $directorAddress['subBuilding'],
                'director_room'                          => $directorAddress['room'],
                'director_phone'                         => static::handlePhones($director->phone),
                'employer_taxpayer_id'                   => $employer->taxpayer_id,
                'birth_place'                            => $birthPlace,
                'guest_birth_place'                      => $birthPlace,
                'destination_region'                     => $regAddress['region'],
                'actual_destination_region'              => $regAddress['region'],
                'guest_destination_region'               => $regAddress['region'],
                'usage_permit'                           => $usage_permit,
                'representatives'                        => $representatives,
                'existing_address'                       => $existingAddress,
                'director_region'                        => $directorAddress['region'],
                'employer_name'                          => $employer->name_ru,
                'employer_address'                       => $employerAddress,
            ];

        $visaCategory = 'WORK';

        if ($employee->resident_document) {
            $data[strtolower($employee->resident_document)] = 'X';
            $data['resident_permit_serie'] = $employee->resident_document_serie;
            $data['resident_permit_number'] = $employee->resident_document_number;
        }

        if ($employee->visa_number) {
            $data['visa'] = 'X';
            $visaCategory = $employee->visa_category ?: $visaCategory;
            $data['resident_permit_serie'] = $employee->visa_serie;
            $data['resident_permit_number'] = $employee->visa_number;
        }


        $data[strtolower($visaCategory)] = 'X';

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

        static::splitDate($dates, $data);

        return static::prepareData($doc, $docData, $data);
    }

    public static function printDepartureNotice($docData, $doc, $id)
    {
        $employee = Employee::find($id);
        $firstMiddleName =
            implode(' ', array_filter([$employee->first_name_ru, $employee->middle_name_ru]));
        $employer = Employer::find($employee->last_job->employer_id);
        $director = Employee::find($employer->director_id);
        $directorFirstMiddleName =
            implode(' ', array_filter([$director->first_name_ru, $director->middle_name_ru]));
        $repId = $docData['rep_id'] ?: $employee->director;
        $rep = Employee::find($repId);
        $regAddress = static::parseAddress(
            Address::find($employee->reg_address_id)->name_ru
        );
        $city = array_filter([$regAddress['city'], $regAddress['locality']]);

        $data =
            [
                'last_name_ru_1'                  => $employee->last_name_ru,
                'last_name_ru_2'                  => $employee->last_name_ru,
                'first_middle_name_ru_1'          => $firstMiddleName,
                'first_middle_name_ru_2'          => $firstMiddleName,
                'region_1'                        => $regAddress['region'],
                'district_1'                      => $regAddress['district'],
                'city_1'                          => implode(', ', $city),
                'street_1'                        => $regAddress['street'],
                'house_1'                         => $regAddress['house'],
                'building_1'                      => $regAddress['building'],
                'sub_building_1'                  => $regAddress['subBuilding'],
                'room_1'                          => $regAddress['room'],
                'director_last_name_ru_1'         => $director->last_name_ru,
                'director_first_middle_name_ru_1' => $directorFirstMiddleName,
                'director_passport'               => __('PASSPORT'),
                'director_passport_serie'         => $director->passport_serie,
                'director_passport_number'        => $director->passport_number,
                'director_phone'                  => $director->phone,
                'employer_name'                   => $employer->full_name_ru,
                'employer_address'                => Address::find($employer->address_id)->name_ru,
                'employer_taxpayer_id'            => $employer->taxpayer_id,
                'rep_passport_1'                  => __('PASSPORT'),
                'rep_passport_serie'              => $rep->passport_serie,
                'rep_passport_number'             => $rep->passport_number,
            ];

        $dates =
            [
                'birth_1'                   => $employee->birth_date,
                'birth_2'                   => $employee->birth_date,
                'departure'                 => $docData['departure_date'],
                'director_passport_issued'  => $director->passport_issued_date,
                'director_passport_expired' => $director->passport_expired_date,
                'rep_passport_issued'       => $rep->passport_issued_date,
                'rep_passport_expired'      => $rep->passport_expired_date
            ];

        static::splitDate($dates, $data);

        return static::prepareData($doc, $docData, $data);
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
        $fileName = static::getFileName($id, $doc, true);

        if (!$pdf->send($fileName, true)) {
            abort(
                implode(
                    "\r\n",
                    array_filter([$pdf->getError(), $pdf->getCommand()->getStdErr()])
                )
            );
        }
    }

    public static function printFiringNotice($docData, $doc, $id)
    {
        return static::printHiringOrFiringNotice($docData, $doc, $id);
    }

    public static function printHiringNotice($docData, $doc, $id)
    {
        return static::printHiringOrFiringNotice($docData, $doc, $id);
    }

    public static function printHiringOrFiringNotice($docData, $doc, $id)
    {
        $recipient = Employer::find($docData['authority_id']);
        $agent = (isset($docData['agent_id']) && $docData['agent_id']) ? Employee::find($docData['agent_id']) : null;
        $employee = Employee::find($id);
        $employer = Employer::find($employee->last_job->employer_id);

        $employerType = Type::find($employer->type_id)->code;

        if (in_array($employerType, static::$legalEmployers)) {
            $employerType = 'LEGAL';
        }

        $accRegInfo = array_filter(
            [
                $employer->acc_reg_number,
                $employer->employer_taxpayer_id,
                $employer->taxpayer_code
            ]
        );
        $accRegInfo = implode(',', $accRegInfo);

        $employerPhone = static::handlePhones($employer->phone, '8', [1]);

        $citizenship = Country::find($employee->citizenship_id);
        $birthPlace = implode(', ', [$citizenship->name_ru, $employee->birth_place]);

        $director = Employee::find($employer->director_id);
        $director_name = static::shortenName($director);

        $regInfo = array_filter(
            [$employer->uni_reg_number, $employer->prime_reg_number]
        );
        $regInfo = implode(',', $regInfo);

        $data =
            [
                strtolower($employerType) => 'X',
                'active_business_type'    => preg_replace(
                    '~(\d+)(.\d+)*(\D)*~',
                    '$1$2',
                    $employer->active_business_type
                ),
                'acc_reg_info'            => $accRegInfo,
                'employer_phone'          => $employerPhone,
                'last_name_ru'            => $employee->last_name_ru,
                'first_name_ru'           => $employee->first_name_ru,
                'middle_name_ru'          => $employee->middle_name_ru,
                'citizenship'             => $citizenship->name_ru,
                'passport'                => __('PASSPORT'),
                'passport_serie'          => $employee->passport_serie,
                'passport_number'         => $employee->passport_number,
                'director'                => __('GENERAL_DIRECTOR'),
                'director_name'           => $director_name,
                'recipient'               => $recipient->name_ru,
                'employer_name'           => $employer->full_name_ru,
                'reg_info'                => $regInfo,
                'employer_address'        => Address::find($employer->address_id)->name_ru,
                'birth_place'             => $birthPlace,
                'issuer'                  => $employee->passport_issuer,
                'occupation'              => Occupation::find($employee->last_job->occupation_id)->name_ru,
            ];

//		$data[strtolower($item->gender)] = 'Х';

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
            $data['work_permit_issuer'] =
                $employee->work_permit_issuer_id ? Employer::find($employee->work_permit_issuer_id)->name_ru : '';
        }

        $dates =
            [
                'birth'           => $employee->birth_date,
                'passport_issued' => $employee->passport_issued_date,
            ];

        if ($doc == 'hiring-notice') {
            $dates['hired'] = $docData['hired_date'];

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

        return static::prepareData($doc, $docData, $data);
    }

    public static function printInviteMotion($docData, $doc, $id)
    {
        $date = Carbon::parse($docData['date'])->isoFormat('DD.MM.YYYY');
        $desiredDate = Carbon::parse($docData['date'])->addDays(30)->isoFormat('DD.MM.YYYY');
        $supposedEntryDate = Carbon::parse($docData['date'])->addDays(30)->isoFormat('DD.MM.YYYY');
        $upToDate = Carbon::parse($docData['date'])->addDays(120)->isoFormat('DD.MM.YYYY');
        $inviteForm = $docData['invite_form'];
        $multiplicity = $docData['visa_multiplicity'];
        $tripPurpose = $docData['visa_purpose'];
        $employee = Employee::find($id);
        $country = Country::find($employee->citizenship_id)->name_ru;
        $birthDate = Carbon::parse($employee->birth_date)->isoFormat('DD.MM.YYYY');
        $passportIssued = Carbon::parse($employee->passport_issued_date)->isoFormat('DD.MM.YYYY');
        $passportExpired = Carbon::parse($employee->passport_expired_date)->isoFormat('DD.MM.YYYY');

        if (strpos($employee->visa_issuer, ',') !== false) {
            $visaIssuer = explode(',', $employee->visa_issuer);
            $visaIssuedCountry = $visaIssuer[0];
            $visaIssuedRegion = $visaIssuer[1];
        } else {
            $visaIssuedCountry = $country;
            $visaIssuedRegion = $employee->visa_issuer;
        }

        $employer = Employer::find($docData['inviter_id']);
        $director = Employee::find($employer->director_id);
        $uniRegDate = Carbon::parse($employer->uni_reg_date)->isoFormat('DD.MM.YYYY');

        $address = Address::find($employer->address_id)->name_ru;
        $parsedAddress = static::parseAddress($address);
        $tripStops = array_filter([
            $parsedAddress['region'],
            $parsedAddress['city'],
            $parsedAddress['locality']
        ]);
        array_unshift($tripStops, __('RUSSIA'));
        $tripStops = implode(', ', $tripStops);


        $data =
            [
                strtolower($inviteForm)       => 'Х',
                'date'                        => $date,
                'taxpayer_id'                 => $employer->taxpayer_id,
                'prime_reg_number'            => $employer->prime_reg_number,
                'uni_reg_date'                => $uniRegDate,
                'full_name'                   => $employer->full_name_ru,
                'address_name'                => $address,
                'real_address_name'           => $address,
                'phone'                       => static::handlePhones($employer->phone, '8', [1], false),
                'desired_date'                => $desiredDate,
                'director'                    => static::shortenName($director),
                'trip_purpose'                => __($tripPurpose),
                'trip_stops'                  => $tripStops,
                'duration'                    => __('DURATION'),
                'supposed_entry_date'         => $supposedEntryDate,
                'up_to'                       => $upToDate,
                strtolower($multiplicity)     => 'Х',
                strtolower($tripPurpose)      => 'Х',
                'special_pass_number'         => '',
                'special_pass_date_from'      => '',
                'special_pass_date_to'        => '',
                'last_name_ru'                => $employee->last_name_ru,
                'last_name_en'                => $employee->last_name_en,
                'first_name_ru'               => $employee->first_name_ru,
                'first_name_en'               => $employee->first_name_en,
                'middle_name_ru'              => $employee->middle_name_ru,
                'birth_date'                  => $birthDate,
                strtolower($employee->gender) => 'X',
                'citizenship_name'            => $country,
                'birth_place_country'         => $country,
                'birth_place_region'          => $employee->birth_place,
                'address_country'             => $country,
                'address_region'              => $employee->birth_place,
                'visa_issued_country'         => $visaIssuedCountry,
                'visa_issued_region'          => $visaIssuedRegion,
                'work_place'                  => __('NO'),
                'occupation'                  => __('NO'),
                'passport_serie'              => $employee->passport_serie,
                'passport_number'             => $employee->passport_number,
                'passport_issued'             => $passportIssued,
                'passport_expired'            => $passportExpired,
                'host_phone'                  => static::handlePhones($employer->phone, '8', [1], false),
            ];

        return static::prepareData($doc, $docData, $data);
    }

    public static function printVisaApplication($docData, $doc, $id)
    {
        $action = $docData['action'];
        $visaPurpose = $docData['visa_purpose'];
        $inviterId = $docData['inviter_id'];
        $destinationId = $docData['destination_id'];

        $visaMultiplicity = $docData['visa_multiplicity'];
        $visaCategory = $docData['visa_category'];
        $date = $docData['date'];

        $employee = Employee::find($id);
        $citizenship = Country::find($employee->citizenship_id)->name_ru;
        $birthPlace = $employee->birth_place;
        $homeAddress = implode(', ', [$citizenship, $birthPlace]);
        $occupation = Occupation::find($employee->last_job->occupation_id)->name_ru;
        $reason = static::getReason($docData);
        $inviter = Employer::find($inviterId);
        $inviterPhone = static::handlePhones($inviter->phone, '8', [1], false);
        $inviterAddress = Address::find($inviter->address_id)->name_ru;
        $inviterTaxpayerId = __('TAXPAYER_ID') . ' ' . $inviter->taxpayer_id;
        $inviterInfo = array_filter([
            $inviter->full_name_ru,
            $inviterTaxpayerId,
            $inviterAddress,
            $inviterPhone
        ]);
        $inviterInfo = implode(', ', $inviterInfo);

        $employer = Employer::find($employee->last_job->employer_id);
        $employerPhone = static::handlePhones($employer->phone, '8', [1], false);
        $employerTaxpayerId = __('TAXPAYER_ID') . ' ' . $employer->taxpayer_id;
        $employerAddress = Address::find($employer->address_id)->name_ru;

        $hostInfo = array_filter([
            $employer->name_ru,
            $employerTaxpayerId,
            $employerAddress,
            $employerPhone
        ]);
        $hostInfo = implode(', ', $hostInfo) ?: $inviterInfo;

        $workInfo = array_filter([
            $employer->name_ru,
            $occupation,
            $employerAddress,
            $employerPhone
        ]);
        $workInfo = implode(', ', $workInfo);

        $destination = Address::find($destinationId)->name_ru;
        $relatives = __('NO');

        $inviterAddress = static::parseAddress($inviterAddress);
        $tripStops = array_filter([
            $inviterAddress['region'],
            $inviterAddress['city'],
            $inviterAddress['locality']
        ]);
        array_unshift($tripStops, __('RUSSIA'));
        $tripStops = implode(', ', $tripStops);

        $data =
            [
                strtolower($action)           => '',
                strtolower($visaMultiplicity) => 'Х',
                strtolower($visaCategory)     => 'Х',
                strtolower($visaPurpose)      => 'Х',
                'last_name_ru'                => $employee->last_name_ru,
                'last_name_en'                => $employee->last_name_en,
                'first_name_ru'               => $employee->first_name_ru,
                'first_name_en'               => $employee->first_name_en,
                'middle_name_ru'              => $employee->middle_name_ru,
                strtolower($employee->gender) => 'Х',
                'citizenship_name'            => $citizenship,
                'birth_place'                 => $birthPlace,
                'passport'                    => __('PASSPORT'),
                'passport_serie'              => $employee->passport_serie,
                'passport_number'             => $employee->passport_number,
                'existing_visa_serie'         => $employee->visa_serie,
                'existing_visa_number'        => $employee->visa_number,
                'existing_invitation_number'  => $employee->invitation_number,
                'reason'                      => $reason,
                'inviter'                     => $inviterInfo,
                'host'                        => $hostInfo,
                'relatives'                   => $relatives,
                'destination_address'         => $destination,
                'trip_stops'                  => $tripStops,
                'home_address'                => $homeAddress,
                'work_info'                   => $workInfo,
            ];

        $dates =
            [
                'date'                       => $date,
                'birth_date'                 => $employee->birth_date,
                'passport_issued_date'       => $employee->passport_issued_date,
                'passport_expired_date'      => $employee->passport_expired_date,
                'existing_visa_started_date' => $employee->visa_started_date,
                'existing_visa_expired_date' => $employee->visa_expired_date,
            ];

        array_walk($dates, function ($value, $key) use (&$data) {
            if ($value) {
                $data[$key] = Carbon::parse($value)->isoFormat('DD/MM/YYYY');
            }
        });

        return static::prepareData($doc, $docData, $data);
    }

    public static function printVisaMotion($docData, $doc, $id)
    {
        $recipient = Employer::find($docData['authority_id']);
        $recipientName = static::declension($recipient->name_ru, 2, '', '', 1);
        $recipientDirectorId = $docData['officer_id'] ?: $recipient->director_id;
        $recipientDirector = Employee::find($recipientDirectorId);
        $recipientDirector = static::shortenName($recipientDirector, '', '', '', 3);
        $employee = Employee::find($id);
        $employer = Employer::find($employee->last_job->employer_id);
        $hostInfo = implode(', ', [
            $employer->name_ru,
            __('TAXPAYER_ID') . ' ' . $employer->taxpayer_id,
            Address::find($employer->address_id)->name_ru,
            static::handlePhones($employer->phone, '8', [1], false)
        ]);
        $birth_date =
            is_null($employee->birth_date) ? '' : date('d/m/Y', strtotime($employee->birth_date));
        $passportIssued =
            is_null($employee->passport_issued_date) ?
                '' : date('d/m/Y', strtotime($employee->passport_issued_date));
        $passportExpired =
            is_null($employee->passport_expired_date) ?
                '' : date('d/m/Y', strtotime($employee->passport_expired_date));
        $visaStarted =
            is_null($employee->visa_started) ? '' : date('d/m/Y', strtotime($employee->visa_started));
        $visaExpired =
            is_null($employee->visa_expired) ? '' : date('d/m/Y', strtotime($employee->visa_expired));
        $reason = static::getReason($docData);
        $date = $docData['date'] ? date('d/m/Y', strtotime($docData['date'])) : '';
        $director = __('GENERAL_DIRECTOR');
        $directorName = static::shortenName(Employee::find($employer->director_id));

        $data =
            [
                'recipient'                    => $recipientName,
                'recipient_director'           => $recipientDirector,
                'host_info'                    => $hostInfo,
                strtolower($docData['action']) => '___________',
                'last_name_ru'                 => $employee->last_name_ru,
                'first_name_ru'                => $employee->first_name_ru,
                'middle_name_ru'               => $employee->middle_name_ru,
                'last_name_en'                 => $employee->last_name_en,
                'first_name_en'                => $employee->first_name_en,
                'middle_name_en'               => $employee->middle_name_en,
                'birth_date'                   => $birth_date,
                'citizenship_name'             => $employee->citizenship_name,
                strtolower($employee->gender)  => 'X',
                'passport_serie'               => $employee->passport_serie,
                'passport_number'              => $employee->passport_number,
                'passport_issued'              => $passportIssued,
                'passport_expired'             => $passportExpired,
                'visa_serie'                   => $employee->visa_serie,
                'visa_number'                  => $employee->visa_number,
                'visa_started'                 => $visaStarted,
                'visa_expired'                 => $visaExpired,
                'date'                         => $date,
                'director'                     => $director,
                'director_name'                => $directorName,
                'reason'                       => $reason,
            ];

        return static::prepareData($doc, $docData, $data);
    }

    /**
     * @param array $docData
     * @param string $doc
     * @param int $id
     * @return array
     */
    public static function printInviteWarranty(array $docData, string $doc, int $id): array
    {
        $recipientId = $docData['recipient_id'];
        $recipientPersonId = $docData['recipient_person_id'];
        $employerId = $docData['employer_id'];
        $destinationAddress = $docData['destination_id'];
        $date = $docData['date'];
        $reg_num = $docData['reg_num'];

        $recipient = Employer::find($recipientId);
        $recipientPerson = Employee::find($recipientPersonId);
        $recipientPersonName =
            $recipientPerson->first_name_ru == __('CHIEF') ? ''
                : static::shortenName($recipientPerson, '', '', '', 3);

        $employer = Employer::find($employerId);
        $employer_address = Address::find($employer->address_id)->name_ru;
        $taxpayerId = __('TAXPAYER_ID') . ' ' . $employer->taxpayer_id;
        $primeRegNumber = __('PRIME_REG_NUMBER') . ' ' . $employer->prime_reg_number;
        $taxpayerCode = __('TAXPAYER_CODE') . ' ' . $employer->taxpayer_code;
        $employerPhone = static::handlePhones($employer->phone, '8', [-1], false);
        $phone = __('PHONE_LC') . ': ' . $employerPhone;

        $hostInfo = [
            $employer->full_name_ru,
            $employer_address,
            $taxpayerId . '/' . $primeRegNumber . '/' . $taxpayerCode,
            $phone
        ];
        $hostInfo = implode(', ', $hostInfo);

        $director = Employee::find($employer->director_id);
        $directorName = static::shortenName($director);

        $employee = Employee::find($id);

        if (!empty($employee->citizenship_id)) {
            $country = Country::find($employee->citizenship_id);
            $citizenship = static::declension($country->name_ru, 2, '', 'name');
        } else {
            $citizenship = '';
        }

        $name = $employee->last_name_ru . ' ' . $employee->first_name_ru;
        $name .= $employee->middle_name_ru ? (' ' . $employee->middle_name_ru) : '';

        $birthDate = date('d/m/Y', strtotime($employee->birth_date)) . __('BIRTH_DATE_SUFFIX');
        $passportIssued = date('d/m/Y', strtotime($employee->passport_issued_date));
        $passportExpired = date('d/m/Y', strtotime($employee->passport_expired_date));

        $passportInfo = [
            __('PASSPORT_LC'),
            ' ' . $employee->passport_number,
            __('ISSUED_BY_LC'),
            $passportIssued,
            ' ' . $employee->passport_issuer,
            __('VALID_UNTIL_LC'),
            $passportExpired
        ];

        $guestInfo = [
            $citizenship . ':  ' . $name,
            $birthDate,
            implode($passportInfo)
        ];
        $guestInfo = implode(', ', array_filter($guestInfo));

        $address = Address::find($destinationAddress)->name_ru;

        $data = [
            'recipient'          => static::declension($recipient->name_ru, 2, '', '', 1),
            'recipient_director' => $recipientPersonName,
            'date'               => date('d/m/Y', $date ? strtotime($date) : time()),
            'host_name'          => $employer->name_ru,
            'director'           => $directorName,
            'reg_num'            => $reg_num,
            'host_info'          => $hostInfo,
            'guest_info'         => $guestInfo,
            'address'            => $address,
        ];

        if ($employee->citizenship_id) {
            $data['foreigner_1'] = '';
            $data['foreigner_2'] = '';
        } else {
            $data['stateless'] = '';
        }

        static::splitDate(['date' => $date], $data, true, 'y-m-d');

        return static::prepareData($doc, $docData, $data);
    }

    public static function printWorkContract($docData, $doc, $id): array
    {
        $employee = Employee::find($id);
        $signedDate = $docData['signed_date'];
        $workPermitStartedDate = $employee->work_permit_started_date ?? '';
        $dateFrom = $docData['date_from'] ?: $workPermitStartedDate;
        $workPermitExpiredDate = $employee->work_permit_expired_date ?? '';
        $dateTo = $docData['date_to'] ?: $workPermitExpiredDate;
        $salary = $docData['salary'];
        $contractNumber = $docData['contract_number'];
        $employerId = $docData['employer_id'];
        $employer = Employer::find($employerId);
        $employerAddress = Address::find($employer->address_id)->name_ru;
        $address = static::parseAddress($employerAddress);
        $title = array_filter([$address['region'], $address['city'], $address['locality']]);
        $title[] =
            implode(' ', static::parseDate($signedDate, true)) . __('YEAR_SUFFIX');
        $title = implode(', ', $title);

        $director = Employee::find($employer->director_id);
        $directorName = array_filter([
            $director->last_name_ru,
            $director->first_name_ru,
            $director->middle_name_ru,
        ]);
        $director1 = static::declension(
            implode(' ', $directorName),
            2,
            $director->gender,
            'name'
        );
        $director2 = static::shortenName($director);

        $employeeName = implode(' ',
            array_filter([
                $employee->last_name_ru,
                $employee->first_name_ru,
                $employee->middle_name_ru,
            ]));
        $citizenship = static::declension(
            Country::find($employee->citizenship_id)->name_ru,
            2,
            '',
            'name'
        );
        $employeeAddress = Address::find($employee->reg_address_id)->name_ru;
        $employerInfo = implode(', ', [
            $employer->full_name_ru,
            $employerAddress,
            __('TAXPAYER_ID') . ' ' . $employer->taxpayer_id,
            __('TAXPAYER_CODE') . ' ' . $employer->taxpayer_code,
            __('PRIME_REG_NUMBER') . ' ' . $employer->prime_reg_number,
        ]);

        $employeeInfo = [];
        $employeeInfo[] = $employeeName;
        $employeeInfo[] = date('d/m/Y', strtotime($employee->birth_date)) . __('BIRTH_DATE_SUFFIX');
        $employeeInfo[] = __('PASSPORT_LC') .
                          ' ' .
                          $employee->passport_number .
                          ' ' .
                          __('ISSUED_BY_1_LC') .
                          ' ' .
                          date('d/m/Y', strtotime($employee->passport_issued_date)) .
                          ' ' .
                          $employee->passport_issuer;
        $employeeInfo[] = __('REG_ADDR_LC') . ': ' . $employeeAddress;
        $employeeInfo = implode(', ', $employeeInfo);

        $occupation = static::declension(
            Occupation::find($employee->last_job->occupation_id)->name_ru,
            2,
            '',
            '',
            1
        );

        $data =
            [
                'title'           => $title,
                'director1'       => $director1,
                'employee'        => $employeeName,
                'citizenship'     => $citizenship,
                'address'         => $employeeAddress,
                'date_from'       => date('d/m/Y', strtotime($dateFrom)),
                'date_to'         => date('d/m/Y', strtotime($dateTo)),
                'salary'          => $salary,
                'director2'       => $director2,
                'contract_number' => $contractNumber,
                'employer'        => $employer->full_name_ru,
                'occupation1'     => $occupation,
                'occupation2'     => $occupation,
                'employer_info'   => $employerInfo,
                'employee_info'   => $employeeInfo,
            ];

        if ($employee->work_permit_number) {
            $workPermitName =
                in_array($employee->citizenship_id, static::$CIS) ? __('WORK_PATENT') : __('WORK_PERMIT');
            $data['occation'] = mb_strtolower($workPermitName);
            $data['occation'] .=
                sprintf(__('SERIE_NUMBER_SPRINTF'), $employee->work_permit_serie, $employee->work_permit_number);
            $data['occation'] .= __('SINCE') . date('d/m/Y', strtotime($employee->work_permit_issued_date));
        }

        return static::prepareData($doc, $docData, $data);
    }

    public static function printWorkPermit($docData, $doc, $id)
    {
        $recipient = Employer::find($docData['authority_id']);
        $permit = Permit::find($docData['permit_id']);
        $permitIssued = Carbon::parse($permit->issued_date)->isoFormat('DD.MM.YYYY');

        $permitInfo =
            __('SHORT_PERMIT_NUMBER') .
            $permit->number .
            __('SINCE') .
            $permitIssued;

        $employee = Employee::find($id);
        $citizenship = Country::find($employee->citizenship_id)->name_ru;
        $birthPlace =
            !empty($citizenship) ? ($citizenship . ', ' . $employee->birth_place) : $employee->birth_place;
        $address = $employee->address ?: $birthPlace;
        $regAddress = Address::find($employee->reg_address_id)->name_ru;
        $occupation = Occupation::find($employee->last_job->occupation_id)->name_ru;
        $passport = __('PASSPORT');

        $employer = Employer::find($employee->last_job->employer_id);
        $employerPhone = static::handlePhones($employer->phone, '8', [1]);
        $employerAddress = Address::find($employer->address_id)->name_ru;
        $employerInfo = $employer->uni_reg_number . ', ' . $permitInfo;

        $data =
            [
                'recipient'                   => $recipient->name_ru,
                strtolower($employee->gender) => 'Х',
                'passport'                    => $passport,
                'passport_number'             => $employee->passport_number,
                'taxpayer_id'                 => $employee->taxpayer_id ?: '',
                'employer_taxpayer_id'        => $employer->taxpayer_id ?: '',
                'employer_info'               => $employerInfo,
                'permit_info'                 => $permitInfo,
                'employer_phone'              => $employerPhone,
                'last_name'                   => $employee->last_name_ru,
                'first_name'                  => $employee->first_name_ru,
                'middle_name'                 => $employee->middle_name_ru,
                'citizenship'                 => $citizenship,
                'birth_place'                 => $birthPlace,
                'address'                     => $address,
                'issuer'                      => $employee->passport_issuer,
                'reg_address'                 => $regAddress,
                'occupation'                  => $occupation,
                'employer_name'               => $employer->full_name_ru,
                'employer_address'            => $employerAddress,
                'active_business_type'        => preg_replace(
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

        static::splitDate($dates, $data);

        return static::prepareData($doc, $docData, $data);
    }

    public static function printWorkPermitMotion($docData, $doc, $id)
    {
        $employee = Employee::find($id);
        $recipient = Employer::find($docData['authority_id']);
        $recipientDirectorId = $docData['officer_id'] ?: $recipient->director_id;
        $recipientDirector = Employee::find($recipientDirectorId);
        $recipientDirector =
            [
                static::declension($recipientDirector->last_name_ru, 3, $recipientDirector->gender, 'name'),
                mb_substr($recipientDirector->first_name_ru, 0, 1) . '.',
                mb_substr($recipientDirector->middle_name_ru, 0, 1) . '.'
            ];
        $recipientDirector = implode(' ', $recipientDirector);

        $employer = Employer::find($employee->last_job->employer_id);

        $address = Address::find($employer->address_id);
        $address = static::parseAddress($address->name_ru);
        $title = array_filter([$address['region'], $address['city']]);
        $title[] = Carbon::parse($docData['date'])->isoFormat('DD MMMM YYYY') . __('YEAR_SUFFIX');
        $title = implode(', ', $title);

        $guestInfo = [];

        $guestName = array_filter(
            [$employee->last_name_ru, $employee->first_name_ru, $employee->middle_name_ru]
        );
        $guestName = implode(' ', $guestName);

        $guestCitizenship = Country::find($employee->citizenship_id)->name_ru;
        $guestInfo[] = static::declension($guestCitizenship, 2, '', 'name') . ': ' . $guestName;

        if ($employee->birth_date) {
            $guestInfo[] =
                Carbon::parse($employee->birth_date)->isoFormat('DD/MM/YYYY') . __('BIRTH_DATE_SUFFIX');
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
        $director = static::shortenName(Employee::find($employer->director_id));

        $data =
            [
                'recipient'          => static::declension($recipient->name_ru, 2, '', '', 1),
                'recipient_director' => $recipientDirector,
                'title'              => $title,
                'employer1'          => $employer->name_ru,
                'employer2'          => $employer->name_ru,
                'employer3'          => $employer->name_ru,
                'guest_name'         => $guestName,
                'guest_info'         => $guestInfo,
                'director'           => $director
            ];

        return static::prepareData($doc, $docData, $data);
    }

    public static function shortenAddresses($addresses, $type_required = true)
    {
        foreach ($addresses as &$address) {
            $parts = static::parseAddress($address, $type_required);

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

    public static function getReason($docData, $reason = 'reason')
    {
        switch ($docData[$reason]) {
            case 'EXPIRED_VISA':
                $suffix = $docData['visa'];
                break;
            case 'NEW_PASSPORT':
                $suffix = $docData['passport'];
                break;
            case 'NEW_WORK_PERMIT':
            default:
                $suffix = $docData['work_permit'];
                break;
        }

        $suffix = explode(' ', $suffix);
        $format =
            count($suffix) > 1 ?
                __('SERIE_NUMBER_SPRINTF') : __('NUMBER_SPRINTF');

        return __($docData[$reason]) . sprintf($format, ...$suffix);
    }

    public static function shortenName(
        $person = null,
        $last_name = '',
        $first_name = '',
        $middle_name = '',
        $case = 1,
        $gender = ''
    ): string
    {
        $last_name = $last_name ?: ($person ? $person->last_name_ru : '');

        if (str_contains(
            mb_strtolower($last_name),
            mb_strtolower(__('CHIEF'))
        )) {
            return '';
        }

        $first_name = $first_name ?: ($person ? $person->first_name_ru : '');
        $middle_name = $middle_name ?: ($person ? $person->middle_name_ru : '');
        $gender = $gender ?: ($person ? $person->gender : '');
        $name = [static::declension($last_name, $case, $gender, 'name')];

        $first_name = explode(' ', $first_name);

        foreach ($first_name as $part) {
            $name[] = mb_substr($part, 0, 1) . '.';
        }

        if ($middle_name) {
            $name[] = mb_substr($middle_name, 0, 1) . '.';
        }

        return implode(' ', $name);
    }

    public static function splitDate($dates, &$data, $fullMonthFormat = false, $fullYear = true)
    {
        foreach ($dates as $key => $date) {
            if (!$date) {
                unset($data[$key]);
                continue;
            }

            $date = static::parseDate($date, $fullMonthFormat, $fullYear);
            $key = ($key == 'date') ? '' : ($key . '_');

            $data[$key . 'day'] = $date['d'];
            $data[$key . 'month'] = $date['m'];
            $data[$key . 'year'] = $date['y'];
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
    public static function splitText(string $value,
                                     string $key,
                                     array  &$data,
                                     bool   $justify,
                                     bool   $splitWord,
                                     bool   $cells,
                                     int    $total,
                                            $rows): bool
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
                            $min = max(($separators - $extra), 0);

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
}
