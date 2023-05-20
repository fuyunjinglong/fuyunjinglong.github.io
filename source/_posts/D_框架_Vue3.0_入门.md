---
title: Vue3.0_入门
date: 2022-06-26 07:33:16
categories:
- D_框架和类库
toc: true # 是否启用内容索引

---

Vue 是一套用于构建用户界面的渐进式框架。Vue.js 3.0 "One Piece" 正式版在 2020 年 9 月份发布,经过了 2 年多开发, 100+位贡献者, 2600+次提交, 600+次 PR，同时 Vue3 也支持 Vue2 的大多数特性,且,更好的支持了 TypeScript,也增加了很多的新特性,如:Composition API,新组件(Fragment/Teleport/Suspense)等等.

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

**教程文章**

比如发布一些 Vue3 的教程：

- [我要成为海贼王的男人-Vue3最全宇宙入口](https://github.com/vue3/vue3-News#%E6%88%91%E6%98%AF%E8%A6%81%E6%88%90%E4%B8%BA%E6%B5%B7%E8%B4%BC%E7%8E%8B%E7%9A%84%E7%94%B7%E4%BA%BA)
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

## 生命周期

**vue2.x 的生命周期**

![lifecycle_2](https://vuejs.org/images/lifecycle.png)

**vue3 的生命周期**

![lifecycle_3](https://v3.cn.vuejs.org/images/lifecycle.png)

> Vue2--------------vue3
> beforeCreate  -> setup() // 开始创建组件之前，在`beforeCreate`和`created`之前执行。创建的是`data`和`method`
> created       -> setup()
> beforeMount   -> onBeforeMount // 组件挂载到节点上之前执行
> mounted       -> onMounted // 组件挂载完成后执行
> beforeUpdate  -> onBeforeUpdate //  组件更新之前执行
> updated       -> onUpdated // 组件更新完成之后执行
> beforeDestroy -> onBeforeUnmount // 组件卸载之前执行
> destroyed     -> onUnmounted // 组件卸载完成后执行
> activated     -> onActivated // 被包含在`<keep-alive>`中的组件，会多出两个生命周期钩子函数。被激活时执行。
> deactivated   -> onDeactivated // 比如从 A 组件，切换到 B 组件，A 组件消失时执行
> errorCaptured -> onErrorCaptured // 当捕获一个来自子孙组件的异常时激活钩子函数

**新增的钩子函数onRenderTracked()和 onRenderTriggered()**

onRenderTracked()

> 直译过来就是`状态跟踪`，它会跟踪页面上所有响应式变量和方法的状态。只要页面有`update`的情况，他就会跟踪，然后生成一个`event`对象。

onRenderTriggered()

> 直译过来是`状态触发`，它不会跟踪每一个值，而是给你变化值的信息，并且新值和旧值都会给你明确的展示出来。 与`watch`相似。
>
> event 对象属性的详细介绍：
>
> - key 那边变量发生了变化
> - newValue 更新后变量的值
> - oldValue 更新前变量的值
> - target 目前页面中的响应变量和函数

```vue
<template>
  <div class="about">
    <h2>msg: {{ msg }}</h2>
    <hr />
    <button @click="update">更新</button>
  </div>
</template>

<script lang="ts">
import { ref, onMounted, onUpdated, onUnmounted, onBeforeMount, onBeforeUpdate, onBeforeUnmount } from 'vue'

export default {
  beforeCreate() {
    console.log('beforeCreate()')
  },

  created() {
    console.log('created')
  },

  beforeMount() {
    console.log('beforeMount')
  },

  mounted() {
    console.log('mounted')
  },

  beforeUpdate() {
    console.log('beforeUpdate')
  },

  updated() {
    console.log('updated')
  },

  beforeUnmount() {
    console.log('beforeUnmount')
  },

  unmounted() {
    console.log('unmounted')
  },

  setup() {
    const msg = ref('abc')

    const update = () => {
      msg.value += '--'
    }

    onBeforeMount(() => {
      console.log('--onBeforeMount')
    })

    onMounted(() => {
      console.log('--onMounted')
    })

    onBeforeUpdate(() => {
      console.log('--onBeforeUpdate')
    })

    onUpdated(() => {
      console.log('--onUpdated')
    })

    onBeforeUnmount(() => {
      console.log('--onBeforeUnmount')
    })

    onUnmounted(() => {
      console.log('--onUnmounted')
    })

    return {
      msg,
      update
    }
  }
}
</script>
```

```vue
<template>
  <h2>App</h2>
  <button @click="isShow = !isShow">切换</button>
  <hr />
  <Child v-if="isShow" />
</template>

<script lang="ts">
import Child from './Child.vue'
export default {
  data() {
    return {
      isShow: true
    }
  },

  components: {
    Child
  }
}
</script>
```

**单组件**

> 页面首次加载
>
> ```
> setup -> onBeforeMount -> onRenderTracked -> onMounted
> ```
>
> 页面更新
>
> ```
> onRenderTriggered -> onBeforeUpdate -> onUpdated
> ```
>
> 页面卸载
>
> ```
> onBeforeUnmount -> onUnmounted
> ```

**父子组件**

> **页面首次加载**
>
> ```
> 父组件setup -> 父组件onBeforeMount -> 父组件onRenderTracked -> 子组件setup -> 子组件onBeforeMount -> 子组件onRenderTracked -> 子组件onMounted -> 父组件onMounted
> ```
>
> **页面更新**
>
> 纯父组件属性更新 `onRenderTriggered -> onBeforeUpdate -> onUpdated`
>
> 纯子组件属性更新 `onRenderTriggered -> onBeforeUpdate -> onUpdated`
>
> 父组件属性更新，该属性在子组件中有被使用 `父组件onRenderTriggered -> 父组件onBeforeUpdate -> 子组件onBeforeUpdate -> 子组件onUpdated -> 父组件onUpdated`
>
> 子组件属性更新，该属性在父组件中有被使用 `子组件onRenderTriggered -> 父组件onRenderTriggered -> 父组件onBeforeUpdate -> 子组件onBeforeUpdate -> 子组件onUpdated -> 父组件onUpdated`
>
> **页面卸载**
>
> ```
> 父组件onBeforeUnmount -> 子组件onBeforeUnmount -> 子组件onUnmounted -> 父组件onUnmounted
> ```

##  setup

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

## setup语法糖就是香

- 组件自动注册
- 组件核心 API
- 属性和方法直接使用

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

**属性和方法直接使用**

定义的属性和方法无需返回，可以直接使用



## ref

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

## reactive

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

## img动态图片

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

## 响应性语法糖(已废弃)

[废弃原因](https://github.com/vuejs/rfcs/discussions/369#discussioncomment-5059028)：最重要的是，碎片化的潜在风险。

- let count = $ref(0)
- function myCreateRef() {  *return* ref(0) } let count = $(myCreateRef())
- const {num} =} = defineProps<>()

## computed与watch 

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

## Hooks

```js
template>
  <p>{{ person.name }}</p>
</template>
<script lang="ts" setup>
// 方式一：export default整体导出，用于复用变量和函数hook
import { usePerson } from "./hooks";
const { person, changePersonName } = usePerson();
// 方式二(更推荐):export单一导出，用于复用函数hook
import { changePersonName } from "./hooks/usePerson";
</script>
```

```vue
// 方式一：export default整体导出，用于复用变量和函数hook。/hooks/usePerson.ts
import { reactive, watch } from "vue";
export default function usePerson() {
  const person = reactive<{ name: string; sex: string }>({
    name: "小明"
  });
  function changePersonName() {
    person.name = "小浪";
  }
  return {
    person,
    changePersonName,
  };
}
 // 方式二：export单一导出，用于复用函数hook。/hooks/usePerson.ts
import { reactive, watch } from "vue";
export changePersonName(person) {
  person.name = "小浪";
}
```

## toRefs

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

## ref 获取元素

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

## Suspense异步组件

Vue3 提供 `Suspense`组件，允许程序在等待异步组件时渲染兜底的内容，如 loading ，使用户体验更平滑。使用它，需在模板中声明，并包括两个命名插槽：`default`和`fallback`。`Suspense`确保加载完异步内容时显示默认插槽，并将`fallback`插槽用作加载状态。

```vue
<tempalte>
   <suspense>
     <template #default>
       <todo-list />
     </template>
     <template #fallback>
       <div>
         Loading...
       </div>
     </template>
   </suspense>
</template>
```

## Teleport

Vue3 提供`Teleport`组件可将部分DOM移动到 Vue app之外的位置。比如项目中常见的`Dialog`组件。

```vue
<button @click=dialogVisible = true>点击</button>
<teleport to=body>
   <div class=dialog v-if=dialogVisible>
   </div>
</teleport>
```

## 样式改动

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

## 状态驱动的动态 CSS

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

## 插槽选择器

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

## Composition API(其它部分)

### shallowReactive 与 shallowRef

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

### readonly 与 shallowReadonly

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

### toRaw 与 markRaw

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

### toRef

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

###  customRef

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

###  provide 与 inject

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

###  响应式数据的判断

- isRef: 检查一个值是否为一个 ref 对象
- isReactive: 检查一个对象是否是由 `reactive` 创建的响应式代理
- isReadonly: 检查一个对象是否是由 `readonly` 创建的只读代理
- isProxy: 检查一个对象是否是由 `reactive` 或者 `readonly` 方法创建的代理

## 其它新组合和API

### 新组件

**1) Fragment(片断)**

- 在 Vue2 中: 组件必须有一个根标签
- 在 Vue3 中: 组件可以没有根标签, 内部会将多个标签包含在一个 Fragment 虚拟元素中
- 好处: 减少标签层级, 减小内存占用

```vue
<template>
  <h2>aaaa</h2>
  <h2>aaaa</h2>
</template>
```

**2) Teleport(瞬移)**

- Teleport 提供了一种干净的方法, 让组件的 html 在父组件界面外的特定标签(很可能是 body)下插入显示

ModalButton.vue

```vue
<template>
  <button @click="modalOpen = true">
    Open full screen modal! (With teleport!)
  </button>

  <teleport to="body">
    <div v-if="modalOpen" class="modal">
      <div>
        I'm a teleported modal! (My parent is "body")
        <button @click="modalOpen = false">
          Close
        </button>
      </div>
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

**3) Suspense(不确定的)**

- 它们允许我们的应用程序在等待异步组件时渲染一些后备内容，可以让我们创建一个平滑的用户体验

```vue
<template>
  <Suspense>
    <template v-slot:default>
      <AsyncComp />
      <!-- <AsyncAddress/> -->
    </template>

    <template v-slot:fallback>
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

### 其他新的 API

**全新的全局 API**

- createApp()
- defineProperty()
- defineAsyncComponent()
- nextTick()

**将原来的全局 API 转移到应用对象**

- app.component()
- app.config()
- app.directive()
- app.mount()
- app.unmount()
- app.use()

**模板语法变化**

- v-model 的本质变化
  - prop：value -> modelValue；
  - event：input -> update:modelValue；
- .sync 修改符已移除, 由 v-model 代替
  - `<ChildComponent v-model:title="pageTitle" v-model:content="pageContent" />`
- v-if 优先 v-for 解析

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



# 高级

## Vue3存在的问题

- 丢失响应性
- Vue3的TypeScript对类型的支持十分孱弱

**一、丢失响应性**

vue3还存在着很多问题 例如对ts支持不够友好 ref.value的混乱 解构丢失响应性（不知道有啥好的实践,目前是使用计算属性） 从体验上远不如vue2 目前个人认为最完善的库是solidjs 可惜生态没跟上来 可能对大家而言react vue并不是最好的解 react一个useeffct官网花6篇文章来描述这个api 我真是笑了 总而言之react vue3写起来不是很润。

你没有发现吗?Vue团队是为了补坑而补坑,Vue2的ref仅仅是引用组件而已,而在Vue3变成了定义响应式变量,这一点我估计是参考了react,但react的运行机制与vue不同,react的ref是定义一个引用,避免组件重新渲染值被重置。

vue3对ts的支持挺不错了，毕竟本身就是用ts写的，模板对ts的支持可能比较弱。
解构这个绕不过去，不是vue3的问题，原生js就是那样，除非魔改，但是魔改的好几版提案都没落地。
只能说各有取舍吧。

**二、Vue3的TypeScript对类型的支持十分孱弱**

参考：[为什么我感觉 Vue 3 TypeScript 还是不行？](https://www.zhihu.com/question/453332049)

几个问题：

1. option props define 的方式定义非常不灵活，这种值定义的思想意味着你必须要用值来定义类型，而不是利用类型来指导值应该长什么样，因此 vue 3 整体的类型设计不得不遭受了这个思想的严重毒害，不得不设计的很复杂（具体详见其 d.ts 实现）
2. 值指导类型下不得不引入 ExtractPropTypes 来将 props 值定义转为类型定义，但 vue 没有提供 ExtractPropTypes 的逆运算，导致在定义共有 props 组件 (props 继承) 的时候十分难受
3. defineComponent 不支持泛型；有个 hack 手段是包一层函数 wrapper来引入泛型，不过这样有运行时开销
4. 应我看就应该取缔 SFC .vue 组件，这东西太反类型了，而且容易造成一个 vue 文件几千行的问题，有悖 VCA 所声称的组合优于继承的设计目标；或者说社区可以考虑去推动 ts 支持自定义文件后缀的 type loader （这样也可以解决 .pb 文件的类型问题）
5. 写惯了 React 的来看 vue tsx 会感觉 slots 的设计很奇怪 ... 直接将 props 下的字段作为 slots 使用不是更符合直觉？感觉 vue props 整体的设计完全是 react prop 的子集 ...
6. **emit、onXxx、vModel 等框架基础概念的类型做得很差, 用过的都懂, 太难受了**

Vue 3 还是不够激进（真要激进了我感觉 Vue 就成 React With Reactive Object 了）

> 尤大的回答：
>
> Props 值定义确实是一个兼容性导致的包袱。但是在 <script setup> 下已经支持直接用 defineProps<{...}> 类型声明 props 了（自动编译为对应的值声明）。tsx 下也有方案在讨论。
>
> sfc 的 TS IDE 支持请用 <script setup lang="ts"> + vscode + volar。volar 最近几个月很多改进，我个人用已经跟 tsx 感觉没太大差别了。配套的有 vue-tsc 可以做命令行检查。
>
> 有了 VCA 还能写几千行的 SFC 组件那就纯粹是人的问题了，VCA 抽取逻辑跟纯 JS/TS 文件没什么区别，一个 TS 文件也能写几千行（几万行的 checker.ts 不也有么
>
> tsx 本质上是 ts 团队给开了后门直接把 tsx 的推导做进了 ts 本身。ts 如果愿意开档更加完整的 plugin 机制，所有基于模板的框架的类型支持也不至于需要绕那么多弯子，然而 ts 团队怕增加维护成本不肯开。不管怎么说 vue 和 svelte 现在通过各种 hack 也算是做出来了基本完整的模板 ts 支持。
>
> 模板在性能这块吊打 tsx，在 IDE 支持抹平了的前提下用 tsx 本质上是在为了开发者的偏好牺牲用户体验的性能（性能没遇到瓶颈就无所谓）
>
> 这边自己不维护框架的人吐槽吐槽我也能理解，毕竟作为使用者只需要考虑自己爽不爽。作为维护者，Vue 的已有的用户习惯、生态和历史包袱摆在那里，能激进的程度是有限的，Vue 3 的大部分设计都是戴着镣铐跳舞，需要做很多折衷。如果真要激进还不如开个新项目，或者没人用的玩票项目，想怎么设计都可以。
>
> 组件泛型的问题也有不少人提出了，这个目前确实不行，但不表示以后不会有。
>
> 最后实话实说，所有前端里面像这个问题下面的类型体操运动员们毕竟是少数，绝大部分有 intellisense + 类型校验就满足需求了。真的对类型特别特别较真的用 React 也没什么不好，无非就是性能差点。

> 松若章的回答：
>
> 1. 我觉得 props 的问题很大程度上是兼容性包袱导致的，在 Vue 组件的 prop resolve 的过程里，如果没有大量编写经验其实很难记清楚每种配置会 [resolve](https://www.zhihu.com/search?q=resolve&search_source=Entity&hybrid_search_source=Entity&hybrid_search_extra={"sourceType"%3A"answer"%2C"sourceId"%3A1835420993}) 什么值。同时这些动态 resolve prop 的过程也对类型的编写造成了很多麻烦，即使在现在的版本，setup 函数中 props 的[静态类](https://www.zhihu.com/search?q=静态类&search_source=Entity&hybrid_search_source=Entity&hybrid_search_extra={"sourceType"%3A"answer"%2C"sourceId"%3A1835420993})型和 runtime 的实际表现都有不小的偏差。如果未来这些不一致可以全部修复的话倒也不算什么大问题了
>
> 2. 定义共有 props 组件我觉得问题不是很大，只是相比于 React 在 interface 的层面就能共享，Vue 目前必须通过[展开运算符](https://www.zhihu.com/search?q=展开运算符&search_source=Entity&hybrid_search_source=Entity&hybrid_search_extra={"sourceType"%3A"answer"%2C"sourceId"%3A1835420993})才能解决。
>
>    我想提一下的是 ExtractPropTypes 的另一个问题，这个工具类型提取出来的其实是用于 setup 函数的 props 而不是外界传入的 props，这实际上对于类型的使用造成了一些阻碍。在 prop 没有 [required](https://www.zhihu.com/search?q=required&search_source=Entity&hybrid_search_source=Entity&hybrid_search_extra={"sourceType"%3A"answer"%2C"sourceId"%3A1835420993}) 的情况下需要使用 `Partial<ExtractPropTypes<typeof xxxProps>>` 才能给出实际外部的 props 的类型。
>
> 3. 针对于组件 props 的泛型，目前似乎没啥好办法，我也很头大，只能采取比泛型更松的类型约束。[泛型类](https://www.zhihu.com/search?q=泛型类&search_source=Entity&hybrid_search_source=Entity&hybrid_search_extra={"sourceType"%3A"answer"%2C"sourceId"%3A1835420993})型对于[业务组件](https://www.zhihu.com/search?q=业务组件&search_source=Entity&hybrid_search_source=Entity&hybrid_search_extra={"sourceType"%3A"answer"%2C"sourceId"%3A1835420993})的编写可能不算特别常用，但是对于底层组件的编写其实非常重要。详见：
>
> 4. 取缔 SFC 组件有点过于激进了，有点因噎废食的感觉。如果工具链能成熟多数场景下是可以使用 SFC 来编写的，既维持模板的优点也带有类型检查。当然前提是工具链能成熟，包含 vscode 的插件、类似 tsc --noEmit 的[命令行](https://www.zhihu.com/search?q=命令行&search_source=Entity&hybrid_search_source=Entity&hybrid_search_extra={"sourceType"%3A"answer"%2C"sourceId"%3A1835420993})类型检查，正确的 dts 文件生成。在年初的时候我尝试过 [vuedx](https://www.zhihu.com/search?q=vuedx&search_source=Entity&hybrid_search_source=Entity&hybrid_search_extra={"sourceType"%3A"answer"%2C"sourceId"%3A1835420993})、volar，vuedx 会让我的 vscode 卡死，volar 总有类型提示存在问题，发现不太能适应我的开发场景。但是 ts 不能不上，最后我把一个 .vue 的组件库用 .tsx 重写了
>
> 5. slots 的位置确实有放到 props 的可能，毕竟它的机制和 [render props](https://www.zhihu.com/search?q=render props&search_source=Entity&hybrid_search_source=Entity&hybrid_search_extra={"sourceType"%3A"answer"%2C"sourceId"%3A1835420993}) 非常像，但是我个人觉得放到 prop 里面会导致 tsx 更加难看，因为 [vue3](https://www.zhihu.com/search?q=vue3&search_source=Entity&hybrid_search_source=Entity&hybrid_search_extra={"sourceType"%3A"answer"%2C"sourceId"%3A1835420993}) 的组件全量使用了函数 slot，不允许数组作为组件 children，在嵌套组件时候和别的 prop 会混起来，这两种风格可能大家各有喜好。
>
> 6. 我在 vue3 从没使用过 [emits](https://www.zhihu.com/search?q=emits&search_source=Entity&hybrid_search_source=Entity&hybrid_search_extra={"sourceType"%3A"answer"%2C"sourceId"%3A1835420993})，实际上也非常建议不要允许 emits 属性在生产环境的使用，我相信这个选项留着更多的还是为了兼容性的问题。vModel 本身是个语法糖，类型支持如何完全取决于对 props 的类型支持，只能等着插件逐步完善了。至于对 onXxx 的支持，确实比 React 要弱一些，我觉得目前只能说达到基本可用的状态，由于 Vue 采取了原生事件，原生事件的类型没有对于 target 的泛型，对于事件的支持不如 React 一整套重写的事件类型也是情理之中。
>
>    总的来说 Vue3 的 typescript 支持在 TSX 的情境下其实是可以有不错的体验的（但是离 React 还有不小的差距）。但是模板之下，就看工具链是否给力了，还是希望 Vue 在 SFC 情况下的类型体验能早日达到 TSX 的程度。

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