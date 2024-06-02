---
title: 构建工具
date: 2024-05-12 07:33:16
categories:
- D_框架和类库
toc: true # 是否启用内容索引
---

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