---
title: 状态管理(pinia或vuex)
date: 2023-01-01 08:33:16
categories:
- B_中级
toc: true # 是否启用内容索引
---

# 初级

## **Pinia 和 Vuex的区别**

**一、基础概念**

**1. Pinia 和 Vuex 分别是什么？**

**Vuex** 和 **Pinia** 都是 Vue 的状态管理库：

> - **Vuex** 是 Vue 官方的 **集中式状态管理库**，适用于大型应用。
> - **Pinia** 是 Vuex 的下一代替代方案，提供更简洁和直观的 API。

**2.Pinia 和 Vuex 的核心区别**

| **对比项**   | **Pinia**                        | **Vuex**                      |
| ------------ | -------------------------------- | ----------------------------- |
| **语法风格** | 基于 `setup()`，支持组合式 API   | 传统的 `mutations`、`actions` |
| **模块化**   | 自动支持模块化                   | 需手动 `namespaced: true`     |
| **类型支持** | 原生支持 TypeScript              | TS 需手动定义类型             |
| **使用方式** | 直接访问 `state`，无 `mutations` | 必须通过 `mutations`          |

**3. Vue 3 推荐使用 Pinia 还是 Vuex？**

Vue 3 **官方推荐** **Pinia**，因为它：

> - 更简洁，去掉了 `mutations`
> - 直接支持 TypeScript
> - 更好的开发体验（支持 Vue DevTools）

**二、状态管理 API 对比**

**1.Vuex 和 Pinia 中定义全局状态？**

**Vuex:**

```js
const store = new Vuex.Store({
  state: { count: 0 },
  mutations: { increment(state) { state.count++ } },
  actions: { increment({ commit }) { commit('increment') } },
});
```

**Pinia:**

```js
import { defineStore } from 'pinia';
export const useCounterStore = defineStore('counter', {
  state: () => ({ count: 0 }),
  actions: { increment() { this.count++ } },
});
```

**2.Vuex 和 Pinia 中如何读取 state？**

**Vuex:**

```js
computed(() => store.state.count);
```

**Pinia:**

```js
const store = useCounterStore();
computed(() => store.count);
```

**3.Vuex 和 Pinia 中如何修改 state？**

**Vuex（必须用 mutations）：**

```js
store.commit('increment');
```

**Pinia（直接修改 state 或调用 actions）：**

```js
store.count++;  
store.increment();
```

**4.Pinia 为什么去掉了 mutations？**

Pinia 认为 `mutations` 只是 `actions` 的一个 **额外步骤**，没必要单独存在。因此 **直接使用 actions 处理状态修改**，简化代码。

**5.Pinia 如何支持 TypeScript？**

**Pinia** **原生支持** TypeScript，直接定义 `state` 类型：

```js
export const useCounterStore = defineStore('counter', {
  state: (): { count: number } => ({ count: 0 }),
});
```

**三、模块化与最佳实践**

**1.Vuex 和 Pinia 如何管理多个 store？**

**Vuex:**
手动使用 `modules`：

```js
const store = new Vuex.Store({
  modules: { user: userModule, cart: cartModule },
});
```

**Pinia:**
每个 store **自动模块化**：

```js
export const useUserStore = defineStore('user', { state: () => ({ name: '' }) });
export const useCartStore = defineStore('cart', { state: () => ({ items: [] }) });
```

**2.如何在 Vue 组件中使用 Pinia store？**

```js
import { useCounterStore } from '@/stores/counter';
const store = useCounterStore();
console.log(store.count);
```

**3.Pinia 如何持久化存储？**

使用 `pinia-plugin-persistedstate`：

```js
import { createPinia } from 'pinia';
import persist from 'pinia-plugin-persistedstate';

const pinia = createPinia();
pinia.use(persist);
```

**4.Pinia 是否支持 Vue DevTools？**

是的，Pinia **原生支持 Vue DevTools**，相比 Vuex **更直观**，支持时间旅行调试。

**四、高级特性与性能优化**

**1.Pinia 和 Vuex 哪个性能更好？**

**Pinia 性能更优**：

> - **Pinia 仅在 state 变化时重新计算**
> - **Vuex 可能导致额外的 reactivity 计算**
> - **Pinia 代码更少，减少运行时开销**

**2.Vuex 和 Pinia 如何处理 computed state？**

**Vuex:**

```js
getters: {
  doubleCount: (state) => state.count * 2
}
```

**Pinia:**

```js
export const useCounterStore = defineStore('counter', {
  state: () => ({ count: 0 }),
  getters: { doubleCount: (state) => state.count * 2 },
});
```

**3.Vuex 和 Pinia 如何处理异步操作？**

**Vuex:**

```js
actions: {
  async fetchData({ commit }) {
    const data = await fetchDataFromAPI();
    commit('setData', data);
  }
}
```

**Pinia:**

```js
actions: {
  async fetchData() {
    this.data = await fetchDataFromAPI();
  }
}
```

**五、实战问题**

**1.Pinia 如何监听 state 变化？**

```js
const store = useCounterStore();
watch(() => store.count, (newVal) => {
  console.log('count 变化:', newVal);
});
```

**2.如何在 Vue 组件外部访问 Pinia？**

```js
import { useCounterStore } from '@/stores/counter';
const store = useCounterStore();
console.log(store.count);
```

**3.Pinia 支持 SSR（服务端渲染）吗？**

是的，Pinia **支持 Nuxt 3** 和 **Vue SSR**，相比 Vuex 更简单。

**4.Pinia 如何动态注册 store？**

```js
import { defineStore, createPinia } from 'pinia';

export const useDynamicStore = defineStore('dynamic', {
  state: () => ({ name: '' }),
});
```

```js
const store = useDynamicStore(pinia);
```





# 中级

# 高级

