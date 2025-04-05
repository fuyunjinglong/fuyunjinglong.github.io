---
title: 移动端框架
date: 2022-05-12 06:33:16
categories:
  - I_移动端
toc: true # 是否启用内容索引
---

# 大纲

## 移动端H5

主要以 vue3+vant 为主

- [3 天吃透 Vue3+Vite+Vant 移动开发的新特性-video](https://www.bilibili.com/video/BV1TU4y177UG?vd_source=bd4c7d99d71adf64d6e88c65370e0247&spm_id_from=333.788.videopod.episodes)
- [vue3.2+vite+vant 企业实战项目 仿马蜂窝 旅游 H5-video](https://www.bilibili.com/video/BV1LV4y1z7zY?vd_source=bd4c7d99d71adf64d6e88c65370e0247&spm_id_from=333.788.videopod.episodes)
- Vue3+Vite+Vant-UI 开发双端招聘 APP-video
- 基于 Vue3.2+TypeScript 《医疗问诊》项目课程-video

## 跨端 APP

跨端 APP：Flutter、React Native、UniApp

- Flutter 从入门到进阶 实战携程网 App-video-mk
- Dart Flutter 入门实战基础视频教程-video
- SpringBoot+Uniapp 实战开发全新仿抖音短视频 App-video-mk
- React Native 从入门到实战 打造高质量上线 App-video-mk
- React Native+TypeScript 仿喜马拉雅开发 App-video-mk

## 桌面端

Electron

- [禹神：一小时快速上手 Electron](https://www.bilibili.com/video/BV1sE421N7M5/?spm_id_from=333.337.search-card.all.click&vd_source=bd4c7d99d71adf64d6e88c65370e0247)
- [Electron 入门到精通](https://www.bilibili.com/video/BV1xd4y1J7dB/?spm_id_from=333.337.search-card.all.click&vd_source=bd4c7d99d71adf64d6e88c65370e0247)

## **小程序**

WXML 原生、UniApp、taro 支持 vue

- Taro3+Mysql+Express 开发企业级出行全栈项目 -video
- 掌握 Taro 多端框架 快速上手小程序/H5 开发-video
- 扫码点餐微信小程序云开发，uniapp，vue，nodejs 带后台管理-video
- SpringBoot2.X + Vue + UniAPP，全栈开发医疗小程序-video-mk

## 微信公众号

WeRoBot、Flask-WeChat、Tornado-WeRoBot、django-weixin

- 微信公众号开发课程-video

**一个完整 HTML5 页面的展示要经历浏览器控件的加载、解析和渲染三大过程，性能消耗要比原生开发增加 N 个数量级**。

> **一、移动端框架分类**
>
> **1. 跨平台原生开发框架**
>
> - React Native
>   - **特点**：基于 React，使用 JavaScript 开发，编译为原生组件，性能接近原生应用。
>   - **优势**：社区庞大、支持热更新、代码复用率高（Android/iOS）。
>   - **缺点**：部分原生功能需自行实现，第三方库有限 。
> - Flutter
>   - **特点**：Google 开发，使用 Dart 语言，自带 Skia 渲染引擎，UI 高度一致。
>   - **优势**：高性能、丰富的内置组件、热重载支持。
>   - **缺点**：Dart 学习成本较高，包体积较大 。
> - NativeScript
>   - **特点**：支持 JavaScript/TypeScript，直接调用原生 API。
>   - **优势**：性能优异、灵活性强。
>   - **缺点**：社区较小，学习曲线陡峭 。
>
> **2. 混合应用框架（基于 Web 技术）**
>
> - Ionic
>   - **特点**：基于 Angular/Vue，使用 WebView 渲染。
>   - **优势**：开发成本低、跨平台兼容性好、丰富的 UI 组件。
>   - **缺点**：性能依赖 WebView，原生体验较弱 。
> - PhoneGap/Cordova
>   - **特点**：通过插件访问设备功能（如摄像头、GPS）。
>   - **优势**：适合快速原型开发，支持多平台。
>   - **缺点**：性能瓶颈明显，调试复杂 。
>
> **3. 移动端 UI 组件库**
>
> - Vant
>   - **定位**：专为 Vue 设计的轻量级移动端组件库。
>   - **核心特性**：
> - **轻量高效**：组件平均体积 <1KB（min+gzip），支持按需引入和 Tree Shaking 。
> - **多端兼容**：支持 H5、微信小程序、React Native 等平台 。
> - **主题定制**：内置 700+ CSS 变量，可灵活调整样式 。
> - **开发友好**：完善的文档、TypeScript 支持、单元测试覆盖率 >90%
>   - **适用场景**：电商、社交、工具类应用（如“有赞”多款产品采用）。
> - Vuetify
>   - **特点**：基于 Vue 的 Material Design 风格组件库。
>   - **优势**：设计规范统一，适合企业级应用。
>   - **缺点**：移动端适配不如 Vant 专注 。
> - WeUI / Frozen UI
>   - **特点**：微信官方或社区推出的轻量级 UI 库，专为小程序优化 。
>
> **4. 响应式网页框架（移动端 Web 开发）**
>
> - Bootstrap
>   - **特点**：全球最流行的响应式框架，支持移动优先设计。
>   - **优势**：生态丰富，适合快速搭建网页应用。
>   - **缺点**：代码冗余，需手动优化性能 。
> - Foundation
>   - **特点**：模块化设计，可扩展性强。
>   - **优势**：灵活度高，适合复杂项目。
>   - **缺点**：学习成本较高 。
> - Zepto.js
>   - **特点**：轻量级替代 jQuery，专为移动端优化。
>   - **优势**：体积小（约 10KB），兼容 WebKit 内核浏览器 。
>
> **二、框架选型**
>
> 1. **技术栈匹配**
>
> - Vue 项目：优先选择 **Vant** 或 **Vuetify**。
> - React 项目：考虑 **React Native** 或 **Ant Design Mobile**。
> - 跨平台原生开发：性能优先选 **Flutter**，生态优先选 **React Native**。
>
> 2. **性能与体验**
>
> - 原生级性能：**Flutter**、**React Native**。
> - 快速开发：**Ionic**、**Vant**（适合 MVP 或内部工具）。
>
> 3. **多平台需求**
>
> - 小程序 + H5：**Vant**、**WeUI**。
> - 全平台覆盖：**Flutter**、**React Native**。
>
> 4. **社区与维护**
>
> - 成熟框架：**React Native**、**Bootstrap**。
> - 新兴技术：**Flutter**（增长迅速）、**Vant**（国内活跃社区）。

# 前言

- [移动开发的最佳 React Native 替代方案](https://juejin.cn/post/7036615302007750692?searchId=20240306153831FE860597322AFA0BF4F4#heading-111)
- [思辨：移动开发的未来在哪？](https://juejin.cn/post/7292347319431790607?searchId=20240306153831FE860597322AFA0BF4F4)

**跨平台、跨端**

- 跨平台：指跨操作系统
- 跨端：指跨 web,ios,android,iot 设备

## 移动开发细分领域

- 混合开发和跨平台框架
- Framework 和 Kernel
- 逆向安全
- 音视频
- 移动 Web
- 嵌入式

**个人的一些思考**

> 1.AIGC+移动端
>
> 2023 年的 AIGC 的火热空前绝后，它带来的影响是非常深远的，甚至能够变革整个互联网行业，很多产品可能将会以新的思路去重构和延伸，这里面就会产生相应的在移动端和 AIGC 结合相关产品和业务，公司层面也会有相应的投入意愿，这也许会给我们带来新的机会。
>
> 2.元宇宙：VR/AR/XR
>
> 元宇宙虽然被炒概念，一直不温不火的，但这里面涉及的技术是比较前沿的，在游戏领域跟元宇宙的结合，如果能找到愿意投入企业，未尝不是一个不错的方向。
>
> 3.IoT 物联网
>
> 万物互联方向，比如智能家居，智能创新硬件产品，类似小米 IoT 相关的产品，智能手环、扫地机器人等等。这里面也有庞大的市场需求，另外软硬件结合对开发人员要求更高，更接近底层。
>
> 4.新能源车载系统
>
> 新能源车的其中一个核心就是**智能中控**，比如特斯拉的中控系统是 Linux，比亚迪还有蔚小理和大多数造车新势力用的是 Android 系统，这里面也有很多车载系统应用的需求，也是很多人都求职热门方向。
>
> 5.音视频技术领域
>
> 当下流行的短视频，涉及到的核心就是**音视频技术**，有这方面的技术积累的同学应该也能获得不错的发展机会，而且这方面的人才相对而言比较稀缺。
>
> 6.跨平台技术
>
> 从企业降本的角度，未来可能会更倾向招聘懂跨平台开发的，希望能统一技术栈能够实现多端发布的能力。比如 Flutter、React Native、UniApp 等。
>
> 7.鸿蒙 OS 应用开发
>
> 国产替代是个很深远的话题，卡脖子问题现在越演越烈，从软件产业我们跟漂亮国还存在很多差距，我们能够正视这些差距并且迎头突围是一个非常值得敬佩和骄傲的事情。鸿蒙 OS 有望成为第一个完全去 Android 化的操作系统，Mate60 系列手机产品我认为是一个标志性里程碑，我们不谈什么遥遥领先，我相信 Z 国一定会越来越好，鸿蒙 OS 应用开发也是我觉得有较好前景的方向。

## 移动跨平台

跨平台方案可以分为三个时代：

> - Web 容器时代：包括 Cordova、Ionic 和[微信小程序](https://cloud.tencent.com/product/tcb?from_column=20065&from=20065)。主要采用的是原生应用内嵌浏览器控件 WebView 的方式进行 HTML5 页面渲染，并定义 HTML5 与原生代码交互协议，将部分原生系统能力暴露给 HTML5，从而扩展 HTML5 的边界。这类交互协议，就是我们通常说的 JS Bridge。
> - 泛 Web 容器时代：采用类 Web 标准进行开发，但在运行时把绘制和渲染交由原生系统接管的技术，代表框架有 React Native、Weex 和快应用等。
> - 自绘引擎时代：自带渲染引擎，客户端仅提供一块画布即可获得从业务逻辑到功能呈现的多端高度一致的渲染体验。Flutter，是为数不多的代表。

移动端跨平台主要需求：

- 桌面端跨移动端：桌面向移动端过渡的早期，希望 PC Web 与移动 Web 复用同一套代码。
- Native 跨 Web：一套功能差不多的 Web 页能够在端外访问，需要跨 Native App 与 Web。
- 跨系统双端：出于开发效率等原因，希望 Android、iOS 双端复用一套业务代码，这也是目前主要的需求点。

未来需求：

- 跨[小程序](https://cloud.tencent.com/product/tcb?from_column=20065&from=20065)/轻应用：即用即走的轻量级应用，如各平台的小程序、 Android 快应用、iOS App Clips。
- 跨 IoT 设备：各种有显示屏的设备都会成为新的入口，如车载设备、智能电视等。

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

**PWA**是 web App 的进化型，`PWA（Progressive Web App，渐进式增强 Web 应用）`。它不是一门技术，而是一个概念，他的意思就是使用多种技术来增强 Web App 的功能

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

| 优点                                                       | 缺点                                                            |
| ---------------------------------------------------------- | --------------------------------------------------------------- |
| 跨平台，开发简单，学习成本低                               | WebView 性能低下时，用户体验差，反应慢                          |
| 框架多，插件多，可自定义插件                               | 国外的框架，中文文档资源少                                      |
| 发展最早，社区资源丰富                                     | 调试不方便，既不像原生那种调试，也不像纯 web 那种热重载式的调试 |
| 相同代码通过编译就能跑在各平台，大大提高了多平台开发的效率 | App store 相关政策存在风险？                                    |

**Ionic**

Ionic 是一个开源的移动应用程序开发框架，它可以轻松地使用 web 技术构建高质量的跨平台的移动应用。

**VasSonic**

腾讯开发的产品，专注于提升页面首屏加载速度，完美支持静态直出页面和动态直出页面，兼容离线包等方案

## **语言编译转换:Xamarin**

Xamarin 是一个开放源代码平台，用于通过 .NET 构建适用于 iOS、Android 和 Windows 的新式高性能应用程序。 Xamarin 是一个抽象层，可管理共享代码与基础平台代码的通信。 Xamarin 在提供便利（如内存分配和垃圾回收）的托管环境中运行。

## **原生渲染：React Native,Weex,Dcloud**

**React Native**

React Native (简称 RN)是 Facebook 于 2015 年 4 月开源的跨平台移动应用开发框架,支持 iOS 和安卓.

| 优点                                                         | 缺点                                                                            |
| ------------------------------------------------------------ | ------------------------------------------------------------------------------- |
| 复用了 React 的思想，有利于前端开发者涉足移动端。            | 做不到 Write once, Run everywhere                                               |
| 能够利用 JavaScript 动态更新的特性，快速迭代。               | 不能做到完全屏蔽 iOS 端或 Android 的细节                                        |
| 相比于原生平台，开发速度更快，相比于 Hybrid 框架，性能更好。 | 由于 Objective-C 与 JavaScript 之间切换存在固定的时间开销，所以性能必定不及原生 |

**Weex**

Weex 是 alibaba 于 2015 年推出的一款跨平台开发框架,支持 Android、iOS 和 Web。目前支持 Vue.js 和 Rax 框架的完善开发。

| 优点                             | 缺点                                              |
| -------------------------------- | ------------------------------------------------- |
| 国内团队开发，中文文档齐全       | 动画实现、API 丰富程度及事件机制上略逊于 RN       |
| Vue 作为前端开发语言，学习成本低 | 不支持横竖屏切换                                  |
| 与 RN 不同，Weex 的框架较轻      | 阿里将其捐赠给 Apache，后续维护频率低（KPI 产品） |

**Dcloud（uni-app）**

uni-app 是一个使用 Vue.js 开发所有前端应用的框架，开发者编写一套代码，可发布到 iOS、Android、Web（响应式）、以及各种小程序（微信/支付宝/百度/头条/QQ/钉钉/淘宝）、快应用等多个平台。

uni-app 是双渲染引擎，在 App 端内置了一个 webview 和一个基于 weex 改进的原生渲染引擎，提供了原生渲染能力。

在 App 端：

- 如果使用 vue 页面，则使用 webview 渲染
- 如果使用 nvue 页面(native vue 的缩写)，则使用原生渲染

## **自渲染：Flutter**

Flutter 是 Google 开源的 UI 工具包，帮助开发者通过一套代码库高效构建多平台精美应用，支持移动、Web、桌面和嵌入式平台。

| 类型           | Cordova                 | Xamarin                 | React Native            | Weex                      | Uniapp                  | Flutter                       |
| -------------- | ----------------------- | ----------------------- | ----------------------- | ------------------------- | ----------------------- | ----------------------------- |
| 性能           | 低                      | 高                      | 较高                    | 中                        | 高                      | 高                            |
| 上手难度       | 容易                    | 较高                    | 较高                    | 容易                      | 容易                    | 中                            |
| 核心           | JavaScript              | .NET                    | React                   | Weex                      | vue                     | Dart                          |
| 框架轻重       | 轻                      | 较重                    | 较重                    | 较轻                      | 轻                      | 重                            |
| 特点           | 适合单页面              | 适合开发整体 App        | 适合开发整体 App        | 适合单页面                | 适合开发整体 App        | 适合开发整体 App              |
| 社区           | 活跃度较低              | 活跃度低                | 活跃度高，Facebook 维护 | 活跃度中，目前托管 apache | 活跃度高，Dcloud 维护   | 活跃度高，Google 维护         |
| 支持平平台实现 | JS 引擎解释执行 JS 代码 | JS 引擎解释执行 JS 代码 | JS 引擎解释执行 JS 代码 | JS 引擎解释执行 JS 代码   | JS 引擎解释执行 JS 代码 | Dart 代码编译成目标机器码     |
| 适应性         | Web 开发学习成本低      | .NET C#工程师开发       | Web 开发学习成本低      | Web 开发学习成本低        | Web 开发学习成本低      | Java、C++、C#、开发学习成本低 |

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

# 移动端H5-vant

主要针对移动端H5和微信小程序

## 招投标手机版

**参考**

> - [个人github仓库](https://github.com/fuyunjinglong/web-mobile/tree/web-mobile-vant)

**前言**

> 按照750设计稿，flexible的1rem是75px，如果是vw，100vw是750px，那么1px就是0.1333333vw，75px就是10vw。

**项目介绍**

基于Vite+Vue3+TS+Pinia+VueUse框架，实现招中标业务流程分发，企业数据咨询，机会点跟踪，帮助企业快速识别业务需求落地。

**负责内容**

> - 首页(发现、企业、进展、订阅、我的)，其中发现包括顶部搜索和过滤数据，企业包括查询企业信息，机会包括机会空间跟踪和招标审核，订阅包括企业订阅，我的包括收藏和待处理已处理电子流。
> - 项目信息详情
> - 机会点分发电子流审批：分发-确认-复核-结束

**项目难点**

> - 性能优化瓶颈：复杂组件渲染压力，在低端设备dom节点过多导致卡顿，引入van-pull-refresh实现下列刷新
> - 兼容性适配：需处理Android 4.4以下旧版本WebView的CSS/JS兼容问题，常需引入polyfill或牺牲部分特性
> - 打包策略调整：若未正确配置按需加载，可能造成冗余代码，需依赖babel-plugin-import插件优化
> - 使用router-view插槽，结合keepAlive实现组件缓存
> - 使用router.beforeEach路由守卫，实现路由权限拦截
> - 使用Transition过度标签实现左右滑动动态效果
> - 大量使用vant内置组件，如：van-tabs，van-tabbar,van-list，van-back-top，van-dialog，van-dropdown-menu，van-loading，van-action-sheet，van-search

> - 在使用van-search时发现，顶部的筛选展开时，手滑顶部会左右滚动，通过这个禁用手触摸事件，所以顶部div增加headTabCont.vue-@touchstart.stop="()=>{return;}"
> - Clamp.vue：超过两行中间显示省略号
> - 缓存home页面即home页面的底部公共组件，但不缓存home的子路由页面。:key="route.fullPath.includes('home') ? '/home' : route.fullPath"

**项目亮点**

> - Vant作为一款轻量级、高性能的移动端Vue组件库,平均体积小于1KB
> - 组件生态完善，遵循移动端交互规范，支持响应式布局
> - 支持高度定制化主题和暗黑模式可配置
> - 跨平台与多框架支持，支持Vue 2、Vue 3、React、微信小程序、支付宝小程序等

**搭建Vite+Vue3+TS+Pinia+VueUse**

安装vite脚手架工具，选择ts,pnina,vue-router

> npm create vue@latest 

引入vant,sass,vue-use

> npm i vant sass @vueuse/core 

组件按需引入

> npm i @vant/auto-import-resolver unplugin-vue-components unplugin-auto-import -D

引入vant.css

> /main.js
> import "vant/lib/index.css";

采用Viewport 布局，通过 postcss-px-to-viewport-8-plugin插件将px自动转为vh和vw视窗单位

[vite4项目中，vant兼容750适配](https://blog.csdn.net/qq_29484537/article/details/135429954)

> npm install postcss-px-to-viewport-8-plugin -D

```
/vite.config.js
import AutoImport from "unplugin-auto-import/vite";
import Components from "unplugin-vue-components/vite";
import { VantResolver } from "@vant/auto-import-resolver";
import postcsspxtoviewport8plugin from "postcss-px-to-viewport-8-plugin";
  plugins: [
    AutoImport({
      resolvers: [VantResolver()],
    }),
    Components({
      resolvers: [VantResolver()],
    }),
  ],
  css: {
    postcss: {
      plugins: [
        postcsspxtoviewport8plugin({
          unitToConvert: "px",
          viewportWidth: (file) =>
            (file && file.includes("node_modules/vant")) > 0 ? 375 : 1240,
          unitPrecision: 5, // 单位转换后保留的精度
          propList: ["*"], // 能转化为vw的属性列表
          viewportUnit: "vw", // 希望使用的视口单位
          fontViewportUnit: "vw", // 字体使用的视口单位
          selectorBlackList: ["ignore-"], // 需要忽略的CSS选择器，不会转为视口单位，使用原有的px等单位。
          minPixelValue: 1, // 设置最小的转换数值，如果为1的话，只有大于1的值会被转换
          mediaQuery: true, // 媒体查询里的单位是否需要转换单位
          replace: true, //  是否直接更换属性值，而不添加备用属性
          exclude: [], // 忽略某些文件夹下的文件或特定文件，例如 'node_modules' 下的文件
          include: [], // 如果设置了include，那将只有匹配到的文件才会被转换
          landscape: false, // 是否添加根据 landscapeWidth 生成的媒体查询条件 @media (orientation: landscape)
          landscapeUnit: "vw", // 横屏时使用的单位
          landscapeWidth: 1628, // 横屏时使用的视口宽度
        }),
      ],
    },
  },
```

