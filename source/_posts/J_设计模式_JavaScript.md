---

title: JavaScript中的设计模式
date: 2023-03-15 06:33:16
categories:
- J_设计模式
toc: true # 是否启用内容索引
---

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

