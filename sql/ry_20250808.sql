CREATE TABLE customer (
                          id BIGINT AUTO_INCREMENT PRIMARY KEY COMMENT '自增主键ID',
                          customer_id VARCHAR(20) NOT NULL UNIQUE COMMENT '客户ID',
                          company_name VARCHAR(255) NOT NULL COMMENT '公司名称',
                          customer_name VARCHAR(255) NOT NULL COMMENT '客户名称',

                          status VARCHAR(20) NOT NULL DEFAULT 'P2' COMMENT '状态类',
                          customer_type ENUM('订单客户', '样单客户', '重潜客户', '轻潜客户', '无潜客户') NOT NULL COMMENT '客户类型',
                          customer_source ENUM('阿里国际站', '邮件', '公司客户', '展会', '领英', 'ins', 'Facebook', 'Tiktok', '1688') NOT NULL COMMENT '客户来源',

                          customer_description TEXT COMMENT '客户描述',
                          country_region VARCHAR(100) NOT NULL COMMENT '国家地区',
                          customer_level VARCHAR(50) COMMENT '客户等级',

                          created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP COMMENT '自动字段',

                          followup_content TEXT COMMENT '跟进内容',
                          followup_date DATE COMMENT '跟进日期',

                          position VARCHAR(100) COMMENT '职位',
                          contact_phone VARCHAR(50) COMMENT '联系电话',
                          email VARCHAR(100) COMMENT '邮箱',
                          other_contact VARCHAR(255) COMMENT '其他联系方式',
                          company_website VARCHAR(255) COMMENT '公司网站',
                          company_address VARCHAR(500) COMMENT '公司地址',

                          attachment VARCHAR(255) COMMENT '附件，存储路径或链接',

                          UNIQUE KEY uq_company_name (company_name),
                          INDEX idx_country_region (country_region),
                          INDEX idx_customer_type (customer_type)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='客户信息表';



-- 菜单 SQL
insert into sys_menu (menu_name, parent_id, order_num, path, component, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark)
values('客户信息', '3', '1', 'customer', 'system/customer/index', 1, 0, 'C', '0', '0', 'system:customer:list', '#', 'admin', sysdate(), '', null, '客户信息菜单');

-- 按钮父菜单ID
SELECT @parentId := LAST_INSERT_ID();

-- 按钮 SQL
insert into sys_menu (menu_name, parent_id, order_num, path, component, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark)
values('客户信息查询', @parentId, '1',  '#', '', 1, 0, 'F', '0', '0', 'system:customer:query',        '#', 'admin', sysdate(), '', null, '');

insert into sys_menu (menu_name, parent_id, order_num, path, component, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark)
values('客户信息新增', @parentId, '2',  '#', '', 1, 0, 'F', '0', '0', 'system:customer:add',          '#', 'admin', sysdate(), '', null, '');

insert into sys_menu (menu_name, parent_id, order_num, path, component, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark)
values('客户信息修改', @parentId, '3',  '#', '', 1, 0, 'F', '0', '0', 'system:customer:edit',         '#', 'admin', sysdate(), '', null, '');

insert into sys_menu (menu_name, parent_id, order_num, path, component, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark)
values('客户信息删除', @parentId, '4',  '#', '', 1, 0, 'F', '0', '0', 'system:customer:remove',       '#', 'admin', sysdate(), '', null, '');

insert into sys_menu (menu_name, parent_id, order_num, path, component, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark)
values('客户信息导出', @parentId, '5',  '#', '', 1, 0, 'F', '0', '0', 'system:customer:export',       '#', 'admin', sysdate(), '', null, '');