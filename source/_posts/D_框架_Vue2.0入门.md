---
title: Vue2.0入门
date: 2022-04-17 06:33:16
categories:
  - D_框架和类库
toc: true # 是否启用内容索引
---

## 入门篇

**定义**

vue 是一套构建用户界面的**渐进式框架**，它可以设计为**自底向上**的逐层应用。

**渐进式框架**

- 声明式渲染：数据到视图
- 组件系统：UI 结构到组件树
- 核心插件：客户端路由、状态管理、构建系统 vue-cli

Vue 核心框架只做了前面 2 层，核心插件是热插拔部分。

细节结构图如下：

- Declarative Rendering(声明式渲染)
- Component System(组件系统)
- Client-Side Routing(客户端路由)
- Large Scale State Management(全局状态管理)
- Build System(构建系统)

**声明式渲染和命令式渲染**

- 命令式渲染 ： 命令我们的程序去做什么，程序就会跟着你的命令去一步一步执行
- 声明式渲染 ： 我们只需要告诉程序我们想要什么效果，其他的交给程序来做。

**Vue 框架特点**

- 轻量：内置 bunding 和 tree-shaking,打包后体积 30k,而 angular 是 65k
- 学习成本低：文档组织结构清晰，采用组件化模式，提高代码复用性
- 性能优化：虚拟dom和优化的diff算法,避免子组件渲染
- 国内生态良好：众多厂商使用，持续增长

### 从 0 开始构建

基础代码 balabala

### Vue 核心组件

客户端路由、状态管理、构建系统 vue-cli

## 进阶篇

### Vue 的混入

### Vue 的渲染函数

### Vue 的响应式原理

**双向数据绑定**

```
父组件
<child v-model="msg"></child>

子组件
<div >{{msg}}</div>
<button @click="change"></button>
props:[msf],
model:{
prop:'msg',
event:'msgChange'
},
methods:{
change(){
this.$emit('msgChange','xxx')
}
}
```

## 实战篇

### Vue 的属性与指令

**指令修饰符**

指令是带有 v-前缀的特殊属性，本质是 js 表达式，作用域 dom,常用的指令 v-cloak,v-text，v-html,v-bind,v-on,v-for,v-if,v-show,v-model

- v-bind:value="userName"，提供属性绑定机制，简写为：

- v-on:click="scan",提供事件绑定机制，简写为@

- v-cloak指令

  ```
  <div v-cloak>{{noData}}</div>
  [v-cloak]{
   display: none;
  }
  主要解决网速慢的时候，显示出插值表达式的代码的问题。
  原理：Vue完成实例后，会删除v-cloak属性。
  ```

- v-once指令

  ```
  <div v-once>累加的值{{n}}</div>
  初次渲染后，Vue视为静态内容，值不再变化
  ```

- v-pre指令

  ```
  <div v-pre>累加的值</div> //正常
  <div v-pre>累加的值{{n}}</div>//报错
  v-pre会跳过所在节点，提前编译
  ```

- .stop：等同于 JavaScript 中的 event.stopPropagation()，防止事件冒泡
- .prevent：等同于 JavaScript 中的 event.preventDefault()，防止执行预设的行为（如果事件可取消， 则取消该事件，而不停止事件的进一步传播）
- .capture：与事件冒泡的方向相反，事件捕获由外到内
- .self：只会触发自己范围内的事件，不包含子元素
- .once：只会触发一次

技巧：this.opt=‘+’;const add=this.a+this.opt+this.b;this.res=eval(add);eval 把字符串转成表达式执行

**按键修饰符**

```
@keyup.enter="submit"
.enter
.tab
.delete (捕获 “删除” 和 “退格” 键)
.esc
.space
.up
.down
.left
.right

其他按键值
@keyup.f2="submit"
//定义全局按键修饰符
Vue.config.keyCodes.f2 = 113;
```

**Class**

方式 0 字符串

> 用于类名不确定，动态获取

方式 1 数组

> 绑定多个样式，个数确定，名字也确定

```
:class="[content]"，this.content = 'content-red'
:class="content"，this.content = ['content-red']
```

方式 2 对象

> 绑定多个样式，个数不确定，名字不确定

```
class="{ 'content-red': content }",this.content = true
class="content",this.content = {'content-red':true}
```

**Style**

方式 1 数组:style="[content]",this.content={'background-color': 'red'}

方式 2 对象:style="{ 'background-color': content }"，this.content ='red'

**自定义过滤器**

过滤器可以用在两个地方：**双花括号插值和 `v-bind` 表达式** ,支持串行处理。

局部过滤器

```
v-bind:value="userName | dataFormat('局部过滤器')"
data() {
    return {
      userName: ''
    };
  },
  filters: {
    dataFormat: (msg, a) => {
      // msg表示要过滤的数据，a表示传入的参数
      return msg + a;
    }
  },
```

全局过滤器

```
v-bind:value="userName | dataFormatGlobal('全局过滤器')"
Vue.filter('dataFormatGlobal', function (msg, a) {
  return msg + a;
});
```

技巧：padStart()用于头部补全，padEnd()用于尾部补全.'a'.padStart(3, '0') // '00a'。'a'.padEnd(3, '0') // 'a00'

**自定义指令**

局部指令

```
<input  v-focuslw />
data() {
    return {
      userName: ''
    };
  },
  directives: {
    focuslw: {
      // 指令的定义
      inserted: function (el,binding,vnode,oldVnode) {
        el.focus();
      }
    }
  },
指令钩子函数会被传入以下参数:
el：指令所绑定的元素，可以用来直接操作 DOM。
binding：一个对象，包含以下 property：
    name：指令名，不包括 v- 前缀。
    value：指令的绑定值，例如：v-my-directive="1 + 1" 中，绑定值为 2。
    oldValue：指令绑定的前一个值，仅在 update 和 componentUpdated 钩子中可用。无论值是否改变都可用。
    expression：字符串形式的指令表达式。例如 v-my-directive="1 + 1" 中，表达式为 "1 + 1"。
    arg：传给指令的参数，可选。例如 v-my-directive:foo 中，参数为 "foo"。
    modifiers：一个包含修饰符的对象。例如：v-my-directive.foo.bar 中，修饰符对象为 { foo: true, bar: true }。
vnode：Vue 编译生成的虚拟节点。移步 VNode API 来了解更多详情。
oldVnode：上一个虚拟节点，仅在 update 和 componentUpdated 钩子中可用。
```

全局指令

```
<input  v-focusGlobal />
Vue.directive('focusGlobal', {
  // 当被绑定的元素插入到 DOM 中时……
  inserted: function (el,binding,vnode,oldVnode) {
    // 聚焦元素
    el.focus();
  }
});
```

指令的钩子函数如下：

- `bind`：只调用一次，指令第一次绑定到元素时调用。在这里可以进行一次性的初始化设置。
- `inserted`：被绑定元素插入父节点时调用 (仅保证父节点存在，但不一定已被插入文档中)。
- `update`：所在组件的 VNode 更新时调用
- `componentUpdated`：指令所在组件的 VNode **及其子 VNode** 全部更新后调用。
- `unbind`：只调用一次，指令与元素解绑时调用

**自定义事件传递额外参数**

```
<div @childClick="getData($event,'额外参数')">我是父级内容<div>
```

**常用自定义指令**

- 复制粘贴指令 `v-copy`
- 长按指令 `v-longpress`
- 输入框防抖指令 `v-debounce`
- 禁止表情及特殊字符 `v-emoji`
- 图片懒加载 `v-LazyLoad`
- 权限校验指令 `v-premission`
- 实现页面水印 `v-waterMarker`
- 拖拽指令 `v-draggable`

### Vue 的组件

创建全局组件的两种方式 component 和 use

```
import PageTools from '@/components/PageTools' // 导入需要注册的组件
Vue.component(PageTools.name, PageTools) // 全局注册组件

import ExpHeader from './ExpHeader';
const components = {
  ExpHeader // 导航头
};
// 全局注册组件;
const initComponent = function(app) {
  Object.keys(components).forEach(comp => {
    app.component(comp, components[comp]);
  });
};
export default initComponent;
Vue.use(initComponent)
```

#### 动态组件 & 异步组件

**动态组件**

```
<component v-bind:is="currentTabComponent"></component>
```

**异步组件**

```
new Vue({
  // ...
  components: {
    'my-component': () => import('./my-async-component')
  }
})
```

#### Vue 父子组件生命周期执行顺序

父组件先创建，然后子组件创建；子组件先挂载，然后父组件挂载。

```text
父beforeCreate-> 父create -> 子beforeCreate-> 子created -> 子mounted -> 父mounted
```

#### Vue 的异步组件放在哪个生命周期

结论：created 和 mounted 都可以。

- 对于作为子组件被调用的组件里，异步请求应当在`mounted`里调用，因为这个时候子组件可能需要涉及到对 dom 的操作；
- 对于页面级组件，当我们需要使用`ssr`（服务端渲染）的时候，只有`created`是可用的，所以这个时候请求数据只能用它；
- 对于页面级组件， 当我们做异步操作时，涉及到要访问 dom 的操作，我们仍旧只能使用`mounted`;
- 对于一般情况，`created`和`mounted`都是可以的；

### Vue 的生命周期

[vue生命周期详细全过程](https://blog.csdn.net/m0_70477767/article/details/124684195)

![](\img\vue生命周期.png)

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

## 高级篇

### Vue 的依赖收集和派发更新

##### 响应式数据原理

`Vue2.x`在初始化数据时，会使用`Object.defineProperty`重新定义`data`中的所有属性，当页面使用对应属性时，首先会进行`依赖收集`(收集当前组件的 watcher)，如果属性发生变化会通知相关依赖进行`派发更细`(发布订阅模式)。

`vue3.0`采用`es6`中的`proxy`代替`Object.defineProperty`做数据监听。

##### Observer/Dep/Watcher

**Observer**

Observer 的作用是对整个 Data 进行监听，在 initData 这个初始方法里使用`observe(data)`,Observer 类内部通过 defineReactive 方法劫持 data 的每一个属性的 getter 和 setter。看一下源码：

```js
export function observe(value: any, asRootData: ?boolean): Observer | void {
  /*判断Data是否是一个对象*/
  if (!isObject(value)) {
    return;
  }
  let ob: Observer | void;

  /*这里用__ob__这个属性来判断是否已经有Observer实例，如果没有Observer实例则会新建一个Observer实例并赋值给__ob__这个属性，如果已有Observer实例则直接返回该Observer实例*/
  if (hasOwn(value, "__ob__") && value.__ob__ instanceof Observer) {
    ob = value.__ob__;
  } else if (
    /*这里的判断是为了确保value是单纯的对象，而不是函数或者是Regexp等情况。*/
    observerState.shouldConvert &&
    !isServerRendering() &&
    (Array.isArray(value) || isPlainObject(value)) &&
    Object.isExtensible(value) &&
    !value._isVue
  ) {
    // 创建一个Observer实例，绑定data进行监听
    ob = new Observer(value);
  }
  if (asRootData && ob) {
    /*如果是根数据则计数，后面Observer中的observe的asRootData非true*/
    ob.vmCount++;
  }
  return ob;
}
```

Vue 的响应式数据都会有一个**ob**作为标记，里面存放了 Observer 实例，防止重复绑定。

再看一下 Observer 类的源码:

```js
/**
 * Observer class that are attached to each observed
 * object. Once attached, the observer converts target
 * object's property keys into getter/setters that
 * collect dependencies and dispatches updates.
 */
export class  {
  value: any;
  dep: Dep; // 每一个Data的属性都会绑定一个dep，用于存放watcher arr
  vmCount: number; // number of vms that has this object as root $data

  constructor (value: any) {
    this.value = value
    this.dep = new Dep()
    this.vmCount = 0

    /*
        /vue-src/core/util/lang.js:
        function def (obj: Object, key: string, val: any, enumerable?: boolean) {
            Object.defineProperty(obj, key, {
                value: val,
                enumerable: !!enumerable,
                writable: true,
                configurable: true
            })
        }
    */
    def(value, '__ob__', this) // 这个def的意思就是把Observer实例绑定到Data的__ob__属性上去
    if (Array.isArray(value)) {

      /*
          如果是数组，将修改后可以截获响应的数组方法替换掉该数组的原型中的原生方法，达到监听数组数据变化响应的效果。
      */
      const augment = hasProto
        ? protoAugment  /*直接覆盖原型的方法来修改目标对象*/
        : copyAugment   /*定义（覆盖）目标对象或数组的某一个方法*/
      augment(value, arrayMethods, arrayKeys)
      /*Github:https://github.com/answershuto*/
      /*如果是数组则需要遍历数组的每一个成员进行observe*/
      this.observeArray(value)
    } else {
      /*如果是对象则直接walk进行绑定*/
      this.walk(value)
    }
  }

  /**
   * Walk through each property and convert them into
   * getter/setters. This method should only be called when
   * value type is Object.
   */
  walk (obj: Object) {
    const keys = Object.keys(obj)

    /*
    walk方法会遍历对象的每一个属性进行defineReactive绑定
    defineReactive: 劫持data的getter和setter
    */
    for (let i = 0; i < keys.length; i++) {
      defineReactive(obj, keys[i], obj[keys[i]])
    }
  }

  /**
   * Observe a list of Array items.
   */
  observeArray (items: Array<any>) {
    /*
    数组需要遍历每一个成员进行observe
    */
    for (let i = 0, l = items.length; i < l; i++) {
      observe(items[i])
    }
  }
}
```

可以看到，Observer 类主要干了以下几件事：

- 给 data 绑定一个**ob**属性，用来存放 Observer 实例，避免重复绑定
- 如果 data 是 Object, 遍历对象的每一个属性进行 defineReactive 绑定
- 如果 data 是 Array, 则需要对每一个成员进行 observe。vue.js 会重写 Array 的 push、pop、shift、unshift、splice、sort、reverse 这 7 个方法，保证之后 pop/push 等操作进去的对象也有进行双向绑定. (具体代码参见 observer/array.js)

**defineReactive()**

如上述源码所示，Observer 类主要是靠遍历 data 的每一个属性，使用 defineReactive()方法劫持 getter 和 setter 方法, 下面来具体看一下 defineReactive:

```js
export function defineReactive(
  obj: Object,
  key: string,
  val: any,
  customSetter?: Function
) {
  /*在闭包中定义一个dep对象*/
  const dep = new Dep();

  const property = Object.getOwnPropertyDescriptor(obj, key);
  if (property && property.configurable === false) {
    return;
  }

  /*如果之前该对象已经预设了getter以及setter函数则将其取出来，新定义的getter/setter中会将其执行，保证不会覆盖之前已经定义的getter/setter。*/
  // cater for pre-defined getter/setters
  const getter = property && property.get;
  const setter = property && property.set;

  /*对象的子对象也会进行observe*/
  let childOb = observe(val);
  Object.defineProperty(obj, key, {
    enumerable: true,
    configurable: true,
    get: function reactiveGetter() {
      /*如果原本对象拥有getter方法则执行*/
      const value = getter ? getter.call(obj) : val;
      //   Dep.target：全局属性，用于指向某一个watcher，用完即丢
      if (Dep.target) {
        /*
        进行依赖收集
        dep.depend()内部实现addDep，往dep中添加watcher实例 (具体参考Dep.prototype.depend的代码)
        depend的时候会根据id判断watcher有没有添加过，避免重复添加依赖
        */
        dep.depend();
        if (childOb) {
          /*子对象进行依赖收集，其实就是将同一个watcher观察者实例放进了两个depend中，一个是正在本身闭包中的depend，另一个是子元素的depend*/
          childOb.dep.depend();
        }
        if (Array.isArray(value)) {
          /*是数组则需要对每一个成员都进行依赖收集，如果数组的成员还是数组，则递归。*/
          dependArray(value);
        }
      }
      return value;
    },
    set: function reactiveSetter(newVal) {
      /*通过getter方法获取当前值，与新值进行比较，一致则不需要执行下面的操作*/
      const value = getter ? getter.call(obj) : val;
      /* eslint-disable no-self-compare */
      if (newVal === value || (newVal !== newVal && value !== value)) {
        return;
      }
      /* eslint-enable no-self-compare */
      if (process.env.NODE_ENV !== "production" && customSetter) {
        customSetter();
      }
      if (setter) {
        /*如果原本对象拥有setter方法则执行setter*/
        setter.call(obj, newVal);
      } else {
        val = newVal;
      }
      /*新的值需要重新进行observe，保证数据响应式*/
      childOb = observe(newVal);
      /*dep对象通知所有的观察者*/
      dep.notify();
    },
  });
}
```

defineReactive()方法主要通过 Object.defineProperty()做了以下几件事:

- 在闭包里定义一个 Dep 实例；
- getter 用来收集依赖，Dep.target 是一个全局的属性，指向的那个 watcher 收集到 dep 里来（如果之前添加过就不会重复添加）；
- setter 是在更新 value 的时候通知所有 getter 时候通知所有收集的依赖进行更新（dep.notify）。这边会做一个判断，如果 newVal 和 oldVal 一样，就不会有操作。

**Dep**

在上面的 defineReactive 中提到了 Dep，于是接下来看一下 Dep 的源码, dep 主要是用来在数据更新的时候通知 watchers 进行更新：

```
/**
 * A dep is an observable that can have multiple
 * directives subscribing to it.
 */
export default class Dep {
  static target: ?Watcher;
  id: number;
  subs: Array<Watcher>;

  constructor () {
    this.id = uid++
    // subs: Array<Watcher>
    this.subs = []
  }

  /*添加一个观察者对象*/
  addSub (sub: Watcher) {
    this.subs.push(sub)
  }

  /*移除一个观察者对象*/
  removeSub (sub: Watcher) {
    remove(this.subs, sub)
  }

  /*依赖收集，当存在Dep.target的时候添加观察者对象*/
//   在defineReactive的getter中会用到dep.depend()
  depend () {
    if (Dep.target) {
        // Dep.target指向的是一个watcher
      Dep.target.addDep(this)
    }
  }

  /*通知所有订阅者*/
  notify () {
    // stabilize the subscriber list first
    const subs = this.subs.slice()
    for (let i = 0, l = subs.length; i < l; i++) {
        // 调用每一个watcher的update
      subs[i].update()
    }
  }
}

// the current target watcher being evaluated.
// this is globally unique because there could be only one
// watcher being evaluated at any time.
Dep.target = null
/*依赖收集完需要将Dep.target设为null，防止后面重复添加依赖。*/
```

- Dep 是一个发布者，可以订阅多个观察者，依赖收集之后 Dep 中会有一个 subs 存放一个或多个观察者，在数据变更的时候通知所有的 watcher。
- 再复习一下，Dep 和 Observer 的关系就是 Observer 监听整个 data，遍历 data 的每个属性给每个属性绑定 defineReactive 方法劫持 getter 和 setter, 在 getter 的时候往 Dep 类里塞依赖（dep.depend），在 setter 的时候通知所有 watcher 进行 update(dep.notify)

**Watcher**

watcher 接受到通知之后，会通过回调函数进行更新。

接下来我们要仔细看一下 watcher 的源码。由之前的 Dep 代码可知的是，watcher 需要实现以下两个作用：

- dep.depend()的时候往 dep 里添加自己；
- dep.notify()的时候调用 watcher.update()方法，对视图进行更新；

同时要注意的是，watcher 有三种：render watcher/ computed watcher/ user watcher(就是 vue 方法中的那个 watch)

```js
export default class Watcher {
  vm: Component;
  expression: string; // 每一个DOM attr对应的string
  cb: Function; // update的时候的回调函数
  id: number;
  deep: boolean;
  user: boolean;
  lazy: boolean;
  sync: boolean;
  dirty: boolean;
  active: boolean;
  deps: Array<Dep>;
  newDeps: Array<Dep>;
  depIds: ISet;
  newDepIds: ISet;
  getter: Function;
  value: any;

  constructor(
    vm: Component,
    expOrFn: string | Function,
    cb: Function,
    options?: Object
  ) {
    this.vm = vm;
    /*_watchers存放订阅者实例*/
    vm._watchers.push(this);
    // options
    if (options) {
      this.deep = !!options.deep;
      this.user = !!options.user;
      this.lazy = !!options.lazy;
      this.sync = !!options.sync;
    } else {
      this.deep = this.user = this.lazy = this.sync = false;
    }
    this.cb = cb;
    this.id = ++uid; // uid for batching
    this.active = true;
    this.dirty = this.lazy; // for lazy watchers
    this.deps = [];
    this.newDeps = [];
    this.depIds = new Set();
    this.newDepIds = new Set();
    this.expression =
      process.env.NODE_ENV !== "production" ? expOrFn.toString() : "";
    // parse expression for getter
    /*把表达式expOrFn解析成getter*/
    if (typeof expOrFn === "function") {
      this.getter = expOrFn;
    } else {
      this.getter = parsePath(expOrFn);
      if (!this.getter) {
        this.getter = function () {};
        process.env.NODE_ENV !== "production" &&
          warn(
            `Failed watching path: "${expOrFn}" ` +
              "Watcher only accepts simple dot-delimited paths. " +
              "For full control, use a function instead.",
            vm
          );
      }
    }
    this.value = this.lazy ? undefined : this.get();
  }

  /**
   * Evaluate the getter, and re-collect dependencies.
   */
  /*获得getter的值并且重新进行依赖收集*/
  get() {
    /*将自身watcher观察者实例设置给Dep.target，用以依赖收集。*/
    pushTarget(this);
    let value;
    const vm = this.vm;

    /*
      执行了getter操作，看似执行了渲染操作，其实是执行了依赖收集。
      在将Dep.target设置为自身观察者实例以后，执行getter操作。
      譬如说现在的的data中可能有a、b、c三个数据，getter渲染需要依赖a跟c，
      那么在执行getter的时候就会触发a跟c两个数据的getter函数，
      在getter函数中即可判断Dep.target是否存在然后完成依赖收集，
      将该观察者对象放入闭包中的Dep的subs中去。
    */
    if (this.user) {
      // this.user: 判断是不是vue中那个watch方法绑定的watcher
      try {
        value = this.getter.call(vm, vm);
      } catch (e) {
        handleError(e, vm, `getter for watcher "${this.expression}"`);
      }
    } else {
      value = this.getter.call(vm, vm);
    }
    // "touch" every property so they are all tracked as
    // dependencies for deep watching
    /*如果存在deep，则触发每个深层对象的依赖，追踪其变化*/
    if (this.deep) {
      /*递归每一个对象或者数组，触发它们的getter，使得对象或数组的每一个成员都被依赖收集，形成一个“深（deep）”依赖关系*/
      traverse(value);
    }

    /*将观察者实例从target栈中取出并设置给Dep.target*/
    popTarget();
    this.cleanupDeps();
    return value;
  }

  /**
   * Add a dependency to this directive.
   */
  /*添加一个依赖关系到Deps集合中*/
  //  在dep.depend()中调用的是Dep.target.addDep()
  addDep(dep: Dep) {
    const id = dep.id;
    if (!this.newDepIds.has(id)) {
      // newDepIds和newDeps记录watcher实例所用到的dep，比如某个computed watcher其实用到了data里的a/b/c三个属性，那就需要记录3个dep
      this.newDepIds.add(id);
      this.newDeps.push(dep);
      if (!this.depIds.has(id)) {
        //  作用是往dep的subs里添加自己（Watcher实例）
        //  但是会先判断一下id，如果subs里有相同的id就不会重复添加
        dep.addSub(this);
      }
    }
  }

  /**
   * Clean up for dependency collection.
   */
  /*清理依赖收集*/
  cleanupDeps() {
    /*移除所有观察者对象*/
    let i = this.deps.length;
    while (i--) {
      const dep = this.deps[i];
      if (!this.newDepIds.has(dep.id)) {
        dep.removeSub(this);
      }
    }
    let tmp = this.depIds;
    this.depIds = this.newDepIds;
    this.newDepIds = tmp;
    this.newDepIds.clear();
    tmp = this.deps;
    this.deps = this.newDeps;
    this.newDeps = tmp;
    this.newDeps.length = 0;
  }

  /**
   * Subscriber interface.
   * Will be called when a dependency changes.
   */
  //   dep.notify的时候会逐个调用watcher的update方法
  update() {
    /* istanbul ignore else */
    if (this.lazy) {
      this.dirty = true;
    } else if (this.sync) {
      /*同步则执行run直接渲染视图*/
      // 基本不会用到sync
      this.run();
    } else {
      /*异步推送到观察者队列中，由调度者调用。*/
      queueWatcher(this);
    }
  }

  /**
   * Scheduler job interface.
   * Will be called by the scheduler.
   */
  /*
      调度者工作接口，将被调度者回调。
    */
  run() {
    if (this.active) {
      const value = this.get();
      if (
        value !== this.value ||
        // Deep watchers and watchers on Object/Arrays should fire even
        // when the value is the same, because the value may
        // have mutated.
        /*
            即便值相同，拥有Deep属性的观察者以及在对象／数组上的观察者应该被触发更新，因为它们的值可能发生改变。
        */
        isObject(value) ||
        this.deep
      ) {
        // set new value
        const oldValue = this.value;
        /*设置新的值*/
        this.value = value;

        /*触发回调渲染视图*/
        if (this.user) {
          try {
            this.cb.call(this.vm, value, oldValue);
          } catch (e) {
            handleError(
              e,
              this.vm,
              `callback for watcher "${this.expression}"`
            );
          }
        } else {
          this.cb.call(this.vm, value, oldValue);
        }
      }
    }
  }

  /**
   * Evaluate the value of the watcher.
   * This only gets called for lazy watchers.
   */
  /*获取观察者的值*/
  evaluate() {
    this.value = this.get();
    this.dirty = false;
  }

  /**
   * Depend on all deps collected by this watcher.
   */
  /*收集该watcher的所有deps依赖*/
  depend() {
    let i = this.deps.length;
    while (i--) {
      this.deps[i].depend();
    }
  }

  /**
   * Remove self from all dependencies' subscriber list.
   */
  /*将自身从所有依赖收集订阅列表删除*/
  teardown() {
    if (this.active) {
      // remove self from vm's watcher list
      // this is a somewhat expensive operation so we skip it
      // if the vm is being destroyed.
      /*从vm实例的观察者列表中将自身移除，由于该操作比较耗费资源，所以如果vm实例正在被销毁则跳过该步骤。*/
      if (!this.vm._isBeingDestroyed) {
        remove(this.vm._watchers, this);
      }
      let i = this.deps.length;
      while (i--) {
        this.deps[i].removeSub(this);
      }
      this.active = false;
    }
  }
}
```

##### Proxy 与 defineProperty

**Proxy 的优势**如下:

- Proxy 可以直接监听对象而非属性
- Proxy 可以直接监听数组的变化

- Proxy 有多达 13 种拦截方法,不限于 apply、ownKeys、deleteProperty、has 等等是 Object.defineProperty 不具备的
- Proxy 返回的是一个新对象,我们可以只操作新的对象达到目的,而 Object.defineProperty 只能遍历对象属性直接修改
- Proxy 作为新标准将受到浏览器厂商重点持续的性能优化，也就是传说中的新标准的性能红利

**Object.defineProperty 的优势**如下:

- 兼容性好,支持 IE9

### Vue 的虚拟 dom 和 patching 算法

**虚拟 dom**

最少包含标签名( tag)、属性(attrs)和子元素对象( children)三个属性。

- 由于 dom 操作耗时十分长，且 dom 对象的体积很大，单个 div 的 dom 属性就有 294 个之多；
- Virtual DOM 就是用一个原生的 JS 对象去描述一个 DOM 节点，所以它比创建一个 DOM 的代价要小很多。
- VNode 是对真实 DOM 的一种抽象描述，它的核心定义无非就几个关键属性，标签名、数据、子节点、键值等，其它属性都是用来扩展 VNode 的灵活性以及实现一些特殊 feature 的。由于 VNode 只是用来映射到真实 DOM 的渲染，不需要包含操作 DOM 的方法，因此它是非常轻量和简单的。
- Virtual DOM 到真实的 dom 需要经过以下过程：VNode 的 create、diff、patch

其实虚拟 DOM 在 Vue.js 主要做了两件事：

- 提供与真实 DOM 节点所对应的虚拟节点 vnode
- 将虚拟节点 vnode 和旧虚拟节点 oldVnode 进行对比（diff 算法），然后更新视图

#### **Diff 算法从 O(n^3) 到 O(n)**-vue2/3 都是如此

**O(n^3)是怎么计算出来的**

传统 Diff 算法需要找到两个树的最小更新方式，所以需要[两两]对比每个叶子节点是否相同，对比就需要 O(n^2)次了，再加上更新（移动、创建、删除）时需要遍历一次，所以是 O(n^3)。

参考：[编程距离](https://leetcode.com/problems/edit-distance/)

我们定义三种操作，用来将一棵树转化为另外一棵树：

- 删除：删除一个节点，将它的 children 交给它的父节点
- 插入：在 children 中 插入一个节点
- 修改：修改节点的值

从一棵树转化为另外一棵树,直观的方式是用动态规划，通过这种记忆化搜索减少时间复杂度。由于树是一种递归的数据结构，因此最简单的树的比较算法是递归处理。确切地说，树的最小距离编辑算法的时间复杂度是 O(n^2m(1+logmn)), 我们假设 m 与 n 同阶， 就会变成 O(n^3)。参考：[距离论文](https://github.com/DatabaseGroup/tree-similarity/tree/develop)

**O(n)怎么计算出来的**

通过三大策略将 O(n^3)优化到 O(n)：

- tree diff: Web UI 中 DOM 节点跨层级的移动操作特别少，可以忽略不计。
- component diff: 拥有相同类的两个组件 生成相似的树形结构;拥有不同类的两个组件 生成不同的树形结构。
- element diff:对于同一层级的一组子节点，通过唯一 id 区分。

> 1.tree diff
>
> （1）React 通过 updateDepth 对 Virtual DOM 树进行层级控制。
> （2）对树分层比较，两棵树 只对同一层次节点 进行比较。如果该节点不存在时，则该节点及其子节点会被完全删除，不会再进一步比较。
> （3）只需遍历一次，就能完成整棵 DOM 树的比较。

<img src="/img/image-20220522162120177.png" alt="image-20220522162120177" style="zoom:50%;" />

如果 DOM 节点出现了跨层级操作,diff 会咋办呢？

答：diff 只简单考虑同层级的节点位置变换，如果是跨层级的话，只有创建节点和删除节点的操作。

<img src="/img/image-20220522162157245.png" alt="image-20220522162157245" style="zoom:50%;" />

如上图所示，以 A 为根节点的整棵树会被重新创建，而不是移动，因此 官方建议不要进行 DOM 节点跨层级操作，可以通过 CSS 隐藏、显示节点，而不是真正地移除、添加 DOM 节点。

> 2.component diff
> React 对不同的组件间的比较，有三种策略
> （1）同一类型的两个组件，按原策略（层级比较）继续比较 Virtual DOM 树即可。
> （2）同一类型的两个组件，组件 A 变化为组件 B 时（A、B 类型相同、结构相同），可能 Virtual DOM 没有任何变化，如果知道这点（变换的过程中，Virtual DOM 没有改变），可节省大量计算时间，所以 用户 可以通过 shouldComponentUpdate() 来判断是否需要 判断计算。
> （3）不同类型的组件，将一个（将被改变的）组件判断为 dirty component（脏组件），从而替换 整个组件的所有节点。
> **注意：如果组件 D 和组件 G 的结构相似，但是 React 判断是 不同类型的组件，则不会比较其结构，而是删除 组件 D 及其子节点，创建组件 G 及其子节点。**

> 3.**element diff**
> 当节点处于同一层级时，diff 提供三种节点操作：删除、插入、移动。
>
> 插入：组件 C 不在集合（A,B）中，需要插入
>
> 删除：
> （1）组件 D 在集合（A,B,D）中，但 D 的节点已经更改，不能复用和更新，所以需要删除 旧的 D ，再创建新的。
> （2）组件 D 之前在 集合（A,B,D）中，但集合变成新的集合（A,B）了，D 就需要被删除。
>
> 移动：组件 D 已经在集合（A,B,C,D）里了，且集合更新时，D 没有发生更新，只是位置改变，如新集合（A,D,B,C），D 在第二个，无须像传统 diff，让旧集合的第二个 B 和新集合的第二个 D 比较，并且删除第二个位置的 B，再在第二个位置插入 D，而是 （对同一层级的同组子节点） 添加唯一 key 进行区分，移动即可。

**重点说下移动的逻辑：**
情形一：新旧集合中存在相同节点但位置不同时，如何移动节点
移动 1、

<img src="/img/image-20220522162357535.png" alt="image-20220522162357535" style="zoom:50%;" />

（1）看着上图的 B，React 先从新中取得 B，然后判断旧中是否存在相同节点 B，当发现存在节点 B 后，就去判断是否移动 B。
B 在旧的节点中的 index=1，它的 lastIndex=0，不满足 index < lastIndex 的条件，因此 B 不做移动操作。此时，一个操作是，lastIndex=(index,lastIndex)中的较大数=1.
注意：lastIndex 有点像浮标，或者说是一个 map 的索引，一开始默认值是 0，它会与 map 中的元素进行比较，比较完后，会改变自己的值的（取 index 和 lastIndex 的较大数）。
（2）看着 A，A 在旧的 index=0，此时的 lastIndex=1（因为先前与新的 B 比较过了），满足 index<lastIndex，因此，对 A 进行移动操作，此时 lastIndex=max(index,lastIndex)=1。
（3）看着 D，同（1），不移动，由于 D 在旧的 index=3，比较时，lastIndex=1，所以改变 lastIndex=max(index,lastIndex)=3
（4）看着 C，同（2），移动，C 在旧的 index=2，满足 index<lastIndex（lastIndex=3），所以移动。
由于 C 已经是最后一个节点，所以 diff 操作结束。

情形二：新集合中有新加入的节点，旧集合中有删除的节点

<img src="/img/image-20220522162430005.png" alt="image-20220522162430005" style="zoom:50%;" />

移动 2、

（1）B 不移动，不赘述，更新 l astIndex=1
（2）新集合取得 E，发现旧不存在，故在 lastIndex=1 的位置 创建 E，更新 lastIndex=1
（3）新集合取得 C，C 不移动，更新 lastIndex=2
（4）新集合取得 A，A 移动，同上，更新 lastIndex=2
（5）新集合对比后，再对旧集合遍历。判断 新集合 没有，但 旧集合 有的元素（如 D，新集合没有，旧集合有），发现 D，删除 D，diff 操作结束。

**diff 的不足与待优化的地方**

<img src="/img/image-20220522162627677.png" alt="image-20220522162627677" style="zoom:50%;" />

移动 3、

看图的 D，此时 D 不移动，但它的 index 是最大的，导致更新 lastIndex=3，从而使得其他元素 A,B,C 的 index<lastIndex，导致 A,B,C 都要去移动。
理想情况是只移动 D，不移动 A,B,C。因此，在开发过程中，尽量减少类似将最后一个节点移动到列表首部的操作，当节点数量过大或更新操作过于频繁时，会影响 React 的渲染性能。

#### Vue2 与 Vue3 的 diff

**Vue2.0diff 痛点**

vue2.x 中的虚拟 dom 是进行**「全量的对比」**，在运行时会对所有节点生成一个虚拟节点树，当页面数据发生变更好，会遍历判断 virtual dom 所有节点（包括一些不会变化的节点）有没有发生变化；虽然说 diff 算法确实减少了多 DOM 节点的直接操作，但是这个**「减少是有成本的」**，如果是复杂的大型项目，必然存在很复杂的父子关系的 VNode,**「而 Vue2.x 的 diff 算法，会不断地递归调用 patchVNode，不断堆叠而成的几毫秒，最终就会造成 VNode 更新缓慢」**。

**Vue3.0 解决方案-动静结合 PatchFlag**

在 Vue3.0 中，在这个模版编译时，编译器会在动态标签末尾加上 /_ Text_/ PatchFlag。**「也就是在生成 VNode 的时候，同时打上标记，在这个基础上再进行核心的 diff 算法」**并且 PatchFlag 会标识动态的属性类型有哪些，比如这里 的 TEXT 表示只有节点中的文字是动态的。而 patchFlag 的类型也很多。

<img src="/img/image-20220605222439383.png" alt="image-20220605222439383" style="zoom:80%;" />

其中大致可以分为两类：

- 当 patchFlag 的值「大于」 0 时，代表所对应的元素在 patchVNode 时或 render 时是可以被优化生成或更新的。
- 当 patchFlag 的值「小于」 0 时，代表所对应的元素在 patchVNode 时，是需要被 full diff，即进行递归遍历 VNode tree 的比较更新过程。

总结：**「Vue3.0 对于不参与更新的元素，做静态标记并提示，只会被创建一次，在渲染时直接复用。」**

#### React Fiber（React16 版本）

diff 算法相对传统算法已经是比较高效的计算机制了，但是人总是要有追求，三年前左右 react 就发现了 reconciliation 的一个潜在问题，就是在对比两颗树的时候，花费的时间太长，可能导致浏览器假死，所以就启动了一个项目来重写 reconciliation，那就是 react fiber.

**为什么？**
这里不得不提浏览器的渲染机制，现在基本上公认的是 60fps，也就是说浏览器会在每秒内渲染 60 次，也就是基本上 16.7ms 渲染一次。
(为什么是 60fps 呢，这里和硬件的刷新频率有关系，有兴趣的可以查下)
基本渲染流程如下
1，执行 js
2，样式计算
3，计算布局，执行
4，pait，绘制各层
5，合成各层的绘制结果，呈现在浏览器上。
所以基本上就是在 16.7ms 内执行完这些操作，就是比较完美的啦，但是事情不可能这么完美，比如如果 js 代码执行时间特别长的话，一直在等你的 js 执行完之后，才会去渲染，页面就是一直空白。

1、 React 从版本 16 开始弃用 diff 算法，改为 Fiber 渲染方式进行组件差异化比较

旧版的 diff 算法是递归比较，对 virtural dom 的更新和渲染是同步的。就是当一次更新或者一次加载开始以后，virtual dom 的 diff 比较并且渲染的过程是一口气完成的。如果组件层级比较深，相应的堆栈也会很深，长时间占用浏览器主线程，一些类似用户输入、鼠标滚动等操作得不到响应。造成线程柱塞，因此 React 官方改变了之前的 Virtual Dom 的渲染机制，新架构使用链表形式的虚拟 DOM，新的架构使原来同步渲染的组件现在可以异步化，可中途中断渲染，执行更高优先级的任务。释放浏览器主线程。

我们使用两张图来区分两种算法之间的区别

<img src="/img/image-20220522162934356.png" alt="image-20220522162934356" style="zoom:50%;" />

<img src="/img/image-20220522163114966.png" alt="image-20220522163114966" style="zoom:50%;" />

**React15 与 React16 两个 DOM 的结构和遍历方式已经完全不同**

# 2.vuecli 定制化自己的模板文件

需要准备内容包含三个件

- generator/index.js
- preset.json
- template 自己封装的一套代码

generator/index.js 文件内容

```
const fs = require('fs');
const tool = (api) => {
    return {
        deleteFile(path) {
            const file = api.resolve(path);
            if (fs.existsSync(file)) {
                fs.unlinkSync(file);
            }
        },
        deleteDir(path) {
            const dir = api.resolve(path);
            if (fs.existsSync(dir)) {
                fs.readdirSync(dir).forEach((o) => {
                    const file = dir + '\\' + o;
                    if (fs.statSync(file).isDirectory()) {
                        fs.readdirSync(dir).forEach((p) => {
                            fs.unlinkSync(dir + '\\' + o + '\\' + p);
                        });
                    } else {
                        fs.unlinkSync(file);
                    }
                });
                fs.rmdirSync(dir);
            }
        }
    };
};
module.exports = (api, options, rootOptions) => {
    const utils = tool(api);
    // 命令
    api.extendPackage({
        scripts: {
            "serve": "vue-cli-service serve",
            "build": "vue-cli-service build",
            "lint": "vue-cli-service lint"
        },
    });

    // 安装一些基础公共库
    api.extendPackage({
        dependencies: {
            "core-js": "^3.6.4",
            "vue": "^2.6.11",
            "vue-router": "^3.1.5",
            "vuex": "^3.1.2",
            "element-ui": "^2.15.6",
            "vant": "^2.12.31",
            "axios": "^0.24.0",
        },
        devDependencies: {
            "@vue/cli-plugin-babel": "~4.5.0",
            "@vue/cli-plugin-router": "~4.5.0",
            "@vue/cli-plugin-vuex": "~4.5.0",
            "@vue/cli-service": "~4.5.0",
            "less": "^3.0.4",
            "less-loader": "^5.0.0",
            "vue-template-compiler": "^2.6.11"
        }
    });
    api.render('../template');
    api.onCreateComplete(() => {
        process.env.VUE_CLI_SKIP_WRITE = true;
    });
};
```

preset.json 文件内容

```
{
    "useConfigFiles": true,
    "plugins": {
        "@vue/cli-plugin-babel": {},
        "@vue/cli-plugin-router": {
            "historyMode": true
        },
        "@vue/cli-plugin-vuex": {}
    },
    "cssPreprocessor": "less"
}
```

**将模版上传 github**

- https://github.com/fuyunjinglong/vue2_template

**安装 vue3 cli**

```
npm install -g @vue/cli
```

**创建项目**

```
vue create --preset fuyunjinglong/vue2_template demo
```

# 3.Vue2.0 最佳实践

## 1.实现防抖截流函数

```
import {debounce} from "@/utils/utils"
```

```
methods: {
      inputNum: debounce(function(){
          console.log(1111);
      }, 1000)
  }
```

# 4.Vue 核心组件-[Vue-router 路由原理](https://segmentfault.com/a/1190000023662742)

vue-router 的作用就是通过改变 URL，在不重新请求页面的情况下，更新页面视图。简单的说就是，虽然地址栏的地址改变了，但是并不是一个全新的页面，而是之前的页面某些部分进行了修改。

## 路由懒加载

三种懒加载方式：

1. vue异步组件
2. es提案的import()
3. webpack的require,ensure()

**1.vue异步组件**

```
{ 
path: '/home', 
name: 'home', 
component: resolve => **require**(['@/components/home'],resolve) 
},
```

**2.es提案的import()**

```
const Home = () => import('@/components/home')
```

**3.webpack的require,ensure()**

```
{ 
path: '/home', 
name: 'home', 
component: r => require.ensure([], () => r(require('@/components/home')), 'demo') 
},
```



## hash 模式

hash 模式是 vue-router 的默认模式。hash 指的是 url 描点，当描点发生变化的时候，浏览器只会修改访问历史记录，不会访问服务器重新获取页面。因此可以监听描点值的变化，根据描点值渲染指定 dom。

**实现原理**

- 改变描点

可以通过`location.hash = "/hashpath"`的方式修改浏览器的 hash 值。

- 监听描点变化

可以通过监听 hashchange 事件监听 hash 值的变化。

```dart
window.addEventListener('hashchange', () => {
   const hash = window.location.hash.substr(1)
   // 根据hash值渲染不同的dom
})
```

## history 模式

hash 模式下，url 可能为以下形式：

```
http://localhost:8080/index.html#/book?bookid=1
```

上面的 url 中既有#又有?，会让 url 看上去很奇怪，因此，可以使用 history 模式，在此模式下，url 会如下面所示：

```
http://localhost:8080/book/1
```

**实现原理**

- 改变 url

H5 的 history 对象提供了 pushState 和 replaceState 两个方法，当调用这两个方法的时候，url 会发生变化，浏览器访问历史也会发生变化，但是浏览器不会向后台发送请求。

```awk
// 第一个参数：data对象，在监听变化的事件中能够获取到
// 第二个参数：title标题
// 第三个参数：跳转地址
history.pushState({}, "", '/a')
```

- 监听 url 变化

可以通过监听 popstate 事件监听 history 变化，也就是点击浏览器的前进或者后退功能时触发。

```dart
window.addEventListener("popstate", () => {
    const path = window.location.pathname
    // 根据path不同可渲染不同的dom
})
```

## 服务端支持

当使用 hash 模式的时候，如果手动刷新浏览器，页面也能够正常显示。但是在 history 模式下，刷新浏览器就会出现问题。

如访问`http://localhost:8080/book/1`时，服务端会查找是否有相应的 html 能够匹配此路径，在单页应用下，服务端只有一个 index.html，所以此时匹配不到，会提示 404。针对这个问题，需要服务端进行 history 模式支持。

**node 服务**

在 nodejs 服务中，可以引入`connect-history-api-fallback`插件：

```stylus
const path = require('path')
// 导入处理 history 模式的模块
const history = require('connect-history-api-fallback')
// 导入 express
const express = require('express')

const app = express()
// 注册处理 history 模式的中间件
app.use(history())
// 处理静态资源的中间件，网站根目录 ../web
app.use(express.static(path.join(__dirname, '../web')))

// 开启服务器，端口是 3000
app.listen(3000, () => {
  console.log('服务器开启，端口：3000')
})
```

**nginx 服务**

在 nginx 服务中，可以如下方式修改配置文件，添加 history 模式支持：

```nginx
location / {
    root html;
    index index.html index.htm;
    #新添加内容
    #尝试读取$uri(当前请求的路径)，如果读取不到读取$uri/这个文     件夹下的首页
    #如果都获取不到返回根目录中的 index.html
    try_files $uri $uri/ /index.html;
}
```

## 实现自定义 VueRouter

VueRouter 核心是，通过 Vue.use 注册插件，在插件的 install 方法中获取用户配置的 router 对象。当浏览器地址发生变化的时候，根据 router 对象匹配相应路由，获取组件，并将组件渲染到视图上。

**三个重要点**

- **如何在 install 方法中获取 vue 实例上的 router 属性**。

可以利用 Vue.mixin 混入声明周期函数 beforeCreate，在 beforeCreate 函数中可以获取到 Vue 实例上的属性并赋值到 Vue 原型链上。

```angelscript
_Vue.mixin({
   beforeCreate () {
      if (this.$options.router) {
        _Vue.prototype.$router = this.$options.router
      }
   }
})
```

- **如何触发更新**

hash 模式下：

1. 通过 location.hash 修改 hash 值，触发更新。
2. 通过监听 hashchange 事件监听浏览器前进或者后退，触发更新。

history 模式下：

1. 通过 history.pushState 修改浏览器地址，触发更新。
2. 通过监听 popstate 事件监听浏览器前进或者后退，触发更新。

- **如何渲染 router-view 组件**

1. 通过 Vue.observable 在 router 实例上创建一个保存当前路由的监控对象 current。
2. 当浏览器地址变化的时候，修改监控对象 current。
3. 在 router-view 组件中监听监控对象 current 的变化，当 current 变化后，获取用户注册的相应 component，并利用 h 函数将 component 渲染成 vnodes，进而更新页面视图。

完整代码

```
// 存储全局使用的Vue对象
let _Vue = null
class VueRouter {
  // vue.use要求plugin具备一个install方法
  static install (Vue) {
    // 判断插件是否已经安装过
    if (VueRouter.install.installed) {
      return
    }
    VueRouter.install.installed = true
    _Vue = Vue

    // 将main文件中实例化Vue对象时传入的router对象添加到Vue的原型链上。
    _Vue.mixin({
      beforeCreate () {
        if (this.$options.router) {
          _Vue.prototype.$router = this.$options.router
        }
      }
    })
  }

  constructor (options) {
    this.options = options
    // 用于快速查找route
    this.routeMap = {}
    this.data = _Vue.observable({
      current: window.location.hash.substr(1)
    })
    this.init()
  }

  init () {
    this.createRouteMap()
    this.initComponents(_Vue)
    this.initEvent()
  }

  createRouteMap () {
    // 遍历所有的路由规则 吧路由规则解析成键值对的形式存储到routeMap中
    this.options.routes.forEach(route => {
      this.routeMap[route.path] = route.component
    })
  }

  initComponents (Vue) {
    // 注册router-link组件
    Vue.component('router-link', {
      props: {
        to: String
      },
      methods: {
        clickHandler (e) {
          // 修改hash
          location.hash = this.to
          // 修改current，触发视图更新
          this.$router.data.current = this.to
          e.preventDefault()
        }
      },
      render (h) {
        return h('a', {
          attrs: {
            href: this.to
          },
          on: {
            click: this.clickHandler
          }
        }, [this.$slots.default])
      }
    })
    const that = this
    // 注册router-view插件
    Vue.component('router-view', {
      render (h) {
        const component = that.routeMap[that.data.current]
        return h(component)
      }
    })
  }

  initEvent () {
    // 在hash发生更改的时候，修改current属性，触发组件更新
    window.addEventListener('hashchange', () => {
      this.data.current = window.location.hash.substr(1)
    })
  }
}

export default VueRouter
```

## 路由导航守卫

分三种：全局守卫，路由独享守卫，组件级守卫。

**完整的导航解析流程：**

1. 导航被触发。
2. 在失活的组件里调用 `beforeRouteLeave` 守卫。
3. 调用全局的 `beforeEach` 守卫。
4. 在重用的组件里调用 `beforeRouteUpdate` 守卫(2.2+)。
5. 在路由配置里调用 `beforeEnter`。
6. 解析异步路由组件。
7. 在被激活的组件里调用 `beforeRouteEnter`。
8. 调用全局的 `beforeResolve` 守卫(2.5+)。
9. 导航被确认。
10. 调用全局的 `afterEach` 钩子。
11. 触发 DOM 更新。
12. 调用 `beforeRouteEnter` 守卫中传给 `next` 的回调函数，创建好的组件实例会作为回调函数的参数传入。

### 1.全局守卫

**具体分为：全局前置守卫、全局解析守卫、全局后置钩子**

**1.1 全局前置守卫-beforeEach**

```
// GOOD
router.beforeEach((to, from, next) => {
  if (to.name !== 'Login' && !isAuthenticated) next({ name: 'Login' })
  else next()
})
```

**1.2 全局解析守卫-beforeResolve**

在 **每次导航**时都会触发，但是确保在导航被确认之前，**同时在所有组件内守卫和异步路由组件被解析之后，解析守卫就被正确调用**

```
router.beforeResolve(async to => {
  if (to.meta.requiresCamera) {
    try {
      await askForCameraPermission()
    } catch (error) {
      if (error instanceof NotAllowedError) {
        // ... 处理错误，然后取消导航
        return false
      } else {
        // 意料之外的错误，取消导航并把错误传给全局处理器
        throw error
      }
    }
  }
})
```

**1.3 全局后置钩子**

不会接受 `next` 函数也不会改变导航本身，对于分析、更改页面标题、声明页面等辅助功能

```
router.afterEach((to, from, failure) => {
  if (!failure) sendToAnalytics(to.fullPath)
})
```

### 2.路由独享的守卫-beforeEnter

`beforeEnter` 守卫 **只在进入路由时触发**，不会在 `params`、`query` 或 `hash` 改变时触发

```
const routes = [
  {
    path: '/users/:id',
    component: UserDetails,
    beforeEnter: (to, from) => {
      // reject the navigation
      return false
    },
  },
]
```

### 3.组件内的守卫

- `beforeRouteEnter`
- `beforeRouteUpdate`
- `beforeRouteLeave`

```
const UserDetails = {
  template: `...`,
  beforeRouteEnter(to, from) {
    // 在渲染该组件的对应路由被验证前调用
    // 不能获取组件实例 `this` ！
    // 因为当守卫执行时，组件实例还没被创建！
  },
  beforeRouteUpdate(to, from) {
    // 在当前路由改变，但是该组件被复用时调用
    // 举例来说，对于一个带有动态参数的路径 `/users/:id`，在 `/users/1` 和 `/users/2` 之间跳转的时候，
    // 由于会渲染同样的 `UserDetails` 组件，因此组件实例会被复用。而这个钩子就会在这个情况下被调用。
    // 因为在这种情况发生的时候，组件已经挂载好了，导航守卫可以访问组件实例 `this`
  },
  beforeRouteLeave(to, from) {
    // 在导航离开渲染该组件的对应路由时调用
    // 与 `beforeRouteUpdate` 一样，它可以访问组件实例 `this`
  },
}
```

**`$route`和`$router`的区别**

- $route 是`路由信息对象`，包括 path，params，hash，query，fullPath，matched，name 等路由信息参数。
- 而$router 是`路由实例`对象包括了路由的跳转方法，钩子函数等。

# 5.Vue 核心组件-vuex

Vuex**集中式**存储管理应用的所有组件的状态，规定所有的数据操作必须通过 `action -> mutation -> state(响应式数据)` ->update view

<img src="/img/image-20220529182549936.png" alt="image-20220529182549936" style="zoom:67%;" />

- Vue Components：Vue 组件。HTML 页面上，负责接收用户操作等交互行为，执行 dispatch 方法触发对应 action 进行回应。
- dispatch：操作行为触发方法，是唯一能执行 action 的方法。
- actions：操作行为处理模块。负责处理 Vue Components 接收到的所有交互行为。包含同步/异步操作，支持多个同名方法，按照注册的顺序依次触发。向后台 API 请求的操作就在这个模块中进行，包括触发其他 action 以及提交 mutation 的操作。该模块提供了 Promise 的封装，以支持 action 的链式触发。
- commit：状态改变提交操作方法。对 mutation 进行提交，是唯一能执行 mutation 的方法。
- mutations：状态改变操作方法。是 Vuex 修改 state 的唯一**推荐**方法，**其他修改方式在严格模式下将会报错**。该方法只能进行同步操作，且方法名只能全局唯一。操作之中会有一些 hook 暴露出来，以进行 state 的监控等。
- state：页面状态管理容器对象。集中存储 Vue components 中 data 对象的零散数据，全局唯一，以进行统一的状态管理。页面显示所需的数据从该对象中进行读取，利用 Vue 的细粒度数据响应机制来进行高效的状态更新。
- getters：state 对象读取方法。图中没有单独列出该模块，应该被包含在了 render 中，Vue Components 通过该方法读取全局 state 对象。就像 computed 计算属性一样，getter 返回的值会根据它的依赖被缓存

## vuex 的组成

<img src="/img/image-20220530070800925.png" alt="image-20220530070800925" style="zoom:50%;" />

**Q1：vuex 的插件加载机制**

所谓插件机制，就是需要实现 Install 方法，并且通过`mixin`形式混入到 Vue 的生命周期中

利用 vue 的插件机制，使用 Vue.use(vuex) 时，会调用 vuex 的 install 方法，装载 vuex。applyMixin 方法使用 vue 混入机制，vuex 是利用 vue 的 mixin 混入机制，在 beforeCreate 钩子前混入 vuexInit 方法，vuexInit 方法实现了 store 注入 vue 组件实例，并注册了 vuex store 的引用属性 `$store`。store 注入过程如下图所示：

<img src="/img/image-20220529183039739.png" alt="image-20220529183039739" style="zoom:80%;" />

将初始化 Vue 根组件时传入的 store 设置到 this 对象的 `$store` 属性上，子组件从其父组件引用 `$store` 属性，层层嵌套进行设置。在任意组件中执行 `this.$store` 都能找到装载的那个 store 对象。

Vue.use(Vuex) 方法执行的是 install 方法，它实现了 Vue 实例对象的 init 方法封装和注入，使传入的 store 对象被设置到 Vue 上下文环境的 `$store` 中。因此在 Vue Component 任意地方都能够通过 `this.$store` 访问到该 store。

**Q2. state 内部支持模块配置和模块嵌套，如何实现的？**

在 store 构造方法中有 makeLocalContext 方法，所有 module 都会有一个 local context，根据配置时的 path 进行匹配。所以执行如 `dispatch('user', payload)` 这类 action 时，默认的拿到都是 module 的 local state，如果要访问最外层或者是其他 module 的 state，只能从 rootState 按照 path 路径逐步进行访问。

**Q3. Vuex 如何区分 state 是外部直接修改，还是通过 mutation 方法修改的？**

Vuex 中修改 state 的唯一渠道就是执行 `commit` 方法，其底层通过执行 `this._withCommit(fn)` 设置 `_committing` 标志变量为 true，然后才能修改 state，修改完毕还需要还原 `_committing` 变量。外部修改虽然能够直接修改 state，但是并没有修改 `_committing` 标志位，所以只要 `watch` 一下 state，state 改变时判断是否 `_committing` 值为 true，即可判断修改的合法性

**Q4. vuex 的 state 和 getters 是如何映射到各个组件实例中响应式更新状态呢？**

```js
function resetStoreVM(store, state, hot) {
  const oldVm = store._vm;

  // 设置 getters 属性
  store.getters = {};
  const wrappedGetters = store._wrappedGetters;
  const computed = {};
  // 遍历 wrappedGetters 属性
  forEachValue(wrappedGetters, (fn, key) => {
    // 给 computed 对象添加属性
    computed[key] = partial(fn, store);
    // 重写 get 方法
    // store.getters.xx 其实是访问了store._vm[xx]，其中添加 computed 属性
    Object.defineProperty(store.getters, key, {
      get: () => store._vm[key],
      enumerable: true, // for local getters
    });
  });

  const silent = Vue.config.silent;
  Vue.config.silent = true;
  // 创建Vue实例来保存state，同时让state变成响应式
  // store._vm._data.$$state = store.state
  store._vm = new Vue({
    data: {
      $$state: state,
    },
    computed,
  });
  Vue.config.silent = silent;

  // 只能通过commit方式更改状态
  if (store.strict) {
    enableStrictMode(store);
  }
}
```

Vuex 的 state 状态是响应式，是借助 vue 的 data 响应式，将 state 存入 vue 实例组件的 data 中；Vuex 的 getters 则是借助 vue 的计算属性 computed 实现数据实时监听。

<img src="/img/image-20220529183414437.png" alt="image-20220529183414437" style="zoom:67%;" />

## **自定义实现一个 Vuex**

```js
// store.js
let Vue

// 定义store类
class Store{
  constructor(options = {}) {
    this.$options = options
    this._mutations = options.mutations
    this._actions = options.actions
   this._wrappedGetters = options.getters


    // 定义computed
    const computed = {}
    this.getters = {}
    const store = this
    Object.keys(this._wrappedGetters).forEach(key => {
      // 获取用户定义的getters
      const fn = store._wrappedGetters[key]

      // 转换为computed可以使用无参数形式
      computed[key] = function() {
        return fn(store.state)
      }

      // 为getters定义只读属性
      Object.defineProperty(store.getters, key {
       get:() => store._vm[key]
     })
    })

    // state的响应式实现
    this._vm = new Vue({
      data: {
        // 加两个$，Vue不做代理
        $$state: options.state
      },
      computed // 添加计算属性
    })

    this.commit = this.commit.bind(this)
    this.dispatch = this.dispatch.bind(this)
  }

  // 存取器，获取store.state ，只通过get形式获取，而不是直接this.xxx, 达到对state
  get state() {
    return this._vm._data.$$state
  }

 set state(v) {
    // 如果用户不通过commit方式来改变state，就可以在这里做一控制
  }

  // commit的实现
  commit(type, payload) {
    const entry = this._mutations[type]
    if (entry) {
      entry(this.state, payload)
    }
  }

  // dispatch的实现
  dispatch(type, payload) {
    const entry = this._actions[type]
    if (entry) {
      entry(this, payload)
    }
  }
}

// 实现install
function install(_Vue) {
  Vue = _Vue
  Vue.mixin({
    beforeCreate() {
      if (this.$options.store) {
       Vue.prototype.$Store = this.$options.store // 这样就可以使用 this.$store
      }
    }
  })
}

// 导出Vuex对象
export default {
  Store,
  install
}
```

# 5.Vue 核心组件-动态路由

## 动态路由的 2 种方案

1. 前端将全部路由规定好，登录时根据用户角色权限来动态展示路由；
2. 路由存储在数据库中，前端通过接口获取当前用户对应路由列表并进行渲染；

## 实战-大致思路

> - 若未登录，跳转至登录页面
> - 若已经登录，判断是否已获取路由列表
>   - 若未获取，从后端获取、解析并保存到 `Vuex` 中
>   - 若已获取，跳转至目标页面

## 实战-路由列表解析

1. 将 `JSON` 格式的路由信息解析为 `JavaScript` 列表对象；
2. 利用列表对象的 `filter` 方法实现解析函数，通过 `component` 判断是否为布局组件；
3. 若为布局组件，使用布局组件代替 `component` 字符串；
4. 若为具体页面，使用 `loadView` 函数加载对应的具体页面；

```js
// router/index.js
import Vue from "vue";
import store from "@/store";
import Router from "vue-router";
import { getToken } from "@/lib/util";

Vue.use(Router);

// 定义静态路由
const staticRoutes = [
  {
    path: "/login",
    name: "login",
    meta: {
      title: "登录页面",
      hideInMenu: true,
    },
    component: () => import("@/view/login/login.vue"),
  },
  {
    path: "/401",
    name: "error_401",
    meta: {
      hideInMenu: true,
    },
    component: () => import("@/view/error-page/401.vue"),
  },
  {
    path: "/500",
    name: "error_500",
    meta: {
      hideInMenu: true,
    },
    component: () => import("@/view/error-page/500.vue"),
  },
];

// 定义登录页面名称（为了方便理解才定义的）
const LOGIN_PAGE_NAME = "login";

// 实例化 Router 对象
const router = new Router({
  routes: staticRoutes,
  mode: "history",
});

// 定义全局前置守卫（里面有两个坑要注意）
router.beforeEach((to, from, next) => {
  // 通过自定义方法获取用户 token 用来判断用户登录状态
  const token = getToken();
  if (!token && to.name !== LOGIN_PAGE_NAME) {
    // 如果没有登录而且前往的页面不是登录页面，跳转到登录页
    next({ name: LOGIN_PAGE_NAME });
  } else if (!token && to.name === LOGIN_PAGE_NAME) {
    // 如果没有登录而且前往的页面是登录页面，跳转到登录页面
    // 这里有一个坑，一定要注意这一步和上一步得分开写
    // 如果把前两步判断合并为 if (!token) next({ name:login })
    // 则会形成登录页面无限刷新的错误，具体成因后面解释
    next();
  } else {
    // 如果登录了
    if (!store.state.app.hasGetRoute) {
      // 如果没有获取路由信息，先获取路由信息而后跳转
      store.dispatch("getRouteList").then(() => {
        router.addRoutes(store.state.app.routeList);
        // 这里也是一个坑，不能使用简单的 next()
        // 如果直接使用 next() 刷新后会一直白屏
        next({ ...to, replace: true });
      });
    } else {
      // 如果已经获取路由信息，直接跳转
      next();
    }
  }
});
export default router;
```

```js
// store/index.js
import router from "@/router";
import Main from "@/components/main";
import { getToken } from "@/lib/util";
import { getRoute } from "@/api/app";

const loadView = (viewPath) => {
  // 用字符串模板实现动态 import 从而实现路由懒加载
  return () => import(`@/view/${viewPath}`);
};

const filterAsyncRouter = (routeList) => {
  return routeList.filter((route) => {
    if (route.component) {
      if (route.component === "Main") {
        // 如果 component = Main 说明是布局组件
        // 将真正的布局组件赋值给它
        route.component = Main;
      } else {
        // 如果不是布局组件就只能是页面的引用了
        // 利用懒加载函数将实际页面赋值给它
        route.component = loadView(route.component);
      }
      // 判断是否存在子路由，并递归调用自己
      if (route.children && route.children.length) {
        route.children = filterAsyncRouter(route.children);
      }
      return true;
    }
  });
};

export default {
  state: {
    routeList: [],
    token: getToken(),
    hasGetRoute: false,
  },
  mutations: {
    setRouteList(state, data) {
      // 先将 JSON 格式的路由列表解析为 JavaScript List
      // 再用路由解析函数解析 List 为真正的路由列表
      state.routeList = filterAsyncRouter(JSON.parse(data));
      // 修改路由获取状态
      state.hasGetRoute = true;
    },
  },
  atcions: {
    getRouteList({ state, commit }) {
      return new Promise((resolve) => {
        const token = state.token;
        getRoute({ token }).then((res) => {
          let data = res.data.data;
          // 注意这里取出的是 JSON 格式的路由列表
          commit("setRouteList", data);
          resolve();
        });
      });
    },
  },
};
```

## 常见问题

**1.页面卡在登录页面而且不断刷新**

主要原因是把两种未登录的状态混在一起判断

**2.动态路由刷新后 404**

是因为在创建「基本静态路由」的时候回把 404 页面的路由也加入在里面，从而导致页面加载初期动态路由还没有加入到路由实例中，匹配范围最广的 404 页面就会跳出来。解决方法就是将 404 页面的路由也加入到动态路由中。

# 6.Vue 原理-事件总线 Bus 发布订阅

**源码**

```
// $on 的实现逻辑
Vue.prototype.$on = function (event: string | Array<string>, fn: Function): Component {
    const vm: Component = this
    if (Array.isArray(event)) {
      for (let i = 0, l = event.length; i < l; i++) {
        vm.$on(event[i], fn)
      }
    } else {
      (vm._events[event] || (vm._events[event] = [])).push(fn)
    }
    return vm
  }

// $emit 的实现逻辑
Vue.prototype.$emit = function (event: string): Component {
    const vm: Component = this
    let cbs = vm._events[event]
    if (cbs) {
      cbs = cbs.length > 1 ? toArray(cbs) : cbs
      const args = toArray(arguments, 1)
      const info = `event handler for "${event}"`
      for (let i = 0, l = cbs.length; i < l; i++) {
        invokeWithErrorHandling(cbs[i], vm, args, vm, info)
      }
    }
    return vm
  }

// invokeWithErrorHandling 的实现逻辑
export function invokeWithErrorHandling (
  handler: Function,
  context: any,
  args: null | any[],
  vm: any,
  info: string
) {
  let res
  try {
    res = args ? handler.apply(context, args) : handler.call(context)
  } catch (e) {
    handleError(e, vm, info)
  }
  return res
}
```

**分析：**

1. 首先我们都了解 vue 的数据相应是依赖于“观察-订阅”模式，那 o n 、 on、on、emit 也不例外;
2. $on 用来收集所有的事件依赖，他会将传入的参数 event 和 fn 作为 key 和 value 的形式存到 vm.\_events 这个事件集合里，就像这样 vm.\_events[event]=[fn];
3. 而$emit 是用来触发事件的，他会根据传入的 event 在 vm_events 中找到对应的事件并执行 invokeWithErrorHandling(cbs[i], vm, args, vm, info)
4. 最后我们看 invokeWithErrorHandling 方法可以发现，他是通过 handler.apply(context, args)和 handler.call(context)的形式执行对应的方法

**自定义实现一个 Bus**

```
// Bus： 事件派发、监听和回调
class Bus {
  constructor() {
    this.callbacks = {}
  }
  // 收集监听的回调函数
  $on(name, fn) {
    this.callbacks[name] = this.callbacks[name] || []
    this.callbacks[name].push(fn)
  }
  // 执行监听的回调函数
  $emit(name, args) {
    if (this.callbacks[name]) {
      this.callbacks[name].forEach(cb => cb(args))
    }
  }
}
// 在main.js中这样使用
Vue.prototype.$bus = new Bus()
```

**手写发布订阅**

```js
class EventEmitter {
  constructor() {
    this.cache = {};
  }

  on(name, fn) {
    if (this.cache[name]) {
      this.cache[name].push(fn);
    } else {
      this.cache[name] = [fn];
    }
  }

  off(name, fn) {
    const tasks = this.cache[name];
    if (tasks) {
      const index = tasks.findIndex((f) => f === fn || f.callback === fn);
      if (index >= 0) {
        tasks.splice(index, 1);
      }
    }
  }

  emit(name, once = false) {
    if (this.cache[name]) {
      // 创建副本，如果回调函数内继续注册相同事件，会造成死循环
      const tasks = this.cache[name].slice();
      for (let fn of tasks) {
        fn();
      }
      if (once) {
        delete this.cache[name];
      }
    }
  }
}

// 测试
const eventBus = new EventEmitter();
const task1 = () => {
  console.log("task1");
};
const task2 = () => {
  console.log("task2");
};

eventBus.on("task", task1);
eventBus.on("task", task2);
eventBus.off("task", task1);
setTimeout(() => {
  eventBus.emit("task"); // task2
}, 1000);
```

**手写发布订阅 2**

1. **首先定义一个`list`对象用于存放事件的集合的映射表**
   **当调用`on`事件绑定的时候通过传入的事件名判断当前是否已存在`list`中，不存在则先设置一个空数组，否则就直接 push 进去。**
2. **`emit`发布执行对应事件 event 对入参 arguments 进行处理（shift 剪出要触发的事件名），通过事件名先浅拷贝一个列表副本，然后遍历执行对应列表的所有的函数`this.list[event][i].apply(this, arguments)`**
3. `remove`删除事件先获取`fns`对应主题的函数列表进行一些判断，**如果没指定删除列表中的哪个函数（函数引用）就默认把对应整个列表给删除，如果有传 fn 就在循环中和对应的函数进行引用的判断`fns.fn === fn`是给 once 函数删除的时候使用的**
4. **`once`这里给传入的订阅者包装成一个闭包函数，把订阅者`fn`放在订阅者`once`函数属性下，当对应订阅者执行的时候先执行这个闭包函数删除掉自身后再去执行挂在`once`下的订阅者`fn`，做到用完即删。**

**因为如果想使用`remove`方法删除`once`订阅者的话和删除普通订阅者不一样，单凭传入的 fn(`fns[i] === fn`)是删除不掉`once`订阅者的（因为传入的`fn`函数和`once`包装函数引用不相等），需要用到包装函数下的`fn`属性引用（`fns.fn === fn`）去识别订阅者才能进行删除。**

**核心代码-eventEmitter.js**

```
//发布订阅模式
var eventEmitter = (function () {
  "use strict";
  var eventEmitter = {
    list: {},
    //订阅主题
    on: function (event, fn) {
      if (typeof fn !== "function") {
        return false;
      }
      //创建订阅者列表,如果存在就直接插入
      (this.list[event] || (this.list[event] = [])).push(fn);
      return this;
    },
    //发布主题
    emit: function () {
      var event = [].shift.call(arguments);
      if (this.list[event] && this.list[event].length) {
        var fns = this.list[event].slice();
        //浅拷贝后直接对列表所有订阅者函数依次执行
        for (var i in fns) {
          this.list[event][i].apply(this, arguments);
        }
        return this;
      }
      return false;
    },
    //创建执行后立即销毁的订阅者
    once(event, fn) {
      function once() {
        this.remove(event, once);
        fn.apply(this, arguments);
      }
      //存储当前fn副本用于删除时的查找
      once.fn = fn;
      this.on(event, once);
      return this;
    },
    //移除对应订阅者
    remove: function (event, fn) {
      var fns = this.list[event];
      if (!fns) return false;
      //如没传递对应的订阅者函数引用，就默认删除整个事件列表
      if (!fn) {
        delete this.list[event];
        return this;
      }
      //找到对应的订阅者进行删除,包括once的订阅者
      for (var i = 0; i <= fns.length; i++) {
        if (fns[i] === fn || fns.fn === fn) {
          fns.splice(i, 1);
          break;
        }
      }
      return this;
    },
  };
  return eventEmitter;
})();
```

**使用**

```
<script src="./eventEmitter.js"></script>
<script>
    //注册订阅者
    eventEmitter.on('test',(t)=>{
        document.querySelector('#txt').textContent = t;
    })
    //发布
    eventEmitter.emit('test','start...');
</script>
```

# 7.Vue 数组变异方法

- 变异方法：改变原数组的方法
- 非变异方法：不会改变原数组的方法

**变异方法**

- push( )
- pop( )
- shift( )
- unshift( )
- splice( )
- sort( )
- reverse( )

**非变异方法**

- filter( )
- concat( )
- slice( )

**Vue 变异方法源码**

变异的本质就在这些方法内部加上自定义的逻辑，其实就是想监听这些方法的调用。

Vue 中默认的做法就是在数组实例与它的原型之间，插入了一个新的原型对象，这个原型方法实现了这些变异方法，也就拦截了真正数组原型上的方法（因为原型链的机制，找到了就不会继续往上找了）。 变异方法中增加了自定义逻辑，也调用了真正数组原型上的方法，即实现了目的，也不会对正常使用造成影响。

```js
const arrayProto = Array.prototype
export const arrayMethods = Object.create(arrayProto)
const methodsToPatch = [
  'push',
  'pop',
  'shift',
  'unshift',
  'splice',
  'sort',
  'reverse'
]

/**
 * Intercept mutating methods and emit events
 */
methodsToPatch.forEach(function (method) {
  // cache original method
  const original = arrayProto[method]
  def(arrayMethods, method, function mutator (...args) {
    const result = original.apply(this, args)
    const ob = this.__ob__
    let inserted
    switch (method) {
      case 'push':
      case 'unshift':
        inserted = args
        break
      case 'splice':
        inserted = args.slice(2)
        break
    }
    if (inserted) ob.observeArray(inserted)
    // notify change
    ob.dep.notify()
    return result
  })
})const ob = this.__ob__
    let inserted
    switch (method) {
      case 'push':
      case 'unshift':
        inserted = args
        break
      case 'splice':
        inserted = args.slice(2)
        break
    }
    if (inserted) ob.observeArray(inserted)
    // notify change，关键关键关键
    ob.dep.notify()
```

# 8.vue 项目中的优化

**编码阶段**

- 不要在模板里面写过多表达式
- 尽量减少`data`中的数据，`data`中的数据都会增加`getter`和`setter`，会收集对应的`watcher`
- `v-if`和`v-for`不能连用
- 如果需要使用`v-for`给每项元素绑定事件时使用事件代理
- `SPA` 页面采用`keep-alive`缓存组件
- 频繁切换的使用 v-show，不频繁切换的使用 v-if
- 循环调用子组件时添加 key，`key`保证唯一
- 使用路由懒加载、异步组件
- 防抖、节流
- 第三方模块按需导入
- 长列表滚动到可视区域动态加载
- 图片懒加载

\*\*
\*\*

**SEO 优化**

- 预渲染
- 服务端渲染`SSR`，`nuxt.js`

**打包优化**

- 压缩代码
- `Tree Shaking/Scope Hoisting`
- 使用`cdn`加载第三方模块
- 多线程打包`happypack`
- `splitChunks`抽离公共文件
- `sourceMap`优化

**用户体验**

- 骨架屏
- `PWA`渐进式 Web 应用，使用多种技术来增强 web app 的功能，让网页应用呈现和原生应用相似的体验。

# 9.SFC

平时写的 .vue 文件称为 SFC(Single File Components)。vue 会先对 .vue 文件进行解析，分成 template、script、styles、customBlocks 四个部分，称为 descriptor。之后，再对这四个部分分别进行编译最终得到可以在浏览器中执行的 .js 文件.最终编译成.js 文件是交给 vue-loader 等库来做的。

SFCDescriptor，是表示 .vue 各个代码块的对象，为以下数据格式：

```
// an object format describing a single-file component.
declare type SFCDescriptor = {
    template: ?SFCBlock;
    script: ?SFCBlock;
    styles: Array<SFCBlock>;
    customBlocks: Array<SFCBlock>;
};
```

vue 提供了一个 [`compiler.parseComponent(file, [options\])`方法]，来将 .vue 文件解析成一个 SFCDescriptor。

**1.文件入口**

解析 sfc 文件的源码入口在 src/sfc/parser.js 中，编译后的产出在 /packages/vue-template-compiler 和 /packages/vue-server-renderer 下的 build.js 中。

build.js 文件中直接 export 出了`parseComponent`方法。

首先我们来看看`parseComponent`方法都做了哪些事情。

**`2.parseComponent`方法**

`parseComponent`方法中主要定义了`start`和`end`两个函数，之后调用了`parseHTML`方法来对 .vue 文件内容践行编译。`start`和`end`两个函数作为参数传给了`parseHTML`，我们等下再看。

先看下这个`parseHTML`方法是做啥的呢？

**`3.parseHTML`方法**

该方法看名字可以猜到是一个 html-parser。

parseHTML 的代码细节较多，我们可以简单理解为：遍历解析查找文件中的各个标签，解析到每个起始标签时，调用 option 中的 start 方法进行处理；解析到每个结束标签时，调用 option 中的 end 方法进行处理。

对应到这里，就是分别调用`parseComponent`方法中定义的 `start` 和 `end` 函数进行处理。

由于我们这里只是想要找到第一层标签，也就是 template、script 这些。因此可以在`parseComponent`中维护一个 depth 变量，在`start`中将`depth++`，在`end`中`depth--`。那么，每个`depth === 1`的标签就是我们需要获取的信息，包含 template、script、style 以及一些自定义标签。

接下来我们来看`start`和`end`中进行了哪些处理。

`4.start`

每当遇到一个起始标签时，执行`start`函数。

1、记录下 currentBlock。每个 currentBlock 包含以下内容：

2、根据 tag 名称，将 currentBlock 对象保存在在返回结果对象中。

返回结果对象定义为 sfc，如果 tag 不是 script,style,template 中的任一个，就放在 sfc.customBlocks 中。如果是 style，就放在 sfc.styles 中。script 和 template 则直接放在 sfc 下。

`5.end`

每当遇到一个结束标签时，执行`end`函数。

如果当前是第一层标签(depth === 1)，并且 currentBlock 变量存在，那么取出这部分 text，放在 currentBlock.content 中。

在将 .vue 整个遍历一遍后，得到的 sfc 对象即为我们需要的 SFCDescriptor。

**6.生成 .js**

`compiler.parseComponent(file, [options])`得到的只是一个组件的 `SFCDescriptor`，最终编译成.js 文件是交给 vue-loader 等库来做的。

# 10.Vue2.0 实战-尚硅谷

## 1.基础代码

```html
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Document</title>
    <style>
      #app {
        background-color: pink;
      }
      .app-msg {
        color: yellow;
      }
    </style>
    <script src="./vue.min.js"></script>
  </head>
  <body>
    <div id="app">
      <h1 class="app-msg">{{msg}}</h1>
      <div v-cloak>{{noData}}</div>
      <div v-text="textData"></div>
      <div v-html="textData"></div>
      <input />
    </div>
    <script>
      Vue.config.productionTiop = false; //阻止Vue在生产环境下产生提示
      var vm = new Vue({
        el: "#app",
        data() {
          return {
            msg: "基本代码",
            noData: "无数据",
            textData: '<span style="color:red">阳光</span>',
          };
        },
        mounted() {
          const that = this;
          setTimeout(() => {
            that.noData = "";
          }, 1000);
        },
      });
      console.log("vm", vm);
    </script>
  </body>
</html>
```

vm 实例如下：

<img src="/img/image-20220608072943567.png" alt="image-20220608072943567" style="zoom:67%;" />

## 2.关于数据代理

通过一个对象代理另一个对象中属性的读写操作，如 vue 将\_data 数据代理到 VM 实例上，为每个属性都添加 getter 和 setter 操作，更加方便操作 data 中数据。

```js
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

源码本质

```js
let data = {
  name: "cc",
};
//创建一个监视实例对象
const obs = new Oberver(data);
//准备一个vm实例
let vm = {};
vm._data = data = obs;
function Observer(obj) {
  //遍历所有属性形成一个数组
  const keys = Object.keys(obj);
  keys.forEach((k) => {
    Object.defineProperty(this, k, {
      get() {
        return obj[k];
      },
      set(val) {
        obj[k] = val;
      },
    });
  });
}
```

## 3.深度监听

Vue 默认不监听对象内部值变化，需要监听的话，设置 deep:true

## 4.Vue与VueComponent的关系

```
<body>
    <div id="root">
         <school></school>
    </div>
    <script>
        Vue.config.productionTip = false
        //定义school组件
        const school = Vue.extend({
            name: 'school',
            template: `
              <div>
                <h2>学校名称：{{name}}</h2>
                <h2>学校地址：{{address}}</h2>
              </div>
            `,
            data() {
                return {
                    name: '尚硅谷',
                    address: '北京'
                }
            }   
        })
        //创建Vue
        new Vue({
            el:'#root',
            components:{
                school,
            }
        })
    </script>
</body>
```

<img src="/img/image-20220706071836848.png" alt="image-20220706071836848" style="zoom:80%;" />

每个函数function都有一个prototype属性，即显式原型（属性）。它默认指向Object空对象，

每个实例对象都有一个__proto__属性，即称隐式原型（属性）。

**一个重要的内置关系**：`VueComponent.prototype._proto_===Vue.prototype`.VueComponent把原本指向Object的原型对象改到指向Vue原型对象（黄线）.

**为什么要有这个关系**：让组件实例对象vc可以访问到Vue原型上的属性、方法。

Vue和是VueComponent就像一对孪生双胞胎，他们绝大多数的属性和方法都很像，但不同的是定义组件时不能挂载el，且data要写成函数形式，而Vue可以写成对象形式。

## 5.不同版本的vue

关于不同版本的vue:

1. vue.js与vue.runtime.xxx.js区别：

   1. vue.js是完整版vue,包含核心模块+模板解析器
   2. vue.runtime.xxx.js是运行版vue，只包含核心功能，没有模板解析器

2. 因为vue.runtime.xxx.js没有模板解析器，所以不能使用template配置项，需要使用render函数接收的createElement函数去制定具体内容。

   ```
   new Vue({
   	el:'#app',
   	render:h=>h(APP)
   	// render:q=>q('h1','你好啊')
   	// render(createElemet){
   	// return createElemet('h1','你好啊')
   	//}
   })
   ```


## 6.插件技术

main.js

```
import plugins from './plugins'
Vue.use(plugins)
```

plugins.js

本质是包含install方法的对象，第一个参数是Vue

```
export default{
	install(Vue){
		//全局过滤器
		Vue.filter('mySlice',()=>{})
		//全局指令
		Vue.directive('mySlice',()=>{})
		// 全局混入
		Vue.mixin('mySlice',()=>{})
		Vue.prototype.$hello ='xx'
	}
}
```

## 7.Socpe样式

```
<style lang='less'></style>
不指定lang，则默认按照css处理。否则按照less,sass等处理器处理
```

## 8.自定义事件

props属性值也可以传递函数

child.vue

```
...
<button @click="getVal"></button>
props:['getFatherVal'],
method:{
	getVal(){
		this.getFatherVal()
	}
}
```

**销毁事件**

```
this.$off('clickMe')//销毁一个事件
this.$off(['clickMe]')//销毁多个事件
this.$off()//解绑所有自定义事件
this.$destory()//销毁实例并解绑所有自定义事件
```

## 9.过渡效果

**原生CSS**

```
.come{
	animation:aiMe 1s;
}
@keyframes aiMe{
	from{
		transform:translateX(-100px)
	}
	to{
		transform:translateX(0px)
	}
}
```

**Vue2的transition标签**

```
<transition name="hello" appear>//使用name标记动画，appear初次加载产生动画
	<div v-show="isShow"></div>
</transition>

.hello-enter-active{
	animation:aiMe 1s linear;
}
.hello-leave-active{
	animation:aiMe 1s linear reverse;
}
```

*还有另外的2个指令hello-enter，hello-enter-to，可能比较繁琐*

```
<transition name="hello" appear>//使用name标记动画，appear初次加载产生动画
	<div v-show="isShow"></div>
</transition>
// 进入的起点，离开的终点
.hello-enter,.hello-leave-to{
	transform：translateX(-100px)
}
.hello-enter-active,hello-leave-active{
	transform: 1s linear;
}
// 进入的终点，离开的起点
.hello-enter-to,.hello-leave{
	transform：translateX(-100px)
}
```

*transition-group多个元素过度*

```
<transition-group name="hello" appear>//必须保证key唯一
	<div v-show="isShow" key="0"></div>
	<div v-show="isShow" key="0"></div>
</transition>
```

*使用第三方动画animate.css*

```
<transition-group name="animate_animated animate_bounce"
	enter-active-class="animate_swing"
	leave-active-calss="animate-backOutUp"
>
	<div v-show="isShow"></div>
</transition>
```

## 10.路由

**query参数**

```
<!--1.完整路径-->
<router-link :to="/home?id=11"></router-link>
<!--2.通过名字跳转-->
<router-link :to="{name:'home'}"></router-link>
<!--3.配合参数->
<router-link :to="{
path:'/home',
query:{
id:11
}
}"></router-link>
```

**param参数**

```
路由配置
{
	name:home,
	path:'/home/:id',// id占位符
	conponent:Home
}
<!--1.完整路径-->
<router-link :to="/home/11"></router-link>
<!--2.配合参数->
<router-link :to="{
name:'home',
param:{
id:11
}
}"></router-link>
```

**Props配置项**

```
路由配置
{
	name:home,
	path:'/home/:id',// id占位符
	conponent:Home，
	props:{id:99},//用法1，固定值
	props:true//用法2，只能接受所有的params参数
	props:(route){//用法3，返回一组数据,路由组件可以接收到
		return{
			id：route.param.id
		}
	}
}

组件
props:[id]
```

**push和replace**

push是追加历史记录，replace是替换当前最新记录

```
开启replace模式
<router-link replace :to="/home/11"></router-link>
```



# 11.v-if 与 v-for 比较

- 2.x 版本中在一个元素上同时使用 `v-if` 和 `v-for` 时，`v-for` 会优先作用
- 3.x 版本中 `v-if` 总是优先于 `v-for` 生效。

# 12.nodeJS 手写 mock 数据服务器

## 前言

- koa 基本使用
- koa-router 的基本用法
- koa-logger 的使用
- glob 支持文件遍历查寻
- node 几个核心 api 的使用
- 使用 nodemon 做自动重启

## 核心代码

[github 源码](https://github.com/MrXujiang/openCoder/tree/master/mockServer)

api/v1/user.json 目录层级结构

**index.js**-关键五部曲

```
const Koa = require('koa');
const Router = require('koa-router');
const glob = require("glob");
const logger = require('koa-logger')
const { resolve } = require('path');
const fs = require('fs');

const app = new Koa();
const router = new Router({prefix: '/api'});
const routerMap = {};  // 存放路由映射
//4.添加控制台日志 我们使用koa-logger实现在终端打印node日志，方便调试
app.use(logger());

//2.注册路由 我们使用koa-router来实现后台服务的路由功能，并通过koa提供的上下文ctx将读取到的数据返回给前端
//3.自动注册api接口并返回数据 我们将在这个阶段实现api服务的自动注册，这里我们使用glob这个第三方模块来遍历目录，并通过node的fs模块读取api文件的数据并返回给前台
glob.sync(resolve('./api', "**/*.json")).forEach((item, i) => {
    let apiJsonPath = item && item.split('/api')[1];
    let apiPath = apiJsonPath.replace('.json', '');

    router.get(apiPath, (ctx, next) => {
        try {
            let jsonStr = fs.readFileSync(item).toString();
            ctx.body = {
                data: JSON.parse(jsonStr),
                code: 200,
            }
        }catch(err) {
            ctx.throw('服务器错误', 500);
        }
      });
    // 记录路由
    routerMap[apiJsonPath] = apiPath;
});
//5.路由映射文件的生成 该功能也不是本文的重点，但是会极大的方便前端开发者调试请求
fs.writeFile('./routerMap.json', JSON.stringify(routerMap, null , 4), err => {
    if(!err) {
        console.log('路由地图生成成功！')
    }
});

app
  .use(router.routes())
  .use(router.allowedMethods());
//1.搭建一个node服务
app.listen(9001);

```

**nodemon.json**

```
{
    "restartable": "rs",
    "ignore": [
        ".git",
        "dist",
        ".cache",
        "routerMap.json",
        "readme.md",
        "node_modules/**/node_modules"
    ],
    "verbose": true,
    "watch": [
        "./"
    ],
    "ext": "js json"
}
```

**package.json**

```
{
  "name": "mockserver",
  "version": "1.0.0",
  "description": "",
  "main": "index.js",
  "scripts": {
    "test": "echo \"Error: no test specified\" && exit 1",
    "dev": "nodemon -w ./ --exec"
  },
  "author": "",
  "license": "ISC",
  "dependencies": {
    "glob": "^7.1.4",
    "koa": "^2.8.1",
    "koa-logger": "^3.2.1",
    "koa-router": "^7.4.0",
    "nodemon": "^1.19.2"
  }
}
```
