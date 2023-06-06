---
title: 性能优化_webpack
date: 2023-03-12 10:33:16
categories:
- H_工程热点
toc: true # 是否启用内容索引
---

# 入门



## 前言

**module，chunk 和 bundle是什么**

> - 同一份逻辑代码在不同转换场景下的取了三个名字， module是源码，module经过webpack处理成chunk，webpack最后输出bundle。
> - module：源码文件，包括 ESM或commonJS 或是UMD
> - chunk：webpack 会根据文件引用关系生成 chunk 文件，webpack 会对这个 chunk 文件进行一些操作
> - bundle：webpack 处理好 chunk 文件后，最后会输出 **bundle** 文件，这个 bundle 文件包含了经过加载和编译的最终源文件，所以它可以直接在浏览器中运行

**打包后文件目录**

> - app.js:就是app.vue文件 
> - mainfest.js:一些异步加载的实现方法
> - vender.js:vue核心功能被打包到这里
> - chunk.js:主要的页面路由被打包编译在此

## webpack是什么

**定义**

> webpack 是一个模块打包机，将根据文件间的依赖关系对其进行静态分析，然后按指定规则递归地构建一个依赖关系图，最终打包成一个或多个 bundle。

**核心模块**

> - entry: 入口
> - output: 输出
> - loader: 模块转换器，用于把模块原内容按照需求转换成新内容
> - 插件(plugins): 扩展插件，在webpack构建流程中的特定时机注入扩展逻辑来改变构建结果或做你想要做的事情

**特点**

> - 支持多种模块化标准方案，包括ES Module,CommonJS,UMD
> - 支持code splitting代码分割和文件分块
> - 支持loader静态文件串联处理，强大的plugin插件扩展功能

**打包工具**

gulp/grunt是自动化任务构建工具。

> - gulp/grunt：是一种能够优化前端开发的工作流程的工具，比如css/js的压缩混淆，预处理语言的编译、图片体积优化等等。与webpack有部分重合，比如打包、压缩混淆、图片转 base64 等等。但它们的目的跟要解决的问题是不一样的。

webapck/browserify/seajs/requirejs是模块化解决方案，强调模块化开发，而那些文件压缩合并、预处理等功能，不过是附带的功能。

> - seajs/requirejs： 是一种在线"编译" 模块的方案，相当于在页面上加载一个 CMD/AMD 解释器。这样浏览器就认识了 define、exports、module 这些东西。也就实现了模块化。
> - webpack/browserify： 是一个预编译模块的方案，相比于上面 ，这个方案更加智能。以webpack为例。首先，它是预编译的，不需要在浏览器中加载解释器。另外，你在本地直接写JS，不管是 AMD / CMD / ES6 风格的模块化，它都能认识，并且编译成浏览器认识的JS。

## webpack打包原理

打包概况：

> - 从入口文件开始，分析整个个应用的依赖树
> - 将每个依赖模块包装起来，放到一个数组中，等待被调用
> - 执行模块加载方法，确定模块之间以互相调用
> - 把执行入口文件的逻辑放在一个立即执行函数汇总，参数就是模块数组

详细流程:

> （1）初始化参数：解析webpack配置参数，合并shell传入和webpack.config.js文件配置的参数，形成最后的配置结果。
>
> （2）开始编译：上一步得到的参数初始化compiler对象，注册所有配置的插件，插件监听webpack构建生命周期的事件节点，做出相应的反应，执行对象的 run 方法开始执行编译。
>
> （3）确定入口：从配置的entry入口，开始解析文件构建AST语法树，找出依赖，递归下去。
>
> （4）编译模块：递归中根据文件类型和loader配置，调用所有配置的loader对文件进行转换，再找出该模块依赖的模块，再递归本步骤直到所有入口依赖的文件都经过了本步骤的处理。
>
> （5）完成模块编译并输出：递归完事后，得到每个文件结果，包含每个模块以及他们之间的依赖关系，根据entry配置生成代码块chunk。
>
> （6）输出完成：输出所有的chunk到文件系统。

打包流程：

![image-20211215065353682](/img/image-20211215065353682.png)

打包核心源码：

```
1)首先是一个自执行函数
2)参数通过对象形式传递，key是文件路径，value是函数，eval()表示执行字符串代码。eval执行vaule函数字符串。
3)如果有多个依赖文件，最终会打包成一个文件
4)__webpack_require__最重要，模拟了require方法，将所有的引入合并成一个文件
5)通过递归的方式不断调用自己__webpack_require__，检查自己的依赖关系
(function(modules){
    //module缓存对象
    var installedModules = {};
    //require函数精髓
    function __webpack_require__(moduleId){
        //检查module是否在cache中
        if(installedModules[moduleId]){
            return installedModules[moduleId].exports;
        }
        //若不在cache中则新建module并放入cache中
        var module = installedModules[moduleId] = {
            exports: {},
            id: moduleId,
            loaded: false
        };
        //执行module函数
        modules[moduleId].call(module.exports, module, module.exports, __webpack_require__);
        //标记module已经加载
        module.loaded = true;
        //返回module的导出模块
        return module.exports;
    }

    //暴露modules对象（__webpack_modules__）
    __webpack_require__.m = modules;
    //暴露modules缓存
    __webpack_require__.c = installedModules;
    //设置webpack公共路径__webpack_public_path__
    __webpack_require__.p = "";
    //读取入口模块并且返回exports导出
    return __webpack_require__(0);

})([function(module, exports, __webpack_require__){ /*模块Id为0*/
    var text = __webpack_require__(1);
    console.log(text);
},function(module, exports){ /*模块Id为1*/
    module.exports = 'Hello world';
}]);
```

## webpack优化策略

**分析工具**

> - webpack-bundle-analyzer打包分析神器
> - speed-measure-webpack-plugin分析整个打包时长，涉及所有 loader 和 plugins

**优化指标**

> - 体积更小
>   - 使用摇树技术Tree-Shaking
>   - 使用作用域提升scope-hositing
>   - 缩小打包范围
>   - 压缩h5图片样式文件
>   - splitChunks 代码分割，抽取公共代码
> - 速度更快
>   - 使用多线程打包
>   - 使用中间缓存优化

**一、体积更小**

**使用摇树技术Tree-Shaking**

> DCE（Dead Code Elimination）消除无用js代码。Tree-Shaking 目前只适用于 ESModule模块化的代码，不适用commonjs。通过静态分析将无用代码打上标记，然后删除标记的无用代码。配置usedExports: true,配置mode：production生产环境。或者配置terser-webpack-plugin

**使用作用域提升scope-hositing**

> 把多个作用域用一个作用域取代，以减少内存消耗并减少包裹块代码

**缩小打包范围**

> - 压缩html,如html-webpack-plugin
> - cacheDirectory开启babel缓存，提高二次构建速度，缓存loader执行结果；
> - 优化 module.noParse,不解析依赖打包，externals编译后不打包
> - 优化 resolve.modules，默认值为 ['node_modules']，会逐层查找第三方模块，直接指定绝对路径，更快速查找；
> - 优化 resolve.extensions ,默认值为 ['.wasm', '.mjs', '.js', '.json'],修改为js,ts，更快速匹配文件；
> - 排除对于语言包的打包,比如moment，排除多余语言，new webpack.IgnorePlugin(/\.\/locale/,/moment/)

**压缩h5图片样式文件**

> - HtmlWebpackPlugin优化压缩html
> - UglifyjsWebpackPlugin升级后的minimize压缩
> - 压缩图片，使用 url-loader 减少 http 请求,图片转为内置base64URI
> - 使用 optimize-css-assets-plugin 压缩 CSS

**splitChunks 代码分割，抽取公共代码**

> - entry 配置多入口
> - 动态路由载入
> - splitChunks 配置

splitChunks 规则和配置

> 拆分合并规则：
> a.命名规则：vendor~a~b.js。vendor前缀表示命中缓存，a-b表示a和b有相同模块合并。cacheGroups表示缓存组，被命中的缓存组模块，会以vendor为前缀。
> b.如果都是异步代码，都会被默认拆分出来打包成独立文件。相同模块会自动合并，命名后缀均为a_lodash.js。
> c.如果都是同步代码，在"async"模式下，不拆分不合并;在“initial或all”模式下，会拆分且合并；vendors_a-b_lodash.js。
> d.如果是一同步一异步代码，在"async"模式下，同步代码不拆分不合并;在"initial"模式下，会拆分同步代码，但是同步代码与异步代码相同模块不会合并；在"all"模式下，会拆分且合并。

```js
module.exports = {
    // ...
    optimization: {
        splitChunks: {
            chunks: 'async', // 三选一： "initial" | "all" | "async" (默认)
            minSize: 30000, // 最小尺寸，30K，development 下是10k，越大那么单个文件越大，chunk 数就会变少（针对于提取公共 chunk 的时候，不管再大也不会把动态加载的模块合并到初始化模块中）当这个值很大的时候就不会做公共部分的抽取了
            maxSize: 0, // 文件的最大尺寸，0为不限制，优先级：maxInitialRequest/maxAsyncRequests < maxSize < minSize
            minChunks: 1, // 默认1，被提取的一个模块至少需要在几个 chunk 中被引用，这个值越大，抽取出来的文件就越小
            maxAsyncRequests: 5, // 在做一次按需加载的时候最多有多少个异步请求，为 1 的时候就不会抽取公共 chunk 了
            maxInitialRequests: 3, // 针对一个 entry 做初始化模块分隔的时候的最大文件数，优先级高于 cacheGroup，所以为 1 的时候就不会抽取 initial common 了
            automaticNameDelimiter: '~', // 打包文件名分隔符
            name: true, // 拆分出来文件的名字，默认为 true，表示自动生成文件名，如果设置为固定的字符串那么所有的 chunk 都会被合并成一个
            cacheGroups: {
                vendors: {
                    test: /[\\/]node_modules[\\/]/, // 正则规则，如果符合就提取 chunk
                    priority: -10 // 缓存组优先级，当一个模块可能属于多个 chunkGroup，这里是优先级
                },
                default: {
                    minChunks: 2,
                    priority: -20, // 优先级
                    reuseExistingChunk: true // 如果该chunk包含的modules都已经另一个被分割的chunk中存在，那么直接引用已存在的chunk，不会再重新产生一个
                }
            }
        }
    }
};
```

**二、速度更快**

**使用多线程打包happypack-loader**

> 原理：每次 `webapck` 解析一个模块，`HappyPack` 会将它及它的依赖分配给 `worker` 线程中。处理完成之后，再将处理好的资源返回给 `HappyPack` 的主进程，从而加快打包速度。

**使用中间缓存优化HardSourceWebpackPlugin**

# 进阶

## webpack-loader机制

- [【万字长文｜趣味图解】彻底弄懂Webpack中的Loader机制](https://juejin.cn/post/7157739406835580965#heading-16)

loader是文件加载器，能够加载资源文件，并对这些文件进行一些处理，如编译、压缩等、语法分析及转换，然后交由下一环节进行处理，所有载入的模块最终都会经过moduleFactory处理，转成javascript可以识别和运行的代码，从而完成模块的集成。

**Loader本质**

Loader 本质上是导出为函数的 JavaScript 模块。`它接收资源文件或者上一个 Loader 产生的结果作为入参，也可以用多个 Loader 函数组成 loader chain（链），最终输出转换后的结果`。

**Loader的四种类型**

分为：[前置(pre)](https://link.juejin.cn/?target=https%3A%2F%2Fwebpack.docschina.org%2Fconfiguration%2Fmodule%2F%23ruleenforce)、[普通(normal)](https://link.juejin.cn/?target=https%3A%2F%2Fwebpack.docschina.org%2Fconfiguration%2Fmodule%2F%23ruleenforce)、[行内(inline)](https://link.juejin.cn/?target=https%3A%2F%2Fwebpack.docschina.org%2Fconfiguration%2Fmodule%2F%23ruleenforce)、[后置(post)](https://link.juejin.cn/?target=https%3A%2F%2Fwebpack.docschina.org%2Fconfiguration%2Fmodule%2F%23ruleenforce)。

```
  module: {
    rules: [
      {
        test: /\.css$/,
        use: [
          "style-loader", //将css内容变成style标签插入到html中去
          "css-loader", //解析css文件的路径等
          "less-loader", //将less=>css
        ],
        enforce: "pre", //这里也可以是post，默认不写就是normal
      },
    ],
  },
```

**Loader执行顺序**

简单说：Loader 的执行顺序是由右向左，或者由下到上执行。

官方说法：**Pitching** 阶段和**Normal** 阶段

所有一个接一个地进入的 Loader，都有两个阶段：

1. **Pitching** 阶段: Loader 上的 pitch 方法，按照 `后置(post)、行内(inline)、普通(normal)、前置(pre)` 的顺序调用。
2. **Normal** 阶段: Loader 上的 常规方法，按照 `前置(pre)、普通(normal)、行内(inline)、后置(post)` 的顺序调用。模块源码的转换， 发生在这个阶段。
3. 同等类型下的 Loader 执行顺序才是由右向左，或者由下到上执行。

> 以处理SCSS文件为例：
>
> - SCSS源代码会先交给`sass-loader`把SCSS转换成CSS；
> - 把`sass-loader`输出的CSS交给`css-loader`处理，找出CSS中依赖的资源、压缩CSS等；
> - 把`css-loader`输出的CSS交给`style-loader`处理，转换成通过脚本加载的JavaScript代码；
>
> 先`sass-loader`再`css-loader`再`style-loader`，每个`Loader`会链式的顺序执行， 第一个Loader将会拿到需处理的原内容，上一个`Loader`处理后的结果会传给下一个接着处理。

**babel文件编译器**

> bebel-loader中核心的是，@babel-core核心包、@babel-preset-env预设。
> babel是javascript语法的编译器。比如class，let,for...of promise等等这样的，低版本浏览器不支持，babel编译器将es6代码转换成浏览器能识别的代码。默认情况下对新的语法和API中的，新的语法进行转换。
> 在Babel执行编译的过程中，会从项目的根目录下的 .babelrc文件中读取配置。.babelrc是一个json格式的文件。
> 在.babelrc配置文件中，主要是对预设(presets) 和 插件(plugins) 进行配置。

## webpack-plugin机制

**原理**

plugin` 是一个扩展器，它丰富了 webpack 本身，针对是 `loader` 结束后，webpack 打包的整个过程，它并不直接操作文件，而是基于事件机制工作，会监听webpack 打包过程中的某些节点，执行广泛的任务。

**Plugin 的作用**：

- 能够 hook 到在每个编译(compilation)中触发的所有关键事件。
- 在插件实例的 apply 方法中，可以通过 compiler.options 获取 Webpack 配置，并进行修改。

## webpack-vueloader机制

**完整流程**

.vue 单文件文件组件类型的文件（下文简称 **SFC**）。Webpack 需要增加 vue-loader 和 vueLoaderPlugin 对 SFC 进行支持。入参 source 是 SFC 源码，经过处理逻辑后，输出 export default 的代码字符串。

![image-20211222073047966](C:/img/image-20211222073047966.png)

1.SFC 的输入和输出

![image-20211222073237881](C:/img/image-20211222073237881.png)

2.template、script、style 代码块切分

 template、script、style 代码块在输出结果中已经转化为对应的 import 逻辑。这一步是 vue-loader 调用了 @vue/component-compiler-utils 的 parse 函数进行解析后，分别生成了对应的 import 逻辑.

![image-20211222073348756](C:/img/image-20211222073348756.png)

3.VueLoaderPlugin 的作用

vue&type=template 的作用是什么?

VueLoaderPlugin 通过plugin的第2作用，对 module.rules 进行动态修改。

VueLoaderPlugin 的处理流程中，修改了 module.rules，在原来的基础上加入了 pitcher 和 cloneRules 。这一步的作用是：新增的 rule ，能识别形如 ?vue&type=template 的 querystring，让不同语言的代码块匹配到对应的 rule。

![image-20211222073538232](C:/img/image-20211222073538232.png)

4.SFC 转化流程

每个代码块都导出了对应逻辑，我们以 script 块为例，结合第二节的 PitcherLoader 再次进行转化.

![image-20211222073711287](C:/img/image-20211222073711287.png)

5.再次执行 VueLoader

在 PitchLoader 的转化结果中，还是会以 vue-loader 作为第一个处理的 loader，但 vue-loader 不是一开始就转化过了吗 ？与第一次不同的是，这次 vue-loader 的作用，仅仅是**把 SFC 中语法块的源码提取出来，并交给后面的 loader 进行处理**。

![image-20211222073804134](/img/image-20211222073804134.png)

## webpack-手写loader

自定义loader分为:同步loader和异步loader

```
webpack.config.js
const path = require('path');
module:{
 rules:[
  {
   test:/.js$/,
   use:[
    path.resolve(__dirname,'./loaders/replace.js')
   ]
  }
 ]
}

index.js
console.log('luwentest')

//同步loader,修改打包内容
replace.js
module.export = function(context){
//没有使用箭头函数，可能需要修改this指向
return context.replace(/luwentest/g,'luwenProduction')
}

asyncReplace.js
//异步loader
const sleep = num =>new Promise((resolve)=>{
 setTimeout(()=>{
  resolve();
 },num)
});
module.export = function(content){
//获取loader的异步回调函数
 cosnt callback= this.async();
 ;(async()=>{
 //立即执行函数
 await sleep(3000);
 content = context.replace(/luwentest/g,'luwenProduction')
 //执行回调函数，传入4个参数，第1个是error信息，2是内容，3，4未知
 callback(null,content);
 })();
}
```

## webpack-手写plugin

必须条件：

- 必须是一个class类；
- 必须重写apply方法；
- 必须调用complier API来影响打包结果；

> - 1.webpack 读取配置的过程中会先执行 `new HelloPlugin(options)` 初始化一个 `HelloPlugin` 获得其实例。
> - 2.初始化 `compiler` 对象后调用 `HelloPlugin.apply(compiler)` 给插件实例传入 compiler 对象。
> - 3.插件实例在获取到 `compiler` 对象后，就可以通过 `compiler.plugin` (事件名称, 回调函数) 监听到 Webpack 广播出来的事件。 并且可以通过 `compiler` 对象去操作 Webpack

```
//在项目打包时，动态创建license证书
license-webpack-plugin.js
class LicenseWebpackPlugins{
 constructor(parmas){
  console.log(parmas);
 }
 apply(complier){
  // 在emit阶段插入钩子函数，用于特定时机处理额外的逻辑；
    compiler.hooks.emit.tap('HelloPlugin', (compilation) => {
      // 在功能流程完成后可以调用 webpack 提供的回调函数；
    })
    // 如果事件是异步的，会带两个参数，第二个参数为回调函数，
    compiler.plugin('emit', function (compilation, callback) {
      // 处理完毕后执行 callback 以通知 Webpack
      // 如果不执行 callback，运行流程将会一直卡在这不往下执行
      callback()
    })
 //Compiler 代表了整个 Webpack 从启动到关闭的生命周期
 //Compilation 只是代表了一次新的编译，只要文件有改动，compilation 就会被重新创建。
 //tapAsync表示异步处理，接收2个参数，第1个参数是类名，第2个是函数，
 //第2个是函数,包括2个参数，第1个参数是compliation类似可编译对象实例，第2个是cb回调函数
  complier.hook.emit.tapAsync('LicenseWebpackPlugins',(compliation,cb)=>{
   compliation.assets['LICENSE']={
    source:function(){
     return 'xxxxx我的证书信息'
    }
   }
  })
 }
}
```

## webpack3、4、5比较

webpack4比3的优化：

> - `v8` 引擎带来的优化（`for of` 替代 `forEach`、`Map` 和 `Set` 替代 `Object`、`includes` 替代 `indexOf`）
> - 默认使用更快的 `md4 hash` 算法
> - `webpack AST` 可以直接从 `loader` 传递给 `AST`，减少解析时间
>
> - 增加了mode配置，development | production，production配置默认启用 FlagDependencyUsagePlugin, FlagIncludedChunksPlugin, ModuleConcatenationPlugin, NoEmitOnErrorsPlugin, OccurrenceOrderPlugin, SideEffectsFlagPlugin 和 UglifyJsPlugin。
> - splitChunks替代了CommonChunksPlugin
> - MiniCssExtractPlugin取代ExtractTextWebpackPlugin
> - 代码分割，支持动态import，而不是用system.import或者require.ensure
> - vue-loader，使用vue-loader插件为.vue文件中的各部分使用相对应的loader，比如css-loader
> - UglifyJsPlugin，使用optimization.minimize为true就行

webpack5比4的优化：

> - 内置 terser-webpack-plugin,mode=“production” 配置自动开启js压缩，自动开启 tree-shaking。而webpack4需要安装 terser-webpack-plugin。
>
> - 内置 cache 缓存机制，cache 会在开发模式下被设置成 type： memory 而且会在生产模式把cache 给禁用掉。wepback4需要npm install hard-source-webpack-plugin -D
>
> - 5需要webpack serve 启动服务。日志不好。4可以webpack-dev-server 启动服务
>
> - raw-loader 将文件导入为字符串，asset/source 替换 raw-loader（导出源代码）
>
>   url-loader 将文件作为 data url 内联到 bundle文件中，asset/inline 替换 url-loader （导出 url）
>
>   file-loader 将文件发送到输出目录中，asset/resource 替换 file-loader(发送单独文件)
>
> - 5.2版本以后提供npx webpack全局命令，支持全局操作,原理：当前目录下查找node_module,如果没有用，则下载webpack

## ESbuild就比webpack快

![image-20211215065812474](/img/image-20211215065812474.png)

我的主基准测试会将 three.js 库复制 10 次并从头开始构建单个包，过程中没有任何缓存，从而模拟一个大型代码库。在这个基准测试中，esbuild 比我测试的其他 JavaScript 打包器（Webpack、Rollup、Parcel 和 FuseBox）**快 10-100 倍**。这个基准测试可以使用’make bench-three’来运行。

目前支持：

> - CommonJS 模块
> - ES6 模块
> - 使用’–bundle’与 ES6 模块的静态绑定打包
> - 使用’–minify’完全压缩（空格、标识符和修饰符）
> - 启用’–sourcemap’时，完全支持源映射
> - .jsx 文件的 JSX 到 JavaScript 转换
> - 通过’–define’进行编译时标识符替换
> - 使用 package.json 中的’browser’字段进行路径替换
> - 自动检测 tsconfig.json 中的’baseUrl’

为什么这么快：

> - 它是用 Go 语言编写的，该语言可以编译为原生代码；
> - 解析，打印和源映射生成全部完全并行化；
> - 无需昂贵的数据转换，只需很少的几步即可完成所有操作；
> - 编写代码时处处注意速度表现，并尽量避免不必要的配置。

webpack性能瓶颈

> - 代码构建
>
>   浏览器的很多包分析工具是用`C/C++`写的, 显然是要比 `webpack` 使用 `js` 去分析整个`依赖图谱`更具优势，速度上也是要快很多的。
>
> - 代码压缩
>
>   `webpack` 使用的 `terser`, 是用 `js` 写的，不如go语言编写的esbuild

![image-20211215065505606](/img/image-20211215065505606.png)

# 高级

## webpack-code splitting代码分割

[详解webpack code splitting](https://juejin.cn/post/6844903793151180807#heading-0)

**代码分割需要做的事情：**

> 为 Vendor 单独打包（Vendor 指第三方的库或者公共的基础组件，因为 Vendor 的变化比较少，单独打包利于缓存）
>
> 为 Manifest （Webpack 的 Runtime 代码）单独打包
>
> 为不同入口的业务代码打包，也就是代码分割异步加载（同理，也是为了缓存和加载速度）
>
> 为异步公共加载的代码打一个的包

**分割的两种方式：**

> 1. require.ensure代码分割：通过require.ensure定义分割点，将代码进行分割打包，异步加载
> 2. dynamic import代码分割：在动态代码拆分方面，webpack支持符合ECMAScript提议的import()语法进行代码分割和异步加载。

1.require.ensure代码分割

webpack 在编译时，会静态地解析代码中的 require.ensure()，同时将模块添加到一个分开的 chunk 当中，这个新的 chunk 会被 webpack 通过 jsonp 来异步加载，其他包则会同步加载。

2.dynamic import 代码分割

requre.ensure好像已被webpack4废弃。es6提供了一种更好的代码分割方案也就是dynamic import（动态加载）的方式，webpack打包时会根据import()自动代码分割；

## webpack分包策略

- 基础类库 `chunk-libs`
- UI 组件库 `chunk-elementUI`
- 自定义共用组件/函数 `chunk-commons`
- 低频组件 `chunk-eachrts`/`chunk-xlsx`等
- 业务代码 lazy-loading `xxxx.js`

| 类型            | 共用率 | 使用频率 | 更新频率 | 例子                                                         |
| :-------------- | :----: | :------: | :------: | ------------------------------------------------------------ |
| 基础类库        |   高   |    高    |    低    | vue/react、vuex/mobx、xx-router、axios 等                    |
| UI 组件库       |   高   |    高    |    中    | Element-UI/Ant Design 等                                     |
| 必要组件/函数   |   高   |    高    |    中    | Nav/Header/Footer 组件、路由定义、权限验证、全局 State 、全局配置等 |
| 非必要组件/函数 |   高   |    高    |    中    | 封装的 Select/Radio 组件、utils 函数 等 (必要和非必要组件可合并) |
| 低频组件        |   低   |    低    |    低    | 富文本、Mardown-Editor、Echarts、Dropzone 等                 |
| 业务代码        |   低   |    高    |    高    | 业务组件、业务模块、业务页面  等                             |

- 基础类库 chunk-libs

它是构成我们项目必不可少的一些基础类库，比如 `vue`+`vue-router`+`vuex`+`axios` 这种标准的全家桶，它们的升级频率都不高，但每个页面都需要它们。（一些全局被共用的，体积不大的第三方库也可以放在其中：比如 nprogress、js-cookie、clipboard 等）

- UI 组件库

理论上 UI 组件库也可以放入 libs 中，但这里单独拿出来的原因是： 它实在是比较大，不管是 `Element-UI`还是`Ant Design` gizp 压缩完都可能要 200kb 左右，它可能比 libs 里面所有的库加起来还要大不少，而且 UI 组件库的更新频率也相对的比 libs 要更高一点。我们不时的会升级 UI 组件库来解决一些现有的 bugs 或使用它的一些新功能。所以建议将 UI 组件库也单独拆成一个包。

- 自定义组件/函数 chunk-commons

这里的 commons 主要分为 **必要**和**非必要**。

必要组件是指那些项目里必须加载它们才能正常运行的组件或者函数。比如你的路由表、全局 state、全局侧边栏/Header/Footer 等组件、自定义 Svg 图标等等。这些其实就是你在入口文件中依赖的东西，它们都会默认打包到`app.js`中。

非必要组件是指被大部分页面使用，但在入口文件 entry 中未被引入的模块。比如：一个管理后台，你封装了很多 select 或者 table 组件，由于它们的体积不会很大，它们都会被默认打包到到每一个懒加载页面的 chunk 中，这样会造成不少的浪费。你有十个页面引用了它，就会包重复打包十次。所以应该将那些被大量共用的组件单独打包成`chunk-commons`。

不过还是要结合具体情况来看。一般情况下，你也可以将那些*非必要组件\函数*也在入口文件 entry 中引入，和*必要组件\函数*一同打包到`app.js`之中也是没什么问题的。

- 低频组件

低频组件和上面的共用组件 `chunk-commons` 最大的区别是，它们只会在一些特定业务场景下使用，比如富文本编辑器、`js-xlsx`前端 excel 处理库等。一般这些库都是第三方的且大于 30kb，所以 webpack 4 会默认打包成一个独立的 bundle。也无需特别处理。小于 30kb 的情况下会被打包到具体使用它的页面 bundle 中。

- 业务代码

这部分就是我们平时经常写的业务代码。一般都是按照页面的划分来打包，比如在 vue 中，使用[路由懒加载](https://router.vuejs.org/zh/guide/advanced/lazy-loading.html)的方式加载页面 `component: () => import('./Foo.vue')` webpack 默认会将它打包成一个独立的 bundle。

完整配置代码：

```js
splitChunks: {
  chunks: "all",
  cacheGroups: {
    libs: {
      name: "chunk-libs",
      test: /[\\/]node_modules[\\/]/,
      priority: 10,
      chunks: "initial" // 只打包初始时依赖的第三方
    },
    elementUI: {
      name: "chunk-elementUI", // 单独将 elementUI 拆包
      priority: 20, // 权重要大于 libs 和 app 不然会被打包进 libs 或者 app
      test: /[\\/]node_modules[\\/]element-ui[\\/]/
    },
    commons: {
      name: "chunk-comomns",
      test: resolve("src/components"), // 可自定义拓展你的规则
      minChunks: 2, // 最小共用次数
      priority: 5,
      reuseExistingChunk: true
    }
  }
};
```

# 参考

[webpack 优秀中文文章](https://github.com/webpack-china/awesome-webpack-cn)

[[万字总结] 一文吃透 Webpack 核心原理](https://mp.weixin.qq.com/s/SbJNbSVzSPSKBe2YStn2Zw)

[webpack三部曲-带你深度解锁Webpack系列(基础篇)](https://segmentfault.com/a/1190000021953371)

[webpack三部曲带-你深度解锁Webpack系列(进阶篇)](https://segmentfault.com/a/1190000022041106)

[webpack三部曲-带你深度解锁Webpack系列(优化篇)](https://segmentfault.com/a/1190000022205477)

[浅谈webpack性能优化](https://segmentfault.com/a/1190000022561279)

[记一次真实的Webpack优化经历](https://juejin.cn/post/6908897055599509512)

[17项关于webpack的性能优化](https://juejin.cn/post/6951297954770583565)

[Webpack之SplitChunks插件用法详解](https://zhuanlan.zhihu.com/p/152097785)

[webpack 4 Code Splitting 的 splitChunks 配置探索](https://imweb.io/topic/5b66dd601402769b60847149)

[webpack优化之玩转代码分割和公共代码提取](https://champyin.com/2019/11/15/webpack%E4%BC%98%E5%8C%96%E4%B9%8B%E7%8E%A9%E8%BD%AC%E4%BB%A3%E7%A0%81%E5%88%86%E5%89%B2%E5%92%8C%E5%85%AC%E5%85%B1%E4%BB%A3%E7%A0%81%E6%8F%90%E5%8F%96/)