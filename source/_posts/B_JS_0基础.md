---
title: 0基础_JS
date: 2099-05-29 07:33:16
categories:
- B_JS
toc: true # 是否启用内容索引
---

# 基础

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

## 8种数据类型

- 基本类型：Number,String,Boolean,Null,undefined,symbol
- 引用类型：Object,Array,function

**null和undefined**

null 表示“定义了但是为空”,判空：if(a)。null 典型用法是： 

- 作为函数的参数，表示该函数的参数不是对象。 
- 作为对象原型链的终点。

undefined 表示未定义，它的类型只有一个值，就是 undefined，判空：if(a===undefined)，未定义的值和定义未赋值的为 undefined

- 变量被声明了，但没有赋值时，就等于 undefined。 
- 调用函数时，应该提供的参数没有提供，该参数等于 undefined。 
- 对象没有赋值的属性，该属性的值为 undefined。 
- 函数没有返回值时，默认返回 undefined。

**从内存来看 null 和 undefined 本质的区别是什么？**

> 给一个全局变量赋值为null，相当于将这个变量的指针对象以及值清空，如果是给对象的属性 赋值为null，或者局部变量赋值为null,相当于给这个属性分配了一块空的内存，然后值为null， JS会回收全局变量为null的对象。
>
> 给一个全局变量赋值为undefined，相当于将这个对象的值清空，但是这个对象依旧存在,如果是给对象的属性赋值 为undefined，说明这个值为空值

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

## JS类型判断-typeof,  instanceof, constructor,toString

**typeof**

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
const self_instanceof = function (instance, constructor) {
    let instance_proto = instance.__proto__;
    let constructor_proto = constructor.prototype;

    while(true) {
        // 找到终点返回false
       if (instance_proto === null) {return false};
       // 找到返回true
       if (instance_proto === constructor_proto) {return true};
        // 当实例与构造函数原型不相同, 沿着原型链继续向上查找
        instance_proto = instance_proto.__proto__;
    }
}
console.log([] instanceof Array)   // true
console.log(self_instanceof([], Array))  // true
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

## typeof 与 instanceof 区别

6种基本数据类型：string,Number,boolean,undefined,null,symbol,其他类型如object,function,Array等

- `typeof`会返回一个变量的基本类型，typeof '1' // 'string'
- `instanceof` 可以准确地判断复杂引用数据类型，[1] instanceof Array //true

其中instance原理参考：

```
function myInstanceof(left, right) {
    // 这里先用typeof来判断基础数据类型，如果是，直接返回false
    if(typeof left !== 'object' || left === null) return false;
    // getProtypeOf是Object对象自带的API，能够拿到参数的原型对象
    let proto = Object.getPrototypeOf(left);
    while(true) {                  
        if(proto === null) return false;
        if(proto === right.prototype) return true;//找到相同原型对象，返回true
        proto = Object.getPrototypeof(proto);
    }
}
```

终极检查数据类型工具

```
Object.prototype.toString({})       // "[object Object]"
Object.prototype.toString.call({})  // 同上结果，加上call也ok
Object.prototype.toString.call(1)    // "[object Number]"
Object.prototype.toString.call('1')  // "[object String]"
Object.prototype.toString.call(true)  // "[object Boolean]"
Object.prototype.toString.call(function(){})  // "[object Function]"
Object.prototype.toString.call(null)   //"[object Null]"
Object.prototype.toString.call(undefined) //"[object Undefined]"
Object.prototype.toString.call(/123/g)    //"[object RegExp]"
Object.prototype.toString.call(new Date()) //"[object Date]"
Object.prototype.toString.call([])       //"[object Array]"
Object.prototype.toString.call(document)  //"[object HTMLDocument]"
Object.prototype.toString.call(window)   //"[object Window]"

function getType(obj){
  let type  = typeof obj;
  if (type !== "object") {    // 先进行typeof判断，如果是基础数据类型，直接返回
    return type;
  }
  // 对于typeof返回结果是object的，再进行如下的判断，正则返回结果
  return Object.prototype.toString.call(obj).replace(/^\[object (\S+)\]$/, '$1'); 
}
getType('123')  // "string"
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

defer延迟执行

> 解析完js脚本后不会立刻执行，而是在DOMContentLoaded 事件触发之前开始执行。defer 是顺序执行
>
> 使用场景(依赖dom)：
>
> - 评论框
> - 代码语法高亮
> - polyfill.js
>
> defer 属性表示延迟执行引入的 JavaScript，即这段 JavaScript 加载时 HTML 并未停止解析，这两个过程是并行的。整个 document 解析完毕且 defer-script 也加载完成之后（这两件事情的顺序无关），会执行所有由 defer-script 加载的 JavaScript 代码，然后触发 DOMContentLoaded 事件。

async异步下载

> 解析完js脚本后会立即执行，与html解析过程异步同时执行。async是乱序执行
>
> 使用场景：
>
> - 百度统计
>
> async 属性表示异步执行引入的 JavaScript，与 defer 的区别在于，如果已经加载好，就会开始执行——无论此刻是 HTML 解析阶段还是 DOMContentLoaded 触发之后。需要注意的是，这种方式加载的 JavaScript 依然会阻塞 load 事件。换句话说，async-script 可能在 DOMContentLoaded 触发之前或之后执行，但一定在 load 触发之前执行。

![image-20211201070616431](C:/img/image-20211201070616431.png)

尽量减少DOM访问；

把脚本放在底部；

把JavaScript和CSS放到外面，如果JavaScript和CSS在外部文件中，并且已经被浏览器缓存起来了，那么我们就成功地把HTML文档变小了，而且还没有增加HTTP请求数；

压缩JavaScript和CSS，如启用了gzip模块；

# 三大山-原型和原型链

## 彻底搞懂this

**为什么要有 this？**

官方解释：

> `this` 被自动定义在所有函数的作用域中，它提供了一种更好的方式来“隐式”的传递对象引用，这样使得我们的 `API` 设计或者函数变得更加简洁，而且还更容易复用。

看一段代码：

```
function say() {
  console.log("你好！", this.name);
}
let person1 = {
  name: '小猪课堂'
}
let person2 = {
  name: '张三'
}
say.call(person1); // 你好！ 小猪课堂
say.call(person2); // 你好！ 张三
```

如果我们没有 `this`，那么我们就需要显式的将上下文对象传入函数，即显式传入 `person1` 和 `person2` 对象。

**this的定义**

`this` 就是一个对象，`this` 是在函数被调用时发生的绑定，它指向什么完全取决于函数在哪里被调用。

> - this 是在运行时绑定的，不是在编写时绑定
> - this 的绑定与函数的声明和位置没有任何关系
> - 函数在调用时，会创建一个执行上下文，this 就是这个执行上下文中的一个属性，在函数执行的时候可以用到 this。所以 this 是在函数调用的时候确定绑定关系的，也就是运行时。

**this的绑定规则**

> 绑定流程：先确定函数调用位置，然后确定使用哪条规则，然后根据规则确定 `this` 绑定。
>
> 绑定优先级：默认绑定 < 隐式绑定 < 显式绑定 < new 绑定

4条核心绑定规则

> - 默认绑定：`this` 绑定到全局对象
> - 隐式绑定：一般绑定到调用对象，如 `obj.foo` 绑定到 `obj`
> - 显式绑定：通过 `call`、`apply` 指定 `this` 绑定到哪里。使用 `bind` 函数硬绑定
> - new绑定：使用 `new` 关键词，绑定到当前函数对象

判断 this 最终指向，总体流程：

> 1. 判断函数调用时是否使用了 `new`，即 `new` 绑定，如果使用了，则 `this` 绑定的是新创建的对象。
> 2. 函数调用是否使用了 `call`、`apply` 等显式绑定，或者硬绑定（bind），如果是的话，`this` 指向指定的对象。
> 3. 函数是否在某个上下文对象中调用，即隐式绑定，如 `obj1.foo`，如果是的话，`this` 指向绑定的那个上下文对象。
> 4. 以上 3 点都不涉及的话，则采用默认绑定，但是需要注意的是，在严格模式下，默认绑定的 `this` 是 `undefined`，非严格模式下绑定到全局对象。

**1.默认绑定**

> 当函数不带用任何修饰进行调用时，此时 `this` 的绑定就是默认绑定规则，`this` 指向全局对象。
>
> let变量声明不会绑定在window上面，只有var声明的才会，这是需要注意的。除此之外，严格模式下上段代码的 `this` 是 `undefined`，

```
var name = '小猪课堂';
function foo(){
  console.log(this) // Window{}
  console.log(this.name) // 小猪课堂
}
foo(); // 小猪课堂
```

在全局作用域中定义了一个变量`name`，然后我们在函数 `foo` 中使用`this.name`，输出的结果就是全局变量`name`，这说明我们 `this` 指向了全局作用域，也就是说 `this` 绑定到了 `window` 对象上。

函数的这种调用方式就被称为默认绑定，默认绑定规则下的 `this` 指向全局对象。

**2.隐式绑定**

```
function foo() {
  console.log(this.name) // 小猪课堂
}
let obj = {
  name: '小猪课堂',
  foo: foo
}
obj.foo();
```

在 `obj` 对象中引用了函数 `foo`，然后我们使用 `obj.foo`（函数别名）的方式调用了该函数，此时不是独立函数调用，我们不能使用默认绑定规则。

此时 `this` 的绑定规则称为隐式绑定规则，因为我们不能直接看出函数的调用位置，它的实际调用位置在 `obj` 对象里面，调用 `foo` 时，它的执行上下文对象为 `obj` 对象，所以 `this` 将会被绑定到 `obj` 对象上，所以我们函数中的 `this.name` 其实就是`obj.name`。这就是我们的隐式绑定规则。

i.多个引用调用

如果我们调用函数时有多个引用调用，比如`obj1.obj2.foo()`。这个时候函数 `foo` 中的 `this` 指向哪儿呢？其实不管引用链多长，`this` 的绑定都由最顶层调用位置确定，即`obj1.obj2.foo()`的 `this` 还是绑定带 `obj2`。

ii隐式绑定中 this 丢失

在隐式绑定规则中，我们认为谁调用了函数，`this` 就绑定谁，比如 `obj.foo` 中 `this` 就绑定到 `obj`，但是有一些情况比较特殊，即使采用的隐式绑定规则，但是 `this` 并没有按照我们的想法去绑定，这就是所谓的隐式绑定 `this` 丢失，常见于回调函数中。

```
function foo() {
  console.log(this.name) // 小猪课堂
}
function doFoo(fn) {
  fn(); // 函数调用位置
}

let obj = {
  name: '张三',
  foo: foo
}
let name = '小猪课堂';
doFoo(obj.foo); // 小猪课堂
```

上段代码中我们很容易会以为 `foo` 绑定的 `this` 是 `obj` 对象，因为我们使用了 `obj.foo` 的方式，这种方式就是遵循隐式绑定规则。但是事实上 `this` 却绑定到了全局对象上去，这是因为我们在 `doFoo` 函数中调用 `fn` 时，这里才是函数的实际调用位置，此时是独立函数调用，所以 `this` 指向了全局对象。

实际项目中我们容易遇到这种问题的场景可能就是定时器了，比如下面的代码：

```scss
setTimeout(obj.foo, 100)
```

这种写法就很容易造成 `this` 丢失。

**3.显式绑定**

明确的将函数的 `this` 绑定在某个对象上。使用call、apply、bind。其中bind就是硬绑定。

虽然显式绑定本身不能解决 `this` 绑定丢失的问题，但是我们可以通过变通的方式来解决这个问题，也被称作**硬绑定**。

硬绑定：

```
function foo() {
  console.log(this.name) // 小猪课堂
}
function doFoo(fn) {
  fn(); // 函数调用位置
}
let obj = {
  name: '张三',
}
let bar = function () {
  foo.call(obj)
}
let name = '小猪课堂';
doFoo(bar); // 张三
setTimeout(bar, 100); // 张三
```

其实思路也比较简单，出现 `this` 绑定丢失原因无非就是我们传入的回调函数在被执行时，`this` 绑定规则变为了默认绑定，那么为了解决这个问题，我们不妨在封装一个函数，将 `foo` 函数的 `this` 显式绑定到 `obj` 对象上去即可。

这里提一点，下面写法是错误的：

```scss
doFoo(foo.call(obj));
```

因为回调函数是在 `doFoo` 里面执行的，上面的写法相当于 `foo` 函数立即执行了。

**4.new绑定**

使用 new 来调用函数时，会执行下面操作：

- 创建一个全新的对象
- 这个新对象会被执行原型连接
- 这个新对象会绑定到函数调用的 `this`
- 如果函数没有返回其它对象，那么 `new` 表达式种的函数调用会自动返回这个新对象

我们可以看到 `new` 的操作中就有 `this` 的绑定，我们在来看看代码。

代码如下：

```ini
function foo(name) {
  this.name = name;
}
let bar = new foo('小猪课堂');
console.log(bar.name); // 小猪课堂
复制代码
```

上段代码我们使用 `new` 关键词调用了 `foo` 函数，大家注意这不是默认调用规则，这是 `new` 绑定规则。

**参考**

[面试官：JS中this指向哪儿？你是如何确定this的？](https:/面试官：JS中this指向哪儿？你是如何确定this的？/juejin.cn/post/7115390077353590792#heading-13)

## call/apply/bind

回顾call/apply/bind用法

```
function sayHelloTo (to) {
    console.log(`${this.name} say hello to ${to}`)
}
var Jerry = {
  name: 'Jerry'
}
sayHelloTo.call(Jerry, 'Tom')
//Jerry say hello to Tom.

var Foo = {
  name: 'Foo'
}
sayHelloTo.apply(Foo, ['Bar'])
//Foo say hello to Bar.

var XYZ = {
  name: 'XYZ'
}
var say = sayHelloTo.bind(XYZ)
say('ABC')
//XYZ say hello to ABC.
```

**call/apply**

```
- 第一个参数就是改变 this 的指向，写谁就是谁，在非严格模式下，null/undefined 指向的是 window。
- call/apply 的唯一区别就是，传递参数不一样，apply 第二个参数是数组，call的参数是一个一个传递。
- call 的性能要比 apply 好一些（尤其是传递给函数的参数超过三个的时候）
```

**bind**

```
-  call/apply都是改变this的同时就把函数执行了，但是bind不是立即执行函数，属于预先改变this和传递一些内容，利用的是柯理化的思想。
```

**小结：**

> 1. 当我们使用一个函数需要改变`this`指向的时候才会用到`call``apply``bind`
> 2. 如果你要传递的参数不多，则可以使用`fn.call(thisObj, arg1, arg2 ...)`
> 3. 如果你要传递的参数很多，则可以用数组将参数整理好调用`fn.apply(thisObj, [arg1, arg2 ...])`
> 4. 如果你想生成一个新的函数长期绑定某个函数给某个对象使用，则可以使用`const newFn = fn.bind(thisObj); newFn(arg1, arg2...)`

经典面试题：

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

**call、apply、bind更详细用法**

1. 怎么利用 call、apply 来求一个数组中最大或者最小值 ?
2. 如何利用 call、apply 来做继承 ?
3. apply、call、bind 的区别和主要应用场景 ?

利用 call、apply 来求一个数组中最大或者最小值

```
const arr = [1,8,6]
Math.max.apply(Math或null, arr); //8
Math.max.call(Math或null, 1,8,6); //8
Math.max(...arr); //8 es6扩展运算符法
```

**手写call**

核心思路是：

1. 为传入的`context`扩展一个属性，将原函数指向这个属性
2. 将`context`之外的所有参数全部传递给这个新属性，并将运行结果返回。

一些细节：

1. 利用**rest 参数**(`…args`)可以存储函数多余的参数
2. 为传入的`context`扩展参数扩展新属性使用了**`Symbol()`数据类型**，这样确保不会影响到传入的`context`，因为Symbol值一定是独一无二的。
3. 用**扩展运算符**(`…`)将原来是数组的`args`转发为逗号分隔一个个参数传入到函数中

为什么能找到`this.name`呢？因为`context[fnSymbol]`中的`this`指向的是`context`。

```
Function.prototype.myCall = function(context, ...args) {
  // 判断是否是undefined和null
  if (typeof context === 'undefined' || context === null) {
    context = window
  }
  // 思路和call是一样的只是传参不同方式
  let fnSymbol = Symbol()
  context[fnSymbol] = this
  //通过隐式绑定的方式调用函数
  let fn = context[fnSymbol] (...args)
  //删除添加的属性
  delete context[fnSymbol] 
  return fn
}
```

**手写apply**

思路和`call`是一样的只是传参不同方式

```
Function.prototype.myApply = function(context, args) {
  // 判断是否是undefined和null
  if (typeof context === 'undefined' || context === null) {
    context = window
  }
  let fnSymbol = Symbol()
  context[fnSymbol] = this
  let fn = context[fnSymbol] (...args)
  return fn
}
```

**手写bind**

```
Function.prototype.myBind = function(context) {
// 判断是否是undefined和null
    if (typeof context === "undefined" || context === null) {
     context = window;
    }
    self = this;
    return function() {
     return self.apply(context);
    }
}
```

**参考**

[手写源码系列（一）——call、apply、bin](https://zhuanlan.zhihu.com/p/69070129)

# 三大山-作用域和闭包

## 作用域-变量提升

var上升为全局，let是块级作用域，作用于当前。

- var：声明提升，没有局部作用域，声明覆盖
- let:

```
    for(var i =0;i<5;i++){
        setTimeout(()=>{
            console.log('var的事件循环机制:',i);// 输出55555
        },500)
    }
    for(let j =0;j<5;j++){
        setTimeout(()=>{
            console.log('let的块级作用域：',j);// 输出01234
        },500)
    }
```

例子一：**变量提升**

```js
foo;  // undefined
var foo = function () {
    console.log('foo1');
}

foo();  // foo1，foo赋值

var foo = function () {
    console.log('foo2');
}

foo(); // foo2，foo重新赋值
```

例子二：**函数提升**

```js
foo();  // foo2
function foo() {
    console.log('foo1');
}

foo();  // foo2

function foo() {
    console.log('foo2');
}

foo(); // foo2
```

例子三：声明优先级，**函数 > 变量**

```js
foo();  // foo2
var foo = function() {
    console.log('foo1');
}

foo();  // foo1，foo重新赋值

function foo() {
    console.log('foo2');
}

foo(); // foo1
```

上面三个例子中，第一个例子是变量提升，第二个例子是函数提升，第三个例子是函数声明优先级高于变量声明。

有如下两段代码，执行的结果是一样的，但是两段代码究竟有什么不同？

```js
var scope = "global scope";
function checkscope(){
    var scope = "local scope";
    function f(){
        return scope;
    }
    return f();
}
checkscope();
var scope = "global scope";
function checkscope(){
    var scope = "local scope";
    function f(){
        return scope;
    }
    return f;
}
checkscope()();
```

答案是 执行上下文栈的变化不一样。

第一段代码：

```js
ECStack.push(<checkscope> functionContext);
ECStack.push(<f> functionContext);
ECStack.pop();
ECStack.pop();
```

第二段代码：

```js
ECStack.push(<checkscope> functionContext);
ECStack.pop();
ECStack.push(<f> functionContext);
ECStack.pop();
```

**讨论题**

```
var a = {n: 1};
var b = a;
a.x = a = {n: 2};

a.x  // --> undefined
b.x  // --> {n: 2}
```

答案已经写上面了，这道题的关键在于

- 1、优先级。`.`的优先级高于`=`，所以先执行`a.x`，堆内存中的`{n: 1}`就会变成`{n: 1, x: undefined}`，改变之后相应的`b.x`也变化了，因为指向的是同一个对象。
- 2、赋值操作是`从右到左`，所以先执行`a = {n: 2}`，`a`的引用就被改变了，然后这个返回值又赋值给了`a.x`，**需要注意**的是这时候`a.x`是第一步中的`{n: 1, x: undefined}`那个对象，其实就是`b.x`，相当于`b.x = {n: 2}`

**参考**

[JavaScript深入之变量对象](https://github.com/mqyqingfeng/Blog/issues/5)

## 作用域-VO/AO/GO

JS有两个特性，一个是单线程，一个是解释性语言。

JS运行步骤：1.语法分析2.预编译3.解释执行

函数执行四部曲：

1.创建AO对象，供js引擎自己去访问

activation object （活跃对象/执行期上下文）

2.找变量和形参的声明，作为AO对象的属性名，值是undefined

3.实参和形参相统一，实参赋值给形参

4.找函数声明(注意不是函数表达式)，会覆盖变量的声明。

```js
   function fn(a,c){
console.log(a);//function a(){}
var a=123;
console.log(a);//123
console.log(c);//function c(){}
function a(){}
if(false){
var d= 678;
}
console.log(d);//undefined
console.log(b);//undefined
var b=function(){}
console.log(b);//function (){}
function c(){}
console.log(c);//function c(){}
}
fn(1,2);

AO{
a:undefined,1,function a(){}
c:undefined,2,function c(){}
d:undefined,
b:undefined,
}
```

## 作用域链

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

**到底在调用哪个函数？**

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

## 作用域-调用堆栈

执行栈，也叫调用栈，具有 LIFO（后进先出）结构，用于存储在代码执行期间创建的**所有执行上下文**。

因为JS引擎创建了很多的执行上下文，所以JS引擎创建了执行上下文**栈**（Execution context stack，ECS）来**管理**执行上下文。

当 JavaScript 初始化的时候会向执行上下文栈压入一个**全局**执行上下文，我们用 globalContext 表示它，并且只有当整个应用程序结束的时候，执行栈才会被清空，所以程序结束之前， 执行栈最底部永远有个 globalContext。

**一、执行上下文**

执行上下文总共有三种类型

- **全局执行上下文**：只有一个，浏览器中的全局对象就是 window 对象，`this` 指向这个全局对象。
- **函数执行上下文**：存在无数个，只有在函数被调用的时候才会被创建，每次调用函数都会创建一个新的执行上下文。
- **Eval 函数执行上下文**： 指的是运行在 `eval` 函数中的代码，很少用而且不建议使用。

**二、执行上下文的创建**

分为2个阶段：

- 创建阶段
- 执行阶段

**1.创建阶段**

分为3部分：

- 1、确定 **this** 的值，也被称为 **This Binding**。
- 2、**LexicalEnvironment（词法环境）** 组件被创建。
- 3、**VariableEnvironment（变量环境）** 组件被创建。

**(1)This Binding**

- **全局**执行上下文中，`this` 的值指向全局对象，在浏览器中`this` 的值指向 `window`对象，而在`nodejs`中指向这个文件的`module`对象。
- **函数**执行上下文中，`this` 的值取决于函数的调用方式。具体有：默认绑定、隐式绑定、显式绑定（硬绑定）、`new`绑定、箭头函数，具体内容会在【this全面解析】部分详解。

**(2)词法环境**

分为2部分：

- **环境记录**：存储变量和函数声明的实际位置
- **对外部环境的引用**：可以访问其外部词法环境

词法环境有两种**类型**

- 1、**全局环境**：是一个没有外部环境的词法环境，其外部环境引用为 **null**。拥有一个全局对象（window 对象）及其关联的方法和属性（例如数组方法）以及任何用户自定义的全局变量，`this` 的值指向这个全局对象。
- 2、**函数环境**：用户在函数中定义的变量被存储在**环境记录**中，包含了`arguments` 对象。对外部环境的引用可以是全局环境，也可以是包含内部函数的外部函数环境。

**(3)变量环境**

变量环境也是一个词法环境，因此它具有上面定义的词法环境的所有属性。

在 ES6 中，**词法** 环境和 **变量** 环境的区别在于前者用于存储**函数声明和变量（ `let` 和 `const` ）**绑定，而后者仅用于存储**变量（ `var` ）**绑定。

**2.执行阶段**

完成对所有变量的分配，执行代码，函数出栈

**参考**

[理解 Javascript 执行上下文和执行栈](https://juejin.im/post/5bdfd3e151882516c6432c32)

## 闭包-作用:保存和保护

1.先要说到作用域和作用域链，即AO和GO

js代码在预编译阶段，会有一个AO函数作用域和GO全局作用域。

AO是指函数作用域，GO是指全局作用域。

```js
function a(){
    var aa=111;
    function b(){
        var bb=22;
        console.log(aa)
    }
    return  b;
}
var t=a();

var a = 0, b = 0;
function A(a) {
  A = function (b) {
    alert(a + b++);
  };
  alert(a++);
}
A(1);
A(2); // ‘1’，‘4’
```

a的作用域scope：scope[0]=AO{aa,function b},scope[1]=GO{function a}

b的作用域scope:scope[0]=AO{bb},scope[1]=AO{aa,function b},scope[2]=GO{function a}

通俗理解：**闭包函数(被包裹的函数)中必须要使用到外部函数中的变量**

优点：1.读取函数内部变量；2.让这些变量的值始终保持在内存中，不会在f1调用后被自动清除；

缺点：滥用闭包导致内存泄漏，能不用尽量不用，即时释放内存。（闭包会加深作用域链，加长变量查找时间）

场景：setTimeout的函数携带参数；回调；变量封装

## 闭包-深入

**定义**

闭包是指有权访问另外一个函数作用域中的变量的函数。

关键在于2点：

- 是函数
- 能够访问函数作用域外的变量

**三个特性**

- 闭包可以访问当前函数以外的变量
- 即使外部函数已经返回，闭包仍能访问外部函数定义的变量
- 闭包可以更新外部变量的值

```
// 闭包可以访问当前函数以外的变量
function getOuter(){
  var date = '815';
  function getDate(str){
    console.log(str + date);  //访问外部的date
  }
  return getDate('今天是：'); //"今天是：815"
}
getOuter();
// 即使外部函数已经返回，闭包仍能访问外部函数定义的变量
function getOuter(){
  var date = '815';
  function getDate(str){
    console.log(str + date);  //访问外部的date
  }
  return getDate;     //外部函数返回
}
var today = getOuter();
today('今天是：');   //"今天是：815"
today('明天不是：');   //"明天不是：815"
// 闭包可以更新外部变量的值
function updateCount(){
  var count = 0;
  function getCount(val){
    count = val;
    console.log(count);
  }
  return getCount;     //外部函数返回
}
var count = updateCount();
count(815); //815
count(816); //816
```

**一个简单例子**

```
var scope = "global scope";
function checkscope(){
    var scope = "local scope";
    function f(){
        return scope;
    }
    return f;
}

var foo = checkscope(); // foo指向函数f
foo();     // 调用函数f()
```

简要的执行过程如下：

1. 进入全局代码，创建全局执行上下文，全局执行上下文**压入执行上下文栈**
2. 全局执行**上下文初始化**
3. 执行 checkscope 函数，创建 checkscope 函数执行上下文，checkscope 执行上下文被压入执行上下文栈
4. checkscope 执行**上下文初始化**，创建变量对象、作用域链、this等
5. checkscope 函数执行完毕，checkscope 执行上下文从执行上下文栈中弹出
6. 执行 f 函数，创建 f 函数执行上下文，f 执行上下文被压入执行上下文栈
7. f 执行**上下文初始化**，创建变量对象、作用域链、this等
8. f 函数执行完毕，f 函数上下文从执行上下文栈中弹出

那么**问题**来了， 函数f 执行的时候，checkscope 函数上下文已经被销毁了，那函数f是如何获取到scope变量的呢？

> 函数f 执行上下文维护了一个作用域链，会指向指向`checkscope`作用域。
>
> 所以指向关系是当前作用域 --> `checkscope`作用域--> 全局作用域，即使 checkscopeContext 被销毁了，但是 JavaScript 依然会让 checkscopeContext.AO（活动对象） 活在内存中，f 函数依然可以通过 f 函数的作用域链找到它，这就是闭包实现的**关键**。

**一个闭包题**

```
var data = [];

for (var i = 0; i < 3; i++) {
  data[i] = function () {
    console.log(i);
  };
}

data[0]();
data[1]();
data[2]();
```

如果知道闭包的，答案就很明显了，都是3

如果要依次输出索引值，解决：改成闭包，方法就是`data[i]`返回一个函数，并访问变量`i`

```
var data = [];

for (var i = 0; i < 3; i++) {
  data[i] = (function (i) {
      return function(){
          console.log(i);
      }
  })(i);
}

data[0](); // 0
data[1](); // 1
data[2](); // 2
```

循环结束后的全局执行上下文没有变化。

执行 data[0] 函数的时候，data[0] 函数的作用域链发生了改变：因为闭包执行上下文中贮存了变量`i`，所以根据作用域链会在`globalContext.VO`中查找到变量`i`,并输出0。

**一、作用域**

**1.变量提升**

```js
var scope="global";
function scopeTest(){
    console.log(scope);
    var scope="local"  
}
scopeTest(); //undefined
```

上面的代码输出是`undefined`，这是因为局部变量`scope`变量提升了，等效于下面

```js
var scope="global";
function scopeTest(){
    var scope;
    console.log(scope);
    scope="local"  
}
scopeTest(); //undefined
```

**注意**，如果在局部作用域中忘记var，那么变量就被声明为全局变量。

**2.没有块级作用域**

```js
var data = [];

for (var i = 0; i < 3; i++) {
  data[i] = function () {
    console.log(i);
  };
}

data[0](); // 3
data[1](); // 3
data[2](); // 3
```

**闭包**

```
function createClosure(){
    var name = "jack";
    return {
        setStr:function(){
            name = "rose";
        },
        getStr:function(){
            return name + ":hello";
        }
    }
}
var builder = new createClosure();
builder.setStr();
console.log(builder.getStr()); //rose:hello
```

**面试题**

由于作用域链机制的影响，闭包只能取得内部函数的最后一个值，这引起的一个副作用就是如果内部函数在一个循环中，那么变量的值始终为最后一个值。

如果想以下代码按照预期输出索引值，怎么办？

```
var data = [];

for (var i = 0; i < 3; i++) {
  data[i] = function () {
    console.log(i);
  };
}

data[0](); // 3
data[1](); // 3
data[2](); // 3
```

**方法1：立即执行函数**

```js
for (var i = 0; i < 3; i++) {
    (function(num) {
        setTimeout(function() {
            console.log(num);
        }, 1000);
    })(i);
}
// 0
// 1
// 2
```

**方法2：返回一个匿名函数赋值**

```js
var data = [];

for (var i = 0; i < 3; i++) {
  data[i] = (function (num) {
      return function(){
          console.log(num);
      }
  })(i);
}

data[0](); // 0
data[1](); // 1
data[2](); // 2
```

无论是**立即执行函数**还是**返回一个匿名函数赋值**，原理上都是因为变量的按值传递，所以会将变量`i`的值复制给实参`num`，在匿名函数的内部又创建了一个用于访问`num`的匿名函数，这样每个函数都有了一个`num`的副本，互不影响了。

**方法3：使用ES6中的let**

```js
var data = [];

for (let i = 0; i < 3; i++) {
  data[i] = function () {
    console.log(i);
  };
}

data[0]();
data[1]();
data[2]();
```

解释下**原理**：

```js
var data = [];// 创建一个数组data;

// 进入第一次循环
{ 
 let i = 0; // 注意：因为使用let使得for循环为块级作用域
            // 此次 let i = 0 在这个块级作用域中，而不是在全局环境中
    data[0] = function() {
     console.log(i);
 };
}
```

## 闭包-奇葩的闭包面试题

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

# 三大山-异步和单线程

## 消息队列和事件循环

js是单线程阻塞执行的，js 引擎执行异步代码和支持多线程，主要依靠消息队列和事件循环机制。

**基本概念**

- 消息队列：消息队列是一个先进先出的队列，它里面存放着各种消息。
- 事件循环：事件循环是指主线程重复异步任务压入消息队列，从消息队列中取消息、执行回调函数的过程。

**核心流程**

- 主线程(调用栈)执行同步代码，异步任务就放入到消息队列中
- 消息队列按照先进先出原则，异步处理不阻塞主线程
- 当主线程的同步任务执行完后，开始执行回调函数，处理从消息队列的出来的返回值

![image-20220123200002149](/img/image-20220123200002149.png)

主线程执行的回调函数，一定是在下一轮事件循环中的开始，属于下一轮。

**消息队列**

按照异步任务优先级，分为微任务(microtask队列)和宏任务(macrotask队列)。

- 微任务包括 `process.nextTick` ，`promise` ，`MutationObserver`。
- 宏任务包括 `script` ， `setTimeout` ，`setInterval` ，`setImmediate` ，`I/O` ，`UI rendering`。

**经典题**

[js异步任务](https://www.cnblogs.com/xiaozhumaopao/p/11066005.html)

[js 异步执行顺序](https://www.cnblogs.com/xiaozhumaopao/p/11066005.html)

```
加强版练习
console.log('script start')
async function async1() {
  await async2()
  console.log('async1 end')
}
async function async2() {
  console.log('async2 end')
}
async1()
setTimeout(function() {
  console.log('setTimeout')
}, 0)
new Promise(resolve => {
  console.log('Promise')
  resolve()
})
  .then(function() {
    console.log('promise1')
  })
  .then(function() {
    console.log('promise2')
  })
console.log('script end')
1. 定义函数`async1`、`async2`，**打印`script start`**；
2. 执行`setTimeout`，回调交由`Web API`处理，`Web API`将其加入宏任务队列；
3. 执行`async1`，**打印`async1 start`**；
4. 执行`async2`，**打印`async2`**，由于左边有`await`，将`console.log('async1 end')`放入微任务队列；
5. 执行`new Promise`，同步执行传入构造函数的函数，**打印`promise1`**；
6. promise完成，将`console.log('promise2')`所在函数放入微任务队列；
7. **打印`script end`**，当前任务执行完毕；
8. 检查微任务队列并依次取出执行，**打印`async1 end`**、**打印`promise2`**；
9. 微任务队列为空，执行栈为空，检查宏任务队列，取出任务执行，**打印`setTimeout`**；
10. 执行完毕。
```

async await 本身就是 promise+generator 的语法糖。所以 await 后面的代码是 microtask。所以对于上面代码中的

```
async function async1() {
	console.log('async1 start');
	await async2();
	console.log('async1 end');
}
等价于
async function async1() {
	console.log('async1 start');
	Promise.resolve(async2()).then(() => {
                console.log('async1 end');
        })
}
```

## 防抖和节流

**小结**

- 函数防抖和函数节流都是防止某一时间频繁触发，但原理不一样。
- 函数防抖是某一段时间内只执行一次，而函数节流是间隔时间执行。

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

  **节流**

  完成节流可以使用**时间戳与定时器**的写法

  使用时间戳写法，事件会立即执行，停止触发后没有办法再次执行

  ```js
  function throttled1(fn, delay = 500) {
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

  使用定时器写法，`delay`毫秒后第一次执行，第二次事件停止触发后依然会再一次执行

  ```js
  function throttled2(fn, delay = 500) {
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
  ```

  可以将时间戳写法的特性与定时器写法的特性相结合，实现一个更加精确的节流。实现如下

  ```js
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

**防抖**

  简单版本

  ```js
  function debounce(func, wait) {
      let timeout;
  return function () {
      let context = this; // 保存this指向
      let args = arguments; // 拿到event对象
      clearTimeout(timeout)
    timeout = setTimeout(function(){
          func.apply(context, args)
    }, wait);
  }
    }
  ```

  防抖如果需要立即执行，可加入第三个参数用于判断，实现如下：

  ```js
  function debounce(func, wait, immediate) {
  let timeout;
  return function () {
      let context = this;
      let args = arguments;
      if (timeout) clearTimeout(timeout); // timeout 不为null
      if (immediate) {
          let callNow = !timeout; // 第一次会立即执行，以后只有事件执行后才会再次触发
          timeout = setTimeout(function () {
              timeout = null;
          }, wait)
          if (callNow) {
              func.apply(context, args)
          }
      }
      else {
        timeout = setTimeout(function () {
              func.apply(context, args)
        }, wait);
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

**事件源**：在哪个元素上发生的。比如: p标签、a标签、div标签、form表单 等等

 **事件**：到底发生了什么事件。click(点击事件)、mouseover(鼠标事件)、focus(焦点事件) 等

**监听器**：事件源触发事件后，如何回应发生的事件，通常以函数(funtion)的形式来出现。

常见有3种绑定方式：

1、直接在html元素上进行绑定事件。

```
<input id="btn" type="button" onclick="test();" /> <!--点击按钮 触发事件-->
缺点：HTML与js代码紧密耦合。如果要更换 事件，就要改动两个地方:HTML代码和JS代码，这就不利于后期代码的维护。
```

2、用 on 绑定事件。

```
 var div=document.getElementById('id');
    div.onclick=function(){
        console.log('甲需要红背景');
        div.setAttribute('style', 'background: #ff0000');
    };
优点：它最大的优点是就是兼容性很好，所有浏览器都支持
缺点：同一个 dom 元素上，on 只能绑定一个同类型事件，后者会覆盖前者，不同类型的事件可以绑定多个。有一个问题，无法允许团队不同人员对同一元素监听同一事件但做出不用的响应
```

3、用 addEventListener、attachEvent 绑定事件。

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

## JS事件冒泡和事件捕获

```
userCapture 为false
事件冒泡执行顺序：从内部到外部Document。

userCapture 为true
事件捕获执行顺序：从Document向内部执行

Dom事件流：包含userCapture ture 和 false
捕获阶段的处理函数最先执行，其次是目标阶段的处理函数，最后是冒泡阶段的处理函数。
目标阶段的处理函数，先注册的先执行，后注册的后执行。
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

# 手写-EventBus

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

# 实现setTimeout和实现setInterval

**使用setTimeout实现setInterval**

> setInterval 的作用是每隔一段指定时间执行一个函数，但是这个执行不是真的到了时间立即执行，它真正的作用是每隔一段时间将事件加入事件队列中去，只有当当前的执行栈为空的时候，才能去从事件队列中取出事件执行。所以可能会出现这样的情况，就是当前执行栈执行的时间很长，导致事件队列里边积累多个定时器加入的事件，当执行栈结束的时候，这些事件会依次执行，因此就不能到间隔一段时间执行的效果。

 针对 setInterval 的这个缺点，我们可以使用 setTimeout 递归调用来模拟 setInterval，这样我们就确保了只有一个事件结束了，我们才会触发下一个定时器事件，这样解决了 setInterval 的问题。

 实现思路是使用递归函数，不断地去执行 setTimeout 从而达到 setInterval 的效果

```js
 // 可避免setInterval因执行时间导致的间隔执行时间不一致
function mySetInterval1(fn, timeout) {
    setTimeout (function () {
  // do something
  setTimeout (arguments.callee, 500)
}, 500)    
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

# 高级函数

**JS函数式编程思想**

**1.概述**

中心思想是指：**一个函数的返回值，仅仅依赖于参数的值，而不会因为其他外部的状态而不同。**

我们很难将所有函数都构建成符合函数式编程思维的范式，但如果应用函数式编程，则它的好处主要体现于：

- 引用透明（Referential Transparency）
- 无副作用（No Side Effect）
- 无竞争态 (No Race Condition)
- 惰性求值 (Lazy Evaluation)

**(1)无副作用（no side effects）**

任意一个函数，只要输入是确定的，输出就是确定的，这种**纯函数**称之为没有副作用的。

 函数在表现方式上，我们可以将其区分为 `纯函数` 和 `非纯函数`。他们有以下区分：

```
纯函数：返回值仅依赖于参数，输入相同的值，便会得到相同的值的函数。
let seed = 0; // 定义一个外部变量
// 一个用于求和的函数
const sum = (x, y) => x + y;

非纯函数：在参数一致的情况下，返回值可能不一致的函数。
let seed = 0; // 定义一个外部变量
// 另一个用于求和的函数
const sum = (x, y) => x + y + (++seed);
```

```
纯函数` 和 `非纯函数` 最大的两个不同的表现在于：`副作用性` 和 `引用透明性
```

`副作用性` 是指，该函数的调用过程中，是否对主函数（调用者）产生了附加影响，例如修改了函数外的变量或参数，我们就认为该函数是 `有副作用` 的函数。

**副作用主要表现于：**

- **I/O 操作**：其结果本身就是无法预估的，因此无法判断给定了的参数，是否能给予我们预期的返回结果；比如接收输入、或者将结果输出。
- **改变全局变量原有值**，或者**改变参数对象值及其属性**：其执行结果也是带有副作用的。
- **抛出异常或以错误中止**：函数除了返回一个值之外，还可能发生不太确定的执行结果。

**(2)引用透明**

引用透明（Referential transparency），指的是函数的运行不依赖于外部变量或"状态"，只依赖于输入的参数，任何时候只要参数相同，引用函数所得到的返回值总是相同的。

非纯函数造成的最大的问题，就是其 `不可预知性` 。如果代码比较复杂时，会为我们梳理程序运行逻辑造成一定的困难。因此，在函数式编程思维中，我们应尽可能的确保我们编写的函数是 `纯函数`。

```
JavaScript内置对象中的 非纯函数有：
Math.random()
console.log()
element.addEventListener()
Date.now()
Array.prototype.sort()
ajax操作等
```

在一段程序中，我们无法保证所有的函数都是纯函数。但纯函数的覆盖面越大，对于调试、缓存数据及线程安全都会提供越多的便利。有一种说法是，保证80%的函数是纯函数即可。

**(3)数据不可变**

在React中，强调一个组件不能去修改传入的prop值，这遵循了Immutable的原则

```
let a = 1;
let b = a + 1;
=> a = 1  b = 2;
```

变量b出现，虽然使用了变量a的值，但是没有修改a的值。

再看我们熟悉的react中的代码，假如初始化了this.state = { count: 1 }

```
componentDidMount() {
    const newState = { ...state, count: 2 }; // { count: 2 }
    this.setState(newState);
}
```

虽然我们使用了this.state，但是没有修改this.state的引用地址和直接修改count的值，对待this.props也一样。

React官网中给出三点好处：

- 简化复杂的功能

不可变性使得复杂的特性更容易实现。

- 跟踪数据的改变

如果直接修改数据，那么就很难跟踪到数据的改变。跟踪数据的改变需要可变对象可以与改变之前的版本进行对比，这样整个对象树都需要被遍历一次。

跟踪不可变数据的变化相对来说就容易多了。如果发现对象变成了一个新对象，那么我们就可以说对象发生改变了。

- 确定在 React 中何时重新渲染

不可变性最主要的优势在于它可以帮助我们在 React 中创建 pure components。我们可以很轻松的确定不可变数据是否发生了改变，从而确定何时对组件进行重新渲染。

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

## **尾调用**

**PS:ES6尾调用优化只能在严格模式下使用，详见[尾调用优化 阮一峰](https://link.jianshu.com/?t=http%3A%2F%2Fwww.ruanyifeng.com%2Fblog%2F2015%2F04%2Ftail-call.html)**

**定义：**某个函数的最后一步是调用另一个函数。

```
function f(x){
  return g(x);
}//尾调用
// 情况一 非尾调用
function f(x){
  let y = g(x);
  return y;
}
// 情况二 非尾调用
function f(x){
  return g(x) + 1;
}
//尾调用不一定出现在函数尾部，只要是最后一步操作即可。
    function f(x) {
  if (x > 0) {
    return m(x)
  }
  return n(x);
}
```

(1)尾调用优化（Tail call optimization）

如图所示，函数调用会在内存形成[调用栈（call stack）](https://link.jianshu.com?t=http%3A%2F%2Fzh.wikipedia.org%2Fwiki%2F%E8%B0%83%E7%94%A8%E6%A0%88)，尾调用由于是函数的最后一步操作，所以不需要保留外层函数的调用记录，因为调用位置、内部变量等信息都不会再用到了，只要直接用内层函数的调用记录，取代外层函数的调用记录就可以了。

**优点：**减小调用栈，节省内存使用。

![image-20220114072242443](/img/image-20220114072242443.png)

```
function f() {
  let m = 1;
  let n = 2;
  return g(m + n);
}
f();
// 等同于
function f() {
  return g(3);
}
f();
// 等同于
g(3);
```

(2)尾递归

**定义：**尾调用自身。
 "尾调用优化"对递归操作意义重大。ES6中第一次明确规定，所有 ECMAScript 的实现，都必须部署"尾调用优化"。这就是说，在 ES6 中，只要使用尾递归（在严格模式下），就不会发生栈溢出，相对节省内存

## 尾递归(tail recursion)

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

## 柯里化-实现add(1)(2)(3)=6

**定义**

柯里化是一种将使用多个参数的一个函数转换成一系列使用一个参数的函数的技术。

举个例子

```
function add(a, b) {
    return a + b;
}

// 执行 add 函数，一次传入两个参数即可
add(1, 2) // 3

// 假设有一个 curry 函数可以做到柯里化
var addCurry = curry(add);
addCurry(1)(2) // 3
```

**柯里化写法**

```
高颜值写法：
const curry = fn =>
    judge = (...args) =>
        args.length === fn.length
            ? fn(...args)
            : (arg) => judge(...args, arg)
高颜值的等效写法：
const curry = (fn) =>
  (judge = (...args) =>
    args.length >= fn.length ? fn(...args) : (...arg) => judge(...args, ...arg));
            
简单写法：
const curry = (fn, ...args) => 
            args.length < fn.length 
            // 参数长度不足时,重新柯里化函数,等待接受新参数
            ? (...arguments) => curry(fn, ...args, ...arguments)
            // 函数长度满足时,执行函数
             : fn(...args);
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

- 注释 1：第一次调用获取函数 fn 参数的长度，后续调用获取 fn 剩余参数的长度
- 注释 2：currying 包裹之后返回一个新函数，接收参数为 `...args`
- 注释 3：新函数接收的参数长度是否大于等于 fn 剩余参数需要接收的长度
- 注释 4：满足要求，执行 fn 函数，传入新函数的参数
- 注释 5：不满足要求，递归 currying 函数，新的 fn 为 `bind` 返回的新函数（`bind` 绑定了 `...args` 参数，未执行），新的 length 为 fn 剩余参数的长度

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

## 