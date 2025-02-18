---
title: VueReactAngular比较
date: 2023-03-01 07:33:16
categories:
- D_框架和类库
toc: true # 是否启用内容索引
---

# 框架原理

## 三大框架解析

**angular**

2012开始1.0版本，16年升级2.0版本。缺点：中文文档较少，框架较重，学习成本高。

> 双向绑定；
> 依赖注入；
> 基于ts的组件；
> 良好的应用架构；
> 工具生态完整，angular-cli用于创建、开发、测试等。有整套的解决方案，适合大型项目。

**react**

2013年facebook发布版本。2015年版本稳定，同年发布reacr-native。缺点：本身只是view，大型项目需要加上React Router和Redux。

> 虚拟dom，跨浏览器兼容，性能较好；
> 组件化，代码复用;
> JSX,js语法的扩展，模板简单、直接、语义化。
> 单项数据流：数据流清晰，组件状态更可控。

**Vue**

2015年1.0版本发布，同年vue-router、vuex、vue-cli出现，标志从一个视图层发展成一个渐进式框架。
2016年vue2.0发布，引入虚拟dom，性能大幅提升。
2019年vue2.0公布源码。

>  渐进式、轻量级框架;
>  简单易用;
>  双向数据绑定;
>  组件化;
>  轻量高效(使用虚拟dom，压缩后只有20kb)

**vue和react比较**

**相同点：**

> (1)都使用Virtural DOM
>
> (2)都使用组件化思想，流程基本一致
>
> (3)都是响应式，推崇单向数据流
>
> (4)都有成熟的社区，都支持服务端渲染
>
> (5)实现原理和流程基本一致，都是使用Virtual DOM + Diff算法.不管是Vue的template模板 + options api/composition api写法，还是React的Class或者Function（js 的class写法也是function函数的一种）写法，底层最终都是为了生成render函数,
>
> Vue和React通用流程：vue template/react jsx -> render函数 -> 生成VNode -> 当有变化时，新老VNode diff -> diff算法对比，并真正去更新真实DOM。

**不同点-青铜：**

> - `Vue API` 多，`React API` 少
> - `Vue` 双向绑定，修改数据自动更新视图，而 `React` 单向数据流，需要手动 `setState`
> - `Vue template` 结构表现分离，`React` 用 `jsx` 结构表现融合，html/css都可以写到js里
> - 都可以通过 `props` 进行父子组件数据传递，只是 `Vue props` 要声明，`React` 不用声明可能直接使用
> - `Vue` 可以用插槽，`React` 是万物皆可 `props`
> - `Vue2` 利用基本都是 `Mixin`，`React` 可以用高阶函数、自定义 `hook` 实现
> - `Vue` 的 `fragment`、`hook` 到 `Vue3` 才有，`Vue` 还有丰富的指令，过滤器

**不同点-白银：**

> - 组件化
>   - vue2组件本质是通过new Vue()生产的Vue实例。Vue组件的script导出的是挂满options的纯对象。Vue的插件都是基于Vue原型类基础上的，Vue.install挂到Vue实例上，保证第三方库调用的是同一个Vue对象。this指向Vue实例，对开发者不透明。
>   - React比较简单，直接定义render函数生成vnode,立马通过四个组件类包装vnode。不同类型的vnode用响应的组件类处理。React类组件都是继承与React.component类，它的this指向我们自定义的类，对开发者透明。
> - hook
>   - Vue3 hook是基于响应式实现的，它声明在setup里，一次组件实例化值调用一次setup,而React每次重新渲染都要重新调用，性能差。Vue可以在循环/条件判断/嵌套函数里使用，自动实现了依赖收集，而React需要手动传入依赖。
>   - React hool是根据调用顺序确定下一次重新渲染时的state是来源于哪个，所以有一些限制，比如不能再循环/条件判断/嵌套函数里使用，必须在函数最顶层调用hook。

**不同点-黄金：**

> - 响应式
>   - Vue2响应式特点是依赖收集，数据改变，自动派发更新。初始化时通过Object.defineProperty递归劫持data所有属性添加getter/setter，触发getter的时候进行依赖收集，修改时触发setter自动派发更新找到引用组件重新渲染。
>   - Vue3响应式使用原生Proxy重构，一解决了Vue2响应式缺陷，二是性能更好，支持更多数据结构，不再一开始递归劫持对象属性，而是只代理第一层对象。运行时才递归，用到才代理，用effect副作用代替Vue2的watcher,用一个依赖管理中心trackMap统一管理依赖代替Vue2中的Dep，这样不需要维护特别多的依赖关系。
>   - React则是基于状态，单项数据流，数据不可变，需要手动setState来更新，而且当数据改变时，会以组件根为目录，默认全部重新渲染整个组件树，只能额外用`pureComponent`/`shouldComponentUpdate`/`useMemo`/`useCallback` 等方法来进行控制，更新粒度更粗
> - Diff算法
>   - Vue2是同层比较新老vnode,新的不存在老的存在就删除，新的存在老的不存在就创建，子节点采用双指针头对尾两端对比的方式，全量diff，然后移动节点时通过 splice 进行数组操作。
>   - `Vue3` 是采用 `Map` 数据结构以及动静结合的方式，在编译阶段提前标记静态节点，`Diff` 过程中直接跳过有静态标记的节点，并且子节点对比会使用一个 `source` 数组来记录节点位置及最长递增子序列算法优化了对比流程，快速 `Diff`，需要处理的边际条件会更少。
>   - `React` 是递归同层比较，标识差异点保存到 `Diff` 队列保存，得到 `patch` 树，再统一操作批量更新 `DOM`。`Diff` 总共就是移动、删除、增加三个操作，如果结构发生改变就直接卸载重新创建，如果没有则将节点在新集合中的位置和老集合中的 `lastIndex` 进行比较是否需要移动，如果遍历过程中发现新集合没有，但老集合有就删除。

**不同点-钻石：**

> - 核心思想和设计理念
>
>   - `React` 一开始定位的就是 UI 开发的新思路，它制定规则，改动开发者。Vue是尽可能降低开发的门槛，让开发者怎么爽怎来。后续两者架构的变化都是围绕这个。
>
> - 数据管理方式
>
>   `Vue` 是响应式的，`React` 是手动 `setState`，这个对后面的架构产生不可逆的影响。
>
>   - Vue是对数据进行劫持/代理，它监测数据更加精准，更新粒度很小。而React推崇函数式，没办法感知数据变化，即使setstate触发更新，也不知道更新哪个组件，而是渲染整个DOM。当然Vue精准刷新也是有代价的，就是给每个组件配置监视器来管理依赖收集和派发更新。React迭代是增加了避免刷新的钩子函数或者采用Fiber的架构做时间片优化性能。
>   - 正是这种设计，影响了hooks的实现和表现。React hook底层是基于链表实现的，每次组件被render时候都会按照顺序执行所有hooks,因为是链表，所以每个hooks的next是指向下一个hooks。所以代码不能写条件判断/函数嵌套，会导致错乱。而Vue hook知会被注册调用一次，一次组件实例化只调用一次setup，vue之所以能避开这些问题，得益于数据响应式。它不是链表对hooks进行记录，而是直接对数据代理观察，但不得不返回一个包装对象(通过.value返回)。因为js基础类型只有值，没有引用。必须依赖这个对象进行响应式追踪。
>   - 再比如编译优化问题。Vue能做到数据劫持，再到Vue3动静结合的Diff思想得益于它的模板语法实现了静态编译，就是预编译优化，可以静态分析，在解析模板时根据不同标签执行对应的回调函数来构造AST。而React虽然JSX语法更加灵活，但重新渲染时一堆递归调用`React.createElement`，无法从模板层面进行静态分析，也就做不到双向绑定，即使是很厉害的 `fiber`，也是因为伤害已经造成，所以通过时间分片的优化来弥补，因为已经无法在编译阶段进行优化了。

**项目选型：**

> - (如果公司主要用 `Vue` 技术栈的话)：`Vue` 性能上会更有优势一点，特别是 `Vue3` 更加灵活，有很好的可扩展性，同时有更快的渲染速度和更小的打包体积。从 `mixins` 到 `HOC` 到 `render props` 再到 `hooks`，`React` 基本已经废掉了过去很多基于组件的逻辑抽象模式，抹掉了 `JSX` 对比模板的一个优势，`Vue3` 中现在也都能做到，所以我会偏向 `Vue3`。
> - (如果公司主要用 `React` 技术栈的话)：一些不大的系统或者 `H5` 就用 `Vue`，因为不管是上手还是开发难度上都很简单，开发效率也高嘛，而且它有更小的打包体积，毕竟在移动端网络差异大的情况下，资源体积是非常重要的。但像是一些中后台系统，或者一些大点的项目，会越做越大的，多人协作开发的，就用 `React`，因为它的函数式编程有更加灵活的结构和可扩展性，丰富的生态圈和工具链，解决方案多，后期也更方便迭代与维护，还适用原生 `APP`，所以我会偏向 `React`。

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

