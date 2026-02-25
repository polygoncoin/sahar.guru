<?php

/**
 * API Route config
 * php version 8.3
 *
 * @category  API_Route_Config
 * @package   sahar.guru
 * @author    Ramesh N Jangid <polygon.co.in@gmail.com>
 * @copyright © 2026 Ramesh N. Jangid (Sharma)
 * @license   MIT https://opensource.org/license/mit
 * @link      https://github.com/polygoncoin/sahar.guru
 * @since     Class available since Release 1.0.0
 */

namespace Microservices\public_html\Config\Routes\Open;

use Microservices\App\Constants;
use Microservices\App\DatabaseDataTypes;

return [
    'login' => [
        '__FILE__' => Constants::$OPEN_QUERIES_DIR
            . DIRECTORY_SEPARATOR . 'GET'
            . DIRECTORY_SEPARATOR . 'Login.php',
    ]
];
