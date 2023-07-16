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



