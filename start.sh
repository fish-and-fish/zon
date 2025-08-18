#!/bin/bash
# 部署脚本：关闭旧进程 -> 打包 -> 启动新服务

APP_NAME="ruoyi-admin"
APP_PORT=9937
APP_DIR="/usr/zon/ruoyi-admin"
JAR_PATH="$APP_DIR/target/${APP_NAME}.jar"
LOG_FILE="/usr/zon/app.log"

echo ">>> Step 1. 查找并关闭 $APP_PORT 端口进程..."
PID=$(lsof -t -i:$APP_PORT)
if [ -n "$PID" ]; then
  echo "发现进程 PID=$PID, 正在关闭..."
  kill -9 $PID
  echo "进程已关闭"
else
  echo "端口 $APP_PORT 没有正在运行的进程"
fi

echo ">>> Step 2. 打包项目..."
cd $APP_DIR || exit
mvn clean package -Dmaven.test.skip=true
if [ $? -ne 0 ]; then
  echo "❌ Maven 打包失败，退出部署"
  exit 1
fi

echo ">>> Step 3. 启动新服务..."
nohup java -Xms512m -Xmx1g -jar $JAR_PATH > $LOG_FILE 2>&1 &
sleep 3

NEW_PID=$(lsof -t -i:$APP_PORT)
if [ -n "$NEW_PID" ]; then
  echo "✅ 服务已启动成功 (PID=$NEW_PID)，日志输出在 $LOG_FILE"
else
  echo "⚠️ 服务启动失败，请检查 $LOG_FILE 日志"
fi