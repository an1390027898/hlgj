# 手动集成Capacitor指南

## 1. 概述

由于遇到Capacitor CLI权限问题，我们将使用Android Studio直接创建Android项目，然后手动集成Capacitor。

## 2. 使用Android Studio创建项目

### 步骤1：打开Android Studio

### 步骤2：创建新项目

1. 选择 "New Project"
2. 选择 "Empty Activity" 模板
3. 点击 "Next"

### 步骤3：配置项目

- **Name**: WeddingPlanner
- **Package name**: com.weddingplanner.app
- **Save location**: `/Users/mac/Desktop/婚礼管管家工具/hlgj/婚礼管家程序/android`
- **Language**: Java
- **Minimum SDK**: API 21 (Android 5.0)

4. 点击 "Finish"

### 步骤4：添加Capacitor依赖

打开项目根目录的 `build.gradle` 文件，添加以下依赖：

```gradle
// Top-level build.gradle
allprojects {
    repositories {
        google()
        mavenCentral()
    }
}
```

打开 `app/build.gradle` 文件，添加以下依赖：

```gradle
dependencies {
    implementation fileTree(dir: 'libs', include: ['*.jar'])
    implementation 'androidx.appcompat:appcompat:1.6.1'
    implementation 'androidx.constraintlayout:constraintlayout:2.1.4'
    implementation 'com.getcapacitor:core:8.0.1'
}
```

### 步骤5：同步Gradle

点击 "Sync Now" 按钮同步Gradle配置。

## 3. 配置Capacitor

### 步骤1：创建MainActivity.java

打开 `app/src/main/java/com/weddingplanner/app/MainActivity.java`，修改为：

```java
package com.weddingplanner.app;

import com.getcapacitor.BridgeActivity;
import android.os.Bundle;

public class MainActivity extends BridgeActivity {
    @Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        registerPlugin(MyPlugin.class);
    }
}
```

### 步骤2：创建AndroidManifest.xml

确保 `app/src/main/AndroidManifest.xml` 包含以下权限：

```xml
<?xml version="1.0" encoding="utf-8"?>
<manifest xmlns:android="http://schemas.android.com/apk/res/android"
    package="com.weddingplanner.app">

    <uses-permission android:name="android.permission.INTERNET" />
    <uses-permission android:name="android.permission.ACCESS_NETWORK_STATE" />

    <application
        android:allowBackup="true"
        android:icon="@mipmap/ic_launcher"
        android:label="@string/app_name"
        android:roundIcon="@mipmap/ic_launcher_round"
        android:supportsRtl="true"
        android:theme="@style/Theme.WeddingPlanner">
        <activity
            android:name=".MainActivity"
            android:exported="true"
            android:configChanges="orientation|keyboardHidden|keyboard|screenSize|locale|smallestScreenSize|screenLayout|uiMode"
            android:hardwareAccelerated="true"
            android:windowSoftInputMode="adjustResize">
            <intent-filter>
                <action android:name="android.intent.action.MAIN" />
                <category android:name="android.intent.category.LAUNCHER" />
            </intent-filter>
        </activity>
    </application>

</manifest>
```

### 步骤3：创建assets目录

创建 `app/src/main/assets` 目录，并复制项目的所有Web文件（HTML、CSS、JavaScript等）到该目录。

## 4. 配置Web文件

### 步骤1：复制Web文件

将以下文件复制到 `assets` 目录：
- `index.html`
- 所有CSS和JavaScript文件
- 所有图像和其他资源文件

### 步骤2：修改index.html

在index.html的 `<head>` 中添加：

```html
<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no" />
<meta name="apple-mobile-web-app-capable" content="yes" />
<meta name="apple-mobile-web-app-status-bar-style" content="black" />
```

## 5. 构建和运行

### 步骤1：构建项目

点击Android Studio工具栏中的 "Build" > "Make Project"。

### 步骤2：运行项目

1. 连接Android设备或启动模拟器
2. 点击 "Run" > "Run 'app'"

## 6. 添加iOS支持

### 步骤1：创建iOS项目

使用Xcode创建iOS项目：

1. 打开Xcode
2. 选择 "Create a new Xcode project"
3. 选择 "iOS" > "App"
4. 点击 "Next"

### 步骤2：配置项目

- **Product Name**: WeddingPlanner
- **Team**: 选择您的开发团队
- **Organization Identifier**: com.weddingplanner
- **Language**: Swift
- **Interface**: Storyboard
- **Life Cycle**: UIKit App Delegate
- **Save**: `/Users/mac/Desktop/婚礼管管家工具/hlgj/婚礼管家程序/ios`

5. 点击 "Create"

### 步骤3：集成Capacitor

1. 打开 `Podfile` 文件，添加Capacitor依赖：

```ruby
platform :ios, '13.0'

target 'WeddingPlanner' do
  use_frameworks!
  pod 'Capacitor', '~> 8.0.1'
  pod 'CapacitorCordova', '~> 8.0.1'
end
```

2. 运行 `pod install`

3. 配置项目（详细步骤请参考Capacitor官方文档）

## 7. 替代方案：使用PhoneGap Build

如果手动集成仍然遇到问题，可以考虑使用PhoneGap Build：

1. 将项目文件压缩为ZIP格式
2. 访问 [PhoneGap Build](https://build.phonegap.com/)
3. 上传ZIP文件
4. 按照提示构建APK和IPA文件

## 8. 常见问题

### 问题1：Web资源无法加载

**解决方案**：
- 确保所有Web文件都已正确复制到assets目录
- 检查文件路径是否正确

### 问题2：网络请求失败

**解决方案**：
- 确保AndroidManifest.xml中添加了网络权限
- 检查URL是否正确
- 考虑添加 `android:usesCleartextTraffic="true"` 到AndroidManifest.xml

### 问题3：电容插件无法使用

**解决方案**：
- 确保正确注册了插件
- 检查插件版本是否兼容

## 9. 技术支持

如果遇到问题，可以查看：

- [Capacitor官方文档](https://capacitorjs.com/docs/)
- [Android Studio官方文档](https://developer.android.com/studio/intro)

## 10. 下一步

1. 完成Android Studio项目创建
2. 复制Web资源到assets目录
3. 配置Capacitor
4. 测试应用
5. 构建最终版本

祝您集成顺利！
