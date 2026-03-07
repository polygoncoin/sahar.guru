DROP TABLE IF EXISTS `user`;

CREATE TABLE `user` (
  `id` INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  `client_id` int NOT NULL,
  `group_id` int NOT NULL,
  `allowed_cidr` text,
  `firstname` varchar(255) NOT NULL,
  `lastname` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `username` varchar(255) NOT NULL,
  `password_hash` varchar(255) NOT NULL,
  `token` varchar(255) DEFAULT NULL,
  `token_ts` int UNSIGNED DEFAULT 0,
  `rateLimitMaxRequest` int DEFAULT NULL,
  `rateLimitMaxRequestWindow` int DEFAULT NULL,
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

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES
(1,1,1,'0.0.0.0/0','shared-user-1','client','user1@email.com','client','$2y$10$o8hFTjBIXQS.fOED2Ut1ZOCSdDjTnS3lyELI4rWyFEnu4GUyJr3O6','',0,NULL,NULL,NULL,0,'2023-02-22 04:12:50',NULL,NULL,0,'2023-04-20 16:53:57','Yes','No','No'),
(1,2,2,'0.0.0.0/0','mum-user-1','bai','user2@email.com','mumbai','$2y$10$o8hFTjBIXQS.fOED2Ut1ZOCSdDjTnS3lyELI4rWyFEnu4GUyJr3O6','',0,NULL,NULL,NULL,0,'2023-02-22 04:12:50',NULL,NULL,0,'2023-04-20 16:53:57','Yes','No','No');
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;

------------- Tables for logging --------------
-- (Open for all request)
DROP TABLE IF EXISTS `request`;
CREATE TABLE `request` (
    `request_no` BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    `request_by` ENUM('Admin', 'Customer', 'WebsiteAdmin') NOT NULL,
    `request_by_no` BIGINT NOT NULL,
    `request_route` VARCHAR(250),
    `request_method` ENUM('GET','POST','PUT','PATCH','DELETE') NOT NULL,
    `request_payload_json` JSON NOT NULL,
    `request_operated_on` DATETIME DEFAULT CURRENT_TIMESTAMP,
    `request_operator_ip` VARCHAR(25) NOT NULL
);

-- (Only for authorised request)
DROP TABLE IF EXISTS `error_log`;
CREATE TABLE `error_log` (
    `error_log_no` BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    `request_no` BIGINT NOT NULL,
    `operated_by` ENUM('Admin', 'Customer', 'WebsiteAdmin') NOT NULL,
    `operated_by_no` BIGINT NOT NULL,
    `operated_route` VARCHAR(250),
    `operated_request_method` ENUM('GET','POST','PUT','PATCH','DELETE') NOT NULL,
    `operated_config_json` JSON NOT NULL,
    `operated_payload_json` JSON NOT NULL,
    `operated_session_json` JSON NOT NULL,
    `exception_json` JSON NOT NULL,
    `operated_on` DATETIME DEFAULT CURRENT_TIMESTAMP,
    `operator_ip` VARCHAR(25) NOT NULL
);
------------- Tables for logging --------------

------------- Tables Suoer Admin level --------------
-- @Suoer Admin level
DROP TABLE IF EXISTS `admin`;
CREATE TABLE `admin` (
    `admin_no` BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    `allowed_cidr` VARCHAR(250),
    `rateLimitMaxRequest` BIGINT DEFAULT NULL,
    `rateLimitMaxRequestWindow` BIGINT DEFAULT NULL,
    `admin_username` VARCHAR(100) NOT NULL,
    `admin_password_hash` VARCHAR(150) NOT NULL,
    `admin_user_token` VARCHAR(100) NULL DEFAULT NULL,
    `admin_user_token_ts` DATETIME NULL DEFAULT NULL,
    `admin_general_information` VARCHAR(150) NULL DEFAULT NULL,
    `admin_created_by` BIGINT DEFAULT NULL,
    `admin_created_on` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `admin_approved_by` BIGINT DEFAULT NULL,
    `admin_approved_on` timestamp NULL DEFAULT NULL,
    `admin_updated_by` BIGINT DEFAULT NULL,
    `admin_updated_on` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    `admin_is_editable` ENUM('Yes','No') NOT NULL DEFAULT 'No',
    `admin_is_approved` ENUM('Yes','No') NOT NULL DEFAULT 'No',
    `admin_is_disabled` ENUM('Yes','No') NOT NULL DEFAULT 'No',
    `admin_is_deleted` ENUM('Yes','No') NOT NULL DEFAULT 'No'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- @Suoer Admin level
DROP TABLE IF EXISTS `admin_contact`;
CREATE TABLE `admin_contact` (
    `admin_contact_no` BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
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
    `admin_contact_created_on` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `admin_contact_approved_by` BIGINT DEFAULT NULL,
    `admin_contact_approved_on` timestamp NULL DEFAULT NULL,
    `admin_contact_updated_by` BIGINT DEFAULT NULL,
    `admin_contact_updated_on` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    `admin_contact_is_editable` ENUM('Yes','No') NOT NULL DEFAULT 'No',
    `admin_contact_is_approved` ENUM('Yes','No') NOT NULL DEFAULT 'No',
    `admin_contact_is_disabled` ENUM('Yes','No') NOT NULL DEFAULT 'No',
    `admin_contact_is_deleted` ENUM('Yes','No') NOT NULL DEFAULT 'No'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

DROP TABLE IF EXISTS `admin_group`;
CREATE TABLE `admin_group` (
    `admin_group_no` BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    `allowed_cidr` VARCHAR(250),
    `rateLimitMaxRequest` BIGINT DEFAULT NULL,
    `rateLimitMaxRequestWindow` BIGINT DEFAULT NULL,
    `admin_group_name` varchar(100) NOT NULL,
    `admin_group_general_information` varchar(255) DEFAULT NULL,
    `admin_group_created_by` BIGINT DEFAULT NULL,
    `admin_group_created_on` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `admin_group_approved_by` BIGINT DEFAULT NULL,
    `admin_group_approved_on` timestamp NULL DEFAULT NULL,
    `admin_group_updated_by` BIGINT DEFAULT NULL,
    `admin_group_updated_on` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    `admin_group_is_editable` ENUM('Yes','No') NOT NULL DEFAULT 'No',
    `admin_group_is_approved` enum('Yes','No') NOT NULL DEFAULT 'No',
    `admin_group_is_disabled` enum('Yes','No') NOT NULL DEFAULT 'No',
    `admin_group_is_deleted` enum('Yes','No') NOT NULL DEFAULT 'No'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

DROP TABLE IF EXISTS `admin_group_link`;
CREATE TABLE `admin_group_link` (
    `sr_no` BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    `admin_no` BIGINT NOT NULL,
    `admin_group_no` BIGINT NOT NULL,
    `created_by` BIGINT DEFAULT NULL,
    `created_on` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `approved_by` BIGINT DEFAULT NULL,
    `approved_on` timestamp NULL DEFAULT NULL,
    `updated_by` BIGINT DEFAULT NULL,
    `updated_on` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    `is_editable` ENUM('Yes','No') NOT NULL DEFAULT 'No',
    `is_approved` enum('Yes','No') NOT NULL DEFAULT 'No',
    `is_disabled` enum('Yes','No') NOT NULL DEFAULT 'No',
    `is_deleted` enum('Yes','No') NOT NULL DEFAULT 'No'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
------------- Tables Suoer Admin level --------------

------------- Tables Customer level (By Super Admin) --------------
DROP TABLE IF EXISTS `customer`;
CREATE TABLE `customer` (
    `customer_no` BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    `allowed_cidr` VARCHAR(250),
    `rateLimitMaxRequest` BIGINT DEFAULT NULL,
    `rateLimitMaxRequestWindow` BIGINT DEFAULT NULL,
    `customer_username` VARCHAR(100) NOT NULL,
    `customer_password_hash` VARCHAR(150) NOT NULL,
    `customer_user_token` VARCHAR(100) NULL DEFAULT NULL,
    `customer_user_token_ts` DATETIME NULL DEFAULT NULL,
    `customer_general_information` VARCHAR(150) NULL DEFAULT NULL,
    `customer_created_by` BIGINT DEFAULT NULL,
    `customer_created_on` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `customer_approved_by` BIGINT DEFAULT NULL,
    `customer_approved_on` timestamp NULL DEFAULT NULL,
    `customer_updated_by` BIGINT DEFAULT NULL,
    `customer_updated_on` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    `customer_is_editable` ENUM('Yes','No') NOT NULL DEFAULT 'No',
    `customer_is_approved` ENUM('Yes','No') NOT NULL DEFAULT 'No',
    `customer_is_disabled` ENUM('Yes','No') NOT NULL DEFAULT 'No',
    `customer_is_deleted` ENUM('Yes','No') NOT NULL DEFAULT 'No'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

DROP TABLE IF EXISTS `customer_contact`;
CREATE TABLE `customer_contact` (
    `customer_contact_no` BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    `customer_no` BIGINT NOT NULL,
    `customer_contact_name` VARCHAR(100) NOT NULL,
    `customer_contact_person` VARCHAR(100) NOT NULL,
    `customer_contact_firm` VARCHAR(100) NOT NULL,
    `customer_contact_department` VARCHAR(100) NOT NULL,
    `customer_contact_email_address` VARCHAR(100) NOT NULL,
    `customer_contact_phone` VARCHAR(100) NOT NULL,
    `customer_contact_fax` VARCHAR(100) NOT NULL,
    `customer_contact_mailing_address` VARCHAR(100) NOT NULL,
    `customer_contact_city` VARCHAR(100) NOT NULL,
    `customer_contact_state` VARCHAR(100) NOT NULL,
    `customer_contact_zip` VARCHAR(100) NOT NULL,
    `customer_contact_country` VARCHAR(100) NOT NULL,
    `customer_contact_general_information` VARCHAR(150) NULL DEFAULT NULL,
    `customer_contact_created_by` BIGINT DEFAULT NULL,
    `customer_contact_created_on` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `customer_contact_approved_by` BIGINT DEFAULT NULL,
    `customer_contact_approved_on` timestamp NULL DEFAULT NULL,
    `customer_contact_updated_by` BIGINT DEFAULT NULL,
    `customer_contact_updated_on` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    `customer_contact_is_editable` ENUM('Yes','No') NOT NULL DEFAULT 'No',
    `customer_contact_is_approved` ENUM('Yes','No') NOT NULL DEFAULT 'No',
    `customer_contact_is_disabled` ENUM('Yes','No') NOT NULL DEFAULT 'No',
    `customer_contact_is_deleted` ENUM('Yes','No') NOT NULL DEFAULT 'No'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

DROP TABLE IF EXISTS `customer_group`;
CREATE TABLE `customer_group` (
    `customer_group_no` BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    `allowed_cidr` VARCHAR(250),
    `rateLimitMaxRequest` BIGINT DEFAULT NULL,
    `rateLimitMaxRequestWindow` BIGINT DEFAULT NULL,
    `customer_group_name` varchar(100) NOT NULL,
    `customer_group_general_information` varchar(255) DEFAULT NULL,
    `customer_group_created_by` BIGINT DEFAULT NULL,
    `customer_group_created_on` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `customer_group_approved_by` BIGINT DEFAULT NULL,
    `customer_group_approved_on` timestamp NULL DEFAULT NULL,
    `customer_group_updated_by` BIGINT DEFAULT NULL,
    `customer_group_updated_on` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    `customer_group_is_editable` ENUM('Yes','No') NOT NULL DEFAULT 'No',
    `customer_group_is_approved` enum('Yes','No') NOT NULL DEFAULT 'No',
    `customer_group_is_disabled` enum('Yes','No') NOT NULL DEFAULT 'No',
    `customer_group_is_deleted` enum('Yes','No') NOT NULL DEFAULT 'No'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

DROP TABLE IF EXISTS `customer_group_link`;
CREATE TABLE `customer_group_link` (
    `sr_no` BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    `customer_no` BIGINT NOT NULL,
    `customer_group_no` BIGINT NOT NULL,
    `created_by` BIGINT DEFAULT NULL,
    `created_on` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `approved_by` BIGINT DEFAULT NULL,
    `approved_on` timestamp NULL DEFAULT NULL,
    `updated_by` BIGINT DEFAULT NULL,
    `updated_on` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    `is_editable` ENUM('Yes','No') NOT NULL DEFAULT 'No',
    `is_approved` enum('Yes','No') NOT NULL DEFAULT 'No',
    `is_disabled` enum('Yes','No') NOT NULL DEFAULT 'No',
    `is_deleted` enum('Yes','No') NOT NULL DEFAULT 'No'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

------------- Tables Customer level (By Super Admin) --------------

------------- Tables Customer level (Customer Entered Data) --------------
DROP TABLE IF EXISTS `customer_uom`; -- (Unit of MeasureUnit)
CREATE TABLE `customer_uom` (
    `customer_uom_no` BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    `customer_no` BIGINT NOT NULL,
    `customer_uom_code` VARCHAR(15) NOT NULL,
    `customer_uom_name` VARCHAR(100) NOT NULL,
    `customer_uom_general_information` VARCHAR(150) NULL DEFAULT NULL,
    `customer_uom_created_by` BIGINT DEFAULT NULL,
    `customer_uom_created_on` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `customer_uom_approved_by` BIGINT DEFAULT NULL,
    `customer_uom_approved_on` timestamp NULL DEFAULT NULL,
    `customer_uom_updated_by` BIGINT DEFAULT NULL,
    `customer_uom_updated_on` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    `customer_uom_is_editable` ENUM('Yes','No') NOT NULL DEFAULT 'No',
    `customer_uom_is_approved` ENUM('Yes','No') NOT NULL DEFAULT 'No',
    `customer_uom_is_disabled` ENUM('Yes','No') NOT NULL DEFAULT 'No',
    `customer_uom_is_deleted` ENUM('Yes','No') NOT NULL DEFAULT 'No'
);

DROP TABLE IF EXISTS `customer_uom_conversion`;
CREATE TABLE `customer_uom_conversion` (
    `customer_uom_conversion_no` BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    `customer_no` BIGINT NOT NULL,
    `customer_uom_conversion_from_uom_no` BIGINT NOT NULL,
    `customer_uom_conversion_to_uom_no` BIGINT NOT NULL,
    `customer_uom_conversion_rule` VARCHAR(100) NOT NULL,
    `customer_uom_conversion_general_information` VARCHAR(150) NULL DEFAULT NULL,
    `customer_uom_conversion_created_by` BIGINT DEFAULT NULL,
    `customer_uom_conversion_created_on` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `customer_uom_conversion_approved_by` BIGINT DEFAULT NULL,
    `customer_uom_conversion_approved_on` timestamp NULL DEFAULT NULL,
    `customer_uom_conversion_updated_by` BIGINT DEFAULT NULL,
    `customer_uom_conversion_updated_on` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    `customer_uom_conversion_is_editable` ENUM('Yes','No') NOT NULL DEFAULT 'No',
    `customer_uom_conversion_is_approved` ENUM('Yes','No') NOT NULL DEFAULT 'No',
    `customer_uom_conversion_is_disabled` ENUM('Yes','No') NOT NULL DEFAULT 'No',
    `customer_uom_conversion_is_deleted` ENUM('Yes','No') NOT NULL DEFAULT 'No'
);

DROP TABLE IF EXISTS `customer_manufacturer`;
CREATE TABLE `customer_manufacturer` (
    `customer_manufacturer_no` BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    `customer_no` BIGINT NOT NULL,
    `customer_manufacturer_code` VARCHAR(15) NOT NULL,
    `customer_manufacturer_name` VARCHAR(100) NOT NULL,
    `customer_manufacturer_contact_name` VARCHAR(100) NOT NULL,
    `customer_manufacturer_contact_person` VARCHAR(100) NOT NULL,
    `customer_manufacturer_contact_firm` VARCHAR(100) NOT NULL,
    `customer_manufacturer_contact_department` VARCHAR(100) NOT NULL,
    `customer_manufacturer_contact_email_address` VARCHAR(100) NOT NULL,
    `customer_manufacturer_contact_phone` VARCHAR(100) NOT NULL,
    `customer_manufacturer_contact_fax` VARCHAR(100) NOT NULL,
    `customer_manufacturer_contact_mailing_address` VARCHAR(100) NOT NULL,
    `customer_manufacturer_contact_city` VARCHAR(100) NOT NULL,
    `customer_manufacturer_contact_state` VARCHAR(100) NOT NULL,
    `customer_manufacturer_contact_zip` VARCHAR(100) NOT NULL,
    `customer_manufacturer_contact_country` VARCHAR(100) NOT NULL,
    `customer_manufacturer_general_information` VARCHAR(150) NULL DEFAULT NULL,
    `customer_manufacturer_created_by` BIGINT DEFAULT NULL,
    `customer_manufacturer_created_on` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `customer_manufacturer_approved_by` BIGINT DEFAULT NULL,
    `customer_manufacturer_approved_on` timestamp NULL DEFAULT NULL,
    `customer_manufacturer_updated_by` BIGINT DEFAULT NULL,
    `customer_manufacturer_updated_on` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    `customer_manufacturer_is_editable` ENUM('Yes','No') NOT NULL DEFAULT 'No',
    `customer_manufacturer_is_approved` ENUM('Yes','No') NOT NULL DEFAULT 'No',
    `customer_manufacturer_is_disabled` ENUM('Yes','No') NOT NULL DEFAULT 'No',
    `customer_manufacturer_is_deleted` ENUM('Yes','No') NOT NULL DEFAULT 'No'
);

DROP TABLE IF EXISTS `customer_brand`;
CREATE TABLE `customer_brand` (
    `customer_brand_no` BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    `customer_no` BIGINT NOT NULL,
    `customer_brand_code` VARCHAR(15) NOT NULL,
    `customer_brand_name` VARCHAR(100) NOT NULL,
    `customer_brand_contact_name` VARCHAR(100) NOT NULL,
    `customer_brand_contact_person` VARCHAR(100) NOT NULL,
    `customer_brand_contact_firm` VARCHAR(100) NOT NULL,
    `customer_brand_contact_department` VARCHAR(100) NOT NULL,
    `customer_brand_contact_email_address` VARCHAR(100) NOT NULL,
    `customer_brand_contact_phone` VARCHAR(100) NOT NULL,
    `customer_brand_contact_fax` VARCHAR(100) NOT NULL,
    `customer_brand_contact_mailing_address` VARCHAR(100) NOT NULL,
    `customer_brand_contact_city` VARCHAR(100) NOT NULL,
    `customer_brand_contact_state` VARCHAR(100) NOT NULL,
    `customer_brand_contact_zip` VARCHAR(100) NOT NULL,
    `customer_brand_contact_country` VARCHAR(100) NOT NULL,
    `customer_brand_general_information` VARCHAR(150) NULL DEFAULT NULL,
    `customer_brand_created_by` BIGINT DEFAULT NULL,
    `customer_brand_created_on` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `customer_brand_approved_by` BIGINT DEFAULT NULL,
    `customer_brand_approved_on` timestamp NULL DEFAULT NULL,
    `customer_brand_updated_by` BIGINT DEFAULT NULL,
    `customer_brand_updated_on` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    `customer_brand_is_editable` ENUM('Yes','No') NOT NULL DEFAULT 'No',
    `customer_brand_is_approved` ENUM('Yes','No') NOT NULL DEFAULT 'No',
    `customer_brand_is_disabled` ENUM('Yes','No') NOT NULL DEFAULT 'No',
    `customer_brand_is_deleted` ENUM('Yes','No') NOT NULL DEFAULT 'No'
);

DROP TABLE IF EXISTS `customer_item_category`;
CREATE TABLE `customer_item_category` (
    `customer_item_category_no` BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    `customer_no` BIGINT NOT NULL,
    `customer_item_category_code` VARCHAR(15) NOT NULL,
    `customer_item_category_name` VARCHAR(100) NOT NULL,
    `customer_item_category_general_information` VARCHAR(150) NOT NULL,
    `customer_item_category_created_by` BIGINT DEFAULT NULL,
    `customer_item_category_created_on` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `customer_item_category_approved_by` BIGINT DEFAULT NULL,
    `customer_item_category_approved_on` timestamp NULL DEFAULT NULL,
    `customer_item_category_updated_by` BIGINT DEFAULT NULL,
    `customer_item_category_updated_on` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    `customer_item_category_is_editable` ENUM('Yes','No') NOT NULL DEFAULT 'No',
    `customer_item_category_is_approved` ENUM('Yes','No') NOT NULL DEFAULT 'No',
    `customer_item_category_is_disabled` ENUM('Yes','No') NOT NULL DEFAULT 'No',
    `customer_item_category_is_deleted` ENUM('Yes','No') NOT NULL DEFAULT 'No'
);

DROP TABLE IF EXISTS `customer_item`;
CREATE TABLE `customer_item` (
    `customer_item_no` BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    `customer_no` BIGINT NOT NULL,
    `customer_item_code` VARCHAR(15) NOT NULL,
    `customer_item_name` VARCHAR(250) NOT NULL,
    `customer_item_category_no` BIGINT NOT NULL,
    `customer_item_length` BIGINT NOT NULL,
    `customer_item_breadth` BIGINT NOT NULL,
    `customer_item_height` BIGINT NOT NULL,
    `customer_item_version` VARCHAR(250) NOT NULL,
    `customer_item_model` VARCHAR(250) NOT NULL,
    `customer_item_type` VARCHAR(250) NOT NULL,
    `customer_item_is_fragile` ENUM('Yes','No') NOT NULL,
    `customer_item_price` FLOAT NOT NULL DEFAULT 0, -- (current rate)
    `customer_item_default_uom` VARCHAR(250) NULL DEFAULT NULL,
    `customer_item_default_sku` VARCHAR(250) NULL DEFAULT NULL, --- (stock keeping unit)
    `customer_item_average_cost` VARCHAR(250) NULL DEFAULT NULL,
    `customer_item_single_unit_code` VARCHAR(250) NULL DEFAULT NULL, --  (for packs)
    `customer_item_photography_link` JSON NULL DEFAULT NULL, --  (general not specific)
    `customer_item_warranty_term` TINYTEXT NULL DEFAULT NULL, --  (general not specific)
    `customer_item_general_information` TINYTEXT NULL DEFAULT NULL,
    `customer_item_remark` TINYTEXT NULL DEFAULT NULL,
    `customer_item_markup` TINYTEXT NULL DEFAULT NULL,
    `customer_item_length` BIGINT NOT NULL,
    `customer_item_breadth` BIGINT NOT NULL,
    `customer_item_height` BIGINT NOT NULL,
    `customer_item_condition` ENUM('New','Operational','Requires Maintenance','Out of Service') NOT NULL,
    `customer_item_manufacturing_date` BIGINT NOT NULL,
    `customer_item_warrenty_or_expiry_date` BIGINT NOT NULL,
    `customer_item_unit_cost` BIGINT NOT NULL,
    `customer_item_retail_price` BIGINT NOT NULL,
    `customer_item_serial_number` BIGINT NOT NULL,
    `customer_item_usage_hour` BIGINT NOT NULL,
    `customer_item_fuel_type` ENUM('Gasoline','Diesel','Propane','EV','LPG','CNG') NOT NULL,
    `customer_item_purchase_date` BIGINT NOT NULL,
    `customer_item_initial_purchase_value` BIGINT NOT NULL,
    `customer_item_down_payment` BIGINT NOT NULL,
    `customer_item_service_year_remaining` BIGINT NOT NULL,
    `customer_item_current_market_value` BIGINT NOT NULL,
    `customer_item_expected_residual_value` BIGINT NOT NULL,
    `customer_item_monthly_operating_cost` BIGINT NOT NULL,
    `customer_item_monthly_straight_line_depreciation` BIGINT NOT NULL,
    `customer_item_annual_straight_line_depreciation` BIGINT NOT NULL,
    `customer_item_starting_inventory` BIGINT NOT NULL,
    `customer_item_low_stock_threshold` BIGINT NOT NULL,
    `customer_item_current_stock_level` BIGINT NOT NULL,
    `customer_item_created_by` BIGINT DEFAULT NULL,
    `customer_item_created_on` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `customer_item_approved_by` BIGINT DEFAULT NULL,
    `customer_item_approved_on` timestamp NULL DEFAULT NULL,
    `customer_item_updated_by` BIGINT DEFAULT NULL,
    `customer_item_updated_on` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    `customer_item_is_editable` ENUM('Yes','No') NOT NULL DEFAULT 'No',
    `customer_item_is_approved` ENUM('Yes','No') NOT NULL DEFAULT 'No',
    `customer_item_is_disabled` ENUM('Yes','No') NOT NULL DEFAULT 'No',
    `customer_item_is_deleted` ENUM('Yes','No') NOT NULL DEFAULT 'No'
);

DROP TABLE IF EXISTS `customer_generic_item`;
CREATE TABLE `customer_generic_item` (
    `customer_generic_item_no` BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    `customer_no` BIGINT NOT NULL,
    `customer_generic_item_name` VARCHAR(15) NOT NULL,
    `customer_generic_item_general_information` VARCHAR(150) NULL DEFAULT NULL,
    `customer_generic_item_length` BIGINT NOT NULL,
    `customer_generic_item_breadth` BIGINT NOT NULL,
    `customer_generic_item_height` BIGINT NOT NULL,
    `customer_generic_item_condition` ENUM('New','Operational','Requires Maintenance','Out of Service') NOT NULL,
    `customer_generic_item_manufacturing_date` BIGINT NOT NULL,
    `customer_generic_item_warrenty_or_expiry_date` BIGINT NOT NULL,
    `customer_generic_item_unit_cost` BIGINT NOT NULL,
    `customer_generic_item_retail_price` BIGINT NOT NULL,
    `customer_generic_item_serial_number` BIGINT NOT NULL,
    `customer_generic_item_usage_hour` BIGINT NOT NULL,
    `customer_generic_item_fuel_type` ENUM('Gasoline','Diesel','Propane','EV','LPG','CNG') NOT NULL,
    `customer_generic_item_purchase_date` BIGINT NOT NULL,
    `customer_generic_item_initial_purchase_value` BIGINT NOT NULL,
    `customer_generic_item_down_payment` BIGINT NOT NULL,
    `customer_generic_item_service_year_remaining` BIGINT NOT NULL,
    `customer_generic_item_current_market_value` BIGINT NOT NULL,
    `customer_generic_item_expected_residual_value` BIGINT NOT NULL,
    `customer_generic_item_monthly_operating_cost` BIGINT NOT NULL,
    `customer_generic_item_monthly_straight_line_depreciation` BIGINT NOT NULL,
    `customer_generic_item_annual_straight_line_depreciation` BIGINT NOT NULL,
    `customer_generic_item_starting_inventory` BIGINT NOT NULL,
    `customer_generic_item_low_stock_threshold` BIGINT NOT NULL,
    `customer_generic_item_current_stock_level` BIGINT NOT NULL,
    `customer_generic_item_created_by` BIGINT DEFAULT NULL,
    `customer_generic_item_created_on` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `customer_generic_item_approved_by` BIGINT DEFAULT NULL,
    `customer_generic_item_approved_on` timestamp NULL DEFAULT NULL,
    `customer_generic_item_updated_by` BIGINT DEFAULT NULL,
    `customer_generic_item_updated_on` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    `customer_generic_item_is_editable` ENUM('Yes','No') NOT NULL DEFAULT 'No',
    `customer_generic_item_is_approved` ENUM('Yes','No') NOT NULL DEFAULT 'No',
    `customer_generic_item_is_disabled` ENUM('Yes','No') NOT NULL DEFAULT 'No',
    `customer_generic_item_is_deleted` ENUM('Yes','No') NOT NULL DEFAULT 'No'
);

DROP TABLE IF EXISTS `customer_item_stock`;
CREATE TABLE `customer_item_stock` (
    `customer_item_stock_no` BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    `customer_no` BIGINT NOT NULL,
    `customer_item_no` BIGINT NOT NULL,
    `warehouse_no` BIGINT NOT NULL,
    `zone_no` BIGINT NOT NULL,
    `level_no` BIGINT NOT NULL,
    `rack_no` BIGINT NOT NULL,
    `etc_no` BIGINT NOT NULL, -- warehouse_no, zone_no, level_no, rack_no etc.
    `lot_information` BIGINT NOT NULL, --  (lot_no)
    `lot_or_batch_code` BIGINT NOT NULL,
    `date_manufactured` DATE NOT NULL,
    `date_expiry` DATE NOT NULL,
    `warranty_term` TINYTEXT NULL DEFAULT NULL, --  (general not specific)
    `from_date` DATETIME NOT NULL,
    `item_price` FLOAT NULL DEFAULT NULL, -- (current rate)
    `quantity_in_hand` BIGINT NOT NULL,
    `item_attribute_data_no` BIGINT NOT NULL, --   (if applicable) [we have 4 red color items etc.]
    `customer_item_stock_general_information` VARCHAR(150) NULL DEFAULT NULL,
    `customer_item_stock_created_by` BIGINT DEFAULT NULL,
    `customer_item_stock_created_on` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `customer_item_stock_approved_by` BIGINT DEFAULT NULL,
    `customer_item_stock_approved_on` timestamp NULL DEFAULT NULL,
    `customer_item_stock_updated_by` BIGINT DEFAULT NULL,
    `customer_item_stock_updated_on` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    `customer_item_stock_is_editable` ENUM('Yes','No') NOT NULL DEFAULT 'No',
    `customer_item_stock_is_approved` ENUM('Yes','No') NOT NULL DEFAULT 'No',
    `customer_item_stock_is_disabled` ENUM('Yes','No') NOT NULL DEFAULT 'No',
    `customer_item_stock_is_deleted` ENUM('Yes','No') NOT NULL DEFAULT 'No'
);

DROP TABLE IF EXISTS `customer_item_attribute`;
CREATE TABLE `customer_item_attribute` ( --  (color/size etc.)
    `customer_item_attribute_no` BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    `customer_no` BIGINT NOT NULL,
    `customer_item_attribute_name` VARCHAR(100) NOT NULL,
    `customer_item_attribute_general_information` VARCHAR(150) NULL DEFAULT NULL,
    `customer_item_attribute_created_by` BIGINT DEFAULT NULL,
    `customer_item_attribute_created_on` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `customer_item_attribute_approved_by` BIGINT DEFAULT NULL,
    `customer_item_attribute_approved_on` timestamp NULL DEFAULT NULL,
    `customer_item_attribute_updated_by` BIGINT DEFAULT NULL,
    `customer_item_attribute_updated_on` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    `customer_item_attribute_is_editable` ENUM('Yes','No') NOT NULL DEFAULT 'No',
    `customer_item_attribute_is_approved` ENUM('Yes','No') NOT NULL DEFAULT 'No',
    `customer_item_attribute_is_disabled` ENUM('Yes','No') NOT NULL DEFAULT 'No',
    `customer_item_attribute_is_deleted` ENUM('Yes','No') NOT NULL DEFAULT 'No'
);

DROP TABLE IF EXISTS `customer_item_attribute_value`;
CREATE TABLE `customer_item_attribute_value` ( --  (this item -> red)
    `customer_item_attribute_value_no` BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    `customer_no` BIGINT NOT NULL,
    `customer_item_attribute_no` BIGINT NOT NULL,
    `customer_item_attribute_value_value` VARCHAR(100) NOT NULL,
    `customer_item_attribute_value_general_information` VARCHAR(150) NULL DEFAULT NULL,
    `customer_item_attribute_value_created_by` BIGINT DEFAULT NULL,
    `customer_item_attribute_value_created_on` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `customer_item_attribute_value_approved_by` BIGINT DEFAULT NULL,
    `customer_item_attribute_value_approved_on` timestamp NULL DEFAULT NULL,
    `customer_item_attribute_value_updated_by` BIGINT DEFAULT NULL,
    `customer_item_attribute_value_updated_on` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    `customer_item_attribute_value_is_editable` ENUM('Yes','No') NOT NULL DEFAULT 'No',
    `customer_item_attribute_value_is_approved` ENUM('Yes','No') NOT NULL DEFAULT 'No',
    `customer_item_attribute_value_is_disabled` ENUM('Yes','No') NOT NULL DEFAULT 'No',
    `customer_item_attribute_value_is_deleted` ENUM('Yes','No') NOT NULL DEFAULT 'No'
);

DROP TABLE IF EXISTS `customer_item_attribute_link`;
CREATE TABLE `customer_item_attribute_link` (
    `sr_no` BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    `customer_no` BIGINT NOT NULL,
    `customer_item_no` BIGINT NOT NULL,
    `customer_item_attribute_no` BIGINT NOT NULL,
    `created_by` BIGINT DEFAULT NULL,
    `created_on` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `approved_by` BIGINT DEFAULT NULL,
    `approved_on` timestamp NULL DEFAULT NULL,
    `updated_by` BIGINT DEFAULT NULL,
    `updated_on` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    `is_editable` ENUM('Yes','No') NOT NULL DEFAULT 'No',
    `is_approved` ENUM('Yes','No') NOT NULL DEFAULT 'No',
    `is_disabled` ENUM('Yes','No') NOT NULL DEFAULT 'No',
    `is_deleted` ENUM('Yes','No') NOT NULL DEFAULT 'No'
);

DROP TABLE IF EXISTS `customer_website`;
CREATE TABLE `customer_website` (
    `customer_website_no` BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    `allowed_cidr` VARCHAR(250),
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
    `customer_website_created_on` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `customer_website_approved_by` BIGINT DEFAULT NULL,
    `customer_website_approved_on` timestamp NULL DEFAULT NULL,
    `customer_website_updated_by` BIGINT DEFAULT NULL,
    `customer_website_updated_on` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    `customer_website_is_editable` ENUM('Yes','No') NOT NULL DEFAULT 'No',
    `customer_website_is_approved` ENUM('Yes','No') NOT NULL DEFAULT 'No',
    `customer_website_is_disabled` ENUM('Yes','No') NOT NULL DEFAULT 'No',
    `customer_website_is_deleted` ENUM('Yes','No') NOT NULL DEFAULT 'No'
);

DROP TABLE IF EXISTS `customer_website_admin`;
CREATE TABLE `customer_website_admin` (
    `customer_website_admin_no` BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    `allowed_cidr` VARCHAR(250),
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
    `customer_website_admin_created_on` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `customer_website_admin_approved_by` BIGINT DEFAULT NULL,
    `customer_website_admin_approved_on` timestamp NULL DEFAULT NULL,
    `customer_website_admin_updated_by` BIGINT DEFAULT NULL,
    `customer_website_admin_updated_on` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    `customer_website_admin_is_editable` ENUM('Yes','No') NOT NULL DEFAULT 'No',
    `customer_website_admin_is_approved` ENUM('Yes','No') NOT NULL DEFAULT 'No',
    `customer_website_admin_is_disabled` ENUM('Yes','No') NOT NULL DEFAULT 'No',
    `customer_website_admin_is_deleted` ENUM('Yes','No') NOT NULL DEFAULT 'No'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

DROP TABLE IF EXISTS `customer_website_admin_group`;
CREATE TABLE `customer_website_admin_group` (
    `customer_website_admin_group_no` BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    `allowed_cidr` VARCHAR(250),
    `rateLimitMaxRequest` BIGINT DEFAULT NULL,
    `rateLimitMaxRequestWindow` BIGINT DEFAULT NULL,
    `customer_website_admin_group_name` varchar(100) NOT NULL,
    `customer_website_admin_group_general_information` varchar(255) DEFAULT NULL,
    `customer_website_admin_group_created_by` BIGINT DEFAULT NULL,
    `customer_website_admin_group_created_on` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `customer_website_admin_group_approved_by` BIGINT DEFAULT NULL,
    `customer_website_admin_group_approved_on` timestamp NULL DEFAULT NULL,
    `customer_website_admin_group_updated_by` BIGINT DEFAULT NULL,
    `customer_website_admin_group_updated_on` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    `customer_website_admin_group_is_editable` ENUM('Yes','No') NOT NULL DEFAULT 'No',
    `customer_website_admin_group_is_approved` enum('Yes','No') NOT NULL DEFAULT 'No',
    `customer_website_admin_group_is_disabled` enum('Yes','No') NOT NULL DEFAULT 'No',
    `customer_website_admin_group_is_deleted` enum('Yes','No') NOT NULL DEFAULT 'No'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

DROP TABLE IF EXISTS `customer_website_admin_group_link`;
CREATE TABLE `customer_website_admin_group_link` (
    `sr_no` BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    `customer_no` BIGINT NOT NULL,
    `customer_website_no` BIGINT NOT NULL,
    `customer_website_admin_no` BIGINT NOT NULL,
    `customer_website_admin_group_no` BIGINT NOT NULL,
    `created_by` BIGINT DEFAULT NULL,
    `created_on` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `approved_by` BIGINT DEFAULT NULL,
    `approved_on` timestamp NULL DEFAULT NULL,
    `updated_by` BIGINT DEFAULT NULL,
    `updated_on` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    `is_editable` ENUM('Yes','No') NOT NULL DEFAULT 'No',
    `is_approved` enum('Yes','No') NOT NULL DEFAULT 'No',
    `is_disabled` enum('Yes','No') NOT NULL DEFAULT 'No',
    `is_deleted` enum('Yes','No') NOT NULL DEFAULT 'No'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

------------- Tables Customer level (Customer Entered Data) ------------

------------- Tables Website level (Website Entered Data) --------------
DROP TABLE IF EXISTS `website_item`;
CREATE TABLE `customer_item` (
    `website_item_no` BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    `customer_no` BIGINT NOT NULL,
    `customer_manufacturer_no` BIGINT NOT NULL,
    `customer_brand_no` BIGINT NOT NULL,
    `website_no` BIGINT NOT NULL,
    `customer_item_no` BIGINT NOT NULL,
    `website_item_general_information` VARCHAR(150) NULL DEFAULT NULL,
    `website_item_created_by` BIGINT DEFAULT NULL,
    `website_item_created_on` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `website_item_approved_by` BIGINT DEFAULT NULL,
    `website_item_approved_on` timestamp NULL DEFAULT NULL,
    `website_item_updated_by` BIGINT DEFAULT NULL,
    `website_item_updated_on` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    `website_item_is_editable` ENUM('Yes','No') NOT NULL DEFAULT 'No',
    `website_item_is_approved` ENUM('Yes','No') NOT NULL DEFAULT 'No',
    `website_item_is_disabled` ENUM('Yes','No') NOT NULL DEFAULT 'No',
    `website_item_is_deleted` ENUM('Yes','No') NOT NULL DEFAULT 'No'
);

-- @customer level
DROP TABLE IF EXISTS `website_generic_item`;
CREATE TABLE `website_generic_item` (
    `website_generic_item_no` BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    `customer_no` BIGINT NOT NULL,
    `customer_manufacturer_no` BIGINT NOT NULL,
    `customer_brand_no` BIGINT NOT NULL,
    `website_no` BIGINT NOT NULL,
    `customer_generic_item_no` NULL DEFAULT NULL,
    `website_generic_item_general_information` VARCHAR(150) NULL DEFAULT NULL,
    `website_generic_item_created_by` BIGINT DEFAULT NULL,
    `website_generic_item_created_on` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `website_generic_item_approved_by` BIGINT DEFAULT NULL,
    `website_generic_item_approved_on` timestamp NULL DEFAULT NULL,
    `website_generic_item_updated_by` BIGINT DEFAULT NULL,
    `website_generic_item_updated_on` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    `website_generic_item_is_editable` ENUM('Yes','No') NOT NULL DEFAULT 'No',
    `website_generic_item_is_approved` ENUM('Yes','No') NOT NULL DEFAULT 'No',
    `website_generic_item_is_disabled` ENUM('Yes','No') NOT NULL DEFAULT 'No',
    `website_generic_item_is_deleted` ENUM('Yes','No') NOT NULL DEFAULT 'No'
);
------------- Tables Website level (Website Entered Data) --------------
