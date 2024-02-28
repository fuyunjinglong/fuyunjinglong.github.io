---
title: 源码_Vue3.0
date: 2023-09-12 07:33:16
categories:
- D_框架和类库
toc: true # 是否启用内容索引
---

# 库和框架的区别

库和框架的区别是什么？库是你主动使用的工具，而框架是你被动适应的环境。

# Vue源码调试

**1.下载源码**

源码地址：https://github.com/vuejs/core

**2.安装依赖**

前提：安装node>16和pnpm>7。

> 依赖安装，最好移除*puppeteer*依赖，下载很慢
>
> pnpm install

**3.添加打包源码**

> *"dev"*: "node scripts/dev.js --sourcemap",

**4.调试源码**

> 在目录下可以断点调试，如\core-main\packages\runtime-dom\src\index.ts

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
    <script src="./packages/vue//dist/vue.global.js"></script>
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

# Vue源码目录

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



# Vue从实例化到渲染的完整流程

# Vue源码深度解析

**参考**

> - [催学社-Vue3 源码实战课-video](https://www.1024zyz.com/4724.html)
> - [Vue.js 3.0 核心源码-黄轶-video](https://www.1024zyz.com/3771.html)
> - [Vue3源码解析，打造自己的Vue3框架-video](https://www.1024zyz.com/5016.html)
> - [vue 源码 全宇宙](https://github.com/vue3/vue3-News/issues/16?content_source_url=https://github.com/vue3/vue3-News)
> - [vue3js源码](https://vue3js.cn/start/)

**Vue核心四大模块**

- 生命周期过程
- 变化监测原理
- 模板编译原理
- 虚拟DOM原理

# 尤大手写mini-vue

[链接](https://www.vue-js.com/topic/611b1ba4120d99003158db6f)

**整体流程**

- 数据响应式模块：初始化为响应式对象
- 编译模块：编译为渲染函数，编译过程一般在两个时刻执行,即浏览器运行时(runtime)和Vue打包编译时(compile time)
- 渲染模块：
  - RenderPhase ： 渲染模块使用渲染函数根据初始化数据生成虚拟Dom
  - MountPhase  ： 利用虚拟Dom创建视图页面Html
  - PatchPhase：数据模型一旦变化渲染函数将再次被调用生成新的虚拟Dom，然后做Dom Diff更新视图Html

**编译模块**

1. Parase解析：模板字符串 -> AST(Abstract Syntax Treee)抽象语法树，本质是一连串的正则匹配
2. Transform转换：譬如 v-bind v-if v-for的转换
3. Generate生成渲染器： AST -> 渲染函数

## **defineProperty版本**

```
<div id="app"></div>
<script>
// reactivity ---响应式
let activeEffect
class Dep {
  subscribers = new Set()
  depend() {
    if (activeEffect) {
      this.subscribers.add(activeEffect)
    }
  }
  notify() {
    this.subscribers.forEach(effect => effect())
  }
}

function watchEffect(effect) {
  activeEffect = effect
  effect()
  activeEffect = null
}

function reactive(raw) {
 // 使用 Object.defineProperty
  // 1. 遍历对象上存在的 key
  Object.keys(raw).forEach(key => {
   // 2. 为每个 key 都创建一个依赖对象
    const dep = new Dep()
    // 3. 用 getter 和 setter 重写原对象的属性
    let realValue = raw[key]
    Object.defineProperty(raw, key, {
      get() {
        // 4. 在 getter 和 setter 里调用依赖对象的对应方法
        dep.depend()
        return realValue
      },
      set(newValue) {
        realValue = newValue
        dep.notify()
      }
    })
  })
  return raw
}

// vdom ---虚拟dom
function h(tag, props, children) {
    return { tag, props, children };
  }

function mount(vnode, container, anchor) {
    const el = document.createElement(vnode.tag);
    vnode.el = el;
    // props
    if (vnode.props) {
      for (const key in vnode.props) {
        if (key.startsWith('on')) {
          el.addEventListener(key.slice(2).toLowerCase(), vnode.props[key])
        } else {
          el.setAttribute(key, vnode.props[key]);
        }
      }
    }
    if (vnode.children) {
      if (typeof vnode.children === "string") {
        el.textContent = vnode.children;
      } else {
        vnode.children.forEach(child => {
          mount(child, el);
        });
      }
    }
    if (anchor) {
      container.insertBefore(el, anchor)
    } else {
      container.appendChild(el);
    }
  }

function patch(n1, n2) {
    // Implement this
    // 1. check if n1 and n2 are of the same type
    if (n1.tag !== n2.tag) {
      // 2. if not, replace
      const parent = n1.el.parentNode
      const anchor = n1.el.nextSibling
      parent.removeChild(n1.el)
      mount(n2, parent, anchor)
      return
    }

    const el = n2.el = n1.el

    // 3. if yes
    // 3.1 diff props
    const oldProps = n1.props || {}
    const newProps = n2.props || {}
    for (const key in newProps) {
      const newValue = newProps[key]
      const oldValue = oldProps[key]
      if (newValue !== oldValue) {
        if (newValue != null) {
          el.setAttribute(key, newValue)
        } else {
          el.removeAttribute(key)
        }
      }
    }
    for (const key in oldProps) {
      if (!(key in newProps)) {
        el.removeAttribute(key)
      }
    }
    // 3.2 diff children
    const oc = n1.children
    const nc = n2.children
    if (typeof nc === 'string') {
      if (nc !== oc) {
        el.textContent = nc
      }
    } else if (Array.isArray(nc)) {
      if (Array.isArray(oc)) {
        // array diff
        const commonLength = Math.min(oc.length, nc.length)
        for (let i = 0; i < commonLength; i++) {
          patch(oc[i], nc[i])
        }
        if (nc.length > oc.length) {
          nc.slice(oc.length).forEach(c => mount(c, el))
        } else if (oc.length > nc.length) {
          oc.slice(nc.length).forEach(c => {
            el.removeChild(c.el)
          })
        }
      } else {
        el.innerHTML = ''
        nc.forEach(c => mount(c, el))
      }
    }
  }

// paste all previous code from Codepen
const app = {
  data: reactive({
    count: 0
  }),
  render() {
    return h('div', {
      onClick: () => {
        app.data.count++
      }
    }, String(app.data.count))
  }
}

function mountApp(component, selector) {
  let isMounted = false
  let oldTree
  watchEffect(() => {
    if (!isMounted) {
      mount(oldTree = component.render(), document.querySelector(selector))
      isMounted = true
    } else {
      const newTree = component.render()
      patch(oldTree, newTree)
      oldTree = newTree
    }
  })
}
mountApp(app, '#app')
</script>
```

## **Proxy版本(可断点调试)**

```
<div id="app"></div>
<script>
// 定义一个暂时存放 watchEffect 传进来的参数的变量
let activeEffect
// 定义一个 Dep 类，该类将会为每一个响应式对象的每一个键生成一个发布者实例
class Dep {
  // 用 Set 做缓存列表以防止列表中添加多个完全相同的函数
  subscribers = new Set()
   // 构造函数接受一个初始化的值放在私有变量内
  constructor(value) {
    this._value = value
  }
  // 当使用 xxx.value 获取对象上的 value 值时
  get value() {
  // 代理模式 当获取对象上的value属性的值时将会触发 depend 方法
    this.depend()
     // 然后返回私有变量内的值
    return this._value
  }
  // 当使用 xxx.value = xxx 修改对象上的 value 值时
  set value(value) {
  // 先改值再触发 这样保证触发的时候用到的都是已经修改后的新值
    this._value = value
    // 代理模式 当修改对象上的value属性的值时将会触发 notify 方法
    this.notify()
  }
  // 这就是我们常说的依赖收集方法
  depend() {
  // 如果 activeEffect 这个变量为空 就证明不是在 watchEffect 这个函数里面触发的 get 操作
    if (activeEffect) {
    // 但如果 activeEffect 不为空就证明是在 watchEffect 里触发的 get 操作
      // 那就把 activeEffect 这个存着 watchEffect 参数的变量添加进缓存列表中
      this.subscribers.add(activeEffect)
    }
  }
  // 更新操作 通常会在值被修改后调用
  notify() {
  // 遍历缓存列表里存放的函数 并依次触发执行
    this.subscribers.forEach((effect) => {
      effect()
    })
  }
}
// 模仿 Vue3 的 watchEffect 函数
/**
这个函数就被赋值给了activeEffect这个变量上面去，然后立刻执行这个函数，一般来说这个函数里面都会有一些响应式对象的对吧？既然有，那就会触发getter去进行依赖收集操作，而依赖收集则是判断了activeEffect这个变量有没有值，如果有，那就把它添加进缓存列表里。等到执行完这个函数后，就立即将activeEffect这个变量置为空值，防止不在watchEffect这个函数中触发getter的时候也执行依赖收集操作。
**/
function watchEffect(effect) {
// 先把传进来的函数放入到 activeEffect 这个变量中
  activeEffect = effect
  // 然后执行 watchEffect 里面的函数
  effect()
   // 最后把 activeEffect 置为空值
  activeEffect = null
}

// proxy version
const reactiveHandlers = {
// 当触发 get 操作时
  get(target, key) {
    // 先调用 getDep 函数取到里面存放的 value 值
    const value = getDep(target, key).value
    // 如果 value 是对象的话
    if (value && typeof value === 'object') {
    // 那就把 value 也变成一个响应式对象
      return reactive(value)
    } else {
    // 如果 value 只是基本数据类型的话就直接将值返回
      return value
    }
  },
  // 当触发 set 操作时
  set(target, key, value) {
  // 调用 getDep 函数并将里面存放的 value 值重新赋值成 set 操作的值
    getDep(target, key).value = value
  }
}
// 定义一个 WeakMap 数据类型 用于存放 reactive 定义的对象以及他们的发布者对象集
const targetToHashMap = new WeakMap()
// 定义 getDep 函数 用于获取 reactive 定义的对象所对应的发布者对象集里的某一个键对应的发布者对象
function getDep(target, key) {
 // 获取 reactive 定义的对象所对应的发布者对象集
  let depMap = targetToHashMap.get(target)
   // 如果没获取到的话
  if (!depMap) {
  // 就新建一个空的发布者对象集
    depMap = new Map()
    // 然后再把这个发布者对象集存进 WeakMap 里
    targetToHashMap.set(target, depMap)
  }
// 再获取到这个发布者对象集里的某一个键所对应的发布者对象
  let dep = depMap.get(key)
  // 如果没获取到的话
  if (!dep) {
   // 就新建一个发布者对象并初始化赋值
    dep = new Dep(target[key])
    // 然后将这个发布者对象放入到发布者对象集里
    depMap.set(key, dep)
  }
 // 最后返回这个发布者对象
  return dep
}

function reactive(obj) {
  return new Proxy(obj, reactiveHandlers)
}

function h(tag, props, children) {
  return { tag, props, children }
}

// 根组件挂载
function mount(vnode, container, anchor) {
  const el = document.createElement(vnode.tag)
  vnode.el = el
  // props
  if (vnode.props) {
    for (const key in vnode.props) {
      if (key.startsWith('on')) {
        el.addEventListener(key.slice(2).toLowerCase(), vnode.props[key])
      } else {
        el.setAttribute(key, vnode.props[key])
      }
    }
  }
  if (vnode.children) {
    if (typeof vnode.children === 'string') {
      el.textContent = vnode.children
    } else {
      vnode.children.forEach((child) => {
        mount(child, el)
      })
    }
  }
  if (anchor) {
    container.insertBefore(el, anchor)
  } else {
    container.appendChild(el)
  }
}

// diff算法
function patch(n1, n2) {
  // Implement this
  // 1. check if n1 and n2 are of the same type
  if (n1.tag !== n2.tag) {
    // 2. if not, replace
    const parent = n1.el.parentNode
    const anchor = n1.el.nextSibling
    parent.removeChild(n1.el)
    mount(n2, parent, anchor)
    return
  }

  const el = (n2.el = n1.el)

  // 3. if yes
  // 3.1 diff props
  const oldProps = n1.props || {}
  const newProps = n2.props || {}
  for (const key in newProps) {
    const newValue = newProps[key]
    const oldValue = oldProps[key]
    if (newValue !== oldValue) {
      if (newValue != null) {
        el.setAttribute(key, newValue)
      } else {
        el.removeAttribute(key)
      }
    }
  }
  for (const key in oldProps) {
    if (!(key in newProps)) {
      el.removeAttribute(key)
    }
  }
  // 3.2 diff children
  const oc = n1.children
  const nc = n2.children
  if (typeof nc === 'string') {
    if (nc !== oc) {
      el.textContent = nc
    }
  } else if (Array.isArray(nc)) {
    if (Array.isArray(oc)) {
      // array diff
      const commonLength = Math.min(oc.length, nc.length)
      for (let i = 0; i < commonLength; i++) {
        patch(oc[i], nc[i])
      }
      if (nc.length > oc.length) {
        nc.slice(oc.length).forEach((c) => mount(c, el))
      } else if (oc.length > nc.length) {
        oc.slice(nc.length).forEach((c) => {
          el.removeChild(c.el)
        })
      }
    } else {
      el.innerHTML = ''
      nc.forEach((c) => mount(c, el))
    }
  }
}

function patch(n1, n2) {
  // Implement this
  // 1. check if n1 and n2 are of the same type
  if (n1.tag !== n2.tag) {
    // 2. if not, replace
    const parent = n1.el.parentNode
    const anchor = n1.el.nextSibling
    parent.removeChild(n1.el)
    mount(n2, parent, anchor)
    return
  }

  const el = (n2.el = n1.el)

  // 3. if yes
  // 3.1 diff props
  const oldProps = n1.props || {}
  const newProps = n2.props || {}
  for (const key in newProps) {
    const newValue = newProps[key]
    const oldValue = oldProps[key]
    if (newValue !== oldValue) {
      if (newValue != null) {
        el.setAttribute(key, newValue)
      } else {
        el.removeAttribute(key)
      }
    }
  }
  for (const key in oldProps) {
    if (!(key in newProps)) {
      el.removeAttribute(key)
    }
  }
  // 3.2 diff children
  const oc = n1.children
  const nc = n2.children
  if (typeof nc === 'string') {
    if (nc !== oc) {
      el.textContent = nc
    }
  } else if (Array.isArray(nc)) {
    if (Array.isArray(oc)) {
      // array diff
      const commonLength = Math.min(oc.length, nc.length)
      for (let i = 0; i < commonLength; i++) {
        patch(oc[i], nc[i])
      }
      if (nc.length > oc.length) {
        nc.slice(oc.length).forEach((c) => mount(c, el))
      } else if (oc.length > nc.length) {
        oc.slice(nc.length).forEach((c) => {
          el.removeChild(c.el)
        })
      }
    } else {
      el.innerHTML = ''
      nc.forEach((c) => mount(c, el))
    }
  }
}

const Component = {
  data() {
    return {
      count: 0
    }
  },
  render() {
    return h(
      'div',
      {
        onClick: () => {
          this.count++
        }
      },
      String(this.count)
    )
  }
}

function createApp(Component, container) {
  // implement this
  const state = reactive(Component.data())
  let isMount = true
  let prevTree
  watchEffect(() => {
    const tree = Component.render.call(state)
    if (isMount) {
      mount(tree, container)
      isMount = false
    } else {
      patch(prevTree, tree)
    }
    prevTree = tree
  })
}

// calling this should actually mount the component.
createApp(Component, document.getElementById('app'))
</script>
```

# Vue3源码中学到了什么

## 性能

- 缓存
- Diff算法：贪心+二分
- 位运算

> **缓存**

缓存的本质是**用空间换时间**。 Vue 里使用了 `WeakMap` 这个内置对象缓存响应式数据。使用 `WeakMap` 而不是 `Map` 的目的，是让 JS 引擎在垃圾回收时**释放已经没有引用的内存对象**，提升查询速度和避免内存溢出。

> **Diff算法：贪心+二分**

**Diff** 算法应该说是 Vue 源码里**难度最高**的算法。即便是整个源码中最难的算法，在 Leetcode 上也只是**中等难度**的题目。

一个流行的框架最伟大、最核心的地方，不是他用了多难的算法，而是他从某一类别应用的传统的开发方式中，**抽象出一套公式**。将固化的、重复的、复杂的事情留给框架自己，让使用者可以更关注自己的需求如何实现，同时又提供了一定的灵活性。

算法只是锦上添花。引入算法以优化框架的性能，能让框架更有竞争力，但框架主张的开发模式、带来的设计思想，才是核心。

 根据二八定律，一件事情的核心工作只占20%，在安全漏洞、性能瓶颈方面也一样。识别出软件的性能瓶颈，储备一定的算法知识，再加以实际应用，做好这20%，也就离100%不远了。

- Diff算法解析：http://hcysun.me/vue-design/zh/renderer-diff.html#减小dom操作的性能开销
- LeetCode.300：https://leetcode-cn.com/problems/longest-increasing-subsequence/

> **位运算**

位运算大量用于底层软件开发,在计算资源和内存资源寸土寸金的板子上，用一个bit的高低电平来判断是或否，位运算精准而优雅。

 位运算在 框架/平台 类核心模块编码时可以借鉴，而以CRUD为主的业务类需求，则尽量使用人类（开发者）易于理解的表述方式。

 一是因为**业务逻辑变化频繁**，使用标志位和位运算往往需要**事先对所有枚举值做全面的规划**，如 Linux 文件系统的权限标志位；

 二是**方便自己和其他开发者阅读代码**，好的代码应该是写一次而经得起读百次的。

## 可扩展性

 Vue3 的源码采用 Monorepo 来管理各个包，repo 的组织结构非常完整而合理，各模块各司其职，充分解耦并且提供了极大的可扩展性，每一个 package 都独立提供了足够通用和抽象的API。

## Composition API：组合 > 继承

Vue3 提供了 Composition API，借鉴了 React Hooks。

 从 Vue 的 Options API、React 的 Class Component，两大框架殊途同归，最终都拥抱了 Function Component，说明**函数式编程**十分适应前端（UI）的开发。

## 计算机底层知识：编译

模板或JSX**为用户提供了足够简单、直观的编码方式**（而不是让你自己去写渲染函数），把复杂的事情留给了框架自己。

在Vue2.x版本之前，Vue 没有将编译器与核心模块分离，在运行时引入编译器会使 Vue 整个包的体积变大，在Vue2.x之后，如果使用 webpack + SFC，webpack 会在打包编译阶段将 template 转成**渲染函数**（render function），并且提供了选项，使得运行时 Vue 可以剥离其编译器，减少体积，在 webpack 打包阶段完成 template 编译，也能提升运行时性能。

## 工具

**Typescript**

人总是会犯错，任何事情的成功都不能依赖人的自觉性。Typescript 的编译时类型检查能让大部分常见的错误在开发阶段消除，让代码更加健壮和易于维护。

**Rollup**

Rollup是一款小巧的 Javascript 模块打包工具，更适合于**库应用的构建工具**；可以将小块代码编译成大块复杂的代码，基于ES6 modules，它可以让你的 bundle 最小化，有效减少文件请求大小。

**Monorepo & Lerna**

越来越多的主流框架/库采用monorepo方式来组织自己的代码仓。

lerna 是一个管理多个 npm 模块的工具，是 Babel 自己用来维护自己的 Monorepo 并开源出的一个项目。优化维护多包的工作流，解决多个包互相依赖，且发布需要手动维护多个包的问题。

lerna 现在已经被很多著名的项目组织使用，如：Babel, React, Vue, Angular, Ember, Meteor, Jest 。
