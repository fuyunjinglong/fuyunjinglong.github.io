---
title: NodeJS
date: 2022-01-01 06:33:16
categories:
- C_高级
toc: true # 是否启用内容索引
---

# 初级

## 大纲

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
- Vue-Nuxtjs
- React-Nextjs
- [服务端渲染SSR与前后端同构技术](https://www.bilibili.com/video/BV12GwGegEcH/?spm_id_from=333.1387.search.video_card.click&vd_source=bd4c7d99d71adf64d6e88c65370e0247)

## NodeJS是什么

**1.定义**

Node.js 不是一门新语言，而是**基于 Chrome V8 引擎的 JavaScript 运行时环境**，让我们可以在服务端运行 JavaScript，并提供**事件驱动、非阻塞 I/O、单线程事件循环**等特性，非常适合构建高并发、I/O 密集型的网络应用。

**2. 核心特性（原理）**

Node.js 之所以在服务端表现独特，主要得益于以下三个核心机制：

- **事件驱动**：通过事件循环机制来处理任务的调度，当有新请求或 I/O 操作完成时，会触发对应的事件回调。
- **非阻塞 I/O (Non-blocking I/O)**：当执行 I/O 操作（如读写文件、网络请求、数据库查询）时，主线程不会等待其完成，而是继续执行后续代码，待 I/O 完成后再通过回调处理结果。（底层依赖 libuv 库实现）。
- **单线程**：这里的单线程指的是 **JavaScript 代码执行线程是单线程的**。它避免了多线程上下文切换的开销，也不需要像传统后端那样为每个请求分配一个线程。但底层的 I/O 操作实际上是由 libuv 维护的线程池来异步执行的。

**3. 优缺点**

**优点：**

1. **高并发处理能力强**：由于非阻塞 I/O 和事件驱动的特性，Node.js 在处理高并发、I/O 密集型任务时性能极高，非常适合处理大量短连接请求。
2. **前后端语言统一**：前端和后端可以使用同一种语言，降低了沟通成本，且可以复用部分逻辑代码。
3. **生态极其繁荣**：拥有全球最大的开源包管理库 npm，开发者可以极其方便地引入各种现成的工具和框架。
4. **拓展了前端能力边界**：在前端工程化（Webpack/Vite 构建）、服务端渲染（SSR，如 Next.js）、桌面应用（Electron）中扮演了不可替代的角色。

**缺点：**

1. **不适合 CPU 密集型任务**：因为 JavaScript 执行是单线程的，如果存在大量复杂计算（如视频编码、数据压缩），会长时间占用主线程，导致事件循环阻塞，从而无法处理其他请求，引发卡顿。
2. **稳定性相对较弱**：单线程的缺点在于，如果某个未捕获的异常发生，可能会导致整个 Node 进程崩溃退出（通常需要配合 `cluster` 模块或 PM2 进程守护工具来解决）。
3. **异步编程的学习成本**：虽然现代有了 `Promise` 和 `async/await`，但深度的异步控制流、错误处理对初学者仍有一定门槛。

**4. 适用场景**

基于以上优缺点，Node.js 的适用场景非常明确：

- **I/O 密集型应用**：如聊天室、即时通讯、API 网关/代理层。
- **前端工程化基石**：构建工具、脚手架、本地开发服务器。
- **服务端渲染（SSR）**：解决首屏白屏问题和 SEO 优化。
- **不适合场景**：科学计算、视频转码等 CPU 密集型场景（这类通常交给 C++/Go/Java 等处理）。

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

## NodeJS的多进程模型

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

**一.定义**

**Express** 是一个成熟、功能齐全的 Node.js Web 框架，遵循“**小而美**”但内置丰富功能的原则，通过**回调函数**处理中间件；而 **Koa** 是由 Express 原班人马打造的下一代框架，它更轻量，核心仅保留最基本的异步流程控制，通过 **async/await** 和**洋葱模型**来处理中间件，具有更强的扩展性和更优雅的异步编程体验。

**二.核心区别**

**1. 中间件机制（最核心的区别）**

> - **Express：线性模型**
>   - Express 的中间件是**顺序执行**的，基于回调函数数组。
>   - 请求进入后，依次经过各个中间件，直到响应结束。虽然可以通过 `next()` 传递控制权，但很难在中间件执行完毕后“回溯”执行后续逻辑（即“后置处理”比较麻烦）。
>   - **特点**：调用 `next()` 后，代码继续向下执行，不会等待后续中间件完成。
> - **Koa：洋葱模型**
>   - Koa 的中间件机制基于 **Promise** 和 `async/await`。
>   - 请求进入，像穿过洋葱的表皮一样进入核心，然后再反向穿出。在一个中间件中，`await next()` 之前的代码是“前置处理”，之后的代码是“后置处理”。
>   - **特点**：可以非常方便地处理请求前后的逻辑（如统计响应时间、异常捕获）。

**2. 异步编程范式**

> - Express：基于回调函数。
>   - Express 诞生于 ES6 之前，大量使用回调处理异步。这导致在复杂业务逻辑中容易出现“回调地狱”，且异步错误捕获比较困难（通常需要手动通过 `next(err)` 传递）。
> - Koa：全面拥抱async/await(ES7)。
>   - Koa 核心依赖 `co` 模块（Koa 1）或原生支持 async 函数（Koa 2），完美解决了回调地狱问题，代码读起来像同步代码，非常清晰。

**3. 内核与设计哲学（“胖”与“瘦”）**

> - Express：内置丰富。
>   - Express 内置了路由、模板引擎渲染、静态文件服务、发送响应等方法。开箱即用，非常适合快速构建应用。
> - Koa：极简内核。
>   - Koa 核心代码非常少，不包含路由、模板渲染等功能。它只提供基本的 Context 上下文封装和中间件调度。你需要像搭建积木一样，通过安装中间件（如 `koa-router`, `koa-bodyparser`）来扩展功能。这符合“组合优于继承”的软件工程原则。

**4. Context 对象封装**

> - **Express**：使用 Node.js 原生的 `req` (request) 和 `res` (response) 对象，并在此基础上进行了扩展（如 `req.params`, `res.json`）。参数和响应方法分散在两个对象上。
> - Koa：封装了一个全局的ctx(Context) 对象。
>   - 将 `request` 和 `response` 对象挂载在 `ctx` 上（`ctx.request`, `ctx.response`）。
>   - 同时 Koa 做了属性代理，可以直接通过 `ctx.body` 设置响应体，通过 `ctx.query` 获取参数，API 设计更符合人体工程学。

**三、对比**

| 特性           | Express                           | Koa                                  |
| :------------- | :-------------------------------- | :----------------------------------- |
| **中间件模型** | 线性模型                          | 洋葱模型                             |
| **异步处理**   | 回调函数                          | async/await (Promise)                |
| **核心大小**   | 较大，内置路由、静态服务等        | 极小，仅包含核心调度逻辑             |
| **扩展性**     | 较低，由于 API 固定，修改原型较难 | 极高，通过插件组合，灵活度高         |
| **Context**    | req, res 分离                     | 统一 ctx 上下文                      |
| **学习曲线**   | 平缓，生态成熟，文档多            | 稍高，需理解 Promise 及洋葱模型      |
| **适用场景**   | 快速开发中小型应用，传统后端服务  | 对代码质量要求高，定制化程度高的应用 |

**四、实战选择**

1. **选择 Express**：
   - 项目开发周期紧，需要快速上线。
   - 团队成员对 ES6/7 异步特性不熟悉，习惯回调模式。
   - 需要非常成熟且庞大的生态支持（几乎所有问题都能找到现成解决方案）。
2. **选择 Koa**：
   - 追求代码的优雅性和可维护性，特别是需要处理大量异步操作（如数据库查询、微服务调用）。
   - 希望编写高度定制化的框架（例如：Koa 可以作为底层，封装成企业级框架）。
   - 团队技术栈较新，熟练掌握 async/await。

# 高级

## NodeJS文件上传

**1.定义**

Node.js 图片上传的本质是**客户端通过 `multipart/form-data` 格式发送二进制流，服务端接收并解析该数据流，最终持久化到服务器磁盘或云存储（如 OSS/S3）的过程**。在 Node.js 中，通常使用 `multer` 中间件（Express）或 `formidable` 库来处理这种多部分表单数据。

**2.基础实现方案**

在生产环境中，我推荐使用成熟的开源库来处理，最常见的是 **Multer** 或 **Formidable**。

以 **Express + Multer** 为例，核心实现步骤如下：

1. **引入依赖**：引入 `express` 和 `multer`。
2. **配置存储策略**：通过 `multer.diskStorage` 配置文件存储路径和文件名重命名（通常使用时间戳+随机数防止重名）。
3. **创建中间件**：生成 `upload` 实例。
4. **编写路由**：在路由中使用中间件，如 `upload.single('file')` 处理单文件，`upload.array` 处理多文件。

**关键代码示例：**

```js
const express = require('express');
const multer = require('multer');
const path = require('path');

const app = express();

// 配置存储规则
const storage = multer.diskStorage({
  destination: function (req, file, cb) {
    cb(null, 'uploads/'); // 存储目录
  },
  filename: function (req, file, cb) {
    // 防止中文文件名乱码，通常使用 时间戳 + 原始扩展名
    const uniqueSuffix = Date.now() + '-' + Math.round(Math.random() * 1E9);
    cb(null, uniqueSuffix + path.extname(file.originalname));
  }
});

const upload = multer({ storage: storage });

// 处理单文件上传
app.post('/upload', upload.single('avatar'), (req, res) => {
  if (!req.file) return res.status(400).send('未上传文件');
  res.send({ 
    message: '文件上传成功', 
    file: req.file 
  });
});

app.listen(3000);
```

**3.核心难点**

如果涉及到**大文件上传**（如视频、安装包），直接使用上述方案会有内存溢出、超时或网络波动导致上传失败的风险。因此需要做以下优化：

> - 分片上传：
>   - 前端利用 `Blob.slice` 将文件切片，并行或串行发送。
>   - 后端接收切片，暂时存放到临时文件夹。
> - 断点续传：
>   - 后端需要记录已上传的切片信息（通常存数据库或Redis）。
>   - 前端上传前先询问后端已上传情况，只上传剩余部分。
> - 文件秒传（哈希校验）：
>   - 前端计算文件内容的唯一哈希值（如MD5或SparkMD5）。
>   - 后端比对哈希值，如果数据库已存在，则直接返回成功路径，无需重复上传物理文件。
> - 文件合并：
>   - 所有切片上传完成后，后端触发合并操作。在Node.js中通常使用 `fs.appendFileSync` 或流合并将切片合成完整文件，并删除临时切片。

**4. 安全考量（必答点）**

文件上传功能如果不加限制，是极其危险的。我会在后端做严格的**安全校验**：

> 1. 文件类型校验：
>    - 不能仅依赖前端传入的后缀名。
>    - 通过检查文件的 **Magic Number**（文件头）来判断真实类型，防止将 `.exe` 或 `.php` 脚本伪装成图片上传。
> 2. 文件大小限制：
>    - 防止通过超大文件耗尽服务器磁盘或内存。Multer可以通过 `limits` 配置 `fileSize`。
> 3. 文件名处理：
>    - 绝对不要使用用户上传的原始文件名，必须重命名，防止路径遍历攻击。
> 4. 存储隔离：
>    - 上传目录最好配置为**静态资源目录**，且**禁止执行权限**，防止上传恶意脚本并执行。

**5. 生产环境建议（加分项）**

在实际的大型项目中，Node.js 通常作为 BFF（Backend For Frontend）层：

- **不落盘**：为了减轻Node服务器压力，文件流通常不会保存在Node服务器本地磁盘，而是通过流管道直接转发给对象存储服务（如 AWS S3、阿里云 OSS）。
- **签名直传**：推荐由后端生成一个带有临时权限的签名URL（STS方案），前端拿到URL后直接上传至云存储，Node.js只负责鉴权和生成URL，不接触文件流，性能最高。

## SSR服务端渲染

**1.定义**

**SSR（Server-Side Rendering，服务端渲染）** 是指页面的 HTML 结构和数据在**服务端**组装完成，然后将完整的 HTML 字符串发送给浏览器直接渲染的技术。
在现代前端语境下，SSR 通常指**同构渲染**，即一套 Vue/React 代码既能在 Node.js 服务端运行生成 HTML，又能在浏览器端运行接管页面（如 Next.js、Nuxt.js）。

**2.核心原理**

对比传统的 **CSR（客户端渲染）**：

- **CSR 流程**：浏览器请求 URL -> 服务端返回空 HTML（只有一个 `<div id="app">`）-> 浏览器下载 JS -> 执行 JS 发起 AJAX 请求获取数据 -> 挂载生成 DOM。（首屏白屏时间长，SEO 不友好）
- **SSR 流程**：浏览器请求 URL -> 服务端接收请求 -> 服务端执行 JS 框架，发起数据请求 -> 将组件渲染成 HTML 字符串并注入数据 -> 返回完整的 HTML 给浏览器 -> 浏览器直接显示页面内容 -> 浏览器下载并执行 JS -> **Hydration（水合/注水）**：将事件监听器绑定到现有 DOM 上，使其变为可交互状态。

**3. 优缺点**

**优点：**

1. **SEO 友好**：搜索引擎爬虫直接抓取到包含完整内容的 HTML，有利于网页收录和排名。
2. **首屏渲染快（FCP/LCP 指标好）**：浏览器接收到 HTML 后无需等待 JS 下载和执行即可呈现内容，有效减少首屏白屏时间。
3. **利于社交分享**：微信、推特等社交平台抓取页面链接预览时，能正确获取 OG 标签和页面摘要。

**缺点：**

1. **服务端压力增大**：原本由客户端浏览器承担的渲染工作转移到了服务器，高并发下对 CPU 和内存消耗较大。
2. **开发条件受限**：组件代码需要同时兼容 Node 环境和浏览器环境，不能在组件渲染初期直接访问 `window`、`document`、`localStorage` 等浏览器特有 API。
3. **部署复杂度高**：不能像纯静态资源一样直接扔进 Nginx 或 CDN，需要维护一个 Node.js 服务运行环境。
4. **水合开销**：客户端 JS 加载后，需要遍历 DOM 与虚拟 DOM 进行对比并绑定事件，这在复杂页面下会带来一定的性能开销（可能造成短暂的页面卡顿）。

**4. 适用场景**

基于优缺点，SSR 有明确的应用边界：

- **强适用场景**：内容型网站，如电商商品详情页、新闻资讯门户、博客、企业官网等，这些场景对 SEO 和首屏速度要求极高。
- **不适用场景**：后台管理系统、内部工具类应用。这类应用没有 SEO 需求，且通常在局域网内，CSR 已经足够，强行使用 SSR 只会增加开发和维护成本。

## SSR_Nuxt.js 和 Next.js

**1.定义**

**Next.js 和 Nuxt.js 是分别基于 React 和 Vue 生态的“元框架”。**
它们在底层框架（React/Vue）的基础上，封装了服务端渲染（SSR）、静态站点生成（SSG）、路由系统等能力，提供开箱即用的配置，让开发者无需从零搭建 Node 服务即可实现同构渲染和全栈开发。

**2.核心特性**

**共同特性：**

1. **约定式路由（文件路由）**：通过文件目录结构自动生成路由，无需手动配置（如 `pages/index.js` 对应根路由）。
2. **多渲染模式支持**：不仅支持 SSR，还支持 SSG（构建时生成静态页面）、CSR 以及 ISR（增量静态生成），开发者可以按页面级别灵活选择。
3. **全栈能力**：提供 API Routes（Nuxt 中叫 Server Routes），可以直接在项目中编写后端接口，实现前后端同构部署。

**Next.js（基于 React）的独有特性：**

- **React Server Components (RSC)**：在 App Router（Next.js 13+）中深度集成了服务端组件，允许组件仅在服务端运行，大幅减少客户端 JS 包体积，这是目前 React 官方主推的方向。
- **生态与平台绑定**：由 Vercel 团队维护，与 Vercel 云平台结合极深，部署体验极佳，目前在工业界使用率最高。

**Nuxt.js（基于 Vue）的独有特性：**

- **Nitro 服务端引擎**：Nuxt 3 引入了 Nitro 引擎，它可以编译成几乎任何部署环境（Node、Vercel、Cloudflare Workers、Deno 等），部署极其灵活。
- **DX（开发体验）极佳**：提供了强大的 Auto-imports（自动导入）机制，Vue 的 Composition API 和组件无需手动 import，代码极其简洁。

**3. 优缺点**

**优点：**

1. **极大降低 SSR 开发门槛**：屏蔽了复杂的 Node 服务搭建、Hydration 注水/脱水逻辑，开发者只需写组件即可。
2. **性能优化内置**：自动进行代码分割、图片优化、字体优化，开箱即用获得优秀的 Web Vitals 指标。
3. **全栈化提效**：前后端代码同库管理，类型（TypeScript）可以共享，减少了跨仓库联调成本。

**缺点：**

1. **学习曲线变陡**：尤其是 Next.js 的 App Router 和服务端组件概念，涉及“Server / Client”边界的划分，心智负担较重。
2. **黑盒度增加**：“约定大于配置”虽然方便，但当遇到不符合约定的特殊需求时，深入底层修改成本较高。
3. **仍需 Node 环境支持**：如果要使用完整的 SSR/ISR 功能，部署环境必须支持 Node 或边缘计算平台，不能像纯静态文件那样随便丢到任意静态服务器。

# Windows环境安装

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

# Linux环境安装

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

