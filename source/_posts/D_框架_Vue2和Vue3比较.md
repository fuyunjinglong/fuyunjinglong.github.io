---
title: Vue2和Vue3比较
date: 2023-09-12 07:33:16
categories:
- D_框架和类库
toc: true # 是否启用内容索引
---

# 入门

## 体系架构比较

Vue.js 从 1.x 到 2.0 版本，最大的升级就是引入了虚拟 DOM 。它为后续做服务端渲染以及跨端框架 Weex 提供了基础。

Vue2.0很多需要解决的痛点,比如源码自身的维护性，数据量大后带来的渲染和更新的性能问题.

Vue3.0从**源码、性能和语法 API** 三个大的方面优化框架，vue3是一个比较好符合开源标准的工程化解决方案。

**1.源码优化**

**(1)代码管理方式**

Vue.js 2.x

```
源码托管在 src 目录
src
├── compiler        # 编译相关
├── core            # 核心代码
├── platforms       # 不同平台的支持
├── server          # 服务端渲染
├── sfc             # .vue 文件解析
├── shared          # 共享代码
```

Vue.js 3.0
monorepo 把这些模块拆分到不同的目录中，每个模块有各自的API类型定义和测试。这样使得模块拆分更细化，职责划分更明确，模块之间的依赖关系也更加明确，开发人员也更容易阅读、理解和更改所有模块源码，提高代码的可维护性。

```
@vue
├── compiler-core
│   ├── LICENSE
│   ├── README.md
│   ├── dist
│   │   ├── compiler-core.cjs.js
│   │   ├── compiler-core.cjs.prod.js
│   │   ├── compiler-core.d.ts
│   │   └── compiler-core.esm-bundler.js
│   ├── index.js
│   └── package.json
├── compiler-dom
```

(1)类型检查

Vue.js 2.x
使用Flow做类型检查，Flow 是 Facebook 出品的 JavaScript 静态类型检查工具，它可以以非常小的成本对已有的 JavaScript 代码迁入，非常灵活。但是Flow 对于一些复杂场景类型的检查，支持得并不好。

Vue.js 3.0
使用 TypeScript 重构了整个项目。TypeScript提供了更好的类型检查，能支持复杂的类型推导。

**2.性能优化**

(1)源码体积优化

Vue.js 3.0
移除一些冷门的 feature(比如 filter、inline-template 等)；
引入 tree-shaking 的技术，减少打包体积；

Vue.js 2.x
Vue.js 2.x是采用数据劫持结合发布者-订阅者模式的方式来达到数据响应效果的。

```
Object.defineProperty(data, 'a',{  get(){    // track  },  set(){    // trigger  }})
```

Vue.js 2.x 内部是通过 Object.defineProperty 这个 API 去劫持数据的 getter 和 setter.但这个 API 有一些缺陷:

- 它必须预先知道要拦截的 key 是什么，所以它并不能检测对象属性的添加和删除。尽管 Vue.js 为了解决这个问题提供了 $set 和 $delete 实例方法；
- 对于嵌套层级较深的对象，如果要劫持它内部深层次的对象变化，就需要递归遍历这个对象，执行 Object.defineProperty 把每一层对象数据都变成响应式的。如果我们定义的响应式数据过于复杂，这就会有相当大的性能损耗；

为了解决上述 2 个问题，Vue.js 3.0 使用了 Proxy API 做数据劫持，它的内部是这样的：

```
observed = new Proxy(data, {  get() {    // track  },  set() {    // trigger  }})
```

使用了 Proxy API 做数据劫持，它劫持的是整个对象，对于对象的属性的增加和删除都能检测到。

Proxy API 并不能监听到内部深层次的对象变化，因此 Vue.js 3.0 的处理方式是在 getter 中去递归响应式，这样的好处是真正访问到的内部对象才会变成响应式，而不是无脑递归，这样无疑也在很大程度上提升了性能，我会在后面分析响应式章节详细介绍它的具体实现原理 。

(2)编译优化

Vue.js 2.x
通过数据劫持和依赖收集，Vue.js 2.x 的数据更新并触发重新渲染的粒度是组件级的，虽然 Vue 能保证触发更新的组件最小化，但在单个组件内部依然需要遍历该组件的整个 vnode 树。这就会导致 vnode 的性能跟模版大小正相关，跟动态节点的数量无关，当一些组件的整个模版内只有少量动态节点时，这些遍历都是性能的浪费。

Vue.js 3.0
通过编译阶段对静态模板的分析，编译生成了 Block tree。Block tree 是一个将模版基于动态节点指令切割的嵌套区块，每个区块内部的节点结构是固定的，而且每个区块只需要以一个 Array 来追踪自身包含的动态节点。借助 Block tree，Vue.js 将 vnode 更新性能由与模版整体大小相关提升为与动态内容的数量相关。

**3.语法 API 优化** 

(1)逻辑组织 优化

Vue.js 2.x
在 Vue.js 2.x版本中，编写组件本质就是在编写一个“包含了描述组件选项的对象”，我们把它称为 Options API。Options API 的设计是按照 methods、computed、data、props 这些不同的选项进行分类。和一个逻辑点相关的代码可能写在多个Option里，非常分散，如果需要修改一个逻辑点，就需要在单个文件中不断切换和寻找。

Vue.js 3.0
Vue.js 3.0 提供了一种新的 API：Composition API，它有一个很好的机制去解决这样的问题，就是将某个逻辑关注点相关的代码全都放在一个函数里，这样当需要修改一个功能时，就不再需要在文件中跳来跳去。

(2)逻辑复用优化

Vue.js 2.x
我们通常会用 mixins 去复用逻辑。使用单个 mixin似乎问题不大，但是当我们一个组件混入大量不同的 mixins的时候，会存在两个非常明显的问题：命名冲突和数据来源不清晰。
每个 mixin 都可以定义自己的props、data，它们之间是无感的，所以很容易定义相同的变量，导致命名冲突；
对组件而言，如果模板中使用不在当前组件中定义的变量，那么就会不太容易知道这些变量在哪里定义的，这就是数据来源不清晰；

Vue.js 3.0
使用 hook 函数，整个数据来源清晰了，也不会出现命名冲突的问题。

(3)更好的类型支持

因为它们都是一些函数，在调用函数时，自然所有的类型就被推导出来了。不像 Options API 所有的东西使用 this。

(4)tree-shaking 友好

tree-shaking有一个两个要求,必须是import导入,必须是单个函数或常量导出

Vue.js 2.x
直接导出的是整个vue实例，如果我们只是简单的用某一些功能的话就有点累赘。

Vue.js 3.0
用到的函数可以通过import声明，对“按需加载”有更好的支持。

注意
Composition API 属于 API 的增强，它并不是 Vue.js 3.0组件开发的范式，如果组件足够简单，可以使用 Options API

## 体系架构比较2

**源码优化**

**a.使用monorepo来管理源码**

- Vue.js 2.x 的源码托管在 src 目录，然后依据功能拆分出了 compiler（模板编译的相关代码）、core（与平台无关的通用运行时代码）、platforms（平台专有代码）、server（服务端渲染的相关代码）、sfc（.vue 单文件解析相关代码）、shared（共享工具代码）等目录。
- Vue.js 3.0，整个源码是通过 monorepo 的方式维护的，根据功能将不同的模块拆分到 packages 目录下面不同的子目录中，每个 package 有各自的 API、类型定义和测试。

**b.使用Typescript来开发源码**

- Vue.js 2.x 选用 Flow 做类型检查，来避免一些因类型问题导致的错误，但是 Flow 对于一些复杂场景类型的检查，支持得并不好。
- Vue.js 3.0 抛弃了 Flow ，使用 TypeScript 重构了整个项目。 TypeScript 提供了更好的类型检查，能支持复杂的类型推导；由于源码就使用 TypeScript 编写，也省去了单独维护 d.ts 文件的麻烦。

**性能优化**

**a.引入tree-shaking的技术**

- tree-shaking 依赖 ES2015 模块语法的静态结构（即 import 和 export），通过编译阶段的静态分析，找到没有引入的模块并打上标记。像我们在项目中没有引入 Transition、KeepAlive 等不常用的组件，那么它们对应的代码就不会打包进去。

**b.移除了一些冷门的feature**

- Vue.js 3.0 兼容了 Vue.js 2.x 绝大部分的api，但还是移除了一些比较冷门的feature：如 keyCode 支持作为 v-on 的修饰符、$on，$off 和 $once 实例方法、filter过滤、内联模板等。

**响应式实现优化**

**a.改用proxy api做数据劫持**

- Vue.js 2.x 内部是通过 Object.defineProperty 这个 API 去劫持数据的 getter 和 setter 来实现响应式的。这个 API 有一些缺陷，它必须预先知道要拦截的 key 是什么，所以它并不能检测对象属性的添加和删除。
- Vue.js 3.0 使用了 Proxy API 做数据劫持，它劫持的是整个对象，自然对于对象的属性的增加和删除都能检测到。

**b.响应式是惰性的**

- 在 Vue.js 2.x 中，对于一个深层属性嵌套的对象，要劫持它内部深层次的变化，就需要递归遍历这个对象，执行 Object.defineProperty 把每一层对象数据都变成响应式的，这无疑会有很大的性能消耗。
- 在 Vue.js 3.0 中，使用 Proxy API 并不能监听到对象内部深层次的属性变化，因此它的处理方式是在 getter 中去递归响应式，这样的好处是真正访问到的内部属性才会变成响应式，简单的可以说是按需实现响应式，就没有那么大的性能消耗。

**编译优化**

**a.生成block tree**

- Vue.js 2.x 的数据更新并触发重新渲染的粒度是组件级的，单个组件内部需要遍历该组件的整个 vnode 树。
- Vue.js 3.0 做到了通过编译阶段对静态模板的分析，编译生成了 Block tree。Block tree 是一个将模版基于动态节点指令切割的嵌套区块，每个区块内部的节点结构是固定的。每个区块只需要追踪自身包含的动态节点。

**b.slot编译优化**

- Vue.js 2.x 中，如果有一个组件传入了slot，那么每次父组件更新的时候，会强制使子组件update，造成性能的浪费。
- Vue.js 3.0 优化了slot的生成，使得非动态slot中属性的更新只会触发子组件的更新。动态slot指的是在slot上面使用v-if，v-for，动态slot名字等会导致slot产生运行时动态变化但是又无法被子组件track的操作。

**c.diff算法优化**

- 能力有限，说不清楚，可以看下这篇文章：[https://blog.csdn.net/weixin_48726650/article/details/107019164](https://link.segmentfault.com/?enc=JB6w6BefnVmd%2B0QsX2EQzA%3D%3D.eCcJr9vxZG27O%2FYVW1R%2BoltEGvZMeR4t3f8NVcSPktHkpjIWL8YVqkcr1Mo2kT7MLTmkRCGlt03PhoNoPOMHZQ%3D%3D)

**语法api优化**

**a.优化逻辑组织**

- 使用 Vue.js 2.x 编写组件本质就是在编写一个“包含了描述组件选项的对象”，可以把它称为 Options API。我们按照 data、props、methods、computed 这些不同的选项来书写对应的代码。这种方式对于小型的组件可能代码还能一目了然，但对于大型组件要修改一个逻辑点，可能就需要在单个文件中不断上下切换和寻找逻辑代码。
- Vue.js 3.0 提供了一种新的 API：Composition API，它有一个很好的机制去解决这样的问题，就是将某个逻辑关注点相关的代码全都放在一个函数里，这样在修改一个逻辑时，只需要改那一块的代码了。

**b.优化逻辑复用**

- 在 Vue.js 2.x 中，我们一般会用 mixins 去复用逻辑。当抽离并引用了大量的mixins，你就会发现两个不可避免的问题：命名冲突和数据来源不清晰。
- Vue.js 3.0 设计的 Composition API，在逻辑复用方面就会很有优势了。

# 进阶

## 双向绑定

**vue2在组件中这样设置:**

父组件

```
<ChildComponent v-model = "title">
```

子组件

```
export default {
  model: {
    prop: 'title', // v-model绑定的属性名称
    event: 'change' // v-model绑定的事件
  },
  props: {
    value: String, // value跟v-model无关
    title: { // title是跟v-model绑定的属性
      type: String,
      default: 'Default title'
    }
  },
  methods: {
    handle() {
      // 这里的 change, 对应 event
      this.$emit('change', 'xxx')
    }
  }
}
```

**vue3在组件中这样设置**

父组件

```
<!-- 两个方法等价 -->
<Son v-model="message" />
<!-- <Son :modelValue="message" @update:modelValue="message = $event" /> -->
```

子组件

```
export default defineComponent({
  props: {
    modelValue: {
      type: String
    }
  },
  emits: ['update:modelValue'],
  setup(props, { emit }) {
    const newValue = computed({
      get: () => props.modelValue,
      set: (nv) => {
        console.log(nv)
        emit('update:modelValue', nv)
      }
    })

    return {
      newValue
    }
  }
})
```

**小结**

**vue2:**

1. v-model: 会把 `value` 用作 prop 且把 `input` 用作 event;
2. 可以通过 `.sync`修饰符 指定传递名字
3. 支持model: 可以指定v-model的 value属性名 和 event事件名字

![image-20230223074721472](C:\Users\fuyunjinglong\AppData\Roaming\Typora\typora-user-images\image-20230223074721472.png)

**组件v-model原理:**

```
<Son v-model="age" />
<Son :value="age"  @change="age = $event" />
```

**vue3:**

1. v-model: 不在绑定 value 而是 `modelValue`, 接受方法也不再是 input 而是 `update:modelValue`
2. 组件支持多个 v-model, 并且可以指定名字 v-model:名字

![image-20230223074833400](C:\Users\fuyunjinglong\AppData\Roaming\Typora\typora-user-images\image-20230223074833400.png)

**组件v-model原理:**

```
<Son v-model="formData" />
<Son :modelValue="formData" @update:modelValue="formData = $event" />
```

## diff算法

**Vue2.0diff 痛点**

vue2.x 中的虚拟 dom 是进行**「全量的对比」**，在运行时会对所有节点生成一个虚拟节点树，当页面数据发生变更好，会遍历判断 virtual dom 所有节点（包括一些不会变化的节点）有没有发生变化；虽然说 diff 算法确实减少了多 DOM 节点的直接操作，但是这个**「减少是有成本的」**，如果是复杂的大型项目，必然存在很复杂的父子关系的 VNode,**「而 Vue2.x 的 diff 算法，会不断地递归调用 patchVNode，不断堆叠而成的几毫秒，最终就会造成 VNode 更新缓慢」**。

**Vue3.0 解决方案-动静结合 PatchFlag**

在 Vue3.0 中，在这个模版编译时，编译器会在动态标签末尾加上 /_ Text_/ PatchFlag。**「也就是在生成 VNode 的时候，同时打上标记，在这个基础上再进行核心的 diff 算法」**并且 PatchFlag 会标识动态的属性类型有哪些，比如这里 的 TEXT 表示只有节点中的文字是动态的。而 patchFlag 的类型也很多。

<img src="/img/image-20220605222439383.png" alt="image-20220605222439383" style="zoom:80%;" />

其中大致可以分为两类：

- 当 patchFlag 的值「大于」 0 时，代表所对应的元素在 patchVNode 时或 render 时是可以被优化生成或更新的。
- 当 patchFlag 的值「小于」 0 时，代表所对应的元素在 patchVNode 时，是需要被 full diff，即进行递归遍历 VNode tree 的比较更新过程。

总结：**「Vue3.0 对于不参与更新的元素，做静态标记并提示，只会被创建一次，在渲染时直接复用。」**

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
