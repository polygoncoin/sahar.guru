DROP TABLE IF EXISTS `users`;

CREATE TABLE `users` (
  `id` INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  `client_id` int NOT NULL,
  `group_id` int NOT NULL,
  `allowed_cidrs` text,
  `firstname` varchar(255) NOT NULL,
  `lastname` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `username` varchar(255) NOT NULL,
  `password_hash` varchar(255) NOT NULL,
  `token` varchar(255) DEFAULT NULL,
  `token_ts` int UNSIGNED DEFAULT 0,
  `rateLimitMaxRequests` int DEFAULT NULL,
  `rateLimitMaxRequestsWindow` int DEFAULT NULL,
  `comments` varchar(255) DEFAULT NULL,
  `created_by` int DEFAULT NULL,
  `created_on` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `approved_by` int DEFAULT NULL,
  `approved_on` timestamp NULL DEFAULT NULL,
  `updated_by` int DEFAULT NULL,
  `updated_on` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `is_approved` enum('Yes','No') NOT NULL DEFAULT 'No',
  `is_disabled` enum('Yes','No') NOT NULL DEFAULT 'No',
  `is_deleted` enum('Yes','No') NOT NULL DEFAULT 'No'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

DROP TABLE IF EXISTS `address`;

CREATE TABLE `address` (
  `id` INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  `client_id` int NOT NULL,
  `user_id` int NOT NULL DEFAULT 0,
  `address` varchar(255) NOT NULL,
  `created_by` int DEFAULT NULL,
  `created_on` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `approved_by` int DEFAULT NULL,
  `approved_on` timestamp NULL DEFAULT NULL,
  `updated_by` int DEFAULT NULL,
  `updated_on` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `is_approved` enum('Yes','No') NOT NULL DEFAULT 'No',
  `is_disabled` enum('Yes','No') NOT NULL DEFAULT 'No',
  `is_deleted` enum('Yes','No') NOT NULL DEFAULT 'No'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `api_cache`;

CREATE TABLE `api_cache` (
    `key` CHAR(128) NOT NULL,
    `value` BLOB,
    UNIQUE INDEX api_cache_key (`key`)
) ENGINE=InnoDB;

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES
(1,1,1,'0.0.0.0/0','shared-user-1','clients','user1@email.com','client','$2y$10$o8hFTjBIXQS.fOED2Ut1ZOCSdDjTnS3lyELI4rWyFEnu4GUyJr3O6','',0,NULL,NULL,NULL,0,'2023-02-22 04:12:50',NULL,NULL,0,'2023-04-20 16:53:57','Yes','No','No'),
(1,2,2,'0.0.0.0/0','mum-user-1','bai','user2@email.com','mumbai','$2y$10$o8hFTjBIXQS.fOED2Ut1ZOCSdDjTnS3lyELI4rWyFEnu4GUyJr3O6','',0,NULL,NULL,NULL,0,'2023-02-22 04:12:50',NULL,NULL,0,'2023-04-20 16:53:57','Yes','No','No');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;
