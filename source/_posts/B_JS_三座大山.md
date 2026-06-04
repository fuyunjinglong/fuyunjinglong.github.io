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

面试答题模板：

> **原型与原型链**：不要死记硬背，手写几遍**原型链继承**、**寄生组合继承**，画图推导 `instanceof` 的查找过程。

## 原型与原型链

原型和原型链是一种实现对象之间继承和共享属性的机制。

每个对象都有一个内部属性-proto-(google浏览器是[[Prototype]])，指向另一个对象，称为该对象的原型。原型对象也有自己的原型，这样就形成了一个原型链，直到某个对象的原型为null为止。

> 一句话：“老王（原型对象）是张三的父亲（原型）



**1.标准**

js之父在设计js原型、原型链的时候遵从以下两个准则

>  **准则1：原型对象（即Person.prototype）的constructor指向构造函数本身**
>
>  Person.prototype.constructor == Person
>
>  **准则2：实例的-proto-保存着构造函数的prototype即实例（即person01）的-proto-和原型对象指向同一个地方**
>
>  person01._-proto_- == Person.prototype

- Person.prototype是显示原形属性
- person01._-proto_-是隐式原形属性,对应新版google中的[[prototype]]

**2.定义**

原型：proto是对象object的原形属性，所以proto叫对象的原形。原型才是核心的核心。

原型对象：prototype是构造函数fn的原形属性，所以prototype叫fn的原形对象。原形对象只是构造函数才有的一个名称。

> 一句话：“老王（原型对象）是张三的父亲（原型）。

原型链：一句话就是以对象为基准，以proto为连接点，一直到Object.prototype为止的一条链条。(原型链顶层Object.prototype.-proto-=null)

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

**3.创建对象**

对象的创建方式主要有两种，一种是`new`操作符后跟函数调用，另一种是字面量表示法。(字面量表示法可以理解为语法糖，本质还是new)。

**任何一个函数都可以当做构造函数**。

```js
// 惯例，构造函数应以大写字母开头
function Person(name) {
  // 函数内this指向构造的对象
  // 构造一个name属性
  this.name = name
  // 构造一个sayName方法
  this.sayName = function() {
    console.log(this.name)
  }
}

// 使用自定义构造函数Person创建对象
let person = new Person('logan')
```

**4.函数对象的原型链**

函数都是由`Function`原生构造函数创建的，所以函数的`__proto__`属性指向`Function`的`prototype`属性。

注意一个特例：Function`的`__proto__`属性指向`Function.prototype

```
let fn = function() {}
// 函数（包括原生构造函数）的原型对象为Function.prototype
fn.__proto__ === Function.prototype // true
Array.__proto__ === Function.prototype // true
Object.__proto__ === Function.prototype // true
```

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

**6.举一反三**

**6.1`instanceof`操作符**

`typeof`运算符判断基本类型可以，但对引用类型无法判断(函数对象会返回`function`外，其他都返回`object`)。

**关键一句话**：`instanceof`用于检查右边变量的原型存在于左边变量的原型链上。其实它表示的是一种原型链继承的关系

> MDN描述：instanceof运算符用于测试构造函数的prototype属性是否出现在对象的原型链中的任何位置

```html
instanceof`操作符左边是一个对象，右边是一个构造函数，在左边对象的原型链上查找，直到找到右边构造函数的prototype属性就返回`true`，或者查找到顶层`null`（也就是`Object.prototype.__proto__`），就返回`false
```

**实现思路：**

> 1. 首先 instanceof 左侧必须是对象, 才能找到它的原型链
> 2. instanceof 右侧必须是函数, 函数才会prototype属性
> 3. 迭代 , 左侧对象的原型不等于右侧的 prototype时, 沿着原型链重新赋值左侧

```
// 手写instanceOf-递归版本
function instanceOfMe(obj, Constructor) { // obj 表示左边的对象，Constructor表示右边的构造函数
  let leftP = obj.__proto__ // 取对象隐式原型
    let rightP = Constructor.prototype // 取构造函数显示原型
    // 到达原型链顶层还未找到则返回false
    if (leftP === null) {
        return false
    }
    // 对象实例的隐式原型等于构造函数显示原型则返回true
    if (leftP === rightP) {
        return true
    }
    // 查找原型链上一层
    return instanceOfMe(obj.__proto__, Constructor)
}
// 手写instanceOf-非递归版本
function instanceOfMe(L, R) { // L 表示左边的对象，R表示右边的构造函数
    // 验证如果为基本数据类型，就直接返回false
    const baseType = ['string', 'number','boolean','undefined','symbol']
    if(baseType.includes(typeof(L))) { return false }
    
    let RP  = R.prototype;  //取 R 的显示原型
    L = L.__proto__;       //取 L 的隐式原型
    while(true){           // 无线循环的写法（也可以使 for(;;) ）
        if(L === null){    //找到最顶层
            return false;
        }
        if(L === RP){       //严格相等
            return true;
        }
        L = L.__proto__;  //没找到继续向上一层原型链查找
    }
}
```

可以解释令人费解的现象：

```
fn instanceof Object //true
// 1. fn.__proto__ === Function.prototype
// 2. fn.__proto__.__proto__ === Function.prototype.__proto__ === Object.prototype
arr instanceof Object //true
// 1. arr.__proto__ === Array.prototype
// 2. arr.__proto__.__proto__ === Array.prototype.__proto__ === Object.prototype
Object instanceof Object // true
// 1. Object.__proto__ === Function.prototype
// 2. Object.__proto__.__proto__ === Function.prototype.__proto__ === Object.prototype
Function instanceof Function // true
// Function.__proto__ === Function.prototype
```

**6.2`Object.create`**

其实是创建对象的第三种方法，是ES5提供的，原理：将传入的对象作为原型

```
// 手写Object.create
function createObj(proto) {
    function F() {}
    F.prototype = proto
    return new F()
}
```

**6.3`new`操作符**

四件事：

1.创建一个空对象

2.把该对象的`__proto__`属性指向`Sub.prototype`

3.让构造函数里的`this`指向新对象，然后执行构造函数，

4.返回该对象

依然来模拟实现一下：

```javascript
function myNew (fun) {
  return function () {
    // 创建一个新对象且将其隐式原型指向构造函数原型
    let obj = {
      __proto__ : fun.prototype
    }
    // 执行构造函数
    fun.call(obj, ...arguments)
    // 返回该对象
    return obj
  }
}

function person(name, age) {
  this.name = name
  this.age = age
}
let obj = myNew(person)('chen', 18) // {name: "chen", age: 18}
```

**6.4Function & Object 鸡蛋问题**

不必深究，[鸡蛋问题原文](https://github.com/yygmind/blog/issues/35)

**参考**

[深入JavaScript系列（六）：原型与原型链](https://juejin.cn/post/6844903749345886216#heading-5)

[深入理解javascript原型和闭包（完结）](https://www.cnblogs.com/wangfupeng1988/p/3977924.html)

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

## JS的8种继承方案

**1.原型链继承**

继承的本质就是复制，即重写原型对象，代之以一个新类型的实例。

```js
function SuperType() {
    this.property = true;
}

SuperType.prototype.getSuperValue = function() {
    return this.property;
}

function SubType() {
    this.subproperty = false;
}

// 这里是关键，创建SuperType的实例，并将该实例赋值给SubType.prototype
SubType.prototype = new SuperType(); 

SubType.prototype.getSubValue = function() {
    return this.subproperty;
}

var instance = new SubType();
console.log(instance.getSuperValue()); // true
```

缺点：多个实例对引用类型的操作会被篡改。

```
function SuperType(){
  this.colors = ["red", "blue", "green"];
}
function SubType(){}

SubType.prototype = new SuperType();

var instance1 = new SubType();
instance1.colors.push("black");
alert(instance1.colors); //"red,blue,green,black"

var instance2 = new SubType(); 
alert(instance2.colors); //"red,blue,green,black"
```

**2.借用构造函数继承**

使用父类的构造函数来增强子类**实例**，等同于复制父类的实例给子类（不使用原型）

```js
function  SuperType(){
    this.color=["red","green","blue"];
}
function  SubType(){
    //继承自SuperType
    SuperType.call(this);
}
var instance1 = new SubType();
instance1.color.push("black");
alert(instance1.color);//"red,green,blue,black"

var instance2 = new SubType();
alert(instance2.color);//"red,green,blue"
复制代码
```

核心代码是`SuperType.call(this)`，创建子类实例时调用`SuperType`构造函数，于是`SubType`的每个实例都会将SuperType中的属性复制一份。

缺点：

- 只能继承父类的**实例**属性和方法，不能继承原型属性/方法
- 无法实现复用，每个子类都有父类实例函数的副本，影响性能

**3.组合继承**

组合上述两种方法就是组合继承。用原型链实现对**原型**属性和方法的继承，用借用构造函数技术来实现**实例**属性的继承。

```js
function SuperType(name){
  this.name = name;
  this.colors = ["red", "blue", "green"];
}
SuperType.prototype.sayName = function(){
  alert(this.name);
};

function SubType(name, age){
  // 继承属性
  // 第二次调用SuperType()
  SuperType.call(this, name);
  this.age = age;
}

// 继承方法
// 构建原型链
// 第一次调用SuperType()
SubType.prototype = new SuperType(); 
// 重写SubType.prototype的constructor属性，指向自己的构造函数SubType
SubType.prototype.constructor = SubType; 
SubType.prototype.sayAge = function(){
    alert(this.age);
};

var instance1 = new SubType("Nicholas", 29);
instance1.colors.push("black");
alert(instance1.colors); //"red,blue,green,black"
instance1.sayName(); //"Nicholas";
instance1.sayAge(); //29

var instance2 = new SubType("Greg", 27);
alert(instance2.colors); //"red,blue,green"
instance2.sayName(); //"Greg";
instance2.sayAge(); //27
复制代码
```

缺点：

- 第一次调用`SuperType()`：给`SubType.prototype`写入两个属性name，color。
- 第二次调用`SuperType()`：给`instance1`写入两个属性name，color。

实例对象`instance1`上的两个属性就屏蔽了其原型对象SubType.prototype的两个同名属性。所以，组合模式的缺点就是在使用子类创建实例对象时，其原型中会存在两份相同的属性/方法。

**4.原型式继承**

利用一个空对象作为中介，将某个对象直接赋值给空对象构造函数的原型。

```js
function object(obj){
  function F(){}
  F.prototype = obj;
  return new F();
}
复制代码
```

object()对传入其中的对象执行了一次`浅复制`，将构造函数F的原型直接指向传入的对象。

```js
var person = {
  name: "Nicholas",
  friends: ["Shelby", "Court", "Van"]
};

var anotherPerson = object(person);
anotherPerson.name = "Greg";
anotherPerson.friends.push("Rob");

var yetAnotherPerson = object(person);
yetAnotherPerson.name = "Linda";
yetAnotherPerson.friends.push("Barbie");

alert(person.friends);   //"Shelby,Court,Van,Rob,Barbie"
复制代码
```

缺点：

- 原型链继承多个实例的引用类型属性指向相同，存在篡改的可能。
- 无法传递参数

另外，ES5中存在`Object.create()`的方法，能够代替上面的object方法。

**5.寄生式继承**

核心：在原型式继承的基础上，增强对象，返回构造函数

```js
function createAnother(original){
  var clone = object(original); // 通过调用 object() 函数创建一个新对象
  clone.sayHi = function(){  // 以某种方式来增强对象
    alert("hi");
  };
  return clone; // 返回这个对象
}
复制代码
```

函数的主要作用是为构造函数新增属性和方法，以**增强函数**

```js
var person = {
  name: "Nicholas",
  friends: ["Shelby", "Court", "Van"]
};
var anotherPerson = createAnother(person);
anotherPerson.sayHi(); //"hi"
复制代码
```

缺点（同原型式继承）：

- 原型链继承多个实例的引用类型属性指向相同，存在篡改的可能。
- 无法传递参数

**6.寄生组合式继承**

结合借用构造函数传递参数和寄生模式实现继承

```js
function inheritPrototype(subType, superType){
  var prototype = Object.create(superType.prototype); // 创建对象，创建父类原型的一个副本
  prototype.constructor = subType;                    // 增强对象，弥补因重写原型而失去的默认的constructor 属性
  subType.prototype = prototype;                      // 指定对象，将新创建的对象赋值给子类的原型
}

// 父类初始化实例属性和原型属性
function SuperType(name){
  this.name = name;
  this.colors = ["red", "blue", "green"];
}
SuperType.prototype.sayName = function(){
  alert(this.name);
};

// 借用构造函数传递增强子类实例属性（支持传参和避免篡改）
function SubType(name, age){
  SuperType.call(this, name);
  this.age = age;
}

// 将父类原型指向子类
inheritPrototype(SubType, SuperType);

// 新增子类原型属性
SubType.prototype.sayAge = function(){
  alert(this.age);
}

var instance1 = new SubType("xyc", 23);
var instance2 = new SubType("lxy", 23);

instance1.colors.push("2"); // ["red", "blue", "green", "2"]
instance1.colors.push("3"); // ["red", "blue", "green", "3"]
复制代码
```

这个例子的高效率体现在它只调用了一次`SuperType` 构造函数，并且因此避免了在`SubType.prototype` 上创建不必要的、多余的属性。于此同时，原型链还能保持不变；因此，还能够正常使用`instanceof` 和`isPrototypeOf()`

**这是最成熟的方法，也是现在库实现的方法**

**7.混入方式继承多个对象**

```js
function MyClass() {
     SuperClass.call(this);
     OtherSuperClass.call(this);
}

// 继承一个类
MyClass.prototype = Object.create(SuperClass.prototype);
// 混合其它
Object.assign(MyClass.prototype, OtherSuperClass.prototype);
// 重新指定constructor
MyClass.prototype.constructor = MyClass;

MyClass.prototype.myMethod = function() {
     // do something
};
复制代码
```

`Object.assign`会把  `OtherSuperClass`原型上的函数拷贝到 `MyClass`原型上，使 MyClass 的所有实例都可用 OtherSuperClass 的方法。

**8.ES6类继承extends**

`extends`关键字主要用于类声明或者类表达式中，以创建一个类，该类是另一个类的子类。其中`constructor`表示构造函数，一个类中只能有一个构造函数，有多个会报出`SyntaxError`错误,如果没有显式指定构造方法，则会添加默认的 `constructor`方法，使用例子如下。

```js
class Rectangle {
    // constructor
    constructor(height, width) {
        this.height = height;
        this.width = width;
    }
    
    // Getter
    get area() {
        return this.calcArea()
    }
    
    // Method
    calcArea() {
        return this.height * this.width;
    }
}

const rectangle = new Rectangle(10, 20);
console.log(rectangle.area);
// 输出 200

-----------------------------------------------------------------
// 继承
class Square extends Rectangle {

  constructor(length) {
    super(length, length);
    
    // 如果子类中存在构造函数，则需要在使用“this”之前首先调用 super()。
    this.name = 'Square';
  }

  get area() {
    return this.height * this.width;
  }
}

const square = new Square(10);
console.log(square.area);
// 输出 100
复制代码
```

`extends`继承的核心代码如下，其实现和上述的寄生组合式继承方式一样

```js
function _inherits(subType, superType) {
  
    // 创建对象，创建父类原型的一个副本
    // 增强对象，弥补因重写原型而失去的默认的constructor 属性
    // 指定对象，将新创建的对象赋值给子类的原型
    subType.prototype = Object.create(superType && superType.prototype, {
        constructor: {
            value: subType,
            enumerable: false,
            writable: true,
            configurable: true
        }
    });
    
    if (superType) {
        Object.setPrototypeOf 
            ? Object.setPrototypeOf(subType, superType) 
            : subType.__proto__ = superType;
    }
}
复制代码
```

**总结**

1、函数声明和类声明的区别

函数声明会提升，类声明不会。首先需要声明你的类，然后访问它，否则像下面的代码会抛出一个ReferenceError。

```js
let p = new Rectangle(); 
// ReferenceError

class Rectangle {}
复制代码
```

2、ES5继承和ES6继承的区别

- ES5的继承实质上是先创建子类的实例对象，然后再将父类的方法添加到this上（Parent.call(this)）.
- ES6的继承有所不同，实质上是先创建父类的实例对象this，然后再用子类的构造函数修改this。因为子类没有自己的this对象，所以必须先调用父类的super()方法，否则新建实例报错。

> [《javascript高级程序设计》笔记：继承](https://link.juejin.cn?target=https%3A%2F%2Fsegmentfault.com%2Fa%2F1190000011917606)
> [MDN之Object.create()](https://link.juejin.cn?target=https%3A%2F%2Fdeveloper.mozilla.org%2Fzh-CN%2Fdocs%2FWeb%2FJavaScript%2FReference%2FGlobal_Objects%2FObject%2Fcreate)
> [MDN之Class](https://link.juejin.cn?target=https%3A%2F%2Fdeveloper.mozilla.org%2Fzh-CN%2Fdocs%2FWeb%2FJavaScript%2FReference%2FClasses)

**参考**

[JavaScript常用八种继承方案](https://juejin.cn/post/6844903696111763470#heading-3)

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
