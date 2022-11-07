---
title: F_Vite构建及最佳实践
date: 2022-05-12 06:33:16
categories:
- F_新技术
toc: true # 是否启用内容索引
---

# 1.Vite是什么？

[esbuild官图](https://esbuild.github.io/)

<img src="/img/image-20220522183940056.png" alt="image-20220522183940056" style="zoom:67%;" />

[Vite官网](https://cn.vitejs.dev/guide/why.html#slow-updates)

下一代前端开发与构建工具。

Vite（法语意思是 “快”，发音为 /vit/，类似 veet）是一种全新的前端构建工具。你可以把它理解为一个开箱即用的开发服务器 + 打包工具的组合，但是更轻更快。Vite 利用浏览器原生的 ES 模块支持和用编译到原生的语言开发的工具（如 esbuild）来提供一个快速且现代的开发体验。

两个组成部分：

1. 开发环境：No-Bundle 开发服务器即不需要打包的

\>提供一个静态服务器，源⽂件⽆需打包，直接以 原⽣ ES modules 的形式加载

2. ⽣产构建 

\>提供一套构建指令，基于预配置好的Rollup ，针对⽣产环境⾼度优化的打包命令

And More:

\>基于原生 ESM 的极速热更新，ms级别

\>基于 esbuild 的依赖预构建

\>兼容 Rollup 的插件机制

\>内置 SSR 支持

\>…

|                    | **     Vite@2.0.3**                                          | **Webpack@5.24.2**                                           | **Snowpack@3.0.13**                                          |
| ------------------ | ------------------------------------------------------------ | ------------------------------------------------------------ | ------------------------------------------------------------ |
| 支持Vue2           | 非官方支持:   [https](https://github.com/underfin/vite-plugin-vue2)[://github.com/underfin/vite-plugin-vue2](https://github.com/underfin/vite-plugin-vue2) | 支持：vue-loader@^15.0.0                                     | 非官方支持：   [https](https://link.segmentfault.com/?url=https://www.npmjs.com/package/@lepzulnag/snowpack-plugin-vue-2)[://www.npmjs.com/package/@lepzulnag/Snowpack-plugin-vue-2](https://link.segmentfault.com/?url=https://www.npmjs.com/package/@lepzulnag/snowpack-plugin-vue-2) |
| 支持Vue3           | 支持                                                         | 支持：vue-loader@^16.0.0([https://github.com/Jamie-Yang/vue3-boilerplate](https://link.segmentfault.com/?url=https://github.com/Jamie-Yang/vue3-boilerplate)) | 支持：   [https](https://link.segmentfault.com/?url=https://www.npmjs.com/package/@snowpack/plugin-vue)[://www.npmjs.com/package/@Snowpack/plugin-vue](https://link.segmentfault.com/?url=https://www.npmjs.com/package/@snowpack/plugin-vue) |
| 支持Typescript     | 支持：ESbuild （默认无类型检查）                             | 支持：ts-loader                                              | 支持：   [https](https://link.segmentfault.com/?url=https://github.com/snowpackjs/snowpack/tree/main/create-snowpack-app/app-template-vue-typescript)[://github.com/Snowpackjs/Snowpack/tree/main/create-Snowpack-app/app-template-vue-typescript](https://link.segmentfault.com/?url=https://github.com/snowpackjs/snowpack/tree/main/create-snowpack-app/app-template-vue-typescript) |
| 支持CSS预处理器    | 支持：  [https](https://link.segmentfault.com/?url=https://vitejs.dev/guide/features.html)[://vitejs.dev/guide/features.html#css-pre-processors](https://link.segmentfault.com/?url=https://vitejs.dev/guide/features.html) | 支持：  [https](https://link.segmentfault.com/?url=https://vue-loader.vuejs.org/guide/pre-processors.html)[://vue-loader.vuejs.org/guide/pre-processors.html](https://link.segmentfault.com/?url=https://vue-loader.vuejs.org/guide/pre-processors.html) | 部分支持：官方仅提供了Sass和Postcss，且存在未解决BUG         |
| 开发环境           | no-bundle  native ESM（CJS → ESM）                           | bundle（CJS/UMD/ESM）                                        | no-bundle  native ESM（CJS → ESM）                           |
| HMR                | 支持                                                         | 支持                                                         | 支持                                                         |
| 生产环境           | **Rollup**                                                   | Webpack                                                      | **Webpack****,  Rollup, or** **ESbuild**                     |
| Node  API 调用能力 | 支持                                                         | 支持                                                         | 支持                                                         |

# 2.Vite原理

[vite 下一代前端开发与构建工具](https://juejin.cn/post/6983587446541778957#heading-15)

## ES Modules

vite的成功得益于现代浏览器对于基于ECMAScript 标准原生模块系统（ES Modules）实现。 目前主流浏览器(IE11除外)都已经支持。他允许我们在浏览器使用export、import 的方式导入和导出模块，在 script 标签里设置 type="module"

<script type="module">
  import { createApp } from './main.js‘
  createApp()
</script>

浏览器会识别添加type="module"的 `<script> `元素，浏览器会把这段内联 script 或者外链 script 认为是 ECMAScript 模块。然后浏览器会被这里面的import引用发起一个http请求，请求获取文件中的内容。 因此我们对于第三方的模块，可以不用打包合并,而是通过import 这种方式去发起http 请求，获取代码。这也是vite的主要实现思路。 如果你对ES Modules 不够了解。可以去看看[ES Modules的规范](https://link.juejin.cn?target=https%3A%2F%2Fdeveloper.mozilla.org%2Fzh-CN%2Fdocs%2FWeb%2FJavaScript%2FGuide%2FModules)

## vite的工作流和冷启动

<img src="/img/image-20220522185619495.png" alt="image-20220522185619495" style="zoom: 67%;" />

1. 首先是启动一个静态资源服务器
2. 找到项目的入口，开始加载入口文件
3. 当声明一个 script 标签类型为 module 时，浏览器就会像服务器发起一个GET
4. Vite 通过劫持浏览器`劫持浏览器`劫持浏览器的这些请求，并在后端进行相应的处理，将项目中使用的文件通过简单的分解与整合，然后再返回给浏览器。

从上面的分析可知: vite主要做了以下事情

- 1. 启动了一个静态资源服务器
- 1. 只需要在浏览器请求源码时进行转换并按需提供源码

vite整个过程中没有对文件进行打包编译，至于其他加载的工作就交给了浏览器,所以其运行速度比原始的webpack开发编译速度快出许多。

## vite的hmr热更新

传统打包器是将项目打包之后的资源存入电脑的内存之中，这样他们只需要在文件更改的时候，将对应的模块进行失活，但是它仍然需要重新构建并重载页面。 所以像webpack这类的打包工具支持了动态模块热重载(HMR)，允许一个模块替换自己，而对其余页面没有影响。但是在实践中。我们发现HMR的速度会随着项目的增大而降低(原因在 `目前打包工具的困境` 这一节已经分析过了)

而在vite中HMR 是在原生 ESM 上执行的。当编辑一个文件时，Vite 只需要精确地使已编辑的模块与其最近的 HMR 边界之间的链失效（大多数时候只需要模块本身），使 HMR 更新始终快速，无论应用的大小。

## vite的按需加载

为什么说vite才是真正的按需加载呢？难道webpack不是真正的按需加载吗？
 如果你想知道，那么你可以看看去看看webpack的原理，这里我简单介绍一下 webpack其实在开始构建打包的时候，还是对所有的文件进行一次打包构建，只是在webpack遇到 import( * ) 这种语法的时候,会另外生成一个chunk; 只有在合适的时候去加载import中的内容
 从上面的分析可以知道。不管我们这段import的代码何时执行，我们对需要对它进行一定的打包

但是vite不一样，只有在你真正的需要加载的时候，浏览器才会发送import请求，去请求文件中的内容，所以才说vite才是真正的按需加载

# 3.Vite迁移最佳实践

•项目地址： [https://](https://github.com/originjs/webpack-to-vite)[github.com/originjs/webpack-to-vite](https://github.com/originjs/webpack-to-vite)

•使用：

```
\>npm i @originjs/webpack-to-vite –g

\>webpack-to-vite -d <project path>
```

迁移常见问题

```
1.CommonJS支持问题
使用插件 @originjs/vite-plugin-commonjs
2.~@双别名问题
可配置别名 {  find: /^~@/,        replacement: path.resolve(__dirname,'src')    }
~用法已被废弃，建议删除~
3.Jsx支持
.vue文件中必须显示声明<script lang="jsx"></script>
3.Webpack require.context
使用插件 @originjs/vite-plugin-require-context
require.context 改为 import.meta.globEager
4.Webpack插件在vite生态中的替代插件
将markdown文件转为vue组件 -> vite-plugin-md
raw-loader插件  -> rollup-plugin-string
```

# 4.Vite插件介绍

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

# 5.构建工具的前世今生

构建工具:用来让我们不再做机械重复的事情，解放我们的双手的。
 在早期开发过程中。有很多令我们不爽的地方

- 1. js是弱类型
- 1. 手动维护依赖很麻烦
- 1. 浏览器的兼容性
- 1. 没有热更新

.......

于是 前端构建工具应运而生。构建工具可以帮助我们做以下工作

- 1. 代码检查
- 1. 代码压缩，混淆
- 1. 依赖分析，打包
- 1. 语言编译(比如ts转化js,scss转化css)

前端的构建工具有很多。比如 Grunt Gulp FIS3 Webpack Rollup Parcel snowpack vite 

## Gulp

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

## Webpack 

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

## Vite的优势

vite的三大特点

- 1. 快速的冷启动 在开发预览中，它是不进行打包的。
- 1. 即时热模块更新（HMR，Hot Module Replacement）
- 1. 真正按需进行加载

当然vite也有一定的问题,

1. vite的生态还不够完善。
2. 在生产模式下仍然需要打包。尽管原生 ESM 现在得到了广泛支持，但由于嵌套导入会导致额外的网络往返，在生产环境中发布未打包的 ESM 仍然效率低下（即使使用 HTTP/2）。为了在生产环境中获得最佳的加载性能，最好还是将代码进行 tree-shaking、懒加载和 chunk 分割（以获得更好的缓存）。

**vite和webpack编译过后文件的区别**

<img src="/img/image-20220522185938638.png" alt="image-20220522185938638" style="zoom:80%;" />

# 6.Vite核心原理

## Vite是什么？

利用浏览器ESM特性导入组织代码，在服务器端按需编译返回，完全跳过了打包这个概念，服务器随起随用。生产中利用Rollup作为打包工具，号称下一代的前端构建工具。

特点：

- 快速的冷启动: No Bundle + esbuild 预构建
- 即时的模块热更新: 基于ESM的HMR，同时利用浏览器缓存策略提升速度
- 真正的按需加载: 利用浏览器ESM支持，实现真正的按需加载

|          | 开发环境                  | 生产环境                           | Dev启动速度 | Git Star |
| -------- | ------------------------- | ---------------------------------- | ----------- | -------- |
| Vite     | No Bundle<br />(CJS-ESM)  | Rollup                             | 快          | 36.2k    |
| Snowpack | No Bundle<br />(CJS-ESM)  | 可选<br />(webpack/Rollup/Esbuild) | 快          | 19.6k    |
| webpack  | Bundle<br />(CJS/UMD/ESM) | webpack                            | 慢          | 30k      |

**VS Webapck**

Vite相比于Webpack而言，没有打包的过程，而是直接启动了一个开发服务器 devServer。Vite劫持浏览器的HTTP请求，在后端进行相应的处理将项目中使用的文件通过简单的分解与整合，然后再返回给浏览器(整个过程没有对文件进行打包编译)。所以编译速度很快。

 **VS SnowPack**

Snowpack 首次提出利用浏览器原生ESM能力的打包工具，其理念就是减少或避免整个bundle的打包。默认在 dev 和 production 环境都使用 unbundle 的方式来部署应用。但是它的构建时却是交给用户自己选择，整体的打包体验显得有点支离破碎。

而 Vite 直接整合了 Rollup，为用户提供了完善、开箱即用的解决方案，并且由于这些集成，也方便扩展更多的高级功能。

两者较大的区别是在需要bundle打包的时候Vite 使用 Rollup 内置配置，而 Snowpack 通过其他插件将其委托给 Parcel/“webpack。

## 前置知识

**ESM**

ESM是JavaScript提出的官方标准化模块系统，不同于之前的CJS，AMD，CMD等等，ESM提供了更原生以及更动态的模块加载方案，最重要的就是它是浏览器原生支持的，也就是说我们可以直接在浏览器中去执行import，动态引入我们需要的模块，而不是把所有模块打包在一起。

ESM执行分为3步：

- 构建: 确定从哪里下载该模块文件、下载并将所有的文件解析为模块记录
- 实例化: 将模块记录转换为一个模块实例，为所有的模块分配内存空间，依照导出、导入语句把模块指向对应的内存地址。
- 运行：运行代码，将内存空间填充

从上面实例化的过程可以看出，ESM使用实时绑定的模式，导出和导入的模块都指向相同的内存地址，也就是值引用。而CJS采用的是值拷贝，即所有导出值都是拷贝值。

**Esbuild**

[Esbuild官网](https://esbuild.github.io/getting-started/ )

Vite底层使用Esbuild实现对.“ts、jsx、.“js代码文件的转化，所以先看下什么是es-build。

Esbuild是一个JavaScript“ Bundler打包和压缩工具，它提供了与Webpack、Rollup等工具相似的资源打包能力。可以将JavaScript 和TypeScript代码打包分发在网页上运行。但其打包速度却是其他工具的 10～100 倍。

esbuild总共提供了四个函数：transform、build、buildSync、Service

**Rollup**

[Rollup官网](https://rollupjs.org/guide/en/)

Rollup是基于ESM的JavaScript打包工具。相比于其他打包工具如Webpack，他总是能打出更小、更快的包。因为 Rollup 基于 ESM 模块，比 Webpack 和 Browserify 使用的 CommonJS模块机制更高效。Rollup的亮点在于同一个地方，一次性加载。能针对源码进行 Tree Shaking(去除那些已被定义但没被使用的代码)，以及 Scope Hoisting 以减小输出文件大小提升运行性能。

Rollup分为build（构建）阶段和output generate（输出生成）阶段。主要过程如下：

1. 获取入口文件的内容，包装成module，生成抽象语法树
2. 对入口文件抽象语法树进行依赖解析
3. 生成最终代码

如果你的项目（特别是类库）只有JavaScript，而没有其他的静态资源文件，使用Webpack就有点大才小用了。因为Webpack 打包的文件的体积略大，运行略慢，可读性略低。这时候Rollup也不失为一个好选择。

## 核心原理

详细阐述下：

1. 当声明一个 script标签类型为 module 时,如

   ```
     <script type="module" src="/src/main.js"></script>
   ```

2. 当浏览器解析资源时，会往当前域名发起一个GET请求main.js文件

   ```
   // main.js
   import { createApp } from 'vue'
   import App from './App.vue'
   createApp(App).mount('#app')
   ```

3. 请求到了main.js文件，会检测到内部含有import引入的包，又会import 引用发起HTTP请求获取模块的内容文件，如App.vue、vue文件

Vite其核心原理是利用浏览器现在已经支持ES6的import,碰见import就会发送一个HTTP请求去加载文件，Vite启动一个 koa 服务器拦截这些请求，并在后端进行相应的处理将项目中使用的文件通过简单的分解与整合，然后再以ESM格式返回返回给浏览器。Vite整个过程中没有对文件进行打包编译，做到了真正的按需加载，所以其运行速度比原始的webpack开发编译速度快出许多！

### 基于 ESM 的 Dev server

在Vite出来之前，传统的打包工具如Webpack是先解析依赖、打包构建再启动开发服务器，Dev Server 必须等待所有模块构建完成，当我们修改了 bundle模块中的一个子模块， 整个 bundle 文件都会重新打包然后输出。项目应用越大，启动时间越长。

而Vite利用浏览器对ESM的支持，当 import 模块时，浏览器就会下载被导入的模块。先启动开发服务器，当代码执行到模块加载时再请求对应模块的文件,本质上实现了动态加载。灰色部分是暂时没有用到的路由，所有这部分不会参与构建过程。随着项目里的应用越来越多，增加route，也不会影响其构建速度。

### 基于 ESM 的 HMR 热更新

目前所有的打包工具实现热更新的思路都大同小异：主要是通过WebSocket创建浏览器和服务器的通信监听文件的改变，当文件被修改时，服务端发送消息通知客户端修改相应的代码，客户端对应不同的文件进行不同的操作的更新。

**VS Webpack**

Webpack: 重新编译，请求变更后模块的代码，客户端重新加载

Vite: 请求变更的模块，再重新加载

Vite 通过 chokidar 来监听文件系统的变更，只用对发生变更的模块重新加载， 只需要精确的使相关模块与其临近的 HMR边界连接失效即可，这样HMR 更新速度就不会因为应用体积的增加而变慢而 Webpack 还要经历一次打包构建。所以 HMR 场景下，Vite 表现也要好于 Webpack。

**核心流程**

热更新四步曲：

1. 创建一个websocket服务端和client文件，启动服务

2. 通过chokidar监听文件变更

3. 当代码变更后，服务端进行判断并推送到客户端

4. 客户端根据推送的信息执行不同操作的更新

### 基于 esbuild 的依赖预编译优化

**预构建**

- 支持commonJS依赖

上面提到Vite是基于浏览器原生支持ESM的能力实现的，但要求用户的代码模块必须是ESM模块，因此必须将commonJs的文件提前处理，转化成 ESM 模块并缓存入 node_modules/.vite

- 减少模块和请求数量

除此之外，我们常用的lodash工具库，里面有很多包通过单独的文件相互导入，而 lodash-es这种包会有几百个子模块，当代码中出现 import { debounce } from ‘lodash-es’ 会发出几百个 HTTP 请求，这些请求会造成网络堵塞，影响页面的加载。Vite 将有许多内部模块的 ESM 依赖关系转换为单个模块，以提高后续页面加载性能。通过预构建 lodash-es 成为一个模块，也就只需要一个 HTTP 请求了！

**Esbuild强于webpack**

- 编译运行 VS 解释运行

大多数前端打包工具都是基于 JavaScript 实现的，大家都知道JavaScript是解释型语言，边运行边解释。而 Esbuild 则选择使用 Go 语言编写，该语言可以编译为原生代码,在编译的时候都将语言转为机器语言，在启动的时候直接执行即可，在 CPU 密集场景下，Go 更具性能优势。

- 多线程 VS 单线程

JavaScript 本质上是一门单线程语言，直到引入 WebWorker 之后才有可能在浏览器、Node 中实现多线程操作。就我对Webpack的源码理解，其源码也并未使用 WebWorker 提供的多线程能力。而GO天生的多线程优势。

- 对构建流程进行了优化，充分利用 CPU 资源

**实现原理**

Vite预编译之后，将文件缓存在node_modules/.vite/文件夹下。根据以下地方来决定是否需要重新执行预构建。

- package.json中：dependencies发生变化
- 包管理器的lockfile

**核心代码**

- 通过createServer创建server对象后，当服务器启动会执行httpServer.listen方法
- 在执行createServer时，Vite底层会重写server.listen方法:首先调用插件的buildStart再执行runOptimize()方法
- runOptimize()调用optimizeDeps()和createMissingImporterRegisterFn()方法
- optimizeDeps()主要是根据配置文件生成hash，获取上次预购建的内容(存放在_metadata.json文件)。如果不是强预构建就对比_metadata.json文件的hash和新生成的hash：一致就返回_metadata.json文件的内容，否则清空缓存文件调用Esbuild构建模块再次存入_metadata.json文件

## 小结

优点：

- 快速的冷启动: 采用No Bundle和esbuild预构建，速度远快于Webpack 
- 高效的热更新：基于ESM实现，同时利用HTTP头来加速整个页面的重新加载，增加缓存策略
- 真正的按需加载: 基于浏览器ESM的支持，实现真正的按需加载

缺点：

- 生态：目前Vite的生态不如Webapck，不过我觉得生态也只是时间上的问题。
- 生产环境由于esbuild对css和代码分割不友好使用Rollup进行打包

Vite.js虽然才在构建打包场景兴起，但在很多场景下基本都会优于现有的解决方案。如果有生态、想要丰富的loader、plugins的要求可以考虑成熟的Webpack。在其余情况下，Vite.js不失为一个打包构建工具的好选择。