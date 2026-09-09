---
title: 状态管理_pinia
date: 2023-01-01 08:33:16
categories:
- B_中级
toc: true # 是否启用内容索引
---

# 初级

## 什么是 Pinia？

**一、定义**

> Pinia 是 Vue 的专属状态管理库，是 Vuex 状态管理工具的替代品。 [10](https://zhuanlan.zhihu.com/p/2003133452564833002) Pinia 是 Vue3 官方推荐的状态管理库（由 Vue 核心团队开发），可兼容 Vue2，核心采用"模块化存储"（无单一状态树限制），API 简洁、TS 友好，侧重"轻量化、易用性"，是 Vuex 的替代方案。

**为什么推荐：**

> -  天然支持 TypeScript，Pinia 使用组合式 API 编写逻辑，；
> - 去除了 mutation，只需使用 actions 处理同步或异步操作；
> - 开发体验极佳，提供 storeToRefs 解构响应式 state；devtools 与持久化插件原生支持。

## Pinia 和 Vuex 的区别？

**一、定义**

| 对比维度       | Vuex                               | Pinia                        |
| -------------- | ---------------------------------- | ---------------------------- |
| **状态结构**   | 单一状态树                         | 多 Store 模块化，各自独立    |
| **Mutation**   | 必须通过 mutation 修改状态（同步） | 无 mutation，action 直接修改 |
| **TypeScript** | 类型支持弱                         | 完善的类型推断，TS 友好      |
| **API 复杂度** | state / getter / mutation / action | 仅 state / getter / action   |
| **代码体积**   | 较重                               | 更轻量                       |

> - Vuex 的核心概念包括 State、Getter、Mutation 和 Action。其中 Mutation 是唯一更改 State 的方式，必须同步执行；Action 可以包含任意异步操作，提交 Mutations 来更改 State。
> - Pinia 的一大革新是 Actions 融合了 Vuex 中 Mutation 和 Action 的概念，无论是同步还是异步，都可以在 Action 中直接处理。 在 Pinia 中，我们可以在 action 中直接改变状态，使得代码更为简洁；此外 Pinia 将状态划分到各个独立的 store 中，这使得状态管理更为清晰和灵活。
> - 新项目优先选 Pinia，上手简单，易于精通；掌握两者的核心差异，无论选型还是开发，都能游刃有余。

**二、进阶**

**1.Pinia 为什么去掉了 mutations？**

> Pinia 认为 `mutations` 只是 `actions` 的一个 **额外步骤**，没必要单独存在。因此 **直接使用 actions 处理状态修改**，简化代码。

## Pinia 的三大核心概念

一、定义

> - 通过创建数据仓库，Vuex 中的 state 在 Pinia 中可以引用 `ref` 和 `reactive` 创建响应式数据；
> - Vuex 中的 getters 在 Pinia 中可以引用 `computed` 创建计算属性；
> - Vuex 中的 mutations 和 actions 在 Pinia 中就是普通函数，同步异步都可以。

用代码对应解释：

```js
import { defineStore } from 'pinia'
import { ref, computed } from 'vue'

export const useCounterStore = defineStore('counter', () => {
  // ① State —— 相当于 data
  const count = ref(0)

  // ② Getter —— 相当于 computed
  const doubleCount = computed(() => count.value * 2)

  // ③ Action —— 相当于 methods（同步/异步均可）
  function increment() {
    count.value++
  }

  async function fetchData() {
    const res = await fetch('/api/data')
    count.value = await res.json()
  }

  return { count, doubleCount, increment, fetchData }
})
```

## 如何在组件中解构使用 Pinia？

**一、定义**

> Pinia 想到了解构丢失响应式的问题，于是可以用 `storeToRefs` 替代。

```js
import { useCounterStore } from '@/stores/counter'
import { storeToRefs } from 'pinia'

const store = useCounterStore()

// ❌ 错误：直接解构会丢失响应式
// const { count } = store

// ✅ 正确：用 storeToRefs 保持响应式（仅解构 state/getter）
const { count, doubleCount } = storeToRefs(store)

// ✅ action 直接解构即可，不需要 storeToRefs
const { increment } = store
```

## Pinia 如何实现数据持久化？

**一、定义**

> 明明在 Vuex/Pinia 里存好了用户登录状态，刷新页面瞬间归零；购物车辛辛苦苦加了 5 件商品，一个 F5 全没了。

**二、解决方案**

使用 `pinia-plugin-persistedstate` 插件。

使用 Pinia 的优势包括：状态集中管理更容易维护、支持响应式、支持开发工具调试、支持 TypeScript，还可以配合 localStorage 实现数据持久化，状态变更可追踪。

> npm install pinia-plugin-persistedstate

```js
// main.js
import { createPinia } from 'pinia'
import piniaPluginPersistedstate from 'pinia-plugin-persistedstate'

const pinia = createPinia()
pinia.use(piniaPluginPersistedstate)
```

```js
// store 中开启持久化
export const useUserStore = defineStore('user', {
  state: () => ({ token: '', userInfo: {} }),
  persist: true,  // 全部持久化
  // 或精细控制：
  // persist: {
  //   key: 'user',
  //   storage: localStorage,
  //   paths: ['token']  // 只持久化 token
  // }
})
```

## Pinia 支持多 Store 吗？Store 之间如何通信？

**一、定义**

> Pinia 的核心概念是"stores"，每个 store 都是一个独立的状态容器，这使得开发者可以更灵活地组织他们的状态，而不是像 Vuex 那样必须将所有状态放在一个大的单一对象中。

**二、具体实现**

> **对比 Vuex**：Vuex 的 modules 通信需要用*`rootState`*，Pinia 直接`import` *即可，更符合直觉。*

**Store 间通信**直接引入即可：

```
// stores/order.js
import { defineStore } from 'pinia'
import { useUserStore } from './user'  // 直接引入另一个 store

export const useOrderStore = defineStore('order', () => {
  const userStore = useUserStore()  // 使用其他 store

  function placeOrder() {
    console.log('当前用户：', userStore.userInfo)
    // 直接调用其他 store 的 state/action
  }

  return { placeOrder }
})
```

## 在什么场景下应该使用 Pinia？

在中大型项目中，推荐使用 Pinia 来管理状态，可以获得更好的可维护性和开发体验。

> **推荐使用 Pinia 管理的数据：**
>
> - 🔑 用户登录态（token、userInfo）
> - 🛒 购物车数据
> - 🌐 全局配置（语言、主题）
> - 📦 跨多个组件共享的服务端缓存数据
>
> **不建议用 Pinia 管理的数据：**
>
> - 仅在单个组件内使用的局部 UI 状态（用 `ref`/`reactive` 即可）

# 中级

# 高级

## Pinia 的底层原理是什么？

Pinia 也利用了 Vue.js 的响应性系统，其核心原理可拆解为：

| 概念          | 底层实现                            |
| ------------- | ----------------------------------- |
| `state`       | `reactive()` 包裹整个 store 对象    |
| `getter`      | `computed()` 实现缓存与派生         |
| `action`      | 普通函数，`this` 指向 store 实例    |
| `storeToRefs` | 对 state/getter 调用 `toRef()` 转换 |

> **面试加分**：Pinia 内部每个 store 本质上是一个用 `reactive` 包裹的响应式对象，`defineStore` 返回一个 `useXxxStore` 的 hooks 函数，每次调用都返回同一个单例，保证状态全局唯一。
