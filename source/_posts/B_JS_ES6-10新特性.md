---
title: ES6-10新特性
date: 2022-05-05 06:33:16
categories:
- B_JS
toc: true # 是否启用内容索引
---

# 大纲

- JavaScript ES(6-11)全版本语法

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

# 初级

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
```

数组转为 Map

```js
const arr = [[a,'aa'],[b,'bb']]
const map = new Map(arr)
// {a:'aa',b:'bb'}
```

Map 转为对象

```js
let obj = {}
for (let [k, v] of map) {
  obj[k] = v
}
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