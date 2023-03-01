---
title: Vue3.0入门_华为
date: 2022-04-14 06:33:16
categories:
- D_框架和类库
toc: true # 是否启用内容索引
---

# 入门

## 2020年9月18日**Vue 3.0** 正式发布

[我要成为海贼王的男人](https://github.com/vue3/vue3-News#%E6%88%91%E6%98%AF%E8%A6%81%E6%88%90%E4%B8%BA%E6%B5%B7%E8%B4%BC%E7%8E%8B%E7%9A%84%E7%94%B7%E4%BA%BA)

[One Piece. Vuejs 3.0 正式版发布！代号：海贼王](https://github.com/vue3/vue3-News/issues/21)

*"***Be** **a framework that grows with the** **user"** 

每月npm下载量800万+，每周活跃用户1300万+

**版本改动点汇总：**

- 对 Vue.js 进行了完全 Typescript 重构，让 Vue.js 源码易于阅读、开发和维护；
- 重写了虚拟 Dom 的实现，对编译模板进行优化、组件初始化更高效， 性能上有较大的提升；Vue.js2 对象式组件存在一些问题：难以复用逻辑代码、难以拆分超大型组件、代码无法被压缩和优化、数据类型难以推倒等问题；而 CompositionAPI 则是基于函数理念，去解决上述问题，使用函数可以将统一逻辑的组件代码收拢一起达到复用，也更有利于构建时的 tree-shaking 检测，这个使用起来有些类似于 React 的 hook；
- 以上变化都秉持着 VUE 的“渐进式框架“ 理念， Vue.js3.0 持续开发兼容旧的版本，即使升级了 Vue.js3.0 也可以按照之前的组件开发模式进行开发。

## Vue3.0开发旅程

**大事记**

- 2013年：受到angular启发，犹大开发一套轻量框架Seed,同年12月，改名为Vue,版本为0.6.0
- 2014年：Vue正式对外发布，版本0.8.0
- 2015年：10月27号，发布v1.0.0新世纪福音战士
- 2016年:10月1日，发布V2.0.0攻壳机动队
- 2020年：9月18日，发布V3.0.0海贼王

**2** 年

**37** 个RFC

**2682** 次代码提交

**628** 个合并请求PR

**99** 位贡献者

**+** [无数的子项目开发](https://vue3js.cn/)

- 2018年2月，Vue 3 最初的构想
- 2018年9月，从零开始原型设计、在伦敦宣布启动计划
- 2018年9月 - 2019年初，使用 TypeScript 开发 class、hooks,、time slicing 等
- 2019年1月，建立 RFC（Request for Comments）机制
- 2019年2月，发布 Class API RFC，引发社区争议
- 2019年5月，接受社区意见，宣布放弃 Class API
- 2019年3月 – 6月，思考新的渲染策略，重写渲染逻辑核心
- 2019年6月 – 8月，推出 Function API RFC，后更名为 Composition API
- 2019年9月，2.x Option API 支持新的编译器实现方式
- 2019年10月 – 12月，基于新编译器的 v-model、Transition系统、工具(SFC, HMR)
- 2020年1月，发布 3.0.0-alpha.1 版本
- 2020年1月 – 4月，性能提升两三倍的新服务端渲染器
- 2020年4月，发布 3.0.0-beta.1 版本
- 2020年4月 – 7月，实验性的 Vite 和 VitePress，开发子项目（路由、CLI等）
- 2020年7月，发布 3.0.0-rc.1 版本
- 2020年9月，发布 3.0.0 正式版

**RFC**

全称 （Request for Comments），征求意见。

RFC 概念最早在 互联网 标准指定领域出现。在互联网技术标准领域，RFC 是技术标准文档的代名词，业界公认的主流的互联网技术，比如 TCP/IP 都编入了 IETF 的 RFC 文档中。换句话说，想成为互联网技术方面的标准或者基础设施，都需要进入 IETF 的 RFC 文档

在开源技术领域，古老的开源项目，比如 Linux，采用的是 邮件组的 方式来进行讨论及项目管理。

较新的开源项目，会考虑使用 Github + RFC + IM/论坛 机制来实现 Feature 管理。比如 Rust、React。

**[开源项目 RFC 的基本流程](https://www.rectcircle.cn/series/software-project-management/use-rfc-manage/#开源项目-rfc-的基本流程)**

角色

- 意愿贡献者，想为开源项目贡献代码，但是还没有贡献（多数）
- 普通贡献者，偶尔为开源项目贡献代码
- 项目组核心成员，经常为项目贡献代码，同时负责开源项目管理，参与技术讨论，决策

物料准备

- rfc 仓库，用来维护所有的 rfc 文档
- rfc 仓库 PR 讨论区，作为 rfc 设计评审的讨论地点
- 项目代码库
- 项目代码库代码库的 Issue 讨论区，作为该 rfc 实现过程的讨论地点

角色（一人可能身兼数职）

- 核心项目组成员
- rfc 作者
- rfc 实现者

RFC 创建、讨论、评审流程（工作在 rfc 仓库）

- 确认如下问题
  - 查看所有历史 RFC，确认待创建的 RFC 不存在或者没有被拒绝
  - 该 Feature 不是 Bugfix、重构类的需求
- Fork 代码库，根据模板编写 RFC
- 提交 PR
- 初步评审，项目组核心成员对该 RFC 质量，是否有重复等问题，决定是否进入下一阶段
- 讨论阶段，相关利益相关方在此 PR 处进行讨论，作者根据讨论进行修改并 commit。讨论参与者如下
  - RFC 作者
  - 相关项目组核心成员
  - 所有感兴趣的其他人员
- 最终动议阶段，RFC 作者 和 相关项目组核心成员认为可以进入最终动议阶段，则可以发起最终动议，公示一段时间后，没有问题，则激活 RFC。同时 该 RFC 的 PR 将合入 RFC 仓库

RFC 开发阶段（工作在 项目代码库）

- 在项目代码库创建一个 Issue 用来追踪 RFC 的实现情况
- 实现者（当然欢迎 RFC 作者作为实现者）认领该任务，进入开发阶段

## Vue3.0特性

**1.新特性**

- More maintainable **可维护性更佳**

  TypeScript + modularized internals 内部代码使用 TS 及模块化结构

- Faster **更快**

  Proxy-based Reactivity System 基于 Proxy 的响应式系统

  Compiler-informed Virtual DOM & SSR 编译时优化的虚拟DOM及服务端渲染

- Smaller **更小**

  Tree-shaking 使用摇树技术减少打包体积

  Compile-time flags 使用编译时标记优化生成代码

- Scales better **可伸缩性更强**

  Composition API 兼容原 Option API，使用 Composition API 处理复杂场景

- Better DX **更好的开发时体验**

  New Single-file Component improvements 新的单文件组件开发体验（vite热编译，类型检查等）

**2.vue3内部热插拔架构**

三大模块

@vue/reactivity响应式

@vue/compiler-sfc：@vue/compiler-dom和@vue/compiler-core

@vue/runtime-dom和@vue/runtime-core

**3.解耦的内部结构解锁新的高级用法**

- Compile-time customizations via compiler plugins **通过编译器插件自定义编译过程**

  E.g. build time i18n 比如构建时注入国际化资源，而非运行时加载，组件内加载

- Custom renderers **自定义渲染器**

  E.g. Native, WebGL, Terminals 比如渲染成原生应用，无需h5转换、WebGL图形等，

- Standalone reactivity package **独立的响应式系统包**

  E.g. with alternative templating system 可替换成第三方的模板解析引擎，xx-for

⾃定义渲染器 custom renderer
Vue3.0中⽀持 ⾃定义渲染器 (Renderer)：这个 API 可以⽤来⾃定义渲染逻辑。⽐如下⾯的案例我们可以把数据渲染到canvas上。
⾸先创建⼀个组件描述要渲染的数据，我们想要渲染⼀个叫做piechart的组件，我们不需要单独声明该组件，因为我们只是想把它携带
的数据绘制到canvas上。  

**4.Composition API 优势**

- **天然完整支持** **TypeScript** **类型系统**
- **更好的代码组织和逻辑复用**
- **推荐用来代替旧的** **mixins** **混用语法**

```
mixin有很多问题，例如命名问题、组件改动问题、数据属性组件与mixin定义问题即所谓隐式依赖
使用mixin最头痛的莫过于命名问题，如果一段逻辑不能在多个组件之中进行复用，那么也就没有提取的必要，但恰恰是多个组件的复用就会有命名问题，我们知道混入规则中，如果值为对象的选项，命名冲突时组件内方法将会覆盖混入方法，这使得我们在多个组件复用时，编写代码更为困难，同时如果一旦改动mixin中的代码，那么引用并混入的所有组件都会受到影响，可谓牵一发而动全身。
```

```
import userSearch from '@/mixins/product/search'
<script setup>
const productSearch = userSearch()
<script>
```

**5.生命周期**

- beforeCreate -> 使用 setup()
- created -> 使用 setup()
- beforeMount -> onBeforeMount
- mounted -> onMounted
- beforeUpdate -> onBeforeUpdate
- updated -> onUpdated
- beforeDestroy -> onBeforeUnmount
- destroyed -> onUnmounted
- errorCaptured -> onErrorCaptured

新增了

- onRenderTracked状态跟踪，所有响应式变量和方法的状态
- onRenderTriggered状态触发，跟踪发生变化的值

**5.编译时优化的虚拟DOM**

    在模板编译阶段提供信息，用于运行时优化虚拟DOM渲染函数

**6.使用 Tree-Shaking 的全局 API**

23kb->12kb

DEC代码块对于webpack无法执行tree Shaking

Vue3将以下api抽离独立函数打包，使用tree Shaking：

- Vue.nextTick
- Vue.observable
- Vue.complie
- Vue.set
- Vue.delete

**6.单文件组件的两个新特性**

setup语法糖

```
<script setup> 
balabala
<script>
```

基于状态驱动的CSS变量，注入到style

```
data(){
colora:'red'
}
<style vars="colora">
.text{
color:v-bind('colora')
}
<style>
```

**7.安装 Vue 命令的不同**

**移植** **3.x** **的特性，兼容到** **Vue** **2.7** **版本里**

vue2.0：npm install vue

vue3.0：npm install vue@next，

```
import {ref} from '@vue/composition-api'
```

# 进阶

## 双向绑定

- prop 名从 `value` 变为 `modelValue`
- 事件名也从默认的`input` 改为 `update:modelValue`

**第一种**

父组件

```
// Users.vue
<template>
  <div class="user-wrap">
    <Son v-model="message" />
    <h1>{{ message }}</h1>
  </div>
</template>

<script lang="ts">
import { defineComponent, ref } from 'vue'
import Son from './son.vue'
export default defineComponent({
  name: 'user',
  components: {
    Son
  },
  setup() {
    let message = ref('')
    return {
      message,
    }
  }
})
</script>
```

子组件

```
// Son.vue
<template>
  <div>
    <input type="text" :value="modelValue"
      @input="$emit('update:modelValue', $event.target.value)"
    />
  </div>
</template>

<script lang="ts">
import { defineComponent } from 'vue'
export default defineComponent({
  props: ['modelValue'],
  emits: ['update:modelValue'],
})
</script>
```

**第二种: 通过computed计算属性**

父组件

```
// Users.vue
<template>
  <div class="user-wrap">
  	<!-- 两个方法等价 -->
    <!-- <Son :modelValue="message" @update:modelValue="message = $event" /> -->
    <Son v-model="message" />
    <h1>{{ message }}</h1>
  </div>
</template>

<script lang="ts">
import { defineComponent, ref } from 'vue'
import Son from './son.vue'
export default defineComponent({
  name: 'user',
  components: {
    Son
  },
  setup() {
    let message = ref('')
    return {
      message,
    }
  }
})
</script>
```

子组件

```
// Son.vue
<template>
  <div>
    <!-- 两个方法等价 -->
    <!-- <input type="text" :value="newValue" @input="newValue = $event.target.value" /> -->
    <input type="text" v-model="newValue" />
  </div>
</template>

<script lang="ts">
import { defineComponent, computed } from 'vue'
export default defineComponent({
  props: ['modelValue'],
  emits: ['update:modelValue'],
  setup(props, { emit }) {
    const newValue = computed({
      // 子组件v-model绑定 计算属性, 一旦发生变化, 就会给父组件传递值
      get: () => props.modelValue,
      set: (nv) => {
        emit('update:modelValue', nv)
      }
    })
    return {
      newValue
    }
  }
})
</script>
```

**第三种: 组件绑定多个v-model**

父组件

```
// Users.vue
<template>
  <div class="user-wrap">
    <!-- 这里绑定两个v-model -->
    <Son v-model="message" v-model:title="title" />
    <h1>message:{{ message }}</h1>
    <h1>title:{{ title }}</h1>
  </div>
</template>

<script lang="ts">
import { defineComponent, ref } from 'vue'
import Son from './son.vue'
export default defineComponent({
  name: 'user',
  components: {
    Son
  },
  setup() {
    let message = ref('')
    let title = ref('')

    return {
      message,
      title,
    }
  }
})
</script>
```

子组件

```
// Son.vue
<template>
  <div>
    <!-- 两个方法等价 -->
    <!-- <input type="text" :value="newValue" @input="newValue = $event.target.value" /> -->
    <input type="text" v-model="newValue" />
    -
    <input type="text" v-model="newTitle" />
  </div>
</template>

<script lang="ts">
import { defineComponent, computed } from 'vue'
export default defineComponent({
  props: {
    // v-model默认的名字
    modelValue: {
      type: String
    },
    title: {
      //这里可以直接使用 v-model:title ,:号后面的名字
      type: String
    }
  },
  emits: ['update:modelValue', 'update:title'],
  setup(props, { emit }) {
    const newValue = computed({
      get: () => props.modelValue,
      set: (nv) => {
        console.log(nv)
        emit('update:modelValue', nv)
      }
    })

    const newTitle = computed({
      get: () => props.title,
      set: (nv) => {
        emit('update:title', nv)
      }
    })

    return {
      newValue,
      newTitle
    }
  }
})
</script>
```

## v-bind="`$attrs`"

包含了父[作用域](https://so.csdn.net/so/search?q=作用域&spm=1001.2101.3001.7020)中不作为组件 props 或自定义事件的 attribute 绑定和事件

inheritAttrs:true，true表示子组件渲染父组件传过来的属性值，false则不会。

## watch与watchEffect

- **watch是惰性执行，也就是只有监听的值发生变化的时候才会执行，但是watchEffect不同，每次代码加载watchEffect都会执行**
- **watch只能监听响应式数据：ref定义的属性和reactive定义的对象，如果直接监听reactive定义对象中的属性是不允许的，除非使用函数转换一下**

**组件watch选项和实例⽅法$watch 不再支持"点分隔"写法,除非使用函数转换一下**

```
const count = ref(0) 
watch(count, (newValue, oldValue) => {
})

const state = reactive({ count: 0 })
watch(() => state.count, (newValue, oldValue) => {
    // 因为watch被观察的对象只能是getter/effect函数、ref、热active对象或者这些类型是数组
})

const count = ref(0) 
const count2 = ref(1) 
watch([count, count2], (newValue, oldVlaue) => {
})
```

## suspense 异步组件渲染

如loading转圈

```
<suspense>
        <template #default>
            <CyPeoples />
        </template>
        <template #fallback>
            <div>
                <h3>数据加载中……</h3>
            </div>
        </template>
    </suspense>

CyPeoples子组件
async setup() {
        const peoples = ref(null);
        const headers = { "Content-Type": "application/json" };
        const fetchPeoples = await fetch("https://swapi.dev/api/people", {
            headers,
        });
        peoples.value = await fetchPeoples.json();
        return { peoples };
    }
```

## 传送门Teleport 组件

实现任意组件的传送

```
<teleport to="body"> 
 <div class="first"> 
  第一个挂载元素 
 </div>   
</teleport> 
```

## Fragments和Emits选项

Fragments：单根片段=》多跟片段

Emits选项提供了自定义事件的声明：

- 原生事件会触发2次，如click
- 更好指示组件工作
- 对象形式事件校验-最佳实践

## 全局组件和全局指令

全局组件

```
1.引入封装好的全局组件地址
import 组件名 from './地址' //一般放置在./src/components下

2.导出
exports default{
    install (app) {
    // 此处形参为main.js文件中use()方法自动传进来的Vue实例
        app.component('自定义组件名,最好与组件内的name一致', 组件名)
    }
}

3.main.js中挂载到Vue实例中

import { createApp } from 'vue'
import App from './App.vue' //vue3中引入Vue实例方式
import component from './components'// 引入公共组件
// 链式添加一项 .use(component) 来引入配置好的公共组件
createApp(App).use(component).mount('#app')
4.使用
<自定义组件名 />

```

全局指令

```
1.创建文件并导出配置
export default {
    install(app){
        app.directive('自定义指令名',{ //在创建自定义名称时不要带v-,使用时再携带
            mounted(el,binding,vnode){
                // el 为携带自定义指令的dom节点
                // binding 为指令后携带的参数通过.value取出
                功能
            }
        })
    }
}
2.main.js文件中注册
import direction from './directives'
createApp(App).use(directive).mount('#app')
3.全局使用
<div v-自定义指令名='...'></div> 

```

**注意：自定义指令API和组件保持一致了**

- bind->**beforeMount**
- insert->**mounted**
- **beforeUpdate**:新增的，元素更新前
- update:移除了，与updated功能类似
- componentUpdated->**updated**
- **beforeUnmount**:新增的，元素移除之前
- unbind->**unmounted**

## 函数式组件

vue3官方不推荐使用函数式组件，因为函数式写法并没有带来太大的性能提升

```
Demo6.vue
<!--函数式组件-->
<script>
import { h } from "vue";
function headCon(props, context) {
  return h(`h${props.level}`, context.attrs, context.slots);
}
export default headCon;
</script>

<Demo6 level="2">这是函数式组件</Demo6>
```

**自定义组件白名单**

vue3中⾃定义元素检测发⽣在模板编译时，如果要添加⼀些vue之外的⾃定义元素，需要在编译器选项中设置isCustomElement选
项。
使⽤构建⼯具时，模板都会⽤vue-loader预编译，设置它提供的compilerOptions即可：  

vue.config.js配置

```
rules: [
  {
    test: /.vue$/,
    use: 'vue-loader',
    options: {
      compilerOptions: {
        isCustomElement: tag => tag === '自定义的标签'
      }
    }
  }
]
```

vite.config.js配置

```
module.exports = {
  vueCompilerOptions: {
    isCustomElement: tag => tag === '自定义标签'
  }
}
```

**transition类名变更**

- v-enter → v-enter-from
- v-leave → v-leave-from

<img src="/img/image-20220615071959713.png" alt="image-20220615071959713" style="zoom: 67%;" />

参考：

[vue3的transition类名变更](https://blog.csdn.net/weixin_44691513/article/details/116750956)

```
<template>
  <div class="Demo7">
    <div @click="fade = !fade">淡入淡出</div>
    <transition name="fade">
      <div v-if="fade">我是要变化的元素</div>
    </transition>
  </div>
</template>

<script>
import { reactive, toRefs } from "vue";
export default {
  name: "Demo7",
  setup(props, { emit, attrs, slots }) {
    const state = reactive({
      fade: false,
    });
    return { ...toRefs(state) };
  },
};
</script>
<style scoped lang="scss">
.Demo7 {
  .fade-enter-active,
  .fade-leave-active {
    transition: opacity 1s ease;
  }
  .fade-enter-from,
  .fade-leave-to {
    opacity: 0;
  }
}
</style>
```

## Global API 改为应⽤程序实例调⽤

vue2中有很多全局api可以改变vue的⾏为，⽐如Vue.component等。这导致⼀些问题：

- vue2没有app概念， new Vue()得到的根实例被作为app，这样的话所有创建的根实例是共享相同的全局配置，这在测试时会污
  染其他测试⽤例，导致测试变得困难。
- 全局配置也导致没有办法在单⻚⾯创建不同全局配置的多个app实例。
