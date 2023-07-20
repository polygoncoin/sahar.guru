<?php
namespace App\Servers\Database;

/**
 * Loading database server
 *
 * This abstract class is built to handle the database server.
 *
 * @category   Abstract Database Class
 * @package    Microservices
 * @author     Ramesh Narayan Jangid
 * @copyright  Ramesh Narayan Jangid
 * @version    Release: @1.0.0@
 * @since      Class available since Release 1.0.0
 */
abstract class AbstractDatabase
{
    /**
     * Database connection
     *
     * @return void
     */
    abstract public function connect();

    /**
     * Use Database
     *
     * @param string $database Database .env string
     * @return void
     */
    abstract public function useDatabase($database);

    /**
     * Last Insert Id by PDO
     *
     * @return int
     */
    abstract public function lastInsertId();

    /**
     * Execute parameterised query
     *
     * @param string $query  Parameterised query
     * @param array  $params Parameterised query params
     * @return object
     */
    abstract public function execDbQuery($query, $params = []);

    /**
     * Fetch single row from statement
     *
     * @return array
     */
    abstract public function fetch();

    /**
     * Fetch all rows from statement
     *
     * @return array
     */
    abstract public function fetchAll();

    /**
     * Close statement cursor
     *
     * @return void
     */
    abstract public function closeCursor();
}
