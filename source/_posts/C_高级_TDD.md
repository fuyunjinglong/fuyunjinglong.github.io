---
title: TDD
date: 2000-01-01 06:33:16
categories:
- C_高级
toc: true # 是否启用内容索引
---

# 测试模式

比如顶流框架：Vue,React,Element,Echarts

开发模式：Test-last（后置测试）与TDD（测试驱动开发）

三维保障：TestHost 绑定驱动 + Harness 交互验证 + 因果断言强制

# 测试分类

- 单元测试：Vitest（Vue/Vite生态首选）与 Jest（React经典）
- 组件/集成测试：@vue/test-utils，React Testing Library，以及Cypress/Playwright的组件测试模式
- E2E（端到端）测试：Playwright（微软出品，跨浏览器并行）与Cypress（SPA友好）

**E2E最佳实践**

> - 模板式生成(CAPPortal Website)：配置驱动(Deep-Engine/Rules)。采用Vitest + JSDOM进行HTTP Mock测试
> - 知识库式生成(CB)

# TDD

个人推荐：

- 建议开发功能函数库使用 TDD 方案；
- 建议开发业务系统使用 BDD 方案；

## TDD与BDD

- TDD:**侧重点偏向开发**，通过测试用例来规范约束开发者编写出质量更高、bug更少的代码
- BDD:**侧重设计**，其要求在设计测试用例的时候对系统进行定义，倡导使用通用的语言将系统的行为描述出来，将系统设计和测试用例结合起来，从而以此为驱动进行开发工作。

## 定义

TDD （Test Driven Development）**TDD 专指 UTDD（Unit Test Driven Development），即 「单元测试驱动开发」**。

> 误解
>
> TDD = XP 的测试优先原则 + 重构，认为 TDD 只是通过单元测试来推动代码的编写，然后通过重构来优化程序的内部结构。这很容易被理解成只需要先写单元测试就可以驱动出高质量的代码

> Kent Beck：“测试驱动开发不是一种测试技术。它是一种分析技术、设计技术，更是一种组织所有开发活动的技术”。

**分析技术：** 体现在对问题域的分析，当问题还没有被分解成一个个可操作的任务时，分析技术就派上用场，例如需求分析、任务拆分和任务规划等，《实例化需求》这本书可以给予一定的帮助作用。

**设计技术：** 测试驱动代码的设计和功能的实现，然后驱动代码的再设计和重构，在持续细微的反馈中改善代码。

**组织所有开发活动的技术：** TDD 很好地组织了测试、开发和重构活动，但又不仅限于此，比如实施 TDD 的前置活动包括需求分析、任务拆分和规划活动，这使得 TDD 具有非常好的扩展性。

## TDD原则

两条规则：

- **仅在自动测试失败时才编写新代码**
- **消除重复设计（去除不必要的依赖关系），优化设计结构（逐渐使代码一般化**

> 第一条规则指每次**只编写刚刚好使测试通过的代码，并且只在测试运行失败的时候才编写新的代码**，因为每次增加的代码少，即使有问题定位起来也非常快。
>
> 第二条规则指**在自动化测试的支撑下，通过重构环节消除代码的坏味道来避免代码日渐腐烂，为接下来编码打造一个舒适的环境**

## TDD口号

1. 不可运行——写一个功能最小完备的单元测试，并使得该单元测试编译失败。
2. 可运行——快速编写刚刚好使测试通过的代码，不需要考虑太多，甚至可以使用一些不合理的方法。
3. 重构——消除刚刚编码过程引入的重复设计，优化设计结构。

## TDD好处

- 控制编程过程中的忧虑感：当感觉压力越大，就越不想去做足够多的测试，对代码越不自信
- 把控编程过程中的反馈与决策之间的差距

> 如果我做了一周的规划，并且量化成一个个可操作的任务写到 to-do list，然后使用测试驱动编码，把完成的任务像这样划掉，那么我的工作目标将变得非常清晰，因为我明确工期，明确待办事项，明确难点，可以在持续细微的反馈中有意识地做一些适当的调整，比如添加新的任务，删除冗余的测试；还有一点更加让人振奋，我可以知道我大概什么时候可以完工。项目经理对软件开发进度可以更精确的把握。

## TDD的难点

- 缺乏软件质量意识

- 缺乏一定程度的程序设计能力，很难设计出高内聚低耦合、意图清晰的结构和代码。

- 缺乏分析需求并进行任务分解和规划的能力，很容易在还没开始 TDD 的时候就被打乱了节奏。

- 缺乏合适的测试环境和测试规范。

- 测试优先的习惯难以养成。

- 重构手法不熟练。

## 参考

- [测试驱动开发（TDD）总结——原理篇](https://juejin.cn/post/6844903780970921991#heading-0)

- [三角法](https://link.juejin.cn/?target=http%3A%2F%2Ffeelings-erased.blogspot.com%2F2013%2F03%2Fthe-two-main-techniques-in-test-driven.html)
- [推行TDD的思考——张逸](https://link.juejin.cn/?target=http%3A%2F%2Fagiledon.github.io%2Fblog%2F2013%2F12%2F25%2Fthought-about-applying-tdd%2F)
- [TDD(测试驱动开发)培训录-破狼](https://link.juejin.cn/?target=https%3A%2F%2Fwww.cnblogs.com%2Fwhitewolf%2Fp%2F4205761.html)

# TDD-JEST

[官网](https://jestjs.io/zh-Hans/docs/getting-started)



# TDD-Vue

## Vue测试策略

|   架构层级   | 测试内容                                                     | 测试策略                                                     | 解释                                                         |
| :----------: | :----------------------------------------------------------- | :----------------------------------------------------------- | :----------------------------------------------------------- |
|  action 层   | 1. 是否获取了正确的参数 2. 是否正确地调用了 API 3. 是否使用了正确的返回值存取回 Vuex 中 4. 业务分支逻辑 5. 异常逻辑 | 这五个业务点建议 100% 覆盖                                   | 这个层级主要包含前述 5 大方面的业务逻辑，进行测试很有重构价值 |
| mutation 层  | 是否正确完成计算                                             | 有逻辑的 mutation 要求 100%覆盖率                            | 这个层级输入输出明确，又包含业务计算，非常适合单元测试       |
|  getter 层   | 是否正确完成计算                                             | 有逻辑的 getter 要求 100%覆盖率                              | 这个层级输入输出明确，又包含业务计算，非常适合单元测试       |
| component 层 | 是否渲染了正确的组件                                         | 1. 组件的分支渲染逻辑要求 100%覆盖 2. 交互事件的调用参数一般要求 100%覆盖 3. 连接 vuex store 的容器组件不测 4.渲染出来的UI不测 | 这个层级最为复杂，还是以「代价最低，收益最高」为指导原则进行 |
|    UI 层     | 组件是否渲染了正确的样式                                     | 1. 纯 UI 不测 2. CSS 不测                                    | 这个层级以我目前理解来说测试较难稳定，成本又较高             |
|   utils 层   | 各种辅助工具函数                                             | 没有副作用的必须 100% 覆盖                                   |                                                              |

Component 层，遵循以上的两测两不测原则

- 展示型业务组件
- 容器型业务组件
- 通用 UI 组件
- 功能型组件

## Vue Test Utils

- [Vue测试实战](https://lmiller1990.github.io/vue-testing-handbook/zh-CN/#%E8%BF%99%E6%9C%AC%E6%8C%87%E5%8D%97%E6%98%AF%E4%BB%80%E4%B9%88%EF%BC%9F)

- [Vue Test Utils实战](https://v1.test-utils.vuejs.org/zh/)

- [使用 TDD 开发组件 --- Notification](https://juejin.cn/post/6844904013503152141#heading-19)
- [【element3-开发日记】手摸手教你重写 Button 组件](https://juejin.cn/post/6898959238576472077#heading-0)

# 测试解决方案落地

## 单元测试从 Jest 到 Karma+Mocha+Chai

引子：Jest 的运行环境是 JSDOM，一个伪 DOM 引擎。JSDOM 不能理解 DOM 的布局，尺寸，样式，以及浏览器的高级 API，例如 `ResizeObserver`，`matchMedia()`。我们无法在代码中避免使用它们，于是只能去 Mock 很多东西。结果，我们欺骗了我们自己写的测试。即使你达成了 100% 测试覆盖，所有测试用例都通过，还是会怀疑代码是否在真实环境中会出错…更不要提浏览器兼容性测试了。

Karma 是 Google 开发的测试运行工具。当人们无法忍受太多 Mock，他们通常会转投 Karma 然后发现它真香！你不需要再 Mock 浏览器的特性，便可获得更真实的测试结果，甚至能做浏览器兼容性测试。更重要的是，从 Jest 到 Karma 的迁移并不难。

Karma 不能单独使用。你至少需要一个测试框架（例如 Mocha）和一个断言库（例如 Chai）。

**两种工具集对比**

| Karma 系                          | Jest 系                       |                              |
| --------------------------------- | ----------------------------- | ---------------------------- |
| 测试运行环境 Test Runtime         | Chrome/Firefox/Safari/Edge/IE | JSDOM + Node.js              |
| 代码转译器 Transpiler             | TypeScript                    | TypeScript                   |
| 测试运行工具 Test Runner          | Karma                         | Jest                         |
| 测试框架 Test Framework           | Mocha/Jasmine                 | Jest                         |
| 断言库 Assertion Library          | Chai/Expect.js                | Jest                         |
| React 测试工具 React Test Utility | Enzyme/React-Testing-Library  | Enzyme/React-Testing-Library |

## 鱼与熊掌

**单元测试和集成测试选择：**

*简而言之，如果你是想踏出测试的第一步，或者想为大型项目配备足以快速上手的框架，建议使用 **Jest**。
想要灵活性高可扩展性好，那就用 **Mocha**。
想再简单点，就用 **Ava**。
想做底层的测试，用 **tape**。*

**UI测试选择：**

*简而言之，如果你想立刻着手在多个运行环境下尝试下功能测试，想要一个 all-in-one 的工具，试试 **TestCafe**。
如果你希望测试流程完整，还有强大的社区支持。**WebdriverIO** 是个不错的选择。* *如果不需要测试跨浏览器的支持性，推荐使用 **Puppeteer**。
如果你的应用没有复杂的界面和交互逻辑，比如一个全是表单和导航的系统。换言之，是相对较容易测试de的场景。可以使用 headless 浏览器工具，比如 **Casper**，高效完成测试。*

# Vitest

## 问题汇总

**vue3源码-Vitest单元debug报错解决**

参考：

> - [debug报错方案](https://vitest.dev/config/#environmentmatchglobs)
> - [vitest与单元测试](https://www.cnblogs.com/keatkeat/p/17593475.html)

