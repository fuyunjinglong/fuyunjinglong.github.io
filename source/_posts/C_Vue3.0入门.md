---
title: C_Vue3.0入门
date: 2022-04-14 06:33:16
categories:
- C_框架及工具
toc: true # 是否启用内容索引
---

[TOC]

[Vue3.0官网](https://v3.cn.vuejs.org/guide/installation.html#%E5%8F%91%E5%B8%83%E7%89%88%E6%9C%AC%E8%AF%B4%E6%98%8E)

[Vue2.0与Vue3.0热度](https://trends.google.com/trends/explore?cat=31&date=today%205-y&q=Vue2,vue3)

[Vue,React，Angular三大框架google热度](https://trends.google.com/trends/explore?cat=31&q=Vue.js,React,Angular)

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

### [开源项目 RFC 的基本流程](https://www.rectcircle.cn/series/software-project-management/use-rfc-manage/#开源项目-rfc-的基本流程)

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

# Vue3.0特性

## 新特性

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

## vue3内部热插拔架构

三大模块

@vue/reactivity响应式

@vue/compiler-sfc：@vue/compiler-dom和@vue/compiler-core

@vue/runtime-dom和@vue/runtime-core

## 解耦的内部结构解锁新的高级用法

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

## Composition API 优势

- **天然完整支持** **TypeScript** **类型系统**
- **更好的代码组织和逻辑复用**
- **推荐用来代替旧的** **mixins** **混用语法**

```
mixin有很多问题，例如命名问题、组件改动问题、数据属性组件与mixin定义问题即所谓隐式依赖
使用mixin最头痛的莫过于命名问题，如果一段逻辑不能在多个组件之中进行复用，那么也就没有提取的必要，但恰恰是多个组件的复用就会有命名问题，我们知道混入规则中，如果值为对象的选项，命名冲突时组件内方法将会覆盖混入方法，这使得我们在多个组件复用时，编写代码更为困难，同时如果一旦改动mixin中的代码，那么引用并混入的所有组件都会受到影响，可谓牵一发而动全身。
```

[Vue3的8种组件通信](https://segmentfault.com/a/1190000041240135)

```
import userSearch from '@/mixins/product/search'
<script setup>
const productSearch = userSearch()
<script>
```

- setup
- ref单值引用
- reactive多值
- toRefs多值解构
- computed计算属性

**生命周期**

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

## 编译时优化的虚拟DOM

    在模板编译阶段提供信息，用于运行时优化虚拟DOM渲染函数

## 使用 Tree-Shaking 的全局 API

23kb->12kb

DEC代码块对于webpack无法执行tree Shaking

Vue3将以下api抽离独立函数打包，使用tree Shaking：

- Vue.nextTick
- Vue.observable
- Vue.complie
- Vue.set
- Vue.delete

## 单文件组件的两个新特性

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

## 安装 Vue 命令的不同

**移植** **3.x** **的特性，兼容到** **Vue** **2.7** **版本里**

vue2.0：npm install vue

vue3.0：npm install vue@next，

```
import {ref} from '@vue/composition-api'
```

## Hook和Mixin

**Mixin的噩梦**

拿到应该不熟悉的项目的时候，简直是噩梦，各种Mixin，各种变量，方法，完全看不出从哪来的。

mixin 有如下缺点：

1. 引入了隐式依赖关系。
2. 不同 mixins 之间可能会有先后顺序甚至代码冲突覆盖的问题
3. mixin 代码会导致滚雪球式的复杂性
4. 多个 mixin 导致合并项不明来源

**React中的Hook**

为了避开这些问题，React 采用 HOC，但它依然存在缺陷：

1. 一个组件的state影响许多组件的props
2. 造成地狱嵌套

**Vue3中的Hook**

使用全新的 Hook 组件结构，可以实现平铺式调用组件的复用部分，解决了 mixin 的来源不明和 HOC 的地狱嵌套问题。

- 概念提出
  - React Class组件到函数组件
- VueHook实现:组合式API
- 意义
  - 提取重复逻辑，优化代码结构
  - 替代Mixin和HOC
  - 体现了编程思想

```
import { ref, onMounted, onUnmounted } from "vue";
export function useMousePosition() {
  const x = ref(0);
  const y = ref(0);
  function update(e) {
    x.value = e.pageX;
    y.value = e.pageY;
  }
  onMounted(() => {
    window.addEventListener("mousemove", update);
  });
  onUnmounted(() => {
    window.removeEventListener("mousemove", update);
  });
  return { x, y };
}
```

组件中使用

```
import { useMousePosition } from "./mouse";
export default {
  setup() {
    const { x, y } = useMousePosition();
    return { x, y };
  },
};
```

Hook和Mixin比较：

- hook可以当作以前mixin的来用
- hook是一个函数，mixin是一个对象
- hook就是拆分版的mixin，将导入操作交给开发者，mixin是根据对应的options Api直接merge到组件了
- hook可以借用composition-api完全使用vue的能力，简而言之就是你在setup函数用能用的hook都能用.

# 深入Vue3.0特性

## V-Model双向绑定

vue2.0

sync和v-model功能重合

```
 <input type="text" :value="value" @input="$emit('input',$event.target.value)">
 另外提供将属性或事件名称改为其他名称
 model: {
    prop: "title", // 将默认的 prop 名 value 改为 title
    event: "change", // 将默认的事件名 input 改为 change
  },
```

vue3.0

model选项和v-bind的sync 修饰符被移除，统⼀为v-model参数形式  。因为vue2中.sync和v-model功能有重叠，容易混淆， vue3做了统⼀。  

```
<input
      type="text"
      :value="modelValue"
      @input="$emit('update:modelValue', $event.target.value)"  // 事件名改为 update:modelValue
    />
```

- prop 名从 `value` 变为 `modelValue`
- 事件名也从默认的`input` 改为 `update:modelValue`

使用多个v-model

```
<child-component v-model:name="name" v-model:address="address"></child-component>
```

**子组件修改父组件的props值**

```
父组件：
<Demo4 :name="name" @update:name="name = $event"></Demo4>
等同于
<Demo4 v-model:name="name"></Demo4>
子组件：
<input :value="name" @input="changeInput($event.target.value)" />
props: {
    name: {
      type: Array
    },
  },
  setup(props, { emit, attrs, slots }) {
    const changeInput = (p) => {
      emit("update:name", p);
    };
    return { ...toRefs(state), changeInput };
  }
```

参考：

[子组件修改父组件的props值](https://blog.csdn.net/qq_38974163/article/details/121988963)

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

## 注册全局组件和自定义全局指令

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

## 组件data总是声明为函数

以前vue2还可以是对象，但vue3强制只能是函数

### 自定义组件白名单

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

### transition类名变更

- v-enter → v-enter-from
- v-leave → v-leave-from

<img src="/img/image-20220615071959713.png" alt="image-20220615071959713" style="zoom: 67%;" />

参考：

[类名变更]: https://blog.csdn.net/weixin_44691513/article/details/116750956

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

vue3中使⽤createApp返回app实例，由它暴露⼀系列全局ap  

**Global and internal APIs重构为可做摇树优化**
vue2中不少global-api是作为静态函数直接挂在构造函数上的，例如Vue.nextTick()，如果我们从未在代码中⽤过它们，就会形成
所谓的dead code，这类global-api造成的dead code⽆法使⽤webpack的tree-shaking排除掉。  

vue3中做了相应的变化，将它们抽取成为独⽴函数，这样打包⼯具的摇树优化可以将这些dead code排除掉。  

# 从Vue2.0升级到3.0

[迁移指南](https://v3.cn.vuejs.org/guide/migration/introduction.html)

**简介**

*新特性*

- [Composition API](https://v3.vuejs.org/guide/composition-api-introduction.html)
- [Teleport](https://v3.vuejs.org/guide/teleport.html)
- [Fragments](https://v3.vuejs.org/guide/migration/fragments.html)
- [Emits Component Option](https://v3.vuejs.org/guide/component-custom-events.html)
- createRenderer API⽤于创建⾃定义渲染器

*破坏性变化*

- [Global API 改为应⽤程序实例调⽤](https://v3.vuejs.org/guide/migration/global-api.html)
- [Global and internal APIs重构为可做摇树优化](https://v3.vuejs.org/guide/migration/global-api-treeshaking.html)
- [model选项和v-bind的sync 修饰符被移除，统⼀为v-model参数形式](https://v3.vuejs.org/guide/migration/v-model.html)
- [渲染函数API修改](https://v3.vuejs.org/guide/migration/render-function-api.html)
- [函数式组件仅能通过简单函数⽅式创建](https://v3.vuejs.org/guide/migration/functional-components.html)
- [废弃在SFC的template上使⽤functional或者添加functional选项的⽅式声明函数式组件](https://v3.vuejs.org/guide/migration/functional-components.html)
- [异步组件要求使⽤defineAsyncComponent ⽅法创建](https://v3.vuejs.org/guide/migration/async-components.html)
- [组件data选项应该总是声明为函数](https://v3.vuejs.org/guide/migration/data-option.html)
- [⾃定义组件⽩名单执⾏于编译时](https://v3.vuejs.org/guide/migration/custom-elements-interop.html)
- [is属性仅限于⽤在component标签上](https://v3.vuejs.org/guide/migration/custom-elements-interop.html)
- [$scopedSlots 属性被移除，都⽤$slots代替](https://v3.vuejs.org/guide/migration/slots-unification.html)
- [特性强制策略变更](https://v3.vuejs.org/guide/migration/attribute-coercion.html)
- [⾃定义指令API和组件⼀致](https://v3.vuejs.org/guide/migration/custom-directives.html)
- ⼀些transition类名修改:
  v-enter -> v-enter-from
  v-leave -> v-leave-from
- [watch 选项](https://v3.vuejs.org/api/options-data.html#watch) 和$watch 不再⽀持点分隔符字符串路径, 使⽤计算函数作为其参数
- Vue 2.x中应⽤程序根容器的 outerHTML 会被根组件的模板替换 (或被编译为template)。 Vue 3.x现在使⽤应⽤根容器的
  innerHTML取代.

*移除*

- [移除keyCode 作为 v-on 修饰符](https://v3.vuejs.org/guide/migration/keycode-modifiers.html)
- [on,off and $once 移除](https://v3.vuejs.org/guide/migration/events-api.html)
- [Filters移除](https://v3.vuejs.org/guide/migration/filters.html)
- [Inline templates attributes移除](https://v3.vuejs.org/guide/migration/inline-template-attribute.html)  

## 取消 v-on:keyup.keyCode修饰符

按键数字

## 移除$ on、$off 和 $once 方法

不应该是vue3提供的功能，vue3移除了EventBus总线通信，推荐mitt.js

```
import mitt from "mitt"
<script>
const emitter = mitt()
emitter.emit('foo',1)
emitter.on('foo',(e)=>{})
</script>
```

## 移除 Filter 过滤器

推荐使用 computed 方案来代替

## 初始化 Vue 应用

Vue 不再是一个构造函数，通过 createApp 方法初始化

```
1 $ npm init vite-app <project-name>
2 $ cd <project-name>
3 $ npm install
4 $ npm run dev
```

## 全局 API 调用方式

```
Vue.config.globalProperties.$echarts = echarts;
```

## 渲染 Render 方法修改

vue2.0渲染函数里的 h 参数，便于tree shaking

```
export default{
 render(h){
  return h('div')
 }
}
```

Vue 3.0 中 h 函数通过 vue 引入,不再传入h函数，拍平props结构，scopedslots删掉，统一为slots即this.$scopedSlots 替代为 this.$slots

```
import {h} from 'vue'
export default{
 render(){
  return h(div)
 }
}
```

通过h函数进行render渲染

```
Demo5.js
import { h, reactive } from "vue";
export default {
  setup(props, { slots, attrs, emit }) {
    const state = reactive({
      count: 0,
    });

    function increment() {
      state.count++;
    }
    // 返回render函数
    return () =>
      h(
        "div",
        {
          onClick: increment,
        },
        [slots.default(), slots.content({ data: "jack" }), state.count, h("input", { value: "123456" }, ["我是span"])]
      );
  },
};
其中，h为函数，不再是参数，格式：h('标签名',{属性或事件},[子元素或h函数])

<Demo5>
 我是匿名插槽
      <template #default>我是匿名插槽</template>
      <template #content="{ data }">我是具名插槽，取消了作用域插槽{{ data }}</template>
    </Demo5>
```

## 异步组件defineAsyncComponent

由于vue3引入函数式组件，为了区分函数式组件和异步组件，特地增加标记defineAsyncComponent。

- 必须明确使用defineAsyncComponent包裹
- component选项重名为loader
- Loader 函数不在接收 resolve and reject 且必须返回⼀个Promise  

vue2.0

```
const Home = () => import("./components/Home.vue")
```

vue3.0

```
components: {
    // 无配置项异步组件
    AsyncPage: defineAsyncComponent(() => import("./NextPage.vue")),
    // 有配置项异步组件
    AsyncPageWithOptions: defineAsyncComponent({
   loader: () => import(".NextPage.vue"),
   delay: 200, 
   timeout: 3000,
   errorComponent: () => import("./ErrorComponent.vue"),
   loadingComponent: () => import("./LoadingComponent.vue"),
 })
  },
```

`defineAsyncComponent` 也可以接受一个对象

## 动态组件 is 属性

vue2.0会渲染成mybutton组件

```
<button is="mybutton"></button>
```

vue3.0则当成普通属性，除非用v-is指令替代

is只能作用域component组件

```
<component is="comp"></component>
```

dom内使用模板解析，使用v-is替代

```
<table>
<tr v-is="'comp'"></tr>
</table>
```



## 其他API

**1)shallowRef**

这是一个浅层的 `ref`，与 `shallowReactive` 一样是拿来做性能优化的

**2)toRaw**

`toRaw` 方法是用于获取 `ref` 或 `reactive` 对象的原始数据的

**3)markRaw**

`markRaw` 方法可以将原始数据标记为非响应式的，即使用 `ref` 或 `reactive` 将其包装，仍无法实现数据响应式，其接收一个参数，即原始数据，并返回被标记后的数据

**4)provide && inject**

这里简单说明一下这两个方法的作用：

- **provide** ：向子组件以及子孙组件传递数据。接收两个参数，第一个参数是 `key`，即数据的名称；第二个参数为 `value`，即数据的值
- **inject** ：接收父组件或祖先组件传递过来的数据。接收一个参数 `key`，即父组件或祖先组件传递的数据名称

**5)getCurrentInstance**

獲取this實例

```javascript
let { proxy } = getCurrentInstance()
```

**6)useStore**

在Vue3的 `getCurrentInstance().ctx` 中也没有发现 `$store` 这个属性.这就要通过 `vuex` 中的一个方法了，即 `useStore`

**7)vue3操作dom**

```javascript
<template>
  <div>
    <div ref="el">div元素</div>
  </div>
</template>

<script>
import { ref, onMounted } from 'vue'
export default {
  setup() {
    // 创建一个DOM引用，名称必须与元素的ref属性名相同
    const el = ref(null)

    // 在挂载后才能通过 el 获取到目标元素
    onMounted(() => {
      el.value.innerHTML = '内容被修改'
    })

    // 把创建的引用 return 出去
    return {el}
  }
}
</script>

```

## TypeScript作用

三个原因：

- 您可以避免经典的错误 `'undefined' is not a function.`
- 在不严重破坏代码的情况下，重构代码更容易。
- 使大型、复杂的应用程序源码更易阅读。

研究表明，静态类型检查的TypeScript可以检测到所有JavaScript错误的15％。

1. TypeScript更可靠

   与JavaScript相比，TypeScript代码更可靠、更容易重构。这使开发人员可以更轻松地避免错误并进行重写。

   类型的定义和编译器的引入，可使你避免掉代码中的大多数愚蠢错误。

2. TypeScript更清晰

   显式类型使我们代码可读性更高，所以我们的注意力将会更集中在我们的系统究竟是如何构建的，以及系统的不同部分如何相互作用。在大型系统中，能够在记住上下文的同时抽象出系统的其余部分是很重要的。类型的定义使我们能够做到这一点。

3. TypeScript和JavaScript实际上是可以互换的，何乐而不为呢？

   由于JavaScript是TypeScript的子集，因此您可以在TypeScript代码中使用您想要的所有JavaScript库和代码。

[github上pull request排名](https://madnight.github.io/githut/#/pull_requests/2020/1)

待续

**composition api和react hook区别**

# Vue3.0中的双向数据绑定原理实现

## **前言**

Vue3.0是采用数据劫持结合发布者-订阅者模式的方式，通过new Proxy()来劫持各个属性的setter，getter，在数据变动时发布消息给订阅者，触发相应的监听回调。Vue3.0与Vue2.0的区别仅是数据劫持的方式由Object.defineProperty更改为Proxy代理，其他代码不变。

## **Object.defineProperty缺点**

1、**在Vue中，Object.defineProperty没法监控到数组下标的变化，致使直接经**由过程数组的下标给数组设置值，不能及时相应。为了处置惩罚这个题目，经由vue内部处置惩罚后可以运用以下几种要领来监听数组，**分别是push() 、pop() 、shift()、 unshift() 、splice() 、sort()、 reverse()，Vue.set()对于数组的处理其实就是调用了splice方法**。

2、Object.defineProperty只能挟制对象的属性,因而我们须要对每一个对象的每一个属性举行遍历。Vue里，是经由过程递归以及遍历data对象来完成对数据的监控的，假如属性值也是对象那末须要深度遍历,明显假如能挟制一个完全的对象，不管是对操纵性照样机能都邑有一个很大的提拔。

## **Proxy**

**Proxy** 也就是代理，可以帮助我们完成很多事情，例如对数据的处理，对构造函数的处理，对数据的验证，说白了，就是在我们访问对象前添加了一层拦截，可以过滤很多操作，而这些过滤，由你来定义，因此提供了一种机制，可以对外界的访问进行过滤和改写。

语法：

```js
let p = new Proxy(target, handler);
```

`target` ：需要使用`Proxy`包装的目标对象（可以是任何类型的对象，包括原生数组，函数，甚至另一个代理）。

`handler`: 一个对象，其属性是当执行一个操作时定义代理的行为的函数(可以理解为某种触发器)。具体的`handler`相关函数请查阅官网。

```js
  let w3cjs = {
     name: "w3cjs",
     age: 99
  };
  w3cjs = new Proxy(w3cjs, {
    get(target, key) {
         let result = target[key];
         //如果是获取 年龄 属性，则添加 岁字
         if (key === "age") result += "岁";
         return result;
    },
    set(target, key, value) {
           if (key === "age" && typeof value !== "number") {
           throw Error("age字段必须为Number类型");
        }
        return Reflect.set(target, key, value);
    }
  });
  console.log(`我叫${w3cjs.name}  我今年${w3cjs.age}了`);
  w3cjs.age = 100;
```

上方案例中定义了 **w3cjs**对象，其中有 **age** 和 **name** 两个字段,我们在`Proxy`中的 **get** 拦截函数中添加了一个判断，如果是取 **age** 属性的值，则在后面添加 **岁**。在 **set** 拦截函数中判断了如果是更改 **age** 属性时，类型不是 `Number`则抛出错误。最后输出正确结果：我叫w3cjs 我今年99岁了。

**Proxy支持拦截的操作，一共有13种：**

- **get(target, propKey, receiver)**：拦截对象属性的读取，比如 `proxy.foo` 和`proxy['foo']`。
- **set(target, propKey, value, receiver)**：拦截对象属性的设置，比如`proxy.foo = v` 或 `proxy['foo'] = v`，返回一个布尔值。
- **has(target, propKey)**：拦截 `propKey in proxy` 的操作，返回一个布尔值。
- **deleteProperty(target, propKey)**：拦截 `delete proxy[propKey]`的操作，返回一个布尔值。
- **ownKeys(target)**：拦截 `Object.getOwnPropertyNames(proxy)`、`Object.getOwnPropertySymbols(proxy)`、`Object.keys(proxy)`、`for...in`循环，返回一个数组。该方法返回目标对象所有自身的属性的属性名，而`Object.keys()`的返回结果仅包括目标对象自身的可遍历属性。
- **getOwnPropertyDescriptor(target, propKey)**：拦截`Object.getOwnPropertyDescriptor(proxy, propKey)`，返回属性的描述对象。
- **defineProperty(target, propKey, propDesc)**：拦截`Object.defineProperty(proxy, propKey, propDesc）`、`Object.defineProperties(proxy, propDescs)`，返回一个布尔值。
- **preventExtensions(target)**：拦截`Object.preventExtensions(proxy)`，返回一个布尔值。
- **getPrototypeOf(target)**：拦截`Object.getPrototypeOf(proxy)`，返回一个对象。
- **isExtensible(target)**：拦截`Object.isExtensible(proxy)`，返回一个布尔值。
- **setPrototypeOf(target, proto)**：拦截`Object.setPrototypeOf(proxy, proto)`，返回一个布尔值。如果目标对象是函数，那么还有两种额外操作可以拦截。
- **apply(target, object, args)**：拦截 Proxy 实例作为函数调用的操作，比如`proxy(...args)`、`proxy.call(object, ...args)`、`proxy.apply(...)`。
- **construct(target, args)**：拦截 Proxy 实例作为构造函数调用的操作，比如`new proxy(...args)`。

## **Vue 3.0双向绑定原理的实现**

**1. 定义构造函数**

```js
function Vue(option){
    this.$el = document.querySelector(option.el);   //获取挂载节点
    this.$data = option.data;
    this.$methods = option.methods;
    this.deps = {};     //所有订阅者集合 目标格式（一对多的关系）：{msg: [订阅者1, 订阅者2, 订阅者3], info: [订阅者1, 订阅者2]}
    this.observer(this.$data);  //调用观察者
    this.compile(this.$el);     //调用指令解析器
}
```

**2. 定义指令解析器**

```js
Vue.prototype.compile = function (el) {
    let nodes = el.children; //获取挂载节点的子节点
    for (var i = 0; i < nodes.length; i++) {
        var node = nodes[i];
        if (node.children.length) {
            this.compile(node) //递归获取子节点
        }
        if (node.hasAttribute('l-model')) { //当子节点存在l-model指令
            let attrVal = node.getAttribute('l-model'); //获取属性值
            node.addEventListener('input', (() => {
                this.deps[attrVal].push(new Watcher(node, "value", this, attrVal)); //添加一个订阅者
                let thisNode = node;
                return () => {
                    this.$data[attrVal] = thisNode.value //更新数据层的数据
                }
            })())
        }
        if (node.hasAttribute('l-html')) {
            let attrVal = node.getAttribute('l-html'); //获取属性值
            this.deps[attrVal].push(new Watcher(node, "innerHTML", this, attrVal)); //添加一个订阅者
        }
        if (node.innerHTML.match(/{{([^\{|\}]+)}}/)) {
            let attrVal = node.innerHTML.replace(/[{{|}}]/g, '');   //获取插值表达式内容
            this.deps[attrVal].push(new Watcher(node, "innerHTML", this, attrVal)); //添加一个订阅者
        }
        if (node.hasAttribute('l-on:click')) {
            let attrVal = node.getAttribute('l-on:click'); //获取事件触发的方法名
            node.addEventListener('click', this.$methods[attrVal].bind(this.$data)); //将this指向this.$data
        }
    }
}
```

**3. 定义观察者(区别在这一块代码)**

```plane
Vue.prototype.observer = function (data) {
    const that = this;
    for(var key in data){
        that.deps[key] = [];    //初始化所有订阅者对象{msg: [订阅者], info: []}
    }
    let handler = {
        get(target, property) {
            return target[property];
        },
        set(target, key, value) {
            let res = Reflect.set(target, key, value);
            var watchers = that.deps[key];
            watchers.map(item => {
                item.update();
            });
            return res;
        }
    }
    this.$data = new Proxy(data, handler);
}
```

**4. 定义订阅者**

```js
function Watcher(el, attr, vm, attrVal) {
    this.el = el;
    this.attr = attr;
    this.vm = vm;
    this.val = attrVal;
    this.update(); //更新视图
}
```

**5. 更新视图**

```js
Watcher.prototype.update = function () {
    this.el[this.attr] = this.vm.$data[this.val]
}
```

**6. 使用**

```html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>Document</title>
    <script src="./vue.js"></script>
</head>
<body>
    <!--
        实现mvvm的双向绑定，是采用数据劫持结合发布者-订阅者模式的方式，通过new Proxy()来劫持各个属性的setter，getter，在数据变动时发布消息给订阅者，触发相应的监听回调。就必须要实现以下几点：
            1、实现一个数据监听器Observer，能够对数据对象的所有属性进行监听，如有变动可拿到最新值并通知订阅者
            2、实现一个指令解析器Compile，对每个元素节点的指令进行扫描和解析，根据指令模板替换数据，以及绑定相应的更新函数
            3、实现一个Watcher，作为连接Observer和Compile的桥梁，能够订阅并收到每个属性变动的通知，执行指令绑定的相应回调函数，从而更新视图
            4、mvvm入口函数，整合以上三者
    -->
    <div id="app">
        <input type="text" l-model="msg" >
        <p l-html="msg"></p>
        <input type="text" l-model="info" >
        <p l-html="info"></p>
        <button l-on:click="clickMe">点我</button>
        <p>{{msg}}</p>
    </div>

    <script>
        var vm = new Vue({
            el: "#app",
            data: {
                msg: "W3CJS",
                info: "实现mvvm的双向绑定"
            },
            methods: {
                clickMe(){
                    this.msg = "Vue3.0双向数据绑定原理的实现";
                }
            }
        })
    </script>
</body>
</html>
```

# Vue3的优化

### 1.源码优化

**a.使用monorepo来管理源码**

- Vue.js 2.x 的源码托管在 src 目录，然后依据功能拆分出了 compiler（模板编译的相关代码）、core（与平台无关的通用运行时代码）、platforms（平台专有代码）、server（服务端渲染的相关代码）、sfc（.vue 单文件解析相关代码）、shared（共享工具代码）等目录。
- Vue.js 3.0，整个源码是通过 monorepo 的方式维护的，根据功能将不同的模块拆分到 packages 目录下面不同的子目录中，每个 package 有各自的 API、类型定义和测试。

**b.使用Typescript来开发源码**

- Vue.js 2.x 选用 Flow 做类型检查，来避免一些因类型问题导致的错误，但是 Flow 对于一些复杂场景类型的检查，支持得并不好。
- Vue.js 3.0 抛弃了 Flow ，使用 TypeScript 重构了整个项目。 TypeScript 提供了更好的类型检查，能支持复杂的类型推导；由于源码就使用 TypeScript 编写，也省去了单独维护 d.ts 文件的麻烦。

### 2.性能优化

**a.引入tree-shaking的技术**

- tree-shaking 依赖 ES2015 模块语法的静态结构（即 import 和 export），通过编译阶段的静态分析，找到没有引入的模块并打上标记。像我们在项目中没有引入 Transition、KeepAlive 等不常用的组件，那么它们对应的代码就不会打包进去。

**b.移除了一些冷门的feature**

- Vue.js 3.0 兼容了 Vue.js 2.x 绝大部分的api，但还是移除了一些比较冷门的feature：如 keyCode 支持作为 v-on 的修饰符、$on，$off 和 $once 实例方法、filter过滤、内联模板等。

### 3.响应式实现优化

**a.改用proxy api做数据劫持**

- Vue.js 2.x 内部是通过 Object.defineProperty 这个 API 去劫持数据的 getter 和 setter 来实现响应式的。这个 API 有一些缺陷，它必须预先知道要拦截的 key 是什么，所以它并不能检测对象属性的添加和删除。
- Vue.js 3.0 使用了 Proxy API 做数据劫持，它劫持的是整个对象，自然对于对象的属性的增加和删除都能检测到。

**b.响应式是惰性的**

- 在 Vue.js 2.x 中，对于一个深层属性嵌套的对象，要劫持它内部深层次的变化，就需要递归遍历这个对象，执行 Object.defineProperty 把每一层对象数据都变成响应式的，这无疑会有很大的性能消耗。
- 在 Vue.js 3.0 中，使用 Proxy API 并不能监听到对象内部深层次的属性变化，因此它的处理方式是在 getter 中去递归响应式，这样的好处是真正访问到的内部属性才会变成响应式，简单的可以说是按需实现响应式，就没有那么大的性能消耗。

### 4.编译优化

**a.生成block tree**

- Vue.js 2.x 的数据更新并触发重新渲染的粒度是组件级的，单个组件内部需要遍历该组件的整个 vnode 树。
- Vue.js 3.0 做到了通过编译阶段对静态模板的分析，编译生成了 Block tree。Block tree 是一个将模版基于动态节点指令切割的嵌套区块，每个区块内部的节点结构是固定的。每个区块只需要追踪自身包含的动态节点。

**b.slot编译优化**

- Vue.js 2.x 中，如果有一个组件传入了slot，那么每次父组件更新的时候，会强制使子组件update，造成性能的浪费。
- Vue.js 3.0 优化了slot的生成，使得非动态slot中属性的更新只会触发子组件的更新。动态slot指的是在slot上面使用v-if，v-for，动态slot名字等会导致slot产生运行时动态变化但是又无法被子组件track的操作。

**c.diff算法优化**

- 能力有限，说不清楚，可以看下这篇文章：[https://blog.csdn.net/weixin_48726650/article/details/107019164](https://link.segmentfault.com/?enc=JB6w6BefnVmd%2B0QsX2EQzA%3D%3D.eCcJr9vxZG27O%2FYVW1R%2BoltEGvZMeR4t3f8NVcSPktHkpjIWL8YVqkcr1Mo2kT7MLTmkRCGlt03PhoNoPOMHZQ%3D%3D)

### 5.语法api优化

**a.优化逻辑组织**

- 使用 Vue.js 2.x 编写组件本质就是在编写一个“包含了描述组件选项的对象”，可以把它称为 Options API。我们按照 data、props、methods、computed 这些不同的选项来书写对应的代码。这种方式对于小型的组件可能代码还能一目了然，但对于大型组件要修改一个逻辑点，可能就需要在单个文件中不断上下切换和寻找逻辑代码。
- Vue.js 3.0 提供了一种新的 API：Composition API，它有一个很好的机制去解决这样的问题，就是将某个逻辑关注点相关的代码全都放在一个函数里，这样在修改一个逻辑时，只需要改那一块的代码了。

**b.优化逻辑复用**

- 在 Vue.js 2.x 中，我们一般会用 mixins 去复用逻辑。当抽离并引用了大量的mixins，你就会发现两个不可避免的问题：命名冲突和数据来源不清晰。
- Vue.js 3.0 设计的 Composition API，在逻辑复用方面就会很有优势了。