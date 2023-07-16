---
title: VueReactAngular比较
date: 2023-03-01 07:33:16
categories:
- D_框架和类库
toc: true # 是否启用内容索引
---

# 框架原理

**不用去在意 Vue 和 React 哪个好**，这种比较没什么意义，**重要的是哪个适合自己/团队，能为自己/团队实现价值**。

卡颂大佬在《React 设计原理》中，提出了一个观点：现代前端框架的实现原理都可以用以下公式进行概括：

**UI = f(state)**

其中：

- state —— 当前的视图的状态
- f —— 框架内部的运行机制
- UI —— 宿主环境的视图

**如何描述 UI**

前端领域经过长期发展，形成了两种主流的 UI 描述方案：

- JSX
- template

JSX 是 Meta（原 Facebook）提出的一种 **ECMAScript 的语法糖**，增强了代码的可读性，但其实最终 JSX 在运行时会被转换成浏览器能够识别的标准 ECMAScript 语法。

template 模板的历史更加久远，它是前后端未分离的时代，已经有的产物，它扩充的是 HTML 语法。

**数据驱动**

框架内部运行机制的实现，可以概括为以下两个步骤：

1. 根据 state 计算出 UI 变化，如， Vue 和 React 通过对比变化前后的 VNode，知道需要更新哪些元素
2. 根据 UI 变化，执行具体宿主（如浏览器）的 API。

> 为什么需要分离成两个步骤？
>
> 前端框架通常会抽离出一套抽象的元素操作的 API，例如：新增/删除/移动元素、修改元素属性等原子操作。不会直接操作浏览器 DOM。这样为了做到平台无关

**按 state 变化后，引起框架的 UI 变更的抽象层级**，作为分类依据，可以将框架分为三类：

- 应用级框架：数据变化 > 应用变化 > 比对应用 > 更新元素
- 组件级框架：数据变化 > 组件变化 > 比对组件 > 更新元素
- 元素级框架：数据变化 > 元素变化 > 更新元素

无论哪种路径，都是从最开始的数据变化，到最终的更新元素。只是**不同框架，能够监听的变化层级不同，从而有了不同的处理**

框架能够监听的层级越抽象，就需要**花费更多的时间用于比对变化**。例如应用级框架，需要比对整个应用前后的变化。

在我们常见的框架中：

- React 属于应用级框架
- Vue 属于组件级框架
- Svelte 属于元素级框架

**前端框架用到的技术**

- 响应式：实现了细粒度的更新，是组件级应用的一种实现
- Virtual DOM：最终目的是快速找出一组 UI 元素中变化的部分，应用级和组件级框架需要使用。元素级框架由于直接指导变化的元素，因此不需要
- AOT 预编译优化：使用模板的框架，能从 AOT 预编译优化中受益，因为模板的结构固定，容易分析。JSX 则难以优化，除非约束 JSX 的灵活性

> 响应式

这是一种**自动追踪依赖的技术**，它用于自动追踪依赖的状态，当状态改变时进行更新。

> Virtual DOM

VDOM 有以下优点：

- 相对于 DOM 有体积优势
- 多平台渲染能力

VDOM 可以多平台渲染能力，但反过来，多平台渲染能力，不一定需要 VDOM

VDOM 的最终目的，其实是用于 Diff，计算出 UI 中变化的部分。但刚好又可以用于多平台渲染。

> AOT 预编译优化

现在前端框架一般都有编译这一步骤，用于：

- 代码转换，如：ts 编译为 js，Vue 将 vue 文件转换成 js
- 编译优化
- 代码压缩、打包

编译有两个执行时机：

- 构建时编译（AOT，预编译）
- 运行时编译（JIT，即时编译）

它们的区别如下：

- AOT 可以提前进行编译，用户直接运行编译后的代码，可以减少首屏时间。而 **JIT 则会消耗更多时间用于编译**
- JIT 的应用代码**体积会更大**，因为需要包含编译的相关逻辑

因此，在大多数情况下，我们使用 AOT 更多。不过有些框架（例如 Vue）会同时提供了 AOT 和 JIT 两种使用方式，以应对一些特殊的情况。

# 三大框架解析1

**1三大框架介绍**
 **1)angular**
 **历史**:2012开始1.0版本，16年升级2.0版本。新版本支持es6和ts。
 **基本特点**：
 双向绑定；
 依赖注入；
 基于ts的组件；
 良好的应用架构；
 工具生态完整，angular-cli用于创建、开发、测试等。有整套的解决方案，适合大型项目。
 **缺点**：中文文档较少，框架较重，学习成本高。
 **2)react**
 **历史**：2013年facebook发布版本。2015年版本稳定，同年发布reacr-native。
 **基本特点**：
 虚拟dom，跨浏览器兼容，性能较好；
 组件化，代码复用;
 JSX,js语法的扩展，模板简单、直接、语义化。
 单项数据流：数据流清晰，组件状态更可控。
 **缺点**：
 本身只是view，大型项目需要加上React Router和Redux。
 **3)VUE**
 **历史**：
 2015年1.0版本发布，同年vue-router、vuex、vue-cli出现，标志从一个视图层发展成一个渐进式框架。
 2016年vue2.0发布，引入虚拟dom，性能大幅提升。
 2019年vue2.0公布源码。
 **基本特点**：
 渐进式、轻量级框架;
 简单易用;
 双向数据绑定;
 组件化;
 轻量高效(使用虚拟dom，压缩后只有20kb)
 **缺点**：
 vue不支持IE8，生态比较差(语法提示不友好，插件数量比较少)

**2.vue和react比较**

工程实践上，由于耦合性、代码组织灵活性、平滑升级、测试、重构让我们最终放弃了 Vue。在 Vue 中你操作的是定义好的对象，React 中你操作的是一个函数。所谓前端开发，本质就是在编写下面几个函数。显然，React 对此的抽象更为彻底。

```
S = async(A1)
S = sync(A2)
UI = f(S)
```

**相同点：**

(1)都使用Virtural DOM

(2)都使用组件化思想，流程基本一致

(3)都是响应式，推崇单向数据流

(4)都有成熟的社区，都支持服务端渲染

Vue和React实现原理和流程基本一致，都是使用Virtual DOM + Diff算法.不管是Vue的template模板 + options api写法，还是React的Class或者Function（js 的class写法也是function函数的一种）写法，底层最终都是为了生成render函数,

Vue和React通用流程：vue template/react jsx -> render函数 -> 生成VNode -> 当有变化时，新老VNode diff -> diff算法对比，并真正去更新真实DOM。

**差异点：**

**(1)核心思想不同**

Vue早期定位是尽可能的降低前端开发的门槛，Vue推崇灵活易用（渐进式开发体验），数据可变，双向数据绑定（依赖收集和派发更新）。

React早期口号是Rethinking Best Practices。想要做的是用更好的方式去颠覆前端开发方式，推崇函数式编程（纯组件），数据不可变以及单向数据流。函数式编程最大的好处是其稳定性（无副作用即对主函数（调用者）没有附加影响）和可测试性（输入相同，输出一定相同）。

(1.1)核心思想不同导致写法差异

Vue推崇template。React推崇JSX、HOC、all in js

(1.2)api差异

Vue定位简单易上手，基于template模板 + options API。比如template模板中需要理解slot、filter、指令等概念和api，options API中需要理解watch、computed（依赖收集）等概念和api。

`React本质上核心只有一个Virtual DOM + Diff算法`，所以API非常少，知道setState就可以开发。

(1.3)社区差异

`由于Vue定义简单易上手，能快速解决问题，所以很多常见的解决方案，是Vue官方主导开发和维护`。比如状态管理库Vuex、路由库Vue-Router、脚手架Vue-CLI、Vutur工具等。属于那种大包大揽，遇到某类通用问题，只需要使用官方给出的解决方案即可。

React只关注底层，上层应用解决方案基本不插手。连最基础的状态管理早期也只是给出flow单向数据流思想，大部分都丢给社区去解决。比如状态管理库方面，有redux、mobx、redux-sage、dva等一大堆（选择困难症犯了），所以这也造就了React社区非常繁荣。

(1.4)未来升级方向不同

Vue依然会定位简单易上手（渐进式开发），依然是考虑通过依赖收集来实现数据可变。Vue3核心更新内容可以看到：template语法基本不变、options api只增加了setup选项（composition api）、基于依赖收集（Proxy）的数据可变。

`React的函数式编程这个基本盘不会变`。React核心思想，是把UI作为Basic Type，比如String、Array类型，然后经过render处理，转换为另外一个value（纯函数）。从React Hooks可以看出，React团队致力于组件函数式编程，（纯组件，无class组件），尽量减少副作用（减少this，this会引起副作用）。

**(2)组件实现不同**

`Vue源码实现是把options挂载到Vue核心类上，然后再new Vue({options})拿到实例`（vue组件的script导出的是一个挂满options的纯对象而已）。所以options api中的this指向内部Vue实例，对用户是不透明的，所以需要文档去说明this.$slot、this.$xxx这些api。

React内部实现比较简单，直接定义render函数以生成VNode，而`React内部使用了四大组件类包装VNode`，不同类型的VNode使用相应的组件类处理，职责划分清晰明了,用户透明。

**(3)响应式原理不同**

Vue2和Vue3响应式原理基本一致，都是基于依赖收集，不同的是Vue3使用Proxy.

```
Vue依赖收集，自动优化，数据可变。
Vue递归监听data的所有属性,直接修改。
当数据改变时，自动找到引用组件重新渲染。

React基于状态机，手动优化，数据不可变，需要setState驱动新的State替换老的State。
当数据改变时，以组件为根目录，默认全部重新渲染
```

**(4)diff算法不同**

Vue基于snabbdom库，它有较好的速度以及模块机制。`Vue Diff使用双向链表，边对比，边更新DOM。`

`React主要使用diff队列保存需要更新哪些DOM，得到patch树，再统一操作批量更新DOM`。

**(5)事件机制不同**

```
Vue原生事件使用标准Web事件
Vue组件自定义事件机制，是父子组件通信基础
Vue合理利用了snabbdom库的模块插件

React原生事件被包装，所有事件都冒泡到顶层document监听，然后在这里合成事件下发。基于这套，可以跨端使用事件机制，而不是和Web DOM强绑定。
React组件上无事件，父子组件通信使用props
```

**Vue与React的区别小结**

- vue组件分为全局注册和局部注册，在react中都是通过import相应组件，然后模版中引用；
- `props`是可以动态变化的，子组件也实时更新，在react中官方建议props要像纯函数那样，输入输出一致对应，而且不太建议通过props来更改视图；
- 子组件一般要显示地调用props选项来声明它期待获得的数据。而在react中不必需，另两者都有props校验机制；
- 每个Vue实例都实现了事件接口，方便父子组件通信，小型项目中不需要引入状态管理机制，而react必需自己实现；
- vue使用`插槽`分发内容，使得可以混合父组件的内容与子组件自己的模板；
- vue多了`指令系统`，让模版可以实现更丰富的功能，而React只能使用JSX语法；
- Vue增加的语法糖`computed`和`watch`，而在React中需要自己写一套逻辑来实现；
- react的思路是all in js，通过js来生成html，所以设计了jsx，还有通过js来操作css，社区的styled-component、jss等；而 vue是把html，css，js组合到一起，用各自的处理方式，vue有单文件组件，可以把html、css、js写到一个文件中，html提供了模板引擎来处理。
- react做的事情很少，很多都交给社区去做，vue很多东西都是内置的，写起来确实方便一些，比如 redux的combineReducer就对应vuex的modules， 比如reselect就对应vuex的getter和vue组件的computed， vuex的mutation是直接改变的原始数据，而redux的reducer是返回一个全新的state，所以redux结合immutable来优化性能，vue不需要。
- react是整体的思路的就是函数式，所以推崇纯组件，数据不可变，单向数据流，当然需要双向的地方也可以做到，比如结合redux-form，组件的横向拆分一般是通过高阶组件。而vue是数据可变的，双向绑定，声明式的写法，vue组件的横向拆分很多情况下用mixin

# 三大框架解析2

**一、简介**

**angular**

诞生于2009年的Angular可以算得上Web前端三大主流框架中最完整的框架，它包含模板、数据双向绑定、路由、模块化、服务、过滤器、依赖注入等所有功能。虽然出现较早，但是因为其强大的功能，至今使用热度不减。对于刚开始前端初学者来讲，AngularJS完全基于HTML和JavaScript，因此无需学习其他语法或语言。使用TypeScript能够提高代码可维护性，有利于后期重构。
当然，Angular框架也不是完全没有缺点的。虽然双向数据流很方便，但是等业务复杂之后，你可能就搞不清楚数据流了。还有令人不开心的脏值检查，以及directive的封装并没有解决视图与数据关系完全分离的问题，有时候还要用$digist强制触发检测，当然，因为其由Google主导，小伙伴们还是不要选择了，毕竟Angular能搞定的，Vue也是完全能够胜任的。

**React**

React是一个开源的JavaScript库，由Facebook和一个大型开发者社区共同维护。广泛用于开发web应用程序的用户界面。React框架的主要功能是对DOM操作，声明式设计，更快的开发出Web应用系统。使用React框架，可以非常轻松地创建用户交互界面，为应用的每一个状态设计简洁的视图。甚至在数据改变时，React也可以高效地更新渲染界面。
虽然React框架本身比较容易理解，结构很清晰，就是由十几个API组成，然后异步渲染。但是很多人反映上手还是有一定的的难度的。React是单向数据流，代码写起来会较双向数据流的多一些，但是同样的排查问题时思路清晰很多。

**Vue**

Vue框架的最大优势就是简单易上手，同时它也是目前Web前端开发的最常使用的主流框架。Vue.js是用于构建交互式的Web 界面的库。它提供了MVVM数据绑定和一个可组合的组件系统，具有简单、灵活的API。从技术上讲， Vue.js集中在MVVM模式上的视图模型层，并通过双向数据绑定连接视图和模型。实际的DOM操作和输出格式被抽象出来成指令和过滤器。所以相比其它的MVVM框架，Vue.js更容易上手。
而且它能够开发单页面应用程序，还可以用作Web应用程序框架。Vue框架最大的优势就是能够在没有任何动作的情况下重新渲染，而且允许我们在需要时随时添加组件。

**二、React详解**

**概述**

React（有时叫React.js或ReactJS），是一个为数据提供渲染为HTML视图的开源JavaScript 库。React视图通常采用包含以自定义HTML标记规定的其他组件的组件渲染。React为程序员提供了一种子组件不能直接影响外层组件（"data flows down"）的模型，数据改变时对HTML文档的有效更新，和现代单页应用中组件之间干净的分离。
它由Facebook、Instagram和一个由个人开发者和企业组成的社群维护。

**Fiber架构**

Fiber 的中文翻译叫纤程，与进程、线程同为程序执行过程，Fiber 就是比线程还要纤细的一个过程。纤程意在对渲染过程实现进行更加精细的控制。
从架构角度来看，Fiber 是对 React 核心算法（即调和过程）的重写。
从编码角度来看，Fiber 是 React 内部所定义的一种数据结构，它是 Fiber 树结构的节点单位，也就是 React 16 新架构下的"虚拟 DOM"。
一个 fiber 就是一个 JavaScript 对象，Fiber 的数据结构如下：

**Fiber 如何解决问题的**

Fiber 把一个渲染任务分解为多个渲染任务，而不是一次性完成，把每一个分割得很细的任务视作一个"执行单元"，React 就会检查现在还剩多少时间，如果没有时间就将控制权让出去，故任务会被分散到多个帧里面，中间可以返回至主进程控制执行其他任务，最终实现更流畅的用户体验。

**Fiber 实现原理**

实现的方式是requestIdleCallback这一 API，但 React 团队 polyfill 了这个 API，使其对比原生的浏览器兼容性更好且拓展了特性。
window.requestIdleCallback()方法将在浏览器的空闲时段内调用的函数排队。这使开发者能够在主事件循环上执行后台和低优先级工作，而不会影响延迟关键事件，如动画和输入响应。函数一般会按先进先调用的顺序执行，然而，如果回调函数指定了执行超时时间 timeout，则有可能为了在超时前执行函数而打乱执行顺序。
requestIdleCallback回调的执行的前提条件是当前浏览器处于空闲状态。
即requestIdleCallback的作用是在浏览器一帧的剩余空闲时间内执行优先度相对较低的任务。首先 React 中任务切割为多个步骤，分批完成。在完成一部分任务之后，将控制权交回给浏览器，让浏览器有时间再进行页面的渲染。等浏览器忙完之后有剩余时间，再继续之前 React 未完成的任务，是一种合作式调度。
简而言之，由浏览器给我们分配执行时间片，我们要按照约定在这个时间内执行完毕，并将控制权还给浏览器。
React 16 的Reconciler基于 Fiber 节点实现，被称为 Fiber Reconciler。
作为静态的数据结构来说，每个 Fiber 节点对应一个 React element，保存了该组件的类型（函数组件/类组件/原生组件等等）、对应的 DOM 节点等信息。
作为动态的工作单元来说，每个 Fiber 节点保存了本次更新中该组件改变的状态、要执行的工作。
每个 Fiber 节点有个对应的 React element，多个 Fiber 节点是如何连接形成树呢？靠如下三个属性

**Fiber 架构核心**

Fiber 架构可以分为三层：

- Scheduler 调度器 —— 调度任务的优先级，高优任务优先进入 Reconciler
- Reconciler 协调器 —— 负责找出变化的组件
- Renderer 渲染器 —— 负责将变化的组件渲染到页面上
  在新的架构模式下，工作流如下：
- 每个更新任务都会被赋予一个优先级。
- 当更新任务抵达调度器时，高优先级的更新任务（记为 A）会更快地被调度进 Reconciler 层；
- 此时若有新的更新任务（记为 B）抵达调度器，调度器会检查它的优先级，若发现 B 的优先级高于当前任务 A，那么当前处于 Reconciler 层的 A 任务就会被中断，调度器会将 B 任务推入 Reconciler 层。
- 当 B 任务完成渲染后，新一轮的调度开始，之前被中断的 A 任务将会被重新推入 Reconciler 层，继续它的渲染之旅，即“可恢复”。
  Fiber 架构的核心即是"可中断"、"可恢复"、"优先级"。

*Scheduler 调度器*
这个需要上面提到的requestIdleCallback，React 团队实现了功能更完备的 requestIdleCallback polyfill，这就是 Scheduler。除了在空闲时触发回调的功能外，Scheduler 还提供了多种调度优先级供任务设置。

*Reconciler 协调器*
在 React 15 中是递归处理虚拟 DOM 的，React 16 则是变成了可以中断的循环过程，每次循环都会调用shouldYield判断当前是否有剩余时间

*React 16 是如何解决中断更新时 DOM 渲染不完全的问题呢？*
在 React 16 中，Reconciler与Renderer不再是交替工作。当Scheduler将任务交给Reconciler后，Reconciler会为变化的虚拟 DOM 打上的标记。

整个Scheduler与Reconciler的工作都在内存中进行，所以即使反复中断，用户也不会看见更新不完全的 DOM。只有当所有组件都完成Reconciler的工作，才会统一交给Renderer。

**三、Vue详解**

**1.Vue生命周期**

Vue 主要实现了以下几个阶段：

1. 组件初始化，包括事件初始化、数据初始化、依赖注入初始化等；
2. 模板编译，即把 HTML 模板转化为可以被 Vue 利用的渲染函数，其中包括了虚拟 DOM 的概念；

3. DOM 挂载与更新，即把渲染函数的返回值映射为真实的 DOM ，复用或创建新的 DOM 节点；
4. 组件销毁，包括为了实现响应式而挂载的监听器、事件监听器等。

**2.响应式原理**

为了实现无侵入的响应式数据，Vue 使用了设计模式中的代理模式，在 2.x 系列借助 ES 5 对象方法 Object.defineProperty 对原始数据进行代理，在 3.x 系列中则使用 ES 6 Proxy 对象进行代理。ES 5 对象方法要求 ES 5 支持，因此 Vue 2.x 不支持 IE 8 以下的版本。ES 6 Proxy 要求 ES 6 支持，因此 Vue 3.x 无法支持 IE 11 。下文我们以目前广泛使用的 Vue 2.x 版本为例讲解数据响应式原理。
其中 Object.defineProperty 只能代理属性的 set/get 方法，而 ES 6 Proxy 可以代理 defineProperty/deleteProperty 等方法，能够更全面地代理数据的增删改查，规避了原来使用 Object.defineProperty 无法捕捉的情况。这也是为什么 Vue 3 使用 ES 6 Proxy 的原因。

**对象**

Vue无法检测对象属性的添加或移除。由于 Vue 会在初始化实例时对属性执行 getter/setter 转化，所以属性必须在 data 对象上存在才能让 Vue 将它转换为响应式的。

对于已经创建的实例，Vue 不允许动态添加根级别的响应式 property。但是，可以使用 Vue.set(object, propertyName, value) 方法向嵌套对象添加响应式 property。

```
Vue.set(vm.someObject, 'b', 2)
```

这行语句的原理是虽然修改的是 b 属性的值，但是触发 someObject 的更新。在这种情况下，你应该用原对象与要混合进去的对象的属性一起创建一个新的对象。

```
this.someObject = Object.assign({}, this.someObject, { a: 1, b: 2 })
```

**数组**

在 JS 中，数组可以看作是一类特殊的对象，因此，对于数组而言 Vue 2.x不能检测以下数组的变动：
当你利用索引直接设置一个数组项时，例如：vm.items[indexOfItem] = newValue；
当你修改数组的长度时，例如：vm.items.length = newLength；

但是数组新增元素的情况要比对象新增属性常用得多，因此有必要解决数组无法响应新增属性的问题。为此，Vue 把数组的方法都代理了，调用数组方法相当于 *Vue.set(...)*。因此，用数组的方法也可以使数组保持响应的。例如：

```
vm.items.splice(newLength)
```

**依赖收集**

依赖收集主要依赖两个数据结构实现，分别是 `Dep` 和 `Watcher` ，`Watcher` 封装观察者的信息，而 `Dep` 封装了依赖队列。每个响应式属性都有一个 `Dep` 维护其 `Watcher` 队列，当数据变化时逐个调用 `Dep` 队列中封装的 `Watcher` 实现视图更新。
其过程大致是渲染函数初始化 `Watcher` ，把重新渲染作为 `Watcher` 的回调，触发具体渲染，如果获取了响应式数据，则在 getter 里把 `Watcher` 收集到对应的 `Dep` 中。当事件触发了响应式数据更新，则在其 setter 里通知 `Dep` 中的 `Watcher` 触发视图更新。
读者在此处可能会对如何收集 `Watcher` 有疑问，毕竟 `Watcher` 和 getter 分别在两个过程中定义的，两者如何关联起来？答案是用了全局变量 `Dep.target` 在模块内形成了一个闭包。因此，如果页面上引用了两个 Vue （最常见的情况是创建库的时候把 Vue 打包进去了），响应式属性是无法在两个 Vue 中共享的，可能会造成难以定位的问题。

**响应时机**

由于 JS 是一个单线程的执行环境，也就是说每次只能执行一件事，意味着执行 JS 和更新 DOM 只能选一样执行。每次响应式属性变更时，如果都直接触发界面更新，那么在一个函数里对响应式数据进行大量更新时，就会出现“DOM 更新 - JS 执行 - DOM 更新…”的循环，如果 JS 执行较慢，就会出现卡顿，这显然不是我们想要的。因此，Vue 在更新 DOM 时是**异步**执行的。
只要侦听到数据变化，Vue  将开启一个队列，并缓冲在同一事件循环中发生的所有数据变更。如果同一个 watcher  被多次触发，只会被推入到队列中一次。这种在缓冲时去除重复数据对于避免不必要的计算和 DOM  操作是非常重要的，在下一章虚拟 DOM 的时候会详细讲述。然后，在下一个的事件循环（在 JS 的术语里称为“tick”）中，Vue 刷新队列并执行实际（已去重的）工作。
值得注意的是，Vue 在内部对异步队列尝试使用原生的 `Promise.then`、`MutationObserver` 和 `setImmediate`，如果执行环境不支持，则会采用 `setTimeout(fn, 0)` 代替，本质上是希望利用事件队列中的微任务在逻辑后进行视图更新。

**3.模板编译**

**渲染函数**

一般在使用 Vue 的时候都会使用 Vue 单文件组件里的 HTML 模板或者直接使用挂载元素的 HTML 模板，HTML 模板为视图提供了一种比 JS 代码更友好的表达形式。但是 Vue 的模板并不是完全是 HTML ，因为 HTML 本身不支持定义自定义组件，缺少这种扩展的机制，Vue 设计了一个编译器，输入通过类似的 HTML 的语法，输出为一个输出到虚拟 DOM 的函数，这个过程称为渲染，这个函数就是渲染函数。

渲染函数采用了构造器的设计模式，通过传入一个构建 VNode 的构造函数，开发者可以层次化地构建出虚拟 DOM 树。例如：

```
{
    render: function (createElement) {
      return createElement('div', [
        createElement('child', {
          // 在数据对象中传递 `scopedSlots`
          // 格式为 { name: props => VNode | Array<VNode> }
          scopedSlots: {
            default: function (props) {
              return createElement('span', props.text)
            }
          }
        })
      ])
    }
}
```

以上函数对应为 HTML 模板：

```
<div>
    <child v-slot="props">
        <span>{{ props.text }}</span>
    </child>
</div>
```

可以看到渲染函数实际上比 HTML 模板复杂而且不直观，但是它是驱动 Vue 模板优化的基本原理。

**虚拟DOM**

实际上，虚拟 DOM 是 React 社区提出来的一个概念。在 Vue 早期（大约 2.0 以前），Vue 也是没有使用虚拟 DOM 的。使用虚拟 DOM 的原因主要是直接操作 DOM 会带来重大的性能影响。
主要体现在两方面：

- DOM 节点的属性多，空间开销较大，频繁操作必定会带来性能问题：
- JS 是单线程语言，每次操作 DOM 都是阻塞操作，将会阻塞 JS 的执行，操作 DOM 的时候无法同时执行 JS ，执行 JS 的时候无法更新 DOM ，频繁地切换将会导致动画不能及时响应。更为重要的是，即使 DOM 没有属性值没有更新，但是设置 DOM 的属性值也将阻塞 JS 的执行。

**Diff 算法**

在介绍 Diff 算法前，需要了解一个关于浏览器渲染的概念：

- 回流（reflow）：当 DOM 的布局变化时，例如改变元素大小、位置或者增减元素，浏览器需要清楚当前 DOM 子树并应用重新计算的结果。

- 重绘（redraw）：当 DOM 的属性修改时，例如改变字体颜色，浏览器并不需要重新计算元素的布局，而只要重新绘制新样式。

  很显然回流比重绘更加耗费性能，因此我们在设计 Diff 算法时必须尽可能复用已有元素，避免频繁增减元素造成布局回流。

*算法实现*

虚拟 DOM 应用的核心算法就是 Diff 算法，其目标就是找出两个虚拟 DOM 树之间的最小化差异，好确定要更新的元素。Vue 2.x 的虚拟 DOM 实现主要参考 SnabbDOM ，其 Diff 算法主要有两个特点：

- 同级比较：对于给定两棵树，只比较同一级节点，如果节点类型不同则直接抛弃，重新构建。
- 就近复用：当两个节点类型相同，则复用节点，只修改节点的实例属性。

可以看到该算法主要是在实现简单的基础上尽可能复用节点，避免布局回流。

对于子节点集的比较则是希望找到没有同类型的最小集，为此，Diff 算法用了两个优化策略：

- 双指针比较：对列表的两端分别进行寻找，当两端的值不一致后，按新的前后两端和旧的前后两端比较（尽可能复用已知的索引）
- 按组件 key 寻找：当所有已知索引都无法匹配时，按 key 的散列表寻找，如果还找不到，只能遍历了。
  在实际应用中，新旧 DOM 树往往是比较接近的，因此双指针比较就可以很快地找出差异，剩下的部分再根据 key 或遍历寻找即可。

**4.插件原理**

Vue提供了几种扩展的方式，即：

- 添加全局方法或者property。如vue-custom-element；
- 添加全局资源：指令/过滤器/过渡等。如vue-touch；
- 通过全局混入来添加一些组件选项。如vue-router；
- 添加Vue实例方法，通过把它们添加到Vue.prototype上实现；

**开发插件**

Vue.js 的插件应该暴露一个 `install` 方法。这个方法的第一个参数是 `Vue` 构造器，第二个参数是一个可选的选项对象：

```
MyPlugin.install = function (Vue, options) {
    // 插件逻辑
}
```

当 Vue 使用时，将会被回调：

```
Vue.use(MyPlugin, options);
```

 这个策略也可以认为是一种**依赖反转**，也就是被调用方不需要知道调用方以何种方式引入。因为 Vue 出现的年代里，Webpack 方兴未艾，全局变量引入模块的方式还大行其道，而全局变量名往往会因为冲突而改变，因此使用这种依赖注入的方式能够很好地规避此类情况。

但在现今倡导 ES 模块和 tree-shaking 优化的视角下，实际上 Vue 这么设计是不够优雅的，因为插件将会被全局共享，难以去掉不必要的依赖。在 Vue 3.x 对此已经进行了整改。

# 技术选型建议

**大小**
开发框架的大小对未来应用的性能至关重要。框架和应用程序必须在应用程序开始正常工作之前加载。
在这方面，Angular 最复杂，有143KB。React 次之，有43KB，而 Vue.js只有23KB。除非你的应用特别大，并且包含了大量的组件，否则最好使用更小的结构。

**性能**
在 Web 项目中，性能与 DOM 密切相关：DOM 在浏览器/代码中表示 Web 页面。在发生更新时，你可以通过 DOM 控制 Web页面。
Vue、React和Angular的性能会因为任务的不同而有所差异，但在大多数情况下，它们都非常高效和快速。React和Vue都实现了 DOM。得益于其精心设计的结构，Vue提供了出色的性能和内存分配。这就是 React 和 Vue.js 优于Angular的地方：它们利用了虚拟 DOM。

**社区**
React 是世界上最流行的框架，这已不是什么秘密。它越来越受欢迎，因为它提供了真正的 Promise。React 的 Mental Model 看起来很可靠，其组件让创建用户界面变得更容易，API 灵活且富有表现力，整个项目给人的感觉是就应该那样。对 API 库的描述也友好，更容易给人留下良好的印象。
从那时起，React 库在基本概念和 API 方面就基本保持不变，但已经形成并发展出了一整套的知识和最佳实践，越来越多的人在使用它。Angular 因其优点而备受赞誉，并拥有大量的社区支持。遗憾的是，尽管 Vue.js 有很多好处，但它并没有像它的竞争对手那样被开发者所接受。
下面让我们从流行度和相关性两个方面比较下这三个框架：

- GitHub：目前，Vue.js 是最流行的框架，尽管它是最年轻的，这意味着越来越多的项目将使用它。
- 谷歌搜索：在谷歌搜索中，React 查询请求最多，紧随其后的是 Vue.js。目前最不受欢迎的是 Angular.js。Angular.js 的人气在下降，而 Vue.js 的人气却在上升。

**Vue、React 和 Angular：该选哪个？**

 为了选出最合适的库，你应该首先仔细分析这些框架并理解自己的需求。无论是有许多依赖项的现有项目，还是你想使用熟悉的库进行开发的新应用程序，Vue 都不会给你带来任何麻烦。你可以继续使用 Bootstrap 或 Bulma 这样的 CSS 框架，保留为јQuery 或 Backbone 编写的组件，集成你最喜欢的库执行 HTTP 请求，或使用 Promise 对象。

 要开始使用 Vue 进行编程，你所要做的就是将 Vue.js 库连接到 Web 页面。不需要复杂的组装工具！从头到尾开发一个原型只需要 1 到 2 周的时间，这让你能够尽早并经常地收集用户反馈。Vue 2 引入了服务器端渲染（SSR）支持。这让你可以最小化初期的数据加载，并根据需要请求新的视图和资源。与高效的组件缓存相结合，可以进一步减少流量消耗。
 React 库能够做一些令人惊叹的事情。因为整个用户界面都是用 JavaScript 定义的，所以你可以使用 JavaScript 的丰富功能在模板中执行各种操作。你只会受到 JavaScript 特性的限制，而不会受到模板框架特性的限制。当你想到完全用 JavaScript 定义的视觉效果时，你可能会想到很多引号、转义字符和 createElement 调用。别担心，React 库允许你（选择性地）使用可以与 JavaScript 代码共存的 HTML-like JSX 语法定义可视元素。
 React 与其他两个框架在以下理念上有所不同：
 与其说它是一个框架，不如说它是一个库（最初是为了处理 UI 而创建的），因为它不受框架的限制，所以它的功能更多——更适合专业人士，而不是初学者；在 Angular 中许多可以“开箱即用”的主要特性，在这里必须单独连接（这种方法有优点，也有缺点，对于初学者来说是缺点，因为需要做不必要的动作）；更多地面向 JavaScript 而不是 TypeScript（尽管每个版本对 TS 的支持都在增加）；更便于创建原生 Android 和 iOS 移动应用程序，拥有大量适用于各种场合的第三方库（多于 Angular）。
 Angular 已经被用在了许多规模最大、最复杂的 Web 应用程序中。

# Hooks

- [浅谈：为啥vue和react都选择了Hooks](https://juejin.cn/post/7066951709678895141#heading-1)

**定义**

"hooks" 直译是 “钩子”，它并不仅是 `react`，甚至不仅是前端界的专用术语，而是整个行业所熟知的用语。通常指：

> 系统运行到某一时期时，会调用被注册到该时机的回调函数。

以 `react` 为例，`hooks` 是：

> 一系列以 `“use”` 作为开头的方法，它们提供了让你可以完全避开 `class式写法`，在函数式组件中完成生命周期、状态管理、逻辑复用等几乎全部组件开发工作的能力。

而在 `vue` 中， `hooks` 的定义可能更模糊，姑且总结一下：

> 在 `vue` 组合式API里，以 `“use”` 作为开头的，一系列提供了组件复用、状态管理等开发能力的方法。

**命名规范和指导思想**

在 `react` 官方文档里，对 `hooks` 的定义和使用提出了 **“一个假设、两个只在”** 核心指导思想。

> **一个假设：** 假设任何以 「`use`」 开头并紧跟着一个大写字母的函数就是一个 `Hook`。
>
> **第一个只在：** 只在 `React` 函数组件中调用 `Hook`，而不在普通函数中调用 `Hook`。（`Eslint` 通过判断一个方法是不是大坨峰命名来判断它是否是 `React` 函数）
>
> **第二个只在：** 只在最顶层使用 `Hook`，而不要在循环，条件或嵌套函数中调用 Hook。
>
> 因为是约定，因而 `useXxx` 的命名并非强制，你依然可以将你自定义的 `hook` 命名为 `byXxx` 或其他方式，但不推荐。

**为什么我们需要 `hooks` ?**

- 更好的代码组织
- 更好的逻辑复用

**如何开始玩 `hooks`** 

react 的 `Hooks` 写法，因为 react Hooks 仅支持“函数式”组件，因此需要创建一个函数式组件 `my-component.js`

```
// my-component.js
import { useState, useEffect } from 'React'

export default () => {
  // 通过 useState 可以创建一个 状态属性 和一个赋值方法
  const [ name, setName ] = useState('')

  // 通过 useEffect 可以对副作用进行处理
  useEffect(() => {
    console.log(name)
  }, [ name ])

  // 通过 useMemo 能生成一个依赖 name 的变量 message
  const message = useMemo(() => {
    return `hello, my name is ${name}`
  }, [name])

  return <div>{ message }</div>
}
```

vue 的 `Hooks` 写法，vue 的 `Hooks` 写法依赖于 `组合式API`，因此本例采用 `<script setup>` 来写：

```
<template>
  <div>
    {{ message }}
  </div>
</template>
<script setup>
import { computed, ref } from 'vue'
// 定义了一个 ref 对象
const name = ref('')
// 定义了一个依赖 name.value 的计算属性
const message = computed(() => {
  return `hello, my name is ${name.value}`
})
</script>
```

**自定义Hooks**

react写法：

```
import React from 'react';

export const useName = () => {
  // 这个 useMemo 很关键
  const randomName = React.useMemo(() => genRandomName(), []);
  const [ name, setName ] = React.useState(randomName)

  return {
    name,
    setName
  }
}
```

vue写法：

```
import { ref } from 'vue';

export const useName = () => {
  const name = ref(genRandomName())
  const setName = (v) => {
    name.value = v
  }
  return {
    name,
    setName
  }
}
```

# Mixin-HOC-Hook

参考

- [【React深入】从Mixin到HOC再到Hook](https://juejin.cn/post/6844903815762673671#heading-1)

**前言**

Mixin-HOC的缺点：

- 渲染上下文中公开的属性的来源不清楚。 例如，当使用多个 mixin 读取组件的模板时，可能很难确定从哪个 mixin 注入了特定的属性。

- 命名空间冲突。 Mixins 可能会在属性和方法名称上发生冲突，而 HOC 可能会在预期的 prop 名称上发生冲突。

- 性能问题，HOC 和无渲染组件需要额外的有状态组件实例，这会降低性能。

Hook的优点：

- 暴露给模板的属性具有明确的来源，因为它们是从 Hook 函数返回的值。

- Hook 函数返回的值可以任意命名，因此不会发生名称空间冲突。

- 没有创建仅用于逻辑重用的不必要的组件实例。

Hook的缺点：比如 `ref` 带来的心智负担

## Mixin

广义的mixin方法，就是用赋值的方式将mixin对象中的方法都挂载到原对象上，来实现对象的混入，类似ES6中的Object.assign()的作用。原理如下：

```
const mixin = function(obj, mixins){
  const newObj = obj;
  newObj.prototype = Object.create(obj.prototype);

  for(let prop in mixins){ // 遍历mixins的属性
    if(mixins.hasOwnPrototype(prop)){ // 判断是否为mixin的自身属性
      newObj.prototype[prop] = mixins[prop]; // 赋值
    }
  }

  return newObj;
}
```

**React.createClass的mixins的危害**

1. Mixin 可能会相互依赖，相互耦合，不利于代码维护
2. 不同的 Mixin中的方法可能会相互冲突
3. Mixin非常多时，组件是可以感知到的，甚至还要为其做相关处理，这样会给代码造成滚雪球式的复杂性 `React.createClass`现在已经不再推荐使用`Mixin`来解决代码复用问题，因为`Mixin`带来的危害比他产生的价值还要巨大，并且`HOC`是纯净的JavaScript，不用担心他们会被废弃。

`React`现在已经不再推荐使用`Mixin`来解决代码复用问题，因为`Mixin`带来的危害比他产生的价值还要巨大，并且`React`全面推荐使用高阶组件来替代它。

## HOC(High-Order-Components高阶组件)

高阶组件可以看作`React`对装饰模式的一种实现，高阶组件就是一个纯函数，且该函数接受一个组件作为参数，并返回一个新的组件。

**高阶组件实现的方法有两种：**

1. 属性代理：通过被包裹组件的props来进行相关操作。主要进行组件的复用。
2. 反向继承：继承被包裹的组件。主要进行渲染的劫持。

**高阶组件可以实现什么功能:**

1. **双向绑定**
2. **组合渲染:** 可使用任何其他组件和原组件进行组合渲染，达到样式、布局复用等效果。
3. **条件渲染:** 根据特定的属性决定原组件是否渲染
4. **操作props:** 可以对传入组件的props进行增加、修改、删除或者根据特定的 props进行特殊的操作。
5. **获取refs:** 高阶组件中可获取原组件的 ref，通过 ref获取组件实例, 从而可以实现对组件中的方法进行调用
6. **状态管理:** 将原组件的状态提取到 HOC中进行管理
7. **操作state:** 通过反向继承，我们可以直接操作原组件的 state
8. **渲染劫持:** 高阶组件可以在render函数中做非常多的操作，从而控制原组件的渲染输出。只要改变了原组件的渲染，我们都将它称之为一种 渲染劫持。

**HOC的缺陷**

1. HOC需要在原组件上进行包裹或者嵌套，如果大量使用 HOC，将会产生非常多的嵌套，这让调试变得非常困难。
2. HOC可以劫持 props，在不遵守约定的情况下也可能造成冲突。

**为什么在 Vue 中实现高阶组件比较难**

主要是二者的设计思想和设计目标不同，在 `React` 中写组件就是在写函数，函数拥有的功能组件都有。而 `Vue` 更像是高度封装的函数，在更高的层面 `Vue` 能够让你轻松的完成一些事情，但与高度的封装相对的就是损失一定的灵活，你需要按照一定规则才能使系统更好地运行。

## **Hook**

使用 Hooks，你可以在将含有 state的逻辑从组件中抽象出来，这将可以让这些逻辑容易被测试。 Hooks可以帮助你在不重写组件结构的情况下复用这些逻辑。

```
<template>
 <p>{{ person.name }}</p>
 <p>{{ car.name }}</p>
 <p>{{ animal.name }}</p>
</template>


<script lang="ts" setup>
import { usePerson, useCar, useAnimal } from "./hooks";


const { person, changePersonName } = usePerson();

const { car } = useCar();
</script>
```

```
// usePerson.ts
import { reactive, watch } from "vue";

export default function usePerson() {
 const person = reactive<{ name: string; sex: string }>({
  name: "小明",
  sex: "male",
 });
 watch(
  () => [person.name, person.sex],
  ([nameVal, sexVal]) => {
   console.log(`名字被修改了, 修改为 ${nameVal}`);
   console.log(`名字被修改了, 修改为 ${sexVal}`);
  }
 );
 function changePersonName() {
  person.name = "小浪";
 }
 return {
  person,
  changePersonName,
 };
}
```

**使用Hooks的动机**

1. 减少状态逻辑复用的风险: Hook和 Mixin在用法上有一定的相似之处，但是 Mixin引入的逻辑和状态是可以相互覆盖的，而多个 Hook之间互不影响，这让我们不需要在把一部分精力放在防止避免逻辑复用的冲突上。
2. 避免地狱式嵌套
3. 让组件更容易理解
4. 使用函数代替class

## React Hook 和 Vue Hook 对比

 React Hook 的缺点(限制非常多)：

- 不要在循环，条件或嵌套函数中调用 Hook

- 确保总是在你的 React 函数的最顶层调用他们。

- 遵守这条规则，你就能确保 Hook 在每一次渲染中都按照同样的顺序被调用。这让 React 能够在多次的 useState 和 useEffect 调用之间保持 hook 状态的正确。

Vue Hook的优点：

- 与 React Hooks 相同级别的逻辑组合功能，但有一些重要的区别。 与 React Hook 不同，`setup` 函数仅被调用一次，这在性能上比较占优。

- 对调用顺序没什么要求，每次渲染中不会反复调用 Hook 函数，产生的的 GC 压力较小。

- 不必考虑几乎总是需要 useCallback 的问题，以防止传递`函数prop`给子组件的引用变化，导致无必要的重新渲染。

- React Hook 有臭名昭著的闭包陷阱问题（甚至成了一道热门面试题，omg），如果用户忘记传递正确的依赖项数组，useEffect 和 useMemo 可能会捕获过时的变量，这不受此问题的影响。 Vue 的自动依赖关系跟踪确保观察者和计算值始终正确无误。

- 不得不提一句，React Hook 里的「依赖」是需要你去手动声明的，而且官方提供了一个 eslint 插件，这个插件虽然大部分时候挺有用的，但是有时候也特别烦人，需要你手动加一行丑陋的注释去关闭它。

黄子毅大大眼中的Vue Hook的优点：

- `setup` 仅执行一遍，而 React Function Component 每次渲染都会执行

- Vue 的代码使用更符合 JS 直觉。JS 并非是针对 Immutable 设计的语言，所以 Mutable 写法非常自然，而 Immutable 的写法就比较别扭。

- 当 Hooks 要更新值时，Vue 只要用等于号赋值即可，而 React Hooks 需要调用赋值函数，当对象类型复杂时，还需借助第三方库才能保证进行了正确的 Immutable 更新。

- 对 Hooks 使用顺序无要求，而且可以放在条件语句里。

 > 对 React Hooks 而言，调用必须放在最前面，而且不能被包含在条件语句里，这是因为 React Hooks 采用下标方式寻找状态，一旦位置不对或者 Hooks 放在了条件中，就无法正确找到对应位置的值。
 >
 > 而 Vue Function API 中的 Hooks 可以放在任意位置、任意命名、被条件语句任意包裹的，因为其并不会触发 `setup` 的更新，只在需要的时候更新自己的引用值即可，而 Template 的重渲染则完全继承 Vue 2.0 的依赖收集机制，它不管值来自哪里，只要用到的值变了，就可以重新渲染了。

- 不会再每次渲染重复调用，减少 GC 压力

 > React的Hooks 都在渲染闭包中执行，每次重渲染都有一定性能压力，而且频繁的渲染会带来许多闭包，虽然可以依赖 GC 机制回收，但会给 GC 带来不小的压力。
 >
 > Vue Hooks 只有一个引用，所以存储的内容就非常精简，也就是占用内存小，而且当值变化时，也不会重新触发 `setup` 的执行，所以确实不会造成 GC 压力。

- React 必须要总包裹 `useCallback` 函数确保不让子元素频繁重渲染

 > Vue 3.0，由于 `setup` 仅执行一次，因此函数本身只会创建一次，不存在多实例问题，不需要 `useCallback` 的概念，更不需要使用 [lint 插件](https://link.juejin.cn/?target=https%3A%2F%2Fwww.npmjs.com%2Fpackage%2Feslint-plugin-react-hooks) 保证依赖书写正确.

- Vue不需要使用 `useEffect` `useMemo` 等进行性能优化，所有性能优化都是自动的。

[React Hook + TS 购物车实战（性能优化、闭包陷阱、自定义 hook）](https://juejin.cn/post/6844904079181905927)

**参考**

[Vue3 究竟好在哪里？（和 React Hook 的详细对比）](https://juejin.cn/post/6844904132109664264#heading-9)

[精读《Vue3.0 Function API》](https://juejin.cn/post/6844903877574295560#heading-4)

## React 和 Vue逻辑结构对比

- Vue：Mutable + Template
- React：Immutable + JSX

JSX 与 Template 的根本区别：

- jsx:JSX 使模版与 JS 可以写在一起，因此数据层与渲染层可以耦合在一起写（也可以拆分）
- template:Vue 采取的 Template 思路使数据层强制分离了，这也使代码分层更清晰

**不建议在 JSX 中再实现类似 Mutable + JSX** 

# 心智负担

**React的心智负担**

不能在条件语句中使用，`useMemo` 和 `useCallback` 需要显式指定依赖，解决子组件重新渲染可能还需要配合 `React.memo` 使用等等。虽然有对应的 `eslint-plugin` 可以帮助填充依赖，但是依赖项一旦很多，代码的可能读会非常差。现在普遍的观点是计算量大的再用 `useMemo`, 而 `useCallback` 能不用就不用。因为这点优化对性能的影响是微乎其微的，99% 的情况下都不会出现问题，等到出现问题的时候再进行优化也不迟。

**Vue的心智负担**

> 定义状态

ref定义的变量使用时，需要.value。虽然有了 `$ref` 语法糖，但最新已经废弃了。解构 `props` 也会出现响应丢失的问题，还要使用 `toRefs` 来解决。

> 插槽

因为在 `react` 中万物皆 `props`。Vue中需要具名插槽和作用于插槽等。

> props 和 emits 的定义

属性 和 事件 还需要分成 defineProps 和 defineEmits 两个 api。反观 react，还是万物皆 props 。

> 侦听 watch

watch监听对象里的某个属性时，第一个参数还需要是一个函数。还分为好多种，watch、watchPostEffect、watchSyncEffect、watchEffect。watch 的第三个参数又有很多属性。

> 渲染函数

`vue3` 提供了一个 `h` 函数，但还是很难用,还不如tsx。

> typescript 支持

存在语法限制。给 `defineProps` 定义的 ts 类型，不能从其它文件导入，只能写在这个文件里。想分开写到别的文件，只能不使用 ts 来定义类型，要使用 `defineProps` 的第一个参数来指定类型，这样才能从别的文件导入了。这就是为什么大多数组件库没有使用 ts 来定义类型的原因，这样定义的类型要用 `ExtractPropTypes` 来提取 ts 类型。

> breaking change

`vue2` 升级到 `vue3` 是不兼容的，旧项目升级是很麻烦的。反观 `react`，几乎是没什么影响。

# SolidJS

## SolidJS是什么

号称支持现代前端特性：**JSX**、**Fragments**、**Context**、**Portals**、**Suspense**、**Streaming SSR**、**Error Boundaries**、**并发渲染**等现代功能。

又一个摒弃 虚拟DOM，跟 Svelte 一样走编译型路线的框架，没了虚拟DOM 运行时，又通过优秀的响应式系统保证更新颗粒度非常小，性能爆表。和 Svelte 不同的是 Solid 直接借用了 React 社区的 JSX 来编写模板，没有像 Vue Svelte 那样去自定义模板语法。总体来讲 React 有的 API 大部分都能在它里面找到，甚至包括 React 18 的 useTransition，SuspenseList. 另外不提供 Class 组件玩法，所有的组件都是函数组件，且该组件函数只会执行一次。内置了 For 组件来替代 map 来优化性能。支持自定指令等

## 使用

```
import { render } from 'solid-js/web';
import { createSignal, createEffect } from 'solid-js';

const Counter = () => {
  const [getCount, setCount] = createSignal(0);
  const add = () => setCount(getCount() + 1);
  createEffect(() => {
    console.log('count is change:', getCount());
  });

  return (
    <button type='button' onClick={add}>
      {getCount()}
    </button>
  );
};

render(() => <Counter />, document.getElementById('root'));
```

**SolidJS**不仅打包体积小，性能也是 **Number 1**

参照[js-framework-benchmark](https://link.juejin.cn/?target=https%3A%2F%2Fkrausest.github.io%2Fjs-framework-benchmark%2Findex.html) 跑分结果

<img src="/img/image-20230614065546092.png" alt="image-20230614065546092" style="zoom:80%;" />

## 特点

### 平衡了 jsx 与 template 的利弊

**jsx** 和 **template** 的优缺点：

> jsx
>
> - 优点：作为`js`的语法糖拥有高度灵活性，可以随意编写
> - 缺点：因为过于灵活在 **编译阶段** 很难分析操作意图
>
> template
>
> - 优点：因为语法有限制，大部分带有 **操作意图（v-if、v-for）** 的代码都可以在 **编译阶段**被识别以做优化
> - 缺点：写法受限，大部分情况下不如`jsx`灵活

**Vue3** 对比 **Vue2** 性能之所以实现了一个质的飞跃，这其中就离不开 **编译阶段优化**。

> 1、 比如在**编译阶段**标记出`template`中永远不会变化的节点作为**静态节点**存储，将来更新时直接绕过他们；
>
> 2、提前对`v-if、v-for`这一类**区块**做区分，将来diff时绕过不必要的判断；
>
> 3、绑定`props`时记录哪些**属性**可能会变，将来 **diff** 时只对比“可能会变化的动态节点和属性”，跳过“永远不会变化的节点和属性”。
>
> 除此之外还有**缓存事件处理程序**等等

但JSX就不能识别操作意图，主要是写法太灵活。如果每种情况都去判断一遍，那么 **编译阶段** 将会非常复杂且耗时，另外显得也非常麻瓜。

```
v-if的写法就有三种：
// 写法1
return status === 1 ? <span>通过</span> : status === 2 ? <span>拒绝</span> : null;
// 写法2
return (
  <>
    {status === 1 && <span>通过</span>}
    {status === 2 && <span>拒绝</span>}
  </>
);
// 写法3
switch (status) {
  case 1:
    return <span>通过</span>;
  case 2:
    return <span>拒绝</span>;
}
```

**SolidJS** 采用的方案是：在 **JSX** 的基础上做了一层规范，中文译名为 [控制流](https://link.juejin.cn/?target=https%3A%2F%2Fwww.solidjs.com%2Fdocs%2Flatest%2Fapi%23%E6%8E%A7%E5%88%B6%E6%B5%81)。写法上类似某种预设的组件，用于**编译阶段**优化。这样在**编译阶段**就可以做**意图分析**，提前知道这是在**做按条件渲染**，然后编译成对应的**dom操作**即可。

SolidJS小结：

> - 即借鉴了 **template** 更容易做编译阶段优化的优势
> - 又保留了 **JSX** 的灵活性

### No Dom Diff

**No Dom Diff** 是说 **SolidJS**在**更新粒度**方面，摒弃了**虚拟dom**，采用**节点级更新**。

目前前端主流的几种方案：

- 应用级更新：状态更新会引起整个应用`render`，具体渲染哪些内容取决于**协调**的结果。代表作有 **React**(因为 **React** 每次更新都会重新走一遍更新流程，做这些限制是为了获取到完整的**VDom树/Fiber树**，通过 **diff新旧两棵树**来决定真正更新哪些组件，所以 **React** 并不是**组件级更新**)
- 组件级更新：状态更新时只会引起绑定了该状态的组件渲染，具体渲染哪些内容同样取决于**协调**的结果。代表作有**vue2.x**
- 节点级更新：状态更新时直接触法绑定该状态的节点更新，也就是**指向型更新**。代表作有**vue1.x**、**Svelte**、**SolidJS**

而**SolidJS**对于三大对象均采用**简单对象**存储，另外不需要**递归观察**，所以占用内存非常少。对于**如何更新dom**，具体的做法是：在**编译阶段**提前生成类似 `insert`、`update`、`delete`的**dom操作**方法，将来更新时直接调用。

### 重·编译时

- 提前生成节点渲染方法

刚才说到 **SolidJS** 在 **jsx** 中借鉴了部分 **template** 的规范写法，在编译阶段 **分析意图**，提前生成对应的**dom操作方法**

- 按需打包，缩小体积

这一步也就是 **tree-shaking**，只打包用到的模块，近一步缩小打包资源体积。

### 轻·运行时

由于没有了**diff**这一大规模计算，使得运行时代码更轻量，所以**SolidJS**在更新时也更**简洁**。

**SolidJS** 在更新时的**js调用栈**如图：

<img src="/img/image-20230614065648667.png" alt="image-20230614065648667" style="zoom:80%;" />

**React v16** 在更新时的**js调用栈**如图：

<img src="/img/image-20230614065722172.png" alt="image-20230614065722172" style="zoom:80%;" />

### 不被顺序限制的 hook

说到前端框架中的 **Hook**，最先将这个方案落地的是**React**，但由于**React**一直推崇 **immutable** 思想，每次更新必须重新走一遍整个树的更新流程，使得 **React Hook** 不可以在条件循环中使用，否则**可能**使渲染结果受到影响。

后来尤大发布了**Vue3.0**，伴随而来的一大特性是**Composition API**，俗称**Vue3 hook**，由于**Vue2**以后都采用**组件级**的**更新粒度**，再加上**响应式原理**采用的是**自动收集依赖**，所以**Vue3 hook**不会有顺序/条件的限制，另外还可以嵌套使用。

**SolidJS**的**响应式原理**主要借鉴了**React Hook**的思想，同时也保留了**Vue3**的**依赖收集模型**，所以用起来非常丝滑。

### 其他

- 脚手架：**degit**，内部集成了 **vite**。
- 支持`TS`且**类型**友好
- 现代前端框架大部分特性：`Fragments`、`Portals`、`Context`、`Suspense`、`事件委托`、`SSR`等等

**参考**

- [比React还Vue3的框架SolidJS](https://juejin.cn/post/7018846783203704863#heading-1)

