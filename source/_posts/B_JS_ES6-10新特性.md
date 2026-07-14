---
title: ES6-10新特性
date: 2022-05-05 06:33:16
categories:
- B_JS
toc: true # 是否启用内容索引
---

# 大纲

- JavaScript ES(6-11)全版本语法

# 初级

## ES6(2015)-ES17(2026)新特性

- ES6：let/const、解构、模板字符串、箭头函数、扩展/剩余、Symbol、Set/Map、迭代器/生成器、Promise、Class、Module。
- ES7：includes、 幂运算。
- ES8：async/await、Object.values/entries、padStart/padEnd、getOwnPropertyDescriptors。
- ES9：对象展开/剩余、for await…of、Promise.finally、正则增强。
- ES10：flat/flatMap、fromEntries、trimStart/End、Symbol.description、可选 catch、matchAll、sort 稳定。
- ES11：?. 可选链、?? 空值合并、BigInt、Promise.allSettled、globalThis、动态 import()。
- ES12：replaceAll、Promise.any、逻辑赋值、数字分隔符、WeakRefs。
- ES13：类字段/私有、顶层 await、at、Object.hasOwn、Error cause。
- ES14：toSorted/toReversed/toSpliced/with、findLast/LastIndex、#!、Symbol 做 WeakMap 键
- ES15：Object.groupBy/Map.groupBy、Promise.withResolvers、正则 /v、Atomics.waitAsync、String.isWellFormed/toWellFormed
- ES16：迭代器助手、Set 方法（union/intersection/difference/symmetricDifference/isSubsetOf/isSupersetOf/isDisjointFrom）、Promise.try、JSON 模块与导入属性、Float16Array
- ES17：Map.getOrInsert/getOrInsertComputed、Error.isError。

## for 循环中的var/let/const

一句话：在 `for` 循环中，`var`、`let` 和 `const` 的核心区别在于**作用域机制**、**变量提升**以及**每次循环迭代是否创建新的变量绑定**。

简单来说，`var` 会引发闭包陷阱，`let` 完美解决该问题，而 `const` 在普通 `for` 循环中会报错，但可用于 `for...of/in`。

**1. `var` —— 函数作用域与共享绑定**

- **作用域**：`var` 声明的变量是函数作用域（或全局作用域），没有块级作用域。
- **变量提升**：存在变量提升，在声明前访问值为 `undefined`。
- **循环表现**：在传统的 `for` 循环中，`var i` 在整个循环过程中只声明了一次，所有迭代共用同一个 `i`。
- **闭包陷阱**：如果在循环体内有异步执行（如 `setTimeout`），因为闭包捕获的是同一个 `i` 的引用，当异步任务执行时，循环已经结束，`i` 已经变成了最终值，导致输出全部是同一个值。

**2. `let` —— 块级作用域与每次迭代新绑定**

- **作用域**：`let` 声明的变量是块级作用域，只在当前 `{}` 内有效。
- **暂时性死区（TDZ）**：不存在变量提升，在声明前访问会报错 `ReferenceError`。
- **循环表现**：这是 `let` 在 `for` 循环中最关键的特性。**JS 引擎会在每次循环迭代时，为 `let` 声明的变量创建一个新的绑定**。相当于每次循环都会复制一份当前的 `i` 值给本次迭代。
- **闭包表现**：由于每次迭代都有独立的 `i` 绑定，循环内的异步闭包捕获到的是各自独立的状态，从而能正确输出预期的 0, 1, 2… 序列。

**3. `const` —— 块级作用域与不可变绑定**

- **作用域与死区**：同 `let` 一样，具有块级作用域和暂时性死区。

- **不可变性**：`const` 声明的变量不能被重新赋值。

- 循环表现（分情况）

  ：

  - **传统的 `for` 循环**：由于 `i++` 试图修改 `const` 变量，会直接抛出 `TypeError: Assignment to constant variable.` 报错，因此**不能**用于传统 `for` 循环。
  - **`for...of` 或 `for...in` 循环**：**可以使用**。因为在这类循环中，每次迭代都会在新的块级作用域中声明一个新的 `const` 变量，不存在修改同一个变量值的情况。非常适合遍历不需要修改的数组或对象元素。

**代码示例佐证（实战演示）**

为了更直观地展示，我用代码说明 `var` 和 `let` 在闭包中的区别：

```js
// 1. var 的闭包陷阱
for (var i = 0; i < 3; i++) {
  setTimeout(() => console.log(i), 0);
}
// 输出：3, 3, 3 
// 原因：共享同一个 i，异步执行时 i 已变成 3

// 2. let 的完美解决
for (let i = 0; i < 3; i++) {
  setTimeout(() => console.log(i), 0);
}
// 输出：0, 1, 2
// 原因：每次迭代生成新的块级作用域，闭包保留了当前的 i

// 3. const 在普通 for 循环中报错
for (const i = 0; i < 3; i++) {
  console.log(i); 
}
// 输出：0，然后报错：TypeError: Assignment to constant variable.

// 4. const 在 for...of 中正常使用
const arr = ['a', 'b', 'c'];
for (const item of arr) {
  console.log(item); 
}
// 输出：a, b, c （每次迭代 item 都是新的 const 变量）
```

## for...in、for...of和forEach

一句话：**他们在设计初衷、适用对象以及中断机制**有显著区别。

- **`for...in`**：遍历对象的原型链上的**可枚举属性名（键名/索引）**，主要用于对象，也可数组(不推荐，如果数组挂载了自定义属性，也会遍历出来)，支持中断
- **`for...of`**：遍历**可迭代对象的值**，主要用于数组、字符串、Map、Set 等，支持中断
- **`forEach`**：数组原型上的方法，遍历数组的**值**，不支持中断

```js
for (let key in obj) {
    if(obj.hasOwnProperty(key)){
      // 仅遍历自身key
     console.log(key, obj[key]); // 输出: a 1, b 2   
    }
}

for (let value of arr) {
  console.log(value);
  if (value === 20) break; // 支持中断
}

obj.forEach(...) 
```

中断：for...in和for...of

> `break`：跳出整个循环，循环语句后面的代码还会执行。
>
> `continue`：跳过本次循环，进入下一次。
>
> `return`：跳出整个循环，循环语句后面的代码不再执行。

中断：forEach

> `break` / `continue`：会直接代码报错
>
> `return`：只会跳过本次循环，进入下一次
>
> `抛出异常`：跳出整个循环(不推荐，建议用some、find替代)

```js
const arr = [1, 2, 3, 4, 5];
try {
    arr.forEach((item) => {
        if (item === 3) {
            throw new Error('停止循环'); // 抛出异常强制停止
        }
    });
} catch (e) {
    // 捕获异常，防止代码报错中断
    if (e.message !== '停止循环') throw e;
}
```

## Symbol、Map、Set三种常用的数据类型

**一、 Symbol**

- **一句话解释**：ES6 引入的**原始数据类型**，表示独一无二的值。
- **核心特性**：每次创建都唯一；作为对象属性时不可枚举（`for...in`、`JSON.stringify`无法读取）。
- 常用 API 与场景：
  - `Symbol('desc')`：创建唯一值。
  - `Symbol.for('key')`：全局复用同一个 Symbol。
  - **场景**：消除魔法字符串、防止对象属性名冲突、定义对象的私有属性/迭代器（`Symbol.iterator`）。

**二、 Set**

- **一句话解释**：类似数组的集合，核心特点是**成员唯一、自动去重**。
- **核心特性**：内部使用 `SameValueZero` 算法去重（`NaN` 视为相等）；无索引；`has` 查找时间复杂度接近 O(1)。
- 常用 API 与场景：
  - `add`、`delete`、`has`、`clear`、`size`。
  - **场景**：数组去重（`[...new Set(arr)]`）、字符串去重([...new Set(str)].join(''))、高频数据查重。

**三、 Map**

- **一句话解释**：**键值对（Hash）集合**，类似对象，但键可以是任意类型。
- **核心特性**：任何类型（对象、函数、基本类型等）均可作键；严格保持插入顺序；频繁增删性能优于 Object。
- 常用 API 与场景：
  - `set`、`get`、`has`、`delete`、`size`。
  - **场景**：将 DOM 节点或复杂对象作为键存储数据，避免数据污染；需要有序且高频增删的键值对缓存。

**一句话总结**：
`Symbol` 解决属性冲突；`Set` 解决去重与高效查重；`Map` 解决键类型限制与高频增删的性能问题。

## 模块化规范

一句话：服务端用 CommonJS，浏览器端早期用 AMD/CMD，现在全面拥抱官方的 ES Modules。ESM 的静态声明特性也直接推动了 Webpack/Vite 等工具的 Tree-shaking（摇树优化）能力，是目前的绝对主流。

1. **CommonJS (CJS)**
   - **代表**：Node.js
   - **特点**：同步加载（`require` 导入，`module.exports` 导出）；在**运行时**加载；输出的是**值的拷贝**。
   - **场景**：服务端（文件都在本地，同步加载无影响）。
2. **AMD / CMD**
   - **代表**：AMD (RequireJS) / CMD (SeaJS)
   - **特点**：专为浏览器端设计的**异步加载**规范。AMD 依赖前置（提前执行），CMD 依赖就近（按需执行）。
   - **现状**：随着打包工具的普及，目前已基本被淘汰。
3. **ES Modules (ESM)**
   - **代表**：ES6 官方标准
   - **特点**：静态模块（`import` 导入，`export` 导出）；在**编译时**确定依赖关系（支持 Tree-shaking）；输出的是**值的引用**（模块内部变化会影响外部）。
   - **场景**：现代前端开发的通用标准（浏览器端与Node.js均支持）。

| 特性             | ES6 Modules (ESM)              | CommonJS (CJS)             |
| :--------------- | :----------------------------- | :------------------------- |
| **加载机制**     | **静态**（编译时确定依赖关系） | **动态**（运行时加载）     |
| **输出值**       | **值的引用**（只读动态绑定）   | **值的拷贝**（缓存输出值） |
| **this 指向**    | 顶层 `this` 指向 `undefined`   | 顶层 `this` 指向模块本身   |
| **Tree Shaking** | **支持**（因静态分析）         | 不支持（难以静态分析）     |

## ES6 Export和Import

**1. 开场白（简述概念）**

ES6 Modules（ESM）是 JavaScript 官方的模块化标准，通过 `export` 导出模块接口，通过 `import` 导入模块。它取代了之前的 CommonJS（Node.js）和 AMD（RequireJS），成为现代前端开发（如 React、Vue、Webpack/Vite 环境）通用的模块化方案。

**2. 核心语法回顾**

- **命名导出：**

  ```js
      // utils.js
      export const add = (a, b) => a + b;
      export const sub = (a, b) => a - b;
      // 或者统一导出
      // export { add, sub };
  ```

- **默认导出：**

  ```js
      // App.js
      export default class App { ... }
  ```

- **导入：**

  ```js
      import { add, sub } from './utils'; // 命名导入
      import App from './App';            // 默认导入
      import * as Utils from './utils';   // 命名空间导入（作为对象）
  ```

**3. 最佳实践（核心重点）**

在实际项目开发中，为了保证代码的可维护性、构建效率和可读性，遵循“优先命名导出、规范导入顺序、避免通配符导入”等最佳实践：

- **优先使用命名导出**
  - **原因**：命名导出能提供更好的 IDE 智能提示和自动补全，便于代码重构（重命名时 IDE 能自动更新引用），且有利于 Tree Shaking（摇树优化），去除未使用的代码，减小打包体积。
  - **避免**：滥用默认导出，因为它可能导致导入时的命名不一致，且不利于静态分析。
- **统一、清晰的导入顺序**
  - 遵循 ESLint 插件（如eslint-plugin-import）推荐的顺序，通常分为三组，组与组之间用空行隔开：
    1. **第三方库**（如 `import React from 'react'`）
    2. **内部绝对路径**（如 `import { Button } from '@/components'`）
    3. **相对路径**（如 `import styles from './App.css'`）
  - 这样可以让依赖关系一目了然。
- **使用路径别名**
  - 在构建工具中配置别名（如 `@` 指向 `src` 目录），避免使用冗长的相对路径（如 `../../../utils/helper`），提高代码可读性和可移植性。
- **杜绝“通配符”导入**
  - **避免**：`import * as Utils from './utils'`。
  - **原因**：这会导入整个模块，即使你只使用其中一个函数。这会阻碍 Tree Shaking，增加打包体积。应明确导入需要的方法：`import { add } from './utils'`。
- **仅导入副作用**
  - 如果只是为了执行全局代码（如注入样式、初始化 polyfill），而不引入任何变量，可以直接写入路径： import './styles/global.css';

- **导出原则**
  - 文件过大时拆分模块，保持“高内聚，低耦合”。
  - 如果一个模块主要只导出一个功能（如工具类函数或组件），可以使用默认导出；如果导出多个工具函数，务必使用命名导出。

**4.代码示例**

```js
// 1. 第三方库
import React, { useState, useEffect } from 'react';
import { useHistory } from 'react-router-dom';

// 2. 内部组件/工具 (使用别名)
import { Button, Modal } from '@/components/ui';
import { formatDate, validateEmail } from '@/utils/helpers';

// 3. 相对路径 (样式、静态资源、类型)
import styles from './UserProfile.module.css';
import type { User } from './types';

// ... 组件逻辑 ...
```



## ES6 Class

**1. 开场白（简述概念）**
ES6 的 `class` 是一种语法糖，它基于 ES5 的原型链和构造函数实现，提供了更清晰、更接近传统面向对象语言的写法，主要用于定义对象模板和实现继承。

**2. 核心特性**

- **本质**：依然是函数，底层逻辑是原型链。
- **继承**：通过 `extends` 关键字实现，语法简洁。
- **方法**：类内部定义的方法自动挂载到 `prototype` 上。
- **静态**：支持 `static` 关键字定义静态方法/属性。
- **严格模式**：类体内部默认开启严格模式。
- **无提升**：类声明不存在变量提升（存在 TDZ）。

**3. 与 ES5 构造函数的区别**

| 特性         | ES5 构造函数            | ES6 Class                |
| :----------- | :---------------------- | :----------------------- |
| **定义**     | `function`              | `class`                  |
| **方法挂载** | 手动挂载 `prototype`    | 自动挂载 `prototype`     |
| **继承**     | 复杂（借用构造+原型链） | `extends` + `super` 简洁 |
| **严格模式** | 默认非严格              | **默认严格**             |
| **变量提升** | 函数提升                | **不提升** (TDZ)         |

**4. 关键语法**

```js
// 基本定义与继承
class Parent {
  constructor(name) {
    this.name = name;
  }
  say() { console.log(this.name); }
}

class Child extends Parent {
  constructor(name, age) {
    super(name); // 必须先调用 super,调用父类构造函数
    this.age = age;
  }
}
```

**5. 优缺点**

- **优点**：写法简洁、语义清晰、继承方便、支持私有属性 `#`。
- **缺点**：需 Babel 转译兼容旧浏览器，灵活性略低于原型操作。

## ES5和ES6函数默认值的区别

**1. 语法表现形式**

- **ES5**：没有原生语法，需在函数体内部手动处理，通常用 `y = y || 'default'`。
- **ES6**：原生支持，直接在参数列表中赋值，如 `function fn(x, y = 'default')`，代码更简洁。

**2. 触发默认值的逻辑（最核心区别）**

- **ES5（有坑）**：使用 `||` 时，只要参数是**假值**（如 `0`、`false`、`''`、`null`），就会触发默认值。这会导致传入有效的 `0` 被错误覆盖。
- **ES6（精准）**：只有参数严格等于 `undefined` 时，才会触发默认值。如果传入 `0` 或 `false`，会正常使用传入的值。

**3. 惰性求值（ES6特性）**

- **ES6**：如果默认值是一个表达式或函数调用，只有当参数确实缺失（为 `undefined`）时，表达式才会执行；如果传了参数，表达式根本不运行。

```js
// ES5: 遇到假值 0 会误判
function es5(x, y) {
  y = y || 'default';
  console.log(y);
}
es5(1, 0); // 输出 'default' (错误)

// ES6: 只有 undefined 才触发
function es6(x, y = 'default') {
  console.log(y);
}
es6(1, 0);       // 输出 0 (正确)
es6(1, undefined); // 输出 'default'
```

## ES5和ES6继承的区别

一句话：ES5 和 ES6 继承的核心区别在于**语法表现形式**、**实例对象的构建顺序**以及**静态方法的继承机制**。ES6 的 `class/extends` 本质上是 ES5 寄生组合式继承的语法糖，但底层逻辑更严谨。

**1. 语法形式**

- **ES5**：通过构造函数和原型链配合实现（最完善的是寄生组合式继承），代码冗长且手动维护原型链容易出错。
- **ES6**：引入了 `class` 和 `extends` 关键字，提供了更接近传统面向对象语言的语法，语义清晰，代码简洁。

**2. `this` 的构建顺序（最核心的区别）**

- **ES5**：先创建子类自己的实例对象 `this`，然后在子类构造函数中通过 `Parent.call(this)` 将父类的属性和方法挂载到这个 `this` 上。
- **ES6**：底层机制不同，它是**先创建父类的实例对象 `this`，然后再用子类的构造函数去修改 `this`**。因此，ES6 规定子类必须在 `constructor` 中调用 `super()`，否则 `this` 无法生成会直接报错。

**3. 静态方法/属性的继承**

- **ES5**：构造函数本身挂载的方法（静态方法）默认**不会**被继承，需要开发者手动处理（如 `Child.__proto__ = Parent`）。
- **ES6**：`extends` 关键字会**自动**将父类的静态方法和静态属性继承给子类，不需要额外写代码。

简单代码对比：

```js
// --- ES5 寄生组合继承 ---
function Parent(name) { this.name = name; }
Parent.prototype.say = function() { console.log(this.name); };

function Child(name, age) {
  Parent.call(this, name); // 继承属性
  this.age = age;
}
// 继承方法
Child.prototype = Object.create(Parent.prototype);
Child.prototype.constructor = Child;

// --- ES6 class 继承 ---
class Parent {
  constructor(name) { this.name = name; }
  say() { console.log(this.name); }
}

class Child extends Parent {
  constructor(name, age) {
    super(name); // 必须调用 super，且在 this 之前
    this.age = age; 
  }
}
```

**总结**：
ES6 的继承虽然是语法糖，但不仅写法更优雅，还通过强制要求 `super()` 调用，规范了对象的实例化顺序，并自动处理了静态方法的继承。现代开发中，应完全使用 ES6 的 `class` 和 `extends` 来实现继承。

# 中级

## Generator 函数

Generator 函数是 ES6 提供的一种**异步编程解决方案**。语法上在 `function` 关键字后加星号（`function*`），内部使用 `yield` 表达式。它最大的特点是**可以暂停执行和恢复执行**。执行 Generator 函数不会立即执行函数体，而是返回一个**迭代器对象**，通过调用该对象的 `next()` 方法来逐步推进执行。

**核心特征**

> 1. **分段执行与交出执行权**
>    普通函数是一气呵成执行到底，而 Generator 遇到 `yield` 表达式会暂停执行，并将紧随其后的表达式的值作为返回对象的 `value`，同时 `done` 属性标记为 `false`。只有再次调用 `next()` 才会继续往下执行，实现了执行权的交接。
> 2. **双向数据流**
>    不仅可以向外输出数据（`yield` 后面的值），还可以向内传入数据。`next(arg)` 方法的参数 `arg` 会作为**上一个被暂停的 `yield` 表达式的返回值**，从而实现内外部数据的双向通信。
> 3. **符合迭代器协议**
>    因为它返回的对象实现了 `next()` 方法，所以它是一个合法的迭代器。这意味着我们可以直接使用 `for...of` 循环遍历它，或者使用扩展运算符 `...` 将其转为数组，而不需要手动一直调用 `next()`。

```js
function* myGenerator() {
  console.log('开始执行');
  // 遇到 yield 暂停，向外部返回 'A'
  let a = yield 'A'; 
  console.log('接收外部传入的:', a); 
  // 再次遇到 yield 暂停，向外部返回 'B'
  yield 'B';
  return 'C'; // 函数执行完毕
}

const gen = myGenerator();

console.log(gen.next());      // 打印: '开始执行'，输出: { value: 'A', done: false }
console.log(gen.next('传给a')); // 打印: '接收外部传入的: 传给a'，输出: { value: 'B', done: false }
console.log(gen.next());      // 输出: { value: 'C', done: true }

// 符合迭代器协议，可使用 for...of
// for (let val of myGenerator()) { console.log(val); } // 输出: A, B (遇到 done: true 自动停止，不含 return 的值)
```

Generator 的主要价值在于：

1. **异步流程控制（最重要）**：在 `async/await` 出现之前，Generator 常配合 Promise（如 `co` 库）实现“用同步的写法处理异步操作”。事实上，`async/await` 本质上就是 Generator 函数的语法糖（`async` 相当于 `*`，`await` 相当于 `yield`）。
2. **自定义迭代器**：为任何复杂的数据结构提供按需计算、惰性求值的遍历接口。
3. **状态机**：利用 `yield` 天然的暂停特性，可以非常优雅地实现状态机逻辑。

现代业务代码中很少直接手写 Generator 来处理异步，但理解它是深入掌握 `async/await` 和前端异步编程演进的必经之路。

## async函数

本质上是 Generator 函数的语法糖，通过配合 `await` 关键字，**让异步代码看起来像同步代码一样执行**，彻底解决了传统 Promise 链式调用（`.then`）导致的代码冗长和嵌套问题。

**核心特征**

> 1. **返回值永远是 Promise**
>    无论 `async` 函数内部 `return` 的是什么（普通值、对象，甚至不 return），引擎都会自动将它包装成一个 `Promise` 对象返回。如果 return 的是一个 Promise，则会直接返回该 Promise。
> 2. **`await` 暂停与等待机制**
>    `await` 只能在 `async` 函数内部使用。它会暂停当前 `async` 函数的执行，等待右侧的 Promise 决议。
>    - 如果 Promise 变为 `resolved`，`await` 表达式返回其结果。
>    - 如果 Promise 变为 `rejected`，会抛出异常。
>    - 注意：`await` 只是暂停函数内部的执行，**不会阻塞主线程**，此时主线程会交出控制权继续执行其他任务。
> 3. **错误处理更友好**
>    相比于 Promise 需要在末尾使用 `.catch()`，`async` 函数可以直接使用传统的 `try...catch` 结构包裹 `await` 语句来捕获异常，符合开发者直觉。

## Reflect

**1. 一句话总结**

`Reflect` 是一个内置的全局对象，它提供了一系列用于拦截和操作 JavaScript 对象的静态方法。它的方法与 `Proxy` 的处理器方法一一对应，并且它不能被实例化（`new Reflect()` 会报错），只能通过静态方法调用。

**2. 诞生的背景与目的**

在 ES6 之前，JS 对象的内部方法（如 `[[Get]]`、`[[Set]]`）并没有统一暴露给开发者，操作对象有时依赖 `Object` 上的方法，有时依赖操作符（如 `in`、`delete`）。引入 `Reflect` 的主要目的有三个：

1. **统一语言内部方法：** 将原本散落在 `Object` 上或作为操作符的方法，统一挂载到 `Reflect` 上，使其成为正规的函数式方法调用（如 `Reflect.has` 替代 `in`，`Reflect.deleteProperty` 替代 `delete`）。
2. **规范返回值：** 修改一些不合理的方法返回值。比如 `Object.defineProperty` 在失败时会抛出错误，而 `Reflect.defineProperty` 失败时只会返回 `false`，便于用 `if` 语句进行错误处理。
3. **配合 Proxy 使用：** 提供与 `Proxy` 拦截器同名的方法，方便在拦截操作后，优雅地恢复默认行为。

**3. 核心 API 概览**

`Reflect` 提供了 13 个静态方法，与 `Proxy` 的拦截操作一一对应，常用的有：

- **属性操作：** `Reflect.get(target, propKey, receiver)`、`Reflect.set(target, propKey, value, receiver)`
- **属性判断：** `Reflect.has(target, propKey)`、`Reflect.ownKeys(target)`
- **属性删除：** `Reflect.deleteProperty(target, propKey)`
- **函数调用与构造：** `Reflect.apply(target, thisArg, argumentsList)`、`Reflect.construct(target, argumentsList)`
- **对象扩展与拦截：** `Reflect.defineProperty(target, propKey, attributes)`、`Reflect.getPrototypeOf(target)` 等。

**4. 典型应用场景与代码示例**

**场景一：与 Proxy 完美配合（保留默认行为）**
在 `Proxy` 拦截器中，如果我们拦截了某些操作，又希望该操作继续执行，最规范的做法是调用 `Reflect` 对应的方法，而不是直接操作原始对象。

```js
const target = { name: '前端面试' };
const handler = {
  get(target, key, receiver) {
    console.log(`获取了 ${key} 属性`);
    // 推荐做法：通过 Reflect 转发操作，而不是直接 return target[key]
    return Reflect.get(target, key, receiver); 
  },
  set(target, key, value, receiver) {
    console.log(`设置了 ${key} 属性为 ${value}`);
    return Reflect.set(target, key, value, receiver);
  }
};
const proxy = new Proxy(target, handler);
proxy.name; // 输出：获取了 name 属性
```

**场景二：解决 Proxy 中 getter 的 this 指向问题（进阶考点）**
`Reflect.get` 的第三个参数 `receiver` 非常关键。当原始对象存在 getter，且通过 Proxy 访问时，传入 `receiver` 可以保证 getter 内部的 `this` 指向 Proxy 实例，而不是原始对象。

```js
const obj = {
  foo: 1,
  get bar() { return this.foo; } // 这里的 this 决定了返回谁的 foo
};

const proxy = new Proxy(obj, {
  get(target, key, receiver) {
    // 如果不传 receiver，this 指向 obj，后续拦截 obj.foo 会失效
    return Reflect.get(target, key, receiver); 
  }
});

const child = Object.create(proxy);
child.foo = 2;
console.log(child.bar); // 输出 2，因为 receiver 保证了 this 指向 child
```

**场景三：函数式调用替代老旧语法**

- 用 `Reflect.has(obj, 'a')` 替代 `'a' in obj`
- 用 `Reflect.deleteProperty(obj, 'a')` 替代 `delete obj.a`
- 用 `Reflect.apply(fn, obj, args)` 替代 `Function.prototype.apply.call(fn, obj, args)`（更整洁）

**5. 总结**

在开发中，`Reflect` 很少单独使用，它统一内部方法，更规范返回，其中最大的价值在于**配合 `Proxy` 实现响应式系统或数据劫持**（例如 Vue 3 的 reactive 实现就大量使用了 `Reflect`），并完美解决 `this` 指向问题。

# 高级

## 手写 Promise

**核心：**

> 1. **核心状态机**（状态与值的维护）
> 2. **执行器逻辑**（`executor` 的立即执行与错误捕获）
> 3. **then 方法**（回调订阅与发布、链式调用、值穿透与错误冒泡）

**1. 核心架构与状态机**

首先定义 Promise 的三种状态，并在构造函数中初始化状态和回调队列。因为同一个 Promise 可以被 `then` 多次，所以需要用数组来保存成功的回调和失败的回调。

```js
const PENDING = 'pending';
const FULFILLED = 'fulfilled';
const REJECTED = 'rejected';

class MyPromise {
  constructor(executor) {
    // 初始状态
    this.status = PENDING;
    // 成功的值
    this.value = undefined;
    // 失败的原因
    this.reason = undefined;
    // 成功回调队列
    this.onFulfilledCallbacks = [];
    // 失败回调队列
    this.onRejectedCallbacks = [];

    // 成功函数
    const resolve = (value) => {
      if (this.status === PENDING) {
        this.status = FULFILLED;
        this.value = value;
        // 状态确定后，执行所有缓存的成功回调
        this.onFulfilledCallbacks.forEach(fn => fn());
      }
    };

    // 失败函数
    const reject = (reason) => {
      if (this.status === PENDING) {
        this.status = REJECTED;
        this.reason = reason;
        // 状态确定后，执行所有缓存的失败回调
        this.onRejectedCallbacks.forEach(fn => fn());
      }
    };

    // 立即执行 executor，捕获抛出的异常
    try {
      executor(resolve, reject);
    } catch (error) {
      reject(error);
    }
  }
}
```

**2. then 方法的实现（核心难点）**

`then` 方法需要处理以下逻辑：

- **参数默认值**：实现 `catch` 的值穿透和错误冒泡。
- **异步处理**：利用 `setTimeout` 模拟微任务（实际 Promise 用的是微任务，这里用宏任务模拟异步表现）。
- **链式调用**：`then` 必须返回一个新的 `MyPromise`。
- **返回值解析**：处理 `then` 回调返回普通值或返回一个新的 `Promise` 的情况。

```js
class MyPromise {
  // ... 前面的 constructor 代码省略 ...

  then(onFulfilled, onRejected) {
    // 处理参数默认值，实现值穿透
    onFulfilled = typeof onFulfilled === 'function' ? onFulfilled : v => v;
    // 处理错误冒泡，让错误能一直传递到 catch
    onRejected = typeof onRejected === 'function' ? onRejected : e => { throw e; };

    // then 返回一个新的 Promise 以支持链式调用
    let promise2 = new MyPromise((resolve, reject) => {
      // 封装微任务执行逻辑
      const handleFulfilled = () => {
        // 用 setTimeout 模拟微任务
        setTimeout(() => {
          try {
            let x = onFulfilled(this.value);
            // 解析 then 回调返回的值 x
            this.resolvePromise(promise2, x, resolve, reject);
          } catch (error) {
            reject(error);
          }
        }, 0);
      };

      const handleRejected = () => {
        setTimeout(() => {
          try {
            let x = onRejected(this.reason);
            this.resolvePromise(promise2, x, resolve, reject);
          } catch (error) {
            reject(error);
          }
        }, 0);
      };

      if (this.status === FULFILLED) {
        handleFulfilled();
      } else if (this.status === REJECTED) {
        handleRejected();
      } else {
        // 如果是 PENDING 状态，将回调推入队列，等待 resolve/reject 触发
        this.onFulfilledCallbacks.push(handleFulfilled);
        this.onRejectedCallbacks.push(handleRejected);
      }
    });

    return promise2;
  }

  // 处理 then 返回值的 Promise 解析过程
  resolvePromise(promise2, x, resolve, reject) {
    // 1. 防止循环引用
    if (promise2 === x) {
      return reject(new TypeError('Chaining cycle detected for promise #<MyPromise>'));
    }

    // 2. 如果 x 是对象或函数（可能是 Promise 或 thenable 对象）
    if (x !== null && (typeof x === 'object' || typeof x === 'function')) {
      let called = false; // 防止多次调用
      try {
        let then = x.then; // 获取 then 方法
        if (typeof then === 'function') {
          // 这里的 then.call 等同于 x.then
          then.call(
            x,
            (y) => {
              if (called) return;
              called = true;
              // 递归解析，直到返回值不是 Promise 为止
              this.resolvePromise(promise2, y, resolve, reject);
            },
            (r) => {
              if (called) return;
              called = true;
              reject(r);
            }
          );
        } else {
          // 普通对象，直接 resolve
          resolve(x);
        }
      } catch (error) {
        if (called) return;
        called = true;
        reject(error);
      }
    } else {
      // 3. 如果 x 是普通值，直接 resolve
      resolve(x);
    }
  }
}
```

**3. 测试用例**

为了验证代码的正确性，我会用几个典型的场景进行测试：

```js
// 1. 测试基本异步状态流转
const p1 = new MyPromise((resolve, reject) => {
  setTimeout(() => {
    resolve('成功 1');
  }, 1000);
});
p1.then(res => console.log('Test 1:', res)); // 1秒后输出: Test 1: 成功 1

// 2. 测试链式调用与值穿透
const p2 = new MyPromise((resolve) => resolve(1));
p2.then(res => res + 1)
  .then() // 测试值穿透
  .then(res => {
    console.log('Test 2:', res); // 输出: Test 2: 2
  });

// 3. 测试错误捕获与冒泡
const p3 = new MyPromise((resolve, reject) => reject('初始错误'));
p3.then(() => {})
  .catch(err => {
    console.log('Test 3:', err); // 输出: Test 3: 初始错误
  });

// 4. 测试 then 中返回 Promise
const p4 = new MyPromise((resolve) => resolve(1));
p4.then(res => {
  return new MyPromise((resolve) => resolve(res + 10));
}).then(res => {
  console.log('Test 4:', res); // 输出: Test 4: 11
});
```

**面试总结**

以上就是我的手写实现。在编写时我特别注意了几个 **Promise/A+ 规范** 的核心要求：

1. **状态不可逆**：状态一旦从 `pending` 变为 `fulfilled` 或 `rejected`，就不能再改变。
2. **异步执行**：回调的执行被包裹在 `setTimeout` 中，确保在事件循环的微任务阶段执行（这里用宏任务模拟）。
3. **错误穿透**：`then` 的第二个参数默认设为抛出错误的函数，实现了不写 `onRejected` 时错误能一直向后传递，直到被 `catch` 捕获。
4. **循环引用检测**：在 `resolvePromise` 中判断了 `promise2 === x`，防止死循环。

## Promise/A+ 规范

A+就是A plus，即 A 的增强版

**一、 3句话核心总结**

1. **状态不可逆**：只有 `pending` -> `fulfilled` 或 `pending` -> `rejected`，且状态一旦改变，永远凝固。
2. **then 返回新 Promise**：`then` 必须返回一个新的 Promise，以支持链式调用。
3. **回调异步执行**：`onFulfilled` 和 `onRejected` 必须在执行栈清空后（微任务阶段）异步执行。

**二、 链式调用的解析规则（处理 then 的返回值 x）**

当 `then` 的回调返回一个值 `x` 时，决定新 Promise 状态的规则如下：

1. **防止死循环**：如果 `x === 新Promise`，直接抛出 `TypeError`。
2. **x 是 Promise**：采用 `x` 的最终状态。
3. **x 是 thenable 对象**（有 `then` 方法）：以 `x` 为 `this` 执行它的 `then` 方法，并加入 `called` 标志位防止多次调用。
4. **x 是普通值**：直接把 `x` 传给新 Promise 的 `resolve`。

**三、 两个默认特性**

1. **值穿透**：如果 `onFulfilled` 不是函数，默认包装成 `v => v`，把值向后传。
2. **错误冒泡**：如果 `onRejected` 不是函数，默认包装成 `e => { throw e }`，把错误向后传，直到被 `catch` 捕获。



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

# 声明变量的六种方法

- ES5 只有两种声明变量的方法：var 和 function 。
- ES6 除了添加 let 和 const 命令。
- 还有两种声明变量的方法：import 命令和 class 命令。



# bigint

bigint是一种新的原始类型，表示超过数值类型安全范围（即超过 2^53−1）的整数

创建方式

> 字面量方式：const a = 12345678901234567890n;
>
> 构造函数：const b = BigInt("999999999999999999");

| **特性**        | **BigInt**                         | **Number**                            |
| --------------- | ---------------------------------- | ------------------------------------- |
| **精度与范围**  | 任意精度整数，无上限（受内存限制） | 双精度浮点数，最大安全整数 253−1253−1 |
| **运算符支持**  | 不支持单目 `+`、`>>>`、`Math` 方法 | 支持所有运算符和 `Math` 方法          |
| **类型检测**    | `typeof 1n === "bigint"`           | `typeof 1 === "number"`               |
| **JSON 序列化** | 默认抛出 `TypeError`，需自定义处理 | 直接支持                              |
| **性能**        | 运算速度较慢（软件实现）           | 运算速度快（硬件优化）                |

------

应用场景

> - 金融与科学计算
> - 加密与安全
> - 大数据处理
> - 避免溢出问题

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
