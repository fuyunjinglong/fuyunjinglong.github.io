---
title: JS三大山
date: 2022-05-29 07:33:16
categories:
- B_JS
toc: true # 是否启用内容索引
---

# 三大山-作用域和闭包

面试答题模板：

> **作用域与闭包**：理解执行上下文栈和变量对象，明白函数创建和执行是两个不同阶段。

## 作用域-执行上下文

参考

- [JavaScript 深入之执行上下文栈](https://link.juejin.cn/?target=https%3A%2F%2Fgithub.com%2Fmqyqingfeng%2FBlog%2Fissues%2F4)；
- [JavaScript 深入之变量对象](https://link.juejin.cn/?target=https%3A%2F%2Fgithub.com%2Fmqyqingfeng%2FBlog%2Fissues%2F5)；
- [JavaScript 深入之作用域链](https://link.juejin.cn/?target=https%3A%2F%2Fgithub.com%2Fmqyqingfeng%2FBlog%2Fissues%2F6)；
- [JavaScript 深入之执行上下文](https://link.juejin.cn/?target=https%3A%2F%2Fgithub.com%2Fmqyqingfeng%2FBlog%2Fissues%2F8)。

**执行上下文**

定义：执行上下文就是当前 JavaScript 代码被解析和执行时所在环境的抽象概念。

- 它包含**三部分**
  - 变量对象（VO）
  - 作用域链（词法作用域）
  - this 指向

- 它的**类型**：
  - 全局执行上下文
  - 函数执行上下文
  - eval 执行上下文

> - 全局执行上下文： 这是默认的、最基础的执行上下文。不在任何函数中的代码都位于全局执行上下文中。它做了两件事：1. 创建一个全局对象，在浏览器中这个全局对象就是 window 对象。2. 将 this 指针指向这个全局对象。一个程序中只能存在一个全局执行上下文。
> - 函数执行上下文： 每次调用函数时，都会为该函数创建一个新的执行上下文。每个函数都拥有自己的执行上下文，但是只有在函数被调用的时候才会被创建。一个程序中可以存在任意数量的函数执行上下文。每当一个新的执行上下文被创建，它都会按照特定的顺序执行一系列步骤，具体过程将在本文后面讨论。
> - Eval 函数执行上下文： 运行在 eval 函数中的代码也获得了自己的执行上下文，但由于 Javascript 开发人员不常用 eval 函数，所以在这里不再讨论。

- 代码执行**过程**：
  - 创建 **全局上下文**（global EC）
  - 全局执行上下文（caller）**自上而下** 逐行执行。遇到函数时，**函数执行上下文**（callee）被 push 到执行栈顶
  - 函数执行上下文被激活，成为 active EC，开始执行函数中的代码，caller 被挂起
  - 函数执行完后，callee 被 pop 移除出执行栈，控制权交还给全局上下文（caller）继续执行

包括三个阶段：**创建阶段→执行阶段→回收阶段**

1.创建阶段

当函数被调用，但未执行任何其内部代码之前，会做以下三件事：

- 创建变量对象：首先初始化函数的参数arguments，提升函数声明和变量声明。下文会详细说明。
- 创建作用域链（Scope Chain）：在执行期上下文的创建阶段，作用域链是在变量对象之后创建的。作用域链本身包含变量对象。作用域链用于解析变量。当被要求解析变量时，JavaScript 始终从代码嵌套的最内层开始，如果最内层没有找到变量，就会跳转到上一层父作用域中查找，直到找到该变量。
- 确定this指向：包括多种情况，下文会详细说明

在一段 JS 脚本执行之前，要先解析代码（所以说 JS 是解释执行的脚本语言），解析的时候会先创建一个全局执行上下文环境，先把代码中即将执行的变量、函数声明都拿出来。变量先暂时赋值为undefined，函数则先声明好可使用。这一步做完了，然后再开始正式执行程序。

另外，一个函数在执行之前，也会创建一个函数执行上下文环境，跟全局上下文差不多，不过 函数执行上下文中会多出this arguments和函数的参数。

2.执行阶段

执行变量赋值、代码执行

3.回收阶段

执行上下文出栈等待虚拟机回收执行上下文

**作用域与执行上下文**

JavaScript属于解释型语言，JavaScript的执行分为：解释和执行两个阶段。解释阶段确定作用域规则，执行阶段确定上下文。太妙了

解释阶段：

- 词法分析
- 语法分析
- 作用域规则确定

执行阶段：

- 创建执行上下文
- 执行函数代码
- 垃圾回收

> 作用域和执行上下文之间最大的区别是：
> **执行上下文在运行时确定，随时可能改变；作用域在定义时就确定，并且不会改变**。

## 作用域-变量对象(VO/AO/GO)

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

**静态作用域与动态作用域**

> JavaScript 采用词法作用域(lexical scoping)，就是静态作用域。

因为 JavaScript 采用的是词法作用域，函数的作用域在函数定义的时候就决定了。

而与词法作用域相对的是动态作用域，函数的作用域是在函数调用的时候才决定的。

```
var value = 1;
function foo() {
    console.log(value);
}
function bar() {
    var value = 2;
    foo();
}
bar();
// 结果是 ???
```

假设JavaScript采用静态作用域，让我们分析下执行过程：

执行 foo 函数，先从 foo 函数内部查找是否有局部变量 value (价值) ，如果没有，就根据书写的位置，查找上面一层的代码，也就是 value (价值) 等于 1，所以结果会打印 1。

假设JavaScript采用动态作用域，让我们分析下执行过程：

执行 foo 函数，依然是从 foo 函数内部查找是否有局部变量 value (价值) 。如果没有，就从调用函数的作用域，也就是 bar 函数内部查找 value (价值) 变量，所以结果会打印 2。

前面我们已经说了，JavaScript采用的是静态作用域，所以这个例子的结果是 1。

来自《JavaScript权威指南》中的例子：

```
var scope = "global scope";
function checkscope(){
    var scope = "local scope";
    function f(){
        return scope;
    }
    return f();
}
checkscope();
```

```
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

两段代码都会打印：`local scope`。因为JavaScript采用的是词法作用域，函数的作用域基于函数创建的位置。

> 引用《JavaScript权威指南》的回答就是：
>
> JavaScript 函数的执行用到了作用域链，这个作用域链是在函数定义的时候创建的。嵌套的函数 f() 定义在这个作用域链里，其中的变量 scope (范围) 一定是局部变量，不管何时何地执行函数 f()，这种绑定在执行 f() 时依然有效。

**变量提升**

- 变量声明提升
- 函数声明提升

> 有个细节必须注意：当遇到函数和变量同名且都会被提升的情况，函数声明优先级比较高，因此变量声明会被函数声明所覆盖，但是可以重新赋值。

```
// 变量声明提升
console.log(a)// undefined
var a = 10

// 函数声明提升
function test() {
    foo(); // Uncaught TypeError "foo is not a function"
    bar(); // "this will run!"
    var foo = function () { // function expression assigned to local variable 'foo'
        alert("this won't run!");
    }
    function bar() { // function declaration, given the name 'bar'
        alert("this will run!");
    }
}
test();

// 复杂点例子
function test(arg){
    // 1. 形参 arg 是 "hi"
    // 2. 因为函数声明比变量声明优先级高，所以此时 arg 是 function
    console.log(arg);  
    var arg = 'hello'; // 3.var arg 变量声明被忽略， arg = 'hello'被执行
    function arg(){
 console.log('hello world') 
    }
    console.log(arg);  
}
test('hi');
/* 输出：
function arg(){
    console.log('hello world') 
    }
hello 
*/
```

## 作用域-作用域与作用域链

**`作用域`** 指代码当前上下文，控制着变量和函数的可见性和生命周期。最大的作用是隔离变量，不同作用域下同名变量不会冲突。

**`作用域链`** 指如果在当前作用域中没有查到值，就会向上级作用域查询，直到全局作用域，这样一个查找过程所形成的链条就被称之为作用域链。

作用域具体可细分为四种：**`全局作用域`**、**`模块作用域`**、**`函数作用域`**、**`块级作用域`**

**全局作用域：** 代码在程序的任何地方都能被访问，例如 window 对象。但全局变量会污染全局命名空间，容易引起命名冲突。

**模块作用域：** 早期 js 语法中没有模块的定义，因为最初的脚本小而简单。后来随着脚本越来越复杂，就出现了模块化方案（AMD、CommonJS、UMD、ES6模块等）。通常一个模块就是一个文件或者一段脚本，而这个模块拥有自己独立的作用域。

**函数作用域：** 顾名思义由函数创建的作用域。闭包就是在该作用域下产生，后面我们会单独介绍。

**块级作用域：** 由于 js 变量提升存在变量覆盖、变量污染等设计缺陷，所以 ES6 引入了块级作用域关键字来解决这些问题。典型的案例就是 let 的 for 循环和 var 的 for 循环。

```
// var demo
for(var i=0; i<10; i++) {
    console.log(i);
}
console.log(i); // 10

// let demo
for(let i=0; i<10; i++) {
    console.log(i);
}
console.log(i); //ReferenceError：i is not defined
```

## 闭包

**1.定义**

闭包是指有权访问另外一个函数作用域中的变量的函数。当内部函数被保存到外部时会产生闭包。**本质是函数与其词法作用域的绑定组合。**

JavaScript引擎通过将闭包所需变量存储在堆内存（而非栈）中，避免函数调用后作用域被销毁。

**两个核心**

- 是函数
- 能够访问函数作用域外的变量

**三个特性(如何判断是闭包)**

- 闭包一定具有嵌套函数
- 内层函数一定操作了外层函数的局部变量
- 外层函数,将内层函数返回到外部(即使外部函数已经返回，闭包仍能访问外部函数定义的变量)

```
function outer() {
  let count = 0;
  return function inner() {
    count++; // 访问外层作用域的变量
    return count;
  };
}
const counter = outer();
console.log(counter()); // 1
console.log(counter()); // 2
```



```js
// 内层函数一定操作了外层函数的局部变量
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
```

**2.为什么需要闭包**

局部变量无法共享和长久保存，而全局变量可能造成变量污染，当我们希望有一种机制既可以长久保存变量，又不会造成全局污染，所有有了闭包。

**3.闭包的作用**

优点：

- 读取函数内部的变量
- 让这些变量的值始终保持在内存中
- 方便调用上下文的局部变量，利于代码封装

缺点：滥用闭包导致内存泄漏，能不用尽量不用，及时释放内存。（闭包会加深作用域链，加长变量查找时间）

**4.闭包的5个使用场景**

**常用场景**

- 实现公有变量 => 累加器
- 可以做缓存,存储结构
- 可以实现封装,属性私有化
- 模块化开发,防止污染全局变量

**5个场景**

> 1. 模块化与封装私有变量
> 2. 高阶函数与状态管理
> 3. 函数柯里化（Currying）
> 4. 迭代器与生成器模式
> 5. 单例模式与缓存优化

**4.1模块化与封装私有变量**

通过立即执行函数（IIFE）创建独立作用域，避免全局污染：

```
const module = (function() {
  let privateVar = 0;
  return {
    increment: () => privateVar++,
    getValue: () => privateVar
  };
})();
module.increment();
console.log(module.getValue()); // 1
```

此时，privateVar对外不可见，仅通过闭包暴露操作方法。

**4.2高阶函数与状态管理**

闭包允许函数携带状态，例如实现防抖（Debounce）和节流（Throttle）：

```
function debounce(fn, delay) {
  let timer = null;
  return function(...args) {
    clearTimeout(timer);
    timer = setTimeout(() => fn.apply(this, args), delay);
  };
}
const searchInput = debounce(() => console.log("Search triggered"), 300);
```

每次调用searchInput时，闭包中的timer变量被复用。

**4.3函数柯里化（Currying）**

将多参数函数转换为单参数链式调用，增强灵活性：

```
function add(x) {
  return function(y) {
    return x + y;
  };
}
const add5 = add(5);
console.log(add5(3)); // 8
```

柯里化通过闭包缓存部分参数，便于复用

**4.4迭代器与生成器模式**

闭包可保存迭代状态，实现自定义迭代逻辑：

```
function createIterator(arr) {
  let index = 0;
  return {
    next: () => (index < arr.length ? arr[index++] : null)
  };
}
const iterator = createIterator([1, 2, 3]);
console.log(iterator.next()); // 1
```

**4.5单例模式与缓存优化**

通过闭包缓存计算结果，避免重复计算：

```
function memoize(fn) {
  const cache = new Map();
  return function(arg) {
    if (cache.has(arg)) return cache.get(arg);
    const result = fn(arg);
    cache.set(arg, result);
    return result;
  };
}
```

[闭包例子1](https://cnodejs.org/topic/5d39c5259969a529571d73a8)

**5.闭包题**

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

**奇葩的闭包面试题**

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

# 三大山-原型和原型链

## 原型与原型链

面试答题模板：

> **原型与原型链**：不要死记硬背，手写几遍**原型链继承**、**寄生组合继承**，画图推导 `instanceof` 的查找过程。

原型和原型链是一种实现对象之间继承和共享属性的机制。

**原型是 JS 实现继承的载体，原型链是 JS 实现继承的机制**。**原型对象是内存中存储共享属性和方法的实体对象**

**1.标准**

js之父在设计了两个准则：

>  **准则 1：** `构造函数.prototype.constructor === 构造函数` （原型对象通过 constructor 指回构造函数本身）
>
>  **准则 2：** `实例.__proto__ === 构造函数.prototype` （实例通过 `__proto__` 指向构造函数的原型对象）
>
>  **形成三角关系**：构造函数通过 `prototype` 找到原型，原型通过 `constructor` 找回构造函数，实例通过 `__proto__` 链接到原型。

**2.定义**

一句话：构造函数的 `prototype` 和 实例对象的 `__proto__`，指向的是内存中同一个原型对象。

proto（隐式原型）

> - **所有对象**（包括原型对象本身，函数、对象、数组等）都有 `proto` 属性。
> - **是它自己找爹用的**：儿子通过 `__proto__` 往上找爹的工具箱，用来**指向父级原型**的指针。
> - 它只是一个属性引用（一个地址），指向爹的 `prototype`。

prototype（显式原型）

> - 只有**函数**（构造函数）拥有 `prototype` 属性。
> - **是给它的孩子准备的**：爹通过 `prototype` 指明自己的工具箱在哪，用来**存放共享属性和方法**的容器。
> - 是一个实实在在的对象（原型对象），还自带一个 `constructor` 属性指回构造函数。

原型链：对象属性查找的路径。实例 -> 构造函数原型 -> 父类构造函数原型 -> … -> Object.prototype -> null

```js
// 实例 -> 构造函数原型（实例靠 __proto__ 连到 构造函数原型）
实例.__proto__ === 构造函数.prototype
// 构造函数原型 -> 父类构造函数原型 -> … -> Object.prototype（构造函数原型靠 __proto__ 连到 父类原型 / Object原型）
构造函数.prototype.__proto__ === Object.prototype
// （Object.prototype）是万物之源，他没有爹了（Object原型靠 __proto__ 连到 null）
Object.prototype.__proto__ === null
```

> **原型存在的意义就是组成原型链**：每个对象都有原型，原型也是对象，也有它自己的原型，一层一层，组成原型链。
>
> **原型链存在的意义就是继承**：访问对象属性时，在对象本身找不到，就在原型链上一层一层找。
>
> **继承存在的意义就是属性共享**：好处：一是代码重用，字面意思；二是可扩展，不同对象可能继承相同的属性，也可以定义只属于自己的属性。

```js
// 原型
var Test = function(){
    a:111
}
Test.prototype.b=222;
Object.prototype.c=333;
const test = new Test();
console.log(test);
console.log(test.__proto__);
console.log(Test.prototype);
console.log(test.__proto__===Test.prototype);//true
console.log(Test.prototype.__proto__===Object.prototype);//true
console.log(Object.prototype.__proto__);// 顶层null
// 原型链
test:{
    a:111,
    __proto__:Test.prototype={
        b:222,
        __proto__:Object.prototype={
            c:333,
            __proto__:null
        }
    }
}
// 模拟一下js引擎读取对象属性
function getProperty(obj, propName) {
    // 在对象本身查找
    if (obj.hasOwnProperty(propName)) {
        return obj[propName]
    } else if (obj.__proto__ !== null) {
    // 如果对象有原型，则在原型上递归查找
        return getProperty(obj.__proto__, propName)
    } else {
    // 直到找到Object.prototype，Object.prototype.__proto__为null，返回undefined
        return undefined
    }
}
```

**3.原型的引子**

创建对象：一种是`new`操作符，一种是字面量表示法。

> 优先使用**构造函数+原型模式**（或 ES6 的 Class），将私有属性放在构造函数中，共享方法放在原型上，兼顾内存和性能。

```js
// 惯例，构造函数应以大写字母开头
function Person(name) {
  // 函数内this指向构造的对象
  // 构造一个name属性
  this.name = name
  // 构造一个sayName方法。缺点：每次new都会创建，浪费内存。
  this.sayHi = function() {
    console.log('hi')
  }
}
// 如果采用原型，解决上述缺点
Person.prototype.sayHi = function() { console.log('Hi') }; // 共享方法放原型
// 使用自定义构造函数Person创建对象
let person = new Person('logan')
```

采用ES6 Class 语法（语法糖）

```js
// 比上述构造函数，更像面向对象编程
class Person {
  constructor(name) { this.name = name;}
  sayHi() { console.log('Hi') } // 自动放在原型上
}
```

**4.函数的双重身份**

> - 作为构造函数：它有 `prototype` 属性
> - 作为函数对象：它有 `__proto__ ` 属性

```js
第一步：函数的爹
// 所有函数的爹 都是Function
Person.__proto__ === Function.prototype(这个工具箱理由call,apply,bind)
第二步：Function.prototype 的爹是谁
// Function.prototype也属于对象，所以它的爹自然也是Object
Function.prototype.__proto__ === Object.prototype
第三步：Function的爹是谁
// JS 引擎在启动时，搞了一个时间循环（Bootstrap 闭环）俗称自己生自己。
Function.__proto__ === Function.prototype
第四步：Object的爹是谁
// Object也属于函数，所以它的爹自然也是Function
Object.__proto__ === Function.prototype
```

神仙逻辑

> **函数的尽头是 Function，对象的尽头是 Object**，而它们俩在顶层打了个死结，最后一起掉进 `null`。
>
> 死结(JS 引擎在初始化时硬编码设定的闭环):
>
> - Function 创造了 Object即（Object 是 Function 的实例），因为 Object.__proto__ === Function.prototype
> - Object 是 Function 的底座即（Function.prototype 继承自 Object.prototype），因为 Function.prototype.__proto__ === Object.prototype

**5.Foo经典原型图**

<img src="/img/image-20220605092641925.png" alt="image-20220605092641925" style="zoom:80%;" />

分3条线路分析一清二楚：

- 第1条路：左上角f1,f2
- 第2条路：构造函数Foo
- 第3条路：左侧o1,o2
- 第4条路：原生构造函数`Object`和`Function`

**第1条路：左上角f1,f2**

```
// f1、f2都是通过new Foo()创建的对象，构造函数为Foo，所以有
f1.__proto__ === Foo.prototype
// Foo.prototype为普通对象，构造函数为Object，所以有
Foo.prototype.__proto === Object.prototype
// Object.prototype没有原型对象
Object.prototype.__proto__ === null
```

**第2条路：构造函数Foo**

```
// Foo是个函数对象，构造函数为Function
Foo.__proto__ === Function.prototype
// Function.prototype为普通对象，构造函数为Object，所以有
Function.prototype.__proto__ === Object.prototype
```

**第3条路：左侧o1,o2**

对原生构造函数`Object`创建的`o1`、`o2`下手：

```javascript
// o1、o2构造函数为Object
o1.__proto__ === Object.prototype
```

**第4条路：原生构造函数`Object`和`Function`**

```
// 原生构造函数也是函数对象，其构造函数为Function
Object.__proto__ === Function.prototype
// 特例
Function.__proto__ === Function.prototype
```

## instanceof操作符

> `A instanceof B` 的本质，就是检查 **`A.__proto__` 的整条链条上，是否存在等于 `B.prototype` 的节点。**

```js
function myInstanceof(obj, Constructor) {
  // 1. 拿到右边构造函数的原型对象（目标靶子）
  let target = Constructor.prototype; 
  
  // 2. 拿到左边对象的隐式原型（起点）
  let current = obj.__proto__;       
  
  // 3. 开始顺着原型链往上找
  while (true) {
    // 找到头了，没找到，返回 false
    if (current === null) {
      return false;
    }
    // 找到了！当前节点等于目标靶子，返回 true
    if (current === target) {
      return true;
    }
    // 没找到，也没到头，顺着链条往上走一步
    current = current.__proto__;
  }
}
```

## Object.create操作符

> **凭空造一个空对象，让这个空对象的 `__proto__` 指向传入的 `proto`。**实现这个等式：`新对象.__proto__ === proto`

```js
function myCreate(proto) {
  // 1. 创建一个空的构造函数
  function F() {}
  // 2. 将空函数的 prototype 指向传入的 proto
  F.prototype = proto;
  // 3. 返回这个空函数的实例
  return new F();
}
```

```js
一步步推导：
1.function F() {}：定义了一个空函数。此时，JS 引擎自动给 F 分配了一个原型对象 F.prototype。
2.F.prototype = proto：我们粗暴地把 F 默认的原型对象扔掉，替换成传入的 proto。
3.return new F()：这是最关键的一步。new F() 做了什么？
3.1创建了一个空实例对象 obj。
3.2将实例的隐式原型指向构造函数的显式原型：obj.__proto__ = F.prototype。
4.代入替换：因为第二步中 F.prototype = proto，所以第三步的等式变成了：obj.__proto__ = proto
```

**为什么我们要用 `Object.create`？**

在 `Object.create` 出现之前，JS 实现继承通常是这样的：

```js
// 旧式继承
// 有个大坑：你在把 Animal 的实例赋给 Dog.prototype 时，Animal 构造函数会被执行！如果 Animal 里有 this.name = '默认名' 这种属性，就会污染 Dog.prototype。
Dog.prototype = new Animal(); 

`Object.create` 完美解决了这个问题：
// 新式继承
// 它只建立原型链的连接（Dog.prototype.__proto__ === Animal.prototype），绝不执行 Animal 的构造函数，干净利落！只认爹（原型），不干活（不执行构造函数）。
Dog.prototype = Object.create(Animal.prototype);
```

## new操作符

```javascript
function myNew(Constructor, ...args) {
  // 1. 创建一个空对象
  let obj = {};

  // 2. 连接原型链：让空对象的 __proto__ 指向构造函数的 prototype
  obj.__proto__ = Constructor.prototype;
  // （更优雅的写法是：let obj = Object.create(Constructor.prototype); 直接合并了1和2）

  // 3. 改变 this 指向，执行构造函数，拿到返回结果
  let result = Constructor.apply(obj, args);

  // 4. 返回值判断
  // 如果构造函数返回了一个对象或函数，就返回它；否则返回新创建的 obj
  return (result !== null && typeof result === 'object') || typeof result === 'function' ? result : obj;
}
```

## JS的5种继承方式

**1.原型链继承—— “全家共用一个钱包”**

**核心**：直接把爹实例化，当成儿子的公共工具箱。

**大白话**：儿子不自己赚钱，直接把爹的钱包当成全家的公共钱包。

```js
function Father() { 
    this.money = [100]; // 爹的私有财产
}
Father.prototype.makeMoney = function() {}; // 爹的工具箱

function Son() {}
Son.prototype = new Father(); // 核心代码：把爹的实例当成儿子的原型
```

**缺点**：共享过剩（修改引用类型，全家遭殃）。

```js
let s1 = new Son();
let s2 = new Son();
s1.money.push(50); // s1 从钱包里拿了 50

console.log(s2.money); // [100, 50] ！！！s2 的钱也变多了！
// 因为 money 是个数组（引用类型），挂在 Son.prototype 上，所有儿子实例共享这一个数组，一个儿子改了，其他儿子全受影响。而且，儿子实例化时没法给爹传参。
```

**2.借用构造函数继承（构造函数窃取） —— “抄爹的作业”**

为了解决“共享钱包”的问题：不共享了，各抄各的！

**核心**：在儿子构造函数里，用 `call` 强行把爹的代码在儿子家里执行一遍。

**大白话**：儿子不让爹留公共钱包了。而是把爹当年赚钱的代码（函数体）拿过来，在自己家里原样执行一遍，自己造一份一样的私有财产。

**优点**：完美解决了引用类型共享的问题，还能给爹传参。
**致命缺点**：拿不到爹的工具箱（函数复用无从谈起）。每次 new 儿子，都要把爹的代码重新执行一遍，内存浪费

```js
Father.prototype.makeMoney = function() {}; // 爹的工具箱
let s1 = new Son();
s1.makeMoney(); // 报错！s1 找不到这个方法
```

**3.组合继承 —— “前两种的结合（最常用的老派方案）”**

第一种能拿到工具箱，第二种能拿到私有财产，合体就行了。

**核心**：用 call 借私有财产，用 prototype 借工具箱。

**大白话**：爹的私有财产儿子自己抄一份（防共享），爹的公共工具箱儿子拿过来共享（省内存）。

**优点**：既能防共享，又能用原型方法，还能传参。在 ES6 之前，这是最完美的方案。
**致命缺点**：爹被调用了两次，有点冗余。一次在 call，一次在 new Father()。而且 new Father() 产生的私有属性，其实会被 call 抄来的同名属性覆盖掉，纯属浪费性能。

```js
function Father(name) { 
    this.name = name; 
    this.money = [100]; 
}
Father.prototype.makeMoney = function() {};

function Son(name) {
    Father.call(this, name); // 第二次调用 Father：抄私有财产
}
Son.prototype = new Father(); // 第一次调用 Father：借工具箱
Son.prototype.constructor = Son; // 记得把 constructor 扳回儿子自己
```

**4.原型式继承 —— “轻量级的对象克隆”**

这种方案不是用来做“父子类”继承的，而是用来“基于一个现有对象，造一个新对象”。

**核心**：就是前面讲的 `Object.create` 的原理。

**大白话**：没有构造函数，直接找一个现成的爹对象，儿子顺着 `__proto__` 认他做爹。

**缺点**：跟第一种一样，引用类型共享。而且没法给初始对象传参。

```js
let father = { money: [100], makeMoney: function(){} };
let son = Object.create(father); // 核心代码
```

**5.寄生组合式继承 —— “终极完美方案（ES5 巅峰）”**

专门为了解决“组合继承调用了两次爹”的问题。

**核心**：用 `call` 借私有财产，用 `Object.create` 借工具箱（绝不调用爹的构造函数！）。

**大白话**：

- 私有财产？我儿子自己抄（call）。
- 公共工具箱？我不实例化你，我直接用 Object.create 造一个空对象，让这个空对象的 __proto__ 指向你的工具箱（Father.prototype）！

**优点**：完美！私有属性不共享，原型方法能复用，爹只调用了一次，没有多余属性。这就是 ES6 class 继承的底层实现原理！

```js
function Father(name) { 
    this.name = name; 
    this.money = [100]; 
}
Father.prototype.makeMoney = function() {};

function Son(name) {
    Father.call(this, name); // 只调用一次 Father：抄私有财产
}
// 核心魔法：不调用 Father，只建立原型链连接！
Son.prototype = Object.create(Father.prototype); 
Son.prototype.constructor = Son;
```

**终极总结：ES6 class 继承（语法糖）**

现在我们写代码，再也不用写那一坨恶心的 `call` 和 `Object.create` 了。JS 给我们提供了 `class` 和 `extends` 关键字：

```js
class Father {
    constructor(name) { this.name = name; this.money = [100]; }
    makeMoney() {}
}
class Son extends Father {
    constructor(name) { super(name); } // super 相当于 Father.call(this, name)
}
```

注意：`class` 只是语法糖！

- `constructor` 里的 `super()`，底层就是 **`Father.call(this)`**。
- `extends`，底层就是 **`Son.prototype = Object.create(Father.prototype)`**。

## 彻底搞懂this

小结：

- 对于直接调用 foo 来说，不管 foo 函数被放在了什么地方，this 一定是 window
- 对于 obj.foo() 来说，我们只需要记住，谁调用了函数，谁就是 this，所以在这个场景下 foo 函数中的 this 就是 obj 对象
- 在构造函数模式中，类中(函数体中)出现的this.xxx=xxx中的this是当前类的一个实例
- call、apply和bind：this 是第一个参数
- 箭头函数this指向:箭头函数没有自己的this，看其外层的是否有函数，如果有，外层函数的this就是内部箭头函数的this，如果没有，则this是window。

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

> - 默认绑定(函数的普通调用)：`this` 绑定到全局对象
> - 隐式绑定(函数作为对象方法调用)：一般绑定到调用对象，如 `obj.foo` 绑定到 `obj`
> - 显示绑定(函数通过`call`、`apply`、`bind`间接调用)：通过 `call`、`apply` 指定 `this` 绑定到哪里。使用 `bind` 函数硬绑定
> - new绑定(函数作为构造函数调用)：使用 `new` 关键词，绑定到当前函数对象

判断 this 最终指向，总体流程：

> 1. 判断函数调用时是否使用了 `new`，即 `new` 绑定，如果使用了，则 `this` 绑定的是新创建的对象。
> 2. 函数调用是否使用了 `call`、`apply` 等显式绑定，或者硬绑定（bind），如果是的话，`this` 指向指定的对象。
> 3. 函数是否在某个上下文对象中调用，即隐式绑定，如 `obj1.foo`，如果是的话，`this` 指向绑定的那个上下文对象。
> 4. 以上 3 点都不涉及的话，则采用默认绑定，但是需要注意的是，在严格模式下，默认绑定的 `this` 是 `undefined`，非严格模式下绑定到全局对象。

**1.默认绑定(函数的普通调用)**

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

**2.隐式绑定(函数作为对象方法调用)**

```
//var foo=()=> {
//  console.log(this.name) // undefined
//}
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

**3.显示绑定(函数通过`call`、`apply`、`bind`间接调用)**

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

**4.new绑定(函数作为构造函数调用)**

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

练习绑定：

```
var name = 'window'

const person1 = {
  name: 'person1',
  show1: function () {
    console.log(this.name)
  },
  show2: () => console.log(this.name),
  show3: function () {
    return function () {
      console.log(this.name)
    }
  },
  show4: function () {
    return () => console.log(this.name)
  }
}
const person2 = { name: 'person2' }

person1.show1()                     // person1 函数作为对象方法调用，this指向对象
person1.show1.call(person2)         // person2 使用call间接调用函数，this指向传入的person2

person1.show2()                     // window  箭头函数无this绑定，在全局环境找到this，指向window
person1.show2.call(person2)         // window  间接调用改变this指向对箭头函数无效

person1.show3()()                   // window  person1.show3()返回普通函数，相当于普通函数调用，this指向window
person1.show3().call(person2)       // person2 使用call间接调用函数，this指向传入的person2
person1.show3.call(person2)()       // window  person1.show3.call(person2)仍然返回普通函数

person1.show4()()                   // person1 person1.show4调用对象方法，this指向person1，返回箭头函数，this在person1.show4调用时的词法环境中找到，指向person1
person1.show4().call(person2)       // person1  间接调用改变this指向对箭头函数无效
person1.show4.call(person2)()       // person2  改变了person1.show4调用时this的指向，所以返回的箭头函数的内this解析改变
```

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

# 三大山-异步与事件循环

面试答题模板：

> **异步与事件循环**：多刷输出顺序题，真正理解“微任务优先”的底层调度逻辑，告别回调地狱（掌握 `Promise` 和 `async/await`）。

## JS异步编程六大方案

参考：[异步编程方案](https://github.com/ljianshu/Blog/issues/53)

- 回调函数（Callback）
- 事件监听
- 发布订阅
- Promise/A+
- 生成器Generators/ yield
- async/await

**回调函数**
致命的弱点，就是容易写出回调地狱（Callback hell）。

- 优点：简单、容易理解和实现
- 缺点：不利于代码的阅读和维护，各个部分之间高度耦合，使得程序结构混乱、流程难以追踪

```
ajax(url, () => {
    // 处理逻辑
})
```

**事件监听**

这种方式下，异步任务的执行不取决于代码的顺序，而取决于某个事件是否发生。

- 优点：比较容易理解，可以绑定多个事件，每个事件可以指定多个回调函数，而且可以"去耦合"，有利于实现模块化。
- 缺点：整个程序都要变成事件驱动型，运行流程会变得很不清晰。阅读代码的时候，很难看出主流程。

**发布订阅**

我们假定，存在一个"信号中心"，某个任务执行完成，就向信号中心"发布"（publish）一个信号，其他任务可以向信号中心"订阅"（subscribe）这个信号，从而知道什么时候自己可以开始执行。这就叫做"发布/订阅模式"（publish-subscribe pattern），又称"观察者模式"（observer pattern）。

- 优点：与“事件监听”类似，但是明显优于后者。因为可以通过查看“消息中心”，了解存在多少信号、每个信号有多少订阅者，从而监控程序的运行。

**Promise/A+**

Promise本意是承诺，在程序中的意思就是承诺我过一段时间后会给你一个结果。

**生成器Generators/ yield**

Generator 函数是 ES6 提供的一种异步编程解决方案，语法行为与传统函数完全不同，Generator 最大的特点就是可以控制函数的执行。

- 语法上，首先可以把它理解成，Generator 函数是一个状态机，封装了多个内部状态。
- Generator 函数除了状态机，还是一个遍历器对象生成函数。
- 可暂停函数, yield可暂停，next方法可启动，每次返回的是yield后的表达式结果。
- yield表达式本身没有返回值，或者说总是返回undefined。next方法可以带一个参数，该参数就会被当作上一个yield表达式的返回值。

**async/await**

它可以轻松地达成之前使用生成器和co函数所做到的工作,它有如下特点：

- async/await是基于Promise实现的，它不能用于普通的回调函数。
- async/await与Promise一样，是非阻塞的。
- async/await使得异步代码看起来像同步代码，这正是它的魔力所在。

## 消息队列和事件循环

js是单线程阻塞执行的，js 引擎执行异步代码和支持多线程，主要依靠消息队列和事件循环机制。

为什么js是一门单线程语言呢？最初设计JS是用来在浏览器验证表单以及操控DOM元素，为了避免同一时间对同一个DOM元素进行操作从而导致不可预知的问题，JavaScript从一诞生就是单线程。

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
