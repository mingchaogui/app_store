# app_store

从Apple的公开API打造一个App Store

## 如何开始

1.在Flutter官网找到对应OS版本的SDK，下载并按照指引完成配置。
- [Flutter官网](https://docs.flutter.dev/get-started/install)

2.将你的设备连接到主机，打开终端，定位到项目的根目录，执行flutter run即可。

## 通过APK文件安装

在工程的根目录下找到app-release.apk，直接安装运行即可。

## 生成代码文件

工程中使用了json_annotation、retrofit等代码生成工具，此部分生成的代码为程序运行所必要。
如修改了相关代码，重新生成代码执行如下命令。

``
$ flutter pub run build_runner build --delete-conflicting-outputs
``

## 关于Lookup API

由于该API每次只能请求一个APP的数据，当快速滑动列表时，可能产生多个并发请求，部分可能会被拒绝。此时可通过滑动列表来重试请求。
项目中使用了HTTP2来改善稳定性，也可尝试延迟部分请求等其他解决方案。
