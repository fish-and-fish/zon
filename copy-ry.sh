#!/bin/bash

# 源文件根目录
SRC_ROOT="/Users/linglong/Downloads/ruoyi"

# 目标项目根目录
DEST_ROOT="/Users/linglong/Documents/code/RuoYi-Vue"

# 复制 Java Controller
cp "$SRC_ROOT/main/java/com/ruoyi/system/controller/"*.java \
   "$DEST_ROOT/ruoyi-admin/src/main/java/com/ruoyi/web/controller/system/" 2>/dev/null

# 复制 Java Domain
cp "$SRC_ROOT/main/java/com/ruoyi/system/domain/"*.java \
   "$DEST_ROOT/ruoyi-system/src/main/java/com/ruoyi/system/domain/" 2>/dev/null

# 复制 Java Service 接口
cp "$SRC_ROOT/main/java/com/ruoyi/system/service/"*.java \
   "$DEST_ROOT/ruoyi-system/src/main/java/com/ruoyi/system/service/" 2>/dev/null

# 复制 Java Service 实现
cp "$SRC_ROOT/main/java/com/ruoyi/system/service/impl/"*.java \
   "$DEST_ROOT/ruoyi-system/src/main/java/com/ruoyi/system/service/impl/" 2>/dev/null

# 复制 Java Mapper
cp "$SRC_ROOT/main/java/com/ruoyi/system/mapper/"*.java \
   "$DEST_ROOT/ruoyi-system/src/main/java/com/ruoyi/system/mapper/" 2>/dev/null

# 复制 Mapper XML
mkdir -p "$DEST_ROOT/ruoyi-system/src/main/resources/mapper/system/"
cp "$SRC_ROOT/main/resources/mapper/system/"*.xml \
   "$DEST_ROOT/ruoyi-system/src/main/resources/mapper/system/" 2>/dev/null

# 复制 Vue 视图文件
mkdir -p "$DEST_ROOT/ruoyi-ui/src/views/system/customer/"
cp "$SRC_ROOT/vue/views/system/customer/"*.vue \
   "$DEST_ROOT/ruoyi-ui/src/views/system/customer/" 2>/dev/null

# 复制 API 文件
mkdir -p "$DEST_ROOT/ruoyi-ui/src/api/system/"
cp "$SRC_ROOT/vue/api/system/"*.js \
   "$DEST_ROOT/ruoyi-ui/src/api/system/" 2>/dev/null

git add .
echo "文件批量复制完成！"