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