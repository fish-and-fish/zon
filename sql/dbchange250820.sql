ALTER TABLE `ruoyi`.`customer`
    MODIFY COLUMN `attachment` varchar(2024) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '附件路径或链接' AFTER `company_address`;