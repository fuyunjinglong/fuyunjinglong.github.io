---
title: Promise原理
date: 2022-05-29 07:33:16
categories:
- B_JS
toc: true # 是否启用内容索引
---

# Promise的理解

基本理解：

- promise是一个类。


- 调用的时候传递一个执行器，执行器接收两个参数，用于更改promise状态。


- promise对象拥有三种状态：pending（等待）、fulfilled（成功）、rejected（失败），状态一旦更改不可逆转。


- then方法对状态判断，如果成功就调用成功回调，如果失败就调用失败回调。


- then方法可链式调用，链式调用判断传入值是普通值还是promise对象。


- 异步逻辑，promise对异步的处理。

## Promise.all、race和any区别

[张鑫旭-Promise.all、race和any](https://www.zhangxinxu.com/wordpress/2021/05/promise-all-race-any/)

- `Promise.all()`中的Promise序列会全部执行通过才认为是成功，否则认为是失败；
- `Promise.race()`中的Promise序列中第一个执行完毕的是通过，则认为成功，如果第一个执行完毕的Promise是拒绝，则认为失败；
- `Promise.any()`中的Promise序列只要有一个执行通过，则认为成功，如果全部拒绝，则认为失败；

为了简化理解，整个异步过程我们就使用定时器代替，示意如下：

```js
const upload = function (blob) {
    let time = Math.round(100 + 500 * Math.random());
    return new Promise((resolve, reject) => {
        // 是否执行测试
        console.log(`run ${time}ms`);
        // 成功失败概率50%
        if (Math.random() > 0.5) {
            setTimeout(resolve, time, 'promise resolved ' + time + 'ms');
        } else {
            setTimeout(reject, time, 'promise rejected ' + time + 'ms');
        }         
    });
};
const load = function (url) {
    // 同upload
};
```

**1.Promise.all()**

例如，页面进行请求的时候，如果请求时间太短，loading图标就会一闪而过，体验并不好

```js
(async () => {
    try {
        let result = await Promise.all([upload(0), upload(1), upload(2)]);
        console.log(result);
    } catch (err) {
        console.error(err);
    }
})();
```

**2.Promise.race()**

`Promise.race()`顾名思意就是“赛跑”，哪个执行快就使用哪个。

```js
(async () => {
    try {
        let result = await Promise.race([load(0), load(1), load(2)]);
        console.log(result);
    } catch (err) {
        console.error(err);
    }
})();
```

**3.Promise.any()**

`Promise.any()`更关心成功，只要有一个成功就可以了，除非所有的Promise都拒绝，否则就认为成功。

```js
(async () => {
    try {
        let result = await Promise.any([load(0), load(1), load(2)]);
        console.log(result);
    } catch (err) {
        console.error(err);
    }
})();
```

# Promise源码分析

## Promise核心

> ```
> /**
>  * 1. new Promise时，需要传递一个 executor 执行器，执行器立刻执行
>  * 2. executor 接受两个参数，分别是 resolve 和 reject
>  * 3. promise 只能从 pending 到 rejected, 或者从 pending 到 fulfilled
>  * 4. promise 的状态一旦确认，就不会再改变
>  * 5. promise 都有 then 方法，then 接收两个参数，分别是 promise 成功的回调 onFulfilled, 
>  *      和 promise 失败的回调 onRejected
>  * 6. 如果调用 then 时，promise已经成功，则执行 onFulfilled，并将promise的值作为参数传递进去。
>  *      如果promise已经失败，那么执行 onRejected, 并将 promise 失败的原因作为参数传递进去。
>  *      如果promise的状态是pending，需要将onFulfilled和onRejected函数存放起来，等待状态确定后，再依次将对应的函数执行(发布订阅)
>  * 7. then 的参数 onFulfilled 和 onRejected 可以缺省
>  * 8. promise 可以then多次，promise 的then 方法返回一个 promise
>  * 9. 如果 then 返回的是一个结果，那么就会把这个结果作为参数，传递给下一个then的成功的回调(onFulfilled)
>  * 10. 如果 then 中抛出了异常，那么就会把这个异常作为参数，传递给下一个then的失败的回调(onRejected)
>  * 11.如果 then 返回的是一个promise,那么需要等这个promise，那么会等这个promise执行完，promise如果成功，
>  *   就走下一个then的成功，如果失败，就走下一个then的失败
>  */
> ```

## Promise源码实现

```
const PENDING = 'pending';
const FULFILLED = 'fulfilled';
const REJECTED = 'rejected';
function Promise(executor) {
    let self = this;
    self.status = PENDING;
    self.onFulfilled = [];//成功的回调
    self.onRejected = []; //失败的回调
    //PromiseA+ 2.1
    function resolve(value) {
        if (self.status === PENDING) {
            self.status = FULFILLED;
            self.value = value;
            self.onFulfilled.forEach(fn => fn());//PromiseA+ 2.2.6.1
        }
    }

    function reject(reason) {
        if (self.status === PENDING) {
            self.status = REJECTED;
            self.reason = reason;
            self.onRejected.forEach(fn => fn());//PromiseA+ 2.2.6.2
        }
    }

    try {
        executor(resolve, reject);
    } catch (e) {
        reject(e);
    }
}

Promise.prototype.then = function (onFulfilled, onRejected) {
    //PromiseA+ 2.2.1 / PromiseA+ 2.2.5 / PromiseA+ 2.2.7.3 / PromiseA+ 2.2.7.4
    onFulfilled = typeof onFulfilled === 'function' ? onFulfilled : value => value;
    onRejected = typeof onRejected === 'function' ? onRejected : reason => { throw reason };
    let self = this;
    //PromiseA+ 2.2.7
    let promise2 = new Promise((resolve, reject) => {
        if (self.status === FULFILLED) {
            //PromiseA+ 2.2.2
            //PromiseA+ 2.2.4 --- setTimeout
            setTimeout(() => {
                try {
                    //PromiseA+ 2.2.7.1
                    let x = onFulfilled(self.value);
                    resolvePromise(promise2, x, resolve, reject);
                } catch (e) {
                    //PromiseA+ 2.2.7.2
                    reject(e);
                }
            });
        } else if (self.status === REJECTED) {
            //PromiseA+ 2.2.3
            setTimeout(() => {
                try {
                    let x = onRejected(self.reason);
                    resolvePromise(promise2, x, resolve, reject);
                } catch (e) {
                    reject(e);
                }
            });
        } else if (self.status === PENDING) {
            self.onFulfilled.push(() => {
                setTimeout(() => {
                    try {
                        let x = onFulfilled(self.value);
                        resolvePromise(promise2, x, resolve, reject);
                    } catch (e) {
                        reject(e);
                    }
                });
            });
            self.onRejected.push(() => {
                setTimeout(() => {
                    try {
                        let x = onRejected(self.reason);
                        resolvePromise(promise2, x, resolve, reject);
                    } catch (e) {
                        reject(e);
                    }
                });
            });
        }
    });
    return promise2;
}

function resolvePromise(promise2, x, resolve, reject) {
    let self = this;
    //PromiseA+ 2.3.1
    if (promise2 === x) {
        reject(new TypeError('Chaining cycle'));
    }
    if (x && typeof x === 'object' || typeof x === 'function') {
        let used; //PromiseA+2.3.3.3.3 只能调用一次
        try {
            let then = x.then;
            if (typeof then === 'function') {
                //PromiseA+2.3.3
                then.call(x, (y) => {
                    //PromiseA+2.3.3.1
                    if (used) return;
                    used = true;
                    resolvePromise(promise2, y, resolve, reject);
                }, (r) => {
                    //PromiseA+2.3.3.2
                    if (used) return;
                    used = true;
                    reject(r);
                });

            }else{
                //PromiseA+2.3.3.4
                if (used) return;
                used = true;
                resolve(x);
            }
        } catch (e) {
            //PromiseA+ 2.3.3.2
            if (used) return;
            used = true;
            reject(e);
        }
    } else {
        //PromiseA+ 2.3.3.4
        resolve(x);
    }
}
module.exports = Promise;
```

**注意：**

1. onFulfilled 和 onFulfilled的调用需要放在setTimeout，因为规范中表示: onFulfilled or onRejected must not be called until the execution context stack contains only platform code。使用setTimeout只是模拟异步，原生Promise并非是这样实现的。
2. 在 resolvePromise 的函数中，为何需要usedd这个flag,同样是因为规范中明确表示: If both resolvePromise and rejectPromise are called, or multiple calls to the same argument are made, the first call takes precedence, and any further calls are ignored. 因此我们需要这样的flag来确保只会执行一次。
3. self.onFulfilled 和 self.onRejected 中存储了成功的回调和失败的回调，根据规范2.6显示，当promise从pending态改变的时候，需要按照顺序去指定then对应的回调。

## Promise的其他方法

1. Promise.resolve()
2. Promise.reject()
3. Promise.prototype.catch()
4. Promise.prototype.finally()
5. Promise.all()
6. Promise.race()

> ### Promise.resolve

Promise.resolve(value) 返回一个以给定值解析后的Promise 对象.

1. 如果 value 是个 thenable 对象，返回的promise会“跟随”这个thenable的对象，采用它的最终状态
2. 如果传入的value本身就是promise对象，那么Promise.resolve将不做任何修改、原封不动地返回这个promise对象。
3. 其他情况，直接返回以该值为成功状态的promise对象。

```
Promise.resolve = function (param) {
        if (param instanceof Promise) {
        return param;
    }
    return new Promise((resolve, reject) => {
        if (param && param.then && typeof param.then === 'function') {
            setTimeout(() => {
                param.then(resolve, reject);
            });
        } else {
            resolve(param);
        }
    });
}
```

thenable对象的执行加 setTimeout的原因是根据原生Promise对象执行的结果推断的，如下的测试代码，原生的执行结果为: 20 400 30;为了同样的执行顺序，增加了setTimeout延时。

> ### Promise.reject

Promise.reject方法和Promise.resolve不同，Promise.reject()方法的参数，会原封不动地作为reject的理由，变成后续方法的参数。

```
Promise.reject = function (reason) {
    return new Promise((resolve, reject) => {
        reject(reason);
    });
}
```

> ### Promise.prototype.catch

Promise.prototype.catch 用于指定出错时的回调，是特殊的then方法，catch之后，可以继续 .then

```
Promise.prototype.catch = function (onRejected) {
    return this.then(null, onRejected);
}
```

> ### Promise.prototype.finally

不管成功还是失败，都会走到finally中,并且finally之后，还可以继续then。并且会将值原封不动的传递给后面的then.

```
Promise.prototype.finally = function (callback) {
    return this.then((value) => {
        return Promise.resolve(callback()).then(() => {
            return value;
        });
    }, (err) => {
        return Promise.resolve(callback()).then(() => {
            throw err;
        });
    });
}
```

> ### Promise.all

Promise.all(promises) 返回一个promise对象

1. 如果传入的参数是一个空的可迭代对象，那么此promise对象回调完成(resolve),只有此情况，是同步执行的，其它都是异步返回的。
2. 如果传入的参数不包含任何 promise，则返回一个异步完成.
3. promises 中所有的promise都promise都“完成”时或参数中不包含 promise 时回调完成。
4. 如果参数中有一个promise失败，那么Promise.all返回的promise对象失败
5. 在任何情况下，Promise.all 返回的 promise 的完成状态的结果都是一个数组

```
Promise.all = function (promises) {
    return new Promise((resolve, reject) => {
        let index = 0;
        let result = [];
        if (promises.length === 0) {
            resolve(result);
        } else {
            function processValue(i, data) {
                result[i] = data;
                if (++index === promises.length) {
                    resolve(result);
                }
            }
            for (let i = 0; i < promises.length; i++) {
                    //promises[i] 可能是普通值
                    Promise.resolve(promises[i]).then((data) => {
                    processValue(i, data);
                }, (err) => {
                    reject(err);
                    return;
                });
            }
        }
    });
}
```

> ### Promise.race

Promise.race函数返回一个 Promise，它将与第一个传递的 promise 相同的完成方式被完成。它可以是完成（ resolves），也可以是失败（rejects），这要取决于第一个完成的方式是两个中的哪个。

如果传的参数数组是空，则返回的 promise 将永远等待。

如果迭代包含一个或多个非承诺值和/或已解决/拒绝的承诺，则 Promise.race 将解析为迭代中找到的第一个值。

```
Promise.race = function (promises) {
    return new Promise((resolve, reject) => {
        if (promises.length === 0) {
            return;
        } else {
            for (let i = 0; i < promises.length; i++) {
                Promise.resolve(promises[i]).then((data) => {
                    resolve(data);
                    return;
                }, (err) => {
                    reject(err);
                    return;
                });
            }
        }
    });
}
```



## 测试是否符合PromiseA+规范

首先，在promise实现的代码中，增加以下代码:

```
Promise.defer = Promise.deferred = function () {
    let dfd = {};
    dfd.promise = new Promise((resolve, reject) => {
        dfd.resolve = resolve;
        dfd.reject = reject;
    });
    return dfd;
}
```

安装测试脚本:

```
npm install -g promises-aplus-tests
```

如果当前的promise源码的文件名为promise.js

那么在对应的目录执行以下命令:

```
promises-aplus-tests promise.js
```

## PromiseA+的规范(翻译版)

> 术语

1. promise 是一个有then方法的对象或者是函数，行为遵循本规范
2. thenable 是一个有then方法的对象或者是函数
3. value 是promise状态成功时的值，包括 undefined/thenable或者是 promise
4. exception 是一个使用throw抛出的异常值
5. reason 是promise状态失败时的值

> 要求

2.1 Promise States

Promise 必须处于以下三个状态之一: pending, fulfilled 或者是 rejected

2.2 then方法

promise必须提供一个then方法，来访问最终的结果

promise的then方法接收两个参数onFulfilled, onRejected

2.3 resolvePromise

resolvePromise(promise2, x, resolve, reject)

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

