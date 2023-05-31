---
title: SSR服务端渲染
date: 2022-05-19 07:33:16
categories:
- D_框架和类库
toc: true # 是否启用内容索引

---

# 渲染的客户端与服务端

![image-20220520065208264](/img/image-20220520065208264.png)

# 六种前端渲染模式

客户端逻辑越重，初始化需要执行的 JS 越多，首屏性能就越慢，因而出现了*更多的渲染模式*探索。

[Google开发者大会对于前端渲染的介绍](https://link.juejin.cn/?target=https%3A%2F%2Fdevelopers.google.com%2Fweb%2Fupdates%2F2019%2F02%2Frendering-on-the-web%23server-vs-static)

## CSR

CSR（Client-side rendering），即客户端渲染，是指用 JS 直接在浏览器里渲染页面，*包括数据请求、视图模板、路由在内的所有逻辑都在客户端处理*.

渲染流程如下图：

<img src="/img/image-20220520065347571.png" alt="image-20220520065347571" style="zoom: 50%;" />

P.S.其中出现的 FCP 与 TTI 是两个重要的性能指标：

- FCP（First Contentful Paint）：用户所请求的内容在屏幕上可见的时间点
- TTI（Time To Interactive）：页面可交互的时间点

主要缺陷在于随着应用程序的更新迭代，*客户端所要执行 JS 代码量越来越多*，前置的第三方类库/框架、polyfill 等都会在一定程度上拖慢首屏性能，在（中低端）移动设备上尤为明显

Code splitting、lazy-load等优化措施能够缓解一部分，但优化空间相对有限，无助于从根本上解决问题

此时，只有改变渲染模式才能创造更多的可能性。

**简而言之，SSR强在首屏渲染。而CSR强在用户和页面多交互的场景。**

## SSR前言

SSR（Server-Side Rendering）前后端分层之前很长的一段时间里都是以服务端渲染为主（JSP、PHP），在服务端生成完整的 HTML 页面：

省去了客户端二次请求数据的网络开销，以及渲染视图模板的性能负担。与 CSR 相比，其 FCP、TTI 通常会更快：

<img src="/img/image-20220520065454057.png" alt="image-20220520065454057" style="zoom:50%;" />

P.S.另一方面，服务端的网络环境要优于客户端，内部[服务器](https://cloud.tencent.com/product/cvm?from=10680)之间通信路径也更短

因为页面逻辑（包括即时数据请求）和模板渲染工作都放在服务端完成，减少了客户端的 JS 代码量，流式文档解析（streaming document parsing）等浏览器优化机制也能发挥其作用，在低端设备和弱网情况下表现更好。但*在服务器上生成页面同样需要时间*，会导致页面内容响应时间（TTFB, Time to First Byte）变慢

一种办法是可以通过流式 SSR、组件级缓存、模板化、HTML 缓存等技术来进一步优化

另一种办法是继续在渲染模式上探索，采用静态渲染（Static Rendering）

<img src="/img/image-20220520070208555.png" alt="image-20220520070208555" style="zoom:67%;" />

**SSR 的困境**

SSR 那么优秀，但是为什么却没能成为 Web 主流的开发模式呢，我想这是因为构建 SSR 应用并不容易：

- 但当你开始开发一个 SSR 应用时，就已经不在是一个简单的前端开发工程师了，而将被迫成为全栈工程师。交付产物从原来的 JS  Bundle 变成了 Node 应用，随之而来的是，需要选型一个 Node 框架，搭建一个 Node 应用，并且应对性能开销、保障应用稳定性等等。

- 其次，还需要考虑如何让现有的前端代码跑到 Server 端上，虽然类似 React 这些主流的框架都提供了 Server 端渲染的能力，但是，不同端上渲染原理和执行环境的差异，会导致编码上的很多差异，比如在 Node 端调用了 window 变量，那么就会报错了，同样的 Hooks 之类的异步更新机制在 Server 端也不适用。

- 最后，当你完成应用的开发，还需要考虑这些问题：如何部署环境、如何负载均衡、如何应对服务器宕机、如何应对用户请求峰值等等

因此，虽然 SSR 在性能上完胜 CSR ，但却因为其高昂的开发和维护成本，使人们转而投向 CSR 的怀抱。

**三大框架**

React、Vue和Angular分别对应Next、Nuxt和Nest

## Static Rendering

将生成 HTML 页面的工作放到编译时，而不必在请求带来时动态完成。为每个 URL 预先单独生成 HTML 文件，并进一步借助[CDN](https://cloud.tencent.com/product/cdn?from=10680)加速访问：

<img src="/img/image-20220520065547435.png" alt="image-20220520065547435" style="zoom: 33%;" />

P.S.SSR 第一部分的 Server Rendering 渲染工作变成了 Streaming 传递静态 HTML 文件

静态渲染也并非完美，其关键问题在于*“静态”*：

- 需要为每个 URL 单独生成一份 HTML 文件：对于无法预知所有可能的 URL，或者存在大量不同页面的网站，静态渲染就不那么容易，甚至根本不可行
- 只适用于偏静态内容：对于动态的、个性化的内容作用不大

另外，还有个与静态渲染相似的概念，叫预渲染（Prerendering）

## Prerendering

主要区别在于，静态渲染得到的页面已经是可交互的，无需在客户端额外执行大量 JS 代码，而*预渲染必须经客户端渲染才真正可交互*：

也就是说，禁用 JS 后，静态渲染的页面几乎不受影响，而预渲染的页面将只剩下超链接之类的基本功能

## Rehydration

Rehydration： “启动”客户端上的JavaScript视图，以便它们重用服务器渲染的HTML的DOM树和数据。

Rehydration 模式将 CSR 与 SSR 结合起来了，*服务端渲染出基本内容后，在客户端进行二次渲染（Rehydration）*：

<img src="/img/image-20220520065738032.png" alt="image-20220520065738032" style="zoom:67%;" />

<img src="/img/image-20220520065816717.png" alt="image-20220520065816717" style="zoom: 67%;" />

注意`bundle.js`仍然是*全量的 CSR 代码*，这些代码执行完毕页面才真正可交互。因此，这种模式下，FP（First Paint）虽然有所提升，但 TTI（Time To Interactive）可能会变慢，因为在客户端二次渲染完成之前，页面无法响应用户输入（被 JS 代码执行阻塞了）

对于二次渲染造成交互无法响应的问题，可能的优化方向是增量渲染（例如React Fiber），以及渐进式渲染/部分渲染

## Trisomorphic Rendering

如果把Service Worker也考虑进来的话，还有一种*涉及三方的渲染模式*：

> SSR + CSR + ServiceWorker rendering = Trisomorphic Rendering

<img src="/img/image-20220520065940915.png" alt="image-20220520065940915" style="zoom:67%;" />

首先通过流式 SSR 渲染初始页面，接着由 Service Worker 根据路由规则，借助 SSR 渲染出目标 HTML 页面：

主要优势在于能够跨三方共享模板渲染和路由控制逻辑：

**总结**

![image-20220520070032107](/img/image-20220520070032107.png)

# SSR

参考

- [SSR的利与弊](http://www.ayqy.net/blog/ssr-pros-and-cons/#articleHeader0)
- [2020 SSR落地开花的三大机遇](http://www.ayqy.net/blog/2020-ssr/)

## 两大优势

**性能**

与 CSR（Client-side rendering）模式相比：

- 网络链路
  - 省去了客户端二次请求数据的网络传输开销
  - 服务端的网络环境要优于客户端，内部服务器之间通信路径也更短
- 内容呈现
  - 首屏加载时间（FCP）更快
  - 浏览器内容解析优化机制能够发挥作用

**可访问性**

- 对人：古老、特殊的用户设备，比如禁用了 JavaScript
- 对机器人：爬虫程序等，典型的，搜索引擎SEO、爬虫

## 六大难题

### **难题 1：如何利用存量 CSR 代码实现同构**

为了降级、复用、降低迁移成本等目的，通常会采用一套 JavaScript 代码跨客户端、服务端运行的同构方式来实现 SSR，然而，要让现有的 CSR 代码在服务端跑起来，先要解决诸多问题。

> - 客户端依赖：分为 API 依赖和数据依赖两种，比如`window/document`之类的 JS API、设备相关数据信息（屏幕宽高、字体大小等）
> - 生命周期差异：例如 React 中，`componentDidMount`在服务端不执行
> - 异步操作不执行：服务端组件渲染过程是同步的，`setTimeout`、`Promise`之类的都等不了
> - 依赖库的适配：React、Redux、Dva 等等，甚至还有第三方库等不确定能否跑在 universal 环境，是否需要跨环境共享状态，以状态管理层为例，SSR 要求其 store 必须是可序列化的
> - 两边共享状态：每一份需要共享的状态都要考虑（服务端）如何传递、（客户端）如何接收

### **难题 2：服务的稳定性和性能要求**

与客户端程序相比，服务端程序对稳定性和性能的要求严苛得多，例如：

> - 稳定性：异常崩溃、死循环
> - 性能：内存/CPU 资源占用、响应速度（网络传输距离等都要考虑在内）

高可用的 SSR 服务却绝非易事，如何应对大流量/高并发，如何识别故障，如何降级/快速恢复，哪些环节需要加缓存，缓存如何更新。

### **难题 3：配套设施的建设**

SSR 最核心的部分是渲染服务，但除此之外还要考虑：

> - 本地开发套件（校验 + 构建 + 预览/HMR + 调试）
> - 发布流程（版本管理）

### **难题 4：钱的问题**

引入 SSR 渲染服务，实际上是在网络结构上加了一层节点，而大流量所过之处，每一层都是钱：

### **难题 5：hydration 的性能损耗**

客户端接到 SSR 响应之后，为了支持（基于 JavaScript 的）交互功能，仍然需要创建出组件树，与 SSR 渲染的 HTML 关联起来，并绑定相关的 DOM 事件，让页面变得可交互，这个过程称为 hydration。

hydration 所需加载、执行的 JavaScript 代码不见得比 CSR 模式少多少，这部分工作在客户端执行，受限于用户设备的性能，在较差的设备下可能会造成可感知的不可交互时间：

> - CSR：可交互但是没有数据（还在异步请求数据，可能会持续很长）
> - SSR：有数据但是不可交互（拉到 JS 后开始 hydrate 的过程，能看到内容但是不可交互，一般不会持续很长）

### **难题 6：数据请求**

服务端同步渲染要求先发请求，拿到数据后才开始渲染组件，那么面临 3 个问题：

> - 数据依赖要从业务组件中剥离出来
> - 缺失客户端公参（包括 cookie 等客户端会默认带上的 header 信息）
> - 两边数据协议不同：服务端可能有更高效的通信方式，比如 RPC

目前主流的 CSR 模式下，数据依赖与业务组件存在紧耦合，要由服务端发起的数据请求全都掺杂在组件生命周期函数中，剥离数据依赖意味着需要同时改造 CSR 代码。公参、数据协议等差异对代码复用、可维护性也提出了一些新的挑战。

## 三大机遇

### **第一大机遇：Serverless**

> 无服务器计算（serverless computing）将服务器相关的配置管理工作统统交给云供应商去做，以减轻用户管理云资源的负担

对云计算用户而言，Serverless 服务能够（自动）弹性伸缩而无需显式预配资源，不仅免去了云资源的管理负担，还能够按使用情况计费，这一特点在很大程度上解决了“难题 4：钱的问题”：引入 SSR 渲染服务，实际上是在网络结构上加了一层节点，而大流量所过之处，每一层都是钱。将组件渲染逻辑从客户端改到服务器执行，势必会增加成本，但有望通过 Serverless 将个中成本降到最低。

> 另一方面，[Serverless Computing](http://www.ayqy.net/blog/serverless-computing/)的关键是 FaaS（Function as a Service），由云函数提供常规计算能力：直接运行后端代码，而无需考虑服务器等计算资源以及服务的扩展性、稳定性等问题，甚至连日志、监控、报警等配套设施也都开箱即用

也就是说，喂给 FaaS 一个 JavaScript 函数，就能上线一个高可用的服务，无需操心如何承载大流量（几万 QPS）、如何保障服务稳定可靠……听起来有些跨时代是么，实际上，AWS Lambda、阿里云 FC、腾讯云 SCF 都已经是成熟的商业产品

无状态的模板渲染工作尤其适合用云函数（输入 React/Vue 组件，输出 HTML）来完成，“难题 2：服务的稳定性和性能要求”最关键的后端专业性问题迎刃而解，SSR 面临的技术难题从一个高可用的组件渲染服务缩小到了一个 JavaScript 函数中：与客户端程序相比，服务端程序对稳定性和性能的要求严苛得多。

FaaS 基础设施解决了大部分的性能问题和可用性问题，函数内的稳定性问题可通过纯前端手段解决，至于剩下的响应速度、缓存/缓存更新问题，则需要引入另一个云计算概念——边缘计算。

***边缘计算***

> 所谓的边缘计算，就是将计算和数据存储分布到离用户更近的（[CDN](http://www.ayqy.net/blog/cdn/)）节点（或者叫边缘服务器，Edge server）上，节省带宽的同时更快响应用户请求

像传统 CDN 通过缩短静态内容与最终用户之间的物理距离来加速资源访问，同时减少了应用服务器的负载一样，支持边缘计算的 CDN 允许将云函数部署到边缘节点中，加速服务响应，同时依托 CDN 轻松控制缓存策略，甚至能够实现动静分离的边缘流式渲染（ESR）。

截图：http://www.ayqy.net/blog/2020-ssr/

### **第二大机遇：low-code**

如果说 FaaS 解决了 SSR 落地最核心的服务可用性问题，给 SSR 插上了双翼，那么[low-code](http://www.ayqy.net/blog/low-code-frontend/)则是让 SSR 得以冲向天际的助飞跑道

因为low-code 几乎解决了其余的所有难题：

- 难题 1：如何利用存量 CSR 代码实现同构
- ~~难题 2：服务的稳定性和性能要求~~
- 难题 3：配套设施的建设
- ~~难题 4：钱的问题~~
- 难题 5：hydration 的性能损耗
- 难题 6：数据请求

**难题 1：如何利用存量 CSR 代码实现同构**

首先，low-code 模式不同于源码开发，现有的 CSR 代码无法直接迁移到 low-code 平台上来，其次，low-code 配置化的开发模式提供了天然的细粒度逻辑拆分和完整的精细控制力，体现在：

- 细粒度逻辑拆分：各个生命周期函数独立配置
- 完整的精细控制力：依赖库、生命周期、异步操作、共享状态严格受控，low-code 平台全权控制所填代码的编译时、运行时环境

总之，low-code 轻松解决了源码开发模式下棘手的如何约束写法、如何管控不确定性的问题。

**难题 3：配套设施的建设**

> SSR 最核心的部分是渲染服务，但除此之外还要考虑：
>
> - 本地开发套件（校验 + 构建 + 预览/HMR + 调试）
> - 发布流程（版本管理）
>
> 一整套的工程设施，在 SSR 模式下都需要重新考虑

这些配套设施是 SSR 要解决的问题，low-code 也面临同样的问题，因此，SSR 能够在一定程度上复用 low-code 提供的在线研发链路支持，只对其部分环节进行扩展，降低配套设施建设的成本

**难题 5：hydration 的性能损耗**

组件作为一层抽象，在提供模块化开发、组件复用等工程价值的同时，也带来了一些问题。典型的，交互逻辑与组件渲染机制绑定在了一起，这是 SSR 需要 hydration 的根本原因：

> 客户端接到 SSR 响应之后，为了支持（基于 JavaScript 的）交互功能，仍然需要创建出组件树，与 SSR 渲染的 HTML 关联起来，并绑定相关的 DOM 事件，让页面变得可交互，这个过程称为 hydration

也就是说，只要仍然依赖组件这层抽象，hydration 的性能损耗就无可避免。在源码开发模式下，组件无可替代，因为没有与之等价的抽象描述形式。然而，在 low-code 模式下，其输出产物（配置数据）也是一种抽象描述形式，如果能够具有与组件同等的表达力，就完全有可能去掉组件这层抽象，不必再背负 hydration 的性能损耗

另一方面，对于无交互（纯静态展示）、弱交互（静态展示带埋点/跳转）的偏静态场景，low-code 平台也能准确地识别出来，避免不必要的 hydration。

**难题 6：数据请求**

> 服务端同步渲染要求先发请求，拿到数据后才开始渲染组件，那么面临 3 个问题：
>
> - 数据依赖要从业务组件中剥离出来
> - 缺失客户端公参（包括 cookie 等客户端会默认带上的 header 信息）
> - 两边数据协议不同：服务端可能有更高效的通信方式，比如 RPC

low-code 开发模式下，数据依赖以配置化的形式录入，天然剥离，客户端公参、数据协议等均可通过 low-code 平台来配置，比如配 HTTP、RPC 两套协议，按环境自动选用。

### 第三大机遇：5G 网络环境

移动时代早期，离线 H5 是业界最佳实践，因为在线页面意味着秒级的加载时间，离线页面有着巨大的加载速度优势

但随着网络环境的发展，离线页面的加载速度优势已经不再是决定性因素（小程序的大爆发足以说明问题），在线页面的动态化特性备受关注，（SSR 无能为力的）离线场景越来越少，SSR 的用武之地越来越多

# Vue-SSR实战

## Vue_SSR服务端渲染Demo

**package.json**

```
{
  "name": "ssr1",
  "version": "0.1.0",
  "private": true,
  "scripts": {
    "serve": "vue-cli-service serve",
    "build": "vue-cli-service build",
    "lint": "vue-cli-service lint"
  },
  "dependencies": {
    "core-js": "^3.6.5",
    "express": "^4.17.1",
    "vue": "^2.6.12",
    "vue-router": "^3.4.6",
    "vue-server-renderer": "^2.6.12"
  },
  "devDependencies": {
    "@vue/cli-plugin-babel": "~4.5.0",
    "@vue/cli-plugin-eslint": "~4.5.0",
    "@vue/cli-service": "~4.5.0",
    "babel-eslint": "^10.1.0",
    "eslint": "^6.7.2",
    "eslint-plugin-vue": "^6.2.2",
    "vue-template-compiler": "^2.6.11"
  },
  "eslintConfig": {
    "root": true,
    "env": {
      "node": true
    },
    "extends": [
      "plugin:vue/essential",
      "eslint:recommended"
    ],
    "parserOptions": {
      "parser": "babel-eslint"
    },
    "rules": {}
  },
  "browserslist": [
    "> 1%",
    "last 2 versions",
    "not dead"
  ]
}
```

**index.template.html**

```
<html>
  <head>
    <!-- 使用双花括号(double-mustache)进行 HTML 转义插值(HTML-escaped interpolation) -->
    <title>{{ title }}</title>

    <!-- 使用三花括号(triple-mustache)进行 HTML 不转义插值(non-HTML-escaped interpolation) -->
    {{{ meta }}}
  </head>
  <body>
    <!--vue-ssr-outlet-->
  </body>
</html>
```

一、简单的Vue实例渲染成html字符串，不再加载Vue.js等文件

```js
// 第 1 步：创建一个 Vue 实例，注意这里没有el
const Vue = require('vue');
const app = new Vue({
  data: {
    hello: 'Hello World',
  },
  template: `<div><h1>{{hello}}</h1></div>`,
});

// 第 2 步：创建一个 renderer,用于将客户端的Vue实例与服务端数据混合处理
const renderer = require('vue-server-renderer').createRenderer();

// 第 3 步：renderer将 Vue 实例渲染为 HTML，并返回给前端页面
renderer
  .renderToString(app)
  .then(html => {
    console.log(html);
  })
  .catch(err => {
    console.error(err);
  });
//结果标记为服务端渲染 <div data-server-rendered="true"><h1>Hello World</h1></div>
```

二、简单的Vue实例指定模板文件，并传递context上下文变量渲染成html

```js
const Vue = require('vue');
//读取需要渲染的模板文件
const template = require('fs').readFileSync('./index.template.html', 'utf-8');
//服务端renderer支持引入模板文件
const renderer = require('vue-server-renderer').createRenderer({
  template,
});
//上下文变量，供renderer进行读取写入变量
const context = {
  title: 'vue ssr',
  meta: `
        <meta name="keyword" content="vue,ssr">
        <meta name="description" content="vue srr demo">
    `,
};

const app = new Vue({
  data: {
    hello2: 'Hello World222222222',
  },
  //此处会替换模板文件标记的 <!--vue-ssr-outlet-->位置
  template: `<div><h1>{{hello2}}</h1></div>`,
});

//服务端renderer支持引入上下文变量
renderer
  .renderToString(app, context)
  .then(html => {
    console.log(html);
  })
  .catch(err => {
    console.error(err);
  });
//结果为：
/*
<html>
  <head>
    <!-- 使用双花括号(double-mustache)进行 HTML 转义插值(HTML-escaped interpolation) -->
    <title>vue ssr</title>
    <!-- 使用三花括号(triple-mustache)进行 HTML 不转义插值(non-HTML-escaped interpolation) -->
        <meta name="keyword" content="vue,ssr">
        <meta name="description" content="vue srr demo">
  </head>
  <body>
    <div data-server-rendered="true"><h1>Hello World222222222</h1></div>
  </body>
</html>
*/
```

三、简单的Vue实例通过express模块渲染成html并在页面显示

```js
const Vue = require('vue');
const server = require('express')();

const template = require('fs').readFileSync('./index.template.html', 'utf-8');

const renderer = require('vue-server-renderer').createRenderer({
  template,
});

const context = {
  title: 'vue ssr',
  meta: `
        <meta charset="UTF-8">
        <meta name="keyword" content="vue,ssr">
        <meta name="description" content="vue srr demo">
    `,
};

server.get('*', (req, res) => {
  const app = new Vue({
    data: {
      url: req.url,
    },
    template: `<div>访问的 URL 是： {{ url }}</div>`,
  });

  renderer.renderToString(app, context, (err, html) => {
    if (err) {
      res.status(500).end('Internal Server Error');
      return;
    }
    res.end(html);
  });
});

server.listen(8080, () => {
  console.log('服务启动成功');
});
//浏览器地址栏输入http://localhost:8080/PageRenderingCase
```

四、简单的Vue实例结合router路由渲染页面，切换路由也是服务端处理返回html文件

```js
const server = require('express')();
//读取数据和需要填充到<!--vue-ssr-outlet-->占位符的内容
const createApp = require('./app.js');
const template = require('fs').readFileSync('./index.template.html', 'utf-8');

const renderer = require('vue-server-renderer').createRenderer({
  template,
});

const context = {
  title: 'vue ssr',
  meta: `
        <meta charset="UTF-8">
        <meta name="keyword" content="vue,ssr">
        <meta name="description" content="vue srr demo">
    `,
};

const getData = function() {
  return new Promise((reslove, reject) => {
    let str = 'this is a async data!';
    reslove(str);
  });
};

server.get('*', async (req, res) => {
  let appServer;
  try {
    const ctx = {
      url: req.url,
    };

    // 调用接口获取数据
    // 数据传递
    ctx.propsData = 'this is a data from props!';
    ctx.asyncData = await getData();

    appServer = await new Promise((reslove, reject) => {
      console.log(req.url);
      let { app, router } = createApp(ctx);
      router.push(req.url);

      //  router回调函数
      //  当所有异步请求完成之后就会触发
      //服务端匹配路由，匹配到则返回给客户端
      router.onReady(() => {
        let matchedComponents = router.getMatchedComponents();
        console.log(matchedComponents);
        if (!matchedComponents.length) {
          return reject({
            code: 404,
          });
        }
        reslove(app);
      }, reject);
    });
  } catch (error) {
    console.log(error);
  }
  renderer.renderToString(appServer, context, (err, html) => {
    if (err) {
      res.status(500).end('Internal Server Error');
      return;
    }
    res.end(html);
  });
});

server.listen(8080, () => {
  console.log('服务启动成功 http://127.0.0.1:8080');
});

```

其他文件

**app.js**

```js
const Vue = require('vue');
const createRouter = require('./router');

module.exports = context => {
  const router = createRouter();
  const app = new Vue({
    router,
    data: {
      message: 'Hello,Vue SSR!',
      propsData: context.propsData,
      asyncData: context.asyncData,
    },
    template: `
            <div>
                <h1>{{message}}</h1>
                <p>{{asyncData}}</p>
                <p>{{propsData}}</p>
                <ul>
                    <li>
                        <router-link to="/">home</router-link>
                    </li>
                    <li>
                        <router-link to="/about">about</router-link>
                    </li>
                </ul>
                <router-view></router-view>
            </div>
        `,
  });
  return {
    app,
    router,
  };
};
```

**router.js**

```js
const vueRouter = require('vue-router');
const Vue = require('vue');

Vue.use(vueRouter);

module.exports = () => {
  return new vueRouter({
    mode: 'history',
    routes: [
      {
        path: '/',
        component: {
          template: `<h1>this is home page</h1>`,
        },
        name: 'home',
      },
      {
        path: '/about',
        component: {
          template: `<h1>this is about page</h1>`,
        },
        name: 'about',
      },
      {
        path: '/about1',
        component: {
          template: `<h1>this is about1 page</h1>`,
        },
        name: 'about1',
      },
    ],
  });
};
```

## Vue_SSR自定义

打包后，核心是生产客户端文件vue-ssr-client-manifest.json和服务端vue-ssr-server-bundle.json，然后访问地址栏。Nuxt解决方案本质也是这个逻辑。

编译脚本为：

```js
  "scripts": {
    "serve": "vue-cli-service serve",
    "build": "vue-cli-service build",
    "lint": "vue-cli-service lint",
    "build:client": "vue-cli-service build",
    "build:server": "cross-env WEBPACK_TARGET=node vue-cli-service build",
    "build:win": "npm run build:server && move dist\\vue-ssr-server-bundle.json bundle && npm run build:client && move bundle dist\\vue-ssr-server-bundle.json && move dist\\index.html . && node server.js"
  }
```

**vue.config.js**：配置打包编译

```js
const VueSSRServerPlugin = require('vue-server-renderer/server-plugin');
const VueSSRClientPlugin = require('vue-server-renderer/client-plugin');
const nodeExternals = require('webpack-node-externals');
const merge = require('lodash.merge');
const TARGET_NODE = process.env.WEBPACK_TARGET === 'node';
const target = TARGET_NODE ? 'server' : 'client';

module.exports = {
  configureWebpack: () => ({
    // 将 entry 指向应用程序的 server / client 文件
    entry: `./src/entry-${target}.js`,
    // 对 bundle renderer 提供 source map 支持
    devtool: 'source-map',
    target: TARGET_NODE ? 'node' : 'web',
    node: TARGET_NODE ? undefined : false,
    output: {
      libraryTarget: TARGET_NODE ? 'commonjs2' : undefined,
    },
    // https://webpack.js.org/configuration/externals/#function
    // https://github.com/liady/webpack-node-externals
    // 外置化应用程序依赖模块。可以使服务器构建速度更快，
    // 并生成较小的 bundle 文件。
    // externals: nodeExternals({
    //   // 不要外置化 webpack 需要处理的依赖模块。
    //   // 你可以在这里添加更多的文件类型。例如，未处理 *.vue 原始文件，
    //   // 你还应该将修改 `global`（例如 polyfill）的依赖模块列入白名单
    //   whitelist: [/\.css$/]
    // }),
    optimization: {
      splitChunks: {
        chunks: 'async',
        minSize: 30000,
        minChunks: 2,
        maxAsyncRequests: 5,
        maxInitialRequests: 3,
      },
    },
    plugins: [TARGET_NODE ? new VueSSRServerPlugin() : new VueSSRClientPlugin()],
  }),
  chainWebpack: config => {
    config.module
      .rule('vue')
      .use('vue-loader')
      .tap(options => {
        merge(options, {
          optimizeSSR: false,
        });
      });
  },
  // css不要分割打包
  css: {
    extract: false,
  },
};
```

**entry-client.js**

```js
import { createApp } from './main';
const { app, router, store } = createApp();
if (window.__INITIAL_STATE__) {
  //window.__INITIAL_STATE__全局数据，保存了后台返回的数据
  store.replaceState(window.__INITIAL_STATE__);
}
router.onReady(() => {
  // 添加路由钩子函数，用于处理 asyncData.
  // 在初始路由 resolve 后执行，
  // 以便我们不会二次预取(double-fetch)已有的数据。
  // 使用 `router.beforeResolve()`，以便确保所有异步组件都 resolve。
  router.beforeResolve((to, from, next) => {
    const matched = router.getMatchedComponents(to);
    const prevMatched = router.getMatchedComponents(from);

    // 我们只关心非预渲染的组件
    // 所以我们对比它们，找出两个匹配列表的差异组件
    let diffed = false;
    const activated = matched.filter((c, i) => {
      return diffed || (diffed = prevMatched[i] !== c);
    });
    console.log(activated);
    if (!activated.length) {
      return next();
    }

    // 这里如果有加载指示器 (loading indicator)，就触发

    Promise.all(
      activated.map(c => {
        if (c.asyncData) {
          return c.asyncData({ store, route: to });
        }
      })
    )
      .then(() => {
        // 停止加载指示器(loading indicator)

        next();
      })
      .catch(next);
  });

  app.$mount('#app');
});
```

**entry-server.js**

```js
import { createApp } from './main';

export default context => {
  console.log(context);
  return new Promise((resolve, reject) => {
    const { app, router, store } = createApp();

    router.push(context.url);

    router.onReady(() => {
      const matchedComponents = router.getMatchedComponents();
      if (!matchedComponents.length) {
        return reject({ code: 404 });
      }
      console.log(matchedComponents);
      // 对所有匹配的路由组件调用 `asyncData()`
      Promise.all(
        matchedComponents.map(Component => {
          if (Component.asyncData) {
            return Component.asyncData({
              store,
              route: router.currentRoute,
            });
          }
        })
      )
        .then(() => {
          // 在所有预取钩子(preFetch hook) resolve 后，
          // 我们的 store 现在已经填充入渲染应用程序所需的状态。
          // 当我们将状态附加到上下文，
          // 并且 `template` 选项用于 renderer 时，
          // 状态将自动序列化为 `window.__INITIAL_STATE__`，并注入 HTML。
          console.log(store.state);
          context.state = store.state;

          resolve(app);
        })
        .catch(reject);
    }, reject);
  });
};
```

**server.js**：启动服务，访问编译后文件的部署页面

```js
const serverBundle = require('./dist/vue-ssr-server-bundle.json');
const fs = require('fs');
const path = require('path');
const express = require('express');
const server = express();
// 渲染打包后的结果
const template = fs.readFileSync('./index.template.html', 'utf-8');
// 客户端的manifest.json
const clientManifest = require('./dist/vue-ssr-client-manifest.json');
const renderer = require('vue-server-renderer').createBundleRenderer(serverBundle, {
  template,
  clientManifest, // 渲染的时候， 可以找到客户端的js文件, 自动引入到html中
});

//引入静态文件  否则运行报错
server.use(express.static(path.resolve(__dirname, './dist')));

server.get('*', (req, res) => {
  const context = {
    title: 'ssr demo',
    url: req.url,
  };
  renderer.renderToString(context, (err, html) => {
    if (err) {
      console.log(err);
      res.status(500).end('Internal Server Error');
      return;
    }
    res.end(html);
  });
});

server.listen(8080, () => {
  console.log('已监听 localhost:8080');
});
```

## Nuxt框架

**基本原理**

nuxt 前端路由沿用了history模式，通过history.pushState 更改url，进而局部渲染组件（history router的实现思路是：监听页面中和路由有关的a标签点击事件，阻止默认的跳转行为，然后调用history.pushState()方法，让浏览器记住路由，然后手动更新相应视图。同时为了监听用户手点击浏览器的前进后退按钮，还需要监听popstate事件，动态的修改相应视图)

**Nuxt基本流程**

- 浏览器访问url
- 执行store中操作，发起请求数据等
- 执行中间件，包括读取nuxt.config.js,匹配layout布局，匹配路由和组件
- 动态路由检测，如_id.vue文件等
- 加载异步数据，取回数据，asyncData(),fetch()
- 页面渲染

**Nuxt路由**

基本路由，动态路由(_id.vue,page/123),嵌套路由，动态嵌套路由

**Vuex 状态树**

Nuxt.js 会尝试找到 src 目录（默认是应用根目录）下的 `store` 目录，如果该目录有多个文件存在，则自动进行合并

# SEO排名

**定义**

SEO（Search Engine Optimization），中文翻译为“**搜索引擎优化**”，从本质上来说，其实就是如何迎合搜索引擎的规则，使得网站在搜索结果中能有更好的排名。比如一个PDA行业网站，当用户输入“PDA数据采集器”，在没有进行SEO优化的情况下，也许这个网站排在第2页或者第3页之后，通过用户行为分析，我们得知，用户在搜索的时候，基本80%左右的用户在浏览完第一页之后就会放弃继续浏览，这样对一个公司来说，如何让你的网站排在尽可能靠前的位置，获得更多流量，就意味着能有更多展示公司产品和品牌的机会。简单一句话，SEO就是让网站，在搜索引擎自然排序中能尽量排在靠前的位置。

**参考**

[SEO禅专注SEO优化](https://www.seozen.top/seo-course-first-step.html)

[台湾加强网站SEO](