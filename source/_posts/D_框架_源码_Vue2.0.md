---
title: 源码_Vue2.0
date: 2023-09-12 07:33:16
categories:
- D_框架和类库
toc: true # 是否启用内容索引
---

# 前言

**关于源码**

> - 为了面试
> - 为了在简历上写自己会源码
> - 了解底层原理 学习高手思路
> - 通过源码来学习一些小技巧(*骚操作*)
> - 对框架如何实现的各种功能感到好奇
> - 内卷严重 不看不行 逆水行舟 不进则退
> - 自己也想造轮子 先看看别人都是怎么做的
> - 各种公众号和卖课的都在贩卖焦虑 被洗脑洗的
>
> 

**怎样学习源码才是最科学的方式呢？**

> 我们来看一个例子：有一些听起来非常高大上的高科技产品，如`电磁轨道炮`。那么当我们拆解一个电磁轨道炮的时候，大概率你是看不懂它的。
>
> 但用了一些磁铁、若干钢珠、以及几个我们日常生活中能够搞到的材料来制作了一个`简易版的电磁轨道炮`。这样我们一下子就能够搞懂`电磁轨道炮的真正原理`。
>
> 虽然这样的轨道炮并不能真正的用于实战，但只要我们明白了最基础的那部分，我们就可以在此基础上一步步进行扩展，慢慢弄懂整个能够用于实战的复杂轨道炮。

# Vue源码调试

**1.下载源码**

[vue-v2.6.14版本](https://github.com/vuejs/vue/tree/v2.6.14)下载

**2.安装依赖**

```
npm i
```

安装依赖报错-phantomjs-prebuilt@2.1.14 install: `node install.js`

```
解决方案：npm install phantomjs-prebuilt@2.1.14 --ignore-scripts
```

安装依赖报错-(plugin Rollup Core) Error: Could not load

```
手动下载依赖包https://github.com/ideayuye/rollup-plugin-alias，并覆盖掉本地文件夹 \node_modules\rollup-plugin-alias。进入rollup-plugin-alias文件夹，依次执行npm i
```

安装依赖报错-idealTree:vue: sill idealTree buildDeps

```
清除npm缓存npm cache clean --force
设置新的淘宝镜像源npm config set registry https://registry.npmmirror.com
```

**3.开启打包源文件**

```
// package.json
"dev": "rollup -w -c scripts/config.js --environment TARGET:web-full-dev --sourcemap",
```

**4.开始调试源码**

> 在源码目录中添加断点调试即可，比如\vue-2.6.14\src\core\instance\init.js

```
<!DOCTYPE html>
<html>
  <head>
    <style>
      #demo {
        font-family: "Helvetica", Arial, sans-serif;
        text-align: center;
      }
    </style>
    <script src="./dist/vue.js"></script>
  </head>
  <body>
    <div id="demo">
      <button @click="num++">Object类型自增加：{{num}}</button>
      <button @click="add">Array类型自增加：{{arr}}</button>
    </div>
    <script>
      new Vue({
        el: "#demo",
        data: {
          num: 0,
          arr: [1, 2, 3],
        },
        methods: {
          add() {
            this.arr.push(this.arr[this.arr.length - 1] + 1);
            // this.$set(this.arr, 0, this.arr[0] + 1);
          },
        },
      });
    </script>
  </body>
</html>
```

# Vue源码目录

```
├── benchmarks                  性能、基准测试
├── dist                        构建打包的输出目录
├── examples                    案例目录
├── flow                        因为Vue使用了Flow来进行静态类型检查，这里定义了声明了一些静态类型
├── packages                    一些额外的包，比如：负责服务端渲染的包 vue-server-renderer、配合 vue-loader 使用的 									vue-template-compiler，还有 weex 相关的
    ├── vue-server-renderer
    ├── vue-template-compiler
    ├── weex-template-compiler
    └── weex-vue-framework
├── scripts                     所有的配置文件的存放位置，比如 rollup 的配置文件
├── src                         vue 源码目录
│   ├── compiler                编译器
      |—codegen     根据ast生成render函数
         |—directives    通用生成render函数之前需要处理的指令
         |—parser     模板解析
│   ├── core                    运行时的核心包
│   │   ├── components          全局组件，比如 keep-alive
│   │   ├── config.js           一些默认配置项
│   │   ├── global-api          全局方法，也就是添加在Vue对象上的方法，比如Vue.use,Vue.extend,,Vue.mixin等
│   │   ├── instance            实例相关内容，包括实例方法，生命周期，事件等
│   │   ├── observer            响应式原理
│   │   ├── util                工具方法
│   │   └── vdom                虚拟 DOM 相关，比如熟悉的 patch 算法就在这儿
│   ├── platforms               平台相关的编译器代码
│   │   ├── web					
│   │   ├── weex 				类似react native跨端平台
    |— web web端独有文件
                |— compiler 编译阶段需要处理的指令和模块
                |— runtime 运行阶段需要处理的组件、指令和模块
                |— server 服务端渲染相关
                |— util 工具库
│   ├── server                  服务端渲染相关
├── test                        测试目录
├── types                       TS 类型声明
```

# Vue从实例化到渲染的完整流程

参考：[vue源码分析](https://segmentfault.com/a/1190000023649060)

> new Vue->init->mount->compile->render->vnode->patch->dom

**1. 定义Vue**构造函数

```
initMixin(Vue);  // 定义 _init
stateMixin(Vue);  // 定义 $set $get $delete $watch 等
eventsMixin(Vue);   // 定义事件  $on  $once $off $emit
lifecycleMixin(Vue); // 定义 _update  $forceUpdate  $destroy
renderMixin(Vue); // 定义 _render 返回虚拟dom  
```

**2. initMixin**

实例化Vue时，执行 _init, _init 定义在 initMixin 中

```
  Vue.prototype._init = function (options) {
    // 合并 options
    if (options && options._isComponent) {
      initInternalComponent(vm, options); // 组件合并
    } else {
      // 非组件合并
      vm.$options = mergeOptions(
        resolveConstructorOptions(vm.constructor), 
        options || {},
        vm
      );
    }
    initLifecycle(vm); // 定义 vm.$parent vm.$root vm.$children  vm.$refs 等
    initEvents(vm);   // 定义 vm._events  vm._hasHookEvent 等
    initRender(vm); // 定义 $createElement $c
    callHook(vm, 'beforeCreate'); // 挂载 beforeCreate 钩子函数
    initInjections(vm); // resolve injections before data/props
    initState(vm);  // 初始化 props methods data computed watch 等方法
    initProvide(vm); // resolve provide after data/props
    callHook(vm, 'created'); // 挂载 created 钩子函数
    if (vm.$options.el) {
      vm.$mount(vm.$options.el); // 实例挂载渲染dom
    }
  };
```

**3. $mount**

vue最终都是通过render函数将dom编译为虚拟dom

```
// 构建render函数
if (!options.render) {
  // 如果没有render属性，那么将template模版编译转为render
}
// 最后调用 mount
return mount.call(this, el, hydrating)
// mount 调用 mountComponent
return mountComponent(this, el, hydrating)
```

**4. mountComponent**

通过 new Watcher 调用执行 updateComponent, vm._render获取虚拟dom, vm._update将虚拟dom转为真实的dom并挂载到页面。

```
// hydrating 代表服务端渲染 hydrating => false
updateComponent = function () {
  vm._update(vm._render(), hydrating); // 关键点
};
```

**5. _render**

_render执行render函数 返回vnode。

```
Vue.prototype._render = function () {
    // 此处的 vm._renderProxy 等价于 vm
    vnode = render.call(vm._renderProxy, vm.$createElement);
}
```

$createElement 主要是参数重载，整合为统一格式后调用 _createElement函数。

**6. _update**

_update 主要实现 vnode 转化为实际的dom， 注入到页面的同时并销毁页面模版。

# Vue源码深度解析

**参考**

> - [Vue.js源码全方位深入解析-黄轶-video](https://www.1024zyz.com/3206.html)
> - [Vue.js源码全方位深入解析-黄轶](https://ustbhuangyi.github.io/vue-analysis/v2/prepare/)
> - [李永宁Vue源码解读-video](https://www.bilibili.com/video/BV1Jb4y1D7eA/?spm_id_from=333.999.0.0&vd_source=bd4c7d99d71adf64d6e88c65370e0247)
> - [珠峰公开课-vue2.0源码实现-video](https://www.bilibili.com/video/BV1aq4y1o7Ny/?spm_id_from=333.999.0.0&vd_source=bd4c7d99d71adf64d6e88c65370e0247)
> - [vue核心四大模块](https://winteroo.github.io/ylblog/docs/vue/01introduce.html#%E5%89%8D%E8%A8%80)
> - [Vue源码系列-Vue中文社区](https://vue-js.com/learn-vue/)
> - [李永宁Vue源码解读](https://juejin.cn/column/6960553066101735461)
> - [汪道南源码解析](https://wangtunan.github.io/blog/vueAnalysis/introduction/)
> - [推荐 7 个 Vue2、Vue3 源码解密分析的开源项目](https://github.com/FrontEndGitHub/FrontEndGitHub/issues/35)

**Vue核心四大模块**

- 生命周期过程
- 变化监测原理
- 模板编译原理
- 虚拟DOM原理

## 生命周期过程-待续

## 变化监测原理-待续

## 模板编译原理-待续

## 虚拟DOM原理-待续

# Vue.js源码全方位深入解析-黄轶

- [2.x版本笔记](https://ustbhuangyi.github.io/vue-analysis/v2/prepare/)

## 认识Flow

[Flow](https://flow.org/en/docs/getting-started/) 是 facebook 出品的 JavaScript 静态类型检查工具。Vue.js 的源码利用了 Flow 做了静态类型检查。

**为什么用 Flow**

> JavaScript 是动态类型语言，但是它过于灵活的副作用是很容易写出非常隐蔽的隐患代码，在编译期不会报错，但在运行阶段就可能出现各种奇怪的bug。
>
> 类型检查是当前动态类型语言的发展趋势，所谓类型检查，就是在编译期尽早发现（由类型错误引起的）bug，又不影响代码运行（不需要运行时动态检查类型），使编写 JavaScript 具有和编写 Java 等强类型语言相近的体验。
>
> 项目越复杂就越需要通过工具的手段来保证项目的维护性和增强代码的可读性。
>
>  Vue.js 在做 2.0 重构的时候，引入了 Flow 做静态类型检查,之所以选择 Flow，主要是因为 Babel 和 ESLint 都有对应的 Flow 插件以支持语法,非常小成本的改动就可以拥有静态类型检查的能力。

**Flow 的工作方式**

> - 类型推断：通过变量的使用上下文来推断出变量类型，然后根据这些推断来检查类型。
> - 类型注释：事先注释好我们期待的类型，Flow 会基于这些注释来判断。

```
类型推断
/*@flow*/
function split(str) {
  return str.split(' ')
}
split(11)

类型注释
/*@flow*/
function add(x: number, y: number): number {
  return x + y
}
add('Hello', 11)
```

**类型注释**

更多请移步 Flow 的[官方文档](https://flow.org/en/docs/types/)。

数组

```
/*@flow*/
var arr: Array<number> = [1, 2, 3]
arr.push('Hello')
```

类和对象

```
/*@flow*/
class Bar {
  x: string;           // x 是字符串
  y: string | number | void;  // y 可以是字符串或者数字，void表示为空即可不传
  z: boolean;
  constructor(x: string, y: string | number| void) {
    this.x = x
    this.y = y
    this.z = false
  }
}

var bar: Bar = new Bar('hello', 4)
var obj: { a: string, b: number, c: Array<string>, d: Bar } = {
  a: 'hello',
  b: 11,
  c: ['hello', 'world'],
  d: new Bar('hello', 3)
}
```

Null

若想任意类型 `T` 可以为 `null` 或者 `undefined`，只需类似如下写成 `?T` 的格式即可。

```
/*@flow*/
var foo: ?string = null // 此时，foo 可以为字符串，也可以为 null。
```

**Flow 在 Vue.js 源码中的应用**

对于引用的第三方库，或者自定义一些类型，但 Flow 并不认识，因此检查的时候会报错。为了解决这类问题，Flow 提出了一个 `libdef` 的概念，可以用来识别这些第三方库或者是自定义类型。

在 Vue.js 的主目录下有 `.flowconfig` 文件， `[libs]` 部分用来描述包含指定库定义的目录，这里 `[libs]` 配置的是 `flow`，表示指定的库定义都在 `flow` 文件夹内。

```
flow
├── compiler.js        # 编译相关
├── component.js       # 组件数据结构
├── global-api.js      # Global API 结构
├── modules.js         # 第三方库定义
├── options.js         # 选项相关
├── ssr.js             # 服务端渲染相关
├── vnode.js           # 虚拟 node 相关
```

## Vue.js 源码构建

Vue.js 源码是基于 [Rollup](https://github.com/rollup/rollup) 构建的，它的构建相关配置都在 scripts 目录下。

**构建脚本**

总共有 3 条命令，Vue.js 源码构建的脚本如下：

```
{
  "script": {
    "build": "node scripts/build.js",
    "build:ssr": "npm run build -- web-runtime-cjs,web-server-renderer",
    "build:weex": "npm run build -- weex"
  }
}
```

**构建过程**

> scripts/build.js

```
// 1.读取配置文件
let builds = require('./config').getAllBuilds()

// 2.根据package.json中脚本的配置参数，得到需要打包的平台，然后过滤配置
if (process.argv[2]) {
  const filters = process.argv[2].split(',')
  builds = builds.filter(b => {
    return filters.some(f => b.output.file.indexOf(f) > -1 || b._name.indexOf(f) > -1)
  })
} else {
  // filter out weex builds by default
  builds = builds.filter(b => {
    return b.output.file.indexOf('weex') === -1
  })
}
// 3.开始构建
build(builds)

function build (builds) {
  let built = 0
  const total = builds.length
  const next = () => {
    // 根据配置逐个构建对应平台的js文件
    buildEntry(builds[built]).then(() => {
      built++
      if (built < total) {
        next()
      }
    }).catch(logError)
  }

  next()
}

function buildEntry (config) {
  const output = config.output
  const { file, banner } = output
  const isProd = /(min|prod)\.js$/.test(file)
  return rollup.rollup(config)// 生成bundle
    .then(bundle => bundle.generate(output))// 生成输出文件
    .then(({ output: [{ code }] }) => {
      if (isProd) {// 如果是生产环境，是否需要压缩代码
        const minified = (banner ? banner + '\n' : '') + terser.minify(code, {
          toplevel: true,
          output: {
            ascii_only: true
          },
          compress: {
            pure_funcs: ['makeMap']
          }
        }).code
        // 最后生成打包文件
        return write(file, minified, true)
      } else {
        return write(file, code)
      }
    })
}
```

> scripts/config.js

```
if (process.env.TARGET) {
  module.exports = genConfig(process.env.TARGET)
} else {
  exports.getBuild = genConfig
  // 根据package.json的脚本配置，生成rollup所需要的配置文件格式数组，genConfig是最终格式
  exports.getAllBuilds = () => Object.keys(builds).map(genConfig)
}
// 所有平台需要配的配置
const builds = {
  // Runtime only (CommonJS). Used by bundlers e.g. Webpack & Browserify
  'web-runtime-cjs-dev': {
    entry: resolve('web/entry-runtime.js'),
    dest: resolve('dist/vue.runtime.common.dev.js'),
    format: 'cjs',
    env: 'development',
    banner
  },
  'web-runtime-cjs-prod': {
    entry: resolve('web/entry-runtime.js'),
    dest: resolve('dist/vue.runtime.common.prod.js'),
    format: 'cjs',
    env: 'production',
    banner
  },
  ....
  }
  
// 转换为rollup最终需要的配置数据格式，并添加其他配置
function genConfig (name) {
  const opts = builds[name]
  const config = {
    input: opts.entry,
    external: opts.external,
    plugins: [
      flow(),
      alias(Object.assign({}, aliases, opts.alias))
    ].concat(opts.plugins || []),
    output: {
      file: opts.dest,
      format: opts.format,
      banner: opts.banner,
      name: opts.moduleName || 'Vue'
    },
    onwarn: (msg, warn) => {
      if (!/Circular/.test(msg)) {
        warn(msg)
      }
    }
  }
  ...
  return config
}
```

## Runtime Only VS Runtime + Compiler

通常我们利用 vue-cli 去初始化我们的 Vue.js 项目的时候会询问我们用 Runtime Only 版本的还是 Runtime + Compiler 版本。下面我们来对比这两个版本。

- Runtime Only

我们在使用 Runtime Only 版本的 Vue.js 的时候，通常需要借助如 webpack 的 vue-loader 工具把 .vue 文件编译成 JavaScript，因为是在编译阶段做的，所以它只包含运行时的 Vue.js 代码，因此代码体积也会更轻量。

- Runtime + Compiler

我们如果没有对代码做预编译，但又使用了 Vue 的 template 属性并传入一个字符串，则需要在客户端编译模板