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

| Vue2          | Vue3               |
| ------------- | ------------------ |
| beforeCreate  | ❌setup(替代)       |
| created       | ❌setup(替代)       |
| beforeMount   | onBeforeMount      |
| mounted       | onMounted          |
| beforeUpdate  | onBeforeUpdate     |
| updated       | onUpdated          |
| beforeDestroy | onBeforeUnmount    |
| destroyed     | onUnmounted        |
| errorCaptured | onErrorCaptured    |
|               | 🎉onRenderTracked   |
|               | 🎉onRenderTriggered |

**新增的钩子函数onRenderTracked()和 onRenderTriggered()**

onRenderTracked()

> 直译过来就是`状态跟踪`，它会跟踪页面上所有响应式变量和方法的状态。只要页面有`update`的情况，他就会跟踪，然后生成一个`event`对象。

onRenderTriggered()

> 直译过来是`状态触发`，它不会跟踪每一个值，而是给你变化值的信息，并且新值和旧值都会给你明确的展示出来。 与`watch`相似。
>
> event 对象属性的详细介绍：
>
> - key 那边变量发生了变化
> - newValue 更新后变量的值
> - oldValue 更新前变量的值
> - target 目前页面中的响应变量和函数

```vue
<template>
  <div class="about">
    <h2>msg: {{ msg }}</h2>
    <hr />
    <button @click="update">更新</button>
  </div>
</template>

<script lang="ts">
import { ref, onMounted, onUpdated, onUnmounted, onBeforeMount, onBeforeUpdate, onBeforeUnmount } from 'vue'

export default {
  beforeCreate() {
    console.log('beforeCreate()')
  },

  created() {
    console.log('created')
  },

  beforeMount() {
    console.log('beforeMount')
  },

  mounted() {
    console.log('mounted')
  },

  beforeUpdate() {
    console.log('beforeUpdate')
  },

  updated() {
    console.log('updated')
  },

  beforeUnmount() {
    console.log('beforeUnmount')
  },

  unmounted() {
    console.log('unmounted')
  },

  setup() {
    const msg = ref('abc')

    const update = () => {
      msg.value += '--'
    }

    onBeforeMount(() => {
      console.log('--onBeforeMount')
    })

    onMounted(() => {
      console.log('--onMounted')
    })

    onBeforeUpdate(() => {
      console.log('--onBeforeUpdate')
    })

    onUpdated(() => {
      console.log('--onUpdated')
    })

    onBeforeUnmount(() => {
      console.log('--onBeforeUnmount')
    })

    onUnmounted(() => {
      console.log('--onUnmounted')
    })

    return {
      msg,
      update
    }
  }
}
</script>
```

```vue
<template>
  <h2>App</h2>
  <button @click="isShow = !isShow">切换</button>
  <hr />
  <Child v-if="isShow" />
</template>

<script lang="ts">
import Child from './Child.vue'
export default {
  data() {
    return {
      isShow: true
    }
  },

  components: {
    Child
  }
}
</script>
```

**单组件**

> 页面首次加载
>
> ```
> setup -> onBeforeMount -> onRenderTracked -> onMounted
> ```
>
> 页面更新
>
> ```
> onRenderTriggered -> onBeforeUpdate -> onUpdated
> ```
>
> 页面卸载
>
> ```
> onBeforeUnmount -> onUnmounted
> ```

## **父子组件生命周期更新顺序**

> **页面首次加载**
>
> ```
> 父组件setup -> 父组件onBeforeMount -> 父组件onRenderTracked -> 子组件setup -> 子组件onBeforeMount -> 子组件onRenderTracked -> 子组件onMounted -> 父组件onMounted
> ```
>
> **页面更新**
>
> 纯父组件属性更新 `onRenderTriggered -> onBeforeUpdate -> onUpdated`
>
> 纯子组件属性更新 `onRenderTriggered -> onBeforeUpdate -> onUpdated`
>
> 父组件属性更新，该属性在子组件中有被使用 `父组件onRenderTriggered -> 父组件onBeforeUpdate -> 子组件onBeforeUpdate -> 子组件onUpdated -> 父组件onUpdated`
>
> 子组件属性更新，该属性在父组件中有被使用 `子组件onRenderTriggered -> 父组件onRenderTriggered -> 父组件onBeforeUpdate -> 子组件onBeforeUpdate -> 子组件onUpdated -> 父组件onUpdated`
>
> **页面卸载**
>
> ```
> 父组件onBeforeUnmount -> 子组件onBeforeUnmount -> 子组件onUnmounted -> 父组件onUnmounted
> ```

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





