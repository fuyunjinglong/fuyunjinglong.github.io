---
title: Vue3.0原理
date: 2023-09-12 07:33:16
categories:
- D_框架和类库
toc: true # 是否启用内容索引
---

# 入门

# 进阶

## Object.defineProperty与Proxy 

**前言**

Vue都是采用数据劫持代理+发布订阅模式方式实现，vue2到vue3的差别是数据劫持的方式由Object.defineProperty更改为Proxy代理，其他代码不变。

**Proxy 的优势**如下:

- Proxy 可以直接监听对象而非属性
- Proxy 可以直接监听数组的变化

- Proxy 有多达 13 种拦截方法,不限于 apply、ownKeys、deleteProperty、has 等等是 Object.defineProperty 不具备的
- Proxy 返回的是一个新对象,我们可以只操作新的对象达到目的,而 Object.defineProperty 只能遍历对象属性直接修改
- Proxy 作为新标准将受到浏览器厂商重点持续的性能优化，也就是传说中的新标准的性能红利

**Object.defineProperty 的优势**如下:

- 兼容性好,支持 IE9

**一、Object.defineProperty**

```
<script>
        let number = 20
        let person = {
            age:18,
            name:'luwen'
        }
        Object.defineProperty(person,'age',{
            // value:10, //初值
            // enumerable:true,//属性是否支持枚举,默认false
            // writable:true,//属性是否支持修改,默认false
            // configurable:true,//属性是否支持删除,默认false
            get(){
                console.log('读取age属性');
                return number
            },
            set(value){
                console.log('修改了age值',value);
                number = value
            }
        })
        person.age = '6'
        console.log('person',person);
        console.log('number',number);
    </script>
```

**Object.defineProperty缺点**

1、**在Vue中，Object.defineProperty没法监控到数组下标的变化，致使直接经**由过程数组的下标给数组设置值，不能及时相应。为了处置惩罚这个题目，经由vue内部处置惩罚后可以运用以下几种要领来监听数组，**分别是push() 、pop() 、shift()、 unshift() 、splice() 、sort()、 reverse()，Vue.set()对于数组的处理其实就是调用了splice方法**。

2、Object.defineProperty只能挟制对象的属性,因而我们须要对每一个对象的每一个属性举行遍历。Vue里，是经由过程递归以及遍历data对象来完成对数据的监控的，假如属性值也是对象那末须要深度遍历,明显假如能挟制一个完全的对象，不管是对操纵性照样机能都邑有一个很大的提拔。



**二、Proxy** 

**Proxy** 也就是代理，可以帮助我们完成很多事情，例如对数据的处理，对构造函数的处理，对数据的验证，说白了，就是在我们访问对象前添加了一层拦截，可以过滤很多操作，而这些过滤，由你来定义，因此提供了一种机制，可以对外界的访问进行过滤和改写。

语法：

```js
let p = new Proxy(target, handler);
```

`target` ：需要使用`Proxy`包装的目标对象（可以是任何类型的对象，包括原生数组，函数，甚至另一个代理）。

`handler`: 一个对象，其属性是当执行一个操作时定义代理的行为的函数(可以理解为某种触发器)。具体的`handler`相关函数请查阅官网。

```js
  let w3cjs = {
     name: "w3cjs",
     age: 99
  };
  w3cjs = new Proxy(w3cjs, {
    get(target, key) {
         let result = target[key];
         //如果是获取 年龄 属性，则添加 岁字
         if (key === "age") result += "岁";
         return result;
    },
    set(target, key, value) {
           if (key === "age" && typeof value !== "number") {
           throw Error("age字段必须为Number类型");
        }
        return Reflect.set(target, key, value);
    }
  });
  console.log(`我叫${w3cjs.name}  我今年${w3cjs.age}了`);
  w3cjs.age = 100;
```

上方案例中定义了 **w3cjs**对象，其中有 **age** 和 **name** 两个字段,我们在`Proxy`中的 **get** 拦截函数中添加了一个判断，如果是取 **age** 属性的值，则在后面添加 **岁**。在 **set** 拦截函数中判断了如果是更改 **age** 属性时，类型不是 `Number`则抛出错误。最后输出正确结果：我叫w3cjs 我今年99岁了。

**Proxy支持拦截的操作，一共有13种：**

- **get(target, propKey, receiver)**：拦截对象属性的读取，比如 `proxy.foo` 和`proxy['foo']`。
- **set(target, propKey, value, receiver)**：拦截对象属性的设置，比如`proxy.foo = v` 或 `proxy['foo'] = v`，返回一个布尔值。
- **has(target, propKey)**：拦截 `propKey in proxy` 的操作，返回一个布尔值。
- **deleteProperty(target, propKey)**：拦截 `delete proxy[propKey]`的操作，返回一个布尔值。
- **ownKeys(target)**：拦截 `Object.getOwnPropertyNames(proxy)`、`Object.getOwnPropertySymbols(proxy)`、`Object.keys(proxy)`、`for...in`循环，返回一个数组。该方法返回目标对象所有自身的属性的属性名，而`Object.keys()`的返回结果仅包括目标对象自身的可遍历属性。
- **getOwnPropertyDescriptor(target, propKey)**：拦截`Object.getOwnPropertyDescriptor(proxy, propKey)`，返回属性的描述对象。
- **defineProperty(target, propKey, propDesc)**：拦截`Object.defineProperty(proxy, propKey, propDesc）`、`Object.defineProperties(proxy, propDescs)`，返回一个布尔值。
- **preventExtensions(target)**：拦截`Object.preventExtensions(proxy)`，返回一个布尔值。
- **getPrototypeOf(target)**：拦截`Object.getPrototypeOf(proxy)`，返回一个对象。
- **isExtensible(target)**：拦截`Object.isExtensible(proxy)`，返回一个布尔值。
- **setPrototypeOf(target, proto)**：拦截`Object.setPrototypeOf(proxy, proto)`，返回一个布尔值。如果目标对象是函数，那么还有两种额外操作可以拦截。
- **apply(target, object, args)**：拦截 Proxy 实例作为函数调用的操作，比如`proxy(...args)`、`proxy.call(object, ...args)`、`proxy.apply(...)`。
- **construct(target, args)**：拦截 Proxy 实例作为构造函数调用的操作，比如`new proxy(...args)`。

