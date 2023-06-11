---
title: Vue3.0_原理
date: 2023-09-12 07:33:16
categories:
- D_框架和类库
toc: true # 是否启用内容索引
---

# 入门

## 生命周期

![](/img/vue3生命周期.png)

## Proxy是代理，Reflect是干嘛用的？

准确讲应该是这样的，Reflect更像是一种语法变体，其挂在的所有方法都能找到对应的原始语法，也就是Reflect的替代性非常强。

比较常用的两个方法就是`get()`和`set()`方法：

```
Reflect.get(target, propertyKey)
Reflect.set(target, propertyKey, value)
```

等效于

```
target[propertyKey]
target[propertyKey] = value;
```

Reflect对象经常和Proxy代理一起使用，原因有三点：

1. Reflect提供的所有静态方法和Proxy第2个handle参数方法是一模一样的。
2. Proxy get/set()方法需要的返回值正是Reflect的get/set方法的返回值，可以天然配合使用，比直接对象赋值/获取值要更方便和准确(通过返回值知道是否赋值成功，并不会因为报错而中断正常代码执行)。
3. receiver参数具有不可替代性。

**关于receiver参数**

receiver是接受者的意思，表示调用对应属性或方法的主体对象，通常情况下，receiver参数是无需使用的，但是如果发生了继承，为了*明确调用主体*，receiver参数就需要出马了。

```
let miaoMiao = {
  _name: '疫苗',
  get name () {
    return this._name;
  }
}
let miaoXy = new Proxy(miaoMiao, {
  get (target, prop, receiver) {
    return target[prop];
  }
});

let kexingMiao = {
  __proto__: miaoXy,
  _name: '科兴疫苗'
};

// 结果是疫苗
console.log(kexingMiao.name);
```

实际上，这里预期显示应该是“科兴疫苗”，而不是“疫苗”。

这个时候，就需要使用`receiver`参数了，代码变化部分参见下面标红的那一行：

```
return Reflect.get(target, prop, receiver);
// 也可以简写为 Reflect.get(...arguments) 
```

# 进阶





