<?php

/**
 * DataTypes
 * php version 8.3
 *
 * @category  DataTypes
 * @package   Sahar.Guru
 * @author    Ramesh N. Jangid (Sharma) <polygon.co.in@gmail.com>
 * @copyright © 2026 Ramesh N. Jangid (Sharma)
 * @license   MIT https://opensource.org/license/mit
 * @link      https://github.com/polygoncoin/sahar.guru
 * @since     Class available since Release 1.0.0
 */

namespace Microservices\App;

/**
 * Custom DataTypes
 * php version 8.3
 *
 * @category  DataTypes
 * @package   Sahar.Guru
 * @author    Ramesh N. Jangid (Sharma) <polygon.co.in@gmail.com>
 * @copyright © 2026 Ramesh N. Jangid (Sharma)
 * @license   MIT https://opensource.org/license/mit
 * @link      https://github.com/polygoncoin/sahar.guru
 * @since     Class available since Release 1.0.0
 */
class DatabaseDataTypes
{
	/**
	 * Example to create custom data type
	 * You can configure them in /Config/Queries folder as a data type
	 * This will validate the received payload/uriParam/etc data where this is
	 * configured
	 *
	 * DatabaseDataTypes::$CustomINT
	 *
	 * public static $CustomINT = [
	 *
	 *     // Required param
	 *        // Supported data type (bool, int, float, string)
	 *        'dataType' => 'int',
	 *
	 *     // Optional params
	 *        // Value can be null
	 *        'canBeNull' => false, // bool, int, float, string
	 *        // Minimum value (int)
	 *        'minValue' => false, // int, float
	 *        // Maximum value (int)
	 *        'maxValue' => false, // int, float
	 *        // Minimum length (string)
	 *        'minLength' => false, // string
	 *        // Maximum length (string)
	 *        'maxLength' => false, // string
	 *        // Any one value from the Array
	 *        'enumValues' => false, // bool, int, float, string
	 *        // Values belonging to this Array
	 *        'setValues' => false, // bool, int, float, string
	 *
	 *        // Values should pass this regex before use
	 *        'regex' => false
	 *  ];
	 */

	public static $BOOL = [
		'dataType' => 'bool',
		'canBeNull' => false
	];

	public static $INT = [
		'dataType' => 'int',
		'canBeNull' => false
	];

	public static $FLOAT = [
		'dataType' => 'float',
		'canBeNull' => false
	];

	public static $STRING = [
		'dataType' => 'string',
		'canBeNull' => false
	];

	public static $Default = [
		'dataType' => 'string',
		'canBeNull' => false
	];

	public static $PrimaryKey = [
		'dataType' => 'int',
		'canBeNull' => false
	];

	public static $Varchar15 = [
		'dataType' => 'string',
		'canBeNull' => false,
		'maxLength' => 15
	];

	public static $Varchar25 = [
		'dataType' => 'string',
		'canBeNull' => false,
		'maxLength' => 25
	];

	public static $Varchar100 = [
		'dataType' => 'string',
		'canBeNull' => false,
		'maxLength' => 100
	];

	public static $Varchar150 = [
		'dataType' => 'string',
		'canBeNull' => false,
		'maxLength' => 150
	];

	public static $VarcharNullable15 = [
		'dataType' => 'string',
		'canBeNull' => true,
		'maxLength' => 15
	];

	public static $VarcharNullable25 = [
		'dataType' => 'string',
		'canBeNull' => true,
		'maxLength' => 25
	];

	public static $VarcharNullable100 = [
		'dataType' => 'string',
		'canBeNull' => true,
		'maxLength' => 100
	];

	public static $VarcharNullable150 = [
		'dataType' => 'string',
		'canBeNull' => true,
		'maxLength' => 150
	];

	public static $VarcharNullable250 = [
		'dataType' => 'string',
		'canBeNull' => true,
		'maxLength' => 250
	];

	public static $Json = [
		'dataType' => 'json',
		'canBeNull' => false
		// regex
	];

	public static $JsonNullable = [
		'dataType' => 'json',
		'canBeNull' => true
		// regex
	];

	public static $TinyText = [
		'dataType' => 'string',
		'canBeNull' => false,
		'maxLength' => 150
	];

	public static $TinyTextNullable = [
		'dataType' => 'string',
		'canBeNull' => true,
		'maxLength' => 150
	];

	public static $UserTypeEnum = [
		'dataType' => 'string',
		'canBeNull' => false,
		'enumValues' => ['Admin', 'Customer', 'WebsiteAdmin']
	];

	public static $HttpMethodEnum = [
		'dataType' => 'string',
		'canBeNull' => false,
		'enumValues' => ['GET', 'POST', 'PUT', 'PATCH', 'DELETE']
	];

	public static $EditEnum = [
		'dataType' => 'string',
		'canBeNull' => false,
		'enumValues' => ['Yes', 'No']
	];

	public static $ApprovedEnum = [
		'dataType' => 'string',
		'canBeNull' => false,
		'enumValues' => ['Yes', 'No']
	];

	public static $DisabledEnum = [
		'dataType' => 'string',
		'canBeNull' => false,
		'enumValues' => ['Yes', 'No']
	];

	public static $DeletedEnum = [
		'dataType' => 'string',
		'canBeNull' => false,
		'enumValues' => ['Yes', 'No']
	];

	/**
	 * Validates DataType
	 *
	 * @param bool|float|int|string|null $data     Data
	 * @param array                      $dataType Custom data type
	 *
	 * @return bool|float|int|string|null
	 * @throws \Exception
	 */
	public static function validateDataType(
		&$data,
		&$dataType
	): bool {
		switch ($dataType['dataType']) {
			case 'bool':
				$data = (bool)$data;
				break;
			case 'int':
				$data = (int)$data;
				break;
			case 'float':
				$data = (float)$data;
				break;
			case 'string':
				$data = (string)$data;
				break;
		}

		$returnFlag = true;

		if (
			$returnFlag
			&& isset($dataType['canBeNull'])
			&& $dataType['canBeNull'] === true
			&& $data === null
		) {
			return true;
		}
		if (
			$returnFlag
			&& $dataType['dataType'] === 'int'
			&& isset($dataType['minValue'])
			&& $dataType['minValue'] <= $data
		) {
			$returnFlag = false;
		}
		if (
			$returnFlag
			&& $dataType['dataType'] === 'int'
			&& isset($dataType['maxValue'])
			&& $data <= $dataType['maxValue']
		) {
			$returnFlag = false;
		}
		if (
			$returnFlag
			&& $dataType['dataType'] === 'string'
			&& isset($dataType['minLength'])
			&& $dataType['minLength'] <= strlen(string: $data)
		) {
			$returnFlag = false;
		}
		if (
			$returnFlag
			&& $dataType['dataType'] === 'string'
			&& isset($dataType['maxLength'])
			&& strlen(string: $data) <= $dataType['maxLength']
		) {
			$returnFlag = false;
		}
		if (
			$returnFlag
			&& isset($dataType['enumValues'])
			&& in_array(needle: $data, haystack: $dataType['enumValues'])
		) {
			$returnFlag = false;
		}
		if (
			$returnFlag
			&& isset($dataType['setValues'])
			&& empty(array_diff([$data], $dataType['setValues']))
		) {
			$returnFlag = false;
		}
		if (
			$returnFlag
			&& isset($dataType['regex'])
			&& preg_match(pattern: $dataType['regex'], subject: $data) === 0
		) {
			$returnFlag = false;
		}

		if (!$returnFlag) {
			throw new \Exception(
				message: 'Invalid data based on Data-type details',
				code: HttpStatus::$BadRequest
			);
		}

		return true;
	}
}
