---
title: React入门
date: 2023-03-11 07:33:16
categories:
- D_框架和类库
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

## 类组件与函数组件区别

**一.定义**

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

# 中级

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
