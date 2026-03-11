-- ----------- Tables Suoer Admin level --------------
DROP TABLE IF EXISTS `admin`;
CREATE TABLE `admin` (
    `admin_no` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `allowed_cidr` VARCHAR(250) DEFAULT NULL,
    `rateLimitMaxRequest` BIGINT DEFAULT NULL,
    `rateLimitMaxRequestWindow` BIGINT DEFAULT NULL,
    `admin_username` VARCHAR(100) NOT NULL,
    `admin_password_hash` VARCHAR(150) NOT NULL,
    `admin_user_token` VARCHAR(100) NULL DEFAULT NULL,
    `admin_user_token_ts` DATETIME NULL DEFAULT NULL,
    `admin_general_information` VARCHAR(150) NULL DEFAULT NULL,
    `admin_created_by` BIGINT DEFAULT NULL,
    `admin_created_on` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `admin_approved_by` BIGINT DEFAULT NULL,
    `admin_approved_on` TIMESTAMP NULL DEFAULT NULL,
    `admin_updated_by` BIGINT DEFAULT NULL,
    `admin_updated_on` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    `admin_is_editable` ENUM('Yes', 'No') NOT NULL DEFAULT 'No',
    `admin_is_approved` ENUM('Yes', 'No') NOT NULL DEFAULT 'No',
    `admin_is_disabled` ENUM('Yes', 'No') NOT NULL DEFAULT 'No',
    `admin_is_deleted` ENUM('Yes', 'No') NOT NULL DEFAULT 'No',
    PRIMARY KEY (`admin_no`)
) ENGINE = InnoDB;

DROP TABLE IF EXISTS `admin_contact`;
CREATE TABLE `admin_contact` (
    `admin_contact_no` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `admin_no` BIGINT NOT NULL,
    `admin_contact_name` VARCHAR(100) NOT NULL,
    `admin_contact_person` VARCHAR(100) NOT NULL,
    `admin_contact_firm` VARCHAR(100) NOT NULL,
    `admin_contact_department` VARCHAR(100) NOT NULL,
    `admin_contact_email_address` VARCHAR(100) NOT NULL,
    `admin_contact_phone` VARCHAR(100) NOT NULL,
    `admin_contact_fax` VARCHAR(100) NOT NULL,
    `admin_contact_mailing_address` VARCHAR(100) NOT NULL,
    `admin_contact_city` VARCHAR(100) NOT NULL,
    `admin_contact_state` VARCHAR(100) NOT NULL,
    `admin_contact_zip` VARCHAR(100) NOT NULL,
    `admin_contact_country` VARCHAR(100) NOT NULL,
    `admin_contact_general_information` VARCHAR(150) NULL DEFAULT NULL,
    `admin_contact_created_by` BIGINT DEFAULT NULL,
    `admin_contact_created_on` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `admin_contact_approved_by` BIGINT DEFAULT NULL,
    `admin_contact_approved_on` TIMESTAMP NULL DEFAULT NULL,
    `admin_contact_updated_by` BIGINT DEFAULT NULL,
    `admin_contact_updated_on` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    `admin_contact_is_editable` ENUM('Yes', 'No') NOT NULL DEFAULT 'No',
    `admin_contact_is_approved` ENUM('Yes', 'No') NOT NULL DEFAULT 'No',
    `admin_contact_is_disabled` ENUM('Yes', 'No') NOT NULL DEFAULT 'No',
    `admin_contact_is_deleted` ENUM('Yes', 'No') NOT NULL DEFAULT 'No',
    PRIMARY KEY (`admin_contact_no`)
) ENGINE = InnoDB;

DROP TABLE IF EXISTS `admin_group`;
CREATE TABLE `admin_group` (
    `admin_group_no` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `allowed_cidr` VARCHAR(250) DEFAULT NULL,
    `rateLimitMaxRequest` BIGINT DEFAULT NULL,
    `rateLimitMaxRequestWindow` BIGINT DEFAULT NULL,
    `admin_group_name` VARCHAR(100) NOT NULL,
    `admin_group_general_information` VARCHAR(250) DEFAULT NULL,
    `admin_group_created_by` BIGINT DEFAULT NULL,
    `admin_group_created_on` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `admin_group_approved_by` BIGINT DEFAULT NULL,
    `admin_group_approved_on` TIMESTAMP NULL DEFAULT NULL,
    `admin_group_updated_by` BIGINT DEFAULT NULL,
    `admin_group_updated_on` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    `admin_group_is_editable` ENUM('Yes', 'No') NOT NULL DEFAULT 'No',
    `admin_group_is_approved` ENUM('Yes', 'No') NOT NULL DEFAULT 'No',
    `admin_group_is_disabled` ENUM('Yes', 'No') NOT NULL DEFAULT 'No',
    `admin_group_is_deleted` ENUM('Yes', 'No') NOT NULL DEFAULT 'No',
    PRIMARY KEY (`admin_group_no`)
) ENGINE = InnoDB;

DROP TABLE IF EXISTS `admin_group_link`;
CREATE TABLE `admin_group_link` (
    `sr_no` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `admin_no` BIGINT NOT NULL,
    `admin_group_no` BIGINT NOT NULL,
    `created_by` BIGINT DEFAULT NULL,
    `created_on` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `approved_by` BIGINT DEFAULT NULL,
    `approved_on` TIMESTAMP NULL DEFAULT NULL,
    `updated_by` BIGINT DEFAULT NULL,
    `updated_on` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    `is_editable` ENUM('Yes', 'No') NOT NULL DEFAULT 'No',
    `is_approved` ENUM('Yes', 'No') NOT NULL DEFAULT 'No',
    `is_disabled` ENUM('Yes', 'No') NOT NULL DEFAULT 'No',
    `is_deleted` ENUM('Yes', 'No') NOT NULL DEFAULT 'No',
    PRIMARY KEY (`sr_no`)
) ENGINE = InnoDB;
-- ----------- Tables Suoer Admin level --------------
