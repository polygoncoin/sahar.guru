<?php
namespace Crons;

use App\HttpErrorResponse;
use App\Servers\Database;

/**
 * Class for a particular cron.
 *
 * This class is meant for cron
 * One can initiate cron via access URL to this class
 * https://domain.tld/crons/className?queryString
 * All HTTP methods are supported
 *
 * @category   Crons
 * @package    Microservices
 * @author     Ramesh Narayan Jangid
 * @copyright  Ramesh Narayan Jangid
 * @version    Release: @1.0.0@
 * @since      Class available since Release 1.0.0
 */
class Cron
{
    /**
     * Initialize cron
     *
     * @param string $requestMethod HTTP method
     * @param string $requestUri    Route
     * @return void
     */
    public static function init($requestMethod, $requestUri)
    {
        (new HttpRequest)->parseRoute($requestMethod, $requestUri);
        (new self)->process();
    }

    /**
     * Process all functions
     *
     * @return void
     */
    public function process()
    {
        // Create and call functions to manage cron functionality here.
        // In functions one can also perform DB operations with $this->authorize object
        // $this->authorize->connectClientDB();

        // ...

        // End the calls with json response with jsonEncode Object.
        $this->endProcess($result);
    }

    /**
     * Function to end process which outputs the results.
     *
     * @return void
     */
    private function endProcess()
    {
        HttpErrorResponse::return2xx(200, 'message as desired.');
    }
}
