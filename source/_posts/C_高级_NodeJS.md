---
title: NodeJS
date: 2022-01-01 06:33:16
categories:
- C_高级
toc: true # 是否启用内容索引
---

# 初级

## NodeJS是什么

**一.定义**

Node.js 不是一门新语言，而是**基于 Chrome V8 引擎的 JavaScript 运行时环境**，让我们可以在服务端运行 JavaScript，并提供**事件驱动、非阻塞 I/O、单线程事件循环**等特性，非常适合构建高并发、I/O 密集型的网络应用。

**二、概念拆解**

**1. 从“能做什么”看**

Node.js 主要用来在**服务器端、命令行工具、脚本、后端服务**等场景运行 JavaScript，常见用途包括：

- Web 服务器 / API 服务（如 Express、NestJS 等）
- 实时应用（即时通讯、聊天室、协作工具）
- 代理服务、网关、API 聚合层
- 构建工具/脚手架（如 Webpack、Vite 等基于 Node 的工具链）
- Serverless 函数、后台任务、定时任务等

**2. 从“底层实现”看**

- Node.js 内部使用 **Chrome V8 引擎** 执行 JavaScript 代码（和 Chrome 浏览器用的是同一个 JS 引擎）。
- 在 V8 之上，Node.js 提供：
  - 一套**异步 I/O API**（文件、网络、子进程等）
  - **事件循环（Event Loop）** 和事件驱动架构
  - **模块系统**（CommonJS / ES Modules）
  - C++ 绑定，让 JS 可以调用底层系统能力（文件、网络、多线程等）

所以更准确地说：
**Node.js = V8 + 一组内置模块（http / fs / path / stream / …）+ 事件循环 + 模块系统 + C++ 扩展能力。**

**3. 从“运行特性”看**

- **单线程 + 事件循环**：主线程是单线程的，通过事件循环（event loop）管理异步任务，实现“并发处理多个请求”。
- **非阻塞 I/O**：文件读写、网络请求等 I/O 操作不会阻塞主线程，通过回调 / Promise / async-await 处理结果。
- **事件驱动架构**：很多内部模块（如 http、fs、stream）都是基于事件的（`EventEmitter`），通过监听和触发事件处理异步流程。

## NodeJS创建静态服务器

**一.定义**

静态服务器是指根据客户端的请求，从服务器磁盘中读取静态文件（如 HTML、CSS、JS、图片等），并通过 HTTP 协议返回给客户端的服务器。它不涉及动态数据的处理（如数据库查询、服务端渲染）。

**二.核心模块**

在 Node.js 中实现静态服务器，主要依赖以下核心原生模块：

- **`http`**：用于创建 HTTP 服务器，处理请求和响应。
- **`fs`**：文件系统模块，用于读取磁盘上的文件。
- **`path`**：路径处理模块，用于拼接路径，解决不同操作系统的路径分隔符兼容问题。
- **`url`**：(Node v8 之前常用) 用于解析请求路径；(Node v8 之后推荐使用 `new URL()` 或原生 `req.url` 配合 `path` 模块处理)。

**三.代码**

```js
const http = require('http');
const fs = require('fs');
const path = require('path');

const server = http.createServer((req, res) => {
    // 1. 获取请求路径，默认访问 index.html
    let pathname = req.url === '/' ? '/index.html' : req.url;
    
    // 2. 拼接文件在服务器中的实际路径
    // 假设静态资源存放在当前目录下的 'public' 文件夹
    const filePath = path.join(__dirname, 'public', pathname);

    // 3. 异步读取文件
    fs.readFile(filePath, (err, data) => {
        if (err) {
            // 文件不存在，返回 404
            if (err.code === 'ENOENT') {
                res.writeHead(404, { 'Content-Type': 'text/html; charset=utf-8' });
                res.end('<h1>404 Not Found</h1>');
            } else {
                // 服务器内部错误
                res.writeHead(500, { 'Content-Type': 'text/plain' });
                res.end('Server Error');
            }
        } else {
            // 4. 简单的 MIME 类型映射（加分项）
            const ext = path.extname(filePath);
            const mimeTypes = {
                '.html': 'text/html',
                '.css': 'text/css',
                '.js': 'application/javascript',
                '.png': 'image/png',
                '.jpg': 'image/jpeg'
            };
            const contentType = mimeTypes[ext] || 'application/octet-stream';

            // 5. 成功返回
            res.writeHead(200, { 'Content-Type': contentType });
            res.end(data);
        }
    });
});

server.listen(3000, () => {
    console.log('Server running at http://localhost:3000/');
});
```

**四.关键点解析与难点攻克**

**1. 路径安全处理**

- **问题**：直接使用用户输入的 URL 拼接路径可能导致目录穿越攻击。
- **解决**：必须使用 `path.join` 规范化路径，或者在读取前判断路径是否包含 `..` 跳出根目录。上述代码中 `path.join` 会自动处理相对路径，但在生产环境建议使用 `path.resolve` 结合 `startsWith` 校验文件是否在允许的目录内。

**2. MIME 类型识别**

- 浏览器需要根据 `Content-Type` 来解析文件。如果未设置或设置错误（例如将 CSS 文件返回为 `text/html`），页面样式会失效。
- 面试中应提到需要根据文件后缀名动态设置响应头，或者使用第三方库（如 `mime-types`）来处理复杂的 MIME 类型。

**3. 性能优化：流式处理**

- `fs.readFile` 会将整个文件读入内存，对于大文件（如视频、高清图）会占用大量内存，甚至导致服务器崩溃。
- **改进方案**：使用 `fs.createReadStream` 配合 `pipe` 方法。流式读取并分段发送，内存占用低。

**五.进阶优化**

**1. 缓存机制**
为了减少带宽浪费和服务器压力，应实现 HTTP 缓存策略：

- **强缓存**：设置 `Cache-Control` 或 `Expires` 头，让浏览器直接使用本地缓存。
- **协商缓存**：使用 `Last-Modified` / `If-Modified-Since` 或 `ETag`，配合 `304` 状态码，让服务器判断文件是否修改。

**2. 压缩传输**
对于文本文件（HTML, CSS, JS），可以使用 Node.js 的 `zlib` 模块进行 gzip 压缩。

- 判断请求头 `Accept-Encoding` 是否包含 `gzip`。
- 如果支持，设置响应头 `Content-Encoding: gzip`，并使用 `zlib.createGzip()` 转换流。

**3. Range 请求（断点续传）**
对于音视频文件，需解析请求头中的 `Range` 字段，返回状态码 `206 Partial Content`，支持分段请求。

**4. 与 Express/Koa 的对比**

- 原生实现适合理解底层原理。
- 实际开发中推荐使用 `express.static` 或 `koa-static` 中间件，它们已经内置了 MIME 类型检测、缓存、Range 支持等完善功能。

**总结**

Node.js 创建静态服务器的核心在于 **HTTP 模块搭建服务** 与 **FS 模块读取文件** 的结合。面试回答时，重点在于：**路径拼接的安全性**、**MIME 类型的正确设置**、以及**大文件场景下流式读取的优化**。

# 中级

## NodeJS的事件循环机制

**1.定义**

NodeJS 是单线程、非阻塞 I/O 的运行时。事件循环是 NodeJS 实现异步非阻塞 I/O 的核心机制。它负责协调同步代码执行、处理异步事件回调、执行定时器等，使 NodeJS 能够在单线程中处理大量并发请求。

**2.执行顺序**

> 1. **同步代码**（当前栈中的代码）
> 2. **`process.nextTick()`**（Node 独有，优先级最高）
> 3. **微任务**（Promise.then/catch/finally）
> 4. **宏任务**（事件循环的 6 个阶段）

**3.事件循环的 6 个阶段**

> 1. **Timers**：执行 `setTimeout` 和 `setInterval` 到期的回调。
> 2. **Pending Callbacks**：执行上一轮循环遗留下来的 I/O 异常回调（一般不需关注）。
> 3. **Idle/Prepare**：内部使用（忽略）。
> 4. **Poll**（核心）：获取新的 I/O 事件；**几乎所有的异步回调（除定时器、setImmediate、close）都在这里执行**。
> 5. **Check**：执行 `setImmediate` 的回调。
> 6. **Close Callbacks**：执行关闭事件的回调（如 `socket.destroy()`）。

**process.nextTick**

> - 不属于 Event Loop 的阶段。
> - 在**当前操作完成后**、**进入下一个 Event Loop 阶段之前**立即执行。
> - **优先级极高**，递归调用会导致 I/O 饿死。

**4.经典题**

```js
setTimeout(() => console.log('timeout'), 0);
setImmediate(() => console.log('immediate'));
```

- **情况一：在 I/O 回调中**：`setImmediate` 一定先于 `setTimeout`。因为在 I/O 回调后的阶段是 Check，下一轮循环才是 Timers。
- **情况二：在主模块中**：执行顺序不确定，取决于性能（CPU 耗时）。如果准备时间短，先执行 Timers；如果准备时间长，先执行 Check。

**5.Node 11 前后的区别**

> - **Node 10 及以前**：微任务在事件循环的各个阶段之间执行。
> - **Node 11 及以后**：微任务在**每个宏任务之后**立即执行，与浏览器行为趋同。

## NodeJS中的Stream(流)是什么

**1.定义**

流是一种抽象的数据处理方式，用于处理流式数据（如文件读写、网络请求）。它将数据分割成小块按需处理，而不是一次性加载到内存中。

**四种流类型：**

- `Readable`：可读流（如 `fs.createReadStream`）。
- `Writable`：可写流（如 `fs.createWriteStream`）。
- `Duplex`：双工流（可读可写）。
- `Transform`：转换流（读写过程中修改数据）。

**2.代码实现**

```js
const fs = require('fs');
const path = require('path');

// 传统方式（不推荐，占用大量内存）
// fs.readFileSync -> fs.writeFileSync

// 流式处理（推荐）
const rs = fs.createReadStream(path.join(__dirname, 'source.txt'));
const ws = fs.createWriteStream(path.join(__dirname, 'dest.txt'));

rs.pipe(ws); // pipe 方法自动管理流
```

**3.背压（Back Pressure）**

> **1. 问题场景：**
> 当可读流读取速度大于可写流写入速度时，数据会堆积在内存中（缓冲区），导致内存飙升（“爆仓”）。
>
> **2. 解决原理：**
>
> - `pipe` 方法内部自动处理了背压。
> - 如果写入过慢，可读流会触发 `pause` 事件暂停读取，等待可写流 `drain` 事件后继续读取。

```js
rs.on('data', (chunk) => {
    // 写入返回 false 表示缓冲区已满，应当暂停读取
    if (!ws.write(chunk)) {
        rs.pause();
    }
});

// 缓冲区清空后，继续读取
ws.on('drain', () => {
    rs.resume();
});
```

优化：

> - **`pipeline` 替代 `pipe`**：`stream.pipeline` 提供了更好的错误处理机制，避免管道断裂导致资源泄漏。
> - **Buffer 对象**：流底层的二进制数据容器，NodeJS 默认 Buffer 大小为 64KB。

## Node.js的多进程模型

**1.定义**

Node.js 虽然以**单线程、非阻塞 I/O** 著称，但这仅指 JavaScript 代码的执行部分。为了充分利用多核 CPU 资源，并解决单线程在处理 CPU 密集型任务时会阻塞的问题，Node.js 提供了完善的多进程模型。

> **Node.js 单线程瓶颈**：CPU 密集型任务（如加密、图片处理）会阻塞主线程。
>
> - 解决方案：
>   1. **Cluster 模块**：主进程负责监听端口，分发给多个子进程（Master-Slave 模型）。
>   2. **Worker Threads**：Node 10+ 引入，允许在同一个进程中开启多线程，共享内存，适合计算密集型任务。

Node.js 的多进程模型主要依赖于底层的 `libuv` 库，并在应用层通过内置的 `child_process` 和 `cluster` 模块来实现。

**2.优点**

> - **充分利用多核 CPU**：单线程只能使用一个 CPU 核心。多进程可以启动多个实例，将负载分摊到多个核心上。
> - **稳定性（容错）**：如果单线程程序崩溃，整个服务就宕机了。多进程模型中，如果某个子进程崩溃，主进程可以重新拉起一个新的子进程，保证服务高可用。
> - **隔离性**：进程之间内存隔离，一个进程的内存泄漏不会直接影响其他进程。

**3.核心模块：child_process**

> `child_process` 是 Node.js 最基础的进程创建模块。它提供了四个主要方法来创建子进程：
>
> - `spawn(command, args)`：
>   - 启动一个子进程来执行命令。
>   - 特点：流式处理输出，适合处理大量数据（如视频转码、大日志分析），不阻塞主进程。
> - `exec(command, callback)`：
>   - 启动一个 shell 并在 shell 中执行命令。
>   - 特点：将输出缓存起来，一次性传给回调函数。适合执行简单的 shell 命令，但有最大缓冲区限制（默认 1MB）。
> - `execFile(file, args, callback)`：
>   - 类似于 `exec`，但不启动 shell，直接执行指定的可执行文件，效率更高也更安全。
> - `fork(modulePath)`：
>   - `spawn` 的特例，专门用于创建 Node.js 子进程。
>   - 特点：**自带 IPC (Inter-Process Communication) 通道**，父子进程之间可以通过 `send()` 和 `on('message')` 进行通信。

**4.负载均衡模块：cluster**

> 如果你要构建一个 HTTP 服务器，手动用 `child_process` 创建多个进程并分配网络请求会非常麻烦。Node.js 提供了 `cluster` 模块来简化这个过程。
>
> `cluster` 模块的核心思想是 **主从模式**：
>
> - **Master 进程（主进程）**：负责管理 Worker 进程的创建、销毁和重启，以及监听网络端口（如 80/443）。
> - **Worker 进程（工作进程）**：负责处理具体的业务逻辑和请求。
>
> **工作原理（负载均衡）**：
> 在 Node.js v0.12 之前，所有 Worker 进程共同竞争accept请求，会导致“惊群效应”。后来 Node.js 引入了 **轮询调度机制**。主进程负责接收所有的客户端连接，然后依次（Round-Robin）将这些连接分发给空闲的 Worker 进程处理。
>
> Node.js 的多进程之间内存是独立的（无法共享全局变量），必须通过 IPC 机制通信。

**5.生产环境实践：PM2**

> 在实际生产环境中，通常不会手写 `cluster` 代码，而是使用进程管理器，最著名的是 **PM2**。
> PM2 封装了 `cluster` 模块，提供了以下开箱即用的功能：
>
> - 一键开启多进程模式：`pm2 start app.js -i max`（max 代表 CPU 核心数）。
> - 零停机重启：在更新代码时，PM2 会一个接一个地重启 Worker，保证服务不断线。
> - 日志管理、性能监控、异常自动重启。

**6.多进程 vs 多线程 (`worker_threads`)**

在 Node.js v10.5.0 之后引入了 `worker_threads` 模块，支持真正的多线程。

- **多进程**：开销大，内存隔离，通信需要序列化数据，更安全稳定。适合做负载均衡、微服务隔离。
- **多线程**：开销小，可以共享内存（通过 `SharedArrayBuffer`），适合处理 CPU 密集型计算任务（如图像处理、加解密），避免了创建新进程的巨大开销和 IPC 序列化开销。

**总结**

> Node.js 的多进程模型是应对单线程瓶颈的标准方案。通过 `child_process` 实现基础的任务派生与 IPC，通过 `cluster` 实现网络服务的多核负载均衡，再配合 PM2 等工具，Node.js 完全有能力构建高并发、高可用的企业级后端服务。

## Koa 与 Express 的区别

# 高级

# 大纲

**10套教程**

- Node.js+Express+Koa2 开发Web Server博客-video-慕课网mk
- [NestJS 从入门到进阶](https://www.bilibili.com/video/BV1GmAdzzEma/?spm_id_from=333.337.search-card.all.click&vd_source=bd4c7d99d71adf64d6e88c65370e0247)
- [Node基础-尚硅谷-video](https://www.bilibili.com/video/BV1gM411W7ex/?spm_id_from=333.337.search-card.all.click&vd_source=bd4c7d99d71adf64d6e88c65370e0247)/[千峰前端Node.JS基础](https://www.bilibili.com/video/BV1rA4y1Z7fd/?spm_id_from=333.337.search-card.all.click&vd_source=bd4c7d99d71adf64d6e88c65370e0247)
- Vue Element＋Node.js开发企业通用管理后台系统-video-mk
- Node.js-Koa2框架生态实战－从零模拟新浪微博-video-mk
- Node.js+Koa2+MySQL 打造前后端分离精品项目《旧岛》-小程序服务端-video-mk
- 中级-Vue3 + TS仿知乎专栏企业级项目-mk
- 高级-Vue3.0+TS打造企业级组件库-mk
- Vue核心技术（Vue+Vue-Router+Vuex+SSR）实战精讲-mk

# 初始化项目

```
npm init -y
```

# package版本(^和~)区别

```
~1.15.2 :=  >=1.15.2 <1.16.0     

^3.3.4 := >=3.3.4 <4.0.0
```

# Node入门

## NodeJS是什么

Node.js 是一个开源与跨平台的 JavaScript 运行时环境
在浏览器外运行 V8 JavaScript 引擎(Google Chrome 的内核)，利用事件驱动、非阻塞和异步输入输出模型等技术提高性能
可以理解为 Node.js 就是一个服务器端的、非阻塞式I/O的、事件驱动的JavaScript运行环境

> 非阻塞异步
>
> Nodejs采用了非阻塞型I/O机制，在做I/O操作的时候不会造成任何的阻塞，当完成之后，以时间的形式通知执行操作
> 例如在执行了访问数据库的代码之后，将立即转而执行其后面的代码，把数据库返回结果的处理代码放在回调函数中，从而提高了程序的执行效率

> 事件驱动
>
> 事件驱动就是当进来一个新的请求的时，请求将会被压入一个事件队列中，然后通过一个循环来检测队列中的事件状态变化，如果检测到有状态变化的事件，那么就执行该事件对应的处理代码，一般都是回调函数

## 应用场景

场景如下：善于I/O，不善于计算。因为Nodejs是一个单线程，如果计算(同步)太多，则会阻塞这个线程。大量并发的I/O，应用程序内部并不需要进行非常复杂的处理。与 websocket 配合，开发长连接的实时交互应用程序。

- 用户表单收集系统、后台管理系统、实时交互系统、考试系统、联网软件、高并发量的web应用程序
- 基于web、canvas等多人联网游戏
- 基于web的多人实时聊天客户端、聊天室、图文直播
- 单页面浏览器应用程序
- 操作数据库、为前端和移动端提供基于json的API

# windows环境安装

## 下载nodejs

官网下载https://nodejs.org/en/

## 安装及配置

最好安装到非系统盘，依赖后续会越来越大。

检查第一步安装是否成功

```
node -v
npm -v
都需要出现版本号
```

1.配置node全局引用和缓存

在node安装目录下创建node_global和node_cache文件夹

```
npm config set prefix D:\programFiles\node\node_global
npm config set cache D:\programFiles\node\node_cache
```

测试下配置是否生效

```
npm install -g vue
```

成功后在node_global和node_cache中出现对应vue文件

2.配置全局模块环境变量

先检查是否正确配置：

```
输入node进入交互界面，然后输入require('vue')
查看是否出现vue相关的指令或生命周期，出现则环境变量正确，否则需要配置环境变量
```

我的电脑-高级属性-环境变量下：

先配置用户变量，将原有的AppData\Roaming\npm修改为D:\programFiles\node\node_global

再配置系统变量，新建NODE_PATH,值为D:\programFiles\node\node_global\node_modules。接着在path中添加%NODE_PATH%

最后使用require('vue')检查是否最终安装成功

cnpm install -g @vue/cli全局安装

vue -V查看vuecli版本

vue init是vuecli2的初始化方式

vue create 是vuecli3的初始化方式

## 安装常见镜像

**npm清空缓存**

```
npm cache clean --force
```

**npm淘宝镜像**

```
npm config set registry https://registry.npmmirror.com，切换国内镜像，使用淘宝镜像

npm config get registry，查看当前镜像使用的地址，返回成功，则代表设置成功
```

**cnpm淘宝镜像**

```
npm install -g cnpm --registry=https://registry.npmmirror.com，安装cnpm

cnpm install xxx，使用cnpm安装所想要的包
```

cnpm安装依赖包的方式和npm是一样，只是npm的命令变成cnpm

以上两种模式的对比，cnpm在安装某些包的时候，package环境不是很正确，所以推荐使用npm安装淘宝镜像即可

## 卸载nodejs重装

0.npm cache clean --force 清除npm缓存

1.卸载程序卸载nodejs应用程序

2.删除以下文件夹下npm文件

C:\Program Files (x86)\Nodejs
C:\Program Files\Nodejs
C:\Users\{User}\AppData\Roaming\npm（或%appdata%\npm）
C:\Users\{User}\AppData\Roaming\npm-cache（或%appdata%\npm-cache）

3.检查您的%PATH%环境变量以确保没有引用Nodejs或npm存在。

4.重启

## 常见问题

**1.安装依赖报错npm EPERM mkdir**

使用cmd，管理员权限打开对话窗口

**2.出现unable to verify the first certificate**

npm config set strict-ssl false

**3.Error: EPERM: operation not permitted, mkdir...**

文件夹邮件，添加用户操作权限

<img src="/img/image-20220904121713944.png" alt="image-20220904121713944" style="zoom:67%;" />

## yarn安装

```
npm install -g yarn --registry=https://registry.npmmirror.com
yarn config get registry // 查看淘宝源是否正确
```

修改 yarn的全局安装位置和缓存位置

```
yarn config set global-folder "D:\nvm\nvm\yarn\global"
yarn config set cache-folder "D:\nvm\nvm\yarn\cache"
```

查看版本

```
yarn -v
```

yarn 常用命令

```
npm init === yarn init
npm install === yarn 或者 yarn install
npm install taco --save === yarn add taco
npm uninstall taco --save === yarn remove taco
npm install taco --save-dev === yarn add taco --dev
npm update --save === yarn upgrade
npm install taco@latest --save === yarn add taco
npm install taco --global === yarn global add taco
npm init --yes/-y === yarn init --yes/-y
npm link === yarn link
npm outdated === yarn outdated
npm publish === yarn publish
npm run === yarn run
npm cache clean === yarn cache clean
npm login === yarn login
npm test === yarn test
```

```
初始化项目:
yarn init // 同npm init，执行输入信息后，会生成package.json文件

yarn的配置项：
yarn config list // 显示所有配置项
yarn config get <key> //显示某配置项
yarn config delete <key> //删除某配置项
yarn config set <key> <value> [-g|--global] //设置配置项

安装包：
yarn install //安装package.json里所有包，并将包及它的所有依赖项保存进yarn.lock
yarn install --flat //安装一个包的单一版本
yarn install --force //强制重新下载所有包
yarn install --production //只安装dependencies里的包
yarn install --no-lockfile //不读取或生成yarn.lock
yarn install --pure-lockfile //不生成yarn.lock

添加包（会更新package.json和yarn.lock）：
yarn add [package] // 在当前的项目中添加一个依赖包，会自动更新到package.json和yarn.lock文件中
yarn add [package]@[version] // 安装指定版本，这里指的是主要版本，如果需要精确到小版本，使用-E参数
yarn add [package]@[tag] // 安装某个tag（比如beta,next或者latest）

//不指定依赖类型默认安装到dependencies里，你也可以指定依赖类型：
yarn add --dev/-D // 加到 devDependencies
yarn add --peer/-P // 加到 peerDependencies
yarn add --optional/-O // 加到 optionalDependencies

//默认安装包的主要版本里的最新版本，下面两个命令可以指定版本：
yarn add --exact/-E // 安装包的精确版本。例如yarn add foo@1.2.3会接受1.9.1版，但是yarn add foo@1.2.3 --exact只会接受1.2.3版
yarn add --tilde/-T // 安装包的次要版本里的最新版。例如yarn add foo@1.2.3 --tilde会接受1.2.9，但不接受1.3.0

发布包
yarn publish

移除一个包
yarn remove <packageName>：移除一个包，会自动更新package.json和yarn.lock

更新一个依赖
yarn upgrade 用于更新包到基于规范范围的最新版本

运行脚本
yarn run 用来执行在 package.json 中 scripts 属性下定义的脚本

显示某个包的信息
yarn info <packageName> 可以用来查看某个模块的最新版本信息
```

**两者比较**

1. 并行安装：无论 npm 还是 Yarn 在执行包的安装时，都会执行一系列任务。npm 是按照队列执行每个 package，也就是说必须要等到当前 package 安装完成之后，才能继续后面的安装。而 Yarn 是同步执行所有任务，提高了性能。
2. 离线模式：如果之前已经安装过一个软件包，用Yarn再次安装时之间从缓存中获取，就不用像npm那样再从网络下载了。

- 安装**版本统一**：为了防止拉取到不同的版本，Yarn 有一个锁定文件 (lock file) 记录了被确切安装上的模块的版本号。每次只要新增了一个模块，Yarn 就会创建（或更新）yarn.lock 这个文件。这么做就保证了，每一次拉取同一个项目依赖时，使用的都是一样的模块版本。npm 其实也有办法实现处处使用相同版本的 packages，但需要开发者执行 npm shrinkwrap 命令。这个命令将会生成一个锁定文件，在执行 npm install 的时候，该锁定文件会先被读取，和 Yarn 读取 yarn.lock 文件一个道理。npm 和 Yarn 两者的不同之处在于，Yarn 默认会生成这样的锁定文件，而 npm 要通过 shrinkwrap 命令生成 npm-shrinkwrap.json 文件，只有当这个文件存在的时候，packages 版本信息才会被记录和更新。
- **更简洁的输出**：npm 的输出信息比较冗长。在执行 npm install 的时候，命令行里会不断地打印出所有被安装上的依赖。相比之下，Yarn 简洁太多：默认情况下，结合了 emoji直观且直接地打印出必要的信息，也提供了一些命令供开发者查询额外的安装信息。
- **多注册来源处理：**所有的依赖包，不管他被不同的库间接关联引用多少次，安装这个包时，只会从一个注册来源去装，要么是 npm 要么是 bower, 防止出现混乱不一致。
- **更好的语义化**： yarn改变了一些npm命令的名称，比如 yarn add/remove，感觉上比 npm 原本的 install/uninstall 要更清晰。

## pnpm安装

全局安装

```
npm install pnpm -g
```

设置淘宝源

```
//查看源
pnpm config get registry 
//切换淘宝源
pnpm config set registry https://registry.npmmirror.com
```

查看

```
pnpm -v
```

# linux环境安装

## 1.安装nodejs环境

```
1.卸载npm和node  
npm uninstall npm -g  
yum remove nodejs npm -y  
看看是否有残留  
 进入 /usr/local/lib 删除所有 node 和 node_modules文件夹  
进入 /usr/local/include 删除所有 node 和 node_modules 文件夹  
进入 /usr/local/bin 删除 node 的可执行文件,这里删除所有软连接rm- rf ./node  
2.到nodejs官网下载并解压  
wget https://nodejs.org/dist/v10.16.0/node-v10.16.0-linux-x64.tar.xz  
tar -xvf node-v10.16.0-linux-x64.tar.xz  
3.重命名文件夹，将软连接变为全局
ln -snf /newen/programfiles/node-v10.16.0-linux-x64/bin/npm /usr/local/bin/  
ln -snf /newen/programfiles/node-v10.16.0-linux-x64/bin/node /usr/local/bin/  
4.查看nodejs是否安装成功
node -v
v10.16.0
```

