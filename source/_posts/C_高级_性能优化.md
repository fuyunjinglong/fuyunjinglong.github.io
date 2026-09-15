---
title: 性能优化
date: 2020-06-01 16:33:16
categories:
- C_高级
toc: true # 是否启用内容索引
---

参考：

- [Web Vitals](https://web.dev/learn-web-vitals/)
- [工作中如何进行前端性能优化(23 种优化+10 种定位方式](https://juejin.cn/post/6904517485349830670)
- [前端性能优化 24 条建议（2020）](https://juejin.cn/post/6892994632968306702)
- [写在 2021 的前端性能优化指南](https://juejin.cn/post/7020212914020302856)
- [前端性能优化实践](https://segmentfault.com/a/1190000041753539)

# 性能优化(最新)

## 大纲

```js
前端性能优化
│
├── 度量基准：LCP≤2.5s / INP≤200ms / CLS≤0.1（P75）
│             辅助：TTFB、FCP、TBT
│
├── 加载优化
│   ├── 构建：Vite/esbuild/Rolldown、代码分割、Tree-Shaking、持久化缓存
│   ├── 资源：AVIF/WebP、fetchpriority、srcset、preload、font-display
│   ├── 传输：HTTP/2/3 细化拆分、Brotli、103 Early Hints、CDN + 边缘
│   ├── 缓存：HTML 协商 + 静态资源 immutable + s-maxage
│   └── 导航：Speculation Rules 预渲染、preconnect
│
├── 渲染优化
│   ├── CSS：transform/opacity 动画、content-visibility、contain
│   ├── DOM：读写分离防布局抖动、批量更新、虚拟列表
│   ├── JS：消灭长任务（scheduler.yield）、Partytown、Worker
│   └── 框架：SSR/流式/RSC/Islands、懒加载、响应式精简
│
├── 监控采集
│   ├── 指标：web-vitals 库（onCLS/onLCP/onINP）
│   ├── API：PerformanceNavigationTiming + PerformanceObserver
│   └── 上报：navigator.sendBeacon
│
└── 工作流：DevTools 定位 → Lighthouse 评分 → PSI/CrUX 验证 → RUM 追踪
```



## **度量（Core Web Vitals）**

**一、定义**

三大核心指标衡量页面在 **P75 分位**下真实用户的表现，是 SEO 排名信号和业务体验基线：

| 指标    | 含义                                                    | 良好阈值    | 优化抓手                                              |
| ------- | ------------------------------------------------------- | ----------- | ----------------------------------------------------- |
| **LCP** | 最大内容绘制，衡量加载性能                              | **≤ 2.5s**  | TTFB、资源优先级、图片优化、SSR                       |
| **INP** | 交互到下次绘制，衡量交互响应性（2024-03-12 起取代 FID） | **≤ 200ms** | 减少长任务、拆分事件处理器、延迟非关键 JS             |
| **CLS** | 累积布局偏移，衡量视觉稳定性（取最大会话窗口分数）      | **≤ 0.1**   | 给媒体设置尺寸、预留动态内容空间、用 transform 做动画 |

**二、核心**

**关键区别**：FID 只测首次交互的输入延迟；INP 统计**整个生命周期内所有交互**，取最差值，且覆盖从事件触发到绘制下一帧的完整时长。INP 严苛得多——目前仍是三个指标中最容易不合格的一个。

**辅助指标**：**TTFB**（服务器响应速度，LCP 前置）、**FCP**（首屏内容出现）、**TBT**（实验室环境衡量主线程阻塞，与线上 INP 对应）。TTI 已逐步淡出推荐，由 TBT + INP 组合替代。

## **优化（加载 + 渲染）**

### 加载性能优化

**1.构建层**

> - **编译器与工具链**：优先使用 **Vite / esbuild / swc / Rolldown**，构建速度和产物优化远超传统 Webpack 配置调优。
> - **代码分割**：路由级懒加载为默认做法；结合 `splitChunks`/`manualChunks` 抽离 vendor；动态 `import()` 拆分非关键路径。
> - **摇树与压缩**：Tree-Shaking、Scope Hoisting 开启；生产环境用 Terser/SWC 压缩 JS，CSS 用 lightningcss/cssnano。
> - **持久化缓存**：构建工具的 persistent cache（Vite/Webpack 5 原生支持），二次构建提速显著。
> - **按需引入**：UI 库（如 antd/element-plus）使用自动导入插件，避免全量打包。

**2. 资源层**

**图片**是 LCP 的首要瓶颈：

| 类型        | 适用场景         | 说明                                            |
| ----------- | ---------------- | ----------------------------------------------- |
| **AVIF**    | 照片类首选       | 比 WebP 再省 20-30% 体积，通过 `<picture>` 降级 |
| **WebP**    | 通用替代 JPG/PNG | 全平台兼容，不是问题                            |
| **SVG**     | 图标/矢量        | 无损缩放，可内联                                |
| **JPG/PNG** | 兜底             | 仅在格式不支持时使用                            |

图片优化要点：

> - 使用 `srcset` + `sizes` 做响应式图片；`<picture>` 处理格式降级
> - **LCP 图片**加 `fetchpriority="high"` 提升加载优先级openreplay.com+1，并 `loading="eager"`（不要懒加载 LCP 图）
> - 非首屏图片 `loading="lazy"` + `decoding="async"`
> - 始终设置 `width`/`height` 或 CSS `aspect-ratio` 防止 CLS

字体：

> - `font-display: swap` 避免 FOIT；关键字体 `preload`
> - 使用 `size-adjust` / 可变字体减少多字重请求数

JS/CSS 加载：

> - 关键 CSS 内联，其余异步加载；`<script defer>`（保序、DOM 解析后执行）为默认，独立脚本用 `async`
> - `preload` 加载当前页关键资源；`prefetch` 空闲时加载下一页可能用的资源

**3.传输与协议层**

> - **HTTP/2/3**：多路复用让"合并文件、雪碧图"失去必要性。HTTP/2 下应**细化拆分模块**获得更优缓存粒度；HTTP/3（QUIC）进一步降低连接建立延迟，尤其改善弱网和移动端。
> - **Brotli 压缩**：静态资源优先用 `br`（比 gzip 小 15-25%），gzip 作为降级。
> - **103 Early Hints**：服务器在最终响应前先发送预加载提示，让浏览器在源站准备 HTML 的同时就开始加载 CSS/JS，对 TTFB 较长的场景提升明显。
> - **CDN + 边缘**：静态资源全量走 CDN；配合边缘计算（Edge SSR / Edge Function）把动态渲染也推向用户附近。

**4.缓存层**

> - **HTML**：`Cache-Control: no-cache`（每次协商），保证用户能拿到新版本入口。
> - **带 hash 的静态资源**：`Cache-Control: max-age=31536000, immutable`，文件内容变化时改文件名即可。
> - **CDN 边缘缓存**：用 `s-maxage` 与 `stale-while-revalidate` 提升命中率。
> - 协商缓存依赖 `ETag`/`Last-Modified`。

**5.导航加速（现代新增）**

> - **Speculation Rules API**：声明式指定预取或预渲染下一页导航，Chrome 支持后对多页应用和电商站点的 LCP 提升可达数百毫秒
> - **preconnect / dns-prefetch**：对关键第三方域名提前建立连接。

### 渲染性能优化

**1. CSS**

> - 动画只用 `transform` 和 `opacity`（走合成层，跳过 layout/paint）
> - 长列表/复杂区块使用 `content-visibility: auto` + `contain-intrinsic-size` 跳过屏外渲染
> - 控制选择器嵌套层级，避免通配符；利用可继承属性减少重复声明
> - `will-change` 谨慎使用，只在动画前提示，动画后移除

**2. DOM 与布局**

> - **避免布局抖动**：读写分离——先批量读取布局属性（`offsetHeight` 等），再批量写入；或使用 `requestAnimationFrame` 分帧
> - 批量 DOM 修改用 `DocumentFragment` 或框架的批量更新机制
> - 大列表用虚拟滚动

**3. JavaScript 与主线程**

> - INP 优化的核心是消灭长任务（>50ms 的任务）：
>   - 把大任务拆小块，用 `scheduler.yield()` 或 `setTimeout` 让出主线程
>   - 事件处理器只做同步必要工作，昂贵部分用 `requestAnimationFrame` 或 `requestIdleCallback` 延后
>   - 用 `isInputPending()` 在处理队列时优先响应输入
> - 第三方脚本：分析必要性、按需加载、`async`/`defer`、放在页面底部；用 **Partytown** 把第三方 JS 跑在 Web Worker
> - Web Worker 处理计算密集型任务，避免阻塞主线程

**4. 框架层**

> - **React**：`React.lazy` + Suspense、`useMemo`/`useCallback` 按需、React 19 的 Server Components 减少客户端 bundle、`useTransition` 降低更新优先级
> - **Vue 3**：`defineAsyncComponent`、`shallowRef`/`markRaw` 减少响应式开销、`v-memo` 缓存大块节点、`v-for` 加唯一 key
> - **SSR / 流式 SSR / RSC / Islands**：首屏由服务端渲染 + 流式传输，LCP 大幅改善；静态内容用 Islands 架构（Astro）只激活必要交互
> - `v-show` vs `v-if`：高频切换用 v-show，低频大块用 v-if

















## **监控（RUM + 实验室）**

### 指标采集

使用 **web-vitals 库**（v4+）获取标准化指标：

```js
import { onCLS, onLCP, onINP, onFCP, onTTFB } from 'web-vitals';

const report = (metric) =>
  navigator.sendBeacon('/analytics', JSON.stringify(metric));

onCLS(report); onLCP(report); onINP(report);
onFCP(report); onTTFB(report);
```

底层 API（用于深度分析或自研 SDK）：

```js
// 导航计时：替代已弃用的 performance.timing
const [nav] = performance.getEntriesByType('navigation');
const ttfb = nav.responseStart - nav.requestStart;
const load = nav.loadEventEnd - nav.startTime;

// LCP（用户首次交互前持续更新，取最后一个）
new PerformanceObserver((list, obs) => {
  const entries = list.getEntries();
  const lcp = entries[entries.length - 1];
  obs.disconnect();
}).observe({ type: 'largest-contentful-paint', buffered: true });

// INP / CLS 通过 Event Timing API 与 Layout Shift API 观察
```

### 上报

> - 首选 **`navigator.sendBeacon`**：异步、unload 时也能发送、可被浏览器合并请求
> - 兜底 `fetch(url, { keepalive: true })`；`<img>` 上报仅作极简兜底

### 工具链与工作流

推荐工作流：**Lighthouse/DevTools 本地定位 → 优化上线 → PSI/CrUX 验证 P75 → RUM 持续追踪回归**。

| 阶段                | 工具                               | 用途                                |
| ------------------- | ---------------------------------- | ----------------------------------- |
| 开发                | Chrome DevTools Performance/Memory | 瀑布图 + 火焰图定位长任务、内存泄漏 |
| 构建/发布前         | Lighthouse（CI 集成）              | 实验室评分与优化建议                |
| 线上验证            | PageSpeed Insights                 | 同时给出实验室 + CrUX 真实数据      |
| 真实用户监控（RUM） | CrUX / 自建 web-vitals SDK         | P75 分位数据，反映真实体验          |
| 持续监控            | Search Console CWV 报告            | 全站趋势与异常预警                  |



# 监控-ChromeDevTools

## Performance

![image-20211219215308332](/img/image-20211219215308332.png)

**一、Personmance面板简介**
三大区域：网页性能(总览图);网络面板(瀑布图)，主线程(火焰图)等。熟语：总览在瀑布下用火焰烤饼

> 总览图：**蓝色**：解析htmlLoading；**黄色**：js相关；**紫色**：渲染相关；绿色：绘制相关；
>
> 瀑布图：**蓝色**：html加载；**黄色**：js脚本资源加载；**紫色**：css资源加载；**绿色**：img等资源加载；**灰色**：api接口请求
>
> 火焰图：红色标记的为长任务

瀑布图

```
一个请求分为4段：
浅色线段：请求建立连接时间，从客户端发送请求到建立tcp连接，比如网络问题，nginx转发问题
浅色柱子TTFB：客户端请求第一个字节到客户端收到第一个字节的时间，比如：后台处理任务时间过长
深色柱子：客户端下载第一个字节到最后一个字节的时间
浅色线段：等待主线程处理时间即浏览器拿到所有资源到交给主线程处理的等待时间，比如：主线程有很多任务，某些js脚本执行时间过长
```

火焰图

```
脚本执行、样式计算、布局计算、绘制等等。
任务队列，每个任务又分为若然子任务，有红色箭头标记长任务，run time。找到最长的长任务，可能就是存在性能瓶颈的地方。
这个Task还不是Event Loop，表示当前主线程忙碌，无法响应用户交互。Run Microtasks 则确实是在一次任务的末尾执行的微任务。
Task之间的白色就是Idle空闲时间,可能是资源加载时间过长引起的。
当我们点开调用栈观察时，可以看到源码中的回调函数以及对应的源码位置。
比如：LongTask里有一个二维码绘制的函数drawQrCode。耗时比较久，但是其实只需要鼠标移入才需要显示的，没必要做到首页加载。
```

**二、面板详解**

![image-20211107232411254](/img/image-20211107232411254.png)

**区域1：网页性能总览图**
总览图包含 FPS（每秒帧数情况，越大越好）、CPU（CPU占用情况）、NET（网络资源情况）、HEAP（JS占用情况）一共四项指标。

**区域2：各项指标的区块图**

![image-20211107232617810](/img/image-20211107232617810.png)

```
1Network：表示每个服务器资源的加载情况，**瀑布图**。
main:表示每个task执行的时间，以及子任务的执行时间，**火焰图**，x轴表示时间轴，每个条形代表一个事件，越宽代表花费时间越长。y轴表示调用堆栈，高的事件调用低的事件。
2Frames：表示每幅帧的运行情况。
3Timings：上图中有 4 条虚线，分别表示如下。
（1）DCL（DOMContentLoaded）表示 HTML 文档加载完成事件。当初始 HTML 文档完全加载并解析之后触发，无需等待样式、图片、子 frame 结束。作为明显的对比，load 事件是当个页面完全被加载时才触发。
（2）FP（First Paint）首屏绘制，页面刚开始渲染的时间。
（3）FCP（First Contentful Paint）首屏内容绘制，首次绘制任何文本，图像，非空白canvas 或 SVG 的时间点。
（4）FMP（First Meaningful Paint）首屏有意义的内容绘制，这个“有意义”没有权威的规定，本质上是通过一种算法来猜测某个时间点可能是 FMP。有的理解为是最大元素绘制的时间，即同LCP（Largest Contentful Paint ）。
其中 FP、FCP、FMP 是同一条虚线，三者时间不一致。比如首次渲染过后，有可能出现 JS 阻塞，这种情况下 FCP 就会大于 FP。
（5）L（Onload）页面所有资源加载完成事件。
（6）LCP（Largest Contentful Paint ）最大内容绘制，页面上尺寸最大的元素绘制时间。
```

**区域3：数据统计与汇总**

**bottom-up**

执行的事件，可以看到各活动占用的时间。**Self Time** 表示直接花费的时间，**Total Time**表示在该活动和其所有子活动花费的时间。可以看到该事件是执行的微任务，包含了重新计算样式+布局+调用方法+[请求状态改变](https://www.w3school.com.cn/ajax/ajax_xmlhttprequest_onreadystatechange.asp)+解析html。

![image-20211107232703176](/img/image-20211107232703176.png)

**Call Tree**

调用树，查看[根活动](https://developer.chrome.com/docs/devtools/evaluate-performance/reference/#root-activities)（根活动是那些导致浏览器做一些工作的活动。例如，当单击一个页面时，浏览器会触发一个`Event`作为根 Activity 的 Activity。这`Event`可能会导致处理程序执行，等等。其在Main,call Tree 、Event Log都是最高级）。

**Event log**

浏览器在每一帧里，都会执行：

```js
Schedule Style Recalculation` -> `Recalculate Style` -> `Update Layer Tree` -> `Paint` -> `Composite Layers
```

```
- JavaScipt：JavaScript 实现动画效果，DOM 元素操作等。（Demo 3没有 js ，故这一步没有）
- Style（Schedule Style Recalculation、Recalculate Style）：确定每个 DOM 元素应该应用什么 CSS 规则，重新计算样式。
- Layout（Update Layer Tree）：计算每个 DOM 元素在最终屏幕上显示的大小和位置。由于 web 页面的元素布局是相对的，所以其中任意一个元素的位置发生变化，都会联动的引起其他元素发生变化，这个过程叫 reflow，即回流
- Paint（绘制）：在多个层上绘制 DOM 元素的的文字、颜色、图像、边框和阴影等。这个过程会触发对元素的绘制，rePaint，即重绘
- Composite（渲染层合并，Composite Layers）：按照合理的顺序合并图层然后显示到屏幕上。
```

**案例分析**

[google官方推出的性能案例](https://googlechrome.github.io/devtools-samples/jank/)

![image-20211012230610276](/img/2024-03-22_072758.png)

a.打开性能面板，进行录制

![image](/img/2024-03-29_065127.png)

b.开始分析

![image](/img/2024-03-22_073105.png)

根据调用时间，推断代码入口

![image](/img/2024-03-30_112159.png)

根据具体某个阶段，推断代码入口

![image](/img/2024-03-30_112520.png)

## Memory

**案例分析**

主要查看程序是否存在内存泄漏情况

```
<html>
    <head>
    </head>
<body>
    <h1>内存泄漏案例分析</h1>
    <div id="app">
        <button id="run">运行</button>
        <button id="stop">停止</button>
    </div>
</body>
<script >
    const arr =[]
    for(let i=0;i<200000;i++){
        arr.push(i)
    }
// let arr = new Array(20000).fill(1)
    let newArr=[]
    function run(){
        newArr = newArr.concat(arr)
    } 
    
    let clearRun
    document.querySelector('#run').onclick=function(){
        clearRun=setInterval(()=>{
            run()
        },1000)
    }
    document.querySelector('#stop').onclick=function(){
        clearInterval(clearRun)
    }
 </script>
</html>
```

a.打开内存面板，进行录制

![image](/img/20240322_1.png)

b.分析面板

![image](/img/20240322_2.png)

