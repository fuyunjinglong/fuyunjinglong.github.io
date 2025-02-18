---

title: JavaScript中的设计模式
date: 2023-03-15 06:33:16
categories:
- J_设计模式
toc: true # 是否启用内容索引
---

# 大纲

- [快速掌握前端必会的 7 种设计模式-video-mk](https://pan.baidu.com/disk/main?from=homeFlow#/index?category=all&path=%2F%E5%AD%A6%E4%B9%A0%E7%A7%91%E7%A0%94%2F200%E5%B7%A5%E4%BD%9C%2F%E8%AE%BE%E8%AE%A1%E6%A8%A1%E5%BC%8F%2FJS)

## 创建型

### 工厂模式

**小结：** 构造函数和创建对象分离，符合开放封闭原则。

**使用场景：** 比如根据权限生成不同用户。

工厂模式根据抽象程度可分为三种，分别为简单工厂、工厂方法和抽象工厂。其核心在于将创建对象的过程封装其他，然后通过同一个接口创建新的对象。 简单工厂模式又叫静态工厂方法，用来创建某一种产品对象的实例，用来创建单一对象。

```
// 简单工厂
class Factory {
  constructor (username, pwd, role) {
   this.username = username;
    this.pwd = pwd;
    this.role = role;
  }
}

class CreateRoleFactory {
 static create (username, pwd, role) {
   return new Factory(username, pwd, role);
  }
}

const admin = CreateRoleFactory.create('张三', '222', 'admin');
```

在实际工作中，各用户角色所具备的能力是不同的,可以考虑使用工厂方法来代替。工厂方法的本意是将实际创建对象的工作推迟到子类中。

```
class User {
constructor (name, menuAuth) {
   if (new.target === User) throw new Error('User 不能被实例化');
    this.name = name;
    this.menuAuth = menuAuth;
  }
}

class UserFactory extends User {
constructor (...props) {
   super(...props);
  }
  static create (role) {
   const roleCollection = new Map([
     ['admin', () => new UserFactory('管理员', ['首页', '个人中心'])],
      ['user', () => new UserFactory('普通用户', ['首页'])]
    ])
   
    return roleCollection.get(role)();
  }
}

const admin = UserFactory.create('admin');
console.log(admin); // {name: "管理员", menuAuth: Array(2)}
const user = UserFactory.create('user');
console.log(user); // {name: "普通用户", menuAuth: Array(1)}
```

随着业务形态的变化，一个用户可能在多个平台上同时存在，显然工厂方法也不再满足了，这时候就要用到抽象工厂。抽象工厂模式是对类的工厂抽象用来创建产品类簇，不负责创建某一类产品的实例。

```
class User {
  constructor (hospital) {
    if (new.target === User) throw new Error('抽象类不能实例化!');
    this.hospital = hospital;
  }
}
// 浙一
class ZheYiUser extends User {
  constructor(name, departmentsAuth) {
    super('zheyi_hospital');
    this.name = name;
    this.departmentsAuth = departmentsAuth;
  }
}
// 萧山医院
class XiaoShanUser extends User {
  constructor(name, departmentsAuth) {
    super('xiaoshan_hospital');
    this.name = name;
    this.departmentsAuth = departmentsAuth;
  }
}

const getAbstractUserFactory = (hospital) => {
  switch (hospital) {
    case 'zheyi_hospital':
      return ZheYiUser;
      break;
    case 'xiaoshan_hospital':
      return XiaoShanUser;
      break;
  }
}

const ZheYiUserClass = getAbstractUserFactory('zheyi_hospital');
const XiaoShanUserClass = getAbstractUserFactory('xiaoshan_hospital');

const user1 = new ZheYiUserClass('王医生', ['外科', '骨科', '神经外科']);
console.log(user1);
const user2 = newXiaoShanUserClass('王医生', ['外科', '骨科']);
console.log(user2);
```

### 单例模式

**小结：** 实例如果存在，直接返回已创建的，符合开放封闭原则。

**使用场景：** Redux、Vuex 等状态管理工具，还有我们常用的 window 对象、全局缓存等。

单例模式，就是保证一个类只能存在一个实例，并提供一个访问它的全局接口。单例模式又分懒汉式和饿汉式两种，其区别在于懒汉式在调用的时候创建实例，而饿汉式则是在初始化就创建好实例

```
// 懒汉式
class Single {
static getInstance () {
   if (!Single.instance) {
     Single.instance = new Single();
    }
    return Single.instance;
  }
}
const test1 = Single.getInstance();
const test2 = Single.getInstance();
console.log(test1 === test2); // true
```

```
// 饿汉式
class Single {
static instance = new Single();

  static getInstance () {
    return Single.instance;
  }
}
const test1 = Single.getInstance();
const test2 = Single.getInstance();
console.log(test1 === test2); // true
```

### 原型模式

**小结：** 原型模式最简单的实现方式---Object.create()。

**使用场景：** 新创建对象和已有对象无较大差别时，可以使用原型模式来减少创建新对象的成本。

当新创建的对象和已有对象存在较大共性时，可以通过对象的复制来达到创建新的对象，这就是原型模式。

```
// Object.create()实现原型模式
const user = {
name: 'zhangsan',
  age: 18
};
let userOne = Object.create(user);
console.log(userOne.__proto__); // {name: "zhangsan", age: 18}


// 原型链继承实现原型模式
class User {
constructor (name) {
   this.name = name;
  }
  getName () {
   return this.name;
  }
}

class Admin extends User {
constructor (name) {
   super(name);
  }
  setName (_name) {
   return this.name = _name;
  }
}

const admin = new Admin('zhangsan');
console.log(admin.getName());
console.log(admin.setName('lisi'));
```

## 结构型

### 装饰器模式

**小结：** 装饰器模式将现有对象和装饰器进行分离，两者独立存在，符合开放封闭原则和单一职责模式。

**使用场景：** es7 装饰器、vue mixins、core-decorators 等。

讲装饰器模式之前，先聊聊高阶函数。高阶函数就是一个函数就可以接收另一个函数作为参数。

```
const add = (x, y, f) => {
 return f(x) + f(y);
}
const num = add(2, -2, Math.abs);
```

add 相对于 Math.abs 来说相当于一个装饰器，因此这个例子也可以理解为一个简单的装饰器模式。在 react 中，高阶组件(HOC)也是装饰器模式的一种体现，通常用来不改变原来组件的情况下添加一些属性，达到组件复用的功能。

```
import React from 'react';
const BgHOC = WrappedComponent => class extends React.Component {
 render () {
   return (
     <div style={{ background: 'blue' }}>
       <WrappedComponent />
      </div>
    );
  }
}
```

### 适配器模式

**小结：** 不改变原有接口的情况下，统一接口、统一入参、统一出参、统一规则，符合开发封闭原则。

**使用场景** ：拥抱变化，兼容代码。

适配器别名包装器，其作用是解决两个软件实体间的接口不兼容的问题。以 axios 源码为例：

```
function getDefaultAdapter() {
  var adapter;
  // 判断当前是否是 node 环境
  if (typeof process !== 'undefined' && Object.prototype.toString.call(process) === '[object process]') {
    // 如果是 node 环境，调用 node 专属的 http 适配器
    adapter = require('./adapters/http');
  } else if (typeof XMLHttpRequest !== 'undefined') {
    // 如果是浏览器环境，调用基于 xhr 的适配器
    adapter = require('./adapters/xhr');
  }
  return adapter;
}

// http adapter
module.exports = function httpAdapter(config) {
  return new Promise(function dispatchHttpRequest(resolvePromise, rejectPromise) {
    ...
  }
}
// xhr adapter
module.exports = function xhrAdapter(config) {
  return new Promise(function dispatchXhrRequest(resolve, reject) {
    ...
  }
}
```

### 代理模式

**小结：** 通过修改代理类来增加功能，符合开放封闭模式。

**使用场景：** 图片预加载、缓存服务器、处理跨域以及拦截器等。

代理模式就是为对象提供一个代理，用来控制对这个对象的访问。在我们业务开发中最常见的有四种代理类型：事件代理，虚拟代理、缓存代理和保护代理。

虚拟代理，其最具代表性的例子就是图片预加载。解决方案是先给 img 标签展示一个占位图，然后创建一个 Image 实例，让这个实例的 src 指向真实的默认图片地址，当默认图片加载完成之后，再将 DOM 上的 img 标签的 src 属性指向真实图片地址。

```
class ProxyImg {
constructor (imgELe) {
   this.imgELe = imgELe;
    this.DEFAULT_URL = 'xxx';
  }
  setUrl (targetUrl) {
   this.imgEle.src = this.DEFAULT_URL;
    const image = new Image();
   
    image.onload = () => {
     this.imgEle.src = targetUrl;
    }
    image.src = targetUrl;
  }
}
```

缓存代理常用于一些计算量较大的场景。当计算的值已经被出现过的时候，不需要进行第二次重复计算。以传参求和为例：

```
const countSum = (...arg) => {
console.log('count...');
  let result = 0;
  arg.forEach(v => result += v);
  return result;
}

const proxyCountSum = (() => {
const cache = {};
  return (...arg) => {
   const args = arg.join(',');
    if (args in cache) return cache[args];
    return cache[args] = countSum(...arg);
  };
})()

proxyCountSum(1,2,3,4); // count...  10
proxyCountSum(1,2,3,4); // 10
```

## 行为型

### 策略模式

**小结：** 定义一系列算法，将其一一封装起来，并且使它们可相互替换。符合开放封闭原则。

**使用场景：** 表单验证、存在大量 if-else 场景、各种重构等。

介绍策略模式之前，简单实现一个常见的促销活动规则：

```
// 人人喊打的ifelse
const activity = (type, price) => {
 if (type === 'pre') {
   return price * 0.95;
  } else if (type === 'onSale') {
   return price * 0.9;
  } else if (type === 'back') {
   return price * 0.85;
  } else if (type === 'limit') {
   return price * 0.8;
  }
}
```

```
// 优雅的扩展性
const activity = new Map([
['pre', (price) => price * 0.95],
  ['onSale', (price) => price * 0.9],
  ['back', (price) => price * 0.85],
  ['limit', (price) => price * 0.8]
]);

const getActivityPrice = (type, price) => activity.get(type)(price);

// 新增新手活动
activity.set('newcomer', (price) => price * 0.7);
```

### 观察者模式

**小结：** 为解耦而生，为事件而生，符合开放封闭原则。

**使用场景：** 跨层级通信、事件绑定等。

观察者模式又叫发布-订阅模式，其用来定义对象之间的一对多依赖关系，以便当一个对象更改状态时，将通知其所有依赖关系。

```
// 定义发布者类
class Publisher {
  constructor () {
    this.observers = [];
    this.prdState = null;
  }
  // 增加订阅者
  add (observer) {
    this.observers.push(observer);
  }
  // 通知所有订阅者
  notify () {
    this.observers.forEach((observer) => {
      observer.update(this);
    })
  }
  // 该方法用于获取当前的 prdState
  getState () {
    return this.prdState;
  }

  // 该方法用于改变 prdState 的值
  setState (state) {
    // prd 的值发生改变
    this.prdState = state;
    // 需求文档变更，立刻通知所有开发者
    this.notify();
  }
}

// 定义订阅者类
class Observer {
  constructor () {
  this.prdState = {};
  }
  update (publisher) {
    // 更新需求文档
    this.prdState = publisher.getState();
    // 调用工作函数
    this.work();
  }
  // work 方法，一个专门搬砖的方法
  work () {
    // 获取需求文档
    const prd = this.prdState;
    console.log(prd);
  }
}

// 创建订阅者：前端开发小王
const wang = new Observer();
// 创建订阅者：后端开发小张
const zhang = new Observer();
// 创建发布者：产品经理小曾
const zeng = new Publisher();
// 需求文档
const prd = {
  url: 'xxxxxxx'
};
// 小曾开始拉人入群
zeng.add(wang);
zeng.add(zhang);
// 小曾发布需求文档并通知所有人
zeng.setState(prd);
```

# 设计模式的源码应用

## 单例模式(闭包的应用)

> 点击登录，弹出登录弹窗

```js
// 基础版
let createLogin = (function(){
    let div = null;
    return function(){
        if(!div){
            div = document.createElement('div');
            div.innerHTML = '我是登录的弹窗';
            div.style.display = 'none';
            document.body.append(div);
        }
        return div
    }
})()

document.getElementById('login').onclick = function(){
    let login = createLogin();
    login.style.display = 'block';
}

改进：单一职责的闭包
// 最经典的闭包
let getSingle = function(fn){
    let result = null;
    return function(){
        return result||(result = fn());
    }
}
// 单一职责
let createLogin = function(){
   let div = document.createElement('div');
   div.innerHTML = '我是登录的弹窗';
   div.style.display = 'none';
   document.body.append(div);
   return div
}
// 还可以创建createIframe等等
const singleLogin = getSingle(createLogin);
document.getElementById('login').onclick = function(){
    let login = singleLogin();
    login.style.display = 'block';
}
```



## **ES6-Promise观察者模式**

> - 通过 Promise.prototype.then 和 Promise.prototype.catch 方法将观察者方法注册到被观察者 Promise 对象中，同时返回一个新的 Promise 对象，以便可以链式调用。
>
> - 被观察者管理内部 pending、fulfilled 和 rejected 的状态转变，同时通过构造函数中传递的 resolve 和 reject 方法以主动触发状态转变和通知观察者。

## **Vue3-Proxy策略模式+代理模式**

> - Proxy的表单验证，使用各种策略校验数据类型
> - Proxy代理原始数据，进行数据劫持和代理

参考

- [探索两种优雅的表单验证](https://github.com/jawil/blog/issues/19)

**场景：前端表单校验**

- 所有选项不能为空
- 用户名长度不能少于6位
- 密码长度不能少于6位
- 手机号码必须符合格式
- 邮箱地址必须符合格式

**常规校验**

```
  let registerForm = document.querySelector('#registerForm')
  registerForm.addEventListener('submit', function() {
      if (registerForm.userName.value === '') {
          alert('用户名不能为空！')
          return false
      }
      if (registerForm.userName.length < 6) {
          alert('用户名长度不能少于6位！')
          return false
      }
      if (registerForm.passWord.value === '') {
          alert('密码不能为空！')
          return false
      }
      if (registerForm.passWord.value.length < 6) {
          alert('密码长度不能少于6位！')
          return false
      }
      if (registerForm.phoneNumber.value === '') {
          alert('手机号码不能为空！')
          return false
      }
      if (!/^1(3|5|7|8|9)[0-9]{9}$/.test(registerForm.phoneNumber.value)) {
          alert('手机号码格式不正确！')
          return false
      }
      if (registerForm.emailAddress.value === '') {
          alert('邮箱地址不能为空！')
          return false
      }
      if (!/^\w+([+-.]\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*
      $/.test(registerForm.emailAddress.value)) {
          alert('邮箱地址格式不正确！')
          return false
      }
  }, false)
```

但存在很多问题，比如：

> - `registerForm.addEventListener`绑定的函数比较庞大，包含了很多的`if-else`语句，看着都恶心，这些语句需要覆盖所有的校验规则。
> - `registerForm.addEventListener`绑定的函数缺乏弹性，如果增加了一种新的校验规则，或者想要把密码的长度校验从6改成8，我们都必须深入`registerForm.addEventListener`绑定的函数的内部实现，这是违反了开放-封闭原则的。
> - 算法的复用性差，如果程序中增加了另一个表单，这个表单也需要进行一些类似的校验，那我们很可能将这些校验逻辑复制得漫天遍野。

**用策略模式重构表单校验**

> 思路：一键验证，使用策略模式，核心思想:将做什么和谁去做相分离

策略模式的组成

- 抽象策略角色：策略类，通常由一个接口或者抽象类实现。
- 具体策略角色：包装了相关的算法和行为。
- 环境角色：持有一个策略类的引用，最终给客户端用的。

具体策略角色——编写策略类

```
/*策略对象*/
const strategies = {
        isNonEmpty(value, errorMsg) {
            return value === '' ?
                errorMsg : false
        },
        minLength(value, length, errorMsg) {
            return value.length < length ?
                errorMsg : false
        },
        isMoblie(value, errorMsg) {
            return !/^1(3|5|7|8|9)[0-9]{9}$/.test(value) ?
                errorMsg : false
        },
        isEmail(value, errorMsg) {
            return !/^\w+([+-.]\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*$/.test(value) ?
                errorMsg : false
        }
    }
```

抽象策略角色——编写Validator类

```
/*Validator类*/
class Validator {
    constructor() {
        this.cache = [] //保存校验规则
    }
    add(value,name,...other) {
        this.cache.push(strategies[name])
    }
    start() {
        for (let validatorFunc of this.cache) {
            let errorMsg = validatorFunc()//开始校验，并取得校验后的返回信息
            if (errorMsg) {//r如果有确切返回值，说明校验没有通过
                return errorMsg
            }
        }
    }
}
```

环境角色——客户端调用代码

```
// 获取表单form元素
let registerForm = document.querySelector('#registerForm')
function validatorFunc(){
    // 创建表单校验实例
    let validator = new Validator();
    // 编写校验配置
    validator.add(registerForm.userName, 'isNonEmpty', '用户名不能为空')
    validator.add(registerForm.userName, 'minLength', '用户名长度不能小于6')
    // 开始校验，并接收错误信息
    let errorMsg = validator.start()
    // 如果有错误信息输出，说明校验未通过
    if(errorMsg){
        alert(errorMsg)
        return false//阻止表单提交
    }
}
validatorFunc()
```

**策略模式的优缺点**

- 策略模式利用组合、委托和多态等技术思想，可以有效的避免多种条件选择语句；
- 策略模式提供了对开放-封闭原则的完美支持，将算法封装在独立的strategy中，使得它易于切换，易于理解，易于拓展；
- 策略模式中的算法也可以复用在系统的其它地方，从而避免了许多重复的复制黏贴的工作；
- 在策略模式利用组合和委托来让Context拥有执行算法的能力，这也是继承一种更轻便的替代方案。

当然，策略模式也有一些缺点，但掌握了策略模式，这些缺点并不严重。

- 编写难度加大，代码量变多了，这是最直观的一个缺点，也算不上缺点，毕竟不能完全以代码多少来衡量优劣。
- 首先，使用策略模式会在程序中增加许多策略类或者策略对象，但实际上这比把它们负责的逻辑堆砌在Context中要好。
- 其次，要使用策略模式，必须了解所有的strategy，必须了解各个strategy之间的不同点，这样才能选择一个合适的strategy。比如，我们要选择一种合适的旅游出行路线，必须先了解选择飞机、火车、自行车等方案的细节。此时strategy要向客户暴露它的所有实现，这是违反最少知识原则的。

**参考**

[16种JavaScript设计模式（中）](https://juejin.cn/post/6844903734091186189#heading-1)

