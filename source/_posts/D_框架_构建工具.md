---
title: 构建工具
date: 2024-05-12 07:33:16
categories:
- D_框架和类库
toc: true # 是否启用内容索引
---

# 前言

## 过去：前端构建工具简史

**为什么需要前端构建工具？**

> •**性能优化：**通过减少HTTP请求数量和优化文件大小（如tree-shaking）来减少加载时间。
>
> •**兼容性：**确保用现代 JavaScript 或其他语言编写的代码与所有浏览器兼容。
>
> •**开发效率：**提供 HMR 和资产管理等功能，简化开发工作流程。

**~2009** **无模块化时期**

> •早期的Web开发比较简单，甚至由后端人员编写（JSP）
>
> •2009 年，Node.js 发布初始版本，CommonJS 模块定义规范被提出
>
> •2010 年，npm包管理发布

**2011~2015** **社区模块化**

> •为了解决浏览器端JS异步模块化问题，出现了AMD/CMD规范
>
> •Browserify：实现浏览器中使用CommonJS模块
>
> •Grunt：将处理过程定义为多个不同的任务，每个任务执行一个函数或插件
>
> •Gulp：引入代码和文件流的概念
>
> •Webpack：模块依赖间关系

**2016~2019** **打包一切**

> •Webpack：一切皆可打包，支持AMD\CommonJS\ESM、css/less/sass/stylus、babel、TypeScript、JSX、Angular、Vue
>
> •Rollup：基于ES Module 主打工具库的打包，率先提出Tree-Shaking的概念

**2020~** **性能优化**

> •Webpack5：多进程编译、缓存机制
>
> •Vite：开发态Bundleless、ESM
>
> •esbuild：go语言实现
>
> •SWC: rust语言实现

## 现在：主流构建工具对比

|              | **Webpack**                           | **Rollup**                       | **Vite**               | **Esbuild**                                                  | **Turbopack**               |
| ------------ | ------------------------------------- | -------------------------------- | ---------------------- | ------------------------------------------------------------ | --------------------------- |
| **使用场景** | 应用构建                              | 库构建                           | 应用构建               | 代码转译                                                     | 应用构建                    |
| **优点**     | •功能全面  •生态丰富  •高度可配置     | •输出产物精简  •优先ESM标准      | •配置简单  •启动服务快 | •速度快                                                      | •速度快  •兼容webpack       |
| **缺点**     | •配置复杂  •输出产物复杂  •构建速度慢 | •CJS兼容依赖插件  •有限的HMR支持 | /                      | •成熟度不够，一直没发1.0版  •code splitting开发中  •HMR不支持 | •主要支持Next.js  •Beta状态 |

•新项目建议优先使用Vite

•已有的Webpack项目，可利用swc替换babel提升构建性能

•新兴构建工具可以尝鲜,如等待rolldown

## 未来：前端构建的未来趋势

**Rust**语言是前端基建的未来。

JavaScript与Rust比较：

| JavaScript                                 | Rust                                   |
| ------------------------------------------ | -------------------------------------- |
| 编译器宽松<br/>入门快，体验好<br/>性能一般 | 编译器严格<br/>学习曲线陡峭<br/>性能高 |
| 偏应用                                     | 偏系统                                 |

# Rollup

- [使用Rollup打包JavaScript](https://juejin.cn/post/6844903570974703629#heading-1)

## 手写Vue2-珠峰-待续

- [手写Vue2-珠峰-video](https://www.bilibili.com/video/BV1aq4y1o7Ny/?spm_id_from=333.999.top_right_bar_window_history.content.click&vd_source=bd4c7d99d71adf64d6e88c65370e0247)

### Rollup搭建环境

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

### 响应式实现

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



# Monorepo vs Multirepo

## 定义 

Monorepo 的全称是 monolithic repository，即单体式仓库，与之对应的是 Multirepo(multiple repository)，这里的“单”和“多”是指每个仓库中所管理的模块数量。

Multirepo 是比较传统的做法，即每一个 package 都单独用一个仓库来进行管理。例如：Rollup。

Monorep 是把所有相关的 package 都放在一个仓库里进行管理，**每个 package 独立发布**。例如：React, Angular, Babel, Jest, Umijs, Vue ...

![image](/img/2024-06-02_09-21-43.png)

## Lerna

Lerna是业界知名度最高的 Monorepo 管理工具，功能完整。

Lerna 是一个管理多个 npm 模块的工具，是 Babel 自己用来维护自己的 Monorepo 并开源出的一个项目。优化维护多包的工作流，解决多个包互相依赖，且发布需要手动维护多个包的问题。

Lerna 现在已经被很多著名的项目组织使用。基于 Lerna 管理 packages 的 Monorepo 项目，如：Babel, React, Vue, Angular, Ember, Meteor, Jest 。