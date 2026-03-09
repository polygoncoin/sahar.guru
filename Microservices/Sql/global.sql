DROP TABLE IF EXISTS `global_counter`;
CREATE TABLE `global_counter` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    PRIMARY KEY (`id`)
) ENGINE = InnoDB;

DROP TABLE IF EXISTS `client`;
CREATE TABLE `client` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `name` VARCHAR(255) DEFAULT NULL,
    `sub_domain` VARCHAR(10) DEFAULT NULL,
    `allowed_cidr` TINYTEXT,
    `api_domain` VARCHAR(255) DEFAULT NULL,
    `open_api_domain` VARCHAR(255) DEFAULT NULL,
    `master_db_server_type` VARCHAR(255) NOT NULL,
    `master_db_hostname` VARCHAR(255) NOT NULL,
    `master_db_port` VARCHAR(255) NOT NULL,
    `master_db_username` VARCHAR(255) NOT NULL,
    `master_db_password` VARCHAR(255) NOT NULL,
    `master_db_database` VARCHAR(255) NOT NULL,
    `master_query_placeholder` VARCHAR(255) NOT NULL,
    `slave_db_server_type` VARCHAR(255) NOT NULL,
    `slave_db_hostname` VARCHAR(255) NOT NULL,
    `slave_db_port` VARCHAR(255) NOT NULL,
    `slave_db_username` VARCHAR(255) NOT NULL,
    `slave_db_password` VARCHAR(255) NOT NULL,
    `slave_db_database` VARCHAR(255) NOT NULL,
    `slave_query_placeholder` VARCHAR(255) NOT NULL,
    `usersTable` VARCHAR(255) NOT NULL,
    `master_cache_server_type` VARCHAR(255) NOT NULL,
    `master_cache_hostname` VARCHAR(255) NOT NULL,
    `master_cache_port` VARCHAR(255) NOT NULL,
    `master_cache_username` VARCHAR(255) NOT NULL,
    `master_cache_password` VARCHAR(255) NOT NULL,
    `master_cache_database` VARCHAR(255) NOT NULL,
    `master_cache_table` VARCHAR(255) NOT NULL,
    `slave_cache_server_type` VARCHAR(255) NOT NULL,
    `slave_cache_hostname` VARCHAR(255) NOT NULL,
    `slave_cache_port` VARCHAR(255) NOT NULL,
    `slave_cache_username` VARCHAR(255) NOT NULL,
    `slave_cache_password` VARCHAR(255) NOT NULL,
    `slave_cache_database` VARCHAR(255) NOT NULL,
    `slave_cache_table` VARCHAR(255) NOT NULL,
    `rateLimitMaxRequest` INT DEFAULT NULL,
    `rateLimitMaxRequestWindow` INT DEFAULT NULL,
    `comments` VARCHAR(255) DEFAULT NULL,
    `created_by` INT DEFAULT NULL,
    `created_on` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `approved_by` INT DEFAULT NULL,
    `approved_on` TIMESTAMP NULL DEFAULT NULL,
    `updated_by` INT DEFAULT NULL,
    `updated_on` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    `is_approved` enum('Yes','No') NOT NULL DEFAULT 'No',
    `is_disabled` enum('Yes','No') NOT NULL DEFAULT 'No',
    `is_deleted` enum('Yes','No') NOT NULL DEFAULT 'No',
    PRIMARY KEY (`id`)
) ENGINE = InnoDB;

DROP TABLE IF EXISTS `group`;
CREATE TABLE `group` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `name` VARCHAR(100) NOT NULL,
    `client_id` INT DEFAULT NULL,
    `allowed_cidr` TINYTEXT,
    `rateLimitMaxRequest` INT DEFAULT NULL,
    `rateLimitMaxRequestWindow` INT DEFAULT NULL,
    `comments` VARCHAR(255) DEFAULT NULL,
    `created_by` INT DEFAULT NULL,
    `created_on` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `approved_by` INT DEFAULT NULL,
    `approved_on` TIMESTAMP NULL DEFAULT NULL,
    `updated_by` INT DEFAULT NULL,
    `updated_on` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    `is_approved` enum('Yes','No') NOT NULL DEFAULT 'No',
    `is_disabled` enum('Yes','No') NOT NULL DEFAULT 'No',
    `is_deleted` enum('Yes','No') NOT NULL DEFAULT 'No',
    PRIMARY KEY (`id`)
) ENGINE = InnoDB;

INSERT INTO `client` VALUES
(1,'Rest-Of-Clients','','0.0.0.0/0','api.localhost','localhost','cDbServerType','cDbServerHostname','cDbServerPort','cDbServerUsername','cDbServerPassword','cDbServerDatabase','cDbServerQueryPlaceholder','cDbServerType','cDbServerHostname','cDbServerPort','cDbServerUsername','cDbServerPassword','cDbServerDatabase','cDbServerQueryPlaceholder','cDbUsersTable','cCacheServerType','cCacheServerHostname','cCacheServerPort','cCacheServerUsername','cCacheServerPassword','cCacheServerDatabase','cCacheServerTable','cCacheServerType','cCacheServerHostname','cCacheServerPort','cCacheServerUsername','cCacheServerPassword','cCacheServerDatabase','cCacheServerTable',NULL,NULL,'',NULL,'2023-04-15 08:54:50',NULL,NULL,NULL,'2023-04-29 16:00:41','Yes','No','No'),
(2,'Mumbai','mum.','0.0.0.0/0','api.mum.localhost','mum.localhost','mumDbServerType','mumDbServerHostname','mumDbServerPort','mumDbServerUsername','mumDbServerPassword','mumDbServerDatabase','mumDbServerQueryPlaceholder','mumDbServerType','mumDbServerHostname','mumDbServerPort','mumDbServerUsername','mumDbServerPassword','mumDbServerDatabase','mumDbServerQueryPlaceholder','mumDbUsersTable','mumCacheServerType','mumCacheServerHostname','mumCacheServerPort','mumCacheServerUsername','mumCacheServerPassword','mumCacheServerDatabase','mumCacheServerTable','mumCacheServerType','mumCacheServerHostname','mumCacheServerPort','mumCacheServerUsername','mumCacheServerPassword','mumCacheServerDatabase','mumCacheServerTable',NULL,NULL,'',NULL,'2023-04-15 08:54:50',NULL,NULL,NULL,'2023-04-29 16:00:41','Yes','No','No');

INSERT INTO `group` VALUES
(1,'ClientGroup',1,'0.0.0.0/0',NULL,NULL,'',NULL,'2023-04-15 08:54:50',NULL,NULL,NULL,'2023-04-21 06:38:22','Yes','No','No'),
(2,'MumbaiClientGroup',2,'0.0.0.0/0',NULL,NULL,'',NULL,'2023-04-15 08:54:50',NULL,NULL,NULL,'2023-04-21 06:38:22','Yes','No','No');
