---
title: Vue3
date: 2021-01-01 07:33:16
categories:
- B_中级
toc: true # 是否启用内容索引
---

Vue 是一套用于构建用户界面的渐进式框架。Vue.js 3.0 "One Piece" 正式版在 2020 年 9 月份发布,经过了 2 年多开发, 100+位贡献者, 2600+次提交, 600+次 PR，同时 Vue3 也支持 Vue2 的大多数特性,且,更好的支持了 TypeScript,也增加了很多的新特性,如:Composition API,新组件(Fragment/Teleport/Suspense)等等.

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

# 中级

# 高级



# 入门

## 认识 Vue3

**1) 了解相关信息**

- Vue.js 3.0 "One Piece" 正式版在今年 9 月份发布
- 2 年多开发, 100+位贡献者, 2600+次提交, 600+次 PR
- <font color='red'>**Vue3 支持 vue2 的大多数特性**</font>
- <font color='red'>**更好的支持 Typescript**</font>

**2) 性能提升**

- 打包大小减少 41%
- 初次渲染快 55%, 更新渲染快 133%
- 内存减少 54%
- <font color='red'>**使用 Proxy 代替 defineProperty 实现数据响应式**</font>
- <font color='red'>**重写虚拟 DOM 的实现和 Tree-Shaking**</font>

**3) 新增特性**

- <font color='red'>**Composition (组合) API**</font>
- setup

  - ref 和 reactive
  - computed 和 watch
  - 新的生命周期函数
  - provide 与 inject
  - ...

- 新组件

  - Fragment - 文档碎片
  - Teleport - 瞬移组件的位置
  - Suspense - 异步加载组件的 loading 界面

- 其它 API 更新

  - 全局 API 的修改
  - 将原来的全局 API 转移到应用对象
  - 模板语法变化

## 创建 vue3 项目

**1) 使用 vue-cli 创建**

[文档指南](https://cli.vuejs.org/zh/guide/creating-a-project.html#vue-create)

```bash
## 安装或者升级
npm install -g @vue/cli
## 保证 vue cli 版本在 4.5.0 以上
vue --version
## 创建项目
vue create my-project
```

**2) 使用 vite 创建**

- [文档指南:](https://v3.cn.vuejs.org/guide/installation.html)

- vite 是一个由原生 ESM 驱动的 Web 开发构建工具。在开发环境下基于浏览器原生 ES imports 开发，
- 它做到了**_本地快速开发启动_**, 在生产环境下基于 Rollup 打包。
  - 快速的冷启动，不需要等待打包操作；
  - 即时的热模块更新，替换性能和模块数量的解耦让更新飞起；
  - 真正的按需编译，不再等待整个应用编译完成，这是一个巨大的改变。

```bash
npm init vite-app <project-name>
cd <project-name>
npm install
npm run dev
```

## Vue3手摸手一站式

**实战视频**

| 相关库名称                                | 在线地址 🔗                                                   |
| ----------------------------------------- | ------------------------------------------------------------ |
| Vue 3.0 实战星座物语 H5 项目              | [在线地址](https://link.juejin.cn?target=https%3A%2F%2Fwww.bilibili.com%2Fvideo%2FBV1Q64y1F7mm%3Ffrom%3Dsearch%26seid%3D15048255084253288459) |
| Vue 3.0 UI 组件库开发                     | [在线地址](https://link.juejin.cn?target=https%3A%2F%2Fwww.bilibili.com%2Fvideo%2FBV1ny4y1i7Sh%3Ffrom%3Dsearch%26seid%3D15048255084253288459) |
| Vue 3.0 + Vite 手册阅读                   | [在线地址](https://link.juejin.cn?target=https%3A%2F%2Fwww.bilibili.com%2Fvideo%2FBV1Q54y1k7At%3Ffrom%3Dsearch%26seid%3D15048255084253288459) |
| Vue 3.0 入门之项目搭建（杨村长）          | [在线地址](https://link.juejin.cn?target=https%3A%2F%2Fwww.bilibili.com%2Fvideo%2FBV1vX4y1K7bQ%3Ffrom%3Dsearch%26seid%3D17184556019333060655) |
| Vue 3.0 入门（技术胖）                    | [在线地址](https://link.juejin.cn?target=https%3A%2F%2Fwww.bilibili.com%2Fvideo%2FBV1L5411j7vj%3Ffrom%3Dsearch%26seid%3D17184556019333060655) |
| Vite 2.0 插件开发指南                     | [在线地址](https://link.juejin.cn?target=https%3A%2F%2Fwww.bilibili.com%2Fvideo%2FBV1jb4y1R7UV%3Ffrom%3Dsearch%26seid%3D384387825939775015) |
| Vue 3.0 + Vite 2.0 快速搭建 Electron 应用 | [在线地址](https://link.juejin.cn?target=https%3A%2F%2Fwww.bilibili.com%2Fvideo%2FBV1XV411e7Hq%3Ffrom%3Dsearch%26seid%3D384387825939775015) |
| Vue3开发企业级音乐Web App                 | [黄轶](https://coding.imooc.com/class/chapter/503.html#Anchor) |

**教程文章**

比如发布一些 Vue3 的教程：

- [我要成为海贼王的男人-Vue3最全宇宙入口](https://github.com/vue3/vue3-News#%E6%88%91%E6%98%AF%E8%A6%81%E6%88%90%E4%B8%BA%E6%B5%B7%E8%B4%BC%E7%8E%8B%E7%9A%84%E7%94%B7%E4%BA%BA)
- [Vue3+TS快速上手-尚硅谷-video](https://www.bilibili.com/video/BV1ra4y1H7ih/?p=2&spm_id_from=pageDriver&vd_source=bd4c7d99d71adf64d6e88c65370e0247)
- [Vue3+TS快速上手-尚硅谷](https://24kcs.github.io/vue3_study/)
- [Vite + Vue3 + Pinia + 实战项目 + TypeScript-小鹿线-video](https://www.bilibili.com/video/BV1aU4y1U7Gv/?p=12&spm_id_from=pageDriver&vd_source=bd4c7d99d71adf64d6e88c65370e0247)
- [📺 VueMastery原版](https://link.juejin.cn/?target=https%3A%2F%2Fwww.bilibili.com%2Fvideo%2FBV1my4y1m7sz%3Fp%3D6)
- [📺 然叔与杨村长的深度解读](https://link.juejin.cn/?target=https%3A%2F%2Fwww.bilibili.com%2Fvideo%2FBV1my4y1m7sz%3Fp%3D7)
- [🔥 39岁的夺路狂奔| 掘金年度征文](https://juejin.cn/post/6903701243361755149) 98赞
- [🔥 Element3开发内幕 - Vue CLI插件开发](https://juejin.cn/post/6899334776860180494) 167赞
- [🔥 天天造轮子系列](https://juejin.cn/post/6893338774088974343) 500+ 赞
- [🔥 Vue3.0全球发布会干货总结](https://juejin.cn/post/6875236411349008398) 267赞
- [《Vue 3.0 来了，我们该做些什么？》](https://juejin.cn/post/6874604408030789640)
- [《Vue3实战系列：结合 Ant-Design-of-Vue 实践 Composition API》](https://juejin.cn/post/6882393804310052871)
- [《Vue3 来了，Vue3 开源商城项目重构计划正式启动！》](https://juejin.cn/post/6884991023811215374)
- [《Vue3实战系列：Vue3.0 + Vant3.0 搭建种子项目》](https://juejin.cn/post/6887590229692121096)
- [《🎉🎉一个基于 Vue 3 + Vant 3 的开源商城项目🎉🎉》](https://juejin.cn/post/6892783570016796679)
- [《Vue3教程：用 Vue3 开发小程序，这里有一份实践代码！》](https://juejin.cn/post/6895360073460416525)
- [《Vue3教程：Vue 3.x 快在哪里？》](https://juejin.cn/post/6903171037211557895)
- [《Vue3教程：开发一个 Vue 3 + element-plus 的后台管理系统》](https://juejin.cn/post/6942251234191654949)
- [《🎉🎉Vue 3 + Element Plus + Vite 2 的后台管理系统开源啦🎉🎉》](https://juejin.cn/post/6945072070132760590)
- [程序员的副业：写了一个专栏《Vue 3企业级项目实战》](https://juejin.cn/post/6947703226128924702)
- [心脏跳动团队-商城](https://link.juejin.cn?target=https%3A%2F%2Fgithub.com%2Fnewbee-ltd)
- [vue3保姆级教程Vue.js前端](https://juejin.cn/post/7030992475271495711)
- [Vue3.0 新特性以及使用经验总结](https://juejin.cn/post/6940454764421316644#heading-1)
- [焕然一新的 Vue 3 中文文档要来了](https://juejin.cn/post/7077701166397653028)

**Vue 3.0 生态**

| 相关库名称             | 在线地址 🔗                                                   |
| ---------------------- | ------------------------------------------------------------ |
| Vue 3.0 官方文档(英文) | [在线地址](https://link.juejin.cn?target=https%3A%2F%2Fv3.vuejs.org%2F) |
| Vue 3.0 中文文档       | [在线地址](https://link.juejin.cn?target=https%3A%2F%2Fv3.cn.vuejs.org%2F) [国内加速版](https://link.juejin.cn?target=https%3A%2F%2Fvue3js.cn%2Fdocs%2Fzh%2F) |
| Composition-API手册    | [在线地址](https://link.juejin.cn?target=https%3A%2F%2Fvue3js.cn%2Fvue-composition-api%2F) |
| Vue 3.0 源码学习       | [在线地址](https://link.juejin.cn?target=https%3A%2F%2Fvue3js.cn%2Fstart%2F) |
| Vue-Router 官方文档    | [在线地址](https://link.juejin.cn?target=https%3A%2F%2Fnext.router.vuejs.org%2F) |
| Vuex 4.0               | [Github](https://link.juejin.cn?target=https%3A%2F%2Fgithub.com%2Fvuejs%2Fvuex%2Ftree%2F4.0) |
| vue-devtools           | [Github](https://link.juejin.cn?target=https%3A%2F%2Fgithub.com%2Fvuejs%2Fvue-devtools%2Freleases)(Vue3.0 需要使用最新版本) |
| Vite 源码学习          | [线上地址](https://link.juejin.cn?target=https%3A%2F%2Fvite-design.surge.sh%2Fguide%2F) |
| Vite 2.0 中文文档      | [线上地址](https://link.juejin.cn?target=https%3A%2F%2Fcn.vitejs.dev%2F) |
| Vue3 新动态            | [线上地址](https://link.juejin.cn?target=https%3A%2F%2Fgithub.com%2Fvue3%2Fvue3-News) |

**Element-plus**

- [Vue 3.0 + Vite 2.0 + Vue-Router 4.0 + Element-Plus + Echarts 5.0 + Axios 开发的后台管理系统](https://link.juejin.cn?target=https%3A%2F%2Fgithub.com%2Fnewbee-ltd%2Fvue3-admin) ⭐ ： **419**
- [Vue3.0+TypeScript+NodeJS+MySql编写的一套后台管理系统](https://link.juejin.cn?target=https%3A%2F%2Fgithub.com%2Fxiaoxian521%2FCURD-TS) ⭐ ： **262**

**Ant Design of Vue**

- [AntdV后台管理系统](https://link.juejin.cn?target=https%3A%2F%2Fgithub.com%2Ficzer%2Fvue-antd-admin) ⭐ ： **2.8k**
- [vue3.x + ant-design-vue（beta 版本，免费商用，支持 PC、平板、手机）](https://link.juejin.cn?target=https%3A%2F%2Fgithub.com%2Fchuzhixin%2Fvue-admin-better) ⭐ ： **8.2k**
- [基于 Vue3.0 + Vite + Ant Design Vue](https://link.juejin.cn?target=https%3A%2F%2Fgithub.com%2Flirongtong%2Fmiitvip-vue-admin-manager) ⭐ ： **74**

**Vant**

- [newbee-mall Vue3 版本](https://link.juejin.cn?target=https%3A%2F%2Fgithub.com%2Fnewbee-ltd%2Fnewbee-mall-vue3-app)⭐ ： **1.7k**
- [高仿微信记账本](https://link.juejin.cn?target=https%3A%2F%2Fgithub.com%2FNick930826%2Fdaily-cost) ⭐ ： **48**
- [仿京东淘宝电商](https://link.juejin.cn?target=https%3A%2F%2Fgithub.com%2FGitHubGanKai%2Fvue3-jd-h5) ⭐ ： **319**

# 进阶

> [composition-api 文档](https://composition-api.vuejs.org/zh/api.html)
>
> [Vue3的8种组件通信](https://segmentfault.com/a/1190000041240135)

## 五大API-全局API

全局API —— 全局会用到的API

- createApp()：创建一个应用实例
- createSSRApp()：以SSR 激活的模式，来创建一个应用实例
- app.mount()：将应用实例挂载到一个容器元素中
- app.unmount()：卸载一个已挂载的应用实例
- app.component()：如果传递的是一个字符串类型的组件名及其定义，则注册一个全局组件
- app.directive()：如果同时传递一个名字和一个指令，那么将注册一个全局指令
- app.use()：安装一个插件
- app.mixin()：应用一个全局的组件mixin。(如果要进行逻辑复用的话，那么推荐使用组合式函数来替代)
- app.config.globalProperties：用于注册“能够被应用内所有组件实例所访问到的全局属性”的对象
- nextTick()：用来等待下一次DOM更新和刷新
- defineComponent()：在定义vue组件时，提供【类型推导】的辅助函数
- defineAsyncComponent()：用来定义一个异步组件，当用了这个函数时，组件在运行时是懒加载的

## 五大API-组合式API

组合式API —— vue3所拥有的组合式API

### setup

- 新的 option, 所有的组合 API 函数都在此使用, 只在初始化时执行一次
- 函数如果返回对象, 对象中的属性或方法, 模板中可以直接使用

**setup 细节**

- setup 执行的时机

  - 在 beforeCreate 之前执行(一次), 此时组件对象还没有创建
  - this 是 undefined, 不能通过 this 来访问 data/computed/methods / props
  - 其实所有的 composition API 相关回调函数中也都不可以

- setup 的返回值

  - 一般都返回一个对象: 为模板提供数据, 也就是模板中可以直接使用此对象中的所有属性/方法
  - 返回对象中的属性会与 data 函数返回对象的属性合并成为组件对象的属性
  - 返回对象中的方法会与 methods 中的方法合并成功组件对象的方法
  - 如果有重名, setup 优先
  - 注意:
  - 一般不要混合使用: methods 中可以访问 setup 提供的属性和方法, 但在 setup 方法中不能访问 data 和 methods
  - setup 不能是一个 async 函数: 因为返回值不再是 return 的对象, 而是 promise, 模板看不到 return 对象中的属性数据

- setup 的参数
  - setup(props, context) / setup(props, {attrs, slots, emit})
  - props: 包含 props 配置声明且传入了的所有属性的对象
  - attrs: 包含没有在 props 配置中声明的属性的对象, 相当于 this.\$attrs
  - slots: 包含所有传入的插槽内容的对象, 相当于 this.\$slots
  - emit: 用来分发自定义事件的函数, 相当于 this.\$emit

```vue
<template>
  <h2>App</h2>
  <p>msg: {{ msg }}</p>
  <button @click="fn('--')">更新</button>
  <child :msg="msg" msg2="cba" @fn="fn" />
</template>

<script lang="ts">
import { reactive, ref } from 'vue'
import child from './child.vue'
export default {
  components: {
    child
  },
  setup() {
    const msg = ref('abc')
    function fn(content: string) {
      msg.value += content
    }
    return {
      msg,
      fn
    }
  }
}
</script>
```

```vue
<template>
  <div>
    <h3>{{ n }}</h3>
    <h3>{{ m }}</h3>
    <h3>msg: {{ msg }}</h3>
    <h3>msg2: {{ $attrs.msg2 }}</h3>
    <slot name="xxx"></slot>
    <button @click="update">更新</button>
  </div>
</template>

<script lang="ts">
import { ref, defineComponent } from 'vue'

export default defineComponent({
  name: 'child',
  props: ['msg'],
  emits: ['fn'], // 可选的, 声明了更利于程序员阅读, 且可以对分发的事件数据进行校验
  data() {
    console.log('data', this)
    return {
      // n: 1
    }
  },
  beforeCreate() {
    console.log('beforeCreate', this)
  },
  methods: {
    // update () {
    //   this.n++
    //   this.m++
    // }
  },
  // setup (props, context) {
  setup(props, { attrs, emit, slots }) {
    console.log('setup', this)
    console.log(props.msg, attrs.msg2, slots, emit)
    const m = ref(2)
    const n = ref(3)
    function update() {
      // console.log('--', this)
      // this.n += 2
      // this.m += 2
      m.value += 2
      n.value += 2
      // 分发自定义事件
      emit('fn', '++')
    }
    return {
      m,
      n,
      update
    }
  }
})
</script>
```

### setup语法糖就是香

- 组件自动注册
- 组件核心 API
- 属性和方法直接使用，变量自动拆箱装箱

**组件自动注册**

它会自动以文件名为主，也就是不用再写`name`属性了

**组件核心 API**

1.使用 props

通过`defineProps`指定当前 props 类型，获得上下文的props对象。示例：

```vue
<script setup>
  import { defineProps } from 'vue'
  const props = defineProps({
    title: String,
  })
</script>
```

2.使用 emits

使用`defineEmit`定义当前组件含有的事件，并通过返回的上下文去执行 emit。示例：

```vue
<script setup>
  import { defineEmits } from 'vue'
  const emit = defineEmits(['change', 'delete'])
</script>
```

3.获取 slots 和 attrs

可以通过`useContext`从上下文中获取 slots 和 attrs。不过提案在正式通过后，废除了这个语法，被拆分成了`useAttrs`和`useSlots`。示例：

```vue
// 旧
<script setup>
  import { useContext } from 'vue'
  const { slots, attrs } = useContext()
</script>

// 新
<script setup>
  import { useAttrs, useSlots } from 'vue'
  const attrs = useAttrs()
  const slots = useSlots()
</script>
```

4.defineExpose API

传统的写法，我们可以在父组件中，通过 ref 实例的方式去访问子组件的内容，但在 script setup 中，该方法就不能用了，setup 相当于是一个闭包，除了内部的 `template`模板，谁都不能访问内部的数据和方法。

如果需要对外暴露 setup 中的数据和方法，需要使用 defineExpose API。示例：

```vue
<script setup>
 import { defineExpose } from 'vue'
 const a = 1
 const b = 2
 defineExpose({
     a
 })
</script>
```

### 响应式核心-ref

- 作用: 定义一个数据的响应式
- 语法: const xxx = ref(initValue):
  - 创建一个包含响应式数据的引用(reference)对象
  - js 中操作数据: xxx.value
  - 模板中操作数据: 不需要.value
- 一般用来定义一个基本类型的响应式数据,实际开发中强烈推荐用这个-万物皆可用ref。

```vue
<template>
  <h2>{{ count }}</h2>
  <hr />
  <button @click="update">更新</button>
</template>

<script>
import { ref } from 'vue'
export default {
  /* 在Vue3中依然可以使用data和methods配置, 但建议使用其新语法实现 */
  // data () {
  //   return {
  //     count: 0
  //   }
  // },
  // methods: {
  //   update () {
  //     this.count++
  //   }
  // }

  /* 使用vue3的composition API */
  setup() {
    // 定义响应式数据 ref对象
    const count = ref(1)
    console.log(count)

    // 更新响应式数据的函数
    function update() {
      // alert('update')
      count.value = count.value + 1
    }

    return {
      count,
      update
    }
  }
}
</script>
```

> **ref 获取元素**

利用 ref 函数获取组件中的标签元素

功能需求: 让输入框自动获取焦点

```vue
<template>
  <h2>App</h2>
  <input type="text" />
  <input type="text" ref="inputRef" />
</template>
<script lang="ts">
import { onMounted, ref } from 'vue'
/*
ref获取元素: 利用ref函数获取组件中的标签元素
功能需求: 让输入框自动获取焦点
*/
export default {
  setup() {
    const inputRef = ref<HTMLElement | null>(null)
    onMounted(() => {
      inputRef.value && inputRef.value.focus()
    })
    return {
      inputRef
    }
  }
}
</script>
```

多个ref情况：`itemRefs` 不必是数组：它也可以是一个对象，其 ref 可以通过迭代的 key 被设置。如有需要，`itemRefs` 也可以是响应式的，且可以被侦听。

```
<template>
  <div v-for="(item, i) in list" :ref="el => { if (el) divs[i] = el }">
    {{ item }}
  </div>
</template>
<script>
  import { ref, reactive, onBeforeUpdate } from 'vue'
  export default {
    setup() {
      const list = reactive([1, 2, 3])
      const divs = ref([])
      // 确保在每次更新之前重置ref
      onBeforeUpdate(() => {
        divs.value = []
      })
      return {
        list,
        divs
      }
    }
  }
</script>
```

### 响应式核心-reactive

- 作用: 定义多个数据的响应式
- const proxy = reactive(obj): 接收一个普通对象然后返回该普通对象的响应式代理器对象
- 响应式转换是“深层的”：会影响对象内部所有嵌套的属性
- 内部基于 ES6 的 Proxy 实现，通过代理对象操作源对象内部数据都是响应式的

```vue
<template>
  <h2>name: {{ state.name }}</h2>
  <h2>age: {{ state.age }}</h2>
  <h2>wife: {{ state.wife }}</h2>
  <hr />
  <button @click="update">更新</button>
</template>

<script>
/*
reactive:
    作用: 定义多个数据的响应式
    const proxy = reactive(obj): 接收一个普通对象然后返回该普通对象的响应式代理器对象
    响应式转换是“深层的”：会影响对象内部所有嵌套的属性
    内部基于 ES6 的 Proxy 实现，通过代理对象操作源对象内部数据都是响应式的
*/
import { reactive } from 'vue'
export default {
  setup() {
    /*
    定义响应式数据对象
    */
    const state = reactive({
      name: 'tom',
      age: 25,
      wife: {
        name: 'marry',
        age: 22
      }
    })
    console.log(state, state.wife)

    const update = () => {
      state.name += '--'
      state.age += 1
      state.wife.name += '++'
      state.wife.age += 2
    }

    return {
      state,
      update
    }
  }
}
</script>
```

 **reactive 与 ref细节**

- 是 Vue3 的 composition API 中 2 个最重要的响应式 API
- ref 用来处理基本类型数据, reactive 用来处理对象(递归深度响应式)
- 如果用 ref 对象/数组, 内部会自动将对象/数组转换为 reactive 的代理对象
- ref 内部: 通过给 value 属性添加 getter/setter 来实现对数据的劫持
- reactive 内部: 通过使用 Proxy 来实现对对象内部所有数据的劫持, 并通过 Reflect 操作对象内部数据
- ref 的数据操作: 在 js 中要.value, 在模板中不需要(内部解析模板时会自动添加.value)

```vue
<template>
  <h2>App</h2>
  <p>m1: {{ m1 }}</p>
  <p>m2: {{ m2 }}</p>
  <p>m3: {{ m3 }}</p>
  <button @click="update">更新</button>
</template>

<script lang="ts">
import { reactive, ref } from 'vue'

export default {
  setup() {
    const m1 = ref('abc')
    const m2 = reactive({ x: 1, y: { z: 'abc' } })

    // 使用ref处理对象  ==> 对象会被自动reactive为proxy对象
    const m3 = ref({ a1: 2, a2: { a3: 'abc' } })
    console.log(m1, m2, m3)
    console.log(m3.value.a2) // 也是一个proxy对象

    function update() {
      m1.value += '--'
      m2.x += 1
      m2.y.z += '++'

      m3.value = { a1: 3, a2: { a3: 'abc---' } }
      m3.value.a2.a3 += '==' // reactive对对象进行了深度数据劫持
      console.log(m3.value.a2)
    }

    return {
      m1,
      m2,
      m3,
      update
    }
  }
}
</script>
```

### 响应式核心-computed与watch 

- computed 函数:

  - 与 computed 配置功能一致
  - 只有 getter
  - 有 getter 和 setter

- watch 函数

  - 与 watch 配置功能一致
  - 监视指定的一个或多个响应式数据, 一旦数据变化, 就自动执行监视回调
  - 默认初始时不执行回调, 但可以通过配置 immediate 为 true, 来指定初始时立即执行第一次
  - 通过配置 deep 为 true, 来指定深度监视

- watchEffect 函数
  - 不用直接指定要监视的数据, 回调函数中使用的哪些响应式数据就监视哪些响应式数据
  - 默认初始时就会执行第一次, 从而可以收集需要监视的数据
  - 监视数据发生变化时回调

```vue
<template>
  <h2>App</h2>
  fistName:
  <input v-model="user.firstName" />
  <br />
  lastName:
  <input v-model="user.lastName" />
  <br />
  fullName1:
  <input v-model="fullName1" />
  <br />
  fullName2:
  <input v-model="fullName2" />
  <br />
  fullName3:
  <input v-model="fullName3" />
  <br />
</template>

<script lang="ts">
import { reactive, ref, computed, watch, watchEffect } from 'vue'

export default {
  setup() {
    const user = reactive({
      firstName: 'A',
      lastName: 'B'
    })

    // 只有getter的计算属性
    const fullName1 = computed(() => {
      console.log('fullName1')
      return user.firstName + '-' + user.lastName
    })

    // 有getter与setter的计算属性
    const fullName2 = computed({
      get() {
        console.log('fullName2 get')
        return user.firstName + '-' + user.lastName
      },

      set(value: string) {
        console.log('fullName2 set')
        const names = value.split('-')
        user.firstName = names[0]
        user.lastName = names[1]
      }
    })

    const fullName3 = ref('')

    /*
    watchEffect: 监视所有回调中使用的数据
    */
    /*
    watchEffect(() => {
      console.log('watchEffect')
      fullName3.value = user.firstName + '-' + user.lastName
    })
    */

    /*
    使用watch的2个特性:
      深度监视
      初始化立即执行
    */
    watch(
      user,
      () => {
        fullName3.value = user.firstName + '-' + user.lastName
      },
      {
        immediate: true, // 是否初始化立即执行一次, 默认是false
        deep: true // 是否是深度监视, 默认是false
      }
    )

    /*
    watch一个数据
      默认在数据发生改变时执行回调
    */
    watch(fullName3, value => {
      console.log('watch')
      const names = value.split('-')
      user.firstName = names[0]
      user.lastName = names[1]
    })

    /*
    watch多个数据:
      使用数组来指定
      如果是ref对象, 直接指定
      如果是reactive对象中的属性,  必须通过函数来指定
    */
    watch([() => user.firstName, () => user.lastName, fullName3], values => {
      console.log('监视多个数据', values)
    })

    return {
      user,
      fullName1,
      fullName2,
      fullName3
    }
  }
}
</script>
```

**watch、watchEffect区别**

- 1、watch是惰性执行，也就是只有监听的值发生变化的时候才会执行，但是watchEffect不同，每次代码加载watchEffect都会执行（忽略watch第三个参数的配置，如果修改配置项也可以实现立即执行）
- 2、watch需要传递监听的对象，watchEffect不需要
- 3、watch只能监听响应式数据：ref定义的属性和reactive定义的对象，如果直接监听reactive定义对象中的属性是不允许的，除非使用函数转换一下
- 4、watchEffect如果监听reactive定义的对象是不起作用的，只能监听对象中的属性。

> `watch` 和 `watchEffect` 会共享以下四种行为：
>
> - `停止监听`：组件卸载时都会自动停止监听
> - `清除副作用`：onInvalidate 会作为回调的第三个参数传入
> - `副作用刷新时机`：响应式系统会缓存副作用函数，并异步刷新，避免同一个 tick 中多个状态改变导致的重复调用
> - `监听器调试`：开发模式下可以用 onTrack 和 onTrigger 进行调试

```js
  let count = ref(0)
    let countObj = reactive({count: 0})

    // 惰性，首次加载不执行
    watch(count, (newVal, oldVal) =>{console.log(newVal, oldVal)} )
    // watch 不能直接监听reactive里面的属性，只能监听ref、reactiveObject， function， array, 如果想监听reactive的某个属性，那么需要转换成函数
    watch(() => countObj.count, (newVal, oldVal) => {console.log(oldVal, newVal)}, {})
    watch (countObj, (newVal, oldVal) => {
      console.log(newVal, oldVal)
    })
    // 监听多个值，前面是监听数据的数组，后面的参数是两个数组，前面数组是变化后监听对象值的数组，后面是变化前监听对象值的数组
    watch ([countObj, count], ([oneNewName, twoNewName], [oneOldName, twoOldName]) => {
      console.log(oneNewName, oneOldName, twoNewName, twoOldName)
    })
    // watchEffect，和watch不一样，1、会立即执行，只要定义了就会执行。2、他只能监听某个值，监听对象不管用。3、不需要传递参数，会自动管制代码中的变量。4、没法获取newVal和oldVal
    const watchEf = watchEffect(() => {
      console.log(countObj.count)
    })
```

**watchEffect副作用函数**

定义：watchEffect的第三个参数是用于注册副作用清理的回调函数，该回调函数会在副作用函数下一次重新执行前调用，多用于取消重复请求、防抖、事件注册销毁等。

```js
// 取消重复请求
watch(source, async (old, new, OnCleanup) => {
  // 是否过期是标志
  let expired = false
  // 注册过期回调
  OnCleanup(()=> {
    expired = true
  })
 const res = await fetch('something')
 // 如果未过期，那么可以取res为finalData
 if (!expired) {
   finalData = res
 }
})

// 防抖
const id = ref(13)
watchEffect(onInvalidate => {
   // 异步请求
  const token = performAsyncOperation(id.value)
  // 如果id频繁改变，会触发失效函数，取消之前的接口请求
  onInvalidate(() => {
    // id has changed or watcher is stopped.
    // invalidate previously pending async operation
    token.cancel()
  })
})

// dom的事件监听和取消监听
onMounted(()=>{
  watchEffect((onInvalidate) => {
    document.querySelector('.btn').addEventListener('click', handleClick, false)
    onInvalidate(() => document.querySelector('.btn').removeEventListener('click', handleClick))
  })
})
```

### 响应式-工具函数

**ref相关**

- isRef()：检查某个值是否为ref
- unref()：如果参数为ref，则返回其内部的值，否则返回参数本身
- toRef()：toRef 可以响应对象 Object ，其针对的是某一个响应式对象（ reactive 封装）的属性prop 。与 toRef 不一样的是， toRefs 是针对整个对象的所有属性，目标在于将响应式对象（ reactive 封装）转换为普通对象
- toRefs()：普通对象里的每一个属性 prop 都对应一个 ref，常用于想要在合成函数中返回响应式对象

**is相关**

- isProxy()：检查一个对象是否是由 reactive()、readonly()、shallowReactive() 或 shallowReadonly() 创建的代理
- isReactive()：检查一个对象是否是由 reactive() 或 shallowReactive() 创建的代理
- isReadonly()：检查一个对象是否是由 readonly() 或 shallowReadonly() 创建的代理

> **toRef**

- 为源响应式对象上的某个属性创建一个 ref 对象, 二者内部操作的是同一个数据值, 更新时二者是同步的
- 区别 ref: 拷贝了一份新的数据值单独操作, 更新时相互不影响
- 应用: 当要将 某个 prop 的 ref 传递给复合函数时，toRef 很有用

```vue
<template>
  <h2>App</h2>
  <p>{{ state }}</p>
  <p>{{ foo }}</p>
  <p>{{ foo2 }}</p>
  <button @click="update">更新</button>
  <Child :foo="foo" />
</template>

<script lang="ts">
/*
toRef:
  为源响应式对象上的某个属性创建一个 ref对象, 二者内部操作的是同一个数据值, 更新时二者是同步的
  区别ref: 拷贝了一份新的数据值单独操作, 更新时相互不影响
  应用: 当要将某个 prop 的 ref 传递给复合函数时，toRef 很有用
*/

import { reactive, toRef, ref } from 'vue'
import Child from './Child.vue'

export default {
  setup() {
    const state = reactive({
      foo: 1,
      bar: 2
    })

    const foo = toRef(state, 'foo')
    const foo2 = ref(state.foo)
    const update = () => {
      state.foo++
      // foo.value++
      // foo2.value++  // foo和state中的数据不会更新
    }

    return {
      state,
      foo,
      foo2,
      update
    }
  },
  components: {
    Child
  }
}
</script>
```

```vue
<template>
  <h2>Child</h2>
  <h3>{{ foo }}</h3>
  <h3>{{ length }}</h3>
</template>

<script lang="ts">
import { computed, defineComponent, Ref, toRef } from 'vue'

const component = defineComponent({
  props: {
    foo: {
      type: Number,
      require: true
    }
  },

  setup(props, context) {
    const length = useFeatureX(toRef(props, 'foo'))

    return {
      length
    }
  }
})

function useFeatureX(foo: Ref) {
  const lenth = computed(() => foo.value.length)

  return lenth
}

export default component
</script>
```

> **toRefs**

把一个响应式对象转换成普通对象，该普通对象的每个 property 都是一个 ref

应用: 当从合成函数返回响应式对象时，toRefs 非常有用，这样消费组件就可以在不丢失响应式的情况下对返回的对象进行分解使用

问题: reactive 对象取出的所有属性值都是非响应式的

解决: 利用 toRefs 可以将一个响应式 reactive 对象的所有原始属性转换为响应式的 ref 属性

```vue
<template>
  <h2>App</h2>
  <h3>foo: {{ foo }}</h3>
  <h3>bar: {{ bar }}</h3>
  <h3>foo2: {{ foo2 }}</h3>
  <h3>bar2: {{ bar2 }}</h3>
</template>

<script lang="ts">
import { reactive, toRefs } from 'vue'
/*
toRefs:
  将响应式对象中所有属性包装为ref对象, 并返回包含这些ref对象的普通对象
  应用: 当从合成函数返回响应式对象时，toRefs 非常有用，
        这样消费组件就可以在不丢失响应式的情况下对返回的对象进行分解使用
*/
export default {
  setup() {
    const state = reactive({
      foo: 'a',
      bar: 'b'
    })

    const stateAsRefs = toRefs(state)

    setTimeout(() => {
      state.foo += '++'
      state.bar += '++'
    }, 2000)

    const { foo2, bar2 } = useReatureX()

    return {
      // ...state,
      ...stateAsRefs,
      foo2,
      bar2
    }
  }
}

function useReatureX() {
  const state = reactive({
    foo2: 'a',
    bar2: 'b'
  })

  setTimeout(() => {
    state.foo2 += '++'
    state.bar2 += '++'
  }, 2000)

  return toRefs(state)
}
</script>
```

### 响应式-进阶函数

**响应式**

- shallowRef()：ref的浅层作用形式，和ref()不同的是，浅层ref的内部值将会原样存储和暴露，并且不会被深层递归转为响应式。只有.value的访问是响应式的。常见场景：①对大型数据结构的性能优化；②外部的状态管理系统集成。
- triggerRef()：强制触发【依赖于浅层ref的副作用】，常用于：对浅引用shallowRef的内部值进行深度变更时。
- customRef()：创建一个自定义ref，显示地声明将要对其进行【依赖追踪】和【更新触发】的控制方式。一般来说，track()应该在get()方法中调用，而trigger()方法应该在set()中调用。但其实，想要怎么调用，自己来控制就好啦！常用场景：防抖场景
- shallowReactive()：reactive()的浅层作用形式。和reactive不同的是，这里没有深层级的转换，它只有【根级别】的属性是响应式的。属性的值乎一杯原样存储和暴露，这也就意味着值为ref的属性【不会被自动解包】。

**只读**

- shallowReadonly()：readonly()的浅层作用形式。和readonly()不同的是，这里没有深层级的转换。只有根层级的属性变为了只读，其他层级的都可以正常访问。属性的值都会被原样存储和暴露，这也意味着根部【值为ref的属性】不会被自动解包。

**raw**

- toRaw()：根据一个vue创建的代理，返回其【原始对象】。toRaw可以返回由reactive()、readonly()、shallowReactive()创建的代理所对应的原始对象。常用于：①可以临时读取而不会引起代理访问/跟踪开销的场景；② 可以写入而不触发更改的特殊方法。

  不建议保存对原始对象的持久引用，要注意谨慎使用

- markRaw()：将一个对象标记为【不可被转为代理】，返回该【对象本身】。可以理解为让对象【不能拥有响应式功能】。markRaw()和类似shallowReactive()这样的浅层式API可以使你有选择地避开默认的深度响应/只读转换，并在状态关系中嵌入原始的、非代理的对象。

  谨慎使用的几点原因：

  - 有些值不应该是响应式的，例如复杂的第三方类实例或 Vue 组件对象。
  - 当呈现带有【不可变数据源】的大型列表时，跳过代理转换可以提高性能。
  - 这可以说是一种进阶需求，因为只在根层访问能到原始值，所以如果把一个嵌套的、没有标记的原始对象设置成一个响应式对象，然后再次访问它，你获取到的是代理的版本。
  - 它可能会导致对象身份风险，即执行一个依赖于对象身份的操作，但却同时使用了同一对象的原始版本和代理版本。

**scope**

- effectScope()：可以处理掉所创建的响应式副作用（即计算属性和侦听器watch/watchEffect）。也就是说，如果你创建了【无用的】响应式数据，那么可以通过effectScope()这个API，来处理掉这些无用的副作用
- getCurrentScope()：如果有的话，返回当前活跃的【effect作用域】，即effectScope()中活跃的作用域
- onScopeDispose()：在当前活跃的effect作用域上，注册一个处理回调的函数。当相关的effect作用域停止时，将会调用上述这个回调函数。常用场景：这个方法可以作为【可复用的组合式函数】中【onUnmounted】的替代品，且它不会与组件耦合，因为对于每一个vue组件的setup()函数来说，它们也是在一个【effect作用域】中调用的。

> **shallowReactive 与 shallowRef**

- shallowReactive : 只处理了对象内最外层属性的响应式(也就是浅响应式)
- shallowRef: 只处理了 value 的响应式, 不进行对象的 reactive 处理

- 什么时候用浅响应式呢?
  - 一般情况下使用 ref 和 reactive 即可
  - 如果有一个对象数据, 结构比较深, 但变化时只是外层属性变化 ===> shallowReactive
  - 如果有一个对象数据, 后面会产生新的对象来替换 ===> shallowRef

```vue
<template>
  <h2>App</h2>
  <h3>m1: {{ m1 }}</h3>
  <h3>m2: {{ m2 }}</h3>
  <h3>m3: {{ m3 }}</h3>
  <h3>m4: {{ m4 }}</h3>
  <button @click="update">更新</button>
</template>

<script lang="ts">
import { reactive, ref, shallowReactive, shallowRef } from 'vue'
/*
shallowReactive与shallowRef
  shallowReactive: 只处理了对象内最外层属性的响应式(也就是浅响应式)
  shallowRef: 只处理了value的响应式, 不进行对象的reactive处理
总结:
  reactive与ref实现的是深度响应式, 而shallowReactive与shallowRef是浅响应式
  什么时候用浅响应式呢?
    一般情况下使用ref和reactive即可,
    如果有一个对象数据, 结构比较深, 但变化时只是外层属性变化 ===> shallowReactive
    如果有一个对象数据, 后面会产生新的对象来替换 ===> shallowRef
*/
export default {
  setup() {
    const m1 = reactive({ a: 1, b: { c: 2 } })
    const m2 = shallowReactive({ a: 1, b: { c: 2 } })
    const m3 = ref({ a: 1, b: { c: 2 } })
    const m4 = shallowRef({ a: 1, b: { c: 2 } })

    const update = () => {
      // m1.b.c += 1
      // m2.b.c += 1
      // m3.value.a += 1
      m4.value.a += 1
    }
    return {
      m1,
      m2,
      m3,
      m4,
      update
    }
  }
}
</script>
```

> **customRef**

- 创建一个自定义的 ref，并对其依赖项跟踪和更新触发进行显式控制
- 需求: 使用 customRef 实现 debounce 的示例

```vue
<template>
  <h2>App</h2>
  <input v-model="keyword" placeholder="搜索关键字" />
  <p>{{ keyword }}</p>
</template>

<script lang="ts">
/*
customRef:
  创建一个自定义的 ref，并对其依赖项跟踪和更新触发进行显式控制

需求:
  使用 customRef 实现 debounce 的示例
*/

import { ref, customRef } from 'vue'

export default {
  setup() {
    const keyword = useDebouncedRef('', 500)
    console.log(keyword)
    return {
      keyword
    }
  }
}

/*
实现函数防抖的自定义ref
*/
function useDebouncedRef<T>(value: T, delay = 200) {
  let timeout: number
  return customRef((track, trigger) => {
    return {
      get() {
        // 告诉Vue追踪数据
        track()
        return value
      },
      set(newValue: T) {
        clearTimeout(timeout)
        timeout = setTimeout(() => {
          value = newValue
          // 告诉Vue去触发界面更新
          trigger()
        }, delay)
      }
    }
  })
}
</script>
```

> **readonly 与 shallowReadonly**

- readonly:
  - 深度只读数据
  - 获取一个对象 (响应式或纯对象) 或 ref 并返回原始代理的只读代理。
  - 只读代理是深层的：访问的任何嵌套 property 也是只读的。
- shallowReadonly
  - 浅只读数据
  - 创建一个代理，使其自身的 property 为只读，但不执行嵌套对象的深度只读转换
- 应用场景:
  - 在某些特定情况下, 我们可能不希望对数据进行更新的操作, 那就可以包装生成一个只读代理对象来读取数据, 而不能修改或删除

```vue
<template>
  <h2>App</h2>
  <h3>{{ state }}</h3>
  <button @click="update">更新</button>
</template>

<script lang="ts">
import { reactive, readonly, shallowReadonly } from 'vue'
/*
readonly: 深度只读数据
  获取一个对象 (响应式或纯对象) 或 ref 并返回原始代理的只读代理。
  只读代理是深层的：访问的任何嵌套 property 也是只读的。
shallowReadonly: 浅只读数据
  创建一个代理，使其自身的 property 为只读，但不执行嵌套对象的深度只读转换
应用场景:
  在某些特定情况下, 我们可能不希望对数据进行更新的操作, 那就可以包装生成一个只读代理对象来读取数据, 而不能修改或删除
*/

export default {
  setup() {
    const state = reactive({
      a: 1,
      b: {
        c: 2
      }
    })

    // const rState1 = readonly(state)
    const rState2 = shallowReadonly(state)

    const update = () => {
      // rState1.a++ // error
      // rState1.b.c++ // error

      // rState2.a++ // error
      rState2.b.c++
    }

    return {
      state,
      update
    }
  }
}
</script>
```

> **toRaw 与 markRaw**

- toRaw
  - 返回由 `reactive` 或 `readonly` 方法转换成响应式代理的普通对象。
  - 这是一个还原方法，可用于临时读取，访问不会被代理/跟踪，写入时也不会触发界面更新。
- markRaw
  - 标记一个对象，使其永远不会转换为代理。返回对象本身
  - 应用场景:
    - 有些值不应被设置为响应式的，例如复杂的第三方类实例或 Vue 组件对象。
    - 当渲染具有不可变数据源的大列表时，跳过代理转换可以提高性能。

```vue
<template>
  <h2>{{ state }}</h2>
  <button @click="testToRaw">测试toRaw</button>
  <button @click="testMarkRaw">测试markRaw</button>
</template>

<script lang="ts">
/*
toRaw: 得到reactive代理对象的目标数据对象
*/
import { markRaw, reactive, toRaw } from 'vue'
export default {
  setup() {
    const state = reactive<any>({
      name: 'tom',
      age: 25
    })

    const testToRaw = () => {
      const user = toRaw(state)
      user.age++ // 界面不会更新
    }

    const testMarkRaw = () => {
      const likes = ['a', 'b']
      // state.likes = likes
      state.likes = markRaw(likes) // likes数组就不再是响应式的了
      setTimeout(() => {
        state.likes[0] += '--'
      }, 1000)
    }

    return {
      state,
      testToRaw,
      testMarkRaw
    }
  }
}
</script>
```

### 响应性语法糖(已废弃)

[废弃原因](https://github.com/vuejs/rfcs/discussions/369#discussioncomment-5059028)：最重要的是，碎片化的潜在风险。

- let count = $ref(0)
- function myCreateRef() {  *return* ref(0) } let count = $(myCreateRef())
- const {num} =} = defineProps<>()

### 依赖注入provide 与 inject

- provide`和`inject`提供依赖注入，功能类似 2.x 的`provide/inject

- 实现跨层级组件(祖孙)间通信

```vue
<template>
  <h1>父组件</h1>
  <p>当前颜色: {{ color }}</p>
  <button @click="color = 'red'">红</button>
  <button @click="color = 'yellow'">黄</button>
  <button @click="color = 'blue'">蓝</button>

  <hr />
  <Son />
</template>

<script lang="ts">
import { provide, ref } from 'vue'
/*
- provide` 和 `inject` 提供依赖注入，功能类似 2.x 的 `provide/inject
- 实现跨层级组件(祖孙)间通信
*/

import Son from './Son.vue'
export default {
  name: 'ProvideInject',
  components: {
    Son
  },
  setup() {
    const color = ref('red')

    provide('color', color)

    return {
      color
    }
  }
}
</script>
```

```vue
<template>
  <div>
    <h2>子组件</h2>
    <hr />
    <GrandSon />
  </div>
</template>

<script lang="ts">
import GrandSon from './GrandSon.vue'
export default {
  components: {
    GrandSon
  }
}
</script>
```

```vue
<template>
  <h3 :style="{ color }">孙子组件: {{ color }}</h3>
</template>

<script lang="ts">
import { inject } from 'vue'
export default {
  setup() {
    const color = inject('color')

    return {
      color
    }
  }
}
</script>
```

## 五大API-选项式API

选项式API —— vue2所拥有的选项式API

### 状态选项

- data
- props
- computed
- methods
- watch
- emits：用于声明由组件触发的自定义事件
- expose：用于声明"当组件实例被父组件通过模板引用访问时"所暴露的公共属性

### 渲染选项

- template：用于声明组件的字符串模板。如果 render 选项也同时存在于该组件中，template 将被忽略。
- render：用于编程式地创建组件虚拟 DOM 树的函数
- compilerOptions：用于配置组件模板在运行时的编译器选项。仅在使用完整构建版本时才有效（浏览器运行vue.js文件时才有效，可以理解为html里面引用了vue.js的脚本）

### 组合选项

- provide：提供可以被后代组件注入的值
- inject：声明来自于上层想要注入进当前组件的属性
- mixins：mixins是一个包含”组件选项对象的”数组，这些选项都将被混入到当前组件的实例中
- extends：将要继承的“基类”组件

## 五大API-内置内容

内置内容 —— 指令、组件、特殊元素和特殊属性

### **指令**

- v-for：如果跟v-if一起使用时，v-if的优先级更高，但不推荐一起使用，容易造成各种混淆
- v-slot：主要用途：①声明具名插槽；②期望接收props的作用域插槽。

### **组件**

- TransitionGroup：为列表中多个元素提供过度效果
- KeepAlive
- Teleport：将插槽内容渲染到Dom的另外一个位置
- Suspense：解决异步问题

**Teleport(瞬移)**

- Vue3 提供`Teleport`组件可将部分DOM移动到 Vue app之外的位置。比如项目中常见的`Dialog`组件。

ModalButton.vue

```vue
<template>
  <button @click="modalOpen = true"></button>
  <teleport to="body">
    <div v-if="modalOpen" class="modal">
      <div><button @click="modalOpen = false">Close</button></div>
    </div>
  </teleport>
</template>
<script>
import { ref } from 'vue'
export default {
  name: 'modal-button',
  setup() {
    const modalOpen = ref(false)
    return {
      modalOpen
    }
  }
}
</script>
<style>
.modal {
  position: absolute;
  top: 0;
  right: 0;
  bottom: 0;
  left: 0;
  background-color: rgba(0, 0, 0, 0.5);
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
}

.modal div {
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  background-color: white;
  width: 300px;
  height: 300px;
  padding: 5px;
}
</style>
```

App.vue

```vue
<template>
  <h2>App</h2>
  <modal-button></modal-button>
</template>
<script lang="ts">
import ModalButton from './ModalButton.vue'

export default {
  setup() {
    return {}
  },
  components: {
    ModalButton
  }
}
</script>
```

**Suspense(不确定的)**

- Vue3 提供 `Suspense`组件，允许程序在等待异步组件时渲染兜底的内容，如 loading ，使用户体验更平滑。使用它，需在模板中声明，并包括两个命名插槽：`default`和`fallback`。`Suspense`确保加载完异步内容时显示默认插槽，并将`fallback`插槽用作加载状态。

```vue
<template>
  <Suspense>
    <template #default>
      <AsyncComp />
      <!-- <AsyncAddress/> -->
    </template>
    <template #fallback>
      <h1>LOADING...</h1>
    </template>
  </Suspense>
</template>
<script lang="ts">
/*
异步组件 + Suspense组件
*/
// import AsyncComp from './AsyncComp.vue'
import AsyncAddress from './AsyncAddress.vue'
import { defineAsyncComponent } from 'vue'
const AsyncComp = defineAsyncComponent(() => import('./AsyncComp.vue'))
export default {
  setup() {
    return {}
  },
  components: {
    AsyncComp,
    AsyncAddress
  }
}
</script>
```

- AsyncComp.vue

```vue
<template>
  <h2>AsyncComp22</h2>
  <p>{{ msg }}</p>
</template>

<script lang="ts">
export default {
  name: 'AsyncComp',
  setup() {
    // return new Promise((resolve, reject) => {
    //   setTimeout(() => {
    //     resolve({
    //       msg: 'abc'
    //     })
    //   }, 2000)
    // })
    return {
      msg: 'abc'
    }
  }
}
</script>
```

- AsyncAddress.vue

```vue
<template>
  <h2>{{ data }}</h2>
</template>

<script lang="ts">
import axios from 'axios'
export default {
  async setup() {
    const result = await axios.get('/data/address.json')
    return {
      data: result.data
    }
  }
}
</script>
```

### img动态图片

解法1:在将asset 前面加上src

```
<img :src="`/src/assets/blogPhotos/${name}.jpg`" />
```

解法2：官网说：“实际上，Vite 并不需要在开发阶段处理这些代码！在生产构建时，Vite 才会进行必要的转换保证 URL 在打包和资源哈希后仍指向正确的地址。”

```
<img :src="" alt="getImageUrl(name)" />
function getImageUrl(name) {
    return new URL(`../assets/blogPhotos/${name}.jpg`, import.meta.url).href;
}
```

### 状态驱动的动态 CSS

```
<script setup>
const size = 10
</script>
<style scoped>
.home {
  width: v-bind(size + "px");
}
</style>
```

### 插槽选择器

默认情况下，作用域样式不会影响到 `<slot/>` 渲染出来的内容，因为它们被认为是父组件所持有并传递进来的。使用 `:slotted` 伪类以确切地将插槽内容作为选择器的目标。

```
// 父组件
<Child3>
  <div class="slot1">我是slot传递过来的</div>
</Child3>
// 子组件里写样式
<style scoped>
:slotted(.slot1) {
  color: red;
}
</style>
// 或者直接在父组件里写样式
<style scoped>
.slot1 {
  color: red;
}
</style>
```

### 样式穿透和全局样式

**样式穿透**

```
// vue2
<style scoped>
.a /deep/ .b {
  /* ... */
}
</style>

// vue3
<style scoped>
.a :deep(.b) {
  /* ... */
}
```

**全局样式和局部样式**

```
局部样式
<style scoped>
/* local styles */
</style>
```

```
全局样式：不带scope
<style>
/* global styles */
</style>

全局样式：使用:global伪类
// 创建一个.red的全局类样式
<style scoped>
:global(.red) {
  color: red;
}
</style>
```

## 五大API-进阶API

进阶API —— 渲染函数、TS工具类型和自定义渲染

**渲染函数**

- h()：创建虚拟DOM节点
- mergeProps()：合并多个props对象，用于处理【含有特定的props参数】的情况

**服务端渲染**

- renderToString()：从 vue/server-renderer 中导出。传入一个可选的上下文对象，可以用来在渲染过程中记录额外的数据，比如：访问teleprt的内容。该上下文对象可以在组件代码里面，通过 useSSRContext 辅助函数来进行访问

**TS工具类型**

- PropType<T>：用于给prop标注更复杂的类型定义
- ComponentCustomProperties：用于增强组件实例类型，以用来更好地支持自定义全局属性。
- ComponentCustomOptions：用于扩展组件选项类型，以更好地支持自定义选项。
- ComponentCustomProps：用于扩展全局可用的 TSX props，以便在TSX元素上，使用从来没有在【组件选项上】定义过的 props
- CSSProperties：在样式属性绑定上，允许有更多种【值的类型】。比如：我们平常只能用color: blue，那么我们可以扩展出一个 --bg-color ，最终就可以用 【‘--bg-color’: 'blue'】来表示

**自定义渲染**

- createRenderer()：从 @vue/runtime-core 中导出，创建一个自定渲染器，通过平台所提供的特定节点，来创建以及更改API，可以在非DOM环境中也享受到Vue核心运行时的特性。

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

## 新用法

### defineOptions 宏

用于自定义组件的 `name`、 `inheritAttrs` 或其他自定义的属性。仅在3.3+版本支持

```
<script setup>
defineOptions({
  name: 'Foo',
  inhritAttrs: false,
  // ... 更多自定义属性
})
</script>

```

低版本可用插件vite-plugin-vue-setup-expend支持name属性

### defineModel 宏

用于双向绑定，当然也可以借助vuesuse库useVModel实现，但开发者需要手动分别调用 `defineProps` 和 `defineEmits`

```
<script setup>
const modelValue = defineModel()
modelValue.value++
</script>
```



## pinia入门

推荐使用使用composition API模式定义store

```
import { ref, computed } from 'vue';
import { defineStore } from 'pinia';

// 使用composition API模式定义store
export const useCounterStoreForSetup = defineStore('counterForSetup', () => {
  const count = ref<number>(1);
  const doubleCount = computed(() => count.value * 2);
  function increment() {
    count.value++;
  }

  return { count, doubleCount, increment };
});

// composition API模式调用
const counterStoreForSetup = useCounterStoreForSetup();
// 确保解构确保后的state具有响应式，要使用storeToRefs方法
const { count, doubleCount } = storeToRefs(counterStoreForSetup);
const { increment } = counterStoreForSetup;
```

## VueUse

是一款基于组合式API的函数集合。

**指南**

核心包括9种函数：

- 动画（Animation）—包含易于使用的过渡、超时和计时函数
- 浏览器（Browser）—可用于不同的屏幕控制、剪贴板、首选项等
- 组件（Component）— 为不同的组件方法提供简写
- Formatters – 提供反应时间格式化功能
- 传感器（Sensors ）—用于监听不同的 DOM 事件、输入事件和网络事件
- 状态（State ）—管理用户状态（全局、本地存储、会话存储）
- 实用程序（Utility）—不同的实用程序函数，如 getter、条件、引用同步等
- Watch —更高级的观察者类型，如可暂停观察者、去抖动观察者和条件观察者

**常用的5大函数**

**1.useVModel**

简化了 v-model 绑定

```
<div v-model="isPop"></div>
import { useVModels } from '@vueuse/core';
const props = defineProps({
  isPop: {
    default: false,
  }})
const { isPop } = useVModels(props, emits);
const emits = defineEmits(['update:isPop']);
// 修改值
isPop.value = true
```

**2.onClickOutside**

关闭模态

```
<button @click="open = true"> Open Popup </button>
  <div class="popup" v-if='open'>
  我是弹窗
  </div>
 import { onClickOutside } from '@vueuse/core'
 const open = ref(false) // state of our popup
const popup = ref() // template ref
onClickOutside(popup, () => {
  open.value  = false
})
```

**3.useTransition** 

允许我们在一行内平滑地转换数值

步骤：

> - 创建我们的 `count` ref并将其初始化为零
> - 使用 `useTransition` 创建 `output` ref(设置持续时间和转换类型)
> - 更改 `count` 的值

```
<template>
  <h2> 
    <p> Join over </p>
    <p> {{ Math.round(output) }}+ </p>
    <p>Developers </p>
  </h2>
</template>

<script setup>
import { ref } from 'vue'
import { useTransition, TransitionPresets } from '@vueuse/core'
const source = ref()
const output = useTransition(source, {
  duration: 3000,
  transition: TransitionPresets.easeOutExpo,
})
source.value = 5000
</script>
```

**4.useRefHistory** 

`useRefHistory` 跟踪对Ref所做的每一个改变，并将其存储在一个数组中。这使我们能够轻松地为我们的应用程序提供撤销和重做功能。

**5.useIntersectionObserver**

在确定两个元素是否重叠时，[Intersection Observers ](https://link.juejin.cn/?target=https%3A%2F%2Fdeveloper.mozilla.org%2Fen-US%2Fdocs%2FWeb%2FAPI%2FIntersectionObserver)非常强大。一个很好的用例是检查元素当前是否在视口中可见。

# 高级

## 案例-实现switch 功能组件

一般比较粗暴简单的办法是if判断，或者component动态组件。

这里我们使用render函数处理slot，动态判断插槽显示。

```
// App.vue
<script setup lang="ts">
import { ref } from "vue";
import VSwitch from './components/VSwitch.vue'

const name = ref('bar')
</script>
<template>
    <v-switch :case="name">
        <template #foo>
            foo
        </template>
        <template #bar>
            bar
        </template>
        <template #default>
            default
        </template>
    </v-switch>
</template>

// VSwitch.vue
<script lang="ts">
import { defineComponent}  from 'vue'
export default defineComponent({
    props:['case'],
    setup(props,{slots}){
        return ()=>{
            if(slots[props.case]){
                return slots[props.case]();
            }
            if(slots['default']){
                return slots['default']()
            }
        }
    }
})
</script>
```

## 使用Ref还是Reactive？

- [使用Ref还是Reactive？](https://www.cnblogs.com/chuckQu/p/17350975.html)
- [`reactive`和 `ref` 对比](https://zhuanlan.zhihu.com/p/656470876)

> 一句话总结：默认情况下使用`ref`，当你需要对变量分组时使用`reactive`。(在一个`reactive`对象中对`ref`分组)

| reactive                                | ref                                                       |
| --------------------------------------- | --------------------------------------------------------- |
| ❌只支持对象和数组(引用数据类型)         | ✅支持基本数据类型+引用数据类型                            |
| ✅在 <script> 和 <template> 中无差别使用 | ❌在 <script> 和 <template> 使用方式不同(script中要.value) |
| ❌重新分配一个新对象会丢失响应性         | ✅重新分配一个新对象不会失去响应                           |
| 能直接访问属性                          | 需要使用 .value 访问属性                                  |
| ❌将对象传入函数时,失去响应              | ✅传入函数时,不会失去响应                                  |
| ❌解构时会丢失响应性,需使用toRefs        | ❌解构对象时会丢失响应性,需使用toRefs                      |

- ref 用于将**基本类型的数据（如字符串、数字，布尔值等）和引用数据类型(对象)** 转换为响应式数据。使用 ref 定义的数据可以通过 **`.value`** 属性访问和修改。
- reactive 用于将**对象**转换为响应式数据，包括复杂的嵌套对象和数组。使用 reactive 定义的数据可以**直接**访问和修改属性。

一种推荐使用的模式是在 `reactive` 对象中嵌套 refs,如果你不需要响应式的 `state` object，则可以将 refs 放入普通的 JavaScript object 。

```
const loading = ref(true)
const error = ref(null)

const state = reactive({
  loading,
  error,
})

// 可以 watch 响应式 object
watchEffect(() => console.log(state.loading))

// ...和 ref
watch(loading, () => console.log('loading has changed'))

setTimeout(() => {
  loading.value = false
  // 触发所有的 watchers
}, 500)
```
