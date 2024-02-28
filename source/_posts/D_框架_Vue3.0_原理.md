---
title: Vue3.0_原理
date: 2023-09-12 07:33:16
categories:
- D_框架和类库
toc: true # 是否启用内容索引
---

# 入门

## 生命周期

![](/img/vue3生命周期.png)

> setup() :开始创建组件之前，在beforeCreate和created之前执行。创建的是data和method
> onBeforeMount() : 组件挂载到节点上之前执行的函数。
> onMounted() : 组件挂载完成后执行的函数。
> onBeforeUpdate(): 组件更新之前执行的函数。
> onUpdated(): 组件更新完成之后执行的函数。
> onBeforeUnmount(): 组件卸载之前执行的函数。
> onUnmounted(): 组件卸载完成后执行的函数
> onActivated(): 被包含在中的组件，会多出两个生命周期钩子函数。被激活时执行。
> onDeactivated(): 比如从 A 组件，切换到 B 组件，A 组件消失时执行。
> onErrorCaptured(): 当捕获一个来自子孙组件的异常时激活钩子函数。

| Vue2          | Vue3               |
| ------------- | ------------------ |
| beforeCreate  | ❌setup(替代)       |
| created       | ❌setup(替代)       |
| beforeMount   | onBeforeMount      |
| mounted       | onMounted          |
| beforeUpdate  | onBeforeUpdate     |
| updated       | onUpdated          |
| beforeDestroy | onBeforeUnmount    |
| destroyed     | onUnmounted        |
| errorCaptured | onErrorCaptured    |
|               | 🎉onRenderTracked   |
|               | 🎉onRenderTriggered |

**新增的钩子函数onRenderTracked()和 onRenderTriggered()**

onRenderTracked()

> 直译过来就是`状态跟踪`，它会跟踪页面上所有响应式变量和方法的状态。只要页面有`update`的情况，他就会跟踪，然后生成一个`event`对象。

onRenderTriggered()

> 直译过来是`状态触发`，它不会跟踪每一个值，而是给你变化值的信息，并且新值和旧值都会给你明确的展示出来。 与`watch`相似。
>
> event 对象属性的详细介绍：
>
> - key 那边变量发生了变化
> - newValue 更新后变量的值
> - oldValue 更新前变量的值
> - target 目前页面中的响应变量和函数

**实际开发中如何使用**

>  beforecreate : 可以在这函数中初始化加载动画
>  created ：做一些数据初始化，实现函数自执行
>  mounted： 调用后台接口进行网络请求，拿回数据，配合路由钩子做一些事情
>  destoryed ：当前组件已被删除，清空相关内容
>  mounted中做网络请求和重新赋值，在destoryed中清空页面数据。

**单组件**

> 页面首次加载
>
> ```
> setup -> onBeforeMount -> onRenderTracked -> onMounted
> ```
>
> 页面更新
>
> ```
> onRenderTriggered -> onBeforeUpdate -> onUpdated
> ```
>
> 页面卸载
>
> ```
> onBeforeUnmount -> onUnmounted
> ```

## **父子组件生命周期更新顺序**

> **页面首次加载**
>
> ```
> 父组件setup -> 父组件onBeforeMount -> 父组件onRenderTracked -> 子组件setup -> 子组件onBeforeMount -> 子组件onRenderTracked -> 子组件onMounted -> 父组件onMounted
> ```
>
> **页面更新**
>
> 纯父组件属性更新 `onRenderTriggered -> onBeforeUpdate -> onUpdated`
>
> 纯子组件属性更新 `onRenderTriggered -> onBeforeUpdate -> onUpdated`
>
> 父组件属性更新，该属性在子组件中有被使用 `父组件onRenderTriggered -> 父组件onBeforeUpdate -> 子组件onBeforeUpdate -> 子组件onUpdated -> 父组件onUpdated`
>
> 子组件属性更新，该属性在父组件中有被使用 `子组件onRenderTriggered -> 父组件onRenderTriggered -> 父组件onBeforeUpdate -> 子组件onBeforeUpdate -> 子组件onUpdated -> 父组件onUpdated`
>
> **页面卸载**
>
> ```
> 父组件onBeforeUnmount -> 子组件onBeforeUnmount -> 子组件onUnmounted -> 父组件onUnmounted
> ```

## 生命周期

![](/img/vue3生命周期.png)

## Proxy是代理，Reflect是干嘛用的？

准确讲应该是这样的，Reflect更像是一种语法变体，其挂在的所有方法都能找到对应的原始语法，也就是Reflect的替代性非常强。

比较常用的两个方法就是`get()`和`set()`方法：

```
Reflect.get(target, propertyKey)
Reflect.set(target, propertyKey, value)
```

等效于

```
target[propertyKey]
target[propertyKey] = value;
```

Reflect对象经常和Proxy代理一起使用，原因有三点：

1. Reflect提供的所有静态方法和Proxy第2个handle参数方法是一模一样的。
2. Proxy get/set()方法需要的返回值正是Reflect的get/set方法的返回值，可以天然配合使用，比直接对象赋值/获取值要更方便和准确(通过返回值知道是否赋值成功，并不会因为报错而中断正常代码执行)。
3. receiver参数具有不可替代性。

**关于receiver参数**

receiver是接受者的意思，表示调用对应属性或方法的主体对象，通常情况下，receiver参数是无需使用的，但是如果发生了继承，为了*明确调用主体*，receiver参数就需要出马了。

```
let miaoMiao = {
  _name: '疫苗',
  get name () {
    return this._name;
  }
}
let miaoXy = new Proxy(miaoMiao, {
  get (target, prop, receiver) {
    return target[prop];
  }
});

let kexingMiao = {
  __proto__: miaoXy,
  _name: '科兴疫苗'
};

// 结果是疫苗
console.log(kexingMiao.name);
```

实际上，这里预期显示应该是“科兴疫苗”，而不是“疫苗”。

这个时候，就需要使用`receiver`参数了，代码变化部分参见下面标红的那一行：

```
return Reflect.get(target, prop, receiver);
// 也可以简写为 Reflect.get(...arguments) 
```

# 进阶

## Vue3存在的问题

**参考**

- [Vue3的漏洞](https://www.vue-js.com/topic/61e622a4cbbfd1003b11fa19)

- 丢失响应性
- Vue3的TypeScript对类型的支持十分孱弱

**一、丢失响应性**

vue3还存在着很多问题 例如对ts支持不够友好 ref.value的混乱 解构丢失响应性（不知道有啥好的实践,目前是使用计算属性） 从体验上远不如vue2 目前个人认为最完善的库是solidjs 可惜生态没跟上来 可能对大家而言react vue并不是最好的解 react一个useeffct官网花6篇文章来描述这个api 我真是笑了 总而言之react vue3写起来不是很润。

你没有发现吗?Vue团队是为了补坑而补坑,Vue2的ref仅仅是引用组件而已,而在Vue3变成了定义响应式变量,这一点我估计是参考了react,但react的运行机制与vue不同,react的ref是定义一个引用,避免组件重新渲染值被重置。

vue3对ts的支持挺不错了，毕竟本身就是用ts写的，模板对ts的支持可能比较弱。
解构这个绕不过去，不是vue3的问题，原生js就是那样，除非魔改，但是魔改的好几版提案都没落地。
只能说各有取舍吧。

**二、Vue3的TypeScript对类型的支持十分孱弱**

参考：[为什么我感觉 Vue 3 TypeScript 还是不行？](https://www.zhihu.com/question/453332049)

几个问题：

1. option props define 的方式定义非常不灵活，这种值定义的思想意味着你必须要用值来定义类型，而不是利用类型来指导值应该长什么样，因此 vue 3 整体的类型设计不得不遭受了这个思想的严重毒害，不得不设计的很复杂（具体详见其 d.ts 实现）
2. 值指导类型下不得不引入 ExtractPropTypes 来将 props 值定义转为类型定义，但 vue 没有提供 ExtractPropTypes 的逆运算，导致在定义共有 props 组件 (props 继承) 的时候十分难受
3. defineComponent 不支持泛型；有个 hack 手段是包一层函数 wrapper来引入泛型，不过这样有运行时开销
4. 应我看就应该取缔 SFC .vue 组件，这东西太反类型了，而且容易造成一个 vue 文件几千行的问题，有悖 VCA 所声称的组合优于继承的设计目标；或者说社区可以考虑去推动 ts 支持自定义文件后缀的 type loader （这样也可以解决 .pb 文件的类型问题）
5. 写惯了 React 的来看 vue tsx 会感觉 slots 的设计很奇怪 ... 直接将 props 下的字段作为 slots 使用不是更符合直觉？感觉 vue props 整体的设计完全是 react prop 的子集 ...
6. **emit、onXxx、vModel 等框架基础概念的类型做得很差, 用过的都懂, 太难受了**

Vue 3 还是不够激进（真要激进了我感觉 Vue 就成 React With Reactive Object 了）

> 尤大的回答：
>
> Props 值定义确实是一个兼容性导致的包袱。但是在 <script setup> 下已经支持直接用 defineProps<{...}> 类型声明 props 了（自动编译为对应的值声明）。tsx 下也有方案在讨论。
>
> sfc 的 TS IDE 支持请用 <script setup lang="ts"> + vscode + volar。volar 最近几个月很多改进，我个人用已经跟 tsx 感觉没太大差别了。配套的有 vue-tsc 可以做命令行检查。
>
> 有了 VCA 还能写几千行的 SFC 组件那就纯粹是人的问题了，VCA 抽取逻辑跟纯 JS/TS 文件没什么区别，一个 TS 文件也能写几千行（几万行的 checker.ts 不也有么
>
> tsx 本质上是 ts 团队给开了后门直接把 tsx 的推导做进了 ts 本身。ts 如果愿意开档更加完整的 plugin 机制，所有基于模板的框架的类型支持也不至于需要绕那么多弯子，然而 ts 团队怕增加维护成本不肯开。不管怎么说 vue 和 svelte 现在通过各种 hack 也算是做出来了基本完整的模板 ts 支持。
>
> 模板在性能这块吊打 tsx，在 IDE 支持抹平了的前提下用 tsx 本质上是在为了开发者的偏好牺牲用户体验的性能（性能没遇到瓶颈就无所谓）
>
> 这边自己不维护框架的人吐槽吐槽我也能理解，毕竟作为使用者只需要考虑自己爽不爽。作为维护者，Vue 的已有的用户习惯、生态和历史包袱摆在那里，能激进的程度是有限的，Vue 3 的大部分设计都是戴着镣铐跳舞，需要做很多折衷。如果真要激进还不如开个新项目，或者没人用的玩票项目，想怎么设计都可以。
>
> 组件泛型的问题也有不少人提出了，这个目前确实不行，但不表示以后不会有。
>
> 最后实话实说，所有前端里面像这个问题下面的类型体操运动员们毕竟是少数，绝大部分有 intellisense + 类型校验就满足需求了。真的对类型特别特别较真的用 React 也没什么不好，无非就是性能差点。

> 松若章的回答：
>
> 1. 我觉得 props 的问题很大程度上是兼容性包袱导致的，在 Vue 组件的 prop resolve 的过程里，如果没有大量编写经验其实很难记清楚每种配置会 [resolve](https://www.zhihu.com/search?q=resolve&search_source=Entity&hybrid_search_source=Entity&hybrid_search_extra={"sourceType"%3A"answer"%2C"sourceId"%3A1835420993}) 什么值。同时这些动态 resolve prop 的过程也对类型的编写造成了很多麻烦，即使在现在的版本，setup 函数中 props 的[静态类](https://www.zhihu.com/search?q=静态类&search_source=Entity&hybrid_search_source=Entity&hybrid_search_extra={"sourceType"%3A"answer"%2C"sourceId"%3A1835420993})型和 runtime 的实际表现都有不小的偏差。如果未来这些不一致可以全部修复的话倒也不算什么大问题了
>
> 2. 定义共有 props 组件我觉得问题不是很大，只是相比于 React 在 interface 的层面就能共享，Vue 目前必须通过[展开运算符](https://www.zhihu.com/search?q=展开运算符&search_source=Entity&hybrid_search_source=Entity&hybrid_search_extra={"sourceType"%3A"answer"%2C"sourceId"%3A1835420993})才能解决。
>
>    我想提一下的是 ExtractPropTypes 的另一个问题，这个工具类型提取出来的其实是用于 setup 函数的 props 而不是外界传入的 props，这实际上对于类型的使用造成了一些阻碍。在 prop 没有 [required](https://www.zhihu.com/search?q=required&search_source=Entity&hybrid_search_source=Entity&hybrid_search_extra={"sourceType"%3A"answer"%2C"sourceId"%3A1835420993}) 的情况下需要使用 `Partial<ExtractPropTypes<typeof xxxProps>>` 才能给出实际外部的 props 的类型。
>
> 3. 针对于组件 props 的泛型，目前似乎没啥好办法，我也很头大，只能采取比泛型更松的类型约束。[泛型类](https://www.zhihu.com/search?q=泛型类&search_source=Entity&hybrid_search_source=Entity&hybrid_search_extra={"sourceType"%3A"answer"%2C"sourceId"%3A1835420993})型对于[业务组件](https://www.zhihu.com/search?q=业务组件&search_source=Entity&hybrid_search_source=Entity&hybrid_search_extra={"sourceType"%3A"answer"%2C"sourceId"%3A1835420993})的编写可能不算特别常用，但是对于底层组件的编写其实非常重要。详见：
>
> 4. 取缔 SFC 组件有点过于激进了，有点因噎废食的感觉。如果工具链能成熟多数场景下是可以使用 SFC 来编写的，既维持模板的优点也带有类型检查。当然前提是工具链能成熟，包含 vscode 的插件、类似 tsc --noEmit 的[命令行](https://www.zhihu.com/search?q=命令行&search_source=Entity&hybrid_search_source=Entity&hybrid_search_extra={"sourceType"%3A"answer"%2C"sourceId"%3A1835420993})类型检查，正确的 dts 文件生成。在年初的时候我尝试过 [vuedx](https://www.zhihu.com/search?q=vuedx&search_source=Entity&hybrid_search_source=Entity&hybrid_search_extra={"sourceType"%3A"answer"%2C"sourceId"%3A1835420993})、volar，vuedx 会让我的 vscode 卡死，volar 总有类型提示存在问题，发现不太能适应我的开发场景。但是 ts 不能不上，最后我把一个 .vue 的组件库用 .tsx 重写了
>
> 5. slots 的位置确实有放到 props 的可能，毕竟它的机制和 [render props](https://www.zhihu.com/search?q=render props&search_source=Entity&hybrid_search_source=Entity&hybrid_search_extra={"sourceType"%3A"answer"%2C"sourceId"%3A1835420993}) 非常像，但是我个人觉得放到 prop 里面会导致 tsx 更加难看，因为 [vue3](https://www.zhihu.com/search?q=vue3&search_source=Entity&hybrid_search_source=Entity&hybrid_search_extra={"sourceType"%3A"answer"%2C"sourceId"%3A1835420993}) 的组件全量使用了函数 slot，不允许数组作为组件 children，在嵌套组件时候和别的 prop 会混起来，这两种风格可能大家各有喜好。
>
> 6. 我在 vue3 从没使用过 [emits](https://www.zhihu.com/search?q=emits&search_source=Entity&hybrid_search_source=Entity&hybrid_search_extra={"sourceType"%3A"answer"%2C"sourceId"%3A1835420993})，实际上也非常建议不要允许 emits 属性在生产环境的使用，我相信这个选项留着更多的还是为了兼容性的问题。vModel 本身是个语法糖，类型支持如何完全取决于对 props 的类型支持，只能等着插件逐步完善了。至于对 onXxx 的支持，确实比 React 要弱一些，我觉得目前只能说达到基本可用的状态，由于 Vue 采取了原生事件，原生事件的类型没有对于 target 的泛型，对于事件的支持不如 React 一整套重写的事件类型也是情理之中。
>
>    总的来说 Vue3 的 typescript 支持在 TSX 的情境下其实是可以有不错的体验的（但是离 React 还有不小的差距）。但是模板之下，就看工具链是否给力了，还是希望 Vue 在 SFC 情况下的类型体验能早日达到 TSX 的程度。

## vue3代码实践建议

**Typescript**

TS严格模式：使用TS时，要开启tsconfig中的严格模式，如果关闭严格模式，类型检查的效果将大打折扣

避免AnyScript：使用TS时要进行严格的类型声明，避免过多的any，因为使用any将失去类型检查，如果实在难以描述类型，则可以考虑使用unknow。TS项目中如果存在很多的any，不如抛弃TypeScript

不要保留报错：各类报错通常是用来处理`边界情况`的，这正是此类报错存在的意义，需要重视并解决。有时候开发者会比TS更清楚数据的类型，此时一些不必要的类型报错可以通过`类型断言`解决。重视并解决所有报错可以为代码提供更好的`健壮性`

**代码建议**

- 规范、明确的命名： 在命名变量或函数时，名称应该尽可能的明确它的作用/功能，不要使用缩写特别是拼音缩写，这将导致代码可读性严重下降，复杂变量/方法使用注释进行注解
- 积极使用新的ES语法：包括可选链操作符(?.)、解构、剩余参数语法、空值合并运算符(??)等，合理地使用它们将有效地提高代码可读性
- 合理的代码组织：单个函数中，一些相关的函数内容写在一起可以有效的规范代码结构，在某个代码块比较复杂时，还可以提取为一个函数置于函数后部，前半部分仅`保留核心逻辑`，可以有效提升代码可读性。在VUE组件中也是类似的逻辑
- 语义化代码：在编写代码时，调用各类JSAPI时，应该注重`语义化`，比如要对数组进行某种批处理，就使用Array.map而不是使用Array.forEach或其他循环方式然后配合外部创建的另一个空数组进行处理。要实现什么效果就使用什么API，这样既可以让代码精简，也可以增强可读性，让代码`自己描述自己`，这是`增强代码可读性的关键`
- 基础功能使用工具类：在进行一些基础判断等操作时，尽量使用一些封装好的工具类，这样可以`避免`判断时的`疏漏`而产生错误；使用某功能时也先查询是否已有相关工具，同一类功能使用同一个封装好的工具将更`方便管理`，但要注意的是此类工具`不能过于复杂`，否则大范围应用后将会导致`难以维护`、牵一发而动全身

## Vapor Mode

Vapor Mode是一种替代编译策略，受到Solid的启发，我们一直在进行实验。使用相同的Vue SFC，Vapor Mode将其编译为JavaScript输出，与当前基于Virtual DOM的输出相比，它更具有性能、内存占用和运行时支持代码方面的优势。尽管它仍处于早期阶段，拥有以下优点：

- 1、Vapor模式旨在用于性能是主要关注点的用例。它是选择性的，不会影响现有的代码库。
- 2、您将能够将Vapor组件子树嵌入到任何现有的Vue 3应用程序中。理想情况下，我们希望在组件级别实现细粒度选择，这意味着可以在同一个应用程序中自由混合Vapor和非Vapor组件。
- 3、仅使用Vapor组件构建应用程序允许您从构建包中删除虚拟DOM运行时，从而显着减少基线运行时大小。
- 4、为了实现最佳性能，Vapor模式将仅支持Vue功能的子集。特别地，Vapor模式组件将仅支持Composition API和<script setup>。然而，这个受支持的子集在Vapor和非Vapor组件之间将完全相同。

不同框架的编译策略对比：

- 🚀 React编译之后是`Jsx`函数返回的`虚拟DOM`
- 🚀 Vue编译之后是`render`函数返回的`虚拟DOM`
- 🚀 SolidJS编译之后返回的`真实DOM`字符串
- 🚀 Svelte编译之后返回的是`真实DOM`片段

> 粗颗粒度：`React`由于架构机制决定了每当状态发生改变，从当前组件开始一直到叶子组件重新加载。
>
> 中颗粒度：`Vue`由于给每个组件建立了`watchEffect`监听机制，每当组件依赖的状态发生改变，当前组件重新加载。
>
> 细颗粒度：`SolidJS`和`Svelte`由于在编译之后就确定了当状态发生改变`UI`随之变化的关系，所以仅仅是具体`DOM`的重新加载。

对于组件更新时：

- `React`在当前组件状态发生变化时，从当前组件开始，包括子组件都被重新加载了。
- `Vue`仅仅是当前组件重新加载。
- `SolidJS`、`Svelte`仅仅是重新加载对应的`DOM`！

在项目比较小时，`SolidJS`、`Svelte`的优势不会很明显，

但是当面对大型项目时，`React`和`Vue`的性能短板就显露出来了。

`Vapor mode`可以在给定相同的`Vue SFC`前提下，与当前基于`虚拟DOM`的输出相比，`Vapor Mode`将其编译成性能更高、使用更少内存且需要更少运行时支持代码的`JavaScript`输出。

## 手写Vue3-珠峰(pnpm的workspace来实现monorepo包管理)

- [从零手写Vue3响应式模块 - 珠峰培训-video](https://www.bilibili.com/video/BV1WP4y1u7qi/?spm_id_from=333.337.search-card.all.click&vd_source=bd4c7d99d71adf64d6e88c65370e0247)

### pnpm是什么

pnpm是快速、节省磁盘空间的包管理器，主要采用符号链接的方式管理模块。

### 搭建monorepo环境

**初始化**

```
npm init -y
```

安装基本的依赖包

- typescript：做类型检查
- rollup：打包
- rollup-plugin-typescript2：打包时解析ts
- @rollup/plugin-json:打包时解析json
- @rollup/plugin-node-resolve:按照node的方式解析模块
- @rollup/plugin-commonjs：解析低版本模块
- minimist：解析用户提供的参数
- execa@4：启动多个进程打包程序，指定版本4

```
pnpm install typescript rollup rollup-plugin-typescript2 @rollup/plugin-json @rollup/plugin-node-resolve @rollup/plugin-commonjs minimist execa@4 -D -w
```

创建packages目录，在根目录下pnpm-workspace.yaml配置文件，指定打包目录

```
packages:
  - "packages/*" 
```

安装tsc即tsconfig配置文件

```
pnpm tsc --init 
tsconfig.json配置
{
  "compilerOptions": {
    "outDir": "dist", // 输出目录
    "sourceMap": true, // 采用source
    "target": "ES2016", // 目标语法
    "module": "ESNext", //  模块格式
    "moduleResolution": "Node", // 模块解析方式
    "strict": true, // 严格模式
    "resolveJsonModule": true, //解析json
    "esModuleInterop": true, // 允许es6语法引入commonjs模块
    "jsx": "preserve", // jsx不转义
    "lib": ["ESNext", "DOM"], // 支持的类库esnext和dom
    "baseUrl": ".", //以当前路径为基准进行查找
    "paths": {
      "@vue/*": ["packages/*/src"] // 别名前缀
    }
  }
}
```

**创建reactivity模块和shared模块**

其中reactivity会依赖shared

```
创建packages/reactivity/src/index.js
创建packages/reactivity/package.json
{
  "name": "@vue/reactivity",
  "version": "1.0.0",
  "main": "index.js",
  "module": "dist/reactivity.esm-bundler.js",
  "unpkg": "dist/reactivity.global.js",
  "buildOptions": {
    "name": "VueReactivity",
    "formats": [
      "esm-bundler",
      "cjs",
      "global"
    ]
  }
}
```

```
创建packages/shared/src/index.js
创建packages/shared/package.json
{
  "name": "@vue/shared",
  "version": "1.0.0",
  "main": "index.js",
  "module": "dist/shared.esm-bundler.js",
  "buildOptions": {
    "formats": [
      "esm-bundler",
      "cjs"
    ]
  }
}
```

给reactivity指定安装shared的依赖，让它找得到它

```
pnpm i @vue/shared@workspace --filter @vue/reactivity
```

```
packages/reactivity/src/index.js
import { isObject } from "@vue/shared";

packages/shared/src/index.js
export function isObject(value: unknown): value is Record<any, any> {
  return typeof value === "object" && value !== null;
}

```

**创建打包脚本**

```
package.json
"scripts": {
    "dev":"node scripts/dev.js reactivity -f global -s" //表示打包响应式模块，使用global方式打包，输出sourcemap
  },
```

```
scripts/dev.js
const minimist = require("minimist");
const execa = require("execa");
// import minimist from "minimist";
// import execa from "execa";
const args = minimist(process.argv.slice(2)); //获取打包命令的执行参数

// 获取执行命名时，打包的参数
const target = args._.length ? args._[0] : "reactivity"; //目标模块
const formats = args.f || "global"; // 打包的方式es6还是global全局等等
const sourcemap = args.s || false; // 是否生产源码模式
console.log(target, formats, sourcemap);
// 读取参数后，执行子进程命令
execa(
  "rollup",
  [
    "-wc", // --watch --config监视文件变化和读取配置文件
    "--environment", // 配置环境
    [
      `TARGET:${target}`,
      `FORMATS:${formats}`,
      sourcemap ? `SOURCE_MAP:true` : "",
    ]
      .filter(Boolean)
      .join(","), //过滤掉空值或false的值
  ],
  {
    stdio: "inherit", // 子进程命令在当前命令进程下继续执行
  }
);
```

```
rollup.config.js
import path from "path";
import ts from "rollup-plugin-typescript2";
import json from "@rollup/plugin-json";
import { nodeResolve } from "@rollup/plugin-node-resolve";
import commonjs from "@rollup/plugin-commonjs";

// 命令参数获取-打包格式
const packageFormats = process.env.FORMATS && process.env.FORMATS.split(",");
// 命令参数获取-源码
const sourcemap = process.env.SOURCE_MAP;
const target = process.env.TARGET;
console.log(packageFormats, sourcemap, target);

// 根据target找到要打包的目录
const packagesDir = path.resolve(__dirname, "packages");
// 要打包的入口
const packageDir = path.resolve(packagesDir, process.env.TARGET);
// 以打包的目录解析文件
const resolve = (p) => path.resolve(packageDir, p);
// 获取打包的名字
const name = path.basename(packageDir);
const pkg = require(resolve("package.json"));
// 输出配置
const outputConfig = {
  "esm-bundler": {
    file: resolve(`dist/${name}.esm-bundler.js`),
    format: "es",
  },
  cjs: {
    file: resolve(`dist/${name}.cjs.js`),
    format: "cjs",
  },
  global: {
    file: resolve(`dist/${name}.global.js`),
    format: "iife",
  },
};
// 稍后打包的所有文件，可能命令中不含packageFormats值
const packageConfigs = packageFormats || pkg.buildOptions.formats;

function createConfig(format, output) {
  output.sourcemap = sourcemap;
  output.export = "named";
  // 外部模块，哪些模块不需要打包
  let external = [];
  if (format === "global") {
    // 填充全局名称
    output.name = pkg.buildOptions.name;
  } else {
    // 哪些内部依赖不需要打包
    external = [...Object.keys(pkg.dependencies)];
  }
  return {
    input: resolve(`src/index.ts`),
    output,
    external,
    plugins: [json(), ts(), commonjs(), nodeResolve()],
  };
}
// 返回数组，会依次进行打包
export default packageConfigs.map((format) =>
  createConfig(format, outputConfig[format])
);
```

