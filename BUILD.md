# 婚礼管家App打包指南

## 项目概况

本项目是一个基于Web技术开发的婚礼管家应用，使用Capacitor框架进行跨平台打包。

## 已完成的配置

1. ✅ 创建了 `package.json` 文件
2. ✅ 安装了 Capacitor 核心依赖
3. ✅ 初始化了 `capacitor.config.json` 配置文件
4. ✅ 优化了配置文件，添加了必要的平台设置

## 权限问题解决

在执行 `npx cap add android` 或 `npx cap add ios` 时遇到了权限问题：
```
[Error: EPERM: operation not permitted, mkdir '/Users/mac/Library/Preferences/capacitor']
```

### 解决方案

1. **手动创建Capacitor配置目录**：
   ```bash
   sudo mkdir -p /Users/mac/Library/Preferences/capacitor
   sudo chmod -R 777 /Users/mac/Library/Preferences/capacitor
   ```

2. **使用sudo执行Capacitor命令**：
   ```bash
   sudo npx cap add android
   sudo npx cap add ios
   ```

3. **或使用--no-sync选项跳过同步**：
   ```bash
   npx cap add android --no-sync
   npx cap add ios --no-sync
   ```

## 手动添加平台

如果上述方法仍无法解决问题，您可以手动创建平台目录：

### 1. 手动创建Android平台

```bash
# 创建Android平台目录
mkdir -p android

# 复制Android模板文件（从Capacitor安装目录复制）
cp -r node_modules/@capacitor/android/template/* android/

# 更新capacitor.config.json，添加Android配置
```

### 2. 手动创建iOS平台

```bash
# 创建iOS平台目录
mkdir -p ios

# 复制iOS模板文件（从Capacitor安装目录复制）
cp -r node_modules/@capacitor/ios/template/* ios/

# 更新capacitor.config.json，添加iOS配置
```

## 使用Android Studio构建APK

### 步骤1：安装Android Studio

从[Android Studio官网](https://developer.android.com/studio)下载并安装最新版本。

### 步骤2：打开Android项目

```bash
# 使用Android Studio打开项目
open -a "Android Studio" android/
```

### 步骤3：构建APK

1. 在Android Studio中，选择 `Build` > `Generate Signed Bundle / APK`
2. 选择 `APK`，点击 `Next`
3. 点击 `Create new...` 生成签名密钥
4. 填写密钥信息，点击 `OK`
5. 选择 `debug` 或 `release` 构建类型
6. 点击 `Finish` 开始构建

### 步骤4：查找APK文件

构建完成后，APK文件将位于：
```
android/app/build/outputs/apk/debug/app-debug.apk
```

## 使用Xcode构建IPA（仅macOS）

### 步骤1：安装Xcode

从Mac App Store下载并安装最新版本的Xcode。

### 步骤2：打开iOS项目

```bash
# 使用Xcode打开项目
open ios/App/App.xcworkspace
```

### 步骤3：配置签名

1. 在Xcode中，选择项目导航器中的 `App` 项目
2. 选择 `Signing & Capabilities` 选项卡
3. 选择您的开发团队
4. 确保 `Automatically manage signing` 已勾选

### 步骤4：构建IPA

1. 选择 `Product` > `Archive`
2. 归档完成后，点击 `Distribute App`
3. 选择 `Ad Hoc` 或 `App Store Connect`
4. 按照提示完成构建过程

## 测试应用

### 1. 使用本地服务器测试

```bash
# 启动本地服务器
python3 -m http.server 8080

# 在浏览器中测试
open http://localhost:8080
```

### 2. 使用Capacitor Dev模式测试

```bash
# 启动本地服务器
python3 -m http.server 8080

# 运行Capacitor Dev模式
sudo npx cap run android --livereload --external
```

## 替代打包方案

### 1. 使用PhoneGap Build

1. 将项目文件压缩为ZIP格式
2. 访问 [PhoneGap Build](https://build.phonegap.com/)
3. 上传ZIP文件
4. 按照提示构建APK和IPA文件

### 2. 使用AppGyver

1. 访问 [AppGyver](https://www.appgyver.com/)
2. 创建新应用
3. 选择 "Web App" 模板
4. 上传项目文件
5. 按照提示构建应用

## 注意事项

1. **网络功能配置**：
   - 确保Firebase配置正确
   - 在AndroidManifest.xml和Info.plist中添加网络权限

2. **资源文件**：
   - 添加App图标（1024x1024px）到 `android/app/src/main/res/mipmap-*`
   - 添加启动画面到 `android/app/src/main/res/drawable/`

3. **测试**：
   - 在真实设备上测试所有功能
   - 测试网络连接和数据同步
   - 测试分享和天气功能

## 技术支持

如果您在打包过程中遇到问题，可以：

1. 查看 [Capacitor官方文档](https://capacitorjs.com/docs/)
2. 搜索 [Capacitor GitHub Issues](https://github.com/ionic-team/capacitor/issues)
3. 咨询专业的移动开发人员

## 完成状态

- [x] 项目初始化
- [x] Capacitor配置
- [ ] Android平台添加
- [ ] iOS平台添加
- [ ] 应用图标和启动画面添加
- [ ] 签名配置
- [ ] 最终构建

祝您打包顺利！
