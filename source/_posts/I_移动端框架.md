---
title: 移动端框架
date: 2022-05-12 06:33:16
categories:
- I_移动端
toc: true # 是否启用内容索引
---

# 大纲

## 跨端APP

跨端APP：Flutter、React Native、UniApp

- Dart Flutter入门实战基础视频教程-video
- Flutter从入门到进阶 实战携程网App-video-mk
- SpringBoot+Uniapp实战开发全新仿抖音短视频App-video-mk
- React Native从入门到实战 打造高质量上线App-video-mk
- React Native+TypeScript仿喜马拉雅开发App-video-mk

## **小程序**

WXML原生、UniApp、taro支持vue

- Taro3+Mysql+Express开发企业级出行全栈项目 -video
- 掌握Taro多端框架 快速上手小程序/H5开发-video
- 扫码点餐微信小程序云开发，uniapp，vue，nodejs带后台管理-video
- SpringBoot2.X + Vue + UniAPP，全栈开发医疗小程序-video-mk

## 微信公众号

WeRoBot、Flask-WeChat、Tornado-WeRoBot、django-weixin

- 微信公众号开发课程-video

**一个完整 HTML5 页面的展示要经历浏览器控件的加载、解析和渲染三大过程，性能消耗要比原生开发增加 N 个数量级**。

# 前言

- [移动开发的最佳 React Native 替代方案](https://juejin.cn/post/7036615302007750692?searchId=20240306153831FE860597322AFA0BF4F4#heading-111)
- [思辨：移动开发的未来在哪？](https://juejin.cn/post/7292347319431790607?searchId=20240306153831FE860597322AFA0BF4F4)

**跨平台、跨端**

- 跨平台：指跨操作系统
- 跨端：指跨web,ios,android,iot设备

## 移动开发细分领域

- 混合开发和跨平台框架
- Framework和Kernel
- 逆向安全
- 音视频
- 移动Web
- 嵌入式

**个人的一些思考**

> 1.AIGC+移动端
>
> 2023年的AIGC的火热空前绝后，它带来的影响是非常深远的，甚至能够变革整个互联网行业，很多产品可能将会以新的思路去重构和延伸，这里面就会产生相应的在移动端和AIGC结合相关产品和业务，公司层面也会有相应的投入意愿，这也许会给我们带来新的机会。
>
> 2.元宇宙：VR/AR/XR
>
> 元宇宙虽然被炒概念，一直不温不火的，但这里面涉及的技术是比较前沿的，在游戏领域跟元宇宙的结合，如果能找到愿意投入企业，未尝不是一个不错的方向。
>
> 3.IoT物联网
>
> 万物互联方向，比如智能家居，智能创新硬件产品，类似小米IoT相关的产品，智能手环、扫地机器人等等。这里面也有庞大的市场需求，另外软硬件结合对开发人员要求更高，更接近底层。
>
> 4.新能源车载系统
>
> 新能源车的其中一个核心就是**智能中控**，比如特斯拉的中控系统是Linux，比亚迪还有蔚小理和大多数造车新势力用的是Android系统，这里面也有很多车载系统应用的需求，也是很多人都求职热门方向。
>
> 5.音视频技术领域
>
> 当下流行的短视频，涉及到的核心就是**音视频技术**，有这方面的技术积累的同学应该也能获得不错的发展机会，而且这方面的人才相对而言比较稀缺。
>
> 6.跨平台技术
>
> 从企业降本的角度，未来可能会更倾向招聘懂跨平台开发的，希望能统一技术栈能够实现多端发布的能力。比如Flutter、React Native、UniApp等。
>
> 7.鸿蒙OS应用开发
>
> 国产替代是个很深远的话题，卡脖子问题现在越演越烈，从软件产业我们跟漂亮国还存在很多差距，我们能够正视这些差距并且迎头突围是一个非常值得敬佩和骄傲的事情。鸿蒙OS有望成为第一个完全去Android化的操作系统，Mate60系列手机产品我认为是一个标志性里程碑，我们不谈什么遥遥领先，我相信华为一定会越来越好，鸿蒙OS应用开发也是我觉得有较好前景的方向。

# **发展史**

- WebApp:PWA
- Hybrid APP:Cordova，Ionic,VasSonic
- 语言编译转换:Xamarin
- 原生渲染：React,Native,Weex,Dcloud
- 自渲染：Flutter

还有一个**笼统划分**：Web 容器时代，泛 Web 容器时代，自绘引擎时代

- Web 容器时代：基于 Web 相关技术通过浏览器组件来实现界面及功能，典型的框架包括 Cordova(PhoneGap)、Ionic 和微信小程序。
- 泛 Web 容器时代：采用类 Web 标准进行开发，但在运行时把绘制和渲染交由原生系统接管的技术，代表框架有 React Native、Weex 和快应用，广义的还包括天猫的 Virtual View 等。
- 自绘引擎时代：自带渲染引擎，客户端仅提供一块画布即可获得从业务逻辑到功能呈现的多端高度一致的渲染体验。Flutter，是为数不多的代表。

## **WebApp:PWA**

Web App 是指基于 Web 的应用，运行于网络和标准浏览器上，相当于一个网页然后加一个 App 的壳。主要采用的是原生应用内嵌浏览器控件 WebView（iOS 为 UIWebView 或 WKWebView，Android 为 WebView）的方式进行 HTML5 页面渲染，并定义 HTML5 与原生代码交互协议，将部分原生系统能力暴露给 HTML5，从而扩展 HTML5 的边界。

- 性能低，操作体验不好
- 无法调用原生 API，很多功能无法实现，
- 依赖于网络，网速慢时体验很差，并且没有离线功能，优化不好的话会消耗流量
- 只能做为一个临时的入口，用户留存率低

**PWA**是web App的进化型，`PWA（Progressive Web App，渐进式增强 Web 应用）`。它不是一门技术，而是一个概念，他的意思就是使用多种技术来增强 Web App 的功能

PWA 的主要的能力就是离线、推送、桌面访问，可以说 PWA 赋予 Web App 原生的体验，但是 PWA 一直不温不火的原因主要有以下几点：

- 用 Service Worker + HTTPS +Cache Api + indexedDB 等一系列 web 技术实现离线加载和缓存
- 实现了推送和通知
- 可以直接添加到手机的桌面上
- 使用 Service Worker 可以进行后台同步
- 游览器对 PWA 技术支持还不够全面， 不是每一款游览器都能 100% 的支持 PWA
- 国内一些手机厂商对 Android 系统各种魔改，对 PWA 的兼容性不好，甚至不支持 PWA
- 平台的竞争，iOS 对 PWA 的支持力度远远低于 Android，所以 PWA 在 iOS 上的体验打了折扣。PWA 面对类似的微信小程序和快应用的竞争中，并没有优势

## **Hybrid APP:Cordova，Ionic,VasSonic**

HTML5 + 原生来进行混合开发，这就是 Hybrid。

**Cordova**

| 优点                                                       | 缺点                                                         |
| ---------------------------------------------------------- | ------------------------------------------------------------ |
| 跨平台，开发简单，学习成本低                               | WebView性能低下时，用户体验差，反应慢                        |
| 框架多，插件多，可自定义插件                               | 国外的框架，中文文档资源少                                   |
| 发展最早，社区资源丰富                                     | 调试不方便，既不像原生那种调试，也不像纯web那种热重载式的调试 |
| 相同代码通过编译就能跑在各平台，大大提高了多平台开发的效率 | App store相关政策存在风险？                                  |

**Ionic**

Ionic是一个开源的移动应用程序开发框架，它可以轻松地使用web技术构建高质量的跨平台的移动应用。

**VasSonic**

腾讯开发的产品，专注于提升页面首屏加载速度，完美支持静态直出页面和动态直出页面，兼容离线包等方案

## **语言编译转换:Xamarin**

Xamarin 是一个开放源代码平台，用于通过 .NET 构建适用于 iOS、Android 和 Windows 的新式高性能应用程序。 Xamarin 是一个抽象层，可管理共享代码与基础平台代码的通信。 Xamarin 在提供便利（如内存分配和垃圾回收）的托管环境中运行。

## **原生渲染：React Native,Weex,Dcloud**

**React Native**

React Native (简称RN)是Facebook于2015年4月开源的跨平台移动应用开发框架,支持iOS和安卓.

| 优点                                                         | 缺点                                                         |
| ------------------------------------------------------------ | ------------------------------------------------------------ |
| 复用了 React 的思想，有利于前端开发者涉足移动端。            | 做不到 Write once, Run everywhere                            |
| 能够利用 JavaScript 动态更新的特性，快速迭代。               | 不能做到完全屏蔽 iOS 端或 Android 的细节                     |
| 相比于原生平台，开发速度更快，相比于 Hybrid 框架，性能更好。 | 由于 Objective-C 与 JavaScript 之间切换存在固定的时间开销，所以性能必定不及原生 |

**Weex**

Weex是alibaba于2015年推出的一款跨平台开发框架,支持Android、iOS 和 Web。目前支持Vue.js 和 Rax框架的完善开发。

| 优点                            | 缺点                                            |
| ------------------------------- | ----------------------------------------------- |
| 国内团队开发，中文文档齐全      | 动画实现、API丰富程度及事件机制上略逊于RN       |
| Vue作为前端开发语言，学习成本低 | 不支持横竖屏切换                                |
| 与RN不同，Weex的框架较轻        | 阿里将其捐赠给Apache，后续维护频率低（KPI产品） |

**Dcloud（uni-app）**

uni-app 是一个使用 Vue.js 开发所有前端应用的框架，开发者编写一套代码，可发布到iOS、Android、Web（响应式）、以及各种小程序（微信/支付宝/百度/头条/QQ/钉钉/淘宝）、快应用等多个平台。

uni-app是双渲染引擎，在 App端内置了一个webview和一个基于 weex 改进的原生渲染引擎，提供了原生渲染能力。

在App端：

- 如果使用vue页面，则使用webview渲染
- 如果使用nvue页面(native vue的缩写)，则使用原生渲染

## **自渲染：Flutter**

Flutter 是 Google 开源的 UI 工具包，帮助开发者通过一套代码库高效构建多平台精美应用，支持移动、Web、桌面和嵌入式平台。

| 类型           | Cordova               | Xamarin               | React Native           | Weex                     | Uniapp                | Flutter                       |
| -------------- | --------------------- | --------------------- | ---------------------- | ------------------------ | --------------------- | ----------------------------- |
| 性能           | 低                    | 高                    | 较高                   | 中                       | 高                    | 高                            |
| 上手难度       | 容易                  | 较高                  | 较高                   | 容易                     | 容易                  | 中                            |
| 核心           | JavaScript            | .NET                  | React                  | Weex                     | vue                   | Dart                          |
| 框架轻重       | 轻                    | 较重                  | 较重                   | 较轻                     | 轻                    | 重                            |
| 特点           | 适合单页面            | 适合开发整体App       | 适合开发整体App        | 适合单页面               | 适合开发整体App       | 适合开发整体App               |
| 社区           | 活跃度较低            | 活跃度低              | 活跃度高，Facebook维护 | 活跃度中，目前托管apache | 活跃度高，Dcloud维护  | 活跃度高，Google维护          |
| 支持平平台实现 | JS 引擎解释执行JS代码 | JS 引擎解释执行JS代码 | JS 引擎解释执行JS代码  | JS 引擎解释执行JS代码    | JS 引擎解释执行JS代码 | Dart 代码编译成目标机器码     |
| 适应性         | Web开发学习成本低     | .NET C#工程师开发     | Web开发学习成本低      | Web开发学习成本低        | Web开发学习成本低     | Java、C++、C#、开发学习成本低 |

## **其他**

**小程序**

小程序开发本质上还是前端 `HTML + CSS + JS` 那一套逻辑，它基于 WebView 和微信自己定义的一套 `JS/WXML/WXSS/JSON` 来开发和渲染页面。

- 在 iOS 上，小程序的 JavaScript 代码是运行在 `JavaScriptCore` 中，是由 `WKWebView` 来渲染的，环境有 iOS 8+；
- 在 Android 上，小程序的 JavaScript 代码是通过 `X5 JSCore` 来解析，是由 X5 基于 `Mobile Chrome 53/57` 内核来渲染的；
- 在 开发工具上， 小程序的 JavaScript 代码是运行在 `nwjs` 中，是由 `Chrome Webview` 来渲染的。

# **编程语言**

编程语言分为两大阵营:

- 解释型 - 需要解释器提供“实时翻译”。如 python、JavaScript、Dart
- 编译型 - 需要预编译，执行效率高，但跨平台能力差。如 C/C++、Java、Dart



