---
title: 源码_Vue3.0
date: 2023-09-12 07:33:16
categories:
- D_框架和类库
toc: true # 是否启用内容索引
---

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
> pnpm serve
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

# 尤大手写mini-vue

**一、整体流程**

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

#