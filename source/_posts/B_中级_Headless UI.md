---
title: Headless UI
date: 2003-06-01 08:33:16
categories:
- B_中级
toc: true # 是否启用内容索引
---

# 初级

## Headless UI是什么

**一、定义**

> Headless UI 是一种只提供组件逻辑和行为（如状态管理、无障碍访问、键盘交互），而不提供任何具体样式（HTML结构/CSS）的组件库。

**二、与传统的 UI 组件库(如 Ant Design、Element UI)区别**

> - **传统组件库**：提供“逻辑 + 样式 + DOM结构”，开箱即用，但定制化困难，容易产生“长得一样”的网站，覆盖样式时容易引发权重冲突。
> - **Headless UI**：提供“逻辑 + a11y支持”，不提供样式。开发者完全掌控DOM结构和样式，适合结合 Tailwind CSS 等原子化CSS实现高度定制化的UI。如 Tailwind Labs 的 `@headlessui/react` 或 React Aria。

## Headless UI优点

**一、定义**

> - **样式自由度**：彻底解耦了逻辑与表现，开发者可以使用任意CSS方案（Tailwind, styled-components, CSS Modules），不会受到组件库默认主题的限制。
> - **无障碍访问**：实现复杂的 WAI-ARIA 标准非常耗时且容易出错，Headless UI 在底层处理了焦点管理、`aria-*` 属性和键盘事件，保证了组件的基础可用性。
> - **避免样式覆盖地狱**：传统库修改内部样式经常需要使用 `!important` 或深层选择器，Headless UI 没有样式，避免了这些问题。

## 状态是如何暴露

**一、定义**

> 组件通信模式（Render Props vs Hooks）

**二、主要有两种常见模式**

Hooks 模式比 Render Props 模式更灵活，且能避免 JSX 嵌套地狱（如 React Aria 和 downshift 的演进）。

> - **Render Props 模式**：通过子组件传递一个函数，函数参数包含当前状态和操作方法。
> - **Custom Hooks 模式**：将逻辑抽离为 Hook，开发者自己组装 DOM。

```js
   // Render Props 模式
   <Menu>
     {({ open }) => (
       <button>{open ? '关闭' : '打开'}</button>
     )}
   </Menu>
   
   // Custom Hooks 模式
    const { open, getToggleProps } = useToggle();
   <button {...getToggleProps()}>{open ? '关闭' : '打开'}</button>
```

## 流行的 Headless UI 库

**一、定义**

> - **@headlessui/react**：由 Tailwind CSS 团队开发，主要配合 Tailwind 使用。
> - **React Aria**：由 Adobe 开源，专注于无障碍访问和复杂交互逻辑，Hooks化程度最高。
> - **TanStack Table (React Table)**：无头表格库的绝对霸主。
> - **Downshift**：专注于 Autocomplete、Combobox、Select 等输入型组件的无头库。

# 中级

## 处理无障碍访问

**一、定义**

> a11y规范在无头库中的落地实践。

**二、具体实践**

在 Dialog 中，Headless UI 会自动处理以下 a11y 细节：

> 1. **焦点陷阱**：当弹窗打开时，焦点会被限制在弹窗内部，防止用户通过 Tab 键聚焦到背景的隐藏元素。
> 2. **焦点恢复**：弹窗关闭后，焦点自动恢复到触发弹窗打开的元素（如打开按钮）上。
> 3. **ARIA 属性**：自动添加 `role="dialog"` 和 `aria-modal="true"`，并将弹窗标题与 `aria-labelledby` 绑定。
> 4. **滚动锁定**：通常还会锁定 `body` 的滚动，防止背景内容滚动。

## Prop Getters 模式

**一、定义**

对无头库底层 API 设计模式的理解。

> Prop Getters 是一种返回包含事件监听器、Aria属性等配置对象的函数，如 `getInputProps()`, `getToggleButtonProps()`。

**二、为什么使用**

> - 如果直接展开对象（如 `<input {...props} />`），当开发者需要监听同样的 `onChange` 时，会覆盖库的默认逻辑。
> - 使用 Prop Getters，库内部可以通过合并函数将开发者传入的事件处理函数与库自身的事件处理函数合并执行。

## 自定义 Dropdown 组件

**一、定义**

> Headless UI+Tailwind CSS 实现自定义Dropdown 组件

**二、代码**

以 `@headlessui/react` 为例，结构如下：

**【解析】** `Menu` 管理状态，`Menu.Button` 触发，`Menu.Items` 展示，`Menu.Item` 提供选中态，样式完全由 Tailwind 类名接管。

```js
import { Menu } from '@headlessui/react'

function Dropdown() {
  return (
    <Menu>
      <Menu.Button className="px-4 py-2 bg-blue-500 text-white rounded">
        选项
      </Menu.Button>
      <Menu.Items className="mt-2 w-56 origin-top-right rounded-md bg-white shadow-lg">
        <Menu.Item>
          {({ active }) => (
            <a className={`${active ? 'bg-blue-100' : ''} block px-4 py-2`} href="#">编辑</a>
          )}
        </Menu.Item>
      </Menu.Items>
    </Menu>
  )
}
```

## 复杂的键盘导航

**一、定义**

组件交互逻辑的控制。

Headless UI 库内部维护了一套键盘事件处理器。例如在 Combobox 或 Listbox 中：

> - 监听 `ArrowDown` / `ArrowUp` 移动高亮项的索引。
> - 监听 `Home` / `End` 跳转到首项或末项。
> - 监听 `Enter` / `Space` 选中当前项。
> - 监听 `Escape` 关闭弹层。

开发者只需将这些事件处理函数通过 Prop Getters 绑定到对应的 DOM 元素上，无需自己手写复杂的 `keydown` 逻辑。

# 高级

## 设计Toast（通知）组件

**一、定义**

> 偏命令式的无头组件设计、状态管理架构。

**二、实现**

Toast 与常规表单组件不同，通常是命令式触发的。设计思路如下：

> 1. **状态管理引擎**：创建一个单例的 ToastStore，维护一个队列（数组）。
> 2. **命令式 API**：暴露 `toast.show()`, `toast.error()` 等方法，内部更新 Store。
> 3. **渲染层**：提供 `<ToastContainer />` 组件，它订阅 Store 的变化，并通过 React Portal 渲染到 `document.body`。
> 4. **无头化**：`ToastContainer` 不提供样式，而是提供类似 `toastList.map(t => render(t))` 的 Render Props，让用户自定义 Toast 的外观，并处理入场/出场动画状态。

## 无头库按需渲染和性能优化

**一、定义**

> 无头库(如 表格库TanStack Table)在海量数据下的性能瓶颈处理。

**二、实现**

> 1. **状态与视图解耦**：TanStack Table 将状态维护在内存实例中，只有当开发者调用 `row.getCell()` 时才去计算具体的单元格值，不强制要求一次性生成完整 VDOM。
> 2. **虚拟化集成**：无头库本身不渲染 DOM，因此可以完美对接如 `react-virtual` 等虚拟列表库。开发者只把可见区域的 Rows 渲染出来。
> 3. **选择器记忆化**：利用 `useMemo` 确保只有当相关 state（如排序字段、当前页码）变化时，才重新计算派生数据（如过滤后的行、分页后的行）。
> 4. **不可变数据流**：保证传入的数据引用未变时不触发重计算。

## 在 SSR的挑战

**一、定义**

> 同构应用中的无头库表现。

**二、挑战**

> SSR 时没有真实的 DOM，因此涉及 DOM 测量（如 `getBoundingClientRect` 用于定位 Popover/浮层）、焦点管理、`window` 对象访问等逻辑都会报错或在服务端和客户端产生水合不匹配。

**三、解决方案**

> 1. **状态延迟初始化**：在组件挂载前，浮层定位相关的状态保持默认值，在 `useEffect`（客户端执行）中再计算真实坐标。
> 2. **环境检测**：内部封装 `isClient` 判断，SSR 阶段跳过 `addEventListener` 等副作用。
> 3. **浮层方案替代**：使用基于 CSS 的浮层方案（如 CSS Anchor Positioning 或纯依赖视口的 Fixed 定位）替代依赖 JS 宽高计算的绝对定位，减少 SSR 阶段的计算量。

## Compound Components(复合组件)模式与 Headless UI

**一、定义**

>  组件设计模式的高阶认知。

**二、具体解析**

> - **复合组件模式**：通过 `Context` 共享状态，允许开发者以声明式的方式组装子组件（如 `<Select><Select.Trigger/><Select.Option/></Select>`）。
> - **关系**：Headless UI 通常以复合组件的形式呈现（如 `@headlessui/react`）。复合组件负责管理内部状态和 Context 分发，而 Headless 理念负责保证这些组件不自带任何 CSS。
> - **配合优势**：这种结合既提供了极佳的 API 语义化体验，又保留了完全的样式定制权，同时内部通过 Context 传递状态和 a11y 属性，避免了 Prop Drilling（属性透传）的繁琐。
