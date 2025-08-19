CREATE TABLE `ruoyi`.`company`
(
    `id`           bigint(20) NOT NULL AUTO_INCREMENT,
    `company_name` varchar(255) NULL,
    `createTime`   datetime(0) NULL,
    `updateTime`   datetime(0) NULL,
    PRIMARY KEY (`id`),
    UNIQUE INDEX `c`(`company_name`) USING BTREE
);
