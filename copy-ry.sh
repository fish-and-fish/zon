#!/bin/bash

# 源文件根目录
SRC_ROOT="/Users/linglong/Downloads/ruoyi"

# 目标项目根目录
DEST_ROOT="/Users/linglong/Documents/code/RuoYi-Vue"

# 复制 Java 代码相关
cp "$SRC_ROOT/main/java/com/ruoyi/system/controller/CustomerController.java" \
   "$DEST_ROOT/ruoyi-admin/src/main/java/com/ruoyi/web/controller/system/"

cp "$SRC_ROOT/main/java/com/ruoyi/system/domain/Customer.java" \
   "$DEST_ROOT/ruoyi-system/src/main/java/com/ruoyi/system/domain/"

cp "$SRC_ROOT/main/java/com/ruoyi/system/service/ICustomerService.java" \
   "$DEST_ROOT/ruoyi-system/src/main/java/com/ruoyi/system/service/"

cp "$SRC_ROOT/main/java/com/ruoyi/system/service/impl/CustomerServiceImpl.java" \
   "$DEST_ROOT/ruoyi-system/src/main/java/com/ruoyi/system/service/impl/"

cp "$SRC_ROOT/main/java/com/ruoyi/system/mapper/CustomerMapper.java" \
   "$DEST_ROOT/ruoyi-system/src/main/java/com/ruoyi/system/mapper/"

# 复制 Mapper XML，先确保目录存在
mkdir -p "$DEST_ROOT/ruoyi-system/src/main/resources/mapper/system/"
cp "$SRC_ROOT/main/resources/mapper/system/CustomerMapper.xml" \
   "$DEST_ROOT/ruoyi-system/src/main/resources/mapper/system/"

# 复制 Vue 视图文件，确保目录存在
mkdir -p "$DEST_ROOT/ruoyi-ui/src/views/system/customer/"
cp "$SRC_ROOT/vue/views/system/customer/index.vue" \
   "$DEST_ROOT/ruoyi-ui/src/views/system/customer/"

# 复制 API 文件，确保目录存在
mkdir -p "$DEST_ROOT/ruoyi-ui/src/api/system/"
cp "$SRC_ROOT/vue/api/system/customer.js" \
   "$DEST_ROOT/ruoyi-ui/src/api/system/"

echo "文件复制完成！"