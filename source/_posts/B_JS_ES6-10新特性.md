---
title: ES6-10新特性
date: 2022-05-05 06:33:16
categories:
- B_JS
toc: true # 是否启用内容索引
---

# 参考

[ES6、ES7、ES8、ES9、ES10新特性](https://juejin.cn/post/6844903811622912014#heading-56)

# Set、Map、WeakSet 和 WeakMap 的区别

**Set**

几个关键点：

- 集合中的元素无序且唯一
- 集合中的元素可以是任何类型，无论是原始值还是对象引用

**WeakSet**

与 Set 的区别

- WeakSet 中的元素只能是对象，不能是其他类型的值
- WeakSet 中的对象都是弱引用，即垃圾回收机制不考虑 WeakSet 对该对象的引用，也就是说，如果该对象不在被其他变量引用，那么垃圾回收机制就会自动回收该对象所占用内存，所以只要 WeakSet 成员对象在外部消失，它们在 WeakSet 里面的引用就会自动消失。
- 由于 WeakSet 内部有多少个成员，取决于垃圾回收机制有没有运行，运行前后很可能成员个数是不一样的，而垃圾回收机制何时运行是不可预测的，因此 ES6 规定 WeakSet 不可遍历。

**WeakMap**

WeakMap 和 Map 区别

- WeakMap 只接受对象作为键名（不包括null）
- WeakMap 键名所指向的对象，不计入垃圾回收机制（同 WeakSet）

**小结：**

Set、Map、WeakSet、WeakMap、都是一种集合的数据结构

Set 和 WeakSet 是一种值-值的集合，且元素唯一不重复

Map 和 WeakMap 是一种键-值对的集合，Map 的键可以是任意类型，WeakMap 的键只能是对象类型。

Set 和 Map可遍历，WeakSet 和 WeakMap不可遍历

WeakSet 和 WeakMap 键名所指向的对象，不计入垃圾回收机制

# ES6

## set和map

`Set`是一种叫做集合的数据结构，`Map`是一种叫做字典的数据结构.

Set是由一堆无序的、相关联的，且不重复的内存结构;

Map是一些元素的集合。每个元素有一个称作key 的域，不同元素的key 各不相同

**Set**

set常用方法：add(),delete();has();clear();

遍历方法：keys();values();entires();foreach();

扩展运算符和` Set` 结构相结合实现数组或字符串去重

```js
// 数组
let arr = [3, 5, 2, 2, 5, 5];
let unique = [...new Set(arr)]; // [3, 5, 2]
```

实现并集、交集、和差集

```js
// 并集
let union = new Set([...a, ...b]);
// Set {1, 2, 3, 4}

// 交集
let intersect = new Set([...a].filter(x => b.has(x)));
// set {2, 3}

// （a 相对于 b 的）差集
let difference = new Set([...a].filter(x => !b.has(x)));
```

手写set

```
class Set {
  //Symbol.iterator 为每个对象定义了默认的迭代器。
  //该迭代器可以被for... of循环使用
  constructor(iterator = []) {
    //传递的对象必须是一个可迭代对象
    //所以需要判断传递的参数是否是可迭代对象
    if (typeof iterator[Symbol.iterator] !== 'function') {
      //不是可迭代对象就抛出一个错误
      throw new TypeError(`您所提供的 ${iterator}不是一个可迭代对象`)
    }
    //创建一个空数组
    this._datas = []
    //取出数组iterator里面的值，用for of循环
    for (const item of iterator) {
      // 将值添加到空数组中
      this.add(item)
    }
  }

  //判断两个值是否相等
  isEqual(data1, data2) {
    //1.存在两个都为0的情况
    if (data1 === 0 && data2 === 0) {
      return true
    }
    //2.Object.is()方法判断两个值是否为同一个值
    return Object.is(data1, data2)
  }

  //判断数据是否存在数组中
  has(data) {
    //遍历数组中的值(用for of)
    for (const item of this._datas) {
      //调用isEqual()方法判断 data(输入的数据)跟item(数组中的数据)
      if (this.isEqual(data, item)) {
        //相同返回true
        return true
      }
      //不相同返回false
      return false
    }
  }

  //添加数据的方法
  add(data) {
    //首先判断添加的值是否存在在当前数组中，存在的话就默认返回undefined，
    //不存在就把数据添加到之前定义的空数组中，
    // 此时已经不是空数组，而是存入了item值
    if (!this.has(data)) {
      //不存在就添加到数组中
      this._datas.push(data)
    }
    return this._datas
  }

  // 删除数据，返回结果true/false,删除成功/删除失败
  delete(data) {
    //遍历数组中的数据,i为下标,element为每个数据
    for (let i = 0; i < this._datas.length; i++) {
      const element = this._datas[i]
      //判断data跟element是否相同,相同说明数组中存在数据，可以删除
      if (this.isEqual(data, element)) {
        //删除数据利用splice()方法
        this._datas.splice(i, 1)
        //删除成功
        return true
      }
    }
    //删除失败
    return false
  }

  //清除数据
  clear() {
    //数组长度为0
    this._datas.length = 0
    return this._datas
  }

  //获取数组长度
  get size() {
    return this._datas.length
  }

  //forEach方法(里层用for of)
  forEach(callback) {
    for (const item of this._datas) {
      callback(item, item, this)
    }
  }

  values() {
    return this._datas
  }
  entries() {
    return this._datas.map(item => [item, item])
  }

  //*[Sysbol.iterator]
  *[Symbol.iterator]() {
    for (const item of this._datas) {
      yield item
    }
  }
}

const s = new Set([1, 1, '1'])
console.log([...s]) // [ 1, '1' ]
console.log(s.size) // 2
s.clear() // 清空重新来
console.log(s.size) // 0
s.add(1)
console.log(s.size) // 1
s.add(1) // 检测重复
console.log(s.size) // 1
s.add('1') // 检测 数字1 与 字符串 '1'
console.log(s.size) // 2
console.log(s.values()) // [ 1, '1' ]
s.add(2)
console.log(s.size) // 3
console.log(s.values()) //[ 1, '1', 2 ]
console.log(s.entries()) // [ [ 1, 1 ], [ '1', '1' ], [ 2, 2 ] ]
console.log([...s]) // [ 1, '1', 2 ]
s.delete(1)
console.log(s.size) // 2
s.clear()
console.log(s.size) // 0
```

**Map**

size 属性,set();get();has();delete();clear()

遍历：同set

手写map

map函数接收两个参数,迭代器函数fn和迭代器函数的this指向

```
class Map {
  //Symbol.iterator 为每个对象定义了默认的迭代器。
  //该迭代器可以被for... of循环使用
  constructor(iterator = []) {
    //传递的对象必须是一个可迭代对象
    //所以需要判断传递的参数是否是可迭代对象
    if (typeof iterator[Symbol.iterator] !== 'function') {
      //不是可迭代对象就抛出一个错误
      throw new TypeError(`您所提供的 ${iterator}不是一个可迭代对象`)
    }
    //创建一个空数组
    this._datas = []
    //取出数组iterator里面的值，用for of循环
    for (const item of iterator) {
      const [k, v] = item
      // 将值添加到空数组中
      this.set(k, v)
    }
  }

  //判断两个值是否相等
  isEqual(data1, data2) {
    //1.存在两个都为0的情况
    if (data1 === 0 && data2 === 0) {
      return true
    }
    //2.Object.is()方法判断两个值是否为同一个值
    return Object.is(data1, data2)
  }

  //判断数据是否存在数组中
  has(key) {
    //遍历数组中的值(用for of)
    for (const [k, _] of this._datas) {
      //调用isEqual()方法判断 data(输入的数据)跟item(数组中的数据)
      if (this.isEqual(key, k)) {
        //相同返回true
        return true
      }
      //不相同返回false
      return false
    }
  }

  //添加数据的方法
  set(key, val) {
    //首先判断添加的值是否存在在当前数组中，存在的话就默认返回undefined，
    //不存在就把数据添加到之前定义的空数组中，
    // 此时已经不是空数组，而是存入了item值
    if (!this.has(key)) {
      //不存在就添加到数组中
      this._datas.push([key, val])
    } else {
      const item = this._datas.find(([k, _]) => k === key)
      item[1] = val
    }
    return this._datas
  }
  //添加数据的方法
  get(key) {
    //首先判断添加的值是否存在在当前数组中，存在的话就默认返回undefined，
    //不存在就把数据添加到之前定义的空数组中，
    // 此时已经不是空数组，而是存入了item值
    if (!this.has(key)) {
      //不存在就添加到数组中
      return undefined
    }
    const item = this._datas.find(([k, _]) => k === key)
    return item[1]
  }

  // 删除数据，返回结果true/false,删除成功/删除失败
  delete(key) {
    if (!this.has(key)) {
      //不存在返回false
      return false
    }
    const idx = this._datas.findIndex(([k, _]) => k === key)
    //删除数据利用splice()方法
    this._datas.splice(idx, 1)
    //删除成功，返回true
    return true
  }

  //清除数据
  clear() {
    //数组长度为0
    this._datas.length = 0
    return this._datas
  }

  //获取数组长度
  get size() {
    return this._datas.length
  }

  //forEach方法(里层用for of)
  forEach(callback) {
    for (const [k, v] of this._datas) {
      callback(v, k, this)
    }
  }

  keys() {
    return this._datas.reduce((acc, cur) => {
      acc.push(cur[0])
      return acc
    }, [])
  }
  values() {
    return this._datas.reduce((acc, cur) => {
      acc.push(cur[1])
      return acc
    }, [])
  }
  entries() {
    return this._datas.reduce((acc, cur) => {
      acc.push([cur[0], cur[1]])
      return acc
    }, [])
  }

  //*[Sysbol.iterator]
  *[Symbol.iterator]() {
    for (const item of this._datas) {
      yield item
    }
  }
}

const m = new Map([[1], [2, 3]])
console.log([...m]) // [ [ 1, undefined ], [ 2, 3 ] ]
console.log(m.keys()) // [ 1, 2 ]
console.log(m.values()) // [ undefined, 3 ]
console.log(m.entries()) // [ [ 1, undefined ], [ 2, 3 ] ]
console.log(m.size) // [ [ 1, undefined ], [ 2, 3 ] ]
m.clear()
m.set(1, 2)
console.log(m.entries()) // [ [ 1, 2 ] ]
m.set(1, 3)
console.log(m.entries()) // [ [ 1, 3 ] ]
m.delete(1)
console.log(m.entries()) // []
```

1 迭代器函数 ，该函数有三个参数
数组项的值
数组项下标
数组对象本身
2 迭代器函数的this指向
（注：当传了该值，迭代器函数不能为箭头函数了。原因是箭头函数没有this隐式指向。箭头函数在定义时候就已经绑定了上层上下文中非箭头函数this）

```
Array.prototype.copyMap = function (fn, toThis) {
let arr = this;
const result = [];
const redirectThis = toThis || Object.create(null);
for (let i = 0; i < arr.length; i++) {
const item = fn.call(redirectThis, arr[i], i, arr);
result.push(item);
}
return result;
};
```



## Promise原理

[promise原理及手写]: https://juejin.cn/post/6850037281206566919#heading-6

1.promise解决的问题

它是一个异步解决方案，比如：以前嵌套调用即回调地域，处理多个异步请求并发。现在可以消灭嵌套调用和合并多个任务请求。

以前异步方案有四种：

- calllback回调函数；
- generator+co库；
- promise;
- aysnc+await;

2.promise/A+规范

- **解决（fulfill）**：指一个 promise 成功时进行的一系列操作，如状态的改变、回调的执行。虽然规范中用 `fulfill` 来表示解决，但在后世的 promise 实现多以 `resolve` 来指代之。
- **拒绝（reject）**：指一个 promise 失败时进行的一系列操作。
- **终值（eventual value）**：所谓终值，指的是 promise 被**解决**时传递给解决回调的值，由于 promise 有**一次性**的特征，因此当这个值被传递时，标志着 promise 等待态的结束，故称之终值，有时也直接简称为值（value）。
- **据因（reason）**：也就是拒绝原因，指在 promise 被**拒绝**时传递给拒绝回调的值。

[promise/A+]: http://www.ituring.com.cn/article/66566

promise状态有三种：等待态（Pending）、执行态（Fulfilled）和拒绝态（Rejected）。

promise提供一个 then 方法以访问其当前值、终值和据因。入参分别是 promise 成功的回调 onFulfilled, 和 promise 失败的回调 onRejected

3.原理

new promise时， 需要传递一个executor()执行器，入参是resolve和reject函数。结合settimeout异步+回调数组实现then异步，then的new promise实现链式调用

4.手写promise

4.1基础版

```js
Promise.js
class Promise{
    constructor(executor){
        if(typeof executor !=='function')
        throw new TypeError('executor 不是一个函数');
        const resolve =(value)=>{
            //接收终值，成功时回调
            console.log('接收终值');
        };
        const reject=(res)=>{
            //接收据因，失败时回调
            console.log('接收据因');
        };
        executor(resolve,reject);
    }
}
module.exports= Promise

index.js
const  Promise = require('./promise.js') 
new Promise((resolve,reject)=>{
    console.log('开始了');
    resolve(1)
})
```

代码优化版本

```js
class Promise{
    constructor(executor){
        if(typeof executor !=='function')
        throw new TypeError('executor 不是一个函数');

        this.initValue();
        this.initBind();
        executor(this.resolve,this.reject);
    }
    initValue(){
        //初始化
        this.value = null;//终值
        this.reason=null;//据因
        this.state='pending';//状态
    }
    initBind(){
        // 初始化改变this指向
        //如果是箭头函数，就不要改变this指向，因为箭头函数自动继承父的this即当前实例
        this.resolve = this.resolve.bind(this);
        this.reject = this.reject.bind(this);
    }
    resolve(value){
        //接收终值，成功时回调
        console.log('接收终值');
        if(this.state='pending'){
            this.state='fulfilled';
            this.value = value;
        }
    }
    reject(reason){
        //接收据因，失败时回调
        console.log('接收据因');
        if(this.state='pending'){
            this.state='fulfilled';
            this.reason = reason;
        }
    }
}

module.exports= Promise
```

4.2then异步实现

先上同步代码

```js
class Promise{
    constructor(executor){
        if(typeof executor !=='function')
        throw new TypeError('executor 不是一个函数');

        this.initValue();
        this.initBind();
        executor(this.resolve,this.reject);
    }
    initValue(){
        //初始化
        this.value = null;//终值
        this.reason=null;//据因
        this.state=Promise.PENDING;//状态
    }
    initBind(){
        // 初始化改变this指向
        //如果是箭头函数，就不要改变this指向，因为箭头函数自动继承父的this即当前实例
        this.resolve = this.resolve.bind(this);
        this.reject = this.reject.bind(this);
    }
    resolve(value){
        //接收终值，成功时回调
        console.log('接收终值');
        if(this.state=Promise.PENDING){
            this.state=Promise.FULFILLED;
            this.value = value;
        }
    }
    reject(reason){
        //接收据因，失败时回调
        console.log('接收据因');
        if(this.state=Promise.PENDING){
            this.state=Promise.REJECTED;
            this.reason = reason;
        }
    }
    then(onFulfilled,onRejected){
        //参数校验
        if(typeof onFulfilled !=='function' ){
            //不是函数则返回一个函数
            onFulfilled = function(value){
                return value;
            }
        }
        if(typeof onRejected !=='function' ){
            //不是函数则返回一个函数
            onRejected = function(reason){
                return reason;
            }
        }
        if(this.state ===Promise.FULFILLED){
            //有结果后，直接回调
            onFulfilled(this.value);
        }
        if(this.state ===Promise.REJECTED){
            onRejected(this.reason);
        }

    }
}

//也称为魔法数字
Promise.PENDING = 'pending';
Promise.FULFILLED = 'fulfilled';
Promise.REJECTED = 'rejected';
module.exports= Promise


console.log(1);
const  Promise = require('./promise.js') 
new Promise((resolve,reject)=>{
    console.log(2);
    setTimeout(()=>{
        resolve('我要执行')
    })
}).then(value=>{
    console.log(4);
    console.log('value:',value);
},reason=>{
    console.log('reason:',reason); 
})
console.log(3);
打印
1,2,3； 4不执行了，这是不对的
```

上异步代码

```
class Promise{
    constructor(executor){
        if(typeof executor !=='function')
        throw new TypeError('executor 不是一个函数');

        this.initValue();
        this.initBind();
        executor(this.resolve,this.reject);
    }
    initValue(){
        //初始化
        this.value = null;//终值
        this.reason=null;//据因
        this.state=Promise.PENDING;//状态
        this.onFulfilledCallbacks=[];//成功回调数组
        this.onRejectedCallbacks=[];//失败回调数组
    }
    initBind(){
        // 初始化改变this指向
        //如果是箭头函数，就不要改变this指向，因为箭头函数自动继承父的this即当前实例
        this.resolve = this.resolve.bind(this);
        this.reject = this.reject.bind(this);
    }
    resolve(value){
        //接收终值，成功时回调
        console.log('接收终值');
        if(this.state=Promise.PENDING){
            this.state=Promise.FULFILLED;
            this.value = value;
            // 成功后，执行成功的回调数组
            this.onFulfilledCallbacks.forEach(fn=>fn(this.value));
        }
    }
    reject(reason){
        //接收据因，失败时回调
        console.log('接收据因');
        if(this.state=Promise.PENDING){
            this.state=Promise.REJECTED;
            this.reason = reason;
            this.onRejectedCallbacks.forEach(fn=>fn(this.reason));
        }
    }
    then(onFulfilled,onRejected){
        //参数校验
        if(typeof onFulfilled !=='function' ){
            //不是函数则返回一个函数
            onFulfilled = function(value){
                return value;
            }
        }
        if(typeof onRejected !=='function' ){
            //不是函数则返回一个函数
            onRejected = function(reason){
                return reason;
            }
        }
        if(this.state ===Promise.FULFILLED){
            //有结果后，直接回调
            onFulfilled(this.value);
        }
        if(this.state ===Promise.REJECTED){
            onRejected(this.reason);
        }

        if(this.state ===Promise.PENDING){
            //还在执行中，将异步回调函数加入到数组中存放起来
            this.onFulfilledCallbacks.push(value=>{
                setTimeout(()=>{
                    onFulfilled(value);
                })
            })
            this.onRejectedCallbacks.push(reason=>{
                setTimeout(()=>{
                    onRejected(reason);
                })
            })
        }

    }
}

//也称为魔法数字
Promise.PENDING = 'pending';
Promise.FULFILLED = 'fulfilled';
Promise.REJECTED = 'rejected';
module.exports= Promise
```

4.3链式调用

```
promise.js文件
class Promise{
    constructor(executor){
        if(typeof executor !=='function')
        throw new TypeError('executor 不是一个函数');

        this.initValue();
        this.initBind();
        executor(this.resolve,this.reject);
    }
    initValue(){
        //初始化
        this.value = null;//终值
        this.reason=null;//据因
        this.state=Promise.PENDING;//状态
        this.onFulfilledCallbacks=[];//成功回调数组
        this.onRejectedCallbacks=[];//失败回调数组
    }
    initBind(){
        // 初始化改变this指向
        //如果是箭头函数，就不要改变this指向，因为箭头函数自动继承父的this即当前实例
        this.resolve = this.resolve.bind(this);
        this.reject = this.reject.bind(this);
    }
    resolve(value){
        //接收终值，成功时回调
        console.log('接收终值');
        if(this.state=Promise.PENDING){
            this.state=Promise.FULFILLED;
            this.value = value;
            // 成功后，执行成功的回调数组
            this.onFulfilledCallbacks.forEach(fn=>fn(this.value));
        }
    }
    reject(reason){
        //接收据因，失败时回调
        console.log('接收据因');
        if(this.state=Promise.PENDING){
            this.state=Promise.REJECTED;
            this.reason = reason;
            this.onRejectedCallbacks.forEach(fn=>fn(this.reason));
        }
    }
    then(onFulfilled,onRejected){
        //参数校验
        if(typeof onFulfilled !=='function' ){
            //不是函数则返回一个函数
            onFulfilled = function(value){
                return value;
            }
        }
        if(typeof onRejected !=='function' ){
            //不是函数则返回一个函数
            onRejected = function(reason){
                return reason;
            }
        }

        //链式调用，需要返回一个新实例
        let promise2=new Promise((resolve,reject)=>{
            if(this.state ===Promise.FULFILLED){
                //有结果后，直接回调
              try {
                const x=  onFulfilled(this.value);
                resolve(x);
              } catch (e) {
                  reject(e);
              }
            }
            if(this.state ===Promise.REJECTED){
                try {
                    const x= onRejected(this.reason);
                    resolve(x);
                } catch (e) {
                    reject(e);
                }
                
            }
    
            if(this.state ===Promise.PENDING){
                //还在执行中，将异步回调函数加入到数组中存放起来
                this.onFulfilledCallbacks.push(value=>{
                    setTimeout(()=>{
                        try {
                            const x = onFulfilled(value);
                        resolve(x);
                        } catch (e) {
                            reject(e);
                        }
                        
                    })
                })
                this.onRejectedCallbacks.push(reason=>{
                    setTimeout(()=>{
                        try {
                            const x=  onRejected(reason);
                        resolve(x);
                        } catch (e) {
                            reject(e);
                        }
                        
                    })
                })
            }
        })
        return promise2

    }
}

//也称为魔法数字
Promise.PENDING = 'pending';
Promise.FULFILLED = 'fulfilled';
Promise.REJECTED = 'rejected';
module.exports= Promise

index.js文件
console.log(1);
const  Promise = require('./promise.js') 
new Promise((resolve,reject)=>{
    console.log(2);
    setTimeout(()=>{
        resolve('我要执行')
    })
}).then(value=>{
    console.log(4);
    console.log('value:',value);
},reason=>{
    console.log('reason:',reason); 
}).then(value=>{
    console.log(5);
    console.log('value:',value);
})
console.log(3);
```

4.4终极解决方案

解决promise的then返回一个promise和循环递归调用自己

```js
Promise.js文件
class Promise{
    constructor(executor){
        if(typeof executor !=='function')
        throw new TypeError('executor 不是一个函数');

        this.initValue();
        this.initBind();
        executor(this.resolve,this.reject);
    }
    initValue(){
        //初始化
        this.value = null;//终值
        this.reason=null;//据因
        this.state=Promise.PENDING;//状态
        this.onFulfilledCallbacks=[];//成功回调数组
        this.onRejectedCallbacks=[];//失败回调数组
    }
    initBind(){
        // 初始化改变this指向
        //如果是箭头函数，就不要改变this指向，因为箭头函数自动继承父的this即当前实例
        this.resolve = this.resolve.bind(this);
        this.reject = this.reject.bind(this);
    }
    resolve(value){
        //接收终值，成功时回调
        console.log('接收终值');
        if(this.state=Promise.PENDING){
            this.state=Promise.FULFILLED;
            this.value = value;
            // 成功后，执行成功的回调数组
            this.onFulfilledCallbacks.forEach(fn=>fn(this.value));
        }
    }
    reject(reason){
        //接收据因，失败时回调
        console.log('接收据因');
        if(this.state=Promise.PENDING){
            this.state=Promise.REJECTED;
            this.reason = reason;
            this.onRejectedCallbacks.forEach(fn=>fn(this.reason));
        }
    }
    then(onFulfilled,onRejected){
        //参数校验
        if(typeof onFulfilled !=='function' ){
            //不是函数则返回一个函数
            onFulfilled = function(value){
                return value;
            }
        }
        if(typeof onRejected !=='function' ){
            //不是函数则返回一个函数
            onRejected = function(reason){
                return reason;
            }
        }

        //链式调用，需要返回一个新实例
        let promise2=new Promise((resolve,reject)=>{
            if(this.state ===Promise.FULFILLED){
                //有结果后，直接回调
              try {
                const x=  onFulfilled(this.value);
                // x可能是一个proimise
                Promise.resolvePromise(promise2, x, resolve, reject);
              } catch (e) {
                  reject(e);
              }
            }
            if(this.state ===Promise.REJECTED){
                try {
                    const x= onRejected(this.reason);
                    // x可能是一个proimise
                    Promise.resolvePromise(promise2, x, resolve, reject);
                } catch (e) {
                    reject(e);
                }
                
            }
    
            if(this.state ===Promise.PENDING){
                //还在执行中，将异步回调函数加入到数组中存放起来
                this.onFulfilledCallbacks.push(value=>{
                    setTimeout(()=>{
                        try {
                            const x = onFulfilled(value);
                        // x可能是一个proimise
                        Promise.resolvePromise(promise2, x, resolve, reject);
                        } catch (e) {
                            reject(e);
                        }
                        
                    })
                })
                this.onRejectedCallbacks.push(reason=>{
                    setTimeout(()=>{
                        try {
                            const x=  onRejected(reason);
                        // x可能是一个proimise
                        Promise.resolvePromise(promise2, x, resolve, reject);
                        } catch (e) {
                            reject(e);
                        }
                        
                    })
                })
            }
        })
        return promise2

    }
}

//也称为魔法数字
Promise.PENDING = 'pending';
Promise.FULFILLED = 'fulfilled';
Promise.REJECTED = 'rejected';
// 循环调用
Promise.resolvePromise=function(promise2,x,resolve,reject){
// x与promise相等，说明自己在调用自己
let called; //是否调用过，防止无限循环调用
if(promise2===x){
    reject(new TypeError('Chaining cycle detected for promise'));
}
 if(x instanceof Promise){
//判断x是promise
x.then(value=>{
    // 如果返回的是promise,则要继续调用
    if(called) return;
    called = true;
    Promise.resolvePromise(promise2,value,resolve,reject);
},reason=>{
reject(reason);
})
}else if(x !==null && (typeof x ==='object'||typeof x ==='function')){
// x为对象或函数
let then = x.then;//官方推荐这么写，不明原因
if(typeof then === 'function'){
then.call(x,value=>{
    // 如果返回的是promise,则要继续调用
    if(called) return;
    called = true;
    Promise.resolvePromise(promise2,value,resolve,reject);
},reason=>{
    reject(reason);
})
}else{
    reject(x);
}
}else{
    resolve(x);
}
}
module.exports= Promise

index.js文件
console.log(1);
const  Promise = require('./promise.js') 
new Promise((resolve,reject)=>{
    console.log(2);
    setTimeout(()=>{
        resolve('我要执行')
    })
}).then(value=>{
    console.log(4);
    console.log('value:',value);
    // then返回一个promise
    return new Promise(resolve=>{
        resolve('promise');
    })
},reason=>{
    console.log('reason:',reason); 
}).then(value=>{
    console.log(5);
    console.log('value:',value);
})
console.log(3);
```

```js
//循环调用
// let p1=new Promise(resolve=>{
//     console.log('p1');
//     resolve(1);
// })
// let p2=p1.then(()=>{
//     console.log('p2');
//     return p2
// })
```

```js
//简约版手写Promise
class MyPromise {
  constructor(executor) {
    this.status = 'pending' // 初始状态为等待
    this.value = null // 成功的值
    this.reason = null // 失败的原因
    this.onFulfilledCallbacks = [] // 成功的回调函数数组
    this.onRejectedCallbacks = [] // 失败的回调函数数组
    let resolve = value => {
      if (this.status === 'pending') {
        this.status = 'fulfilled'
        this.value = value;
        this.onFulfilledCallbacks.forEach(fn => fn()) // 调用成功的回调函数
      }
    }
    let reject = reason => {
      if (this.status === 'pending') {
        this.status = 'rejected'
        this.reason = reason
        this.onRejectedCallbacks.forEach(fn => fn()) // 调用失败的回调函数
      }
    };
    try {
      executor(resolve, reject)
    } catch (err) {
      reject(err)
    }
  }
  then(onFulfilled, onRejected) {
    return new MyPromise((resolve, reject) => {
      if (this.status === 'fulfilled') {
        setTimeout(() => {
          const x = onFulfilled(this.value);
          x instanceof MyPromise ? x.then(resolve, reject) : resolve(x)
        })
      }
      if (this.status === 'rejected') {
        setTimeout(() => {
          const x = onRejected(this.reason)
          x instanceof MyPromise ? x.then(resolve, reject) : resolve(x)
        })
      }
      if (this.status === 'pending') {
        this.onFulfilledCallbacks.push(() => { // 将成功的回调函数放入成功数组
          setTimeout(() => {
            const x = onFulfilled(this.value)
            x instanceof MyPromise ? x.then(resolve, reject) : resolve(x)
          })
        })
        this.onRejectedCallbacks.push(() => { // 将失败的回调函数放入失败数组
          setTimeout(() => {
            const x = onRejected(this.reason)
            x instanceof MyPromise ? x.then(resolve, reject) : resolve(x)
          })
        })
      }
    })
  }
}

// 测试
function p1() {
  return new MyPromise((resolve, reject) => {
    setTimeout(resolve, 1000, 1)
  })
}
function p2() {
  return new MyPromise((resolve, reject) => {
    setTimeout(resolve, 1000, 2)
  })
}
p1().then(res => {
  console.log(res) // 1
  return p2()
}).then(ret => {
  console.log(ret) // 2
})
```

4.5自动化测试Promise代码

```
Promise.defer = Promise.deferred = function () {
  let dfd = {};
  dfd.promise = new Promise((resolve,reject)=>{
      dfd.resolve = resolve;
      dfd.reject = reject;
  })
  return dfd;
}

```

安装测试脚本

```
npm install -g promises-aplus-tests
```

执行自动化脚本

```
promises-aplus-tests promise.js
```

4.6promise.all原理

```
Promise.all = function(values) {
  if (!Array.isArray(values)) {
    const type = typeof values;
    return new TypeError(`TypeError: ${type} ${values} is not iterable`)
  }
  
  return new Promise((resolve, reject) => {
    let resultArr = [];
    let orderIndex = 0;
    const processResultByKey = (value, index) => {
      resultArr[index] = value;
      if (++orderIndex === values.length) {
          resolve(resultArr)
      }
    }
    for (let i = 0; i < values.length; i++) {
      let value = values[i];
      if (value && typeof value.then === 'function') {
        value.then((value) => {
          processResultByKey(value, i);
        }, reject);
      } else {
        processResultByKey(value, i);
      }
    }
  });
}

```

4.7如何中断promise

注意这里是中断而不是终止，因为 Promise 无法终止，这个中断的意思是：在合适的时候，把 pending 状态的 promise 给 reject 掉。例如一个常见的应用场景就是希望给网络请求设置超时时间，一旦超时就就中断，我们这里用定时器模拟一个网络请求，随机 3 秒之内返回

```js
function timeoutWrapper(p, timeout = 2000) {
  const wait = new Promise((resolve, reject) => {
    setTimeout(() => {
      reject('请求超时')
    }, timeout)
  })
  return Promise.race([p, wait])
}
```

## Promise、Generator、Async三者的区别

**Promise**

Promise有三种状态：pending(进行中)、resolved(成功)、rejected(失败)。

缺点：

- 无法取消Promise，一旦新建它就会立即执行，无法中途取消。
- 如果不设置回调函数，Promise内部抛出的错误，不会反应到外部。
- 当处于Pending状态时，无法得知目前进展到哪一个阶段（刚刚开始还是即将完成）。
- Promise 真正执行回调的时候，定义 Promise 那部分实际上已经走完了，所以 Promise 的报错堆栈上下文不太友好。

**Generator**

Generator 是ES6引入的新语法，Generator是一个可以暂停和继续执行的函数。

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

**Async(推荐使用～～)**

async await 本身就是 promise+generator 的语法糖

Async 是 Generator 的一个语法糖。

async 对应的是 * 。

await 对应的是 yield 。

async/await 自动进行了 Generator 的流程控制。

**为什么Async/Await更好？**

1. 使用async函数可以让代码简洁很多，不需要像Promise一样需要些then，不需要写匿名函数处理Promise的resolve值，也不需要定义多余的data变量，还避免了嵌套代码。
2. 错误处理：Async/Await 让 try/catch 可以同时处理同步和异步错误。

## reduce,every,some

reduce累加器

var total = [ 0, 1, 2, 3 ].reduce(( acc, cur ) => {    return acc + cur }, 0);

every一假即假

const flag=[ 0, 1, 2, 3 ].every(ele=> {    return ele>3 });

some一真即真

const flag=[ 0, 1, 2, 3 ].some(ele=> {    return ele>3 });

## Symbol

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



## weakset 和 weakmap

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

## for in、for of、forEach的区别

**for…of与for…in的区别**

- for…in循环会遍历（当前对象及其原型上的）每一个**属性名称**。
- for…of只能应用于**可迭代对象**，循环遍历（当前对象上的）每一个属性值.

**forEach**

是数组的一个方法，用于遍历数组的每一项，没有返回值，返回值总是undefined。

**for…of**

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

**for…in**

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
