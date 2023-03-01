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

## methods和watch、computed

watch和computed都是对数据的监听只有数据发生变化时才会触发。

***watch更擅长一对多***：就是主要监听一个可以影响多个数据的数据，watch比computed更强大。因为它能处理异步。
**computed擅长多对一**：主要监听多个数据影响一个数据的数据，一定要return

**methods**是通过事件驱动来执行函数的是被动的，watch、computed是当监听的数据发生变化时主动执行这个函数。

methods的运算是没有缓存的，computed运算是有缓存的。

## v-if产生的内存泄漏问题

v-if 绑定到 false 的值，但是实际上 dom 元素在隐藏的时候没有被真实的释放掉。

比如下面的示例中，我们加载了一个带有非常多选项的选择框，然后我们用到了一个显示/隐藏按钮，通过一个 v-if 指令从虚拟 DOM 中添加或移除它。这个示例的问题在于这个 v-if 指令会从 DOM 中移除父级元素，但是我们并没有清除由 js文件中新添加的 DOM 片段，从而导致了内存泄漏。

## 数组变异方法

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

变异的本质就是重写原型链,在这些方法内部加上自定义的逻辑，其实就是想监听这些方法的调用。

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

# 进阶

## 数据响应式

首先要了解vue的初始化

```js
/*初始化生命周期*/
initLifecycle(vm)
/*初始化事件*/
initEvents(vm)Object.defineProperty 
/*初始化render*/
initRender(vm)
/*调用beforeCreate钩子函数并且触发beforeCreate钩子事件*/
callHook(vm, 'beforeCreate')
initInjections(vm) // resolve injections before data/props
/*初始化props、methods、data、computed与watch*/
initState(vm)
initProvide(vm) // resolve provide after data/props
/*调用created钩子函数并且触发created钩子事件*/
callHook(vm, 'created')
```

**initState(vm)** 是用来初始化props,methods,data,computed和watch;**initState**中的**initData**为关键一步。

**initData**做了两件事：1将_data上面的数据代理到vm；2执行observe()，将所有data变成可观察的。

关键3步：

1）Observer.defineProperty劫持data中的每一个属性添加`getter`和`setter`即数据劫持

2）创建`dep`和`watcher`进行`依赖收集`和`派发更新`，即订阅发布

3）通过`diff`算法对比新旧vnode差异，通过`patch`即时更新DOM

简单理解：Dep可以看做是书店，Watcher就是书店订阅者，而Observer就是书店的书，订阅者在书店订阅书籍，就可以添加订阅者信息，一旦有新书就会通过书店给订阅者发送消息。Observer与Dep是1对1，Dep和Watcher是多对多。

## Observer/Dep/Watcher

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



## **双向绑定**

- Vue是单向数据流，不是双向绑定
- Vue的双向绑定不过是语法糖，v-bind数据绑定 与 v-on处理函数绑定
- Object.definePropert是用来做响应式更新的

父组件

```
<AnalysisSub v-model="phoneInfo" :zip-code.sync="zipCode" />
或 <AnalysisSub :phone-info="phoneInfo" @change="val => (phoneInfo = val)"
    :zip-code="zipCode"  @update:zipCode="val => (zipCode = val)"/>
```

子组件

```
<template>
  <div>
    <input
      :value="phoneInfo.phone"
      type="number"
      placeholder="手机号"
      @input="handlePhoneChange"
    />
    <input
      :value="zipCode"
      type="number"
      placeholder="邮编"
      @input="handleZipCodeChange"
    />
  </div>
</template>
<script>
export default {
  name: "PersonalInfo",
  model: {
    prop: "phoneInfo", // 默认 value
    event: "change" // 默认 input
  },
  props: {
    phoneInfo: Object,
    zipCode: String
  },
  methods: {
    handlePhoneChange(e) {
      this.$emit("change", {
        ...this.phoneInfo,
        phone: e.target.value
      });
    },
    handleZipCodeChange(e) {
      this.$emit("update:zipCode", e.target.value);
    }
  }
};
</script>
```

```
允许一个自定义组件在使用 v-model 时定制 prop 和 event。默认情况下，一个组件上的 v-model 会把 value 用作 prop 且把 input 用作 event，但是一些输入类型比如单选框和复选框按钮可能想使用 value prop 来达到不同的目的。使用 model 选项可以回避这些情况产生的冲突。
在有些情况下，我们可能需要对一个 prop 进行“双向绑定”。不幸的是，真正的双向绑定会带来维护上的问题，因为子组件可以修改父组件，且在父组件和子组件都没有明显的改动来源。
v-model和.sync修饰符分别在组件单个属性、多个属性需要双向绑定下使用，这是二者使用的场景。引入sync标记。这种双向的改变可以灵活控制，但是会带来维护上的复杂性
```

**Object.defineProperty 与 Proxy**

1.Object.defineProperty：
只能对属性进行劫持，需要递归遍历对象的每个属性，执行Object.defineProperty把每一层对象数据都变成响应式的（如果定义的响应式数据过于复杂，会有很大的性能负担）
不能检测对象属性的添加和删除（需要重新遍历）
2.Proxy
在getter中去递归响应式，真正访问到的内部对象才会变成响应式，而不是无脑递归，提升了性能
劫持的是整个对象，能检测到对象属性的添加和删除

## 虚拟dom和diff算法

原理：虚拟dom和diff算法

**虚拟DOM**

好处：

1. 减少直接操作DOM。框架给我们提供了屏蔽底层dom书写的方式，减少频繁的整更新dom，同时也使得数据驱动视图
2. 为函数式UI编程提供可能（React核心思想）
3. 可以跨平台，渲染到DOM（web）之外的平台。比如ReactNative，Weex

虚拟DOM就是一个普通的JavaScript对象，包含了`tag`、`props`、`children`三个属性。

真实dom非常复杂，包括各种属性和事件方法等。

简单场景下真实dom效率高，复杂场景下，操作虚拟dom效率高。

**diff算法**

虚拟DOM + Diff算法才是vue提高性能的关键，**Diff算法是一种对比算法**，**执行差异化补丁更新**。对比两者是`旧虚拟DOM和新虚拟DO`。

Diff算法比较只会在同层级进行, 不会跨层级比较。 所以Diff算法是:`深度优先算法`。 时间复杂度:`O(n)`。

直到oldNodeStart>=oldNodeEnd&&newNodeStart>=newNodeEnd不符合条件，diff算法才最终结束。

vue的diff算法参考了`snabbdom`(https://github.com/snabbdom/snabbdom)是著名的虚拟DOM库，diff算法的鼻祖。

![image-20211012230610276](/img/image-20211012230610276.png)

1.patch中的sameVnode方法：判断是否为相同节点：依据key和tag标签名

- 是：继续执行`patchVnode方法`进行深层比对
- 否：没必要比对了，直接整个节点替换成`新虚拟节点`

*key值是否一样*；*标签名是否一样*；*否都为注释节点*；*是否都定义了data*

2.patchVnode：更新节点

- 判断`newVnode`和`oldVnode`是否指向同一个对象，如果是，那么直接`return`
- 如果他们都是文本节点并且不相等，那么将`el`的文本节点设置为`newVnode`的文本节点。
- 如果`oldVnode`有子节点而`newVnode`没有，则删除`el`的子节点
- 如果`oldVnode`没有子节点而`newVnode`有，则将`newVnode`的子节点真实化之后添加到`el`
- 如果两者都有子节点，则执行`updateChildren`函数比较子节点，这一步很重要

3.`updateChildren`：首尾指针法

> **「双端比较的算法」**过程可以概括为：oldCh和newCh各有两个头尾的变量StartIdx和EndIdx，它们的2个变量相互比较，一共有4种比较方式。如果4种比较都没匹配，如果设置了key，就会用key进行比较，在比较的过程中，变量会往中间靠，一旦StartIdx>EndIdx表明oldCh和newCh至少有一个已经遍历完了，就会结束比较.

oldNode头尾指针标记，newNode头尾指针标记。

oldNode与newNode指针逐个比较，如果判定相同节点，则执行patchVnode更新节点。

否则以newNode的key去oldNode中寻找等key值，如果找到key相等的，再比较sameVnode，如果相同，则patchVnode更新节点，否则插入节点。如果没有找到key相等的，则插入节点。

如果结束后，oldNodeStart>=oldNodeEnd，那么就需要删除旧节点中部分节点。newNodeStart>=newNodeEnd，那么需要新增新节点中的部分节点。

## 虚拟dom和diff算法2

**虚拟 dom**

最少包含标签名( tag)、属性(attrs)和子元素对象( children)三个属性。

- 由于 dom 操作耗时十分长，且 dom 对象的体积很大，单个 div 的 dom 属性就有 294 个之多；
- Virtual DOM 就是用一个原生的 JS 对象去描述一个 DOM 节点，所以它比创建一个 DOM 的代价要小很多。
- VNode 是对真实 DOM 的一种抽象描述，它的核心定义无非就几个关键属性，标签名、数据、子节点、键值等，其它属性都是用来扩展 VNode 的灵活性以及实现一些特殊 feature 的。由于 VNode 只是用来映射到真实 DOM 的渲染，不需要包含操作 DOM 的方法，因此它是非常轻量和简单的。
- Virtual DOM 到真实的 dom 需要经过以下过程：VNode 的 create、diff、patch

其实虚拟 DOM 在 Vue.js 主要做了两件事：

- 提供与真实 DOM 节点所对应的虚拟节点 vnode
- 将虚拟节点 vnode 和旧虚拟节点 oldVnode 进行对比（diff 算法），然后更新视图

**Diff 算法从 O(n^3) 到 O(n)-vue2/3 都是如此**

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

## runtime-compiler和runtime-only

**1.Vue的编译渲染过程**

template => ast => render函数 => VDOM => 真实DOM

- 先将template解析成抽象语法树（ast）
- 将ast编译成（complier）成render函数
- 将render函数渲染（render）成虚拟DOM
- 最后将虚拟DOM渲染成真实DOM

**runtime-with-compiler**

```
new Vue({
  el:'#app',
  components:{APP},
  template:'<APP/>'
})
```

渲染过程：template ==> ast ==> render ==> vdom ==> UI

**runtime-only**

```
new Vue({
  el:'#app',

  render: h=>h(APP)
})
```

渲染过程：render ==> vdom ==> UI

| runtime-compiler                     | runtime-only           |
| :----------------------------------- | :--------------------- |
| 体积更大（有compiler代码）           | 体积更小               |
| 有Vue.compilerAPI                    | 无Vue.compilerAPI      |
| 可以使用template模板、render函数渲染 | 只能使用render函数渲染 |

- 若只使用指令、数据绑定等，此时写template比写render函数更容易理解并方便，则需使用Runtime + Compiler构建的Vue库
- 挂载DOM元素的HTML被提取出来作为模板，则需使用Runtime + Compiler构建的Vue库

**本质**

runtime-with-compiler的打包入口文件是src/platforms/web/entry-runtime-with-compiler.js

runtime-only的打包入口文件是src/platforms/web/entry-runtime.js

runtime-with-compiler调用了runtime-only的$mount,并原形重写其方法。

**打包流程**

![image-20220113072406138](/img/image-20220113072406138.png)

## keep-alive原理

**1.定义**

keep-alive是一个抽象组件：它是一个vNode虚拟节点，它自身不会渲染一个 DOM 元素，也不会出现在父组件链中。

keep-alive包裹动态组件时，会缓存不活动的组件实例，而不是销毁它们。

**2.功能**

`include`定义缓存白名单，keep-alive会缓存命中的组件；`exclude`定义缓存黑名单，被命中的组件将不会被缓存；`max`定义缓存组件上限，超出上限使用[LRU的策略](https://link.juejin.cn/?target=https%3A%2F%2Fbaike.baidu.com%2Fitem%2FLRU)置换缓存数据。`include`优先级比`exclude`更高。

**3.源码分析**

**(1.1)初始化过程：**

1. 获取keep-alive包裹的组件及组件名。
2. 根据设置的黑白名单，判断缓存是否命中，命中则使用缓存，否则直接创建或销毁组件。核心函数pruneCacheEntry
3. 根据组件ID和tag生成缓存Key，value为componentInstance组件实例的键值对。
4. 键值对超过max长度，使用LRU最近最少使用策略删除。
5. 设置keepAlive为true即标记为激活状态,patch期间渲染组件，mounted等生命周期过滤

```
// src/core/components/keep-alive.js
export default {
  name: 'keep-alive',
  abstract: true, // 判断当前组件虚拟dom是否渲染成真实dom的关键

  props: {
    include: patternTypes, // 缓存白名单
    exclude: patternTypes, // 缓存黑名单
    max: [String, Number] // 缓存的组件实例数量上限，使用LRU最近最少使用的组件删除
  },
//核心是cache和keys，keys里默认值是tagname。
//这两个属性没有声明到可视化的data中,静态属性声明可以减少数据监听的开销
  created () {
    this.cache = Object.create(null) // 缓存虚拟dom的key和实例的映射
    this.keys = [] // 缓存的虚拟dom的key键集合
  },

  destroyed () {
  //销毁时，更新cache
    for (const key in this.cache) { // 删除所有的缓存
      pruneCacheEntry(this.cache, key, this.keys)
    }
  },

  mounted () {
    // 实时监听黑白名单的变动
    this.$watch('include', val => {
      pruneCache(this, name => matches(val, name))
    })
    this.$watch('exclude', val => {
      pruneCache(this, name => !matches(val, name))
    })
  },

  render () {
    // 先省略...
  }
}

```

核心render函数

```
  // src/core/components/keep-alive.js
  render () {
    const slot = this.$slots.default
    const vnode: VNode = getFirstComponentChild(slot) // 找到第一个子组件对象
    const componentOptions: ?VNodeComponentOptions = vnode && vnode.componentOptions
    if (componentOptions) { // 存在组件参数
      // check pattern
      const name: ?string = getComponentName(componentOptions) // 组件名,name:'VBase'
      const { include, exclude } = this
      if ( // 条件匹配
        // not included
        (include && (!name || !matches(include, name))) ||
        // excluded
        (exclude && name && matches(exclude, name))
      ) {
      //没有匹配到，则直接返回节点
        return vnode
      }

      const { cache, keys } = this
      const key: ?string = vnode.key == null // 定义组件的缓存key
        // same constructor may get registered as different local components
        // so cid alone is not enough (#3269)
        ? componentOptions.Ctor.cid + (componentOptions.tag ? `::${componentOptions.tag}` : '')
        : vnode.key
      if (cache[key]) { // 已经缓存过该组件
      //将缓存的组件，赋值给你要渲染的新的组件
        vnode.componentInstance = cache[key].componentInstance
        // make current key freshest
        //删除并添加key
        remove(keys, key)
        keys.push(key) // 调整key排序
      } else {
        cache[key] = vnode // 缓存组件对象
        keys.push(key)
        // prune oldest entry
        //如果超过max最大缓存组件的长度，使用LRU策略，删除第一个
        if (this.max && keys.length > parseInt(this.max)) { // 超过缓存数限制，将第一个删除
          pruneCacheEntry(cache, keys[0], keys, this._vnode)
        }
      }

      vnode.data.keepAlive = true // 渲染和执行被包裹组件的钩子函数需要用到
    }
    return vnode || (slot && slot[0])
  }

```

**(1.2)actived生命周期流程：**

patch阶段调用invokeInsertHook，执行activateChildComponent递归调用自组建的active生命周期。所以先执行子组件的active，然后是父组件的active.

deactivated也是类似。标记为失活状态。

4.使用场景

```
<keep-alive include="a,b">
  <!-- 将缓存name为a或者b的组件，结合动态组件使用 -->
  <component :is="view"></component>
</keep-alive>

<!-- 动态判断 -->
<keep-alive :include="includedComponents">
  <router-view></router-view>
</keep-alive>

<keep-alive>
    <router-view v-if="$route.meta.keepAlive"></router-view>
</keep-alive>
<router-view v-if="!$route.meta.keepAlive"></router-view>

```

- 首页是A页面
- B页面跳转到A，A页面需要缓存
- C页面跳转到A，A页面不需要被缓存

```
{
    path: '/',
    name: 'A',
    component: A,
    meta: {
        keepAlive: true // 需要被缓存
    }
}

export default {
    data() {
        return {};
    },
    methods: {},
    beforeRouteLeave(to, from, next) {
         // 设置下一个路由的 meta
        to.meta.keepAlive = true;  // B 跳转到 A 时，让 A 缓存，即不刷新
        next();
    }
};

export default {
    data() {
        return {};
    },
    methods: {},
    beforeRouteLeave(to, from, next) {
        // 设置下一个路由的 meta
        to.meta.keepAlive = false; // C 跳转到 A 时让 A 不缓存，即刷新
        next();
    }
};


```

**4.vue的渲染过程**

![image-20211212174443165](/img/image-20211212174443165.png)

- Vue在渲染的时候先调用原型上的`_render`函数将组件对象转化为一个**VNode实例**；而`_render`是通过调用`createElement`和`createEmptyVNode`两个函数进行转化。
- 完成VNode实例化后，Vue调用原型上的`_update`函数把VNode渲染为真实DOM，这个过程又是通过调用`__patch__`函数完成的。

keep-alive刚好就发生在patch期间。abstract: true也导致了vue渲染时，不会生成真正的实例。

## $nexttick原理

**1.概述**

在下次 `DOM` 更新循环结束之后执行延迟回调。`nextTick`主要使用了宏任务和微任务。根据执行环境分别尝试采用

- Promise
- MutationObserver
- setImmediate
- 如果以上都不行则采用setTimeout

定义了一个异步方法，多次调用nextTick会将方法存入队列中，通过这个异步方法清空当前队列。

**2.源码分析**

nextTick源码主要分为两块：

- 1.能力检测
- 2.根据能力检测以不同方式执行回调队列

**(2.1)能力检测**

Event Loop分为宏任务（macro task）以及微任务（ micro task），不管执行宏任务还是微任务，完成后都会进入下一个tick，并在两个tick之间执行UI渲染。

宏任务耗费的时间是大于微任务的，所以在浏览器支持的情况下，优先使用微任务。如果浏览器不支持微任务，使用宏任务；但是，各种宏任务之间也有效率的不同，需要根据浏览器的支持情况，使用不同的宏任务。

nextTick在能力检测这一块，就是遵循的这种思想。

```
//首先，检测浏览器是否支持setImmediate，不支持就使用MessageChannel，再不支持只能使用效率最差但是兼容性最好的setTimeout了。
//之后，检测浏览器是否支持Promise，如果支持，则使用Promise来执行回调函数队列，毕竟微任务速度大于宏任务。如果不支持的话，就只能使用宏任务来执行回调函数队列。
if (typeof setImmediate !== 'undefined' && isNative(setImmediate)) {
  // 如果支持，宏任务（ macro task）使用setImmediate
  macroTimerFunc = () => {
    setImmediate(flushCallbacks)
  }
  // 同上
} else if (typeof MessageChannel !== 'undefined' && (
  isNative(MessageChannel) ||
  // PhantomJS
  MessageChannel.toString() === '[object MessageChannelConstructor]'
)) {
  const channel = new MessageChannel()
  const port = channel.port2
  channel.port1.onmessage = flushCallbacks
  macroTimerFunc = () => {
    port.postMessage(1)
  }
} else {
  /* istanbul ignore next */
  // 都不支持的情况下，使用setTimeout
  macroTimerFunc = () => {
    setTimeout(flushCallbacks, 0)
  }
}
```

**(2.2)执行回调函数队列**

总体流程是:接收回调函数，将回调函数推入回调函数队列中。

```
// 回调函数队列
const callbacks = []
// 异步锁
let pending = false

// 执行回调函数
function flushCallbacks () {
  // 重置异步锁
  pending = false
  // 防止出现nextTick中包含nextTick时出现问题，在执行回调函数队列前，提前复制备份，清空回调函数队列
  const copies = callbacks.slice(0)
  callbacks.length = 0
  // 执行回调函数队列
  for (let i = 0; i < copies.length; i++) {
    copies[i]()
  }
}

...

// 我们调用的nextTick函数
export function nextTick (cb?: Function, ctx?: Object) {
  let _resolve
  // 将回调函数推入回调队列
  callbacks.push(() => {
    if (cb) {
      try {
        cb.call(ctx)
      } catch (e) {
        handleError(e, ctx, 'nextTick')
      }
    } else if (_resolve) {
      _resolve(ctx)
    }
  })
  // 如果异步锁未锁上，锁上异步锁，调用异步函数，准备等同步函数执行完后，就开始执行回调函数队列
  if (!pending) {
    pending = true
    if (useMacroTask) {
      macroTimerFunc()
    } else {
      microTimerFunc()
    }
  }
  // $flow-disable-line
  // 2.1.0新增，如果没有提供回调，并且支持Promise，返回一个Promise
  if (!cb && typeof Promise !== 'undefined') {
    return new Promise(resolve => {
      _resolve = resolve
    })
  }
}

```

有2个关键点：

*如何保证只在接收第一个回调函数时执行异步方法？*

nextTick源码中使用了一个异步锁的概念，即接收第一个回调函数时，先关上锁，执行异步方法。此时，浏览器处于等待执行完同步代码就执行异步代码的情况。

当然执行flushCallbacks函数时有个难以理解的点，即：*为什么需要备份回调函数队列？执行的也是备份的回调函数队列*？

因为，会出现这么一种情况：nextTick套用nextTick。如果flushCallbacks不做特殊处理，直接循环执行回调函数，会导致里面nextTick中的回调函数会进入回调队列。这就相当于，下一个班车的旅客上了上一个班车。

**3.自己实现简易的nextTick**

在简易版的nextTick中，通过nextTick接收回调函数，通过setTimeout来异步执行回调函数。通过这种方式，可以实现在下一个tick中执行回调函数，即在UI重新渲染后执行回调函数。

```
let callbacks = []
let pending = false

function nextTick (cb) {
    callbacks.push(cb)

    if (!pending) {
        pending = true
        setTimeout(flushCallback, 0)
    }
}

function flushCallback () {
    pending = false
    let copies = callbacks.slice()
    callbacks.length = 0
    copies.forEach(copy => {
        copy()
    })
}

```

## vue 性能优化

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

## SFC

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