<?php
spl_autoload_register(function ($className) {
    $className = str_replace("\\", DIRECTORY_SEPARATOR, $className);
	$file = __DIR__ . DIRECTORY_SEPARATOR . $className . '.php';
    if (!file_exists($file)) {
        die(json_encode(['Status' => 501, 'Message' => "Class File '{$className}' missing"]));
    }
    require $file;
});

/**
 * Validates subnet specified by CIDR notation.of the form IP address followed by 
 * a '/' character and a decimal number specifying the length, in bits, of the subnet
 * mask or routing prefix (number from 0 to 32).
 *
 * @param  $ip     IP address to check
 * @param  $cidr   IP address range in CIDR notation for check
 * @return boolean true match found otherwise false
 */
function cidr_match($ip, $cidr) {
    $outcome = false;
    $pattern = '/^(([01]?\d?\d|2[0-4]\d|25[0-5])\.){3}([01]?\d?\d|2[0-4]\d|25[0-5])\/(\d{1}|[0-2]{1}\d{1}|3[0-2])$/';
    if (preg_match($pattern, $cidr)){
        list($subnet, $mask) = explode('/', $cidr);
        if (ip2long($ip) >> (32 - $mask) == ip2long($subnet) >> (32 - $mask)) {
            $outcome = true;
        }
    }
    return $outcome;
}

function httpAuthentication()
{
    // Check request not from proxy.
    if (
        !isset($_SERVER['REMOTE_ADDR']) ||
        $_SERVER['REMOTE_ADDR'] !== getenv('HttpAuthenticationRestrictedIp')
    ) {
        http_response_code(404);
    }
    if (!isset($_SERVER['PHP_AUTH_USER']) || !isset($_SERVER['PHP_AUTH_PW'])) {
        header('WWW-Authenticate: Basic realm="Test Authentication System"');
        header('HTTP/1.0 401 Unauthorized');
        echo "You must enter a valid login ID and password to access this resource\n";
        return false;
    } else {
        $valid_passwords = array ("shames11" => "shames11");
        $valid_users = array_keys($valid_passwords);

        $user = $_SERVER['PHP_AUTH_USER'];
        $pass = $_SERVER['PHP_AUTH_PW'];

        $validated = ($user === getenv('HttpAuthenticationUser')) && ($pass === getenv('HttpAuthenticationPassword'));

        if (!$validated) {
            header('WWW-Authenticate: Basic realm="My Realm"');
            header('HTTP/1.0 401 Unauthorized');
            die ("Not authorized");
        } else {
            return true;
        }
    }
}

/**
 *  An example CORS-compliant method.  It will allow any GET, POST, or OPTIONS requests from any
 *  origin.
 *
 *  In a production environment, you probably want to be more restrictive, but this gives you
 *  the general idea of what is involved.  For the nitty-gritty low-down, read:
 *
 *  - https://developer.mozilla.org/en/HTTP_access_control
 *  - https://fetch.spec.whatwg.org/#http-cors-protocol
 *
 */
function cors() {
    
    // Allow from any origin
    if (isset($_SERVER['HTTP_ORIGIN'])) {
        // Decide if the origin in $_SERVER['HTTP_ORIGIN'] is one
        // you want to allow, and if so:
        header("Access-Control-Allow-Origin: {$_SERVER['HTTP_ORIGIN']}");
        header('Access-Control-Allow-Credentials: true');
        header('Access-Control-Max-Age: 86400');    // cache for 1 day
    }
    
    // Access-Control headers are received during OPTIONS requests
    if ($_SERVER['REQUEST_METHOD'] == 'OPTIONS') {
        
        if (isset($_SERVER['HTTP_ACCESS_CONTROL_REQUEST_METHOD']))
            // may also be using PUT, PATCH, HEAD etc
            header("Access-Control-Allow-Methods: GET, POST, OPTIONS");
        
        if (isset($_SERVER['HTTP_ACCESS_CONTROL_REQUEST_HEADERS']))
            header("Access-Control-Allow-Headers: {$_SERVER['HTTP_ACCESS_CONTROL_REQUEST_HEADERS']}");
    
        exit(0);
    }
}

cors();

$env = parse_ini_file(__DIR__ . '/.env');
foreach ($env as $key => $value) {
    putenv("{$key}={$value}");
}
