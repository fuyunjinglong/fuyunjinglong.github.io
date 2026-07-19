---
title: 前端工程化_webpack
date: 2021-02-01 10:33:16
categories:
- C_高级
toc: true # 是否启用内容索引
---





# 初级

## Module/Chunk/Bundle是什么

一句话：**Webpack 把许多 Module（模块）组合成一个个 Chunk（代码块），再把 Chunk 编译成浏览器可运行的 Bundle（文件）**。这是一个从**离散**到**聚合**再到**文件**的过程。

**1.定义**

> - **Module（模块 - 输入源）：**
>   - **是什么：** 项目中的**每一个源文件**，JS 文件、CSS 文件、图片、字体等。
>   - **本质：** 是 Webpack 进行依赖分析和构建的最小单元。
> - **Chunk（代码块 - 中间产物）：**
>   - **是什么：** Chunk 是 Webpack 构建过程中，用于**组合和分组 Module 的逻辑概念**。它存在于内存中。
>   - 来源：Chunk 是根据配置生成的。
>     - **入口 Chunk：** Entry 配置的入口文件会生成一个 Chunk。
>     - **异步 Chunk：** 动态导入（`import()`）的模块会生成独立的 Chunk。
>     - **提取 Chunk：** `SplitChunksPlugin` 提取公共代码生成的 Chunk。
>   - **本质：** 是一个 Module 的集合，是 Bundle 的前身。
> - **Bundle（包 - 最终产出）：**
>   - **是什么：** Bundle 是最终输出到**磁盘**上的**物理文件**。
>   - **包括：** `main.js`, `app.css`, `main.js.map` 等。
>   - **本质：** 是 Chunk 经过压缩、代码混淆等处理后，最终生成的被浏览器加载的文件。

**2.转化关系**

> 1. **Module -> Chunk：**
>    Webpack 根据配置（Entry、SplitChunks 等），将相互依赖的 Module 组装在一起，形成一个 Chunk。
>    - *例子：* `main.js` 依赖 `utils.js`，这两个 Module 被组装成 `Chunk A`。
> 2. **Chunk -> Bundle：**
>    Webpack 对 Chunk 进行编译（Loader 转换）和优化（压缩、Tree Shaking），最后输出成文件。
>    - *例子：* `Chunk A` 被压缩生成了 `dist/main.js`（这就是 Bundle）。

**通常情况：**

- 1 个 Chunk 对应 1 个 Bundle。

**特殊情况（1个 Chunk 对应多个 Bundle）：**

- 当使用 `MiniCssExtractPlugin` 时，一个 JS Chunk 可能会被拆分成一个 JS Bundle 和一个 CSS Bundle。
- 当生成 SourceMap 时，一个 Chunk 会生成代码文件 Bundle 和 .map 文件 Bundle。



**3.举例说明**

**场景一：简单的单页应用**

- **配置：** `entry: './src/main.js'`
- 过程：
  1. **Module：** `main.js` 引用了 `header.js`, `footer.js`。
  2. **Chunk：** Webpack 将这三个文件组合成一个 **Main Chunk**。
  3. **Bundle：** 最终输出一个 `bundle.js`。

**场景二：代码分割**

- **配置：** 动态导入 `import('./math.js')`
- 过程：
  1. **Module：** `main.js` 和 `math.js` 是分开的 Module。
  2. **Chunk：** `main.js` 生成 **Chunk A**，`math.js` 单独生成 **Chunk B**（异步加载）。
  3. **Bundle：** 生成两个文件 `main.js` (Bundle A) 和 `math.js` (Bundle B)。浏览器加载时，先加载 `main.js`，需要时再请求 `math.js`。

**场景三：提取公共代码**

- **配置：** 使用 `SplitChunksPlugin` 提取 `node_modules`。
- 过程：
  1. **Module：** 页面 A 和 页面 B 都引用了 `lodash`。
  2. **Chunk：** Webpack 发现公共依赖，将其提取出来形成一个独立的 **Vendor Chunk**。
  3. **Bundle：** 生成 `vendor.js` (公共库) 和 `pageA.js`, `pageB.js`。

## Webpack是什么

**1.定义**

**Webpack** 是一个静态模块打包工具。它的核心功能是**分析你的项目结构，找到 JavaScript 模块以及其它的一些浏览器不能直接运行的拓展语言（Scss, TS 等），并将其打包为合适的格式以供浏览器使用。**

**2.核心概念**

四个核心概念：

> 1. **Entry（入口）：** 指示 Webpack 从哪个文件开始构建依赖图。
> 2. **Output（输出）：** 告诉 Webpack 在哪里输出打包后的 bundle，以及如何命名。
> 3. Loader（加载器）：
>    - **作用：** 让 Webpack 能够处理非 JavaScript 文件（如 CSS、图片、Vue），将它们转换为有效模块。
>    - **关键点：** Loader 本身是一个函数，接收源文件，返回转换后的结果。
> 4. Plugin（插件）：
>    - **作用：** 用于执行范围更广的任务，从打包优化和压缩，到重新定义环境中的变量。
>    - **关键点：** Plugin 基于 Webpack 的事件流机制，监听构建过程中的特定钩子，执行逻辑。

**3.构建流程**

> 1. **初始化参数：** 从配置文件和 Shell 语句中读取合并参数。
> 2. **开始编译：** 用参数初始化 Compiler 对象，加载所有插件，执行 `run` 方法。
> 3. **确定入口：** 根据 `entry` 找出入口文件。
> 4. **编译模块：** 从入口出发，调用 Loader 对模块进行翻译，再找出该模块依赖的模块，**递归**进行，直到所有依赖模块解析完成。
> 5. **完成模块编译：** 得到每个模块被翻译后的最终内容和依赖关系图。
> 6. **输出资源：** 根据依赖关系，组装成一个个包含多个模块的 Chunk，再把 Chunk 转换成文件输出（此时是修改输出内容的最后机会）。
> 7. **输出完成：** 根据配置确定输出的路径和文件名，写入文件系统。

**4.性能优化**

从**构建速度**和**产物体积**两个维度进行过深度优化：

> **提升构建速度：**
>
> - **升级版本：** 使用最新的 Webpack 5 或迁移到 **Rspack**（基于 Rust，兼容 Webpack API），速度有数量级提升。
> - **利用缓存：** 开启 `babel-loader` 的缓存 (`cacheDirectory`)，或 Webpack 5 的 **持久化缓存** (`cache: { type: 'filesystem' }`)，二次构建速度极大提升。
> - **缩小范围：** 配置 `include/exclude`，明确 Loader 只处理 `src` 目录，排除 `node_modules`。
> - **多进程构建：** 使用 `thread-loader`（项目较小不建议用，进程开启有开销）。
> - **热更新：** 开启 HMR，只更新变动的模块。
>
> **减少产物体积：**
>
> - **Tree Shaking：** 基于 ES6 Module 静态分析，删除未引用的代码（需在 `optimization` 中开启 `usedExports` 和 `sideEffects`）。
> - Code Splitting（代码分割）：
>   - **SplitChunksPlugin：** 提取公共代码（如 node_modules 中的库）到单独的 `vendor.js`，利用浏览器长效缓存。
>   - **动态导入：** 使用 `import()` 语法实现路由懒加载，按需加载页面代码。
> - **压缩代码：** 使用 `TerserPlugin` 压缩 JS，`CssMinimizerPlugin` 压缩 CSS。
> - **资源压缩：** 开启 `Gzip`（通过 `CompressionWebpackPlugin`），并在服务器端开启 Brotli 压缩。

**5.实战经验**

在之前的项目中，构建耗时曾达到 5 分钟。我通过**Webpack Bundle Analyzer** 分析产物体积，发现将巨大的第三方库（如 ECharts、AntD）全部打包进了主包。我采取了以下措施：

1. 将这些库通过 CDN 引入，排除在 Webpack 打包之外。
2. 配置 `SplitChunks` 拆分公共包。
   最终，构建时间降低到 1 分钟内，首屏加载时间减少了 40%。”

**对比：**
“虽然现在 Vite 很火，但 Webpack 依然不可替代。

- **Vite** 利用浏览器原生 ESM，开发环境启动极快，更适合库开发或新项目。
- **Webpack** 生态极其成熟，对于**复杂的企业级巨石应用**、需要深度定制构建流程、或者需要兼容老旧浏览器的场景，Webpack 依然是首选。不过，我也在尝试使用 **Rspack** 来替代 Webpack，因为它兼容 Webpack 生态，但性能快 5-10 倍。

 **面试高分小抄**

- Q: Loader 和 Plugin 的区别是什么？
  - A: **Loader** 本质是函数，作用于文件级别，将文件 A 转换为文件 B（如 sass -> css）。**Plugin** 本质是类，基于事件流机制，作用于构建过程，监听 Webpack 生命周期事件，执行特定逻辑（如压缩 HTML、拷贝文件）。
- Q: 什么是 Tree Shaking？它有什么要求？
  - A: Tree Shaking 是通过静态分析去除死代码。它要求模块必须是 **ES6 Module**（`import/export`），因为 ES Module 是静态结构，可以在编译时确定依赖关系；而 CommonJS 是动态加载的，无法进行 Tree Shaking。
- Q: Webpack 5 的 Module Federation 是什么？
  - A: 模块联邦，允许多个 Webpack 构建一起工作。它允许多个应用**动态加载**彼此的代码，实现了**微前端**的一种技术方案，让应用间可以共享依赖（如 React），不必重复下载。

## Webpack 3 到 5 的演进

- Webpack 3：手工配置时代的尾声
  - **特点**：高度依赖开发者手写配置。
  - **代码分割**：主要依靠 `CommonsChunkPlugin` 提取公共代码，配置比较繁琐且不够智能。
  - **优化**：引入了 `Scope Hoisting`（作用域提升）来减少闭包开销。
- Webpack 4：开箱即用与性能优化
  - **零配置（Mode）**：引入了 `mode: 'development' | 'production' | 'none'`。在 production 模式下，Webpack 自动开启 Tree Shaking、代码压缩、SplitChunks 等，极大降低了配置门槛。
  - **代码分割**：废弃了 `CommonsChunkPlugin`，引入了更智能的 `SplitChunksPlugin`，基于缓存组自动拆分代码。
  - **插件生态**：支持 WebAssembly，原生支持 JSON 模块的具名导入。
- Webpack 5：持久缓存与架构升级
  - **持久化缓存**：引入了基于文件系统的缓存（`cache: { type: 'filesystem' }`），首次构建后，后续冷启动和增量构建速度大幅提升。
  - **资源模块**：原生支持资源文件处理，内置了 `asset/resource`、`asset/inline` 等，不再需要安装 `file-loader`、`url-loader`、`raw-loader`。
  - **Module Federation（模块联邦）**：允许不同 Webpack 构建的应用在运行时共享模块，是微前端架构的重大突破。
  - **更强大的 Tree Shaking**：支持嵌套模块和内部模块的死代码消除。
  - **破坏性更新**：移除了 Node.js 核心模块的 Polyfill（如 `crypto`、`path`），不再自动引入，需要开发者手动配置。

## esbuild 与 Webpack

**1.定义**

Webpack 是一款基于 JavaScript 生态的经典打包工具，胜在生态丰富和高度可定制；而 esbuild 是一款使用 Go 语言编写的极速打包工具，主打极致的构建性能，通常比 Webpack 快 10 到 100 倍。

Webpack 配置庞大，依赖生态；esbuild 配置极简，开箱即用。

**2.核心原理**

底层语言和架构设计区别：

> - Webpack：
>   - 基于 Node.js 运行，受限于 JS 单线程的特性。
>   - 内部通过 Tapable 事件流机制串联各个构建环节（解析、转换、打包、输出），强依赖 Loader 和 Plugin。
>   - 过程中需要将代码转换为 JS 对象（AST）进行频繁的操作，内存分配和垃圾回收（GC）开销大。
> - esbuild：
>   - 底层由 Go 语言编写，天然支持多核并发。
>   - 从零实现了 JS/TS 的词法和语法分析器，解析、链接、代码生成三个阶段高度并行化。
>   - 尽量避免将 AST 转换为 JS 对象，而是直接在内存中操作原生数据结构，极大减少了内存分配开销。

**3.对比延伸**

面试官常会追问：**esbuild 这么快，为什么现在还没有完全替代 Webpack？**

- **生态与定制能力不足**：esbuild 的插件生态远不及 Webpack 丰富，对于复杂的代码转换（如通过 Babel 注入复杂的 Polyfill、自动按需加载组件等）能力有限。
- **不支持模块联邦**：esbuild 目前无法支持 Webpack 5 的 Module Federation 等高级架构特性。
- **Vite 的取舍**：现代构建工具如 Vite 采取了折中策略——在开发阶段利用 esbuild 极速预构建依赖，而在生产环境打包时依然使用生态更成熟、对代码优化更彻底的 Rollup。

**4.总结**

Webpack 是全能型的“重型推土机”，靠庞大的生态和高度可定制性稳居大型复杂应用构建的首选；而 esbuild 是“超跑”，凭借 Go 语言和多核并发实现了性能上的降维打击。在当下的工程化实践中，它们更多是互补关系，esbuild 常被用作底层加速引擎，而 Webpack 依然是解决复杂构建逻辑的基石。

# 中级

## Webpack 的打包原理

一句话：Webpack 的打包原理就是**“识别依赖 -> AST 分析 -> Loader 转换 -> 递归编译 -> 封装 Runtime”**的过程。

**1.定义**

Webpack 的打包原理，本质上就是一个**从“入口”出发，递归分析“依赖图”，将各种类型的模块“翻译”成浏览器能识别的 JS，最后封装成一个个“包”的过程**。

简单来说，它做了三件事：

1. **识别：** 识别代码中的 `import`、`require` 等依赖语句。
2. **转换：** 利用 Loader 将不同资源（CSS、图片、TS）转换为 JS 模块。
3. **打包：** 将这些散落的模块，按照依赖关系，组装成若干个 Bundle 文件。

**2.构建流程**

> 1. 初始化参数：
>    - 从配置文件（`webpack.config.js`）和 Shell 语句中读取并合并参数，得到最终的配置对象。
> 2. 开始编译：
>    - 用上一步得到的参数初始化 `Compiler` 对象，加载所有插件，挂载钩子。执行对象的 `run` 方法开始执行编译。
> 3. 确定入口：
>    - 根据 `entry` 配置，找到入口文件。
> 4. 编译模块：
>    - **这是最核心的一步。** 从入口出发，调用 `Loader` 去翻译文件内容（比如把 Vue 转成 JS，把 SCSS 转成 JS）。
>    - 递归地查找文件里的依赖（如 `import './a.js'`），一旦发现新依赖，就加入编译队列，直到所有依赖都被解析完毕。
>    - 在这个过程中，会生成一个**模块依赖图**。
> 5. 完成模块编译与输出：
>    - 根据依赖关系，组装成一个个包含多个模块的 `Chunk`（代码块）。
>    - 把 `Chunk` 转换成文件输出（此时是修改输出内容的最后机会，如压缩）。
>    - 根据配置确定输出的路径和文件名，写入文件系统。

**3.微观核心机制**

三个微观机制：

> 1. **AST 语法树分析：**
>    - Webpack 在读取文件内容后，会将其解析成 **AST（抽象语法树）**。
>    - 通过分析 AST 结构，Webpack 能够精准地找到 `import` 语句，从而定位到具体的依赖文件路径，这是构建依赖图的基础。
> 2. **Loader 的转换链：**
>    - Loader 就像翻译官。
>    - **原理：** Webpack 将模块内容作为参数传入 Loader 函数，Loader 处理后返回新的 JS 代码字符串（通常附带 SourceMap）。
>    - **执行顺序：** 从右向左，从下向上执行。例如 `use: ['style-loader', 'css-loader']`，先由 css-loader 解析 CSS，再由 style-loader 插入页面。
> 3. **Webpack 的模块化 runtime（关键点）：**
>    - 浏览器不认识 Node.js 的 `require` 或 ES6 的 `import`。
>    - Webpack 会在打包后的代码中注入一段**运行时代码**，定义了一个 `__webpack_require__` 函数。
>    - 这个函数模拟了 Node.js 的模块加载机制，实现了模块的缓存和导出。这就是为什么打包后的文件能在浏览器运行的原因。

**4.打包产物**

它本质上是一个**立即执行函数表达式 (IIFE)**。

Webpack 将每个文件都封装成了一个函数，放入 `modules` 对象中，通过 `__webpack_require__` 来按需执行。

```js
(function(modules) {
  // webpack runtime
  // 模拟 require 函数
  function __webpack_require__(moduleId) { ... }

  // 启动入口
  return __webpack_require__(0);
})({
  // modules 对象就是我们的依赖图
  // key 是模块 ID，value 是函数（包装后的模块代码）
  0: function(module, exports, __webpack_require__) {
      // 入口模块的内容
      var content = __webpack_require__(1);
      console.log(content);
  },
  1: function(module, exports) {
      // 被依赖的模块内容
      module.exports = "Hello World";
  }
});
```

**💡 面试追问防御**

- Q: Webpack 的热更新（HMR）原理是什么？
  - A: 简单说是 `websocket`。浏览器端和编译端建立 websocket 连接。当代码变化时，Webpack 重新编译，但不是全量刷新，而是生成两个文件：`manifest.json`（记录变化的 chunk）和 `update.js`（包含新代码）。浏览器拿到这两个文件，通过 HMR runtime 替换掉旧模块，并尝试保留状态。
- Q: Loader 和 Plugin 的区别？
  - A: 见上一个问题的回答，但这里要强调 Loader 是**文件转换**，Plugin 是**基于事件流的构建流程扩展**。
- Q: Tree Shaking 的原理？
  - A: 基于 ES6 Module 的静态特性。Webpack 在 AST 分析阶段标记出 `export` 和 `import` 的关系，在打包阶段利用 `Terser` 等工具删除掉未被 `import` 引用的代码（DCE - Dead Code Elimination）。CommonJS 因为是动态加载，无法做到完美的 Tree Shaking。

## Webpack-Loader机制

**1.定义**

**一句话总结：Loader 负责‘文件到文件’的转换。**

**Loader** 是 Webpack 中用于**转换模块源码**的机制。

Webpack 本质上只认识 JavaScript 和 JSON 文件。Loader 的作用就像一个**翻译官**，它将其他类型的文件（如 CSS、Less、TypeScript、图片等）转换为 Webpack 能够处理的有效模块，以便加入到依赖图中。

**2.核心机制**

运行机制主要包含三个核心点：

> 1. **本质是函数：**
>    - 每个 Loader 本质上就是一个 Node.js 函数。它接收源文件内容作为参数，返回转换后的内容。
>    - **签名：** `function(source, sourceMap, meta) { ... }`。
>    - 它可以是同步的，也可以是异步的（通过调用 `this.async()` 获取回调函数）。
> 2. **链式调用（从右向左）：**
>    - 当配置了多个 Loader 时（如 `use: ['style-loader', 'css-loader']`），它们的执行顺序是**从右向左**，即**从下向上**。
>    - **原因：** 这就像 Unix 的管道。最右边的 Loader 先拿到源文件进行预处理，处理结果传给左边的 Loader，直到最左边的 Loader 返回最终的 JS 模块字符串。
>    - *例子：* `css-loader` 先把 CSS 解析成字符串，`style-loader` 接收这个字符串，将其插入到 JS 代码中（创建 style 标签）。
> 3. **Pitching 阶段（前置处理 - 进阶点）：**
>    - Loader 除了导出的主函数外，还可以导出一个 `pitch` 方法。
>    - **执行顺序：** 在 Loader 链真正执行之前，会先**从左向右**执行所有 Loader 的 `pitch` 方法。
>    - **熔断机制：** 如果某个 `pitch` 方法返回了值，那么该 Loader 右边的所有 Loader 都会被跳过，直接进入该 Loader 的主函数执行。这常用于性能优化（如缓存校验）。

**3.核心API**

通过 `this` 上下文访问 Webpack 提供的丰富 API：

> - `this.callback`: 更灵活的返回方式，可以同时传递 SourceMap 和元数据，而不仅仅是返回字符串。
> - `this.async`: 标记 Loader 为异步，避免阻塞构建。
> - `this.cacheable`: 默认开启缓存。如果处理结果依赖文件以外的变量，需要关闭缓存。
> - `this.getOptions`: 获取配置文件中传递给 Loader 的参数（通过 `schema-utils` 校验）。

**4.Loader 类别**

Webpack 的 Loader 链分为两个阶段（Pitching 阶段和 Execution 阶段），不同类型的 Loader 在这两个阶段中的执行顺序截然不同。分为四类：

> - **Pre（前置）：** 强制优先执行。
> - **Normal（普通）：** 默认类型，标准顺序。
> - **Inline（行内）：** 显式引入，优先级最高，可手动控制忽略其他类型。
> - **Post（后置）：** 延后执行。

> **第一阶段：Pitching 阶段**
>
> 这是“拦截”阶段。Loader 从左到右（在 `use` 数组中）执行它们的 `pitch` 方法。
> **执行顺序：**
> `pre` -> `normal` -> `inline` -> `post`
>
> - **关键点：** 如果某个 Loader 的 `pitch` 方法有返回值，该 Loader 右边（包括同类）的所有 Loader 都会被跳过（熔断机制）。
>
> **第二阶段：Execution 阶段**
>
> 这是“真正执行”阶段。Loader 从右到左执行 `module.exports` 的主函数（标准的转换逻辑）。
> **执行顺序：**
> `post` -> `inline` -> `normal` -> `pre`
>
> - **关键点：** 这个顺序是 Pitching 的逆序（类似于函数调用栈的压栈和出栈）。`pre` Loader 虽然最先 Pitch（拦截），但它的主函数**最后执行**。”

**5.手写Loader**

功能是将源码中的 ‘hello’ 替换为 ‘webpack’

```js
// replaceLoader.js
module.exports = function(source) {
  // source: 文件的字符串内容
  // this: loader 的上下文
  
  // 1. 获取配置参数
  const options = this.getOptions() || {};
  const name = options.name || 'webpack';

  // 2. 转换逻辑
  const result = source.replace(/hello/g, name);

  // 3. 返回转换后的内容
  // 必须返回 JS 字符串或 Buffer
  return result; 
  
  // 或者使用 this.callback 返回 SourceMap:
  // this.callback(null, result, sourceMaps);
};
```

**配置方式：**

```js
// webpack.config.js
module: {
  rules: [{
    test: /\.js$/,
    use: [
      {
        loader: path.resolve(__dirname, 'loaders/replaceLoader.js'),
        options: { name: 'World' }
      }
    ]
  }]
}
```

**4.总结**

Loader 的核心价值在于**转换**。它将非标准资源转换为 Webpack 的通用语言——JavaScript。

**Loader 和 Plugin：**

- **Loader：** 专注于**文件内容**的转换（输入 -> 输出），运行在模块构建的加载阶段。
- **Plugin：** 专注于**构建流程**的扩展（监听事件），运行在构建周期的各个钩子中，能做更广泛的事情（如压缩 HTML、拷贝文件）。

💡 **面试高分小抄**

- Q: 为什么 Loader 的执行顺序是从右向左？
  - A: 为了符合函数式编程的组合思想。最右边的 Loader 处理最原始的文件，处理结果作为参数传给左边的 Loader，就像 `compose(loaderA, loaderB)(source)`。
- Q: 如果我想让 Loader 先从左向右执行怎么办？
  - A: 可以利用 `pitch` 方法，或者在配置 `enforce` 字段。例如 `enforce: 'pre'` 会强制提前执行，`enforce: 'post'` 会延后执行。
- Q: `style-loader` 和 `css-loader` 谁先执行？
  - A: `css-loader` 先执行（右边）。它解析 CSS 里的 `@import` 和 `url()`，并把 CSS 转成一个 JS 模块（字符串）。`style-loader` 后执行（左边），它拿到这个字符串，生成一段 JS 代码去创建 `<style>` 标签并插入 DOM。如果反过来，`style-loader` 拿到的是原始 CSS 文本，它是无法识别的。

## Webpack-Plugin机制

**1.定义**

Webpack Plugin 本质上是一个带有 `apply` 方法的 JavaScript 对象（或类）。它通过监听 Webpack 构建生命周期中的事件钩子，在合适的时机介入编译流程，从而扩展或自定义 Webpack 的功能。



**2.核心原理**

Plugin 机制的核心主要依赖于以下三个方面：

> - **Tapable 事件流机制**：Webpack 的内部工作流是基于 `Tapable` 实现的。`Tapable` 暴露了各种类型的 Hook（如 `SyncHook` 同步钩子、`AsyncSeriesHook` 异步串行钩子、`AsyncParallelHook` 异步并行钩子等），Plugin 就是通过注册这些 Hook 的回调函数来介入构建过程。
> - Compiler 与 Compilation：
>   - **Compiler**：代表了整个 Webpack 的生命周期，全局唯一。它包含了 Webpack 环境所有的配置信息，Plugin 通过 `apply` 方法接收这个对象。
>   - **Compilation**：代表了一次资源构建过程。当 Webpack 以开发模式运行时，每当检测到文件变化，就会触发一次新的 `Compilation`。它包含了当前的模块资源、编译生成资源、变化的文件等。
> - **执行流程**：Webpack 启动时，会读取配置中的 `plugins` 数组，依次实例化每个 Plugin，并调用其 `apply(compiler)` 方法。在 `apply` 内部，开发者通过 `compiler.hooks.xxx.tap/tapAsync/tapPromise` 注册钩子。当 Webpack 运行到对应阶段时，就会触发这些注册的回调函数。



**3.手写Plugin**

编写一个简单的 Plugin，用于在生成文件到 `output` 目录之前，添加一个版权声明文件：

```js
class CopyrightPlugin {
  // 构造函数接收 plugin 配置参数
  constructor(options) {
    this.options = options;
  }

  // 必须实现 apply 方法
  apply(compiler) {
    const { name } = this.options;
    
    // 监听 emit 钩子（即将输出资源到目录前触发，这是一个异步钩子）
    compiler.hooks.emit.tapAsync('CopyrightPlugin', (compilation, callback) => {
      console.log(`${name} Plugin 正在执行...`);
      
      // 往 compilation.assets 中添加一个新的文件
      compilation.assets['copyright.txt'] = {
        source: function() {
          return 'Copyright 2023 by Interviewee';
        },
        size: function() {
          return 26; // 返回文件大小
        }
      };
      
      callback(); // 必须调用回调通知 Webpack 继续往下执行
    });
  }
}

module.exports = CopyrightPlugin;
```

**4.Plugin 和 Loader 的区别**

> - **Loader**：主要用于**文件转换**。它运行在单个文件级别，将非 JS 文件（如 CSS、图片、TS）转换成 Webpack 能识别的 JS 模块。本质是一个输入字符串、输出字符串的函数。
> - **Plugin**：主要用于**流程控制**。它贯穿整个 Webpack 构建生命周期，能力比 Loader 更强，可以做 Loader 做不到的事情，比如：打包前清空目录（`CleanWebpackPlugin`）、自动生成 HTML 文件（`HtmlWebpackPlugin`）、代码压缩、环境变量注入等。

# 高级

## Webpack 优化策略

**1.定义**

Webpack 优化主要围绕两个核心维度展开：一是**提升构建速度**（减少开发等待时间），二是**优化产物质量**（减小打包体积、合理分包以提升页面加载与运行性能）。

**2.核心原理**

> **A. 提升构建速度**
>
> - **利用缓存**：Webpack 5 原生支持 `cache: { type: 'filesystem' }` 持久化缓存，二次构建速度大幅提升；旧版本可用 `cache-loader`。
> - **多线程并行**：使用 `thread-loader` 将耗时的 Loader（如 `babel-loader`）放到 Worker 池中并行处理。
> - 缩小构建目标：
>   - 配置 `resolve.extensions` 减少文件后缀查找次数。
>   - 利用 `include/exclude` 精确限定 Loader 的作用目录，避免编译 `node_modules`。
>   - 合理使用 `resolve.alias`（别名）缩短模块查找路径。
>
> **B. 优化产物体积与运行性能**
>
> - **Tree Shaking**：依赖 ES6 模块的静态分析，移除未使用的死代码（生产环境默认开启）。
> - **代码压缩**：内置 `TerserWebpackPlugin` 压缩 JS，配合 `CssMinimizerWebpackPlugin` 压缩 CSS。
> - **分包策略**：利用 `SplitChunksPlugin` 将第三方库和公共业务代码抽离，最大化利用浏览器缓存。
> - **图片/资源优化**：使用 Webpack 5 的 Asset Modules 将小图片转 base64 内联（`asset/inline`），减少 HTTP 请求；大图片使用 `image-webpack-loader` 进行无损压缩。
> - **Gzip 压缩**：使用 `CompressionWebpackPlugin` 在打包时预生成 `.gz` 文件，减轻服务器实时压缩压力。

**3.代码示例**

```js
const TerserPlugin = require('terser-webpack-plugin');

module.exports = {
  mode: 'production',
  resolve: {
    extensions: ['.js', '.json', '.jsx'], // 减少后缀尝试次数
    alias: { '@': path.resolve(__dirname, 'src') } // 缩短路径查找
  },
  cache: {
    type: 'filesystem', // Webpack 5 持久化缓存，极大提升二次构建速度
  },
  module: {
    rules: [
      {
        test: /\.js$/,
        exclude: /node_modules/, // 排除不需要编译的目录
        use: [
          'thread-loader', // 开启多线程转译
          'babel-loader'
        ]
      },
      {
        test: /\.(png|jpg|gif)$/,
        type: 'asset', // Webpack 5 资源处理
        parser: { dataUrlCondition: { maxSize: 8 * 1024 } } // 小于8kb转base64
      }
    ]
  },
  optimization: {
    minimize: true,
    minimizer: [new TerserPlugin()], // 代码压缩
    splitChunks: { chunks: 'all' }   // 智能分包
  }
};
```

**4.对比延伸**

面试官可能会追问：**优化是否需要在开发环境和生产环境做区分？**

- 是的。**开发环境**的核心诉求是“快”，因此更侧重于缓存、多线程和缩小范围，通常会关闭代码压缩和 Tree Shaking，甚至不进行彻底的分包。
- **生产环境**的核心诉求是“小”和“稳”，侧重于 Tree Shaking、代码压缩、提取 CSS 和精准分包。
- **工具换代**：如果 Webpack 优化到极限，在大型项目中开发环境的冷启动依然需要十几秒甚至更久，现在的主流做法是开发环境切换为 Vite（利用浏览器原生 ESM 实现秒级启动），生产环境依然保留 Webpack/Rollup 以保证兼容性和复杂的构建逻辑。

## Webpack 的分包策略

**1.定义**

Webpack 的分包策略主要是通过 `SplitChunksPlugin` 插件，将打包后的代码按照一定规则拆分成多个较小的 Chunk，目的是减小单个文件体积、实现按需加载、并最大化利用浏览器缓存。

**2.核心原理**

Webpack 4 及以上版本废弃了早期的 `CommonsChunkPlugin`，默认内置了更智能的 `SplitChunksPlugin`。它的核心机制基于**缓存组**和**阈值控制**：

> - 拆分维度（chunks）：
>   - `async`（默认）：只对异步加载（动态 `import()`）的模块进行分包。
>   - `initial`：只对同步加载的模块进行分包。
>   - `all`：同步和异步模块都会进行分包（最常用）。
> - **缓存组**：允许开发者自定义拆分规则。通常包含两个默认的组：`vendors`（用于抽离 `node_modules` 中的第三方库）和 `default`（用于抽离被多次复用的业务公共代码）。
> - **阈值控制**：为了防止拆分出过多极小的文件，Webpack 提供了控制参数，如 `minSize`（拆分出的包最小体积）、`minChunks`（模块被引用的最少次数）、`maxAsyncRequests`（按需加载最大并发请求数）等。

**3.代码示例**

企业级项目中的 `splitChunks` 配置示例：

```js
module.exports = {
  optimization: {
    splitChunks: {
      chunks: 'all', // 同步和异步都参与分包
      minSize: 20000, // 体积大于 20KB 才拆分
      cacheGroups: {
        // 1. 抽离第三方库
        vendors: {
          test: /[\\/]node_modules[\\/]/,
          name: 'vendors',
          priority: -10, // 优先级，数字越大越优先匹配
          reuseExistingChunk: true, // 复用已存在的 chunk
        },
        // 2. 抽离业务公共代码
        common: {
          name: 'common',
          minChunks: 2, // 被至少 2 个入口引用的公共业务代码才拆分
          priority: -20,
          reuseExistingChunk: true,
        }
      }
    }
  }
};
```

**4.对比延伸**

面试官常会追问：**为什么要分包？以及分包和懒加载的区别？**

- **缓存优化**：如果所有代码打成一个 bundle，每次更新业务代码都会导致整个文件的 hash 改变，用户需重新下载所有代码（包括不常更新的 React/Vue 等库）。分包后，第三方库的 hash 保持不变，浏览器直接读取缓存，大幅减少带宽和加载时间。
- **分包 vs 懒加载**：分包（SplitChunks）侧重于把代码拆开，优化缓存；而懒加载（动态 `import()`）侧重于延迟执行，首屏不加载非首屏的代码。两者通常结合使用，通过路由懒加载按需拉取分包后的代码，极致提升首屏性能。
- **HTTP 协议的影响**：在 HTTP/1.1 时代，浏览器有并发请求数限制（通常 6 个），分包过多反而会拖慢速度；但在 HTTP/2 多路复用时代，并发请求不再是瓶颈，拆分多个小文件反而更有利于传输和缓存精细控制。

**5.总结**

Webpack 的分包策略是前端性能优化的基石。通过合理配置 `SplitChunksPlugin`，将稳定不变的第三方库与频繁变动的业务代码剥离，配合路由级别的懒加载，能够有效减小首屏负荷，最大化利用浏览器缓存。

## Tree Shaking是什么

**1.定义**

Tree Shaking（摇树优化）是一种用于消除 JavaScript 上下文中未引用代码（死代码）的优化手段，它可以显著减小打包体积。

**2.核心原理**

- **静态分析**：Webpack 在构建阶段（不运行代码）分析模块的导入和导出，标记出哪些导出变量被其他模块使用，哪些未被使用。
- **压缩剔除**：在生成产物阶段，Webpack 自身的 Tree Shaking 只是把未使用的代码标记为“未使用”，真正的物理删除是由代码压缩工具（如 Terser）在压缩阶段完成的。
- **为什么只能基于 ES6 Module**：CommonJS 模块是动态的（`require` 可以出现在 `if` 里，运行时才确定），无法在编译时确定依赖关系。而 ES6 Module 是静态的，`import/export` 必须在顶层静态声明，这使得 Webpack 能够在编译阶段确定模块的依赖关系和导出变量的使用情况。

**3.对比延伸**

- **副作用**：Tree Shaking 也有局限性。如果模块有副作用（如修改全局变量、修改原型链），即使其导出未被使用，Webpack 也不敢随意删除。此时需要在 `package.json` 中配置 `"sideEffects": false`，明确告诉 Webpack 该模块可以安全进行 Tree Shaking。
- 与 Rollup 相比，早期的 Webpack Tree Shaking 能力较弱，只能针对顶层导出，而 Rollup 支持更细粒度的作用域分析。但 Webpack 5 之后，Tree Shaking 能力已大幅增强，支持嵌套模块的死代码消除。

**4.总结**

Tree Shaking 是前端体积优化的核心利器。它基于 ES6 Module 的静态特性，在编译时标记死代码，并在压缩时移除。开发中应尽量使用 ES6 语法编写库和应用，并合理配置 `sideEffects` 以获得最优的摇树效果。

## Webpack热更新(HMR)

**1.定义**

Webpack 的 HMR（Hot Module Replacement）机制允许在运行时无需刷新整个页面的情况下，替换、添加或删除模块，从而极大提升开发体验。

**2.核心原理**

HMR 的核心是建立 Webpack 与浏览器之间的双向通信，主要包含以下流程：

- **文件监听**：Webpack 监听本地文件变化，重新编译变更的模块，生成两个补丁文件：`[hash].hot-update.json`（记录变更模块的清单）和 `[hash].hot-update.js`（变更模块的具体代码）。
- **传递更新**：Webpack-dev-server（WDS）通过 WebSocket 将最新的 `hash` 值推送到浏览器端。
- **拉取代码**：浏览器的 HMR Runtime 接收到 `hash` 后，通过 AJAX/JSONP 拉取上面生成的两个补丁文件。
- **替换执行**：HMR Runtime 将新模块代码替换旧模块。如果有配置 `module.hot.accept`，则执行回调更新视图；如果没有配置，则降级为整页刷新。

**3.代码示例（React/Vue 中通常由框架的 loader 处理，原生 JS 需手动配置）**

```js
// 原生 JS 中的 HMR 处理
if (module.hot) {
  // 接受当前模块的更新
  module.hot.accept('./app.js', function() {
    console.log('App 模块更新了，重新渲染...');
    renderApp();
  });
}
```

**4.对比延伸**

- **Live Reload vs HMR**：Live Reload 是文件变化后整页刷新，会导致页面状态丢失（比如表单输入了一半）；而 HMR 是局部替换，能保留页面当前的运行状态。
- **Vite 的 HMR**：Webpack 的 HMR 需要重新编译受影响的模块生成 chunk。而 Vite 因为基于浏览器原生 ESM，文件修改后 Vite 只需让浏览器重新请求该单一模块即可，不需要打包，因此 HMR 速度与项目规模解耦，永远保持在毫秒级。

**5.总结**

Webpack 的 HMR 通过 `WebSocket` 通信和动态拉取热更新补丁文件，实现了模块级别的按需更新。它不仅减少了开发时全量刷新带来的状态丢失问题，也通过只编译变化模块加快了反馈速度，是现代化前端开发流不可或缺的一环。