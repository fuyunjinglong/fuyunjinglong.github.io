---
title: 性能优化_webpack入门到精通
date: 2023-03-12 10:33:16
categories:
- H_工程热点
toc: true # 是否启用内容索引
---

# 入门

## 基本概念

**module，chunk 和 bundle关系**

> 其实就是同一份逻辑代码在不同转换场景下的取了三个名字，直接写出来的是 module，webpack 处理时是 chunk，最后生成浏览器可以直接运行的 bundle。
> devDependencies  里面的插件只用于开发环境，不用于生产环境，而 dependencies  是需要发布到生产环境的。 比如我们写一个项目要依赖于jQuery，没有这个包的依赖运行就会报错，这时候就把这个依赖写入dependencies ； 而我们使用的一些构建工具比如glup、webpack这些只是在开发中使用的包，上线以后就和他们没关系了，所以将它写入devDependencies。**–save**会把依赖包名称添加到package.json文件**dependencies**键下，**–save-dev**则添加到package.json文件**devDependencies**键下

**打包后文件目录**

> - app.js:就是app.vue文件 
> - mainfest.js:一些异步加载的实现方法
> - vender.js:vue核心功能被打包到这里
> - chunk.js:主要的页面路由被打包编译在此

## webpack打包原理

- 从入口文件开始，分析整个个应用的依赖树
- 将每个依赖模块包装起来，放到一个数组中，等待被调用
- 执行模块加载方法，确定模块之间以互相调用
- 把执行入口文件的逻辑放在一个立即执行函数汇总，参数就是模块数组

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

## webpack-loader文件解析器

**原理**

loader是文件加载器，能够加载资源文件，并对这些文件进行一些处理，如编译、压缩等、语法分析及转换，然后交由下一环节进行处理，所有载入的模块最终都会经过moduleFactory处理，转成javascript可以识别和运行的代码，从而完成模块的集成。

> 以处理SCSS文件为例：
>
> - SCSS源代码会先交给`sass-loader`把SCSS转换成CSS；
> - 把`sass-loader`输出的CSS交给`css-loader`处理，找出CSS中依赖的资源、压缩CSS等；
> - 把`css-loader`输出的CSS交给`style-loader`处理，转换成通过脚本加载的JavaScript代码；
>
> 先`sass-loader`再`css-loader`再`style-loader`，每个`Loader`会链式的顺序执行， 第一个Loader将会拿到需处理的原内容，上一个`Loader`处理后的结果会传给下一个接着处理。

```
module：{
rule:[
 {
    test:'css,style,babel'// cssstyle快速优化，babel将es6转es5,jsx转js
 loader:‘对应loader’
 }
]
}
```

**babel文件编译器**

> bebel-loader中核心的是，@babel-core核心包、@babel-preset-env预设。
> babel是javascript语法的编译器。比如class，let,for...of promise等等这样的，低版本浏览器不支持，babel编译器将es6代码转换成浏览器能识别的代码。默认情况下对新的语法和API中的，新的语法进行转换。
> 在Babel执行编译的过程中，会从项目的根目录下的 .babelrc文件中读取配置。.babelrc是一个json格式的文件。
> 在.babelrc配置文件中，主要是对预设(presets) 和 插件(plugins) 进行配置。

## webpack-plugin插件

**原理**

plugin` 是一个扩展器，它丰富了 webpack 本身，针对是 `loader` 结束后，webpack 打包的整个过程，它并不直接操作文件，而是基于事件机制工作，会监听webpack 打包过程中的某些节点，执行广泛的任务。

**Plugin 的作用**：

- 能够 hook 到在每个编译(compilation)中触发的所有关键事件。
- 在插件实例的 apply 方法中，可以通过 compiler.options 获取 Webpack 配置，并进行修改。

## webpack-vueloader

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

# webpack三部曲

[带你深度解锁Webpack系列(基础篇)](https://segmentfault.com/a/1190000021953371)

[带你深度解锁Webpack系列(进阶篇)](https://segmentfault.com/a/1190000022041106)

[带你深度解锁Webpack系列(优化篇)](https://segmentfault.com/a/1190000022205477)

# webpack分包策略

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

## 持久化缓存

[持久化缓存原文](https://panjiachen.github.io/awesome-bookmarks/blog/webpack/webpack4-b.html)

- 使用 `runtimeChunk` 提取 `manifest`，使用 `script-ext-html-webpack-plugin`等插件内联到`index.html`减少请求
- 使用 `HashedModuleIdsPlugin` 固定 `moduleId`
- 使用 `NamedChunkPlugin`结合自定义 nameResolver 来固定 `chunkId`

原理：

- 针对 html 文件：不开启缓存，把 html 放到自己的服务器上，关闭服务器的缓存
- 针对静态的 js，css，图片等文件：开启 cdn 和缓存，将静态资源上传到 cdn 服务商，我们可以对资源开启长期缓存，因为每个资源的路径都是独一无二的，所以不会导致资源被覆盖，保证线上用户访问的稳定性。
- 每次发布更新的时候，先将静态资源(js, css, img) 传到 cdn 服务上，然后再上传 html 文件，这样既保证了老用户能否正常访问，又能让新用户看到新的页面。

## 博弈

其实优化就是一个**博弈**的过程，是让 a bundle 大一点还是 b? 是让首次加载快一点还是让 cache 的利用率高一点？ 但有一点要切记，拆包的时候不要过分的追求颗粒化，什么都单独的打成一个 bundle，不然你一个页面可能需要加载十几个`.js`文件，如果你还不是`HTTP/2`的情况下，请求的阻塞还是很明显的(受限于浏览器并发请求数)。所以还是那句话资源的加载策略并没什么完全的方案，都需要结合自己的项目找到最合适的拆包策略。

> 比如支持`HTTP/2`的情况下，你可以使用 `webpack4.15.0` 新增的 [maxSize](https://webpack.js.org/plugins/split-chunks-plugin/#splitchunks-maxsize)，它能将你的`chunk`在`minSize`的范围内更加合理的拆分，这样可以更好地利用`HTTP/2`来进行长缓存(在`HTTP/2`的情况下，缓存策略就和之前又不太一样了)。

# 性能优化-Tree Shaking

## 什么是Tree Shaking？

Tree-Shaking 是一种基于 ES Module 规范的 Dead Code Elimination 技术，它会在运行过程中静态分析模块之间的导入导出，确定 ESM 模块中哪些导出值未曾其它模块使用，并将其删除，以此实现打包产物的优化。

## Tree Shaking的必要条件

必须同时满足三个条件：

- 使用 ESM 规范编写模块代码
- 配置 `optimization.usedExports` 为 `true`，启动标记功能
- 启动代码优化功能，可以通过如下方式实现：
  - 配置 `mode = production`
  - 配置 `optimization.minimize = true`
  - 提供 `optimization.minimizer` 数组

## 实现原理

Webpack 中，Tree-shaking 的实现一是先**标记**出模块导出值中哪些没有被用过，二是使用 Terser 删掉这些没被用到的导出语句。标记过程大致可划分为三个步骤：

- Make 阶段，收集模块导出变量并记录到模块依赖关系图 ModuleGraph 变量中
- Seal 阶段，遍历 ModuleGraph 标记模块导出变量有没有被使用
- 生成产物时，若变量没有被其它模块使用则删除对应的导出语句

> 标记功能需要配置 `optimization.usedExports = true` 开启

也就是说，标记的效果就是删除没有被其它模块使用的导出语句。

真正执行“**Shaking**”操作的是 Terser 插件。例如在上例中 `foo` 变量经过标记后，已经变成一段 Dead Code —— 不可能被执行到的代码，这个时候只需要用 Terser 提供的 DCE 功能就可以删除这一段定义语句，以此实现完整的 Tree Shaking 效果。

### 收集模块导出

[[万字总结\] 一文吃透 Webpack 核心原理](https://link.juejin.cn/?target=https%3A%2F%2Fmp.weixin.qq.com%2Fs%2FSbJNbSVzSPSKBe2YStn2Zw) 

首先，Webpack 需要弄清楚每个模块分别有什么导出值，这一过程发生在 make 阶段，大体流程：

1. 将模块的所有 ESM 导出语句转换为 Dependency 对象，并记录到 `module` 对象的 `dependencies` 集合，转换规则：

   - 具名导出转换为 `HarmonyExportSpecifierDependency` 对象

   - `default` 导出转换为 `HarmonyExportExpressionDependency` 对象

2. 所有模块都编译完毕后，触发 `compilation.hooks.finishModules` 钩子，开始执行 `FlagDependencyExportsPlugin` 插件回调

3. `FlagDependencyExportsPlugin` 插件从 entry 开始读取 ModuleGraph 中存储的模块信息，遍历所有 `module` 对象

4. 遍历 `module` 对象的 `dependencies` 数组，找到所有 `HarmonyExportXXXDependency` 类型的依赖对象，将其转换为 `ExportInfo` 对象并记录到 ModuleGraph 体系中

经过 `FlagDependencyExportsPlugin` 插件处理后，所有 ESM 风格的 export 语句都会记录在 ModuleGraph 体系内，后续操作就可以从 ModuleGraph 中直接读取出模块的导出值。

### 标记模块导出

模块导出信息收集完毕后，Webpack 需要标记出各个模块的导出列表中，哪些导出值有被其它模块用到，哪些没有，这一过程发生在 Seal 阶段，主流程：

1. 触发 `compilation.hooks.optimizeDependencies` 钩子，开始执行 `FlagDependencyUsagePlugin` 插件逻辑
2. 在 `FlagDependencyUsagePlugin` 插件中，从 entry 开始逐步遍历 ModuleGraph 存储的所有 `module` 对象
3. 遍历 `module` 对象对应的 `exportInfo` 数组
4. 为每一个 `exportInfo` 对象执行 `compilation.getDependencyReferencedExports` 方法，确定其对应的 `dependency` 对象有否被其它模块使用
5. 被任意模块使用到的导出值，调用 `exportInfo.setUsedConditionally` 方法将其标记为已被使用。
6. `exportInfo.setUsedConditionally` 内部修改 `exportInfo._usedInRuntime` 属性，记录该导出被如何使用
7. 结束

上面是极度简化过的版本，中间还存在非常多的分支逻辑与复杂的集合操作，我们抓住重点：标记模块导出这一操作集中在 `FlagDependencyUsagePlugin` 插件中，执行结果最终会记录在模块导出语句对应的 `exportInfo._usedInRuntime` 字典中。

### 生成代码

经过前面的收集与标记步骤后，Webpack 已经在 ModuleGraph 体系中清楚地记录了每个模块都导出了哪些值，每个导出值又没那块模块所使用。接下来，Webpack 会根据导出值的使用情况生成不同的代码。

这一段生成逻辑均由导出语句对应的 `HarmonyExportXXXDependency` 类实现，大体的流程：

1. 打包阶段，调用 `HarmonyExportXXXDependency.Template.apply` 方法生成代码
2. 在 `apply` 方法内，读取 ModuleGraph 中存储的 `exportsInfo` 信息，判断哪些导出值被使用，哪些未被使用
3. 对已经被使用及未被使用的导出值，分别创建对应的 `HarmonyExportInitFragment` 对象，保存到 `initFragments` 数组
4. 遍历 `initFragments` 数组，生成最终结果

基本上，这一步的逻辑就是用前面收集好的 `exportsInfo` 对象未模块的导出值分别生成导出语句。

### 删除 Dead Code

经过前面几步操作之后，模块导出列表中未被使用的值都不会定义在 `__webpack_exports__` 对象中，形成一段不可能被执行的 Dead Code 效果，如上例中的 `foo` 变量：

在此之后，将由 Terser、UglifyJS 等 DCE 工具“摇”掉这部分无效代码，构成完整的 Tree Shaking 操作。

### 小结

综上所述，Webpack 中 Tree Shaking 的实现分为如下步骤：

- 在 `FlagDependencyExportsPlugin` 插件中根据模块的 `dependencies` 列表收集模块导出值，并记录到 ModuleGraph 体系的 `exportsInfo` 中
- 在 `FlagDependencyUsagePlugin` 插件中收集模块的导出值的使用情况，并记录到 `exportInfo._usedInRuntime` 集合中
- 在 `HarmonyExportXXXDependency.Template.apply` 方法中根据导出值的使用情况生成不同的导出语句
- 使用 DCE 工具删除 Dead Code，实现完整的树摇效果

## 最佳实践

虽然 Webpack 自 2.x 开始就原生支持 Tree Shaking 功能，但受限于 JS 的动态特性与模块的复杂性，直至最新的 5.0 版本依然没有解决许多代码副作用带来的问题，使得优化效果并不如 Tree Shaking 原本设想的那么完美，所以需要使用者有意识地优化代码结构，或使用一些补丁技术帮助 Webpack 更精确地检测无效代码，完成 Tree Shaking 操作。

### 避免无意义的赋值

使用 Webpack 时，需要有意识规避一些不必要的赋值操作

```
import foo from './foo'
console.log(foo)
```

示例中，`index.js` 模块引用了 `bar.js` 模块的 `foo` 并赋值给 `f` 变量，但后续并没有继续用到 `foo` 或 `f` 变量，这种场景下 `bar.js` 模块导出的 `foo` 值实际上并没有被使用，理应被删除，但 Webpack 的 Tree Shaking 操作并没有生效，产物中依然保留 `foo` 导出

造成这一结果，浅层原因是 Webpack 的 Tree Shaking 逻辑停留在代码静态分析层面，只是浅显地判断：

- 模块导出变量是否被其它模块引用
- 引用模块的主体代码中有没有出现这个变量

没有进一步，从语义上分析模块导出值是不是真的被有效使用。

更深层次的原因则是 JavaScript 的赋值语句并不**纯**，视具体场景有可能产生意料之外的副作用

### 使用 `#pure` 标注纯函数调用

与赋值语句类似，JavaScript 中的函数调用语句也可能产生副作用，因此默认情况下 Webpack 并不会对函数调用做 Tree Shaking 操作。不过，开发者可以在调用语句前添加 `/*#__PURE__*/` 备注，明确告诉 Webpack 该次函数调用并不会对上下文环境产生副作用,带上 Pure 声明后则被 Tree Shaking 删除.

### 禁止 Babel 转译模块导入导出语句

Babel 是一个非常流行的 JavaScript 代码转换器，它能够将高版本的 JS 代码等价转译为兼容性更佳的低版本代码，使得前端开发者能够使用最新的语言特性开发出兼容旧版本浏览器的代码。

但 Babel 提供的部分功能特性会致使 Tree Shaking 功能失效，例如 Babel 可以将 `import/export` 风格的 ESM 语句等价转译为 CommonJS 风格的模块化语句，但该功能却导致 Webpack 无法对转译后的模块导入导出内容做静态分析

所以，在 Webpack 中使用 `babel-loader` 时，建议将 `babel-preset-env` 的 `moduels` 配置项设置为 `false`，关闭模块导入导出语句的转译。

### 优化导出值的粒度

Tree Shaking 逻辑作用在 ESM 的 `export` 语句上，因此对于下面这种导出场景：

```Javascript
export default {
    bar: 'bar',
    foo: 'foo'
}
复制代码
```

即使实际上只用到 `default` 导出值的其中一个属性，整个 `default` 对象依然会被完整保留。所以实际开发中，应该尽量保持导出值颗粒度和原子性，上例代码的优化版本：

```
const bar = 'bar'
const foo = 'foo'

export {
    bar,
    foo
}
```

### 使用支持 Tree Shaking 的包

如果可以的话，应尽量使用支持 Tree Shaking 的 npm 包，例如：

- 使用 `lodash-es` 替代 `lodash` ，或者使用 `babel-plugin-lodash` 实现类似效果

不过，并不是所有 npm 包都存在 Tree Shaking 的空间，诸如 React、Vue2 一类的框架原本已经对生产版本做了足够极致的优化，此时业务代码需要整个代码包提供的完整功能，基本上不太需要进行 Tree Shaking。

# 其他

[浅谈webpack性能优化](https://segmentfault.com/a/1190000022561279)

[记一次真实的Webpack优化经历](https://juejin.cn/post/6908897055599509512)

[17项关于webpack的性能优化](https://juejin.cn/post/6951297954770583565)

杂项

[Webpack之SplitChunks插件用法详解](https://zhuanlan.zhihu.com/p/152097785)

[webpack 4 Code Splitting 的 splitChunks 配置探索](https://imweb.io/topic/5b66dd601402769b60847149)

[webpack优化之玩转代码分割和公共代码提取](https://champyin.com/2019/11/15/webpack%E4%BC%98%E5%8C%96%E4%B9%8B%E7%8E%A9%E8%BD%AC%E4%BB%A3%E7%A0%81%E5%88%86%E5%89%B2%E5%92%8C%E5%85%AC%E5%85%B1%E4%BB%A3%E7%A0%81%E6%8F%90%E5%8F%96/)