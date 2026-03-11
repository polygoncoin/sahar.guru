-- ----------- Tables Website level (Website Entered Data) --------------
DROP TABLE IF EXISTS `customer_website`;
CREATE TABLE `customer_website` (
    `customer_website_no` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `allowed_cidr` VARCHAR(250) DEFAULT NULL,
    `rateLimitMaxRequest` BIGINT DEFAULT NULL,
    `rateLimitMaxRequestWindow` BIGINT DEFAULT NULL,
    `customer_no` BIGINT NOT NULL,
    `customer_website_code` VARCHAR(15) NOT NULL,
    `customer_website_name` VARCHAR(100) NOT NULL,
    `customer_website_contact_name` VARCHAR(100) NOT NULL,
    `customer_website_contact_person` VARCHAR(100) NOT NULL,
    `customer_website_contact_firm` VARCHAR(100) NOT NULL,
    `customer_website_contact_department` VARCHAR(100) NOT NULL,
    `customer_website_contact_email_address` VARCHAR(100) NOT NULL,
    `customer_website_contact_phone` VARCHAR(100) NOT NULL,
    `customer_website_contact_fax` VARCHAR(100) NOT NULL,
    `customer_website_contact_mailing_address` VARCHAR(100) NOT NULL,
    `customer_website_contact_city` VARCHAR(100) NOT NULL,
    `customer_website_contact_state` VARCHAR(100) NOT NULL,
    `customer_website_contact_zip` VARCHAR(100) NOT NULL,
    `customer_website_contact_country` VARCHAR(100) NOT NULL,
    `customer_website_general_information` VARCHAR(150) NULL DEFAULT NULL,
    `customer_website_created_by` BIGINT DEFAULT NULL,
    `customer_website_created_on` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `customer_website_approved_by` BIGINT DEFAULT NULL,
    `customer_website_approved_on` TIMESTAMP NULL DEFAULT NULL,
    `customer_website_updated_by` BIGINT DEFAULT NULL,
    `customer_website_updated_on` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    `customer_website_is_editable` ENUM('Yes', 'No') NOT NULL DEFAULT 'No',
    `customer_website_is_approved` ENUM('Yes', 'No') NOT NULL DEFAULT 'No',
    `customer_website_is_disabled` ENUM('Yes', 'No') NOT NULL DEFAULT 'No',
    `customer_website_is_deleted` ENUM('Yes', 'No') NOT NULL DEFAULT 'No',
    PRIMARY KEY (`customer_website_no`)
) ENGINE = InnoDB;

DROP TABLE IF EXISTS `customer_website_admin`;
CREATE TABLE `customer_website_admin` (
    `customer_website_admin_no` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `allowed_cidr` VARCHAR(250) DEFAULT NULL,
    `rateLimitMaxRequest` BIGINT DEFAULT NULL,
    `rateLimitMaxRequestWindow` BIGINT DEFAULT NULL,
    `customer_no` BIGINT NOT NULL,
    `customer_website_no` BIGINT NOT NULL,
    `customer_website_admin_username` VARCHAR(100) NOT NULL,
    `customer_website_admin_password_hash` VARCHAR(150) NOT NULL,
    `customer_website_admin_user_token` VARCHAR(100) NULL DEFAULT NULL,
    `customer_website_admin_user_token_ts` DATETIME NULL DEFAULT NULL,
    `customer_website_admin_contact_name` VARCHAR(100) NOT NULL,
    `customer_website_admin_contact_person` VARCHAR(100) NOT NULL,
    `customer_website_admin_contact_firm` VARCHAR(100) NOT NULL,
    `customer_website_admin_contact_department` VARCHAR(100) NOT NULL,
    `customer_website_admin_contact_email_address` VARCHAR(100) NOT NULL,
    `customer_website_admin_contact_phone` VARCHAR(100) NOT NULL,
    `customer_website_admin_contact_fax` VARCHAR(100) NOT NULL,
    `customer_website_admin_contact_mailing_address` VARCHAR(100) NOT NULL,
    `customer_website_admin_contact_city` VARCHAR(100) NOT NULL,
    `customer_website_admin_contact_state` VARCHAR(100) NOT NULL,
    `customer_website_admin_contact_zip` VARCHAR(100) NOT NULL,
    `customer_website_admin_contact_country` VARCHAR(100) NOT NULL,
    `customer_website_admin_contact_general_information` VARCHAR(150) NULL DEFAULT NULL,
    `customer_website_admin_created_by` BIGINT DEFAULT NULL,
    `customer_website_admin_created_on` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `customer_website_admin_approved_by` BIGINT DEFAULT NULL,
    `customer_website_admin_approved_on` TIMESTAMP NULL DEFAULT NULL,
    `customer_website_admin_updated_by` BIGINT DEFAULT NULL,
    `customer_website_admin_updated_on` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    `customer_website_admin_is_editable` ENUM('Yes', 'No') NOT NULL DEFAULT 'No',
    `customer_website_admin_is_approved` ENUM('Yes', 'No') NOT NULL DEFAULT 'No',
    `customer_website_admin_is_disabled` ENUM('Yes', 'No') NOT NULL DEFAULT 'No',
    `customer_website_admin_is_deleted` ENUM('Yes', 'No') NOT NULL DEFAULT 'No',
    PRIMARY KEY (`customer_website_admin_no`)
) ENGINE = InnoDB;

DROP TABLE IF EXISTS `customer_website_admin_group`;
CREATE TABLE `customer_website_admin_group` (
    `customer_website_admin_group_no` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `allowed_cidr` VARCHAR(250) DEFAULT NULL,
    `rateLimitMaxRequest` BIGINT DEFAULT NULL,
    `rateLimitMaxRequestWindow` BIGINT DEFAULT NULL,
    `customer_website_admin_group_name` VARCHAR(100) NOT NULL,
    `customer_website_admin_group_general_information` VARCHAR(255) DEFAULT NULL,
    `customer_website_admin_group_created_by` BIGINT DEFAULT NULL,
    `customer_website_admin_group_created_on` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `customer_website_admin_group_approved_by` BIGINT DEFAULT NULL,
    `customer_website_admin_group_approved_on` TIMESTAMP NULL DEFAULT NULL,
    `customer_website_admin_group_updated_by` BIGINT DEFAULT NULL,
    `customer_website_admin_group_updated_on` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    `customer_website_admin_group_is_editable` ENUM('Yes', 'No') NOT NULL DEFAULT 'No',
    `customer_website_admin_group_is_approved` ENUM('Yes', 'No') NOT NULL DEFAULT 'No',
    `customer_website_admin_group_is_disabled` ENUM('Yes', 'No') NOT NULL DEFAULT 'No',
    `customer_website_admin_group_is_deleted` ENUM('Yes', 'No') NOT NULL DEFAULT 'No',
    PRIMARY KEY (`customer_website_admin_group_no`)
) ENGINE = InnoDB;

DROP TABLE IF EXISTS `customer_website_admin_group_link`;
CREATE TABLE `customer_website_admin_group_link` (
    `sr_no` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `customer_no` BIGINT NOT NULL,
    `customer_website_no` BIGINT NOT NULL,
    `customer_website_admin_no` BIGINT NOT NULL,
    `customer_website_admin_group_no` BIGINT NOT NULL,
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

DROP TABLE IF EXISTS `website_item`;
CREATE TABLE `website_item` (
    `website_item_no` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `customer_no` BIGINT NOT NULL,
    `customer_manufacturer_no` BIGINT NOT NULL,
    `customer_brand_no` BIGINT NOT NULL,
    `website_no` BIGINT NOT NULL,
    `customer_item_no` BIGINT NOT NULL,
    `website_item_general_information` VARCHAR(150) NULL DEFAULT NULL,
    `website_item_created_by` BIGINT DEFAULT NULL,
    `website_item_created_on` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `website_item_approved_by` BIGINT DEFAULT NULL,
    `website_item_approved_on` TIMESTAMP NULL DEFAULT NULL,
    `website_item_updated_by` BIGINT DEFAULT NULL,
    `website_item_updated_on` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    `website_item_is_editable` ENUM('Yes', 'No') NOT NULL DEFAULT 'No',
    `website_item_is_approved` ENUM('Yes', 'No') NOT NULL DEFAULT 'No',
    `website_item_is_disabled` ENUM('Yes', 'No') NOT NULL DEFAULT 'No',
    `website_item_is_deleted` ENUM('Yes', 'No') NOT NULL DEFAULT 'No',
    PRIMARY KEY (`website_item_no`)
) ENGINE = InnoDB;

DROP TABLE IF EXISTS `website_generic_item`;
CREATE TABLE `website_generic_item` (
    `website_generic_item_no` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `customer_no` BIGINT NOT NULL,
    `customer_manufacturer_no` BIGINT NOT NULL,
    `customer_brand_no` BIGINT NOT NULL,
    `website_no` BIGINT NOT NULL,
    `customer_generic_item_no` BIGINT NULL DEFAULT NULL,
    `website_generic_item_general_information` VARCHAR(150) NULL DEFAULT NULL,
    `website_generic_item_created_by` BIGINT DEFAULT NULL,
    `website_generic_item_created_on` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `website_generic_item_approved_by` BIGINT DEFAULT NULL,
    `website_generic_item_approved_on` TIMESTAMP NULL DEFAULT NULL,
    `website_generic_item_updated_by` BIGINT DEFAULT NULL,
    `website_generic_item_updated_on` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    `website_generic_item_is_editable` ENUM('Yes', 'No') NOT NULL DEFAULT 'No',
    `website_generic_item_is_approved` ENUM('Yes', 'No') NOT NULL DEFAULT 'No',
    `website_generic_item_is_disabled` ENUM('Yes', 'No') NOT NULL DEFAULT 'No',
    `website_generic_item_is_deleted` ENUM('Yes', 'No') NOT NULL DEFAULT 'No',
    PRIMARY KEY (`website_generic_item_no`)
) ENGINE = InnoDB;
-- ----------- Tables Website level (Website Entered Data) --------------
