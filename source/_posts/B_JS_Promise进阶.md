---
title: Promise进阶
date: 2022-05-29 07:33:16
categories:
- B_JS
toc: true # 是否启用内容索引
---

# 背景

在Promise出现前，处理多个异步请求时，使用多层嵌套和同步处理。

带来两个问题：

> 1. **嵌套调用**，第一个函数的输出往往是第二个函数的输入；
> 2. **处理多个异步请求并发，开发**时往往需要同步请求最终的结果。

Promise解决了上述问题：

> 1. **消灭嵌套调用**：通过 Promise 的链式调用可以解决；
> 2. **合并多个任务的请求结果**：使用 Promise.all 获取合并多个任务的错误处理。

# Promise是什么

> - Promise 是异步编程的一种解决方案。将回调函数的异步编程方法转成用relsove和reject触发事件， 用then和catch捕获成功失败的状态执行相应代码
> - Promise 对象代表一个异步操作，有三种状态：pending（进行中）、fulfilled（已成功）和rejected（已失败）。
> - Promise 对象的状态改变，只有两种可能：从 pending 变为 fulfilled 和从 pending 变为
>   rejected。只要这两种情况发生，状态就凝固了，不会再变了，会一直保持这个结果，这时就称为 resolved（已定型）

**原理**

Promise 也是使用回调函数，只不过是把回调封装在了内部，使用上一直通过 then 方法的链式调用，使得多层的回调嵌套看起来变成了同一层的，书写上以及理解上会更直观和简洁一些。

# Promise/A+规范

Promise 实现遵循了Promise/A+规范,[官方站](https://promisesaplus.com/)，[官方-中文版](https://www.ituring.com.cn/article/66566)

规范的核心有2点：

> - Promise对象的状态不受外界影响
> - 一旦状态改变，就不会再变

**Promise对象的状态不受外界影响**

```
Promise对象代表一个异步操作，有三种状态：pending（进行中）、fulfilled（已成功）和rejected（已失败）。只有异步操作的结果，可以决定当前是哪一种状态，任何其他操作都无法改变这个状态。这也是Promise这个名字的由来，它的英语意思就是“承诺”，表示其他手段无法改变。
```

**一旦状态改变，就不会再变**

```
任何时候都可以得到这个结果。Promise对象的状态改变，只有两种可能：从pending变为fulfilled和从pending变为rejected。只要这两种情况发生，状态就凝固了，不会再变了，会一直保持这个结果，这时就称为 resolved（已定型）。如果改变已经发生了，你再对Promise对象添加回调函数，也会立即得到这个结果。
```

缺点：

> - 无法取消`Promise`，一旦新建它就会立即执行，无法中途取消
> - 如果不设置回调函数，`Promise`内部抛出的错误，不会反应到外部
> - 当处于`pending`状态时，无法得知目前进展到哪一个阶段（刚刚开始还是即将完成）

# 手写Promise-核心流程!!!

[手写Promise/A+](http://dennisgo.cn/Articles/JavaScript/Promise.html)

[看了就会，手写Promise原理，最通俗易懂的版本！！！](https://juejin.cn/post/6994594642280857630#heading-6)

**核心流程**

> 1. 新建Promise需要使用`new`关键字，那他肯定是作为面向对象的方式调用的，Promise是一个类。[关于JS的面向对象更详细的解释可以看这篇文章。](https://juejin.im/post/5e50e5b16fb9a07c9a1959af)
> 2. 我们`new Promise(fn)`的时候需要传一个函数进去，说明Promise的参数是一个函数
> 3. 构造函数传进去的`fn`会收到`resolve`和`reject`两个函数，用来表示Promise成功和失败，说明构造函数里面还需要`resolve`和`reject`这两个函数，这两个函数的作用是改变Promise的状态。
> 4. 根据规范，promise有`pending`，`fulfilled`，`rejected`三个状态，初始状态为`pending`，调用`resolve`会将其改为`fulfilled`，调用`reject`会改为`rejected`。
> 5. promise实例对象建好后可以调用`then`方法，而且是可以链式调用`then`方法，说明`then`是一个实例方法。[链式调用的实现这篇有详细解释，我这里不再赘述](https://juejin.im/post/5e64cf0ef265da5734024f84#heading-7)。简单的说就是`then`方法也必须返回一个带`then`方法的对象，可以是this或者新的promise实例。

通俗易懂版本：

```
// 三个常量用于表示状态
const PENDING = 'pending'
const RESOLVED = 'resolved'
const REJECTED = 'rejected'

function MyPromise(fn) {
    const that = this
    this.state = PENDING

    // value 变量用于保存 resolve 或者 reject 中传入的值
    this.value = null

    // 用于保存 then 中的回调，因为当执行完 Promise 时状态可能还是等待中，这时候应该把 then 中的回调保存起来用于状态改变时使用
    that.resolvedCallbacks = []
    that.rejectedCallbacks = []


    function resolve(value) {
         // 首先两个函数都得判断当前状态是否为等待中
        if(that.state === PENDING) {
            that.state = RESOLVED
            that.value = value

            // 遍历回调数组并执行
            that.resolvedCallbacks.map(cb=>cb(that.value))
        }
    }
    function reject(value) {
        if(that.state === PENDING) {
            that.state = REJECTED
            that.value = value
            that.rejectedCallbacks.map(cb=>cb(that.value))
        }
    }

    // 完成以上两个函数以后，我们就该实现如何执行 Promise 中传入的函数了
    try {
        fn(resolve,reject)
    }cach(e){
        reject(e)
    }
}

// 最后我们来实现较为复杂的 then 函数
MyPromise.prototype.then = function(onFulfilled,onRejected){
  const that = this

  // 判断两个参数是否为函数类型，因为这两个参数是可选参数
  onFulfilled = typeof onFulfilled === 'function' ? onFulfilled : v => v;
  onRejected = typeof onRejected === 'function' ? onRejected : e => throw e;

  // 当状态不是等待态时，就去执行相对应的函数。如果状态是等待态的话，就往回调函数中 push 函数
  if(this.state === PENDING) {
      this.resolvedCallbacks.push(onFulfilled)
      this.rejectedCallbacks.push(onRejected)
  }
  if(this.state === RESOLVED) {
      onFulfilled(that.value)
  }
  if(this.state === REJECTED) {
      onRejected(that.value)
  }
}
```



# 手写Promise-一步一步跟随

[图解 Promise 实现原理（一）—— 基础实现](https://zhuanlan.zhihu.com/p/58428287)

## 极简

步骤：

> 1. 调用 then 方法，将想要在 Promise 异步操作成功时执行的 onFulfilled 放入callbacks队列，其实也就是注册回调函数，可以向观察者模式方向思考；
> 2. 创建 Promise 实例时传入的函数会被赋予一个函数类型的参数，即 resolve，它接收一个参数 value，代表异步操作返回的结果，当异步操作执行成功后，会调用resolve方法，这时候其实真正执行的操作是将 callbacks 队列中的回调一一执行；

```
//极简的实现
class Promise {
    callbacks = [];
    constructor(fn) {
        fn(this._resolve.bind(this));
    }
    then(onFulfilled) {
        this.callbacks.push(onFulfilled);
    }
    _resolve(value) {
        this.callbacks.forEach(fn => fn(value));
    }
}
```

调用：设置定时器模拟异步的场景

```
let p = new Promise(resolve => {
    setTimeout(() => {
        console.log('done');
        resolve('5秒');
    }, 5000);
});

p.then(tip => {
    console.log('then1', tip);
});

p.then(tip => {
    console.log('then2', tip);
});
```

## 极简+链式调用

上一版本缺点：

> - 不能链式调用

**解决：只需要在 then 中 return this 即可**

```
//极简+链式调用
class Promise {
    callbacks = [];
    constructor(fn) {
        fn(this._resolve.bind(this));
    }
    then(onFulfilled) {
        this.callbacks.push(onFulfilled);
        return this;//看这里
    }
    _resolve(value) {
        this.callbacks.forEach(fn => fn(value));
    }
}

let p = new Promise(resolve => {
    setTimeout(() => {
        console.log('done');
        resolve('5秒');
    }, 5000);
}).then(tip => {
    console.log('then1', tip);
}).then(tip => {
    console.log('then2', tip);
});
```

## 极简+链式调用+延迟机制

上一版本缺点：

> - 如果在 then 方法注册 onFulfilled 之前，resolve 就执行了，onFulfilled 就不会执行到了。比如 "同步执行" 打印了，但 "then1" 和 "then2" 没有打印

```
//同步执行了resolve
let p = new Promise(resolve => {
    console.log('同步执行');
    resolve('同步执行');
}).then(tip => {
    console.log('then1', tip);
}).then(tip => {
    console.log('then2', tip);
});
```

**解决：保证在 resolve 执行之前，then 方法已经注册完所有的回调**

步骤：

> 在 resolve 中增加定时器，通过 setTimeout 机制，将 resolve 中执行回调的逻辑放置到JS任务队列末尾，以保证在 resolve 执行时，then方法的 onFulfilled 已经注册完成。

```
//极简的实现+链式调用+延迟机制
class Promise {
    callbacks = [];
    constructor(fn) {
        fn(this._resolve.bind(this));
    }
    then(onFulfilled) {
        this.callbacks.push(onFulfilled);
        return this;
    }
    _resolve(value) {
        setTimeout(() => {//看这里
            this.callbacks.forEach(fn => fn(value));
        });
    }
}
```

## 极简+链式调用+延迟机制+状态机制

上一版本缺点：

> - 在 resolve 执行后，再通过 then 注册上来的 onFulfilled 都没有机会执行了。我们加了延迟后，then1 和 then2 打印了，但 then3 打印不了。

```
let p = new Promise(resolve => {
    console.log('同步执行');
    resolve('同步执行');
}).then(tip => {
    console.log('then1', tip);
}).then(tip => {
    console.log('then2', tip);
});

setTimeout(() => {
    p.then(tip => {
        console.log('then3', tip);
    })
});
```

**解决：引入pending、fulfilled、rejected状态机制**

步骤：

> - 当增加完状态之后，原先的_resolve中的定时器可以去掉了。当reolve同步执行时，虽然callbacks为空，回调函数还没有注册上来，但没有关系，因为后面注册上来时，判断状态为fulfilled，会立即执行回调。

```
//极简的实现+链式调用+延迟机制+状态
class Promise {
    callbacks = [];
    state = 'pending';//增加状态
    value = null;//保存结果
    constructor(fn) {
        fn(this._resolve.bind(this));
    }
    then(onFulfilled) {
        if (this.state === 'pending') {//在resolve之前，跟之前逻辑一样，添加到callbacks中
            this.callbacks.push(onFulfilled);
        } else {//在resolve之后，直接执行回调，返回结果了
            onFulfilled(this.value);
        }
        return this;
    }
    _resolve(value) {
        this.state = 'fulfilled';//改变状态
        this.value = value;//保存结果
        this.callbacks.forEach(fn => fn(value));
    }
}
```

## 完整+链式调用

上一版本缺点：

> -  then 方法中 return 了 this,所以所有的then返回的都是同一个Promise实例的值

**解决：then函数中返回一个新的Promise实例**

步骤：

> - then 方法中，创建并返回了新的 Promise 实例，这是串行Promise的基础，是实现真正链式调用的根本
> - then 方法传入的形参 onFulfilled 以及创建新 Promise 实例时传入的 resolve 放在一起，被push到当前 Promise 的 callbacks 队列中，这是衔接当前 Promise 和后邻 Promise 的关键所在
> - 根据规范，onFulfilled 是可以为空的，为空时不调用 onFulfilled

```
//完整的实现
class Promise {
    callbacks = [];
    state = 'pending';//增加状态
    value = null;//保存结果
    constructor(fn) {
        fn(this._resolve.bind(this));
    }
    then(onFulfilled) {
        return new Promise(resolve => {
            this._handle({
                onFulfilled: onFulfilled || null,
                resolve: resolve
            });
        });
    }
    _handle(callback) {
        if (this.state === 'pending') {
            this.callbacks.push(callback);
            return;
        }
        //如果then中没有传递任何东西
        if (!callback.onFulfilled) {
            callback.resolve(this.value);
            return;
        }
        var ret = callback.onFulfilled(this.value);
        callback.resolve(ret);
    }
    _resolve(value) {
        this.state = 'fulfilled';//改变状态
        this.value = value;//保存结果
        this.callbacks.forEach(callback => this._handle(callback));
    }
}
```

## 完整+原型方法

 Promise 原型方法的实现，包括 catch、finally 以及 rejected 状态等的实现。

rejected实现：

```
//完整的实现+reject
class Promise {
    callbacks = [];
    state = 'pending';//增加状态
    value = null;//保存结果
    constructor(fn) {
        fn(this._resolve.bind(this), this._reject.bind(this));
    }
    then(onFulfilled, onRejected) {
        return new Promise((resolve, reject) => {
            this._handle({
                onFulfilled: onFulfilled || null,
                onRejected: onRejected || null,
                resolve: resolve,
                reject: reject
            });
        });
    }
    _handle(callback) {
        if (this.state === 'pending') {
            this.callbacks.push(callback);
            return;
        }

        let cb = this.state === 'fulfilled' ? callback.onFulfilled : callback.onRejected;

        if (!cb) {//如果then中没有传递任何东西
            cb = this.state === 'fulfilled' ? callback.resolve : callback.reject;
            cb(this.value);
            return;
        }

        let ret = cb(this.value);
        cb = this.state === 'fulfilled' ? callback.resolve : callback.reject;
        cb(ret);
    }
    _resolve(value) {

        if (value && (typeof value === 'object' || typeof value === 'function')) {
            var then = value.then;
            if (typeof then === 'function') {
                then.call(value, this._resolve.bind(this), this._reject.bind(this));
                return;
            }
        }

        this.state = 'fulfilled';//改变状态
        this.value = value;//保存结果
        this.callbacks.forEach(callback => this._handle(callback));
    }
    _reject(error) {
        this.state = 'rejected';
        this.value = error;
        this.callbacks.forEach(callback => this._handle(callback));
    }
}
```

catch、finally添加到Class上，不需要添加到构造函数

```
class Promise {
  callbacks = [];
  state = 'pending';//增加状态
  value = null;//保存结果
  constructor(fn) {
    fn(this._resolve.bind(this), this._reject.bind(this));
  }
  then(onFulfilled, onRejected) {
    return new Promise((resolve, reject) => {
      this._handle({
        onFulfilled: onFulfilled || null,
        onRejected: onRejected || null,
        resolve: resolve,
        reject: reject
      });
    });
  }
  catch(onError) {
    return this.then(null, onError);
  }
  finally(onDone) {
    if (typeof onDone !== 'function') return this.then();

    let Promise = this.constructor;
    return this.then(
      value => Promise.resolve(onDone()).then(() => value),
      reason => Promise.resolve(onDone()).then(() => { throw reason })
    );
  }
  _handle(callback) {
    if (this.state === 'pending') {
      this.callbacks.push(callback);
      return;
    }

    let cb = this.state === 'fulfilled' ? callback.onFulfilled : callback.onRejected;

    if (!cb) {//如果then中没有传递任何东西
      cb = this.state === 'fulfilled' ? callback.resolve : callback.reject;
      cb(this.value);
      return;
    }

    let ret;

    try {
      ret = cb(this.value);
      cb = this.state === 'fulfilled' ? callback.resolve : callback.reject;
    } catch (error) {
      ret = error;
      cb = callback.reject
    } finally {
      cb(ret);
    }

  }
  _resolve(value) {

    if (value && (typeof value === 'object' || typeof value === 'function')) {
      var then = value.then;
      if (typeof then === 'function') {
        then.call(value, this._resolve.bind(this), this._reject.bind(this));
        return;
      }
    }

    this.state = 'fulfilled';//改变状态
    this.value = value;//保存结果
    this.callbacks.forEach(callback => this._handle(callback));
  }
  _reject(error) {
    this.state = 'rejected';
    this.value = error;
    this.callbacks.forEach(callback => this._handle(callback));
  }
}
```

## 完整+静态方法

 Promise 静态方法的实现，包括resolve、reject、all 和 race。

resolve:

```
static resolve(value) {
    if (value && value instanceof Promise) {
      return value;
    } else if (value && typeof value === 'object' && typeof value.then === 'function') {
      let then = value.then;
      return new Promise(resolve => {
        then(resolve);
      });

    } else if (value) {
      return new Promise(resolve => resolve(value));
    } else {
      return new Promise(resolve => resolve());
    }
  }
```

reject:

> Promise.reject 与 Promise.resolve 类似，区别在于 Promise.reject 始终返回一个状态的 rejected 的 Promise 实例，而 Promise.resolve 的参数如果是一个 Promise实例的话，返回的是参数对应的 Promise 实例，所以状态不一 定。

```
static reject(value) {
    if (value && typeof value === 'object' && typeof value.then === 'function') {
      let then = value.then;
      return new Promise((resolve, reject) => {
        then(reject);
      });
    } else {
      return new Promise((resolve, reject) => reject(value));
    }
  }
```

all:

>Promise.all 接收一个 Promise 实例的数组，在所有这些 Promise 的实例都 fulfilled 后，按照 Promise 实例的顺序返回相应结果的数组。

```
static all(promises) {
    return new Promise((resolve, reject) => {
      let fulfilledCount = 0
      const itemNum = promises.length
      const rets = Array.from({ length: itemNum })
      promises.forEach((promise, index) => {
        Promise.resolve(promise).then(result => {
          fulfilledCount++;
          rets[index] = result;
          if (fulfilledCount === itemNum) {
            resolve(rets);
          }
        }, reason => reject(reason));
      })

    })
  }
```

race:

> Promise.race 也接收一个 Promise 实例的数组，与 Promise.all不同的是，所以返回的结果是这些 Promise 实例中最先 fulfilled 的。

```
 static race(promises) {
    return new Promise(function (resolve, reject) {
      for (let i = 0; i < promises.length; i++) {
        Promise.resolve(promises[i]).then(function (value) {
          return resolve(value)
        }, function (reason) {
          return reject(reason)
        })
      }
    })
  }
```

## 最终完整

```
//Promise 完整的实现
class Promise {
  callbacks = [];
  state = 'pending';//增加状态
  value = null;//保存结果
  constructor(fn) {
    fn(this._resolve.bind(this), this._reject.bind(this));
  }
  then(onFulfilled, onRejected) {
    return new Promise((resolve, reject) => {
      this._handle({
        onFulfilled: onFulfilled || null,
        onRejected: onRejected || null,
        resolve: resolve,
        reject: reject
      });
    });
  }
  catch(onError) {
    return this.then(null, onError);
  }
  finally(onDone) {
    if (typeof onDone !== 'function') return this.then();

    let Promise = this.constructor;
    return this.then(
      value => Promise.resolve(onDone()).then(() => value),
      reason => Promise.resolve(onDone()).then(() => { throw reason })
    );
  }
  static resolve(value) {
    if (value && value instanceof Promise) {
      return value;
    } else if (value && typeof value === 'object' && typeof value.then === 'function') {
      let then = value.then;
      return new Promise(resolve => {
        then(resolve);
      });

    } else if (value) {
      return new Promise(resolve => resolve(value));
    } else {
      return new Promise(resolve => resolve());
    }
  }
  static reject(value) {
    if (value && typeof value === 'object' && typeof value.then === 'function') {
      let then = value.then;
      return new Promise((resolve, reject) => {
        then(reject);
      });

    } else {
      return new Promise((resolve, reject) => reject(value));
    }
  }
  static all(promises) {
    return new Promise((resolve, reject) => {
      let fulfilledCount = 0
      const itemNum = promises.length
      const rets = Array.from({ length: itemNum })
      promises.forEach((promise, index) => {
        Promise.resolve(promise).then(result => {
          fulfilledCount++;
          rets[index] = result;
          if (fulfilledCount === itemNum) {
            resolve(rets);
          }
        }, reason => reject(reason));
      })

    })
  }
  static race(promises) {
    return new Promise(function (resolve, reject) {
      for (let i = 0; i < promises.length; i++) {
        Promise.resolve(promises[i]).then(function (value) {
          return resolve(value)
        }, function (reason) {
          return reject(reason)
        })
      }
    })
  }
  _handle(callback) {
    if (this.state === 'pending') {
      this.callbacks.push(callback);
      return;
    }

    let cb = this.state === 'fulfilled' ? callback.onFulfilled : callback.onRejected;

    if (!cb) {//如果then中没有传递任何东西
      cb = this.state === 'fulfilled' ? callback.resolve : callback.reject;
      cb(this.value);
      return;
    }

    let ret;

    try {
      ret = cb(this.value);
      cb = this.state === 'fulfilled' ? callback.resolve : callback.reject;
    } catch (error) {
      ret = error;
      cb = callback.reject
    } finally {
      cb(ret);
    }

  }
  _resolve(value) {
    if(this.state !== 'pending') return
    if (value && (typeof value === 'object' || typeof value === 'function')) {
      var then = value.then;
      if (typeof then === 'function') {
        then.call(value, this._resolve.bind(this), this._reject.bind(this));
        return;
      }
    }

    this.state = 'fulfilled';//改变状态
    this.value = value;//保存结果
    this.callbacks.forEach(callback => this._handle(callback));
  }
  _reject(error) {
    if(this.state !== 'pending') return
    this.state = 'rejected';
    this.value = error;
    this.callbacks.forEach(callback => this._handle(callback));
  }
}
```

**参考**

[面试官：“你能手写一个 Promise 吗”](https://juejin.cn/post/6850037281206566919#heading-3)

[阮一峰ES6](https://es6.ruanyifeng.com/#docs/promise)

[张鑫旭-Promise.all、race和any](https://www.zhangxinxu.com/wordpress/2021/05/promise-all-race-any/)

# Promise面试题

[Promise 必知必会（十道题）](https://zhuanlan.zhihu.com/p/30828196)

[【建议星星】要就来45道Promise面试题一次爽到底(1.1w字用心整理)](https://juejin.cn/post/6844904077537574919#heading-51)

# axios cancelToken取消请求

## 使用方式

axios 如何取消一个请求提供了两种使用模式：

- 第一种 调用CancelToken的静态方法source

```javascript
const CancelToken = axios.CancelToken;
const source = CancelToken.source();
axios.post('/user/12345', {
  name: 'new name'
}, {
  cancelToken: source.token
})
source.cancel('Operation canceled by the user.');
```

- 第二种 自己实例化

```javascript
let cancel;
axios.get('/user/12345', {
  cancelToken: new CancelToken(function executor(c) {
    cancel = c;
  })
});
cancel();
```

**其他取消Promise的方法**

**例如：使用Promise.race()**

```
let cancelPromise = null;
const p1 = new Promise(resolve,reject){
   cancelPromise = resolve;
}
const p2 = axios.get('/api/data',{
  params: params,
});
const fetchData = () => {
   this.cancelPromise && this.cancelPromise ();
   Promise.race(p1,p2).then(callback);
}
```

## 源码分析

```
// axios/lib/cancel/CancelToken.js
'use strict';
var Cancel = require('./Cancel');

function CancelToken(executor) {
    if (typeof executor !== 'function') {
        throw new TypeError('executor must be a function.');
    }
    /**
    * 定义一个将来能执行取消请求的promise对象，当这个promise的状态为完成时(fullfilled),
    * 就会触发取消请求的操作（执行then函数）。而执行resolve就能将promise的状态置为完成状态。
    * 这里把resolve赋值给resolvePromise，就是为了在这个promise外能执行resolve而改变这个promise的状态
    * 注意这个promise对象被赋值给CancelToken实例的属性promise，将来定义then函数就是通过这个属性得到promise
    */
    var resolvePromise;
    this.promise = new Promise(function promiseExecutor(resolve) {
        resolvePromise = resolve;
    });
    /**
    * 将CancelToken实例赋值给token
    * 执行executor函数，将cancel方法传入executor，
    * cancel方法可调用resolvePromise方法，即触发取消请求的操作
    */
    var token = this;
    executor(function cancel(message) {
        if (token.reason) {
            // 取消已响应 返回
            return;
        }
        token.reason = new Cancel(message);
        // 这里执行的就是promise的resolve方法，改变状态
        resolvePromise(token.reason);
  });
}

CancelToken.prototype.throwIfRequested = function throwIfRequested() {
    if (this.reason) {
        throw this.reason;
    }
};

// 这里可以看清楚source函数的真面目
CancelToken.source = function source() {
    var cancel;
    var token = new CancelToken(function executor(c) {
        // c 就是CancelToken中给executor传入的cancel方法
        cancel = c;
    });
    return {
        token: token,
        cancel: cancel
    };
};
module.exports = CancelToken;
```

### CancelToken

CancelToken是一个构造函数，通过new CancelToken()得到的是一个实例对象，它只有一个属性promise, 它的值是一个能触发取消请求的Promise对象。

```
token = new CancelToken(executor function) ===> { promise: Promise对象 }
```

执行CancelToken函数做了两件事：

1. 创建一个Promise对象，且将这个对象赋值给promise属性，其resolve参数被暴露出来以备外部引用。 
2. 执行executor函数，将内部定义的cancel函数作为参数传递给executor

```
var token = this;
var cancel = function (message) {
    if (token.reason) {
        // 取消已响应 返回
        return;
    }
    token.reason = new Cancel(message);
    // 这里执行的就是promise的resolve方法，改变状态
    resolvePromise(token.reason);
}
executor(cancel);
```

### CancelToken.source

CancelToken.source是一个函数，通过源码可以看到，执行const source = CancelToken.source(),得到的是一个对象：

```
return {
    token: token,
    cancel: cancel
};
复制代码
```

包含一个token对象，即CancelToken实例对象，和一个cancel函数。

因此CancelToken.source()函数的作用是生成token对象和取得cancel函数。token对象是用于配置给axios请求中的cancelToken属性，cancel函数是将来触发取消请求的函数。

