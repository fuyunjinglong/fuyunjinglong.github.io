---
title: Vite
date: 2022-05-12 06:33:16
categories:
- H_工程热点
toc: true # 是否启用内容索引

---

# **模板全宇宙入口**

- [awesome-vite](https://github.com/vitejs/awesome-vite)

# Vite是什么？

参考

- [Vite官网](https://cn.vitejs.dev/guide/why.html#slow-updates)
- [esbuild官图](https://esbuild.github.io/)
- [vite 下一代前端开发与构建工具](https://juejin.cn/post/6983587446541778957#heading-15)
- [Vite介绍及实现原理<超详细、纯干货！>](https://zhuanlan.zhihu.com/p/424842555)
- [深入理解Vite核心原理](https://juejin.cn/post/7064853960636989454#heading-0)

<img src="/img/image-20220522183940056.png" alt="image-20220522183940056" style="zoom:67%;" />

Vite（法语是 “快”）是新一代的前端构建工具。你可以把它理解为一个开箱即用的开发服务器 + 打包工具的组合，但是更轻更快。Vite 利用浏览器原生的 ES 模块支持和用编译到原生的语言开发的工具（如 esbuild）来提供一个快速且现代的开发体验。开箱即用如CSS预处理、html预处理、异步加载、分包、压缩、HMR。

Vite由两个主要部分组成：

1. dev server：利用浏览器的ESM能力来提供源文件，具有丰富的内置功能并具有高效的HMR
2. 生产构建：生产环境利用Rollup来构建代码，提供指令用来优化构建过程

Vite作为一个基于浏览器原生ESM的构建工具，它省略了开发环境的打包过程，利用浏览器去解析imports，在服务端按需编译返回。同时，在开发环境拥有速度快到惊人的模块热更新，且热更新的速度不会随着模块增多而变慢。因此，使用Vite进行开发，至少会比Webpack快10倍左右。

# Vite的主要特性

- 优点：
  - 快速的冷启动: 采用`No Bundle`和`esbuild`预构建，速度远快于`Webpack`
  - 高效的热更新：基于`ESM`实现，同时利用`HTTP`头来加速整个页面的重新加载，增加缓存策略
  - 真正的按需加载: 基于浏览器`ESM`的支持，实现真正的按需加载

- 缺点
  - 生态：目前`Vite`的生态不如`Webapck`，不过我觉得生态也只是时间上的问题。
  - 生产环境由于`esbuild`对`css`和代码分割不友好使用`Rollup`进行打包

# 主流构建工具对比

构建工具:用来让我们不再做机械重复的事情，解放我们的双手的。

构建工具指能自动对代码执行检验、转换、压缩等功能的工具。常见功能包括：代码转换、代码打包、代码压缩、HMR、代码检验。构建工具也随着前端技术的发展，从Browserify、Gulp到Parcel，从Webpack到Rollup，一直到最近比较火的面向非打包的Snowpack和Vite。

 在早期开发过程中。有很多令我们不爽的地方

- 1. js是弱类型
- 1. 手动维护依赖很麻烦
- 1. 浏览器的兼容性
- 1. 没有热更新

于是 前端构建工具应运而生。构建工具可以帮助我们做以下工作

- 1. 代码检查
- 1. 代码压缩，混淆
- 1. 依赖分析，打包
- 1. 语言编译(比如ts转化js,scss转化css)

前端的构建工具有很多。比如 Grunt Gulp FIS3 Webpack Rollup Parcel snowpack vite 

**Browserify**

- 预编译模块化方案（文件打包工具）
- Browserify基于流方式干净灵活
- 遵循commonJS规范打包JS
- 可引入插件打包CSS等其他资源（非原生能力）

**Gulp**

- 基于流的自动化构建工具（工程化）
- 配置复杂度高，偏向编程式，需要定义task处理构建
- 支持监听读写文件
- 可搭配Browserify等模块化工具来使用

Gulp.js 是一个自动化构建工具，开发者可以使用它在项目开发过程中自动执行常见任务。Gulp.js 是基于 Node.js 构建的，利用 Node.js 流的威力，你可以快速构建项目

```js
var gulp = require('gulp');
    var jshint = require('gulp-jshint');
    var concat = require('gulp-concat');
    var rename = require('gulp-rename');
    var uglify = require('gulp-uglify');

    // Lint JS
    gulp.task('lint', function() {
    return gulp.src('src/*.js')
        .pipe(jshint())
        .pipe(jshint.reporter('default'));
    });

    // Concat & Minify JS
    gulp.task('minify', function(){
        return gulp.src('src/*.js')
        .pipe(concat('all.js'))
        .pipe(gulp.dest('dist'))
        .pipe(rename('all.min.js'))
        .pipe(uglify())
        .pipe(gulp.dest('dist'));
    });

    // Watch Our Files
    gulp.task('watch', function() {
        gulp.watch('src/*.js', ['lint', 'minify']);
    });

    // Default
    gulp.task('default', ['lint', 'minify', 'watch']);
复制代码
```

gulp的执行是从上倒下的执行一个个任务。然后文件内容通过管道。进行传递。如果你想了解更多gulp的知识，可以去gulp官网

**Parcel**

- 极速打包（工程化：极速0配置）
- 零配置，但造成了配置不灵活，内置常见场景的构建方案及其依赖，无需再次安装（babel等）
- 以html入口，自动检测和打包依赖
- 不支持SourceMap
- 无法Tree-shaking

**Webpack**

- 预编译模块化方案（工程化：大而全）
- 通过配置文件达到一站式配置
- loader进行资源转换，功能全面（css+js+icon+front）
- 插件丰富，灵活扩展
- 社群庞大
- 大型项目构建慢

webpack 是一个用于现代 JavaScript 应用程序的 静态模块打包工具。当 webpack 处理应用程序时，它会在内部构建一个 依赖图(dependency graph)，此依赖图对应映射到项目所需的每个模块，并生成一个或多个 bundle。
 接下来我们看看Webpack的工作原理图

<img src="/img/image-20220522184628295.png" alt="image-20220522184628295" style="zoom: 80%;" />

webpack打包流程主要5步：

1. 查找入口文件

   从webpack的配置文件中查找entry的配置，从而找到入口文件

2. 分析依赖关系

   接到入口文件之后，从入口文件出发，分析入口文件中依赖了哪些文件，并且这些依赖的文件中还可能依赖别的文件，就这么递归的找下去。

3. 模块函数

   找到依赖中的所有文件，把这些文件转化成模块的函数，为了方便后面webpack进行调用

4. 打包

   打包完毕的文件可以产出到配置文件的output指定路径里，生成一个bundle

5. 启动服务

   node创建本地服务器并启动静态页面

**Rollup**

- 基于ES6打包（模块打包工具）
- Tree-shaking
- 打包文件小且干净，执行效率更高
- 更专注于JS打包

**Snowpack**

- 基于ESM运行时编译（工程化：ESM运行时）
- 无需递归循环依赖组装依赖树
- 默认输出单独的构建模块（未打包），可选择不同打包器（webpack、rollup等）

## 目前打包的困境

在目前的工作中,我们主要利用webpack+vue(webpack+react)进行项目开发。然而，当我们构建越来越大型的应用的时候，打包工具需要处理的javascript代码量也呈指数级增长。在大型项目中包含几百甚至几千个模块的情况也越来越多。我们开始遇到性能瓶颈，使用javascript的工具通常需要很长的时间,才能启动开发服务器

这是我工作中的一个真实项目, 项目不大，但是启动服务器的时间花了30s。这作为一个讲究效率的程序员肯定是无法忍受的

当项目越来越大，项目的hmr热更新速度越来越慢。有时候甚至改动一个字段，页面几十秒之后才会进行热更新。

**为什么产生这种问题？**

其实这和webpack打包的原理有关系，我们前面其实已经大概了解webpack的主要工作流，这里就不在详细讲解

1. 启动服务器慢，是因为在每次服务器启动之前。webpack需要执行一系列的事情。找模块间的依赖,将各个模块进行合并，生成一个build,存入内存中，最后在启动服务器。所以速度上随着项目的增加，速度会越来越慢
2. webpack的hmr。当你改动一个文件的时候，Webpack 的热更新会以当前修改的文件为入口重新 build 打包，所有涉及到的依赖也都会被重新加载一次。所以速度也随着项目的增加而降低(后面会写一遍文章专门介绍webpack的hmr的实现)

**为何不用 ESBuild 打包？**

虽然 `esbuild` 快得惊人，并且已经是一个在构建库方面比较出色的工具，但一些针对构建 *应用* 的重要功能仍然还在持续开发中 —— 特别是代码分割和 CSS 处理方面。就目前来说，Rollup 在应用打包方面更加成熟和灵活。尽管如此，当未来这些功能稳定后，我们也不排除使用 `esbuild` 作为生产构建器的可能。

## Vite

**ESM**

ESM是JavaScript提出的官方标准化模块系统，不同于之前的CJS，AMD，CMD等等，ESM提供了更原生以及更动态的模块加载方案，最重要的就是它是浏览器原生支持的，也就是说我们可以直接在浏览器中去执行import，动态引入我们需要的模块，而不是把所有模块打包在一起。

ESM执行分为3步：

- 构建: 确定从哪里下载该模块文件、下载并将所有的文件解析为模块记录
- 实例化: 将模块记录转换为一个模块实例，为所有的模块分配内存空间，依照导出、导入语句把模块指向对应的内存地址。
- 运行：运行代码，将内存空间填充

从上面实例化的过程可以看出，ESM使用实时绑定的模式，导出和导入的模块都指向相同的内存地址，也就是值引用。而CJS采用的是值拷贝，即所有导出值都是拷贝值。

**Esbuild**

Vite底层使用Esbuild实现对.“ts、jsx、.“js代码文件的转化，所以先看下什么是es-build。

Esbuild是一个JavaScript“ Bundler打包和压缩工具，它提供了与Webpack、Rollup等工具相似的资源打包能力。可以将JavaScript 和TypeScript代码打包分发在网页上运行。但其打包速度却是其他工具的 10～100 倍。

esbuild总共提供了四个函数：transform、build、buildSync、Service

**Vite**

|                 | Vite@2.0.3                                                 | **Webpack@5.24.2**       | **Snowpack@3.0.13**                                  |
| --------------- | ---------------------------------------------------------- | ------------------------ | ---------------------------------------------------- |
| 支持Vue2        | [非官方支持](https://github.com/underfin/vite-plugin-vue2) | 支持：vue-loader@^15.0.0 | 非官方支持                                           |
| 支持Vue3        | 支持                                                       | 支持：vue-loader@^16.0.0 | 支持                                                 |
| 支持Typescript  | 支持：ESbuild （默认无类型检查）                           | 支持：ts-loader          | 支持                                                 |
| 支持CSS预处理器 | 支持                                                       | 支持                     | 部分支持：官方仅提供了Sass和Postcss，且存在未解决BUG |
| 开发环境        | no-bundle  native ESM（CJS → ESM）                         | bundle（CJS/UMD/ESM）    | no-bundle  native ESM（CJS → ESM）                   |
| HMR             | 支持                                                       | 支持                     | 支持                                                 |
| 生产环境        | **Rollup**                                                 | Webpack                  | **Webpack,  Rollup, or ESbuild**                     |

**vite和webpack编译过后文件的区别**

<img src="/img/image-20220522185938638.png" alt="image-20220522185938638" style="zoom:80%;" />

### VS Webapck

`Webpack`是近年来使用量最大，同时社区最完善的前端打包构建工具，新出的`5.x`版本对构建细节进行了优化，在部分场景下打包速度提升明显。`Webpack`在启动时，会先构建项目模块的依赖图，如果在项目中的某个地方改动了代码，`Webpack`则会对相关的依赖重新打包，随着项目的增大，其打包速度也会下降。

`Vite`相比于`Webpack`而言，没有打包的过程，而是直接启动了一个开发服务器devServer。`Vite`劫持浏览器的`HTTP`请求，在后端进行相应的处理将项目中使用的文件通过简单的分解与整合，然后再返回给浏览器(整个过程没有对文件进行打包编译)。所以编译速度很快。

### VS SnowPack

`Snowpack` 首次提出利用浏览器原生`ESM`能力的打包工具，其理念就是减少或避免整个`bundle`的打包。默认在 `dev` 和 `production` 环境都使用 `unbundle` 的方式来部署应用。但是它的构建时却是交给用户自己选择，整体的打包体验显得有点支离破碎。

而 `Vite` 直接整合了 `Rollup`，为用户提供了完善、开箱即用的解决方案，并且由于这些集成，也方便扩展更多的高级功能。

两者较大的区别是在需要`bundle`打包的时候`Vite` 使用 `Rollup` 内置配置，而 `Snowpack` 通过其他插件将其委托给 `Parcel/``webpack`。

# Vite原理

## Bundle-Based Dev Server(webpack)

首先来说它们都有一个对应的 js 入口，然后通过入口 js 进行扫描应用的子模块，当这些模块被解析的时候，当然一些动态的模块也会被解析，当这些模块被 bundle 之后，它会把这些 bundlejs 注入到 html 当中，然后才会启动 dev server，等待页面的访问。从这之中我们就能看到整个过程存在的一些问题。首先他会找到整个应用所依赖的所有模块，这也正是导致我们项目变大之后启动就会变的很卡的一个主要原因。虽然有很多模块都是动态加载的，但是要进行对应的 chunk 到 bundle 的操作，其实并不是真正意义上的动态加载。其必须等待所有模块构建完成，即使是分片的模块也需要构建。

<img src="/img/image-20230614065023743.png" alt="image-20230614065023743" style="zoom:80%;" />![image-20230614065054406](/img/image-20230614065054406.png)

## Native ESM based dev server(vite)

![image-20230614065054406](/img/image-20230614065054406.png)

ESM 是 es6 提出的概念，也就是可以原生支持 import，当然你得在 script 标签上增加一个 type='moudle'的属性。当你 import 某一个模块的时候，浏览器会发一个对应的请求。具体去看看[ES Modules的规范](https://link.juejin.cn?target=https%3A%2F%2Fdeveloper.mozilla.org%2Fzh-CN%2Fdocs%2FWeb%2FJavaScript%2FGuide%2FModules)

```js
<script type="module">
  import { createApp } from './main.js‘
  createApp()
</script>
```

vite在开发环境启动时只需要启动两个Server，一个用于页面加载，一个用于HMR的Websocket。当浏览器发出原生的ESM请求，Server收到请求只需要编译当前文件后返回给浏览器，不需要管理依赖。

## vite的工作流和冷启动

<img src="/img/image-20220522185619495.png" alt="image-20220522185619495" style="zoom: 67%;" />

1. 首先是启动一个静态资源服务器
2. 找到项目的入口，开始加载入口文件
3. 当声明一个 script 标签类型为 module 时，浏览器就会像服务器发起一个GET
4. Vite 通过劫持浏览器`劫持浏览器`劫持浏览器的这些请求，并在后端进行相应的处理，将项目中使用的文件通过简单的分解与整合，然后再返回给浏览器。

从上面的分析可知: vite主要做了以下事情

- 启动了一个静态资源服务器
- 只需要在浏览器请求源码时进行转换并按需提供源码

vite整个过程中没有对文件进行打包编译，至于其他加载的工作就交给了浏览器,所以其运行速度比原始的webpack开发编译速度快出许多。

## vite的hmr热更新

Vite 的热加载原理，其实就是在客户端与服务端建立了一个 websocket 连接，当代码被修改时，服务端发送消息通知客户端去请求修改模块的代码，完成热更新。

- 服务端：服务端做的就是监听代码文件的改变，在合适的时机向客户端发送 websocket 信息通知客户端去请求新的模块代码。
- 客户端：Vite 中客户端的 websocket 相关代码在处理 html 中时被写入代码中。可以看到在处理 html 时，vite/client 的相关代码已经被插入。

## vite的按需加载

为什么说vite才是真正的按需加载呢？难道webpack不是真正的按需加载吗？
 如果你想知道，那么你可以看看去看看webpack的原理，这里我简单介绍一下 webpack其实在开始构建打包的时候，还是对所有的文件进行一次打包构建，只是在webpack遇到 import( * ) 这种语法的时候,会另外生成一个chunk; 只有在合适的时候去加载import中的内容
 从上面的分析可以知道。不管我们这段import的代码何时执行，我们对需要对它进行一定的打包

但是vite不一样，只有在你真正的需要加载的时候，浏览器才会发送import请求，去请求文件中的内容，所以才说vite才是真正的按需加载

## Vite的请求拦截

Vite 的基本实现原理，就是启动一个 koa 服务器拦截由浏览器请求 ESM的请求。通过请求的路径找到目录下对应的文件做一定的处理最终以 ESM的格式返回给客户端。

![image-20230614065216359](/img/image-20230614065216359.png)

# Vite插件

•@vitejs/plugin-vue / @vite-plugin-vue2

\>Vue3/Vue2支持

•@vitejs/plugin-vue-jsx

\>提供 Vue 3 JSX 支持

•@vitejs/plugin-legacy

\>为打包后的文件提供传统浏览器兼容性支持

**开发一个自己的Vite插件**

本质：编写基于Vite或Rollup的钩子函数。命名一般为vite-plugin- 前缀，rollup-plugin-前缀

插件钩子函数(普通字体为Rollup钩子，加粗为Vite钩子)

- 配置阶段：**config、configResolved、configureServer**
- 构建启动：options、buildStart
- 转换阶段：resolveId、load、transform；**handleHotUpdate、transformIndexHtml**
- 构建结束：buildEnd、closeBundle

```js
export default function myPlugin() {
    return {
        name: 'my-plugin', // 插件名称
        enforce: 'pre', //调整插件被执行顺序
        apply: "build | serve", // 指定插件应用情景
        options(options) {
            //服务器启动时被调用
        },
        buildStart(options) {
            //服务器启动时被调用
        },
        resolveId(id) {
            //每个传入请求时被调用
        },
        load(id) {
            //定义一个自定义加载器,对代码需要使用特性编译器解析可以使用
        },
        transform(src, id) {
            //这个钩子可以对解析后的代码进行加工处理
        },
        buildEnd(error) {
            //服务器关闭时被调用
        },
        closeBundle() {
            //这个是最终执行的钩子，可以用于清理等工作      
        },
        config(config, env) {
            //在被解析之前修改 Vite 配置。
        },
        configResolved(config) {
            //在解析 Vite 配置后调用。     
        },
        configureServer(server) {
            //用于配置开发服务器的钩子。
        },
        transformIndexHtml(html, ctx) {
            //转换 index.html 的专用钩子。        },
        handleHotUpdate(ctx) {
            //执行自定义 HMR 更新处理。
        }
    }
}

```

插件执行顺序

-Alias

-带有 enforce: 'pre' 的用户插件

-Vite 核心插件

-没有 enforce 值的用户插件

-Vite 构建用的插件

-带有 enforce: 'post' 的用户插件

-Vite 后置构建插件（最小化，manifest，报告）

# Vite性能优化

[记一次Vite打包优化](https://developer.aliyun.com/article/1166403)

三部曲：

- Network 分析
- Lighthouse 分析
- Bundle 分析