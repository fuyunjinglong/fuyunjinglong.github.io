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

# 催学社-Vue3 源码实战课

- [个人vue3源码分析仓库](https://github.com/fuyunjinglong/web-sourceCode-vue3)

## Vue3核心模块

![image](/img/2025-04-03_06-48-27.png)

> - compiler编译期
>   - compiler-sfc：主要把vue单文件组件编译为js文件，其中底层依赖调用了compiler-dom和compiler-core
>     - compiler-dom：主要把template代码片段转换为render函数
>     - compiler-core：dom转换render函数时用到的核心函数
> - runtime运行时
>   - runtime-dom：运行时dom。源码中vue/src/index.js实际是全量导出runtime-dom。源码中runtime-dom/src/index.js实际是全量导出runtime-core，所以又依赖runtime-core
>   - runtime-core：运行时核心函数。源码中runtime-core/src/index.js实际是大量导出reactivity，所以又依赖reactivity
>   - reactivity：运行时响应式系统。

# 《Vue.js 设计与实现》-笔记

## 大纲

《Vue.js 设计与实现》的内容一共分为 6 篇， `18` 个章节：

- 首先第一篇：对 `vue` 的整个框架设计，进行了概述
- 第二篇：主要讲解了 `vue` 中的响应式系统，除了大家所熟悉的 `proxy` 之外，额外还包含了：调度系统 `scheduler`、惰性执行 `lazy`、`ref` 的实现原理
- 第三篇：主要针对 `vue` 的渲染器（`renderer`）进行了讲解，额外还包含了 `diff` 算法的详细讲解
- 第四篇：是组件化。包含了 组件的渲染机制，以及对 `vue` 官方组件 `KeepAlive`、`Teleport`、`Transition` 的实现原理，进行了剖析
- 第五篇：是编译器（`compiler`）。在这一篇中，把编译器的三大步：`parse`、`transform`、`generate` 进行了分步的讲解。
- 最后：是服务端渲染。主要是 `CSR`、`SSR` 以及 同构渲染。

## 第一篇：框架设计概览

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

![image-20230207231540415.png](https://p9-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/1a18c4426c154e9a860ba9aafa683827~tplv-k3u1fbpfcp-watermark.image?)

而 **声明式** 指的就是： **关注结果** 的范式。

![image-20230207231536123.png](https://p3-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/dd8c4bd0f4ff43f6b28c3249d1fd1b29~tplv-k3u1fbpfcp-watermark.image?)

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

## 第二篇：响应式系统

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

## 第三篇：渲染器

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

## 第四篇：组件化

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

## 第五篇：编译器

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

## 第六篇：服务端渲染

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
