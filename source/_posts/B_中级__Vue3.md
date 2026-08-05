---
title: Vue3
date: 2021-01-01 07:33:16
categories:
- B_中级
toc: true # 是否启用内容索引
---

**参考**

> - [我要成为海贼王的男人-Vue3最全宇宙入口](https://github.com/vue3/vue3-News#%E6%88%91%E6%98%AF%E8%A6%81%E6%88%90%E4%B8%BA%E6%B5%B7%E8%B4%BC%E7%8E%8B%E7%9A%84%E7%94%B7%E4%BA%BA)
> - [Vue3+TS快速上手-尚硅谷-video](https://www.bilibili.com/video/BV1ra4y1H7ih/?p=2&spm_id_from=pageDriver&vd_source=bd4c7d99d71adf64d6e88c65370e0247)
> - [Vue3+TS快速上手-尚硅谷](https://24kcs.github.io/vue3_study/)
> - [Vite + Vue3 + Pinia + 实战项目 + TypeScript-小鹿线-video](https://www.bilibili.com/video/BV1aU4y1U7Gv/?p=12&spm_id_from=pageDriver&vd_source=bd4c7d99d71adf64d6e88c65370e0247)
> - [📺 VueMastery原版](https://link.juejin.cn/?target=https%3A%2F%2Fwww.bilibili.com%2Fvideo%2FBV1my4y1m7sz%3Fp%3D6)
> - [📺 然叔与杨村长的深度解读](https://link.juejin.cn/?target=https%3A%2F%2Fwww.bilibili.com%2Fvideo%2FBV1my4y1m7sz%3Fp%3D7)
> - [🔥 39岁的夺路狂奔| 掘金年度征文](https://juejin.cn/post/6903701243361755149) 98赞
> - [🔥 Element3开发内幕 - Vue CLI插件开发](https://juejin.cn/post/6899334776860180494) 167赞
> - [🔥 天天造轮子系列](https://juejin.cn/post/6893338774088974343) 500+ 赞
> - [🔥 Vue3.0全球发布会干货总结](https://juejin.cn/post/6875236411349008398) 267赞
> - [《Vue 3.0 来了，我们该做些什么？》](https://juejin.cn/post/6874604408030789640)
> - [《Vue3实战系列：结合 Ant-Design-of-Vue 实践 Composition API》](https://juejin.cn/post/6882393804310052871)
> - [《Vue3 来了，Vue3 开源商城项目重构计划正式启动！》](https://juejin.cn/post/6884991023811215374)
> - [《Vue3实战系列：Vue3.0 + Vant3.0 搭建种子项目》](https://juejin.cn/post/6887590229692121096)
> - [《🎉🎉一个基于 Vue 3 + Vant 3 的开源商城项目🎉🎉》](https://juejin.cn/post/6892783570016796679)
> - [《Vue3教程：用 Vue3 开发小程序，这里有一份实践代码！》](https://juejin.cn/post/6895360073460416525)
> - [《Vue3教程：Vue 3.x 快在哪里？》](https://juejin.cn/post/6903171037211557895)
> - [《Vue3教程：开发一个 Vue 3 + element-plus 的后台管理系统》](https://juejin.cn/post/6942251234191654949)
> - [《🎉🎉Vue 3 + Element Plus + Vite 2 的后台管理系统开源啦🎉🎉》](https://juejin.cn/post/6945072070132760590)
> - [程序员的副业：写了一个专栏《Vue 3企业级项目实战》](https://juejin.cn/post/6947703226128924702)
> - [心脏跳动团队-商城](https://link.juejin.cn?target=https%3A%2F%2Fgithub.com%2Fnewbee-ltd)
> - [vue3保姆级教程Vue.js前端](https://juejin.cn/post/7030992475271495711)
> - [Vue3.0 新特性以及使用经验总结](https://juejin.cn/post/6940454764421316644#heading-1)
> - [焕然一新的 Vue 3 中文文档要来了](https://juejin.cn/post/7077701166397653028)

# 初级

## ref 和 reactive

**1.定义**

> 它们的本质都是为了解决数据变化后视图自动更新的问题，但在**适用数据类型**、**使用方式**以及**底层实现**上有明显的区别。

**2.区别**

| 维度          | ref                                                     | reactive                                   |
| :------------ | :------------------------------------------------------ | :----------------------------------------- |
| **目标数据**  | 基本类型、对象（不推荐）                                | 对象、数组                                 |
| **取值/赋值** | JS 中需要 `.value`                                      | 直接属性访问                               |
| **重新赋值**  | **支持**替换整个对象（`data.value = newObj`）           | **不支持**直接替换整个对象（会丢失响应式） |
| **解构影响**  | 解构后依然保持响应式（因为解构的是 RefImpl 对象）       | 解构后**响应式丢失**（ES6 解构是值传递）   |
| **底层原理**  | 基于 `Object.defineProperty` 的 getter/setter (RefImpl) | 基于 ES6 `Proxy`                           |

**3.底层原理**

- **ref：** 在内部创建了一个 `RefImpl` 类的实例。对于基本类型，它使用 `Object.defineProperty` 的 `get` 和 `set` 来拦截 `.value` 的读写操作，从而触发依赖收集和更新。如果传入的是对象，`ref` 内部其实会自动调用 `reactive` 来转化。
- **reactive：** 直接使用了 ES6 的 `Proxy` API。Proxy 可以拦截对象属性的读取、赋值、删除等操作，实现深度的响应式拦截，相比 Vue 2 的 `Object.defineProperty` 能更好地处理数组索引和动态添加属性的问题。

4.进阶

> Q：**reactive 不要直接赋值**
>
> A：可以采用`Object.assign(state, newState)` （合并属性）
>
> Q:reactive数组解构
>
> A:从 `reactive` 定义的数组中取出一个元素（`const [item] = arr`），`item` 会失去响应式。如果需要解构，请务必使用 `toRefs`。
>
> Q:为什么 ref 需要 .value 而 reactive 不需要?
>
> A:因为 JS 基本类型是按值传递的，无法被 Proxy 代理，所以 Vue 把它包在一个对象里，通过拦截对象的 .value 属性来实现。
>
> Q:toRefs 原理是什么？
>
> A:它遍历 reactive 对象的每个 key，把每个属性都转换成一个 ref，从而在解构时保持响应式链接。

## 生命周期

- 新增钩子：
  - `onRenderTracked`：状态渲染跟踪（用于调试）。
  - `onRenderTriggered`：状态触发渲染（用于调试）。
  - `onServerPrefetch`：SSR 服务端渲染相关。

## 自定义指令

**1.定义**

> Vue 3 的自定义指令主要用来对普通 DOM 元素进行底层操作。
> 虽然 Vue 推崇数据驱动视图，但在某些场景下（如自动聚焦输入框、防抖节流、无限滚动、权限控制等），我们仍然需要直接访问 DOM

**2.核心钩子函数**

自定义指令的钩子函数名称与组件生命周期保持了一致性（但有所不同），主要包括以下几个：

> - **created**：指令绑定到元素后，只调用一次。此时 DOM 还没挂载，可以在此时进行一些初始化逻辑。
> - **beforeMount**：元素插入 DOM 前调用。
> - **mounted**：元素被插入父节点后调用（最常用），通常在这里进行 DOM 操作。
> - **beforeUpdate**：元素更新前调用。
> - **updated**：元素更新后调用。
> - **beforeUnmount**：元素卸载前调用。
> - **unmounted**：指令与元素解绑，且元素从 DOM 移除后调用（常用于清理定时器、解绑事件）。

**3.钩子参数**

> - **el**：指令绑定的**真实 DOM 元素**，可以直接操作它。
>
> - **binding**
>
>   ：是一个对象，包含以下核心属性：
>
>   - `value`：指令绑定的值（例如 `v-focus="true"` 中的 `true`）。
>   - `oldValue`：指令绑定的前一个值（仅在 `updated` 和 `beforeUpdate` 中可用）。
>   - `arg`：传给指令的参数（例如 `v-text:msg` 中的 `"msg"`）。
>   - `modifiers`：包含修饰符的对象（例如 `v-submit.prevent` 中的 `{ prevent: true }`）。
>   - `instance`：使用指令的组件实例。
>
> - **vnode**：代表绑定元素的底层 VNode。
>
> - **prevVnode**：上一个渲染状态中代表绑定元素的 VNode（仅在 `beforeUpdate` 和 `updated` 中可用）。

**4.注册方式**

**A. 全局注册 (main.js)**

```js
const app = createApp(App)

// 定义一个 v-focus 指令
app.directive('focus', {
  mounted(el) {
    el.focus()
  }
})
```

**B. 局部注册 (script setup 语法糖)**

在 Vue 3 `<script setup>` 中，指令名需要以 `v` 开头的小驼峰命名。

```js
<script setup>
// 局部指令：vLoading
const vLoading = {
  mounted(el, binding) {
    if (binding.value) {
      // 模拟添加 loading 样式
      el.classList.add('loading')
      el.innerText = 'Loading...'
    }
  },
  updated(el, binding) {
    if (binding.value !== binding.oldValue) {
      if (binding.value) {
        el.classList.add('loading')
      } else {
        el.classList.remove('loading')
      }
    }
  }
}
</script>

<template>
  <div v-loading="isLoading">Content</div>
</template>
```

**C. 简写形式**

如果指令逻辑只在 `mounted` 和 `updated` 时相同（例如根据值动态设置样式），可以使用简写：

```js
app.directive('color', (el, binding) => {
  // 这里的函数会在 mounted 和 updated 时调用
  el.style.color = binding.value
})
```

**5. 实际应用场景（项目经验）**

在项目中，我通常会在以下场景使用自定义指令：

1. **权限控制**：`v-permission`，根据用户权限动态移除或禁用按钮。
2. **防抖节流**：`v-debounce`，防止用户频繁点击提交按钮。
3. **懒加载**：`v-lazy`，图片滚动到可视区域时才加载。
4. **一键复制**：`v-copy`，点击元素自动将内容复制到剪贴板。
5. **Loading 状态**：全屏 Loading 或局部 Loading 的切换。

**6.Vue2与Vue3区别**

| 特性            | Vue 2                                                      | Vue 3                                                        |
| :-------------- | :--------------------------------------------------------- | :----------------------------------------------------------- |
| **钩子命名**    | `bind`, `inserted`, `update`, `componentUpdated`, `unbind` | `created`, `beforeMount`, `mounted`, `beforeUpdate`, `updated`, `beforeUnmount`, `unmounted` |
| **`el` 的时机** | 在 `bind` 钩子中，`el` 可能是一个注释节点（如果是 `v-if`） | 在 `created` 中就能拿到真实的 DOM 元素                       |
| **逻辑复用**    | 较难复用，通常混合在钩子里                                 | 可以利用 Composition API 的函数提取复用逻辑                  |

## 自定义过滤器

**Vue 3 移除了内置的过滤器。**

官方给出了两个主要原因：

> 1. **可替代性强**：过滤器的功能完全可以通过 Methods（方法调用）或 Computed（计算属性）来实现，且计算属性拥有更好的响应式缓存机制。
> 2. **语法冗余与模糊**：过滤器在模板中看起来像函数调用（`{{ msg | filter }}`），但又不完全等同于 JavaScript 的函数调用或管道操作符，这增加了学习成本和解析复杂度。同时，过滤器只适用于插值 `{{ }}` 和 `v-bind`，限制了使用场景。

## 常用修饰符

Vue 2 和 Vue 3 在修饰符上的区别，主要在于 **`v-model` 的参数**。

- **Vue 2**：组件上的 `v-model` 默认利用名为 `value` 的 prop 和 `input` 事件。如果要绑定其他变量，需要用 `.sync` 修饰符。
- **Vue 3**：移除了 `.sync` 修饰符。`v-model` 在组件上默认利用名为 `modelValue` 的 prop 和 `update:modelValue` 事件。如果需要绑定多个值，使用 `v-model:arg` 的形式。

## keep-alive

Vue3替换为两个新的钩子：

> - `onActivated`：组件被激活（从缓存中取出，插入 DOM）时调用。
>   - *替代场景*：原来写在 `mounted` 中的刷新数据逻辑，如果需要每次进入都刷新，应移入此钩子。
> - `onDeactivated`：组件失活（从 DOM 移除，放入缓存）时调用。
>   - *场景*：在这里可以保存当前的滚动位置，或者清除定时器。

**面试**

> Q:**如果一个组件使用了 `<KeepAlive>`，它什么时候会被销毁？**
>
> A:1. 组件被从 `<KeepAlive>` 中移除（如 `v-if="false"`）。2. 达到了 `max` 缓存上限，且该实例是最久未使用的（LRU）。
>
> Q:**为什么我的 `include` 写了组件名却不生效？**
>
> A:检查组件内部是否显式定义了 `name` 选项。Vue 3 的 `<script setup>` 语法糖需要配合 `defineOptions` 或单独的 `<script>` 标签来定义 `name`。

## 检测路由动态变化

**1.定义**

> 在 Vue 3 中，由于推荐使用 **Composition API**，我们不再像 Vue 2 那样通过 `watch: { '$route': ... }` 来监听路由。
> Vue 3 提供了组合式函数 `useRoute`，配合 Vue 的 `watch` 或 `watchEffect` 来实现路由监听。此外，Vue Router 还提供了组件内的导航守卫 `onBeforeRouteUpdate`，专门用于处理组件复用时的路由参数变化。

**2.核心实现**

**方案一：使用 `watch` 监听（最常用）**

注意：必须监听路由的某个具体属性（如 `route.params.id`），不能直接监听 `route` 对象本身，因为 `route` 对象的引用在路由跳转时是不变的。

```js
<script setup>
import { watch } from 'vue'
import { useRoute } from 'vue-router'
import { fetchData } from '@/api'

const route = useRoute()

// 监听路由参数 id 的变化
watch(
  () => route.params.id, 
  (newId, oldId) => {
    console.log(`ID 从 ${oldId} 变为 ${newId}`)
    fetchData(newId) // 重新获取数据
  },
  { immediate: true } // 可选：初始化时立即执行一次
)
</script>
```

**方案二：使用导航守卫 `onBeforeRouteUpdate`（推荐用于“组件复用”场景）**

```js
<script setup>
import { onBeforeRouteUpdate } from 'vue-router'
import { ref } from 'vue'

const userData = ref(null)

const getUser = (id) => { /* ... */ }

// 在当前路由改变，但是该组件被复用时调用
onBeforeRouteUpdate((to, from, next) => {
  console.log('路由即将更新，目标：', to)
  getUser(to.params.id)
  next() // 务必调用 next() 或直接 return true
})
</script>
```

**方案三：使用 `watchEffect`（简化版）**

```js
<script setup>
import { watchEffect } from 'vue'
import { useRoute } from 'vue-router'

const route = useRoute()

watchEffect(() => {
  // 只要 route 里的任意属性发生变化，这里都会重新执行
  document.title = route.meta.title || '默认标题'
})
</script>
```

**3.对比**

| 方案                      | 适用场景                           | 特点                                                         |
| :------------------------ | :--------------------------------- | :----------------------------------------------------------- |
| **`watch`**               | 需要根据路由变化获取新数据         | 精确控制，可以拿到 `newValue` 和 `oldValue`，灵活性高。      |
| **`onBeforeRouteUpdate`** | 涉及导航拦截、取消旧请求、权限控制 | 能访问 `next` 函数，可以在路由更新**前**执行逻辑，适合在组件复用时替代 `created`。 |
| **`watchEffect`**         | 副作用简单，如修改网页标题         | 代码简洁，但难以获取新旧值对比。                             |

## router-link上v-slot

**Vue 2 与 Vue 3 的区别（迁移相关）**

- Vue 2 (tag 属性)：过去可以使用 `<router-link to="/foo" tag="li">` 来渲染 `li` 标签。
- **Vue 3 (移除 `tag`)**：Vue Router 4 移除了 `tag` 和 `event` 属性。**原因**是这种属性组合不够灵活，无法支持在链接中渲染多个根节点。
- **替代方案**：现在必须使用 `v-slot` + `custom` 来实现同样的效果。

## 插槽

**Vue 2 与 Vue 3 的语法区别（重要）**

- **废弃了 `slot` 属性**：Vue 2 中具名插槽使用 `<div slot="header">`，Vue 3 中必须使用 `<template #header>`。
- **废弃了 slot-scope**：Vue 2 中作用域插槽使用 `<div slot-scope="props">`，Vue 3 中统一使用 `<template #default="props">`。
- **统一指令**：Vue 3 引入了 `v-slot` 指令（可缩写为 `#`），统一了所有插槽的语法，更加规范和强大。

## Watch vs WatchEffect

> - `watch` 需要明确指定依赖源。
> - `watchEffect` 会自动追踪回调内访问的响应式数据，但无法获取 `oldVal`，且初始时就会立即执行一次。

## 组件通信

分为三类：**父子通信**、**跨级通信**、**兄弟/任意组件通信**

> - 父子：`props/$emit`，defineProps/defineEmits。**多个 v-model**
> - 跨级：`provide` / `inject`(依赖注入)
> - 兄弟/任意：**Mitt** (事件总线)，**Pinia**(状态管理)
> - 其他：**Ref & defineExpose**

**场景选择**

> 1. **最简单直接的父子交互**，首选 **Props/Emits**。
> 2. 如果层级很深（如布局组件），使用 **Provide/Inject**。
> 3. 如果涉及到全局数据（如用户登录态），直接上 **Pinia**。
> 4. 如果仅仅是两个非关联组件偶尔通信，且不想引入重型状态库，可以用 **Mitt**。
> 5. 如果需要父组件直接操作子组件的表单校验，用 **Ref** 获取实例调用 `defineExpose` 暴露的方法。

## 动画

Vue 3 对类名进行了重命名以符合 W3C 标准：

| 阶段         | Vue 2 旧版命名 | Vue 3 新版命名     |
| :----------- | :------------- | :----------------- |
| **进入开始** | `v-enter`      | **`v-enter-from`** |
| **离开结束** | `v-leave-to`   | **`v-leave-to`**   |

# 中级

## 双向数据绑定

**1.重大变化**

`v-model` 实际上就是 `prop` + `event` 的语法糖。

- **Vue 2**：默认绑定 `value` 属性，监听 `input` 事件。
- **Vue 3**：默认绑定 `modelValue` 属性，监听 `update:modelValue` 事件。**并且支持多个 `v-model`**。

| 特性           | Vue 2                         | Vue 3                                |
| :------------- | :---------------------------- | :----------------------------------- |
| **默认 Prop**  | `value`                       | **`modelValue`**                     |
| **默认 Event** | `input`                       | **`update:modelValue`**              |
| **支持多绑定** | 不支持（需用 `.sync` 修饰符） | **支持**（可写多个 `v-model:xxx`）   |
| **配置方式**   | `model` 选项                  | 无需配置，直接实现 `update:xxx` 事件 |

**2.底层原理**

Vue 3 的双向绑定，表面上是 `v-model` 的语法糖，底层依赖于 **Proxy (代理)** 实现的响应式系统。

当数据变化时，Vue 的 `Proxy` 会拦截赋值操作，触发依赖更新，实现数据驱动视图。
我们在使用时，应理解 Vue 3 推崇的 `modelValue` 和 `update:xxx` 模式，这比 Vue 2 更规范，且支持多参数绑定，非常适合开发复杂的业务组件。

## Proxy

**1.定义**

> 它是一个 ES6 新增的特性，用于创建一个对象的代理，从而拦截和自定义该对象的基本操作（如属性查找、赋值、枚举、函数调用等）。
> Vue 2 使用 `Object.defineProperty`，而 Vue 3 改用 `Proxy`，是为了解决 Vue 2 中无法监听数组下标变化、无法监听对象属性新增/删除等痛点，并提升了性能。

**2.Vu2与Vue3对比**

| 维度           | Vue 2 (`Object.defineProperty`)                       | Vue 3 (`Proxy`)                                    |
| :------------- | :---------------------------------------------------- | :------------------------------------------------- |
| **监听对象**   | 递归遍历，给每个属性添加 getter/setter                | **代理整个对象**，不需要遍历                       |
| **数组监听**   | **无法监听**索引修改和长度变化（需重写 7 个数组方法） | **原生支持**，直接监听数组的索引和长度变化         |
| **属性增删**   | **无法监听**，需要调用 `Vue.set` / `Vue.delete`       | **直接监听**，`delete` 操作也能触发更新            |
| **Map/Set 等** | 不支持                                                | **支持** Map, Set, WeakMap, WeakSet                |
| **性能**       | 初始化时递归遍历，耗时多                              | **惰性代理**（Lazy Proxy），用到才递归，初始化更快 |

**3.核心原理**

Vue 3 在实现 `reactive` 时，使用 `new Proxy(target, handler)` 来包装对象，并配合 **`Reflect`**（反射）来进行操作的实现了更高效、更规范的惰性响应式。

**为什么需要 `Reflect`？**

1. **保证 `this` 指向**：在 Proxy 的 handler 中调用 `Reflect` 可以确保 `this` 始终指向原始对象，而不是 Proxy 对象（解决依赖收集时的上下文丢失问题）。
2. **统一返回值**：`Reflect` 的返回值与 Proxy 的拦截要求一致，方便错误处理。

**4.手写Proxy**

```js
function reactive(target) {
  return new Proxy(target, {
    get(target, key, receiver) {
      console.log(`获取了属性: ${key}`) // 依赖收集
      
      // 1. Reflect.get 获取值
      // 2. receiver 作用是保证如果 target 内部有 getter，this 指向代理对象，从而保持响应式
      const result = Reflect.get(target, key, receiver)
      
      // 3. 懒代理：只有当访问到的值是对象时，才递归调用 reactive，而不是一开始就递归
      if (isObject(result)) {
        return reactive(result)
      }
      
      return result
    },
    
    set(target, key, value, receiver) {
      console.log(`设置了属性: ${key} = ${value}`) // 触发更新
      
      // 4. 触发更新逻辑
      const result = Reflect.set(target, key, value, receiver)
      return result
    }
  })
}
```

**5.Proxy优缺点**

**优点**

> **A. 解决了数组响应式的难题**
> Vue 2 中修改 `arr[0] = 1` 无效，必须用 `Vue.set`。
> Vue 3 中直接修改数组索引或 `length`，Proxy 都能拦截到，从而触发更新。
>
> **B. 解决了动态属性添加的难题**
> Vue 2 中给对象添加新属性 `obj.newProp = 1` 无效，必须用 `Vue.set`。
> Vue 3 中直接添加 `obj.newProp = 1`，Proxy 的 `set` 拦截器会立即捕获，无需额外 API。
>
> **C. 惰性代理（性能优化）**
>
> - **Vue 2**：初始化时，无论数据多深，都会递归把所有属性转成响应式。如果数据量大但实际只用了很少一部分，非常浪费性能。
> - **Vue 3**：初始化时只代理第一层。只有当你真正访问了 `obj.a.b` 时，Vue 才会去代理 `a` 和 `b`。这大大减少了初始化的时间。

**缺点**

> - **浏览器兼容性**：`Proxy` 是 ES6 标准，不支持 IE 浏览器。这也是 Vue 3 宣布放弃支持 IE11 的主要原因之一。

## 虚拟 DOM

**1.Vue2与Vue3变化**

Vue 2 的虚拟 DOM 机制在初始化时需要遍历整个树，比较时采用全量 Diff，性能在某些场景下仍有瓶颈。Vue 3 通过 **“编译时优化”** 和 **“运行时优化”** 结合，大幅提升了性能。

主要体现在以下三个点：

**A. 静态提升**

- **Vue 2**：每次重新渲染时，即使内容没变，静态的节点（如 `<div>static text</div>`）也会被重新创建，然后丢弃旧的。
- **Vue 3**：编译器会将不参与更新的静态节点提升到渲染函数外部。这意味着**静态节点只创建一次**，后续渲染直接复用。

**B. Patch Flags（补丁标记）**

- **原理**：在编译阶段，Vue 3 会给动态节点打上“标签”。比如，如果一个节点只有 `class` 会变，就标记 `CLASS`；只有文本会变，就标记 `TEXT`。
- **优势**：在 Diff 算法比对时，Vue 3 只会对比标记为“动态”的部分，完全跳过静态属性的比较，极大减少了运行时的计算量。

**C. Block Tree（块级树）**

- **原理**：Vue 3 将模板基于动态节点切分成一个个 `Block`。每个 `Block` 内部只收集动态节点的数组。
- **优势**：在进行全量 Diff 时，不需要遍历整个 VNode 树，只需要遍历 `Block` 内部的动态节点数组即可。这在模板越大、静态内容越多时，性能提升越明显。

# 高级

## $forceUpdate原理

**1.定义**

> `$forceUpdate` 的底层原理是**手动调用组件实例上的渲染副作用函数（`instance.update`）**，从而强制触发当前组件的重新渲染（即重新执行 `render` 函数生成新的虚拟 DOM，并进行 patch 比对），但这个过程**不会深度强制更新子组件**。

**2.核心原理**

在 Vue3 的源码中，组件挂载时通过 `setupRenderEffect` 建立了渲染副作用（基于 `ReactiveEffect`）。`$forceUpdate` 的实现非常简练，核心步骤如下：

> 1. **获取组件实例**：首先获取当前组件的实例 `instance`。
> 2. **调用 `update` 函数**：直接执行 `instance.update()`。
> 3. **副作用执行**：`instance.update` 实际上是 `ReactiveEffect` 包装后的函数。调用它相当于直接绕过响应式系统的依赖追踪，强制重新执行组件的渲染函数 `renderComponentRoot`。
> 4. **DOM 比对与更新**：重新执行渲染函数会生成新的 VNode（虚拟节点），随后 Vue 的 `patch` 逻辑会对比新旧 VNode，最终只将变化的部分更新到真实 DOM 上。

**3.Vue2与Vue3区别**

> 1. **底层实现不同**：
>    - Vue2 是通过调用 `vm._watcher.update()`（触发 Watcher 的 update 方法），将渲染 Watcher 加入异步队列。
>    - Vue3 是通过调用 `instance.update()`（触发 `ReactiveEffect` 的执行），同样会被 `scheduler` 调度到微任务队列中，但底层 API 完全重写。
> 2. **更新范围一致**：无论是 Vue2 还是 Vue3，`$forceUpdate` **都只针对当前组件**，不会强制更新子组件。如果子组件需要更新，必须依赖子组件自身的响应式数据变化，或者子组件自身调用 `$forceUpdate`。

**4.使用场景**

> 1. **非响应式数据绑定**：在复杂逻辑中，绑定了未经过 `reactive` 或 `ref` 包装的普通 JavaScript 对象/数组（如直接操作了 `window` 对象上的某些属性，或使用了第三方库的对象实例）。
> 2. **深层对象解构丢失响应式**：不慎对响应式对象进行解构导致丢失响应式，但又不想重构代码时，作为临时补救措施。
> 3. **强烈不建议**使用 `$forceUpdate`。它的出现通常意味着代码设计存在缺陷（违背了 Vue 响应式数据驱动的核心理念）

**5.面试**

> Q:**为什么 `$forceUpdate` 不会触发 `created/mounted` 等生命周期钩子？**
>
> A:因为 `$forceUpdate` 触发的是组件的 `patch` 阶段（更新阶段），它只重新执行 `render` 函数并比对 DOM，而不会重新执行 `setup` 或 `created/mounted` 这些初始化阶段的逻辑。在更新阶段只会触发 `beforeUpdate` 和 `updated` 生命周期。

## nextTick原理

**1.定义**

> `nextTick` 的原理是**利用微任务（Microtask）队列异步执行回调**。它将传入的回调函数收集到一个数组中，并在当前同步代码执行完毕后，通过 `Promise.resolve().then()` 将其放入微任务队列中统一批量执行，从而确保回调在 DOM 更新完成之后触发。

**2.核心原理**

Vue 的数据更新是异步的。当响应式数据发生变化时，Vue 不会立刻渲染 DOM，而是将渲染副作用函数（`component.update`）推入一个队列（`queueJob`）中，并在下一个微任务中批量执行。`nextTick` 正是配合这一机制的核心 API。

> (注：Vue3 对源码做了高度精简优化，直接复用 Promise 的链式调用机制，不再像 Vue2 那样维护一个复杂的降级数组。)

Vue3 源码（`packages/runtime-core/src/scheduler.ts`）中的核心步骤如下：

> 1. **维护闭包队列**：内部维护了一个 `callbacks` 数组，用来存放所有通过 `nextTick` 传入的回调函数。
> 2. **触发微任务**：当第一次调用 `nextTick` 时，会创建一个 `Promise` 对象，并通过 `Promise.resolve().then()` 将清空 `callbacks` 数组的函数（`flushCallbacks`）放入微任务队列中。
> 3. **收集回调**：将当前调用 `nextTick` 传入的回调函数 `push` 到 `callbacks` 数组中。
> 4. **批量执行**：当当前主线程的同步代码执行完毕后，微任务队列中的 `flushCallbacks` 被执行，它会遍历并依次执行 `callbacks` 中的所有回调，然后清空数组。
> 5. **DOM 更新的先后顺序**：Vue3 中组件的更新逻辑（`queueJob`）也是通过 `nextTick` 调度的。因为 JavaScript 是单线程执行，只要在调用 `nextTick` 之前修改了数据，组件的渲染更新任务就会先被推入微任务队列，随后用户传给 `nextTick` 的回调也会被推入微任务队列。**这就保证了用户的回调始终在组件 DOM 更新之后执行。**

**3.Vue2与Vue3区别**

> 1. **异步策略降级不同**：
>    - Vue2 内部有一套复杂的降级机制：`Promise`（微任务） -> `MutationObserver`（微任务） -> `setImmediate`（宏任务） -> `setTimeout`（宏任务）。主要是为了兼容不支持微任务的旧环境（如 IE）。
>    - Vue3 直接抛弃了 IE 兼容，全面拥抱现代浏览器，直接使用原生 `Promise`（微任务），不再需要复杂的降级处理，源码更轻量。
> 2. **队列维护方式不同**：Vue3 借助 `Promise.then` 的天然特性实现链式调用，而不再像 Vue2 那样显式维护一个 `callbacks` 数组并手动遍历。

**4.面试**

> Q:**为什么 Vue 的数据更新和 DOM 更新要是异步的？**
>
> A:为了性能优化。如果每次响应式数据修改都同步触发组件重新渲染和 patch，在一个大型组件中，如果在一个方法里连续修改 10 个数据，就会导致 10 次无意义的 DOM 比对和重排/重绘。通过异步队列合并更新，Vue 可以将这些操作合并到一次微任务中执行，极大提升了渲染性能。

## Vue Router原理

**一.定义**

> Vue3 的 Vue Router（v4 版本）相较于 Vue2（v3 版本），**底层全面拥抱 Composition API 与 Promise，在外层 API 上从“类构造函数”转变为“函数式编程”，废弃了通配符 `\*` 和 `next()` 回调，并在状态管理上深度融合了 Vue3 的响应式系统（`reactive`）**。

**二.Vue2与Vue3区别**

**1.初始化方式与模式定义**

Vue3 废弃了 `new VueRouter()` 的实例化方式，改用函数式创建，并将路由模式从字符串配置改为了具体的 history 对象。

```js
// Vue2 (v3)
const router = new VueRouter({
  mode: 'history', // 字符串 'history' 或 'hash'
  routes: [...]
})

// Vue3 (v4)
import { createRouter, createWebHistory, createWebHashHistory } from 'vue-router'
const router = createRouter({
  history: createWebHistory(), // 使用函数创建 history 实例
  routes: [...]
})
```

**2. 导航守卫：移除 `next()`，全面 Promise 化**

Vue3 的导航守卫不再强制依赖 `next()` 函数来控制流程，而是通过**返回值**（返回 `false`、路由地址或 Promise）来决定导航。这解决了 Vue2 中容易忘记调用 `next()` 导致路由卡死的痛点。

```js
// Vue2
router.beforeEach((to, from, next) => {
  if (!isLogin) next('/login')
  else next() // 必须调用
})

// Vue3
router.beforeEach((to, from) => {
  if (!isLogin) return '/login' // 直接 return，或者 return false
  // 返回 undefined 或 true 表示继续
})
```

**3. 动态路由匹配：移除通配符 `*`**

Vue2 支持使用 `*` 作为通配符兜底，Vue3 出于类型推导和路由优先级解析的性能考虑，**彻底移除了通配符 `\*`**，必须使用正则参数 `:pathMatch(.*)*` 来代替。

```js
// Vue2
{ path: '*', component: NotFound }

// Vue3
{ path: '/:pathMatch(.*)*', component: NotFound }
```

**4. 组件内获取路由**

Vue3 移除了 `this`，推崇在 `setup` 中使用 Composition API 获取路由。

```js
// Vue2
this.$router.push('/login')
this.$route.params.id

// Vue3
import { useRouter, useRoute } from 'vue-router'
const router = useRouter() // router 是路由实例，用于跳转
const route = useRoute()   // route 是响应式路由对象，用于获取参数
router.push('/login')
```

**5.底层原理差异**

> 1. 响应式系统对接不同：
>    - **Vue2**：Router 底层通过 `Vue.util.defineReactive` 劫持 `_route` 属性，通过在根组件的 `beforeCreate` 钩子中执行 `this._router.init(this)` 来挂载依赖。
>    - **Vue3**：Router 底层通过 `reactive` 包裹当前路由状态，并利用 Vue3 的依赖注入系统（`provide` / `inject`）将 `router` 和 `currentRoute` 暴露给全局。`<router-view>` 内部通过 `inject` 获取响应式的 `currentRoute`，当路由变化时触发组件重新渲染。
> 2. 路由匹配引擎升级：
>    - **Vue2**：底层依赖 `path-to-regexp` 库的旧版本，支持通配符但解析复杂。
>    - **Vue3**：升级了路由匹配算法，对路径的优先级和参数提取进行了更严格的类型检查和优化，更易于 Tree-shaking。

## Pinia(Vuex4)原理

**一.Vuex 3 与Vuex 4区别**

> 1. **响应式底层不同**：
>    - Vuex 3 基于 Vue2 的 `Object.defineProperty` 实现数据劫持，新增属性需用 `Vue.set`。
>    - Vuex 4 基于 Vue3 的 `Proxy` 实现，直接修改或新增 State 下的属性也能自动触发响应式更新，不再需要 `Vue.set`。
> 2. **安装与挂载方式不同**：
>    - Vuex 3 通过 `new Vue({ store })` 将 Store 绑定到根组件实例上。
>    - Vuex 4 改为通过 `app.use(store)` 结合 `provide/inject` 机制注入，更契合 Vue3 的组合式 API 生态。
> 3. **TS 支持与解构**：Vuex 4 增强了 TypeScript 的类型推导，但由于其本质依然是 `this` 指向的单一 Store 实例，直接解构 `State` 或 `Getters` 依然会**丢失响应式**，需使用 `computed` 包裹。

**二.Pinia 与Vuex 4区别**

**1.定义**

> Pinia 是 Vue 团队官方推荐的新一代状态管理库（Vue3 的默认首选）。与 Vuex 4 相比，Pinia **移除了 Mutations 概念，采用扁平化去中心化的 Store 架构，天生支持 TypeScript 和 Composition API，且在体积和心智负担上大幅减小**。

**2.核心区别**

> **1.架构设计：去中心化 vs 单一状态树**
>
> - **Vuex 4**：采用单一 Store 树，必须通过 `modules` 将状态分割成不同模块，且需要繁琐的 `namespaced: true` 来避免命名冲突。获取状态时需层层层级访问（如 `store.state.user.profile.name`）。
> - **Pinia**：没有模块嵌套概念，每个 Store 都是独立平行的实体。你可以定义任意多个独立的 Store，直接按需引入调用，天然实现了代码分割和 Tree-shaking。
>
> **2.核心概念：移除 Mutations**
>
> - **Vuex 4**：遵循严格的同步/异步分离设计。修改 State 必须通过 `Mutations`（同步），处理异步逻辑必须通过 `Actions`（异步）。
> - **Pinia**：**彻底废弃了 Mutations**。无论是同步还是异步操作，都直接在 `Actions` 中完成，并且可以直接在 Action 内部修改 State（无需 commit）。
>
> **3.TypeScript 支持**
>
> - **Vuex 4**：由于 Vue2 历史包袱和自身架构设计，Vuex 4 的 TS 类型推导非常繁琐，往往需要大量类型声明文件（如 `ModuleTree` 等），且 IDE 自动补全体验较差。
> - **Pinia**：从底层设计就完全基于 TS 编写，拥有完美的类型推导。开发者几乎不需要手写任何类型声明，Store 中的 State、Getters、Actions 都能获得精准的 IDE 提示。
>
> **4. API 风格：Options API vs Setup 函数**
>
> - **Vuex 4**：依然延续 Options 对象写法（`state: () => ({})`, `mutations: {}`, `actions: {}`）。
> - **Pinia**：除了支持 Options 风格，**核心推荐使用 Setup 函数风格**（类似组件的 `setup`）。你可以直接使用 `ref`、`computed` 来定义状态和计算属性，甚至可以在 Store 中直接使用其他 Vue3 Composition API（如 `watch`）。

```js
// ====== Vuex 4 写法 ======
const store = {
  state: () => ({ count: 0 }),
  mutations: { increment(state) { state.count++ } },
  actions: { asyncIncrement({ commit }) { setTimeout(() => commit('increment'), 1000) } }
}
// 组件中使用
this.$store.dispatch('asyncIncrement')
const count = computed(() => this.$store.state.count)

// ====== Pinia 写法 (Setup 风格) ======
export const useCounterStore = defineStore('counter', () => {
  const count = ref(0)
  function increment() { count.value++ }
  function asyncIncrement() { setTimeout(increment, 1000) }
  return { count, increment, asyncIncrement }
})
// 组件中使用
const counterStore = useCounterStore()
counterStore.asyncIncrement() // 直接解构调用也不会丢失响应式（见下方避坑）
```

**三.底层原理**

**1.定义**

> Pinia 的底层原理本质上是 **Vue3 响应式系统（`reactive`/`ref`/`computed`）+ 依赖注入（`provide`/`inject`）+ 延迟挂载（`effectScope`）** 的结合体。它通过 `defineStore` 闭包缓存配置，在组件首次调用 `useStore` 时才真正实例化 Store，并利用 `effectScope` 独立管理 Store 的响应式副作用，使其不受组件销毁的影响。

**2.核心原理**

Pinia 的核心源码非常精炼，主要分为两个阶段：**创建 Pinia 实例（全局注册）** 和 **定义/使用 Store（按需实例化）**。

1. 创建 Pinia 实例 (`createPinia`)

当执行 `createPinia()` 时，Pinia 会在内部创建一个全局的 Vue `effectScope`（副作用作用域）和一个用于缓存所有 Store 的 Map（`_s`）。

2. 定义 Store (`defineStore`)

`defineStore` 并不会立即执行传入的 Setup 函数或 Options，而是返回一个 `useStore` 钩子函数。它利用闭包缓存了 `id` 和 `setup` 函数。

3. 使用 Store (`useStore`) 的核心逻辑

当组件内部调用 `useStore()` 时，这是核心的**懒加载（按需实例化）**逻辑：

> 1. **依赖注入获取 Pinia**：通过 `inject('pinia')` 获取全局的 Pinia 实例。
> 2. **缓存检查**：检查 `pinia._s` 中是否已经存在当前 `id` 的 Store。如果存在，直接返回缓存（实现单例模式）。
> 3. 首次实例化：如果不存在，则进入创建流程：
>    - **Setup 模式**：将 Store 当作组件的 `setup` 函数，在 `pinia._e` (全局 effectScope) 中运行它，从而得到 `ref`、`computed` 和函数。这些响应式数据因为是在全局作用域中创建的，**不会随组件卸载而销毁**。
>    - **Options 模式**：如果传入的是对象，Pinia 会在内部将其转换为 Setup 函数（类似于 Vuex 的处理逻辑），再用 `reactive` 包装 `state`，用 `computed` 包装 `getters`。

**手写pinia**

```js
import { effectScope, reactive, inject } from 'vue'

// 1. 创建全局实例
function createPinia() {
  const scope = effectScope(true) 
  const state = scope.run(() => reactive({}))
  const pinia = {
    _s: new Map(), // 缓存 Store 实例的 Map: { key: store }
    _a: app,       // Vue 应用实例
    state,         // 全局响应式 state
    install(app) {
      app.provide('pinia', pinia) // 通过 provide 注入全局
      app.config.globalProperties.$pinia = pinia
    }
  }
  return pinia
}

// 2. 定义 Store
function defineStore(id, setup) {
  // 返回一个闭包函数，按需执行
  return function useStore() {
    const pinia = inject('pinia')
    
    // 单例缓存：有则直接取
    if (!pinia._s.has(id)) {
      // 首次调用时，在全局作用域中执行 setup
      const store = pinia._e.run(() => setup())
      pinia._s.set(id, store) // 存入缓存
    }
    return pinia._s.get(id)
  }
}
```

**四.关键机制**

> 1. 为什么 Pinia 不需要 `Mutation`？
>    - 在 Vuex 中，为了保证状态变更可追踪，强制走 `Mutation` 同步修改。
>    - 在 Pinia 中，State 本质上是通过 `reactive` 代理的对象。直接修改 `state.xxx = yyy`，Vue3 的 Proxy 拦截器会自动触发依赖更新。Pinia 内部集成了 `$patch` 方法，除了直接赋值，你可以通过 `$patch` 函数式修改，这同样会被 Vue DevTools 捕获，从而实现了无需 Mutation 的状态追踪。
> 2. `effectScope` 的作用（核心考点）：
>    - 如果在组件 A 的 `setup` 中直接写 `const count = ref(0)`，当组件 A 卸载时，`count` 的响应式依赖会被垃圾回收。
>    - Pinia 将 Store 的创建逻辑放在全局的 `effectScope` 中执行，相当于脱离了组件树的生命周期。因此，无论哪个组件首次触发 Store 创建，即使该组件销毁，Store 内部的 `computed` 和 `watch` 等副作用依然全局存活。
> 3. `storeToRefs` 的原理：
>    - 直接解构 Store（如 `const { count } = useStore()`）会丢失响应式。
>    - `storeToRefs` 内部遍历 Store 的属性，只对 `state` 和 `getters`（即 `ref` 和 `computed`）调用 `toRefs` 进行转换，而忽略 `actions`（普通函数），从而保证解构后仍具响应式。

**五.面试**

> Q:**解构响应式丢失问题?**
>
> A:在 Pinia 中，虽然直接解构 Store 实例的方法不会丢失上下文，但**直接解构 State 依然会丢失响应式**。必须使用 Pinia 专属 API `storeToRefs` 来解构 State 和 Getters（不能用 Vue3 的 `toRefs`，因为 `toRefs` 会把 Actions 也变成无意义的 ref 对象）。
>
> Q:**Pinia 为什么不需要像 Vuex 那样在严格模式下禁止直接修改 State？**
>
> A:因为 Pinia 的设计理念是简洁直观。在 Pinia 中，虽然你可以直接通过 `store.count++` 修改 State，但这并不会破坏状态追踪机制。Pinia 底层依然是基于 Vue3 的 `reactive` 或 `ref` 实现的，任何形式的修改都能被 DevTools 捕获到。它鼓励开发者将修改逻辑统一放在 Actions 中更多是为了**代码组织规范和复用**，而不是像 Vuex 那样出于**底层机制的强制约束**。
>
> Q:**Pinia 是如何实现 Store 之间的互相调用的？**
>
> A:因为所有 Store 实例最终都被缓存在 `pinia._s` 这个 Map 中。当 Store A 需要调用 Store B 时，Store A 只需要在自身的 `setup` 执行期间，直接调用 `useStoreB()`。由于 `useStoreB` 内部会去全局 `pinia._s` 中查找缓存，此时如果 B 还没创建会先创建 B，然后返回 B 的实例。由于它们都在同一个全局 `effectScope` 下，因此可以安全地互相访问和建立依赖。

## template 编译过程

**1.定义**

> Vue 3 的模板编译过程主要是指将 `template` 字符串转换为渲染函数 `render` 的过程。
> 这个过程主要分为三个核心阶段：**解析**、**转换** 和 **代码生成**。相比于 Vue 2，Vue 3 在编译阶段引入了更多的优化策略（如静态提升、Patch Flags 等），旨在提升运行时的性能。

**2.核心流程**

**第一步：解析 —— 将字符串转换为 AST（抽象语法树）**

> - **输入**：模板字符串（例如 `<div @click="onClick">{{ msg }}</div>`）。
> - 过程：编译器会利用正则表达式逐个字符地解析模板。
>   - 先进行**词法分析**，将字符串解析成一个个 Token（标签名、属性、文本等）。
>   - 再进行**语法分析**，根据 Token 之间的嵌套关系，构建出一棵 AST 树。
> - **产出**：包含节点类型、标签名、属性、指令、父子关系等信息的纯 JavaScript 对象树（AST）。

**第二步：转换 —— 优化并转换 AST**

编译器会遍历 AST，对节点进行修改和标记。

> - **指令转换**：将 `v-if`、`v-for`、`v-model` 等指令转换为对应的逻辑描述对象或渲染函数调用。
> - **语法糖转换**：例如将 `v-model` 展开为 `v-bind` 和 `v-on` 的组合。
> - 关键优化点（核心）：
>   - **静态提升**：识别出永远不会变化的静态节点或静态属性，将它们提升到渲染函数之外，避免每次重新渲染时重复创建。
>   - **Patch Flags（补丁标记）**：给动态节点打上标记（如 `TEXT`、`CLASS`、`STYLE`、`PROPS` 等）。运行时 Diff 算法会根据这些标记只比对更新动态的部分，跳过静态内容。
>   - **Block Tree（块树）**：将模板切分成一个个“块”，每个 Block 收集其内部的所有动态节点。运行时只需遍历 Block 中的动态节点，无需遍历整个树。

**第三步：代码生成 —— 生成可执行的渲染函数代码**

> - **输入**：转换并优化后的 AST。
> - **过程**：递归遍历 AST，将其拼接成字符串形式的 JavaScript 代码。
> - 产出：一个字符串形式的render函数体。
>   - 例如：`return _createElementVNode("div", { onClick: onClick }, _toDisplayString(msg), 1 /* TEXT */)`。
>   - 最终通过 `new Function` 生成真正的渲染函数。

**3.Vue2与Vue3区别**

> - **Vue 2**：编译出的代码在渲染时，每次都要重新生成整个 VNode 树，Diff 算法需要同层遍历所有节点进行比对，无法精准跳过静态节点。
> - **Vue 3**：编译时生成的代码包含了“优化信息”。
>   - 通过 **Patch Flags**，Diff 时不仅知道哪里变了，还知道是*怎么*变的（是文本变了还是类名变了）。
>   - 通过 **Block Tree**，Diff 算法不需要遍历整棵树，只需要遍历动态节点组成的数组，极大地减少了 Diff 的时间复杂度。

**4.面试**

> Q：**静态提升**具体提升了什么？
>
> A：避免重复创建对象/数组的内存开销，减少 GC 压力
>
> Q：**Patch Flags** 有哪些常见的值？
>
> A：TEXT=1, CLASS=2, STYLE=4, PROPS=8, FULL_PROPS=16 等
>
> Q：**Block Tree** 是怎么解决 `v-if` 导致的动态节点索引错位的？
>
> A：通过 Fragment 和 Block 嵌套，Block 收集的是动态节点本身而非索引，且 Block 会自动调整结构

## Diff算法

**1.定义**

> Vue 3 的 Diff 算法通过 **“首尾同步 + 最长递增子序列”** 的组合拳，配合编译时的 Block Tree 和 Patch Flags，实现了极致的性能优化。

**2.核心流程**

Diff 算法的本质是对比新旧两组子节点（`c1` 和 `c2`），找出差异并更新 DOM。Vue 3 的 `patchKeyedChildren` 函数主要包含以下步骤：

**第一步：同步头部节点**

> - 从新旧两组子节点的头部开始比较。
> - 如果节点相同（key 和 type 都相同），则进行 `patch` 更新，指针向后移动。
> - 直到遇到不相同的节点为止。
> - 目的：处理前置节点不变的情况。

**第二步：同步尾部节点**

> - 从新旧两组子节点的尾部开始比较。
> - 如果节点相同，则进行 `patch` 更新，指针向前移动。
> - 直到遇到不相同的节点为止。
> - 目的：处理后置节点不变的情况。

**第三步：判断是否需要挂载或卸载**

> - **挂载新节点**：如果旧节点已经遍历完，但新节点还有剩余，说明剩余的都是新增节点，直接挂载。
> - **卸载旧节点**：如果新节点已经遍历完，但旧节点还有剩余，说明剩余的都是删除节点，直接卸载。

**第四步：处理未知序列（核心难点）**

如果上述步骤完成后，新旧节点都还有剩余（说明发生了乱序、移动或新增/删除），则进入最复杂的处理逻辑：

> 1. **构建 Source 表**：遍历新节点剩余部分，建立一个 `keyToNewIndexMap`（Key 到新索引的映射表）。同时初始化一个 `newIndexToOldIndexMap`（用于记录新节点在旧节点中的位置，如果不存在则记为 0）。
> 2. **更新与移除**：遍历旧节点剩余部分：
>    - 通过 Map 查找旧节点是否在新节点中存在。
>    - **不存在**：说明该节点被删除了，执行 `unmount`。
>    - **存在**：执行 `patch` 更新，并更新 `newIndexToOldIndexMap` 中对应位置的值为“旧索引 + 1”（用 +1 是为了区分 0 表示不存在的情况）。
> 3. **移动节点**（最长递增子序列 LIS）：
>    - 此时我们已经知道新节点顺序，以及它们对应的旧节点索引。
>    - 我们需要计算**最长递增子序列（LIS）**。这个序列中的节点在旧数组中的相对顺序是正确的，**不需要移动**。
>    - 剩下不在 LIS 中的节点，就是需要移动的节点。
>    - 遍历新节点，如果不在 LIS 中，则将其移动到正确的位置。

**3.Vue2与Vue3区别**

**Vue 2（双端 Diff）**

> - 使用 4 个指针。
> - 每次比较都要做 4 种假设（头对头、尾对尾、头对尾、尾对头）。
> - 如果以上都不满足，则会拿旧节点的 key 去新节点的 Map 中找，找到后移动节点。
> - **缺点**：逻辑分支较多，且对于复杂的长列表移动，处理方式相对机械。

**Vue 3（LIS Diff）**

> - 先做简单的同步（头头、尾尾），把能确定的先处理掉。
> - 对于乱序部分，利用 **最长递增子序列算法** 求解。
> - 优点：
>   - **算法更优**：LIS 算法保证了需要移动的节点数量最少，减少了 DOM 操作。
>   - **逻辑更清晰**：去掉了双端比较的头尾交叉判断，逻辑更加直观。
>   - **配合编译优化**：Vue 3 的 Diff 是基于 Block Tree 的，只收集动态节点，不需要遍历整个静态树，进一步降低了 Diff 的复杂度。

**4.面试**

> Q：**最长递增子序列 (LIS)？**
>
> A：这是 Vue 3 Diff 的灵魂。它的数学意义是在一个序列中，找到一个子序列，使其数值递增且长度最长。在 Diff 中，LIS 代表了“不需要移动的节点集合”。Vue 3 会以 LIS 为基准，将其他节点移动到合适的位置，从而保证 DOM 移动次数最少。
>
> Q：**最长递增子序列的时间复杂度是多少？**
>
> A：使用贪心算法 + 二分查找实现，时间复杂度是 O(n log n)
>
> Q：**为什么 `source` 数组初始化为 0，且匹配后要 `+1`？**
>
> A：因为 0 被用作占位符，表示“该新节点在旧节点中不存在（是新增的）”。所以存储旧节点索引时需要 `+1`，以便区分索引为 0 的旧节点和不存在的情况。
>
> Q：**PatchFlag (编译时优化)**
>
> A：虽然 Diff 算法本身很强大，但 Vue 3 通过编译时的 `PatchFlag` 标记，在更新时可以跳过静态节点，直接靶向定位动态节点，大大减少了进入 Diff 流程的节点数量。

## Vue3性能优化

> - 代码层面
> - 基础框架层
> - 打包层面

**代码层面**

> - **v-if 与 v-show**：原则不变。频繁切换用 `v-show`（CSS 切换），条件很少改变用 `v-if`（惰性加载）。
> - **优先级反转**。`v-if` 优先级高于 `v-for`，虽然解决了 Vue 2 的性能陷阱，但解构写法更推荐，依然建议在计算属性中过滤数据以减少模板复杂度。
> - **Key 的使用**：依然必须使用唯一的 `key`，且避免使用 `index`，以保证 Diff 算法的准确性。
> - **Computed 缓存**：依然优先使用 `computed`，利用其缓存特性（依赖不变不重算）。
> - **Watch 优化**：Vue 3 中使用 `watch` 或 `watchEffect` 时，可通过配置 `{ flush: 'post' }` 避免在组件更新前触发，或使用 `immediate: true` 替代 Vue 2 中的 `created` 初始化逻辑。
> - **Proxy 惰性代理**：Vue 3 的 Proxy 是惰性的，只有访问到深层对象才代理，本身性能就优于 Vue 2。
> - **shallowRef / shallowReactive**：Vue 3 官方 API。对于只关心顶层变化的深层大对象，使用浅层响应式，完全跳过深层 Proxy 代理，性能提升显著。
> - **markRaw**：标记对象永远不转为响应式，适合存静态配置数据。
> - **自动清理**：在 `setup` 语法糖中，`watch`、`computed` 以及生命周期钩子会随组件卸载自动停止，无需手动清理（极大减少了内存泄漏风险）。
> - **Effect 清理**：在 `watchEffect` 的回调函数中返回一个清理函数，非常优雅地处理副作用（如取消请求）。
> - **v-memo（新利器）**：Vue 3 新增 `v-memo` 指令。它可以记忆子树的渲染结果，只有当指定依赖项变化时才重新渲染。这在长列表或复杂静态区块优化上，比 Vue 2 的函数式组件更强大。

**基础框架层**

> - **路由懒加载**：Vue 3 配合 Vue Router 4 使用方式一致，但 `defineAsyncComponent` 提供了更强大的异步组件控制能力。
> - **Vue 3 增强**：配合 `<keep-alive>` 使用 `<transition>` 更加流畅，且 `onActivated` 和 `onDeactivated` 钩子在 Composition API 中使用更便捷。
> - **结合 v-memo**：在 Vue 3 中，如果不使用库，简单的列表可通过 `v-memo` 实现类似“手动虚拟滚动”的跳过渲染效果。
> - **Nuxt 3**：Vue 3 配合 Nuxt 3 实现了更快的冷启动和混合渲染模式，首屏性能更优。

**打包层面**

> - **Vue 3 优势**：源码基于 ES Module 重写，**天然支持 Tree-shaking**。未使用的 API（如 `nextTick`, `keepAlive`）会在打包时自动移除，无需额外配置，体积减少约 40%。
> - **开发环境**：Vue 3 推荐使用 **Vite**。利用浏览器原生 ESM，启动速度比 Webpack 快数十倍，不再需要漫长的打包等待。
> - **生产环境**：Vite 使用 Rollup 打包，配置更简洁，Chunk 分割更智能。
> - **Vue 3 新写法**：可以使用 `v-lazy` 指令库，或者利用 `IntersectionObserver` 封装自定义指令，Composition API 封装指令逻辑更清晰。
> - 确保关闭 `devtools`、关闭控制台警告（`devtools: false`）。
> - 开启 Gzip/Brotli 压缩。
> - 使用 CDN 加速核心库（Vue, Pinia, Router），利用浏览器缓存。

## Hooks

### Hooks实战

- 方式一：export default导出单一函数，导入参数，导出函数和出参
- 方式二：参考大崔哥的新写法(同一vue和js文件共享数据)--推荐
- 方式三：返璞归真，结合1和2，进化到hooks本质--强强强推荐

**方式一：export default导出单一函数，导入参数，导出函数和出参**

App.vue

```js
<template>
   <p>{{ num1 }}</p>
   <p>{{ num2 }}</p>
   <p>{{ addNum }}</p>
</template>
<script lang="ts" setup>
const num1 = ref(2)
const num2 = ref(1)
// 方式一
import {useAdd} from './useAdd.ts'     //引入自动hook 
const { addNum, addFn } = useAdd({ num1, num2 })
addFn(num1.value, num2.value)
</script>
```

@/service/useAdd.ts

```
import { ref, watch } from 'vue';
export const useAdd= ({ num1, num2 })  =>{
 // 入参数
    const addNum = ref(0)
     watch([num1, num2], ([num1, num2]) => {
        addFn(num1, num2)
    })
    const addFn = (num1, num2) => {
        addNum.value = num1 + num2
    }
    return {
     // 出参
        addNum,
        // 出函数
        addFn
    }
}
```

**方式二：参考大崔哥的新写法(同一vue和js文件共享数据)--推荐**

- Flow.vue--渲染页面(引入index.ts)

- index.ts-总入口

- tabs.ts--顶部tab业务

- cardBLine.ts--卡片业务

- dialog.ts--弹窗业务

  @/view/Flow.vue--渲染页面

```
import { initAll, diaConfirm } from '@/services/reviewFlow';

const tabs = reactive([]);
const tab = ref();
const cardBLine = ref({});
const dia = ref({});
initAll({ tabs, tab, cardBLine, dia });
```

@/services/index.ts-总入口

```
import { initTabs } from './tabs';
import { initCardBLine } from './cardBLine';
export { initDialog, diaConfirm } from './dialog';

export function initAll(params) {
  initTabs(params.tabs, params.tab);
}
```

@/services/tabs.ts--顶部tab业务

```
import * as myApi from '@/services/myApi';

// 分解的产品线
let tabs = [];
let tab = {};

export async function initTabs(tabsReactive, tabRef) {
  declareTag(tabsReactive, tabRef);
  await loadTabs();
  loadTab();
}
function declareTag(tabsReactive, tabRef) {
  // 1.初始化-变量
  tabs = tabsReactive;
  tab = tabRef;
}

async function loadTabs() {
  // 载入tabs
  tabs.length = 0;
  const res = [];
  res.forEach((r) => {
    tabs.push(createTab(r));
  });
}

```

**方式三：返璞归真，结合1和2，进化到hooks本质--强强强推荐**

@/view/Flow.vue--渲染页面

```
<script setup>
import { userFlow } from '@/services/userFlow';
const {tabs,tab,cardBLine,dia,diaConfirm} = userFlow()
</script>

<template>
<Tab v-model:tab="tab" :tabs="tabs"></Tab>
<CardBaseLine v-model:card="cardBLine"></CardBaseLine>
<VDialog v-model:dVis="dia.dVis" v-bind="dia" @oprate="diaConfirm(dia)">
      <div>
        <span>转给</span>
        <VUser v-model:user="dia.dCont"></VUser>
      </div>
    </VDialog>
<template>
```

@/services/userFlow.ts-总入口

```
import { useTabs } from './useTabs';
import { useCardBLine } from './useCardBLine';
export { userDialog } from './userDialog';

export async function userFlow() {
 const {tabs,tab} =await useTabs();
 const {cardBLine} =await useCardBLine();
 const {dia,diaConfirm} =await userDialog();
  return {tabs,tab,cardBLine,dia,diaConfirm}
}
```

@/services/useTabs.ts--顶部tab业务

```
import * as myApi from '@/services/myApi';

// 分解的产品线
let tabs = reactive([]);
let tab = ref();

export async function  useTabs() {
  async function initTabs(){
   watchOnce(
    () => tab.value,
    (value) => {
      // 其他操作
    },
  )
    await loadTabs();
   loadTab();
  }
  async function loadTabs() {
  // 载入tabs
  tabs.length = 0;
  const res = [];
  res.forEach((r) => {
    tabs.push(createTab(r));
  });
}

function createTab(item) {
  // 创建tab
  const result = {
    label: item.pbiNameCn,
    value: item.pbiId,
    product: getProduct(item.pbiId), // 有联动查询
    ...item,
  };
  return result;
}

async function getProduct(id) {
  const res = await myApi.baseLine_querBaseLine();
  return res;
}

function loadTab() {
  // 载入
  const i = tabs.findIndex((t) => t.showFlag === '1');
  // showFlag 0是查看，1是编辑
  tab.value = tabs[i === -1 ? 0 : i];
}

  initTabs()
  return {
   tabs,tab
  }
}
```

@/services/useCardBLine.ts--卡片业务

```
import * as myApi from '@/services/myApi';

// 基线对标卡片
let cardBLine = ref();

export async function useCardBLine() {
  async function initCardBLine(){
     await loadCardBLine();
     setCardBLine();
  }
  function loadCardBLine() {
  // 2.载入
  const cbData = { a: 1, b: 2 };
  cardBLine.value = createCardBaseLine(cbData);
}

 function createCardBaseLine(cbData) {
  return {
    prop: 'baseLine',
    label: cbData.a,
    data: cbData.b,
  };
}
 function setCardBLine(result?) {
  // 设值基线对标
  let p0 = result ? result.benchmarkStatus : '';
  setValue(cardBLine.value, 'mark', p0);
  // 未接纳
  if (p0 === 'DIC_MARK_STATUS_003') {
    const markI = cardBLine.value.findIndex((d) => d.prop === 'mark');
    cardBLine.value.splice(markI + 2, 1);
  }
}

 function setValue(prop, val) {
  // 正常设值
  const c1 = cardBLine.value.find((c) => c.prop === prop);
  if (!c1) {
    return;
  }
  c1.value = val;
}
function saveCardBLine() {
  // 保存数据
  const param = collectCardBLine();
  myApi.baseLine_saveBaseLine(param);
}

function collectCardBLine() {
  // 收集数据
  const benchmarkStatus = findValue(cardBLine, 'mark');
  return {
    benchmarkStatus,
  };
}

 function findValue(card, prop) {
  // 正常获取
  return cardBLine.value.data.find((c) => c.prop === prop)?.value;
}

 async function btnToOtherHandle(cb = cardBLine.value) {
  // 可以自己调用，或第三方调用
  await myApi.flow_transfer(cb);
}

  initCardBLine()
  return {cardBLine,btnToOtherHandle}
}
```

@/services/userDialog.ts--弹窗业务

```
// 弹窗信息
let dia = ref();

export async function userDialog() {
  function initDialog(){
     loadDia();
  }
  function loadDia() {
  // 2.载入
  dia.value = createDia('transfer');
}

function createDia(type) {
  const t = {
    transfer: {
      dVis: false,
      dType: 'transfer',
      dTitle: '转他人审批',
      dClass: 'transfer',
      dCont: {
        val: '',
      },
    },
  };
  return t[type];
}

 async function btnToOther() {
  // 转给他人审批
  dia.value.dVis = true;
}

 async function diaConfirm(cardBLine) {
  // 弹窗确认
  const { dType } = dia.value;
  if (dType === 'transfer') {
    dia.value.dVis = false;
  }
}
  
  initDialog()
  return {dia,diaConfirm}
}
```

### **什么是Hooks**

Hooks并不是VUE特有的概念，实际上它原本被用于指代一些特定时间点会触发的勾子。而在React16之后，它被赋予了新的意义：

> 一系列以 `use` 作为开头的方法，它们提供了让你可以完全避开 `class式写法`，在函数式组件中完成生命周期、状态管理、逻辑复用等几乎全部组件开发工作的能力
>
> ```
> Hooks最核心的价值来自于内部的状态管理
> ```

在VUE3中，`Hooks`的概念结合了VUE的响应式系统，被称为`组合函数`。组合函数是VUE3组合式API中提供的新的逻辑复用的方案，是一类利用 Vue 的组合式 API 来封装和复用有状态逻辑的函数。

### Hook规则

**React官方规范**

> Hook 本质就是 JavaScript 函数，但是在使用它时需要遵循两条规则。我们提供了一个 [linter 插件](https://www.npmjs.com/package/eslint-plugin-react-hooks)来强制执行这些规则
>
> - **只在最顶层使用 Hook**
>
>   **不要在循环，条件或嵌套函数中调用 Hook，** 确保总是在你的 React 函数的最顶层以及任何 return 之前调用他们。遵守这条规则，你就能确保 Hook 在每一次渲染中都按照同样的顺序被调用。这让 React 能够在多次的 `useState` 和 `useEffect` 调用之间保持 hook 状态的正确。
>
> - **只在 React 函数中调用 Hook**
>
>   **不要在普通的 JavaScript 函数中调用 Hook。**你可以：
>
>   - ✅ 在 React 的函数组件中调用 Hook
>   - ✅ 在自定义 Hook 中调用其他 Hook

**其他规范**

> - 通常来讲，一个Hook的命名需要以use开头，比如useTimeOut，这是约定俗成的，开发者看到useXXX即可明白这是一个Hook。Hook的名称需要清楚地表明其功能。
> - 函数必须是纯函数，没有副作用
> - 返回值是一个函数或数据，供外部使用
> - Hook内部可以使用其他的Hook，组合功能
> - 数据必须依赖于输入，不依赖于外部状态，保持数据流的明确性
> - 在Hook内部处理错误，不要把错误抛出到外部，否则会增加hook的使用成本
> - Hook是单一功能的，不要给一个Hook设计过多功能。单个Hook只负责做一件事，复杂的功能可以使用多个Hook互相组合实现，如果给单个Hook增加过多功能，又会陷入过于臃肿、使用成本高、难维护的问题中

### **Hooks与composition Api**

Hooks是一种`基于闭包`的函数式编程思维产物，所以通常我们会在`函数式风格`的框架或组件中使用Hook，比如VUE的组合式API(Composition Api)。Hooks在VUE2所使用的`选项式风格API`中也不是不可以使用，毕竟Hook本质只是一个函数，只要hook内部所使用的api能够得到支持，我们可以在任何地方使用它们，只是可能需要额外的支持以及效果没有函数式组件中那么好，因为仍会被选项分割。

### 为什么要使用Hook

Mixin/Class的局限性：

- **不清晰的数据来源**：当使用了多个mixin/class时，哪个数据是哪个模块提供的将变得难以追寻，这将提高维护难度
- **命名空间冲突**：来自多个class/mixin的开发者可能会注册同样的属性名，造成冲突
- **隐性的跨模块交流**：不同的mixin/class之间可能存在某种相互作用，产生未知的后果

其实Mixin/Class的缺点反过来就是**Hooks的优点**：

- 清晰一目了然的源头：Hooks不是一个类，没有将状态、方法存放在对象中，然后通过导出对象的形式实现复用，也就不会有对象间过度`耦合`、`干扰`等问题。Hooks中的各类状态是封装在内部的，与外界隔离，仅暴露部分函数、变量，这使得其来源、功能`清晰可辨`且`不易被干扰`
- 没有命名冲突的问题：Hooks本质是闭包函数，内部所导出的变量、方法支持重命名，因而同一个Hook在同一个组件中可以N次使用而不冲突
- 精简逻辑：一个Hook开发完成后，在使用Hook时不需要关心其内部逻辑，只需知道有什么效果、如何使用即可，专注于其他核心业务逻辑，可以节省大量重复代码
