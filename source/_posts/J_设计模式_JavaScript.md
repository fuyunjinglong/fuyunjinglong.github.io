---

title: JavaScript中的设计模式
date: 2023-03-15 06:33:16
categories:
- J_设计模式
toc: true # 是否启用内容索引
---

# 设计模式的源码应用

**ES6-Promise观察者模式**

> - 通过 Promise.prototype.then 和 Promise.prototype.catch 方法将观察者方法注册到被观察者 Promise 对象中，同时返回一个新的 Promise 对象，以便可以链式调用。
>
> - 被观察者管理内部 pending、fulfilled 和 rejected 的状态转变，同时通过构造函数中传递的 resolve 和 reject 方法以主动触发状态转变和通知观察者。

**Vue3-Proxy策略模式+代理模式**

> - Proxy的表单验证，使用各种策略校验数据类型
> - Proxy代理原始数据，进行数据劫持和代理

**参考**

[16种JavaScript设计模式（中）](https://juejin.cn/post/6844903734091186189#heading-1)

