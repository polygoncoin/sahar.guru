<?php
return [
    'query' => "INSERT INTO `{$this->globalDB}`.`{$this->execPhpFunc(getenv('groups'))}` SET __SET__",
    'payload' => [
        //column => [payload|readOnlySession|uriParams|insertIdParams|{custom}, key|{value}],
        'name' => ['payload', 'name'],
        'client_id' => ['payload', 'client_id'],
        'connection_id' => ['payload', 'connection_id'],
        'allowed_ips' => ['payload', 'allowed_ips'],
        'comments' => ['payload', 'comments'],
        'created_by' => ['readOnlySession', 'user_id'],
        'created_on' => ['custom', date('Y-m-d H:i:s')],
        'is_approved' => ['custom', 'No'],
        'is_disabled' => ['custom', 'No'],
        'is_deleted' => ['custom', 'No']
    ],
    'insertId' => 'group_id',
];
