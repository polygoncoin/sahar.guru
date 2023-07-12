<?php
return [
    'query' => "UPDATE `{$this->globalDB}`.`{$this->execPhpFunc(getenv('links'))}` SET __SET__ WHERE __WHERE__",
    'payload' => [
        //column => [payload|readOnlySession|uriParams|insertIdParams|{custom}, key|{value}],
        'name' => ['payload', 'name'],
        'updated_by' => ['readOnlySession', 'user_id'],
        'updated_on' => ['custom', date('Y-m-d H:i:s')]
    ],
    'where' => [
        'is_approved' => ['custom', 'Yes'],
        'is_disabled' => ['custom', 'No'],
        'is_deleted' => ['custom', 'No'],
        'link_id' => ['uriParams', 'link_id']
    ],
    'validate' => [
		[
			'fn' => 'primaryKeyExist',
			'fnArgs' => [
                'table' => ['custom', getenv('links')],
                'primary' => ['custom', 'link_id'],
                'id' => ['payload', 'link_id']
            ],
			'errorMessage' => 'Invalid Link Id'
		],
	]
];
