<?php

/**
 * ThirdPartyAPI
 * php version 8.3
 *
 * @category  ThirdPartyAPI_Interface
 * @package   sahar.guru
 * @author    Ramesh N Jangid <polygon.co.in@gmail.com>
 * @copyright © 2026 Ramesh N. Jangid (Sharma)
 * @license   MIT https://opensource.org/license/mit
 * @link      https://github.com/polygoncoin/sahar.guru
 * @since     Class available since Release 1.0.0
 */

namespace Microservices\public_html\Supplement\ThirdParty;

/**
 * ThirdPartyAPI Interface
 * php version 8.3
 *
 * @category  ThirdPartyAPI_Interface
 * @package   sahar.guru
 * @author    Ramesh N Jangid <polygon.co.in@gmail.com>
 * @copyright © 2026 Ramesh N. Jangid (Sharma)
 * @license   MIT https://opensource.org/license/mit
 * @link      https://github.com/polygoncoin/sahar.guru
 * @since     Class available since Release 1.0.0
 */
interface ThirdPartyInterface
{
    /**
     * Initialize
     *
     * @return bool
     */
    public function init(): bool;

    /**
     * Process
     *
     * @param array $payload Payload
     *
     * @return array
     */
    public function process(array $payload = []): array;
}
