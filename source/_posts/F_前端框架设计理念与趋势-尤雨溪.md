---
title: F_前端框架设计理念与趋势-尤雨溪
date: 2022-06-26 07:33:16
categories:
- F_新技术
toc: true # 是否启用内容索引
---

背景：AI大前端技术峰会-尤雨溪

# 开发范式

**开发范式要解决的问题**

- 高度复杂的场景

- 大团队规模化开发

- 长期可维护性

**要考虑的问题**

- API对类型系统的亲和性，如typescript,flow

- 逻辑拆分，整理和复用的能力,如vue2的超巨型组件，vue3的优化，屎山代码

- 可重构性

- 语法简洁度/可读性/上手成本/开发体验

**近年来的代表方案**

- React Hooks

- Vue Composition API

- Svelte 3

- Reactive Conrtrollers

**React Hooks**

```
// 状态
const [count,setCount] = useState(0)
// 副作用
userEffect(()=>{
console.log(count)
},[count])
// 状态更新
setCount(count + 1)
```

> - 2018年发布
> - 强大的逻辑组合复用能力
> - 相对Class更简洁的用法
> - 在React生态中彻底取代Class
> - 启发一系列新范式的实现，Composition API，Svelte,SolidJS

*React Hooks的问题*

- 执行原理与原生的JS心智模型冲突，即每次声明的hook都会重复加载执行
  - 大量API如useEffect需要手动声明依赖，否则会产生过期闭包问题
- 由于ConCurrent Mode并行模式 导致useEffect副作用处理存在大量负担，多任务的并行处理的野心
- 受限于实现原理，依赖如userCallBack的手动性能优化
- 和React的运行机制强耦合

*React团队的改善*

- userEvent RFC改善 userCallBack的手动优化的问题，用户不需要手动缓存事件函数
- 新版文档对useEffect更详细的指导
- React Forget通过编译时优化避免手动声明依赖-开发中

**Vue Composition API**

```
// 状态
const count = ref(0)
// 副作用
watchEffect(()=>console.log(count.value))
// 状态更新
count.value++
```

- 基于Vue内部的响应式系统暴露更多控制权
- 受React Hooks启发，提供同等级的复用，但避免了Hooks的大部分问题
- 比Vue原本的Options API更类型友好
- 通过setup语法糖改善开发体验

*Composition API优势*

- 代表了“依赖追踪响应式系统”
- 和组件机制解耦，可在非组件场景下使用
- 可追溯到Knockout.js
- 近年有如Solid.js和Ember Starbeam这样的新实验

**Svelte 3**

```
// 状态
let count = 0
// 副作用
$:console.log(count)
// 状态更新
count++
```

- 代表了“编译时响应式系统”
- 通过变量的引用和赋值触发追踪和更新，用法简洁
- 部分设计违背原生JS语义，如美元符，标记追踪的对象
- 和组件上下文强耦合，只能在组件中使用
- 组件外需要使用额外机制，影响重构和复用

*Vue Reactivity transform*

```
// 状态
const count = $ref(0)//使用$的宏函数标记，转换为响应式代码
// 副作用
watchEffect(()=>console.log(count.value))
// 状态更新
count.value++
```

- 在“依赖追踪响应式系统”基础上添加“编译时响应式系统”
- 类似Svelte的简洁语法
- 遵循JS语义，和类型系统无缝连接
- 可以同时在组件和普通TS/JS中使用

**Reactive Conrtrollers**

- Google的Lit项目提出的逻辑复用模式
- 基于Class和Interface的设计，理论上完全和宿主组件实现解耦
- Web Components社区试图推广的标准
- 需要手动触发更新，语法相对繁琐

# 运行机制

**纯Virtual Dom的性能瓶颈**

- 组件更新粒度的问题，如父组件更新导致一系列所有子组件更新

- diff算法效率问题，如由于js引擎太强大了，容易被忽略

- 内存GC压力，如频繁更新导致旧vdom和新的vdom存储内存的压力

**编译时优化**

- Vue3:配合编译时优化的Virtual Dom，如二进制的flag埋入动态信息，进行fast parse
- Svelte:模板编译为命令式Dom节点生成+更新代码
- Solid:模板编译为静态Dom生成+响应式绑定代码

*Vue Vapor Mode*

- 参考Solid的编译策略，目前还是实验原型阶段
- 仅影响生成代码和底层运行时，不影响API
- 显著优化运行时大小和内存占用
- 可在单个组件内使用(保留Virtual Dom兼容)，或全应用启动

# 工具链

**前端性能杀手**

- webpack

- TypeScript

后续引发了新的基于原生JS编译的工具，如esbuild,SWC。

> esbuild使用go语言编写
>
> Vite是一种混合编译模式，大部分动态逻辑使用JS处理，但依赖预处理和JS转义层面使用Esbuild处理。将JS的灵活性和Esbuild性能结合。
>
> 未来基于JS的编译器被其他原生语言替代，这基本不可能。

**工具链的抽象层次**

- browserify/webpack/rolllup
  - 专注于打包，抽象层次低
- Parcel/Vue-CLI/CRA
  - 专注于应用，抽象层次高
- Vite
  - CLI专注于应用，抽象层次高，方便开箱即用
  - API专注于上层框架，抽象层次中，方便任意定制化

# 上层框架

**下一代上层框架的通用工具链基础层是Vite**

- Nuxt3
- Sveltekit
- Shopify Hydrogen
- Astro
- Qwik
- FastifyDx
- Solid Start
- Laravel新默认前端方案