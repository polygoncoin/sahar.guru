<?php
return [
    'query' => "INSERT INTO `{$this->globalDB}`.`{$this->execPhpFunc(getenv('connections'))}` SET __SET__",
    'payload' => [
        //column => [payload|readOnlySession|uriParams|insertIdParams|{custom}, key|{value}],
        'name' => ['payload', 'name'],
        'db_server_type' => ['payload', 'db_server_type'],
        'db_hostname' => ['payload', 'db_hostname'],
        'db_username' => ['payload', 'db_username'],
        'db_password' => ['payload', 'db_password'],
        'db_database' => ['payload', 'db_database'],
        'comments' => ['payload', 'comments'],
        'created_by' => ['readOnlySession', 'user_id'],
        'created_on' => ['custom', date('Y-m-d H:i:s')],
        'is_approved' => ['custom', 'No'],
        'is_disabled' => ['custom', 'No'],
        'is_deleted' => ['custom', 'No']
    ],
    'insertId' => 'connection_id',
];
