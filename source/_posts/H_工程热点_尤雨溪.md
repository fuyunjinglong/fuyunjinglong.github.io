---
title: 尤雨溪
date: 2022-06-26 07:33:16
categories:
- H_工程热点
toc: true # 是否启用内容索引
---

背景：AI大前端技术峰会-尤雨溪

# 前端框架设计理念与趋势

## 开发范式

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

**基于依赖追踪的范式共同点**

如：SolidJS,Vue Composition API,Enber的Starbeam

- 一次调用，符合JS调用直觉
- 自动追踪依赖，无需手动声明
- 引用稳定，无需useCallback

**基于编译的响应式系统**

如：Svelte,Vue Reactivity Transform,solid-labels

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
- 不能条件式调用
- Stale Closure（过期闭包）的心智负担
- 必须手动声明useEffecty依赖
- 如何正确使用useEffect是个复杂问题
- 需要useMemo/useCallback等手动优化

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

*Vue Reactivity transform*实验性阶段

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

**Reactive Conrtrollers**

- Google的Lit项目提出的逻辑复用模式
- 基于Class和Interface的设计，理论上完全和宿主组件实现解耦
- Web Components社区试图推广的标准
- 需要手动触发更新，语法相对繁琐



## 工具链

**前端性能杀手**

- webpack

- TypeScript

**原生语言在前端工具链中的使用**

- esbuild（Go）
- SWC（Rust）
- Bun（Zig）
- Parcel2（JS/Rust hybrid）
- Vite（JS/Go hybrid via esbuild）
- napi-rs（Rust）

**原生语言开发是否为常态？**

- 原生语言更适用于相对稳定情况，否则很难榨取最优性能
- 原生语言会影响可扩展性，增加社区参与门槛，影响社区发展
- JS/原生混合工具链将成为常态

**工具链的抽象层次**

- browserify/webpack/rolllup
  - 专注于打包，抽象层次低
- Parcel/Vue-CLI/CRA
  - 专注于应用，抽象层次高
- Vite
  - CLI专注于应用，抽象层次高，方便开箱即用
  - API专注于上层框架，抽象层次中，方便任意定制化

## 运行机制

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

## 上层框架

**下一代上层框架的通用工具链基础层是Vite**

- Nuxt3
- Sveltekit
- Shopify Hydrogen
- Astro
- Qwik
- FastifyDx
- Solid Start
- Laravel新默认前端方案

## JS全栈

**数据的前后打通**

- Next:getStaticProps/getServerSideProps
- Nust:API routes+,useFetch+,Top level await
- Remix:loader/action,+Enhanced,HTML Form

**类型的前后端打通**

- 通过显式引入共享类型
- 自动基于DB schema生成类型
- Nuxt 3:自动基于文件布局生成API/路由类型

**JS全栈的代价**

- 虽然数据已经渲染出html,但还需要额外发送一份数据用于Hydrate
- 即使在客户端没有交互的组件依然会被打包发送至客户端
- Hydrate影响页面交互指标TTI

# 掘金夜谈-第一期尤雨溪对话Vue

视频地址：[尤大对话](https://live.juejin.cn/4354/vue3)

**尤对吐槽**

尤对吐槽 [React](https://so.csdn.net/so/search?q=React&spm=1001.2101.3001.7020) hooks 的缺点：心智负担，闭包陷阱，useEffect 的依赖项等等.

其实不然。

> 首先闭包陷阱的由来在于大家对于闭包的理解不够深刻，因此在使用部分 hooks 的时候，对于某些闭包的产生无法感知到。实际上闭包陷阱的逻辑如果成立的话，并不仅仅存在于 React hooks 中，而是存在于 JavaScript 的所有可能出现的场景。特别是匿名函数这种弱感知的场景。
>
> useEffect 的依赖问题其实在我看来不仅不是 hooks 的缺点，反而是 hooks 的优点。useEffect 的依赖项能够帮助我们监听单一数据以驱动多个数据，于是我们就可以借助这个特性完成单数据驱动多数据，再由多数据驱动 UI 的开关思维。能够极大的简化我们的开发，提升开发效率。

**Vue3尖锐问题**

1.vue3 与 ts 的结合

 vue3 与 ts 的结合不够完善的事情。主要是 props 的定义方式与泛型组件的问题。

> 尤大解释：Props 值定义确实是一个兼容性导致的包袱。但是在 <script setup> 下已经支持直接用 defineProps<{...}> 类型声明 props 了（自动编译为对应的值声明）。

2.Vue3不支持跨端

 Vue 团队没有精力去做这些事情，只有公司级别的体量才有能力去做，因为跨端的支持确实很复杂。

**Vue4新变化**

vue 会借鉴 solid 的编译模式。solid 是一个摈弃了虚拟 DOM，走编译型路线的框架，别的不说，他的性能是能吊打目前的 Vue 与 React。

**郭辉：低代码，无代码**

财务公司(金蝶)在低代码做得非常成熟，但是呢，大多数团队都做得不是很好。主要的原因在于许多场景业务逻辑比较复杂，不通用，无法抽象。也就导致了低代码的实现成为了一种愿景。

许多团队在攻克组件渲染这一层的东西，但是实际上这些都是比较简单的，不是项目的核心痛点。也就是说，郭老师觉得他们的方向走错了。

低代码仅仅只适合逻辑抽象比较简单，比较通用的场景。例如发票。业务逻辑抽象比较容易。toB 的业务逻辑是无法解决的。

# 