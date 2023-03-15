---
title: 源码_Vue2.0
date: 2023-09-12 07:33:16
categories:
- D_框架和类库
toc: true # 是否启用内容索引
---

# Vue源码分两步走

**Vue 的主体内容**

1、依赖收集 

2、依赖更新 

3、Virtual DOM ，dom 节点 生成虚拟Vnode 节点 

4、Compile，  模板编译 

5、Diff、Patch， 节点比较更新 

6、NextTick ，延迟执行回调 

7、Render， 渲染机制 

8、LifeCircle ，生命周期 

9、Model ，双向绑定 

10、Event ，事件机制

**Vue 组件选项**

1、computed 

2、filter 

3、mixin 

4、directive 

5、slot 

6、props 

7、watch

# 手写Vue2核心原理-珠峰

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

