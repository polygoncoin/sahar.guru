<?php

/**
 * Handling JSON Encode
 * php version 8.3
 *
 * @category  DataEncode_JSON
 * @package   sahar.guru
 * @author    Ramesh N Jangid <polygon.co.in@gmail.com>
 * @copyright 2025 Ramesh N Jangid
 * @license   MIT https://opensource.org/license/mit
 * @link      https://github.com/polygoncoin/sahar.guru
 * @since     Class available since Release 1.0.0
 */

namespace Microservices\App\DataRepresentation\Encode\JsonEncoder;

/**
 * JSON object
 *
 * This class is built to help maintain state of simple/associative array
 * php version 8.3
 *
 * @category  Json_Encoder_Object
 * @package   sahar.guru
 * @author    Ramesh N Jangid <polygon.co.in@gmail.com>
 * @copyright 2025 Ramesh N Jangid
 * @license   MIT https://opensource.org/license/mit
 * @link      https://github.com/polygoncoin/sahar.guru
 * @since     Class available since Release 1.0.0
 */
class JsonEncoderObject
{
    public $mode = '';
    public $comma = '';

    /**
     * Constructor
     *
     * @param string $mode Values can be one among Array/object
     */
    public function __construct($mode)
    {
        $this->mode = $mode;
    }
}
