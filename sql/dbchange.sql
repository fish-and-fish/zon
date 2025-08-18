ALTER TABLE `ruoyi`.`customer`
    ADD COLUMN `followup_json` varchar(2048) NULL AFTER `followup_date`,
ADD COLUMN `createBy` varchar(255) NULL AFTER `attachment`,
ADD COLUMN `createTime` datetime(0) NULL AFTER `createBy`,
ADD COLUMN `updateTime` datetime(0) NULL AFTER `createTime`;

ALTER TABLE `ruoyi`.`customer`
    ADD COLUMN `createUserId` bigint(20) NULL AFTER `attachment`,
ADD COLUMN `updateBy` varchar(255) NULL AFTER `createBy`;

ALTER TABLE `ruoyi`.`customer`
DROP COLUMN `created_at`;
