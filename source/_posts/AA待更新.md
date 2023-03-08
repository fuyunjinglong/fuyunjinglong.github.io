# 低层级目录

一、

1.

(1.)

a.

# Vue历代版本代号

| 版本号                                                       | 发布日期   |
| ------------------------------------------------------------ | ---------- |
| [Vue0.9 Animatrix 黑客帝国](https://link.juejin.cn/?target=https%3A%2F%2Fgithub.com%2Fvuejs%2Fvue%2Freleases%2Ftag%2Fv0.9.0) | 2014-02-25 |
| [Vue0.10 Blade Runner 银翼杀手](https://link.juejin.cn/?target=https%3A%2F%2Fgithub.com%2Fvuejs%2Fvue%2Freleases%2Ftag%2Fv0.10.0) | 2014-03-24 |
| [Vue0.11 Cowboy Bebop 星际牛仔](https://link.juejin.cn/?target=https%3A%2F%2Fgithub.com%2Fvuejs%2Fvue%2Freleases%2Ftag%2F0.11.0) | 2014-11-07 |
| [Vue0.12 Dragon Ball 龙珠](https://link.juejin.cn/?target=https%3A%2F%2Fgithub.com%2Fvuejs%2Fvue%2Freleases%2Ftag%2F0.12.0) | 2015-06-13 |
| [Vue1.0 Evangelion 新福音战士](https://link.juejin.cn/?target=https%3A%2F%2Fgithub.com%2Fvuejs%2Fvue%2Freleases%2Ftag%2F1.0.0) | 2015-10-27 |
| [Vue2.0 Ghost in the Shell 攻壳机动队](https://link.juejin.cn/?target=https%3A%2F%2Fgithub.com%2Fvuejs%2Fvue%2Freleases%2Ftag%2Fv2.0.0) | 2016-10-01 |
| [Vue2.1 Hunter X Hunter 全职猎人](https://link.juejin.cn/?target=https%3A%2F%2Fgithub.com%2Fvuejs%2Fvue%2Freleases%2Ftag%2Fv2.1.0) | 2016-11-23 |
| [Vue2.2 Initial D 头文字D](https://link.juejin.cn/?target=https%3A%2F%2Fgithub.com%2Fvuejs%2Fvue%2Freleases%2Ftag%2Fv2.2.0) | 2017-02-26 |
| [Vue2.3 JoJo's Bizarre Adventure JOJO的奇妙冒险](https://link.juejin.cn/?target=https%3A%2F%2Fgithub.com%2Fvuejs%2Fvue%2Freleases%2Ftag%2Fv2.3.0) | 2017-04-27 |
| [Vue2.4 Kill la Kill 斩服少女](https://link.juejin.cn/?target=https%3A%2F%2Fgithub.com%2Fvuejs%2Fvue%2Freleases%2Ftag%2Fv2.4.0) | 2017-07-13 |
| [Vue2.5 Level E 灵异E接触](https://link.juejin.cn/?target=https%3A%2F%2Fgithub.com%2Fvuejs%2Fvue%2Freleases%2Ftag%2Fv2.5.0) | 2017-10-03 |
| [Vue2.6 Macross 超时空要塞](https://link.juejin.cn/?target=https%3A%2F%2Fgithub.com%2Fvuejs%2Fvue%2Freleases%2Ftag%2Fv2.6.0) | 2019-02-04 |
| [Vue2.7 Naruto](https://link.juejin.cn/?target=https%3A%2F%2Fgithub.com%2Fvuejs%2Fvue%2Freleases%2Ftag%2Fv2.7.0) | 2022-07-01 |
| [Vue3.0 One Piece 海贼王](https://link.juejin.cn/?target=https%3A%2F%2Fgithub.com%2Fvuejs%2Fvue-next%2Freleases%2Ftag%2Fv3.0.0) | 2020-09-18 |
| [Vue3.1 Pluto](https://link.juejin.cn/?target=https%3A%2F%2Fgithub.com%2Fvuejs%2Fvue-next%2Freleases%2Ftag%2Fv3.1.0) | 2021-06-08 |
| [Vue3.2 Quintessential Quintuplets 五等分的花嫁](https://link.juejin.cn/?target=https%3A%2F%2Fgithub.com%2Fvuejs%2Fvue-next%2Freleases%2Ftag%2Fv3.2.0) | 2021-08-10 |

# Vue3 

## **Hook**

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

```
// useCar.ts
import { reactive } from "vue";

export default function useCar() {
  const car = reactive<{ name: string; price: string }>({
    name: "宝马",
    price: "40w",
  });
  function changeCarPrice() {
    car.price = "80w";
  }
  return {
    car,
    changeCarPrice,
  };
}
```

## **Mixin-HOC-Hook**

Mixin-HOC的缺点：

- 渲染上下文中公开的属性的来源不清楚。 例如，当使用多个 mixin 读取组件的模板时，可能很难确定从哪个 mixin 注入了特定的属性。

- 命名空间冲突。 Mixins 可能会在属性和方法名称上发生冲突，而 HOC 可能会在预期的 prop 名称上发生冲突。

- 性能问题，HOC 和无渲染组件需要额外的有状态组件实例，这会降低性能。

Hook的优点：

- 暴露给模板的属性具有明确的来源，因为它们是从 Hook 函数返回的值。

- Hook 函数返回的值可以任意命名，因此不会发生名称空间冲突。

- 没有创建仅用于逻辑重用的不必要的组件实例。

Hook的缺点：比如 `ref` 带来的心智负担

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

  >  Vue 3.0，由于 `setup` 仅执行一次，因此函数本身只会创建一次，不存在多实例问题，不需要 `useCallback` 的概念，更不需要使用 [lint 插件](https://link.juejin.cn/?target=https%3A%2F%2Fwww.npmjs.com%2Fpackage%2Feslint-plugin-react-hooks) 保证依赖书写正确.

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





# Vue3存在的问题

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

# Vue3手摸手一站式

**实战视频**

| 相关库名称                                | 在线地址 🔗                                                   |
| ----------------------------------------- | ------------------------------------------------------------ |
| Vue 3.0 实战星座物语 H5 项目              | [在线地址](https://link.juejin.cn?target=https%3A%2F%2Fwww.bilibili.com%2Fvideo%2FBV1Q64y1F7mm%3Ffrom%3Dsearch%26seid%3D15048255084253288459) |
| Vue 3.0 UI 组件库开发                     | [在线地址](https://link.juejin.cn?target=https%3A%2F%2Fwww.bilibili.com%2Fvideo%2FBV1ny4y1i7Sh%3Ffrom%3Dsearch%26seid%3D15048255084253288459) |
| Vue 3.0 + Vite 手册阅读                   | [在线地址](https://link.juejin.cn?target=https%3A%2F%2Fwww.bilibili.com%2Fvideo%2FBV1Q54y1k7At%3Ffrom%3Dsearch%26seid%3D15048255084253288459) |
| Vue 3.0 入门之项目搭建（杨村长）          | [在线地址](https://link.juejin.cn?target=https%3A%2F%2Fwww.bilibili.com%2Fvideo%2FBV1vX4y1K7bQ%3Ffrom%3Dsearch%26seid%3D17184556019333060655) |
| Vue 3.0 入门（技术胖）                    | [在线地址](https://link.juejin.cn?target=https%3A%2F%2Fwww.bilibili.com%2Fvideo%2FBV1L5411j7vj%3Ffrom%3Dsearch%26seid%3D17184556019333060655) |
| Vite 2.0 插件开发指南                     | [在线地址](https://link.juejin.cn?target=https%3A%2F%2Fwww.bilibili.com%2Fvideo%2FBV1jb4y1R7UV%3Ffrom%3Dsearch%26seid%3D384387825939775015) |
| Vue 3.0 + Vite 2.0 快速搭建 Electron 应用 | [在线地址](https://link.juejin.cn?target=https%3A%2F%2Fwww.bilibili.com%2Fvideo%2FBV1XV411e7Hq%3Ffrom%3Dsearch%26seid%3D384387825939775015) |

**教程文章**

比如发布一些 Vue3 的教程：

- [《Vue 3.0 来了，我们该做些什么？》](https://juejin.cn/post/6874604408030789640)
- [《Vue3实战系列：结合 Ant-Design-of-Vue 实践 Composition API》](https://juejin.cn/post/6882393804310052871)
- [《Vue3 来了，Vue3 开源商城项目重构计划正式启动！》](https://juejin.cn/post/6884991023811215374)
- [《Vue3实战系列：Vue3.0 + Vant3.0 搭建种子项目》](https://juejin.cn/post/6887590229692121096)
- [《🎉🎉一个基于 Vue 3 + Vant 3 的开源商城项目🎉🎉》](https://juejin.cn/post/6892783570016796679)
- [《Vue3教程：用 Vue3 开发小程序，这里有一份实践代码！》](https://juejin.cn/post/6895360073460416525)
- [《Vue3教程：Vue 3.x 快在哪里？》](https://juejin.cn/post/6903171037211557895)
- [《Vue3教程：开发一个 Vue 3 + element-plus 的后台管理系统》](https://juejin.cn/post/6942251234191654949)
- [《🎉🎉Vue 3 + Element Plus + Vite 2 的后台管理系统开源啦🎉🎉》](https://juejin.cn/post/6945072070132760590)
- [程序员的副业：写了一个专栏《Vue 3企业级项目实战》](https://juejin.cn/post/6947703226128924702)
- [心脏跳动团队-商城](https://link.juejin.cn?target=https%3A%2F%2Fgithub.com%2Fnewbee-ltd)

**Vue 3.0 生态**

| 相关库名称             | 在线地址 🔗                                                   |
| ---------------------- | ------------------------------------------------------------ |
| Vue 3.0 官方文档(英文) | [在线地址](https://link.juejin.cn?target=https%3A%2F%2Fv3.vuejs.org%2F) |
| Vue 3.0 中文文档       | [在线地址](https://link.juejin.cn?target=https%3A%2F%2Fv3.cn.vuejs.org%2F) [国内加速版](https://link.juejin.cn?target=https%3A%2F%2Fvue3js.cn%2Fdocs%2Fzh%2F) |
| Composition-API手册    | [在线地址](https://link.juejin.cn?target=https%3A%2F%2Fvue3js.cn%2Fvue-composition-api%2F) |
| Vue 3.0 源码学习       | [在线地址](https://link.juejin.cn?target=https%3A%2F%2Fvue3js.cn%2Fstart%2F) |
| Vue-Router 官方文档    | [在线地址](https://link.juejin.cn?target=https%3A%2F%2Fnext.router.vuejs.org%2F) |
| Vuex 4.0               | [Github](https://link.juejin.cn?target=https%3A%2F%2Fgithub.com%2Fvuejs%2Fvuex%2Ftree%2F4.0) |
| vue-devtools           | [Github](https://link.juejin.cn?target=https%3A%2F%2Fgithub.com%2Fvuejs%2Fvue-devtools%2Freleases)(Vue3.0 需要使用最新版本) |
| Vite 源码学习          | [线上地址](https://link.juejin.cn?target=https%3A%2F%2Fvite-design.surge.sh%2Fguide%2F) |
| Vite 2.0 中文文档      | [线上地址](https://link.juejin.cn?target=https%3A%2F%2Fcn.vitejs.dev%2F) |
| Vue3 新动态            | [线上地址](https://link.juejin.cn?target=https%3A%2F%2Fgithub.com%2Fvue3%2Fvue3-News) |

**Element-plus**

- [Vue 3.0 + Vite 2.0 + Vue-Router 4.0 + Element-Plus + Echarts 5.0 + Axios 开发的后台管理系统](https://link.juejin.cn?target=https%3A%2F%2Fgithub.com%2Fnewbee-ltd%2Fvue3-admin) ⭐ ： **419**
- [Vue3.0+TypeScript+NodeJS+MySql编写的一套后台管理系统](https://link.juejin.cn?target=https%3A%2F%2Fgithub.com%2Fxiaoxian521%2FCURD-TS) ⭐ ： **262**

**Ant Design of Vue**

- [AntdV后台管理系统](https://link.juejin.cn?target=https%3A%2F%2Fgithub.com%2Ficzer%2Fvue-antd-admin) ⭐ ： **2.8k**
- [vue3.x + ant-design-vue（beta 版本，免费商用，支持 PC、平板、手机）](https://link.juejin.cn?target=https%3A%2F%2Fgithub.com%2Fchuzhixin%2Fvue-admin-better) ⭐ ： **8.2k**
- [基于 Vue3.0 + Vite + Ant Design Vue](https://link.juejin.cn?target=https%3A%2F%2Fgithub.com%2Flirongtong%2Fmiitvip-vue-admin-manager) ⭐ ： **74**

**Vant**

- [newbee-mall Vue3 版本](https://link.juejin.cn?target=https%3A%2F%2Fgithub.com%2Fnewbee-ltd%2Fnewbee-mall-vue3-app)⭐ ： **1.7k**
- [高仿微信记账本](https://link.juejin.cn?target=https%3A%2F%2Fgithub.com%2FNick930826%2Fdaily-cost) ⭐ ： **48**
- [仿京东淘宝电商](https://link.juejin.cn?target=https%3A%2F%2Fgithub.com%2FGitHubGanKai%2Fvue3-jd-h5) ⭐ ： **319**







# Vue3源码

render.js 2400-600行，更多的是处理边缘case

# 一、JS

# JS判断数据类型的6种方法

> 1.最常见的判断方法：typeof
>
> 2.已知对象类型:   instanceof 
>
> 3.对象原型链判断方法： prototype 通用但很繁琐
>
> 4.根据对象的构造器constructor进行判断
>
> 5.jQuery方法： jquery.type()
>
> 6.严格运算符:   ===

**1.typeof**

缺点：无法区分null，数组，对象

```
typeof null            ------------------>"object"
typeof [1,2,3]         ------------------>"object"
typeof ibj          ------------------>"object"
typeof new Date()      ------------------>"object"
typeof new RegExp()    ------------------>"object"
typeof "helloworld"    ------------------>"string"     
typeof 123             ------------------>"number"
typeof new Function()  ------------------>"function"
typeof Symbol()        ------------------>"symbol"
typeof true            ------------------>"true"
typeof undefined       ------------------>"undefined"
typeof 'undefined'     ------------------>"string"
```

**2.instanceof** 

缺点：不能区分undefined和null，不能区分Object和Function。对于基本类型如果不是用new声明的则也测试不出来，对于是使用new声明的类型，它还可以检测出多层继承关系。

```
console.log(bool instanceof Boolean);// false
console.log(num instanceof Number);// false
console.log(str instanceof String);// false
console.log(und instanceof Object);// false
console.log(arr instanceof Array);// true
console.log(nul instanceof Object);// false
console.log(obj instanceof Object);// true
console.log(fun instanceof Function);// true

var bool2 = new Boolean()
console.log(bool2 instanceof Boolean);// true

var num2 = new Number()
console.log(num2 instanceof Number);// true

var str2 = new String()
console.log(str2 instanceof String);//  true

function Person(){}
var per = new Person()
console.log(per instanceof Person);// true

function Student(){}
Student.prototype = new Person()
var haoxl = new Student()
console.log(haoxl instanceof Student);// true
console.log(haoxl instanceof Person);// true
```

**3.prototype** 

> 原理(摘自高级程序设计3)：在任何值上调用 Object 原生的 toString() 方法，都会返回一个 [object NativeConstructorName] 格式的字符串。每个类在内部都有一个 [[Class]] 属性，这个属性中就指定了上述字符串中的构造函数名。
> 但是它不能检测非原生构造函数的构造函数名。

```
console.log(Object.prototype.toString.call(bool));//[object Boolean]
console.log(Object.prototype.toString.call(num));//[object Number]
console.log(Object.prototype.toString.call(str));//[object String]
console.log(Object.prototype.toString.call(und));//[object Undefined]
console.log(Object.prototype.toString.call(nul));//[object Null]
console.log(Object.prototype.toString.call(arr));//[object Array]
console.log(Object.prototype.toString.call(obj));//[object Object]
console.log(Object.prototype.toString.call(fun));//[object Function]

function Person(){}
function Student(){}
Student.prototype = new Person()
var haoxl = new Student()
console.log(Object.prototype.toString.call(haoxl));//[object Object]
```

**4.constructor**

缺点：不能判断undefined和null，并且使用它是不安全的，因为contructor的指向是可以改变的

```
console.log(bool.constructor === Boolean);// true
console.log(num.constructor === Number);// true
console.log(str.constructor === String);// true
console.log(arr.constructor === Array);// true
console.log(obj.constructor === Object);// true
console.log(fun.constructor === Function);// true

console.log(haoxl.constructor === Student);// false
console.log(haoxl.constructor === Person);// true
```

**5.jquery.type()**

内部原理就是用的Object.prototype.toString.call()

# JS手动实现new操作符

new操作符做了4件事：

> 1. 创建一个**新对象**
> 2. 为**新对象**添加属性`__proto__`，将该属性链接至**构造函数**的**原型对象**
> 3. 执行构造函数，`this`被绑定在**新对象**上
> 4. 确保返回一个对象

**手写new**

```js
// 定义构造函数
function Person(name, age) {
    this.name = name;
    this.age = age;
}

// 手动实现new:
// constructor: 构造函数
// ...args: 构造函数参数
function myNew(constructor, ...args) {
    // 1. 创建一个新对象
    const obj = {};
    // 2. 为新对象添加属性__proto__，将该属性链接至构造函数的原型对象
    obj.__proto__ = constructor.prototype;
    // 3. 执行构造函数，this被绑定在新对象上
    const res = constructor.call(obj, ...args);
    // 4. 确保返回一个对象
    return res instanceof Object ? res : obj;
}

const usr1 = myNew(Person, 'Jack', 18);
const usr2 = new Person('Jack', 18);

console.log(usr1);
console.log(usr2);
```

# 原型链与继承

## 基本概念

> __proto__表示原型属性
> prototype表示原型对象即chrome新版浏览器中的[[prototype]]
>
> 1.__proto__是每个对象都有的一个属性，而prototype是函数才有的属性
>
> 2.__proto__是当前对象的原型对象（隐式原型），而prototype是当前构造函数的原型对象（显式原型）
>
> 3.**每个对象的__proto__属性指向自身构造函数的prototype**

```
    // 构造函数:Foo
    // 实例对象:f1
    // 原型对象:Foo.prototype
    function Foo() {}
    var f1 = new Foo()
    // 1.原型对象和实例对象的关系
    console.log(Foo.prototype === f1.__proto__); // true
    // 2.原型对象和构造函数的关系
    console.log(Foo.prototype.constructor === Foo); // true
    // 3.实例对象和构造函数
    // 间接关系是实例对象可以继承原型对象的constructor属性
    console.log(f1.constructor === Foo); // true
     // 注意：代码顺序很重要
    Foo.prototype = {}
    console.log(Foo.prototype === f1.__proto__); // false
    console.log(Foo.prototype.constructor === Foo); // false
```

## Function & Object 鸡蛋问题

[鸡蛋问题原文](https://github.com/yygmind/blog/issues/35)

引子：深入探究下 `Function.__proto__ === Function.prototype` 引起的鸡生蛋蛋生鸡问题，并在这个过程中深入了解 Object.prototype、Function.prototype、function Object 、function Function 之间的关系。

**结论**

> **总结：先有Object.prototype（原型链顶端），Function.prototype继承Object.prototype而产生，最后，Function和Object和其它构造函数继承Function.prototype而产生。**

看到这里，关于鸡蛋问题我的唯一疑问就是，`Object.prototype` 显然也是个对象，而对象最终都必须由 `Function` 生成，但混沌之初，此时还并没有 `Function`。于是又往下看：

> 这已经某种程度上解开了鸡和蛋的问题：**Object.prototype是对象，但它不是通过Object函数创建的。**

验证了一下，果然是这样：

```
Object.prototype instanceof Object // false
Object.prototype instanceof Function // false
```

所以，大概回答就是，`Object.prototype` 是个神之对象，由它诞生了 `Function.prototype`，以之为原型又诞生了 `Function` 和 `Object`，接着创造了对象世界的万物吧。

**Object.prototype**

Object.prototype 表示 Object 的原型对象，其 `[[Prototype]]` 属性是 null，访问器属性 `__proto__` 暴露了一个对象的内部 `[[Prototype]]` 。 Object.prototype 并不是通过 `Object` 函数创建的，为什么呢？看如下代码

```
function Foo() {
  this.value = 'foo';
}
let f = new Foo();
f.__proto__ === Foo.prototype;
// true
```

实例对象的 `__proto__` 指向构造函数的 `prototype`，即 `f.__proto__` 指向 Foo.prototype，但是 `Object.prototype.__proto__` 是 null，所以 Object.prototype 并不是通过 Object 函数创建的，那它如何生成的？其实 Object.prototype 是浏览器底层根据 ECMAScript 规范创造的一个对象。

Object.prototype 就是原型链的顶端（不考虑 null 的情况下），所有对象继承了它的 toString 等方法和属性。

**Function.prototype**

Function.prototype 对象是一个函数（对象），其 ` [[Prototype]]` 内部属性值指向内建对象 Object.prototype。Function.prototype 对象自身没有 `valueOf` 属性，其从 Object.prototype 对象继承了` valueOf` 属性。

Function.prototype 的 `[[Class]]` 属性是 `Function`，所以这是一个函数，但又不大一样。为什么这么说呢？因为我们知道只有函数才有 prototype 属性，但并不是所有函数都有这个属性，因为 Function.prototype 这个函数就没有。

```
Function.prototype
// ƒ () { [native code] }

Function.prototype.prototype
// undefined
```

当然你会发现下面这个函数也没有 prototype 属性。

```
let fun = Function.prototype.bind()
// ƒ () { [native code] }

fun.prototype
// undefined
```

为什么没有呢，我的理解是 `Function.prototype` 是引擎创建出来的函数，引擎认为不需要给这个函数对象添加 `prototype` 属性，不然 `Function.prototype.prototype…` 将无休无止并且没有存在的意义。

**function Object**

Object 作为构造函数时，其 ` [[Prototype]]` 内部属性值指向 Function.prototype，即

```
Object.__proto__ === Function.prototype
// true
```

使用 `new Object()` 创建新对象时，这个新对象的 ` [[Prototype]]` 内部属性指向构造函数的 prototype 属性，对应上图就是 Object.prototype。

当然也可以通过对象字面量等方式创建对象。

- 使用对象字面量创建的对象，其 `[[Prototype]]` 值是 `Object.prototype`。
- 使用数组字面量创建的对象，其 `[[Prototype]]` 值是 `Array.prototype`。
- 使用 `function f(){}` 函数创建的对象，其 `[[Prototype]]` 值是 `Function.prototype`。
- 使用 `new fun()` 创建的对象，其中 fun 是由 JavaScript 提供的内建构造器函数之一(Object, Function, Array, Boolean, Date, Number, String 等等），其 `[[Prototype]]` 值是 fun.prototype。
- 使用其他 JavaScript 构造器函数创建的对象，其 `[[Prototype]]` 值就是该构造器函数的 prototype 属性。

```
let o = {a: 1};
// 原型链: o ---> Object.prototype ---> null

let a = ["yo", "whadup", "?"];
// 原型链: a ---> Array.prototype ---> Object.prototype ---> null

function f(){
  return 2;
}
// 原型链: f ---> Function.prototype ---> Object.prototype ---> null

let fun = new Function();
// 原型链: fun ---> Function.prototype ---> Object.prototype ---> null

function Foo() {}
let foo = new Foo();
// 原型链: foo ---> Foo.prototype ---> Object.prototype ---> null

function Foo() {
  return {};
}
let foo = new Foo();
// 原型链: foo ---> Object.prototype ---> null
```

**function Function**

Function 构造函数是一个函数对象，其 `[[Class]]` 属性是 `Function`。Function 的 `[[Prototype]]` 属性指向了 `Function.prototype`，即

```
Function.__proto__ === Function.prototype
// true
```

**鸡蛋问题**

我们看下面这段代码

```
Object instanceof Function   // true
Function instanceof Object   // true

Object instanceof Object    // true
Function instanceof Function  // true
```

`Object` 构造函数继承了 `Function.prototype`，同时 `Function` 构造函数继承了`Object.prototype`。这里就产生了 **鸡和蛋** 的问题。为什么会出现这种问题，因为 `Function.prototype` 和 `Function.__proto__` 都指向 `Function.prototype`。

```
// Object instanceof Function  即
Object.__proto__ === Function.prototype      // true

// Function instanceof Object  即
Function.__proto__.__proto__ === Object.prototype // true

// Object instanceof Object   即    
Object.__proto__.__proto__ === Object.prototype  // true

// Function instanceof Function 即 
Function.__proto__ === Function.prototype     // true
```

对于 `Function.__proto__ === Function.prototype` 这一现象有 2 种解释，争论点在于 Function 对象是不是由 Function 构造函数创建的一个实例？

**解释 1、YES**：按照 JavaScript 中“实例”的定义，a 是 b 的实例即 `a instanceof b` 为 true，默认判断条件就是 `b.prototype` 在 a 的原型链上。而 `Function instanceof Function` 为 true，本质上即 `Object.getPrototypeOf(Function) === Function.prototype`，正符合此定义。

**解释 2、NO**：Function 是 `built-in` 的对象，也就是并不存在“Function对象由Function构造函数创建”这样显然会造成鸡生蛋蛋生鸡的问题。实际上，当你直接写一个函数时（如 `function f() {}` 或 `x => x`），也不存在调用 Function 构造器，只有在显式调用 Function 构造器时（如 `new Function('x', 'return x')` ）才有。

我个人偏向于第二种解释，即先有 `Function.prototype` 然后有的 `function Function()` ，所以就不存在鸡生蛋蛋生鸡问题了，把 `Function.__proto__` 指向 `Function.prototype` 是为了保证原型链的完整，让 `Function` 可以获取定义在 `Object.prototype` 上的方法。

# 堆栈溢出和内存泄漏

**堆栈溢出**

> 最常见的就是**无限递归**或**递归层级过深**，导致调用栈空间不足，从而导致栈上溢。

```
function isEven(n){
  if(n===0)return true
  if(n===1)return false
  return isEven(Math.abs(n)-2)
}
```

当n为10时，可以正常输出true，运行的也很快。 当n为10000000时，会抛出错误`Uncaught RangeError: Maximum call stack size exceeded`，即最大调用超过堆栈大小。

解决方案：改为使用闭包和Trampoline循环来解决

```
function isEven(n) {
  function isEvenInner(n) {
    if (n === 0) return true
    if (n === 1) return false
    return isEven(Math.abs(n) - 2)
  }
  // trampoline蹦床函数，你可以将递归函数转化为 while 循环：
  function trampoline(func,arg) {
    var value=fun(arg)
    while (typeof value==='function')value=value()
    return value
  }
  return trampoline.bind(null,isEvenInner)(n)
}
```

# 尾递归(tail recursion)

**非尾递归**

因为最后一个操作并不是调用自己, 而是 乘法

```
function fact(n){
    if(n==0)return 1;
    return n*fact(n-1);
}
```

**尾递归**

当然是最后一个操作一定是调用自己.

```
function fact(n, acc){
    if(n==0)return acc;
    return fact(n-1, acc*n)
}
```

两个地方值得注意

- 看到 `acc` 了没有, 这就是典型的尾递归最常见的东西, 用来累计每次递归运算结果
- fact函数的最后一个操作是fact本身



由于tail recur非常容易改写成循环, 编译器容易对其进行优化

```
function fact(n){
    var acc=1,i=n
    while(i!=0){
        acc=acc*i;
        i-=1;
    }
    return acc
}
```

有没有觉得尾递归和循环非常像, 唯一的区别是

- 尾递归用参数重新绑定递减的n
- 尾递归用参数重新绑定叠加值acc
- 循环直接改变变量i来进行递减
- 循环叠加变量acc

# try...catch...finally

总原则：顺序执行(如遇异常或throw,则进入catch),最后进入finally，最后再执行return语句(如果有return语句的话)。

**catch**

一旦出现异常或throw抛出异常，就进入catch

```
try{
    console.log('begin throw error')
    throw new Error('this is a error')
    console.log('Will it work here ? ')
} catch(e){
    console.log('e:',e)
}

//打印结果
begin throw error
e: this is a error
```

**finally**

```
function test() {
        try {
          console.log(1);
          throw new Error("throw");
        } catch (e) {
          console.log(e.message);
          return "from_catch";
        } finally {
          console.log(2);
        }
      }
      console.log(test());
      /*打印
        1
        throw
        2
        from_catch
      */
```

# 事件循环

**单线程如何实现异步**

js的任务分为同步和异步两种。同步任务是直接在主线程上排队执行，异步任务则会被放到任务队列中。这些任务最终都会被放入调用栈中执行。

**EventLoop事件循环**

事件循环就是基于之上的，调用栈的任务执行完之后会去查看任务队列是否存在任务。若是存在则推到调用栈执行，执行完之后再去查看任务队列，基于这种机制形成的循环就叫 EventLoop

> 宏任务macrotask 包括
>
> - 整体JS代码，
> - 事件回调，
> - XHR回调，
> - 定时器（setTimeout, setInterval, setImmediate），
> - IO操作，
> - UI render
>
> 微任务microtask 包括
>
> - promise回调
> - MutationObserver
> - process.nextTick
> - Object.observe（已废弃）
>
> 其中定时器 setImmediate（某些浏览器也有，非标准 ）和process.nextTick是node独有

**宏任务与微任务执行的机制**

> 基于宏任务与微任务又存在一个运行机制-浏览器端
>
> 1. 检查macrotask队列是否为空，非空则到2，为空则到3
> 2. 执行macrotask中的一个任务
> 3. 继续检查microtask队列是否为空，若有则到4，否则到5
> 4. 取出microtask中的任务执行，执行完成返回到步骤3
> 5. 执行视图更新
>
> 基于宏任务与微任务又存在一个运行机制-NodeJS
>
> 1. timer阶段
> 2. I/O callback阶段
> 3. idle, prepare 阶段
> 4. poll 阶段
> 5. check 阶段
> 6. close callbacks 阶段

**`Async/Await`在事件循环中**

```js
async function async1() {
  console.log('a')
  await async2()
  console.log('b')
}
async function async2() {
  console.log('c')
}

async1()

new Promise((resolve) => {
  console.log('d')
  resolve()
}).then(() => {
  console.log('e')
})
```

> 不同chrome版本表现不同，有以下两种情况：
>
> - `a c d b e`
> - `a c d e b`
>
> 结论：**最新ECMAScript规范下，第一种为正确表现**

最新ECMAScript规范中，`await`直接使用Promise.resolve()相同语义，也就是说，如果`await`后跟的是一个`Promise`，则直接返回`Promise`本身，如果不是，则使用`Promise.resolve`包裹后返回，上述代码执行过程可以简化理解为：

```
console.log('a')
new Promise(resolve => {
  console.log('c')
  resolve()
}).then(() => {
  console.log('b')
})
new Promise((resolve) => {
  console.log('d')
  resolve()
}).then(() => {
  console.log('e')
})
```

`console.log('b')`在第一轮事件循环时就加入微任务队列，然后`console.log('e')`才加入微任务队列，故`b`的打印顺序在先。

**复杂异步嵌套分析**

```
async function async1() {
  console.log('async1 start')
  await async2()
  console.log('async1 end')
}
 
async function async2() {
  console.log('async2')
}
 
console.log('script start')
 
setTimeout(function() {
  console.log('setTimeout')
}, 0)
 
async1()
 
new Promise(function(resolve) {
  console.log('promise1')
  resolve()
}).then(function() {
  console.log('promise2')
})
 
console.log('script end')
```

> 1. 定义函数`async1`、`async2`，**打印`script start`**；
> 2. 执行`setTimeout`，回调交由`Web API`处理，`Web API`将其加入宏任务队列；
> 3. 执行`async1`，**打印`async1 start`**；
> 4. 执行`async2`，**打印`async2`**，由于左边有`await`，将`console.log('async1 end')`放入微任务队列；
> 5. 执行`new Promise`，同步执行传入构造函数的函数，**打印`promise1`**；
> 6. promise完成，将`console.log('promise2')`所在函数放入微任务队列；
> 7. **打印`script end`**，当前任务执行完毕；
> 8. 检查微任务队列并依次取出执行，**打印`async1 end`**、**打印`promise2`**；
> 9. 微任务队列为空，执行栈为空，检查宏任务队列，取出任务执行，**打印`setTimeout`**；
> 10. 执行完毕。
>
> 故打印顺序为：
>
> - `script start`
> - `async1 start`
> - `async2`
> - `promise1`
> - `script end`
> - `async1 end`
> - `promise2`
> - `setTimeout`

# 其他

中成药：感冒清热颗粒19，宣肺败毒43
发热退烧：对乙酰氨基酚，疏风解毒胶囊
咽干咽痛：六神丸，银翘解毒颗粒
咳嗽：复方鲜竹荔液18
止痰：乙酰半胱氨酸32
流鼻涕：氯雷他定39
鼻塞:赛落唑啉滴鼻剂
恶心/呕吐:藿香正气水
肠胃：健胃消食片


基于声明式渲染的SFC的响应式框架，更小更快更强



自然科学的真理性最强；社会科学次之；人文科学最弱。
人文科学：心理，伦理，语言，历史，考古，美学，宗教
社会科学：政治、军事、经济，管理，教育，社会学
自然科学：数学，物理，化学，天文，地理，生物

主升浪，缩量突破
1分钟、5分钟，做日内，用5 分钟判断趋势，1分钟具体找买卖点。5分钟结构管两小时，15分钟一天半（6小时），30分钟结构管3天。

15分钟、30分钟，做隔夜；

60分钟做4天内；

日线做5-7天；周线做2周，当五日均线上穿了十日、二十日均线，十日均线上穿二十日均线，投资者可以买入；反之，投资者就选择卖出。

孙子兵法
《黑冰》里的王志文，

《黑洞》陈道明，

《征服》孙红雷，

《破冰行动》王劲松。

# JavaScript和ECMAScript的关系

JavaScript是脚本语言，ECMAScript是规范。**JavaScript是基于ECMAScript规范的脚本语言**。

JavaScript只是ECMAScript的其中一种实现，除此之外还有其他的实现。

# 实现setTimeout和实现setInterval

**使用setTimeout实现setInterval**

> setInterval 的作用是每隔一段指定时间执行一个函数，但是这个执行不是真的到了时间立即执行，它真正的作用是每隔一段时间将事件加入事件队列中去，只有当当前的执行栈为空的时候，才能去从事件队列中取出事件执行。所以可能会出现这样的情况，就是当前执行栈执行的时间很长，导致事件队列里边积累多个定时器加入的事件，当执行栈结束的时候，这些事件会依次执行，因此就不能到间隔一段时间执行的效果。

 针对 setInterval 的这个缺点，我们可以使用 setTimeout 递归调用来模拟 setInterval，这样我们就确保了只有一个事件结束了，我们才会触发下一个定时器事件，这样解决了 setInterval 的问题。

 实现思路是使用递归函数，不断地去执行 setTimeout 从而达到 setInterval 的效果

```js
      function mySetInterval(fn, timeout) {
        // 控制器，控制定时器是否继续执行
        let timer = { flag: true };
        // 设置递归函数，模拟定时器执行
        function interval() {
          if (timer.flag) {
            fn();
            setTimeout(interval, timeout);
          }
        }
        // 启动定时器
        setTimeout(interval, timeout);
        // 返回控制器
        return timer;
      }
```

**使用setInterval实现setTimeout**

```js
function mySetInterval(fn, timeout) {
        //timer用来接收setInterval返回的编号，用于后面清除setInterval
        //setInterval会一直执行，但是在setInterval里面执行clearInterval()将会被清除
        const timer = setInterval(() => {
          //执行传入函数
          fn();
          //清除该次setInterval
          clearInterval(timer);
        }, timeout);
      }
```

# 重构-手写Promise

https://juejin.cn/post/6850037281206566919#heading-6

# 实现双向绑定的两种方式

所谓的双向绑定，其实就是将Model和View绑定在一起，任何一方改变的同时，改变另外一方。 在流行框架中，react是单向绑定（只支持Model改变=>View改变），要实现双向绑定得加value和onChange事件从而实现（View改变=>调起事件=>改变Model）。 而vue是双向绑定的，因为它事先已经帮我们绑定好了事件。

**什么是Model**

我理解为Model就是一个JS对象，用来存储页面中的数据。

**什么是View**

我理解是页面中所显示的DOM对象的集合。

**方式一：Object.defineProperty**

> Model => View 实现的原理：
>
> 当Model改变时，得到事件响应（数据劫持），获取到Dom节点，我们就可以通过Dom.value来改变View。而Object.defineProperty主要帮我们来获得这个过程的事件响应，或者常说的数据劫持，可以劫持到改变后的新值。
>
> View => Model 实现原理：
>
> 当View改变时，调起onKeyup之类的事件，然后改变响应的Model，这个其实是很简单的。

**方式二:Proxy()**

```
index.html
<html lang="en">
<style>
    div {
        width: 40%;
        float: left;
        border: 1px dashed;
        padding: 20px;
        height: 100vh;
    }
</style>
<body>
    <div>
        <p>View:</p>
        <input id="view" />
    </div>
    <div>
        <p>Model:</p>
        <span id="model"></span>
    </div>
    <script src="./index.js"></script>
</body>
</html>
 
// 方式一：Object.defineProperty
// 获取DOM节点
var view = document.getElementById('view');
var model = document.getElementById('model');
// 设置model对象
var data = {};
// 设置get函数的中转站，封装后可以去掉
let temp = 0;
//在data对象中定义number属性，并给他赋值两个访问器属性，来代理或者说劫持number的值的获取与设置
Object.defineProperty(data, "number", {
 //可枚举，这个主要是用来将Model显示在前端的，可以省去
    enumerable:true,
    // 获取值时的处理方法 就相当于代理执行获取值的操作，返回什么都又他决定，这里不能return data.number会造成无限循环的
    get: function () {
        return temp;
    },
    // data的number值发生变化时调用
    set: function (value) {
     // 改变View节点的值
        view.value = value;
        // 将值存在temp中，在get时要用到
        temp = value;
        // 这个主要是用来将Model显示在前端的，可以省去
        model.innerHTML = `"data":${JSON.stringify(data)}`;
    },
})
// 绑定事件，当view改变时将改变的值赋值给data对象中的number属性
view.addEventListener("keyup", function (event) {
    data.number = event.target.value;
})

// 方式二:Proxy()
// 这里只是为了前端展示model 可以省去
var model = document.getElementById('model');
// 所有dom的id
const domKeys =["username","password","sex"];
// 枚举信息 根据 {domkey:dom}
const domEnum = {};
// model
var data = {};
// proxy 代理整个data 
const proxy = new Proxy(data, {
 // taget 即为代理的对象 prop为属性值
    get: function (target, prop) {
        return target[prop];
    },
    // value为新值
    set: function (target, prop, value) {
        target[prop] = value;        
        domEnum[prop+'Dom'].value = target[prop];
        // 这里只是为了前端展示model 可以省去
        model.innerHTML = JSON.stringify(data);
    }
})
// 加上key事件
domKeys.forEach(item=>{
    const dom = document.getElementById(item);
    domEnum[item+'Dom'] = dom;
    dom.addEventListener("keyup", function (event) {
        proxy[item] = event.target.value;
    })
})
```

# 手写源码-JSON.stringfy()和JSON.parse()

```
if (!window.JSON) {
    window.JSON = {
        parse: function(jsonStr) {
            return eval('(' + jsonStr + ')');
        },
        stringify: function(jsonObj) {
            var result = '',
                curVal;
            if (jsonObj === null) {
                return String(jsonObj);
            }
            switch (typeof jsonObj) {
                case 'number':
                case 'boolean':
                    return String(jsonObj);
                case 'string':
                    return '"' + jsonObj + '"';
                case 'undefined':
                case 'function':
                    return undefined;
            }

            switch (Object.prototype.toString.call(jsonObj)) {
                case '[object Array]':
                    result += '[';
                    for (var i = 0, len = jsonObj.length; i < len; i++) {
                        curVal = JSON.stringify(jsonObj[i]);
                        result += (curVal === undefined ? null : curVal) + ",";
                    }
                    if (result !== '[') {
                        result = result.slice(0, -1);
                    }
                    result += ']';
                    return result;
                case '[object Date]':
                    return '"' + (jsonObj.toJSON ? jsonObj.toJSON() : jsonObj.toString()) + '"';
                case '[object RegExp]':
                    return "{}";
                case '[object Object]':
                    result += '{';
                    for (i in jsonObj) {
                        if (jsonObj.hasOwnProperty(i)) {
                            curVal = JSON.stringify(jsonObj[i]);
                            if (curVal !== undefined) {
                                result += '"' + i + '":' + curVal + ',';
                            }
                        }
                    }
                    if (result !== '{') {
                        result = result.slice(0, -1);
                    }
                    result += '}';
                    return result;

                case '[object String]':
                    return '"' + jsonObj.toString() + '"';
                case '[object Number]':
                case '[object Boolean]':
                    return jsonObj.toString();
            }
        }
    };
}
```



# 二、HTML

# 三、CSS

# CSS模块化

模块化进程:BEM、OOCSS、SMACSS、ITCSS，以及 CSS Modules 和 CSS-in-JS 等,目前主流的是CSS Modules 和 CSS-in-JS

**一、CSS 命名方法论**

通过人工的方式来约定命名规则.

> 社区在早期诞生了一些 CSS 命名方法论，如 BEM、OOCSS、SMACSS、ITCSS、SUITCSS、Atomic CSS 等

**1.BEM**

[BEM](https://link.segmentfault.com/?enc=yvW7zwnlxk23Je688mavOg%3D%3D.slTmHPfpl7kIEsnMLdKdGAX34lkMbtmb9JbNK731ieY%3D)（Block Element Modifier）是一种典型的 CSS 命名方法论，在 2009 年前提出，它的核心思想是 **通过组件名的唯一性来保证选择器的唯一性，从而保证样式不会污染到组件外**。

BEM 命名规约是 `.block-name__element-name--modifier-name`，即 `.模块名__元素名--修饰器名` 三个部分。也可以自定义

```
<!-- 示例模块 -->
<div class="card">
  <div class="card__head">
    <ul class="card__menu">
      <li class="card__menu-item">menu item 1</li>
      <li class="card__menu-item">menu item 2</li>
      <li class="card__menu-item card__menu-item--active">menu item 3</li>
      <li class="card__menu-item card__menu-item--disable">menu item 4</li>
    </ul>
  </div>
  <div class="card__body"></div>
  <div class="card__foot"></div>
</div>

.card {}
.card__head {}
.card__menu {}
.card__menu-item {}
.card__menu-item--active {}
.card__menu-item--disable {}
.card__body {}
.card__foot {}

使用sass更简单
.card {
  &__head {}
  &__menu {
    &-item {
      &--active {}
      &--disable {}
    }
  }
  &__body {}
  &__foot {}
}
```

**2.OOCSS**

[OOCSS](https://link.segmentfault.com/?enc=xQLxwsdZQTlZ9EndBOEWoA%3D%3D.TTDNApcr2Fzcm68Lm17UVrYSn8HEGzQf%2FoNpnsV7rzI%3D)（Object-Oriented CSS）即面向对象的 CSS，它借鉴了 OOP（面向对象编程）的抽象思维，主张将元素的样式抽象成多个独立的小型样式类，来提高样式的灵活性和可重用性。

OOCSS 有两个基本原则：

1. **独立的结构和样式**。即不要将定位、尺寸等布局样式与字体、颜色等表现样式写在一个选择器中。
2. **独立的容器和内容**。即让对象的行为可预测，避免对位置的依赖，子元素即使离开了容器也应该能正确显示。

```
<div class="size1of4 bgBlue solidGray mt-5 ml-10 mr-10 mb-10"></div>

<style>
  .size1of4 { width: 25%; }
  .bgBlue { background: blue; }
  .solidGray { border: 1px solid #ccc; }
  .mt-5 { margin-top: 5px; }
  .mr-10 { margin-right: 10px }
  .mb-10 { margin-bottom: 10px; }
  .ml-10 { margin-left: 10px; }
</style>
```

**3.SMACSS**

[SMACSS](https://link.segmentfault.com/?enc=EPc3pUkONY6IB98KLpzuqA%3D%3D.lzbwbQHlVHy4FEbypLaauwhxlu9zjTEjZwvnMALKmrM%3D)（Scalable and Modular Architecture for CSS）即可伸缩及模块化的 CSS 结构，由 Jonathan Snook 在 2011 年雅虎时提出。

SAMCSS 按照部件的功能特性，将其划分为五大类：

1. 基础（Base）是为HTML元素定义默认样式，可以包含属性、伪类等选择器。
2. 布局（Layout）会将页面分为几部分，可作为高级容器包含一个或多个模块，例如左右分栏、栅格系统等。
3. 模块（Module）又名对象或块，是可重用的模块化部分，例如导航栏、产品列表等。
4. 状态（State）描述的是任一模块或布局在特定状态下的外观，例如隐藏、激活等。
5. 主题（Theme）也就是换肤，描述了页面的外观，它可修改前面四个类别的样式，例如链接颜色、布局方式等。

SMACSS 推荐使用前缀来区分不同部件：

1. 基础规则是直接作用于元素的，因此不需要前缀。
2. 布局的前缀是 `l-` 或 `layout-`，例如 `.l-table`、`.layout-grid` 等。
3. 模块的前缀是 `m-` 或模块自身的命名，例如 `.m-nav`、`.card`、`.field` 等。
4. 状态的前缀是 `is-`，例如 `.is-active`、`.is-current` 等。
5. 主题的前缀是 `theme-`，例如 `.theme-light`、`.theme-dark` 等。

**4.ITCSS**

[ITCSS](https://link.segmentfault.com/?enc=7puURltb2DMR9OvLY0hagA%3D%3D.GwUjYal62vVu4Sr6ZC8rwf%2BOw1p35zkM4pnVHzNsoJs%3D)（Inverted Triangle CSS，倒三角 CSS）是一套方便扩展和管理的 CSS 体系架构，它兼容 BEM、OOCSS、SMACSS 等 CSS 命名方法论。ITCSS 使用 **分层** 的思想来管理你的样式文件，类似服务端开发中的 MVC 分层设计。

ITCSS 将 CSS 的样式规则划分成以下的几个层次：

1. Settings：项目使用的全局变量，比如颜色，字体大小等等。
2. Tools：项目使用的 mixins 和 functions。到 Tools 为止，不会生成具体的 CSS 代码。
3. Generic：最基本的设定，比如 reset.css、normalize.css 等。
4. Base：最基础的元素（elements），比如 img、p、link、list 等。
5. Objects：某种设计模式，比如水平居中，
6. Components：UI 组件，比如 button、switch、slider 等。
7. Trumps：用于辅助和微调的样式，只有这一层才可以使用 `!important`。

ITCSS 的分层逻辑越往下就越具体。

**二、CSS Modules**

一个 CSS 文件就是一个独立的模块，参考 [官网](https://link.segmentfault.com/?enc=BJsoEYOSyS57lkiwMJLYnw%3D%3D.vh2xxHkCWj%2BQKZpJsHXPIUajJVVSZjVjfBsemBR5r%2BVf%2BMc%2FDKvK9%2F0DpFE%2Bvo48) 或 [阮老师的《CSS Modules 用法教程》](https://link.segmentfault.com/?enc=eAUflHKK1qn8%2FThzUP%2FR4A%3D%3D.houo%2FuVymgDZkoWrMpZteijNiFDjiyLdtnAu6BLApoDkRFGoQNaOBxdP%2BWbZhEQW2K6zSg2WtRewaQE2ZAvtFQ%3D%3D)

CSS Modules 特性：

- **作用域**：模块中的名称默认都属于本地作用域，定义在 `:local` 中的名称也属于本地作用域，定义在 `:global` 中的名称属于全局作用域，全局名称不会被编译成哈希字符串。
- **命名**：对于本地类名称，CSS Modules 建议使用 camelCase 方式来命名，这样会使 JS 文件更干净，即 `styles.className`。
  但是你仍然可以固执己见地使用 `styles['class-name']`，允许但不提倡。🤪
- **组合**：使用 `composes` 属性来继承另一个选择器的样式，这与 Sass 的 `@extend` 规则类似。
- **变量**：使用 `@value` 来定义变量，不过需要安装 PostCSS 和 [postcss-modules-values](https://link.segmentfault.com/?enc=6qRrTvtCeBEVMSaZinCvdg%3D%3D.BsxZmhP%2B%2FpbLWFfYbVDqPIZBmsJe5BRIoBln8De8oK2zWQeSHOvH9swE3OwSdkhyqCwuM3aMzTXOJ6RfU48csw%3D%3D) 插件。

使用 CSS Modules 时，推荐配合 CSS 预处理器（Sass/Less/Stylus）一起使用。

**三、CSS-in-JS**

在 JS 中写 CSS

一些流行的 CSS-in-JS 库：

- styled-components：[https://github.com/styled-com...](https://link.segmentfault.com/?enc=a6xFyjud2eLVlZQ5W2dCTg%3D%3D.O8yGJpTGR78T%2BKlvrGFRBPIl4j%2FiRGbhKVzgBCPGSSJ64j1gwCSrPUB6llUvUK3Kpr8Cg54GUvbw%2FWGpy109zQ%3D%3D) 33k（**推荐**）
- emotion：[https://github.com/emotion-js...](https://link.segmentfault.com/?enc=jphqNJAWNp2wv3ZHyS7EJw%3D%3D.fClomBedJyIu9HKokNoSCK9GLiXBBXv4fTKTlOU%2FAG7xqOJgchIEiJBmrcV0GHf0) 13k
- Radium：[https://github.com/Formidable...](https://link.segmentfault.com/?enc=LLhYeIIgaa2Y8%2FuEt%2FLclQ%3D%3D.guROpM%2F6%2Fkr%2BVF3x6BM8ImnwLK8obWjQln7RtS5pfVtTiFbbf56YFAnt6Z0sJhPj) 7k（已不再维护）
- Styled System：[https://github.com/styled-sys...](https://link.segmentfault.com/?enc=zMezLar1YHL%2FZ6dm9trvQA%3D%3D.BGxU7DGdgNRUEXGxmjOFj9TyUSA9KoR9bkTn3r4OB5x0CJl62JwuBrj5E7VQBH5P) 7k
- styled-jsx：[https://github.com/vercel/sty...](https://link.segmentfault.com/?enc=AwZY8bwO%2BaDAicthXeRp3Q%3D%3D.egjjKkwkd7TwqJPL9flUk32UBBQfdSbsJo3cpC%2FrIz0dD%2Fhs97MBmYy%2BBxjDSayU) 6k
- JSS：[https://github.com/cssinjs/jss](https://link.segmentfault.com/?enc=3N%2F6ppz5NgJENbDap%2BSOvQ%3D%3D.aUwJeWyfzuONqE%2BD%2FeEbu%2Fsw1yB5qPNwV%2FxUkMAs3Bc%3D) 6k

**参考**

[[CSS 模块化方案探讨（BEM、OOCSS、CSS Modules、CSS-in-JS ...）](https://segmentfault.com/a/1190000039772466)](https://segmentfault.com/a/1190000039772466)

[CSS模块化演进](https://codechina.gitcode.host/programmer/fe/20-CSS-modularization.html#css-%E6%A8%A1%E5%9D%97%E5%8C%96%E6%BC%94%E8%BF%9B)

# BFC

**定义**

`BFC` 全称：`Block Formatting Context`， 名为 "块级格式化上下文"。

`W3C`官方解释为：`BFC`它决定了元素如何对其内容进行定位，以及与其它元素的关系和相互作用，当涉及到可视化布局时，`Block Formatting Context`提供了一个环境，`HTML`在这个环境中按照一定的规则进行布局。

一句话：`BFC`是一个完全独立的空间（布局环境），让空间里的子元素不会影响到外面的布局。

**触发BFC的css属性**

- overflow: hidden
- display: inline-block
- position: absolute
- position: fixed
- display: table-cell
- display: flex

**BFC规则**

- BFC是块级元素，会按照瀑布流的方式从上到下排列
- BFC是隔离容器，容器里的标签不受外部影响
- 同一个`BFC`下的两个相邻的标签外边距会发生重叠
- 计算`BFC`的高度时，浮动元素也参与计算

**BFC应用**

- 使用Float脱离文档流，高度塌陷，如清除浮动
- Margin边距重叠
- 两栏布局

# Float浮动

**定义**

一句话：让block元素无视float元素，让inline元素像流水一样围绕着float元素实现浮动布局

**float特性**

- 包裹性
- 高度塌陷
- 块状化
- 没有任何margin合并

> 1.包裹性,是指包裹和自适应。
>
> 包裹：将浮动元素父元素宽度设置为200px，浮动元素的子元素是一个128px宽度的图片，则此时浮动元素宽度表现为”包裹”，即包裹了子元素，宽度也是128px.一句话：对内，浮动元素被内部撑起最小值
>
> 自适应：浮动元素自适应父元素的200px，一句话：对外，浮动元素被内部撑起最大值是父元素容器

```
/* CSS代码 */
.father{
    border: 1px solid deeppink;
    width: 200px;
}
.son {
    float: left;
    font-size: 0;
    border: 1px solid blue;
    padding: 5px;
}
.father img {
    width: 128px;
}

/* HTML代码 */
<div class="father">
    <div class="son">
     <!--包裹-->
        <img src="../../lib/img/mm1.png">
        <!--自适应-->
        <span style="font-size: 12px">美女1，美女2，美女3，美女4，美女5，美女6，后宫1，后宫2，后宫3，后宫</span>
    </div>
</div>
```

> 2.高度塌陷
>
> 会让父元素的高度塌陷，即无法撑开父元素高度

> 3.块状化
>
> 浮动元素的display值就是block或者table。注意它不是真正的块状元素，只是有块状的属性，如可以设置宽高。
>
> 以下是冗余写法，浮动元素加display: block;

> 4.没有任何margin合并
>
> 设置了float属性的元素没有任何的margin重叠

**清除浮动**

注意浮动一直还在，并没有清除！只能清除浮动带来的影响。

- 父级盒子元素触发BFC，overflow:hidden,auto（完美方法）
- 浮动元素设置clear:both。本质是让自己不和float元素在一行显示，并不是真正意义上的清除浮动
  - 如果`clear:both`元素前面的元素就是float元素，则设置margin-top无效
  - `clear:both`后面的元素依旧可能会发生文字环绕现象

**参考**

[CSS 深入理解之 float 浮动](https://juejin.cn/post/6844903616155746312#heading-1)

# 三栏布局（圣杯、双飞翼等6种）

**float浮动**

```
<div id="left">left</div>
<div id="right">right</div>
<div id="middle">middle</div>

      #left,
      #right {
        width: 200px;
        height: 200px;
        background: red;
      }
      #middle {
        height: 200px;
        background: green;
      }
      #left {
        float: left;
      }
      #right {
        float: right;
      }
```

**position定位**

```
<div id="left">left</div>
<div id="right">right</div>
<div id="middle">middle</div>     
     
     #left,
      #right {
        width: 200px;
        height: 100%;
        background: red;
      }
      #left {
        position: absolute;
        left: 0;
        top: 0;
      }
      #right {
        position: absolute;
        right: 0;
        top: 0;
      }
      #middle {
        margin: 0 200px;
      }
```

**圣杯布局**

> 原理：将基本布局之后使用向左浮动，middle栏用padding留出两边位置，然后使用相对定位将左右两栏通过margin-left,margin-right到相应位置。

```
    <div class="wrapper">
      <div class="middle">middle</div>
      <div class="left">left</div>
      <div class="right">right</div>
    </div>
    
          .wrapper {
        /* 触发BFC,撑起mid，left,right高度*/
        overflow: hidden;
        /* 预留左右空间，等待left，right插入*/
        padding-left: 100px;
        padding-right: 100px;
      }
      .middle {
        float: left;
        width: 100%;
        background: #d9d9d9;
      }
      .left {
        float: left;
        width: 100px;
        background: #d5d60f;
        /*向左偏移100%，并且再偏移一个100px*/
        position: relative;
        margin-left: -100%;
        right: 100px;
      }
      .right {
        float: left;
        width: 100px;
        background: #8cc94c;
        /*右移100px*/
        margin-right: -100px;
      }
```

**双飞翼布局**

> 原理：将基本布局之后使用向左浮动，middle栏用margin留出两边位置，然后不使用相对定位，将左右两栏通过margin-left到相应位置。

```
    <div class="middle">
      <div id="middle-wrapper">middle</div>
    </div>
    <div class="left">left</div>
    <div class="right">right</div>
    
          .middle {
        float: left;
        width: 100%;
        background: #d9d9d9;
      }
      #middle-wrapper {
        margin-left: 100px;
        margin-right: 100px;
      }
      .left {
        float: left;
        width: 100px;
        background: #d5d60f;
        margin-left: -100%;
      }
      .right {
        float: left;
        width: 100px;
        background: #8cc94c;
        margin-left: -100px;
      }
```

|        | 优点                               | 缺点                     |
| ------ | ---------------------------------- | ------------------------ |
| 圣杯   | 使用padding，dom简单               | 中间宽度过小，会布局混乱 |
| 双飞翼 | 使用margin，支持各种宽高，通用型强 | dom复杂                  |

**Flex布局**

```
    <div class="main">
      <div class="left">left</div>
      <div class="middle">middle</div>
      <div class="right">right</div>
  </div>
  
    .main{
        display: flex;
        align-items: center;
    }
    .left{
        background: red;
        width: 200px;
        height: 300px;
    }    
    .right{
        background: blue;
        width: 200px;
        height: 300px;
    }
    .middle{
        background: green;
        height: 300px;
        width: 100%;
    }
```

**Grid布局**

```
    <div class="main">
      <div class="left">left</div>
      <div class="middle">middle</div>
      <div class="right">right</div>
  </div>
  
    .main{
        display: grid;
        height: 300px;
    }
    .left{
        background: red;
        grid-row:1;
        grid-column:1/2;
    }    
    .right{
        background: blue;
        grid-row:1;
        grid-column:4/5;
    }
    .middle{
        background: green;
        grid-row:1;
        grid-column:2/4;
    }
```



# 

# 伪类和伪元素

**伪类**

伪类即假的类，通常可以添加类来达到效果。伪类是选择器的一种，它用于选择处于特定状态的元素。它们表现得会像是你向你的文档的某个部分应用了一个类一样，帮你在你的标记文本中减少多余的类，让你的代码更灵活、更易于维护。伪类开头为冒号`:`

用户行为伪类，一些伪类只会在用户以某种方式和文档交互的时候应用。这些用户行为伪类，有时叫做动态伪类，如:hover，:focus。

> 常见伪类
>
> :active 在用户激活（例如点击）元素的时候匹配。
>
> :checked 匹配处于选中状态的单选或者复选框。
>
> :disabled 匹配处于关闭状态的用户界面元素
>
> :first-child 匹配兄弟元素中的第一个元素。
>
> :first-of-type 匹配兄弟元素中第一个某种类型的元素。
>
> :focus 当一个元素有焦点的时候匹配。
>
> :hover 当用户悬浮到一个元素之上的时候匹配。
>
> :last-child 匹配兄弟元素中最末的那个元素。
>
> :last-of-type 匹配兄弟元素中最后一个某种类型的元素。
>
> :is() 匹配传入的选择器列表中的任何选择器。
>
> :not 匹配作为值传入自身的选择器未匹配的物件。
>
> :nth-child 匹配一列兄弟元素中的元素——兄弟元素按照an+b形式的式子进行匹配（比如2n+1匹配元素1、3、5、7等。即所有的奇数个）。
>
> :nth-of-type 匹配某种类型的一列兄弟元素（比如，`<p>`元素）——兄弟元素按照an+b形式的式子进行匹配（比如2n+1匹配元素1、3、5、7等。即所有的奇数个）。
>
> :nth-last-child 匹配一列兄弟元素，从后往前倒数。兄弟元素按照an+b形式的式子进行匹配（比如2n+1匹配按照顺序来的最后一个元素，然后往前两个，再往前两个，诸如此类。从后往前数的所有奇数个）。
>
> :nth-last-of-type 匹配某种类型的一列兄弟元素（比如，`<p>`元素），从后往前倒数。兄弟元素按照an+b形式的式子进行匹配（比如2n+1匹配按照顺序来的最后一个元素，然后往前两个，再往前两个，诸如此类。从后往前数的所有奇数个）。
>
> :only-child 匹配没有兄弟元素的元素。
>
> :only-of-type 匹配兄弟元素中某类型仅有的元素。

**伪元素**

伪元素即假元素，需要通过添加元素才能达到效果。伪元素以类似方式表现，不过表现得是像你往文档中加入全新的HTML元素一样，而不是向现有的元素上应用类。伪元素开头为双冒号`::`

> 常见伪元素
>
> ::before在被选元素前插入内容,属性 `content` 是必须设置的，它的值可以为字符串，也可以有其它形式
>
> ::after在被元素后插入内容，属性 `content` 是必须设置的，它的值可以为字符串，也可以有其它形式
>
> ::first-line作用于第一行的所有字符
>
> ::first-letter作用于第一行的首字符

**伪类和伪元素的区别**

> - 伪类和伪元素都是用来表示文档树以外的"元素"。
> - 伪类和伪元素分别用单冒号`:`和双冒号`::`来表示。
> - 伪类和伪元素的区别，最关键的点在于如果没有伪元素(或伪类)，是否需要添加元素才能达到目的，如果是则是伪元素，反之则是伪类。

# sass（scss）、less、stylus、postcss

它们都是css预处理器。css预处理器的概念：CSS预处理器用一种专门的编程语言，进行Web页面样式设计，然后再编译成正常的CSS文件。

- sass:Sass是一种动态样式语言，Sass语法属于缩排语法，比css比多出好些功能(如变量、嵌套、运算,混入(Mixin)、继承、颜色处理，函数等)，更容易阅读。

  对Sass的缩排语法优化，用{}取代了原来的缩进，变成了Scss(sassy css)，与原来的语法兼容。变量符是$。

- less:也是一种动态样式语言. 受Sass影响较大,对CSS赋予了动态语言的特性，如变量，继承，运算， 函数。在客户端上和服务端都可以运行。变量符是@。

- Stylus：主要用来给Node项目进行CSS预处理支持。提供一个高效、动态、和使用表达方式来生成CSS，以供浏览器使用。支持缩进和CSS常规样式书写规则。写法更接近js,学习曲线陡峭。变量符是随意。

- PostCSS：它是一个对 CSS 进行处理的工具（平台），不能简单的把 PostCSS 归类成 CSS 预处理或后处理工具。PostCSS 一般不单独使用，而是与已有的构建工具进行集成。PostCSS 与主流的构建工具，如 Webpack、Grunt 和 Gulp 都可以进行集成。

# 过度、变形、移动、动画

| 属性               | 含义                                                         |
| ------------------ | ------------------------------------------------------------ |
| transition（过度） | 用于设置元素的样式过度，和animation有着类似的效果，但细节上有很大的不同 |
| transform（变形）  | 用于元素进行旋转、缩放、移动或倾斜，和设置样式的动画并没有什么关系，就相当于color一样用来设置元素的“外表” |
| translate（移动）  | 只是transform的一个属性值，即移动                            |
| animation（动画）  | 用于设置动画属性，他是一个简写的属性，包含6个属性            |

# 保险

惠泽
1.重疾
健康保2.0,保额30w,保费3119,交30年保终身

2.百万医疗
3.意外
4.寿险
定海柱1号，保额50w,保费565，交30年保30年

重疾-达尔文7号保额20w,保费2348,交30年保终身
百万医疗e享护-医享无忧保额400w,保费317,交1年保1年，续保20年
意外-小蜜蜂3号保额100w,保费296,交1年保1年

# 商转公

1.不用先结清贷款，除非贷款额度小于贷款金额，补个差价即可
2.咨询原商贷银行

# 易宝社保

深圳 社会保险缴费基数按照基本工资 合法吗?

您好，从规定上来看，是员工的收入。但是实践中，入职当年一般是员工的基本工资，不合规但也不能视为违法。第二年开始，调整社保基数的时候，以去年平均工资为准，当然，这个平均工资周期在各个地区可能不一样，但是原则上是平均工资大多数地区保持一致。

所以，若次年调整社保基数的时候，用人单位没有足额缴纳调整，建议您至社保监察大队投诉举报，而不是申请劳动仲裁，因为劳动仲裁不受理。

我的月薪一万，公司只按照最低的3360的基数交五险一金，现在公司应该补偿我多少差额呢？

你去举报，成功了公司会给你，但你也会被辞职，现在除了一些大公司，中小公司缴纳方式都这样，合理的规避支出。

本人退休两年后才发现用人单位没有按照当时的实际收入交纳社保，而是按基本工资交纳的社保，能举报和追诉补偿吗?

> ## **如果没有足额申报你的社保工资，员工该怎么办？**
>
> 1、对劳动者而言，缴纳社保的基数比实际工资少，相当于用人单位应缴纳的部分变少，劳动者可以去社保局投诉，社保局会责令用人单位补足。劳动者也可以因此解除劳动合同并要求[支付经济补偿](https://www.zhihu.com/search?q=支付经济补偿&search_source=Entity&hybrid_search_source=Entity&hybrid_search_extra={"sourceType"%3A"answer"%2C"sourceId"%3A1688749449})金。
>
> 2、对用人单位而言，未足额为员工缴纳社保违反[劳动法律](https://www.zhihu.com/search?q=劳动法律&search_source=Entity&hybrid_search_source=Entity&hybrid_search_extra={"sourceType"%3A"answer"%2C"sourceId"%3A1688749449})，会面临[行政处罚](https://www.zhihu.com/search?q=行政处罚&search_source=Entity&hybrid_search_source=Entity&hybrid_search_extra={"sourceType"%3A"answer"%2C"sourceId"%3A1688749449})。
>
> ## 法律依据：
>
> [劳动合同法](https://www.zhihu.com/search?q=劳动合同法&search_source=Entity&hybrid_search_source=Entity&hybrid_search_extra={"sourceType"%3A"answer"%2C"sourceId"%3A1688749449})：第三十八条 用人单位有下列情形之一的，劳动者可以解除劳动合同：（一）未按照劳动合同约定提供劳动保护或者劳动条件的；（二）未及时足额支付[劳动报](https://www.zhihu.com/search?q=劳动报&search_source=Entity&hybrid_search_source=Entity&hybrid_search_extra={"sourceType"%3A"answer"%2C"sourceId"%3A1688749449})酬的；（三）未依法为劳动者缴纳[社会保险费](https://www.zhihu.com/search?q=社会保险费&search_source=Entity&hybrid_search_source=Entity&hybrid_search_extra={"sourceType"%3A"answer"%2C"sourceId"%3A1688749449})的；（四）用人单位的规章制度违反法律、法规的规定，损害[劳动者权益](https://www.zhihu.com/search?q=劳动者权益&search_source=Entity&hybrid_search_source=Entity&hybrid_search_extra={"sourceType"%3A"answer"%2C"sourceId"%3A1688749449})的；（五）因本法第二十六条第一款规定的情形致使劳动合同无效的；（六）法律、[行政法规](https://www.zhihu.com/search?q=行政法规&search_source=Entity&hybrid_search_source=Entity&hybrid_search_extra={"sourceType"%3A"answer"%2C"sourceId"%3A1688749449})规定劳动者可以解除劳动合同的其他情形。
>
> [社会保险法](https://www.zhihu.com/search?q=社会保险法&search_source=Entity&hybrid_search_source=Entity&hybrid_search_extra={"sourceType"%3A"answer"%2C"sourceId"%3A1688749449})：第八十六条 用人单位未按时足额缴纳社会保险费的，由社会保险费征收机构责令限期缴纳或者补足，并自欠缴之日起，按日加收万分之五的[滞纳金](https://www.zhihu.com/search?q=滞纳金&search_source=Entity&hybrid_search_source=Entity&hybrid_search_extra={"sourceType"%3A"answer"%2C"sourceId"%3A1688749449})；逾期仍不缴纳的，由有关行政部门处欠缴数额一倍以上三倍以下的罚款。

小刘每月工资分成[基础工资](https://www.zhihu.com/search?q=基础工资&search_source=Entity&hybrid_search_source=Entity&hybrid_search_extra={"sourceType"%3A"answer"%2C"sourceId"%3A2429037353})、奖金、津贴、补贴等几部分，因[绩效考核](https://www.zhihu.com/search?q=绩效考核&search_source=Entity&hybrid_search_source=Entity&hybrid_search_extra={"sourceType"%3A"answer"%2C"sourceId"%3A2429037353})每个月的实际收入变化较大。为了确定社会保险费的缴费基数，公司与小刘约定以基础工资的标准作为缴纳社会保险费的基数。

这种做法是无效的，以约定缴费基数的方式缴纳社会保险费，违反了按工资总额及职工工资收入核定缴费基数的规定。

> 中华人民共和国[劳动法](https://www.zhihu.com/search?q=劳动法&search_source=Entity&hybrid_search_source=Entity&hybrid_search_extra={"sourceType"%3A"answer"%2C"sourceId"%3A2429037353})》第七十二条和《中华人民共和国社会保险法》第十二条规定，用人单位有按照本单位[职工工资总额](https://www.zhihu.com/search?q=职工工资总额&search_source=Entity&hybrid_search_source=Entity&hybrid_search_extra={"sourceType"%3A"answer"%2C"sourceId"%3A2429037353})，按比例足额缴纳社保的法定义务。足额包括[缴费年限](https://www.zhihu.com/search?q=缴费年限&search_source=Entity&hybrid_search_source=Entity&hybrid_search_extra={"sourceType"%3A"answer"%2C"sourceId"%3A2429037353})足、缴费险种足、缴费人数足、缴费数额足。
>
> 缴纳社会保险的缴费基数，国家有明确规定，按照职工上年度月平均工资性收入作为缴费基数，不得擅自提高或者降低。
>
> 当职工工资低于[社会平均工资](https://www.zhihu.com/search?q=社会平均工资&search_source=Entity&hybrid_search_source=Entity&hybrid_search_extra={"sourceType"%3A"answer"%2C"sourceId"%3A2429037353})60%的，应该按照社会平均工资的60%作为缴费基数，当职工工资高于社会平均工资300%的，按照社会平均工资的300%作为缴费基数。
>
> 而用人单位与劳动者在劳动合同中有关于“按社会保险规定最低参保基数缴纳社会保险费”的约定，该约定变更了社保费用缴纳标准，违反了相关的法律法规，是[无效条款](https://www.zhihu.com/search?q=无效条款&search_source=Entity&hybrid_search_source=Entity&hybrid_search_extra={"sourceType"%3A"answer"%2C"sourceId"%3A2429037353})。

> 首先，根据 **《关于规范社会保险缴费基数有关问题的通知》**（劳社险中心函【2006】60号）文件的规定，职工的社保缴费基数一般是按职工上一年度月平均工资（或个人上月工资）来确定， **职工工资越高，社保缴费基数就会越高。**
>
> 同时，文件也对缴费基数设置了天花板和木地板，具体来说：
>
> **下限：**缴费基数低于各地规定的最低缴费基数（当地社平工资的60%），就按照最低缴费基数缴纳社保；
>
> **上限：**如果缴费基数高于各地规定的最高缴费基数（当地社平工资的300%），就按照最高缴费基数缴纳社保。
>
> 所以说，最低工资标准仅是法律规定的社保缴费最低限额，不是缴费基数，按这个标准缴纳社保是不合法的。

> 根据各省市相关规定，要求社保缴费基数需要按照员工上一年度月平均工资为缴费基数缴纳社保。  除了各省市的调基通知，《劳动法》《中华人民共和国社会保险法》《社会保险费征缴暂行条例》以及《社会保险费征缴监督检查办法》都有明文规定。  企业无论是不按规定为员工缴纳社保，还是社保缴纳不足数，都属于违法违规行为。轻则罚款几百元，重则罚款数千元。  同时，相关监管部门还会责令企业限时整改。  更严重的是，根据《劳动保障监察条例》第二十七条，用人单位向社会保险经办机构申报应缴纳的社会保险费数额时，瞒报工资总额或者职工人数的，由劳动保障行政部门责令改正,并处瞒报工资数额1倍以上3倍以下的罚款。  与此同时，《社会保险领域严重失信人名单管理暂行办法》也有更为严格的要求与规定。  例如，第五条中提到，用人单位、社会保险服务机构及其有关人员、参保及待遇领取人员等，一旦涉及严重违规，县级以上地方人力资源社会保障部门，还可将其列入社会保险严重失信人名单。  由此可见，企业不按照规定给员工缴纳社保，风险多多。

> 公司一：  李四所处公司在北京，2021年度的月平均工资为35,000元。  按照上文中，社保缴费上限为31884/月执行。  那么，2022年调基后，公司按照31884元/月的缴费基数为李四缴纳社保费用就是合法的。  
>
> 公司二：  张三所处公司在北京，2020年度月平均工资为10000元。公司按照每月6000元的缴费基数为张三进行缴费。  根据《关于规范社会保险缴费基数有关问题的通知》（劳社险中心函【2006】60号）文件的规定，职工的社保缴费基数一般是按职工上一年度月平均工资（或个人上月工资）来确定。  那么这种做法就是不合法的，员工可能会要求企业进行补缴。 

> **按照深圳特区企业员工社会养老保险条例的规定，你每月1万元的月工资，这个月工资既低于上年度在岗职工月平均工资的300%，同时也高于深圳市的最低月工资标准2200元，企业按照2200元缴纳既违反了社保法，也不符合深圳特区养老保险的条例的规定，所以你离职以后，只要时间没有超过两年，就属于时效性的有效期内，既可以向深圳市相关的社保部门举报，也可以申请劳动仲裁，要求企业按照你每月1万元的实际工资进行补缴，完全是正当合法的，也是社保法赋予的你权利**

# 大崔哥-程序员之路

1.上午：做自己的事(算法)，不干公司的活

2.设计模式

3.TDD(Tasking任务拆分)

4.参与开源(适合自己难度等级)，做讲师。核心竞争力：解决问题背后的思考过程。



# 计算机网络

## 电脑是怎么把代码转换成可执行程序的

编译过程的5个阶段：词法分析；语法分析；语义分析与中间代码产生；优化；目标代码生成

编译器是一种翻译程序，它用于将源语言（程序设计语言写成）翻译为用二进制表示的伪机器代码程序，通常有两种方式进行翻译，一种是编译，另一种是解释。

> 想象你要制作一个鹰嘴豆泥食谱，但是它是用古希腊语写的。你不会讲古希腊语言，你可以通过两种方式遵循其指示。
>
> 首先是有人已经为你翻译成英文，你可以阅读食谱的英语版本，做鹰嘴豆泥。那么翻译的配方就是 *编译版本*。
>
> 第二种方法是，如果你有一位了解古希腊语的朋友，当你准备制作鹰嘴豆泥时，你的朋友会坐在你的旁边，将菜谱逐行翻译成英语。在这种情况下，你的朋友是食谱 *解释版本* 的解释者。

|      |                         编译型                         |                            解释型                            |
| :--: | :----------------------------------------------------: | :----------------------------------------------------------: |
| 特点 |   可直接执行，每次需要进行更改时，你都需要“重建”程序   |      一边编译一边执行，逐行解释，逐行执行程序的每个命令      |
| 优点 |                           快                           | 语言更加灵活，并且通常具有诸如动态键入和程序较小。解释器自己执行源程序代码，因此代码本身相对于平台是独立的 |
| 缺点 | 编译步骤需要额外的时间，生成的二进制代码对平台的依赖性 | 慢，因为在运行时翻译代码的过程增加了开销，并可能导致程序整体变慢。 |
| 举例 |            java,C，C ++，Erlang，Rust 和 Go            |               PHP，Ruby，Python 和 JavaScript                |

# 大话数据结构-待续

## 基本概念和术语

- 数据：描述客观事物，能被计算机识别的符号合集
- 数据元素：组成数据的基本单位
- 数据项：数据的分割的最小基本单位
- 数据对象：性质相同的数据元素的集合
- 数据结构：相互之间存在一种或多种关系的数据元素的集合

**数据结构分为逻辑结构和物理结构**

- 逻辑结构：数据元素之间的关系(集合结构、线性结构、树形结构、图形结构)
- 物理结构：数据元素在计算机中存储形式(顺序存储、链式存储)

## 算法

**算法是描述解决问题的方法**

算法的五个基本特性：

- 输入
- 输出
- 有穷性：有限的步骤
- 确定性：相同的输入对应唯一输出结果
- 可行性：每一步都可以通过有限次步骤完成

算法设计的要求：

- 正确性
- 可读性：便于阅读、理解、交流
- 健壮性：对于非法输入，也能处理
- 时间短存储低

常见时间复杂度

O(1)<O(logn)<O(n)<O(nlogn)<O(n^2)<O(n^3)<O(2^n)<O(n!)<O(n^n)

**通常，默认运行时间都是按照最坏情况执行。**

## 线性表

定义：零个或多个数据元素的有限序列。

线性表的顺序存储

- 优点：快速查询，元素之间的逻辑关系无需额外空间
- 缺点：插入和删除需要移动元素，扩容问题

线性表的链式存储-单链表



# 项目难点-Vue2的CSP安全策略

**总结**：因为看了Vue3的源码，基于Vue.js 3.0 的编译过程，发现它在离线编译的时候也会把结果编译成带前缀的，核心代码借过来，然后再做一些修改来支持自己特定的一些 feature，这个难题就被我解决了。

**背景**：今年1月份，在我们的 Web 项目中开启了 CSP 安全策略，其中把 `unsafe-eval` 从 `script-src` 中拿掉了，但是这么操作导致了一个很严重的问题，由于运行在 Web 的项目有一部分组件是通过 Vue.js 开发的，这部分代码全部不能正常工作了。

**问题**：目前老项目是直接通过 CDN 的方式引入 Vue.js，并在后端的 Java 模板中写组件的 template，然后用在运行时编译模板。我们知道编译的过程最后是生成一段 code 字符串，然后通过 `new Function` 的方式转成 render 函数，但是 CSP 安全策略开启后，`new Function` 和 `eval` 都被禁用了，导致整个编译后的流程不能进行下去。

**解决**：

- 使用 runtime-only 版本的 Vue.js，涉及大量使用vue.js的页面，成本高，短期实现不了
- 开发一个CSP 兼容版本的 Vue.js，但是到了 Vue.js 2.x 后，官方就不再提供 CSP 兼容版本了，因为从官方的视角看，我都提供了 runtime-only 版本的解决方案了，完全没必要提供 CSP 兼容版本了。

现阶段最小成本解决问题的方式就是使用一个 CSP 兼容版本的 Vue.js，所以只能魔改 Vue.js 了。

**一、new Function替换为notevil库** 

> `new Function` 不能用了，那么生成的 code 字符串如何执行呢？经过调研，我选用了 notevil 这个库。
>
> 它其实就是用 JavaScript 去实现 JavsScript 的解析引擎，大致原理是先把源码解析成 AST 树，再去遍历 AST 树，对不同类型的节点做不同的处理，达到最终执行 JavaScript 代码的目的。
>
> 但 notevil 的实现还是不够完整，致命的是对 `with` 的语法不支持。还如一些 ES6 的语法，像箭头函数、数组对象的解构赋值，是不支持的

Vue.js 2.x 组件模板最终编译的代码，是使用 `with` 语法做了一层包装：

```
<div>  
  {{ message }}
</div>
编译后：
with(this){return _c('div',[_v(_s(message))])}
```

Vue.js 为了让用户使用方便，在模板中访问数据不用手动加 `this`。Vue自己将this定义在组件实例上。

如果不用 `with(this)` 的话，我们需要生成如下的代码：

```
function(_ctx) {
  return _ctx._c('div,[_ctx._v(_ctx._s(_ctx.message))])
}
```

我们定义一个函数，接受一个 `_ctx` 参数，这个 `_ctx` 在运行时就是组件传入的实例对象 `this`。

这个时候，你可能会说，这有何难的，我们给所有的变量和函数的对象前面加上 `_ctx` 前缀不就可以了吗，但事情并没有你想的那么简单。**尤其对于复杂的表达式。**

**二、该加this的添加this**

Vue.js 2.x 的编译会经过三个过程：template 解析生成 AST ——> AST 优化 ——> AST 生成 code。我的思路是不改变这三个过程，最后追加一个转换生成的 code的过程。

具体思路：先把转换前的代码解析生成 AST，再去遍历这颗 AST，根据语法在相关的位置上加上前缀（修改 AST 的 节点），最后再把修改后的 AST 转换成代码。

- recast 库完成了code → AST 和 AST → code
- estree-walker 库去遍历 AST 的节点，通过一系列判断条件去判断这个节点需不需要加前缀

> 注意：
>
> 1.函数的参数不能加前缀，局部变量不能加前缀，全局内置变量不能加前缀，已经加过前缀的节点不能加前缀等。
>
> 2.函数嵌套函数，存在闭包情况。需要设计一个堆栈的数据结构，在函数进入入栈，函数退出出栈，如果是外层函数中定义的变量，内部函数是不能加前缀的。
>
> 3.recast、estree-walker 原本都是在 node.js 端跑的，为了让它们在前端运行，我也分别 clone 了它们的代码， 用 rollup 对它们做打包，并删除了内部一些 node only 的代码和一定程度的魔改，最终编译出一份在 web 端跑的代码，放到了 lib 目录。

为什么 Vue.js 编译生成的代码需要用 `with` 包一层？

缺点： 在 ECMAScript 5 的严格模式中是被禁用的。优点：利用 `with` 的特性动去指定的对象中查找即可，完全不用做多余的转换，也不用引入这些 AST 解析库了，因为引入这些库(recast,estree-walker)要让 Vue.js 最终打包的体积大了约四倍。

题外话

> 我们平时经常会强调技术选型的能力，其实技术选型的一个标准，就是你选择的第三方依赖，你能不能 hold 住。首先是你知道它的职责边界，知道它能做什么不能做什么，怎么利用它帮助你开发需求；其次是出了错你能不能快速定位到原因，知道是依赖的问题还是自身使用的问题；最后就是当它不能满足你的需求，并且官方不愿意解决或者不维护的情况下，你能不能去 fork 这个库，自己开发解决并实现。那么显然拥有这些能力就需要你对它的源码实现非常了解，所以这也是一些高阶岗位为什么会在面试中考察你对技术原理掌握的一方面原因

# TDD

## 前言

> 我从不觉得自己是一个好的程序员，甚至可能连合格都谈不上，不过在内心深处我却渴望着在编程这件事上获得成功。
>
> 可惜每次审视自己写的暂且称之为代码的东西，都会有挫折感，想重构却又感觉盘根错节，难以下手;想重写却又感觉自己好不容易写出来的，也花了不少心思，就这样丢弃心有不甘。
>
> 也曾思考过如何才能写好代码，有段时间觉得只有严格符合编程规范的代码才是好代码进而如同遵守戒律一样地字字斟酌，还有段时间觉得只有用上设计模式才能称之优秀代码进而非模式不用，一切套用模式。不过这些都没有让我走出开发的迷雾，永远是加不完的班，修不完的bug。
>
> 先测试后开发，小步迭代，持续集成。
>
> **测试先行**，其实讲的是需求边界，测试不是漫无目的而是精确计算成本的一项活动。测试从何而来，从需求来，需求推演出测试，也规划出产品边界，不能反映需求的测试是一种浪费，因此引申出开发需要讲求适当。开发是一项功利性的活动，永远都在追求盈利，而测试就一条红线，一旦跨过就意味着亏损。
>
> **小步迭代**，“让子弹飞”中有句话很经典:步子要一步一步迈，一步迈大了，咔，容易扯着蛋。代码堆叠的后遗症是复杂，复杂到没人愿意触碰，且不停地咒骂这代码有多烂，这是步子迈太大的真实写照。TDD讲求的小步迭代是写完一个测试再去写完一个实现，每个实现都是通过测试的，如此累加小胜为大胜，最后所有代码的收尾也不过是让最后一个测试通过而已，就是这样简单。
>
> **重构**，这是我最喜欢的部分，为啥？因为这里面所有的活动都会要求你去思考，且看上去都像是让你的代码向着大师级代码前进。漂亮的代码并不是堆砌各种技巧，而是在正确的时间，正确的地点做正确的事，重构很容易实现这个目标。重构是一件让人一旦开始就会欲罢不能的事，会让开发者在整个开发阶段都能够不停地去思考、实践再思考，直到无法再添加或删除一个字母。
>
> **持续集成**，你终究是需要交付产品的，产品就是客户需要的价值，就如同厨师终究会端出客人点的大餐一样，没有哪个厨师是把所有食材罗列着呈现给你的，而是混合在一起，蒸煮炖烧，有些食材需要先处理，这样吃起来才软硬适中，而有些则是最后下锅，这样吃起来才鲜嫩多汁，厨师就是这样一步步将食材集成起来，每一步的处理都是可用都是有价值的，都是为后续进行的铺垫。软件开发也一样，持续集成就要保证每一次的完成都是有价值都可以为后续提供支撑。
>
> TDD是一个很好的思维框架，如果非要教人一个思维框架的话就得教TDD， 不然人会瞎碰，不思考，不总结，不结果导向，靠灵感编程，凭直觉设计，撞大运修bug。最糟糕的是因为没有好的习惯 会接二连三的发生灵异现象。同一道题，习惯不好的人做，总能做出无数种新问题来。而且问题套问题，给他解决要浪费 我半天时间，如果他学会了TDD出的错只在最近一个引入的变化里，就好纠正多了。甚至他自己都能纠正。
>
> TDD重要的不是测试代码本身，是解决问题的思维，也许可以泛化，哪怕没测试，如果能够做到快速验证，反馈，价值的 稳定叠加，有足够信心，也未尝不可。也许你会说测试可以cover功能，那么如果只有这一点的话，我更喜欢BDD (behavior-driven development)，因为这具有用户最终的使用价值。如果你说快速定位bug，我们我更倾向于BDD (bug-driven development，自创的)。这写都是TDD的结果导致的好处所在，而价值反馈思维才是实现TDD背后原理。 TDD驱使我们以结果导向，使得我们简单设计(并不是无设计)，日常重构我们的代码库，注重交付价值流稳定叠加。

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

# TDD

**单元测试的上下文就是存在于「敏捷」当中**。敏捷为的是更快地交付有价值的可工作的软件。为此，它有一个指标来度量这个「更快」，那就是 lead time，它度量的是一个 idea 从提出被验证，到最终上生产环境面对用户的时间。显然，这个时间越短，软件获得反馈的时间就越短，对价值的验证就越快发生。

## 前言

以下几种情况可以不写单元测试：

- 业务部门不需要频繁上线，并且我有足够的人力来覆盖手工测试
- 不在意代码腐化，并且我也不做重构
- 不在意代码质量，好几个没有测试保护的 `if-else` 裸奔也不在话下，脑不好还做什么程序员
- 确有快速部署的需求，但我们不 care 质量问题，出回归问题就修

除此之外，你就需要写单元测试。如果你想随时整理重构代码，那么你需要写单元测试；如果你想有自动化的测试套件来帮你快速验证提交的完整性，那么你需要写单元测试。

## 测试分类

- 单元测试Unit
- 集成测试Integration
- 端到端测试E2E

其它的功能测试、UI 测试、界面测试只是它们中里面的一种。

[前端测试一共有哪几种？](https://www.51cto.com/article/707816.html)

## 选择测试框架

> Jest 是一个“零配置”的前端测试工具，具有诸如模拟和代码覆盖之类的开箱即用特性

我们团队对采用 JEST 做前端测试的结果非常满意。它提供了一种“零配置”的开发体验，并具备诸多开箱即用的功能，比如 Mock 和代码覆盖率等。你不仅可以将此测试框架应用于 React.js 应用程序，也可以应用于其他 JavaScript 框架。Jest 经常被炒作的功能之一是用户界面的快照测试。快照测试可以作为测试金字塔上层一个很好的补充，但请记住，单元测试仍然是坚实的基础。

Jest几大好处：

- Fast 天下武功，唯快不破。确实很快，虽然实测下来跟 [Mocha 新版本](https://github.com/mochajs/mocha/blob/master/CHANGELOG.md)还是慢了些，以后找个机会再测一次。
- Opinionated 不需要你做出选择和配置，就能提供所有的东西，比如 Mock（干掉 Sinon）、Test Runner（干掉 Karma）、Matcher（干掉 Chai）、Test Coverage（内置 istanbul）
- Watch Mode 守护模式。非常注重开发者体验，能够在编码的时候帮助我们快速获得测试结果的反馈。
- Snapshot Testing 快照测试。这是值得争议的一点，前文也提到过会专门开个 issue 来讨论，在此不再赘述。

## 参考

[Vue 应用单元测试的策略与实践 01 - 前言和目标](https://blog.jimmylv.info/2018-09-19-vue-application-unit-test-strategy-and-practice-01-introduction/)

# 开源项目

## 如何给开源项目贡献代码

> 对有些项目是可以的，但是对有些项目不行，因为你如果merge了已经fork的仓库，会产生merge commit，你再pull request的时候，源仓库的管理人员会退回你的request，因为他们想要保持git history干净整洁，你应该用git rebase自己的分支，这样你提交上去后人家才愿意合并（前提是你的改动是已经被接纳）。可以看看github的help页面有详细解释。

## 参考

[开源指北-科普](https://oschina.gitee.io/opensource-guide/guide/%E7%AC%AC%E4%B8%80%E9%83%A8%E5%88%86%EF%BC%9A%E5%88%9D%E8%AF%86%E5%BC%80%E6%BA%90/%E7%AC%AC%201%20%E5%B0%8F%E8%8A%82%EF%BC%9A%E4%BB%80%E4%B9%88%E6%98%AF%E5%BC%80%E6%BA%90/#%E5%BC%80%E6%BA%90%E7%9A%84%E6%A6%82%E5%BF%B5)

# 源码-Vue3.0-mini-vue

## 尤大手写mini-vue

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

# DefineProperty对比Proxy

Vue普遍走的就是数据劫持方式。不同的在于使用DefineProperty还是Proxy。也就是一次一个属性劫持还是一次劫持一个对象。

Proxy/Reflect是在ES2015规范中加入的，Proxy可以更好的拦截对象行为，Reflect可以更优雅的操纵对象。 优势在于：

- 针对整个对象定制 而不是对象的某个属性，所以也就不需要对keys进行遍历。

- 支持数组,这个DefineProperty不具备。这样就省去了重载数组方法这样的Hack过程。

- Proxy 的第二个参数可以有 13 种拦截方法，这比起 Object.defineProperty() 要更加丰富

- Proxy 作为新标准受到浏览器厂商的重点关注和性能优化，相比之下 Object.defineProperty() 是一个已有的老方法

- 可以通过递归方便的进行对象嵌套。

# 书单

## 前端

[黑马程序员pink](https://www.bilibili.com/video/BV14J4114768)

[黑马程序员JavaScript核心教程](https://www.bilibili.com/video/BV1k4411w7sV)

[Vue-**电商平台数据可视化实时监控系统-Echarts-vue**](https://www.bilibili.com/video/BV1bh41197p8)

[**Vue源码解析**](https://www.bilibili.com/video/BV1op4y1h7Fv)

## Java

[**尚硅谷宋红康老师的 Java 零基础视频**](https://www.bilibili.com/video/BV1Qb411g7cz)

[**尚学堂高琪老师的Java视频**](https://www.bilibili.com/video/BV1ct411n7oG)

[**求知课堂2019Java入门视频**](https://www.bilibili.com/video/BV1CJ411m7gg)

[**尚硅谷Java8新特性**](https://www.bilibili.com/video/BV1ME411y7Ce)

[**B站最强的Java项目-谷粒商城**](https://www.bilibili.com/video/BV1np4y1C7Yf)

## 数据结构与算法

[**青岛大学王卓老师**](https://www.bilibili.com/video/BV1nJ411V7bd)

[**清华邓俊辉老师**](https://www.bilibili.com/video/BV1jt4y117KR)

[Y神的背包九讲](https://www.bilibili.com/video/BV1qt411Z7nE)

## 操作系统

[清华大学陈老师](https://www.bilibili.com/video/BV1uW411f72n)

[**哈工大李治军**](https://www.bilibili.com/video/BV1d4411v7u7)

## 计算机网络

[**韩立刚老师**](https://www.bilibili.com/video/BV1Qr4y1N7cH)

[**计算机网络微课堂**](https://www.bilibili.com/video/BV1c4411d7jb)

## 数据库

[**尚硅谷的MySQ入门视频 + 高级篇**](https://www.bilibili.com/video/BV12b411K7Zu)

[**黑马的MySQL实战教程**](https://www.bilibili.com/video/BV1vi4y137PN)

[**尚硅谷MySQL数据库高级教程**](https://www.bilibili.com/video/BV1KW411u7vy)

## Linux

[**韩顺平 一周学会Linux**](https://www.bilibili.com/video/BV1Sv411r7vd)

[**尚硅谷Linux教程**](https://www.bilibili.com/video/BV1dW411M7xL)

## 爬虫

[**崔庆才老师**](https://www.bilibili.com/video/BV1a7411f76Z)

# 信息获取-阅读-处理

# 前言

**知识的层级**可分为[资料](https://zh.wikipedia.org/wiki/资料)、[资讯](https://zh.wikipedia.org/wiki/資訊)、[知识](https://zh.wikipedia.org/wiki/知识)及[智慧](https://zh.wikipedia.org/wiki/智慧)四个阶段，

知识的形成则是透过收集一些资料，再从资料中找出有用的资讯，利用这些资讯加上自己的想法及做法，最后产生出知识。

智慧则是以知识为基础加上个人的应用能力并将其运用于生活上。

举例来说，我们制做一份报告时，会先收集大量的资料，再从这堆资料中找出可以运用在报告的资讯，运用自己的想法和做法去完成报告，当你完成这份报告后，从报告中所学习到的东西便会转化成自己的知识。

把个人及群体得到的知识进行有效管理，则是知识管理最根本的目的。

## 获取

**信息分类**

- **即时信息：**主要指各种即时资讯，以短讯形式出现的信息。
- **社交信息**：在社交媒体上关注或者订阅的人提供的信息。比如，微信公众号、微博、推特、即刻。
- **工作信息**：在工作中遇到、需要进行留存 / 处理的信息。
- **深度信息**：一些需要深度阅读，满足自我提升等需求的信息。比如，来自少数派、财新周刊的内容。

**工具**

- 搜索引擎：百度搜索、谷歌搜索、必应搜索、雅虎搜索

- 聚合搜索导航：虫部落-快搜、医学导航、设计导航等

- 被动收取：RSS 订阅(pc推荐google插件feedbro+rsshub,app推荐NetNewWire)、邮件订阅

**操作**

- 早上：微信公众号，比如每日早报、新华社· 早知天下事、人民日报·新闻早班车、每日资讯简报、财经早餐、Wind 资讯
- 接着：今日趋势APP和今日热榜APP

**优质信息源推荐**

## 阅读

**工具**

- 简悦

## 处理

**工具**

- notion：黑鲸知识库
- 印象笔记：标签知识库

# 面试

## 谈薪

- 先出价者输

**先出价者输**

切记不要先出价，这也是HR会直接问你期望薪资的原因，泄露低价就会被对方处处拿捏。你可以装糊涂，看我的演技。哎呀，我好久没出来面试了，咱们也是第一家，我也不太清楚现在是啥行情呀，咱们这个岗位的薪资范围是多少呀。或者是直接反问，咱们这个岗位的薪酬结构，年终奖股票，工作强度等细节，以及岗位薪资的范围。

这样就有两种结局：一个是HR会给你一个薪资范围，我们直接基于这个数字来判断是否符合预期。第二个是HR也是个老司机，也一样打太极回来，那就没办法了。

首先你得知道你到底值多少钱，这个数字你说了不算，市场说了算。我建议大家每个季度没事就面试几次，不吐工作，就图和面试官学习技术 外加上和HR谈谈钱，你就时刻知道自己的身价，然后加上你合理的涨幅，在高出10%左右的留给对方砍价，报出去也是可以的。

如果对方爽快答应，直接入职，如果不合理，也不要怂，直接礼貌且坚定的告诉对方，我很认可贵公司的发展前景，但是现在这个offer的薪资和我的预期还是有一些差距，看能否给到XX呢，我个人的发展方向和这个岗位的匹配度非常高，我相信入职以后我也一定能够带来符合这个薪资的作用，或者是你有其他特殊的优势，比如如果是Vue岗位，你给Vue贡献过代码等等

还有很多其他的谈判原则，比如坚决不接收对方的第一次开价，以降价换取成交是条走向灭亡之路,学会装作意外和不情愿，要防止红鲱鱼糖衣炮弹的攻击等等技巧，大家感兴趣可以去读这两本书

## 互联网公司黑名单

[程序员找工作黑名单](https://github.com/shengxinjing/programmer-job-blacklist)

# 通用命名规范

## 命名规则

默认规则是camelCase(小驼峰)

PascalCase(大驼峰): 各个单次首字母大写

camelCase(小驼峰)：首个单词首字母小写，其余单词首字母大写

**命名实践如下：**

- **目录或项目命名**：全小写，连接符(-, _)，如/project-athena
- **组件名**：大驼峰，如KeepLive.vue
- **js,ts文件名**：小驼峰
- **class命名**
  - 基于姓氏命名法（继承 + 外来），modulename，modulename_info，modulename_info_user
  - 嵌套层次最多3层，超过3层或名字过长，新开作用区间，取缩写miu_tit，miu_tit_co
- **变量**：小驼峰
  - 布尔类型：需要有含义的前缀，比如`has, is, wether, can, should`等，如isVisited
  - 数组复数：需要标识复数的结尾，比如s或list
- **函数**：小驼峰
- **常量**：全大写，连接符(_)，如MAX_IMAGE_SIZE 
- 注释：单行用//,多行用/**/

**前缀含义如下：**

| 动词 | 含义                            | 返回值                                                |
| ---- | ------------------------------- | ----------------------------------------------------- |
| can  | 判断是否可执行某个动作 ( 权限 ) | 函数返回一个布尔值。true：可执行；false：不可执行     |
| has  | 判断是否含有某个值              | 函数返回一个布尔值。true：含有此值；false：不含有此值 |
| is   | 判断是否为某个值                | 函数返回一个布尔值。true：为某个值；false：不为某个值 |
| get  | 获取某个值                      | 函数返回一个非布尔值                                  |
| set  | 设置某个值                      | 无返回值、返回是否设置成功或者返回链式对象            |

## 参考

[阿里前端命名规范](https://developer.aliyun.com/article/850913#slide-1)

[不要在sass嵌套过深](http://mydearxym.github.io/2016/09/22/not-nest-in-sass/)

[sass的ClassName命名](https://guide.aotu.io/docs/name/classname.html)

# 代码规范

## 拒绝屎山代码

- TypeScript不要用成AnyScript
- 代码不要太长
- 组件和方法解耦
- 使用 `Mutable Data`响应式数据
- 多用魔术字符串即枚举
- 多尝试不同的方式来解决相同的问题

**TypeScript不要用成AnyScript**

> 如果充分发挥 `AnyScript` 的宗旨，意味着你很轻松地就让代码增加了 `30%` 毫无用处但也挑不出啥毛病的代码，这些代码甚至还会增加项目的编译时间（毕竟增加了`ts`校验和移除的成本嘛）

**代码不要太长**

> 单文件不超过400行，函数不超过100行

**组件和方法解耦**

> 组件优先使用pros和emit,回避vuex

**使用 `Mutable Data`响应式数据**

> 只需要三个单词：`Watch`、`Watch`、`Watch`

**多用魔术字符串即枚举**

```
enum EventType {
  Move,
  Skip,
  Batch
}
```

**多尝试不同的方式来解决相同的问题**

比如vue不只有template，还有render

# inject/provide的响应式问题

官方说法： **provide/inject** 的 **直接绑定数据** 才不支持响应式，但又因为 **没有对数据的进行深层次处理**，所以原有的响应式数据才会继续触发整个响应式系统的改变。

说人话：直接修改对象，inject监听不到改动；修改对象的某个属性，就能监听到改动。加一句，即使修改属性，computed也监听不到变化。

看源码:关闭了依赖数据的 响应式依赖收集;但对inject注入对象的深层处理，没有屏蔽响应式

```
export function initInjections(vm: Component) {
  // 对inject注入对象深层处理，没有屏蔽响应式
  const result = resolveInject(vm.$options.inject, vm)
  if (result) {
  // 关闭了依赖数据的 响应式依赖收集
    toggleObserving(false)
    Object.keys(result).forEach(key => {
      if (__DEV__) {
        defineReactive(vm, key, result[key], () => warn(''))
      } else {
        defineReactive(vm, key, result[key])
      }
    })
    toggleObserving(true)
  }
}
export function resolveInject(inject: any, vm: Component): Record<string, any> | undefined | null {
  if (inject) {
    const result = Object.create(null)
    const keys = hasSymbol ? Reflect.ownKeys(inject) : Object.keys(inject)

    for (let i = 0; i < keys.length; i++) {
      const key = keys[i]
      if (key === '__ob__') continue
      const provideKey = inject[key].from
      if (provideKey in vm._provided) {
        result[key] = vm._provided[provideKey]
      } else if ('default' in inject[key]) {
        const provideDefault = inject[key].default
        result[key] = isFunction(provideDefault) ? provideDefault.call(vm) : provideDefault
      } else if (__DEV__) {
        warn('')
      }
    }
    return result
  }
}
```

**参考**

[Vue 2 阅读理解（十四）之 Provide/Inject 依赖注入](https://juejin.cn/post/7135761522759827493)

# 设计模式

## 设计原则

核心五大原则：SOLID、DRY、KISS、YAGNI、LOD

### **SOLID**原则

- SRP(Single Responsibility Principle) 单一职责
- OCP(Open Closed Principle) 开闭原则
- LSP(Liskov Substitution Principle) 里氏替换
- ISO(Interface Segregation Principle) 接口隔离
- DIP(Dependency Inversion Principle) 依赖倒置/依赖反转

**一、SRP(Single Responsibility Principle) 单一职责**

定义：一个类或模块只负责完成一个功能

理解：不要设计大而全的类，要设计粒度小、高性能单一的类。该原则的目的是为了实现代码高内聚、低耦合、提高代码复用性、可读性以及可维护性。

补充：在保证单一职责时，要避免过分拆分，否则会降低内聚性，影响代码可维护性。

以下场景可能会出现类没有指责单一：

> - 类中的代码行数、函数、属性是否过多。可以考虑对该类进行拆分；
> - 类依赖的其他类过多，或者依赖类的其他类过多，不符合高内聚、低耦合的设计思想；
> - 私有方法过多，可以考虑将私有方法独立到新类中，设置为 public 方法，提高代码复用性；
> - 当发现类名比较难命名或类名笼统、冗长时，说明该类职责定义不够清晰；
> - 类中大量方法集中操作某几个属性时，可以考虑将这几个属性和方法拆分出去；

举例：

```
/**
* 如果下面的用户信息类仅在一个场景中使用，则没有什么问题；
* 如果后面用户的地址信息在其他模块中使用时，就可以将地址信息进行拆分。
* 以及各个属性的操作方法都要进行聚合到一个类中，提高代码的维护性。
*/
data class UserData(val userId:Long, 
                    val userName:String, 
                    val email:String,
                    val telephone:String,
                    val provinceOfAddress:String,
                    val cityOfAddress:String,
                    val regionOfAddress:String,
                    //.....其他属性
                   )
```

**二、OCP(Open Closed Principle) 开闭原则**

定义：(模块、类、方法)对拓展开放，对修改关闭。

理解：对于新功能尽量通过拓展已有代码而非修改的方式完成。

补充：在开发中不需要识别、预留所有拓展点，切勿过度设计。最合理的做法是，保证短期内、可确定的部分进行拓展设计。做常用的代码扩展性的方法：多态、依赖注入、基于接口开发，以及部分设计模式(装饰、策略、模板、责任链、状态等)

举例：

```
/**
* 基于接口开发。对于外部调用者，内部逻辑是无感知的，方便后面进行逻辑拓展，例如国内更新逻辑后面可能会支持跳转指定应用商店、H5链接等。
*/
interface IUpgradeService{
  fun checkUpgrade(ctx:Activity)
}

abstract class BaseUpgradeService : IUpgradeService{
  override fun checkUpgrade(ctx:Activity){
    //网络请求
    //....
    //执行需要更新
    startUpgrade()
  }
  
  fun startUpgrade()
}

class CnUpgradeService : BaseUpgradeService{
  override fun startUpgrade(){
    //国内执行更新逻辑。例如应用内下载安装等
  }
}

class I18nUpgradeService : BaseUpgradeService{
  override fun startUpgrade(){
    //海外执行更新逻辑。例如跳转google play
  }
}

//实际执行Activity
class MainActivity : AppCompactActivity{
  override fun onCreate(savedInstanceState : Bundle){
    super.onCreate(savedInstanceState);
    setContentView(R.layout.activity_main);
    //执行更新逻辑
    ServiceLoader.instance.load(IUpgradeService::class.java).checkUpgrade(this)
  }
}
```

**三、LSP(Liskov Substitution Principle) 里氏替换**

定义：子类对象能够替换程序中父类对象出现的任何地方，并保证原来程序的逻辑行为不变及正确性不被破坏。

理解：在代码中可以用子类来替换父类，和多态类似，区别在于“里氏替换原则”是子类不能违背父类的协议，如父类要实现的功能、入参、出参、异常情况等。

举例：

```
/**
* 下面代码违反里氏替换原则。因为父类并没有对参数进行校验和抛异常，子类违背了父类的协议(入参判断、异常情况)。
*/
class UpgradeService{
  fun checkUpgrade(ctx: Activity, appId:Int, channelId:Int){
    //... 检查逻辑
  }
}

class CnUpgradeService : UpgradeService{
  override fun checkUpgrade(ctx: Activity, appId:Int, channelId:Int){
    if(appId == 0 || channelId == 0){
      throw Exception(...);
    }
    //...国内检测逻辑
  }
}
```

**四、ISO(Interface Segregation Principle) 接口隔离**

定义：客户端(接口调用者)不应该被强迫依赖它不需要的接口。

理解：与“单一职责”类似，区别在于“单一职责”针对的是模块、类、接口的设计，“接口隔离”一方面更侧重于接口的设计，另一方面思考的角度不同。

补充：这里的“接口”可以理解为：①一组API接口集合；②单个API接口或函数；③OOP中的接口概念

举例:

- 一组API接口集合

```
/**
* 下面代码违背了接口隔离原则。
* 因为后期新增的删除接口，对外所有服务都可以调用，非常容易导致误操作场景。
* 在没有做鉴权时，建议将删除接口单独做一个接口服务，供特殊场景使用。
*/
interface UserService{
  fun register(userName:String, password:String):Boolean
  fun login(userName:String, password:String):Boolean
  
  //后期新增了删除用户信息的接口
  fun deleteUserById(userId:Long):Boolean
}
```

- 单个API接口或函数

```
enum class ComputeType{
    ADD,
    SUBTRACT, 
    MULTIPLY , 
    DIVIDE
}

/**
* 假设下面代码每一种计算方式都比较复杂，则违背了接口隔离原则。
* 如果逻辑复杂的情况下，建议将每种情况作为一个单独的接口或函数进行处理。
* 例如:
* fun dataAdd(){}
* fun dataSubtract(){}
*/
fun dataCompute(firstNum:Int, secondNum:Int, computeType:ComputeType): Int{
  retrun when(computeType){
    ComputeType.ADD -> //....
    //....
  }
}
```

- OOP中的接口概念

```
/**
* 尽量避免设计大而全的接口，大而全会导致强迫调用者依赖不必要的接口
* 例如下面接口，如果调用者只是想配置监控和更新，还必须空实现配置日志数据。推荐根据功能进行拆分。
*/
interface IConfig{
  //更新配置信息
  fun update()
  //配置日志输出
  fun outputLog():String
  //配置监控
  fun monitorConfig()
}
```

**五、DIP(Dependency Inversion Principle) 依赖倒置/依赖反转**

定义：高层模块不依赖低层模块，它们共同依赖同一个抽象，抽象不要依赖具体实现细节，具体实现细节依赖抽象。

理解：该原则用于指导框架层面的设计，调用者与被调用者没有直接依赖关系，而是通过一个抽象(规范)来建立关系，同时抽象(规范)不依赖具体的调用者和被调用者的实现细节，而调用者和被调用者需要依赖抽象(规范)。例如，暴露请求参数，由调用者来实现具体的请求，并将结果再返回。

**控制反转(IOC)、依赖反转(DIP)、依赖注入(DI)的区别与联系**

- 控制反转：提供一个可拓展的代码骨架，用来组装对象、管理整个执行流程。不是一种具体的实现技巧，而是一种设计思想，一般用于指导框架层面的设计，具体的方式有很多，例如依赖注入、模板模式等。

```
abstract class TestCase{
  fun run(){
    if(doTest()){
      println("Test success")
    }else{
      println("Test failed")
    }
  }
  
  abstract fun doTest():Boolean
}

class UserServiceTest: TestCase{
  override doTest():Boolean{
    //....控制逻辑
  }
}

fun main(){
  UserServiceTest().run()
}
```

- 依赖注入：不通过 new()方式在类内部创建依赖类对象，而是将依赖的类对象在外部创建好后，通过构造函数、函数参数等方式传递(或注入)给类使用。

```
//Notification类使用通过构造函数传入的类对象messageSender调用发送逻辑
class Notification(val messageSender: MessageSender){
  fun sendMessage(cellphone: String, message: String){
    messageSender.send(cellphone, message)
  }
}

interface MessageSender{
  fun send(cellphone: String, message: String)
}

class SmsSender: MessgeSender{
  override fun send(cellphone: String, message: String){
    //...短信通知逻辑
  }
}

class EmailSender: MessageSender{
  override fun send(cellphone: String, message: String){
    //...邮件通知逻辑
  }
}

fun main(){
  val messageSender = SmsSender()
  val notification = Notification(messageSender)
  notification.sendMessage("xxxxx","xxxxx")
}
```

- 依赖反转：高层模块(调用者)不要依赖底层模块(被调用者代码)。高层模块和底层模块赢通过抽象来互相依赖。除此之外，抽象不要依赖具体实现细节，具体实现细节依赖抽象。

```
//抽象层
interface ISendTypeConfig{
    fun httpRequest(params: String)
    fun socketRequest(params: String)
}
//底层模块逻辑
class SendTypeManager(private val config: ISendTypeConfig){
    fun sendMessage(sendByHttp:Boolean, params: String){
        if (sendByHttp){
            config.httpRequest(params)
            return
        }
        //使用socket进行消息发送
    }
}

//高层模块逻辑
class SendTypeConfig: ISendTypeConfig{
    override fun httpRequest(params: String) {
        //使用http请求
    }

    override fun socketRequest(params: String) {
        //使用socket请求
    }

}

fun main(){
    //这段代码属于[底层模块]逻辑。高层模块只需关注消息发送方式的具体实现，然后调用底层模块的发送消息即可，不会关注底层模块的具体实现。
    SendTypeManager(SendTypeConfig()).sendMessage(true, "这是一条http发送的消息")
}
```

### DRY原则

(Don't Repeat Yourself)原则，不要重复自己

理解：不要开发重复代码，可以复用或提取公共代码，同时也要注意遵守“单一职责”和“接口隔离”原则。

提升代码复用性的方法：

- 减少代码耦合
- 满足单一职责原则
- 模块化
- 业务与非业务逻辑分离
- 通用代码下沉
- 继承、抽象、多态、封装
- 应用模板等设计模式

### KISS原则

(Keep It Simple And Stupid)原则

理解：尽量保证代码简洁，使用通用技术(同事都懂的技术)、不重复造轮子、不过度优化。

举例：对于某个数值的提取或者匹配判断，使用正则表达式可以使代码行数更少，看似更简单，但其实并不是所有同事都熟悉正则表达式，而且在编写正则规则时易出现bug，所以可以采用通用技术来实现。

### YAGNI原则

(You Aint't Gonna Need It)原则，你不会用到它的

理解：不去设计与开发当前功能用不到的代码，但并不意味着不考虑拓展性，可以预留好拓展点，后面需要时再开发。

举例：目前项目只对国内市场，未来将会面向国内海外同时使用。所以在开发中不需要提前编写海外部分代码，但是在国内海外有差异的逻辑上要预留好拓展点，方便后面对海外逻辑进行补充。

### LOD原则/迪米特法则

(Law of Demeter)原则/迪米特法则

理解：不该有直接依赖关系的类之间，不要有依赖；有依赖关系的类之间，尽量只依赖必要的接口。

举例：

```
/**
* NetworkTransporter 类负责底层网络通信，根据请求获取数据。
*
* 该类的入参类型为 HtmlRequest 对象，作为底层类，应保证通用性，而不是仅服务于下载HTML。所以违反了迪米特法则，依赖了不该有直接依赖的 HtmlRequest 类。
*/
public class NetworkTransporter {
    // 省略属性和其他方法...
    public Byte[] send(HtmlRequest htmlRequest) {
      //...
    }
}

public class HtmlDownloader {
  private NetworkTransporter transporter;//通过构造函数或IOC注入
  
  public Html downloadHtml(String url) {
    Byte[] rawHtml = transporter.send(new HtmlRequest(url));
    return new Html(rawHtml);
  }
}

/**
* Document 表示网页文档，后续的网页内容抽取、分词、索引都是以此为处理对象。
*
* 该类总有如下3个问题:
* 1. 构造函数中的 downloader.downloadHtml() 逻辑复杂，耗时长，不应该放到构造函数中，会影响代码的可测试性。
* 2. HtmlDownloader 对象在构造函数中通过 new 来创建，违反了基于接口而非实现编程的设计思想，也会影响到代码的可测试性。
* 3. 从业务含义上来讲，Document 网页文档没必要依赖 HtmlDownloader 类，违背了迪米特法则。
*/
public class Document {
  private Html html;
  private String url;
  
  public Document(String url) {
    this.url = url;
    HtmlDownloader downloader = new HtmlDownloader();
    this.html = downloader.downloadHtml(url);
  }
  //...
}
```

# 反对Vue2升级到Vue3

最近一篇反对**Vue2**升级到**Vue3**的文章在vue官方社区引起了热议。（原文链接：[Vue 3 was a mistake that we should not repeat](https://link.juejin.cn/?target=https%3A%2F%2Fmedium.com%2Fjs-dojo%2Fvue-3-was-a-mistake-that-we-should-not-repeat-81cc65484954)）

原作者主要的问题，是从Vue3**突破性**的改变以及**周边生态圈**未能及时跟上的角度，重点强调了迁移升级**成本**+**风险**较大。

关于升级成本问题：尤大也承认了**Vue3**升级体验并没有想象中的那么流畅，**Vue4**会吸取经验，做好平稳迭代。

**一、破坏性的api变更（Breaking changes）**

**[Events API](https://link.juejin.cn?target=https%3A%2F%2Fv3-migration.vuejs.org%2Fbreaking-changes%2Fevents-api.html)的弃用让这个问题首当其冲**。Vue实例再也不能作为**事件总线**做事件通信，`$`on，`$`off，`$`once的彻底**移除**意味着之前所有有关代码都必须重新推翻重写，虽然有很好的插件工具让这件事变得没那么复杂，但是仍然会带来不小的迁移成本。

**代码构建问题。** 你会经常遇到用Vue2写法写出来的代码在**构建(build)** 失败或抛出**警告**。因为这些api写法在Vue3中已经被废弃。这问题在已存在的大型项目中的尤为突出下图展示了一部分**Breaking changes**，可以看到破坏性的api变更数确实很多：

**二、颠覆式的设计模式（composition-api）**

颠覆式的**composition-api**慢慢向**面向函数**思想转变，导致很多原有习惯于**options-api**的开发者反感Vue正在像react靠拢，没有坚持住Vue特色。它提出了一种新的基于函数的 Vue 组件编写方式，引起了Vue社区大量的争议和分裂，甚至将社区分隔为两种观点阵营针锋相对，最终导致了[Vue 最黑暗的一天事件](https://link.juejin.cn?target=https%3A%2F%2Fdev.to%2Fdanielelkington%2Fvue-s-darkest-day-3fgh)。这很令人沮丧。

**三、生态系统（The ecosystem）**

生态系统和框架本身一样重要。因为没有**责任机制**，在有争议的决定和在弃用功能的时候，很多框架周边的生态系统的许多贡献者会被迫**离开**，并导致许多库被**放弃**或者**延迟更新**。很多时候，我们没有办法做版本兼容时，我们往往只能把责任归咎于，开源库缺乏**同理心**和对大局的理解。

**四、文档系统（Documentation）**

在我们的日常开发中，尤其是在使用框架时，我们会遇到各种各样的问题，这时我们时常需要**google**或者**问答社区**作为帮手，但是目前关于**Vue**搜索出来的结果几乎全是Vue2的结果

**五、过往案例（The past）**

过渡到 Vue 3 看起来很像从*AngularJS*过渡到*Angular*（*版本 1⇒ 2*）。大量的延迟和重大更改导致了挫败感，最终 Angular 失去了对 React 和 Vue 的吸引力。

**尤大的回复：**

> 1.当我们进行版本切换时，所有核心库和工具都与这两个版本兼容（或为 Vue 2/3 支持提供单独的版本）。
>
> 实际上阻碍升级的依赖都是第三方，主要是 **Nuxt** 和 **Vuetify**。
>
> 2.实际使用过 Composition API + < script setup> 的用户在真是开发中的反馈非常积极，证明这是一个有价值的补充，现在他们中的许多人更喜欢它而不是 Options API。
>
> 我们当然可以更好地处理新 API 的引入，但仅仅因为存在争议，并不意味着它是错误的或者不必要的。实际上，引入大的、新的想法的行为，势必会让那些喜欢呆在舒适区的人感到不安，但如果我们迎合这种心态，就永远不会取得真正的进展。
>
> 3、4.虽然我们确实创造了 Vue CLI、Vuex、Vetur 和 VuePress 的新替代品，但它们本身都有适用于 Vue 3 的版本。
>
> 5.关于和angular的过往对比：
>
> - 没有可比性，不能拿Vue升级和angularjs -> angular做对比。
>
> - Angular 和 AngularJS 是根本不同的框架。几乎没有共享交集，除了完全重写之外没有实际的迁移路径。
>
> - 有许多生产 Vue 2 应用程序成功迁移到 Vue 3 的案例。很容易吗，确实不是，但是他们都迁移成功了。
>
> 6.我们同意，Vue3升级体验并没有想象中的那么流畅。Vue 将随着吸取的经验不断发展，我们绝对不打算在未来的Vue4中，进行这样的破坏性重大升级。

**参考**

[Vue2升级到Vue3到底是不是一个正确的选择？(尤雨溪亲自回复解读)](https://juejin.cn/post/7117525259212816414#heading-1)

# Vue2和Vue3比较

## Option API和Composition API

**vue2 Option API**

```vue
<template>
  <div>
    <p>{{ person.name }}</p>
    <p>{{ car.name }}</p>
  </div>
</template>

<script>
export default {
  name: "Person",

  data() {
    return {
      person: {
        name: "小明",
        sex: "male",
      },
      car: {
        name: "宝马",
        price: "40w",
      }
    };
  },

  watch:{
      'person.name': (value) => {
          console.log(`名字被修改了, 修改为 ${value}`)
      },
      'person.sex': (value) => {
          console.log(`性别被修改了, 修改为 ${value}`)
      }
  },

  methods: {
    changePersonName() {
      this.person.name = "小浪";
    },

    changeCarPrice() {
      this.car.price = "80w";
    }
  },
};
</script>
```

**vue3 Composition API**

```vue
<template>
  <p>{{ person.name }}</p>
  <p>{{ car.name }}</p>
</template>

<script lang="ts" setup>
import { reactive, watch } from "vue";

// person的逻辑
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

// car的逻辑
const car = reactive<{ name: string; price: string }>({
  name: "宝马",
  price: "40w",
});
function changeCarPrice() {
  car.price = "80w";
}
</script>
```

# Vue高效代码

- 多用Array.includes()
- 提前退出/提前返回。如果不使用，可能有多层if
- 用字面量替代switch,如用obj的属性取值替代switch

**提前退出/提前返回**

```
a({type}={})=>{
 if(!type) return 'no type';
 if(type==='dog') return 'is dog';
 return type
}
```

# this用法

**this经典面试题**

```
  // 谁调用我，我就指向谁
  var name = 222
  var a={
    name:111,
    say:function(){
      console.log(this.name);
    }
  }
  var fun = a.say
  fun() // fun.call(window)
  a.say() // a.say.call(a)

  var b={
    name:333,
    say:function(fn){
      fn(); // fn.call(window),难点
    }
  }
  b.say(a.say) // 相当于把函数当进去执行，这种函数作为入参的，都是指向全局window，所以就是fn.call(window)
  b.say=a.say

  b.say() // b.say.call(b)
```

# github优秀仓库

**后端**

- [JavaGuide](https://github.com/Snailclimb/JavaGuide)
- [CS-Notes](https://github.com/CyC2018/CS-Notes)
- [advanced-java](https://github.com/doocs/advanced-java)
- [JCSprout](https://github.com/crossoverJie/JCSprout)
- [technology-talk](https://github.com/aalansehaiyang/technology-talk)
- [fullstack-tutorial](https://github.com/frank-lam/fullstack-tutorial)
- [3y](https://github.com/ZhongFuCheng3y/3y)
- [java-bible](https://github.com/biezhi/java-bible)
- [interviews](https://github.com/kdn251/interviews/blob/master/README-zh-cn.md)
- 

**算法**

- [LeetCodeAnimation](https://github.com/MisterBooo/LeetCodeAnimation)
- [awesome-java-leetcode](https://github.com/Blankj/awesome-java-leetcode)
- [leetcode](https://github.com/azl397985856/leetcode)
- [瓶子君](https://www.pzijun.cn/blog/)
- [GitHub上最火的、最值得前端学习的数据结构与算法项目](https://github.com/FrontEndGitHub/FrontEndGitHub/issues/2)
- [awesome-coding-js算法](https://github.com/ConardLi/awesome-coding-js)

# 面试清单

[一行命令爬取掘金文章榜单](https://github.com/shfshanyue/blog/blob/master/post/juejin-interview.md)

[github更多面试题](https://github.com/search?o=desc&p=1&q=%E5%89%8D%E7%AB%AF%E9%9D%A2%E8%AF%95&s=&type=Repositories)

[FrontEndGitHub-前端尤其Issues](https://github.com/FrontEndGitHub/FrontEndGitHub)

[Front-end-Developer-Questions-前端面试问题](https://h5bp.org/Front-end-Developer-Interview-Questions/translations/chinese/#js-questions)

[Daily-Question-大厂每日一题](https://q.shanyue.tech/)

[CS-Interview-Knowledge-Map-前端进阶之道](https://github.com/InterviewMap/CS-Interview-Knowledge-Map)

[Daily-Interview-Question-木易杨前端进阶](https://muyiy.cn/question/)

[fe-interview-大前端面试宝典](https://lucifer.ren/fe-interview/#/)

[fe-interview-前端硬核面试](https://github.com/biaochenxuying/blog/blob/master/interview/fe-interview.md#js-%E7%BB%8F%E5%85%B8%E9%9D%A2%E8%AF%95%E7%9F%A5%E8%AF%86%E6%96%87%E7%AB%A0)

[fe-interview-前端知识每日3+1](http://www.h-camel.com/index.html)

[node-interview-饿了么大前端](https://github.com/ElemeFE/node-interview/tree/master/sections/zh-cn)

[Front-End-Interview-Notebook-前端复习笔记](https://github.com/CavsZhouyou/Front-End-Interview-Notebook)

[FE-Interview-前端面试星球](https://github.com/lgwebdream/FE-Interview)

[javascript-guidebook-JavaScript知识图谱](https://tsejx.github.io/javascript-guidebook/basic-concept)

[前端收集图谱](https://github.com/foru17/front-end-collect)

[阿秀的学习笔记](https://github.com/forthespada/InterviewGuide)

[前端进阶之旅](https://github.com/poetries)

[冰雨博客](https://bingyu123.gitee.io/blog/web/base/html/)

[前端那些事](https://jonny-wei.github.io/blog/base/)

[进击的大前端](http://www.dennisgo.cn/Articles/Engineering/leader.html)

[前端系统进阶](https://interview.poetries.top/fe-blog-docs/blog-docs/javascript/-Ajax%E6%80%BB%E7%BB%93%E7%AF%87.html)

[前端九部-入门指南](https://www.yuque.com/fe9/basic/cg6wui)

[前端语音社群](https://github.com/febobo/web-interview)

[阿离王](https://github.com/347830076/)

[前端自我修养](https://fe.mbear.top/)

[maqixiang的学习](http://study.maqixiang.com/blog/20201026.html)

[TeqNG](https://www.teqng.com/homev1/)

[Nealyang-一个优秀的前端都应该阅读这些文章](https://github.com/Nealyang/PersonalBlog/issues/48)

**其他更精彩**

[2020 - 2021 年 Web 前端最新导航](https://segmentfault.com/a/1190000033134496)

[GitHub 上能挖矿的神仙技巧 - 如何发现优秀开源项目](https://github.com/biaochenxuying/blog/issues/45)

[恕我直言，你可能连 GitHub 搜索都不会用 - 如何精准搜索的神仙技巧](https://github.com/FrontEndGitHub/FrontEndGitHub/issues/4)

# Resume

## 准备阶段

### 简历

**个人信息**

- 冷熊/男/1990
- 本科/北极大学计算机系
- 工作年限：3年
- 微博：[@Easy](http://weibo.com/easy) （如果没有技术相关内容，也可以不放）
- 技术博客：http://old.ftqq.com ( 使用GitHub Host的Big较高 )
- Github：http://github.com/easychen ( 有原创repo的Github帐号会极大的提升你的个人品牌 )
- 期望职位：web高级程序员

主要技术栈：React技术栈、Rax、weex、Kissy、Flutter、Koa、Midway、Ts 等等

涉及领域：pc 页面、手机客户端（目前主要是手淘）、Flutter（FlutterGo 主开发者）、研究性项目后台开发等

**项目经历**

a项目(2022.6-2023.1)

**工作经历**

**开源项目**

**项目层次**

- PC: toC 项目，主要为重客户端状态较为复杂的项目，以前端主要形态为卖点的产品，比如文档类，表格类，API调试类，思维导图类，笔记类。可将该类项目放在首位。另外，还有电商类、股票类等。或者官网。

- RN(react native)/Electron/Browser-Extension: 手机应用、桌面应用、浏览器插件等跨端能力

- Mobile/小程序: 移动端 Web 项目

- Admin: 后台管理系统

- Node: BFF 类项目，或者 Node.js 的纯后端项目

- Infra: 在公司内部所做的基础建设，比如 Package 的发包，组件库的建设，脚手架的编写，公司公共能力抽象为私有库之类。甚至是 lint/type 等 dot 文件的规则建立

**注意点**

- 过时技术栈不要写，比如 jQuery/Bootstrap
- 项目难点，项目亮点，合并集中描述
- 不要写和自己工作经验不符的内容，比如工作五年了，简历还都是熟悉 HTML，CSS 
- 了解、熟悉、掌握、精通四个等级，一般不建议写精通
- 不要光秃秃地写一句“熟悉数据结构与算法”,比如我熟悉十大排序中的快排、归并、堆排

**级别**

- 初级：基础的编码能力和思维
- 中级：熟练使用基础，独立完成任务
- 高级:通过封装、优化手段，提升小组效率
- 资深高级：工程化
- 专家:大前端体系架构

## 投递阶段

### **分2阶段**

- 试水阶段，投递其它城市岗位此时可一周面试一到两次，在面试中完善八股文以及简历，用时三周左右。脱产者可一周面试两到三次。若有 offer，可选择价高者接收一个，方便为正式面试议价。

  一定要投可线上面试的公司

  一定不要投中大厂，容易弄花简历

- 正式阶段，投递心仪公司岗位，或托人内推。此时态度要虚心，诚恳，提前花费一个小时了解其公司（或业务线）业务、商业模式、产品形态，以及公司所需的技术栈等。在 Boss 直聘或邮件投递简历时，可发表一些对技术栈匹配，业务感兴趣且强烈加入的意愿。

**邮件投递**

> 尊敬的米哈游公司人力资源部：
>
> 我是一个热爱米哈游游戏的前端工程师，特别喜欢原神这款游戏，已经玩了两年。在这两年里，我对原神的设计、游戏体验、以及技术实现等方面有了深入的了解，对这款游戏充满了热爱和敬仰。
>
> 因此，我强烈想加入米哈游公司，一起打造更好的原神。我相信，我的专业知识和技能可以为米哈游公司的发展做出贡献，同时，我也期待能够在这里得到成长和提高。
>
> 我拥有丰富的游戏开发经验，熟悉游戏引擎、美术设计、以及游戏编程等方面的技能。我对游戏设计和开发有着独特的见解，并能够灵活地运用到实际工作中。同时，我也具备出色的团队合作精神和良好的沟通能力，可以与团队成员高效协作，完成共同的目标。
>
> 如果米哈游公司有合适的职位空缺，我表示愿意投递我的简历并参加面试。随附的附件中包含了我的详细简历和作品集，希望能给您带来更多的了解。如果需要更多的信息或证明，我随时准备提供。
>
> 我对加入米哈游公司充满了热忱和期待，相信我能够成为您们团队中的一员，为原神的发展做出更多的贡献。
>
> 谢谢您的耐心阅读，期待您的回复。
>
> 此致 敬礼！
>
> 山月

## 面试阶段

不要裸辞 不要裸辞 不要裸辞

### 面试时间

1. 公司会议室面试。不过对心理素质要求极高。
2. **约到晚八点面试**。可早点下班在家中面试，如家里较远无法赶回去，可在公司会议室面试。甚至订一个公司附近的钟点房，进行面试。

### **离职原因**

年终季度奖全部取消，公司业务停滞，无上升空间，于是主动出来，并放弃 N+1，来寻求更好的机会。

### 自我介绍

时间1-3min,准备几个亮点，不要背简历

> 1. 自己的经历和优势。
> 2. 自己做过的项目中的难点，怎么思考和解决的。
> 3. 自己的重大业绩，突破性成果，包括工作和学习。
> 4. 对面试的公司的理解和认识，如果有独特的理解肯定会加分。
> 5. 比赛成绩，国内排名，开源项目。

# 移动端

## 基础

**跨平台、跨端**

- 跨平台：指跨操作系统
- 跨端：指跨web,ios,android,iot设备

# 前端工程化

按照项目的生命周期来分配：

- 需求评审：技术选型
- 开发前：统一规范
- 开发中：模块化、组件化
- 开发完：测试
- 编译：构建工具
- 部署：自动化部署
- 上线后：性能监控
- 发现问题：性能优化
- 项目迭代：重构
- 项目巨型化：微服务
- 无服务架构升级：Serverless 

## 技术选型

- 可控性
- 稳定性
- 适用性
- 易用性

**可控性**

可控，就是指如果这门技术因为 BUG 对项目造成了影响，团队中有人能够解决它，而不是等待官方修复。作为技术团队的负责人，一定要是能够兜底的那个人。如果团队解决不了，你必须能够解决。比如魔改vue,react

**稳定性**

稳定性，表示一门技术更新迭代比较稳定，不会有特别大的修改，比较靠谱。即使有，也很容易做到向后兼容（迁移简单、成本小）。

有两个很典型的反例，那就是 Angular 和 python。例如 python2 升级到 python3，除了语法、API 不兼容之外，python3 的各个版本之间也有差异，直到现在才逐渐稳定下来。

稳定性判断：

> 1. 社区是否活跃、配套插件是否丰富。
> 2. 是否经常维护，可以通过 git commit 查看。
> 3. 官方文档是否齐全。
> 4. 更新是稳定、小步的迭代，而不是非常激进的更新。

**适用性**

适用性，是指需要根据业务场景和团队成员来选择技术。

适用性判断：

> 1. 业务的生命周期：短期js，长期推荐ts
> 2. 业务的兼容性：ios,android，iot,不能有死机、白屏、卡顿
> 3. 团队成员：选择约束性比较强的技术是一个更好的选择，如ts(不会就去学)。要用长远的眼光来为团队考虑，太过自由的技术，往往会造成灾难。

**易用性**

学习曲线相对平缓，而不是陡峭的

## 统一规范

- 代码规范
- git规范
- 项目规范
- UI规范

**代码规范**

- 代码格式
- 命名规范
- 文档注释

出名的js规范：

> - [airbnb (101k star 英文版)](https://github.com/airbnb/javascript)，[airbnb-中文版](https://github.com/lin-123/javascript)
> - [standard (24.5k star) 中文版](https://github.com/standard/standard/blob/master/docs/README-zhcn.md)
> - [百度前端编码规范 3.9k star](https://github.com/ecomfe/spec)

出名的css规范：

> - [styleguide 2.3k star](https://github.com/fex-team/styleguide/blob/master/css.md)
> - [spec 3.9k star](https://github.com/ecomfe/spec/blob/master/css-style-guide.md)

**git规范**

- 分支管理规范
- git commit规范

**项目规范**

- npm管理
- pnpm管理

**UI规范**

- 统一命名
- 统一样式

## 模块化、组件化

- 高内聚 低耦合
- 模块化、组件化
- Web Components

**高内聚 低耦合**

高内聚：一个函数尽量只做一件事，如注册模块，只处理注册逻辑

低耦合：两个模块之间的关联程度低，如注册模块调用其他模块，直接引用其他模块即可，不要直接在注册模块中写其他功能

**模块化、组件化**

模块化：拆分html,css,js，按照功能拆分模块

组件化：按照功能拆分为各个组件

**Web Components**

目前三大框架在构建工具下可很好实现组件化，但如果自己实现呢？

组件化是前端未来的发展方向，[Web Components ](https://developer.mozilla.org/zh-CN/docs/Web/Web_Components)就是浏览器原生支持的组件化标准。使用 Web Components API，浏览器可以在不引入第三方代码的情况下实现组件化。

## 测试

原则：程序简单，不用测试代码；功能越复杂，越需要测试代码(如果修改一个复杂项目，你要对所有功能都点击一遍，但有了测试代码，一条命令执行就行)

- 单元测试Unit
- 集成测试Integration
- 端到端测试E2E

## 构建工具

- webpack
- rollup
- vite

## 自动化部署

- Gitea + Jenkins
- Github Actions

## 性能监控

- 事前预警
- 事后分析

**数据上报**

- [sendBeacon](https://developer.mozilla.org/zh-CN/docs/Web/API/Navigator/sendBeacon)
- [XMLHttpRequest](https://developer.mozilla.org/zh-CN/docs/Web/API/XMLHttpRequest)
- image

## 性能优化

- 加载时优化
- 运行时优化

**加载时优化**

- 白屏时间
- 首屏时间

**运行时优化**

## 重构

**定义**

《重构2》定义：

> 所谓重构（refactoring）是这样一个过程：在不改变代码外在行为的前提下，对代码做出修改，以改进程序的内部结构。重构是一种经千锤百炼形成的有条不紊的程序整理方法，可以最大限度地减小整理过程中引入错误的概率。本质上说，重构就是在代码写好之后改进它的设计。

重构和性能优化都在不改变程序功能的情况下修改代码

- 重构：为了让代码变得更加容易理解、易于修改
- 性能优化：为了让程序运行得更快

**重构的原则**

1. 事不过三，三则重构。即不能重复写同样的代码，在这种情况下要去重构。
2. 如果一段代码让人很难看懂，那就该考虑重构了。
3. 如果已经理解了代码，但是非常繁琐或者不够好，也可以重构。
4. 过长的函数，需要重构。
5. 一个函数最好对应一个功能，如果一个函数被塞入多个功能，那就要对它进行重构了。（4 和 5 不冲突）
6. 重构的关键在于运用大量微小且保持软件行为的步骤，一步步达成大规模的修改。每个单独的重构要么很小，要么由若干小步骤组合而成。

**重构手法**

在[《重构2》](https://book.douban.com/subject/30468597/)这本书中介绍了上百种方法，其中8种比较常用：

1. 提取重复代码，封装成函数
2. 拆分功能太多的函数
3. 变量/函数改名
4. 替换算法
5. 以函数调用取代内联代码
6. 移动语句
7. 折分嵌套条件表达式
8. 将查询函数和修改函数分离



## 微服务

- 小应用，建议还是单独建一个项目开发
- 大应用，使用微前端可以减少开发维护成本

## Serverless 

**定义**

无服务架构。是指由第三方云计算供应商以服务的方式为开发者提供所需功能，例如数据库、消息，以及身份验证等。它的核心思想是让开发者专注构建和运行应用，而无需管理服务器。

优点：

> - 自动扩展伸缩、无需自己管理

缺点：

> - 云上访问速度变得比较慢

**分类**

- Faas(Function as a Service) 函数即服务
- Baas(Backend as a Service) 后端即服务

Faas 其实是一个云计算平台，用户可以将自己写的函数托管到平台上运行。而 Baas 则是提供一系列的服务给用户运用，用户通过 API 调用。

**Faas**

定义

> 一个函数通常用于处理某种业务逻辑，例如一个 `abs()` 函数，它将返回所传参数的绝对值。我们可以把这个函数托管到 Faas 平台，由平台提供容器并运行这个函数。当执行函数时，只需要提供函数所需的参数，就可以在不部署应用的情况下得到函数的执行结果。

**Baas**

定义

> 假设你是一个前端，现在要开发一个网站。前端部分你可以自己完成，但后端部分怎么办呢？这个时候就可以使用 Baas 了。也就是说，你只需编写和维护前端页面。其他的一切，例如数据库、身份验证、对象存储等等都由云服务商提供。你只需要在前端通过 API 调用它们就可以使用所需的服务。

**参考**

[带你入门前端工程化](https://woai3c.github.io/introduction-to-front-end-engineering/12.html#faas)

# Typora常用用法

```
1.代码段
{% codeblock %}
{% endcodeblock %}

2.图片
{% img /img/20200302_1_9.png  "imgPIC'alt text'" %}

3.加粗
**加粗**

4.链接
{% link 深入理解分布式事务 http://wwwe/distributed-transaction.html [external] [title] %}

5.点点
- 风格1
- 风格2

6.换行符
末尾两个空格表示换行

7.本地图片使用服务器绝对路径
C:\Users\fuyunjinglong\AppData\Roaming\Typora\typora-user-images\
/img/

8.竖线段落
使用>回车即可
```



