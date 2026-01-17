# 婚礼筹备管家 - 云端部署方案

## 一、项目概述

婚礼筹备管家是一个基于Web技术开发的跨平台应用，使用Capacitor框架实现移动端适配。本方案将指导您如何将应用部署到云端，包括Web版本和移动端应用分发。

## 二、技术栈

- **前端框架**: 原生HTML/CSS/JavaScript
- **移动端框架**: Capacitor 8.0.1
- **数据库**: Firebase Realtime Database
- **构建工具**: 无（纯静态网站）

## 三、部署架构

### 1. 整体架构

```
┌─────────────────┐     ┌───────────────────┐     ┌────────────────────┐
│  Web 应用       │     │  移动端应用 (iOS)  │     │  移动端应用 (Android)  │
│  (Vercel/Netlify)│     │  (TestFlight)     │     │  (Google Play)        │
└────────┬────────┘     └──────────┬────────┘     └────────────┬───────┘
         │                         │                          │
         └─────────────────────────┼──────────────────────────┘
                                   │
                           ┌───────▼───────┐
                           │ Firebase      │
                           │ Realtime DB   │
                           └───────────────┘
```

### 2. Web版本部署

#### 2.1 部署选项

- **Vercel**: 推荐，配置简单，支持自动部署
- **Netlify**: 配置简单，支持自动部署
- **Firebase Hosting**: 与Firebase数据库集成良好
- **GitHub Pages**: 适合开源项目

#### 2.2 Vercel部署步骤

1. 注册Vercel账号：https://vercel.com/
2. 连接GitHub/GitLab/Bitbucket仓库
3. 选择项目仓库
4. 配置部署选项：
   - **Framework Preset**: `Static Site Generator`
   - **Build Command**: `npm run build`（如果没有构建脚本，可以留空）
   - **Output Directory**: `web`
   - **Environment Variables**: 添加Firebase配置
5. 点击"Deploy"开始部署

#### 2.3 Firebase Hosting部署步骤

1. 安装Firebase CLI：
   ```bash
   npm install -g firebase-tools
   ```
2. 登录Firebase：
   ```bash
   firebase login
   ```
3. 初始化Firebase项目：
   ```bash
   firebase init hosting
   ```
4. 配置选项：
   - 选择Firebase项目
   - 公共目录：`web`
   - 配置为单页应用：`y`
5. 部署到Firebase：
   ```bash
   firebase deploy --only hosting
   ```

### 3. 移动端应用分发

#### 3.1 iOS应用

##### 3.1.1 TestFlight测试分发

1. 安装Xcode和CocoaPods
2. 打开iOS项目：
   ```bash
   npx cap open ios
   ```
3. 在Xcode中配置项目：
   - 配置Bundle Identifier
   - 配置Signing & Capabilities
   - 配置App Icon和Splash Screen
4. 构建应用：
   ```bash
   npx cap build ios
   ```
5. 在Xcode中选择"Product" → "Archive"
6. 归档完成后，选择"Distribute App" → "TestFlight"
7. 按照提示完成TestFlight上传

##### 3.1.2 App Store正式发布

1. 完成TestFlight测试
2. 在Xcode中选择"Distribute App" → "App Store Connect"
3. 按照提示完成App Store上传
4. 在App Store Connect中填写应用信息并提交审核

#### 3.2 Android应用

##### 3.2.1 Firebase App Distribution测试分发

1. 安装Android Studio
2. 打开Android项目：
   ```bash
   npx cap open android
   ```
3. 在Android Studio中配置项目：
   - 配置Package Name
   - 配置Signing Configs
   - 配置App Icon和Splash Screen
4. 构建应用：
   ```bash
   npx cap build android
   ```
5. 在Android Studio中选择"Build" → "Generate Signed Bundle / APK"
6. 生成AAB或APK文件
7. 上传到Firebase App Distribution

##### 3.2.2 Google Play正式发布

1. 完成Firebase App Distribution测试
2. 登录Google Play Console：https://play.google.com/console
3. 创建应用并填写应用信息
4. 上传AAB文件
5. 填写商品详情和政策信息
6. 提交审核

## 四、Firebase配置

### 1. Firebase项目创建

1. 访问Firebase控制台：https://console.firebase.google.com/
2. 点击"添加项目"
3. 填写项目名称
4. 选择国家/地区
5. 启用Google Analytics（可选）

### 2. 配置Realtime Database

1. 在Firebase控制台中，选择"Realtime Database"
2. 点击"创建数据库"
3. 选择数据库位置
4. 选择"测试模式"（部署时请切换到"锁定模式"）
5. 点击"启用"

### 3. 获取Firebase配置

1. 在Firebase控制台中，点击"项目设置"
2. 在"您的应用"部分，点击"添加应用"
3. 选择"Web"
4. 填写应用昵称
5. 点击"注册应用"
6. 复制Firebase配置代码

### 4. 配置应用中的Firebase

1. 打开 `index.html` 文件
2. 找到Firebase配置部分：
   ```javascript
   const firebaseConfig = {
       apiKey: "YOUR_API_KEY",
       authDomain: "YOUR_PROJECT_ID.firebaseapp.com",
       databaseURL: "https://YOUR_PROJECT_ID-default-rtdb.firebaseio.com",
       projectId: "YOUR_PROJECT_ID",
       storageBucket: "YOUR_PROJECT_ID.appspot.com",
       messagingSenderId: "YOUR_MESSAGING_SENDER_ID",
       appId: "YOUR_APP_ID"
   };
   ```
3. 替换为您的Firebase配置

## 五、Capacitor配置优化

### 1. 配置文件说明

Capacitor配置文件 `capacitor.config.json` 已优化配置如下：

- 应用名称已改为中文"婚礼筹备管家"
- 服务器配置已优化，支持移动端访问
- iOS和Android配置已调整，支持状态栏自定义
- 添加了SplashScreen、StatusBar等插件配置

### 2. 构建移动端应用

```bash
# 构建Web版本
npm run build  # 如果有构建脚本

# 同步Capacitor配置
npx cap sync

# 打开iOS项目
npx cap open ios

# 打开Android项目
npx cap open android
```

## 六、CI/CD配置

### 1. GitHub Actions配置

创建 `.github/workflows/deploy.yml` 文件：

```yaml
name: Deploy

on:
  push:
    branches: [ main ]

jobs:
  deploy:
    runs-on: ubuntu-latest
    steps:
    - uses: actions/checkout@v3
    - name: Deploy to Vercel
      uses: amondnet/vercel-action@v25
      with:
        vercel-token: ${{ secrets.VERCEL_TOKEN }}
        vercel-org-id: ${{ secrets.VERCEL_ORG_ID }}
        vercel-project-id: ${{ secrets.VERCEL_PROJECT_ID }}
        working-directory: ./婚礼管家程序
```

### 2. 环境变量配置

在GitHub仓库中添加以下环境变量：

- `VERCEL_TOKEN`: Vercel API令牌
- `VERCEL_ORG_ID`: Vercel组织ID
- `VERCEL_PROJECT_ID`: Vercel项目ID
- `FIREBASE_API_KEY`: Firebase API密钥
- `FIREBASE_AUTH_DOMAIN`: Firebase Auth域
- `FIREBASE_DATABASE_URL`: Firebase数据库URL
- `FIREBASE_PROJECT_ID`: Firebase项目ID

## 七、移动端应用签名

### 1. iOS应用签名

1. 在Apple Developer Portal中创建App ID
2. 创建开发和生产证书
3. 创建Provisioning Profiles
4. 在Xcode中配置签名

### 2. Android应用签名

1. 生成签名密钥：
   ```bash
   keytool -genkey -v -keystore my-release-key.keystore -alias my-key-alias -keyalg RSA -keysize 2048 -validity 10000
   ```
2. 在`android/app/build.gradle`中配置签名：
   ```gradle
   android {
       signingConfigs {
           release {
               storeFile file("my-release-key.keystore")
               storePassword "your-store-password"
               keyAlias "my-key-alias"
               keyPassword "your-key-password"
           }
       }
       buildTypes {
           release {
               signingConfig signingConfigs.release
           }
       }
   }
   ```

## 八、安全配置

### 1. Firebase数据库安全规则

```json
{
  "rules": {
    "weddingPlanner": {
      ".read": "auth != null",
      ".write": "auth != null"
    }
  }
}
```

### 2. CORS配置

确保Firebase数据库允许来自您的Web域名的请求。

### 3. HTTPS配置

- 所有Web部署必须使用HTTPS
- 移动端应用配置已支持HTTPS

## 九、监控和维护

### 1. Firebase Analytics

建议启用Firebase Analytics来监控应用使用情况：

```javascript
// 添加Firebase Analytics SDK
<script src="https://www.gstatic.com/firebasejs/9.22.0/firebase-analytics.js"></script>

// 初始化Analytics
const analytics = firebase.analytics();
```

### 2. 错误监控

建议使用Sentry或Firebase Crashlytics监控应用错误：

```javascript
// 添加Sentry SDK
<script src="https://browser.sentry-cdn.com/7.0.0/bundle.min.js"></script>

// 初始化Sentry
Sentry.init({
  dsn: "YOUR_SENTRY_DSN",
  integrations: [new Sentry.BrowserTracing()],
  tracesSampleRate: 1.0
});
```

## 十、版本管理

### 1. 语义化版本控制

使用语义化版本控制：`MAJOR.MINOR.PATCH`

- **MAJOR**: 不兼容的API更改
- **MINOR**: 向下兼容的功能性新增
- **PATCH**: 向下兼容的问题修正

### 2. 发布流程

1. 更新版本号
2. 构建Web版本
3. 同步Capacitor配置
4. 构建移动端应用
5. 部署Web版本
6. 分发移动端测试版本
7. 提交移动端正式版本

## 十一、常见问题

### 1. Web版本部署后无法访问Firebase数据库

- 检查Firebase配置是否正确
- 检查Firebase数据库规则是否允许访问
- 检查CORS配置

### 2. 移动端应用无法构建

- 检查Capacitor版本是否兼容
- 检查iOS/Android SDK版本
- 检查签名配置

### 3. 数据同步问题

- 检查网络连接
- 检查Firebase配置
- 检查数据结构是否正确

## 十二、总结

本部署方案提供了婚礼筹备管家应用的完整云端部署指南，包括Web版本和移动端应用分发。通过遵循本方案，您可以快速将应用部署到云端，实现跨平台访问和数据同步。

如需进一步帮助，请参考以下文档：

- [Capacitor文档](https://capacitorjs.com/docs)
- [Firebase文档](https://firebase.google.com/docs)
- [Vercel文档](https://vercel.com/docs)
- [Netlify文档](https://docs.netlify.com/)

---

**部署日期**: 2026-01-17
**部署负责人**: AI助手
**版本**: 1.0.0
