---
title: B_JS
date: 2022-05-29 07:33:16
categories:
- B_H5CSSJSES基础
toc: true # 是否启用内容索引
---

# JS的三座大山

- 堆栈内存及闭包作用域
- 面向对象OOP和this处理
- DOM/BOM及事件处理机制

<img src="C:\Users\fuyunjinglong\AppData\Roaming\Typora\typora-user-images\image-20220912183546292.png" alt="image-20220912183546292" style="zoom:80%;" />



# 最新的9种数据类型

基本类型

- Number；
- String；
- Boolean；
- Undefined；
- Null；
- Symbol

引用类型

- Function
- Array
- Object；

**Undefined、Null的区别**

- Undefined 类型表示未定义，它的类型只有一个值，就是 undefined，判空：if(a===undefined)

- Null表示的是：“定义了但是为空”,判空：if(a)

**0.1+0.2不能=0.3**

浮点数运算的精度问题导致等式左右的结果并不是严格相等，而是相差了个微小的值

 console.log( Math.abs(0.1 + 0.2 - 0.3) <= Number.EPSILON);结果为true



# JavaScript对象的两类属性

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

# 浅谈JavaScript、ES5、ES6

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



# requestAnimationFrame 与 requestIdleCallback

**1.视觉暂留**

眼睛的另一个重要特是视觉惰，即光象一旦在视网膜上形成，视觉将会对这个光象的感觉维持一个有限的时间，这种生理现象叫做**`视觉暂留`**。对于中等亮度的光刺激，视觉暂留时间约为`50ms`至`200ms`。当我们看屏幕的时候，虽然你什么也没做，但是屏幕还是以特定的频率在不停刷新，只是这个刷新过程我们肉眼识别到他的细微变化，这就是我们接下来要说的 **`屏幕刷新频率`**

**2.屏幕刷新频率**

我们日常的显示器，一般频率在`60Hz`左右，意味着我们的屏幕每`1`秒需要刷新`60`次，也就是说每`1000ms`需要更新`60`次的屏幕图像，那么我们由此可以得出，屏幕图像更新一次所需要的时间间隔也就是`16.7ms(1000/60≈16.7)`。
由于人的眼睛具有**`视觉暂留效应`**，且暂留时间为`50ms`至`200ms`，也就是说人在看屏幕的时候，还没等到你的大脑印象消失，电脑屏幕就已经更新了，所以这个间隔让你感觉不到变化。
那么屏幕刷新频率是不是越大越好？我们可以大胆假设一下，假如我有三个显示器，刷新频率分别为`1Hz`、`60Hz`、`200Hz`、那么对应的更新周期时间分别为`1000ms`、`16.7ms`、`5ms`。**也就是频率越大，图像更新的间隔就越短，我们看到的画面就会越稳定，**当达到一秒更新一次的时候，这个时候我们就能够感觉到明显的屏幕闪烁，带来视觉疲劳。

与`setTimeout`相比，`requestAnimationFrame`***最大的优势是由浏览器来决定回调函数的执行时机，即紧跟浏览器的刷新步调。\***

具体一点讲，如果屏幕刷新频率是60Hz，那么回调函数每16.7ms被执行一次，如果屏幕刷新频率是75Hz，那么这个时间间隔就变成了1000/75=13.3ms。它能保证回调函数在屏幕每一次的刷新间隔中只被执行一次，这样就不会引起丢帧现象，自然不会导致动画的卡顿。

## **requestAnimationFrame**

requestAnimationFrame是浏览器用于定时循环操作的一个接口，类似于setTimeout，主要用途是按帧对网页进行重绘。

设置这个API的目的是为了让各种网页动画效果（DOM动画、Canvas动画、SVG动画、WebGL动画）能够有一个统一的刷新机制，从而节省系统资源，提高系统性能，改善视觉效果。代码中使用这个API，就是告诉浏览器希望执行一个动画，让浏览器在下一个动画帧安排一次网页重绘。

requestAnimationFrame的优势，在于充分利用显示器的刷新机制，比较节省系统资源。显示器有固定的刷新频率（60Hz或75Hz），也就是说，每秒最多只能重绘60次或75次，requestAnimationFrame的基本思想就是与这个刷新频率保持同步，利用这个刷新频率进行页面重绘。此外，使用这个API，一旦页面不处于浏览器的当前标签，就会自动停止刷新。这就节省了CPU、GPU和电力。

不过有一点需要注意，requestAnimationFrame是在主线程上完成。这意味着，如果主线程非常繁忙，requestAnimationFrame的动画效果会大打折扣。

requestAnimationFrame使用一个回调函数作为参数。这个回调函数会在浏览器重绘之前调用。

```
window.requestAnimationFrame(callback)
```

- **参数：** 其中`callback`接受一个参数`DOMHighResTimeStamp`参数，表示该`callback`执行的时间。
- **返回值：** 返回值requestID：是一个long integer 类型的值。 可以使用`window.cancelAnimationFrame(requestID)`来取消这个回调。

***requestAnimationFrame 比起 setTimeout、setInterval 的比较***

> **优点：**
>
> - requestAnimationFrame 会把每一帧中的所有 DOM 操作集中起来，在一次重绘或回流中就实现，并且重绘或回流的工夫距离紧紧追随浏览器的刷新频率，一般来说，这个频率为每秒 60 帧。
> - 在暗藏或不可见的元素中，requestAnimationFrame 将不会进行重绘或回流，这当然就意味着更少的的 cpu，gpu 和内存使用量。



## **requestIdleCallback**

> MDN上的解释：`requestIdleCallback()`方法将在浏览器的空闲时段内调用的函数排队。这使开发者能够在主事件循环上执行后台和低优先级工作，而不会影响延迟关键事件，如动画和输入响应。函数一般会按先进先调用的顺序执行，然而，如果回调函数指定了执行超时时间timeout，则有可能为了在超时前执行函数而打乱执行顺序。

```
var requestID = window.requestIdleCallback(callback[, options])
```

- **options：** 是一个对象，现在只有一个属性被定义：`timeout` 表示该回调超过这个时间扔未执行，就会强制执行，不必等空闲时间，这个请看**下面代码示例**。

- **callback参数：** 是IdleDeadline对象，包含两个属性： 1：`didTimeout`是一个只读布尔值，表示是否超时。

  2： `timeRemaining()`，是一个方法，返回当前帧还剩多少空余时间。如果没有时间就返回0。

- **返回值：** 返回值requestID可以使用`window.cancelIdleCallback(requestID)`来取消这个回调。

***requestIdleCallback 的比较***

> 优点：常用来切割长任务，利用空闲时间执行，避免主线程长时间阻塞
>
> 缺点：这个办法实践上可行，但为什么 React 团队又 polyfill 这个办法呢？
>
> 1. 浏览器兼容不好的问题
> 2. requestIdleCallback 的 FPS 只有 20，也就是 50ms 刷新一次，远远低于页面晦涩度的要求，所以 React 团队须要本人实现。

> 留神：timeRemaining 最大为 50ms，是有依据钻研得出的，即是说人对用户输出的 100 毫秒以内的响应通常被认为是刹时的，不会被人察觉到。将闲暇工夫限度在 50ms 内意味着即便在闲置工作开始后立刻产生用户操作，用户代理依然有残余的 50ms 能够在其中响应用户输出而不会产生用户可察觉的滞后。

**为什么须要 requestIdleCallback**

> 在网页运行中，有很多耗时但又不是那么重要的工作。这些工作和重要的工作如对用户的输出作出及时响应的之类的工作，它们共享事件队列。如果两者发生冲突，用户体验会很蹩脚。
>
> requestIdleCallback 就解决了这个痛点，requestIdleCallback 会在每一帧完结时并且有闲暇工夫执行回调。
>
> 假如须要大量波及到 DOM 的操作的计算，在运算时，浏览器可能就会呈现显著的卡顿行为，甚至不能进行任何操作，因为是 JS 单线程，就算用在输出解决，给定帧渲染和合成之后，用户的主线程就会变得闲暇，直到下一帧的开始。
>
> 而这些闲暇工夫能够拿来解决低优先级的工作，React16 的调度策略异步可中断，其中要害就靠的这个（polyfill）办法性能；React 把工作细分（工夫切片），在浏览器闲暇的工夫去执行，从而尽可能地进步渲染性能。
>
> 工夫切片的实质是模仿实现 requestIdleCallback
>
> 讲到这里，从 React15 到 React16 Fiber，对整体性能来说是大优化了；但要晓得的是，React16 绝对 15 做出的优化，并不是大大减少了任务量，你写的代码的工作总量并没有变动，只是把闲暇工夫利用起来了，不停的干活，就能更快的把活干完；这只是其中一个角度，React 还做了辨别优先级执行等等。
>
> `requestAnimationFrame`会在每次屏幕刷新的时候被调用，而`requestIdleCallback`则会在每次屏幕刷新时，判断当前帧是否还有多余的时间，如果有，则会调用`requestAnimationFrame`的回调函数
>
> 图片中是两个连续的执行帧，大致可以理解为两个帧的持续时间大概为16.67，图中黄色部分就是空闲时间。所以，`requestIdleCallback`中的回调函数仅会在每次屏幕刷新并且有空闲时间时才会被调用.
>
> 利用这个特性，我们可以在动画执行的期间，利用每帧的空闲时间来进行数据发送的操作，或者一些优先级比较低的操作，此时不会使影响到动画的性能，或者和requestAnimationFrame搭配，可以实现一些页面性能方面的的优化，

> react 的 `fiber` 架构也是基于 `requestIdleCallback` 实现的, 并且在不支持的浏览器中提供了 polyfill

`requestIdleCallback()`常用来切割长任务，利用空闲时间执行，避免主线程长时间阻塞。

**两者应用场景比较**

`requestAnimationFrame`：操作DOM，动画，回调会在每一帧确定执行，属于高优先级工作

`requestIdleCallback`: 回调则不肯定，有闲暇工夫才执行，属于低优先级工作；因为它发生在一帧的最后，此时页面布局已经完成，所以不建议在 requestIdleCallback 里再操作 DOM，这样会导致页面再次重绘。

# Set、Map、WeakSet 和 WeakMap 的区别

**Set**

几个关键点：

- 集合中的元素无序且唯一
- 集合中的元素可以是任何类型，无论是原始值还是对象引用

**WeakSet**

与 Set 的区别

- WeakSet 中的元素只能是对象，不能是其他类型的值
- WeakSet 中的对象都是弱引用，即垃圾回收机制不考虑 WeakSet 对该对象的引用，也就是说，如果该对象不在被其他变量引用，那么垃圾回收机制就会自动回收该对象所占用内存，所以只要 WeakSet 成员对象在外部消失，它们在 WeakSet 里面的引用就会自动消失。
- 由于 WeakSet 内部有多少个成员，取决于垃圾回收机制有没有运行，运行前后很可能成员个数是不一样的，而垃圾回收机制何时运行是不可预测的，因此 ES6 规定 WeakSet 不可遍历。

**WeakMap**

WeakMap 和 Map 区别

- WeakMap 只接受对象作为键名（不包括null）
- WeakMap 键名所指向的对象，不计入垃圾回收机制（同 WeakSet）

**小结：**

Set、Map、WeakSet、WeakMap、都是一种集合的数据结构

Set 和 WeakSet 是一种值-值的集合，且元素唯一不重复

Map 和 WeakMap 是一种键-值对的集合，Map 的键可以是任意类型，WeakMap 的键只能是对象类型。

Set 和 Map可遍历，WeakSet 和 WeakMap不可遍历

WeakSet 和 WeakMap 键名所指向的对象，不计入垃圾回收机制

# 常用技巧方法

## split 方法获取地址栏参数

```js
function getParams(url) {
  const res = {}
  if (url.includes('?')) {
    const str = url.split('?')[1]
    const arr = str.split('&')
    arr.forEach(item => {
      const key = item.split('=')[0]
      const val = item.split('=')[1]
      res[key] = decodeURIComponent(val) // 解码
    })
  }
  return res
}

// 测试
const user = getParams('http://www.baidu.com?user=%E9%98%BF%E9%A3%9E&age=16')
console.log(user) // { user: '阿飞', age: '16' }
```

## 随机生成10以下正数

```
Math.floor(Math.random()*10)
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

## JS中小数相加存在小数位的问题

0.1+0.2=0.300000001，注意要处理

## 截取最后一个特定字符后面的字符串

```
var name=s.substring(s.lastIndexOf("/")+1);
```

# JS操作dom

## querySelector和getElementById

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

## **创建节点添加节点**

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

## 获取屏幕或容器的宽高

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

## 绑定解除事件

事件有三要素 : `事件源`、`事件`、`监听器` 。

**事件源**：在哪个元素上发生的。比如: p标签、a标签、div标签、form表单 等等

 **事件**：到底发生了什么事件。click(点击事件)、mouseover(鼠标事件)、focus(焦点事件) 等

**监听器**：事件源触发事件后，如何回应发生的事件，通常以函数(funtion)的形式来出现。

常见有3种绑定方式：

- 1、直接在html元素上进行绑定事件。

  ```
  <input id="btn" type="button" onclick="test();" /> <!--点击按钮 触发事件-->
  缺点：HTML与js代码紧密耦合。如果要更换 事件，就要改动两个地方:HTML代码和JS代码，这就不利于后期代码的维护。
  ```

- 2、用 on 绑定事件。

  ```
   var div=document.getElementById('id');
      div.onclick=function(){
          console.log('甲需要红背景');
          div.setAttribute('style', 'background: #ff0000');
      };
  优点：它最大的优点是就是兼容性很好，所有浏览器都支持
  缺点：同一个 dom 元素上，on 只能绑定一个同类型事件，后者会覆盖前者，不同类型的事件可以绑定多个。有一个问题，无法允许团队不同人员对同一元素监听同一事件但做出不用的响应
  ```

- 3、用 addEventListener、attachEvent 绑定事件。

```
var oBox = document.getElementById("container");
//绑定事件
oBox.addEventListener("click",fn(),false);
//解绑事件
oBox.removeEventListener("click",fn(),false);

var oBox = document.getElementById("container");
//绑定
oBox.attach("click",fn());
//解绑
oBox.detach("click",fn());
优点：它们可以支持绑定多个同类型事件
缺点：兼容性并不好,它们只兼容相对应的浏览器才有用。
```

## 监听串口变化

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

# 奇葩的JavaScript闭包面试题

```
function fun(n,o) {
  console.log(o)
  return {
    fun:function(m){
      return fun(m,n);
    }
  };
}
var a = fun(0);  a.fun(1);  a.fun(2);  a.fun(3);//undefined,?,?,?
var b = fun(0).fun(1).fun(2).fun(3);//undefined,?,?,?
var c = fun(0).fun(1);  c.fun(2);  c.fun(3);//undefined,?,?,?
```

 这是一道非常典型的JS闭包问题。其中嵌套了三层fun函数，搞清楚每层fun的函数是那个fun函数尤为重要。 可以先在纸上或其他地方写下你认为的结果，然后展开看看正确答案是什么？

```
//答案：
//a: undefined,0,0,0
//b: undefined,0,1,2
//c: undefined,0,1,1
```

## JS中有几种函数

首先，在此之前需要了解的是，在JS中函数可以分为两种，**具名函数（命名函数）**和**匿名函数**。 区分这两种函数的方法非常简单，可以通过输出 fn.name 来判断，有name的就是具名函数，没有name的就是匿名函数

> 注意：在低版本IE上无法获取具名函数的name，会返回undefined，建议在火狐或是谷歌浏览器上测试

或是采用兼容IE的获取函数name方法来获取函数名称：

```
/**
    * 获取指定函数的函数名称（用于兼容IE）
    * @param {Function} fun 任意函数
    */
function getFunctionName(fun) {
    if (fun.name !== undefined)
        return fun.name;
    var ret = fun.toString();
    ret = ret.substr('function '.length);
    ret = ret.substr(0, ret.indexOf('('));
    return ret;
}
```

遂用上述函数测试是否为匿名函数： [![image](http://images2015.cnblogs.com/blog/746158/201511/746158-20151124155220468-1074861494.png)](http://images2015.cnblogs.com/blog/746158/201511/746158-20151124155219640-2082081917.png) 可以得知变量fn1是具名函数，fn2是匿名函数

## 创建函数的几种方式

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

## 三个fun函数的关系是什么？

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

## 函数作用域链的问题

再说第三个fun函数之前需要先说下，在*函数表达式*内部能不能访问存放当前函数的变量。  **测试1，对象内部的函数表达式：**

```
var o={
  fn:function (){
    console.log(fn);
  }
};
o.fn();//ERROR报错
```

**测试2，非对象内部的函数表达式：**

```
var fn=function (){
  console.log(fn);
};
fn();//function (){console.log(fn);};正确
```

结论是：使用var或是非对象内部的函数表达式内，可以访问到存放当前函数的变量；在对象内部的不能访问到。 原因也非常简单，因为**函数作用域链**的问题，采用var的是在外部创建了一个fn变量，函数内部当然可以在内部寻找不到fn后向上册作用域查找fn，而在创建对象内部时，因为没有在函数作用域内创建fn，所以无法访问。  所以综上所述，可以得知，**最内层的return出去的fun函数不是第二层fun函数，是最外层的fun函数**。 所以，三个fun函数的关系也理清楚了，第一个等于第三个，他们都不等于第二个。  

## 到底在调用哪个函数？

再看下原题，现在知道了程序中有两个fun函数(第一个和第三个相同)，遂接下来的问题是搞清楚，运行时他执行的是哪个fun函数？

```
function fun(n,o) {
  console.log(o)
  return {
    fun:function(m){
      return fun(m,n);
    }
  };
}
var a = fun(0);  a.fun(1);  a.fun(2);  a.fun(3);//undefined,?,?,?
var b = fun(0).fun(1).fun(2).fun(3);//undefined,?,?,?
var c = fun(0).fun(1);  c.fun(2);  c.fun(3);//undefined,?,?,?
//问:三行a,b,c的输出分别是什么？
```

 **1、第一行a**

```
var a = fun(0);  a.fun(1);  a.fun(2);  a.fun(3);
```

> 可以得知，第一个fun(0)是在调用**第一层fun函数**。第二个fun(1)是在调用前一个fun的返回值的fun函数，所以： 第后面几个fun(1),fun(2),fun(3),函数都是在调用**第二层fun函数**。 遂： 在第一次调用fun(0)时，o为undefined； 第二次调用fun(1)时m为1，此时fun闭包了外层函数的n，也就是第一次调用的n=0，即m=1，n=0，并在内部调用第一层fun函数fun(1,0);所以o为0； 第三次调用fun(2)时m为2，但依然是调用a.fun，所以还是闭包了第一次调用时的n，所以内部调用第一层的fun(2,0);所以o为0 第四次同理； 即：最终答案为undefined,0,0,0  

**2、第二行b**

```
var b = fun(0).fun(1).fun(2).fun(3);//undefined,?,?,?
```

> 先从fun(0)开始看，肯定是调用的第一层fun函数；而他的返回值是一个对象，所以第二个fun(1)调用的是第二层fun函数，后面几个也是调用的第二层fun函数。 遂： 在第一次调用第一层fun(0)时，o为undefined； 第二次调用 .fun(1)时m为1，此时fun闭包了外层函数的n，也就是第一次调用的n=0，即m=1，n=0，并在内部调用第一层fun函数fun(1,0);所以o为0； 第三次调用 .fun(2)时m为2，此时当前的fun函数不是第一次执行的返回对象，而是**第二次执行的返回对象**。而在第二次执行第一层fun函数时时(1,0)所以n=1,o=0,返回时闭包了第二次的n，遂在第三次调用第三层fun函数时m=2,n=1，即调用第一层fun函数fun(2,1)，所以o为1； 第四次调用 .fun(3)时m为3，闭包了第三次调用的n，同理，最终调用第一层fun函数为fun(3,2)；所以o为2； 即最终答案：undefined,0,1,2  

**3、第三行c**

```
var c = fun(0).fun(1);  c.fun(2);  c.fun(3);//undefined,?,?,?
```

> 根据前面两个例子，可以得知： fun(0)为执行第一层fun函数，.fun(1)执行的是fun(0)返回的第二层fun函数，这里语句结束，遂c存放的是fun(1)的返回值，而不是fun(0)的返回值，所以c中闭包的也是fun(1)第二次执行的n的值。c.fun(2)执行的是fun(1)返回的第二层fun函数，c.fun(3)执行的**也**是fun(1)返回的第二层fun函数。 遂： 在第一次调用第一层fun(0)时，o为undefined； 第二次调用 .fun(1)时m为1，此时fun闭包了外层函数的n，也就是第一次调用的n=0，即m=1，n=0，并在内部调用第一层fun函数fun(1,0);所以o为0； 第三次调用 .fun(2)时m为2，此时fun闭包的是第二次调用的n=1，即m=2，n=1，并在内部调用第一层fun函数fun(2,1);所以o为1； 第四次.fun(3)时同理，但依然是调用的第二次的返回值，遂最终调用第一层fun函数fun(3,1)，所以o还为1 即最终答案：undefined,0,1,1  

# devDependencies 和 dependencies 的区别

`devDependencies` 和 `dependencies`的区别核心体现在 **npm包** 中。

只要开发的项目是**发npm包**提供给外部、其他业务项目使用的，需要非常注意依赖的安装地方，因为搞不好很容易在业务使用中会出现bug。dependencies的依赖包会被打入到npm包中，慎用。

而如果只是自己项目用，**不需要发npm包**的话，把依赖安装到 `devDependencies` 或者 `dependencies` 中，实质上是没有任何区别的。