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

![](/img/vue3生命周期.png)

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

## Vue2与Vue3

在**源码架构、性能优化、API 语法**等方面进行了优化。

**一、源码架构**

> 1. **语言重构与类型支持**：
>    - **Vue 2**：源码主要使用 **ES5** 编写，初期使用 Flow 进行类型检查。随着项目变大，Flow 的维护变得困难，且类型推断不够健壮。
>    - **Vue 3**：源码全面使用 **TypeScript** 重写。这使得代码结构更清晰，类型定义更严谨，极大地降低了维护成本，并提升了开发体验。
> 2. **代码组织架构**：
>    - **Vue 2**：源码是**整体化**的，所有的逻辑（编译器、运行时、服务端渲染等）都耦合在同一个仓库中。
>    - **Vue 3**：采用了 **Monorepo（单体仓库）** 架构，将不同的功能模块拆分到不同的包中（如 `@vue/reactivity`、`@vue/runtime-core`）。这使得模块之间依赖更明确，也方便了 Tree-shaking（按需引入）。
> 3. **响应式系统重写**：
>    - **Vue 2**：使用 `Object.defineProperty` 进行数据劫持。
>    - **Vue 3**：使用 ES6 的 `Proxy` 代理对象重写了响应式系统。（这点在性能部分详细展开）。

**二、性能优化**

> 1. **响应式原理的优化**：
>    - Vue 2：
>      - 使用 `Object.defineProperty`，存在局限性：无法监听对象属性的新增/删除，无法监听数组下标和长度的变化（需要通过 `$set` 解决）。
>      - 初始化时需要递归遍历 `data` 中的所有属性，对象层级越深，性能消耗越大。
>    - Vue 3：
>      - 使用 `Proxy`，可以监听对象的任何属性操作（包括新增、删除、数组索引变化），无需 `$set`。
>      - 采用**惰性代理**：只有当属性被访问时，才会递归代理子对象，这大大提升了初始化速度，尤其对于大型数据结构性能提升明显。
> 2. **虚拟 DOM 与 编译优化**：
>    - **Vue 2**：在数据变化时，通过全量 Diff 算法对比新旧 VNode 树。即使部分内容是静态的，也会参与 Diff 过程。
>    - Vue 3：引入了Patch Flags（补丁标记）和静态树提升。
>      - 编译器在编译模板时，会标记动态节点，Diff 时只对比带有标记的动态节点。
>      - 静态节点会被提升到渲染函数之外，避免重复创建，从而大幅减少了内存占用和 Diff 时间。
> 3. **打包体积**：
>    - Vue 3 通过 Tree-shaking 支持，将许多全局 API（如 `v-model`、`transition`）变为按需引入，使得打包后的核心体积比 Vue 2 更小。

**三、API 语法**

> 1. **组件逻辑复用**：
>    - **Vue 2**：主要使用 **Options API**（data, methods, mounted 等）。缺点是逻辑分散，导致复杂的组件难以维护；逻辑复用主要依靠 Mixins，容易产生命名冲突和数据来源不清晰的问题。
>    - **Vue 3**：引入了 **Composition API (组合式 API)**，使用 `setup` 语法糖。可以将相关的业务逻辑聚合在一起，方便复用（通过自定义 Hooks），逻辑清晰，且更好的 TypeScript 推断。
> 2. **双向绑定原理**：
>    - **Vue 2**：`v-model` 本质上是 `:value` 和 `@input` 的语法糖（即单向数据流 + 事件监听）。
>    - **Vue 3**：`v-model` 变成了 `:modelValue` 和 `@update:modelValue` 的语法糖，并且支持在一个组件上绑定多个 `v-model`，还允许自定义修饰符。
> 3. **生命周期变化**：
>    - Vue 3 将 `beforeDestroy` 和 `destroyed` 重命名为 `beforeUnmount` 和 `unmounted`，以更好地与生命周期语义对齐。
>    - 在 Composition API 中，生命周期钩子前面通常加上 `on`（如 `onMounted`），且 `setup` 相当于 `beforeCreate` 和 `created` 的集合。
> 4. **其他语法特性**：
>    - **Fragments (多根节点)**：Vue 3 组件模板可以支持多个根节点，不再需要外层包裹一个 `div`。
>    - **Teleport (传送门)**：允许将组件的一部分 DOM 挂载到其他节点（如 `body`）下，常用于模态框开发。
>    - **Suspense**：允许在等待异步组件时渲染后备内容。

**其他差异**

> 1. **TypeScript 支持**：Vue 3 对 TS 支持是原生级别的，API 设计之初就考虑了类型推断。
> 2. **自定义渲染器**：Vue 3 暴露了更底层的渲染 API，使得开发跨平台应用（如渲染到 Canvas、WebGL）更加容易。

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

# 源码

**参考**

> - [尤雨溪国外教程：亲手带你写个简易版的Vue](https://www.vue-js.com/topic/611b1ba4120d99003158db6f)

## Vue源码调试

**1.下载源码**

源码地址：https://github.com/vuejs/core

**2.安装依赖**

前提：安装node>16和pnpm>7。

> 依赖安装，最好移除*puppeteer*依赖，下载很慢
>
> pnpm install

**3.添加打包源码**

注意最新版本的dev.js默认已开启源码调试，所以无需额外参数

> *"dev"*: "node scripts/dev.js --sourcemap",

**4.调试源码**

> 在目录下可以断点调试debugger，如\core-main\packages\runtime-dom\src\index.ts。
>
> 执行pnpm run dev,使用Live Server开始源码调试

**注意事项**

> 1.移除tsconfig.json中的puppeteer，否则提交代码报错
>
> 2.移除package.json中simple-git-hooks和lint-staged的校验，否则提交代码报错
>
> 3.注释eslint.config.js中*no-console*，否则提交代码报错

```
<!DOCTYPE html>
<html>
  <head>
    <style>
      #demo {
        font-family: 'Helvetica', Arial, sans-serif;
        text-align: center;
      }
    </style>
    <script src="./packages/vue/dist/vue.global.js"></script>
  </head>
  <body>
    <div id="demo">
      <button @click="num++">Object类型自增加：{{num}}</button>
      <button @click="add">Array类型自增加：{{arr}}</button>
    </div>
    <script>
      Vue.createApp({
        data: () => ({
          num: 0,
          arr: [1, 2, 3]
        }),
        methods: {
          add() {
            this.arr.push(this.arr[this.arr.length - 1] + 1)
            // this.$set(this.arr, 0, this.arr[0] + 1);
          }
        }
      }).mount('#demo')
    </script>
  </body>
</html>
```

也可以使用 源码内部自带的调试案例

> 启动服务
> npm run dev
> 打开链接
> http://localhost:5000/packages/vue/examples/composition/todomvc
> 打断点



## Vue源码目录

```
// 目录结构分析
├── .github              // github 工作流，issue 模版，代码贡献指南
├── .vscode              // vscode 编辑器的配置
├── packages             // vue 源码核心包，使用 pnpm workspace 工作区管理
│   ├── compiler-core    // 编译器（平台无关），例如基础的 baseCompile 编译模版文件, baseParse生成AST
│   ├── compiler-dom     // 基于compiler-core，专为浏览器的编译模块，可以看到它基于baseCompile，baseParse，重写了complie、parse
│   ├── compiler-sfc     // 编译vue单文件组件
│   ├── compiler-ssr     // 服务端渲染编译
│   ├── reactivity       // vue独立的响应式模块，可以与任何框架配合,使用proxy
│   ├── reactivity-transform  // 响应式实验功能，目前仅用于测试
│   ├── runtime-core     // 与平台无关的运行时。有虚拟DOM渲染器，vue组件和各种API。可针对某个具体平台实现高阶runtime，比如自定义渲染器
│   ├── runtime-dom      // 针对浏览器的runtime。包含处理原生DOM API 
│   ├── runtime-test     // 一个专门为了测试而写的轻量级 runtime。由于这个 rumtime 「渲染」出的 DOM 树其实是一个 JS 对象，所以这个 runtime 可以用在所有 JS 环境里。你可以用它来测试渲染是否正确。
│   ├── server-renderer     // 服务端渲染
│   ├── sfc-playground
│   ├── shared             // 内部工具库,不暴露API
│   ├── size-check          // 简单应用，用来测试代码体积
│   ├── template-explorer  // 用于调试编译器输出的开发工具
│   └── vue                 // 面向公众的完整版本, 包含运行时和编译器
│   └── vue-compat          // 用于兼容 vue2
│   ├── global.d.ts      // 声明文件
├── scripts              // vue3脚本文件，包含配置文件，进行编译和打包等
│   ├── bootstrap.js
│   ├── build.js
│   ├── checkYarn.js
│   ├── dev.js
│   ├── release.js
│   ├── setupJestEnv.ts
│   ├── utils.js
│   └── verifyCommit.js
├── test-dts             // 测试文件
│   ├── README.md
│   ├── component.test-d.ts
│   ├── componentTypeExtensions.test-d.tsx
│   ├── defineComponent.test-d.tsx
│   ├── functionalComponent.test-d.tsx
│   ├── h.test-d.ts
│   ├── index.d.ts
│   ├── inject.test-d.ts
│   ├── reactivity.test-d.ts
│   ├── ref.test-d.ts
│   ├── setupHelpers.test-d.ts
│   ├── tsconfig.build.json
│   ├── tsconfig.json
│   ├── tsx.test-d.tsx
│   └── watch.test-d.ts
├── CHANGELOG.md    // 多个版本提交记录、时间和内容
├── LICENSE         // MIT协议是所有开源许可中最宽松的一个，除了必须包含许可声明外，再无任何限制。
├── README.md       // 项目说明
├── api-extractor.json   // 这是所有包的共享基本配置文件
├── jest.config.js       // 测试配置文件
├── package.json         // 项目依赖
├── rollup.config.js     // rollup打包配置文件
├── tsconfig.json        // 定了用来编译这个项目的根文件和编译选项
├── pnpm-lock.yaml       // 锁定依赖版本
└── pnpm-workspace.yaml  // pnpm 工作区
```

**Vue3可构建的版本**

```
// 常见的2个版本
vue.global.js：是包含编译器和运行时的“完整”构建版本，因此它支持动态编译模板。
vue.runtime.global.js：只包含运行时，并且需要在构建步骤期间预编译模板。

// cjs（用于服务端渲染）
vue.cjs.js
vue.cjs.prod.js（生产版，代码进行了压缩）

// global（用于浏览器<script src="" />标签导入，导入之后会增加一个全局的Vue对象）
vue.global.js
vue.global.prod.js（生产版，代码进行了压缩）
vue.runtime.global.js
vue.runtime.global.prod.js（生产版，代码进行了压缩）

// browser（用于支持ES6 Modules浏览器<script type="module" src=""/>标签导入）
vue.esm-browser.js
vue.esm-browser.prod.js（生产版，代码进行了压缩）
vue.runtime.esm-browser.js
vue.runtime.esm-browser.prod.js（生产版，代码进行了压缩）

// bundler（这两个版本没有打包所有的代码，只会打包使用的代码，需要配合打包工具来使用，会让Vue体积更小）
vue.esm-bundler.js
bue.runtime.esm-bundler.js
```

## Vue源码深度解析

**参考**

> - [催学社-Vue3 源码实战课-video](https://www.1024zyz.com/4724.html)
> - [Vue.js 3.0 核心源码-黄轶-video](https://www.1024zyz.com/3771.html)
> - [Vue3源码解析，打造自己的Vue3框架-video](https://www.1024zyz.com/5016.html)
> - [珠峰公开课-vue3源码视频-video](https://www.bilibili.com/video/BV1WP4y1u7qi/?spm_id_from=333.999.0.0&vd_source=bd4c7d99d71adf64d6e88c65370e0247)
> - [vue3生态](https://github.com/vue3/vue3-News/tree/master)
> - [vue 源码汇总](https://github.com/vue3/vue3-News/issues/16?content_source_url=https://github.com/vue3/vue3-News)
> - [vue源码分析结构参考](https://juejin.cn/post/6844904181094957069)
> - [vue 3 源码设计方案](https://juejin.cn/column/7142426144204128269)
> - 《Vue.js 设计与实现》-从高层的设计角度，探讨框架需要关注的问题
> - 《vue.js 技术内幕》，作者黄轶-标准的 “源码分析” 书籍

**Vue核心四大模块**

- 生命周期过程
- 变化监测原理
- 模板编译原理
- 虚拟DOM原理

## mini-vue-大催哥

**参考**

- [个人vue3源码分析仓库](https://github.com/fuyunjinglong/web-sourceCode-vue3)
- [简单版mini-vue](https://www.bilibili.com/video/BV1Rt4y1B7sC/?spm_id_from=333.337.search-card.all.click&vd_source=bd4c7d99d71adf64d6e88c65370e0247)

### Vue3核心模块

![image](/img/2025-04-03_06-48-27.png)

> - compiler编译期
>   - compiler-sfc：主要把vue单文件组件编译为js文件，其中底层依赖调用了compiler-dom和compiler-core
>     - compiler-dom：主要把template代码片段转换为render函数
>     - compiler-core：dom转换render函数时用到的核心函数
> - runtime运行时
>   - runtime-dom：运行时dom。源码中vue/src/index.js实际是全量导出runtime-dom。源码中runtime-dom/src/index.js实际是全量导出runtime-core，所以又依赖runtime-core
>   - runtime-core：运行时核心函数。源码中runtime-core/src/index.js实际是大量导出reactivity，所以又依赖reactivity
>   - reactivity：运行时响应式系统。

## Vue.js 设计与实现-笔记

### 大纲

《Vue.js 设计与实现》的内容一共分为 6 篇， `18` 个章节：

- 首先第一篇：对 `vue` 的整个框架设计，进行了概述
- 第二篇：主要讲解了 `vue` 中的响应式系统，除了大家所熟悉的 `proxy` 之外，额外还包含了：调度系统 `scheduler`、惰性执行 `lazy`、`ref` 的实现原理
- 第三篇：主要针对 `vue` 的渲染器（`renderer`）进行了讲解，额外还包含了 `diff` 算法的详细讲解
- 第四篇：是组件化。包含了 组件的渲染机制，以及对 `vue` 官方组件 `KeepAlive`、`Teleport`、`Transition` 的实现原理，进行了剖析
- 第五篇：是编译器（`compiler`）。在这一篇中，把编译器的三大步：`parse`、`transform`、`generate` 进行了分步的讲解。
- 最后：是服务端渲染。主要是 `CSR`、`SSR` 以及 同构渲染。

**第一篇：框架设计概览**

整个第一篇分为三个章节：

1. 权衡的艺术：这里主要涉及到了 `vue` 框架设计的一些基本概念，也是咱们讲解的重点
2. 框架设计的核心要素：相对比较杂，都是一些零碎的知识点
3. Vue.js 3 的设计思路：这一章包含了 `vue` 框架设计的逻辑主线，也非常重要，但是内容并不多

那么首先咱们先来看第一章。

**第一章：权衡的艺术**

在这一章中，开头的一句话，描述了框架设计的精髓，这句话也是尤雨溪在多个开发者大会中经常提到的，那就是：**框架的设计，本身就是一种权衡的艺术**。

在这一章中，书中分别从三个方面来去分析了所谓权衡的艺术，到底是什么意思。

**命令式和声明式**

首先第一个方面就是：**命令式和声明式** 的概念。

所谓 **命令式** 指的就是：**关注过程** 的范式。

而 **声明式** 指的就是： **关注结果** 的范式。

什么意思呢？我们来举一个小例子：

> 张三的妈妈，让张三去买酱油。
>
> 那么对于张三而言，他就需要：拿钱、出门、下楼、进超市、拿酱油、付钱、回家。
>
> 而对于张三的妈妈来说，她完全不需要关心张三做了什么，只需要对张三说一声就可以了。

那么在这个例子中，张三就是一个典型的命令式，他需要完成整件事情的所有过程。

而张三的妈妈，就是典型的声明式，她不关心过程只关心结果。

那么这里大家来想一下，`vue` 是声明式的？还是命令式的？

对于 `vue` 而言，它的内部实现一定是 **命令式** 的，而我们在使用 `vue` 的时候，则是通过 **声明式** 来使用的。

也就是说： **vue 封装了命令式的过程，对外暴露出了声明式的结果**

**性能与可维护性的权衡**

在明确好了命令式和声明式的概念之后。接下来咱们来看下从 **性能** 层面，`vue` 所体现出来的一种权衡的方式。

针对于性能的分析，主要从两个方面去说。

首先第一个方面：大家觉得 **是命令式的性能更强，还是声明式的性能更强呢？**

答案是：**命令式的性能 > 声明式的性能**。

其实原因非常简单，对于 **命令式** 的代码而言，它直接通过 **原生的 `JavaScript` 进行实现**，这是最简单的代码，没有比这个更简单的了，我们把它的性能比作 `1`。

而声明式，无论内部做了什么，它想要实现同样的功能，内部必然要实现同样的命令式代码。所以它的性能消耗一定是 `1 + N` 的。

那么既然如此，`vue` 为什么还要对外暴露出声明式的接口呢？

这其实是因为：**声明式的可维护性，要远远大于命令式的可维护性**。

> 大家从这两段代码（命令式和声明式代码）中就可以发现，声明式代码比命令式代码要简单的多。
>
> 越简单的代码，可维护性就越强

当性能与可维护性产生冲突时，那么舍鱼而取熊掌者也。（注意：在 `vue` 的性能优化之下，它并不会比纯命令式的性能差太多）

而这样的一种权衡，在 `template` 模板中，更是体现的淋漓尽致。

在前端领域，想要使用 `JavaScript` 修改 `html` 的方式，主要有三种：**`原生 JavaScript、innerHTML、虚拟 DOM`**

很多小伙伴都会认为 `虚拟 DOM` 的性能是最高的，其实不是。

我们来看这个对比。

![image-20230207233547097.png](https://p9-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/1055adc3787b4c0a80fcbc9f9eab4df8~tplv-k3u1fbpfcp-watermark.image?)

从这个对比我们可以发现，`虚拟 DOM` 的性能，并不是最高的。

但是它的 **心智负担（书写难度）最小**， 从而带来了 **可维护性最高**。所以哪怕它的性能并不是最高的。`vue` 依然选择了 `虚拟 DOM` 来进行了渲染层的构建。

这个也是一种性能与可维护性的权衡。

**运行时和编译时**

第一章的最后一部分，主要讲解的就是 **运行时和编译时**。

这两个名词，各位小伙伴在日常开发中，应该是经常听到的。

它们两个都是框架设计的一种方式，可单独出现，也可组合使用。

那么下面咱们就分别来介绍一下它们。

首先是 **运行时：`runtime`**。

> 它指的是：**利用 render 函数，直接把 虚拟 `DOM` 转化为 真实 `DOM` 元素** 的一种方式。
>
> 在整个过程中，不包含编译的过程，所以无法分析用户提供的内容。

其次是 **编译时：compiler**：

> 它指的是：**直接把 `template` 模板中的内容，转化为 真实 `DOM` 元素**。
>
> 因为存在编译的过程，所以可以分析用户提供的内容。
>
> 同时，没有运行时理论上性能会更好。
>
> 目前该方式，有具体的实现库，那就是现在也非常火的 `Svelte`
>
> 但是这里要注意： **它的真实性能，没有办法达到理论数据。**

最后是 **运行时 + 编译时**：

> 它的过程被分为两步：
>
> 1. 先把 `template` 模板转化为 `render` 函数。也就是 **编译时**
> 2. 再利用 `render` 函数，把 虚拟 `DOM` 转化为 真实 `DOM`。也就是 **运行时**
>
> 两者的结合，可以：
>
> 在 编译时，分析用户提供的内容 在 运行时，提供足够的灵活性
>
> 这也是 `vue` 的主要实现方式。

**第二章：框架设计的核心要素**

这一章主要讲解了，框架设计时一些凌乱的注意点。

比如：

1. 通过 环境变量 和 `TreeShanking` 控制打包之后的体积
2. 构建不同的打包产物，以应用不同的场景
3. 提供了 `callWithErrorHandling` 接口函数，来对错误进行统一处理
4. 源码通过 `TypeScript` 开发，以保证可维护性。
5. 内部添加了大量的类型判断和其他工作，以保证开发者使用时的良好体验。

这些东西都是基于一个个的小点单独去说的，整体之间并没有一个完成的线性逻辑。

所以大家可以根据具体感兴趣或者不了解的点，单独去看就可以。

**第三章：Vue.js 3 的设计思路**

在这一章中，作者站在一个高层的角度，以 **`UI` 形式、渲染器、组件、编辑器** 为逻辑主线进行的讲解。

下面咱们就来捋一捋这条线。

在 `Vue` 中 `UI` 形式主要分为两种：

- 声明式的模板描述

![image-20230208170232727.png](https://p3-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/204d3c7bd04f44b3be8eed7ebb8441a7~tplv-k3u1fbpfcp-watermark.image?)

- 命令式的 render 函数

![image-20230208170236795.png](https://p3-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/0f6d472daf6d4a7db97f39f655787ba1~tplv-k3u1fbpfcp-watermark.image?)

而针对于 **声明式的模板描述** 而言，本质上就是咱们常用的 `tempalte` 模板。它会被 **编辑器** 编译，得到 **渲染函数 `render`** 。

渲染器与渲染函数，并 **不是** 一个东西。

渲染器是 **函数 `createRenderer` 的返回值，是一个对象。被叫做 `renderer`**。 **`renderer` 对象中有一个方法 `render`**，这个 `render` ，就是我们常说的**渲染函数**。

渲染函数接收两个参数 `VNode` 和 `container`。

其中 `VNode` 表示 **虚拟 DOM**，本质上是一个 `JS` 对象。`container` 是一个容器，表示被挂载的位置。而 `render` 函数的作用，就是： **把 `vnode` 挂载到 `container` 上**。

同时，因为 `Vue` 以组件代表最小颗粒度，所以 `vue` 内部的渲染，本质上是：**大量的组件渲染**。

而组件本质上是一组 `DOM` 的集合，所以渲染一个一个的组件，本质上就是在渲染一组这一组的 `DOM`。也就是说，`Vue` 本质上是： **以组件作为介质，来完成针对于一组、一组的 `DOM` 渲染。**

**第一篇总结**

在整个第一篇中，作者主要就是通过这三章的内容， **自顶向下** 的为我们介绍了 `vue` 的框架设计逻辑。其目的主要就是为了让我们了解， `Vue` 框架的运行逻辑和一些关键概念。

### 第二篇：响应式系统

第二篇主要是针对 **响应式系统** 的讲解。

同样也是被分为三章：

- 首先第一章，也是最重要的一章，就是 **响应系统的作用与实现**
- 第二章，主要针对 **对象的响应性实现原理** 进行了讲解
- 第三章，主要针对 **非对象的响应性实现原理** 进行了讲解

**第四章：响应系统的作用与实现**

在这一章中，作者从 **响应式数据的概念开始，讲解了响应式系统的实现。** 然后针对于 **计算属性与 `watch` 的实现原理，进行了分析。** 在分析的过程中，也对其所设计到的 **`调度系统（scheduler）` 和 `惰性执行（lazy）` 的原理进行了明确。** 最后讲解了在 **竞态问题下，关于过期的副作用的处理逻辑。**

**响应式数据**

那么首先咱们先来看基本概念 **副作用函数 与 响应式数据**。

所谓 **副作用函数** 指的是 **会产生副作用的函数**，这样的函数非常的多。比如

![image-20230208190429676.png](https://p3-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/ef34b738308e460280f9cd8120dc1c4e~tplv-k3u1fbpfcp-watermark.image?)

在这段代码中， `effect` 的触发会导致全局变化 `val` 发生变化，那么 `effect` 就可以被叫做**副作用函数**。而如果 `val` 这个数据的变化，导致了视图的变化，那么 `val` 就被叫做 **响应式数据**。

那么如果想要实现响应式数据的话，那么它的核心逻辑，必然要依赖两个行为：

- 第一个是 `getter` 行为，也就是 **数据读取**
- 第二个是 `setter` 行为，也就是 **数据修改**

在 `vue 2` 中，这样的两个行为通过 `Object.defineProperty` 进行的实现。

在 `vue 3` 中，这样的两个行为通过 `Proxy` 进行的实现。

那么具体的实现逻辑是什么呢？咱们来看下面的图示：

> 首先是 `getter` 形式：
>
> ![image-20230208191120105.png](https://p1-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/82855905c19c4f309d9f4253575c80ca~tplv-k3u1fbpfcp-watermark.image?)
>
> 在该函数中，存在一个 `effect` 方法，方法内部触发了 `getter` 行为。一旦 `getter` 行为被触发，则把对应的 `effect` 方法保存到一个 “桶（数据对象）” 中
>
> 当触发 `setter` 行为时：
>
> <img src="https://p6-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/4ef91f7616374f0db7f9f14b3674382b~tplv-k3u1fbpfcp-watermark.image?" alt="image-20230208191257788.png" style="zoom: 25%;" />
>
> 则会从 “桶” 中取出 `effect` 方法，并执行。
>
> 那么此时因为 `obj.text` 的值发生了变化，所以 `effect` 被执行时 `document.body.innerText` 会被赋上新的值。从而导致视图发生变化。

这是一套构建响应式系统的基础逻辑。这一套逻辑足够应对大家在日常的 **面试** 或者 **工作** 中的基本需求。

而这套逻辑说起来简单，做起来还是有一些难度的。如果想要构建出一套完善的响应式系统，那么需要做非常多的工作，篇幅也会非常长。这就不是咱们这一个视频的长度可以解决的了。

所以我在这里给大家提供了两个方案，第一个是：我在掘金上发布的博客《手写响应式模块》。第二个是：我在慕课网的视频《Vue 3 源码解析，打造自己的 vue 框架》，里面也详细的讲解并且实现了响应性模块。大家可以按需进行选择。

**调度系统（scheduler）**

那么说完了基本的响应性之后，接下来咱们来看 **调度系统（`scheduler`）**

所谓调度系统，指的就是 **响应性的可调度性**。

而所谓的可调度，指的就是 **当数据更新的动作，触发副作用函数重新执行时，有能力决定：副作用函数（effect）执行的时机、次数以及方式**

比如，在这段打印中，决定打印的顺序

![image-20230208192343242.png](https://p1-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/5f526a19532b4b6391fef8856d6cd6b6~tplv-k3u1fbpfcp-watermark.image?)

而想要实现一个调度系统，则需要依赖 **`异步：Promise` 和 `队列：jobQueue`** 来进行实现。咱们需要 **基于 `Set` 构建出一个基本的队列数组 `jobQueue`，利用 `Promise` 的异步特性，来控制执行的顺序**

**计算属性（computed）**

当我们可以控制了执行顺序之后，那么就可以利用这个特性来完成 **计算属性（computed）** 的实现了。

计算属性本质上是： **一个属性值，当依赖的响应式数据发生变化时，重新计算**

那么它的实现就需要彻底依赖于 **调度系统（scheduler）** 来进行实现。

**惰性执行（lazy）**

说完计算属性，那么下面我们来看下 `watch` 监听器。

`watch` 监听器本质上是 **观测一个响应式数据，当数据发生变化时，通知并执行相应的回调函数**

这也就意味着，`watch` 很多时候并不需要立刻执行。

那么此时，就需要使用到 **惰性执行（`lazy`）** 来进行控制。

惰性执行的实现要比调度系统简单。它本质上 **是一个 `boolean` 型的值，可以被添加到 `effect` 函数中，用来控制副作用的执行**。

```
if (!lazy) {
  // 执行副作用函数
}
```

**watch 的实现原理**

基于 调度系统 与 惰性执行，那么就可以实现 `watch` 监听器了。

**过期的副作用**

`watch` 监听器的实现非常广泛，有时候我们甚至可以在 **`watch` 中完成一些异步操作。**

但是大量的异步操作，极有可能会导致 **竞态问题**。

所谓的竞态问题，指的是 **在描述一个系统或者进程的输出，依赖于不受控制的事件出现顺序或者出现时机**。比如咱们来看这段代码

![image-20230208194352049.png](https://p3-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/ec32164f3399416c9f9ffbdb3a7c471b~tplv-k3u1fbpfcp-watermark.image?)

> 这段代码完成的是一个异步操作。
>
> 如果 `obj` 连续被修改了两次，那么就会发起两个请求。我们最终的期望应该是 `data` 被赋值为 请求B 的结果。
>
> 但是，因为异步的返回结果我们无法预计。所以，如果 请求 B 先返回，那么最终 `data` 的值就会变为 请求 A 的返回值。
>
> 这个咱们的期望是不一样的。
>
> 那么这样的问题，就是 **竞态问题**

而如果想要解决这问题，那么就需要使用到 `watch` 回调函数的第三个参数 `onInvalidate`，它本身也是一个回调函数。并且 **该回调函数（`onInvalidate`）会在副作用下一次重新执行前调用，可以用来清除无效的副作用，例如等待中的异步请求**

而 `onInvalidate` 的实现原理也非常简单，只需要 **在副作用函数（effct）重新执行前，先触发 `onInvalidate`** 即可。

**第四章总结**

那么到这里，咱们就把 **响应性系统的大致核心逻辑** 明确完成了。从这个逻辑中，我们知道想要实现响应性数据，那么核心就是通过 `Proxy` 实现。

那么这个 `proxy` 具体怎么做呢？

接下来，咱们来看第五章。

**第五章：非原始值（对象）的响应性方案**

书中的第五章整体而言非常简单，主要就介绍了两个接口，`Proxy` 和 `Reflect`。

这两个接口通常会一起进行使用，其中：

- `Proxy` 可以 **代理一个对象（被代理对象）的 getter 和 setter 行为，得到一个 proxy 实例（代理对象）**
- `Reflect` 可以 **在 Proxy 中使用 this 时，保证 this 指向 proxy，从而正确执行次数的副作用**

**第六章：原始值（非对象）的响应性方案**

如果大家熟悉 `proxy` 的话，那么可以知道，针对于 `proxy` 而言，它只能代理复杂数据类型。这就意味着，简单数据类型无法具备响应性。

但是，在 `vue` 中，我们可以通过 `ref` 构建简单数据类型的响应。

那么 `ref` 是如何进行实现的呢？

这里大家要注意：**针对于最新的 vue 3.2 而言，书中在 《6.1 引入 ref 的概念》中所讲解的 ref 实现原理存在 “落后性”。 vue 3.2 已经修改了 ref 的实现，这得益于 @basvanmeurs 的贡献**

在最新的 `vue 3.2` 代码中，`vue` 通过 **`get` 、`set` 函数标记符，让函数以属性调用的形式被触发。**这两个修饰符，可以让我们 **像调用属性一样，调用方法**。 所以当我们平时 **访问 ref.value 属性时，本质上是 value() 函数的执行**。

**第二篇总结**

那么到这里咱们整个响应式系统的大概流程，就已经描述完成了。其核心逻辑主要就是在第四章中。

至于第五章和第六章，更多的偏向于具体的细节和代码逻辑。

### 第三篇：渲染器

那么下面咱们来看 **第三篇：渲染器** 。

第三篇一共被分为 5 个章节。但是只讲解了三部分内容。

- 首先第七章，主要讲解了**渲染器的设计**。
- 第八章，主要讲解了 **`DOM` 的挂载和更新的逻辑**。
- 而 第九、十、十一 这三章，主要讲解了 **Diff 算法**

**第七章：渲染器的设计**

在之前咱们说过 **渲染器与渲染函数不是一个东西**

- **渲染器** 是 `createRenderer` 的返回值，是一个对象。
- **渲染函数** 是渲染器对象中的 `render` 方法

在 `vue 3.2.37` 的源码内部，`createRenderer` 函数的具体实现是通过 `baseCreateRenderer` 进行的。它的代码量非常庞大，涉及到了 `2000` 多行的代码。

<img src="https://p6-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/ab42acdff39a482fb65bc4f72fa00301~tplv-k3u1fbpfcp-watermark.image?" alt="image-20230209085155034.png" style="zoom: 50%;" />

代码量虽多，但是核心思路并不是特别复杂。总体可以被分为两部分：

1. **在浏览器端渲染时，利用 `DOM API` 完成 `DOM` 操作**：比如，如果渲染 `DOM` 那么就使用 `createElement`，如果要删除 `DOM` 那么就使用 `removeChild`。
2. **渲染器不能与宿主环境（浏览器）产生强耦合**：因为 `vue` 不光有浏览器渲染，还包括了 `服务端` 渲染，所以如果在渲染器中绑定了宿主环境，那么就不好实现服务端渲染了。

在渲染的过程中，还有一个非常重要的概念 `vnode`。书中并没有专门的章节来介绍 `vnode`。所以为了避免各位小伙伴对 `vnode` 不了解，咱们单独把 `vnode` 说一下。

所谓 `vnode` 本身是 **一个普通的 JavaScript 对象，代表了渲染的内容**。对象中通过 `type` 表示渲染的 `DOM`。比如 `type === div`：则表示 `div` 标签、`type === Framgnet` 则表示渲染片段（vue 3 新增）、`type === Text` 则表示渲染文本节点。

**第八章：挂载与更新**

对于渲染器而言，它做的最核心的事情就是 **对节点进行挂载、更新的操作**。作者在第八章中，详细的介绍了对应的逻辑。

整个第八章分为两部分来讲解了这个事情：

1. `DOM` 节点操作
2. 属性节点操作

**`DOM` 节点操作**

首先先来看 `DOM` 节点操作。`DOM` 节点的操作可以分为三部分：

- **挂载**：所谓挂载表示节点的初次渲染。比如，可以直接通过 `createElement` 方法新建一个 `DOM` 节点，再利用 `parentEl.insertBefore `方法插入节点。
- **更新**：当响应性数据发生变化时，可能会涉及到 `DOM` 的更新。此时的更新本质上是属于 **属性的更新**。咱们等到属性节点操作那里再去说。
- **卸载**：所谓卸载表示旧节点不在被需要了。那么此时就需要删除旧节点，比如可以通过 `parentEl.removeChild` 进行。

以上三种类型，是 `vue` 在进行 `DOM` 操作时的常见逻辑。基本上覆盖了 `DOM` 操作 `90% 以上` 的常见场景

**属性节点操作**

看完了 `DOM` 操作之后，接下来咱们来看属性节点操作。

针对于属性而言，大体可以分为两类：

1. **属性**：比如 `class`、`id`、`value`、`src`...
2. **事件**：比如 `click`、`input`....

那么咱们就先来看 **非事件的属性部分**。

想要了解 `vue` 中对于属性的处理，那么首先咱们需要先搞明白一个很重要的问题。那就是 **浏览器中的属性分类**。

在浏览器中 `DOM` 属性其实被分为了两类：

- 第一类叫做 `HTML Attributes`：直接定义在 `HTML 标签` 上的属性，都属于这一类。
- 第二类叫做 `DOM Properties`：它是拿到 `DOM` 对象后定义的属性。咱们接下来主要要说的就是它。

`HTML Attributes` 的定义相对而言比较简单和直观，但是问题在于 **它只能在 `html` 中进行操作**。

而如果想要在 `JS` 中操作 `DOM` 属性，就必须要通过 `DOM Properties` 来进行实现。但是因为 `JS` 本身特性的问题，会导致某些 `DOM Properties` 的设置存在特殊性。比如 `class、type、value` 这三个。

所以为了保证 `DOM Properties` 的成功设置，那么我们就必须要知道 **不同属性的 `DOM Properties` 定义方式 **。

下面咱们来看一下。

`DOM Properties` 的设置一共被分为两种：

1. `el.setAttribute('属性名', '属性值')`
2. `. 属性赋值` ： `el.属性名 = 属性值` 或者 `el[属性名] = 属性值` 都属于 `.属性赋值`

我们来看这段代码：

<img src="https://p9-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/100aef93baa14a6e9c7e9c493a380611~tplv-k3u1fbpfcp-watermark.image?" alt="image-20230209093545078.png" style="zoom:50%;" />

> 在这段代码中，我们为 `textarea` 利用 `DOM Properties` 的方式设置了三个不同的属性：
>
> - 首先是 `class`： `class` 在属性操作中是一个非常特殊的存在。它有两个名字 `class` 和 `className`。如果我们直接通过 `el.setAttribute` 的话，那么必须要用 `class` 才可以成功，而如果是通过 `. 属性` 的形式，那么必须要使用 `className` 才可以成功。
> - 第二个是 `type`： `type` 仅支持 `el.setAttribute` 的方式，不支持 `.属性的方式`
> - 第三个是 `value`：`value` 不支持直接使用 `el.setAttribute` 设置，但是支持 `.属性` 的设置方式

除了这三个属性之外，其实还有一些其他的属性也需要进行特殊处理，咱们这里就不再一一赘述了。

**事件**

接下来，咱们来看 `vue` 对事件的处理操作。

事件的处理和属性、`DOM` 一样，也是分为 **添加、删除、更新** 三类。

- 添加：添加比较简单，主要利用 `el.addEventListener` 进行实现即可。
- 删除：主要利用 `el.removeEventListener` 进行处理。
- 更新：但是对于更新来说，就比较有意思了。下面咱们主要来看的就是这个更新操作。

通常情况下，我们所认知的事件更新应该是 **删除旧事件、添加新事件** 的过程。但是如果利用 `el.addEventListener` 和 `el.removeEventListener` 来完成这件事情，是一件非常消耗性能的事。

那么怎么能够节省性能，同时完成事件的更新呢？

这时，`vue` 对事件的更新提出了一个叫做 `vei` 的概念，这个概念的意思是： **为 `addEventListener` 回调函数，设置了一个 `value` 的属性方法，在回调函数中触发这个方法。通过更新该属性方法的形式，达到更新事件的目的。**

这个代码比较多，大家如果想要查看具体代码的话，可以 [在 github 搜索 vue-next-mini](https://github.com/lgd8981289/vue-next-mini)，进入到 `packages/runtime-dom/src/modules/events.ts` 路径下查看。

**第九、十、十一章：Diff 算法**

整个渲染器最后的三个章节全部都用来讲解了 `diff` 算法。

针对于 `diff` 而言，它的本质其实就是一个对比的方法，其描述的核心就是： **“旧 DOM 组”更新为“新 DOM 组”时，如何更新才能效率更高。**

目前针对于 `vue 3.2.37` 的版本来说，整个的 `diff` 算法被分为 5 步（**这 5 步不跟大家读了，因为咱们没头没尾的读一遍，其实对大家也没有什么帮助**）：

1. `sync from start`：自前向后的对比
2. `sync from end`：自后向前的对比
3. `common sequence + mount`：新节点多于旧节点，需要挂载
4. `common sequence + unmount`：旧节点多于新节点，需要卸载
5. `unknown sequence`：乱序

而，针对于书中的这三章来说，本质上是按照 **简单 diff 算法、双端 diff 算法、快速 diff 算法** 的顺序把整个 `diff` 的前世今生基本上都说了一遍。里面涉及到了非常多的代码。

所以说咱们在当前的这个视频中，肯定是没有办法为大家讲解具体算法逻辑的。

针对于这一块，我同样也是准备了另外的博客和视频：

- 首先是 [免费的博客版](https://juejin.cn/post/71907262420) ，我把它发布到了掘金。**在评论区，会通过评论的形式为大家提供地址**。
- 其次是 [收费的视频版](https://coding.imooc.com/class/608.htm)，是在慕课网发布的。**同样链接会放到评论区**。

**第三篇总结**

针对于第三篇渲染器来说，咱们所描述的重点主要是围绕 **渲染器的设计** 和 **`DOM` 的挂载和更新的逻辑** 来去说的。

针对于这两部分而言，大家要明确 **渲染器与渲染函数的区别**，同时要知道 `HTML Attributes` 和 `DOM Properties` 在行为上的差异性。另外关于事件更新的 `vei` 概念，应该也可以给大家带来一些新的思路。

而针对于 `diff`，咱们没有放在当前视频中去说，主要还是因为时长不够的原因。但是我为大家准备了额外的博客和视频，大家可以根据自己需要去进行查看。

### 第四篇：组件化

第四篇组件化，它应该算是比较简单的一个篇章，也是分为三部分来去讲解：

1. 组件的实现原理：这是咱们讲解的重心，但是不用担心，它并不复杂。
2. 异步组件与函数式组件：这个比较冷僻，在实际开发中的使用场景有限
3. 内建组件和模块：里面主要讲解了 `KeepAlive`、`Teleport`、`Transition` 这三个内置组件的实现逻辑

**第十二章：组件的实现原理**

想要了解 `vue` 中组件的实现，那么首先我们需要知道什么是组件。

组件本质上就是一个 `JavaScript` 对象，比如，以下对象就是一个基本的组件

![image-20230209105953064.png](https://p3-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/f75a31d7872b49dd840005b3063ebace~tplv-k3u1fbpfcp-watermark.image?)

而对于组件而言，同样需要使用 `vnode` 来进行表示，当 `vnode` 的 `type` 属性是一个 **自定义对象** 时，那么这个 `vnode` 就表示组件的 `vnode`

![image-20230209110548502.png](https://p9-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/aa1be66ad7c745ac992d6150330ce9e8~tplv-k3u1fbpfcp-watermark.image?)

而组件的渲染，本质上是 **组件包含的 `DOM` 的渲染。** 对于组件而言，必然会包含一个 `render` 渲染函数。如果没有 `render` 函数，那么 `vue` 会把 `template` 模板编译为 `render` 函数。而组件渲染的内容，其实就是 `render` 函数返回的 `vnode`。具体的渲染逻辑，全部都通过渲染器执行。

![image-20230209110919710.png](https://p1-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/bc767638e42c4c599926acf54021fc66~tplv-k3u1fbpfcp-watermark.image?)

`vue 3` 之后提出了 `composition API`，`composition API` 包含一个入口函数，也就是 `setup` 函数。 `setup` 函数包含两种类型的返回值：

1. **返回一个函数**：当 `setup` 返回一个函数时，那么该函数会被作为 `render` 函数直接渲染。
2. **返回一个对象**：当 `setup` 返回一个对象时，那么 `vue` 会直接把该对象的属性，作为 `render` 渲染时的依赖数据

同时，对于组件来说还有一个 **插槽** 的概念。插槽的实现并不神奇。插槽本质上 **是一段 `innerHTML` 的内容，在 `vnode` 中以 `children` 属性进行呈现**。当插槽被渲染时，只需要渲染 `children` 即可。

对于组件来说，除了咱们常用的 **对象组件** 之外，`vue` 还提供了额外的两种组件，也就是 **异步组件与函数式组件**。

**第十三章：异步组件与函数式组件**

所谓异步组件，指的是： **异步加载的组件** 。

比如服务端返回一个组件对象，那么我们也可以拿到该对象，直接进行渲染。

异步组件在 **优化页面性能、拆包、服务端下发组件** 时，会比较有用。

而对于 **函数式组件** 来说，相对就比较冷僻了。函数式组件指的是 **没有状态的组件。本质上是一个函数，可以通过静态属性的形式添加 `props` 属性** 。在实际开发中，并不常见。

**第十四章：内建组件和模块**

这一章中，主要描述了 `vue` 的三个内置组件。

**keepAlive**

首先第一个是 `KeepAlive`。

这是我们在日常开发中，非常常用的内置组件。它可以 **缓存一个组件，避免该组件不断地销毁和创建**。

看起来比较神奇，但是它的实现原理其实并不复杂，主要围绕着 **组件卸载** 和 **组件挂载** 两个方面：

- **组件卸载**：当一个组件被卸载时，它并不被真正销毁，而是把组件保存在一个容器中
- **组件挂载**：因为组件被保存了。所以当这个组件需要被挂载时，就不需要在重新创建，而是直接从容器中获取即可。

**Teleport**

`Teleport` 是 `vue 3` 新增的组件，作用是 **将 `Teleport` 插槽的内容渲染到其他的位置**。比如我们可以把 `dialog` 渲染到 `body` 根标签之下。

它的实现原理，主要也是分为两部分：

1. 把 Teleport 组件的渲染逻辑，从渲染器中抽离
2. 在指定的位置进行独立渲染

**Transition**

`Transition` 是咱们常用的动画组件，作用是 **实现动画逻辑**。

其核心原理同样被总结为两点：

1. `DOM` 元素被挂载时，将动效附加到该 `DOM` 元素上
2. `DOM` 元素被卸载时，等在 `DOM` 元素动效执行完成后，执行卸载 `DOM` 操作

**第四篇总结**

整个第四篇，主要围绕着组件来去讲。所以内容并不复杂。

对于咱们的日常的开发与面试而言，其实只需要搞清楚 **组件的原理** 与 **内建组件原理** 即可。

### 第五篇：编译器

编译器是一个非常复杂的环节。作者主要通过 **编辑器核心逻辑、解析器、编译优化** 这三个方向进行了说明。

其中对于我们日常开发与面试来说，最核心的就是 **第十五章：编译器核心技术概述** 。这也是咱们在这一篇中的主要章节。

**第十五章：编译器核心技术概述**

在编译器核心技术概述，主要包含两个核心内容：

1. 模板 `DSL` 的编译器
2. `Vue` 编译流程三大步

**模板 `DSL` 的编译器**

在任何一个编程语言中，都存在编译器的概念。 `vue` 的编译器是在 **一种领域下，特定语言的编译器** ，那么这种编译器被叫做 `DSL` 编译器。

而编译器的本质是 **通过一段程序，可以把 A 语言翻译成 B 语言**。在 `vue` 中的体现就是 **把 `tempalte` 模板，编译成 `render` 渲染函数**

一个完整的编译器，一个分为 **两个阶段、六个流程**：

- 编译前端：
  - 词法分析
  - 语法分析
  - 语义分析
- 编译后端：
  - 中间代码生成
  - 优化
  - 目标代码生成

![image-20230209113241592.png](https://p9-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/ffad2f8700484c16a54ba64df0c0a0b8~tplv-k3u1fbpfcp-watermark.image?)

而对于 `vue` 的编译器而言，因为它是一个特定领域下的编译器，所以流程会进行一些优化，一共分为三大步

![image-20230209113421705.png](https://p9-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/217f4f7f06174c498ce14d61fd3b6c12~tplv-k3u1fbpfcp-watermark.image?)

1. `parse`：通过 `parse` 函数，把模板编译成 `AST` 对象
2. `transform`：通过 `transform` 函数，把 `AST` 转化为 `JavaScript AST`
3. `generate`：通过 `generate` 函数，把 `JavaScript AST` 转化为 渲染函数（`render`）

这三大步中，每一步都包含非常复杂的逻辑实现。

和之前一样，因为篇幅的问题，我们没有办法这里去详细讲解三大步的流程。

我依然为大家提供了 [免费的博客版](https://juejin.cn/post/7197977396603256890/42118200) 和 [收费的视频版](https://coding.imooc.com/class/608.html) 。如果想要了解详细流程，那么可以自己进行选择。

**第十六章：解析器（parse）**

这一章，主要详细讲解了 **parse 解析逻辑**。是在三大步中的 `parse` 逻辑的基础上，进行了一个加强。

所以这里咱们也按下不表

**第十七章：编译优化**

最后就是编译优化。

编译优化也是一个非常大的概念，其核心就是 **通过编译的手段提取关键信息，并以此知道生成最优代码的过程**。

它的核心优化逻辑，主要是 **把节点分为两类**：

- 第一类是 **动态节点**：也就是会 **受数据变化影响** 的节点
- 第二类是 **静态节点**：也就是 **不受数据变化影响** 的节点

优化主要的点，就是 **动态节点**。

优化的方式主要是通过 `Block 树` 进行优化。

`Block 树` 本质上就是一个 **虚拟节点数对象**，内部包含一个 `dynamicChildren` 属性，用来 **收集所有的动态子节点**，以达到提取关键点进行优化的目的。

除此之外，还有一些小的优化手段，比如：

- 静态提升
- 预字符串化
- 缓存内联事件处理函数
- `v-once` 指令
- ...

**第五篇总结**

其实第五篇编译器应该是整本书中，逻辑最复杂的一篇了。内部包含了特别多的代码实现。

但是因为篇幅问题，所以我们没有办法给大家进行详细介绍。只能是把大致的核心流程为大家进行明确。希望大家见谅。

### 第六篇：服务端渲染

最后一篇只有一个章节，就是 **同构渲染**。

想要了解同构渲染，那么需要先搞明白 `CSR、SSR` 的概念。

`CSR`：所谓 `CSR` 指的是 **客户端渲染**。

> - 浏览器向服务器发起请求
> - 服务器查询数据库，返回数据
> - 浏览器得到数据，进行页面构建

`SSR`：表示 **服务端渲染**

> - 浏览器向服务器发起请求
> - 服务器查询数据库，根据数据，生成 `HTML` ，并进行返回
> - 浏览器直接渲染 `HTML`

两种方式各有利弊，所以同构渲染，指的就是 **把 `CSR` 和 `SSR` 进行合并**。既可以单独 `CSR` ，也可以单独 `SSR`，同时还可以 **结合两者，在首次渲染时，通过 `SSR`，在非首次渲染时，通过 `CSR`**。

以下是三者的对比图

<img src="https://p6-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/89708017acf04610b78efdd7ff4fa98c~tplv-k3u1fbpfcp-watermark.image?" alt="image-20230209121227934.png" style="zoom:33%;" />

而针对 `vue` 的服务端渲染来说，它是 **将虚拟 `DOM` 渲染为 `HTML` 字符串**，本质上是 **解析的 `vnode` 对象，然后进行的 `html` 的字符串拼接**

最后又讲解了客户端激活的原理，大致分为两步：

1. 为页面中的 `DOM` 元素与虚拟节点对象之间建立联系
2. 为页面中的 `DOM` 元素添加事件绑定

这两步主要是通过 `renderer.hydrate()` 方法进行实现了。
