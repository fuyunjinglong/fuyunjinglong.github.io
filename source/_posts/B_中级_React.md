---
title: React
date: 2022-01-11 07:33:16
categories:
- B_中级
toc: true # 是否启用内容索引
---

# 大纲

- [React19+TypeScript-妙码](https://www.bilibili.com/video/BV1Q1BhBiEqL?spm_id_from=333.788.videopod.sections&vd_source=bd4c7d99d71adf64d6e88c65370e0247)
- [尚硅谷React教程](https://www.bilibili.com/video/BV1wy4y1D7JT/?spm_id_from=333.999.0.0&vd_source=bd4c7d99d71adf64d6e88c65370e0247)
- React16.4 开发简书项目 从零基础入门到实战(欢乐购旧版)-video-mk
- 2023 React18 系统入门 进阶实战《欢乐购》-video-mk
- [全栈萧晨](https://xiaochen1024.com/)
- [scrimba 的互动式 React 教程](https://scrimba.com/learn/learnreact)

# 初级

## JSX是什么

**一、定义**

**JSX（JavaScript XML）** 是一种JavaScript的**语法扩展**（Syntax Extension），最早由Facebook提出。它允许我们在JavaScript代码中编写类似HTML的标签结构。

**一句话总结**：JSX本质上上是`React.createElement`函数调用的**语法糖**，经过Babel编译转化为虚拟DOM对象。它并不是字符串，也不是HTML，而是JavaScript对象。

**二、 底层原理**

JSX是如何转化为DOM的，流程如下：

**1.编译阶段**

JSX代码无法被浏览器直接识别，必须经过编译器（如Babel）转译。

> - **旧版React（v17之前）**：Babel会将JSX转换为`React.createElement`调用。
> - **新版React（v17+）**：引入了全新的转换机制，自动引入`react/jsx-runtime`中的`jsx`函数，不再强制需要`import React from 'react'`。

**2.虚拟DOM生成**

> `React.createElement`函数执行后，返回一个**React元素对象**，也就是我们常说的**虚拟DOM（Virtual DOM）**对象。这个对象描述了真实DOM的结构，包含`type`、`props`、`children`等属性。React随后会根据这个对象渲染出真实的DOM。

**三、为什么React选择JSX**

为什么不直接用模板字符串或`createElement`？

> 1. **声明式编程**：JSX让视图层代码更加直观，组件的结构一目了然，降低了维护成本。
> 2. **JavaScript的能力**：JSX不是一种新的模板语言（如Vue的模板），它是JavaScript的扩展。这意味着你可以在JSX中拥有JS的全部能力（变量、循环、逻辑判断），无需学习特殊的模板语法（如`v-if`, `v-for`）。
> 3. **安全性**：React DOM在渲染JSX之前，默认会进行**转义**，可以有效防止XSS（跨站脚本攻击）。

**四、面试**

**1.JSX如何防止XSS攻击？**

React默认会对JSX中嵌入的变量内容进行HTML转义。如果变量中包含恶意脚本代码，React会将其转义为字符串显示，而不是作为HTML执行。

- **注意**：如果确实需要渲染HTML字符串，可以使用`dangerouslySetInnerHTML`属性，但需谨慎使用。

**2.条件渲染的几种写法**

> - 逻辑与 `&&`：`{show && <Modal />}`
> - 三元表达式：`{loading ? <Spin /> : <List />}`
> - 函数返回值：利用立即执行函数（不推荐，代码复杂），通常建议在JSX外部处理逻辑。

**3.列表渲染与Key**

在JSX中使用`map`进行列表渲染时，必须给元素添加`key`属性。

> - **Key的作用**：Key是React用于识别列表中元素的唯一标识，帮助Diff算法高效地判断哪些元素发生了变化、添加或删除。
> - **禁止使用Index作为Key（除非列表是静态的）**：如果列表发生重排或删除，使用Index作为Key会导致性能问题或状态错乱。

## 渲染一个组件的过程

**一、定义**

> React 渲染组件的过程主要分为三个阶段：**调度阶段**、**渲染阶段**和**提交阶段**。
>
> 核心流程是：React 触发更新 -> 生成新的 Fiber 树 -> 计算差异-> 将差异提交到真实 DOM -> 执行生命周期钩子。

**二、 详细流程**

**1. 触发更新**
渲染的起点通常是以下几种情况：

> - 初次渲染（`ReactDOM.render` 或 `createRoot`）。
> - 状态更新（`setState`、`useState`、`useReducer`）。
> - 父组件重渲染或 Context 变化。

**2. 渲染阶段—— 纯计算阶段**
这是 React 内部最核心的部分，是一个**纯函数**过程，不可中断，且不产生副作用。

> - **构建/更新 Fiber 树**：
>   React 从触发更新的组件节点开始，递归遍历组件树。对于类组件，会调用 `render()` 方法；对于函数组件，会执行函数体。
>
> - **生成虚拟 DOM**：
>   组件返回 JSX，JSX 被转换为 React Element 对象（虚拟 DOM）。
>
> - Diff 算法：
>
>   React 将新生成的 Element 树与当前的 Fiber 树进行对比。
>
>   - **比较规则**：同层比较、类型比较、Key 比较。
>   - **结果**：生成 Effect List（副作用链表），记录了哪些节点需要插入、删除或更新。
>
> - **特点**：此阶段只做计算，不操作真实 DOM，可以被 React 的并发模式打断（高优先级任务插队）。

**3. 提交阶段—— 真实 DOM 更新**

此阶段是同步执行的，不可中断，直接操作真实 DOM。

> - **执行变更**：
>   根据 Render Phase 生成的 Effect List，React 将变更应用到真实的 DOM 节点上（如 `appendChild`、`removeChild`、`setAttribute` 等）。
> - 生命周期执行顺序：
>   - `getSnapshotBeforeUpdate`（类组件）。
>   - `componentDidMount` / `componentDidUpdate`（类组件）。
>   - `useLayoutEffect` 的销毁函数和执行函数。
>   - `useEffect` 的调度（注意：`useEffect` 是异步执行的，不阻塞 DOM 更新）。

**三、 底层原理**

**1. Fiber 架构**
React 16 引入 Fiber 架构，将递归的同步更新改为链表的异步更新。Fiber 节点包含了组件的类型、DOM 实例、Props、EffectTag 等信息，使得渲染过程可以被切分为多个小任务，实现时间切片。

**2. 双缓存机制**
React 内部维护两棵 Fiber 树：

> - **Current Tree**：当前屏幕显示的树。
> - **WorkInProgress Tree**：正在内存中构建的新树。
>   当 WorkInProgress Tree 构建完成并在 Commit 阶段提交后，它直接成为 Current Tree。这种切换是原子性的，避免了界面闪烁。

**3. Diff 算法策略**
React 采取了以下策略将 O(N^3) 复杂度降为 O(N)：

> - **同层比较**：不跨层级比较。
> - **类型判断**：类型不同直接销毁重建；类型相同复用节点。
> - **Key 标识**：通过 Key 判断列表项是移动、新增还是删除。

## 生命周期

**一.定义**

> 生命周期划分为三个主要阶段：**挂载阶段**、**更新阶段**和**卸载阶段**。
>
> 目前主要分为**类组件生命周期**和**函数组件生命周期**。随着 React 16.3 的发布及 Hooks 的普及，生命周期 API 经历了一次重大的调整（废弃了部分存在风险的 API）。

**二.（类组件 - React 16.3+ 标准）**

**第一阶段：挂载阶段**

当组件实例被创建并插入到 DOM 中时，按顺序执行：

> 1. `constructor`：
>    - **作用**：初始化 state，绑定事件处理函数的 `this` 指向。
>    - *注意*：必须调用 `super(props)`，且尽量不要在这里调用 `setState` 或发起请求。
> 2. `static getDerivedStateFromProps(props, state)`：
>    - **作用**：静态方法，在 render 之前调用。它允许组件根据 props 更新 state。
>    - *特点*：这是一个**纯函数**，没有 `this`，必须返回一个对象来更新 state，或者返回 null 不更新。**使用场景极少**，主要用于当 state 完全依赖于 props 时。
> 3. `render`：
>    - **作用**：必须实现的方法。返回 JSX、null、Portal 等描述 UI 结构。
>    - *原则*：必须保持纯函数，不能在其中执行副作用（如修改 state、操作 DOM）。
> 4. `componentDidMount`：
>    - **作用**：组件挂载完成（DOM 已生成）后立即调用。
>    - *场景*：**官方推荐**在这里进行网络请求、订阅事件、操作 DOM、初始化第三方库等。

**第二阶段：更新阶段**

当组件的 props 或 state 发生变化时触发：

> 1. `static getDerivedStateFromProps(props, state)`：
>    - 同挂载阶段，再次根据 props 计算 state。
> 2. `shouldComponentUpdate(nextProps, nextState)`：
>    - **作用**：性能优化的关键点。在 render 之前调用。
>    - *返回值*：返回 `true`（默认）继续渲染，返回 `false` 阻止渲染。
>    - *注意*：不建议在此做深层比较，否则可能得不偿失。现在更推荐使用 `React.PureComponent`。
> 3. `render`：
>    - 根据 props 和 state 重新渲染 UI。
> 4. `getSnapshotBeforeUpdate(prevProps, prevState)`：
>    - **作用**：在最近一次渲染输出（提交到 DOM）之前调用。
>    - *场景*：极少用，主要用于获取 DOM 更新前的信息（例如滚动条位置），以便在更新后恢复。
> 5. `componentDidUpdate(prevProps, prevState, snapshot)`：
>    - **作用**：组件更新完成后调用。
>    - *场景*：当组件更新后需要对 DOM 进行操作，或者当 props 变化时需要重新发请求（记得对比 `prevProps`）。

**第三阶段：卸载阶段**

当组件从 DOM 中移除时：

> 1. `componentWillUnmount`：
>    - **作用**：组件销毁前调用。
>    - *场景*：**必须**执行清理工作，如清除定时器、取消网络请求、移除事件监听器，防止内存泄漏。

**废弃部分生命周期**

> React 16.3 引入了 **Fiber 架构**（支持异步渲染），为了平滑过渡，废弃了以下三个生命周期（带 `Will` 前缀）：
>
> - `componentWillMount`
> - `componentWillReceiveProps`
> - `componentWillUpdate`
>
> **废弃原因：**
>
> 1. **误解与误用**：开发者常在 `componentWillMount` 里发请求，但在异步渲染下，它可能会被多次调用，导致重复请求或内存泄漏。
> 2. **中断风险**：Fiber 允许 React 暂停、恢复或中止渲染。`Will` 系列生命周期在执行过程中可能会被中断，导致逻辑不一致（例如：一边更新 DOM，一边又被中断重置）。
>
> **替代方案：**
>
> - `componentWillMount` -> `constructor` 或 `componentDidMount`
> - `componentWillReceiveProps` -> `getDerivedStateFromProps` 或 `componentDidUpdate`

**三.函数组件(Hooks 中的生命周期)**

在现在流行的函数组件中，我们不使用上述生命周期方法，而是通过 `useEffect` 来统一实现挂载、更新和卸载逻辑。

| 类组件生命周期         | Hooks (useEffect)                               | 说明                                                   |
| :--------------------- | :---------------------------------------------- | :----------------------------------------------------- |
| `componentDidMount`    | `useEffect(() => { ... }, [])`                  | 依赖数组为空，表示仅在挂载后执行一次。                 |
| `componentDidUpdate`   | `useEffect(() => { ... }, [dep])`               | 依赖数组包含变量，变量变化时执行。                     |
| `componentWillUnmount` | `useEffect(() => { return () => { ... } }, [])` | `useEffect` 的返回函数（清理函数）会在组件卸载前执行。 |

**四、父子组件生命周期执行顺序**

> - 挂载时：
>
>   > 父 Render -> 子 全部 -> 父 DidMount
>
> - 更新时：
>
>   > 父 Render -> 子 全部 -> 父 DidUpdate
>
> - 卸载时：
>
>   > 父 Render -> 子 WillUnmount -> 父 DidUpdate

**五、总结**

> 1. **请求放哪里？** 无论是类组件还是 Hooks，异步请求（AJAX）都应该在组件**挂载后**（`componentDidMount` 或 `useEffect`）进行，而不是在渲染阶段。
> 2. **避免 `getDerivedStateFromProps`**：除非你的 state 确实完全依赖 props，否则尽量不要使用它，这会导致代码变得难以理解。
> 3. **清理工作**：在卸载阶段（`componentWillUnmount` 或 `useEffect` 的 return）务必清理副作用，这是面试官考察“细心度”和“性能意识”的重点。
> 4. **Fiber 影响**：理解生命周期变更的底层原因是 Fiber 的引入，这使得 React 能够实现任务优先级调度（如 Suspense）。

## 组件通信

**一、定义**

| 场景描述                   | 推荐方案                | 原因                                                     |
| :------------------------- | :---------------------- | :------------------------------------------------------- |
| **直接父子组件**           | **Props + Callback**    | 简单、直接，符合 React 设计理念。                        |
| **深层嵌套，仅读数据**     | **Context**             | 避免了繁琐的 Props 透传。                                |
| **深层嵌套，需要频繁更新** | **状态管理库**          | Context 的频繁更新可能导致不必要的渲染，状态库性能更优。 |
| **兄弟组件**               | **状态提升**            | 将数据源上升到父组件，逻辑清晰。                         |
| **无关系组件（跨页面）**   | **Redux / Zustand**     | 需要全局存储或跨页面共享状态。                           |
| **需要调用子组件方法**     | **useRef + forwardRef** | 唯一能直接操作子组件实例的方式。                         |

**二、具体场景**

**第一类：基本通信（适用于关系紧密的组件）**

> **1. Props 传递（父 -> 子）**
> 这是最基础的通信方式。父组件通过属性将数据传递给子组件。
>
> - **特点**：单向流动，子组件只能读取，不能直接修改（遵循单向数据流原则）。
>
> **2. 回调函数（子 -> 父）**
> 父组件通过 props 传递一个回调函数给子组件，子组件在适当的时候调用该函数，将数据通过参数传递回父组件。
>
> - **特点**：利用“函数也是一等公民”的特性，实现了反向数据流。
>
> **3. 状态提升（兄弟组件）**
> 当两个兄弟组件需要共享数据时，将它们的共同状态提升到它们最近的公共父组件中管理。父组件通过 Props 将状态分发下去，通过回调函数接收修改。
>
> - **特点**：遵循“单一数据源”，是 React 处理兄弟通信的标准范式。

**第二类：跨层级通信（适用于多层嵌套）**

> **4. Context 上下文**
> `React.createContext` 创建一个上下文对象，Provider 在顶层提供数据，Consumer 或 `useContext` Hook 在深层子组件中直接消费数据，无需一层层 Props 传递。
>
> - **特点**：解决了“Props Drilling（Props 透传）”的问题。适合全局共享的数据（如主题色、语言、用户信息）。
> - *注意*：Context 会触发消费者组件的重渲染，需要注意性能优化。

**第三类：复杂/全局通信（适用于任意组件）**

> **5. 状态管理库**
> 对于组件关系极其复杂或需要全局状态的场景，引入 Redux、MobX、Zustand 等第三方库。
>
> - 特点：
>   - **Redux**：单一数据源、纯函数 Reducer，适合大型项目和中大型团队，逻辑可预测性强。
>   - **MobX**：响应式数据，适合状态关系复杂、追求开发效率的项目。
>   - **Zustand/Recoil**：轻量级，API 简单，适合中小型项目或 Hooks 优先的开发模式。

**第四类：特殊场景通信**

> **6. Refs / forwardRef**
> 父组件通过 `useRef` 获取子组件的 DOM 节点或组件实例（如果是类组件），从而直接调用子组件的方法或操作 DOM。
>
> - **特点**：打破了数据流的限制，属于命令式编程。常用于聚焦输入框、触发动画、强制滚动等场景。
> - **配合**：`forwardRef` 用于将 ref 从父组件透传到子组件内部的 DOM 元素。
>
> **7. 自定义事件 / 订阅发布模式**
> 虽然 React 官方不推荐，但在某些遗留系统或与第三方库集成时，可以使用 `EventEmitter` 或简单的全局事件监听。
>
> - **特点**：组件解耦，但数据流向不清晰，难以调试，一般慎用。

## 类组件与函数组件的区别

**一.定义**

- **类组件**：实例化后，调用 `render` 方法返回 Element。
- **函数组件**：直接执行函数，函数的返回值即为 Element。
- **Hooks**：函数组件执行时，Hooks 通过链表结构按顺序执行，将状态挂载到 Fiber 节点上。

> **类组件**是基于 ES6 Class 编写，通过继承 `React.Component` 基类，使用 `render` 方法返回 UI 的组件形式，它拥有自己的实例和生命周期方法。
>
> **函数组件**则是一个纯 JavaScript 函数，接收 `props` 作为参数并返回 React 元素。在 Hooks 出现前它没有状态和生命周期，被称为“无状态组件”；Hooks 出现后，函数组件具备了与类组件同等的能力，成为现代 React 开发的首选。

**二、核心区别**

主要从**写法、状态管理、生命周期、this 指向**四个方面进行对比：

| 维度          | 类组件                                                       | 函数组件                                                     |
| :------------ | :----------------------------------------------------------- | :----------------------------------------------------------- |
| **编写形式**  | 基于 Class，需继承 `React.Component`。                       | 普通函数（或箭头函数），代码更简洁。                         |
| **状态管理**  | 通过 `this.state` 初始化，`this.setState` 修改。             | 通过 `useState` Hook 管理。                                  |
| **生命周期**  | 拥有完整的生命周期钩子（如 `componentDidMount`、`componentDidUpdate`）。 | 没有“生命周期方法”的概念，通过 `useEffect` Hook 模拟对应逻辑。 |
| **this 指向** | 拥有 `this` 实例，需要手动绑定 `this`（或使用箭头函数），容易出 bug。 | 无需 `this`，直接使用 props 和 state，避免了 `this` 指向问题。 |
| **逻辑复用**  | 早期通过 HOC（高阶组件）或 Render Props，容易形成“嵌套地狱”。 | 通过自定义 Hooks 实现，逻辑复用更直观、代码解耦性更强。      |

**三、底层机制**

> 1. **底层实例化机制不同**：
>    - **类组件**：React 在渲染时会 `new` 一个实例，并通过实例调用 `render` 方法。因为实例存在，React 可以在内存中持有它的 `state` 和生命周期状态。
>    - **函数组件**：React **不会**实例化函数，而是直接调用该函数获取返回的 JSX。函数组件中的状态（如 `useState`）并不保存在函数作用域内，而是保存在 React 内部的 Fiber 节点的 `memoizedState` 链表中。每次渲染，函数都是重新执行的。
> 2. **性能差异**：
>    - 类组件实例化涉及对象创建和垃圾回收，理论开销略大。
>    - 函数组件无需实例化，编译后代码量更少，内存占用相对较低。虽然实际业务中差异微乎其微，但在大规模列表渲染场景下，函数组件结合 `useMemo` 等优化手段更具优势。

**四、坑点**

> 1. 错误边界：
>    - 函数组件**无法**充当错误边界组件，因为错误边界必须使用 `componentDidCatch` 生命周期，这只能由类组件实现。
> 2. 闭包陷阱：
>    - 函数组件由于每次渲染都是新的函数作用域，容易产生“闭包陷阱”（例如在定时器或事件监听中读取到旧的 state 值），需要通过 `useRef` 或正确使用 `useEffect` 依赖项来解决。

**五、总结**

> **总结**：
> 类组件和函数组件在功能上已经等价。类组件是面向对象编程（OOP）思维的体现，适合复杂的生命周期管理（早期）；函数组件结合 Hooks 是函数式编程（FP）思维的体现。
>
> **最佳实践**：
> 目前 React 官方强推 **函数组件 + Hooks**。建议新项目全部使用函数组件，因为它代码更简洁、逻辑复用更灵活、符合 React “UI 即渲染函数” 的设计哲学。仅在极少数需要错误边界处理的场景下，才需要编写类组件。

## 重新渲染render的情况

**一.定义**

React 组件触发重新渲染的本质是 **React 组件树的更新**。主要有以下四种核心情况：

> 1. **自身状态改变**：组件内部 `setState` 或 `useState` 调用导致状态变更。
> 2. **父组件重新渲染**：父组件重渲染时，默认会递归重渲染所有子组件。
> 3. **Props 改变**：父组件传递的 props 发生变化（通常由父组件重渲染引起）。
> 4. **Context 变化**：使用了 `useContext` 或 `context.consumer`，且 Context Provider 的值发生变化。

**二、详细解释**

**1. 组件内部 State 更新**
这是最基础的触发方式。当调用 `setState`、`useState` 的 setter 函数或 `dispatch` 时，React 会在下一次渲染周期调度该组件的更新。

> - **注意**：如果状态值引用没变（如 `setState(0)` 且当前状态也是 `0`），React 会跳过该组件及其子组件的渲染（这是 React 的默认优化）。

**2. 父组件重渲染引发的“连带效应”**
React 默认的渲染行为是“递归”的。如果父组件渲染了，React 默认不知道子组件是否需要更新，为了保证数据一致性，会无条件地重新渲染子组件。

> - **关键点**：即使子组件的 `props` 没有任何变化，只要父组件渲染，子组件也会渲染。

**3. Props 发生变化**
Props 的改变通常伴随父组件的渲染。

> - 如果父组件传递的是新对象或新函数（如 `onClick={() => {}}` 或传递新创建的对象），引用改变会导致子组件重渲染。
> - 如果父组件重渲染但 Props 引用未变，默认情况下子组件依然会渲染（见第2点），除非使用了优化手段。

**4. Context 更新**
当 Context Provider 的 `value` 发生变化时，所有消费该 Context 的组件（即使用了 `useContext` 或 `context.consumer` 的组件）都会强制重新渲染，无论它们是否使用了改变的那部分数据。

**5. 其他较少见情况**

> - 类组件中调用 `forceUpdate()`。
> - 使用了 `useReducer` 且 dispatch 了 action 后 state 发生变化。

**三、进阶**

1.**引用类型的 Props 陷阱**

```js
// 父组件
const Parent = () => {
    const [count, setCount] = useState(0);
    // 每次渲染都会创建一个新的 style 对象和函数引用
    return <Child style={{ color: 'red' }} onClick={() => {}} />
}
```

即使 Child 使用了 `React.memo`，由于 `style` 和 `onClick` 每次都是新引用，浅比较会认为 Props 变了，导致 Child 无效重渲染。
**解法**：使用 `useMemo` 包裹对象，用 `useCallback` 包裹函数。

## 避免渲染render的情况

**一、定义**

React 组件的不必要渲染主要源于**父组件的“连带渲染”**和**引用类型 Props 的变化**。避免重新渲染的核心思路有三点：

> 1. **缓存组件实例**：使用 `React.memo` 阻断父组件渲染的向下传递。
> 2. **缓存引用类型**：使用 `useMemo` 和 `useCallback` 避免 Props 引用变化。
> 3. **优化状态结构**：状态下沉、组件解耦，减少渲染波及范围。

**二、 核心解决方案**

**1. 使用 `React.memo`（浅比较控制）**
这是最直接的优化手段。`React.memo` 是一个高阶组件，它会对传入的 Props 进行浅比较。如果 Props 未变，React 会复用上一次的渲染结果，跳过该组件及其子树的 Render 过程。

> **适用场景**：展示型组件、数据结构简单的子组件。

```js
const Child = React.memo(function Child({ data }) {
  console.log('Child render');
  return <div>{data}</div>;
});
```

**2. 配合 `useMemo` 与 `useCallback`（解决引用问题）**
单独使用 `React.memo` 往往不够，因为父组件重渲染时，传递给子组件的**对象**和**函数**引用通常会重新创建，导致浅比较失效。

> - **`useCallback`**：缓存函数引用，避免因函数重新创建导致子组件 `props` 变化。
> - **`useMemo`**：缓存计算结果或对象引用，避免每次渲染都重新生成新的对象。

```js
// 父组件
const Parent = () => {
  const [count, setCount] = useState(0);
  
  // 若不加 useCallback，每次 Parent 渲染，handleClick 都是新引用
  // 导致 React.memo(Child) 失效
  const handleClick = useCallback(() => {
    console.log('click');
  }, []);

  // 若不加 useMemo，style 每次都是新对象
  const style = useMemo(() => ({ color: 'red' }), []);

  return <Child onClick={handleClick} style={style} />;
};
```

**3. 状态下沉**
如果某个状态只被某个子组件使用，不要提升到父组件中。将状态“下沉”到真正需要它的组件内部，可以避免父组件更新牵连子组件。

```js
// 优化前：点击按钮，ExpensiveTree 也会重渲染
const App = () => {
  const [count, setCount] = useState(0);
  return (
    <div>
      <button onClick={() => setCount(count + 1)}>{count}</button>
      <ExpensiveTree />
    </div>
  );
};

// 优化后：将按钮部分抽离，状态隔离
const Counter = () => { ... } // 独立的组件
const App = () => (
  <div>
    <Counter />
    <ExpensiveTree /> {/* 不会再受影响 */}
  </div>
);
```

**4. 组件作为 Props 传递（Slots 模式）**
将组件（JSX）作为 Props 传递给子组件。父组件渲染时，子组件接收的是 React Element 对象，只要父组件不重新创建这个 Element（通常放在 return 中，每次渲染确实会重建），或者是通过 `children` 传递，子组件配合 `React.memo` 可以避免渲染。

实际上，更精准的做法是：

*更正：最有效的 slots 模式是利用 `useMemo` 包裹 JSX 元素。*

```js
const Parent = () => {
  // 即使 Parent 渲染，childElement 引用不变（如果写在 JSX 外部）
  // 但通常 JSX 写在内部，所以利用 children 属性
  return <Child><GrandChild /></Child>;
};

// Child 组件使用 React.memo
// 当 Parent 渲染时，Child 的 props.children 引用可能变化吗？
// 实际上，Parent 每次渲染都会生成新的 React Element 对象给 children。
// 所以这种方式主要适用于 "渲染劫持" 或 "控制反转"，而非直接避免渲染。
// *修正*：正确的避免渲染方式是利用 `children` 且配合 `React.memo` 无效，
// 必须是传递的组件实例在父组件外层定义，或者使用 useMemo 包裹 JSX。
```

**三、 进阶优化方案**

> **1. 虚拟列表**
> 针对长列表渲染，只渲染可视区域内的组件，避免全量渲染。
>
> - 工具库：`react-window` 或 `react-virtualized`。
>
> **2. 使用 `useReducer` 避免传递回调**
> 在深层嵌套组件树中，如果要更新父组件状态，通常需要层层传递回调函数（导致每层组件都需要 `React.memo` + `useCallback`）。
> 使用 `useReducer` 并将 `dispatch` 通过 Context 传递，可以避免多层回调函数的定义，且 `dispatch` 引用是稳定的。
>
> **3. 错误的优化：`defaultProps` 与 Class Component**
> 面试中常问：为什么函数组件需要 `React.memo` 而类组件 `PureComponent` 就行？
> 答：`PureComponent` 内置了 `shouldComponentUpdate` 进行浅比较，而函数组件默认“只要父渲染我就渲染”，必须手动包裹 `React.memo`。

**四、底层原理分析**

> - **浅比较**：`React.memo` 和 `PureComponent` 都是基于 `Object.is` 或浅比较。对于基本类型比较值，对于引用类型比较内存地址。
> - **Fiber 架构**：React 在 Render Phase（协调阶段）会遍历 Fiber 树。如果组件被 `React.memo` 包裹且 Props 未变，React 会直接复用该 Fiber 节点，跳过 `beginWork` 中的 `reconcileChildren` 过程，从而避免了 JS 计算开销。

## props与state的区别

**一.定义**

**Props 是组件对外的接口，State 是组件对内的接口。**

> **Props (Properties)** 是 React 组件的**输入参数**，由父组件传递给子组件，用于配置组件，具有**只读**特性，遵循“单向数据流”原则。
>
> **State** 是组件内部的**私有数据**，由组件自身创建和管理，用于存储随时间变化的数据，具有**可变**特性（只能通过 `setState` 或 `useState` 修改），状态的改变会触发组件的重新渲染。

**二、 核心区别**

主要从**来源、可变性、归属权、功能**四个方面进行对比：

| 维度         | Props                                                | State                                                        |
| :----------- | :--------------------------------------------------- | :----------------------------------------------------------- |
| **来源**     | 来自父组件，类似于函数的**参数**。                   | 来自组件内部，类似于函数内的**局部变量**。                   |
| **可变性**   | **只读**。组件内部不能修改 `props`，遵循“纯净”原则。 | **可变**。组件可以通过 `setState` 修改，驱动 UI 更新。       |
| **归属权**   | 归属于**父组件**。子组件只能读取，无法控制。         | 归属于**当前组件**。组件拥有完全的控制权。                   |
| **功能定位** | 用于**组件间通信**和配置（如定制样式、传递回调）。   | 用于**记忆状态**，存储影响渲染的动态数据（如表单值、计时器）。 |

**三、两者关联**

> 1. **“Props 向下流动”**：
>    State 往往是 Props 的数据源。父组件的 `state` 可以作为 `props` 传递给子组件。
>    - *示例*：父组件请求回来的数据存在 `state` 中，作为 `props` 传给展示组件。
> 2. **“派生状态”**：
>    有时子组件需要根据 Props 初始化 State（即 `state = { value: props.value }`），这被称为“派生状态”。但 React 官方不推荐这种写法，因为会导致数据源不一致（单一数据源原则），现在更推荐使用 `useState` 配合 `useEffect` 同步，或直接受控组件模式。
> 3. **回调函数作为 Props**：
>    子组件要修改父组件的数据（修改 Props），必须通过父组件传递的回调函数（作为 Props 传递）来“告知”父组件修改。这是 React **“状态提升”** 的核心思想。



## setState是什么

**一.定义**

> `setState` 是 React 响应式编程的核心。`setState` 是 React 类组件中用于更新组件状态并发起重新渲染的核心 API。它接收一个新状态对象或一个返回新状态的函数，并将更改加入队列，通知 React 需要使用新状态重新渲染组件及其子组件。

**二.核心机制**

1.异步更新与批量更新

> - **表现**：在 React 合成事件和生命周期钩子中，`setState` 表现为**异步**。React 会将多个 `setState` 调用合并成一个更新任务，只触发一次 Re-render（批量更新），以提高性能。
> - **原理**：React 内部使用 `isBatchingUpdates` 标志位。当处于批量更新上下文时，状态更新会被推入 `dirtyComponents` 队列等待执行，而不是立即更新。
> - **注意**：在原生 DOM 事件、`setTimeout`、`Promise` 等原生 JS 异步逻辑中，`setState` 会表现为**同步**（React 18 之前），因为此时 React 无法控制批量更新标志位。

2.浅合并

> - `setState` 对传入的对象执行**浅合并**，而不是深拷贝或替换。
> - 这意味着如果你在 `state` 中有嵌套对象（如 `{ user: { name: 'A', age: 10 } }`），调用 `setState({ user: { name: 'B' } })` 会丢失 `age` 属性。你需要使用展开运算符手动合并：`setState({ user: { ...this.state.user, name: 'B' } })`。

**三、 参数形式对比（深度解析）**

`setState` 接收两种参数形式，这是考察“数据可靠性”的关键点：

| 形式         | 写法                                                         | 适用场景                       | 原因分析                                                     |
| :----------- | :----------------------------------------------------------- | :----------------------------- | :----------------------------------------------------------- |
| **对象形式** | `setState({ count: 1 })`                                     | 简单的、不依赖旧状态的更新。   | 直接合并对象，代码简洁。                                     |
| **函数形式** | `setState((prevState, props) => { return { count: prevState.count + 1 } })` | **依赖旧状态**、链式调用更新。 | **解决“闭包陷阱”与“状态竞争”**。函数形式接收最新 `prevState`，确保在批量更新或异步场景下能拿到准确的最新值，避免数据丢失。 |

**四、底层流程**

`setState` 的执行大致经历以下生命周期：

> 1. **调用 `setState`**：将新状态加入 `pendingState` 队列。
> 2. **批量更新判断**：判断是否处于批量更新阶段。
> 3. **事务机制**：React 利用“事务”机制在批量更新结束时，遍历 `dirtyComponents` 执行更新。
> 4. **Diff 与 Commit**：生成新的 Fiber 树，计算差异，最终提交到渲染层。

**五、版本演进**

> - **React 17 及之前**：只有在 React 管理的事件（合成事件、生命周期）中才是异步批量更新；在原生事件、`setTimeout` 中是同步更新。
> - **React 18 (Automatic Batching)**：引入了自动批处理机制。无论在 `setTimeout`、`Promise`、原生事件还是 React 合成事件中，`setState` **默认都是异步批量更新**。这统一了行为，进一步提升了性能。

**六、setState不能立刻获取值，怎么办**

**1.方案一：类组件**

1.使用回调函数（推荐，即时获取）

> - `setState` 接受第二个参数，这是一个回调函数，它会在状态更新且 DOM 渲染完成后执行。

```js
    this.setState({ count: this.state.count + 1 }, () => {
      // 这里可以获取到最新的 state
      console.log(this.state.count); 
    });
```

2.生命周期函数 `componentDidUpdate`

> - 如果需要在每次更新后做通用处理，可以在生命周期中监听。

```js
    componentDidUpdate(prevProps, prevState) {
      if (this.state.count !== prevState.count) {
        console.log('count 更新了：', this.state.count);
      }
    }
```

**2.方案二：函数组件 Hooks（推荐）**

在 Hooks 中，`setXxx` 不再支持回调函数，需要使用 `useEffect` 来监听变化。

1.使用 `useEffect` 监听状态变化

> - **适用场景**：响应状态的变化，执行副作用（如发请求、操作 DOM）。

```js
    const [count, setCount] = useState(0);
    useEffect(() => {
      // 这里的 count 是最新的
      console.log('count 变化了：', count);
    }, [count]); // 依赖数组中填入 count
```

2.特殊情况：如何在同一个函数中获取旧值并正确更新？

> - 如果你遇到的问题是“更新后的值总是滞后一步”（闭包陷阱），是因为你依赖了旧的快照。解决方法是使用**函数式更新**。

```js
    // ❌ 错误写法：如果快速点击多次，count 会因为闭包导致计算错误
    setCount(count + 1); 
    // ✅ 正确写法：传入一个函数，参数 prevCount 永远是最新的 state
    setCount(prevCount => prevCount + 1);
```





## 路由

一、定义

> React Router（React 路由）是 React 生态中最常用的标准路由库，它通过管理 URL 与组件 UI 之间的同步，实现了单页应用（SPA）中的页面跳转和状态保持，而不会触发页面整体刷新。

**二、核心原理**

> React Router 的本质是利用 **History API**（如 `pushState`、`replaceState`）监听 URL 的变化，维护一个历史记录栈。当 URL 发生变化时，路由库会根据配置的规则匹配到对应的 React 组件并将其渲染到页面上。

**三、核心组件与 API**

| 特性         | React Router v5                                    | React Router v6                                     |
| :----------- | :------------------------------------------------- | :-------------------------------------------------- |
| **路由匹配** | 使用 `<Switch>`，支持 `exact` 精确匹配             | 使用 `<Routes>`，**默认精确匹配**，不再需要 `exact` |
| **嵌套路由** | 需要在父组件中手动写 `<Route path="/child" ... />` | 支持相对路径，使用 `<Outlet>` 占位符，配置更扁平化  |
| **跳转方式** | `<Link to="/">` 或 `useHistory()` hook             | `<Link to="/">` 或 **`useNavigate()`** hook         |
| **代码体积** | 较大                                               | 更小，内部重构提升了性能                            |

**常用组件与 Hook (v6)**

> 1. **`<BrowserRouter>`**：最外层容器，使用 HTML5 History API。
> 2. `<Routes>` & `<Route>`：
>    - `<Routes>` 类似于 v5 的 `Switch`，用于包裹路由规则。
>    - `<Route>` 用于定义路径和组件的映射关系。
> 3. `<Link>` & `<NavLink>`：
>    - `<Link to="/home">`：生成无刷新的 a 标签。
>    - `<NavLink>`：增加了 activeClassName，用于做导航的高亮显示。
> 4. **`<Outlet>`**：用于嵌套路由的父组件中，表示子路由渲染的位置。
> 5. **`useNavigate`**：替代 v5 的 `useHistory`，用于编程式导航（跳转、后退）。
> 6. **`useParams`**：用于获取动态路由参数（如 `/user/:id` 中的 id）。

**四、路由模式**

**1.BrowserRouter (推荐)**

> - **原理**：使用 HTML5 `pushState` API。
> - **URL 表现**：`http://example.com/user/id`（干净，看起来像真 URL）。
> - **缺点**：刷新页面时，服务器必须配置返回 `index.html`，否则会报 404 错误。
> - **场景**：大多数 Web 应用。

**2.HashRouter**

> - **原理**：使用 URL 的 `hash` 部分（`#`）。
> - **URL 表现**：`http://example.com/#/user/id` 。
> - **优点**：不需要服务器配置，兼容性好。
> - **缺点**：URL 不美观，SEO 不友好（虽然 SPA 本身 SEO 就弱）。
> - **场景**：老旧服务器、简单的静态页面托管（如 GitHub Pages）。

**五、路由传参**

**1.Params (动态路由参数)**

> - **定义**：`<Route path="/user/:id" element={<User />} />`
> - **获取**：`const { id } = useParams();`
> - **特点**：参数必填，刷新页面参数不丢失。

**2.Search (查询字符串)**

> - **定义**：`/user?id=123&name=tom`
> - **获取**：`const [searchParams] = useSearchParams();` 类似于 URLSearchParams。
> - **特点**：适合可选参数，刷新页面参数不丢失。

**3.State (隐式传参)**

> - **定义**：`navigate('/detail', { state: { id: 123 } });` 或 `<Link to="/detail" state={{ id: 123 }} />`
> - **获取**：`const location = useLocation(); location.state.id`
> - **特点**：URL 不可见，安全性稍好，但**刷新页面后数据会丢失**。

**六、路由守卫**

React Router v6 **没有**像 Vue Router 那样内置的 `beforeEach` 钩子。通常通过 **高阶组件 (Wrapper)** 或 **条件渲染** 来实现。

## 按需加载

**一、定义**

React 的按需加载，本质上是**代码分割**与**动态导入**的结合。

> 其核心实现方案是：利用 Webpack 的 `import()` 语法配合 React 官方提供的 **`React.lazy`** 和 **`Suspense`** 组件，在渲染阶段动态加载组件代码，从而减小主包体积，提升首屏加载速度（FCP）。

**二、 具体实现方案**

**路由级或组件级懒加载**，不再静态 `import` 组件，而是使用 `React.lazy` 动态导入。

```js
import React, { lazy, Suspense } from 'react';
import { BrowserRouter, Route, Switch } from 'react-router-dom';

// 1. 使用 React.lazy 动态导入
const Home = lazy(() => import('./pages/Home'));
const About = lazy(() => import('./pages/About'));

const App = () => (
  <BrowserRouter>
    {/* 2. 使用 Suspense 包裹，提供加载中的后备UI */}
    <Suspense fallback={<div>Loading...</div>}>
      <Switch>
        <Route path="/" component={Home} />
        <Route path="/about" component={About} />
      </Switch>
    </Suspense>
  </BrowserRouter>
);
```

**三、 底层原理**

**1. 构建层面：Code Splitting**

> Webpack 遇到 `import('./Page.js')` 这种动态导入语法时，会识别为代码分割点。Webpack 会将 `Page.js` 及其依赖单独打包成一个 chunk 文件（如 `1.chunk.js`），而不是打包进主 bundle。

**2. 运行时层面：React.lazy 与 Suspense 的配合**

> - **React.lazy**：这是一个高阶组件，它接收一个 Promise 类型的函数。在组件首次渲染时，React 会“暂停”渲染，等待 Promise resolve（即 Chunk 加载完成）。
> - **Suspense**：React 16.6 引入的机制。当子组件（Lazy 组件）处于 Pending 状态时，Suspense 会捕获这个状态，并渲染 `fallback` 属性中的内容（如 Loading 动画）。
> - **加载完成**：Promise resolve 后，React 会重新触发渲染，此时 Lazy 组件已拥有实际代码，正常渲染。

**四、进阶**

**1. 服务端渲染（SSR）的兼容性**

`React.lazy` 和 `Suspense` 目前还不完全支持服务端渲染

> - **问题**：在服务端，动态导入是异步的，而 `renderToString` 是同步的，会导致报错或内容缺失。
> - **解决方案**：在 SSR 场景下，通常使用 `react-loadable` 或 `@loadable/component` 库，它们支持服务端的预加载逻辑（`preload` 方法）。

**2. 预加载**
为了优化用户体验，可以在用户交互（如鼠标悬停）时提前加载资源，而不是等到点击那一刻才加载。

```js
// 鼠标悬停时触发加载
const handleMouseEnter = () => {
  import('./Editor');
};
// 点击时直接渲染，此时 Chunk 可能已经下载好了
```

**3. 错误处理**
网络错误可能导致 Chunk 加载失败。可以使用**错误边界**组件包裹 Lazy 组件，捕获加载异常并展示降级 UI 或重试按钮。

**4. 命名 Chunk**
在 Webpack 中，可以通过 Magic Comments 为 Chunk 命名，方便调试：

```js
const Home = lazy(() => import(/* webpackChunkName: "home" */ './Home'));
```

## Props的应用验证

**一、定义**

Props 验证是保证 React 组件**健壮性**和**可维护性**的重要手段。

主要分为两种流派：

> 1. **运行时验证**：使用 `prop-types` 库（React 官方推荐），在开发环境下通过控制台警告提示类型错误。
> 2. **静态编译时验证**：使用 **TypeScript**（现代主流方案），在编码阶段即可发现类型不匹配，并享受 IDE 的智能提示

**二、 详细方案**

React 的 Props 验证经历了从“运行时检查”到“静态类型检查”的演变。

| 维度           | prop-types (运行时)    | TypeScript (编译时)   |
| :------------- | :--------------------- | :-------------------- |
| **检查时机**   | 程序运行时，开发环境   | 编写/编译代码时       |
| **报错方式**   | 控制台警告             | IDE 红线报错/编译失败 |
| **运行时开销** | 开发环境有，生产环境无 | 无 (类型擦除)         |
| **适用场景**   | JS 项目、第三方库开发  | 现代 TS 项目 (首选)   |

**1. 运行时验证：`prop-types`**

这是 React 早期延续至今的经典方案，适用于 JavaScript 项目。

> - **基本用法**：
>   引入 `prop-types` 库，为组件定义静态属性 `propTypes`。
> - **常用验证类型**：
>   - 基础类型：`string`, `number`, `bool`, `func`, `array`, `object`。
>   - 复杂类型：`PropTypes.arrayOf(PropTypes.number)` (数组项类型)、`PropTypes.shape({})` (对象结构)、`PropTypes.oneOf([])` (限定枚举值)。
>   - 特殊类型：`PropTypes.element` (React 元素)、`PropTypes.node` (可渲染节点)。

```js
import PropTypes from 'prop-types';

function MyComponent({ name, age }) {
  return <div>{name} - {age}</div>;
}

// 定义验证规则
MyComponent.propTypes = {
  name: PropTypes.string.isRequired, // 必传字符串
  age: PropTypes.number              // 数字
};

// 定义默认值（可选）
MyComponent.defaultProps = {
  age: 18
};
```

**2. 静态编译时验证：TypeScript**

这是现代 React 项目（特别是大型项目）的标准配置。

> - **基本用法**：
>   直接在函数参数或类组件 Props 中定义 Interface 或 Type。
> - **优势**：
>   - 无需引入额外库，编译时直接报错。
>   - 拥有极佳的代码补全和智能提示。
>   - 无运行时开销（编译后类型被移除）。

**三、 底层原理与机制**

**1. `prop-types` 的工作原理**
React 组件在渲染生命周期中，会将传入的 `props` 对象与 `propTypes` 定义的规则进行对比。

> - **检查时机**：仅在开发模式下执行检查。
> - **报错方式**：通过 `console.warn` 抛出警告，**不会阻断程序运行**。
> - **性能考量**：由于检查有性能开销，React 在生产环境打包时会自动忽略检查逻辑，因此不必担心上线后的性能问题。

**2. 为什么 `prop-types` 不是必须的？**
随着前端工程化的发展，代码层面的类型检查逐渐转移到了编译阶段。

> - Flow 和 TypeScript 的兴起，使得 `prop-types` 在纯 TS 项目中显得冗余。
> - 但对于遗留的 JS 项目或引入的第三方 JS 库，`prop-types` 依然是定义 API 契约的最佳方式。

**四、 最佳实践**

**1. 默认值的处理**

> - **函数组件**：推荐使用 ES6 默认参数 `function({ name = 'Guest' }) {}`，代码更简洁。
> - **类组件**：必须使用 `defaultProps` 静态属性，或者在构造函数中处理。
> - **注意**：`defaultProps` 在使用 TypeScript 时可能会引发类型推断冗余，TS 项目更推荐默认参数写法。

**2. 自定义验证器**
当 `prop-types` 内置类型无法满足复杂业务逻辑时，可以自定义验证函数。

```js
MyComponent.propTypes = {
  // 自定义验证：age 必须是大于 0 的数字
  age: function(props, propName, componentName) {
    if (props[propName] <= 0) {
      return new Error(`Invalid prop ${propName} supplied to ${componentName}. Must be positive.`);
    }
  }
};
```

**3. Children 的验证**
很多时候我们需要验证 `this.props.children` 的类型。

> - `PropTypes.element`：验证是否为单个 React 元素。
> - `PropTypes.node`：验证是否为可渲染的内容（字符串、数字、React 元素、数组等）。

## Hooks

**1.定义**

> React Hooks 是 React 16.8 版本引入的新特性。它允许我们在**不编写 class 组件**的情况下，能够在函数组件内部使用 **state（状态）** 以及其他的 React 特性（如生命周期、Context 等）。
>
> React Hooks 是 React 生态的里程碑，它让函数组件拥有了类组件的能力，同时简化了逻辑复用。目前官方推荐优先使用函数组件 + Hooks 的方式进行开发。

**2.为什么要引入 Hooks？**

在 Hooks 出现之前，类组件存在几个主要问题：

> - **逻辑复用难：** 以前我们使用 Render Props 或高阶组件（HOC）来复用状态逻辑，但这会导致组件层级嵌套过深，形成“Wrapper Hell”，且代码难以理解。
> - **复杂的组件难以理解：** 类组件中，同一个业务逻辑（如数据获取）的代码往往被分散在 `componentDidMount`、`componentDidUpdate` 和 `componentWillUnmount` 中，导致代码支离破碎，难以维护。
> - **`this` 指向困扰：** 类组件中需要手动绑定 `this`，对于新手来说容易出错。
> - **编译优化问题：** 类组件难以进行热重载和代码压缩优化（Minification）。

**Hooks 的出现就是为了解决这些问题，主要是为了实现逻辑复用和关注点分离。**

**3.常用的 Hooks** 

> - `useState`: 用于在函数组件中添加状态。它返回一个数组，第一个是当前状态值，第二个是更新状态的函数。
>
>   - *注意：* 更新函数是异步的，且如果新值依赖旧值，建议使用函数式更新 `setCount(prev => prev + 1)`。
>
> - `useEffect`: 处理副作用。它相当于类组件中的componentDidMount、componentDidUpdate和componentWillUnmount
>
>   的集合体。
>
>   - 通过依赖数组 `[deps]` 来控制执行时机。
>   - 返回一个清理函数用于执行清除操作（如取消订阅、清除定时器）。
>
> - **`useContext`**: 用于在组件间跨层级共享数据，接收一个 Context 对象并返回该 Context 的当前值，避免了层层传递 `props`。
>
> - `useRef`: 返回一个可变的 ref 对象，其.current属性被初始化为传入的参数。
>
>   - 常用于获取 DOM 元素或存储跨渲染周期的变量（且不会触发重渲染）。
>
> - **`useMemo`**: 性能优化。返回一个 memoized（记忆化）的值。仅当依赖项改变时才重新计算值，避免昂贵的计算。
>
> - **`useCallback`**: 性能优化。返回一个 memoized 的回调函数。主要用于配合子组件的 `React.memo` 使用，防止子组件因父组件函数引用变化而进行不必要的渲染。
>
> - **`useReducer`**: `useState` 的替代方案，适用于 state 逻辑较复杂且包含多个子值，或者下一个 state 依赖于之前的 state 等场景。

**4.Hooks 的使用规则**

React Hooks 有两个必须遵守的黄金法则：

> 1. **只能在函数最外层调用 Hook：** 不要在循环、条件判断或者子函数中调用。这是因为 React 依赖调用顺序来将 Hook 的状态与组件对应起来。
> 2. **只能在 React 的函数组件或自定义 Hook 中调用 Hook：** 不要在普通的 JavaScript 函数中调用。

**5.Hooks 的原理**

React 是通过一个**数组**或者**链表**来维护 Hooks 的状态的。

> - 当组件首次渲染时，React 按照顺序创建 Hook 对象并存入数组中。
> - 当组件再次渲染时，React 也是按照同样的顺序去读取数组中的 Hook 数据。
> - **这就是为什么不能在条件语句中使用 Hooks：** 如果顺序乱了，React 就无法正确地将当前的 Hook 状态与之前保存的状态对应起来，导致数据错乱。

6.面试

> Q：在异步操作中 `useEffect` 或 `setTimeout` 中使用旧的状态？
>
> A：函数组件每次渲染都会生成一个新的作用域，Hooks 引用的是那次渲染时的变量。 使用 `useRef` 来保存可变变量，或者在 `useEffect` 的依赖数组中正确添加依赖项，或者使用函数式更新。
>
> Q：**`useEffect` 和 `useLayoutEffect` 的区别是什么？**
>
> A：`useEffect` 是异步执行的，不会阻塞浏览器绘制（Paint），适合处理副作用、数据请求。`useLayoutEffect` 是同步执行的，会在 DOM 更新之后、浏览器绘制**之前**执行。如果需要在绘制前读取 DOM 布局信息并同步修改样式，使用它，但会阻塞页面渲染，慎用。
>
> Q：**`useMemo` 和 `useCallback` 的区别？**
>
> A：`useMemo` 缓存的是**值**（计算结果）。`useCallback` 缓存的是**函数**（引用）。实际上 `useCallback(fn, deps)` 相当于 `useMemo(() => fn, deps)`。
>
> Q：**为什么官方推荐把 Hooks 放在文件顶部？**
>
> A：主要是为了配合 ESLint 插件 (`eslint-plugin-react-hooks`) 进行检查，确保 Hooks 的调用顺序在多次渲染中保持一致，防止出现逻辑错误。

## Hooks与Render Props 与HOC(高阶组件)

**1.定义**

> Hooks 在“逻辑复用”场景上基本取代了 Render Props 与高阶组件（HOC），成为当前的首选；但在“渲染控制/反转控制”和需要“组件容器结构”的场景下，Render Props 仍然有价值；HOC 则更多保留在旧生态和某些跨组件包装需求中，但新项目应优先考虑 Hooks。
>
> React 在 Hooks 出现前，主要靠 Render Props 与 HOC 来复用组件逻辑。

**2.三者各自的定位**

> - 新功能/新项目：优先用 Hooks 处理逻辑复用。
> - 需要渲染控制/反转控制（UI 组件）：考虑 Render Props。
> - 需要对一批组件进行统一包装/注入 props 且 Hook 方案成本更高：可以审慎使用 HOC。

| 模式         | 主要能力                     | 典型用途                             | 在 Hooks 时代的定位    |
| ------------ | ---------------------------- | ------------------------------------ | ---------------------- |
| Hooks        | 逻辑复用（状态/副作用等）    | 封装自定义 Hook、业务逻辑复用        | 新项目首选             |
| Render Props | 逻辑复用 + 渲染控制/反转控制 | 让调用方决定“怎么渲染”、列表/滑窗等  | 仍在用，尤其在 UI 组件 |
| HOC          | 逻辑复用 + 组件增强/包装     | 库的集成（如 Redux connect）、跨组件 | 旧代码/特定场景保留    |

**3.Render Props 还会用吗？会的**

> 官方 Hooks FAQ 明确：Render Props 仍有适用空间，例如虚拟滚动可能提供 `renderItem`，或视觉容器需要自己的 DOM 结构时。
>
> 适用场景：
>
> - 列表/菜单/虚拟滚动等需要让使用者决定每一项怎么渲染。
> - 与“Compound Components”结合，构建灵活的 UI 组件。

**4.高阶组件（HOC）还会用吗？变少了，但没消失**

> 官方态度：你可以继续用老 API；同时主流库已提供 Hooks 版本（如 React Redux 的 `useDispatch`/`useSelector`、React Router 的 Hooks）。
>
> 适用场景：
>
> - 需要批量为多个组件注入 props/埋点/权限/样式，且组件来源多样、改造成本较高。
> - 与仍基于 HOC 的第三方库集成或维护现有 HOC 抽象时。

**5.面试**

> Q：为什么不建议到处用 HOC 了？
>
> A：容易形成“Wrapper Hell”，增加调试难度；props 命名冲突；静态类型推断更麻烦；Hooks 在多数场景能更简洁地完成逻辑复用。
>
> Q：Hooks 能完全替代 Render Props 吗？
>
> A：不能。Render Props 能把“渲染控制权”交给调用方，适合 UI 组件灵活性场景；这是“怎么渲染”的问题，Hooks 不直接解决。
>
> Q：老项目里大量 HOC 需要重构吗？
>
> A：不急着一刀切。先保证新功能用 Hooks；在维护/扩展成本高时，按需逐步重构，优先把业务逻辑层面的 HOC 转为自定义 Hook。

# 中级

## StrictMode(严格模式)

**一、定义**

> `React.StrictMode` 是 React 提供的一个**辅助开发组件**。它不会渲染任何可见 UI，而是为其后代组件触发额外的检查和警告。
>
> 其核心目的是：**帮助开发者发现潜在问题、识别不安全的生命周期、以及检测过时的 API，从而提升代码质量，为未来升级 React 版本（如并发渲染）做准备。**
>
> **注意**：`StrictMode` 仅在**开发环境**生效，**生产环境**构建时会被自动移除，不会影响性能。

**二、 主要功能与检查项**

`StrictMode` 主要检查以下四类问题：

**1. 识别不安全的生命周期方法**
React 16.逐渐废弃了 `componentWillMount`、`componentWillReceiveProps`、`componentWillUpdate` 这三个生命周期，因为它们在异步渲染下容易产生副作用。

> - `StrictMode` 会对这些方法发出警告，建议使用 `getDerivedStateFromProps` 或 `getSnapshotBeforeUpdate` 替代。

**2. 检测废弃的 API**

> - 检测是否使用了遗留的 String Ref（`ref="myRef"`），建议使用回调 Ref 或 `createRef`。
> - 检测是否使用了 `findDOMNode`，该 API 已被废弃。
> - 检测是否使用了旧版 Context API（`contextTypes`）。

**3. 检测意外的副作用**
这是 `StrictMode` 最核心但也最让新手困惑的功能。为了帮助发现副作用，React 会**故意双重调用**某些函数。

> - **类组件**：`constructor`、`render`、`getDerivedStateFromProps`、`shouldComponentUpdate` 会被调用两次。
> - **函数组件**：函数体、`useState`/`useMemo` 等的初始化函数会被调用两次。

**4. 检测过时的 Context API**
确保代码没有使用旧的 Context 定义方式。

**三、 底层原理（为什么会调用两次？）**

面试官常问：*“为什么我的 console.log 打印了两次？”*

**原理**：
React 的渲染过程必须是“纯净”的。React 假设组件的渲染逻辑不应该包含副作用（如修改外部变量、修改 Props 等）。
为了验证这一点，`StrictMode` 会模拟“渲染一次 -> 销毁 -> 再渲染一次”的过程。

> - 如果组件逻辑是纯净的，调用两次的结果应该一致，用户无感知。
> - 如果组件包含副作用（如 `render` 里调用了 `setState`），第二次调用就会暴露问题，控制台会报错。

**公式**：
`开发环境 + StrictMode` => `双重调用` = `副作用检测`。

**四、 使用方式**

通常在应用的入口文件包裹根组件：

```js
import React from 'react';
import ReactDOM from 'react-dom';
import App from './App';

ReactDOM.render(
  <React.StrictMode>
    <App />
  </React.StrictMode>,
  document.getElementById('root')
);
```

**五、进阶**

**1. 控制台日志重复打印**
这是开发者在 `StrictMode` 下最常遇到的问题。

> - **现象**：`console.log` 执行了两次。
> - **原因**：函数体被双重调用。
> - **解决**：这是预期行为，证明你的代码在多次执行时没有崩溃。如果是副作用导致的报错，需修复副作用代码。

**2. useEffect 执行两次**
React 18 中，如果开启了 `StrictMode`，`useEffect` 的清理函数和执行函数也会在开发环境下执行多次。

> - **设计初衷**：模拟组件挂载、卸载、再挂载的过程，测试开发者是否正确实现了清理逻辑（如取消订阅、清除定时器）。

## React的Immutable

**一、定义**

> **mmutable Data（不可变数据）** 是指一旦被创建，就**不能被修改**的数据。任何对数据的“修改”操作（如增、删、改），都不会改变原数据，而是返回一个新的数据对象。

**核心原则**：

> 1. **变量不变性**：`state` 创建后不可变。
> 2. **修改即创建**：修改数据时，必须基于原数据创建一个新的副本。

**二、为什么React需要Immutable**

React的开发模式高度依赖不可变数据，主要原因有两点：

**1. 性能优化机制：浅比较**

React组件的更新机制（如 `PureComponent`、`React.memo`、`shouldComponentUpdate`）默认使用**浅比较**来判断props或state是否变化。

> - **如果是可变数据**：直接修改对象内部的属性（如 `this.state.list.push(1)`），对象的引用地址不变。React的浅比较认为“旧State === 新State”，因此**不会触发重新渲染**，导致UI与数据不一致。
> - **如果是不可变数据**：修改数据必须返回新对象，引用地址改变。浅比较发现“旧State !== 新State”，**触发重新渲染**。

**2. 纯函数与状态可追溯**

React推崇函数式编程。不可变数据保证了State的纯净，使得组件像纯函数一样可预测。同时，它也是Redux实现“时间旅行”调试的基础（因为每一次状态变更都是独立的快照）。

**三、实现Immutable的方式**

| 维度           | 原生JS (Spread/Object.assign)    | Immutable.js         | Immer           |
| :------------- | :------------------------------- | :------------------- | :-------------- |
| **学习成本**   | 低                               | 高                   | 中              |
| **代码复杂度** | 高（深层嵌套代码冗长）           | 中                   | 低（写法直观）  |
| **性能**       | 一般（深拷贝昂贵，浅拷贝需手写） | 极高（结构共享）     | 高（基于Proxy） |
| **调试友好度** | 友好（就是普通对象）             | 差（需转换才能查看） | 友好            |
| **兼容性**     | 最好                             | 好                   | 需Proxy支持     |

**1.原生JavaScript实现（基础写法）**

> - **对象**：使用 `Object.assign` 或 扩展运算符 `...`。
> - **数组**：使用数组的高阶函数（`map`, `filter`, `slice`, `concat`）或扩展运算符。

**2.第三方库：Immutable.js（进阶方案）**

Facebook官方出品的库，实现了一套持久化数据结构。

> - **原理**：利用**结构共享**。修改数据时，只有变化的部分生成新节点，未变化的部分共享旧节点的引用。
> - **特点**：性能极高（尤其是深层嵌套数据），提供了专门的API（如 `Map`, `List`, `get`, `set`）。
> - **缺点**：学习成本高，API与原生JS差异大，调试困难（数据结构特殊）。

**3.第三方库：Immer（现代最佳实践）**

目前最推荐的方案（Redux Toolkit内置）。

> - **原理**：利用ES6的 `Proxy` 代理对象。
> - **特点**：**写法上是可变的，结果是不可变的**。开发者可以像写 `draft.user.name = 'new'` 这样直接赋值，Immer内部会自动生成新的不可变对象。
> - **优点**：代码极其简洁，学习成本低，性能优异。

## Flux 与 MVC

**1. MVC 模式**

> MVC（Model-View-Controller）是一种经典的软件架构模式，它将应用分为三个核心部分：**模型**（数据）、**视图**（UI）和 **控制器**（业务逻辑），旨在实现关注点分离。

**在 React/传统 Web 中的问题**

虽然 MVC 在后端或简单的前端应用中表现良好，但在复杂的 React 单页应用（SPA）中，它面临一个致命的问题：**双向数据流带来的混乱**。

Facebook 团队在开发聊天功能时发现，由于 MVC 的双向绑定，消息状态经常出现不同步的 Bug，且难以排查，这正是催生 Flux 架构的直接原因。

> - **双向数据流**：用户操作 View -> 更新 Model -> Model 变更 -> 自动更新 View。
> - **级联更新**：当一个 Model 发生变化时，可能触发依赖它的多个 View 更新，而这些 View 的变更又可能触发其他 Model 的变化。
> - **维护噩梦**：在复杂应用中，数据流变得交错纵横（面条式代码）。当一个 Bug 出现时，开发者很难追踪是哪个 View 改变了哪个 Model，导致数据流不可预测。

**2. Flux 架构**

> Flux 是 Facebook 提出的一种应用架构模式，它强制使用**单向数据流**来解决 MVC 的复杂性，非常适合 React 的组件化开发。

**核心四要素**

Flux 不是具体的库（虽然官方有 `flux` 库），而是一种模式。它包含四个主要部分：

> 1. **Action（动作）**：描述发生了什么（如：`{ type: 'ADD_TODO', text: 'Learn Flux' }`）。它是数据的载体。
> 2. **Dispatcher（派发器）**：中央枢纽。它是单例，负责接收所有的 Action，并将它们分发给所有的 Store。
> 3. **Store（存储器）**：管理应用的状态和业务逻辑。它监听 Dispatcher，当接收到相关 Action 时更新 State。
> 4. **View（视图）**：React 组件。它从 Store 获取数据并渲染，同时用户交互会产生新的 Action。

**核心特点**

> - **单向数据流**：数据只能沿着一个方向流动，没有回环。
> - **可预测性**：任何一个状态改变，都可以通过追踪 Action 的来源来还原，极易调试。
> - **Store 独立性**：Store 之间不能直接通信，必须通过 Dispatcher 传递 Action。

**3.对比**

| 维度           | MVC                              | Flux                                              |
| :------------- | :------------------------------- | :------------------------------------------------ |
| **数据流向**   | **双向/循环**（View <-> Model）  | **单向**（Action -> Dispatcher -> Store -> View） |
| **可预测性**   | 低（复杂场景下难以追踪数据来源） | 高（数据流清晰，每一个 Action 都是记录）          |
| **控制器角色** | 有明确的 Controller              | 弱化 Controller，主要由 Dispatcher 承担调度       |
| **组件依赖**   | View 与 Model 往往是多对多依赖   | View 仅依赖 Store，Store 之间不直接依赖           |
| **适用场景**   | 简单的 CRUD 应用，后端渲染       | 复杂的交互式单页应用（SPA）                       |

**Flux 与 Redux 的关系**

> Redux 是 Flux 架构思想的一种**实现**，但做了简化和改进：
>
> 1. **去掉了 Dispatcher**：Flux 有一个中央 Dispatcher，而 Redux 让每个 Store（Redux 中只有一个 Store）直接接收 Action。
> 2. **单一 Store**：Flux 允许多个 Store，Redux 只有唯一的一个 Store。
> 3. **纯函数 Reducer**：Flux 的 Store 更新逻辑通常是命令式的，Redux 引入了函数式编程的 Reducer（纯函数），使得状态变更逻辑更易测试和回溯。



## 高阶组件 (HOC)、受控组件 与 非受控组件

> 在实际开发中，我主要使用 **受控组件**，因为它更符合 React 的数据驱动思想，便于维护和调试。只有在处理文件上传或者某些特定的性能优化场景下，才会考虑使用 **非受控组件**。对于逻辑复用，以前我可能写过 **HOC**，但在新项目中，我更倾向于使用 **Hooks** 来替代 HOC，以避免组件层级嵌套过深。

**一. React 高阶组件**

**1.定义**

> 高阶组件是参数为组件，返回值为新组件的函数。它本质上是一个**装饰器模式**的应用，用于复用组件逻辑。

**2.核心原理**

> HOC 不是 React API 的一部分，而是一种基于 React 组合特性的设计模式。

**3.常见使用场景**

> 1. **权限控制**：根据用户权限决定渲染组件还是重定向。
> 2. **代码复用**：抽离通用的业务逻辑（如日志记录、数据获取）。
> 3. **Props 增强**：为被包裹组件注入特定的 props。
> 4. **渲染劫持**：由 HOC 控制渲染结果，甚至修改 React 元素树。

**4.注意**

> 1. **不要在 render 方法中使用 HOC**：每次 render 都会重新创建新组件，导致原组件卸载、状态丢失。
> 2. **必须复制静态方法**：HOC 返回新组件，会丢失原组件的静态方法（如 `WrappedComponent.staticMethod`）。可以使用 `hoist-non-react-statics` 库解决。
> 3. **Refs 不会被传递**：Refs 会被透传到最外层容器，需要使用 `React.forwardRef` 进行转发。
> 4. **Props 命名冲突**：如果 HOC 注入的 props 与组件原有 props 重名，会覆盖原有 props。
> 5. 虽然 HOC 依然有用，但现在更推荐使用 Hooks 来复用逻辑，因为 Hooks 不会导致组件层级嵌套（“包装地狱”），且代码更直观。

**二. React 受控组件**

**1.定义**

> 在 React 中，表单元素（如 `<input>`、`<select>`）的值由 React 的 **State** 来控制，并且其变化通过事件处理器更新 State 的组件，称为受控组件。

**2.核心原理**

> - **单一数据源**：表单数据的唯一来源是组件的 State。
> - **可预测性**：UI 是 State 的函数，输入内容受 React 严格控制。
> - **实时交互**：通常配合 `onChange` 事件实时更新状态。

**3.优缺点**

> - 优点：
>   - 可以即时验证用户输入（如长度限制、格式校验）。
>   - 可以根据输入条件禁用/启用按钮。
>   - 强制统一的数据流，便于调试。
> - 缺点：
>   - 每次输入都会触发 `setState` 和组件重新渲染，对于极其复杂的表单可能存在性能瓶颈（通常可忽略，或通过 `useMemo` 优化）。

**三. React 非受控组件**

**1.定义**

> 表单元素的值由 DOM 本身处理，而不是由 React 的 State 控制。通常使用 **Ref** 来从 DOM 中获取表单数据的组件，称为非受控组件。

**2.核心原理**

> - **数据源是 DOM**：类似于传统的 HTML 表单行为。
> - **按需获取**：只有在需要的时候（如点击提交）才去读取值。
> - **使用 defaultValue**：使用 `defaultValue` 而不是 `value` 来设置初始值。

**3.使用场景**

> - 处理文件上传（`<input type="file" />` 只能是非受控的）。
> - 集成第三方非 React 库（如 jQuery 插件、Datepicker）。
> - 极其简单的表单，不想编写繁琐的 `onChange` 逻辑。
> - 为了性能优化（避免输入时的频繁渲染）。

**四. 对比**

| 维度           | 受控组件                         | 非受控组件                       |
| :------------- | :------------------------------- | :------------------------------- |
| **数据源**     | React State                      | DOM                              |
| **获取值方式** | `state.value`                    | `ref.current.value`              |
| **事件处理**   | 必须 (`onChange`)                | 可选 (通常在提交时处理)          |
| **实时验证**   | 容易实现                         | 较难实现                         |
| **代码量**     | 较多（需写 handler）             | 较少                             |
| **推荐场景**   | 大部分表单场景、需校验、动态表单 | 文件上传、简单表单、集成第三方库 |

## React-Router-Dom原理

**1.定义**

> `react-router-dom` 是 React 官方推荐的标准路由库。它是 `react-router` 的 Web 版本绑定，专门用于在 React 应用中实现**客户端路由**（Client-side Routing），即在单页应用（SPA）中通过 URL 的变化来渲染不同的组件，而不会引起页面的整体刷新。

**2.核心作用**

它的主要作用是管理视图与 URL 的同步。

> - **声明式路由**：允许像编写 UI 组件一样配置路由（例如 `<Route path="/" element={<Home />} />`），代码更直观。
> - **页面无刷新跳转**：通过 `Link` 或 `useNavigate` 切换 URL 时，只更新变化的部分组件，提升用户体验和应用性能。
> - **路由参数管理**：方便地获取 URL 中的查询参数和路径参数。
> - **权限控制**：结合路由配置实现登录拦截（路由守卫）等功能。

**3.核心 API** 

`react-router-dom` 的 API 主要分为三类：**路由器组件**、**路由匹配组件**和**导航组件/Hooks**。

**路由器容器**

> - `<BrowserRouter>`：使用 HTML5 History API（最常用，URL 更美观）。
> - `<HashRouter>`：使用 URL 的 hash 部分（如 `/#/about`），兼容性更好。

**路由匹配**

> - `<Routes>`：类似于 v5 的 `Switch`，用于包裹一组路由，内部只会渲染第一个匹配到的路由。
> - `<Route>`：定义路径与组件的对应关系。

**导航与 Hooks**

> - `<Link>` / `<NavLink>`：生成跳转链接，`NavLink` 支持样式激活状态。
> - `useNavigate()`：编程式导航（替代了 v5 的 `useHistory`）。
> - `useParams()`：获取动态路由参数（如 `/user/:id` 中的 id）。
> - `useLocation()`：获取当前 location 对象（包含 pathname, search 等）。
> - `<Outlet />`：用于嵌套路由，渲染子路由的组件位置。

**4.核心原理**

其原理主要由三个层面组成：

1.History 管理（底层驱动）

> - 依赖于 HTML5 的 `History API`（如 `pushState`、`replaceState`）来改变 URL 而不刷新页面。
> - 内部维护了一个 history 对象，监听 URL 的变化（`popstate` 事件）。当 URL 改变时，history 对象会更新并通知上层。

2.Context 状态共享（数据流转）

> - `BrowserRouter`（或 `HashRouter`）组件作为最外层的 Provider，通过 React Context 创建了一个全局的路由上下文。
> - 它将当前的 `location`（路径信息）、`navigate`（跳转方法）等状态放入 Context 中。
> - 所有子组件（如 `Link`、`useNavigate`）都通过 `useContext` 消费这些数据，从而感知路由变化。

3.路由匹配与渲染（UI 展示）

> - `Routes` 组件会从 Context 中获取当前的 `location`。
> - 它遍历所有的 `Route` 子组件，将 `location.pathname` 与 `Route` 的 `path` 属性进行匹配。
> - 匹配成功后，渲染对应的 `element` 组件；匹配失败则渲染 `null` 或默认的 `404` 组件。

**简易源码级流程**

> 1. `Router` 组件挂载时，创建一个 history 对象并监听 `popstate` 事件。
> 2. 当用户点击 `Link` 或调用 `navigate` 时，调用 history 的 `push` 方法修改 URL。
> 3. URL 变化触发监听回调，更新 `Router` 内部的 State（`location`）。
> 4. State 更新触发 React 重新渲染。
> 5. `Routes` 组件重新执行，根据最新的 `location` 计算出哪个 `Route` 应该显示。”

## 虚拟DOM

**一、定义**

> **虚拟DOM（Virtual DOM）** 本质上是 **一个普通的 JavaScript 对象**（在React中通常表现为树形结构）。
>
> 它是真实DOM在内存中的轻量级表示。React通过 `ReactDOM.render` 等方法，将这个对象树最终渲染成浏览器的真实DOM。每当数据发生变化，React会生成一个新的虚拟DOM树，并与旧树进行对比，计算出最小变更，最后只更新变化的部分到真实DOM。

**二、工作原理**

React处理虚拟DOM的核心流程：

> 1. **初始渲染**：
>    React将JSX编译成 `React.createElement` 调用，生成虚拟DOM树，然后一次性渲染成真实DOM。
> 2. **更新阶段**：
>    当组件的 `state` 或 `props` 发生变化时，React会重新调用 `render` 方法，生成一棵**新的虚拟DOM树**。
> 3. **Diff算法与Reconciliation（协调）**：
>    React使用 **Diff算法** 比较新旧两棵虚拟DOM树。通过特定的比较策略，找出哪些节点发生了变化（这个过程称为 Reconciliation）。
> 4. **批量更新**：
>    计算出差异后，React会将所有需要变更的操作收集起来，一次性同步更新到真实DOM上（避免频繁操作DOM导致的性能损耗）。

**三、Diff算法策略**

React的Diff算法设计基于以下三个核心假设（也称为“降低复杂度的策略”）：

> 1. **同层比较**：
>    React只比较同一层级的节点，不会跨层级比较。如果父节点不同，直接销毁旧节点及其子节点，不再比较子节点。这把算法复杂度从 O(n3)*O*(*n*3) 降低到了 O(n)*O*(*n*)。
> 2. **类型比较**：
>    - 如果节点类型改变（如 `div` 变成 `span`），则直接销毁旧节点，创建新节点。
>    - 如果节点类型相同（如 `div` 还是 `div`），则只更新属性，并继续对子节点进行递归比较。
> 3. **Key属性标识**：
>    在处理列表时，React通过 `key` 来识别哪些元素是新的、哪些是移动了的、哪些是被删除的。这极大地提高了列表渲染和更新的效率。

**四、优势与劣势**

**优势：**

> 1. **性能优化（批量更新）**：
>    虚拟DOM最大的价值在于**将多次DOM操作合并为一次**。真实DOM的重排和重绘开销很大，虚拟DOM利用JS的计算能力，减少了真实DOM的操作次数。
> 2. **跨平台能力**：
>    由于虚拟DOM是JS对象，不依赖于浏览器环境，这使得React可以通过不同的渲染器适配多种平台（如 `ReactDOM` 渲染Web，`React Native` 渲染移动端原生组件，`React ART` 渲染Canvas/SVG）。
> 3. **声明式开发体验**：
>    开发者只需关注数据状态，不需要手动操作DOM。React帮我们处理了数据到视图的映射，代码更易维护。

**劣势：**

> 1. **内存占用**：
>    需要在内存中维护一份虚拟DOM树的副本，如果应用极其庞大，会占用更多内存。
> 2. **初次渲染开销**：
>    在首次渲染时，由于需要构建虚拟DOM树再映射为真实DOM，比直接操作 innerHTML 插入大量静态内容稍慢（但在后续更新中优势明显）。

**五、进阶**

> 1. **React 16+ 的 Fiber 架构**：
>    早期的React Diff是递归调用，不可中断，大量更新可能导致页面卡顿（Stack Reconciler）。React 16引入了 **Fiber** 架构，将虚拟DOM节点变成了一个链表结构，实现了**可中断的异步渲染**（Time Slice），让高优先级任务（如用户输入）可以插队，解决了卡顿问题。
> 2. **虚拟DOM vs 模板引擎**：
>    Vue和React都使用虚拟DOM，但Vue的模板编译器能做静态标记，跳过静态节点的Diff，而React需要开发者手动通过 `React.memo` 等API优化。

# 高级

## 事件绑定原理

**一、 核心定义（一句话总结）**

> React 事件绑定原理可以概括为：**“合成事件” + “事件委托”**。
>
> React 并不会直接把事件绑定到真实的 DOM 节点上，而是采用**事件委托**的方式，将所有事件统一绑定到根节点（React 17 开始）或 `document`（React 16）上。当事件触发时，React 通过**事件池**和**合成事件**对象来模拟原生事件流，从而实现跨浏览器的兼容性和性能优化。

**二、核心机制**

**1.事件委托**

> - **原理**：React 在应用初始化时，会在根节点（`#root`）上通过 `addEventListener` 绑定多种原生事件（如 `click`、`input` 等）。
> - 优势：
>   - **减少内存消耗**：不需要在每个 JSX 元素上单独绑定监听器，大大减少了内存占用。
>   - **统一管理**：方便事件的统一分发和移除，避免内存泄漏。
> - **执行流程**：当用户点击某个按钮时，原生 `click` 事件会冒泡到根节点 -> React 捕获到该事件 -> 根据 `target` 找到对应的 Fiber 节点 -> 从 Fiber 节点中取出 `onClick` 回调函数 -> 执行回调。

**2.合成事件**

> - **原理**：React 模拟了一套原生事件的实现，创建了一个名为 `SyntheticEvent` 的类。
> - 作用：
>   - **抹平浏览器差异**：React 将不同浏览器（如 IE、Chrome、Safari）的事件行为进行了统一，开发者无需关心兼容性问题（例如 `e.target` vs `e.srcElement`）。
>   - **统一接口**：提供了标准的 `preventDefault()`、`stopPropagation()` 等方法。
> - **模拟冒泡/捕获**：React 利用 Fiber 架构的层级关系，在内存中模拟了原生事件的“冒泡”和“捕获”阶段，按照组件层级顺序执行用户绑定的代码。

**三.与原生事件的区别**

| 维度             | React 合成事件                          | 原生事件                                          |
| :--------------- | :-------------------------------------- | :------------------------------------------------ |
| **命名规范**     | 小驼峰命名：`onClick`                   | 全小写：`onclick`                                 |
| **事件对象**     | `SyntheticEvent` 对象（跨浏览器包装器） | 原生 `Event` 对象                                 |
| **阻止默认行为** | `e.preventDefault()`                    | `return false` (部分事件) 或 `e.preventDefault()` |
| **this 指向**    | 类组件中默认为 `undefined`，需手动绑定  | 指向触发事件的 DOM 元素                           |

**四、坑点**

> 1. **混合使用时的执行顺序**：
>    - 如果同时存在原生事件和 React 合成事件。
>    - **捕获阶段**：原生捕获事件 -> React 合成捕获事件。
>    - **冒泡阶段**：React 合成冒泡事件 -> 原生冒泡事件。
>    - *注意：React 的事件流是模拟的，只有原生事件真正经过了浏览器的 DOM 树，React 的事件是在 JS 逻辑层模拟遍历 Fiber 树执行的。*
> 2. **阻止冒泡的局限性**：
>    - 在 React 事件中使用 `e.stopPropagation()` 只能阻止 React 合成事件的冒泡，**无法阻止原生事件的冒泡**。
>    - 如果需要阻止原生事件，必须使用 `e.nativeEvent.stopImmediatePropagation()`（不常用，通常建议避免混用）。

五、版本演进（React 16 vs 17+）

> - **React 16 及之前**：事件委托绑定在 `document` 对象上。这导致如果页面中混用了 jQuery 等原生库，可能会出现事件冲突（因为 `document` 也是原生事件的根）。
> - React 17 及之后：事件委托绑定在渲染树的根 DOM 容器上（通常是div#root）。
>   - **优点**：解决了多版本 React 共存的问题，也减少了与原生事件的冲突概率。

## Redux原理

**一、定义**

> Redux 是一个基于 Flux 思想的可预测状态容器，它通过**单一数据源**、**只读 State** 和**纯函数 Reducer** 三大原则来管理状态。它主要用于管理跨组件、跨页面的全局状态，确保状态的变化是可追踪、可预测的。

**最佳实践**

> 在 React 项目中，我通常配合 `react-redux` 使用，通过 `useSelector` 和 `useDispatch` 连接组件。对于异步逻辑，我会使用 `redux-thunk` 或 `redux-saga` 中间件。
>
> 不过，我也注意到传统 Redux 写起来比较繁琐。现在的项目中，我首选 **Redux Toolkit (RTK)**，它利用 `createSlice` 和 `Immer` 大幅简化了不可变数据的写法，是官方目前推荐的 Redux 开发方式。对于非常小型的项目，我也会权衡是否直接使用 React Context API 来替代 Redux。

**二、三大核心原则**

**1.单一数据源**

> - 整个应用的 state 只存储在**唯一**的一个 Store 对象树中。
> - 这使得调试、持久化（如本地存储）和服务器端渲染变得容易。

**2.State 是只读的**

> - 唯一改变 state 的方法是触发 **Action**。
> - Action 是一个普通的 JavaScript 对象（如 `{ type: 'ADD_TODO', text: 'Go shopping' }`）。
> - 这保证了 View 或网络回调都不能直接修改数据，所有修改都被集中化处理。

**3.使用纯函数来执行修改**

> - 为了描述 action 如何改变 state tree，你需要编写 **Reducers**。
> - Reducer 是一个纯函数：`(previousState, action) => newState`。它接收旧的 state 和 action，返回新的 state。

**三、React-Redux（连接层）**

Redux 本身是框架无关的，要在 React 中使用，需要 `react-redux` 库。

**核心 API**

> 1. `<Provider>`：
>    - 包裹在应用最外层，利用 React Context 将 Store 注入到整个组件树中。
> 2. `useSelector` (Hooks)：
>    - 用于从 Store 中读取状态。
>    - 内部会自动优化，仅当 selector 返回的值发生变化时才触发重渲染。
> 3. `useDispatch` (Hooks)：
>    - 用于获取 `dispatch` 函数，从而触发 Action。

**四、中间件**

中间件提供的是位于 action 被发起之后，到达 reducer 之前的**扩展点**。主要用于处理异步逻辑或副作用。

> - **redux-thunk**：允许 Action 是一个函数（而不只是对象）。在这个函数里可以进行异步操作（如 Ajax 请求），完成后再手动 `dispatch` 一个普通的 action。
> - **redux-saga**：使用 ES6 的 Generator 特性，将异步逻辑写得更像同步代码，便于处理复杂的异步流。
> - **redux-observable**：使用 RxJS 处理异步流。
> - **redux-logger**：用于在控制台打印每次 action 和 state 的变化，便于调试。

**中间件的原理**

中间件的本质是对 `store.dispatch` 方法的**增强（重写）**。它使用了**洋葱模型**和**柯里化**的技术。

> **核心思想：柯里化与链式调用**
>
> Redux 中间件的签名遵循以下柯里化形式：
>
> const middleware = store => next => action => {  *// 中间件逻辑*  next(action); *// 传递给下一个中间件或 Reducer* };
>
> - **`store`**：包含 getState, dispatch 的引用。
> - **`next`**：下一个中间件的 dispatch 函数（或者是原生的 dispatch）。
> - **`action`**：当前 dispatch 的 action。
>
> 
>
> **洋葱模型 执行流程**
>
> 当我们使用 `applyMiddleware` 挂载多个中间件时，它们会被组合成一个链。Action 像穿针引线一样穿过每个中间件。
>
> 1. **外层入**：Action 进入第一个中间件 -> 第二个中间件 -> …
> 2. **执行核心**：到达最底层的 Store，State 更新。
> 3. **内层出**：从内层中间件返回结果 -> … -> 第一个中间件返回结果。
>
> 
>
> **redux-thunk 的原理**
>
> `redux-thunk` 是最简单的异步中间件，它的源码极其精简，非常适合面试时手写。
>
> - 如果是**对象**（同步 action）：直接传给下一个中间件。
>
> - 如果是**函数**（异步 action）：执行这个函数，并把 `dispatch` 和 `getState` 传给它。
>
>   ```js
>   const thunk = ({ dispatch, getState }) => next => action => {
>     // 如果 action 是函数，执行它
>     if (typeof action === 'function') {
>       return action(dispatch, getState);
>     }
>     // 否则，默认处理（传给下一个中间件或 Reducer）
>     return next(action);
>   };
>   ```

**五、进阶-现代 Redux (Redux Toolkit)** 

背景：传统的 Redux 写法繁琐，且容易在 Reducer 中因忘记展开运算符而修改了原对象。

**Redux Toolkit (RTK)** 是官方现在推荐的标准写法，它解决了原始 Redux 的痛点：

> 1. **简化配置**：`configureStore` 自动集成了 Redux DevTools、Thunk 中间件和序列化检查。
> 2. **简化 Reducers (Immer)**：引入了 `createSlice`，内部使用 `Immer` 库。**允许我们在 Reducer 中直接修改 state（如 `state.value = 1`）**，Immer 会在底层自动生成不可变的新状态，极大减少了代码量。
> 3. **不复用样板代码**：不再需要手写 switch-case 语句或 action creators。

**六、优缺点**

**优点**

> - **可预测**：状态的变化清晰可追踪，配合 Time-travel Debugging（时光旅行调试）极其强大。
> - **解耦**：组件与状态逻辑分离，代码结构清晰。
> - **生态丰富**：中间件、DevTools 非常成熟。

**缺点**

> - **概念繁琐**：对于简单的应用，学习成本和代码量过大。
> - **样板代码**：如果不使用 Redux Toolkit，需要写大量的 Action、Reducer、Type 定义。

## Redux 与 Vuex 

**1.定义**

> Redux 和 Vuex 虽然都源自 Flux 架构，但设计哲学截然不同，这主要是为了适配各自的框架底层机制。

**Redux** 基于 **函数式编程**，强调 **数据的不可变性** 和 **纯函数 Reducer**，这种显式的数据变更让 React 的 diff 算法能高效工作，也极其便于调试。

**Vuex** 基于 **Vue 的响应式系统**，强调 **显式的 Mutation** 但数据本身是 **可变** 的，利用 Vue 的 Proxy 能力自动通知组件更新。Vuex 还特意区分了 `Action`（异步）和 `Mutation`（同步），这在规范上比 Redux 的统一 Action 更加明确。

简而言之，**Redux 像是一个严格的记账员**，每一笔账都记在新本子上；**Vuex 像是一个智能管家**，修改数据后自动把事情办好，但必须按照规定的流程来修改。

**2.核心对比**

| 维度                | Redux (React)                                              | Vuex (Vue)                                                   |
| :------------------ | :--------------------------------------------------------- | :----------------------------------------------------------- |
| **底层数据机制**    | **普通 JS 对象**，不支持自动响应式更新，依赖浅比较。       | **响应式对象** (Vue 2: `Object.defineProperty` / Vue 3: `Proxy`)，自动通知依赖更新。 |
| **修改 State 方式** | **不可变**。必须返回新对象 (如 `...state, { count: 1 }`)。 | **可变**。直接修改属性 (如 `state.count = 1`)，因为 Proxy 拦截到了修改操作。 |
| **异步处理**        | 统一由 **Action** 处理，通过中间件 拦截。                  | **Action** 处理异步逻辑，然后调用 **Mutation** 修改状态。    |
| **代码风格**        | 函数式编程，Reducer 是纯函数。                             | 面向对象/配置式，区分 Modules, State, Getters, Mutations, Actions。 |
| **调试能力**        | 强大。由于是纯函数和不可变数据，可以轻松实现 Time-Travel。 | 较强。通过 Mutation 记录实现，但因为数据是可变的，回滚功能相对复杂。 |

**3.为什么设计会有差异**

**React 为什么推崇不可变数据？**
React 的 `setState` 或 Hooks 的更新机制依赖于**前后值的引用比较**。如果你直接修改了对象的属性，引用地址没变，React 就不知道数据变了，界面不会更新。因此，Redux 必须配合 React 的这个特性，强制返回新引用。

**Vue 为什么推崇可变数据？**
Vue 的核心是**依赖收集**。Vue 的响应式系统会自动拦截对象的 `get` 和 `set` 操作。当你修改 `state.count = 1` 时，Vue 知道哪个组件用了它，并自动去更新那个组件。因此，在 Vuex 中直接修改变量不仅符合直觉，而且性能极高。

**4.Redux 的设计思想：纯粹与可预测**

Redux 的设计深受**函数式编程** 影响，核心思想是 **“数据的不可变性”** 和 **“显式的状态变更”**。

> 1. **单一数据源**：整个应用的 state 存储在一个单一的 object tree 中。
> 2. **State 是只读的**：唯一修改 state 的方式是触发 **Action**（一个描述发生什么的普通对象）。这保证了 View 和网络请求都不能直接修改状态。
> 3. 使用纯函数执行修改：通过Reducer（纯函数）来计算新状态。
>    - **设计哲学**：`reducer(previousState, action) => newState`。
>    - **不可变数据**：Redux 强制要求每次修改都返回一个新的对象引用，而不是修改原对象。这使得 React 能够极其高效地进行浅比较来决定是否重渲染，也使得“时光旅行调试”成为可能。
> 4. **核心流程**：View -> dispatch(Action) -> Middleware -> Reducer -> Store (New State) -> View

**5.Vuex 的设计思想：响应式与约定**

Vuex 是专门为 **Vue.js** 设计的状态管理库，它深度融合了 Vue 的**响应式系统**。

> 1. **响应式的 State**：Vuex 的 state 也就是一个 Vue 的 `data` 对象。当 state 变化时，依赖该 state 的组件会自动更新。
> 2. **显式地修改状态**：虽然 Vuex 内部也是响应式的，但它强制要求通过 **Mutation** 修改状态，以便 DevTools 追踪变化。
> 3. 同步/异步分离：Vuex 强制将同步操作放在Mutation中，将异步操作放在Action中。
>    - **设计哲学**：`Action` (异步) -> `commit` -> `Mutation` (同步修改) -> `State`。
> 4. **核心流程**：View -> dispatch(Action) (异步) -> commit(Mutation) (同步) -> State (Vue 响应式更新) -> View

## Redux 与 Mobx 

**一、定义**

> - **Redux**：是**单向数据流**、**不可变数据**的状态管理库。它提倡严格的函数式编程，通过`Action`描述意图，`Reducer`纯函数更新状态，适合大型应用，状态可预测性强。
> - **MobX**：是**响应式编程**、**可变数据**的状态管理库。它通过`Observable`（可观察对象）自动追踪状态变化，自动触发UI更新，代码量少，开发模式更接近Vue，学习曲线平缓。

**总结**：Redux是“**仪式感强、可预测**”的代表，MobX是“**响应式、魔法化**”的代表。

**二、 详细对比维度**

**1. 设计理念与范式**

> - Redux (函数式编程 FP)：
>   - 遵循**Flux架构**，强调**单向数据流**（View -> Action -> Reducer -> Store -> View）。
>   - 状态是**只读**的，必须通过触发`action`，由`reducer`返回一个新的状态对象来更新。
> - MobX (面向对象 OOP + 响应式)：
>   - 基于**观察者模式**（Observer Pattern）。
>   - 状态是**可变**的，可以直接修改数据（类似Vue），MobX会自动检测变化并触发渲染。它通过`@observable`、`@computed`、`@action`等装饰器（或API）来实现响应式。

**2. 数据结构：单一Store vs 多Store**

> - **Redux**：推崇**单一Store**（Single Source of Truth）。整个应用的状态集中在一个巨大的对象树中，便于调试和持久化。
> - **MobX**：允许（甚至鼓励）**多个Store**。你可以按业务模块拆分多个小Store，更符合面向对象的思维，管理起来相对灵活。

**3. 状态更新方式：不可变 vs 可变**

> - Redux：必须保持不可变性。
>   - 在Reducer中，不能直接修改state，必须返回一个新的对象（通常配合展开运算符`...`或Immutable.js）。
>   - **优点**：易于追踪状态变化历史，实现“时光旅行”调试。
>   - **缺点**：编写繁琐，需要不断解构赋值。
> - MobX：可变性。
>   - 直接修改数据：`this.count++`。
>   - **优点**：代码直观，符合直觉，无需处理复杂的对象拷贝。
>   - **缺点**：难以精确追踪每一次状态变更历史（相比Redux的DevTools稍弱），调试可能依赖侵入式的日志。

**4. 样板代码与开发体验**

> - Redux：样板代码多。
>   - 需要定义Action Types、Action Creators、Reducers、配合`mapStateToProps`/`mapDispatchToProps`（虽然Redux Toolkit极大缓解了这个问题，但概念依然存在）。
> - MobX：代码量极少。
>   - 状态定义简单，修改直接，无需编写繁琐的模板代码。被称为“开箱即用”的极简方案。

**5. 性能优化机制**

> - Redux：依靠浅比较和组件连接优化。
>   - Redux本身不处理性能，通常配合`react-redux`的`connect`或`useSelector`，通过浅比较避免不必要的渲染。如果状态树很大，需要手动优化（如`reselect`）。
> - MobX：自动精确更新。
>   - MobX通过依赖收集，确切知道哪些组件依赖了哪些属性。当只有`name`变化时，只有使用了`name`的组件会重新渲染，性能由库内部机制保证，通常优于手动的Redux优化。

**三、适用场景**

> - **Redux** 胜在**可维护性和可预测性**，它用繁琐的流程换取了应用的稳定性，适合对代码规范要求极高的大型团队。
> - **MobX** 胜在**开发效率和极简性**，它利用响应式机制屏蔽了手动更新的复杂性，适合追求开发速度和代码简洁的场景。

> **什么时候选择 Redux？**
>
> 1. **项目规模大、逻辑复杂**：需要严格的数据流规范，便于多人协作。
> 2. 需要强大的**调试工具**（Redux DevTools的时间旅行、Action回放是刚需）。
> 3. 服务端渲染需求较高，需要统一的State快照。
> 4. 团队习惯函数式编程，或使用Redux Toolkit简化了开发。
>
> **什么时候选择 MobX？**
>
> 1. **快速开发、中小型项目**：希望代码量少，快速迭代。
> 2. 团队有**Vue背景**，习惯响应式数据绑定。
> 3. 状态逻辑复杂但不需要严格的时间旅行调试。
> 4. 希望以面向对象（OOP）的方式组织代码。

## Difff算法

**一、定义**

> React的Diff算法，本质上是 **“协调”过程的核心实现**。
>
> 当组件的状态发生变化时，React会生成一棵新的虚拟DOM树。Diff算法的作用就是 **以最小的代价** 将旧树转换为新树。它通过特定的比较策略，计算出哪些节点发生了变化，最终只将这些变化更新到真实DOM上。
>
> **核心成就：** 将标准的树形结构比较复杂度从 O(n3)*O*(*n*3) 降低到了 **O(n)\*O\*(\*n\*)**，使得算法在浏览器环境中具备实际应用价值。

**二、三大策略**

React为了实现 O(n)*O*(*n*) 的复杂度，主要基于以下三个主要策略（也称为“Trade-off”/权衡）：

**1. 同层比较**

> - **策略**：React只对同一层级的节点进行比较，不跨层级比较。
> - **逻辑**：如果父节点不同，直接销毁旧节点及其子树，创建新节点。虽然这看似“暴力”，但实际上在Web开发中，跨层级移动节点的操作非常少，这样做极大地减少了计算量。

**2.类型比较**

> - **策略**：通过判断节点的 `type`（类型）来决定是复用还是销毁。
> - 逻辑：
>   - **类型相同**：如果是原生元素（如 `div`），保留节点，更新属性；如果是组件，保留实例，更新状态。
>   - **类型不同**：直接销毁旧节点（触发卸载生命周期），创建新节点（触发挂载生命周期）。

**3.Key属性标识**

> - **策略**：通过 `key` 来识别列表中的节点是否可复用。
> - **逻辑**：在对比子节点列表时，React通过 `key` 将新旧列表中的节点进行匹配，判断节点是移动了、新增了还是删除了。

**三、Diff流程详解**

React的Diff过程主要发生在 `reconcileChildren`（协调子节点）过程中，分为单节点Diff和多节点Diff：

**1. 单节点Diff**

> 比较新旧节点：
>
> 1. 比较 `key`：如果 `key` 不同，直接标记删除旧节点，创建新节点。
> 2. 比较 `type`：如果 `key` 相同但 `type` 不同，标记删除旧节点，创建新节点。
> 3. 如果 `key` 和 `type` 都相同，则判定为**可复用**，更新属性。

**2. 多节点Diff（列表对比）**

> React对列表的处理分为两轮遍历：
>
> - **第一轮遍历（处理更新）**：
>   从左往右逐个对比，如果 `key` 和 `type` 都匹配，则复用并更新属性；一旦遇到不匹配的节点，立即停止第一轮遍历。
> - **第二轮遍历（处理移动、新增、删除）**：
>   如果第一轮遍历中途停止，说明存在节点移动或新增。React会将旧列表中剩余的节点存入一个 Map 映射表（以 `key` 为索引），然后遍历新列表中剩余的节点，去 Map 中查找复用。最后，处理未被复用的旧节点（删除）和未被匹配的新节点（新增）。

**四、React与Vue的区别**

> - **React**：采用“双端比较”的变种（虽然源码逻辑上是两轮遍历），更倾向于“仅从左向右”的查找逻辑，配合 `lastPlacedIndex` 标记来处理移动。在节点移动复杂时，性能可能略逊于Vue，但实现逻辑相对简单。
> - **Vue 2 (双端Diff)**：同时从新旧列表的头尾四个方向进行比较，尽可能快速找到可复用节点。
> - **Vue 3 (最长递增子序列)**：在处理移动时，通过求解“最长递增子序列”来最大程度减少DOM移动次数，理论性能最优。

**五、进阶扩展（Fiber架构）**

在React 16之前：

> Diff算法是**递归同步执行**的（Stack Reconciler）。这导致一旦组件树很深，Diff计算会长时间占用主线程，导致页面卡顿（掉帧）。

React 16引入 **Fiber架构** 后：

> 1. **数据结构改变**：虚拟DOM树变成了链表结构（`child`, `sibling`, `return` 指针）。
> 2. **任务拆分**：Diff过程变成了**可中断的“增量渲染”**。React利用浏览器的空闲时间执行Diff，如果有高优先级任务（如用户输入），会暂停Diff，优先响应用户交互，从而解决了大型应用的交互卡顿问题。

## 类组件和函数组件的性能优化

**一、定义**

React 性能优化的核心目标是**减少不必要的重新渲染**。

> - **类组件**：主要依赖 **`React.PureComponent`** 自动进行浅比较，或手动实现 **`shouldComponentUpdate`** 生命周期来控制渲染开关。
> - **函数组件**：主要依赖 **`React.memo`** 进行 Props 浅比较，配合 **`useMemo`** 和 **`useCallback`** 缓存引用类型数据，避免因引用变化导致的无效渲染。

**二、 类组件的性能优化**

| 维度         | 类组件                                    | 函数组件                                       |
| :----------- | :---------------------------------------- | :--------------------------------------------- |
| **核心手段** | `PureComponent` / `shouldComponentUpdate` | `React.memo` / `useMemo` / `useCallback`       |
| **原理**     | 通过生命周期钩子控制是否渲染              | 通过 Hooks 缓存引用，利用 Fiber 架构依赖链     |
| **常见陷阱** | 在 render 中 bind 函数导致优化失效        | 忘记配合 `useCallback`，导致 `React.memo` 失效 |
| **副作用**   | `getSnapshotBeforeUpdate` 等生命周期管理  | `useEffect` / `useLayoutEffect` 管理           |

**1. 使用 `React.PureComponent`**
`PureComponent` 对 `props` 和 `state` 进行了浅比较。如果数据引用未变，组件将不会重新渲染。

> - **原理**：对 `props` 和 `state` 的第一层属性进行 `Object.is` 或 `===` 比较。
> - **局限**：如果是对象内部属性变化（深层比较）或新的引用对象（即使内容相同），依然会触发渲染。

```js
class MyComponent extends React.PureComponent {
  // 自动挂载了浅比较的 shouldComponentUpdate
}
```

**2. 手动实现 `shouldComponentUpdate`**
对于复杂逻辑或 `PureComponent` 无法满足的场景，手动控制渲染。

> - **场景**：需要比对深层对象，或根据特定业务逻辑判断是否更新。

```js
shouldComponentUpdate(nextProps, nextState) {
  // 返回 false 则阻止渲染
  return nextProps.id !== this.props.id;
}
```

**3. 避免箭头函数绑定**
在 `render` 方法中避免使用 `bind` 或箭头函数，这会导致每次渲染都创建新的函数引用，破坏子组件的 `PureComponent` 优化。

> - **错误做法**：`onClick={() => this.handleClick()}` 或 `onClick={this.handleClick.bind(this)}`。
> - **正确做法**：在构造函数 `constructor` 中预先绑定，或使用类属性语法 `handleClick = () => {}`。

**三、 函数组件的性能优化**

**1. 使用 `React.memo`（组件级缓存）**
类似于 `PureComponent`，它是一个高阶组件，用于包裹函数组件。

> - 如果 Props 未变，React 会复用上次的渲染结果。

```js
const MyComponent = React.memo(function MyComponent(props) {
  /* render */
});
```

**2. 配合 `useCallback`（缓存函数）**
`React.memo` 只做浅比较。如果父组件传递了一个函数 Props，每次父组件渲染都会创建新函数，导致引用不同，`React.memo` 失效。

> - **解决方案**：使用 `useCallback` 缓存函数引用，确保依赖不变时，函数引用不变。

```js
const handleClick = useCallback(() => {
  doSomething(a, b);
}, [a, b]); // 只有 a, b 变化时才创建新函数
```

**3. 配合 `useMemo`（缓存对象/计算结果）**
对于传递给子组件的对象或复杂的计算结果，使用 `useMemo` 缓存。

```js
const style = useMemo(() => ({ color: 'red' }), []);
const computedValue = useMemo(() => heavyCalc(data), [data]);
```

**四、共同的优化思想**

无论是类组件还是函数组件，都应遵循以下原则：

> **1. 状态下放**
> 如果父组件的一个状态只被某个子组件使用，不要将状态存在父组件。将状态下沉到子组件内部，避免父组件更新牵连子组件。
>
> **2. 列表 Key 的正确使用**
> 列表渲染必须使用稳定的 `key`（通常是 ID），避免使用 `index`。这能帮助 React 准确识别节点复用，减少 DOM 操作。
>
> **3. 虚拟滚动**
> 针对长列表，只渲染可视区域的组件（使用 `react-window` 等库），这是解决列表性能问题的终极方案。

## 性能优化

**一.定义**

> React 性能优化的核心原则只有两个：**减少不必要的渲染** 和 **减少计算量**。React 的调和过程是昂贵的，我们的目标是控制 React 在数据变化时，只更新该更新的部分。

**二.具体层面**

**1.组件渲染层面**

> 首先使用 `React.memo` 避免子组件无意义的重渲染，配合 `useCallback` 和 `useMemo` 来稳定 props 的引用，防止因内联函数或对象导致的缓存失效。特别注意列表渲染时不要用 `index` 做 key。

**2.状态管理层面**

> 遵循 State 最小化原则，避免将所有状态提升导致全局渲染。对于 Context，我会根据业务维度进行拆分，防止单一 Context 变更引发大面积组件重渲染。

**3.工程化与体验层面**

> 利用 `React.lazy` 和 `Suspense` 进行路由级代码分割，减少首屏加载时间。在 React 18 中，我会使用 `useTransition` 来处理繁重的计算任务，保证 UI 的响应性不被阻塞。

# 用了Vue-两天学会React(实战)

## React入门

```
<html>
<head>
    <title>Document</title>
    <script crossorigin src="https://unpkg.com/react@16/umd/react.development.js"></script>
    <script crossorigin src="https://unpkg.com/react-dom@16/umd/react-dom.development.js"></script>
    <script src="https://unpkg.com/babel-standalone@6/babel.min.js"></script>
</head>
<body>
    <div id="app"></div>
</body>
</html>
<script type="text/babel">
    // OH的右边的内容就是JSX的语法：类似XML的js的扩展语法
    // 需要这么写，不然就会报错，需要告诉babel需要转哪些，只需要在script标签写type="text/babel"就可以了）
    let oH = <div id='xx'>hello react!</div>;
    // ReactDOM.render(要渲染什么内容，渲染到哪里)
    // 只有用了这个才会创建虚拟DOM，先创建再更新
    ReactDOM.render(oH, document.querySelector("#app"));
</script>
```

**基本语法规则**

- 遇到<>开头的代码，以标签的语法解析
- 遇到{}开头的代码，以js的语法解析

**渲染虚拟dom**

- 使用纯JS方式创建
- 使用JSX方式创建

```
// 使用纯JS方式创建
let oH = React.createElement('h1',{id:'xx'},'hello react!')
// 使用JSX方式创建'
let oH = <div id='xx'>hello react!</div>;
```

**声明组件的两种方式**

类组件->函数组件就好像vue2->vue3进化过程一样

- 类组件
- 函数组件及react-hooks

```
// 类组件
 class App extends React.Component{
        // 方式1：需要使用到props传值继承时
        constructor(props){
            super(props)
            console.log(props)
            this.state={
                flag:false
            }
        }
        // 方式2：不需要props传值
        // state={
        //         flag:false
        //     }
         handleClick=()=> {
            debugger
            const {flag} =this.state
            this.setState({
                flag:!flag
            })
        }
        render(){
            const {flag} = this.state
            const msg = flag?'a':'b' 
            return(
                <div>
                    <h1 onClick={this.handleClick}></h1>
                    {msg}
                    </div>
            )
        }
   }
    ReactDOM.render(<App name="test"/>, document.querySelector("#app"));
   
// 函数组件及react-hooks，要求：函数名首字母大写，div根节点只能有一个。
function App(){
        return (<div>这是函数组件</div>)
    }
ReactDOM.render(<App/>, document.querySelector("#app"));
```

## 组件传值

vue

```javascript
// 父组件
<GoodsList v-if="!isGoodsIdShow" :goodsList="goodsList"/>
// 子组件 -- 通过props获取即可
props: {
    goodsList:{
      type:Array,
      default:function(){
        return []
      }
    }
  }
```

react

```typescript
// 父组件
export default function tab(props:any) {
    const [serverUrl, setServerUrl] = useState<string | undefined>('https://');
    console.log(props);
 // 父组件接收子组件的值并修改
    const changeMsg = (msg?:string) => {
        setServerUrl(msg);
     };

    return(
        <View className='tab'>
            <View className='box'>
                <TabName msg={serverUrl} changeMsg={changeMsg} />
            </View>
        </View>
    )
}

// 子组件
function TabName(props){
    console.log('props',props);
 // 子传父
    const handleClick = (msg:string) => {
      props.changeMsg(msg);
    };
    return (
        <View>
            <Text>{props.msg}</Text>
            <Button onClick={()=>{handleClick('77777')}}>测试</Button>
        </View>
    );
};
```

## 获取DOM

**vue**

```javascript
this.$refs['ref']
```

react

```typescript
// 声明ref    
const domRef = useRef<HTMLInputElement>(null);
// 通过点击事件选择input框
const handleBtnClick = ()=> {
     domRef.current?.focus();
     console.log(domRef,'domRef')
}

return(
        <View className='home'>
            <View className='box'>
                <Input ref={domRef} type="text" />
                <button onClick={handleBtnClick}>增加</button>
            </View>
        </View>
    )
```

## 列表渲染

vue

```html
<div v-for="(item, index) in mealList" :key="index">
 {{item}}
</div>
```

react

```typescript
//声明对象类型
  type Coordinates = {
    name:string,
    age:number
  };
 // 对象
  let [userState, setUserState] = useState<Coordinates>({ name: 'John', age: 30 });
 // 数组
  let [list, setList] = useState<Coordinates[]>([{ name: '李四', age: 30 }]);

// 如果你的 => 后面跟了一对花括号 { ，那你必须使用 return 来指定返回值！
const listItem = list.map((oi)=>{
    return <View key={oi.age}>{oi.name}</View>
  });

return (
      {
        list.map((oi)=>{
          return <Text className='main-list-title' key={oi.age}>{oi.name}</Text>
        })
      }
      <View>{ listItem }</View>
    </View>
  )
```

## 条件渲染

react

```
render() {
    const { showBgView, bgType, lang, showView, industryList } = this.state
    return (
      <div className='change-product-pop'>
        {
          showView ? (
            <div className='change-product-pop-list'>
            ):[]
         }
        </div>
        )
```

## 计算属性

vue

```javascript
computed: {
    userinfo() {
      return this.$store.state.userinfo;
    },
  },
```

react

```typescript
const [serverUrl, setServerUrl] = useState('https://localhost:1234');
let [age, setAge] = useState(2);

const name = useMemo(() => {
        return serverUrl + " " + age;
}, [serverUrl]);
console.log(name) // https://localhost:1234 2
```

## 监听器

vue

```javascript
watch: {
    // 保证自定义菜单始终显示在页面中
    customContextmenuTop(top) {
      ...相关操作
    }
  },
```

react

```typescript
import { useEffect, useState } from 'react';

export default function home() {
    const [serverUrl, setServerUrl] = useState('https://localhost:1234');
    const [age, setAge] = useState(2);

   /**
     * useEffect第二个参数中所传递的值才会进行根据值的变化而出发;
     * 如果没有穿值的话,就不会监听数据变化
     */
    useEffect(()=>{
        if (age !== 5) {
            setAge(++age)
        }
    },[age])

    useEffect(()=>{
        if(serverUrl !== 'w3c') {
            setServerUrl('w3c');
        }
    },[serverUrl])

    return(78)
}
```
