-- ----------- Tables Website level (Website Entered Data) --------------
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
    `website_item_is_editable` ENUM('Yes','No') NOT NULL DEFAULT 'No',
    `website_item_is_approved` ENUM('Yes','No') NOT NULL DEFAULT 'No',
    `website_item_is_disabled` ENUM('Yes','No') NOT NULL DEFAULT 'No',
    `website_item_is_deleted` ENUM('Yes','No') NOT NULL DEFAULT 'No',
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
    `website_generic_item_is_editable` ENUM('Yes','No') NOT NULL DEFAULT 'No',
    `website_generic_item_is_approved` ENUM('Yes','No') NOT NULL DEFAULT 'No',
    `website_generic_item_is_disabled` ENUM('Yes','No') NOT NULL DEFAULT 'No',
    `website_generic_item_is_deleted` ENUM('Yes','No') NOT NULL DEFAULT 'No',
    PRIMARY KEY (`website_generic_item_no`)
) ENGINE = InnoDB;
-- ----------- Tables Website level (Website Entered Data) --------------
