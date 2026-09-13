---
title: 多端_移动端
date: 2022-05-10 06:33:16
categories:
- I_多端
toc: true # 是否启用内容索引
---

**参考**

> - [Flutter学习仓库](https://github.com/chinabrant/flutter_study)
> - [Github Flutter源码仓库](https://github.com/flutter/flutter)
> - [Flutter中文网](https://flutterchina.club/)

# 初级

## meta viewport 的作用

**一、定义**

> viewport 控制页面在移动浏览器中的可视区域和缩放行为。

**二、原理**

> 手机浏览器默认 viewport 宽度为 980px，页面会被整体缩小显示，字太小需要手动缩放。

**三、解决方案**

> - `width=device-width`：宽度等于设备宽度
> - `initial-scale`：初始缩放比例
> - `user-scalable=no`：禁止用户缩放（注意无障碍问题）

```js
<meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=no">
```

## 1px 边框问题

**一、定义**

> 由于 DPR（设备像素比）> 1，CSS 的 1px 被渲染成 2~3 物理像素，视觉上偏粗。

**二、原理**

> iPhone 的 DPR 为 2 或 3，`1px` 逻辑像素对应多个物理像素。

**三、解决方案**

> 方案对比：scaleY 只适合单边框；viewport 缩放最彻底但需 JS 动态计算；`border-image` / `box-shadow` 有缺陷，已少用。

```
/* 方案1：伪元素 + transform 缩放（主流） */
.border-1px::after {
  content: '';
  position: absolute;
  left: 0; bottom: 0;
  width: 100%;
  height: 1px;
  background: #ccc;
  transform: scaleY(0.5);
  transform-origin: 0 0;
}

<!-- 方案2：viewport 缩放（配合 rem 布局） -->
<meta name="viewport" content="width=device-width, initial-scale=0.5">
```

## 点击 300ms 延迟的原因

**一、定义**

> 早期移动浏览器为区分“单击”和“双击缩放”，点击后等待 300ms 判断是否双击。

**二、解决方案**

> 1. 声明 viewport（现代浏览器自动取消延迟）✅
> 2. `fastclick` 库 —— **原理**：在 `touchend` 时 `preventDefault()` 阻止默认事件，并手动派发 click

**三、优劣对比**

> fastclick 现已不常用，但它的原理仍是高频追问点。

## rem / vw 适配方案

**一、定义**

> rem 和 vw 都是相对单位，用于实现移动端等比自适应布局。

**二、定义**

> - `rem`：相对根元素 `font-size`，通过 JS 动态设置根字号实现缩放
> - `vw`：视口宽度的 1%，纯 CSS 无 JS

**三、解决方案**

```js
// rem 方案：1rem = 屏宽 / 10
document.documentElement.style.fontSize = 
document.documentElement.clientWidth / 10 + 'px';
```

```css
/* vw 方案：设计稿 375px，元素 40px，用 postcss-px-to-viewport 自动转换 */
.el { width: calc(40 / 375 * 100vw); }
```

**四、优劣对比**：

| 方案 | 优点           | 缺点                       |
| ---- | -------------- | -------------------------- |
| rem  | 兼容性好       | 依赖 JS，有闪屏/精度问题   |
| vw   | 纯 CSS、精度高 | 老设备不支持（现在可忽略） |

**加分项**：阿里 flexible 方案已官方宣布过时，现在主流是 `vw + postcss`。

## 触摸事件

**一、定义**

> 核心触摸事件有 `touchstart / touchmove / touchend / touchcancel`。

**二、原理**

事件对象包含三个触摸点列表：

> - `touches`：屏幕上所有触摸点
> - `targetTouches`：目标元素上的触摸点
> - `changedTouches`：触发本次事件的触摸点（**touchend 时只有它能拿到信息**）

**加分项**：`touchcancel` 的触发场景（来电、系统手势打断）；滑动/捏合手势需基于 touch 事件自行计算。

## 软键盘弹起问题

**一、定义**

> 软键盘会遮挡输入框，或导致 fixed 元素错位。

**二、原理**

> iOS 键盘弹起**不改变窗口高度**（页面整体被推上去），Android 会**压缩视口高度**，行为不一致。

**三、解决方案**

```js
// 输入框被遮挡：聚焦时滚动到可视区
input.addEventListener('focus', () => {
  setTimeout(() => input.scrollIntoView({ block: 'center' }), 300);
});

// iOS 键盘收起后底部留白：失焦时手动滚回
input.addEventListener('blur', () => window.scrollTo(0, 0));
```

**加分项**：`VisualViewport API` 是较新的标准方案，可精确获取键盘弹出后的可视区域。

## 点击穿透

**一、定义**

> 上层元素在 touch 事件中消失后，300ms 内的 click 落到了下层元素上。

**二、原理**

> 典型场景 —— “touchstart 关闭蒙层 → 浏览器又派发 click → 命中蒙层下方的按钮”。

**三、解决方案**

> 1. 蒙层关闭统一用 `click` 事件
> 2. 在 touchend 中调用 `e.preventDefault()`
> 3. 下层按钮延迟绑定事件

## 图片适配不同 DPR 屏幕

**一、定义**

> 根据 DPR 加载 1x/2x/3x 图，避免模糊或浪费流量。

**二、解决方案**

```js
<img src="img@1x.png" 
     srcset="img@2x.png 2x, img@3x.png 3x" alt="">

<picture>
  <source media="(min-resolution: 3dppx)" srcset="img@3x.png">
  <source media="(min-resolution: 2dppx)" srcset="img@2x.png">
  <img src="img@1x.png" alt="">
</picture>
```

**加分项**：WebP 体积减少 25%+；CDN 图片服务动态裁剪。

## safe-area 适配

**一、定义**

> iPhone X 之后的刘海屏和底部指示条需要避让，否则内容被遮挡。

**二、解决方案**

```js
<meta name="viewport" content="viewport-fit=cover">
```

```css
padding-bottom: constant(safe-area-inset-bottom); /* iOS 11.0-11.2 */
padding-bottom: env(safe-area-inset-bottom);      /* iOS 11.2+ */
```

**加分项**：四个方向的 `safe-area-inset-*`，吸底按钮的适配实践。

## 常用布局

**一、定义**

> 主流方案为 flex 为主、grid 为辅、rem/vw 控制尺寸。

**二、解决方案**

> - **Flex**：解决绝大多数一维布局场景
> - **Grid**：九宫格、复杂二维布局
> - **移动端特殊处理**：文本溢出省略、sticky 吸顶、`flex: 1` 的兼容写法

**加分项**：能说出 iOS Safari 上 flex 的一些兼容 bug（如 flex-basis 百分比问题）。

# 中级

## 性能优化

**一、加载层**

> - 路由懒加载、代码分割
> - 图片懒加载 + WebP + CDN 裁剪
> - 骨架屏替代 loading
> - HTTP 强缓存/协商缓存 + Service Worker

**二、渲染层**

> - 动画只用 `transform/opacity`
> - 长列表虚拟滚动
> - scroll/input 防抖节流

**三、资源层**

> - 中文字体子集化
> - 组件库按需引入

**加分项**：结合 Lighthouse 数据量化，说出优化前后对比（如首屏 3s → 1.2s）。

## 图片懒加载原理

**一、定义**

> 延迟加载视口外图片，节省流量、加快首屏。

**二、解决方案**

```js
// IntersectionObserver（推荐）
const observer = new IntersectionObserver((entries) => {
  entries.forEach(entry => {
    if (entry.isIntersecting) {
      const img = entry.target;
      img.src = img.dataset.src;
      observer.unobserve(img);
    }
  });
}, { rootMargin: '100px' }); // 提前 100px 预加载

document.querySelectorAll('img[data-src]').forEach(img => observer.observe(img));
```

**三、方案对比**

> scroll + `getBoundingClientRect`（需节流，兼容旧浏览器）vs IntersectionObserver（性能好，主流）。

**加分项**：原生 `loading="lazy"`；Chrome 的动态阈值策略（离视口越近阈值越小）。

## 滚动卡顿

**一、定义**

> - 长列表 DOM 过多
> - scroll 事件频繁触发重排
> - 大图、复杂样式重绘开销大

**二、解决方案**

> - scroll 回调节流 + `requestAnimationFrame`
> - **虚拟列表**：只渲染可视区 + 上下缓冲区 DOM

```css
/* GPU 加速 */
.animated { transform: translateZ(0); will-change: transform; }
/* iOS 惯性滚动 */
.scroll-box { -webkit-overflow-scrolling: touch; }
```

**加分项**：能讲虚拟列表实现原理（绝对定位 + transform 位移补偿 + 动态高度场景处理）。

## JSBridge是什么

**一、定义**

> JSBridge 是 H5 与原生之间的通信桥梁，实现双向调用。

**二、原理**

**H5 → Native**

> 1. URL Scheme 拦截（`jsbridge://method?params`）
> 2. **注入 API**（主流）：iOS 的 `window.webkit.messageHandlers`、Android 的 `addJavascriptInterface`

**Native → H5**

> - iOS：`evaluateJavaScript`
> - Android：`evaluateJavascript / loadUrl`

**加分项**：回调机制（callbackId 映射表）、Native 未注入完成时的消息队列、URL 白名单安全校验。

## 兼容问题

| 问题                                | 解决方案                      |
| ----------------------------------- | ----------------------------- |
| iOS `new Date('2024-01-01')` 为 NaN | 格式改为 `2024/01/01`         |
| iOS 输入框内阴影                    | `-webkit-appearance: none`    |
| 音视频自动播放被禁                  | 首次 touchstart 后触发 play() |
| 软键盘导致 fixed 错位               | 改 absolute 布局 + 内部滚动   |
| iOS 橡皮筋效果                      | `overscroll-behavior: none`   |
| 长按弹出系统菜单                    | `-webkit-touch-callout: none` |

**加分项**：使用 `browserslist + autoprefixer` 自动处理前缀；维护兼容性问题清单文档。

## 动画推荐 transform 而不是 top/left

**一、定义**

> - `top/left` 触发 **layout → paint → composite** 全流程
> - `transform` 只触发 **composite**，由合成器线程处理，不阻塞主线程

**二、代码**

```css
/* ❌ 每帧重排 */
@keyframes move { to { left: 100px; } }
/* ✅ 仅合成 */
@keyframes move { to { transform: translateX(100px); } }
```

**加分项**：能画出浏览器渲染流水线；`will-change` 滥用会增加内存；CSS 合成动画即使 JS 阻塞也不掉帧。

## 真机调试

**一、定义**

> 1. **iOS**：Safari 开发模式 + 数据线
> 2. **Android**：Chrome + `chrome://inspect`
> 3. **vconsole / eruda**：页面内嵌调试面板（生产环境记得关闭）
> 4. **Charles / Whistle**：抓包、mock 数据、断点
> 5. **微信**：微信开发者工具 Remote Debug

**加分项**：Whistle 的 mock 与代理实践、HTTPS 抓包证书配置。

## 下拉刷新和上拉加载

**一、定义**

> 基于 touch 事件监听手势，配合位移和状态机实现。

**二、原理**

> - 下拉刷新：`touchmove` 中计算位移（顶部时才生效）→ 释放后超过阈值触发刷新动画 → 数据回来后复位
> - 上拉加载：监听 scroll，滚动到底部（`scrollTop + clientHeight >= scrollHeight - buffer`）时请求下一页

**三、代码**

```js
// 阻止 iOS 橡皮筋干扰，touchmove 时用 transform 跟随手指
// 注意 Three 点：位移系数（0.5 阻尼感）、状态锁（防止重复请求）、touchcancel 兜底
```

**加分项**：提到直接使用成熟方案（better-scroll、vant-list），并说出自己实现时踩过的坑（如 iOS 橡皮筋导致的误触发）。

# 高级

## 输入 URL 到移动端页面渲染完成

**网络层**

> DNS → TCP → TLS → HTTP。移动端特点：**弱网环境**，需要考虑 DNS 劫持（HTTPDNS）、连接复用（HTTP/2、QUIC）。

**渲染层**

> 解析 HTML 构建 DOM → CSSOM → 渲染树 → Layout → Paint → Composite。移动端特点：**合成层爆炸会导致内存暴涨**（低端安卓机直接崩溃），需控制 `will-change` 和层数量。

**加分项**：能延伸到 **CRP（关键渲染路径）优化** —— 关键 CSS 内联、JS 异步化（async/defer）、资源优先级控制；以及移动端特有的**离线包 + 预加载**体系（美团/阿里方案）。

## 首屏秒开/弱网

**一、定义**

> 先定义指标 —— LCP < 2.5s，用 `web-vitals` + 上报体系建立监控看板。

**二、分层优化**

| 层级   | 手段                                                         | 关键词     |
| ------ | ------------------------------------------------------------ | ---------- |
| 网络层 | CDN、HTTP/2多路复用、QUIC（抗丢包）、HTTPDNS(解决 DNS 劫持和解析慢)、域名收敛 | 快         |
| 资源层 | 代码分割、Tree Shaking、Brotli、图片 WebP/AVIF、增量更新、数据压缩（Protobuf 替代 JSON） | 小         |
| 渲染层 | SSR / 预渲染、关键 CSS 内联、骨架屏                          | 早见       |
| 缓存层 | Service Worker 离线缓存、端内离线包                          | 不重复请求 |
| 预测层 | 预加载下一页资源（用户意图预测）                             | 抢跑       |

 弱网场景补充（问弱网时加这部分）

- 请求：超时设置 + **指数退避重试**
- 兜底：缓存数据优先展示、失败降级
- 体验：弱网提示、接口合并减少请求次数
- 测试：Charles 限速模拟弱网

**三、具体作答**

> - 问**秒开** → 五层框架 + 重点讲离线包和数据预取
>
>   能给出量化结果（“首屏从 3.2s 优化到 1.4s，转化率提升 x%”）；提到大厂的 **秒开方案**（离线包 + 数据预取 + 骨架屏直出）
>
> - 问**弱网优化** → 简略带过五层 + 重点讲重试/兜底/降级
>
>   能讲**弱网模拟测试**（Charles 限速、iOS Network Link Conditioner）；以及大厂的**多通道并发请求**（同接口多 IP 同时请求，取最快返回）。

## 虚拟列表

**一、定义**

> 只渲染可视区 + 缓冲区的 DOM，用总高度撑开滚动容器，模拟出完整列表。

**二、原理**

> 核心三要素：
> 1. 总容器高度 = itemHeight × total（撑开滚动条）
> 2. 可视区绝对定位，transform: translateY(起始偏移) 
> 3. 监听 scroll，计算 startIndex / endIndex，只渲染这个区间

**三、不定高场景（难点）**

> - **预估高度**：先按预估渲染，渲染后缓存真实高度（`getBoundingClientRect`）
> - 滚动时用**缓存的高度数组**二分查找定位 startIndex
> - 高度更新后修正总高度和偏移量，可能产生**滚动抖动**，需做偏移补偿

**四、方案对比**

> 自研 vs `react-window` / `vue-virtual-scroller`。

**加分项**：提到 scroll 分帧渲染、IntersectionObserver 判断可见性、以及 DOM 回收导致的白屏闪烁问题（缓冲区 + 快速滚动兜底 loading）。

## PWA 的核心能力

**一、定义**

> PWA 让 Web 应用具备接近原生的体验，核心是离线、推送、可安装。

**二、原理**

> 1. **Service Worker**：独立于主线程的代理脚本，可拦截请求实现缓存策略
> 2. **Manifest**：定义应用名、图标、启动方式，实现“添加到主屏幕”
> 3. **Push + Notification**：消息推送能力

**三、缓存策略**

```js
// Cache First：静态资源
// Network First：接口数据
// Stale While Revalidate：允许旧内容 + 后台更新（常用）
```

**四、最佳实践**

> - SW 作用域限制、HTTPS 强制要求
> - **SW 更新问题**：旧 SW 缓存导致页面不更新（需 `skipWaiting` + 版本管理）
> - iOS 对 PWA 支持残缺（推送 iOS 16.4+ 才支持）

**加分项**：能对比 PWA 与小程序、Hybrid 的架构取舍。

## Hybrid选型 

**一、定义**

| 维度     | H5     | Hybrid | RN        | Flutter  | 原生 |
| -------- | ------ | ------ | --------- | -------- | ---- |
| 体验     | 一般   | 一般   | 较好      | 接近原生 | 最好 |
| 开发效率 | 最高   | 高     | 高        | 高       | 低   |
| 动态化   | ✅ 天然 | ✅      | ✅（热更） | 部分支持 | ❌    |
| 性能     | 弱     | 弱     | 中        | 强       | 强   |

**二、选型原则**

> - 强交互/高性能页面（首页信息流、动画）→ 原生 / Flutter
> - 运营活动、频繁变更的业务 → H5（动态化优先）
> - 中等复杂度业务页 → RN

**加分项**：能讲自研 **Hybrid 容器设计** —— 离线包机制、JSBridge 协议设计、H5 与原生页面路由互通、灰度发布与兜底降级策略。

## 移动端监控体系

**一、定义**

> 监控体系 = 数据采集 + 上报 + 分析 + 告警，移动端需额外关注性能与异常。

**二、方案设计**

**采集维度**

> - **异常监控**：JS 错误（`window.onerror`、`unhandledrejection`）、接口错误、**资源加载失败**
> - **性能监控**：FP/FCP/LCP、接口耗时、卡顿（长任务检测 `PerformanceObserver`）
> - **行为监控**：PV/UV、用户行为回溯（录屏）

**上报策略（移动端特色）**

> - `sendBeacon` / img 打点，页面卸载时数据不丢
> - **采样上报 + 批量上报**，减少弱网下请求开销
> - 本地缓存失败数据，下次启动补报

**告警与归因**

> 错误聚类（source-map 还原）、阈值告警、版本对比。

**加分项**：sourcemap 管理、错误聚合指纹算法、用户行为栈还原定位问题路径。

## 排查内存泄漏

**一、定义**

> 1. **未清除的定时器 / 事件监听**（尤其 `resize/scroll`、SW 全局监听）
> 2. 闭包持有大对象
> 3. 全局变量累积
> 4. **单页应用路由切换**：组件销毁未清理副作用（最大来源）
> 5. 游离 DOM 引用

**二、排查方法**

> Chrome DevTools → Performance 面板录制 → 观察内存曲线（JS Heap 持续上涨）
> → Memory 面板 Heap Snapshot → 三次快照对比 → 查 Retained Size / Detached DOM

**加分项**：能演示“Detached DOM”定位过程；提到 `WeakMap/WeakRef` 减少强引用；团队层面用 ESLint 规则（如 hooks 依赖检查）预防。

## 小程序与 H5

**一、定义**

小程序是双线程架构，逻辑和渲染分离、Native 通信，**目的是安全和性能隔离**。代价是通信有开销，所以开发中要合并 setData、减少数据量。此外微信的 Skyline 引擎正用原生渲染替代 WebView。

> H5 的逻辑和渲染都在 WebView 一个线程里；小程序把**逻辑层和渲染层分开**，通过 Native 层通信。

**二、核心差异**

**1.线程模型不同**

> H5：   JS + 渲染 都在 WebView（同一个线程）
> 小程序：逻辑层(JSCore) + 渲染层(WebView) 分离，Native 中转

**2. JS 能力不同**

|          | H5       | 小程序               |
| -------- | -------- | -------------------- |
| 操作 DOM | ✅ 可以   | ❌ 不行，只能 setData |
| 运行环境 | 浏览器   | 微信客户端           |
| 页面跳转 | 自己控制 | Native 接管          |

**三、双线程的意义**

> **1. 安全**：逻辑层拿不到 DOM/BOM，微信能完全管控页面内容和跳转，审核才有效。
>
> **2. 性能**：JS 再卡也不会阻塞页面渲染。

**四、代价与优化**

通信要经过 Native，有开销，所以：

```js
// ❌ 频繁调用
this.setData({ list: newList });

// ✅ 合并 + 精准更新
this.setData({ 'list[2].status': 1 });
```



### 移动端H5 实现秒开

**一、定义**

> 秒开 = 让用户在 1s 内看到可交互页面，是加载优化 + 缓存体系 + 预测机制的综合工程。

**二、方案体系**

```js
┌─ 静态资源 ── 离线包（提前下发 zip + 增量更新 + 签名校验）
├─ 接口数据 ── 数据预取（点击前预测用户行为，提前请求）
├─ 渲染层  ── 骨架屏直出 / SSR / 客户端预渲染
├─ 网络   ── HTTPDNS + 链路复用
└─ 兜底   ── 离线包版本降级、异常上报
```

**三、原理**

> 离线包让静态资源走本地，省去网络请求；数据预取让接口请求与页面跳转**并行**而非串行。

**加分项**

> - 增量更新算法（diff 下载，节省流量）
> - 离线包的**拦截机制**（Native 拦截 URL 请求映射到本地文件）
> - 秒开率的统计口径（LCP or 自定义首屏标记）









# 移动端适配怎么解决

参考

- [2022 年移动端适配方案指南 — 全网最新最全](https://juejin.cn/post/7046169975706353701#heading-20)
- [响应式设计 - 理解设备像素、设备独立像素和 css 像素](https://link.juejin.cn?target=https%3A%2F%2Fwww.jianshu.com%2Fp%2F6b1f94bfa263)
- [移动前端开发之viewport的深入理解](https://link.juejin.cn?target=https%3A%2F%2Fwww.cnblogs.com%2F2050%2Fp%2F3877280.html)
- [使用 Flexible 实现手淘 H5 页面的终端适配](https://link.juejin.cn?target=https%3A%2F%2Fgithub.com%2Famfe%2Farticle%2Fissues%2F17)
- [VW: 是时候放弃 REM 布局了](https://link.juejin.cn?target=https%3A%2F%2Fwww.jianshu.com%2Fp%2Fe8ae1c3861dc)
- [lib-flexible](https://link.juejin.cn?target=https%3A%2F%2Fgithub.com%2Famfe%2Flib-flexible)
- [postcss-px-to-viewport](https://link.juejin.cn?target=https%3A%2F%2Fgithub.com%2Fevrone%2Fpostcss-px-to-viewport)
- [网页适配 iPhoneX](https://link.juejin.cn?target=https%3A%2F%2Faotu.io%2Fnotes%2F2017%2F11%2F27%2Fiphonex%2Findex.html)

方案如下：

> 1. meta viewport视口
> 2. 图片适配
> 3. 媒体查询
> 4. 动态rem方案

**1.meta viewport视口**

大多数PC网页的宽度为980px，如果不做移动端适配，文字会缩小的很小。device-width表示等于设备宽度，不写的化就变成默认的980了。initial-scale缩放比例为1。

```html
<head>
<meta names="viewport"content="width=device-width,initial-scale=1.0"
<title>测试</title>
</head>
```

**2.图片适配**

使用img{max-width:100%}，而不是img{width:100%}。后者在容器大于图片时，图片会无线拉伸。前者最大显示自身图片那么大。

**3.媒体查询**

```
@media screen and（min-width:1200px）{
 body{
  background-color:red;
 }
}
```

**4.动态rem方案**

px，em，rem有什么不同？

px时屏幕上显示像素的基本单位。em是一个相对大小，相当于父元素的font-size的百分比大小(如果使用的话，要一层层计算，太复杂)。rem也是相对大小，是相对于根元素的font-size。

每次开发框架时，开发只需要动态调整UI给的设计稿即可，即designWidth。然后如果高保真图片是500px的宽度，就写5rem。

```js
const designWidth = 750; // 设计稿宽度(每次开发框架时，开发只需要动态调整UI给的设计稿即可)
const baseFontSize = 100; // 基准 font-size
const clientWidth = docEl.clientWidth; // 当前屏幕宽度
// 一般设计稿宽度：750px -> 对应 html { font-size: 100px}即1rem=100px，100px只是方便计算，如果高保真图片是200px的宽度，就可以写2rem，实际是2rem*100px=200px
// 那么如果在小屏幕上375px -> 对应 html { font-size: 50px}即1rem=50px,如果高保真图片是200px的宽度，就可以写2rem，实际是2rem*50px=100px.刚好实现了等比例放缩，缩小一般。
document.documentElement.style.fontSize = (clientWidth/designWidth)*baseFontSize+'px'
```

优缺点比较

> 优点：
>
> 1. **完美等比缩放**：在任何尺寸的屏幕下，页面的视觉效果比例完全一致，不会出现布局错乱。
> 2. **兼容性好**：rem 单位兼容到 Android 2.1 / iOS 4.1，在几年前是万能解法。
> 3. **开发体验好**：配合构建工具，开发者可以继续在 CSS 里写 `px`，无感知地使用 rem。
>
> 缺点（也是现在逐渐被替代的原因）：
>
> 1. **依赖 JS**：必须加载一段 JS 脚本，如果 JS 被阻塞，页面可能会闪烁或错乱。
> 2. **字体不够优雅**：等比缩放意味着在小屏手机上字体变得很小（可能低于 12px 影响阅读），在大屏手机上字体会变得超大。现代网页更希望大屏看更多内容，而不是单纯的放大。
> 3. **1px 边框问题**：由于 rem 是等比缩放，在 2倍/3倍 屏幕上，写 `0.01rem` 渲染出来的物理像素可能不是真正的 1px，导致边框看起来变粗。

# React Native

**参考**

- [react native入门到实战](https://www.bilibili.com/video/BV1Pt4y1n7bD/?spm_id_from=333.337.search-card.all.click&vd_source=bd4c7d99d71adf64d6e88c65370e0247)

# Flutter

## 1.Flutter是什么?

- [Flutter官网](https://flutter.dev/)

Flutter是一款移动应用程序SDK，一份代码可以同时生成iOS和Android两个高性能、高保真的应用程序。

Flutter诞生过程：

- 2017 年 Google I/O 大会上，Google 首次推出了一款新的用于创建跨平台、高性能的移动应用框架——Flutter。
- 2018年2月，Flutter发布了第一个Beta版本，同年五月， 在2018年Google I/O 大会上，Flutter 更新到了 beta 3 版本。
- 2018年6月，Flutter发布了首个预览版本，这意味着 Flutter 进入了正式版（1.0）发布前的最后阶段。

## 2.Flutter优势

- 提高开发效率
  - 同一份代码开发iOS和Android
  - 用更少的代码做更多的事情
  - 轻松迭代
    - 在应用程序运行时更改代码并重新加载（通过热重载）
    - 修复崩溃并继续从应用程序停止的地方进行调试
- 创建美观，高度定制的用户体验
  - 受益于使用Flutter框架提供的丰富的Material Design和Cupertino（iOS风格）的widget
  - 实现定制、美观、品牌驱动的设计，而不受原生控件的限制

## 3.核心模块

<img src="/img/image-20220510071129446.png" alt="image-20220510071129446" style="zoom:67%;" />

Flutter包括一个现代的响应式框架、一个2D渲染引擎、现成的widget和开发工具。

**跨平台自绘引擎**

Flutter与其他用于构建App的大多数框架不同，因为Flutter既不使用WebView，也不使用平台（Android、iOS等）的原生控件。相反，Flutter使用自己的高性能渲染引擎来绘制Widget。这样不仅可以保证在Android和iOS平台上UI的一致性，而且也可以避免对原生控件依赖而带来的限制及高昂的维护成本。

Flutter使用Skia作为其2D渲染引擎，Skia是Google的一个2D图形处理函数库，包含字型、坐标转换以及点阵图都有高效能且简洁的表现，Skia是跨平台的，并提供了非常友好的API，目前Google Chrome浏览器和Android均采用Skia作为其绘图引擎，值得一提的是，由于Android系统已经内置了Skia，所以Flutter在打包APK（Android应用安装包）时，不需要再将Skia打入APK中，但iOS系统并未内置Skia，所以构建iPA时，也必须将Skia一起打包，这也是为什么Flutter APP的Android应用安装包比iOS应用安装包小的主要原因。

**高性能**

Flutter采用GPU渲染技术，Flutter编写的应用是可以达到120fps（每秒传输帧数），这也就是说，它完全可以胜任游戏的制作，而我们常说的RN的性能只能达到60fps，这也算是Flutter的一个超高竞争力，官方宣称Flutter甚至会超过原生性能。

Flutter高性能主要靠两点来保证：

- 首先，Flutter App采用Dart语言开发，Dart在JIT（即时编译）模式下，速度与JavaScript基本持平；而且Dart还支持AOT（提前编译）模式，当以AOT模式运行时，JavaScript便远远追不上了。速度的提升对高帧率下的视图数据计算很有帮助。
- 其次，Flutter使用自己的渲染引擎来绘制UI，布局数据等由Dart语言直接控制，所以在布局过程中不需要像RN那样通过JavaScriptCore在JavaScript和原生之间进行通信，这在一些滑动和拖动的场景下具有明显优势，因为在滑动和拖动过程中往往都会引起布局发生变化，所以JavaScript需要和原生之间不停的同步布局信息，这和在浏览器中要JavaScript频繁操作DOM所带来的问题是相同的，都会带来比较可观的性能开销。

**为什么Flutter采用Dart语言开发？**

- [为什么 Flutter 选择了 Dart 语言](https://juejin.cn/post/6870286147541696525)

介绍两个概念：JIT和AOT。

目前，程序主要有两种运行方式：静态编译和动态解释。

- 静态编译：静态编译的程序在执行前全部被翻译为机器码，通常将这种类型称为AOT（Ahead of time）即“提前编译”；
- 动态解释：动态解释的程序是在执行中一句一句边翻译边运行的，通常将这种类型称为JIT（Just-in-time）即“即时编译”。

AOT程序的典型代表是用C/C++开发的应用，它们必须在执行前编译成机器码，而JIT的代表则非常多，如JavaScript、Python等，事实上，所有脚本语言都支持JIT模式。但值得一提的是JIT和AOT指的是程序运行方式，它们和编程语言并非强关联，有些语言既可以以JIT方式运行也可以以AOT方式运行，如Java、Python，它们可以在第一次执行时编译成中间字节码，然后在之后执行时可以直接执行字节码，也许有人会说，中间字节码并非机器码，在程序执行时仍然需要动态将字节码转为机器码，是的，不过通常我们区分是否为AOT的标准就是看代码在执行之前是否需要编译，只要需要编译，无论其编译产物是字节码还是机器码，都属于AOT。

Dart和JavaScript比较：

1. 开发效率高

- 基于JIT的快速开发周期：Flutter在开发阶段采用JIT模式，这样就避免了每次改动都要进行编译，极大的节省了开发时间；（Dart运行时支持）
- 基于AOT的发布包：Flutter在发布时可以通过AOT生成高效的ARM代码以保证应用性能，而JavaScript则不具有这个能力。（编译器支持）

1. 高性能

   Flutter旨在提供流畅、高保真的UI体验。为了实现这一点，Flutter需要能够在每个动画帧中运行大量的代码，这意味着需要一种既能提供高性能的语言，又不会出现丢帧的周期性暂停，而Dart支持AOT，在这一点上可以做的比JavaScript更好。

2. 快速内存分配

   Flutter框架使用函数式流，这使得它在很大程度上依赖于底层的内存分配器。因此，拥有一个能够有效的处理琐碎任务的内存分配器将显得十分重要，如果Dart语言缺乏此功能，Flutter将无法有效地工作。当然Chrome V8的JavaScript引擎在内存分配上也已经做的很好了，事实上Dart开发团队的很多成员都是来自Chrome团队的，所以在内存分配上Dart并不能作为超越JavaScript的优势，但对于Flutter来说，它需要这样的特性，而Dart也正好满足而已。

3. 类型安全

   由于Dart是类型安全的语言，支持静态类型检测，所以可以在编译前发现一些类型的错误，并排除潜在问题，这一点对于前端开发者来说可能会更具有吸引力。与之不同的，JavaScript是一个弱类型语言，也因此前端社区出现了很多给JavaScript代码添加静态类型检测的扩展语言和工具，如：微软的TypeScript以及Facebook的Flow。相比之下，Dart本身就支持静态类型，就是它的一个重要优势。

4. Dart团队的支持

   由于有Dart团队的积极投入，Flutter团队可以获得更多、更方便的支持，正如Flutter官网所诉：“我们正与Dart社区进行密切合作，以改进Dart在Flutter中的使用。例如，当我们最初使用Dart时，该语言并没有提供生成原生二进制文件的工具链（工具链对于实现可预测的高性能具有很大的帮助），但是现在它实现了，因为Dart团队专门为Flutter构建了它。同样，Dart VM之前已经针对吞吐量进行了优化，但团队现在正在优化VM的延迟时间，这对于Flutter的工作负载更为重要。”



## 4.一切皆为widget

Widget是Flutter应用程序用户界面的基本构建块。每个Widget都是用户界面一部分的不可变声明。 与其他将视图、控制器、布局和其他属性分离的框架不同，Flutter具有一致的统一对象模型：widget。

Widget可以被定义为:

- 一个结构元素（如按钮或菜单）
- 一个文本样式元素（如字体或颜色方案）
- 布局的一个方面（如填充）
- 等等…

## 5.Flutter与React Native、Weex比较

React Native、Weex等一直存在一个问题，就是性能跟原生App存在很大的差异

**原生app**

苹果2008年发布iOS，Google 2009年发布Android，它们的SDK是基于两种不同的编程语言Objective-C 和 Jave.现在又有了Swift和Kotlin。

**WebViews**

最早的跨平台方案是基于JaveScript 和 WebView的，像PhoneGap、Cordova、Ionic等。

**React Native**

RN不仅桥接系统服务，也将系统UI也桥接到了JaveScript中，这样写出来的UI最终也会渲染成原生的控件。

**Flutter**

Flutter使用Dart语言开发，Dart可以被编译（AOT）成不同平台的本地代码，让Flutter可以直接和平台通讯而不需要一个中间的桥接过程，从而提高了性能。
