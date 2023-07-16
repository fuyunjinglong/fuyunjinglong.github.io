---
title: ES6-10新特性
date: 2022-05-05 06:33:16
categories:
- B_JS
toc: true # 是否启用内容索引
---

# ES新特性

## ES7新特性

- Array.prototype.includes()

**Array.prototype.includes()**

查询给定字符串是否包含一个字符

## ES8新特性

- Async/Await
- Object.values()，Object.entries()

**Async/Await**

这是JavaScript异步编程的一个重大改进，提供了在不阻塞主线程的情况下使用同步代码实现异步访问资源的能力，并且使得代码逻辑更加清晰。

**Object.values()，Object.entries()**

作为遍历一个对象的补充手段，供for...of循环使用

## ES9新特性

- for await of

**for await of**

for of方法能够遍历具有Symbol.iterator接口的同步迭代器数据，但是不能遍历异步迭代器。

for await of可以用来遍历具有Symbol.asyncIterator方法的数据结构，也就是异步迭代器，且会等待前一个成员的状态改变后才会遍历到下一个成员，相当于async函数内部的await。

## ES10新特性

- Array.prototype.flat()
- String.trimStart 和 String.trimEnd

**Array.prototype.flat()**

将多维数组打平，flat() 方法会按照一个可指定的深度递归遍历数组，并将所有元素与遍历到的子数组中的元素合并为一个新数组返回。

```
newArray = arr.flat(depth) // depth是指定要提取嵌套数组的结构深度，默认值为 1
```

**String.trimStart 和 String.trimEnd**

移除开头和结尾的空格。

trimStart() 方法从字符串的开头删除空格，trimLeft()是此方法的别名。

trimEnd() 方法从一个字符串的右端移除空白字符，trimRight 是 trimEnd 的别名。

## ES2020新特性

- 可选链操作符
- 空位合并操作符
- Promise.allSettled

**可选链操作符**

```
let nestedProp = obj && obj.first && obj.first.second;
let nestedProp = obj?.first?.second;
```

**空位合并操作符**

空位合并操作符，用 ?? 表示

```
let c = a ? a : b // 方式1
let c = a || b // 方式2
缺点：它都会覆盖所有的假值，如a(0, '', false)，这些值可能是在某些情况下有效的输入，但会执行b
```

```
let c = a ?? b;
// 等价于let c = a !== undefined && a !== null ? a : b;
```

**Promise.allSettled**

使用 Promise.all 来并发请求三个接口，如果其中任意一个接口出现异常，状态是reject,这会导致页面中该三个区域数据全都无法出来，这个状况我们是无法接受。

Promise.allSettled跟Promise.all类似, 其参数接受一个Promise的数组, 返回一个新的Promise, **唯一的不同在于, 它不会进行短路**, 也就是说当Promise全部处理完成后,我们可以拿到每个Promise的状态, 而不管是否处理成功。

## ES2021/ES12新特性

候选提案

- String.prototype.replaceAll()
- Promise.any
- 逻辑运算符和赋值表达式
- 数值分隔符
- WeakRef and Finalizers

**Promise.any**

Promise.any() 接收一个Promise可迭代对象，只要其中的一个 promise 成功，就返回那个已经成功的 promise。

`Promise.any()`跟`Promise.race()`方法很像，只有一点不同，就是不会因为某个 `Promise` 变成rejected状态而结束。

# 箭头函数与普通函数区别

参考

- [ES6 - 箭头函数、箭头函数与普通函数的区别](https://juejin.cn/post/6844903805960585224#heading-0)

区别：

- 语法更加简洁、清晰
- 箭头函数不会创建自己的this
- 箭头函数继承而来的this指向在定义时指定后，永远不变
- .call()/.apply()/.bind()无法改变箭头函数中this的指向
- 箭头函数不能作为构造函数使用
- 箭头函数没有自己的arguments
- 箭头函数没有原型prototype
- 箭头函数不能用作Generator函数，不能使用yeild关键字

# 扩展运算符

- 替代apply方法，一般在函数调用时处理参数
- 剩余参数(rest运算符)，主要针对函数形参
- 数据连接、合并
- 数组和对象的拷贝
- 字符串转数组

替代apply方法，一般在函数调用时处理参数

```
function addFun(x, y, z) {
    return x + y + z;
}
var args = [1, 2, 3];
// 用apply方法直接传递数组
addFun.apply(null, args);
// 替代apply的扩展运算符
addFun(...args);
```

剩余参数(rest运算符)，主要针对函数形参

```
function(argA, ...args){
 //
}
```

数据连接、合并

```
// ES5 合并
var es5Arr = arr1.concat(arr2);
// ES6 合并
var es6Arr = [...arr1, ...arr2];
```

数组和对象的拷贝

```
var arr1 = [1, 2, 3];
var arr2 = [...arr1];
```

字符串转数组

```
var str = 'hello';
// ES5 处理方式
var es5Arr = str.split('');
// ES6 处理方式
var es6Arr = [...str];
```

# **链判断运算符**

ES2020引入了链判断运算符 ?. 来简化这个操作：

```
const firstName = message?.body?.user?.firstName || 'default';
```

# let

**暂时性死区定义**

[let 暂时性死区详解](https://segmentfault.com/a/1190000015603779)

```
注意：let和const声明定义的变量作用在当前执行上下文的词法环境中。变量在他们的词法环境被初始化的时候被创建，但是在变量的词法绑定被执行前他们不能被以任何形式被访问。以带有初始化器的词法绑定形式定义的变量，在词法绑定被执行的时候用他的初始化器的赋值表达式的计算结果来赋值，而不是在变量被创建的时候赋值。如果一个let声明的词法绑定没有初始化器，那么这个变量在初始化绑定被执行的时候会被用undefined赋值。
```

*ES6规定，`let/const` 命令会使区块形成封闭的作用域。若在声明之前使用变量，就会报错。*
*总之，在代码块内，使用 `let` 命令声明变量之前，该变量都是不可用的。*
*这在语法上，称为 **“暂时性死区”**（ temporal dead zone，简称 **TDZ**）。*

**一、作用域**

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

**二、变量提升**

变量声明的提升是以变量所处的第一层词法作用域为“单位”的，即全局作用域中声明的变量会提升至全局最顶层，函数内声明的变量只会提升至该函数作用域最顶层。

说变量完全不提升是不准确的。只是 **let 和 const 所在的块级作用域变量提升后的行为跟`var`不一样，`var`是读到一个`undefined`，而块级作用域的提升行为是会制造一个暂时性死区。**

**三、函数提升**

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

**小结var 和 let、const**

总结一下var 和 let、const的区别：

- `var`变量会进行申明提前，在赋值前可以访问到这个变量，值是`undefined`。
- 块级作用域也有“变量提升”，但是行为跟`var`不一样，块级作用域里面的“变量提升”会形成“暂时性死区”，在申明前访问会直接报错。
- var 定义的变量可以反复去定义，let 和 const 不可以
- var 定义的变量在循环过程中无法保存，let 和 const 可以
- const 不能在 for 循环中定义，对于`for...in`和`for...of`循环是没问题的
- var声明的变量会挂载到 window 全局对象上，let 和 const 不会

# for 循环中的 var 、let 与 const 区别

> - var具有函数作用域，因此在for循环内定义的迭代变量会渗透到for循环外面。根据事件循环机制，先执行同步再异步，当5次循环结束后，i的值为5，i渗透到for循环外部
>
> - let声明的迭代变量i不能渗透到for循环外面，因此可以认为是，声明了5个块级作用域。可以认为每个for都是独立的作用域块。
>
>   ```
>   {let i = 0;setTimeout(()=>console.log(i),0);}
>   ```

```
//使用var声明for循环中的迭代变量
for(var i = 0;i < 5;++ i){
setTimeout(()=>console.log(i),0);
}
// 5,5,5,5,5

//使用let声明for循环中的迭代变量
for(let i = 0;i < 5;++ i){
setTimeout(()=>console.log(i),0);
}
// 0,1,2,3,4
```

# 声明变量的六种方法

- ES5 只有两种声明变量的方法：var 和 function 。
- ES6 除了添加 let 和 const 命令。
- 还有两种声明变量的方法：import 命令和 class 命令。

# 数组的扩展

**reduce累加器**

var total = [ 0, 1, 2, 3 ].reduce(( acc, cur ) => {    return acc + cur }, 0);

**every一假即假**

const flag=[ 0, 1, 2, 3 ].every(ele=> {    return ele>3 });

**some一真即真**

const flag=[ 0, 1, 2, 3 ].some(ele=> {    return ele>3 });

# Set

`Set` 本身是一个构造函数，用来生成 `Set` 数据结构。`Set` 对象允许你存储任何类型的值，但是成员的值都是唯一的，没有重复的值。

**Set 中的特殊值**

`Set` 对象存储的值总是唯一的，所以需要判断两个值是否恒等。有几个特殊值需要特殊对待：

- +0 与 -0 在存储判断唯一性的时候是恒等的，所以不重复
- `undefined` 与 `undefined` 是恒等的，所以不重复
- `NaN` 与 `NaN` 是不恒等的，但是在 `Set` 中认为 `NaN` 与 `NaN` 相等，所有只能存在一个，不重复。

**Set 实例对象的方法**

- `add(value)`：添加某个值，返回 `Set` 结构本身(可以链式调用)。
- `delete(value)`：删除某个值，删除成功返回 `true`，否则返回 `false`。
- `has(value)`：返回一个布尔值，表示该值是否为 `Set` 的成员。
- `clear()`：清除所有成员，没有返回值。

**遍历方法**

- `keys()`：返回键名的遍历器。
- `values()`：返回键值的遍历器。
- `entries()`：返回键值对的遍历器。
- `forEach()`：使用回调函数遍历每个成员。

**Array 和 Set 对比**

- `Array` 的 `indexOf` 方法比 `Set` 的 `has` 方法效率低下
- `Set` 不含有重复值（可以利用这个特性实现对一个数组的去重）
- `Set` 通过 `delete` 方法删除某个值，而 `Array` 只能通过 `splice`。两者的使用方便程度前者更优
- `Array` 的很多新方法 `map`、`filter`、`some`、`every` 等是 `Set` 没有的（但是通过两者可以互相转换来使用）

**Set 的应用**

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

**weakSet**

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

# Map

`Map` 中存储的是 `key-value` 形式的键值对, 其中的 `key` 和 `value` 可以是任何类型的

**Map 和 Object 的区别**

1. `Object` 对象有原型， 也就是说他有默认的 `key` 值在对象上面， 除非我们使用 `Object.create(null)`创建一个没有原型的对象；
2. 在 `Object` 对象中， 只能把 `String` 和 `Symbol` 作为 `key` 值， 但是在 `Map` 中，`key` 值可以是任何基本类型(`String`, `Number`, `Boolean`, `undefined`, `NaN`….)，或者对象(`Map`, `Set`, `Object`, `Function` , `Symbol` , `null`….);
3. 通过 `Map` 中的 `size` 属性， 可以很方便地获取到 `Map` 长度， 要获取 `Object` 的长度， 你只能手动计算

**Map 对象的方法**

- `set(key, val)`: 向 `Map` 中添加新元素
- `get(key)`: 通过键值查找特定的数值并返回
- `has(key)`: 判断 `Map` 对象中是否有 `Key` 所对应的值，有返回 `true`，否则返回 `false`
- `delete(key)`: 通过键值从 `Map` 中移除对应的数据
- `clear()`: 将这个 `Map` 中的所有元素删除

**遍历方法**

- `keys()`：返回键名的遍历器
- `values()`：返回键值的遍历器
- `entries()`：返回键值对的遍历器
- `forEach()`：使用回调函数遍历每个成员

**数据类型转化**

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

**Map的应用**

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

**WeakMap**

`WeakMap` 结构与 `Map` 结构类似，也是用于生成键值对的集合。

- 只接受对象作为键名（`null` 除外），不接受其他类型的值作为键名
- 键名是弱引用，键值可以是任意的，键名所指向的对象可以被垃圾回收，此时键名是无效的
- 不能遍历，方法有 `get`、`set`、`has`、`delete`

# Set、WeakSet 、Map、WeakMap 比较

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

**weakset 和 weakmap**

ES6 考虑到防止内存泄漏，推出了两种新的数据结构： weakset 和 weakmap 。他们对值的引用都是不计入垃圾回收机制的，也就是说，如果其他对象都不再引用该对象，那么垃圾回收机制会自动回收该对象所占用的内存。

```
const wm = new WeakMap()const element = document.getElementById('example') vm.set(element, 'something') vm.get(element)
```

上面代码中，先新建一个 Weakmap 实例。然后，将一个 DOM 节点作为键名存入该实例，并将一些附加信息作为键值，一起存放在 WeakMap 里面。这时，WeakMap 里面对 element 的引用就是弱引用，不会被计入垃圾回收机制。

注册监听事件的 listener 对象很适合用 WeakMap 来实现。

```
// 代码1
ele.addEventListener('click', handler, false)// 
代码2
const listener = new WeakMap() 
listener.set(ele, handler) 
ele.addEventListener('click', listener.get(ele), false)
```

代码 2 比起代码 1 的好处是：由于监听函数是放在 WeakMap 里面，一旦 dom 对象 ele 消失，与它绑定的监听函数 handler 也会自动消失。

**小结：**

Set、Map、WeakSet、WeakMap、都是一种集合的数据结构

Set 和 WeakSet 是一种值-值的集合，且元素唯一不重复

Map 和 WeakMap 是一种键-值对的集合，Map 的键可以是任意类型，WeakMap 的键只能是对象类型。

Set 和 Map可遍历，WeakSet 和 WeakMap不可遍历

WeakSet 和 WeakMap 键名所指向的对象，不计入垃圾回收机制

# Symbol

ES6引入了一种新的原始数据类型Symbol，表示**独一无二的值**。

基本数据类型有6种：Undefined、Null、布尔值（Boolean）、字符串（String）、数值（Number）、对象（Object）。

`Symbol`函数前不能使用`new`命令，否则会报错。这是因为生成的Symbol是一个原始类型的值，不是对象。

```
// 没有参数的情况
var s1 = Symbol();
var s2 = Symbol();
s1 === s2 // false

// 有参数的情况
var s1 = Symbol("foo");
var s2 = Symbol("foo");
s1 === s2 // false
```

**1)应用场景1：使用Symbol来作为对象属性名(key)**

```
const PROP_NAME = Symbol()
const PROP_AGE = Symbol()

let obj = {
  [PROP_NAME]: "一斤代码"
}
obj[PROP_AGE] = 18
obj[PROP_NAME] // '一斤代码'
obj[PROP_AGE] // 18
```

Symbol类型的key是不能通过`Object.keys()`或者`for...in`来枚举的，它未被包含在对象自身的属性名集合(property names)之中。所以，利用该特性，我们可以把一些不需要对外操作和访问的属性使用Symbol来定义。

也正因为这样一个特性，当使用`JSON.stringify()`将对象转换成JSON字符串的时候，Symbol属性也会被排除在输出内容之外。

```
let obj = {
   [Symbol('name')]: '一斤代码',
   age: 18,
   title: 'Engineer'
}

Object.keys(obj)   // ['age', 'title']

for (let p in obj) {
   console.log(p)   // 分别会输出：'age' 和 'title'
}

Object.getOwnPropertyNames(obj)   // ['age', 'title']
JSON.stringify(obj)  // {"age":18,"title":"Engineer"}
```

还是会有一些专门针对Symbol的API

```
// 使用Object的API
Object.getOwnPropertySymbols(obj) // [Symbol(name)]

// 使用新增的反射API
Reflect.ownKeys(obj) // [Symbol(name), 'age', 'title']
```

**2)应用场景2：使用Symbol来替代常量**

```
const TYPE_AUDIO = Symbol()
const TYPE_VIDEO = Symbol()
const TYPE_IMAGE = Symbol()

function handleFileResource(resource) {
  switch(resource.type) {
    case TYPE_AUDIO:
      playAudio(resource)
      break
    case TYPE_VIDEO:
      playVideo(resource)
      break
    case TYPE_IMAGE:
      previewImage(resource)
      break
    default:
      throw new Error('Unknown type of resource')
  }
}
```

**3)应用场景3：使用Symbol定义类的私有属性/方法**

在JavaScript中，是没有如Java等面向对象语言的访问控制关键字`private`的，类上所有定义的属性或方法都是可公开访问的。因此这对我们进行API的设计时造成了一些困扰。

而有了`Symbol`以及`模块化机制`，类的私有属性和方法才变成可能。例如：

```
a.js
const PASSWORD = Symbol()

class Login {
  constructor(username, password) {
    this.username = username
    this[PASSWORD] = password
  }

  checkPassword(pwd) {
      return this[PASSWORD] === pwd
  }
}

export default Login
```

```
b.js
import Login from './a'

const login = new Login('admin', '123456')

login.checkPassword('admin')  // true

login.PASSWORD  // oh!no!
login[PASSWORD] // oh!no!
login["PASSWORD"] // oh!no!
```

**4)Symbol.for()，Symbol.keyFor()**

**Symbol.for**机制有点类似于单例模式，首先在全局中搜索有没有以该参数作为名称的Symbol值，如果有，就返回这个Symbol值，否则就新建并返回一个以该字符串为名称的Symbol值。和直接的Symbol就点不同了。

```
var s1 = Symbol.for('foo');
var s2 = Symbol.for('foo');

s1 === s2 // true
```

**Symbol.keyFor**方法返回一个已登记的Symbol类型值的key。实质就是检测该Symbol是否已创建

```
var s1 = Symbol.for("foo");
Symbol.keyFor(s1) // "foo"

var s2 = Symbol("foo");
Symbol.keyFor(s2) // undefined
```

# Iterator迭代器

说`Iterator`迭代器的原因是，为后面`async/await`的文章做铺垫，因为我`async/await`是由`Generator`+`Promise`共同构成，而其中的`Generator`就是依赖于迭代器`Iterator`。

**一、定义**

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

**二、Iterator规范**

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

**三、Iterator和Generator**

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

**四、Iterator应用**

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

**参考**

[弄懂!!ES6中的Iterator迭代器](https://segmentfault.com/a/1190000022894514)

# Generator函数是什么

Generator 是ES6引入的新语法，Generator是一个可以暂停和继续执行的函数。Generator函数是将函数分步骤阻塞 ，只有主动调用next() 才能进行下一步 。

简单的用法，可以当做一个Iterator来用，进行一些遍历操作。复杂一些的用法，他可以在内部保存一些状态，成为一个状态机。

```
Generator 基本语法包含两部分：函数名前要加一个星号；函数内部用 yield 关键字返回值。
yield，表达式本身没有返回值，或者说总是返回undefined。
next，方法可以带一个参数，该参数就会被当作上一个yield表达式的返回值。
```

```
function * foo(x) {
  var y = 2 * (yield (x + 1));
  var z = yield (y / 3);
  return (x + y + z);

}

var b = foo(5); 
b.next() // { value:6, done:false }
b.next(12) // { value:8, done:false } 
b.next(13) // { value:42, done:true }

```

# async函数是什么

asyns函数是Generator函数的语法糖。

相当于自执行的Generator函数，相当于自带一个状态机，在await的部分等待返回， 返回后自动执行下一步。而且相较于Promise,async的优越性就是把每次异步返回的结果从then中拿到最外层的方法中，不需要链式调用，只要用同步的写法就可以了。

但是async必须以一个Promise对象开始 ，所以async通常是和Promise结合使用的。

async 对应的是 * 。

await 对应的是 yield 。

async/await 自动进行了 Generator 的流程控制。

**为什么Async/Await更好？**

1. 使用async函数可以让代码简洁很多，不需要像Promise一样需要些then，不需要写匿名函数处理Promise的resolve值，也不需要定义多余的data变量，还避免了嵌套代码。
2. 错误处理：Async/Await 让 try/catch 可以同时处理同步和异步错误。

# for in、for of、forEach的比较

**1.for…of与for…in的区别**

- for…in循环会遍历（当前对象及其原型上的）每一个**属性名称**。
- for…of只能应用于**可迭代对象**，循环遍历（当前对象上的）每一个属性值.

**2.forEach**

是数组的一个方法，用于遍历数组的每一项，没有返回值，返回值总是undefined。

**3.for…of**

ES6提出的语句，在**可迭代对象**（Array，Map，Set，String，TypedArray，arguments）上创建一个迭代循环。

```
//遍历数组
let array = [10,20];
for(let val of array){
    console.log(val);
}
// 10
// 20

//遍历字符串
let str = "bo";
for(let val of str){
    console.log(val);
}
// "b"
// "o"

//遍历map
let map = new Map([["a", 1], ["b", 2], ["c", 3]]);
for(let entry of map){
    console.log(entry);
}
// ["a", 1]
// ["b", 2]
// ["c", 3]

for(let [key,value] of map){
    console.log(value);
}
// 1
// 2
// 3

//遍历set
let set = new Set([1,1,2,2,3,3]);
for(let value of set){
    console.log(value);
}
// 1
// 2
// 3

//遍历DOM
let divs = document.querySelectorAll("div");
for(let div of divs){
    div.className = "red";
}

//遍历生成器
function* fibonacci(){
    let [prev,curr] = [0,1];
    for(;;){
        [prev,curr] = [curr,curr+prev];
        yield curr;
    }
}

for(let n of fibonacci()){
    if(n>1000) break;
    console.log(n);
}
```

**4.for…in**

for…in 语句以任意顺序遍历**一个对象的可枚举属性的属性名**。所有可枚举属性和从它原型继承而来的可枚举属性，因此如果想要仅迭代对象本身的属性，要结合hasOwnProperty（）来使用

```
var obj = {a:1, b:2, c:3};
for(var prop in obj){
    console.log(prop);
}
//a
//b
//c

var obj= {
a:1,
[Symbol('level')]:2
}
Reflect.ownKeys(obj) // 遍历所有属性，包括Symbol
```

# ES5和ES6之默认值的区别 ？

**ES5**

- 使用三目运算符判断

```
function doSomething (name) {
  name = name === undefined ? 'default name' : name
}
```

**ES6**

- 普通值入参，直接赋值默认值

- 对象入参，fun({a}={}),使用空对象

- 针对必填参数，可添加函数

  ```
  function requireParams () {
    throw new Error('required params')
  }
  function doSomething (name = requireParams(), age = 18) {
    // do something
  }
  ```

# ES5和ES6之继承的区别 ？

- ES5的继承通过寄生组合式继承来实现。`ES5 的继承实质上是先创建子类的实例对象，然后再将父类的方法添加到this上（Parent.apply(this)）`。
- `ES6 的继承机制完全不同，实质上是先创建父类的实例对象this（所以必须先调用父类的 super()方法），然后再用子类的构造函数修改 this`。

**ES5 寄生组合式继承**

ES5的继承，实质上是先创造子类的实例对象this，然后再将父类的方法添加到子类（this）上面。

所以，

> **es5的写法不能继承原生构造函数**（比如Array、Number等） 因为es5的继承是先创造子类的实例对象this，再将父类原型的属性和方法重写到子类上，因为没法访问父类的内部属性，导致**es5的继承方式无法继原生的构造函数**。

<img src="/img/image-20230614063858609.png" alt="image-20230614063858609" style="zoom:50%;" />

**ES6 extend继承**

参考

- [廖雪峰的原型继承](https://www.liaoxuefeng.com/wiki/1022910821149312/1023021997355072)
- [ES6类以及继承的实现原理](https://segmentfault.com/a/1190000014798678)
- [ES6下babel如何编译Class](https://www.aligoogle.net/pages/25e63f/#%E4%BA%94-babel-%E7%BC%96%E8%AF%91)

ES6的继承机制完全不同，实质上是先创造父类的实例对象this，并将父类的属性和方法放到this上（前提是通过super函数调用），然后再用子类的构造函数修改this。

所以，

>  es6允许继承构造函数生成子类。因为es6是先创建父类的实例对象this，然后再用子类的构造函数修饰，所以子类就可以继承父类的所有属性和方法。因此**class可以继承并自定义原生构造函数的子类**。extends不仅可以用来继承类，还能用来继承原生构造函数，因此也就可以在原生数据结构的基础上，构造自定义的数据结构。

<img src="/img/image-20230614063939130.png" alt="image-20230614063939130" style="zoom:50%;" />

**ES6继承核心源码**

bable编译Class文件后的代码：

```
var Child = function(_Parent) {
    _inherits(Child, _Parent);// 核心
    function Child(name, age) {
        _classCallCheck(this, Child);
        // 调用父类的 constructor(name)
        var _this = _possibleConstructorReturn(this, (Child.__proto__ || Object.getPrototypeOf(Child)).call(this, name));
        _this.age = age;
        return _this;
    }

    return Child;
}(Parent);
```

其中核心是_inherits：

```
function _inherits(subClass, superClass) {
    // extend 的继承目标必须是函数或者是 null
    if (typeof superClass !== "function" && superClass !== null) {
        throw new TypeError("Super expression must either be null or a function, not " + typeof superClass);
    }
    // 代码1，类似于 ES5 的寄生组合式继承，使用 Object.create，设置子类 prototype 属性的 __proto__ 属性指向父类的 prototype 属性
    subClass.prototype = Object.create(superClass && superClass.prototype, { constructor: { value: subClass, enumerable: false, writable: true, configurable: true } });

    // 代码2，设置子类的 __proto__ 属性指向父类
    if (superClass) Object.setPrototypeOf ? Object.setPrototypeOf(subClass, superClass) : subClass.__proto__ = superClass;
}
```

_inherits通俗理解：

- 代码1：保证了`c instanceof Parent`是true,Child的实例可以访问到父类的属性，包括内部属性，以及原型属性。

<img src="/img/image-20230614064228077.png" alt="image-20230614064228077" style="zoom:50%;" />

- 代码2：子类能访问到父类的静态方法

```
// 代码1翻译下就是
function F(){}
F.prototype = superClass.prototype
subClass.prototype = new F()
subClass.prototype.constructor = subClass
简写为一行代码是：subClass.prototype.__proto__ = superClass.prototype

// 代码2翻译下就是：
function A(){}
var a = new A()
a.__proto__ = A.prototype
// a是一个实例，A.prototype是构造方法的原型。通过这种方式，那么a就可以访问A.prototype上面的方法。
// 那把 subClass类比成 a，superClass类比成A.prototype，那是不是subClass可以直接访问 superClass的静态属性，静态方法了。
```

# Module模块化语法

注意：导入导出均可使用as别名

参考

- [「万字进阶」深入浅出 Commonjs 和 Es Module](https://juejin.cn/post/6994224541312483336)
- [深入 CommonJs 与 ES6 Module](https://link.juejin.cn/?target=https%3A%2F%2Fsegmentfault.com%2Fa%2F1190000017878394)
- [「Node.js系列」深入浅出Node模块化开发——CommonJS规范](https://juejin.cn/post/6892786383249735687)

```
/**
 * 导出
 */
export * from 'module'; //重定向导出 不包括 module内的default
export { name1, name2, ..., nameN } from 'module'; // 重定向命名导出
export { import1 as name1, import2 as name2, ..., nameN } from 'module'; // 重定向重命名导出
export { name1, name2, …, nameN }; // 与之前声明的变量名绑定 命名导出
export { variable1 as name1, variable2 as name2, …, nameN }; // 重命名导出
export let name1 = 'name1'; // 声明命名导出 或者 var, const，function， function*, class
export default expression; // 默认导出
export default function () { ... } // 或者 function*, class
export default function name1() { ... } // 或者 function*, class

/**
 * 导入
 */
import defaultExport from "module"; // 默认导入
import { a, b, c } from "module"; //解构导入
import defaultExport, { a, b, c as newC } from "module"; //混合导入
import * as name from "module"; //混合导入
var promise = import("module"); //动态导入(异步导入)
```

**一、exports**

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

**二、import**

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

**三、最佳实践**

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

# 参考

[ES6、ES7、ES8、ES9、ES10新特性](https://juejin.cn/post/6844903811622912014#heading-56)