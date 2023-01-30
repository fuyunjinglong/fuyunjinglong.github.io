---
title: ES6-10新特性
date: 2022-05-05 06:33:16
categories:
- B_JS
toc: true # 是否启用内容索引
---

# 参考

[ES6、ES7、ES8、ES9、ES10新特性](https://juejin.cn/post/6844903811622912014#heading-56)

# **链判断运算符**

ES2020引入了链判断运算符 ?. 来简化这个操作：

```
const firstName = message?.body?.user?.firstName || 'default';
```

# [let 暂时性死区详解](https://segmentfault.com/a/1190000015603779)

## 暂时性死区定义

```
注意：let和const声明定义的变量作用在当前执行上下文的词法环境中**。变量在他们的词法环境被初始化的时候被创建**，但是在变量的词法绑定被执行前他们不能被以任何形式被访问。以带有初始化器的词法绑定形式定义的变量，在词法绑定被执行的时候用他的初始化器的赋值表达式的计算结果来赋值，而不是在变量被创建的时候赋值。如果一个let声明的词法绑定没有初始化器，那么这个变量在初始化绑定被执行的时候会被用undefined赋值。
```

*ES6规定，`let/const` 命令会使区块形成封闭的作用域。若在声明之前使用变量，就会报错。*
*总之，在代码块内，使用 `let` 命令声明变量之前，该变量都是不可用的。*
*这在语法上，称为 **“暂时性死区”**（ temporal dead zone，简称 **TDZ**）。*

# 作用域与变量提升

## 作用域

作用域 (scope) 可以被理解为是标识符（变量）在程序中的可见性范围。

**作用域类型**

动态作用域：动态作用域是在代码运行时确定的，关注函数从何处调用。javascript 并不具有动态作用域，但是this机制某种程度上很像动态作用域。

静态作用域：静态作用域在函数定义时决定了，关注函数在何处声明。静态作用域又叫词法作用域，JS就是静态作用域。

**作用域种类**

ES2015 / ES6出现之前，作用域分为函数作用域和全局作用域，es6增加了块级作用域。

**作用域链**

访问变量时，如果当前作用域没有，会一级一级往上找，一直到全局作用域，这就是作用域链。

**作用域链延长**

大部分情况下，作用域链有多长主要看它当前嵌套的层数，但是有些语句可以在作用域链的前端临时增加一个变量对象，这个变量对象在代码执行完后移除，这就是作用域延长了。

能够导致作用域延长的语句有两种:`try...catch`的`catch`块和`with`语句。

## 变量提升

变量声明的提升是以变量所处的第一层词法作用域为“单位”的，即全局作用域中声明的变量会提升至全局最顶层，函数内声明的变量只会提升至该函数作用域最顶层。

说变量完全不提升是不准确的。只是 **let 和 const 所在的块级作用域变量提升后的行为跟`var`不一样，`var`是读到一个`undefined`，而块级作用域的提升行为是会制造一个暂时性死区。**

## 函数提升

有了上面变量提升的说明，函数提升理解起来就比较容易了，但较之变量提升，函数的提升还是有区别的。即：**函数提升只会提升函数声明，而不会提升函数表达式。**

```
console.log(foo1) // [Function: foo1]
foo1() // foo1
console.log(foo2) // undefined
foo2() // TypeError: foo2 is not a function
function foo1 () {
  console.log("foo1")
}
var foo2 = function () {
  console.log("foo2")
} // foo2在这里是一个函数表达式且不会被提升
```

以上代码中，函数 `foo1` 是一个函数声明，在执行前会预解析，所以会提升至全局作用域，输出函数本身。但是`foo2` 是一个表达式，是在执行阶段才进行的赋值操作，所以不能预解析。

## 小结var 和 let、const

总结一下var 和 let、const的区别：

- `var`变量会进行申明提前，在赋值前可以访问到这个变量，值是`undefined`。
- 块级作用域也有“变量提升”，但是行为跟`var`不一样，块级作用域里面的“变量提升”会形成“暂时性死区”，在申明前访问会直接报错。
- var 定义的变量可以反复去定义，let 和 const 不可以
- var 定义的变量在循环过程中无法保存，let 和 const 可以
- const 不能在 for 循环中定义，对于`for...in`和`for...of`循环是没问题的
- var声明的变量会挂载到 window 全局对象上，let 和 const 不会

# [Iterator迭代器](https://segmentfault.com/a/1190000022894514)

说`Iterator`迭代器的原因是，为后面`async/await`的文章做铺垫，因为我`async/await`是由`Generator`+`Promise`共同构成，而其中的`Generator`就是依赖于迭代器`Iterator`。

## 定义

`Iterator`迭代器就是为了解决这个问题，它提供统一的接口，为**不同的数据结构提供统一的访问机制**。(目前Map、Set、Array支持`Iterator`)。常用的`for...of`就是依赖与`Iterator`迭代器。

**核心：**

1. **`Iterator`迭代器就是一个接口方法，它为不同的数据结构提供了一个统一的访问机制**
2. **使得数据结构的成员能够按某种次序排列，并逐个被访问**

```
// 阮一峰 ECMAScript 6 入门
// 模拟next方法返回值
var it = makeIterator(['a', 'b']);

it.next() // { value: "a", done: false }
it.next() // { value: "b", done: false }
it.next() // { value: undefined, done: true }

function makeIterator(array) {
  var nextIndex = 0;
  return {
    next: function() {
      return nextIndex < array.length ?
        {value: array[nextIndex++], done: false} :
        {value: undefined, done: true}
    }
  }
}
```

上面的`makeIterator`函数，它就是一个`迭代器生成函数`，作用就是返回一个**迭代器对象**。对数组执行这个函数，就会返回该数组的**迭代器对象it**。

通过调用`next`函数，返回`value`和`done`两个属性；value属性返回当前位置的成员，done属性是一个布尔值，表示遍历是否结束，即是否还有必要再一次调用next方法；当`done`为true时，即遍历完成。

## Iterator规范

迭代器对象`it`包含一个`next()` 方法，调用`next()`方法，返回两个属性：布尔值`done`和值`value`，value的类型无限制。

要成为可迭代对象， 一个对象必须实现`@@iterator`方法。这意味着对象（或者它原型链上的某个对象）必须有一个键为`@@iterator`的属性，可通过常量 `Symbol.iterator` 访问该属性。

```
let myIterable = {
    a: 1,
    b: 2,
    c: 3
}
myIterable[Symbol.iterator] = function() {
  let self = this;
  let arr = Object.keys(self);
  let index = 0;
  return {
    next() {
      return index < arr.length ? {value: self[arr[index++]], done: false} : {value: undefined, done: true};
    }
  }
}
var it = myIterable[Symbol.iterator]();
it.next();
for(const i of myIterable) {
  console.log(i);
}
```

将`myIterable`对象添加`Symbol.iterator`属性，同时在返回的`next`方法中，添加两个属性，既让它成为了一个可迭代对象。

关键：包含一个`next()`方法，两个属性：`done`和`value`；定义一个对象的`Symbol.iterator`属性

## Iterator和Generator

`Generator`和`Promise`一样，都是提供异步编程解决方案。

Generator函数本质就是一个**普通函数**，但有2个特征：

- function关键字与函数名之间有一个星号*
- 函数内部使用yield表达式，定义不同的内部状态

```
function* helloWorldGenerator() {
  yield 'hello';
  yield 'world';
  return 'ending';
}
var hw = helloWorldGenerator();
hw.next()
// { value: 'hello', done: false }
hw.next()
// { value: 'world', done: false }
hw.next()
// { value: 'ending', done: true }
hw.next()
// { value: undefined, done: true }
```

`Generator`函数执行后，会返回一个`Iterator`对象。在`Generator`中的yield表达式，yield会记住当前代码运行的状态和位置，等在调用这串代码的时候会依次往后走。

`Iterator`（迭代器）就是一个可迭代的对象，而`Generator`（生成器）使用了yield或者生成器表达式，生成iterator对象，用一种方便的方法实现了iterator，在for循环取数据或使用next()取数据.

小结：`Generator`（生成器）可以理解为是对`Iterator`（迭代器）的一种实现

## Iterator应用

`Generator`（生成器）就是其中最典型的一个应用，当然还有其他，例如：Map、Set、Array等原生具备`Iterator`（迭代器），支持`for...of`循环。

**Obejct实现`Iterator`接口**

Object对象虽然不支持`Iterator`（迭代器），但我们可以使用`Generator`（生成器）进行包装。

```
let obj = {a: 1, b: 2, c: 3}
function* entries(obj) {
  for (let key of Object.keys(obj)) {
    yield [key, obj[key]];
  }
}
for (let [key, value] of entries(obj)) {
  console.log(key, '->', value);
}
```

# Set与Map

## Set

`Set` 本身是一个构造函数，用来生成 `Set` 数据结构。`Set` 对象允许你存储任何类型的值，但是成员的值都是唯一的，没有重复的值。

### Set 中的特殊值

`Set` 对象存储的值总是唯一的，所以需要判断两个值是否恒等。有几个特殊值需要特殊对待：

- +0 与 -0 在存储判断唯一性的时候是恒等的，所以不重复
- `undefined` 与 `undefined` 是恒等的，所以不重复
- `NaN` 与 `NaN` 是不恒等的，但是在 `Set` 中认为 `NaN` 与 `NaN` 相等，所有只能存在一个，不重复。

### Set 实例对象的方法

- `add(value)`：添加某个值，返回 `Set` 结构本身(可以链式调用)。
- `delete(value)`：删除某个值，删除成功返回 `true`，否则返回 `false`。
- `has(value)`：返回一个布尔值，表示该值是否为 `Set` 的成员。
- `clear()`：清除所有成员，没有返回值。

### 遍历方法

- `keys()`：返回键名的遍历器。
- `values()`：返回键值的遍历器。
- `entries()`：返回键值对的遍历器。
- `forEach()`：使用回调函数遍历每个成员。

### Array 和 Set 对比

- `Array` 的 `indexOf` 方法比 `Set` 的 `has` 方法效率低下
- `Set` 不含有重复值（可以利用这个特性实现对一个数组的去重）
- `Set` 通过 `delete` 方法删除某个值，而 `Array` 只能通过 `splice`。两者的使用方便程度前者更优
- `Array` 的很多新方法 `map`、`filter`、`some`、`every` 等是 `Set` 没有的（但是通过两者可以互相转换来使用）

### Set 的应用

1、`Array.from` 方法可以将 `Set` 结构转为数组。

```js
const items = new Set([1, 2, 3, 4, 5])
const array = Array.from(items)
```

2、数组去重

```js
// 去除数组的重复成员
;[...new Set(array)]
Array.from(new Set(array))
复制代码
```

3、数组的 `map` 和 `filter` 方法也可以间接用于 `Set`

```js
let set = new Set([1, 2, 3])
set = new Set([...set].map((x) => x * 2))
// 返回Set结构：{2, 4, 6}
let set = new Set([1, 2, 3, 4, 5])
set = new Set([...set].filter((x) => x % 2 == 0))
// 返回Set结构：{2, 4}
```

4、实现并集 `(Union)`、交集 `(Intersect)` 和差集

```js
let a = new Set([1, 2, 3])
let b = new Set([4, 3, 2])
// 并集
let union = new Set([...a, ...b])
// Set {1, 2, 3, 4}
// 交集
let intersect = new Set([...a].filter((x) => b.has(x)))
// set {2, 3}
// 差集
let difference = new Set([...a].filter((x) => !b.has(x)))
// Set {1}
```

### weakSet

`WeakSet` 结构与 `Set` 类似，也是不重复的值的集合。

- 成员都是数组和类似数组的对象，若调用 `add()` 方法时传入了非数组和类似数组的对象的参数，就会抛出错误。

```js
const b = [1, 2, [1, 2]]
new WeakSet(b) // Uncaught TypeError: Invalid value used in weak set
复制代码
```

- 成员都是弱引用，可以被垃圾回收机制回收，可以用来保存 DOM 节点，不容易造成内存泄漏。
- `WeakSet` 不可迭代，因此不能被用在 `for-of` 等循环中。
- `WeakSet` 没有 `size` 属性。

## Map

`Map` 中存储的是 `key-value` 形式的键值对, 其中的 `key` 和 `value` 可以是任何类型的

### Map 和 Object 的区别

1. `Object` 对象有原型， 也就是说他有默认的 `key` 值在对象上面， 除非我们使用 `Object.create(null)`创建一个没有原型的对象；
2. 在 `Object` 对象中， 只能把 `String` 和 `Symbol` 作为 `key` 值， 但是在 `Map` 中，`key` 值可以是任何基本类型(`String`, `Number`, `Boolean`, `undefined`, `NaN`….)，或者对象(`Map`, `Set`, `Object`, `Function` , `Symbol` , `null`….);
3. 通过 `Map` 中的 `size` 属性， 可以很方便地获取到 `Map` 长度， 要获取 `Object` 的长度， 你只能手动计算

### Map 对象的方法

- `set(key, val)`: 向 `Map` 中添加新元素
- `get(key)`: 通过键值查找特定的数值并返回
- `has(key)`: 判断 `Map` 对象中是否有 `Key` 所对应的值，有返回 `true`，否则返回 `false`
- `delete(key)`: 通过键值从 `Map` 中移除对应的数据
- `clear()`: 将这个 `Map` 中的所有元素删除

### 遍历方法

- `keys()`：返回键名的遍历器
- `values()`：返回键值的遍历器
- `entries()`：返回键值对的遍历器
- `forEach()`：使用回调函数遍历每个成员

### 数据类型转化

Map 转为数组

```js
let map = new Map()
let arr = [...map]
复制代码
```

数组转为 Map

```js
Map: map = new Map(arr)
复制代码
```

Map 转为对象

```js
let obj = {}
for (let [k, v] of map) {
  obj[k] = v
}
复制代码
```

对象转为 Map

```js
for( let k of Object.keys(obj)）{
  map.set(k,obj[k])
}
```

### Map的应用

Map 会保留所有元素的顺序, 是在基于可迭代的基础上构建的，如果考虑到元素迭代或顺序保留或键值类型丰富的情况下都可以使用。

下面摘抄自 vue3 源码中依赖收集的核心实现 

```js
let depsMap = targetMap.get(target)  
 if (!depsMap) {  
   targetMap.set(target, (depsMap = new Map()))  
 }  
 let dep = depsMap.get(key)  
 if (!dep) {  
   depsMap.set(key, (dep = new Set()))  
 }  
 if (!dep.has(activeEffect)) {  
   dep.add(activeEffect)  
   activeEffect.deps.push(dep)  
   ...  
 } 
```

### WeakMap

`WeakMap` 结构与 `Map` 结构类似，也是用于生成键值对的集合。

- 只接受对象作为键名（`null` 除外），不接受其他类型的值作为键名
- 键名是弱引用，键值可以是任意的，键名所指向的对象可以被垃圾回收，此时键名是无效的
- 不能遍历，方法有 `get`、`set`、`has`、`delete`

## 小结：

Set

- 是一种叫做集合的数据结构(ES6新增的)
- 成员唯一、无序且不重复
- `[value, value]`，键值与键名是一致的（或者说只有键值，没有键名）
- 允许储存任何类型的唯一值，无论是原始值或者是对象引用
- 可以遍历，方法有：`add`、`delete`、`has`、`clear`

WeakSet

- 成员都是对象
- 成员都是弱引用，可以被垃圾回收机制回收，可以用来保存 `DOM` 节点，不容易造成内存泄漏
- 不能遍历，方法有 `add`、`delete`、`has`

Map

- 是一种类似于字典的数据结构，本质上是键值对的集合
- 可以遍历，可以跟各种数据格式转换
- 操作方法有:`set`、`get`、`has`、`delete`、`clear`

WeakMap

- 只接受对象作为键名（`null` 除外），不接受其他类型的值作为键名
- 键名是弱引用，键值可以是任意的，键名所指向的对象可以被垃圾回收，此时键名是无效的
- 不能遍历，方法有 `get`、`set`、`has`、`delete`

# ES6你倒是用啊！

**1.关于获取对象属性值的吐槽**

```
const name = obj && obj.name;
复制代码
```

**吐槽**

ES6中的可选链操作符会使用么？

**改进**

```
const name = obj?.name;
```

**2.关于输入框非空的判断**

在处理输入框相关业务时，往往会判断输入框未输入值的场景。

```
if(value !== null && value !== undefined && value !== ''){
    //...
}
复制代码
```

**吐槽**

ES6中新出的空值合并运算符了解过吗，要写那么多条件吗？

```
if((value??'') !== ''){
  //...
}
```

# ES6的export&import模块化导入导出

注意：导入导出均可使用as别名

## **exports**

**1.命名导出（Named exports）**

每一个需要导出的数据类型都要有一个name，**引入的时候都需要`{}`**。除非使用*命名空间引入，才不需要{}

```js
//------ lib0.js ------
const sqrt = Math.sqrt;
function square(x) {
    return x * x;
}
export {sqrt, square}//同时导出多个方法
export {sqrt as sqrtOut, square as squareOut}//同时也支持别名导出
或者
//------ lib0.js ------
export const sqrt = Math.sqrt;//单独导出
export const square = ()=>{xx}//单独导出
-----------------------------------------------------------------------------------
//------ main.js ------
import { sqrt, square } from 'lib0'; 
import { sqrt, square } from 'lib1';
```

**2.默认导出（Default exports）**

默认导出就不需要name了，但是一个js文件中只能有一个export default，**引入的时候不需要`{}`**

> *相当于默认导出了一个名称为default的数据类型*

```js
//------ lib0.js ------
const sqrt = Math.sqrt;
const square = ()=>{xx}
export default sqrt //单独导出
或
//------ lib1.js ------
const sqrt = Math.sqrt;
const square = ()=>{xx}
export default {sqrt,square} //导出多个方法
-----------------------------------------------------------------------------------
//------ main.js ------
import sqrt from 'lib0';
或
import lib from 'lib1';
lib.sqrt
等价于
import { default as lib } from './lib1';
lib.sqrt
```

## import

**1.别名引入（Aliasing named imports）**

```js
//------ lib0.js ------
export const sqrt = Math.sqrt;//单独导出
//------ lib1.js ------
const sqrt = Math.sqrt;
export default sqrt //单独导出
---------------------------------------------------------------------------------
//------ main.js ------
import {sqrt as sqrt0} from 'lib0';//非default
import sqrt from 'lib1';//default
```

**2.命名空间引入（Namespace imports）**

当从每个模块需要引入的方法很多的时候，别名引入显得十分繁琐

```js
//------ lib0.js ------
export const sqrt = Math.sqrt;//单独导出
export const square = ()=>{xx}//单独导出
------------------------------------------------------------------------------------
//------ main.js ------
import * as coreLib0 from 'lib0';
coreLib0.sqrt//优雅
```

## 最佳实践

**1.Combinations exports (混合导出)**

> 混合导出是 `Named exports` 和 `Default exports` 组合导出。
>
> 混合导出后，默认导入一定放在命名导入前面；

```js
//------ lib0.js ------
export const sqrt = Math.sqrt;//单独导出
const square = ()=>{xx}
export default {square}
---------------------------------------------------------------
// index.js
import defaultlib0, { sqrt } from 'lib0';
defaultlib0.square;sqrt
import defaultlib0, * as all from 'lib0';
all.default.square;all.sqrt
注意：{}大括号和*不能同时存在
```

**2.Module Redirects (中转模块导出)**

创建单个模块，集中多个模块的多个导出。使用 `export from` 语法实现

```js
export { hostname, hostname2 } from './env'; // 域名
export { Api } from './api'; // 接口api
export { default as config } from './config'; // 配置
export { default as httpAxios } from './axios'; // 请求函数
```

其他如：

```js
export * from 'lib'; // 没有设置 export default
export * as myFunc2 from 'myFunc'; // 【ES2021】没有设置 export default
import { default as function1, function2 } from 'bar.js';
export { function1, function2 };
```

```js
// Empty import (for modules with side effects)
import './lib0';
```
