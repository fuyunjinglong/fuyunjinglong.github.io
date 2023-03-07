---
title: 自动化测试
date: 2022-05-04 06:33:16
categories:
- H_工程热点
toc: true # 是否启用内容索引
---

# 自动化测试

## 思想先行

**TDD：Test-Driven Development（测试驱动开发）**

> TDD 则要求在编写某个功能的代码之前先编写测试代码，然后只编写使测试通过的功能代码，通过测试来推动整个开发的进行

**BDD：Behavior-Driven Development（行为驱动开发）**

> BDD 可以让项目成员（甚至是不懂编程的）使用自然语言来描述系统功能和业务逻辑，从而根据这些描述步骤进行系统自动化的测试

## 为什么要测试？

- 提高代码质量
- 准确定位问题
- 方便迭代/重构
- 最大程度保证产品符合预期
- 减少回归流程
- 提升开发者信心和安全感

## 测试类型有哪些？

- **单元测试（Unit Test）**
- **集成测试（Integration Test）**
- **UI 测试（UI Test）**

**单元测试（Unit Test）**

> 单元测试是最容易实现的：代码中多个组件共用的工具类库、多个组件共用的子组件等。
>
> **通常情况下，在公共函数/组件中一定要有单元测试来保证代码能够正常工作。单元测试也应该是项目中数量最多、覆盖率最高的。**
>
> 能进行单元测试的函数/组件，一定是低耦合的，这也从一定程度上保证了我们的代码质量。

**集成测试（Integration Test）**

> 集成测试通常被应用在：耦合度较高的函数/组件、经过二次封装的函数/组件、多个函数/组件组合而成的函数/组件等。
>
> 集成测试的目的在于，测试经过单元测试后的各个模块组合在一起是否能正常工作。会对组合之后的代码整体暴露在外接口进行测试，查看组合后的代码工作是否符合预期。

**UI 测试（UI Test）**

> UI 测试（UI Test）只是对于前端的测试，是脱离真实后端环境的，仅仅只是将前端放在真实环境中运行，而后端和数据都应该使用 Mock 的。
>
> UI 测试（UI Test）更贴近于我们的开发流程。在前后端分离的开发模式中，前端开发通常会使用到 Mock 的服务器和数据。因而我们需要在开发基本完成后进行相应的 UI 测试（UI Test）。
>
> UI 测试的自动化程度还不高，大多数还依赖于手工测试。
>
> 在一些自动化测试工具中有创建快照的功能，也能帮助我们在一定程度上实现 UI 测试（UI Test）的自动化。

## 哪些项目适合自动化测试？

大部分的开发都会觉得：需求这么多，这么紧急，保证完成需求都已经非常困难了，已经没精力再编写测试代码了。

现实中，我们经常会针对一些活动开发一些一次性的代码模块，这样的代码模块功能简单，且后续继续迭代的可能性低，这种代码就完全没有必要引入自动化测试工具。

**适合引入自动化测试的场景：**

1. 公共库类的开发维护
2. 中长期项目的迭代/重构
3. 引用了不可控的第三方依赖

这些场景是需要引入自动化测试来对现有代码进行约束的。**尤其是中长期项目，迭代/重构时人力回归困难，自动化测试就显得尤为重要！**

## 测试工具有哪些？

- 单元测试（Unit Test）有 Mocha, Ava, Karma, Jest, Jasmine 等。
- 集成测试（Integration Test）和 UI 测试（UI Test）有 ReactTestUtils, Test Render, Enzyme, React-Testing-Library, Vue-Test-Utils 等。

**Mocha**

> Mocha 是生态最好，使用最广泛的单测框架，但是他需要较多的配置来实现它的高扩展性。

**Ava**

> Ava 是更轻量高效简单的单测框架，但是自身不够稳定，并发运行文件多的时候会撑爆 CPU。

**Jasmine**

> Jasmine 是单测框架的“元老”，开箱即用，但是异步测试支持较弱。

**Jest**

> Jest 基于 Jasmine, 做了大量修改并添加了很多特性，同样开箱即用，但异步测试支持良好。

**Karma**

> Karma 能在真实的浏览器中测试，强大适配器，可配置其他单测框架，一般会配合 Mocha 或 Jasmine 等一起使用。

每个框架都有自己的优缺点，没有最好的框架，只有最适合的框架。

Vue和React 的默认测试框架是 Jest，Augular 的默认测试框架就是 Karma + Jasmine

## 测试工具对比

- 单元测试（Unit Test）有 Mocha, Ava, Karma, Jest, Jasmine 等
- 集成测试（Integration Test）和 UI 测试（UI Test）有 ReactTestUtils, Test Render, Enzyme, React-Testing-Library, Vue-Test-Utils 等

1. 提供**测试结构**：[Mocha](https://mochajs.org/), [Jasmine](http://jasmine.github.io/), [Jest](https://facebook.github.io/jest/), [Cucumber](https://github.com/cucumber/cucumber-jshttps://github.com/cucumber/cucumber-js)
2. 有**断言**测试：[Chai](http://chaijs.com/), [Jasmine](http://jasmine.github.io/), [Jest](https://facebook.github.io/jest/), [Unexpected](http://unexpected.js.org/)
3. 生成、**展示和监控**测试结果：[Mocha](https://mochajs.org/), [Jasmine](http://jasmine.github.io/), [Jest](https://facebook.github.io/jest/), [Karma](https://karma-runner.github.io/)
4. 通过对比生成的组件和数据结构的快照，确保更改是来自前一次运行的：[Jest](https://facebook.github.io/jest/), [Ava](https://github.com/avajs/ava)
5. 提供 **Mocks、Spies 和 Stubs**：[Sinon](http://sinonjs.org/), [Jasmine](http://jasmine.github.io/), [enzyme](http://airbnb.io/enzyme/docs/api/), [Jest](https://facebook.github.io/jest/), [testdouble](https://github.com/testdouble/testdouble.js)
6. 生成**代码覆盖**报告：[Istanbul](https://gotwarlost.github.io/istanbul/), [Jest](https://facebook.github.io/jest/), [Blanket](http://blanketjs.org/)
7. 提供一个**浏览器或类浏览器环境**，并提供接口可以控制它们的执行场景：[Protractor](http://www.protractortest.org/)**,** [Nightwatch](http://nightwatchjs.org/), [Phantom](http://phantomjs.org/)**,** [Casper](http://casperjs.org/)

**主流工具比较**

| 框架    | 断言                 | 仿真                 | 快照                 | 异步测试             |
| ------- | -------------------- | -------------------- | -------------------- | -------------------- |
| Mocha   | 默认不支持，可配置   | 默认不支持，可配置   | 默认不支持，可配置   | 友好                 |
| Ava     | 默认支持             | 不支持，需第三方配置 | 默认支持             | 友好                 |
| Jasmine | 默认支持             | 默认支持             | 默认支持             | 不友好               |
| Jest    | 默认支持             | 默认支持             | 默认支持             | 友好                 |
| Karma   | 不支持，需第三方配置 | 不支持，需第三方配置 | 不支持，需第三方配置 | 不支持，需第三方配置 |

**Mocha**

- Mocha 是生态最好，使用最广泛的单测框架，但是他需要较多的配置来实现它的高扩展性。

**Ava**

- Ava 是更轻量高效简单的单测框架，但是自身不够稳定，并发运行文件多的时候会撑爆 CPU

**Jasmine**

- Jasmine 是单测框架的“元老”，开箱即用，但是异步测试支持较弱。

**Jest**

- Jest 基于 Jasmine, 做了大量修改并添加了很多特性，同样开箱即用，但异步测试支持良好。
- jest⾃自带覆盖率，如果⽤用的 mocha，需要使⽤用 istanbul来统计覆盖率。（所以我推荐jest）

**Karma**

- Karma 能在真实的浏览器中测试，强大适配器，可配置其他单测框架，一般会配合 Mocha 或 Jasmine 等一起使用。

Augular 的默认测试框架就是 Karma + Jasmine，而 React 的默认测试框架是 **Jest**。

**React/Vue 官方推荐的单元测试工具都是 Jest**

# 测试覆盖率

按照上面的测试用例跑一轮，测试覆盖率肯定是 100% 的，这是在简单组件上测试才有这样的效果。

事实上在实际应用当中，测试覆盖率很难达到 100%，能够达到百分之八九十就已经是很高的覆盖率了。

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