---
title: 面试题-1
date: 2021-11-01 06:33:16
categories:
- AA_面试
toc: true # 是否启用内容索引
---

# 0.优秀博客

+ 【👍 5059】[一个合格(优秀)的前端都应该阅读这些文章](https://juejin.im/post/6844903896637259784)
+ 【👍 4695】[2018前端面试总结，看完弄懂，工资少说加3K | 掘金技术征文](https://juejin.im/post/6844903673009553416)
+ 【👍 4425】[中高级前端大厂面试秘籍，为你保驾护航金三银四，直通大厂(上)](https://juejin.im/post/6844903776512393224)
+ 【👍 3013】[2018春招前端面试: 闯关记(精排精校) | 掘金技术征文](https://juejin.im/post/6844903570001625102)
+ 【👍 2493】[前端面试考点多？看这些文章就够了（2019年6月更新版）](https://juejin.im/post/6844903577220349959)
+ [一名【合格】前端工程师的自检清单](https://juejin.cn/post/6844903830887366670)
+ [JS 原生面经从初级到高级【近1.5W字】](https://juejin.cn/post/6844903976081555470#heading-97)
+ [技术胖155集前端](https://juejin.cn/post/6844903550552637454)
+ [一个合格的中级前端](https://juejin.cn/post/6844903856489365518#heading-14)
+ [冴羽的博客](https://github.com/mqyqingfeng/Blog)
+ [一个优秀的前端都应该阅读这些文章](https://github.com/Nealyang/PersonalBlog/issues/48)
+ [阿里我是如何当面试官](https://juejin.cn/post/6844904093425598471)
+ [写给初中级前端的高级进阶指南](https://juejin.cn/post/6844904103504527374)
+ [我是如何零基础入门前端开发的（2021 版）](https://chinese.freecodecamp.org/news/how-do-i-learn-front-end-development-in-2021/)

# 1.JavaScript

- 讲讲js数据类型？基本和引用的区别？symbol和bigint讲一讲应用场景？
- 判断数据类型的方法？instanceof原理?判断空对象？ typeof null？typeof NaN？
- var/let/const 区别？暂时性死区？块级作用域？const a = {}; a.x = 1 能不能修改？
- 说说你对函数式编程的理解？函数柯里化的理解？平时的使用场景？
- 防抖、节流的含义，使用场景？手写一下？
- call、apply、bind区别？bind实现？bind之后还能修改this指向吗？为什么？
- 闭包概念，最主要的还是问闭包的场景？
- 用es5实现es6类的继承？各种继承问的挺多的
- 深拷贝与浅拷贝？常用方法？手写一个深拷贝函数？
- 说说你知道的JavaScript设计模式？观察者和发布订阅的区别？手写一个发布订阅？我真的写了
- 说说对你对JavaScript异步编程的理解？
- ES Module与 CommonJS 模块的差异？两者互相加载的方式？一般会扯到AMD
- Promise.all、race、allSettled 概念、手写？很多手写题都会用到，比如用promise实现请求并发个数限制？

# 2.CSS

- 水平垂直居中？兼容性？不知道宽高情况下？
- BFC概念？作用？常用场景？
- Flex？注意flex：1的含义，一般会给你个场景题
- 盒模型概念，如何切换盒模型？
- 实现1px边框？1px线条？
- 伪类和伪元素区别？使用场景？

# 3.Http &浏览器

- 浏览器缓存？http缓存？ 主要要讲一讲强缓存、协商缓存、preload、prefetch、Service Worker等，304的含义？协商缓存e-tag是怎么生成的？Last-Modified是基于什么生成的？两者对比一下？优先级哪个高？
- 什么是跨域？什么情况下会跨域？浏览器根据什么字段判断是否允许跨域？跨域的解决方案有哪些？options请求了解过吗？说说CORS中的简单请求和复杂请求？form表单提交会跨域吗？
- 讲一讲浏览器事件循环Event Loop？node 事件循环描述一下？
- http2有哪些新特性？http2还有哪些缺陷？http3的一些了解？
- 从输入 URL 到页面加载完成的过程，一般要很详细的描述：包括DNS查询，缓存查询，3次握手，4次挥手，浏览器渲染进程等，面试官会从里面再挑几个问题深入问，比如为什么是3次握手4次挥手？渲染进程中的GUI渲染线程、JS引擎线程、事件触发线程等等？可能会问到进程线程的区别？浏览器为什么是多进程？js为什么是单线程？怎么支持多线程？等等
- https加密原理？主要是讲对称加密和非对此加密结合使用的一个过程。什么是中间人攻击？和http区别？



# 4.VUE

- 生命周期？那个生命周期可以获取到真实DOM？修改data里面的数据，会触发什么生命周期？
- 组件data为什么是一个函数？
- vue 组件通信？一般说了vuex，就会问vuex用法？action和mutations区别？实现原理等？
- vue 导航守卫，分全局和组件的，一般用于权限控制，这个就可能扯到项目中的一些鉴权问题。
- $nextTick 作用？实现原理？微任务向宏任务的降级处理，经常被问到说出几种宏任务，微任务。
- vue响应式原理？基本都会问
- vue scoped属性作用？实现原理？
- vue router有几种模式？实现方式？
- key的作用？没有key的情况，vue会怎么做？会引出diff的问题
- vue diff过程，和react diff区别？
- vue 2.x defineProperty缺陷？业务代码里面怎么处理？$set原理？vue是怎么重写数组方法的？考察你是不是真的看过源码
- vue 3.0 proxy优缺点？怎么处理vue3不支持IE？
- computed 和 watch 的区别和运用的场景？除了基本的，看你能不能说出三种watcher的区别

# 5.React

- 生命周期详细描述一下？官方为什么改变？
- 说说你对虚拟DOM的理解？直接全量更新和diff哪个快（这个问题要分情况）？
- 什么是HOC？React里面用过哪些？可能让你实现一个add(1)(2)(3)的函数
- Fiber干了什么事情？requestIdleCallback了解多少？
- react性能优化？
- hooks出现的意义？类组件和函数组件之间的区别是什么？
- 为什么不要在循环、条件语句或者嵌套函数中调用hooks？记住官网的一句话，Not Magic, just Arrays
- setState 同步还是异步？比较常问，问的可能也比较深入
- 如何避免组件的重新渲染？memo/useMemo、PureComponent？useMemo和useCallback区别？



# 6.其他

- webpack 构建流程？打包原理？
- 项目中做的一些优化？
- loader和plugin的区别？有没有写过？常用哪些loader和plugin
- webpack热跟新原理？
- tree-shaking？对于 CommonJS，tree shaking怎么办？
- webpack loader的执行顺序？从左到右？从上到下？
- 项目做过的一些性能优化，基本必问
- 长列表渲染怎么优化？
- 各种懒加载的实现原理？路由？图片？
- Typescript 中的 interface 和 type 到底有什么区别