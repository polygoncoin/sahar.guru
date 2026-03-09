-- ----------- Tables for logging --------------
DROP TABLE IF EXISTS `request`;
CREATE TABLE `request` (
    `request_no` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `request_by` ENUM('Admin', 'Customer', 'WebsiteAdmin') NOT NULL,
    `request_by_no` BIGINT NOT NULL,
    `request_route` VARCHAR(250),
    `request_method` ENUM('POST', 'PUT', 'PATCH', 'DELETE') NOT NULL,
    `request_payload_json` JSON NOT NULL,
    `request_operated_on` DATETIME DEFAULT CURRENT_TIMESTAMP,
    `request_operator_ip` VARCHAR(25) NOT NULL,
    PRIMARY KEY (`request_no`)
) ENGINE = InnoDB;

DROP TABLE IF EXISTS `error_log`;
CREATE TABLE `error_log` (
    `error_log_no` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `request_no` BIGINT NOT NULL,
    `operated_by` ENUM('Admin', 'Customer', 'WebsiteAdmin') NOT NULL,
    `operated_by_no` BIGINT NOT NULL,
    `operated_route` VARCHAR(250),
    `operated_request_method` ENUM('POST', 'PUT', 'PATCH', 'DELETE') NOT NULL,
    `operated_config_json` JSON NOT NULL,
    `operated_payload_json` JSON NOT NULL,
    `operated_session_json` JSON NOT NULL,
    `exception_json` JSON NOT NULL,
    `operated_on` DATETIME DEFAULT CURRENT_TIMESTAMP,
    `operator_ip` VARCHAR(25) NOT NULL,
    PRIMARY KEY (`error_log_no`)
) ENGINE = InnoDB;
-- ----------- Tables for logging --------------
