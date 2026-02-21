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


------------- Tables for logging --------------
-- (Only for authorised requests)
DROP TABLE IF EXISTS `sahar.guru`.`requests`;
CREATE TABLE `sahar.guru`.`requests` (
    `request_no` BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    `for` ENUM('Customer','Website') NOT NULL,
    `for_no` BIGINT NOT NULL,
    `route_no_for` BIGINT NOT NULL,
    `request_method` ENUM('GET','POST','PUT','PATCH','DELETE') NOT NULL,
    `request_payload_json` JSON NOT NULL,
    `request_operator_no` BIGINT NOT NULL,
    `request_operated_on` DATETIME DEFAULT CURRENT_TIMESTAMP,
    `request_operator_ip` VARCHAR(25) NOT NULL
);

-- (Only for authorised requests)
DROP TABLE IF EXISTS `sahar.guru`.`dml_logs`;
CREATE TABLE `sahar.guru`.`dml_logs` (
    `request_no` BIGINT NOT NULL,
    `for` ENUM('Customer','Website') NOT NULL,
    `for_no` BIGINT NOT NULL,
    `route_no_for` BIGINT NOT NULL,
    `operated_payload_json` JSON NOT NULL,
    `operated_by` ENUM('Admin','Client','Web') NOT NULL,
    `operator_no` BIGINT NULL DEFAULT NULL,
    `operated_on` DATETIME DEFAULT CURRENT_TIMESTAMP,
    `operator_ip` VARCHAR(25) NOT NULL
);

-- (Only for authorised requests)
DROP TABLE IF EXISTS `sahar.guru`.`dml_error_logs`;
CREATE TABLE `sahar.guru`.`dml_error_logs` (
    `request_no` BIGINT NOT NULL,
    `for` ENUM('Customer','Website') NOT NULL,
    `for_no` BIGINT NOT NULL,
    `route_no_for` BIGINT NOT NULL,
    `sub_module_no_for` BIGINT NOT NULL,
    `operated_config_json` JSON NOT NULL,
    `operated_payload_json` JSON NOT NULL,
    `exception_json` JSON NOT NULL,
    `operated_by` ENUM('Admin','Client','Web') NOT NULL,
    `operator_no` BIGINT NULL DEFAULT NULL,
    `operated_on` DATETIME DEFAULT CURRENT_TIMESTAMP,
    `operator_ip` VARCHAR(25) NOT NULL
);
------------- Tables for logging --------------

------------- Tables @product level --------------
-- @product level -- 3 groups (Vendors/Customers/Wensites)
DROP TABLE IF EXISTS `groups`;
CREATE TABLE `customer_groups` (
    `group_no` BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    `group_name` varchar(100) NOT NULL,
    `allowed_cidrs` VARCHAR(250),
    `rateLimitMaxRequests` BIGINT DEFAULT NULL,
    `rateLimitMaxRequestsWindow` BIGINT DEFAULT NULL,
    `customer_group_general_information` varchar(255) DEFAULT NULL,
    `created_by` BIGINT DEFAULT NULL,
    `created_on` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `approved_by` BIGINT DEFAULT NULL,
    `approved_on` timestamp NULL DEFAULT NULL,
    `updated_by` BIGINT DEFAULT NULL,
    `updated_on` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    `is_approved` enum('Yes','No') NOT NULL DEFAULT 'No',
    `is_disabled` enum('Yes','No') NOT NULL DEFAULT 'No',
    `is_deleted` enum('Yes','No') NOT NULL DEFAULT 'No'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- @product level
DROP TABLE IF EXISTS `sahar.guru`.`routes`;
CREATE TABLE `sahar.guru`.`routes` (
    `route_no` BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    `route_code` VARCHAR(15) NOT NULL,
    `route_name` VARCHAR(100) NOT NULL,
    `allowed_cidrs` VARCHAR(250),
    `rateLimitMaxRequests` BIGINT DEFAULT NULL,
    `rateLimitMaxRequestsWindow` BIGINT DEFAULT NULL,
    `route_general_information` VARCHAR(150) NULL DEFAULT NULL,
    `is_editable` ENUM('Yes','No') NOT NULL DEFAULT 'Yes',
    `is_approved` ENUM('Yes','No') NOT NULL DEFAULT 'No',
    `is_disabled` ENUM('Yes','No') NOT NULL DEFAULT 'No',
    `is_deleted` ENUM('Yes','No') NOT NULL DEFAULT 'No'
);

-- @product level
DROP TABLE IF EXISTS `sahar.guru`.`sub_modules`;
CREATE TABLE `sahar.guru`.`sub_modules` (
    `sub_module_no` BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    `route_no` VARCHAR(15) NULL DEFAULT NULL,
    `sub_module_code` VARCHAR(15) NOT NULL,
    `sub_module_name` VARCHAR(100) NOT NULL,
    `sub_module_general_information` VARCHAR(150) NULL DEFAULT NULL,
    `is_editable` ENUM('Yes','No') NOT NULL DEFAULT 'No',
    `is_approved` ENUM('Yes','No') NOT NULL DEFAULT 'Yes',
    `is_disabled` ENUM('Yes','No') NOT NULL DEFAULT 'No',
    `is_deleted` ENUM('Yes','No') NOT NULL DEFAULT 'No'
);

-- @product level
DROP TABLE IF EXISTS `sahar.guru`.`customers`;
CREATE TABLE `sahar.guru`.`customers` (
    `customer_no` BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    `customer_group_no` BIGINT NOT NULL,
    `username` VARCHAR(100) NOT NULL,
    `password_hash` VARCHAR(150) NOT NULL,
    `user_token` VARCHAR(100) NULL DEFAULT NULL,
    `user_token_ts` DATETIME NULL DEFAULT NULL,
    `allowed_cidrs` VARCHAR(250),
    `rateLimitMaxRequests` BIGINT DEFAULT NULL,
    `rateLimitMaxRequestsWindow` BIGINT DEFAULT NULL,
    `contact_name` VARCHAR(100) NOT NULL,
    `contact_person` VARCHAR(100) NOT NULL,
    `contact_firm` VARCHAR(100) NOT NULL,
    `contact_department` VARCHAR(100) NOT NULL,
    `contact_email_address` VARCHAR(100) NOT NULL,
    `contact_phone` VARCHAR(100) NOT NULL,
    `contact_fax` VARCHAR(100) NOT NULL,
    `contact_mailing_address` VARCHAR(100) NOT NULL,
    `contact_city` VARCHAR(100) NOT NULL,
    `contact_state` VARCHAR(100) NOT NULL,
    `contact_zip` VARCHAR(100) NOT NULL,
    `contact_country` VARCHAR(100) NOT NULL,
    `general_information` VARCHAR(150) NULL DEFAULT NULL,
    `is_editable` ENUM('Yes','No') NOT NULL DEFAULT 'Yes',
    `is_approved` ENUM('Yes','No') NOT NULL DEFAULT 'No',
    `is_disabled` ENUM('Yes','No') NOT NULL DEFAULT 'No',
    `is_deleted` ENUM('Yes','No') NOT NULL DEFAULT 'No'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

------------- Tables @product level --------------

------------- Tables @vendor level --------------
-- @vendor level
DROP TABLE IF EXISTS `sahar.guru`.`vendors`;
CREATE TABLE `sahar.guru`.`vendors` (
    `vendor_no` BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    `customer_manufacturer_no` BIGINT NOT NULL,
    `customer_brand_no` BIGINT NOT NULL,
    `customer_no` BIGINT NOT NULL,
    `vendor_code` VARCHAR(15) NOT NULL,
    `vendor_name` VARCHAR(100) NOT NULL,
    `vendor_web_link` VARCHAR(100) NOT NULL,
    `vendor_general_information` VARCHAR(150) NOT NULL,
    `vendor_contact_name` VARCHAR(100) NOT NULL,
    `vendor_contact_person` VARCHAR(100) NOT NULL,
    `vendor_contact_firm` VARCHAR(100) NOT NULL,
    `vendor_contact_department` VARCHAR(100) NOT NULL,
    `vendor_contact_email_address` VARCHAR(100) NOT NULL,
    `vendor_contact_phone` VARCHAR(100) NOT NULL,
    `vendor_contact_fax` VARCHAR(100) NOT NULL,
    `vendor_contact_mailing_address` VARCHAR(100) NOT NULL,
    `vendor_contact_city` VARCHAR(100) NOT NULL,
    `vendor_contact_state` VARCHAR(100) NOT NULL,
    `vendor_contact_zip` VARCHAR(100) NOT NULL,
    `vendor_contact_country` VARCHAR(100) NOT NULL,
    `general_information` VARCHAR(150) NULL DEFAULT NULL,
    `is_editable` ENUM('Yes','No') NOT NULL DEFAULT 'Yes',
    `is_approved` ENUM('Yes','No') NOT NULL DEFAULT 'No',
    `is_disabled` ENUM('Yes','No') NOT NULL DEFAULT 'No',
    `is_deleted` ENUM('Yes','No') NOT NULL DEFAULT 'No'
);

-- @vendor level
DROP TABLE IF EXISTS `sahar.guru`.`vendor_warehouses`;
CREATE TABLE `sahar.guru`.`vendor_warehouse` (
    `vendor_warehouse_no` BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    `vendor_no` BIGINT NOT NULL,
    `vendor_warehouse_code` VARCHAR(15) NOT NULL,
    `vendor_warehouse_name` VARCHAR(100) NOT NULL,
    `vendor_warehouse_general_information` VARCHAR(150) NULL DEFAULT NULL,
    `is_editable` ENUM('Yes','No') NOT NULL DEFAULT 'Yes',
    `is_approved` ENUM('Yes','No') NOT NULL DEFAULT 'No',
    `is_disabled` ENUM('Yes','No') NOT NULL DEFAULT 'No',
    `is_deleted` ENUM('Yes','No') NOT NULL DEFAULT 'No'
);

-- @vendor level
DROP TABLE IF EXISTS `sahar.guru`.`vendor_items`;
CREATE TABLE `sahar.guru`.`vendor_items` (
    `vendor_item_no` BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    `vendor_no` BIGINT NOT NULL,
    `vendor_warehouse_no` BIGINT NOT NULL,
    `item_no` BIGINT NOT NULL,
    `uom_no` BIGINT NOT NULL,
    -- `COST` VARCHAR(15) NOT NULL,
    -- `LEAD TIME IN DAYS` VARCHAR(15) NOT NULL,
    `vendor_item_general_information` VARCHAR(150) NULL DEFAULT NULL,
    `is_editable` ENUM('Yes','No') NOT NULL DEFAULT 'Yes',
    `is_approved` ENUM('Yes','No') NOT NULL DEFAULT 'No',
    `is_disabled` ENUM('Yes','No') NOT NULL DEFAULT 'No',
    `is_deleted` ENUM('Yes','No') NOT NULL DEFAULT 'No'
);

-- @vendor level
DROP TABLE IF EXISTS `sahar.guru`.`uom`; -- (Unit of MeasureUnit)
CREATE TABLE `sahar.guru`.`item_uom` (
    `uom_no` BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    `vendor_no` BIGINT NOT NULL,
    `uom_code` VARCHAR(15) NOT NULL,
    `uom_name` VARCHAR(100) NOT NULL,
    `uom_general_information` VARCHAR(150) NULL DEFAULT NULL,
    `is_editable` ENUM('Yes','No') NOT NULL DEFAULT 'Yes',
    `is_approved` ENUM('Yes','No') NOT NULL DEFAULT 'No',
    `is_disabled` ENUM('Yes','No') NOT NULL DEFAULT 'No',
    `is_deleted` ENUM('Yes','No') NOT NULL DEFAULT 'No'
);

-- @vendor level
DROP TABLE IF EXISTS `sahar.guru`.`uom_conversion`;
CREATE TABLE `sahar.guru`.`item_uom_conversion` (
    `uom_conversion_no` BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    `vendor_no` BIGINT NOT NULL,
    `from_uom_no` BIGINT NOT NULL,
    `to_uom_no` BIGINT NOT NULL,
    `conversion_rule` VARCHAR(100) NOT NULL,
    `uom_conversion_general_information` VARCHAR(150) NULL DEFAULT NULL,
    `is_editable` ENUM('Yes','No') NOT NULL DEFAULT 'Yes',
    `is_approved` ENUM('Yes','No') NOT NULL DEFAULT 'No',
    `is_disabled` ENUM('Yes','No') NOT NULL DEFAULT 'No',
    `is_deleted` ENUM('Yes','No') NOT NULL DEFAULT 'No'
);
------------- Tables @vendor level --------------

------------- Tables @vendor/@customer level --------------
-- @vendor/@customer level
DROP TABLE IF EXISTS `sahar.guru`.`categories`;
CREATE TABLE `sahar.guru`.`categories` (
    `category_no` BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    `customer_no` BIGINT NOT NULL,
    `category_code` VARCHAR(15) NOT NULL,
    `category_name` VARCHAR(100) NOT NULL,
    `category_web_link` VARCHAR(100) NOT NULL,
    `category_general_information` VARCHAR(150) NOT NULL,
    `is_editable` ENUM('Yes','No') NOT NULL DEFAULT 'Yes',
    `is_approved` ENUM('Yes','No') NOT NULL DEFAULT 'No',
    `is_disabled` ENUM('Yes','No') NOT NULL DEFAULT 'No',
    `is_deleted` ENUM('Yes','No') NOT NULL DEFAULT 'No'
);

-- @vendor/@customer level
DROP TABLE IF EXISTS `sahar.guru`.`manufacturers`;
CREATE TABLE `sahar.guru`.`manufacturers` (
    `manufacturer_no` BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    `customer_no` BIGINT NOT NULL,
    `manufacturer_code` VARCHAR(15) NOT NULL,
    `manufacturer_name` VARCHAR(100) NOT NULL,
    `manufacturer_web_link` VARCHAR(100) NOT NULL,
    `manufacturer_contact_name` VARCHAR(100) NOT NULL,
    `manufacturer_contact_person` VARCHAR(100) NOT NULL,
    `manufacturer_contact_firm` VARCHAR(100) NOT NULL,
    `manufacturer_contact_department` VARCHAR(100) NOT NULL,
    `manufacturer_contact_email_address` VARCHAR(100) NOT NULL,
    `manufacturer_contact_phone` VARCHAR(100) NOT NULL,
    `manufacturer_contact_fax` VARCHAR(100) NOT NULL,
    `manufacturer_contact_mailing_address` VARCHAR(100) NOT NULL,
    `manufacturer_contact_city` VARCHAR(100) NOT NULL,
    `manufacturer_contact_state` VARCHAR(100) NOT NULL,
    `manufacturer_contact_zip` VARCHAR(100) NOT NULL,
    `manufacturer_contact_country` VARCHAR(100) NOT NULL,
    `manufacturer_general_information` VARCHAR(150) NULL DEFAULT NULL,
    `is_editable` ENUM('Yes','No') NOT NULL DEFAULT 'Yes',
    `is_approved` ENUM('Yes','No') NOT NULL DEFAULT 'No',
    `is_disabled` ENUM('Yes','No') NOT NULL DEFAULT 'No',
    `is_deleted` ENUM('Yes','No') NOT NULL DEFAULT 'No'
);

-- @vendor/@customer level
DROP TABLE IF EXISTS `sahar.guru`.`brands`;
CREATE TABLE `sahar.guru`.`brands` (
    `brand_no` BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    `customer_no` BIGINT NOT NULL,
    `brand_code` VARCHAR(15) NOT NULL,
    `brand_name` VARCHAR(100) NOT NULL,
    `brand_web_link` VARCHAR(100) NOT NULL,
    `brand_contact_name` VARCHAR(100) NOT NULL,
    `brand_contact_person` VARCHAR(100) NOT NULL,
    `brand_contact_firm` VARCHAR(100) NOT NULL,
    `brand_contact_department` VARCHAR(100) NOT NULL,
    `brand_contact_email_address` VARCHAR(100) NOT NULL,
    `brand_contact_phone` VARCHAR(100) NOT NULL,
    `brand_contact_fax` VARCHAR(100) NOT NULL,
    `brand_contact_mailing_address` VARCHAR(100) NOT NULL,
    `brand_contact_city` VARCHAR(100) NOT NULL,
    `brand_contact_state` VARCHAR(100) NOT NULL,
    `brand_contact_zip` VARCHAR(100) NOT NULL,
    `brand_contact_country` VARCHAR(100) NOT NULL,
    `brand_general_information` VARCHAR(150) NULL DEFAULT NULL,
    `is_editable` ENUM('Yes','No') NOT NULL DEFAULT 'Yes',
    `is_approved` ENUM('Yes','No') NOT NULL DEFAULT 'No',
    `is_disabled` ENUM('Yes','No') NOT NULL DEFAULT 'No',
    `is_deleted` ENUM('Yes','No') NOT NULL DEFAULT 'No'
);

-- @vendor/@customer level
DROP TABLE IF EXISTS `sahar.guru`.`generic_items`;
CREATE TABLE `sahar.guru`.`generic_items` (
    `generic_item_no` BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    `customer_no` BIGINT NOT NULL,
    `generic_items_name` VARCHAR(15) NOT NULL,
    `generic_item_general_information` VARCHAR(150) NULL DEFAULT NULL,
    `is_editable` ENUM('Yes','No') NOT NULL DEFAULT 'Yes',
    `is_approved` ENUM('Yes','No') NOT NULL DEFAULT 'No',
    `is_disabled` ENUM('Yes','No') NOT NULL DEFAULT 'No',
    `is_deleted` ENUM('Yes','No') NOT NULL DEFAULT 'No'
);

-- @vendor/@customer level
DROP TABLE IF EXISTS `sahar.guru`.`items`;
CREATE TABLE `sahar.guru`.`items` (
    `item_no` BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    `customer_no` BIGINT NOT NULL,
    `item_code` VARCHAR(15) NOT NULL,
    `item_name` VARCHAR(250) NOT NULL,
    `item_category_no` BIGINT NOT NULL,
    `item_length` BIGINT NOT NULL,
    `item_breadth` BIGINT NOT NULL,
    `item_height` BIGINT NOT NULL,
    `item_version` VARCHAR(250) NOT NULL,
    `item_model` VARCHAR(250) NOT NULL,
    `item_type` VARCHAR(250) NOT NULL,
    `item_is_fragile` ENUM('Yes','No') NOT NULL,
    `item_price` FLOAT NOT NULL DEFAULT 0, -- (current rate)
    `default_uom` VARCHAR(250) NULL DEFAULT NULL,
    `default_sku` VARCHAR(250) NULL DEFAULT NULL, --- (stock keeping unit)
    `average_cost` VARCHAR(250) NULL DEFAULT NULL,
    `single_unit_item_code` VARCHAR(250) NULL DEFAULT NULL, --  (for packs)
    `item_photography_link` JSON NULL DEFAULT NULL, --  (general not specific)
    `item_warranty_terms` TINYTEXT NULL DEFAULT NULL, --  (general not specific)
    `item_general_information` TINYTEXT NULL DEFAULT NULL,
    `item_remarks` TINYTEXT NULL DEFAULT NULL,
    `item_markup` TINYTEXT NULL DEFAULT NULL,
    `allow_others_to_inherit` ENUM('Yes','No') NOT NULL DEFAULT 'Yes',
    `is_editable` ENUM('Yes','No') NOT NULL DEFAULT 'Yes',
    `is_approved` ENUM('Yes','No') NOT NULL DEFAULT 'No',
    `is_disabled` ENUM('Yes','No') NOT NULL DEFAULT 'No',
    `is_deleted` ENUM('Yes','No') NOT NULL DEFAULT 'No'
);

-- @vendor/@customer level
DROP TABLE IF EXISTS `sahar.guru`.`item_dimensions`;
CREATE TABLE `sahar.guru`.`item_dimensions` (
    `item_dimension_no` BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    `item_no` BIGINT NOT NULL,
    `item_length` BIGINT NOT NULL,
    `item_breadth` BIGINT NOT NULL,
    `item_height` BIGINT NOT NULL,
    `Item_condition` ENUM('New','Operational','Requires Maintenance','Out of Service') NOT NULL,
    `item_manufacturing_date` BIGINT NOT NULL,
    `item_warrenty_or_expiry_date` BIGINT NOT NULL,
    `item_unit_cost` BIGINT NOT NULL,
    `item_retail_price` BIGINT NOT NULL,
    `item_serial_number` BIGINT NOT NULL,
    `item_usage_hours` BIGINT NOT NULL,
    `item_fuel_type` ENUM('Gasoline','Diesel','Propane','EV','LPG','CNG') NOT NULL,
    `item_purchase_date` BIGINT NOT NULL,
    `item_initial_purchase_value` BIGINT NOT NULL,
    `item_down_payment` BIGINT NOT NULL,
    `item_service_years_remaining` BIGINT NOT NULL,
    `item_current_market_value` BIGINT NOT NULL,
    `item_expected_residual_value` BIGINT NOT NULL,
    `item_monthly_operationg_costs` BIGINT NOT NULL,
    `item_monthly_straight_line_depreciation` BIGINT NOT NULL,
    `item_annual_straight_line_depreciation` BIGINT NOT NULL,
    `item_starting_inventory` BIGINT NOT NULL,
    `item_low_stock_threshold` BIGINT NOT NULL,
    `item_current_stock_level` BIGINT NOT NULL,
    `is_editable` ENUM('Yes','No') NOT NULL DEFAULT 'Yes',
    `is_approved` ENUM('Yes','No') NOT NULL DEFAULT 'No',
    `is_disabled` ENUM('Yes','No') NOT NULL DEFAULT 'No',
    `is_deleted` ENUM('Yes','No') NOT NULL DEFAULT 'No'
);

-- @vendor/@customer level
DROP TABLE IF EXISTS `sahar.guru`.`attribute`;
CREATE TABLE `sahar.guru`.`attribute_types` ( --  (color/size etc.)
    `attribute_no` BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    `customer_no` BIGINT NOT NULL,
    `attribute_name` VARCHAR(100) NOT NULL,
    `general_information` VARCHAR(150) NULL DEFAULT NULL,
    `is_editable` ENUM('Yes','No') NOT NULL DEFAULT 'Yes',
    `is_approved` ENUM('Yes','No') NOT NULL DEFAULT 'No',
    `is_disabled` ENUM('Yes','No') NOT NULL DEFAULT 'No',
    `is_deleted` ENUM('Yes','No') NOT NULL DEFAULT 'No'
);

-- @vendor/@customer level
DROP TABLE IF EXISTS `sahar.guru`.`attribute_data`;
CREATE TABLE `sahar.guru`.`attribute_data` ( --  (this item -> red)
    `attribute_data_no` BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    `customer_no` BIGINT NOT NULL,
    `attribute_no` BIGINT NOT NULL,
    `attribute_value` VARCHAR(100) NOT NULL,
    `general_information` VARCHAR(150) NULL DEFAULT NULL,
    `is_editable` ENUM('Yes','No') NOT NULL DEFAULT 'Yes',
    `is_approved` ENUM('Yes','No') NOT NULL DEFAULT 'No',
    `is_disabled` ENUM('Yes','No') NOT NULL DEFAULT 'No',
    `is_deleted` ENUM('Yes','No') NOT NULL DEFAULT 'No'
);

-- @vendor/@customer level
DROP TABLE IF EXISTS `sahar.guru`.`item_attribute`;
CREATE TABLE `sahar.guru`.`item_attribute` (
    `item_attribute_no` BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    `customer_no` BIGINT NOT NULL,
    `item_no` BIGINT NOT NULL,
    `attribute_no` BIGINT NOT NULL,
    `attribute_data_no` BIGINT NOT NULL,
    `is_editable` ENUM('Yes','No') NOT NULL DEFAULT 'Yes',
    `is_approved` ENUM('Yes','No') NOT NULL DEFAULT 'No',
    `is_disabled` ENUM('Yes','No') NOT NULL DEFAULT 'No',
    `is_deleted` ENUM('Yes','No') NOT NULL DEFAULT 'No'
);
------------- Tables @vendor/@customer level --------------

------------- Tables @customer level --------------
-- @customer level
DROP TABLE IF EXISTS `sahar.guru`.`item_stocks`;
CREATE TABLE `sahar.guru`.`item_stocks` (
    `item_stock_no` BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    `customer_no` BIGINT NOT NULL,
    `website_no` BIGINT NOT NULL,
    `customer_item_no` BIGINT NOT NULL,
    `warehouse_no` BIGINT NOT NULL,
    `zone_no` BIGINT NOT NULL,
    `level_no` BIGINT NOT NULL,
    `rack_no` BIGINT NOT NULL,
    `etc_nos` BIGINT NOT NULL, -- warehouse_no, zone_no, level_no, rack_no etc.
    `lot_information` BIGINT NOT NULL, --  (lot_no)
    `lot_or_batch_code` BIGINT NOT NULL,
    `date_manufactured` DATE NOT NULL,
    `date_expiry` DATE NOT NULL,
    `warranty_terms` TINYTEXT NULL DEFAULT NULL, --  (general not specific)
    `from_date` DATETIME NOT NULL,
    `item_price` FLOAT NULL DEFAULT NULL, -- (current rate)
    `quantity_in_hand` BIGINT NOT NULL,
    `item_attribute_data_no` BIGINT NOT NULL, --   (if applicable) [we have 4 red color items etc.]
    `general_information` VARCHAR(150) NULL DEFAULT NULL,
    `is_editable` ENUM('Yes','No') NOT NULL DEFAULT 'Yes',
    `is_approved` ENUM('Yes','No') NOT NULL DEFAULT 'No',
    `is_disabled` ENUM('Yes','No') NOT NULL DEFAULT 'No',
    `is_deleted` ENUM('Yes','No') NOT NULL DEFAULT 'No'
);

-- @customer level
DROP TABLE IF EXISTS `sahar.guru`.`websites`;
CREATE TABLE `sahar.guru`.`websites` (
    `website_no` BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    `customer_no` BIGINT NOT NULL,
    `website_code` VARCHAR(15) NOT NULL,
    `website_name` VARCHAR(100) NOT NULL,
    `allowed_cidrs` VARCHAR(250),
    `rateLimitMaxRequests` BIGINT DEFAULT NULL,
    `rateLimitMaxRequestsWindow` BIGINT DEFAULT NULL,
    `website_contact_name` VARCHAR(100) NOT NULL,
    `website_contact_person` VARCHAR(100) NOT NULL,
    `website_contact_firm` VARCHAR(100) NOT NULL,
    `website_contact_department` VARCHAR(100) NOT NULL,
    `website_contact_email_address` VARCHAR(100) NOT NULL,
    `website_contact_phone` VARCHAR(100) NOT NULL,
    `website_contact_fax` VARCHAR(100) NOT NULL,
    `website_contact_mailing_address` VARCHAR(100) NOT NULL,
    `website_contact_city` VARCHAR(100) NOT NULL,
    `website_contact_state` VARCHAR(100) NOT NULL,
    `website_contact_zip` VARCHAR(100) NOT NULL,
    `website_contact_country` VARCHAR(100) NOT NULL,
    `website_general_information` VARCHAR(150) NULL DEFAULT NULL,
    `is_editable` ENUM('Yes','No') NOT NULL DEFAULT 'Yes',
    `is_approved` ENUM('Yes','No') NOT NULL DEFAULT 'No',
    `is_disabled` ENUM('Yes','No') NOT NULL DEFAULT 'No',
    `is_deleted` ENUM('Yes','No') NOT NULL DEFAULT 'No'
);

-- @customer level
DROP TABLE IF EXISTS `sahar.guru`.`websites_admins`;
CREATE TABLE `sahar.guru`.`websites_admins` (
    `website_admin_no` BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    `website_no` BIGINT NOT NULL,
    `website_group_no` BIGINT NOT NULL,
    `username` VARCHAR(100) NOT NULL,
    `password_hash` VARCHAR(150) NOT NULL,
    `user_token` VARCHAR(100) NULL DEFAULT NULL,
    `user_token_ts` DATETIME NULL DEFAULT NULL,
    `allowed_cidrs` VARCHAR(250),
    `rateLimitMaxRequests` BIGINT DEFAULT NULL,
    `rateLimitMaxRequestsWindow` BIGINT DEFAULT NULL,
    `contact_name` VARCHAR(100) NOT NULL,
    `contact_person` VARCHAR(100) NOT NULL,
    `contact_firm` VARCHAR(100) NOT NULL,
    `contact_department` VARCHAR(100) NOT NULL,
    `contact_email_address` VARCHAR(100) NOT NULL,
    `contact_phone` VARCHAR(100) NOT NULL,
    `contact_fax` VARCHAR(100) NOT NULL,
    `contact_mailing_address` VARCHAR(100) NOT NULL,
    `contact_city` VARCHAR(100) NOT NULL,
    `contact_state` VARCHAR(100) NOT NULL,
    `contact_zip` VARCHAR(100) NOT NULL,
    `contact_country` VARCHAR(100) NOT NULL,
    `general_information` VARCHAR(150) NULL DEFAULT NULL,
    `is_editable` ENUM('Yes','No') NOT NULL DEFAULT 'Yes',
    `is_approved` ENUM('Yes','No') NOT NULL DEFAULT 'No',
    `is_disabled` ENUM('Yes','No') NOT NULL DEFAULT 'No',
    `is_deleted` ENUM('Yes','No') NOT NULL DEFAULT 'No'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

------------- Tables @customer level --------------

------------- Mapping for @customer --------------
-- @customer level
DROP TABLE IF EXISTS `sahar.guru`.`customer_groups`;
CREATE TABLE `sahar.guru`.`customer_groups` (
    `customer_group_no` BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    `customer_no` BIGINT NOT NULL,
    `group_no` VARCHAR(15) NOT NULL,
    `is_editable` ENUM('Yes','No') NOT NULL DEFAULT 'No',
    `is_approved` ENUM('Yes','No') NOT NULL DEFAULT 'Yes',
    `is_disabled` ENUM('Yes','No') NOT NULL DEFAULT 'No',
    `is_deleted` ENUM('Yes','No') NOT NULL DEFAULT 'No'
);

-- @customer level
DROP TABLE IF EXISTS `sahar.guru`.`customer_routes`;
CREATE TABLE `sahar.guru`.`customer_routes` (
    `customer_route_no` BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    `customer_no` BIGINT NOT NULL,
    `route_no` VARCHAR(15) NOT NULL,
    `is_editable` ENUM('Yes','No') NOT NULL DEFAULT 'No',
    `is_approved` ENUM('Yes','No') NOT NULL DEFAULT 'Yes',
    `is_disabled` ENUM('Yes','No') NOT NULL DEFAULT 'No',
    `is_deleted` ENUM('Yes','No') NOT NULL DEFAULT 'No'
);

-- @customer level
DROP TABLE IF EXISTS `sahar.guru`.`customer_manufacturers`;
CREATE TABLE `sahar.guru`.`customer_manufacturers` (
    `customer_manufacturer_no` BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    `customer_no` BIGINT NOT NULL,
    `manufacturer_no` BIGINT NOT NULL,
    `is_editable` ENUM('Yes','No') NOT NULL DEFAULT 'Yes',
    `is_approved` ENUM('Yes','No') NOT NULL DEFAULT 'No',
    `is_disabled` ENUM('Yes','No') NOT NULL DEFAULT 'No',
    `is_deleted` ENUM('Yes','No') NOT NULL DEFAULT 'No'
);

-- @customer level
DROP TABLE IF EXISTS `sahar.guru`.`customer_brands`;
CREATE TABLE `sahar.guru`.`customer_brands` (
    `customer_brand_no` BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    `customer_no` BIGINT NOT NULL,
    `brand_no` BIGINT NOT NULL,
    `is_editable` ENUM('Yes','No') NOT NULL DEFAULT 'Yes',
    `is_approved` ENUM('Yes','No') NOT NULL DEFAULT 'No',
    `is_disabled` ENUM('Yes','No') NOT NULL DEFAULT 'No',
    `is_deleted` ENUM('Yes','No') NOT NULL DEFAULT 'No'
);
------------- Mapping for @customer --------------

------------- Mapping for @website --------------
-- @customer level
DROP TABLE IF EXISTS `sahar.guru`.`website_groups`;
CREATE TABLE `sahar.guru`.`website_groups` (
    `website_group_no` BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    `website_no` BIGINT NOT NULL,
    `group_no` VARCHAR(15) NOT NULL,
    `is_editable` ENUM('Yes','No') NOT NULL DEFAULT 'No',
    `is_approved` ENUM('Yes','No') NOT NULL DEFAULT 'Yes',
    `is_disabled` ENUM('Yes','No') NOT NULL DEFAULT 'No',
    `is_deleted` ENUM('Yes','No') NOT NULL DEFAULT 'No'
);

-- @customer level
DROP TABLE IF EXISTS `sahar.guru`.`website_routes`;
CREATE TABLE `sahar.guru`.`website_routes` (
    `website_route_no` BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    `website_no` BIGINT NOT NULL,
    `route_no` VARCHAR(15) NOT NULL,
    `is_editable` ENUM('Yes','No') NOT NULL DEFAULT 'No',
    `is_approved` ENUM('Yes','No') NOT NULL DEFAULT 'Yes',
    `is_disabled` ENUM('Yes','No') NOT NULL DEFAULT 'No',
    `is_deleted` ENUM('Yes','No') NOT NULL DEFAULT 'No'
);

-- @customer level
DROP TABLE IF EXISTS `sahar.guru`.`website_items`;
CREATE TABLE `sahar.guru`.`customer_items` (
    `website_items_no` BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    `website_no` BIGINT NOT NULL,
    `item_no` BIGINT NOT NULL,
    `customer_brand_no` BIGINT NOT NULL,
    `customer_manufacturer_no` BIGINT NOT NULL,
    `generic_no` BIGINT NOT NULL,
    `model_or_part_no` BIGINT NOT NULL,
    `general_information` VARCHAR(150) NULL DEFAULT NULL,
    `is_editable` ENUM('Yes','No') NOT NULL DEFAULT 'Yes',
    `is_approved` ENUM('Yes','No') NOT NULL DEFAULT 'No',
    `is_disabled` ENUM('Yes','No') NOT NULL DEFAULT 'No',
    `is_deleted` ENUM('Yes','No') NOT NULL DEFAULT 'No'
);

-- @customer level
DROP TABLE IF EXISTS `sahar.guru`.`website_generic_items`;
CREATE TABLE `sahar.guru`.`website_generic_items` (
    `website_generic_item_no` BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    `website_no` BIGINT NOT NULL,
    `generic_item_no` BIGINT NOT NULL,
    `is_editable` ENUM('Yes','No') NOT NULL DEFAULT 'Yes',
    `is_approved` ENUM('Yes','No') NOT NULL DEFAULT 'No',
    `is_disabled` ENUM('Yes','No') NOT NULL DEFAULT 'No',
    `is_deleted` ENUM('Yes','No') NOT NULL DEFAULT 'No'
);
------------- Mapping for @website --------------

