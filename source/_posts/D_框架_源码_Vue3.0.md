---
title: 源码_Vue3.0
date: 2023-09-12 07:33:16
categories:
- D_框架和类库
toc: true # 是否启用内容索引
---

# 尤大手写mini-vue

**一、整体流程**

- 数据响应式模块：初始化为响应式对象
- 编译模块：编译为渲染函数，编译过程一般在两个时刻执行,即浏览器运行时(runtime)和Vue打包编译时(compile time)
- 渲染模块：
  - RenderPhase ： 渲染模块使用渲染函数根据初始化数据生成虚拟Dom
  - MountPhase  ： 利用虚拟Dom创建视图页面Html
  - PatchPhase：数据模型一旦变化渲染函数将再次被调用生成新的虚拟Dom，然后做Dom Diff更新视图Html

**编译模块**

1. Parase解析：模板字符串 -> AST(Abstract Syntax Treee)抽象语法树，本质是一连串的正则匹配
2. Transform转换：譬如 v-bind v-if v-for的转换
3. Generate生成渲染器： AST -> 渲染函数

# 