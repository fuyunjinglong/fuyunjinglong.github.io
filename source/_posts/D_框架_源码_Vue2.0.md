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

安装依赖报错1

```
报错phantomjs-prebuilt@2.1.14 install: `node install.js`
解决方案：npm install phantomjs-prebuilt@2.1.14 --ignore-scripts
```

安装依赖报错2

```
报错(plugin Rollup Core) Error: Could not load
解决方案：
手动下载依赖包https://github.com/ideayuye/rollup-plugin-alias，并覆盖掉本地文件夹 \node_modules\rollup-plugin-alias。进入rollup-plugin-alias文件夹，依次执行npm i
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
├── packages                    一些额外的包，比如：负责服务端渲染的包 vue-server-renderer、配合 vue-loader 使用的的 vue-template-compiler，还有 weex 相关的
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
    |— web web端独有文件
                |— compiler 编译阶段需要处理的指令和模块
                |— runtime 运行阶段需要处理的组件、指令和模块
                |— server 服务端渲染相关
                |— util 工具库
│   │   └── weex
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



# 手写Vue2-珠峰-待续

[video](https://www.bilibili.com/video/BV1aq4y1o7Ny/?spm_id_from=333.999.top_right_bar_window_history.content.click&vd_source=bd4c7d99d71adf64d6e88c65370e0247)

## Rollup搭建环境

**Rollup是什么**

Rollup是一个JS模块打包器，可以将小块代码编译成大块复杂代码，rollup.js更专注JS类库打包(开发应用使用webpack，开发库使用Rollup)

**环境搭建**

1.初始化package.json

```
npm init -y
```

2.安装rollup环境

> - @babel/core是es6转es5低级语法的核心包
> - @babel/preset-env是babel插件的集合
> - rollup-plugin-babel是rollup和babel的插件，是桥梁

```
npm i rollup @babel/core @babel/preset-env rollup-plugin-babel -D
```

**目录配置**

```
// rollup.config.js
import babel from 'rollup-plugin-babel'
export default{
    input:'./src/index.js',// 打包项目的入口
    output:{
        file:'dist/vue.js',// 打包输出的结果
        format:'umd', // 采用的模块化规范
        name:'Vue', // 指定的打包后全局变量
        sourcemap:true
    },
    plugins:[
        babel({// 自动读取babel配置文件
            exclude:"./node_module/**" // 排除babel解析目录，**是glob写法
        })
    ]
}

//.babelrc配置文件
{
    "presets": [
        // presets叫预设，也是插件的集合，主要把高级语法转为低级语法，如e6->es5
        "@babel/preset-env"
    ]
}

// index.js入口文件
export default{
    a:1,
    b:2
}

// package.json
{
  "name": "vue2-rollup",
  "version": "1.0.0",
  "description": "",
  "main": "index.js",
  "scripts": {
    "dev": "rollup -c -w"// 执行打包，并读取默认config配置，watch动态监听文件变化
  },
  "keywords": [],
  "author": "",
  "license": "ISC",
  "devDependencies": {
    "@babel/core": "^7.21.3",
    "@babel/preset-env": "^7.20.2",
    "rollup": "^2.79.1",
    "rollup-plugin-babel": "^4.4.0"
  }
}
// 打包后的结果
支持commonjs,amd,有全局Vue参数
```

## 响应式实现

```
// \src\index.js
/**
 * Class方法扩展与构造函数方法扩展比较：
 * 1.Class用于扩展方法耦合的场景，但扩展方法都在class内部
 * 2.构造函数用于外部方法的任意扩展，使用原型属性继承扩展方法，可以无限扩展，不受约束
 */

import initMixin from './init'
function Vue(options){
this._init(options)
}
initMixin(Vue) // 扩展方法通过传入Vue构造函数，通过原形添加方法，并分文件管理
export default Vue

// \src\init.js
import {initState} from './state'
export default function initMixin(Vue){
// 扩展Vue的方法
Vue.prototype._init=function(options){
    // 绑定所有选项参数到实例上，后续所有的扩展方法都可以拿到这些选项
    const vm = this
    // $表示Vue自己的属性参数
    vm.$options= options
    // 初始化数据，如prop,data,methods,computed,watch
    initState(vm)
}
}

//\src\state.js
import { observe } from "./observe/index.js";
export  function initState(vm){
    const options =vm.$options

    if(options.data){
        initData(vm)
    }

}

function initData(vm){
let data = vm.$options.data;
// 判断是否为函数，如果是则执行函数获取返回值。
// 代理后，添加到vm实例上_data
data=vm._data = typeof data ==='function'?data.call(vm):data;
// 观察数据,实现响应式
observe(data)
console.log(data);
}

// \src\observe\index.js
// 高类聚，低耦合
class Observer{
    constructor(data){
        this.walk(data);
    }
    walk(data){
        // 遍历一遍数据，添加响应式
        Object.keys(data).forEach(key=>{
            defineReactive(data,key,data[key])
        })
    }
}

function defineReactive(data,key,value){
    // 属性全部被重写
    // 递归代理属性
    observe(value);
    Object.defineProperty(data,key,{
        get(){
            return value
        },
        set(newV){
            observe(value);
            value = newV===value?value:newV;
        }
    })
}

export function observe(data){
    // 数据响应式
    if(typeof data !== 'object'||data===null){
        return;// 如果不是对象，就不处理
    }
    /**
 * Class方法扩展与构造函数方法扩展比较：
 * 1.Class用于扩展方法耦合的场景，但扩展方法都在class内部
 * 2.构造函数用于外部方法的任意扩展，使用原型属性继承扩展方法，可以无限扩展，不受约束
 */
// 这里采用Class类
    return new Observer(data)
}
```