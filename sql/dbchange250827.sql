ALTER TABLE `customer`
    ADD COLUMN `birthday` date DEFAULT NULL COMMENT '生日' AFTER `country_region`,
ADD COLUMN `gender` varchar(255) DEFAULT NULL COMMENT '性别' AFTER `birthday`;

ALTER TABLE `ruoyi`.`customer`
    MODIFY COLUMN `customer_type` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '客户类型' AFTER `status`,
    MODIFY COLUMN `customer_source` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '客户来源' AFTER `customer_type`;