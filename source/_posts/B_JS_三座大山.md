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

## 作用域

**一、定义**
作用域是指代码中定义变量的区域，它决定了变量的可访问性和生命周期。简单来说，作用域就是一套规则，用于确定在何处以及如何查找变量（标识符）。如果查找失败，通常会报 `ReferenceError`。

**二、作用域的类型：**
JavaScript主要包含以下三种作用域：

- **全局作用域：** 在任何函数、代码块（`{}`）之外声明的变量。它们在代码的任何地方都可以被访问。
- **函数作用域：** 在函数内部声明的变量。它们只能在函数内部被访问，外部无法直接访问。`var` 声明的变量就具有函数作用域。
- **块级作用域：** 在代码块（如 `if`、`for`、`while`、`try/catch` 以及直接使用 `{}`）内部声明的变量。`let` 和 `const` 声明的变量具有块级作用域，这弥补了 `var` 的不足。

**三、工作原理 - 作用域链：**
当代码在一个环境中执行时，会创建一个变量对象的一个作用域链。这个作用域链保证了对执行环境有权访问的所有变量和函数的有序访问。

- **查找规则：** 当访问一个变量时，JavaScript引擎会首先在当前作用域中查找。如果找不到，就会沿着作用域链向上一级作用域查找，直到找到该变量或到达全局作用域。如果在全局作用域中仍未找到，就会抛出 `ReferenceError`。
- **词法作用域（静态作用域）：** JavaScript采用的是词法作用域。这意味着函数的作用域在函数**定义**的时候就已经确定了，而不是在调用的时候。无论函数在哪里被调用，它的作用域链都基于它被定义时的位置。

## 闭包

**1.定义**

闭包是**能够访问其外部函数作用域中变量的内部函数**。**本质是函数与其词法作用域的绑定组合。**

JavaScript引擎通过将闭包所需变量存储在堆内存（而非栈）中，避免函数调用后作用域被销毁。

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

**2.为什么需要闭包**

局部变量无法共享和长久保存，而全局变量可能造成变量污染。**闭包一句话**：长久保存变量，又不会造成全局污染。

**闭包的优缺点**

优点：

- 读取函数内部的变量
- 让这些变量的值始终保持在内存中
- 方便调用上下文的局部变量，利于代码封装

缺点：滥用闭包导致内存泄漏，能不用尽量不用，及时释放内存。（闭包会加深作用域链，加长变量查找时间）

**3.闭包的常用场景**

> - **数据封装与模拟私有变量：** 如上面的计数器例子，`count` 变量对外部是不可见的，只能通过返回的函数来操作，这实现了数据的私有化和封装
> - **柯里化：** 将一个接受多个参数的函数变换为一系列接受单个参数的函数。
> - **函数防抖和节流：** 这些优化技术通常依赖闭包来保存定时器和上一次执行的时间戳等状态。
> - **模块化模式：** 可以用闭包来创建模块，暴露公共API，隐藏内部实现细节。这是许多现代模块系统的基础思想。
> - **回调函数和事件监听器：** 在异步操作或事件处理中，经常需要访问外部作用域的变量，闭包是实现这一点的重要机制。

**4.闭包题**

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

```
// 奇葩的闭包面试题
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

> `new` 做了四件事：
>
> 1. 创建一个全新的空对象。
> 2. 将这个新对象的 `__proto__` 指向函数的 `prototype`。
> 3. **将函数的 `this` 绑定到这个新对象上，并执行函数代码。**
> 4. 如果函数没有返回其他对象，则自动返回这个新对象。

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

**为什么要有 this？**

> 一句话：this 的存在是为了让一个函数能在不同的对象上下文中复用，而不需要把对象显式地当做参数传来传去。

```js
// 本质：this 就是一个隐形的第 0 号参数
obj.foo(arg1, arg2);
// 引擎在底层其实是这样运行的：
foo.call(obj, arg1, arg2);
```

**四大核心规则**

一句话：`this` 永远指向最后调用它的那个对象。（箭头函数除外)

> - 规则一：默认绑定（独立调用）
> - 规则二：隐式绑定（作为对象方法调用）
> - 规则三：显式绑定（call/apply/bind）
> - 规则四：new 绑定

1.默认绑定（独立调用）

> 场景：函数没有任何修饰符，直接被调用。比如 foo()。
>
> 规则：
>
> - 在非严格模式下，`this` 绑定到全局对象（浏览器是 `window`，Node 是 `global`）。
> - 在严格模式下，`this` 绑定到 `undefined`。

```js
var a = 10; // var 声明会挂载到 window 上
function foo() {
  console.log(this.a);
}
foo(); // 10 (非严格模式，this -> window)

function bar() {
  "use strict";
  console.log(this);
}
bar(); // undefined (严格模式)
```

2.规则二：隐式绑定（作为对象方法调用）

> 场景：函数作为某个对象的方法被调用。比如 obj.foo()。
>
> 规则：this 绑定到调用该函数的对象（即点前面的那个对象）。如果存在多层引用，只看最后一层。

```js
var a = 100;

const obj = {
  a: 2,
  foo: function() {
    console.log(this.a);
  }
};

obj.foo(); // 2 (this 指向 obj)

// 多层引用：只看最后一层
const obj2 = { a: 3, obj: obj };
obj2.obj.foo(); // 2 (最后一层是 obj，this 指向 obj)
```

⚠️ 致命陷阱：隐式丢失

```js
// 当把对象的方法赋值给一个变量，或者作为回调函数传递时，会发生隐式丢失，this 会回退到默认绑定。
var a = '全局';
const obj = {
  a: '对象内',
  foo: function() { console.log(this.a); }
};

// 赋值给变量
const fn = obj.foo; 
fn(); // '全局' (fn 直接调用，没有对象修饰，默认绑定 window)

// 作为回调函数
setTimeout(obj.foo, 100); // '全局' (相当于把函数交给 setTimeout 执行，也是独立调用)
```

3.规则三：显式绑定（call/apply/bind）

> 场景：我们不希望 this 随便乱跑，想强行指定 this 指向谁。
>
> 规则：使用 call、apply 或 bind 强行把 this 绑定到指定的对象上。
>
> - call(thisArg, arg1, arg2)：立即执行，参数列表。
> - apply(thisArg, [argsArray])：立即执行，参数数组。
> - bind(thisArg, arg1)：不立即执行，而是返回一个硬绑定了新 this 的新函数。

```js
const obj1 = { name: 'obj1' };
const obj2 = { name: 'obj2' };

function foo() {
  console.log(this.name);
}

foo.call(obj1); // 'obj1'
foo.apply(obj2); // 'obj2'

// bind 的硬绑定
const boundFoo = foo.bind(obj1);
boundFoo.call(obj2); // 'obj1' (bind 一旦绑定，死都不会变)
```

4.规则四：new 绑定

> 场景：使用 new 关键字调用函数（构造函数）。

**一个例外-箭头函数（ES6）**

> 箭头函数是 this 规则中的法外狂徒，它根本不遵守以上四条规则。
>
> 规则：
>
> - 箭头函数没有自己的 this。
> - 它的 this 是在定义时决定的，继承自外层第一个普通函数的 this（词法作用域）。
> - 箭头函数的 this 一旦确定，用 call/apply/bind 也无法改变。

```js
var name = 'window';

const obj = {
  name: 'obj',
  foo: function() {
    // 这里的 this 指向 obj (普通函数规则二)
    const innerFunc = () => {
      // 箭头函数，继承外层 foo 的 this，也指向 obj
      console.log(this.name); 
    };
    innerFunc();
  },
  bar: () => {
    // 箭头函数，外层没有普通函数，只能继承全局作用域的 this (window)
    console.log(this.name);
  }
};

obj.foo(); // 'obj'
obj.bar(); // 'window'
```

**一套优先级机制**

> 箭头函数 > new 绑定 > 显式绑定 > 隐式绑定 > 默认绑定

证明一下 `new` 和 `bind` 的冲突：

```js
// 注：虽然 new 的优先级高于 bind，但 new 不能和 call/apply 一起使用，所以这个优先级主要针对 bind。
function foo(age) {
  this.age = age;
}

const obj = {};
const boundFoo = foo.bind(obj); // 显式绑定到 obj

// new 的优先级比 bind 高！
const instance = new boundFoo(25); 

console.log(obj.age);    // undefined (obj 没有被改变)
console.log(instance.age); // 25 (this 指向了 new 创建的新对象)
```

判断this的总流程

> - 看是不是箭头函数:直接找**定义时**外层普通函数的 `this` 是谁，它就是谁。（死规矩，任何调用方式都改变不了）
> - 普通函数，按优先级从高到低找（命中即止）
>   - 有 new？ 👉 指向新创建的实例对象。
>   - 有 call/apply/bind？ 👉 指向绑定的对象。（注意：绑了 null/undefined 无效，往下走）
>   - 有对象调用（obj.fn()）？ 👉 指向点前面的对象。（注意：赋值给变量后再调用算丢失，往下走）
>   - 直接裸调（fn()）？ 👉 严格模式指向 undefined，非严格模式指向 window。

**实战**

实战 1：对象嵌套与箭头函数

```js
var a = 1;
const obj = {
  a: 2,
  foo: () => {
    console.log(this.a);
  },
  bar: function() {
    const inner = () => console.log(this.a);
    inner();
  }
};

obj.foo(); // ? 
obj.bar(); // ?
```

解析：

obj.foo()：foo 是箭头函数，外层没有普通函数，this 指向 window。输出 1。
obj.bar()：bar 是普通函数，this 指向 obj；inner 是箭头函数，继承 bar 的 this，也指向 obj。输出 2。

## call、apply、bind 的区别

> - 都是 Function 原型上的方法，作用是改变函数内部 this 的指向
> - 执行时机不同（call/apply 立即执行，bind 返回新函数）
> - 传参形式不同（call 逐个传，apply 数组传，bind 逐个传且可合并）

| 方法      | 执行时机       | 传参方式                       | 返回值                                 | 常用场景                                |
| :-------- | :------------- | :----------------------------- | :------------------------------------- | --------------------------------------- |
| **call**  | **立即执行**   | 逐个传递 `(arg1, arg2, ...)`   | 函数的执行结果                         | 借数组方法处理类数组比如 arguments      |
| **apply** | **立即执行**   | 数组传递 `([arg1, arg2, ...])` | 函数的执行结果                         | 求 Math.max 处理数组                    |
| **bind**  | **不立即执行** | 逐个传递 `(arg1, arg2, ...)`   | 返回原函数的拷贝，且 `this` 被永久绑定 | 在 React 类组件或者回调里防止 this 丢失 |

**应用场景**

> call
>
> - 类数组转数组： Array.prototype.slice.call(arguments) （或 [].slice.call(arguments)）
> - 借用构造函数实现继承： 子类构造函数中调用 Parent.call(this, args)，实现属性继承。
>
> apply
>
> - 数学极值： Math.max.apply(null, [1, 2, 3]) （因为 Math.max 不支持接收数组，apply 刚好可以展开数组）
> - 数组合并： Array.prototype.push.apply(arr1, arr2) （比 concat 性能好，因为直接修改原数组不产生新数组）
>
> bind
>
> - 防丢 this： React 类组件中绑定事件 this.handleClick = this.handleClick.bind(this)；或者在定时器/回调函数中保存当前上下文。
> - 函数柯里化（偏函数）： function add(a, b) { return a+b }, const add5 = add.bind(null, 5)，预先传入部分参数。

**手写实现（区分度最高，必考）**

手写call

```js
Function.prototype.myCall = function(context, ...args) {
  // 1. 处理 context 为 null 或 undefined 的情况，默认指向 window
  context = context || window;
  // 2. 创建一个唯一的 key，防止覆盖原对象属性
  const fnKey = Symbol('fn');
  // 3. 将调用的函数作为 context 的属性（this 就是当前调用的函数）
  context[fnKey] = this;
  // 4. 执行函数并保存结果
  const result = context[fnKey](...args);
  // 5. 删除临时属性，恢复原样
  delete context[fnKey];
  // 6. 返回结果
  return result;
}
```

手写bind（核心考点：支持柯里化 + 当作构造函数 new 时 this 失效）

```js
Function.prototype.myBind = function(context, ...bindArgs) {
  // 保存原函数
  const fn = this;
  
  // 返回的新函数
  const boundFn = function(...callArgs) {
    // 关键点：如果 boundFn 被 new 调用，this 应该指向实例，而不是传入的 context
    // 判断是否是 new 调用：this instanceof boundFn
    return fn.apply(this instanceof boundFn ? this : context, [...bindArgs, ...callArgs]);
  }
  
  // 关键点：维持原型链，保证 new 出来的实例能访问原函数的原型
  boundFn.prototype = Object.create(fn.prototype);
  
  return boundFn;
}
```

# 三大山-异步与事件循环

面试答题模板：

> **异步与事件循环**：多刷输出顺序题，真正理解“微任务优先”的底层调度逻辑，告别回调地狱（掌握 `Promise` 和 `async/await`）。

## JS异步编程六大方案

演变历程是从**回调函数** -> **Promise** -> **Generator** -> **Async/Await**

> - **回调函数**是基础，但容易产生回调地狱。
> - **Promise** 解决了链式调用和错误管理问题。
> - **Generator** 提供了暂停执行的能力，但需要手动执行器。
> - **Async/Await** 是目前最主流、最优雅的方案，它结合了 Generator 的同步写法和 Promise 的自动执行特性，是我们在实际开发中的首选。
> - 事件监听
> - 发布订阅

**回调函数**
致命的弱点，就是容易写出回调地狱（Callback hell）。

- 优点：简单、容易理解和实现
- 缺点：不利于代码的阅读和维护，各个部分之间高度耦合，使得程序结构混乱、流程难以追踪

```
ajax(url, () => {
    // 处理逻辑
})
```

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

**事件监听**

这种方式下，异步任务的执行不取决于代码的顺序，而取决于某个事件是否发生。

- 优点：比较容易理解，可以绑定多个事件，每个事件可以指定多个回调函数，而且可以"去耦合"，有利于实现模块化。
- 缺点：整个程序都要变成事件驱动型，运行流程会变得很不清晰。阅读代码的时候，很难看出主流程。

**发布订阅**

我们假定，存在一个"信号中心"，某个任务执行完成，就向信号中心"发布"（publish）一个信号，其他任务可以向信号中心"订阅"（subscribe）这个信号，从而知道什么时候自己可以开始执行。这就叫做"发布/订阅模式"（publish-subscribe pattern），又称"观察者模式"（observer pattern）。

- 优点：与“事件监听”类似，但是明显优于后者。因为可以通过查看“消息中心”，了解存在多少信号、每个信号有多少订阅者，从而监控程序的运行。

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
