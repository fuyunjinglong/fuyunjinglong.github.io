---
title: Vue2和Vue3比较
date: 2023-09-12 07:33:16
categories:
- D_框架和类库
toc: true # 是否启用内容索引


---

# 入门

## 体系架构比较

Vue.js 从 1.x 到 2.0 版本，最大的升级就是引入了虚拟 DOM 。它为后续做服务端渲染以及跨端框架 Weex 提供了基础。

Vue2.0很多需要解决的痛点,比如源码自身的维护性，数据量大后带来的渲染和更新的性能问题.

Vue3.0从**源码、性能和语法 API** 三个大的方面优化框架，vue3是一个比较好符合开源标准的工程化解决方案。

> 1. 源码优化，采用monorepo 方式，形成高内聚、低耦合的代码层次结构
> 2. 性能优化，响应式系统、代码体积、编译阶段做了大幅优化
> 3. 语法API，采用组合式API,更高效的代码逻辑组织和复用

**1.源码优化**

(1)代码管理方式

- 语法开销体积e.js 2.x 的源码托管在 src 目录，然后依据功能拆分出了 compiler（模板编译的相关代码）、core（与平台无关的通用运行时代码）、platforms（平台专有代码）、server（服务端渲染的相关代码）、sfc（.vue 单文件解析相关代码）、shared（共享工具代码）等目录。
- Vue.js 3.0，整个源码是通过 monorepo 的方式维护的，根据功能将不同的模块拆分到不同的目录中，每个模块有各自的API类型定义和测试。这样使得模块拆分更细化，职责划分更明确，模块之间的依赖关系也更加明确，开发人员也更容易阅读、理解和更改所有模块源码，提高代码的可维护性。

Vue.js 2.x

```
源码托管在 src 目录
src
├── compiler        # 编译相关
├── core            # 核心代码
├── platforms       # 不同平台的支持
├── server          # 服务端渲染
├── sfc             # .vue 文件解析
├── shared          # 共享代码
```

Vue.js 3.0

```
@vue
├── compiler-core
│   ├── LICENSE
│   ├── README.md
│   ├── dist
│   │   ├── compiler-core.cjs.js
│   │   ├── compiler-core.cjs.prod.js
│   │   ├── compiler-core.d.ts
│   │   └── compiler-core.esm-bundler.js
│   ├── index.js
│   └── package.json
├── compiler-dom
```

(2)类型检查

- Vue.js 2.x 选用 Flow 做类型检查，来避免一些因类型问题导致的错误，但是 Flow 对于一些复杂场景类型的检查，支持得并不好。
- Vue.js 3.0 抛弃了 Flow ，使用 TypeScript 重构了整个项目。 TypeScript 提供了更好的类型检查，能支持复杂的类型推导；由于源码就使用 TypeScript 编写，也省去了单独维护 d.ts 文件的麻烦。

**2.性能优化**

(1)响应式优化

vue2缺陷

> - 它必须预先知道要拦截的 key 是什么，所以它并不能检测对象属性的添加和删除。尽管 Vue.js 为了解决这个问题提供了 $set 和 $delete 实例方法；
> - 对于嵌套层级较深的对象，如果要劫持它内部深层次的对象变化，就需要递归遍历这个对象，执行 Object.defineProperty 把每一层对象数据都变成响应式的。如果我们定义的响应式数据过于复杂，这就会有相当大的性能损耗；

vue3弥补上述缺陷

> 使用了 Proxy API 做数据劫持，它劫持的是整个对象，对于对象的属性的增加和删除都能检测到。
>
> Proxy API 并不能监听到内部深层次的对象变化，因此 Vue.js 3.0 的处理方式是在 getter 中去递归响应式，这样的好处是真正访问到的内部对象才会变成响应式，而不是无脑递归，这样无疑也在很大程度上提升了性能，我会在后面分析响应式章节详细介绍它的具体实现原理 。

a.改用proxy api做数据劫持

- Vue.js 2.x 内部是通过 Object.defineProperty 这个 API 去劫持数据的 getter 和 setter 来实现响应式的。这个 API 有一些缺陷，它必须预先知道要拦截的 key 是什么，所以它并不能检测对象属性的添加和删除。
- Vue.js 3.0 使用了 Proxy API 做数据劫持，它劫持的是整个对象，自然对于对象的属性的增加和删除都能检测到。

b.响应式是惰性的

- 在 Vue.js 2.x 中，对于一个深层属性嵌套的对象，要劫持它内部深层次的变化，就需要递归遍历这个对象，执行 Object.defineProperty 把每一层对象数据都变成响应式的，这无疑会有很大的性能消耗。
- 在 Vue.js 3.0 中，使用 Proxy API 并不能监听到对象内部深层次的属性变化，因此它的处理方式是在 getter 中去递归响应式，这样的好处是真正访问到的内部属性才会变成响应式，简单的可以说是按需实现响应式，就没有那么大的性能消耗。

(2)体积优化

a.引入tree-shaking的技术

- tree-shaking 依赖 ES2015 模块语法的静态结构（即 import 和 export），通过编译阶段的静态分析，找到没有引入的模块并打上标记。像我们在项目中没有引入 Transition、KeepAlive 等不常用的组件，那么它们对应的代码就不会打包进去。

b.移除了一些冷门的feature

- Vue.js 3.0 兼容了 Vue.js 2.x 绝大部分的api，但还是移除了一些比较冷门的feature：如 keyCode 支持作为 v-on 的修饰符、$on，$off 和 $once 实例方法、filter过滤、内联模板等。

(3)编译优化

a.生成block tree

- Vue.js 2.x 的数据更新并触发重新渲染的粒度是组件级的，单个组件内部需要遍历该组件的整个 vnode 树。
- Vue.js 3.0 做到了通过编译阶段对静态模板的分析，编译生成了 Block tree。Block tree 是一个将模版基于动态节点指令切割的嵌套区块，每个区块内部的节点结构是固定的。每个区块只需要追踪自身包含的动态节点。

b.slot编译优化

- Vue.js 2.x 中，如果有一个组件传入了slot，那么每次父组件更新的时候，会强制使子组件update，造成性能的浪费。
- Vue.js 3.0 优化了slot的生成，使得非动态slot中属性的更新只会触发子组件的更新。动态slot指的是在slot上面使用v-if，v-for，动态slot名字等会导致slot产生运行时动态变化但是又无法被子组件track的操作。

c.diff算法优化

- 能力有限,可以看下这篇文章：[https://blog.csdn.net/weixin_48726650/article/details/107019164](https://link.segmentfault.com/?enc=JB6w6BefnVmd%2B0QsX2EQzA%3D%3D.eCcJr9vxZG27O%2FYVW1R%2BoltEGvZMeR4t3f8NVcSPktHkpjIWL8YVqkcr1Mo2kT7MLTmkRCGlt03PhoNoPOMHZQ%3D%3D)

**3.语法 API 优化** 

a.优化逻辑组织

- 使用 Vue.js 2.x 编写组件本质就是在编写一个“包含了描述组件选项的对象”，可以把它称为 Options API。我们按照 data、props、methods、computed 这些不同的选项来书写对应的代码。这种方式对于小型的组件可能代码还能一目了然，但对于大型组件要修改一个逻辑点，可能就需要在单个文件中不断上下切换和寻找逻辑代码。
- Vue.js 3.0 提供了一种新的 API：Composition API，它有一个很好的机制去解决这样的问题，就是将某个逻辑关注点相关的代码全都放在一个函数里，这样在修改一个逻辑时，只需要改那一块的代码了。

b.优化逻辑复用

- 在 Vue.js 2.x 中，我们一般会用 mixins 去复用逻辑。当抽离并引用了大量的mixins，你就会发现两个不可避免的问题：命名冲突和数据来源不清晰。
- Vue.js 3.0 设计的 Composition API，在逻辑复用方面就会很有优势了。

# 进阶

## 双向绑定

所谓的双向绑定，其实就是将Model和View绑定在一起，任何一方改变的同时，改变另外一方。

**vue2在组件中这样设置:**

父组件

```
<ChildComponent v-model = "title">
```

子组件

```
export default {
  model: {
    prop: 'title', // v-model绑定的属性名称
    event: 'change' // v-model绑定的事件
  },
  props: {
    value: String, // value跟v-model无关
    title: { // title是跟v-model绑定的属性
      type: String,
      default: 'Default title'
    }
  },
  methods: {
    handle() {
      // 这里的 change, 对应 event
      this.$emit('change', 'xxx')
    }
  }
}
```

**vue3在组件中这样设置**

父组件

```
<!-- 两个方法等价 -->
<Son v-model="message" />
<!-- <Son :modelValue="message" @update:modelValue="message = $event" /> -->
```

子组件

```
export default defineComponent({
  props: {
    modelValue: {
      type: String
    }
  },
  emits: ['update:modelValue'],
  setup(props, { emit }) {
    const newValue = computed({
      get: () => props.modelValue,
      set: (nv) => {
        console.log(nv)
        emit('update:modelValue', nv)
      }
    })

    return {
      newValue
    }
  }
})
```

**小结**

**vue2:**

1. v-model: 会把 `value` 用作 prop 且把 `input` 用作 event;
2. 可以通过 `.sync`修饰符 指定传递名字
3. 支持model: 可以指定v-model的 value属性名 和 event事件名字

![image-20230223074721472](/img/image-20230223074721472.png)

**组件v-model原理:**

```
<Son v-model="age" />
<Son :value="age"  @change="age = $event" />
```

**vue3:**

1. v-model: 不在绑定 value 而是 `modelValue`, 接受方法也不再是 input 而是 `update:modelValue`
2. 组件支持多个 v-model, 并且可以指定名字 v-model:名字

![image-20230223074833400](/img/image-20230223074833400.png)

**组件v-model原理:**

```
<Son v-model="formData" />
<Son :modelValue="formData" @update:modelValue="formData = $event" />
```

## Object.defineProperty和Porxy

**前言**

Vue都是采用数据劫持代理+发布订阅模式方式实现，vue2到vue3的差别是数据劫持的方式由Object.defineProperty更改为Proxy代理，其他代码不变。Proxy/Reflect是在ES2015规范中加入的，Proxy可以更好的拦截对象行为，Reflect可以更优雅的操纵对象。

> **并不是说`Proxy`的性能就比`Object.defineProperty`高多少**
>
> 在`Proxy`里的处理方式比`Vue2`时期的好很多：`Vue2`的响应式是一上来就一顿`遍历`+`递归`把你定义的所有数据全都变成响应式的，这就会导致如果页面上有很多很复杂的数据结构时，用`Vue2`写的页面就会白屏一小段时间。毕竟`遍历`+`递归`还是相对很慢的一个操作嘛！
>
> 对于vue3,当我们获取对象上的某个键对应的值时，会先判断这个值到底有没有对应的发布者对象，没有的话再创建发布者对象。而且当获取到的值是引用类型时再把这个值变成`响应式对象`，等你用到了响应式对象里的值时再去新建发布者对象。
>
> 总结成一句话就是：`Vue3`是用到哪部分的数据的时候，再把数据变成响应式的。而`Vue2`则是不管三七二十一，刚开局就全都给你变成响应式数据。

对比：

> - Object.defineProperty 是 Es5 的方法，Proxy 是 Es6 的方法
> - defineProperty 不能监听到数组下标变化和对象新增属性，Proxy 可以
> - defineProperty 是劫持对象属性，Proxy 是代理整个对象
> - defineProperty 局限性大，只能针对单属性监听，所以在一开始就要全部递归监听。Proxy 对象嵌套属性运行时递归，用到才代理，也不需要维护特别多的依赖关系，性能提升很大，且首次渲染更快
> - defineProperty 会污染原对象，修改时是修改原对象，Proxy 是对原对象进行代理并会返回一个新的代理对象，修改的是代理对象
> - defineProperty 不兼容 IE8，Proxy 不兼容 IE11

| 对比                                | Object.defineProperty | Porxy          |
| ----------------------------------- | --------------------- | -------------- |
| 功能                                | 监听对象的单个属性    | 监听整个对象   |
| 属性为对象时                        | 需要递归监            | 不需要         |
| 对象新增一个属性时                  | 需要手动监听          | 不需要手动监听 |
| 数组通过push、unshift方法增加的元素 | 无法监听              | 可以监听       |

**一、Object.defineProperty**

> 基本使用

核心：

- 对象: 通过 defineProperty 对对象的已有属性值的读取和修改进行劫持(监视/拦截)
- 数组: 通过重写数组原型方法实现元素修改的劫持

缺陷：

- 初始化时需要遍历对象所有 key，如果对象层次较深，性能不好
- 通知更新过程需要维护大量 dep 实例和 watcher 实例，额外占用内存较多
- Object.defineProperty 无法监听到数组元素的变化，只能通过劫持重写方法
- 动态新增，删除对象属性无法拦截，只能用特定 set/delete API 代替
- 不支持 Map、Set 等数据结构

```
let obj = {}
let input = document.getElementById('input')
let span = document.getElementById('span')
// 数据劫持
Object.defineProperty(obj, 'text', {
// value:10, //初值
// enumerable:true,//属性是否支持枚举,默认false
// writable:true,//属性是否支持修改,默认false
// configurable:true,//属性是否支持删除,默认false
  get() {
    console.log('获取数据了')
  },
  set(newVal) {
    console.log('数据更新了')
    input.value = newVal
    span.innerHTML = newVal
  }
})
// 输入监听
input.addEventListener('keyup', function(e) {
  obj.text = e.target.value
})
```

> 监听对象上的多个属性

```
Object.keys(person).forEach(function (key) {
    Object.defineProperty(person, key, {
        enumerable: true,
        configurable: true,
        // 默认会传入this
        get() {
            return person[key]
        },
        set(val) {
            console.log(`对person中的${key}属性进行了修改`)
            person[key] = val
            // 修改之后可以执行渲染操作
        }
    })
})
console.log(person.age)
```

> 深度监听一个对象

```
function defineProperty(obj, key, val) {
    //如果某对象的属性也是一个对象，递归进入该对象，进行监听
    if(typeof val === 'object'){
    observer(val)
    }
    Object.defineProperty(obj, key, {
        get() {
            console.log(`访问了${key}属性`)
            return val
        },
        set(newVal) {
         // 如果原本的属性值是一个对象，递归进入该对象进行监听
            if(typeof newVal === 'object'){
                observer(key)
            }
            // 如果原本的属性值是一个字符串
            console.log(`${key}属性被修改为${newVal}了`)
            val = newVal
        }
    })
}

// 在observer里面加一个递归停止的条件
function Observer(obj) {
    //如果传入的不是一个对象，return
    if (typeof obj !== "object" || obj === null) {
        return
    }
    // for (key in obj) {
    Object.keys(obj).forEach((key) => {
        defineProperty(obj, key, obj[key])
    })
    // }
}
```

> 监听数组

如果还是按照基本用法，是无法监听数组变化，vue2采用重写Array原型上的方法实现监听。

**Proxy**

> 基本使用

Proxy 也就是代理，可以帮助我们完成很多事情，例如对数据的处理，对构造函数的处理，对数据的验证，说白了，就是在我们访问对象前添加了一层拦截，可以过滤很多操作，而这些过滤，由你来定义，因此提供了一种机制，可以对外界的访问进行过滤和改写。

核心：

- 通过 Proxy(代理): 拦截对 data 任意属性的任意(13 种)操作, 包括属性值的读写, 属性的添加, 属性的删除等…
- 通过 Reflect(反射): 动态对被代理对象的相应属性进行特定的操作

语法：`const p = new Proxy(target, handler)` 参数:

1. target:要使用 `Proxy` 包装的目标对象（可以是任何类型的对象，包括原生数组，函数，甚至另一个代理）
2. handler:一个通常以函数作为属性的对象，各属性中的函数分别定义了在执行各种操作时代理 `p` 的行为。

通过Proxy，我们可以对`设置代理的对象`上的一些操作进行拦截，外界对这个对象的各种操作，都要先通过这层拦截。

```
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

Proxy的表单验证

```
// 验证规则
  const validators = {
    name: {
      validate(value) {
        return value.length > 6;
      },
      message: '用户名长度不能小于六'
    },
    password: {
      validate(value) {
        return value.length > 10;
      },
      message: '密码长度不能小于十'
    },
    moblie: {
      validate(value) {
        return /^1(3|5|7|8|9)[0-9]{9}$/.test(value);
      },
      message: '手机号格式错误'
    }
  }


  // 验证方法
  function validator(obj, validators) {
    return new Proxy(obj, {
      set(target, key, value) {
        const validator = validators[key]
        if (!validator) {
          target[key] = value;
        } else if (validator.validate(value)) {
          target[key] = value;
        } else {
          alert(validator.message || "");
        }
      }
    })
  }
  let form = {};
  form = validator(form, validators);
  form.name = '666'; // 用户名长度不能小于六
  form.password = '113123123123123';
```

**Proxy支持拦截的操作，一共有13种：**

- get(target, propKey, receiver)：拦截对象属性的读取，比如 `proxy.foo` 和`proxy['foo']`。

- set(target, propKey, value, receiver)：拦截对象属性的设置，比如`proxy.foo = v` 或 `proxy['foo'] = v`，返回一个布尔值。
- has(target, propKey)：拦截 `propKey in proxy` 的操作，返回一个布尔值。
- deleteProperty(target, propKey)：拦截 `delete proxy[propKey]`的操作，返回一个布尔值。
- ownKeys(target)：拦截 `Object.getOwnPropertyNames(proxy)`、`Object.getOwnPropertySymbols(proxy)`、`Object.keys(proxy)`、`for...in`循环，返回一个数组。该方法返回目标对象所有自身的属性的属性名，而`Object.keys()`的返回结果仅包括目标对象自身的可遍历属性。
- getOwnPropertyDescriptor(target, propKey)：拦截`Object.getOwnPropertyDescriptor(proxy, propKey)`，返回属性的描述对象。
- defineProperty(target, propKey, propDesc)：拦截`Object.defineProperty(proxy, propKey, propDesc）`、`Object.defineProperties(proxy, propDescs)`，返回一个布尔值。
- preventExtensions(target)：拦截`Object.preventExtensions(proxy)`，返回一个布尔值。
- getPrototypeOf(target)：拦截`Object.getPrototypeOf(proxy)`，返回一个对象。
- isExtensible(target)：拦截`Object.isExtensible(proxy)`，返回一个布尔值。
- setPrototypeOf(target, proto)：拦截`Object.setPrototypeOf(proxy, proto)`，返回一个布尔值。如果目标对象是函数，那么还有两种额外操作可以拦截。
- apply(target, object, args)：拦截 Proxy 实例作为函数调用的操作，比如`proxy(...args)`、`proxy.call(object, ...args)`、`proxy.apply(...)`。
- construct(target, args)：拦截 Proxy 实例作为构造函数调用的操作，比如`new proxy(...args)`。

## Virtual-DOM

Vue3 相比于 Vue2 虚拟DOM 上增加`patchFlag`字段。我们借助`Vue3 Template Explorer`来看。

```html
<div id=app>
  <h1>技术摸鱼</h1>
  <p>今天天气真不错</p>
  <div>{{name}}</div>
</div>
```

渲染函数如下:

```js
import { createElementVNode as _createElementVNode, toDisplayString as _toDisplayString, openBlock as _openBlock, createElementBlock as _createElementBlock, pushScopeId as _pushScopeId, popScopeId as _popScopeId } from vue

const _withScopeId = n => (_pushScopeId(scope-id),n=n(),_popScopeId(),n)
const _hoisted_1 = { id: app }
const _hoisted_2 = /*#__PURE__*/ _withScopeId(() => /*#__PURE__*/_createElementVNode(h1, null, 技术摸鱼, -1 /* HOISTED */))
const _hoisted_3 = /*#__PURE__*/ _withScopeId(() => /*#__PURE__*/_createElementVNode(p, null, 今天天气真不错, -1 /* HOISTED */))

export function render(_ctx, _cache, $props, $setup, $data, $options) {
  return (_openBlock(), _createElementBlock(div, _hoisted_1, [
    _hoisted_2,
    _hoisted_3,
    _createElementVNode(div, null, _toDisplayString(_ctx.name), 1 /* TEXT */)
  ]))
}
```

注意第 3 个`_createElementVNode`的第 4 个参数即`patchFlag`字段类型，字段类型情况如下所示。1 代表节点为动态文本节点，那在 diff 过程中，只需比对文本对容，无需关注 class、style等。除此之外，发现所有的静态节点，都保存为一个变量进行`静态提升`，可在重新渲染时直接引用，无需重新创建。

```js
export const enum PatchFlags { 
  TEXT = 1, // 动态文本内容
  CLASS = 1 << 1, // 动态类名
  STYLE = 1 << 2, // 动态样式
  PROPS = 1 << 3, // 动态属性，不包含类名和样式
  FULL_PROPS = 1 << 4, // 具有动态 key 属性，当 key 改变，需要进行完整的 diff 比较
  HYDRATE_EVENTS = 1 << 5, // 带有监听事件的节点
  STABLE_FRAGMENT = 1 << 6, // 不会改变子节点顺序的 fragment
  KEYED_FRAGMENT = 1 << 7, // 带有 key 属性的 fragment 或部分子节点
  UNKEYED_FRAGMENT = 1 << 8,  // 子节点没有 key 的fragment
  NEED_PATCH = 1 << 9, // 只会进行非 props 的比较
  DYNAMIC_SLOTS = 1 << 10, // 动态的插槽
  HOISTED = -1,  // 静态节点，diff阶段忽略其子节点
  BAIL = -2 // 代表 diff 应该结束
}
```

## Virtual-DOM-diff算法

diff算法一般流程：

> - 同级比较，再比较子节点
> - 先判断一方有子节点一方没有子节点的情况(如果新的children没有子节点，将旧的子节点移除)
> - 比较都有子节点的情况(核心diff)
> - 递归比较子节点

正常Diff两个树的时间复杂度是`O(n^3)`，但实际情况下我们很少会进行`跨层级的移动DOM`，所以Vue将Diff进行了优化，从`O(n^3) -> O(n)`，只有当新旧children都为多个子节点时才需要用核心的Diff算法进行同层级比较。

**Vue2中diff**

> 采用了`双端比较`的算法。
>
> 从新旧children的两端开始进行比较，借助key值找到可复用的节点，再进行相关操作。相比React的Diff算法，同样情况下可以减少移动节点次数，减少不必要的性能损耗，更加的优雅。

**Vue3中diff**

> 借鉴了 [ivi](https://link.juejin.cn/?target=https%3A%2F%2Fgithub.com%2Flocalvoid%2Fivi)算法和 [inferno](https://link.juejin.cn/?target=https%3A%2F%2Fgithub.com%2Finfernojs%2Finferno)算法。
>
> 在创建VNode时就确定其类型，以及在`mount/patch`的过程中采用`位运算`来判断一个VNode的类型，在这个基础之上再配合核心的Diff算法，使得性能上较Vue2.x有了提升。
>
> 还运用了`动态规划`的思想求解最长递归子序列。

小结

> 编译阶段的优化：
>
> - 事件缓存：将事件缓存(如: [@click](https://www.vue-js.com/user/click))，可以理解为变成静态的了
> - 静态提升：第一次创建静态节点时保存，后续直接复用
> - 添加静态标记：给节点添加静态标记，以优化 Diff 过程
>
> 由于编译阶段的优化，除了能更快的生成虚拟 DOM 以外，还使得 Diff 时可以跳过"永远不会变化的节点"，Diff 优化如下
>
> - Vue2 是全量 Diff，Vue3 是静态标记 + 非全量 Diff
> - 使用最长递增子序列优化了对比流程
>
> 根据尤大公布的数据就是 Vue3 `update` 性能提升了 `1.3~2 倍`

**参考**

- [深入浅出虚拟 DOM 和 Diff 算法，及 Vue2 与 Vue3 中的区别]()

## Option API和Composition API

**vue2 Option API**

```vue
<template>
  <div>
    <p>{{ person.name }}</p>
    <p>{{ car.name }}</p>
  </div>
</template>

<script>
export default {
  name: "Person",

  data() {
    return {
      person: {
        name: "小明",
        sex: "male",
      },
      car: {
        name: "宝马",
        price: "40w",
      }
    };
  },

  watch:{
      'person.name': (value) => {
          console.log(`名字被修改了, 修改为 ${value}`)
      },
      'person.sex': (value) => {
          console.log(`性别被修改了, 修改为 ${value}`)
      }
  },

  methods: {
    changePersonName() {
      this.person.name = "小浪";
    },

    changeCarPrice() {
      this.car.price = "80w";
    }
  },
};
</script>
```

**vue3 Composition API**

```vue
<template>
  <p>{{ person.name }}</p>
  <p>{{ car.name }}</p>
</template>

<script lang="ts" setup>
import { reactive, watch } from "vue";

// person的逻辑
const person = reactive<{ name: string; sex: string }>({
  name: "小明",
  sex: "male",
});
watch(
  () => [person.name, person.sex],
  ([nameVal, sexVal]) => {
    console.log(`名字被修改了, 修改为 ${nameVal}`);
    console.log(`名字被修改了, 修改为 ${sexVal}`);
  }
);
function changePersonName() {
  person.name = "小浪";
}

// car的逻辑
const car = reactive<{ name: string; price: string }>({
  name: "宝马",
  price: "40w",
});
function changeCarPrice() {
  car.price = "80w";
}
</script>
```

## 样式改动

**样式穿透**

```
// vue2
<style scoped>
.a /deep/ .b {
  /* ... */
}
</style>

// vue3
<style scoped>
.a :deep(.b) {
  /* ... */
}
```

**全局样式和局部样式**

```
局部样式
<style scoped>
/* local styles */
</style>
```

```
全局样式：不带scope
<style>
/* global styles */
</style>

全局样式：使用:global伪类
// 创建一个.red的全局类样式
<style scoped>
:global(.red) {
  color: red;
}
</style>
```

# Vue2升级Vue3

[迁移指南](https://v3.cn.vuejs.org/guide/migration/introduction.html)

**简介**

*新特性*

- [Composition API](https://v3.vuejs.org/guide/composition-api-introduction.html)
- [Teleport](https://v3.vuejs.org/guide/teleport.html)
- [Fragments](https://v3.vuejs.org/guide/migration/fragments.html)
- [Emits Component Option](https://v3.vuejs.org/guide/component-custom-events.html)
- createRenderer API⽤于创建⾃定义渲染器

*破坏性变化*

- [Global API 改为应⽤程序实例调⽤](https://v3.vuejs.org/guide/migration/global-api.html)
- [Global and internal APIs重构为可做摇树优化](https://v3.vuejs.org/guide/migration/global-api-treeshaking.html)
- [model选项和v-bind的sync 修饰符被移除，统⼀为v-model参数形式](https://v3.vuejs.org/guide/migration/v-model.html)
- [渲染函数API修改](https://v3.vuejs.org/guide/migration/render-function-api.html)
- [函数式组件仅能通过简单函数⽅式创建](https://v3.vuejs.org/guide/migration/functional-components.html)
- [废弃在SFC的template上使⽤functional或者添加functional选项的⽅式声明函数式组件](https://v3.vuejs.org/guide/migration/functional-components.html)
- [异步组件要求使⽤defineAsyncComponent ⽅法创建](https://v3.vuejs.org/guide/migration/async-components.html)
- [组件data选项应该总是声明为函数](https://v3.vuejs.org/guide/migration/data-option.html)
- [⾃定义组件⽩名单执⾏于编译时](https://v3.vuejs.org/guide/migration/custom-elements-interop.html)
- [is属性仅限于⽤在component标签上](https://v3.vuejs.org/guide/migration/custom-elements-interop.html)
- [$scopedSlots 属性被移除，都⽤$slots代替](https://v3.vuejs.org/guide/migration/slots-unification.html)
- [特性强制策略变更](https://v3.vuejs.org/guide/migration/attribute-coercion.html)
- [⾃定义指令API和组件⼀致](https://v3.vuejs.org/guide/migration/custom-directives.html)
- ⼀些transition类名修改:
  v-enter -> v-enter-from
  v-leave -> v-leave-from
- [watch 选项](https://v3.vuejs.org/api/options-data.html#watch) 和$watch 不再⽀持点分隔符字符串路径, 使⽤计算函数作为其参数
- Vue 2.x中应⽤程序根容器的 outerHTML 会被根组件的模板替换 (或被编译为template)。 Vue 3.x现在使⽤应⽤根容器的
  innerHTML取代.

*移除*

- [移除keyCode 作为 v-on 修饰符](https://v3.vuejs.org/guide/migration/keycode-modifiers.html)
- [on,off and $once 移除](https://v3.vuejs.org/guide/migration/events-api.html)
- [Filters移除](https://v3.vuejs.org/guide/migration/filters.html)
- [Inline templates attributes移除](https://v3.vuejs.org/guide/migration/inline-template-attribute.html)  

## 取消 v-on:keyup.keyCode修饰符

按键数字

## 移除$ on、$off 和 $once 方法

不应该是vue3提供的功能，vue3移除了EventBus总线通信，推荐mitt.js

```
import mitt from "mitt"
<script>
const emitter = mitt()
emitter.emit('foo',1)
emitter.on('foo',(e)=>{})
</script>
```

## 移除 Filter 过滤器

推荐使用 computed 方案来代替

## 初始化 Vue 应用

Vue 不再是一个构造函数，通过 createApp 方法初始化

```
1 $ npm init vite-app <project-name>
2 $ cd <project-name>
3 $ npm install
4 $ npm run dev
```

## 全局 API 调用方式

```
Vue.config.globalProperties.$echarts = echarts;
```

## 渲染 Render 方法修改

vue2.0渲染函数里的 h 参数，便于tree shaking

```
export default{
 render(h){
  return h('div')
 }
}
```

Vue 3.0 中 h 函数通过 vue 引入,不再传入h函数，拍平props结构，scopedslots删掉，统一为slots即this.$scopedSlots 替代为 this.$slots

```
import {h} from 'vue'
export default{
 render(){
  return h(div)
 }
}
```

通过h函数进行render渲染

```
Demo5.js
import { h, reactive } from "vue";
export default {
  setup(props, { slots, attrs, emit }) {
    const state = reactive({
      count: 0,
    });

    function increment() {
      state.count++;
    }
    // 返回render函数
    return () =>
      h(
        "div",
        {
          onClick: increment,
        },
        [slots.default(), slots.content({ data: "jack" }), state.count, h("input", { value: "123456" }, ["我是span"])]
      );
  },
};
其中，h为函数，不再是参数，格式：h('标签名',{属性或事件},[子元素或h函数])

<Demo5>
 我是匿名插槽
      <template #default>我是匿名插槽</template>
      <template #content="{ data }">我是具名插槽，取消了作用域插槽{{ data }}</template>
    </Demo5>
```

## 异步组件defineAsyncComponent

由于vue3引入函数式组件，为了区分函数式组件和异步组件，特地增加标记defineAsyncComponent。

- 必须明确使用defineAsyncComponent包裹
- component选项重名为loader
- Loader 函数不在接收 resolve and reject 且必须返回⼀个Promise  

vue2.0

```
const Home = () => import("./components/Home.vue")
```

vue3.0

```
components: {
    // 无配置项异步组件
    AsyncPage: defineAsyncComponent(() => import("./NextPage.vue")),
    // 有配置项异步组件
    AsyncPageWithOptions: defineAsyncComponent({
   loader: () => import(".NextPage.vue"),
   delay: 200, 
   timeout: 3000,
   errorComponent: () => import("./ErrorComponent.vue"),
   loadingComponent: () => import("./LoadingComponent.vue"),
 })
  },
```

`defineAsyncComponent` 也可以接受一个对象

## 动态组件 is 属性

vue2.0会渲染成mybutton组件

```
<button is="mybutton"></button>
```

vue3.0则当成普通属性，除非用v-is指令替代

is只能作用域component组件

```
<component is="comp"></component>
```

dom内使用模板解析，使用v-is替代

```
<table>
<tr v-is="'comp'"></tr>
</table>
```



## 其他API

**1)shallowRef**

这是一个浅层的 `ref`，与 `shallowReactive` 一样是拿来做性能优化的

**2)toRaw**

`toRaw` 方法是用于获取 `ref` 或 `reactive` 对象的原始数据的

**3)markRaw**

`markRaw` 方法可以将原始数据标记为非响应式的，即使用 `ref` 或 `reactive` 将其包装，仍无法实现数据响应式，其接收一个参数，即原始数据，并返回被标记后的数据

**4)provide && inject**

这里简单说明一下这两个方法的作用：

- **provide** ：向子组件以及子孙组件传递数据。接收两个参数，第一个参数是 `key`，即数据的名称；第二个参数为 `value`，即数据的值
- **inject** ：接收父组件或祖先组件传递过来的数据。接收一个参数 `key`，即父组件或祖先组件传递的数据名称

**5)getCurrentInstance**

獲取this實例

```javascript
let { proxy } = getCurrentInstance()
```

**6)useStore**

在Vue3的 `getCurrentInstance().ctx` 中也没有发现 `$store` 这个属性.这就要通过 `vuex` 中的一个方法了，即 `useStore`

**7)vue3操作dom**

```javascript
<template>
  <div>
    <div ref="el">div元素</div>
  </div>
</template>

<script>
import { ref, onMounted } from 'vue'
export default {
  setup() {
    // 创建一个DOM引用，名称必须与元素的ref属性名相同
    const el = ref(null)

    // 在挂载后才能通过 el 获取到目标元素
    onMounted(() => {
      el.value.innerHTML = '内容被修改'
    })

    // 把创建的引用 return 出去
    return {el}
  }
}
</script>

```

## TypeScript作用

三个原因：

- 您可以避免经典的错误 `'undefined' is not a function.`
- 在不严重破坏代码的情况下，重构代码更容易。
- 使大型、复杂的应用程序源码更易阅读。

研究表明，静态类型检查的TypeScript可以检测到所有JavaScript错误的15％。

1. TypeScript更可靠

   与JavaScript相比，TypeScript代码更可靠、更容易重构。这使开发人员可以更轻松地避免错误并进行重写。

   类型的定义和编译器的引入，可使你避免掉代码中的大多数愚蠢错误。

2. TypeScript更清晰

   显式类型使我们代码可读性更高，所以我们的注意力将会更集中在我们的系统究竟是如何构建的，以及系统的不同部分如何相互作用。在大型系统中，能够在记住上下文的同时抽象出系统的其余部分是很重要的。类型的定义使我们能够做到这一点。

3. TypeScript和JavaScript实际上是可以互换的，何乐而不为呢？

   由于JavaScript是TypeScript的子集，因此您可以在TypeScript代码中使用您想要的所有JavaScript库和代码。

[github上pull request排名](https://madnight.github.io/githut/#/pull_requests/2020/1)

# 反对Vue2升级Vue3

最近一篇反对**Vue2**升级到**Vue3**的文章在vue官方社区引起了热议。（原文链接：[Vue 3 was a mistake that we should not repeat](https://link.juejin.cn/?target=https%3A%2F%2Fmedium.com%2Fjs-dojo%2Fvue-3-was-a-mistake-that-we-should-not-repeat-81cc65484954)）

原作者主要的问题，是从Vue3**突破性**的改变以及**周边生态圈**未能及时跟上的角度，重点强调了迁移升级**成本**+**风险**较大。

关于升级成本问题：尤大也承认了**Vue3**升级体验并没有想象中的那么流畅，**Vue4**会吸取经验，做好平稳迭代。

**一、破坏性的api变更（Breaking changes）**

**[Events API](https://link.juejin.cn?target=https%3A%2F%2Fv3-migration.vuejs.org%2Fbreaking-changes%2Fevents-api.html)的弃用让这个问题首当其冲**。Vue实例再也不能作为**事件总线**做事件通信，`$`on，`$`off，`$`once的彻底**移除**意味着之前所有有关代码都必须重新推翻重写，虽然有很好的插件工具让这件事变得没那么复杂，但是仍然会带来不小的迁移成本。

**代码构建问题。** 你会经常遇到用Vue2写法写出来的代码在**构建(build)** 失败或抛出**警告**。因为这些api写法在Vue3中已经被废弃。这问题在已存在的大型项目中的尤为突出下图展示了一部分**Breaking changes**，可以看到破坏性的api变更数确实很多：

**二、颠覆式的设计模式（composition-api）**

颠覆式的**composition-api**慢慢向**面向函数**思想转变，导致很多原有习惯于**options-api**的开发者反感Vue正在像react靠拢，没有坚持住Vue特色。它提出了一种新的基于函数的 Vue 组件编写方式，引起了Vue社区大量的争议和分裂，甚至将社区分隔为两种观点阵营针锋相对，最终导致了[Vue 最黑暗的一天事件](https://link.juejin.cn?target=https%3A%2F%2Fdev.to%2Fdanielelkington%2Fvue-s-darkest-day-3fgh)。这很令人沮丧。

**三、生态系统（The ecosystem）**

生态系统和框架本身一样重要。因为没有**责任机制**，在有争议的决定和在弃用功能的时候，很多框架周边的生态系统的许多贡献者会被迫**离开**，并导致许多库被**放弃**或者**延迟更新**。很多时候，我们没有办法做版本兼容时，我们往往只能把责任归咎于，开源库缺乏**同理心**和对大局的理解。

**四、文档系统（Documentation）**

在我们的日常开发中，尤其是在使用框架时，我们会遇到各种各样的问题，这时我们时常需要**google**或者**问答社区**作为帮手，但是目前关于**Vue**搜索出来的结果几乎全是Vue2的结果

**五、过往案例（The past）**

过渡到 Vue 3 看起来很像从*AngularJS*过渡到*Angular*（*版本 1⇒ 2*）。大量的延迟和重大更改导致了挫败感，最终 Angular 失去了对 React 和 Vue 的吸引力。

**尤大的回复：**

> 1.当我们进行版本切换时，所有核心库和工具都与这两个版本兼容（或为 Vue 2/3 支持提供单独的版本）。
>
> 实际上阻碍升级的依赖都是第三方，主要是 **Nuxt** 和 **Vuetify**。
>
> 2.实际使用过 Composition API + < script setup> 的用户在真是开发中的反馈非常积极，证明这是一个有价值的补充，现在他们中的许多人更喜欢它而不是 Options API。
>
> 我们当然可以更好地处理新 API 的引入，但仅仅因为存在争议，并不意味着它是错误的或者不必要的。实际上，引入大的、新的想法的行为，势必会让那些喜欢呆在舒适区的人感到不安，但如果我们迎合这种心态，就永远不会取得真正的进展。
>
> 3、4.虽然我们确实创造了 Vue CLI、Vuex、Vetur 和 VuePress 的新替代品，但它们本身都有适用于 Vue 3 的版本。
>
> 5.关于和angular的过往对比：
>
> - 没有可比性，不能拿Vue升级和angularjs -> angular做对比。
>
> - Angular 和 AngularJS 是根本不同的框架。几乎没有共享交集，除了完全重写之外没有实际的迁移路径。
>
> - 有许多生产 Vue 2 应用程序成功迁移到 Vue 3 的案例。很容易吗，确实不是，但是他们都迁移成功了。
>
> 6.我们同意，Vue3升级体验并没有想象中的那么流畅。Vue 将随着吸取的经验不断发展，我们绝对不打算在未来的Vue4中，进行这样的破坏性重大升级。

**参考**

- [Vue2升级到Vue3到底是不是一个正确的选择？(尤雨溪亲自回复解读)](https://juejin.cn/post/7117525259212816414#heading-1)
- [对比Vue2总结Vue3新特性(2022年最全，2.5w字！)](https://juejin.cn/post/7098575243240800286)
- [gogocode插件Vue2 到 Vue3 升级指南](https://gogocode.io/zh/docs/vue/vue2-to-vue3)

# Vue2升级3-问题汇总

参考

- [keeko笔记汇总](https://www.yuque.com/dirackeeko/blog/ly79g2)
- [Vue3 + Vite2 + ElementPlus + TS 项目常见问题](https://bbchin.com/archives/vite2-vue3-ts)
- [Vue2 + Webpack4 + TS 改造小记](https://bbchin.com/archives/vue2-wp4-ts)
- [vue-cli3 + vue2 项目转 vite 小记](https://bbchin.com/archives/vue2-to-vite)
- [vue2 老项目迁移vue3 记录](https://juejin.cn/post/7100903113573269518)

**template v-for告警**

```
报错：<template v-for> key should be placed on the <template> 告警解决
原因：vue3要求template循环的key只能在template标签上
修改：
 1.key属性放到template标签上
 2..eslintrc.js配置'vue/no-v-for-template-key-on-child': 'off' // vue3
```