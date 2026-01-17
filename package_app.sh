#!/bin/bash

# 婚礼管家程序打包脚本
# 使用 sudo 执行此脚本以解决权限问题

echo "开始打包婚礼管家程序..."

# 1. 解决权限问题
echo "正在解决权限问题..."
sudo mkdir -p /Users/mac/Library/Preferences/capacitor
sudo chmod -R 777 /Users/mac/Library/Preferences/capacitor

echo "权限问题已解决！"

# 2. 初始化Capacitor
echo "正在初始化Capacitor..."
npx cap init wedding-planner-app com.weddingplanner.app --web-dir .

# 3. 添加Android平台
echo "正在添加Android平台..."
npx cap add android

# 4. 添加iOS平台
echo "正在添加iOS平台..."
npx cap add ios

# 5. 复制必要的配置文件
echo "正在准备配置文件..."
cp capacitor.config.json capacitor.config.json.bak

# 6. 构建应用
echo "正在构建应用..."
npx cap sync

# 7. 完成
echo "打包准备工作已完成！"
echo ""
echo "下一步操作："
echo "1. 打开Android Studio: npx cap open android"
echo "2. 打开Xcode: npx cap open ios"
echo "3. 构建并运行应用"
echo ""
echo "详细打包步骤请参考 BUILD.md 文件"
