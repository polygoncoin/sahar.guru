<?php
return [
    'all' => [
        'query' => "SELECT * FROM `{$this->globalDB}`.`{$this->execPhpFunc(getenv('users'))}`",
        'where' => [],
        'mode' => 'multipleRowFormat'//Multiple rows returned.
    ],
    'single' => [
        'query' => "SELECT * FROM `{$this->globalDB}`.`{$this->execPhpFunc(getenv('users'))}` WHERE __WHERE__",
        'where' => [
            'is_approved' => ['custom', 'Yes'],
            'is_deleted' => ['custom', 'No'],
            'user_id' => ['uriParams','user_id']
        ],
        'mode' => 'singleRowFormat'//Single row returned.
    ]
][isset($input['uriParams']['user_id'])?'single':'all'];
