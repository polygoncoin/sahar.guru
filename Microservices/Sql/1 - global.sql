-- ----------- Tables Product level --------------
DROP TABLE IF EXISTS `global_counter`;
CREATE TABLE `global_counter` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    PRIMARY KEY (`id`)
) ENGINE = InnoDB;

DROP TABLE IF EXISTS `api_cache`;
CREATE TABLE `api_cache` (
    `key` CHAR(128) NOT NULL,
    `value` BLOB,
    UNIQUE INDEX api_cache_key (`key`)
) ENGINE=InnoDB;
-- ----------- Tables Product level --------------
