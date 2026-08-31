---
title: JS
date: 2018-01-01 07:33:16
categories:
- A_初级
toc: true # 是否启用内容索引
---

# 初级

## 编译型与解释型

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

## 数据类型

8 种数据类型，其中 7 种是基本类型，1 种是引用类型

- 7基本类型：Number,String,Boolean,Null,undefined,symbol(ES6),BigInt(ES2020)
- 1引用类型：只有 Object 这一种。日常用的 Array（数组）、Function（函数）、Date（日期）、RegExp（正则）等，本质上都是 Object 的派生实例。

**💡 面试官可能追问及加分项：**

> **追问1：为什么 `0.1 + 0.2 !== 0.3`？如何解决？**
> 回答思路：计算机底层使用二进制表示小数，有些十进制小数（如 0.1）在二进制中是无限循环的。IEEE 754 标准在截断尾数时会产生精度丢失。解决方法通常是将小数乘以 10 的幂次方转为整数计算，然后再除回去；或者使用 `Number.EPSILON` 设置一个极小的误差范围来判断是否相等。
>
> **追问2：`undefined` 和`null` 有什么区别？**
> 回答思路：
>
> - 语义不同：`undefined` 系统默认值。如变量声明未赋值、函数无返回值、对象属性不存在。`null` 手动赋值。表示“此处应该有值，但现在为空”，常用于初始化或释放对象引用。
> - 类型转换不同：转换为数字时，`Number(undefined)` 是 `NaN`，而`Number(null)` 是 `0`。
> - 类型判断：`typeof undefined` 结果是 `'undefined'`。`typeof null` 结果是 `'object'`（这是 JS 的历史遗留 Bug）。
>
> **追问3：说一下 Symbol 的应用场景？**
> 回答思路：主要用于防止对象属性名冲突。例如在第三方库扩展对象属性时使用 Symbol 作为 key，或者在实现类的私有属性/方法时使用。此外，JS 内部很多内置行为也依赖 Symbol（如 `Symbol.iterator` 决定对象是否可被 `for...of` 遍历）。

## 类型判断

**1. `typeof` 操作符**

> - **原理**：在 JS 底层实现中，变量在机器码中存储的类型标签的前 3 位决定了 `typeof` 的返回值。
> - **优点**：能够精准判断所有的原始类型（除了 `null`），并且能识别出 `function`。
> - 缺点：
>   - `typeof null` 会返回 `'object'`（这是 JS 早期的历史遗留 Bug，因为 null 的机器码前三位和 object 一样都是 000）。
>   - 对于引用类型（如 Array、Object、RegExp），除了 function 会返回 `'function'` 外，其他的都会返回 `'object'`，无法进一步细分。
> - **适用场景**：常用于判断原始类型，以及判断某个变量是否为函数。

**2. `instanceof` 操作符**

> - **原理**：其内部运行机制是检查右边构造函数的 `prototype` 属性，是否出现在左边对象的原型链上。
> - **优点**：能够准确区分引用类型（如 `[] instanceof Array === true`）。
> - 缺点：
>   - 无法判断原始类型（如 `'abc' instanceof String === false`，除非用 `new String('abc')` 创建）。
>   - 只要是在原型链上的构造函数，都会返回 true（例如 `[] instanceof Object === true`），不够精准。
> - **适用场景**：主要用于判断引用类型的实例，特别是在涉及原型链继承的场景中。

**3. `constructor` 属性**

> - **原理**：当实例对象被创建时，其内部会指向它的构造函数。
> - **优点**：似乎既能判断原始类型，又能判断引用类型。
> - **缺点**：非常不安全。因为 `constructor` 指向是可以被随意修改的（比如在写原型继承时常常会重写 `prototype`，导致 `constructor` 丢失或指向错误），并且 `null` 和 `undefined` 是没有 `constructor` 的。
> - **适用场景**：一般很少单独使用，仅作了解。

**4. `Object.prototype.toString.call()`（最准确）**

> - **原理**：`toString` 是 Object 原型上的方法，默认返回当前对象的内部属性 `[[Class]]`，格式为 `'[object Type]'`。通过 `call` 改变 this 指向，可以让任何值都调用这个方法。
> - 优点：最准确、最全面。能精准判断 JS 中所有的内置类型，包括 `null`、`undefined` 和各种细分引用类型。
>   - 例如：`Object.prototype.toString.call(null)` 返回 `'[object Null]'`。
>   - 例如：`Object.prototype.toString.call([])` 返回 `'[object Array]'`。
> - **缺点**：写法较繁琐。不能判断自定义的类实例（比如 `new Person()`，它只能返回 `'[object Object]'`）。
> - **适用场景**：作为通用类型判断的最佳实践。通常会将其封装成一个工具函数，配合正则提取字符串。

**总结与最佳实践（总）**

综上所述，在我的日常开发中：

> 1. 如果只是判断变量是否定义或者是不是函数，我会用 `typeof`。
> 2. 如果是判断具体的引用类型（特别是数组），我会用 `instanceof` 或者 ES6 提供的 `Array.isArray()`。
> 3. 如果需要写一个通用的、最严谨的类型判断工具函数，我会选择 `Object.prototype.toString.call()`。

**💡 面试官可能追问及加分项：**

**追问1：能不能手写一个 `instanceof`？**
*回答思路：利用原型链，写一个 `while` 循环即可。*

**追问2：为什么 `Object.prototype.toString.call()` 能判断类型，而直接 `xxx.toString()` 不行？**
*回答思路：因为很多派生对象（如 Array、Function）都**重写**了 `toString` 方法，导致直接调用时无法返回类型字符串。只有 Object 原型上的 `toString` 才会去读取内部的 `[[Class]]` 属性。因此必须用 `call` 借用 Object 原型上的原生方法。*

## 判断空对象

1. **首选 Object.keys(obj).length === 0**：对于 99% 的常规业务场景，这个方法最简洁高效，能满足判断自身可枚举属性的需求。
2. **特殊场景使用 Reflect.ownKeys**：如果业务中大量使用了 Symbol 或不可枚举属性来定义内部状态，需要绝对严格的空判断时，再使用此方法。
3. **避免单独使用 JSON.stringify**：除非明确知道对象内的属性都是普通的可序列化数据，否则极易产生 Bug。
4. **前置校验**：在执行判断前，最好先加上类型校验（如 `typeof obj === 'object' && obj !== null`），防止传入 `null` 或非对象类型导致报错。

## slice(),splice()两种方法

slice(start,end)有两个参数(start必需,end选填),都是索引,返回值不包括end,**不改变原数组**

```
var heroes=["0",'1','2','3','4'];
console.log(heroes.slice(1,4))//  [ "1", "2", "3" ]开始索引为1 结束索引为4(不包括4)
console.log(heroes)// 不改变原数组  ["0",'1','2','3','4']
```

splice(index,howmany,item1...itemX)只返回被删除的数据,类型为数组(**改变原数组**)

```
var heroes=["0",'1','2','3','4'];
console.log(heroes.splice(1,2))//  [ "1", "2"]开始索引为1 删除2个元素
console.log(heroes)// 不改变原数组  ["0",'3','4']
```

## JS对象的两类属性

第一类属性，数据属性具有四个特征

- value：就是属性的值。
- writable：决定属性能否被赋值。
- enumerable：决定for in能否枚举该属性。
- configurable：决定该属性能否被删除或者改变特征值。

第二类属性是访问器（getter/setter）属性，它也有四个特征。

- getter：函数或undefined，在取属性值时被调用。
- setter：函数或undefined，在设置属性值时被调用。
- enumerable：决定for in能否枚举该属性。
- configurable：决定该属性能否被删除或者改变特征值。

## JavaScript、ES5、ES6

**什么是JavaScript**

JavaScript一种动态类型、弱类型、基于原型的客户端脚本语言，用来给HTML网页增加动态功能

JavaScript由三部分组成：

- ECMAScript（核心）
- DOM（文档对象模型）
- BOM （浏览器对象模型）

> 1.ECMAScript（核心）

作为核心，它规定了语言的组成部分：语法、类型、语句、关键字、保留字、操作符、对象

> 2.DOM（文档对象模型）

DOM把整个页面映射为一个多层节点结果，开发人员可借助DOM提供的API，轻松地删除、添加、替换或修改任何节点。

PS：DOM也有级别，分为DOM1、DOM2、DOM3，拓展不少规范和新接口。

> 3.BOM （浏览器对象模型）

支持可以访问和操作浏览器窗口的浏览器对象模型，开发人员可以控制浏览器显示的页面以外的部分。

PS：BOM未形成规范

**什么是ES5**

作为ECMAScript第五个版本（第四版因为过于复杂废弃了），浏览器支持情况可看第一副图，增加特性如下：

> 1.strict模式

严格模式，限制一些用法，'use strict';

> 2.Array增加方法

增加了every、some 、forEach、filter 、indexOf、lastIndexOf、isArray、map、reduce、reduceRight方法

PS： 还有其他方法 Function.prototype.bind、String.prototype.trim、Date.now

> 3.Object方法

Object.getPrototypeOf

Object.create

Object.getOwnPropertyNames

Object.defineProperty

Object.getOwnPropertyDescriptor

Object.defineProperties

Object.keys

Object.preventExtensions / Object.isExtensible

Object.seal / Object.isSealed

Object.freeze / Object.isFrozen

PS：只讲有什么，不讲是什么。

**什么是ES6**

ECMAScript6在保证向下兼容的前提下，提供大量新特性：

> 1.块级作用域 关键字let, 常量const

> 2.对象字面量的属性赋值简写（property value shorthand）

> 3.赋值解构

> 4.函数参数 - 默认值、参数打包、 数组展开（Default 、Rest 、Spread）

> 5.箭头函数 Arrow functions

(1).简化了代码形式，默认return表达式结果。

(2).自动绑定语义this，即定义函数时的this。如上面例子中，forEach的匿名函数参数中用到的this。

> 6.字符串模板 Template strings

> 7.Iterators（迭代器）+ for..of

迭代器有个next方法，调用会返回：

(1).返回迭代对象的一个元素：{ done: false, value: elem }

(2).如果已到迭代对象的末端：{ done: true, value: retVal }

> 8.生成器 （Generators）

> 9.Class,有constructor、extends、super，但本质上是语法糖（对语言的功能并没有影响，但是更方便程序员使用）

> 10.Modules

ES6的内置模块功能借鉴了CommonJS和AMD各自的优点：

(1).具有CommonJS的精简语法、唯一导出出口(single exports)和循环依赖(cyclic dependencies)的特点。

(2).类似AMD，支持异步加载和可配置的模块加载。

> 11.Map + Set + WeakMap + WeakSet

四种集合类型，WeakMap、WeakSet作为属性键的对象如果没有别的变量在引用它们，则会被回收释放掉。

> 12.Math + Number + String + Array + Object APIs

> 13.Proxy,使用代理（Proxy）监听对象的操作，然后可以做一些相应事情。

可监听的操作： get、set、has、deleteProperty、apply、construct、getOwnPropertyDescriptor、defineProperty、getPrototypeOf、setPrototypeOf、enumerate、ownKeys、preventExtensions、isExtensible。

> 14.Symbols

Symbol是一种基本类型。Symbol 通过调用symbol函数产生，它接收一个可选的名字参数，该函数返回的symbol是唯一的。

> 15.Promises,Promises是处理异步操作的对象，使用了 Promise 对象之后可以用一种链式调用的方式来组织代码，让代码更加直观（类似jQuery的deferred 对象）。

## 合并数组

使用 Array.concat()

```
var array1 = [1, 2, 3];
var array2 = [4, 5, 6];
console.log(array1.concat(array2)); // [1,2,3,4,5,6];
```

不适用于合并大的数组，因为它需要创建一个新的数组，而这会消耗很多内存.

可以使用 Array.push.apply(arr1, arr2) 来代替创建新的数组，它可以把第二个数组合并到第一个中，从而较少内存消耗。

```
console.log(array1.push.apply(array1, array2)); // [1, 2, 3, 4, 5, 6]
```

## async和defer有什么区别?

一句话：`async` 是‘下载完就执行’，适合独立脚本；`defer` 是‘解析完再执行’，适合主业务逻辑且保证顺序。实际开发中，`defer` 的应用场景更为广泛。

1. **无属性（默认情况）**
   - **机制**：遇到 `<script>` 立即停止HTML解析，下载并执行完毕后才继续解析。
   - **缺点**：严重阻塞页面渲染。
2. **`async`（异步执行）**
   - **机制**：下载过程不阻塞HTML解析，但**下载完成后会立即执行**，此时会暂停HTML解析。
   - **顺序**：**不保证执行顺序**，谁先下载完谁先执行。
   - **场景**：互不依赖的独立脚本（如统计代码、广告脚本）。
3. **`defer`（延迟执行）**
   - **机制**：下载过程不阻塞HTML解析，且**会等到HTML完全解析完毕后**，在 `DOMContentLoaded` 事件触发前执行。
   - **顺序**：**保证按代码出现顺序执行**。
   - **场景**：有依赖关系的脚本，或需要操作DOM的脚本。

![image-20211201070616431](/img/image-20211201070616431.png)

## 0.1+0.2竟然不等于0.3

核心原因：十进制转二进制的“死循环”

> **十进制的 0.1**，转换成二进制是：`0.000110011001100110011...`（无限循环）。
>
> **十进制的 0.2**，转换成二进制是：`0.00110011001100110011...`（无限循环）。
>
> JavaScript（及其他语言）为了存储这些无限循环的小数，必须进行截断或舍入。
>
> `0.1` 在计算机里存的其实是：`0.10000000000000000555...`
>
> `0.2` 在计算机里存的其实是：`0.20000000000000001110...`
>
> 当这两个“近似值”相加时，误差累积了：
> `0.1 + 0.2 ≈ 0.30000000000000004`

解决：设置误差范围或使用第三方库(decimal.js 或 bignumber.js底层用字符串或大整数模拟运算，永远不会丢失精度)

```
// 设置误差范围
function isEqual(n1, n2) {
    return Math.abs(n1 - n2) < Number.EPSILON;
}
console.log(isEqual(0.1 + 0.2, 0.3)); // true

// 使用第三方库
import Decimal from 'decimal.js';
let a = new Decimal(0.1);
let b = new Decimal(0.2);
console.log(a.plus(b).toString()); // "0.3"
console.log(a.plus(b).equals(0.3)); // true
```

## DOM操作

**1.获取节点**

querySelector() 方法选择指定 CSS 选择器的第一个元素；

querySelectorAll() 方法选择指定的所有元素

比较：

- query 选择符选出来的元素是静态的，而 getElement 这种方法选出的元素的动态的
- Chrome 浏览器下 getElementBy 方法的执行速度基本都高于 querySelector

**querySelector和getElementById的api相同**

- 添加class:el.classList.add("mystyle", "anotherClass")
- 移除class:el.classList.remove("mystyle", "anotherClass")
- 设置style:el.setAttribute("class",classVal )

- 设置style:el.style.top='100px' 
- el.style["border-width"]="10px"

**2.创建节点添加节点**

```js
window.onload = function() {
    var childNode = document.createElement('p');
    childNode.innerHTML = '这里是提示信息〜〜';
    //childNode.setAttribute('class', 'alerts');
    //childNode.setAttribute('onclick', 'this.style.display = "none"');
    childNode.className = 'alerts';
    childNode.onclick = function () {
        this.style.display = 'none';
    }
    document.getElementsByTagName('body')[0].appendChild(childNode);
}
```

**3.获取屏幕或容器的宽高**

```
获取宽高
元素的实际高度：document.getElementById("div").offsetHeight
元素的实际宽度：document.getElementById("div").offsetWidth
元素的实际距离左边界的距离：document.getElementById("div").offsetLeft
元素的实际距离上边界的距离：document.getElementById("div").offsetTop

设置宽高
document.getElementById("div").style.width = "120px";//可行
document.getElementById("div").style.offsetWidth = "120px";//不可行
```

**4.JS绑定解除事件**

事件有三要素 : `事件源`、`事件`、`监听器` 。

- 第一种
  - 缺点：HTML与js代码紧密耦合。如果要更换 事件，就要改动两个地方:HTML代码和JS代码，这就不利于后期代码的维护。
- 第二种
  - 优点：它最大的优点是就是兼容性很好，所有浏览器都支持
  - 缺点：同一个 dom 元素上，on 只能绑定一个同类型事件，后者会覆盖前者，不同类型的事件可以绑定多个。有一个问题，无法允许团队不同人员对同一元素监听同一事件但做出不用的响应
- 第三种
  - 优点：它们可以支持绑定多个同类型事件
  - 缺点：兼容性并不好,它们只兼容相对应的浏览器才有用。

```
<!-- 第一种 直接在标签里绑定 -->
<button id="btn" onclick="handleClick()">
  自定义函数
</button>

<script>
 // 利用 DOM0 进行绑定
  var btn = document.getElementById('btn')
  btn.onclick = handleClick()
  
  // 利用 DOM3 进行绑定
  btn.addEventListener('click', handleClick)
</script>
```

**5.JS事件捕获和事件冒泡**

DOM事件流（event flow ）存在三个阶段：**事件捕获阶段、处于目标阶段、事件冒泡阶段。**

**事件捕获：**通俗的理解就是，当鼠标点击或者触发dom事件时，浏览器会从根节点开始**由外到内**进行事件传播。

**事件冒泡**：与事件捕获恰恰相反，事件冒泡顺序是由内到外进行事件传播，直到根节点。

<img src="/img/image-20230614063620124.png" alt="image-20230614063620124" style="zoom:80%;" />

1-5是捕获过程，5-6是目标阶段，6-10是冒泡阶段；

```
element.addEventListener(event, handler, useCapture)
useCapture： false(默认值)监听器在冒泡阶段触发，true监听器在捕获阶段触发。
在事件处理函数中，可以通过event.eventPhase 属性查看当前处于哪个阶段（1=捕获，2=目标，3=冒泡）
```

实际应用场景

> - **事件委托：**
>   这是利用**事件冒泡**机制最经典的场景。如果我们有大量的子元素（如列表中的 `<li>`）需要绑定点击事件，直接给每个子元素绑定会造成内存浪费和性能问题。
>   **解决方案：** 将事件绑定在父元素（如 `<ul>`）上，当点击子元素时，事件会冒泡到父元素，通过 `event.target` 判断具体是哪个子元素被点击，从而执行相应逻辑。
>   - **优点：** 节省内存、动态绑定（新增子元素无需重新绑定事件）。
> - **阻止传播：**
>   开发中有时需要阻止事件继续传播，可以使用：
>   - `event.stopPropagation()`：阻止事件继续传播（无论是捕获还是冒泡）。
>   - `event.stopImmediatePropagation()`：不仅阻止传播，还能阻止当前元素上绑定的其他监听器执行。

面试官追问

> 1. 如果父元素和子元素都绑定了事件，且都在捕获/冒泡阶段，执行顺序是什么？
>    - 答：遵循“先捕获，后冒泡”原则。如果都在捕获阶段，先触发父级；如果都在冒泡阶段，先触发子级。
> 2. 点击一个绑定了捕获和冒泡事件的元素，谁先执行？
>    - 答：对于目标元素本身，监听器的执行顺序**取决于代码编写的顺序**，而不是捕获优先于冒泡。（这是很多面试者的盲区）。

**6.监听串口变化**

**Resize事件**

```
 window.addEventListener('resize', () => {
        this.helpHeight = window.innerHeight - 90
      })
```

**ResizeObserverAPI监听元素容器**

```
const resizeObserver = new ResizeObserver(entries => {
  //回调
  this.$chart.resize();
});
resizeObserver.observe(this.$refs.chart);
// 取消某个元素监听
//resizeObserver.unobserve(this.$refs.chart)
// 取消全部元素监听
//resizeObserver.disconnect()
缺点：但是坏处是，兼容性不高
解决：
github上，已经提供了能够兼容至IE9的 resizeObserver polyfill
yarn add @juggle/resize-observer
import ResizeObserver from '@juggle/resize-observer';
```

# 中级

## 数据请求

**1.XHR**

是ajax的底层核心

```js
var xhr = new XMLHttpRequest();// 创建对象
xhr.open('GET', 'example.txt', true);// 打开请求
xhr.send(); // 发送请求
xhr.onreadystatechange =function(){// 接收响应
    // readystate 4 表示成功
    //status 200-300
    // 200 成功(有可能强缓存策略，cache-control，expired）
    // 301 302 redirect
    // 304 从缓存读取数据。（协商缓存策略，etag）
    // 404 not found
    // 500 服务器错误
}
xhr可以取消？
xhr.abort() // 终止请求
```

**2.fetch(w3c）**

解决xhr异步请求混乱问题，它是基于promise规范，替代xhr

```js
fetch("ur1
   {method:post',body:，credencia1:include })
   then(res=>res.json())// 必须要转下json
   .then(res=>{console.1og(res)})
// 兼容性问题
// 发出的请求，默认是不带cookie.credencial:'include'
```

**3.jsonp(解决跨域)**

```js
动态创建script src指向没有跨域限制，onload

后端返回的数据格式一定是，test(["111","222"])

前端提前定义好test这个方法，通过形参就拿到数据了。

jsonp可以做get请求，无法做post请求（缺点）

jsonp可以取消吗？不能
```

## 跨域和同源策略

同源策略：协议、域名、端口都一样。

跨域处理：

1.JSONP

> 主要依赖的是script标签不受同源策略影响，src指向某一个接口的地址，同步需要传递callback回调函数名字，这样当接口调用成功后，本地创建的全局回调函数就会执行，并且接收到数据。不使用img标签的原因是因为img标签无法执行js语句

2.CORS

> 依赖服务端对前端的请求头信息进行放行，不做限制。Access-contro1-A11ow-origin配置成*

3.代理访问

前端访问不存在跨域问题的代理服务器，代理服务器再去访问目标服务器（服务器之间没有跨域限制）

## Axios取消请求

主要依赖原生的 `AbortController` API。它的核心应用场景是**避免竞态条件**（如搜索框频繁输入导致旧请求覆盖新请求）和**防止内存泄漏**（如组件卸载时取消未完成的请求）。基本思路是：“创建取消信号 -> 绑定到请求 -> 触发取消”。

**核心实现**

> 1. **创建控制器**：实例化一个 `new AbortController()`，它包含一个 `signal` 属性和一个 `abort()` 方法。
> 2. **绑定信号到请求**：在调用 axios 请求时，将 `controller.signal` 传入请求的配置项中（`{ signal: controller.signal }`）。
> 3. **触发取消**：在业务逻辑需要时（如组件销毁、发起新请求前），调用 `controller.abort()` 来主动中断该请求。
> 4. **错误处理**：请求被取消后会进入 `catch` 回调，需使用 `axios.isCancel(error)` 来区分是“主动取消”还是“网络错误等真实报错”。

```js
let controller = null;

async function fetchSearchData(keyword) {
  // 1. 如果有上一次未完成的请求，先取消它
  if (controller) {
    controller.abort();
  }

  // 2. 创建新的控制器
  controller = new AbortController();

  try {
    // 3. 绑定 signal 到请求
    const res = await axios.get('/api/search', {
      params: { q: keyword },
      signal: controller.signal 
    });
    console.log('请求成功:', res.data);
  } catch (error) {
    // 4. 区分是否是主动取消的请求
    if (axios.isCancel(error)) {
      console.log('请求被主动取消:', error.message);
    } else {
      console.log('真实网络错误:', error);
    }
  } finally {
    controller = null;
  }
}

// 模拟快速连续输入
fetchSearchData('a'); 
fetchSearchData('ab'); // 这会取消 'a' 的请求
```



## 手写-深浅拷贝

浅拷贝：重新在堆中创建内存，拷贝后的基本数据类型不影响，但是引用类型属性是相互影响共用

深拷贝：重新在堆中创建内存，所有值都不相互影响

```js
//赋值，全部影响
var person={
    name:'jack',
    play:['篮球','足球']
}
var person2 =person;
person2.name='lucy';
person2.play[0]='爵士';
console.log(person);
console.log(person2);
```

```js
//浅拷贝，基本类型不影响，引用类型数据共用
// 1. ...扩展运算符实现
let copy1 = {...{x:1}}

// 2. Object.assign实现
let copy2 = Object.assign({}, {x:1})
```

```js
//深拷贝，所有数据不影响
// 1. JOSN.stringify()/JSON.parse()
let obj = {a: 1, b: {x: 3}}
JSON.parse(JSON.stringify(obj))

// 2. 递归拷贝
function deepClone(obj) {
  let copy = obj instanceof Array ? [] : {}
  for (let i in obj) {
    if (obj.hasOwnProperty(i)) {
      copy[i] = typeof obj[i] === 'object' ? deepClone(obj[i]) : obj[i]
    }
  }
  return copy
}
```

## 手写-setTimeout实现setInterval

**一、 为什么要模拟？（`setInterval` 的缺陷）**

原生的 `setInterval` 存在两个主要问题：

1. **无视代码报错和执行时间**：`setInterval` 会每隔固定时间往事件队列里推入回调，如果前一次回调执行时间很长（或者发生了阻塞），后一次回调依然会按时触发，导致**任务堆叠**，甚至同时执行多个定时器任务。
2. **忘记停止导致内存泄漏**：如果 `setInterval` 没有被正确 `clear`，它会在后台一直执行，占用资源。

**用 `setTimeout` 模拟的优势**：采用递归调用，每次回调执行完毕后，才会去开启下一次定时。这样保证了**前一次任务执行完毕后，才会间隔固定时间开启下一次任务**，避免了任务堆叠。

**二、 代码实现**

我的实现思路是：利用递归调用 `setTimeout`，通过闭包保存定时器 ID，并对外提供一个 `clear` 方法用于停止定时器。

```js
function mySetInterval(callback, delay, ...args) {
  let timer = null;

  // 内部递归函数
  const interval = () => {
    // 1. 执行回调，绑定 this 并传入参数
    callback.apply(this, args);
    
    // 2. 递归调用，设置下一次定时
    timer = setTimeout(interval, delay);
  };

  // 启动第一次定时
  timer = setTimeout(interval, delay);

  // 返回一个闭包对象，用于清除定时器
  return {
    clear: () => {
      clearTimeout(timer);
      console.log('定时器已停止');
    }
  };
}
```

**面试总结**

使用 `setTimeout` 模拟 `setInterval` 的核心在于**递归**和**闭包**。

1. **递归**保证了任务串行执行，前一个任务结束后才调度下一个，避免了 `setInterval` 的任务堆叠问题。
2. **闭包**用于保存内部变量（如 `timer`），并对外暴露清除定时器的接口，实现了类似 `clearInterval` 的功能。
3. 同时注意使用 `apply` 绑定 `this` 和传递剩余参数，保证函数的通用性。

## 手写-发布订阅

**一、 核心架构设计**

EventBus 的核心逻辑是维护一个**事件中心**（通常是一个对象或 Map）。

- **键**：事件名。
- **值**：一个数组，里面存放该事件所有的回调函数。

核心 API 包括：

1. `on(event, callback)`：将回调推入对应事件的数组中。
2. `emit(event, ...args)`：遍历对应事件的数组，依次执行回调。
3. `off(event, callback)`：从数组中移除指定的回调。
4. `once(event, callback)`：订阅一次，触发后自动解绑。

**二、 完整代码实现**

在实现时，需要特别注意**`this` 指向**、**执行时动态 `off` 导致的数组遍历跳过问题**，以及**参数传递**。

```js
class EventBus {
  constructor() {
    this.events = {};
  }

  // 订阅
  on(event, cb) {
    if (!this.events[event]) this.events[event] = [];
    this.events[event].push(cb);
  }

  // 触发
  emit(event, ...args) {
    const cbs = this.events[event];
    if (!cbs) return;
    // 【关键点】拷贝一份遍历，防止回调内部触发 off 修改原数组导致遍历跳过
    [...cbs].forEach(cb => cb(...args));
  }

  // 解绑
  off(event, cb) {
    if (!this.events[event]) return;
    this.events[event] = this.events[event].filter(fn => fn !== cb);
  }

  // 单次订阅
  once(event, cb) {
    const fn = (...args) => {
      cb(...args);
      this.off(event, fn); // 执行后自动解绑
    };
    this.on(event, fn);
  }
}
```

**三、 测试用例**

为了验证代码的健壮性，我会用几个典型场景进行测试：

```js
const bus = new EventBus();

// 1. 测试 on 和 emit
const sayHi = (name) => console.log(`Hi, ${name}`);
bus.on('greet', sayHi);
bus.emit('greet', '张三'); // 输出: Hi, 张三

// 2. 测试 off
bus.off('greet', sayHi);
bus.emit('greet', '李四'); // 无输出 (解绑成功)

// 3. 测试 once
bus.once('connect', () => console.log('连接成功!'));
bus.emit('connect'); // 输出: 连接成功!
bus.emit('connect'); // 无输出 (只触发了一次)

// 4. 测试执行回调时动态 off 会不会导致跳过
const cb1 = () => { console.log('cb1执行'); bus.off('test', cb1); };
const cb2 = () => { console.log('cb2执行'); };
bus.on('test', cb1);
bus.on('test', cb2);
bus.emit('test'); 
// 预期输出: cb1执行  cb2执行 (如果没有拷贝数组，cb2会被跳过)
```

**面试总结：**
简化版核心就三点：

1. `on` 往数组里 `push`，`emit` 遍历数组执行。
2. `emit` 时**必须拷贝数组**再遍历，防止回调内调用 `off` 删除元素导致遍历跳过。
3. `once` 本质是套了一层壳，利用闭包执行后自动调 `off`。

## **V8引擎**

1.定义

`V8`是一个由`Google`开源的采用`C++`编写的高性能`JavaScript`和`WebAssembly`引擎。

主要工作：

- 编译和执行js代码，即将js代码转换为机器代码；
- 处理调用栈；
- 内存分配和垃圾回收；

2.原理

`V8`的内部有很多模块，其中最重要的4个：

- **Parser**解析器:负责将js源代码解析成AST抽象语法树
- **Interpreter**解释器:负责将AST解释为bytecode字节码文件，同时也有直接解释执行bytecode能力
- **complier**编译器:负责编译出运行更加高效的机器代码
- **Orinoco**: 垃圾回收器，负责进行内存空间回收

![image-20211209072317064](/img/image-20211209072317064.png)

(1)AST抽象语法树

[AST 抽象语法树——最基础的 javascript 重点知识，99% 的人根本不了解](https://segmentfault.com/a/1190000016231512)

![image-20211209072730664](/img/image-20211209072730664.png)

Parser解析器在转换过程中有两个重要的阶段：`词法分析（Lexical Analysis）`和`语法分析（Syntax Analysis）`.

- 词法分析,也称为分词，是将字符串形式的代码转换为标记（token）序列的过程。
- 语法分析,语法分心是将词法分析产生的`token`按照某种给定的形式文法转换成`AST`的过程。也就是把单词组合成句子的过程.

(2)byteCode

![image-20211209072755682](/img/image-20211209072755682.png)

(3)machine code

![image-20211209072828890](/img/image-20211209072828890.png)

3.V8发展史

(1)早期的V8

早期的版本5.8以前，V8没有解释器，只有2个编译器。

所以流程是这样的：

- 解析器对js解析成AST，**Full-codegen**编译器(也叫基准编译器)对AST编译成机器代码(省去了bytecode，执行效率更高)。
- 在执行的过程，有分析线程对机器代码进行优化，需要解析器对js解析成AST，**Crankshaft**编译器(也称为优化编译器)对代码进行优化。

```
优点：省去了bytecode的转化，直接生成更加高效的machine code机器代码.

缺点：V8团队的官方博客这样说,
a.生成的机器码占用了大量内存
b.缺少中间层的bytecode，很多性能优化策略无法实施
c.js引擎无法很好的支持新的语法
```

![image-20211209073441948](/img/image-20211209073441948.png)

(2)2017年4月新的V8架构

V8团队这样评价新架构：**它代表了V8团队通过实际测量Javascript性能，并仔细研究Full-codegen和Crankshaft的缺点后收集到的共同见解的顶峰**。

所以新的流程是这样的：

- 解析器对js解析成AST，**Igniton**基准解释器解释成bytecode字节码，并执行
- 执行一段时间后，**TruboFan**优化编译对bytecode字节码优化为更加高效的机器码

有几个优化点：

1.函数**只声明未被调用**，不会被解析成AST

2.函数**只被调用一次**，bytecode直接被解释执行，TruboFan不会进行优化编译

3.函数**被调用多次**，可能被标记为热点函数，可能被编译成机器代码

![image-20211209074403859](/img/image-20211209074403859.png)

(3)新架构的特点

将优化后的bytecode和machine code形成共存的状态。

这里要注意**deoptimization**即回退字节码，即由解释器解释执行。函数类型发生变化时，**Igniton**会检测到变化，会将字节码回退，重新解释为新的字节码。

建议：

1.不要将函数的类型变来变去，尽量保证类型一致，如sum(x,y) x一会是int,一会儿是num

优点：

1.第一次执行，直接使用中间层的字节码，省去了机器码，同时编译器生成字节码的速度远远大于机器码

2.优化线程不需要从源码从新编译，而是从bytecode字节码开始优化就可以了。同时**deoptimization**只需要回退到字节码即可。

优化点：

```
1.隐藏类（hidden class）
2.内联缓存（incline caching）
3.优化 Orinoco
3.1增量标记 - Incremental marking
3.2懒性清理 - Lazy sweeping
3.3并发 - Concurrent
3.4并行 - Parallel
```

## 内存空间

JS内存空间分为**栈(stack)**、**堆(heap)**、**池(一般也会归类为栈中)**。 其中**栈**存放基本变量，**堆**存放应用对象(引用地址存放在栈，真实变量在堆)，**池**存放常量，所以也叫常量池。

**几个问题**

问题1：

```js
var a = 20;
var b = a;
b = 30;
// 这时a的值是多少？
```

问题2：

```js
var a = { name: '前端开发' }
var b = a;
b.name = '进阶';
// 这时a.name的值是多少
```

问题3：

```js
var a = { name: '前端开发' }
var b = a;
a = null;
// 这时b的值是多少
```

现在来解答一下，三个问题的答案分别是`20`、`‘进阶’`、`{ name: '前端开发' }`

- 对于问题1，a、b都是基本类型，它们的值是存储在栈中的，a、b分别有各自独立的栈空间，所以修改了b的值以后，a的值并不会发生变化。
- 对于问题2，a、b都是引用类型，栈内存中存放地址指向堆内存中的对象，引用类型的复制会为新的变量自动分配一个新的值保存在变量对象中，但只是引用类型的一个地址指针而已，实际指向的是同一个对象，所以修改`b.name`的值后，相应的`a.name`也就发生了改变。
- 对于问题3，首先要说明的是`null`是基本类型，`a = null`之后只是把a存储在栈内存中地址改变成了基本类型null，并不会影响堆内存中的对象，所以b的值不受影响。

**JS的内存生命周期**

- 1、分配你所需要的内存
- 2、使用分配到的内存（读、写）
- 3、不需要时将其释放、归还

## **垃圾回收**

**1. 开篇：什么是垃圾回收？**
垃圾回收就是 JS 引擎中的一套自动化机制，它的核心目的是**监控内存分配，并自动释放那些不再使用的内存，以防止内存泄漏**。

**2. 核心原理：如何判断“垃圾”？**
目前主流的浏览器引擎（如 Chrome 的 V8）主要使用**可达性**算法来判断对象是否可以被回收。

- **根节点：** 垃圾回收器会从一组被称为“根”的全局变量开始寻找，比如 `window` 对象（浏览器中）、`global` 对象（Node.js 中）以及当前的调用栈。
- **标记过程：** 从根节点出发，所有能被根节点直接或间接引用的对象，都被标记为“活动对象”。
- **清除过程：** 那些没有被标记到的对象，也就是从根节点无法到达的对象，就被视为“垃圾”，等待回收。

*(补充：早期的浏览器曾使用“引用计数法”，即记录一个对象被引用的次数。但这有一个致命缺陷——**循环引用**，即 A 引用 B，B 也引用 A，导致两者都无法被回收，因此已被现代浏览器弃用。)*

**3. 主流算法：标记-清除与分代回收**
现代垃圾回收主要采用**标记-清除** 算法及其变种。

- **标记-清除：**
  1. **标记：** 遍历所有对象，标记可达对象。
  2. **清除：** 遍历堆内存，清除未标记的对象。
  3. **缺点：** 清除后会产生不连续的内存碎片（类似磁盘碎片），后续如果要分配大对象可能内存不足。
- **标记-整理：**
  - 为了解决碎片化问题，在清除阶段会将存活的对象向内存一端移动，整理出连续的内存空间。通常用于老生代。

**4. 进阶：V8 引擎的优化策略（分代回收）**
V8 引擎为了提高性能，根据对象的生命周期长短，将堆内存分为**新生代** 和 **老生代**，并采用不同的回收策略。

- **新生代：** 存放生存时间较短的对象（如临时变量）。
  - **算法：Scavenge 算法（Cheney 算法）。**
  - **机制：** 将内存分为两块，`From` 空间和 `To` 空间。新对象分配在 `From`。GC 时，将 `From` 中存活的对象复制到 `To` 并有序排列，然后清空 `From`。优点是速度快，不产生碎片。缺点是只能使用一半内存。经历一次复制还存活的对象，会被晋升到老生代。
- **老生代：** 存放生存时间较长的对象或从新生代晋升过来的对象。
  - **算法：标记-清除 + 标记-整理。**
  - **机制：** 由于空间大、对象多，复制算法效率低。采用标记-清除清理垃圾，并在必要时进行标记-整理以解决内存碎片。
- **V8 的性能优化（减少全停顿）：**
  - **增量标记：** 将一个大的 GC 任务拆分成很多个小任务，穿插在 JS 代码执行中，避免长时间阻塞主线程（即“全停顿”）。
  - **并发回收：** 利用多核 CPU，在辅助线程上进行 GC 标记和清理，完全不阻塞主线程的 JS 执行。

**5. 开发中的常见问题：内存泄漏**
虽然 GC 很强大，但代码不当仍会导致无法回收的内存泄漏。常见原因包括：

> 1. **意外的全局变量：** 在函数内未声明的变量（如 `a = 10`）会挂在全局对象上，无法回收。
> 2. **未清理的定时器：** `setInterval` 或 `setTimeout` 在组件销毁时未清除。
> 3. **闭包：** 闭包会维持对外部作用域变量的引用，如果不当使用，会导致变量始终无法被释放。
> 4. **游离的 DOM 引用：** 页面中删除了 DOM 节点，但 JS 代码中还保留着对该节点的引用。
> 5. **事件监听器未解绑：** 添加了 `addEventListener` 却未在移除元素时 `removeEventListener`。

**6. 总结**
JS 的垃圾回收机制是基于**可达性分析**的。V8 引擎通过**分代回收**（新生代用 Scavenge，老生代用标记-整理）来平衡效率与空间。理解 GC 机制能帮助我们编写更高效的代码，并有效避免内存泄漏问题。

💡 **面试官可能会追问的点（准备思路）：**

> 1. V8 的老生代什么时候从标记-清除切换到标记-整理？
>    - 答：通常是在内存空间不足以分配新生对象晋升过来的内存，或者为了应对严重的内存碎片化时触发。
> 2. 什么是全停顿？
>    - 答：GC 运行时，为了防止逻辑冲突，JS 执行线程会被挂起，等待 GC 执行完毕。对于大内存堆，这会导致页面卡顿。增量标记和并发回收就是为了解决这个问题。
> 3. 如何手动触发 GC？（调试用）
>    - 答：在 Node.js 中可以使用 `global.gc()`（需要启动参数 `--expose-gc`）；在 Chrome DevTools 中可以点击 Performance 面板里的 “Collect garbage” 按钮。

## 内存溢出和内存泄漏

**1. 开场白：一句话**
**内存泄漏是因，内存溢出是果**。简单来说，内存泄漏是指程序中已经不再使用的内存没有及时释放，随着程序运行时间的推移，泄漏的内存越来越多，最终导致可用内存耗尽，就会引发内存溢出，从而使程序崩溃。

**2. 概念解析：分别定义**

- **内存泄漏：**
  - 指程序在申请内存后，无法释放已不再使用的内存空间。
  - 表现为：页面随着时间的推移变得越来越卡，占用的内存（Chrome DevTools Memory 面板中）持续走高，不会回落。
- **内存溢出：**
  - 指程序在申请内存时，没有足够的内存供申请者使用。
  - 表现为：程序报错，如 `RangeError: Maximum call stack size exceeded`（栈溢出）或 `FATAL ERROR: Ineffective mark-compacts near heap limit Allocation failed - JavaScript heap out of memory`（堆溢出），严重时直接导致进程崩溃或浏览器标签页崩溃。

**3. 核心重点：常见的内存泄漏场景**
常见的内存泄漏：

> 1. 意外的全局变量：
>    - 在函数内未使用 `var/let/const` 声明的变量（如 `a = 10`）会挂载到 `window` 全局对象上，函数执行完后该变量依然存在，无法被回收。
> 2. 未清理的定时器与回调函数：
>    - 使用了 `setInterval` 或 `setTimeout`，但在组件销毁或页面卸载时没有调用 `clearInterval/clearTimeout`。只要定时器还在，它内部的回调函数以及引用的变量就永远不会被回收。
> 3. 闭包引起的泄漏：
>    - 闭包可以维持函数内部的变量引用。如果闭包使用不当（例如将闭包赋值给一个长生命周期的对象），导致内部的大对象始终被外部引用，就无法被回收。
> 4. 游离的 DOM 引用：
>    - 页面中删除了一个 DOM 节点，但在 JS 代码中（如某个对象的属性）还保留着对该节点的引用。此时 DOM 树已移除，但 JS 内存中仍保留着该节点数据，导致泄漏。
> 5. 事件监听器未解绑：
>    - 给元素绑定了 `addEventListener`，但元素移除时没有调用 `removeEventListener`。

**4. 扩展：内存溢出的常见触发条件**
除了由内存泄漏积累导致外，瞬间的大流量操作也可能直接导致溢出：

- **一次性处理大量数据：** 比如尝试一次性向内存中加载几 GB 的日志文件或图片。
- **无限递归：** 函数由于逻辑错误无限调用自身，导致调用栈瞬间爆满。

**5. 实战解决：如何排查与避免**

> - 排查工具（Chrome DevTools）：
>   - Memory 面板：
>     - **Heap Snapshot（堆快照）：** 拍摄两张快照（操作前和操作后），对比查看“对象”的增长情况，找出分离的 DOM 节点或未释放的对象。
>     - **Allocation Timeline（分配时间线）：** 实时观察内存的分配情况，看是否存在锯齿状不回落（即持续增长）的情况。
> - 避免策略：
>   - 严格使用 `let/const` 避免意外全局变量。
>   - 在页面/组件销毁的生命周期（如 Vue 的 `beforeUnmount`，React 的 `useEffect` 清理函数）中，统一清除定时器、解绑事件、手动置空大对象引用。
>   - 合理使用 **WeakMap** 和 **WeakSet**，它们对对象的引用是弱引用，不会阻止垃圾回收。

**6. 总结**
内存泄漏是由于代码逻辑疏忽导致无法回收无用内存，长期积累会导致内存溢出。在日常开发中，我们要养成良好习惯，特别是在处理生命周期、闭包和 DOM 引用时，要格外小心。当遇到页面卡顿时，要善于利用浏览器 DevTools 进行内存分析，找出泄漏点。

💡 **面试官可能会追问的点（准备思路）**：

> 1. 追问：如何判断是内存泄漏还是正常的内存波动？
>    - **回答：** 正常的应用会有波浪式的内存曲线（GC 发生时会回落）。内存泄漏的表现是：执行一系列操作（如打开关闭页面 5 次），然后强制触发 GC（点击垃圾桶图标），内存水位依然明显高于操作前，且呈阶梯状上升。
> 2. 追问：WeakMap 和 WeakMap 弱引用的原理是什么？
>    - **回答：** 弱引用的意思是，如果一个对象只被 WeakMap 引用，而没有其他强引用，垃圾回收器会忽略 WeakMap 的引用，直接回收该对象。这非常适合用来存储关联 DOM 节点的元数据，DOM 删除了，数据自动消失，不会泄漏。
> 3. 追问：Node.js 中的内存溢出怎么处理？
>    - **回答：** Node.js 默认内存限制较小（64位系统约 1.4GB）。可以通过启动参数 `--max-old-space-size=4096` 扩大内存限制，但这只是治标；根本还是要通过 `node --inspect` 结合 Chrome DevTools 或 `heapdump` 模块分析快照，找到泄漏的代码。

## 如何创建私有变量

**1.使用闭包**

使用闭包可以使用私有属性或者方法的封装。利用闭包可以访问外部函数的变量特征

```js
function MyProfile() {
    const myTitle = "DevPoint";

    return {
        getTitle: function () {
            return myTitle;
        },
    };
}
const myProfile = MyProfile();
console.log(myProfile.getTitle()); // DevPoint
```

**2.在constructor中用Symbol代替key**

```js
// 类的开发者， 调用者
class Login{
    constructor(username,password){
        const PASSWORD = Symbol();
        this.username = username
        // 使用Symbol 规避了公共访问
        this[PASSWORD] = password;
        // 1. {} key
        // 2. 怎么存进对象？ key不可访问呢？私有
        // 3. symbol
    }
    checkPassword(pwd){
        return this[PASSWORD] == pwd
    }
}
var userA = new Login('aa','123456');
// userA.password = '123456';
console.log(userA.username)  //aa
console.log(userA.password)  //undefined
```

**3.用对象以Symbol定义**

```
const gender = Symbol('gender');
const obj = {
    name:'大胖猫',
    age:'3',
    [gender]:'公'
}
//obj.name  
obj[gender]  //调用成功 
// 不可枚举
console.log(Object.keys(obj));
console.log(JSON.stringify(obj));
```

**4.使用Class优化面向对象的读写操作**

```
class Person{
    constructor(name){
        this.name = name;   // 公有属性

    }
    get name(){
        console.log('get 方法');
        return this.name;
    }
    set name(str){
        console.log('设置了name 方法');
        this.name = str;
    }
}
let coco = new Person('coco');
console.log(coco.name);
```

**5.使用 ES2020 提案**

还处于 ES2020 试验草案中，引入了私有方法或者属性的定义，语法比较奇怪，以 `#` 作为前缀。

```
class ButtonCreator {
    #width;
    #height;
    constructor(width, height) {
        this.#width = width;
        this.#height = height;
    }
    // 私有方法
    #calculateWidth() {
        return this.#width;
    }

    getWidth = () => this.#calculateWidth();
    getHeight = () => this.#height;
    setWidth = (width) => (this.#width = width);
    setHeight = (height) => (this.#height = height);
}
const button = new ButtonCreator(600, 360);
console.log(button.width); // undefined
console.log(button.getWidth()); // 600
```

**6.使用 WeakMap**

这种方法建立在闭包方法之上，使用作用域变量方法创建一个私有 `WeakMap`，然后使用该 `WeakMap` 检索与此相关的私有数据。这比作用域变量方法更快，因为所有实例都可以共享一个 `WeakMap`，所以不需要每次创建实例时都重新创建方法。

```
const ButtonCreator = (function () {
    const privateProps = new WeakMap();
    class ButtonCreator {
        constructor(width, height, name) {
            this.name = name; // 公共属性
            privateProps.set(this, {
                width, // 私有属性
                height, // 私有属性
                calculateWidth: () => privateProps.get(this).width, // 私有方法
            });
        }

        getWidth = () => privateProps.get(this).calculateWidth();
        getHeight = () => privateProps.get(this).height;
    }
    return ButtonCreator;
})();
const button = new ButtonCreator(600, 360);
console.log(button.width); // undefined
console.log(button.getWidth()); // 600
```

**7.使用 TypeScript**

可以将 `TypeScript` 用作 JavaScript 的一种风格，可以使用 `private` 关键字从面向对象的语言中真正重新创建功能。

## 防抖和节流

**【一句话总结】**
防抖和节流都是用来限制函数执行频率，优化高频触发事件的性能。**防抖**是“打断重来”，**节流**是“按部就班”。

**【核心要点对比】**

1. **防抖**
   - **原理**：事件触发后，等待 n 秒再执行；如果在 n 秒内**再次触发**，则**重新计时**。
   - **特点**：只执行最后一次。
   - **场景**：搜索框输入联想、窗口大小 `resize`、表单验证。
2. **节流**
   - **原理**：事件触发后，在 n 秒内只执行**第一次**，后续触发无效，直到 n 秒过后才允许再次执行。
   - **特点**：每隔一段时间执行一次。
   - **场景**：滚动条滚动 `scroll`、高频点击按钮提交、鼠标拖拽 `mousemove`。

**【核心实现代码】**

```js
// 1. 防抖：清空旧定时器，建新定时器
function debounce(fn, delay) {
  let timer;
  return function(...args) {
    clearTimeout(timer); // 如果再次触发，取消上一次的执行
    timer = setTimeout(() => {
      fn.apply(this, args);
    }, delay);
  };
}

// 2. 节流：用时间戳判断是否在冷却期
function throttle(fn, interval) {
  let lastTime = 0;
  return function(...args) {
    let now = Date.now();
    if (now - lastTime >= interval) { // 间隔超过设定时间才执行
      lastTime = now;
      fn.apply(this, args);
    }
  };
}
```

**【总结】**
防抖重在“延迟执行，过滤中间过程”，节流重在“稀释执行频率，保证过程均匀”。

## 柯里化

**【一句话总结】**
柯里化（Currying）是一种函数式编程技巧，它把接收多个参数的函数，转化为一系列接收单一参数的函数。简单说就是：`f(a, b, c)` 变成 `f(a)(b)(c)`。

**【核心要点】**

1. **核心作用**

   - **参数复用**：固定某些不变参数，生成更具体的函数（如生成专用的 log 函数）。
   - **延迟执行**：只有当参数收集齐全时，才真正执行原函数。

2. **实现原理**
   利用**闭包**保存已传入的参数，每次调用返回一个新函数继续接收参数。当收集的参数总数等于原函数参数个数时，执行原函数。

3. **简单实现代码**

   ```js
      function curry(fn) {
        return function curried(...args) {
          // 如果传入参数大于等于原函数参数个数，直接执行
          if (args.length >= fn.length) {
            return fn.apply(this, args);
          }
          // 否则返回新函数继续收集参数
          return function(...args2) {
            return curried.apply(this, args.concat(args2));
          }
        }
      }
      // 使用
      const sum = (a, b, c) => a + b + c;
      const curriedSum = curry(sum);
      console.log(curriedSum(1)(2)(3)); // 6
      console.log(curriedSum(1, 2)(3)); // 6
   ```

**【总结】**
柯里化的本质是“降维”和“延迟执行”，在编写高阶函数、中间件设计（如 Redux）以及函数组合时非常有用，但需注意闭包可能带来的内存开销。

# 高级

## 前端登录鉴权如何实现？

登录鉴权的本质是**对用户身份凭证的生命周期管理**。核心流程包括：**登录获取凭证 -> 存储凭证 -> 路由级拦截 -> 接口级拦截 -> 凭证失效处理**。

**1.两种主流的鉴权模型**

> - Cookie + Session（传统模式）
> - JWT (JSON Web Token)（现代主流）

**1.1Cookie + Session（传统模式）**

大白话：用身份证号去银行读取个人所有信息。服务器有档案（Session），浏览器只拿档案号（SessionID）→ **有状态**。“我给你一个档案号，你自己别乱动，我这边有你的完整档案。”

原理：用户登录后，后端创建并生成一个 `sessionId`，返回给前端，前端自动保存到cookie中，后续请求中自动携带cookie(核心cookie中的sessionId)

> 凭证获取与存储：
>
> - **localStorage**：前端可控，跨域处理简单，但易受 XSS 攻击窃取。
> - **HttpOnly Cookie**：JS 无法读取，能防 XSS，但需处理跨域 Cookie 配置，且易受 CSRF 攻击。
> - *（补充亮分项）*：一般普通业务用 localStorage；金融等高安全级别业务推荐 HttpOnly Cookie + CSRF Token。

**1.2JWT (JSON Web Token)（现代主流）**

大白话：拿着手环去游乐园玩。服务器没档案，只给你一张自带信息+签名的通行证（Token）→ **无状态**。“我给你一张写好信息+签名的通行证，你以后自己带过来，我只看票不查档案。”

原理：用户登录后，后端生成一个加密的 Token 字符串返回给前端。后续请求的 HTTP Header 中手动携带这个 Token。

**Token 过期与无感刷新**

Token 为了安全通常有效期较短（如 2 小时），如果让用户频繁重新登录体验极差。解决方案是引入 双 Token 机制（Access Token + Refresh Token）。

> 现代推荐做法：AccessToken 存内存（如 Vuex/Pinia 的 state），RefreshToken 存 HttpOnly Cookie。但为了简单，大多数中小项目依然采用 localStorage 存 AccessToken。
>
> - Access Token：有效期短（如 2h），用于业务接口请求。
> - Refresh Token：有效期长（如 7d），仅用于在 Access Token 过期时去换发新的 Access Token。

无感刷新的流程：

> 1. Access Token 过期，后端返回 401。
> 2. 前端拦截 401，利用 Refresh Token 调用刷新接口。
> 3. 拿到新的 Access Token，存储起来。
> 4. 关键点：把刚才失败的请求重新发一次，对用户完全透明。

如果页面同时发起多个请求且 Token 过期，会触发多次刷新请求导致后端报错：

> 解决方案：使用互斥锁 + 请求队列。第一个 401 触发刷新时加锁，后续的 401 请求不再刷新，而是将请求存入队列（返回未 resolve 的 Promise），等新 Token 返回后，统一遍历队列携带新 Token 重发。

**2.权限控制**

> - 后端权限（核心防线）：接口层、数据库层必须校验权限，前端防不住恶意请求。
> - 前端权限（体验优化）：隐藏用户无权操作的按钮和菜单，避免误导用户。
>   - 菜单路由权限：后端返回当前用户的菜单树，前端动态生成路由（router.addRoute）。
>   - 按钮操作权限：通常使用自定义指令，如 v-permission="['edit_article']"，如果没有该权限则移除 DOM 节点或 disable。

**3.鉴权安全**

> 1. XSS（跨站脚本攻击）：黑客注入 JS 读取 localStorage 中的 Token。
>
>    *防御*：对用户输入进行转义；将 Token 存入 HttpOnly Cookie；配置 CSP。
>
> 2. CSRF（跨站请求伪造）：黑客利用浏览器自动携带 Cookie 的特性，伪造用户请求。
>
>    防御：使用 Token 机制（不用 Cookie）；如果用 Cookie，需后端校验 SameSite 属性、Referer/Origin 头，或加入 CSRF Token。
>
> 3. 网络劫持：HTTP 请求被中间人窃听或篡改。
>
>    *防御*：全站 HTTPS。

## 函数式编程

**1.定义**

函数式编程是一种**编程范式**（Programming Paradigm），它将计算过程视为数学函数的求值。

> - **核心思想：** 强调程序的主体是**函数**，而不是指令（即告诉计算机“做什么”，而不是“怎么做”）。
> - **对比：** 它与命令式编程相对。命令式编程侧重于“怎么做”（通过循环、条件判断改变状态），而函数式编程侧重于“做什么”（通过函数组合变换数据）。
> - **本质：** 它是**声明式**的，强调无副作用的纯函数计算和数据的不可变性。

**2.核心特性**

**纯函数**

> - **定义：** 相同的输入永远会得到相同的输出，而且在执行过程中没有任何可观察的副作用。
> - **要点：** 不依赖外部状态，不修改外部状态。

**不可变性**

> - **定义：** 数据一旦创建，就不能被修改。
> - **实现：** 如果需要改变数据，必须创建一个新的数据副本，而不是在原数据上修改（例如在 React 中使用 `setState` 或 Redux 的 Reducer）。

**函数是一等公民**

> - **定义：** 函数可以像普通变量一样，被赋值给变量、作为参数传递给另一个函数，或者作为另一个函数的返回值。

**高阶函数**

> - **定义：** 接收函数作为参数，或者返回一个函数的函数（如 JavaScript 中的 `map`, `filter`, `reduce`）。

**函数组合**

> - **定义：** 将多个简单的函数组合起来，形成一个复杂的函数，以此来解决复杂的问题（如 Unix 管道理念）。

**柯里化**

> - **定义：** 将一个多参数的函数转换成一系列单参数函数的过程。

**3.函数式编程的优缺点**

**优点**

> 1. **代码更简洁、逻辑更清晰：** 减少了中间变量和循环语句，代码更接近自然语言。
> 2. **可维护性高：** 纯函数不依赖外部状态，逻辑独立，便于重构和排查问题。
> 3. **易于测试：** 纯函数只需关注输入和输出，Mock 非常容易，单元测试覆盖率更高。
> 4. **可预测性强：** 由于没有副作用，代码执行结果更加可控，减少了不可预知的 Bug。
> 5. **适合并发处理：** 不可变数据使得多线程/并发环境下不需要加锁，因为数据不会竞争。

**缺点**

> 1. **学习成本高：** 概念（如 Monad、Functor 等）比较抽象，对数学思维有一定要求。
> 2. **性能开销：** 大量创建新对象和函数调用，可能带来更多的内存消耗和垃圾回收（GC）压力（但在现代 JS 引擎优化下，这个差距正在缩小，且可通过结构共享优化）。
> 3. **过度抽象：** 有时为了追求纯函数，代码可能变得过度抽象，导致可读性下降（所谓的“回调地狱”或点号链过长）。

**4.函数式编程的应用场景**

> - React 框架：
>   - React 组件本质上就是纯函数（`props` -> `UI`），`props` 是不可变的。
>   - React Hooks 的设计理念也大量借鉴了函数式编程思想。
> - Redux 状态管理：
>   - Redux 的 Reducer 必须是纯函数，要求保持 State 的不可变性。
> - ES6+ 原生方法：
>   - `Array.prototype.map`, `filter`, `reduce`, `find` 等都是高阶函数的标准应用。
> - 工具库：
>   - **Lodash (fp 模块):** 提供了自动柯里化和不可变的函数式工具。
>   - **RxJS:** 基于函数响应式编程（FRP），大量使用函数组合来处理数据流。



## 手写forEach

```
if(!Array.prototype.forEach) {
    Array.prototype.forEach = function(fn, context) {
        var context = arguments[1];
        if(typeof fn !== "function") {
            throw new TypeError(fn + "is not a function");
        }

        for(var i = 0; i < this.length; i++) {
            fn.call(context, this[i], i, this);
        }
    };
}
```

## 手写map

```
Array.prototype.map = function (fn) {
    let arr = []
    for (let i = 0; i < this.length; i++) {
        arr.push(fn(this[i], i, this))
    }
    return arr
}
```

## 手写reduce

```
Array.prototype.myReduce = function (fn, initVal) {
    let res = initVal ? initVal : 0
    for (let i = 0; i < this.length; i++) {
        res = fn(res, this[i], i, this)
    }
    return res
}
```

## 手写filter

```
Array.prototype.myFilter = function (fn) {
    let arr = []
    for (let i = 0; i < this.length; i++) {
        if (fn(this[i], i, this)) {
            arr.push(this[i])
        }
    }
    return arr
}
```

## **手写push**

```
Array.prototype.myPush = function () {
    let args = arguments
    for (let i = 0; i < args.length; i++) {
        this[this.length] = args[i]
    }
    return this.length
}
```

# 创建函数的几种方式

说完函数的类型，还需要了解JS中创建函数都有几种创建方法。

 **1、声明函数** 最普通最标准的声明函数方法，包括函数名及函数体。

```
function fn1(){}
```

 **2、创建匿名函数表达式** 创建一个变量，这个变量的内容为一个函数

```
var fn1=function (){}
```

注意采用这种方法创建的函数为**匿名函数**，即没有函数name

```
var fn1=function (){};
getFunctionName(fn1).length;//0
```

 **3、创建具名函数表达式** 创建一个变量，内容为一个带有名称的函数

```
var fn1=function xxcanghai(){};
```

> 注意：具名函数表达式的函数名只能在创建函数内部使用

即采用此种方法创建的函数在函数外层只能使用fn1不能使用xxcanghai的函数名。xxcanghai的命名只能在创建的函数内部使用 测试：

```
var fn1=function xxcanghai(){
    console.log("in:fn1<",typeof fn1,">xxcanghai:<",typeof xxcanghai,">");
};
console.log("out:fn1<",typeof fn1,">xxcanghai:<",typeof xxcanghai,">");
fn1();
//out:fn1< function >xxcanghai:< undefined >
//in:fn1< function >xxcanghai:< function >
```

可以看到在函数外部（out）无法使用xxcanghai的函数名，为undefined。

> 注意：在对象内定义函数如var o={ fn : function (){…} }，也属于函数表达式

 **4、Function构造函数** 可以给 Function 构造函数传一个函数字符串，返回包含这个字符串命令的函数，此种方法创建的是**匿名函数**。 

 **5、自执行函数**

```
(function(){alert(1);})();
(function fn1(){alert(1);})();
```

自执行函数属于上述的“函数表达式”，规则相同  

**6、其他创建函数的方法** 当然还有其他创建函数或执行函数的方法，这里不再多说，比如采用 eval ， setTimeout ， setInterval 等非常用方法，这里不做过多介绍，属于非标准方法，这里不做过多展开  

**三个fun函数的关系是什么？**

说完函数类型与创建函数的方法后，就可以回归主题，看这道面试题。 这段代码中出现了三个fun函数，所以第一步先搞清楚，这三个fun函数的关系，哪个函数与哪个函数是相同的。

```
function fun(n,o) {
  console.log(o)
  return {
    fun:function(m){
      //...
    }
  };
}
```

 先看第一个fun函数，属于标准具名函数声明，是**新创建**的函数，他的返回值是一个对象字面量表达式，属于一个新的object。 这个新的对象内部包含一个也叫fun的属性，通过上述介绍可得知，属于匿名函数表达式，即fun这个属性中存放的是一个**新创建**匿名函数表达式。

> 注意：所有**声明的匿名函数都是一个新函数。**

所以第一个fun函数与第二个fun函数不相同，均为新创建的函数。  

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

# 九种跨域方式原理

[九种跨域方式实现原理（完整版）](https://juejin.cn/post/6844903767226351623)

# **JS 识别不同浏览器信息**

```
function myBrowser() {
  var userAgent = navigator.userAgent; //取得浏览器的userAgent字符串  
  var isOpera = userAgent.indexOf("Opera") > -1;
  if (isOpera) {
    return "Opera"
  }; //判断是否Opera浏览器  
  if (userAgent.indexOf("Firefox") > -1) {
    return "Firefox";
  }  //判断是否Firefox浏览器  
  if (userAgent.indexOf("Chrome") > -1) {
    return "Chrome";
  }   //判断是否Google浏览器  
  if (userAgent.indexOf("Safari") > -1) {
    return "Safari";
  } //判断是否Safari浏览器  
  if (userAgent.indexOf("compatible") > -1 && userAgent.indexOf("MSIE") > -1 && !isOpera) {
    return "IE";
  }; //判断是否IE浏览器  
} 
```

# 隐式转换

逻辑非，会将类型转换为Boolean类型，只有6种值取反会转为true,其他都是false。6种：0,NaN,undefined,null,'',false。

两边都是引用类型时，不会隐式转换，比较的是地址。

```
console.log([]==0);
console.log(![]==0);
console.log([]==![]);
console.log([]==[]);
console.log({}==!{});
console.log({}=={});
结果：
VM2986:1 true
VM2986:2 true
VM2986:3 true
VM2986:4 false
VM2986:5 false
VM2986:6 false
解析：
[].valueof.toString() 转为''
{}.valueof.toString() 转为[object,Object]
```

数值运算

```
console.log(1+"true");
console.log(1+true);
console.log(1+undefined);
console.log(1+null);
结果：
1true
2
NAN
1
解析：都会转成1+Number(xx)
```

关系运算符比较，只要有一个是数值类型，都会被转为数值型。如果都不值数值型，则转为unicode码进行比较

```
console.log("2">10);
console.log("2">"10");
console.log("abc">"b");
console.log("abc">"aad");
console.log(undefined==undefined);
console.log(undefined==null);
console.log(null==null);
console.log(NaN==NaN);
结果：
VM2590:1 false
VM2590:2 true
VM2590:3 false
VM2590:4 true
VM2590:5 true
VM2590:6 true
VM2590:7 true
VM2590:8 false
解析：都会转成1+Number(xx)
```

# 高级函数

## 自执行函数

**一、函数的声明与执行**

函数申明方式

```
    // 声明函数fun0
    function fun0(){
        console.log("fun0");
    }

    //执行函数fun0
    fun0(); // fun0
```

变量赋值方式

```
    // 声明函数fun1 - 变量方式
    var fun1 = function(){
        console.log("fun1");
    }

    // 执行函数fun1
    fun1(); // fun1
```

**二、 函数的一点猜想**

既然函数名加上括号`fun1()`就是执行函数。 **思考：**直接取赋值符号右侧的内容直接加个括号，是否也能执行？ 试验如下，直接加上小括弧：

```javascript
    function(){
        console.log("fun");
    }();
```

以上会报错 line1：`Uncaught SyntaxError: Unexpected token (`。 **分析：** `function` 是声明函数关键字，若非变量赋值方式声明函数，默认其后面需要跟上函数名的。

加上函数名看看：

```javascript
    function fun2(){
        console.log("fun2");
    }();
```

以上会报错 line3：`Uncaught SyntaxError: Unexpected token )`。 **分析：** 声明函数的结构花括弧后面不能有其他符号（比如此处的小括弧）。

不死心的再胡乱试一下，给它加个实参（表达式）：

```javascript
    function fun3(){
        console.log("fun3");
    }(1);
```

不会报错，但不会输出结果`fun3`。 **分析：** 以上代码相当于在声明函数后，又声明了一个毫无关系的表达式。相当于如下代码形式：

```javascript
    function fun3(){
        console.log("fun3");
    }

(1);

// 若此处执行fun3函数，可以输出结果
fun3(); //"fun3"
```

**三、自执行函数表达式**

**1. 正儿八经的自执行函数**

想要解决上面问题，可以采用小括弧将要执行的代码包含住（方式一），如下：

```javascript
// 方式一
    (function fun4(){
        console.log("fun4");
    }()); // "fun4"
```

**分析：**因为在JavaScript语言中，`()`里面不能包含语句（只能是表达式），所以解析器在解析到`function`关键字的时候，会把它们当作function表达式，而不是正常的函数声明。 

除了上面直接整个包含住，也可以只包含住函数体（方式二），如下：

```javascript
// 方式二
    (function fun5(){
        console.log("fun5");
    })();// "fun4"
```

写法上建议采用方式一（这是参考文的建议。但实际上，我个人觉得方式二比较常见）。

**2. “歪瓜裂枣”的自执行函数**

除了上面`()`小括弧可以把`function`关键字作为函数声明的含义转换成函数表达式外，JavaScript的`&&` 与操作、`||`或操作、`,`逗号等操作符也有这个效果。

```javascript
    true && function () { console.log("true &&") } (); // "true &&"
    false || function () { console.log("true ||") } (); // "true ||"
    0, function () { console.log("0,") } (); // "0,"

// 此处要注意： &&, || 的短路效应。即： false && (表达式1)  是不会触发表达式1；
// 同理，true || (表达式2) 不会触发表达式2
```

如果不在意返回值，也不在意代码的可读性，我们甚至还可以使用一元操作符（`!` `~` `-` `+` ），函数同样也会立即执行。

```javascript
    !function () { console.log("!"); } (); //"!"
    ~function () { console.log("~"); } (); //"~"
    -function () { console.log("-"); } (); //"-"
    +function () { console.log("+"); } (); //"+"
```

甚至还可以使用`new`关键字：

```javascript
// 注意：采用new方式，可以不要再解释花括弧 `}` 后面加小括弧 `()` 
new function () { console.log("new"); } //"new"

// 如果需要传递参数
new function (a) { console.log(a); } ("newwwwwwww"); //"newwwwwwww"
```

嗯，最好玩的是赋值符号`=`同样也有此效用（例子中的`i`变量方式）：

```javascript
//此处 要注意区分 i 和 j 不同之处。前者是函数自执行后返回值给 i ；后者是声明一个函数，函数名为 j 。
    var i = function () { console.log("output i:"); return 10; } (); // "output i:"
    var j = function () { console.log("output j:"); return 99;}
    console.log(i); // 10
    console.log(j); // ƒ () { console.log("output j:"); return 99;}
```

上面提及到，要注意区分 `var i`和 `var j` 不同之处（前者是函数自执行后返回值给`i` ；后者是声明一个函数，函数名为`j`）。如果是看代码，我们需要查看代码结尾是否有没有`()`才能区分。一般为了方便开发人员阅读，我们会采用下面这种方式：

```javascript
    var i2 = (function () { console.log("output i2:"); return 10; } ()); // "output i2:"
    var i3 = (function () { console.log("output i3:"); return 10; }) (); // "output i3:"
// 以上两种都可以，但依旧建议采用第一种 i2 的方式。（个人依旧喜欢第二种i3方式）
```

**四、自执行函数的应用**

**1. for循环 + setTimeout 例子**

因为是全局变量，所以输出都是同一个值

```
for( var i=0;i<3;i++){
    setTimeout(function(){
        console.log(i);
    }
    ,300);
}
// 输出结果 3,3,3
```

那怎么样才能输出`1,2,3`呢？ 看看下面的方式（写法一）：把`setTimeout`代码包含在匿名自执行函数里面，就可以实现“锁住”索引`i`，正常输出索引值。

```javascript
for( var i=0;i<3;i++){
    (function(lockedIndex){
        setTimeout(function(){
            console.log(lockedIndex);
        }
        ,300);
    })(i);
}
// 输出 "1,2,3"
```

**分析**：尽管循环执行结束，`i`值已经变成了3。但因遇到了自执行函数，当时的`i`值已经被 `lockedIndex`锁住了。也可以理解为 自执行函数属于for循环一部分，每次遍历`i`，自执行函数也会立即执行。所以尽管有延时器，但依旧会保留住立即执行时的`i`值。 *上面的分析有点模糊和牵强，也可以从* ***闭包\*** *角度出发分析的。*

除了上面的写法，也可以直接在 `setTimeout` 第一个参数做自执行（写法二），如下：

```javascript
for( var i=0;i<3;i++){
    setTimeout((function(lockedInIndex){
        console.log(lockedInIndex);
    })(i)
    ,300);
}
```

```js
// 1. lockedInIndex变量，也可以换成i，因为和外面的i不在一个作用域
for( var i=0;i<3;i++){
    (function(i){
        setTimeout(function(){
            console.log(i); // 1,2,3
        }
        ,300);
    })(i);
}

for( var i=0;i<3;i++){
    setTimeout((function(i){
        console.log(i); // 1,2,3
    })(i)
    ,300);
}

// 2. 自执行函数不带入参数 
for( var i=0;i<3;i++){
    (function(){
        setTimeout(function(){
            console.log(i); // 3,3,3
        }
        ,300);
    })();
}

for( var i=0;i<3;i++){
    setTimeout((function(){
        console.log(i); // 1,2,3
    })()
    ,300);
}

// 3. 自执行函数只有实参没有写形参
for( var i=0;i<3;i++){
    (function(){
        setTimeout(function(){
            console.log(i); // 3,3,3
        }
        ,300);
    })(i);
}

for( var i=0;i<3;i++){
    setTimeout((function(){
        console.log(i); // 1,2,3
    })(i)
    ,300);
}

// 4. 自执行函数只有形参没有写实参，这种情况不行。因为会导致输出 undefined。
for( var i=0;i<3;i++){
    (function(i){
        setTimeout(function(){
            console.log(i); // undefined,undefined,undefined
        }
        ,300);
    })();
}

for( var i=0;i<3;i++){
    setTimeout((function(i){
        console.log(i); // undefined,undefined,undefined
    })()
    ,300);
}
```



# 常用函数

## 字符串自动补全padStart()和padEnd()

`padStart`可以在字符串的前面进行字符补全.padEnd是在字符串后面补全。

```
let month  = 8;
month.padStart(2, 0);// 08
```

可以省掉

```
if (month < 10) {
    month = '0' + month;
}
```

## 获取20~50随机数

```
function randomNum(min,max){
	const range = max -min;
	const xishu = Math.random();// [0,1]
	const res=min+math.round(xishu*range);
	return res;
}

randomNum(20,50)
```

## 数组的交集，差集，并集，补集

```js
var a = [1,2,3,4,5]
var b = [2,4,6,8,10]
 
//交集
var c = a.filter(function(v){ return b.indexOf(v) > -1 })
 
//差集
var d = a.filter(function(v){ return b.indexOf(v) == -1 })
 
//补集
var e = a.filter(function(v){ return !(b.indexOf(v) > -1) })
        .concat(b.filter(function(v){ return !(a.indexOf(v) > -1)}))
 
//并集
var f = a.concat(b.filter(function(v){ return !(a.indexOf(v) > -1)}));
 
console.log("数组a：", a);
console.log("数组b：", b);
console.log("a与b的交集：", c);
console.log("a与b的差集：", d);
console.log("a与b的补集：", e);
console.log("a与b的并集：", f);
```

## 数组去重

```
const uniqueArr = (arr) => [...new Set(arr)];
```

## 从url获取参数

```
    const getParameters = () => {
      const url = window.location.href;
      return JSON.parse(`{"${decodeURI(url.split('?')[1]).replace(/"/g, '\\"').replace(/&/g, '","').replace(/=/g, '":"')}"}`);
    };
```

## 检查对象是否为空

```
const isEmpty = obj => Reflect.ownKeys(obj).length === 0 && obj.constructor === Object;
```

## 反转字符串

```
const reverse = str => str.split('').reverse().join('');
```

## 生成随机十六进制颜色

```
const randomHexColor = () => `#${Math.floor(Math.random() * 0xffffff).toString(16).padEnd(6, "0")}`
```

## 检查设备类型

```
const judgeDeviceType =
      () => /Android|webOS|iPhone|iPad|iPod|BlackBerry|IEMobile|OperaMini/i.test(navigator.userAgent) ? 'Mobile' : 'PC';
```

## 文字复制到剪贴板

```
const copyText = async (text) => await navigator.clipboard.writeText(text)
```

## 添加水印

```
export function paintWaterMark(msg='仅测试用途', className='water', transparency='0.3') {
  // 在Vue中可改为ES6写法
  var childNode = document.getElementsByClassName('fixed-water-mark');
  if (childNode && childNode.length !== 0) {
    document.getElementsByClassName(className)[0].removeChild(childNode[0]);
  }
  var wrap = document.createElement('div'); // 创建一个div
  wrap.className = 'fixed-water-mark'; // 给div添加类名
  var wm = document.createElement('canvas'); // 单个水印画布
  wm.id = 'watermark'; // 给canvas标签添加id
  wm.width = 450; // 设置canvas宽
  wm.height = 200; // 设置canvas高
  wm.style.display = 'none'; // 设置画布隐藏属性
  wrap.appendChild(wm); // 在div中添加画布
  var rwm = document.createElement('canvas'); // 重复绘制水印画布，用于整个页面
  rwm.id = 'repeat-watermark';
  wrap.appendChild(rwm);
  document.getElementsByClassName(className)[0].appendChild(wrap);

  // 绘制单个水印
  var cw = document.getElementById('watermark');
  var ctx = cw.getContext('2d');

  // 清空矩形
  ctx.clearRect(0, 0, 450, 200);

  // 设置字体
  ctx.font = '16px Arial';

  // 文字居中
  ctx.textAlign = 'center';

  // 逆时针旋转20度
  ctx.rotate((-30 * Math.PI) / 180);

  // 填充透明度为 transparency 的灰色
  ctx.fillStyle = `rgba(255,128,64,${transparency})`;
  ctx.fillText(msg, 55, 95); // 填充内容为工号
  var date = new Date();
  var currentDateText = date.getFullYear() + '/' + (date.getMonth() + 1) + '/' + date.getDate();

  // 填充内容为当前时间
  ctx.fillText(currentDateText, 55, 115);

  // 在另一个画布上重复绘制单个水印
  var crw = document.getElementById('repeat-watermark');
  crw.width = window.innerWidth; // 设置画布宽度等于窗口显示宽度
  crw.height = window.innerHeight; // 设置画布高度等于窗口显示高度
  var ctxr = crw.getContext('2d');
  ctxr.clearRect(0, 0, crw.width, crw.height);
  var pat = ctxr.createPattern(cw, 'repeat'); // 在水平和垂直方向重复绘制单个水印
  ctxr.fillStyle = pat;
  ctxr.fillRect(0, 0, crw.width, crw.height);
}
```

## splice新增-删除-替换

```
const arr = [1, 2, 3];
// 新增，在索引1处新增,删除个数为0
arr.splice(1, 0, ...[7, 8]); // 1,7,8,2,3
// 删除，在索引1处删除,删除个数为1
arr.splice(1, 1); // 1,3
// 替换，在索引1处替换,替换个数为1
arr.splice(1, 1, ...[7, 8]); // 1,7,8,3
```

## JS复制粘贴

```
function addEventListenerCopyPaste() {
  // 支持复制粘贴
  const target = document.getElementById(uniId.value);
  target.addEventListener('copy', (event) => {
    // 复制,使用ClipboardApi来设置剪贴板里的内容,参考张鑫旭的博客
    const clipboardData = event.clipboardData || window.clipboardData;
    if (!clipboardData) {
      return;
    }
    let text = window.getSelection().toString();
    if (text) {
      event.preventDefault();
      text = text.replace(/\n\n/g, ',');
      text = text.replace(/\n/g, ' ');
      clipboardData.setData('text/plain', text);
    }
  });
  target.addEventListener('paste', (event) => {
    // 粘贴
    event.preventDefault();
    let paste = (event.clipboardData || window.clipboardData).getData('text');
    paste = paste.toUpperCase();
    pasteHandle(paste);
  });
```

## 原生textarea模拟el-input，实现自动换行，超过行数滚动，最大输入限制

```
<textarea
   v-model="content"
    :disabled="true"
   class="textareaMe"
    rows="10"
   maxlength="1500"
  @input="handleAutoResize($event)"
></textarea>

const content = ref()
function handleAutoResize(e,column){
  // textarea输入触发自动调整高度
  const maxleng= e.target.maxLength
  // 限制文字个数
  if(e.target.value.length>maxleng){
    content.value=e.value.substr(0,maxleng)
  }
  adjustTextareaHeight(e.target)
}
async function adjustTextareaHeight(textarea) {
  // textarea自动调整高度
  textarea.style.height = '0';
  // 超过xx行高度滚动：20是行高
  const rowScroll = Number(textarea.rows)
  const heightNow = Math.min(textarea.scrollHeight, 22*rowScroll)
  textarea.style.height = heightNow + 'px';
  textarea.style.overflow = heightNow ===textarea.scrollHeight?'hidden':''
}

.textareaMe {
  width: 100%;
  height: 32px;
  line-height: 1.5;
  padding: 5px 15px;
  border: 1px solid #dcdfe6;
  border-radius: 4px;
  resize: none;
  outline: none;
  font-size:14px;
  font-family: 微软雅黑;
}
```
