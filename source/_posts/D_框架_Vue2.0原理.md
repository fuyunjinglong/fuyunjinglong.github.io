---
title: Vue2.0原理
date: 2023-09-12 07:33:16
categories:
- D_框架和类库
toc: true # 是否启用内容索引
---

# 入门

## Vue 的生命周期

[vue生命周期详细全过程](https://blog.csdn.net/m0_70477767/article/details/124684195)

![](/img/vue生命周期.png)

1.**beforeCreate**钩子函数

a.用户使用 new Vue()新建 Vue 实例

b.父实例实例化子实例，确认组件间的父子关系，将父组件的自定义事件传递给子组件

c.初始化将 render 函数转为虚拟 dom 的方法

**2. created**钩子函数:

a.初始化事件，进行数据的观测

b.数据已经和**data\*\***属性进行绑定\*\*（放在 data 中的属性当值发生改变的同时，视图也会改变）

c.此时还是没有 el 选项

**3.** **beforeMount**钩子函数：

a.**el\*\***选项**。**如果有的话就继续向下编译，如果没有**el 选项**，则停止编译，也就意味着停止了\***\*生命周期。**

b.如删掉 el: ‘#app’

c.template 参数

（1）如果 vue 实例对象中有 template 参数选项，则将其作为模板编译成 render 函数。
（2）如果没有 template 选项，则将外部 HTML 作为模板编译。
（3）可以看到 template 中的模板优先级要高于 outer HTML 的优先级。

**4. mounted**

a.给 vue 实例对象添加$el 成员，beforeMount 之前 el 上还是 undefined

b.mounted 之前 h1 中还是通过**{{message}}**进行占位的，因为此时还有挂载到页面上，还是 JavaScript 中的虚拟 DOM 形式存在的。在 mounted 之后可以看到 h1 中的内容发生了变化。

**5.** **beforeUpdate**

a.vue 发现 data 中的数据发生了改变，则在下一次时间循环开始重新渲染组件

**6. updated**

a.重新执行 render 函数生成 vnode。

b.将 vnode 转化为真实 Dom

c.重新挂载到 HTML 中，并且覆盖掉上一次渲染的$el

**7.** **beforeDestroy**:

a.调用 vm.$destroy()准备销毁 vue 实例

b.beforeDestroy 钩子函数在实例销毁之前调用。在这一步，实例仍然完全可用。

**8. destroyed**:

a.在 Vue 实例销毁后调用，调用后，Vue 实例指示的所有东西都会解绑定，所有的事件监听器会被移除，所有的子实例也会被销毁。

## 父子组件生命周期顺序

父组件先创建，然后子组件创建；子组件先挂载，然后父组件挂载。

```text
父beforeCreate-> 父create -> 子beforeCreate-> 子created -> 子mounted -> 父mounted
```

#### 