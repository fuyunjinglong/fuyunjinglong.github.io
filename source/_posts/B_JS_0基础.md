---
title: 0基础_JS
date: 2099-05-29 07:33:16
categories:
- B_JS
toc: true # 是否启用内容索引
---

# 基础

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

也叫内置对象

- 6基本类型：Number,String,Boolean,Null,undefined,symbol(ES6),BigInt(ES2020)
- 3引用类型：Object,Array,function,日期、正则、Map/Set等

## null和undefined

> - **`undefined`**：表示 **“缺失”**（本来应该有值，但还没给）。
> - **`null`**：表示 **“空”**（特意设定为没有值）。

1.类型不同

```js
console.log(typeof undefined); // "undefined"
console.log(typeof null);      // "object" (注意这是一个历史Bug，null并不是对象)
```

2.语义与出现场景不同

```js
let a;
console.log(a); // undefined (变量声明了但未赋值)

let b = null; // 主动赋值为 null
console.log(b); // null
```

3.转换为数字时的结果不同

```js
// undefined 转数字是 NaN (Not a Number)
console.log(Number(undefined)); // NaN
console.log(5 + undefined);     // NaN

// null 转数字是 0
console.log(Number(null));      // 0
console.log(5 + null);          // 5
```

4.相等性比较

```js
console.log(null == undefined);  // true  (因为双等号会进行类型转换，JS认为它们都是“假值”)
console.log(null === undefined); // false (类型不同)
```

**isNaN和Number.isNaN**

- isNaN是es5的语法特性,这个值能被转成一个合法的数字吗？如果不能，我就返回 true。
- Number.isNaN是es6的语法特性。先判断类型，如果不是 `number` 类型，直接返回 `false`。如果是 `number` 类型，再判断是不是 `NaN`。

| 参数值      | `isNaN(val)` (全局) | `Number.isNaN(val)` (ES6) | 解释                                       |
| :---------- | :------------------ | :------------------------ | :----------------------------------------- |
| `NaN`       | `true`              | `true`                    | 两者结果一致                               |
| `'hello'`   | **`true`**          | **`false`**               | `isNaN` 转换失败变成 NaN；后者直接判断不是 |
| `undefined` | **`true`**          | **`false`**               | 同上                                       |
| `{}`        | **`true`**          | **`false`**               | 同上                                       |
| `123`       | `false`             | `false`                   | 两者结果一致                               |
| `'123'`     | `false`             | `false`                   | `isNaN` 转为 123；后者直接判断不是         |



## JS 类型判断-对象,数组

第一，使用 typeof 加 length 属性

数组有 length 属性，object 没有，而 typeof 数组与对象都返回 object，所以我们可以这么判断

```js
var getDataType = function(o){
    if(typeof o == 'object'){
        if( typeof o.length == 'number' ){
            return 'Array';
        } else {
            return 'Object';   
        }
    } else {
        return 'param is no object type';
    }
};
```

第二，使用 instanceof

利用 instanceof 判断数据类型是对象还是数组时应该优先判断 array，最后判断 object。

```js
var getDataType = function(o){
    if(o instanceof Array){
        return 'Array'
    } else if ( o instanceof Object ){
        return 'Object';
    } else {
        return 'param is no object type';
    }
};
```

## JS类型判断-完整

**typeof**

缺点：无法区分null，数组，对象

```js
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

**instanceof**

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

手写instanceof

```
function myInstanceof(left, right) {
    // 这里先用typeof来判断基础数据类型，如果是，直接返回false
    if(typeof left !== 'object' || left === null) return false;
    // getProtypeOf是Object对象自带的API，能够拿到参数的原型对象
    let proto = Object.getPrototypeOf(left);// 等价于left.__proto__;
    while(true) {                  
        if(proto === null) return false;
        if(proto === right.prototype) return true;//找到相同原型对象，返回true
        proto = Object.getPrototypeof(proto);
    }
}
```

**constructor**

`constructor`主要是利用原型上的`prototype.constructor`指向实例的构造函数来进行判断的。

缺点：不能判断undefined和null，并且使用它是不安全的，因为contructor的指向是可以改变的

```
console.log('1'.constructor === String);  // true
console.log(new Number(1).constructor === Number); // true
console.log(true.constructor === Boolean); // true
console.log(alert.constructor === Function); // true
console.log([].constructor === Array); // true
console.log(new Date().constructor === Date); // true
```

**toString**

`toString`是`Object.prototype`上的一个方法, 常用方式为 `Object.prototype.toString.call(target)`返回值是 `[object 类型]`字符串,该方法基本上能判断所有的数据类型(自定义数据类型除外)

```
// 定义判断类型函数
let getType = target => Object.prototype.toString.call(target)

console.log(getType('')); // [object String]
console.log(getType(2)); // [object Number]
console.log(getType(true)); // [object Boolean]
console.log(getType(undefined)); // [object Undefined]
console.log(getType(null)); // [object Null]
console.log(getType(Symbol())); // [object Symbol]
console.log(getType({})); // [object Object]
console.log(getType([])); // [object Array]
console.log(getType(alert)); // [object Function]
console.log(getType(new RegExp())); // [object RegExp]
console.log(getType(new Date())); // [object Date]
```

## 模块化规范

参考

- [前端模块化详解(完整版)](https://juejin.cn/post/6844903744518389768#heading-2)

**模块化是什么？**

- 按照一定的规则(规范)封装成几个块(文件), 并自由组合在一起
- 对内数据封装，对外暴露接口

**模块化详解**

- ESModule支持es6语法的浏览器规范
- CommonJS 是同步支持nodejs的后端规范
- UMD统一模块规范，支持amd和cmd(amd和cmd一般不单独使用)，支持全局变量Vue

```
常用的是ESM和CJS,其中UMD还可以指定全局变量
浏览器端使用ESM和UMD,nodejs使用CJS
```

> **ESModule**

简称ESM,是一个符合ES6语法的模块化规范，语法为：import export。

ECMAScript 6 的一个目标是解决作用域的问题，也为了使 JS 应用程序显得有序，于是引进了模块。目前部分主流浏览器已原生支持 ES Module，使用 type = module 指定为模块引入即可
注意：使用该方式执行 JS 时自动应用 defer 属性。

ESM由于具有简单的语法，**同步异步**加载的特性，适用于前后端，以及**Tree-shakeable**的特性.具有Tree-shakeable的特性，这是由于**ES6的静态模块**结构。

```js
import {foo, bar} from './myLib';
...
export default function() {
  // your Function
};
export const function1() {...};
export const function2() {...};
```

- 在很多[现代浏览器](https://link.juejin.cn?target=https%3A%2F%2Fcaniuse.com%2Fes6-module)可以使用
- 它兼具两方面的优点：具有 `CJS` 的简单语法和 `AMD` 的异步
- 得益于 `ES6` 的[静态模块结构](https://link.juejin.cn?target=https%3A%2F%2Fexploringjs.com%2Fes6%2Fch_modules.html%23sec_design-goals-es6-modules)，可以进行 [ Tree Shaking](https://link.juejin.cn?target=https%3A%2F%2Fdevelopers.google.com%2Fweb%2Ffundamentals%2Fperformance%2Foptimizing-javascript%2Ftree-shaking%2F)
- `ESM` 允许像 `Rollup` 这样的打包器，[删除不必要的代码](https://link.juejin.cn?target=https%3A%2F%2Fdev.to%2Fbennypowers%2Fyou-should-be-using-esm-kn3)，减少代码包可以获得更快的加载
- 可以在 `HTML` 中调用，只要如下

```javascript
<script type="module">
  import {func1} from 'my-lib';

  func1();
</script>
```

> **CommonJS **

简称CJS,是同步支持nodejs的后端规范。语法为：module.exports，require。

```javascript
// importing 
const doSomething = require('./doSomething.js'); 

// exporting
module.exports = function doSomething(n) {
  // do something
}
复制代码
```

- 很多人可以从 `Node` 中立刻认出 `CJS` 的语法。这是因为 `Node` 就是使用 [`CJS` 模块](https://link.juejin.cn?target=https%3A%2F%2Fblog.risingstack.com%2Fnode-js-at-scale-module-system-commonjs-require%2F)的
- `CJS` 是同步导入模块
- 你可以从 `node_modules` 中引入一个库或者从本地目录引入一个文件 。如 `const myLocalModule = require('./some/local/file.js')` 或者 `var React = require('react');` ，都可以起作用
- 当 `CJS` 导入时，它会给你一个导入对象的副本
- `CJS` 不能在浏览器中工作。它必须经过转换和打包

CommonJS和es6区别

> - 因为CommonJS的`require`语法是同步的，所以就导致了CommonJS模块规范只适合用在服务端，而ES6模块无论是在浏览器端还是服务端都是可以使用的，但是在服务端中，还需要遵循一些特殊的规则才能使用 ；
> - CommonJS 模块输出的是一个值的拷贝，而ES6 模块输出的是值的引用；
> - CommonJS 模块是动态引入，执行时引入，而ES6 模块是静态引入，编译时引入；
> - 因为两个模块加载机制的不同，所以在对待循环加载的时候，它们会有不同的表现。CommonJS遇到循环依赖的时候，只会输出已经执行的部分，后续的输出或者变化，是不会影响已经输出的变量。而ES6模块相反，使用`import`加载一个变量，变量不会被缓存，真正取值的时候就能取到最终的值；
> - 关于模块顶层的`this`指向问题，在CommonJS顶层，`this`指向当前模块；而在ES6模块中，`this`指向`undefined`；

> **UMD**

简称统一模块规范，支持amd和cmd(amd和cmd一般不单独使用)，支持全局变量Vue

- 当使用 `Rollup/Webpack` 之类的打包器时，`UMD` 通常用作备用模块

`AMD` 代表异步模块定义。

```js
define(['dep1', 'dep2'], function (dep1, dep2) {
    //Define the module value by returning a value.
    return function () {};
});
或者
define(function (require) {
    var dep1 = require('dep1'),
        dep2 = require('dep2');
    return function () {};
});
```

- `AMD` 是异步(`asynchronously`)导入模块的(因此得名)
- 一开始被提议的时候，`AMD` 是为前端而做的(而 `CJS` 是后端)
- `AMD` 的语法不如 `CJS` 直观。我认为 `AMD` 和 `CJS` 完全相反

**模块化进化过程**

> **全局function模式** 

 将不同的功能封装成不同的全局函数

- 编码: 将不同的功能封装成不同的全局函数
- 问题: 污染全局命名空间, 容易引起命名冲突或数据不安全，而且模块成员之间看不出直接关系

> **namespace模式** 

简单对象封装

- 作用: 减少了全局变量，解决命名冲突
- 问题: 数据不安全(外部可以直接修改模块内部的数据)

```
let myModule = {
  data: 'www.baidu.com',
  foo() {
    console.log(`foo() ${this.data}`)
  },
  bar() {
    console.log(`bar() ${this.data}`)
  }
}
myModule.data = 'other data' //能直接修改模块内部的数据
myModule.foo() // foo() other data
```

> **IIFE模式**

匿名函数自调用(闭包)

- 作用: 数据是私有的, 外部只能通过暴露的方法操作
- 编码: 将数据和行为封装到一个函数内部, 通过给window添加属性来向外暴露接口
- 问题: 如果当前这个模块依赖另一个模块怎么办?

```
// index.html文件
<script type="text/javascript" src="module.js"></script>
<script type="text/javascript">
    myModule.data = 'xxxx' //不是修改的模块内部的data
    myModule.foo() //没有改变
</script>

// module.js文件
(function(window) {
  let data = 'www.baidu.com'
  //操作数据的函数
  function foo() {
    //用于暴露有函数
    console.log(`foo() ${data}`)
  }
  function bar() {
    //用于暴露有函数
    console.log(`bar() ${data}`)
    otherFun() //内部调用
  }
  function otherFun() {
    //内部私有的函数
    console.log('otherFun()')
  }
  //暴露行为
  window.myModule = { foo, bar } //ES6写法
})(window)
```

> **IIFE模式增强** 

 引入依赖,这就是现代模块实现的基石。**这样做除了保证模块的独立性，还使得模块之间的依赖关系变得明显**。

```
// module.js文件
(function(window, $) {
  let data = 'www.baidu.com'
  //操作数据的函数
  function foo() {
    //用于暴露有函数
    console.log(`foo() ${data}`)
    $('body').css('background', 'red')
  }
  function bar() {
    //用于暴露有函数
    console.log(`bar() ${data}`)
    otherFun() //内部调用
  }
  function otherFun() {
    //内部私有的函数
    console.log('otherFun()')
  }
  //暴露行为
  window.myModule = { foo, bar }
})(window, jQuery)
```

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

## async和defer的作用是什么？有什么区别?

- `script` ：会阻碍 HTML 解析，只有下载好并执行完脚本才会继续解析 HTML。
- `async script` ：解析 HTML 过程中进行脚本的异步下载，下载成功立马执行，有可能会阻断 HTML 的解析。
- `defer script`：完全不会阻碍 HTML 的解析，解析完成之后再按照顺序执行脚本。

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

# 中级

## 深浅拷贝

var obj={}

obj存放在栈内存中，{}实例存在在堆中。

```
//example 1
let a={}, b='0', c=0;
a[b]='珠峰';
a[c]='培训';
console.log(a[b]); // '培训', 对象的key数字和字符串等效

// ---------------------
//example 2
let a={}, b=Symbol('1'), c=Symbol('1');
a[b]='珠峰';
a[c]='培训';
console.log(a[b]); // '珠峰', Symbol的特点，都是唯一的

// ---------------------
//example 3
let a={}, b={n:'1'}, c={m:'2'};
a[b]='珠峰';
a[c]='培训';
console.log(a[b]); // '培训', key会转化成字符串[Obejct object]
```

**赋值、浅拷贝、深拷贝**

赋值：把一个对象赋给一个新变量，赋的其实是该对象在栈中的地址，所有值都会相互影响

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

**(1)定义**

JavaScript 中自动垃圾回收机制的原理为：

```
找出那些不再使用的变量，然后释放其占用的内存。
垃圾收集器会按照固定的时间间隔(或预定的收集时间)周期性地执行此操作。
```

**(2)内存生命周期**

不管什么程序语言，内存生命周期基本是一致的：

- 分配你所需要的内存
- 使用分配到的内存（读、写）
- 不需要时将其释放归还

对于javascript而言，

- 简单类型，内存是保存在栈（stack）空间
- 复杂数据类型，内存是保存在堆（heap）空间

**(3)为什么需要垃圾回收机制？**

在Chrome中，v8被限制了内存的使用（64位约1.4G/1464MB ， 32位约0.7G/732MB），为什么要限制？

- 表层原因是，V8最初为浏览器而设计，不太可能遇到用大量内存的场景。JS的单线程机制，垃圾回收的过程阻碍了主线程逻辑的执行。
- 深层原因是，V8的垃圾回收机制的限制（垃圾回收的过程缓慢，也就会导致主线程的等待时间越长，那么性能和应用直线下降）

**(4)垃圾收集机制**

V8的垃圾回收策略主要是基于`分代垃圾回收机制`，其根据**对象的存活时间**将内存的垃圾回收进行不同的分代，然后对不同的分代采用不同的垃圾回收算法。

(1.1)内存模型

- 新生代：生存时间短的对象，支持 1～8M 的容量
- 老年代：生存时间长的对象，容量较大

为了提高回收效率，V8 分别使用两个不同的垃圾回收器，

- 副垃圾回收器 - Scavenge：主要负责新生代的垃圾回收。
- 主垃圾回收器 - Mark-Sweep & Mark-Compact：主要负责老生代的垃圾回收。

(1.2)新生代回收

在新生代中，主要使用`Scavenge`算法进行垃圾回收，`Scavenge`算法是一个典型的牺牲空间换取时间的复制算法，在占用空间不大的场景上非常适用。

Scavange算法将新生代堆分为两部分，分别叫`from-space`和`to-space`。

工作过程如下：

- 标记活动对象和非活动对象
- 复制 from space 的活动对象到 to space 并对其进行排序
- 释放 from space 中的非活动对象的内存
- 将 from space 和 to space 角色互换

<img src="/img/image-20220222215742735.png" alt="image-20220222215742735" style="zoom: 80%;" />

新生代又细分为`nursery`子代和`intermediate`子代两个区域。一个对象第一次分配内存时会被分配到新生代中的`nursery`子代，如果进过下一次垃圾回收这个对象还存在新生代中，这时候我们移动到 `intermediate` 子代，再经过下一次垃圾回收，如果这个对象还在新生代中，副垃圾回收器会将该对象移动到老生代中，这个移动的过程被称为**晋升**。

对象晋升的条件主要有以下两个：

- 对象是否经历过一次`Scavenge`算法
- `To`空间的内存占比是否已经超过`25%`(之所以有`25%`的内存限制是因为`To`空间在经历过一次`Scavenge`算法后会和`From`空间完成角色互换，会变为`From`空间，后续的内存分配都是在`From`空间中进行的，如果内存使用过高甚至溢出，则会影响后续对象的分配，因此超过这个限制之后对象会被直接转移到老生代来进行管理)

(1.3)老年代回收

scavenge算法缺陷：

- scavenge为复制算法，重复复制活动对象会使得效率低下
- scavenge是牺牲空间来换取时间效率的算法，而老生代支持的容量较大，会出现空间资源浪费问题

老年代采用 Mark-Sweep（标记清除） 和 Mark-Compact（标记整理） 算法。

1.）Mark-Sweep

Mark-Sweep处理时分为两阶段，标记阶段和清理阶段。看起来与Scavenge类似，不同的是，Mark-Sweep在标记了活动对象和非活动对象之后，直接把非活动对象清除。

- 标记阶段：对老生代进行第一次扫描，标记活动对象
- 清理阶段：对老生代进行第二次扫描，清除未被标记的对象，即清理非活动对象

<img src="/img/image-20220504095928130.png" alt="11" style="zoom: 80%;" />

但是遗留一个问题，被清除的对象遍布于各内存地址，产生很多内存碎片。

2.)Mark-Compact

若不清理这些内存碎片，如果出现需要分配一个大对象的时候，这时所有的碎片空间都完全无法完成分配，就会提前触发垃圾回收,而这次回收其实不是必要的。

Mark-Compact被提出，它是在 Mark-Sweep的基础上演进而来的，相比Mark-Sweep，Mark-Compact添加了活动对象整理阶段，将所有的活动对象往一端移动，移动完成后，直接清理掉边界外的内存。

<img src="/img/image-20220222220554956.png" alt="image-20220222220554956" style="zoom: 80%;" />

(1.4)全停顿 Stop-The-World

由于垃圾回收是在JS引擎中进行的，而Mark-Compact算法在执行过程中需要移动对象，而当活动对象较多的时候，它的执行速度不可能很快，为了避免JavaScript应用逻辑和垃圾回收器的内存资源竞争导致的不一致性问题，垃圾回收器会将JavaScript应用暂停，这个过程，被称为`全停顿`（stop-the-world）。

在新生代中，由于空间小、存活对象较少、Scavenge算法执行效率较快，所以全停顿的影响并不大。而老生代中就不一样，如果老生代中的活动对象较多，垃圾回收器就会暂停主线程较长的时间，使得页面变得卡顿。

**(5)标记活动对象和非活动对象的策略**

通常有两个：**引用计数**和**标记清除**

- 引用计数-dom的垃圾回收机制
- 标记清除-js的垃圾回收机制

(1.1)引用计数

定义：每个值被引用的次数。声明一个变量后，当使用引用类型值赋值时，+1，当这个变量又赋值另外一值，计数-1。

这是最初级的垃圾收集算法，如果没有引用指向该对象（零引用），对象将被垃圾回收机制回收。

缺陷:在循环的情况下，引用计数算法存在很大的局限性。

```
存在内存泄漏
function problem() {
var objA = new Object();
var objB = new Object();
objA.someOtherObject = objB;
objB.anotherObject = objA;
}
objectA 和objectB 通过各自的属性相互引用，即这两个对象的引用次数都是2，在采用标记清除策略的实现中，由于函数执行之后，这两个对象都离开了作用域，因此这种相互引用不是个问题。但在采用引用计数策略的实现中，当函数执行完毕后，objectA 和objectB 还说明将继续存在，因为它们的引用次数永远不会是0。

DOM中也如此
var element=document.getElementById（''）；
var myObj=new Object();
myObj.element=element;
element.someObject=myObj;
```

(1.2)标记清除

定义：当变量进入环境时，标记“进入环境”。当变量离开环境时，标记“离开环境”。

垃圾回收器创建了一个“roots”列表,“window”对象是一个全局变量，被当作root.

从root开始的所有对象如果是可达的，它就不被当作垃圾。所有未被标记的内存会被当做垃圾，收集器现在可以释放内存。

循环引用的问题迎刃而解，缺点: 算法运行时程序执行被暂停。

```
以下几种情况都可以作为根节点：
全局对象
本地函数的局部变量和参数
当前嵌套调用链上的其他函数的变量和参数
```

## 内存溢出和内存泄漏

**概念**

内存溢出：当程序需要的内存超过了剩余内存，就会抛出内存溢出错误。

内存泄漏：**不再用到的内存，没有及时释放，就叫做内存泄漏。**应用程序不再需要占用内存的时候，由于某些原因，内存没有被操作系统或可用内存池回收。

**内存泄漏的几种原因**

> - 意外的全局变量
> - 被遗忘的定时器或回调函数
> - 被遗忘的dom引用
> - 闭包

(1)意外的全局变量

```
function foo(arg) {
    bar = "this is a hidden global variable";
    this.bar = "potential accidental global"
}

真相是：
function foo(arg) {
    window.bar = "this is an explicit global variable";
}

实战：
<html>
<head></head>
<body>
<botton onclick="grow()">点击测试内存泄漏</botton>
<botton onclick="clearGrow()">点击释放内存</botton>
<div id="nodes"></div>
<script>
var largeObj = []
function grow(){
grow3()
}
function clearGrow(){
clearGrow3()
}
function getBigData(){
let res = []
for (var i = 0; i < 100; i++) {
let obj = {}
for(let i=0;i<10000;i++){
  obj[`key-${i}`] = `js创建一个很大内存的对象？`
}
res.push(obj)
}
return res
}
function grow0(){
 largeObj=[...largeObj,getBigData()]
}
var timer
function grow1(){
let someResource = getBigData();
 timer = setInterval(function() {
    var node = document.getElementById('nodes');
    if(node) {
        node.innerHTML = JSON.stringify(someResource);
        // 定时器也没有清除
    }
    // node、someResource 存储了大量数据 无法回收
}, 1000);
}
function clearGrow1(){
window.clearInterval(timer)
}
var childNode = document.createElement('p');
function grow2(){
let someResource = getBigData();
var node = document.getElementById('nodes');
    if(node) {
childNode.innerHTML = JSON.stringify(someResource);
node.appendChild(childNode)
  }
}
function clearGrow2(){
var node = document.getElementById('nodes');
node.remove();
//childNode = null;
}
function grow3(){
var theThing = null
    var replaceThing = function () {
        var originalThing = theThing
        var unused = function () {
            if (originalThing)
                console.log("hi")
        }
        theThing = {
            longStr: new Array(1000000).join('*'),
            someMethod: function someMethod() {
                console.log('someMessage')
            }
        };
    };
    setInterval(replaceThing,100)
}
function clearGrow3(){
解决: 去除unuserd函数或者在replaceThing函数最后一行加上 originlThing = null.
}
</script>
</body>
</html>
```

![image-20220313115045079](/img/image-20220313115045079.png)

解决方法：

- 避免创建全局变量
- 在 JavaScript 文件头部加上 `'use strict'`，可以避免此类错误发生。启用严格模式解析 JavaScript ，避免意外的全局变量

(2)被遗忘的定时器或回调函数

```
var timer
function grow1(){
let someResource = getBigData();
 timer = setInterval(function() {
    var node = document.getElementById('nodes');
    if(node) {
        node.innerHTML = JSON.stringify(someResource);
        // 定时器也没有清除
    }
    // node、someResource 存储了大量数据 无法回收
}, 1000);
}
function clearGrow1(){
window.clearInterval(timer)
}

原因:与节点或数据关联的计时器不再需要，node 对象可以删除，整个回调函数也不需要了。可是，计时器回调函数仍然没被回收（计时器停止才会被回收）。同时，someResource 如果存储了大量的数据，也是无法被回收的。
解决方法： 在定时器完成工作的时候，手动清除定时器和回调函数。
现代的浏览器（包括 IE 和 Microsoft Edge）使用了更先进的垃圾回收算法，已经可以正确检测和处理循环引用了。换言之，回收节点内存时，不必非要调用 removeEventListener 了。
```

![image-20220313115410595](/img/image-20220313115410595.png)

![image-20220313120537563](/img/image-20220313120537563.png)

(3)被遗忘的dom引用

```
function grow2(){
let someResource = getBigData();
var node = document.getElementById('nodes');
    if(node) {
childNode.innerHTML = JSON.stringify(someResource);
node.appendChild(childNode)
  }
}

function clearGrow2(){
var node = document.getElementById('nodes');
node.remove();
//childNode = null;必须主动释放dom引用
}
```

![image-20220320214519742](/img/image-20220320214519742.png)

**原因**: 保留了DOM节点的引用,导致GC没有回收

**解决办法**：断开引用，childNode=null

(4)闭包

使用闭包只是让内存常驻，滥用闭包才会导致内存泄漏。

```
function grow3(){
var theThing = null
    var replaceThing = function () {
        var originalThing = theThing
        var unused = function () {
            if (originalThing)
                console.log("hi")
        }
        theThing = {
            longStr: new Array(1000000).join('*'),
            someMethod: function someMethod() {
                console.log('someMessage')
            }
        };
    };
    setInterval(replaceThing,100)
}

function clearGrow3(){
解决: 去除unuserd函数或者在replaceThing函数最后一行加上 originlThing = null.
}
```

首先我们明确一下，unused是一个闭包，因为它引用了自由变量 originalThing，虽然它被没有使用，但v8引擎并不会把它优化掉，因为 JavaScript里存在eval函数，所以v8引擎并不会随便优化掉暂时没有使用的函数。

theThing 引用了someMethod，someMethod这个函数作用域隐式的和unused这个闭包共享一个闭包上下文。所以someMethod也引用了originalThing这个自由变量。

```
GCHandler -> replaceThing -> theThing -> someMethod -> originalThing -> someMethod(old) -> originalThing(older)-> someMethod(older)
```

这里面的引用链是：

随着setInterval的不断执行，这条引用链是不会断的，所以内存会不断泄漏，直致程序崩溃。
因为是闭包作用域引起的内存泄漏，这时候最好的选择是使用 chrome的heap snapshot的container视图，我们通过container视图能清楚的看到这条不断泄漏内存的引用链

![image-20220320221047255](/img/image-20220320221047255.png)

这是一段糟糕的代码,每次调用 replaceThing ，theThing 得到一个包含一个大数组和一个新闭包（someMethod）的新对象。同时，变量 unused 是一个引用 originalThing 的闭包（先前的 replaceThing 又调用了theThing）。思绪混乱了吗？最重要的事情是，闭包的作用域一旦创建，它们有同样的父级作用域，作用域是共享的。someMethod 可以通过 theThing 使用，someMethod 与 unused 分享闭包作用域，尽管 unused 从未使用，它引用的 originalThing 迫使它保留在内存中（防止被回收）。当这段代码反复运行，就会看到内存占用不断上升，垃圾回收器（GC）并无法降低内存占用。本质上，闭包的链表已经创建，每一个闭包作用域携带一个指向大数组的间接的引用，造成严重的内存泄漏。

**解决**: 去除unuserd函数或者在replaceThing函数最后一行加上 originlThing = null.

**4.内存泄漏排查手段**

> - 打开ChromeDevTools-Performance
> - 勾选 Screenshots 和 memory
> - 左上角小圆点开始录制(record)
> - 停止录制
> - 查看heap对内存是否周期性变化

内存泄漏优化

> - 数组优化，用完arr=[]
> - 对象复用，t=null
> - 在循环中的表达式，最好放在循环外面

(1)chrome devtools-memory工具

主要功能分为：Head snapshot堆快照，Allocaiton instrumentastion on timeline(js堆内存在时间线上的回收情况)

```
<botton @click="grow()"></botton>
function largeObj(){
var largeArr= new Array(1000_10000);
}
var x= [];
fucntion grow(){
var o = new larfeObj();
x.push(new Array(1000_10000));
}

```

1)Head snapshot堆快照

```
1.核心参数
Summary：摘要视图
Comparison：对比视图，与其它快照对比，看增、删、Delta数量及内存大小
Containment：俯瞰视图，自顶向下看堆的情况，根节点包括window对象，GC root，原生对象等等列头
Shallow Size   ： 对象本身占用的内存
Retained Size ： 对象本身及其引用总共占用的内存
Distance ：当前对象到根的引用层级距离
Alloc. Size : 新分配的内存
Freed  Size ： 释放的内存
2.其他参数
Detached DOM tree：表示它已经不在DOM树上了，但Javascript仍旧对它有引用
(compiled code) — 未知，估计是程序代码区
(closure) — 闭包(array) — 未知
Object — JS对象类型(system) — 未知
(string) — 字符串类型，有时对象里添加了新属性，属性的名称也会出现在这里
Array — JS数组类型cls — 游戏大厅特有的继承类
Window — JS的window对象
Quark.DisplayObjectContainer — Quark引擎的显示容器类
Quark.ImageContainer — Quark引擎的图片类
Quark.Text — Quark引擎的文本类
Quark.ToggleButton — Quark引擎的开关按钮类

```

功能：查看两次快照之间的新建对象情况

录制两次可以操作之间的快照，使用object allocation between snashot1 and snapshot选项，比较两次快照间创建的对象，常用这个功能；

使用comparison，比较两次快照的内存增减情况

![image-20211207073137249](/img/image-20211207073137249.png)

largeObj的第0个元素，被window全局变量x引用着。

2)Allocaiton instrumentastion on timeline分配栈时间轴

功能：查看内存分配在代码中的位置，查看内存回收的时机和频率，要勾选Record stack

蓝色竖条表示内存未被回收，灰色表示内存回收。

![image-20211207073246002](/img/image-20211207073246002.png)

选中蓝色竖条，不仅可以查看Retainer表示的泄漏的对象，还可以通过Allocaiton stack分配栈，定位具体代码位置。

![image-20211207235441427](/img/image-20211207235441427.png)

在class filter中输入detached,查看是否存在分离的dom节点，如果能搜索出结果，说明有分离的dom节点

![image-20211208000338908](/img/image-20211208000338908.png)

查看Constructor构造器中出现system/Context,说明有函数导致闭包留存，下面的Retainer可以找到是inner函数引起的闭包内存泄漏。

![image-20211208001049548](/img/image-20211208001049548.png)

(2)在控制台使用ctrl+shift+p打开command menu，输入performance monitor来监听

**内存溢出的几种场景**

**i.溢出原因**

由于过多的函数调用，导致调用堆栈无法容纳这些调用的返回地址，一般在递归中产生。堆栈溢出很可能由无限递归（Infinite recursion）产生，但也可能仅仅是过多的堆栈层级

**ii.如何解决堆栈溢出**

解决方案：1，引入闭包； 2，引入计时器； 3，尾调优化

(2.1)引入闭包

错误代码

```
  function isEven(num){
     if(num == 0){return true;}
     if(num == 1){return false;}
     return isEven(Math.abs(num)-2);
 }
 console.log(isEven(100000))//堆栈溢出
```

引入闭包代码

```
function isEven(num){
    function isEvenInner(num){
        if(num === 0){return true;}
        if(num === 1){return false;}
        return function(){
        return isEvenInner(Math.abs(num)-2);
        }
    }
    function simplify(func,num){
        var value=func(num);
        while(typeof value == 'function'){
            value=value();
        }
        return value;
    }
    return simplify.bind(null,isEvenInner)(num)
}
console.log(isEven(100000));//这种方法num太大也不可以
```

(2.3)使用尾递归(尾调用)

错误代码

```
  function tailFactorial(n, total) {
    if (n === 1) return total;
    return tailFactorial(n - 1, n * total);
  }
  console.log(tailFactorial(5,1))
```

尾调优化（新增简化函数）

```
function tailFactorial(n, total) {
  if (n === 1) return total;
  return tailFactorial(n - 1, n * total);
}
console.log(tailFactorial(5,1))
function factorial(n) {
  return tailFactorial(n, 1);
}
console.log(factorial(10000))
```

尾调优化（柯里化）

```
function currying(fn,n){//柯里化要绑定的参数
    return function(m){//柯里化的函数，m对应输入的唯一一个参数
        return fn.call(this,m,n)  
}//柯里化
}
var factorial_1=currying(tailFactorial,1);
console.log(factorial_1(5));
```

尾调优化（ES6）

```
function factorial(n, total = 1) {
  if (n === 1) return total;
  return factorial(n - 1, n * total);
}
factorial(5) // 120
```

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

**小结**

- 函数防抖和函数节流都是防止某一时间频繁触发，但原理不一样。
- 防抖是多次操作变成一次，而节流是一定时间内只调用一次。

**应用场景**

- debounce防抖
  - search搜索联想，用户在不断输入值时，用防抖来节约请求资源。
  - window触发resize的时候，不断的调整浏览器窗口大小会不断的触发这个事件，用防抖来让其只触发一次
- throttle节流
  - 鼠标不断点击触发，mousedown(单位时间内只触发一次)
  - 监听滚动事件，比如是否滑到底部自动加载更多，用throttle来判断

**本质上是优化高频率执行代码的一种手段**

- 节流: n 秒内只运行一次，若在 n 秒内重复触发，只有一次生效

- 防抖: n 秒后在执行该事件，若在 n 秒内被重复触发，则重新计时

  一个经典的比喻:

  想象每天上班大厦底下的电梯。把电梯完成一次运送，类比为一次函数的执行和响应

  假设电梯有两种运行策略 `debounce` 和 `throttle`，超时设定为15秒，不考虑容量限制

  电梯第一个人进来后，15秒后准时运送一次，这是**节流**

  电梯第一个人进来后，等待15秒。如果过程中又有人进来，15秒等待重新计时，直到15秒后开始运送，这是**防抖**

  

  **防抖**

  核心逻辑
  
  > - 延迟执行：通过`setTimeout`设置延迟，每次触发事件时重置计时器。
  > - 取消前序触发：若事件在延迟时间内重复触发，用`clearTimeout`清除前一次的计时器。
  
  使用场景
  
  > - 搜索框输入联想（停止输入后再触发搜索）
  > -  窗口大小调整（调整结束后再计算布局） 
  > - 文本编辑器自动保存（停止编辑后保存）
  
    简单版本
  
  ```html
  <html>
  <body>
      <input/>
  </body>
  </html>
  <script >
     let tInput = document.querySelector('input')
     tInput.addEventListener('input',debounce(demo,2000));
  // 支持立即执行与非立即执行
  function debounce(func, delay, immediate = false) {
      let timer = null;
      return function (...args) {
          const context = this;
          if (timer) clearTimeout(timer);
          if (immediate) {
              const callNow = !timer;
              timer = setTimeout(() => {
                  timer = null;
              }, delay);
              if (callNow) func.apply(context, args);
          } else {
              // 简单版本
              timer = setTimeout(() => {
                  func.apply(context, args);
              }, delay);
          }
      };
  }
  
     function demo(){
      console.log('发起请求')
     }
  </script>
  ```
  
   
  
  **节流**
  
  核心逻辑
  
  > - 时间戳版：比较当前时间与上次执行时间差。
  > - 定时器版：通过setTimeout标记可执行状态。
  
  使用场景
  
  > - 滚动事件加载更多内容（滚动时每隔一段时间触发） 
  > - 按钮频繁点击提交（防止重复提交） 
  > - 鼠标移动事件（如拖拽元素时）
  
  完整节流可以使用**定时器与时间戳**的写法
  
  使用定时器写法，`delay`毫秒后第一次执行，第二次事件停止触发后依然会再一次执行
  

```html
<html>
    <head>
        <style>
            .box{
                width: 500px;
                height: 500px;
                background-color: aqua;
            }
        </style>
    </head>
<body>
    <div class="box"></div>
</body>
</html>
<script >
   let tBox = document.querySelector('.box')
   tBox.addEventListener('touchmove',demo);
	// 简单版本
   function throttled1(fn, delay = 500) {
    let timer = null
    return function (...args) {
        if (!timer) {
            timer = setTimeout(() => {
                fn.apply(this, args)
                timer = null
            }, delay);
      }
    }
}
   function demo(){
    console.log('发起请求')
   }
</script>
```

 使用时间戳写法，事件会立即执行，停止触发后没有办法再次执行

```
function throttled2(fn, delay = 500) {
      let oldtime = Date.now()
      return function (...args) {
          let newtime = Date.now()
          if (newtime - oldtime >= delay) {
              fn.apply(null, args)
              oldtime = Date.now()
          }
      }
  }
```

可以将时间戳写法的特性与定时器写法的特性相结合，实现一个更加精确的节流。实现如下

  ```
function throttled(fn, delay) {
      let timer = null
      let starttime = Date.now()
      return function () {
          let curTime = Date.now() // 当前时间
          let remaining = delay - (curTime - starttime)  // 从上一次到现在，还剩下多少多余时间
          let context = this
          let args = arguments
          clearTimeout(timer)
          if (remaining <= 0) {
              fn.apply(context, args)
              starttime = Date.now()
        } else {
              timer = setTimeout(fn, remaining);
        }
      }
  }
  ```

# DOM

## 获取节点

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

## JS绑定解除事件

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

## JS事件冒泡和事件捕获(事件委托)

DOM事件流（event flow ）存在三个阶段：**事件捕获阶段、处于目标阶段、事件冒泡阶段。**

**事件捕获：**通俗的理解就是，当鼠标点击或者触发dom事件时，浏览器会从根节点开始**由外到内**进行事件传播。

**事件冒泡**：与事件捕获恰恰相反，事件冒泡顺序是由内到外进行事件传播，直到根节点。

<img src="/img/image-20230614063620124.png" alt="image-20230614063620124" style="zoom:80%;" />

1-5是捕获过程，5-6是目标阶段，6-10是冒泡阶段；

```
userCapture 为false
事件冒泡执行顺序：从内部到外部Document。

userCapture 为true
事件捕获执行顺序：从Document向内部执行

Dom事件流：包含userCapture ture 和 false
捕获阶段的处理函数最先执行，其次是目标阶段的处理函数，最后是冒泡阶段的处理函数。
目标阶段的处理函数，先注册的先执行，后注册的后执行。
```

**事件委托**

```
var ul = document.getElementById('ul');
ul.onclick = function(event){
	event= event||window.event;
	const target = event.target;
	if(target.nodeName==='LI'){
		alert(target.innerHTML)
	}
}
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

# Ajax原理

`AJAX`全称(Async Javascript and XML)即异步的`JavaScript` 和`XML`，是一种创建交互式网页应用的网页开发技术，可以在不重新加载整个网页的情况下，与服务器交换数据，并且更新部分网页.

```
(1)创建对象
var xhr = new XMLHttpRequest();

(2)打开请求
xhr.open('GET', 'example.txt', true);

(3)发送请求
xhr.send(); 发送请求到服务器

(4)接收响应
xhr.onreadystatechange =function(){}

(1)当readystate值从一个值变为另一个值时，都会触发readystatechange事件。
(2)当readystate==4时，表示已经接收到全部响应数据。
(3)当status ==200时，表示服务器成功返回页面和数据。
(4)如果(2)和(3)内容同时满足，则可以通过xhr.responseText，获得服务器返回的内容。
```

**服务器响应处理**

同步处理

```
	1. xhr.open("GET","info.txt",false);  
	2. xhr.send();  
	3. document.getElementById("myDiv").innerHTML=xhr.responseText; //获取数据直接显示在页面上
```

异步处理

```
	1. xhr.onreadystatechange=function()  { 
	2.    if (xhr.readyState==4 &&xhr.status==200)  { 
	3.       document.getElementById("myDiv").innerHTML=xhr.responseText;  
	4.      }
	5.    } 
```

什么是**readyState**？

readyState是XMLHttpRequest对象的一个属性，用来标识当前XMLHttpRequest对象处于什么状态。 readyState总共有5个状态值，分别为0~4，每个值代表了不同的含义。

0：未初始化 -- 尚未调用.open()方法；

1：启动 -- 已经调用.open()方法，但尚未调用.send()方法；

2：发送 -- 已经调用.send()方法，但尚未接收到响应；

3：接收 -- 已经接收到部分响应数据；

4：完成 -- 已经接收到全部响应数据，而且已经可以在客户端使用了；

**什么是status？**

1：服务器收到请求

2：成功

3：重定向

4：客户端错误

5：服务端错误

# 手写setTimeout实现setInterval

**为什么要用setTimeout来模拟setInterval的行为？**

这里用setInerval不是更方便吗？

```
setTimeout(function(){··· }, n); // n毫秒后执行function
setInterval(function(){··· }, n); // 每隔n毫秒执行一次function
```

可以看看setInterval有什么缺点：

> 再次强调，定时器指定的时间间隔，表示的是何时将定时器的代码添加到消息队列，而不是何时执行代码。所以真正何时执行代码的时间是不能保证的，取决于何时被主线程的事件循环取到，并执行。

```
setInterval(function, N)  
//即：每隔N秒把function事件推到消息队列中
```

<img src="/img/image-20230614063755823.png" alt="image-20230614063755823" style="zoom:80%;" />

上图可见，setInterval每隔100ms往队列中添加一个事件；100ms后，添加T1定时器代码至队列中，主线程中还有任务在执行，所以等待，some event执行结束后执行T1定时器代码；又过了100ms，T2定时器被添加到队列中，主线程还在执行T1代码，所以等待；又过了100ms，理论上又要往队列里推一个定时器代码，但由于此时T2还在队列中，所以T3不会被添加，结果就是此时被跳过；这里我们可以看到，T1定时器执行结束后马上执行了T2代码，所以并没有达到定时器的效果。

综上所述，setInterval有两个缺点：

1. 使用setInterval时，某些间隔会被跳过；
2. 可能多个定时器会连续执行；

> 可以这么理解：**每个setTimeout产生的任务会直接push到任务队列中；而setInterval在每次把任务push到任务队列前，都要进行一下判断(看上次的任务是否仍在队列中)**。因而我们一般用setTimeout模拟setInterval，来规避掉上面的缺点。

**使用setTimeout实现setInterval**

> setInterval 的作用是每隔一段指定时间执行一个函数，但是这个执行不是真的到了时间立即执行，它真正的作用是每隔一段时间将事件加入事件队列中去，只有当当前的执行栈为空的时候，才能去从事件队列中取出事件执行。所以可能会出现这样的情况，就是当前执行栈执行的时间很长，导致事件队列里边积累多个定时器加入的事件，当执行栈结束的时候，这些事件会依次执行，因此就不能到间隔一段时间执行的效果。

 针对 setInterval 的这个缺点，我们可以使用 setTimeout 递归调用来模拟 setInterval，这样我们就确保了只有一个事件结束了，我们才会触发下一个定时器事件，这样解决了 setInterval 的问题。

 实现思路是使用递归函数，不断地去执行 setTimeout 从而达到 setInterval 的效

```js
 // 可避免setInterval因执行时间导致的间隔执行时间不一致
function myInterval(fn,time){
    let interval=()=>{
      fn()
      setTimeout(interval,time)
    }
    setTimeout(interval,time)
}

function mySetInterval2(fn, timeout) {
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



# 手写-EventBus

通俗理解：

> 小明最近看上了一套房子，到了售楼处之后才被告知，该楼盘的房子早已售罄。好在售楼 MM 告诉小明，不久之后还有一些尾盘推出，开发商正在办理相关手续，手续办好后便可以购买。但到底是什么时候，目前还没有人能够知道。
>
> 小明离开之前，把电话号留在了售楼处。售楼 MM 答应他，新楼盘一推出就马上发信息通知小明。小红、小强和小龙也是一样，他们的电话号码都被记载售楼处的花名册上，新楼盘推出的时候，售楼 MM 会翻开花名册，遍历上面的电话号码，依次发送一条短信来通知他们。

有三个要点：

- `发布者`：dep 对象
- `缓存列表`：dep.subscribers
- `发布消息`：dep.notify()

1. 首先要指定好谁充当发布者（比如售楼处）
2. 然后给发布者添加一个缓存列表，用于存放回调函数以便通知订阅者（售楼处的花名册）
3. 最后发布消息的时候，发布者会遍历这个缓存列表，依次触发里面存放的订阅者回调函数（遍历花名册，挨个发短信）

极简版本

```
class SyncHook {
  constructor() {
    this.taps = [];
  }

  //注册监听函数，这里的name其实没啥用
  tap(name, fn) {
    this.taps.push({ name, fn });
  }

  //执行函数
  call(...args) {
    this.taps.forEach((tap) => tap.fn(...args));
  }
}
```

一般版本

```js
// 组件通信，一个触发与监听的过程
class EventEmitter {
  constructor () {
    // 存储事件
    this.events = this.events || new Map()
  }
  // 监听事件
  addListener (type, fn) {
    if (!this.events.get(type)) {
      this.events.set(type, fn)
    }
  }
  // 触发事件
  emit (type) {
    let handle = this.events.get(type)
    handle.apply(this, [...arguments].slice(1))
  }
}

// 测试
let emitter = new EventEmitter()
// 监听事件
emitter.addListener('ages', age => {
  console.log(age)
})
// 触发事件
emitter.emit('ages', 18)  // 18
```

# 手写-JSON.stringfy()和JSON.parse()

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

# 手写-简单路由

```
// hash路由
class Route{
  constructor(){
    // 路由存储对象
    this.routes = {}
    // 当前hash
    this.currentHash = ''
    // 绑定this，避免监听时this指向改变
    this.freshRoute = this.freshRoute.bind(this)
    // 监听
    window.addEventListener('load', this.freshRoute, false)
    window.addEventListener('hashchange', this.freshRoute, false)
  }
  // 存储
  storeRoute (path, cb) {
    this.routes[path] = cb || function () {}
  }
  // 更新
  freshRoute () {
    this.currentHash = location.hash.slice(1) || '/'
    this.routes[this.currentHash]()
  }   
}
```

# 手写-JS实现图片懒加载

```
let imgs =  document.querySelectorAll('img')
// 可视区高度
let clientHeight = window.innerHeight || document.documentElement.clientHeight || document.body.clientHeight
function lazyLoad () {
  // 滚动卷去的高度
  let scrollTop = window.pageYOffset || document.documentElement.scrollTop || document.body.scrollTop
  for (let i = 0; i < imgs.length; i ++) {
    // 图片在可视区冒出的高度
    let x = clientHeight + scrollTop - imgs[i].offsetTop
    // 图片在可视区内
    if (x > 0 && x < clientHeight+imgs[i].height) {
      imgs[i].src = imgs[i].getAttribute('data')
    } 
  }      
}
// addEventListener('scroll', lazyLoad) or setInterval(lazyLoad, 1000)
```

# 手写-rem实现原理

```
// 原始配置
function setRem () {
  let doc = document.documentElement
  let width = doc.getBoundingClientRect().width
  let rem = width / 75
  doc.style.fontSize = rem + 'px'
}
// 监听窗口变化
addEventListener("resize", setRem)
```

# 手写-AJAX

```
// 1. 简单流程
// 实例化
let xhr = new XMLHttpRequest()
// 初始化
xhr.open(method, url, async)
// 发送请求
xhr.send(data)
// 设置状态变化回调处理请求结果
xhr.onreadystatechange = () => {
  if (xhr.readyStatus === 4 && xhr.status === 200) {
    console.log(xhr.responseText)
  }
}

// 2. 基于promise实现 
function ajax (options) {
  // 请求地址
  const url = options.url
  // 请求方法
  const method = options.method.toLocaleLowerCase() || 'get'
  // 默认为异步true
  const async = options.async
  // 请求参数
  const data = options.data
  // 实例化
  const xhr = new XMLHttpRequest()
  // 请求超时
  if (options.timeout && options.timeout > 0) {
    xhr.timeout = options.timeout
  }
  // 返回一个Promise实例
  return new Promise ((resolve, reject) => {
    xhr.ontimeout = () => reject && reject('请求超时')
    // 监听状态变化回调
    xhr.onreadystatechange = () => {
      if (xhr.readyState == 4) {
        // 200-300 之间表示请求成功，304资源未变，取缓存
        if (xhr.status >= 200 && xhr.status < 300 || xhr.status == 304) {
          resolve && resolve(xhr.responseText)
        } else {
          reject && reject()
        }
      }
    }
    // 错误回调
    xhr.onerror = err => reject && reject(err)
    let paramArr = []
    let encodeData
    // 处理请求参数
    if (data instanceof Object) {
      for (let key in data) {
        // 参数拼接需要通过 encodeURIComponent 进行编码
        paramArr.push(encodeURIComponent(key) + '=' + encodeURIComponent(data[key]))
      }
      encodeData = paramArr.join('&')
    }
    // get请求拼接参数
    if (method === 'get') {
      // 检测url中是否已存在 ? 及其位置
      const index = url.indexOf('?')
      if (index === -1) url += '?'
      else if (index !== url.length -1) url += '&'
      // 拼接url
      url += encodeData
    }
    // 初始化
    xhr.open(method, url, async)
    // 发送请求
    if (method === 'get') xhr.send(null)
    else {
      // post 方式需要设置请求头
      xhr.setRequestHeader('Content-Type','application/x-www-form-urlencoded;charset=UTF-8')
      xhr.send(encodeData)
    }
  })
}
```

# 手写-实现拖拽

```
window.onload = function () {
  // drag处于绝对定位状态
  let drag = document.getElementById('box')
  drag.onmousedown = function(e) {
    var e = e || window.event
    // 鼠标与拖拽元素边界的距离 = 鼠标与可视区边界的距离 - 拖拽元素与边界的距离
    let diffX = e.clientX - drag.offsetLeft
    let diffY = e.clientY - drag.offsetTop
    drag.onmousemove = function (e) {
      // 拖拽元素移动的距离 = 鼠标与可视区边界的距离 - 鼠标与拖拽元素边界的距离
      let left = e.clientX - diffX
      let top = e.clientY - diffY
      // 避免拖拽出可视区
      if (left < 0) {
        left = 0
      } else if (left > window.innerWidth - drag.offsetWidth) {
        left = window.innerWidth - drag.offsetWidth
      }
      if (top < 0) {
        top = 0
      } else if (top > window.innerHeight - drag.offsetHeight) {
        top = window.innerHeight - drag.offsetHeight
      }
      drag.style.left = left + 'px'
      drag.style.top = top + 'px'
    }
    drag.onmouseup = function (e) {
      this.onmousemove = null
      this.onmouseup = null
    }
  }
}
```

# 手写-其他

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

# 函数式编程

## 定义特征

- **函数是一等公民** ：在函数式编程中，函数与其他数据类型地位平等，可以作为参数传递、赋值给变量或作为返回值。这种特性使得函数式编程更加灵活和模块化，能够通过组合和变换函数来实现复杂逻辑
- **无副作用** ：函数式编程中的函数应该是纯函数，即给定相同的输入总是返回相同的输出，并且不会修改外部状态或产生其他影响。这种特性使得程序更易于理解、测试和优化。
- **不可变数据** ：函数式编程倾向于使用不可变数据结构，即一旦创建就不能被修改的数据。这种特性有助于避免并发问题，提高程序的可靠性和可预测性。
- **声明式编程** ：函数式编程更偏向于声明式编程，即通过描述问题的性质和关系，而不是指定解决问题的具体步骤。这种方式使得代码更加清晰和易于理解。

## 核心思想

### 不可变性

不可变性的核心思想可以概括为： **创建后的数据结构保持不变，任何修改都通过创建新的数据结构来实现** 。这种方式确保了数据的一致性和可预测性，避免了因数据意外修改而导致的错误。

例如：利用Object.freeze()或immutable.js库。const obj = Object.freeze({ key: 'value' });

不可变性对编写代码产生了深远影响：

> 1. **简化并发编程** ：不可变数据结构在多线程环境中无需加锁，大大降低了并发编程的复杂性。
> 2. **提高代码可读性和可维护性** ：由于数据不会被意外修改，代码的行为变得更加可预测。
> 3. **增强函数纯度** ：不可变性有助于编写纯函数，减少副作用。
> 4. **优化性能** ：在某些情况下，不可变数据结构可以通过结构共享技术实现高效的内存利用。

不可变性与函数式编程的其他核心概念密切相关：

> - **纯函数** ：不可变性是编写纯函数的基础，确保相同输入总是产生相同输出。
> - **函数组合** ：不可变性使得函数组合更加安全和可靠，避免了中间状态的意外修改。
> - **声明式编程** ：不可变性符合声明式编程的理念，强调描述问题而非解决步骤。

### 纯函数

定义

> 给定相同的输入，永远会得到相同的输出，并且没有任何可观察的副作用。

这里有两个关键因素：

> 1. **确定性** ：对于相同的输入，函数总是返回相同的结果。
> 2. **无副作用** ：函数不会修改外部状态或与外部世界进行可观察的交互。

判断一个函数是否为纯函数，可以从以下几个方面入手：

> 1. **输入输出关系** ：函数的输出是否完全由输入决定，不依赖于外部状态或全局变量。
> 2. **状态修改** ：函数是否修改了外部状态，如全局变量、文件系统或数据库。
> 3. **可观察的副作用** ：函数是否执行了I/O操作，如打印、网络请求或读取用户输入。

纯函数的意义:

> **可缓存性** ：由于纯函数的确定性，其结果可以被缓存，从而提高性能。例如，可以使用memoize技术缓存纯函数的结果
>
> **可测试性** ：纯函数的输入输出关系明确，使得单元测试变得简单。只需提供输入并验证输出，无需考虑外部环境或状态变化。
>
> **引用透明性** ：纯函数的结果不依赖于外部状态，因此可以被替换为其返回值，而不影响程序的正确性。这一特性使得代码更易于理解和重构。
>
> **并行执行** ：由于纯函数不依赖于外部状态，多个纯函数可以并行执行，从而提高程序的性能和效率。

### 高阶函数

定义

> 高阶函数是一种能够操作其他函数的函数，它可以接受函数作为参数，或者返回函数作为结果。

高阶函数的意义：

> 1. **提高代码的模块化程度** ：通过将函数作为参数传递，可以将通用的操作逻辑与具体的业务逻辑分离，从而提高代码的可维护性和复用性。
> 2. **实现函数组合** ：高阶函数可以将多个简单函数组合成更复杂的功能，从而简化复杂问题的处理过程。
> 3. **增强代码的表达能力** ：高阶函数能够以更抽象和通用的方式描述问题，使得代码更易读、易懂。

在实际编程中，高阶函数常常与 **闭包** 结合使用。高阶函数的一个典型应用是 **函数柯里化** 。柯里化是一种将多参数函数转换为一系列单参数函数的技术。通过柯里化，我们可以将一个复杂的函数分解成多个简单的函数，从而提高代码的可读性和可维护性

### 函数组合

定义

> 将多个函数按顺序串联起来，形成一个新的函数。这个新函数会先执行第一个函数，然后将结果作为输入传递给第二个函数，以此类推，直到最后一个函数返回结果。

函数组合的意义：

> 1. **提高代码的模块化程度** ：通过将复杂的逻辑分解成多个简单的函数，然后再组合起来，可以提高代码的可读性和可维护性。
> 2. **增强代码的复用性** ：组合后的函数可以在多个地方复用，而无需重复编写相同的逻辑。
> 3. **支持函数式编程的声明式风格** ：通过函数组合，可以将复杂的操作表示为一系列简单函数的组合，使得代码更加接近问题的描述，而不是具体的实现细节。

## 函数式编程特性

### 声明式编程

主要体现在：

> - **函数组合** ：通过组合简单函数来描述复杂逻辑
> - **延迟计算** ：推迟表达式求值，提高灵活性
> - **抽象表达** ：使用高阶函数和闭包来抽象问题
> - **数据转换** ：使用map、filter和reduce等操作处理数据

### 惰性求值

它指的是在需要时才进行计算，而不是立即计算所有结果。这种求值策略可以显著提高性能和资源利用率，特别是在处理大型数据集或无限序列时。

### 递归(尾递归)

 **递归** 是一种强大的技术，它允许函数通过调用自身来解决问题。这种方法体现了函数式编程的核心思想，如分而治之和不可变性。递归通过将复杂问题分解为更简单的子问题，提供了一种优雅的问题解决策略。

然而，递归也存在潜在问题，如 **栈溢出** ，特别是在处理大型数据集时。为避免此问题，一些语言支持 **尾递归优化** ，将递归调用转换为循环，从而提高性能和资源利用率。

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

## 实现机制

### 闭包

定义

> 当一个函数被定义时，它会捕获其词法环境（即函数被定义时的作用域），并将其作为一个“隐藏状态”与函数一起保存。这个隐藏状态可以被函数访问和修改，即使函数在不同的作用域中被调用。

闭包的意义：

> 1. **实现信息隐藏和封装** ：通过闭包，我们可以创建“私有”变量，这些变量只能被特定的函数访问和修改，从而实现信息隐藏和封装。
> 2. **实现函数柯里化** ：闭包可以用来实现函数柯里化，即将一个多参数函数转换为一系列单参数函数。
> 3. **实现函数记忆化** ：闭包可以用来实现函数记忆化，即将函数的结果缓存起来，避免重复计算。

闭包的注意：

> - **内存管理** ：闭包会占用额外的内存空间，因为它需要保存其词法环境。如果闭包被频繁创建和销毁，可能会导致内存泄漏或性能问题。
> - **可维护性** ：过度使用闭包可能会导致代码难以理解和维护。因此，在使用闭包时，需要权衡其带来的灵活性和可能的负面影响。

### 柯里化

定义

> 将一个接受多个参数的函数转换为一系列接受单个参数的函数。

柯里化的原理基于函数的 **闭包** 特性。通过使用闭包，柯里化函数能够“记住”之前传入的参数，并返回一个新的函数，这个新函数接受剩余的参数。这种方式使得函数可以逐步接受参数，而不是一次性接受所有参数。

柯里化的意义：

> **参数复用** ：通过柯里化，可以固定某些参数，创建更具针对性的函数。
>
> **延迟执行** ：柯里化函数可以在接收到足够的参数时才执行，这在某些场景下非常有用。
>
> **函数组合** ：柯里化使得函数组合更加灵活和强大。

```
参数复用
const log = (date, importance, message) => {
    console.log(`${date} [${importance}] ${message}`);
};

const logToday = log(new Date());
logToday('DEBUG', 'Some debug message');

延迟执行
function add(x) {
    return function(y) {
        return x + y;
    };
}
const add5 = add(5);
setTimeout(add5, 1000, 3); // 1秒后输出: 8

函数组合
const double = x => x * 2;
const addOne = x => x + 1;
const square = x => x * x;

const doubleAndAddOneAndSquare = x => square(addOne(double(x)));
const curriedDoubleAndAddOneAndSquare = curry(doubleAndAddOneAndSquare);

const result = curriedDoubleAndAddOneAndSquare(3);
console.log(result); // 输出: 49
```

柯里化的注意：

> - **函数嵌套增加** ：柯里化会导致函数嵌套层次增加，可能会影响代码的可读性。
> - **内存占用** ：柯里化函数会占用额外的内存，特别是在频繁创建和销毁柯里化函数的场景中。
> - **性能问题** ：在某些情况下，柯里化可能会导致性能下降，特别是在需要频繁调用柯里化函数的场景中。

实现一个简单柯里化

```
    function add() {
      let sum = 0;
      return function innerFn(num) {
        if (num !== undefined) {
          sum += num;
          return innerFn;
        } else {
          return sum;
        }
      }
    }

    console.log(add()(1)(2)(3)()); // 输出 6
```

> 我们首先定义了一个 `add` 函数，它返回了一个内部函数 `innerFn`。在 `innerFn` 中，我们首先定义了一个变量 `sum`，用于保存累加的结果。当传入的参数不为 `undefined` 时，我们将其加到 `sum` 中，并返回 `innerFn`。这样就可以继续传递下一个参数了。当参数为 `undefined` 时，我们返回 `sum`，表示累加完毕
>
> 但是，这种简单的实现方式存在一个问题，那就是只能处理参数数量为 2 的函数，无法处理参数数量不确定的函数。因此我们需要更加通用的柯里化实现方式
>
> 这里是一个更加通用的函数柯里化的实现方式：

**柯里化写法**

```
// es6写法
const curry = (fn, ...args) => 
            args.length < fn.length 
            // 参数长度不足时,重新柯里化函数,等待接受新参数
            ? (...arguments) => curry(fn, ...args, ...arguments)
            // 函数长度满足时,执行函数
             : fn(...args);
// es5写法
function curry(fn) {
      return function curried(...args) {
        if (args.length >= fn.length) {
          return fn.apply(this, args);
        } else {
          return function(...args2) {
            return curried.apply(this, args.concat(args2));
          }
        }
      }
    }
该函数的参数是一个函数 fn，它返回一个柯里化后的函数。在函数内部，我们定义了一个 curried 函数，它的作用是接受函数需要的所有参数。当传入的参数数量大于或等于原函数需要的参数数量时，就直接调用原函数并返回结果；否则，返回一个新函数，然后使用闭包将当前已经传入的参数保存下来。这个新函数再次接受一个参数，并将这个参数与之前已经保存的参数合并，然后递归调用 curried 函数
const add = (a, b, c) => a + b + c;
const curriedAdd = curry(add);
console.log(curriedAdd(1)(2)(3));
```

currying 函数详解：

```js
function currying(fn, length) {
  length = length || fn.length;  // 注释 1
  return function (...args) {   // 注释 2
    return args.length >= length // 注释 3
     ? fn.apply(this, args)   // 注释 4
      : currying(fn.bind(this, ...args), length - args.length) // 注释 5
  }
}

// Test
const fn = currying(function(a, b, c) {
    console.log([a, b, c]);
});

fn("a", "b", "c") // ["a", "b", "c"]
fn("a", "b")("c") // ["a", "b", "c"]
fn("a")("b")("c") // ["a", "b", "c"]
fn("a")("b", "c") // ["a", "b", "c"]
```

**柯里化应用场景**

> - 参数复用，如var curriedAdd = curry(add, 5)
> - 延迟执行，sum(1)(2)(3)，传入参数个数没有满足原函数入参个数，都不会立即返回结果。
> - 函数式编程中，作为compose, functor, monad 等实现的基础

**注意事项**

使用柯里化函数，离不开闭包， arguments， 递归。

> 闭包，函数中的变量都保存在内存中，内存消耗大，有可能导致内存泄漏。
> 递归，效率非常差，
> arguments, 变量存取慢，访问性很差,

**参考**

[JavaScript专题之函数柯里化](https://github.com/mqyqingfeng/Blog/issues/42)

### 函子

 **函子** 是一个核心概念，它为处理数据和控制流提供了一种抽象的方式。函子是一个实现了 `map` 方法的类型，这个方法可以将一个普通函数应用到函子内部的值上，同时保持函子的结构不变。

## 应用场景

- 并发编程：不可变性在多线程环境中无需加锁，大大降低了并发编程的复杂性;纯函数可并行执行，提高程序的性能和效率。
- 数据处理： **Apache Spark** 作为一个基于函数式编程的大数据处理框架，充分利用了函数式编程的特性来优化大规模数据处理。Spark的 **弹性分布式数据集（RDD）** 抽象提供了一个不可变的分布式数据结构，允许用户通过一系列转换和动作操作来处理数据。这种函数式编程风格使得Spark能够高效地处理大规模数据集，同时保持代码的简洁性和可读性。
- UI组件： **React** 和 **Vue.js** ，都在不同程度上采用了函数式编程的思想。

## 优缺点

优点：

> **更好的状态管理** ：函数式编程的核心原则之一是无状态性，这有助于减少程序中的未知因素，从而优化代码并降低出错的可能性。通过将状态封装在函数内部，开发者可以更清晰地控制和管理程序的状态变化
>
> **简化代码复用** ：函数式编程强调纯函数的使用，即给定相同的输入总是返回相同的输出，且没有副作用。这种特性使得函数可以在不同的上下文中复用，而无需担心其内部实现或外部影响。
>
> **增强代码组合性** ：函数式编程通过高阶函数和函数组合的概念，提供了强大的代码组合能力。这种方式使得开发者可以将多个简单函数组合成复杂的功能，从而提高代码的可读性和可维护性。
>
> **减少代码量** ：函数式编程的声明式风格通常会导致更简洁的代码。通过使用高阶函数和函数组合，开发者可以用更少的代码实现相同的功能。

缺点:

> 1. **性能问题** ：函数式编程通常涉及更多的函数调用和对象分配，这可能导致性能下降。特别是在处理大规模数据时，频繁的函数调用和对象创建可能会成为性能瓶颈。例如，在Java中使用lambda表达式和Stream API时，可能会产生额外的对象创建和垃圾回收开销。
> 2. **资源占用** ：函数式编程的不可变性特性可能导致资源占用增加。在JavaScript等语言中，为了实现不可变数据结构，可能需要频繁创建新的对象，这会增加内存占用并可能导致垃圾回收压力增大。
> 3. **代码复杂度** ：函数式编程的一些高级概念，如高阶函数、闭包和柯里化，可能会增加代码的复杂度。过度使用这些概念可能会导致代码变得难以理解和维护。例如，多层嵌套的函数组合可能会使代码的执行流程变得模糊不清。
> 4. **工具和库支持不足** ：与面向对象编程相比，函数式编程在某些编程语言中的工具和库支持相对薄弱。例如，在Java中，虽然Java 8引入了函数式编程特性，但与Scala等函数式编程语言相比，其函数式编程支持仍然有限。
> 5. **调试困难** ：函数式编程的声明式风格可能会使调试变得更加困难。由于函数式编程强调描述问题而非解决步骤，当出现问题时，可能更难追踪代码的执行路径和定位问题所在。
> 6. **不适合所有问题域** ：函数式编程并不适合所有类型的问题。例如，在需要频繁修改状态或处理复杂交互逻辑的场景中，函数式编程可能不是最佳选择。对于这些问题，命令式或面向对象编程可能更合适。

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

# devDependencies 和 dependencies 的区别

`devDependencies` 和 `dependencies`的区别核心体现在 **npm包** 中。

只要开发的项目是**发npm包**提供给外部、其他业务项目使用的，需要非常注意依赖的安装地方，因为搞不好很容易在业务使用中会出现bug。dependencies的依赖包会被打入到npm包中，慎用。

而如果只是自己项目用，**不需要发npm包**的话，把依赖安装到 `devDependencies` 或者 `dependencies` 中，实质上是没有任何区别的。

# args剩余参数与arguments函数形参类数组

**args**

定义：只包含那些没有对应形参的实参。将所有后面剩余的是实参个数包裹成一个数组。

- 展开运算符
- 用于解构赋值
- 类数组对象变成数组

> **var** arr1=['a','b','c']; **var** arr2=['d','e'];arr1.**push**(...arr2)
>
> **let** b=[...new Set([1,2])]

**arguments对象**

1.定义：包含了传给函数的所有实参。在函数代码中，使用特殊对象 `arguments`，开发者无需明确指出参数名，就能访问它们。它是一个类数组，不是数组。

```js
function test(a, b, c) {
  console.log(arguments) // Arguments(4) [1, 2, 3, 4, callee: ƒ, Symbol(Symbol.iterator): ƒ] 
  console.log(test.length) // 3
  console.log(arguments.callee.length) // 3
  console.log(Array.apply(null, arguments))
}

test(1,2,3,4)
其中arguments 代表的是函数实参的个数
其中fn.length 代表函数形参的个数
其中arguments.callee 指向函数本身
```

2.提取参数

```js
var args = Array.prototype.slice.call(arguments);
var args = [].slice.call(arguments);

// ES2015
const args = Array.from(arguments);
const args = [...arguments];
```

> **警告：** 对参数使用 slice 会阻止某些 JavaScript 引擎中的优化 (比如 V8 - [更多信息](https://github.com/petkaantonov/bluebird/wiki/Optimization-killers#3-managing-arguments))。如果你关心性能，尝试通过遍历 arguments 对象来构造一个新的数组。另一种方法是使用被忽视的`Array`构造函数作为一个函数：
>
> ```
> var args = (arguments.length === 1 ? [arguments[0]] : Array.apply(null, arguments));
> ```

3.一般模式和严格模式下arguments

- 一般模式：如果缺省参数，arguments和参数是隔离开的；如果传入参数，arguments和参数是双向绑定的
- 严格模式：arguments和参数是双向绑定的

(1)一般模式

直接上代码，先来看调用时缺省参数的情况

```
function a1(x) {
    x = 2;
    console.log(x, arguments[0]);
}
a1(); // 2 undefined

function a2(x) {
    arguments[0] = 2;
    console.log(x, arguments[0]);
}
a2(); // undefined 2
```

再来看调用时传入参数的情况

```
function a3(x) {
    x = 2;
    console.log(x, arguments[0]);
}
a3(1); // 2 2

function a4(x) {
    arguments[0] = 2;
    console.log(x, arguments[0]);
}
a4(1); // 2 2
```

可以看到如果缺省参数，arguments和参数是隔离开的；如果传入参数，arguments和参数是双向绑定的。

(2)严格模式

再来看看严格模式，直接上代码

```
function b1(x) {
    'use strict';
    x = 2;
    console.log(x, arguments[0]);
}
b1(); // 2 undefined

function b2(x) {
    'use strict';
    arguments[0] = 2;
    console.log(x, arguments[0]);
}
b2(); // undefined 2

function b3(x) {
    'use strict';
    x = 2;
    console.log(x, arguments[0]);
}
b3(1); // 2 1

function b4(x) {
    'use strict';
    arguments[0] = 2;
    console.log(x, arguments[0]);
}
b4(1); // 1 2
```

在严格模式下，无论参数是否缺省，arguments和参数都是隔离开的。

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
