---
title: Vue2
date: 2000-01-01 06:33:16
categories:
  - B_中级
toc: true # 是否启用内容索引
---

# 初级

## 声明式渲染与渐进式框架

- 声明式渲染：数据驱动视图
- 组件系统：UI 结构到组件树
- 核心插件(热插拔)：客户端路由、状态管理、构建系统 vue-cli

## vue.min.js体验

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

## MVC / MVP / MVVM

**1.定义**

MVC / MVP / MVVM 都是架构设计模式，用于分离数据、UI 和业务逻辑，让代码职责更清晰，便于维护和团队协作。

> - MVC：Model 负责数据，View 负责展示，Controller 接收用户输入并协调 Model 和 View。View 往往直接依赖 Model，Controller 容易膨胀。典型代表是早期 Backbone.js。
> - MVP：View 被动，不直接依赖 Model，Presenter 处理所有逻辑并更新 View。可测试性强，常见于对质量要求高的客户端应用。
> - MVVM：View 通过数据绑定与 ViewModel 关联，ViewModel 抽象 View 的状态和行为。框架帮我们完成“数据同步”，典型代表是 Vue 和 Angular，React 在实践中也类似 MVVM 的结构。

其中，MVVM

> - **Model**：数据与业务逻辑。
> - **View**：声明式 UI（模板/组件），通过**数据绑定**与 ViewModel 关联。
> - ViewModel：
>   - 抽取 View 的“状态 + 行为”，是 **View 的一对一抽象模型**。
>   - 不持有 View 引用，通过**数据绑定 + 命令**驱动 View 更新。

**2.优缺点**

> - MVC 最简单，但 View 与 Model 耦合，不利于扩展和测试。
> - MVP 可测试性最好，但 Presenter 容易写得很大。
> - MVVM 在前端框架中最常见，通过数据绑定减少手动 DOM 操作，适合数据驱动的 SPA。

**3.实践**

> - Vue：组件实例类似 ViewModel，模板是 View，通过响应式系统 + `v-model` 实现近似 MVVM 的结构。
> - React：JSX 是 View，Hook/状态类似 ViewModel，整体是 MVVM 风格，但官方更强调“视图层 + 单向数据流”，所以我们更多用状态管理、分层架构来组织业务逻辑，而不是硬套某个模式名称。

## 生命周期

<img src="/img/vue2生命周期.png" style="zoom:50%;" />

| Vue2          | Vue3            |
| ------------- | --------------- |
| beforeCreate  | setup           |
| created       | setup           |
| beforeMount   | onBeforeMount   |
| mounted       | onMounted       |
| beforeUpdate  | onBeforeUpdate  |
| updated       | onUpdated       |
| beforeDestory | onBeforeUnmount |
| destoryed     | onUnmounted     |

**1.时机**

> - beforeCreate：实例刚在内存中被创建出来，组件 `props`、`data`、`methods` 都还未初始化。
> - created：实例已创建，`data`、`methods`、`computed` 等已初始化，但 `DOM` 还未渲染（`$el` 不存在）。**发送 AJAX 请求、初始化数据（无需 DOM 的逻辑）**
> - beforeMount：模板编译完成，虚拟 DOM 已生成，但还未挂载到真实 DOM 上。最后一次修改数据不会触发重渲染。
> - mounted：真实 DOM 已挂载完成，`this.$el` 可访问。**操作 DOM、初始化第三方库、绑定 DOM 事件**
> - beforeUpdate：数据已变，DOM 还未更新（页面显示旧数据）。
> - updated：数据已变，DOM 已更新（页面显示新数据）。
> - beforeDestory：实例销毁前，实例属性（`data`、`methods`）仍可访问。**清除定时器、解绑全局事件监听器、销毁第三方实例**
> - destoryed：实例销毁后，所有事件监听和子组件均被移除。

**2.父子组件生命周期执行顺序**

加载渲染过程

> 父 beforeCreate -> 父 created -> 父 beforeMount -> **子 beforeCreate -> 子 created -> 子 beforeMount -> 子 mounted** -> 父 mounted

子组件更新过程

> 父 beforeUpdate -> 子 beforeUpdate -> 子 updated -> 父 updated

销毁过程

> 父 beforeDestroy -> 子 beforeDestroy -> 子 destroyed -> 父 destroyed

**3.特殊钩子：keep-alive**

当使用 `<keep-alive>` 缓存组件时，会新增两个钩子：

- `activated`：组件被激活时调用（从缓存中取出或首次加载）。
- `deactivated`：组件被停用时调用（切换到其他组件）。

## 自定义指令

**一、定义**

Vue 2 自定义指令主要用于对普通 DOM 元素进行底层操作，它提供了一组生命周期钩子函数（如 `bind`、`inserted`、`update`），允许开发者在指令绑定的不同阶段对 DOM 进行访问和修改，从而封装可复用的 DOM 操作逻辑。

在 Vue 2 中，当我们需要对 DOM 元素进行直接操作，而这些操作无法通过组件的模板语法或内置指令（如 `v-model`、`v-show`）完成时，自定义指令是最佳选择。

**二、注册方式**

自定义指令分为 **全局注册** 和 **局部注册**。

1.**全局注册**：在任何组件中都可以使用。

```js
    // 在 main.js 中
    Vue.directive('focus', {
      // 指令配置对象
    })
```

2.**局部注册**：只能在当前组件中使用。

```js
    // 在组件内部
    directives: {
      focus: {
        // 指令配置对象
      }
    }
```

**三、5个钩子函数**

| 钩子函数           | 调用时机                               | 说明                       |
| ------------------ | -------------------------------------- | -------------------------- |
| `bind`             | 指令第一次绑定到元素时                 | 只调用一次，适合初始化操作 |
| `inserted`         | 被绑定元素插入父节点时                 | 元素已存在于 DOM 中        |
| `update`           | 所在组件的 VNode 更新时                | 可能在子 VNode 更新前触发  |
| `componentUpdated` | 组件 VNode 及其子 VNode **全部更新后** | 更新完成后调用             |
| `unbind`           | 指令与元素解绑时                       | 只调用一次，适合清理工作   |

**钩子函数参**

> 每个钩子函数都会接收以下参数（除了 `update` 和 `componentUpdated` 多了一个 `oldVnode`）：
>
> - **`el`**：指令所绑定的元素，可以直接用来操作 DOM。
>
> - `binding`
>
>   ：一个对象，包含以下属性：
>
>   - `name`：指令名（不包括 `v-` 前缀）。
>   - `value`：指令的绑定值（例如 `v-my-dir="1 + 1"`，`value` 是 2）。
>   - `oldValue`：指令绑定的前一个值（仅在 `update` 和 `componentUpdated` 中可用）。
>   - `expression`：字符串形式的指令表达式（例如 `v-my-dir="1 + 1"`，`expression` 是 `"1 + 1"`）。
>   - `arg`：传给指令的参数（例如 `v-my-dir:foo`，`arg` 是 `"foo"`）。
>   - `modifiers`：一个包含修饰符的对象（例如 `v-my-dir.foo.bar`，`modifiers` 是 `{ foo: true, bar: true }`）。
>
> - **`vnode`**：Vue 编译生成的虚拟节点。
>
> - **`oldVnode`**：上一个虚拟节点（仅在 `update` 和 `componentUpdated` 中可用）。

**四、Vue 2 与 Vue 3 自定义指令**

1. 钩子函数名称变化：
   - Vue 2：`bind` -> `inserted` -> `update` -> `componentUpdated` -> `unbind`
   - Vue 3：重命名，为了与组件生命周期保持一致，更容易记忆。
     - `bind` →→ `beforeMount`
     - `inserted` →→ `mounted`
     - `update` →→ 被拆分（移除）
     - `componentUpdated` →→ `updated`
     - `unbind` →→ `unmounted`
2. 参数变化：
   - Vue 3 中，不再提供 `binding.expression` 和 `binding.arg` 等部分属性（虽然主要逻辑还在），且钩子中接受的 `vnode` 和 `oldVnode` 结构发生了变化。

## 自定义过滤器

**一、定义**

Vue 2 自定义过滤器主要用于**文本格式化**，它可以在插值表达式 `{{ }}` 或 `v-bind` 表达式中使用管道符 `|` 进行调用，对原始数据进行处理后返回显示结果，而不改变原始数据本身。过滤器本质上是一个 JavaScript 函数，接受输入值，处理后返回新的值。

注意：过滤器只能用在**插值表达式**和 **`v-bind`** 表达式中，不能用在 `v-model` 或其他指令中。

**二、注册方式**

过滤器分为 **全局注册** 和 **局部注册**。

1.**全局注册**：在所有 Vue 实例中都可以使用。

```js
    // 参数1：过滤器名称，参数2：过滤器函数
    Vue.filter('capitalize', function (value) {
      if (!value) return ''
      value = value.toString()
      return value.charAt(0).toUpperCase() + value.slice(1)
    })
```

2.**局部注册**：只在当前组件实例中可用。

```js
    export default {
      filters: {
        reverse(value) {
          return value.split('').reverse().join('')
        }
      }
    }
```

**三、使用方法**

过滤器通过管道符 `|` 进行连接，支持**串联**和**传参**。

```
{{ message | filteA | filterB('arg1', 'arg2') }}
```

## 常用修饰符

在 *vue* 中修饰符可以分为 *3* 类：

- 事件修饰符
- 按键修饰符
- 表单修饰符

事件修饰符

> - *.stop*：阻止冒泡。
> - *.prevent*：阻止默认事件。
> - *.capture*：使用事件捕获模式。
> - *.self*：只在当前元素本身触发。
> - *.once*：只触发一次。
> - *.passive*：默认行为将会立即触发。

按键修饰符

> - .*left*：左键
> - .*right*：右键
> - .*middle*：滚轮
> - .*enter*：回车
> - .*tab*：制表键
> - .*delete*：捕获 “删除” 和 “退格” 键
> - .*esc*：返回
> - .*space*：空格

表单修饰符

> - .*lazy*：在文本框失去焦点时才会渲染
> - .*number*：将文本框中所输入的内容转换为number类型
> - .*trim*：可以自动过滤输入首尾的空格

**面试高频追问应对**

> - 问：.stop 和 .self 有什么区别？
> - 答：.stop 是彻底阻止事件向上冒泡，父元素完全收不到通知；.self 只是限制回调函数的触发条件（必须是自身元素触发），但事件依然会冒泡，父元素的事件依然会被触发（如果父元素绑定了事件）。
> - 问：.passive 是做什么的？能提高什么性能？
> - 答：主要用于移动端滚动。告诉浏览器该事件监听器不会调用 preventDefault()，从而浏览器可以立即开始滚动页面，不用等待 JS 执行完毕。这能显著提升滚动帧率，防止页面卡顿。

## Vue Router的 params 与 query

**一、定义**

> `query` 传参类似于 HTTP 的 GET 请求，参数拼接在 URL 后面（`?key=value`），**刷新页面参数不丢失**；`params` 传参类似于 RESTful 风格，参数属于路由的一部分，**配合路由配置使用，如果不配置动态路由，刷新页面参数会丢失**。

**二、区别**

| 比较维度     | **Query**                     | **Params**                                                   |
| :----------- | :---------------------------- | :----------------------------------------------------------- |
| **表现形态** | `/path?id=123&name=tom`       | `/path/123` (动态路由) 或 不显示 (非配置)                    |
| **路由配置** | **不需要**特殊配置            | **通常需要**在 `path` 中定义动态段（如 `/:id`）              |
| **刷新页面** | **数据保留**（参数在 URL 上） | **数据丢失**（如果未配置动态路由）或 **数据保留**（如果配置了动态路由） |
| **获取方式** | `this.$route.query.id`        | `this.$route.params.id`                                      |
| **适用场景** | 搜索、筛选、分页等非敏感数据  | 必须存在才能正常访问的详情页 ID、用户唯一标识                |

**三、详细解析**

1.Query 传参

Query 传参就是我们传统 URL 中 `?` 后面的参数。

```js
   // 跳转支持path: '/user' 或者 name: 'User'
	this.$router.push({
      path: '/user',
      query: {
        userId: '123',
        name: 'alice'
      }
    });
    // 地址栏显示: /user?userId=123&name=alice
    // 获取
    const id = this.$route.query.userId;
```

2.Params 传参

**场景 A：配置了动态路由**

```js
    // 路由配置
    { path: '/user/:id', component: User, name: 'User' }

    // 跳转只支持name: 'User'(用 path 则无效)
    this.$router.push({
      name: 'User',
      params: {
        id: '123'
      }
    });
    // 地址栏显示: /user/123
    // 结果：刷新页面后，参数依然存在（因为 123 是 URL 路径的一部分）。
```

**场景 B：未配置动态路由**

如果路由配置是 `path: '/user'`（没有 `:id`）。*第一次进入能获取到 userId，但一旦刷新页面，参数就会丢失。*

**四、总结**

- **Query**：相当于 `?id=1`，**刷新保留**，适合搜索、筛选。
- **Params**：相当于 `/1`，**依赖路由配置**，配合 `name` 使用，适合详情页 ID。
- **核心技巧**：怕刷新丢失就用 `query` 或者把 `params` 写在路由配置的 `path` 里；传参必须用 `name` 时记得别用 `path` 导致 `params` 失效。

**五、面试**

> Q:**为什么 params 用 `path` 跳转会失效？**
>
> A:Vue Router 的官方设计逻辑是，`params` 是路径的一部分。当你提供 `path` 时（如 `/user/123`），Router 就认为路径已经完整了，无法知道你提供的 `{ id: 123 }` 是要放在路径的哪个位置。只有提供 `name`，Router 才能去路由表中查找该路由对应的路径结构（如 `/user/:id`），从而把参数填进去。
>
> Q:**为什么 params 刷新页面有时会数据丢失？**
>
> A:在 Vue Router 3.x 及之前的某些版本中（或者 Webpack 的 history 模式配置不当），如果路由没有定义 `/:id` 占位符就传递 `params`，参数不会显示在 URL 上，刷新后参数自然就丢失了。**在 Vue 4 (Vue 3) 中，规范做法是必须配置占位符，这样参数就在 URL 里了，刷新也不会丢。**

##  keep-alive

**一、定义**

> `<keep-alive>` 是 Vue 2 提供的一个内置抽象组件，用于在组件切换时将失活的组件实例**缓存**在内存中，而不是销毁它们。它可以保留组件的状态（如滚动位置、表单输入），避免重复渲染

**二、原理**

1.**抽象组件**

> - `<keep-alive>` 自身不会渲染成 DOM 元素（在页面上看不到它），也不会出现在父组件链中。
> - 它作用于包裹在其内部的**第一个子组件**（通常配合 `<router-view>` 或动态组件 `<component :is="...">` 使用）。

2.**缓存机制**

> - 当组件在 `<keep-alive>` 内被切换时，它的 `activated` 和 `deactivated` 两个生命周期钩子函数会被执行。
> - 组件实例会被缓存在内存中，下次切换回来时，会直接从缓存中读取实例，**不会再次执行 `created`、`mounted` 等初始化钩子**。

**3.LRU算法**

> - 如果设置了 `max` 属性，`keep-alive` 使用 **LRU (Least Recently Used)** 算法来管理缓存。即：如果缓存数量超过上限，最近最少使用的缓存实例会被销毁，以便为新实例腾出空间。

**三、核心属性**

`<keep-alive>` 接受三个属性：

> 1. `include`：白名单。只有名称匹配的组件会被缓存。
>    - 类型：`String`、`RegExp` 或 `Array`。
> 2. `exclude`：黑名单。任何名称匹配的组件都不会被缓存。
>    - 类型：`String`、`RegExp` 或 `Array`。
> 3. `max`：限制最多可以缓存多少组件实例。
>    - 类型：`Number`。

**注意：** `include` 和 `exclude` 匹配的是**组件内部定义的 `name` 选项**，而不是路由的名称。

**四、进阶**

1.**配合路由使用时的清除缓存需求**

> - 场景：从 A 页面进入 B 页面，再回到 A 页面，需要缓存 A；但是从 A 页面进入 C 页面，再回到 A 页面，不需要缓存 A。
> - **解决方案**：利用路由元信息（`meta`）动态控制 `include` 数组。或者使用 `beforeRouteLeave` 导航守卫手动设置当前组件是否需要缓存（较少用，通常通过 Vuex 控制 keep-alive 的 include 列表）。

## 路由模式 Hash 与 History

**一、定义**

> Vue Router 的 `Hash` 模式和 `History` 模式是两种实现前端路由的方式。`Hash` 模式基于 URL 的哈希值（`#`）变化，兼容性好但 URL 不美观；`History` 模式基于 HTML5 History API，URL 美观但需要后端服务器配合配置，否则刷新页面会报 404。

**二、原理**

1.Hash 模式 (默认)

> - 原理：
>   - URL 中 `#` 及其后面的部分被称为 Hash。Hash 的改变不会导致浏览器向服务器发送请求，也就是说**不会刷新页面**。
>   - Vue Router 通过监听浏览器的 `window.addEventListener('hashchange', ...)` 事件来感知 Hash 的变化。
>   - 一旦 Hash 变化，Router 会根据新的 Hash 值匹配路由表，渲染对应的组件。
> - 特点：
>   - 虽然地址栏变了，但 HTTP 请求中不会包含 Hash 部分，因此对后端无影响。
>   - 兼容性极好。

2.History 模式

> - 原理：
>   - 利用 HTML5 History Interface 中新增的 `pushState()` 和 `replaceState()` 方法。
>   - 这两个方法可以改变 URL 地址且**不会发送 HTTP 请求**，也不会刷新页面。
>   - Vue Router 使用 `window.addEventListener('popstate', ...)` 来监听浏览器前进后退操作，从而触发路由更新。
> - 特点：
>   - URL 更加美观、正规，看起来像传统的多页面应用 URL。
>   - **坑点**：因为 URL 是真实的路径（如 `/user`），当用户直接在地址栏输入或刷新页面时，浏览器会把这个 URL 当作一个普通的 HTTP 请求发送给后端。如果后端没有对应的路由处理（例如 `/user` 这个接口或文件），就会返回 **404 Not Found**。

**三、进阶**

**1.History 模式的 404 问题与解决方案（必问）**

**问题**：在 History 模式下，刷新页面为什么会报 404？
**回答**：因为前端路由是单页应用（SPA），只有 `index.html` 一个入口。刷新 `/user` 时，服务器会去寻找文件系统下的 `/user` 目录或文件，找不到自然报 404。

**解决方案**：
需要在服务器端进行配置，实现**资源回退**（Fallback）。即：如果 URL 匹配不到任何静态资源，就统一返回 `index.html`，把控制权交还给前端路由。

```js
location / {
  try_files $uri $uri/ /index.html;
}
```

**四、总结**

**1.使用 Hash 模式**：

- 如果是简单的后台管理系统、Web App，不需要复杂的 URL 语义。
- 服务器环境不可控（例如部署在静态文件托管服务，无法配置 Nginx）。
- 需要兼容非常老的浏览器。

**2.使用 History 模式**：

- 如果是对外的官网、电商网站，需要 SEO 优化。
- 追求 URL 美观和语义化（如 `/product/123`）。
- 有能力或权限配置服务器。

## 一个路径渲染多个组件

**1.定义**

在 Vue 2 中，要实现一个路径（URL）同时渲染多个组件，需要使用 Vue Router 的 **命名视图** 功能。通过在路由配置中使用 `components`（复数）对象，并在模板中使用带 `name` 属性的 `<router-view>` 标签，将不同的组件渲染到页面的不同位置。

**2.实战代码**

定义三个组件

```js
// 简单组件定义
const Header = { template: '<div class="header">我是顶部导航</div>' };
const Sidebar = { template: '<div class="sidebar">我是侧边栏</div>' };
const Content = { template: '<div class="content">我是主要内容</div>' };
```

配置路由

```js
const router = new VueRouter({
  routes: [
    {
      path: '/home',
      // 注意这里是 components (复数)，并且是一个对象
      components: {
        // key 对应 <router-view> 的 name 属性
        // value 对应要渲染的组件
        default: Content,  // 默认视图，对应没有 name 的 <router-view>
        a: Header,         // 名为 'a' 的视图
        b: Sidebar         // 名为 'b' 的视图
      }
    }
  ]
});
```

- **适用场景**：复杂布局（多面板、侧边栏+内容区+顶部栏）。

## 检测路由动态变化

**一.定义**

> 在 Vue 2 中，检测路由变化主要通过 **`watch` 监听 `$route` 对象** 或使用组件内的 **导航守卫 `beforeRouteUpdate`**。这主要用于解决在**同一个组件被复用**（如从 `/user/1` 跳转到 `/user/2`）时，组件生命周期钩子（`created`、`mounted`）不会再次触发，导致数据无法更新的问题。

**二.解决方案**

1.使用 `watch` 监听 `$route`（最常用）

```js
  // 1. 简单写法
  watch: {
    '$route'(to, from) {
      // 路由变化时，重新获取数据
      console.log('路由变化了', to.params.id);
      this.fetchData();
    }
  },

  // 2. 进阶写法（推荐）：使用 handler + immediate
  watch: {
    '$route': {
      handler(to, from) {
        this.userId = to.params.id;
        this.fetchData();
      },
      // 关键点：immediate: true 表示组件创建时立即执行一次 handler
      // 这样就不需要在 created 里再写一遍 fetchData 了
      immediate: true 
    }
  },
```

2.使用 `beforeRouteUpdate` 导航守卫

```js
  // 关键点：beforeRouteUpdate
  beforeRouteUpdate(to, from, next) {
    // to: 即将进入的目标路由对象
    // from: 当前导航正要离开的路由
    // next: 必须调用该方法来 resolve 这个钩子
    this.userId = to.params.id;
    this.fetchData(); // 重新请求数据
    
    next(); // 不要忘记调用 next()
  }
```

## router-link上v-slot

**1.定义**

早期，`router-link` 只能渲染为 `<a>` 标签，虽然可以通过 `tag` 属性改为 `<li>` 或 `<div>`，但这会导致 HTML 结构不合理（例如 `div` 包裹 `a` 或 `li` 包裹 `a` 产生无效的嵌套）。

使用 `v-slot` 可以让我们完全掌控渲染的内容，手动控制触发跳转的事件和样式，从而写出更符合语义化和 SEO 的结构。

**2.核心参数**

使用 `v-slot="{ props }"` 时，`router-link` 会向插槽传递一个对象，包含以下关键属性：

> 1. **`href`**: 解析后的 URL 地址。必须将其绑定到标签的 `href` 属性上。
> 2. **`route`**: 解析后的标准路由对象。
> 3. **`navigate`**: 一个函数，用于触发导航。必须绑定到点击事件上（通常配合 `.prevent` 修饰符使用）。
> 4. **`isActive`**: 布尔值，如果当前路由匹配该链接（模糊匹配），则为 `true`。
> 5. **`isExactActive`**: 布尔值，如果当前路由**精确匹配**该链接，则为 `true`。

```js
<ul>
  <li>
    <router-link to="/" custom v-slot="{ href, route, navigate, isActive }">
      <a 
        :href="href" 
        @click="navigate"
        :class="{ 'text-red': isActive }"
      >
        首页 (当前状态: {{ isActive ? '激活' : '未激活' }})
      </a>
    </router-link>
  </li>
</ul>
```

## $router与$route区别

**一、定义**

> **`$router`** 是 Vue Router 的**全局路由实例**，相当于“路由指挥官”，用于控制路由跳转（如 `push`、`replace`）；**`$route`** 是当前激活的**路由信息对象**，相当于“当前路况”，用于获取当前路径、参数等状态（如 `path`、`query`、`params`）。

- **`$router` 是“导航仪”**：
  - 你想“去北京”或者“回退到上一站”，你需要操作导航仪（调用 `$router.push` 或 `$router.go`）。整个车里只有一个导航仪（全局单例）。
- **`$route` 是“路牌”**：
  - 你想知道“我现在在哪里”、“这条叫什么路”、“这条路限速多少”，你需要看路牌（读取 `$route` 的属性）。不同的路口有不同的路牌（每个路由状态不同）。

**二、实践**

1.使用 `$router` 进行跳转 (写操作)

```js
export default {
  methods: {
    goToDetail() {
      // 使用 $router 进行编程式导航
      // 类似于点击了 <router-link to="/detail">
      // 1. push (跳转，保留历史记录，可回退)
      this.$router.push('/detail');
      this.$router.push({ path: '/detail', query: { id: 1 } });
      // 2. replace (替换当前记录，不可回退)
      this.$router.replace('/login');
      // 3. go (前进或后退，类似于浏览器的左右箭头)
      this.$router.go(-1); // 后退一页
      this.$router.back(); // 后退
      this.$router.forward(); // 前进
    }
  }
}
```

2.使用 `$route` 获取参数 (读操作)

```js
export default {
  created() {
    // 读取当前 URL 的参数
    // 获取 Query 参数 (?id=123)
    const id = this.$route.query.id;
    // 获取 Params 参数 (/detail/123)
    const userId = this.$route.params.id;
    // 获取当前路径
    const path = this.$route.path; // "/detail" 
    // 获取元信息
    const requiresAuth = this.$route.meta.requiresAuth;
  }
}
```

## 路由守卫

**一、定义**

> 路由守卫是 Vue Router 提供的**钩子函数**，主要用于通过**跳转或取消**的方式来守卫导航。常用于**登录验证（鉴权）**、**权限控制**和**页面标题设置**等场景。它分为**全局守卫**、**路由独享守卫**和**组件内守卫**三类。

**二、三种路由守卫**

> 1. **全局守卫**：注册在 `router` 实例上，对所有路由跳转生效。
>    - `beforeEach`：**全局前置守卫**（最常用），常用于登录拦截。
>    - `beforeResolve`：**全局解析守卫**，在导航被确认之前，且所有组件内守卫和异步路由组件被解析之后调用。
>    - `afterEach`：**全局后置钩子**，导航结束之后调用，没有 `next` 函数，常用于修改页面 Title。
> 2. **路由独享守卫**：直接在路由配置（`routes` 数组的对象）中定义，只对特定路由生效。
>    - `beforeEnter`。
> 3. **组件内守卫**：直接在 `.vue` 组件内部定义（与 `methods`、`mounted` 同级）。
>    - `beforeRouteEnter`：进入该组件前调用（**此时组件实例还未创建**，不能访问 `this`）。
>    - `beforeRouteUpdate`：复用组件时（如 `/a/1` -> `/a/2`）调用。
>    - `beforeRouteLeave`：离开该组件时调用（常用于防止误操作，如未保存提示）。

**核心参数**

> 在 Vue 2 的守卫中（`afterEach` 除外），通常接收三个参数：
>
> - **`to`**: 即将要进入的目标 路由对象。
> - **`from`**: 当前导航正要离开的 路由对象。
> - `next`: (Vue 2 必须调用) 这是一个必须调用的函数，用来 resolve 这个钩子。
>   - `next()`: 进行管道中的下一个钩子。
>   - `next(false)`: 中断当前的导航。
>   - `next('/')` 或 `next({ path: '/' })`: 跳转到一个不同的地址。

**三、实战**

1.全局前置守卫（登录鉴权经典案例）

```js
// router/index.js
router.beforeEach((to, from, next) => {
  // 1. 判断是否需要登录（meta 字段配置）
  if (to.meta.requiresAuth) {
    // 2. 判断是否有 token
    const token = localStorage.getItem('token');
    if (token) {
      next(); // 已登录，放行
    } else {
      // 未登录，强制跳转到登录页
      next('/login?redirect=' + encodeURIComponent(to.fullPath));
    }
  } else {
    next(); // 不需要登录，直接放行
  }
})
```

2.组件内守卫（获取组件实例与离开确认）

```js
export default {
  data() {
    return { isSaved: false }
  },
  // 进入组件前
  beforeRouteEnter(to, from, next) {
    // 注意：这里不能访问 this，因为组件实例还没创建
    // 可以通过回调函数来访问实例
    next(vm => {
      // 通过 vm 访问组件实例
      console.log('当前组件 ID:', vm.id);
    });
  },
  // 离开组件前
  beforeRouteLeave(to, from, next) {
    if (this.isSaved) {
      next(); // 已保存，允许离开
    } else {
      const answer = window.confirm('您有未保存的内容，确定要离开吗？');
      if (answer) {
        next();
      } else {
        next(false); // 取消离开
      }
    }
  }
}
```

## 路由懒加载

**一、定义**

> 路由懒加载是 Vue Router 结合 Webpack 实现的一种**性能优化手段**。它通过**动态导入**语法替代静态导入，将不同路由对应的组件打包成独立的代码块

**二、实战**

```
// import User from './User.vue' 静态导入
const User = () => import('./User.vue') // 动态导入
const router = createRouter({
	// ...
	routes:[{path:'/user/:id', component: User}]
})
```

**三、进阶用法-命名 Chunk 和预加载**

配合 Webpack 的**魔法注释**来控制打包后的文件名，以及进行资源预取/预加载，进一步提升体验。

**1.把组件打包在同一个 chunk 中（分组）**

相关的页面，或者业务逻辑强相关，可以打包在一起。

```js
const About = () => import(/* webpackChunkName: "about-group" */ '@/views/About.vue')
const User = () => import(/* webpackChunkName: "about-group" */ '@/views/User.vue')
// 打包后文件名会类似 about-group.a1b2.js
```

**2.预加载**

在主 bundle 加载完成后，浏览器空闲时，偷偷下载其他路由的资源。

```js
const About = () => import(/* webpackPrefetch: true */ '@/views/About.vue')
```

## 插槽

分为：**默认插槽**、**具名插槽**和**作用域插槽**。

```js
// Parent.vue
	<Child>
      <p>这是父组件插入的一段话</p>
	  <template #content></template>
	  <template v-slot="{data:[]}"></template>
    </Child>
// Child.vue
	<div class="box">
      <slot>默认插槽</slot>
	  <slot name="content">具名插槽</slot>
	  <slot :data="item">作用域插槽</slot>
    </div>
```

## computed 和 watch

**1.共同点**：watch和computed都是依赖数据变化触发

**2.区别**

> - watch:擅长一对多的关系处理，无缓存性。支持异步。不需要返回值。
> - computed:擅长多对一的关系处理，有缓存性。不支持异步。必须有返回值

**3.进阶**

**Computed 为什么不能做异步**

> 因为 computed 的本质是 getter，它需要依赖 return 返回一个值给模板渲染。如果在里面写异步，函数会立即返回一个 Promise，而不是计算后的数据，导致模板无法正确显示。

## 组件的data是函数，而根组件是对象

**1.定义**

**Vue 组件的 `data` 必须是一个函数，是为了防止组件在多次复用时发生数据污染（多个实例共享同一份数据）；而根实例（Root Instance）是单例模式，不会被复用，因此 `data` 可以是对象。**

**2.详细分析**

data 必须是函数

> - **对象是引用类型**：如果 `data` 是一个对象，当该组件被复用多次（例如在页面中使用多个 `<my-component>`），所有的实例实际上都指向内存中的同一个对象地址。
> - **数据污染风险**：一旦某个组件实例修改了数据，其他所有实例的数据也会随之改变，这显然不符合组件独立性的设计原则。
> - **函数返回新对象**：如果 `data` 是一个函数，Vue 在创建每个组件实例时，都会调用这个函数。函数每次执行都会返回一个新的对象，从而确保每个组件实例都有自己独立的数据作用域，互不干扰。

根组件的 data 是对象

> - **单例特性**：Vue 应用的根实例（通过 `new Vue()` 创建）在整个应用中通常是唯一的，不存在“复用”的情况。
> - **无需隔离**：既然根实例不会被多次实例化，也就不存在多个实例共享数据引用的问题，所以直接使用对象形式更加简洁方便。

## 组件通信

分为三类：**父子通信**、**跨级通信**、**兄弟/任意组件通信**

> - 父子：`props/$emit`，语法糖 (`v-model` / `.sync`)
> - 跨级：`provide` / `inject`(依赖注入)，`$attrs` / `$listeners`(隔代传递)
> - 兄弟/任意：Event Bus (事件总线)，Vuex (状态管理)
> - 其他：`$refs`，`$parent` / `$children`

## 动态class/动态style

> - 动态class对象：`<div :class="{ 'is-active': true, 'red': isRed }"></div>`
> - 动态class数组：`<div :class="['is-active', isRed ? 'red' : '' ]"></div>`
> - 动态style对象：`<div :style="{ color: textColor, fontSize: '18px' }"></div>`
> - 动态style数组：`<div :style="[{ color: textColor, fontSize: '18px' }, { fontWeight: '300' }]"></div>`

## 动画

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

# 中级

## 单向数据流与双向数据绑定

**一、 定义**

**1. 单向数据流**
单向数据流是指数据的流向是单向的，即**数据总是从父组件流向子组件**。父组件通过 `props` 向子组件传递数据，子组件不能直接修改父组件传递过来的数据。如果子组件需要修改数据，必须通过 `$emit` 触发事件通知父组件，由父组件修改数据后再通过 `props` 传递下来。

- **核心原则**：数据向下传，事件向上传。

**2. 双向数据绑定**
双向数据绑定是指数据模型与视图之间的自动同步机制。当数据变化时，视图自动更新；当视图发生变化（如用户输入）时，数据模型也自动更新。在 Vue 2 中，`v-model` 是实现双向数据绑定的典型指令。

**二、原理与机制**

1.单向数据流的实现机制

Vue 2 强制要求组件间通信遵循单向数据流，主要体现在 `props` 的传递上：

- **数据传递**：父组件将数据通过 `props` 传给子组件。
- **只读限制**：子组件内部不允许直接修改 `props` 中的数据。如果尝试修改，Vue 会在控制台抛出警告。
- **修改方式**：子组件必须通过 `this.$emit('eventName', newValue)` 通知父组件，父组件在事件回调中修改源数据。

1.双向数据绑定的实现原理

Vue 2 的双向数据绑定是由 **数据劫持** + **发布-订阅模式** 配合 **语法糖** 实现的。

> - **底层原理（响应式）**：Vue 2 使用 `Object.defineProperty` 劫持对象属性的 `getter` 和 `setter`。在 `getter` 中收集依赖，在 `setter` 中触发更新，实现数据变视图变。
> - v-model 原理（语法糖）：v-model本质上是value属性绑定和input事件的语法糖。
>   - 对于普通输入框：`<input v-model="msg">` 等价于 `<input :value="msg" @input="msg = $event.target.value">`。
>   - 对于组件：`v-model` 默认会利用名为 `value` 的 prop 和名为 `input` 的事件。

**三、进阶**

**1. 为什么 Vue 要采用单向数据流？**
主要是为了**降低代码复杂度和避免状态混乱**。如果允许子组件直接修改父组件的数据，当多个子组件都依赖该数据时，数据的变更源头将变得不可追踪，调试成本极高。单向数据流使得所有状态的修改都有迹可循。

2.**.sync 修饰符**

Vue 2 中的 `.sync` 修饰符也是一种双向绑定的语法糖，常用于“一次性更新多个 prop”或非 value 类型的双向绑定场景。
`<child :title.sync="doc.title"></child>` 等价于 `<child :title="doc.title" @update:title="doc.title = $event"></child>`。

## Object.defineProperty

**一、.定义**

**`Object.defineProperty`** 是 ES5 提供的一个原生方法，用于在一个对象上定义一个新属性，或者修改一个现有属性，并返回这个对象。

在 Vue 2 中，它是实现**响应式系统**的核心 API。Vue 利用它来**劫持** data 对象属性的 `getter` 和 `setter`，从而在数据被读取或修改时，自动触发视图更新或依赖收集。

**二.响应式原理**

响应式主要包含三个步骤：**数据劫持**、**依赖收集**、**派发更新**。

**1.数据劫持**

Vue 在初始化时，会遍历 `data` 中的所有属性，并使用 `Object.defineProperty` 将它们转化为 `getter` 和 `setter`。

- **Getter（读取）**：当读取属性时（如模板渲染时），会触发 `getter`。Vue 会在此处进行**依赖收集**，将当前正在渲染的 Watcher 添加到该属性的依赖列表中。
- **Setter（修改）**：当修改属性值时，会触发 `setter`。Vue 会在此处通知所有依赖该属性的 Watcher，触发**派发更新**，最终重新渲染视图。

**2. 递归遍历**

Vue 会对 `data` 对象进行深度遍历，对嵌套对象的每一个属性都调用 `Object.defineProperty`，确保所有层级的属性都是响应式的。

**三、优缺点**

优点

> - **兼容性好**：支持 IE9 及以上浏览器（这是 Vue 2 一直沿用此方案的主要原因）。
> - **实现机制成熟**：作为 ES5 标准方法，性能稳定，不需要像 Proxy 那样的 Polyfill。

缺点

> - 无法监测对象属性的添加或删除：
>   - 对于后来添加的属性（如 `this.obj.newProp = 'value'`），Vue 无法检测到，因为它没有经过 `defineProperty` 的劫持。必须使用 `Vue.set` 或 `this.$set` 手动处理。
> - 无法监测数组索引和长度的变化：
>   - 直接通过索引修改数组项（`this.arr[0] = 'new'`）或修改长度（`this.arr.length = 0`）不会触发更新。Vue 2 通过重写数组原型方法（`push`, `pop`, `splice` 等）来变相解决这个问题。
> - 深层监听性能问题：
>   - `Object.defineProperty` 必须在初始化时递归遍历所有属性。如果数据层级很深，初始化耗时较长，影响性能。

**四、对比Vue3**

| 特性         | Vue 2 (Object.defineProperty)    | Vue 3(Proxy)                     |
| :----------- | :------------------------------- | :------------------------------- |
| **劫持方式** | 劫持对象的具体属性               | 劫持整个对象                     |
| **新增属性** | 需要使用 `Vue.set`，默认无响应式 | 自动响应式，无需特殊处理         |
| **数组监听** | 索引修改无响应，需重写数组方法   | 支持                             |
| **性能**     | 初始化时递归定义，层级深时耗性能 | 惰性响应式，只有访问到才进行代理 |
| **兼容性**   | 支持 IE9+                        | 不支持 IE (Proxy 无法 Polyfill)  |

**五、手写响应式**

```js
// ==========================================
// 1. Dep 类 (依赖管理器)
// ==========================================
class Dep {
  constructor() {
    this.subs = []; // 存储 Watcher 实例
  }

  // 添加观察者
  addSub(sub) {
    if (sub && sub.update) {
      this.subs.push(sub);
    }
  }

  // 通知所有观察者更新
  notify() {
    this.subs.forEach(sub => sub.update());
  }
}

// 静态属性，指向当前正在收集依赖的 Watcher
// 作用：在 getter 执行时，通过这个全局变量知道是谁在“用”我
Dep.target = null;
// ==========================================
// 2. Observer 函数 (数据劫持/响应式转换)
// ==========================================
function observe(data) {
  if (!data || typeof data !== 'object') return;

  Object.keys(data).forEach(key => {
    // 递归处理嵌套对象
    observe(data[key]); 
    // 定义响应式
    defineReactive(data, key, data[key]);
  });
}

function defineReactive(obj, key, val) {
  // 每个属性都创建一个属于自己的 Dep 容器
  const dep = new Dep();
  Object.defineProperty(obj, key, {
    enumerable: true,
    configurable: true,
    get() {
      // 【依赖收集】
      // 如果此时 Dep.target 有值（说明有 Watcher 正在读取数据）
      if (Dep.target) {
        dep.addSub(Dep.target);
      }
      return val;
    },
    set(newVal) {
      if (val === newVal) return;
      val = newVal;
      // 如果新值是对象，也需要进行响应式处理
      observe(newVal);
      // 【派发更新】
      dep.notify();
    }
  });
}

// ==========================================
// 3. Watcher 类 (观察者/视图渲染代表)
// ==========================================
class Watcher {
  constructor(data, key, cb) {
    this.data = data;
    this.key = key;
    this.cb = cb; // 回调函数，通常用于更新视图
    // 初始化时，主动触发一次 getter，建立连接
    this.get();
  }
  get() {
    // 【关键步骤】
    // 1. 将当前实例挂载到 Dep.target 上
    Dep.target = this;
    // 2. 触发 getter，此时 getter 中的 Dep.target 有值，会调用 addSub
    this.data[this.key]; 
    // 3. 重置 Dep.target，避免重复收集
    Dep.target = null;
  }
  update() {
    // 数据变化时执行的逻辑
    const newVal = this.data[this.key];
    this.cb(newVal);
  }
}

// ==========================================
// 4. 简易 Vue 类 (入口)
// ==========================================
class Vue {
  constructor(options) {
    this.$data = options.data;
    // 1. 数据响应化
    observe(this.$data);
    // 2. 模拟模板编译/视图渲染
    // 实际 Vue 中会解析 template，这里简化为手动创建 Watcher
    if (options.render) {
      new Watcher(this.$data, 'msg', (val) => {
        options.render(val);
      });
      // 初始化渲染一次
      options.render(this.$data.msg);
    }
  }
}
```

## vue-loader是什么

**1.定义**

> `vue-loader` 是 Webpack 的一个 **loader（加载器）**，它的核心作用是解析和转换 Vue 的**单文件组件（.vue 文件）**。它能将 `.vue` 文件中的 `<template>`、`<script>` 和 `<style>` 块拆分出来，分别交给对应的 loaders 处理，最后组装成一个标准的 JavaScript 模块。

**2.原理**

浏览器无法直接识别 `.vue` 文件。Webpack 本身也只理解 JavaScript 和 JSON。

`vue-loader` 就是一个“翻译官”：

> 1. **拆解**：把一个 `.vue` 文件拆解成三部分（HTML、JS、CSS）。
> 2. 分发：
>    - `<template>` -> 提取给 `vue-template-compiler` 编译成 `render` 函数。
>    - `<script>` -> 提取给 `babel-loader` 或 `ts-loader` 处理。
>    - `<style>` -> 提取给 `css-loader`、`style-loader` 或 `sass-loader` 处理。
> 3. **组装**：将处理好的部分重新组合，导出一个 ESM 模块，供 Webpack 打包。

**3.Scoped CSS 原理**

在 Vue 2 中，给 `<style>` 标签加上 `scoped` 属性后，CSS 样式只会作用于当前组件，`vue-loader` 是如何实现的？

> 1. **生成 Hash**：在编译组件时，`vue-loader` 会为该组件生成一个唯一的哈希字符串（例如 `data-v-12345678`）。
> 2. **HTML 注入**：将该 Hash 作为属性添加到组件内所有的 HTML 标签上（例如 `<div data-v-12345678></div>`）。
> 3. **CSS 选择器增强**：通过 PostCSS 处理 CSS，给所有的样式选择器末尾添加一个 `[data-v-12345678]` 的属性选择器。

## 虚拟 DOM

**1.定义**

虚拟 DOM（Virtual DOM，简称 VDOM）本质上是一个 **JavaScript 对象**。它用 JS 对象结构来描述真实的 DOM 结构，包含标签名、属性、子节点等信息，是对真实 DOM 的一层抽象。

**2.核心作用**

> - **优化性能**：通过 Diff 算法计算出最小的变化量，从而减少直接操作真实 DOM（重排重绘）的开销。
> - **屏蔽 DOM 操作差异**：虚拟 DOM 是 JS 对象，与平台无关。提供了一种跨平台的抽象层（如 Weex、SSR），支持浏览器 DOM，原生应用、Canvas 或 SVG 等平台。

**3.生成过程**

分为三个阶段：**生成 -> Diff -> Patch**

> 1. **生成 VNode**：
>    - 当组件渲染时，`render` 函数执行，生成虚拟 DOM 树。
> 2. **Diff 算法（核心）**：
>    - 当数据变化触发重新渲染时，生成新的 VNode 树。
>    - Vue 采用 **同层比较** 策略，只会对同一层级的节点进行比较，不跨层级比较，将时间复杂度从 O(n^3) 降低到 O(n)。
> 3. **Patch（打补丁）**：
>    - 根据对比结果，直接操作真实 DOM（创建、删除、移动节点）。

# 高级

## $forceUpdate原理

**1.定义**

迫使Vue实例重新渲染。注意它仅仅影响实例本身和插入插槽内容的子组件，而不是所有子组件。

2.内部原理

```
Vue.prototype.$forceUpdate = function (){
	const vm:Component = this
	if(vm._watcher){
		// 触发watcher手动更新update方法
		vm._watcher.update()
	}
}
```

## nextTick原理

**一.定义**

**核心作用是：将回调函数推迟到下一次 DOM 更新循环结束之后执行**

简单说：当你修改了数据（Data），视图（DOM）还来不及更新时，使用 `nextTick` 可以确保在 DOM 更新完成后才执行相关逻辑，从而获取到最新的 DOM 元素。

**二.为什么要用它**

Vue 的**异步更新策略**

> Vue 2 在修改数据时，默认不会立即更新 DOM。如果同一个事件循环内多次修改同一个数据，Vue 会将其放入队列，并在下一次事件循环的微任务中去批量更新。这样做是为了避免不必要的性能消耗

**三.源码实现**

两个关键点：**回调队列** 和 **降级策略**。

**1.核心逻辑**

> Vue 内部维护了一个回调队列（`callbacks`数组）。当我们调用 `nextTick(cb)` 时，会将回调函数 `cb` 推入这个队列。然后，Vue 会利用浏览器的异步任务机制（微任务优先，宏任务兜底）来异步清空这个队列。

**2. 降级策略（优先级排序）**

> Vue 2 为了兼容性和性能，会按照优先级依次尝试使用以下异步方法：
>
> 1. **Promise**（微任务）：
>    如果浏览器支持 Promise，则首选 `Promise.then`。这是最理想的微任务方案。
> 2. **MutationObserver**（微任务）：
>    如果不支持 Promise，会尝试使用 H5 的 `MutationObserver`（它通常也是微任务）。
> 3. **setImmediate**（宏任务/准微任务）：
>    如果以上都不支持，会尝试使用 IE 特有的 `setImmediate`。
> 4. **setTimeout**（宏任务）：
>    最后的兜底方案。虽然性能稍差，但所有浏览器都支持。

**3.流程**

> - 用户修改数据 -> 触发 `setter` -> 通知 Watcher -> Watcher 被推入队列 -> 调用 `nextTick(flushSchedulerQueue)`。
> - `nextTick` 将刷新视图的函数 `flushSchedulerQueue` 和用户自定义的回调一起推入 `callbacks` 队列。
> - 执行 `timerFunc`（上述降级策略中的一种）。
> - 在异步任务中，遍历 `callbacks` 队列并执行所有回调。

## Vue Router原理

**一、定义**

> Vue Router 的底层原理核心在于**URL 变化监听**与**组件映射**。通过监听浏览器 URL 的变化，利用**路由匹配器**找到对应的组件，再通过 Vue 的响应式机制更新 `<router-view>` 中的内容，从而实现页面无刷新切换。主要分为 **Hash 模式**和 **History 模式**两种实现方式。

**二、核心流程**

无论哪种模式，Vue Router 的内部工作流程都遵循以下三个步骤：

1. **监听**：监听浏览器地址栏 URL 的变化。
2. **匹配**：根据新的 URL 路径，在路由配置表中进行查找，生成一个匹配的路由记录对象（Route Record）。
3. **渲染**：将匹配到的组件实例渲染到页面上的 `<router-view>` 占位符中。

**三、底层原理**

**1.Hash 模式（基于 `window.location.hash`）**

> 底层实现逻辑：
>
> 1. **初始化**：页面加载时，读取 `window.location.hash`，根据初始值进行首次路由匹配。
> 2. **监听**：调用 `window.addEventListener('hashchange', callback)`。
> 3. **触发**：当用户点击 `<router-link>` 或调用 `router.push` 时，Vue Router 会直接修改 `window.location.hash`（例如从 `#/home` 改为 `#/user`），从而触发 `hashchange` 事件。
> 4. **回调处理**：在回调函数中，解析新的 Hash 值，匹配对应的组件，并渲染。

**2.History 模式（基于 HTML5 History API）**

> 底层实现逻辑：
>
> 1. **URL 修改**：当路由跳转时，调用 `history.pushState(state, title, url)`。注意：**手动调用 `pushState` 不会触发任何事件**，所以 Vue Router 内部封装了 `push` 方法，在修改 URL 后，手动执行路由匹配逻辑。
> 2. **事件监听**：监听 `window.addEventListener('popstate', callback)`。
> 3. **触发时机**：`popstate` 事件仅在浏览器**前进/后退**按钮被点击时触发（或在 JS 中调用 `back()`/`forward()` 时）。
> 4. **刷新问题**：用户直接刷新页面时，浏览器会向服务器请求该 URL。如果没有后端配置返回 `index.html`，就会报 404。

**四、`<router-view>`的底层原理**

“路由变了，组件是怎么换掉的？”

> - `<router-view>` 是一个**函数式组件**（Functional Component）。
> - 它不渲染自己的 HTML，而是根据当前的路由状态（`this.$route`），找到匹配到的组件定义，并将其渲染出来。
> - 它通过维护一个深度标记来支持嵌套路由：
>   - Vue Router 会维护一个 `matched` 数组（例如：`[ParentComponent, ChildComponent]`）。
>   - 最外层的 `<router-view>` 渲染 `matched[0]`。
>   - `ParentComponent` 内部的 `<router-view>` 渲染 `matched[1]`，以此类推。

## Vuex原理

**一、定义**

Vuex 的本质是一个**专为 Vue 应用设计的全局状态管理插件**。

> `Vue.use` 注入 -> `Mixin` 挂载 -> `new Store` 初始化内部 Vue 实例

核心原理有2点：

> 1. **注入机制**：利用 Vue 的**插件系统**（`Vue.use`），通过 `Vue.mixin` 全局混入，将 `$store` 实例挂载到每个组件实例上。
> 2. **响应式机制**：利用 Vue 的**响应式系统**，在内部创建一个 Vue 实例来存储 state，使得 state 的变化能自动触发视图更新。

**二、架构**

**1.整体**

Vuex 的核心是一个 `Store` 类。它包含了 `state`、`getters`、`mutations`、`actions` 等核心概念。

**2. 响应式原理**

这是 Vuex 最巧妙的地方。Vuex 内部维护了一个 Vue 实例（VM）：

- State 的响应式：Vuex 将 state 对象作为这个内部 Vue 实例的data选项。
  - 因为 Vue 的 `data` 是响应式的，所以当 `state` 改变时，依赖该 state 的组件会自动重新渲染。
- Getters 的实现：Vuex 将 getters 作为这个内部 Vue 实例的computed计算属性。
  - 计算属性具有缓存和依赖收集的特性，非常适合处理派生状态。

**3.注入与挂载原理**

为了让所有组件都能访问 `$store`，Vuex 实现了 `install` 方法：

- **`Vue.use(Vuex)`**：调用 Vuex 的 `install` 方法。
- **全局混入 (`Vue.mixin`)**：通过 `beforeCreate` 生命周期钩子进行混入。
- 逻辑流程：
  1. 根实例创建时，`options.store` 存在，将 `this.$store` 指向它。
  2. 子组件创建时，通过 `options.parent.$store` 向上查找，从而实现所有组件共享同一个 `$store` 实例。

**4.单向数据流**

- **State**：数据源。
- **View**：渲染视图。
- **Mutations**：同步修改 state（唯一途径）。
- **Actions**：处理异步操作，提交 Mutation。

**三、源码层面**

> 1. **`resetStoreVM`**：
>    在 Vuex 源码中，核心逻辑在 `resetStoreVM` 函数中。它创建了内部的 Vue 实例，并遍历 `getters`，通过 `Object.defineProperty` 将每个 getter 代理到 Store 实例上，使其访问方式为 `store.getterName`，但实际上读取的是内部 VM 的计算属性。
> 2. **严格模式**：
>    源码中通过 `_vm.$watch` 监听 state 的变化。在严格模式下，如果 state 的变化不是由 mutation 函数触发的（即没有通过 commit 修改），控制台会报警告。这是通过检查 `commiting` 标志位实现的。

**四、面试**

> - Q：Mutations 为什么不能做异步操作？
> - A：Mutation 同步性不是语法限制，而是**调试体系的契约**——它用"放弃异步便利性"换取了"状态变更可追踪、可回放、可预测。异步逻辑应交给 Action，由 Action 在异步完成后 commit 一个同步 Mutation 来落地状态。

## template 编译过程

**一、定义**

本质上是：**模板字符串 → AST →（优化）→ 渲染函数代码字符串 → 真正的 render 函数**

> - parse解析器：将template模板中的节点和数据解析成 AST抽象语法树
> - optimize优化器：标记静态节点，提升渲染性能
> - generate代码生成器：将 AST 转换成“代码字符串”，然后将 render 字符串通过 new Function 的方式转换成渲染函数

通常由 `vue-template-compiler` 在构建时预编译，或在运行时使用 `Vue.compile` 动态编译。

**二、整体流程**

**1.第一步：parse —— 模板字符串 → AST**

目标：把模板字符串解析成抽象语法树（AST）

> - 使用基于正则的有限状态机解析 HTML：
>   - 面试可说：**“逐字符扫描，用正则匹配标签、属性、文本、注释等，维护一个栈来构建层级关系”**。
> - 主要生成的 AST 节点类型：
>   - `Element`：元素节点，包含 `tag`、`attrsList`、`children`、`parent` 等。
>   - `Text`：普通文本节点。
>   - `Expression`：模板插值 `{{ msg }}` 解析出的表达式。
>   - `Comment`：注释节点。
> - 处理的关键内容：
>   - 指令解析：`v-if`、`v-for`、`v-model` 等，转换成 AST 上的特殊属性（如 `if`、`for`、`model`）。
>   - 插值表达式：`{{ xxx }}` 被解析为带有 `expression` 的文本节点或表达式节点。
> - 输出：
>   - 一棵描述模板结构的 AST 树，后面所有优化和代码生成都基于这棵树进行。

**2.第二步：optimize —— 标记静态节点（重要优化）**

目标：在 AST 上标记静态子树，为后续渲染性能优化打基础。

> - 核心思想：
>   - **静态节点**：一旦渲染就不会再变化的节点（没有绑定、没有指令、没有插值）。
>   - 静态子树在每次重渲染时可以跳过重新创建，直接复用，甚至提升为静态渲染函数。
> - 做的事情：
>   - 标记每个 AST 节点的 `static` 属性。
>   - 标记 `staticRoot`：当某个节点及其所有子节点都是静态时，将其标记为静态根。
> - 收益：
>   - 生成 `staticRenderFns`，将静态子树单独渲染为函数，在 `_render` 中直接调用。
>   - 减少每次 render 的开销，提升更新性能，这是模板编译相对于手写 render 的主要优化之一。

**3.第三步：generate —— AST → 渲染函数代码字符串**

目标：根据优化后的 AST 生成渲染函数的代码字符串。

> - 输入：
>   - 优化后的 AST。
> - 输出（vue-template-compiler.compile返回的对象）
>   - `render`：主渲染函数代码字符串。
>   - `staticRenderFns`：静态子树的渲染函数代码字符串数组。
>   - `ast`：解析后的 AST（可选）。
>   - `errors/warnings`：编译错误/警告信息。
> - 生成的代码特点：
>   - 使用 `with(this){...}` 包裹，简化属性访问（运行时也可在非严格模式下使用）。
>   - 内部通过 `_c(tag, data, children)`、`_v(text)`、`_s(expr)` 等运行时辅助函数创建 VNode。
>   - `v-if` / `v-for` 等被展开成三元表达式、`_l` 循环等 JavaScript 逻辑。

**4.第四步：代码字符串 → 真正的 render 函数**

目标：把生成的代码字符串变成可执行的函数。

> - 通常通过 new Function(code) 创建函数：
>   - 在运行时编译场景下，Vue 使用类似：const res = Vue.compile(template);const render = new Function(res.render)
> - 在构建时预编译时，`vue-loader` 直接把生成的 `render` / `staticRenderFns` 字符串注入到组件选项中，无需运行时编译。
> - 严格模式 / CSP 问题：
>   - 因为生成的代码使用了 `with`，所以不能在严格模式或 CSP 环境直接执行；这就是推荐预编译的原因之一。

5.运行时执行：render → VNode

> - 组件初始化时，会把编译得到的 `render` 和 `staticRenderFns` 挂载到组件选项上。
> - 在组件渲染流程中：
>   - 调用 `render` 函数，结合组件实例作为上下文（`this`），生成 VNode 树。
>   - 静态子树通过 `staticRenderFns` 单独调用，返回的 VNode 会被复用。
> - 后续：
>   - VNode 经过 `patch` 过程，转化为真实 DOM 并挂载到页面。

**三、关键点**

**1.编译时机：构建时 vs 运行时**

> - 构建时预编译（主流）：
>   - `vue-loader` + `vue-template-compiler`，在构建阶段就生成 `render` / `staticRenderFns`。
>   - 运行时只需要“运行时构建”，体积更小，且没有 CSP / 严格模式问题。
> - 运行时编译：
>   - 使用完整构建版本，通过 `Vue.compile` 在浏览器端编译模板。
>   - 适合动态模板、简单示例，但性能和兼容性都不如预编译。

**2.AST 的作用**

> - AST 是模板的中间表示，所有后续操作（优化、代码生成）都基于 AST。
> - AST 让我们可以对模板做静态分析、优化、错误检查，而不是直接用正则“硬拼”代码。

**3.optimize 的意义**

> - 标记静态节点，让 Vue 能够：
>   - 跳过静态子树的 diff。
>   - 提升为静态渲染函数，减少每次渲染的函数调用开销。
> - 面试可以顺带说：**“这是模板编译比手写 render 性能更好的关键点之一”**。

## Diff算法

**1.定义**

> Vue 2 的 Diff 算法采用的是**基于双端比较**的同层比较策略。它的核心目标是在 Virtual DOM（虚拟 DOM）树发生变更时，通过对比新旧节点，找出最小的变动量，从而以最小的操作代价更新真实 DOM，提高渲染性能。

**2.核心算法**

**节点比较**

> 首先判断新旧节点是否为同一节点（通过 `sameVnode` 函数判断 `key` 和 `tag` 等是否相同）。
>
> - **如果是同一节点**：执行 `patchVnode`，更新属性，并递归比较子节点。
> - **如果不是同一节点**：直接销毁旧节点，创建新节点，不需要继续对比子节点。

**子节点更新策略（双端比较算法）**

当旧节点和新节点都有子节点时，Vue 2 使用 **双端比较**（同时从首尾遍历）来处理子节点列表更新。主要通过四个指针进行四种情况的命中查找：

> 1. **旧头 vs 新头** (`oldStartIdx` vs `newStartIdx`)：
>    - 如果匹配，说明节点位置没变，直接 `patch` 更新属性，两指针右移。
> 2. **旧尾 vs 新尾** (`oldEndIdx` vs `newEndIdx`)：
>    - 如果匹配，说明节点位置没变，直接 `patch` 更新属性，两指针左移。
> 3. **旧头 vs 新尾** (`oldStartIdx` vs `newEndIdx`)：
>    - 如果匹配，说明该旧节点被移动到了新列表的末尾。
>    - 操作：将该真实 DOM 节点移动到旧尾节点的后面，旧头指针右移，新尾指针左移。
> 4. **旧尾 vs 新头** (`oldEndIdx` vs `newStartIdx`)：
>    - 如果匹配，说明该旧节点被移动到了新列表的开头。
>    - 操作：将该真实 DOM 节点移动到旧头节点的前面，旧尾指针左移，新头指针右移。
> 5. **非上述四种情况（乱序/未知匹配）**：
>    - 拿新头节点（`newStartIdx`）的 Key 去旧节点列表中查找。
>    - **如果找到了**：说明该旧节点存在于旧列表中，但位置变了。将该真实 DOM 节点移动到旧头指针之前。并将该旧节点在旧列表中标记为 `undefined`（表示已处理，防止重复移动）。
>    - **如果没找到**：说明这是一个新节点，直接创建新 DOM 节点插入到旧头指针之前。

**4.循环结束后的收尾工作**

当循环结束（通常是 `OldStart > OldEnd` 或 `NewStart > NewEnd`）时，可能存在多余节点：

- **如果旧列表先遍历完**：说明新列表中还有剩余节点，这些节点都是需要新增的。直接批量创建并插入到 DOM 中。
- **如果新列表先遍历完**：说明旧列表中还有剩余节点，这些节点都是需要删除的。直接批量销毁这些真实 DOM。

**5.总结**

Vue 2 的 Diff 算法通过**双端比较**和**Key 映射**，将最坏情况下的全量比对 O(n3)*O*(*n*3) 降低到了 O(n)*O*(*n*)。它虽然不如 Vue 3 的最长递增子序列算法极致，但在大多数业务场景下已经提供了非常好的性能表现。

**6.进阶**

> 1.**为什么不建议用 index 做 Key**
>
> 如果用数组索引做 Key，当列表发生插入、删除操作时，所有后续元素的索引都会变化，导致 DOM 没有被复用，而是全部重新渲染（Patch 失效），极大地降低了性能。建议使用唯一的 ID（如后端返回的 ID）作为 Key。
>
> 2.**Vue 3 的 Diff 有什么不同**
>
> Vue 3 采用了**最长递增子序列**算法，去掉了双端比较，仅通过新的头尾和旧的头尾进行比对，利用 Map 查找 Key，整体算法更复杂但减少了不必要的 DOM 移动，性能更高。

## Vue2性能优化

> - 代码层面
> - 基础框架层
> - 打包层面

**代码层面**

> - 合理使用 v-if 和 v-show
> - v-for 必须搭配 key，且避免与 v-if 同级，优先级是 v-for > v-if
> - 计算属性 vs 侦听器
>   - 优先使用 `computed` 计算属性，因为它具有缓存特性，依赖不变就不会重新执行。
>   - 避免在 `computed` 中执行耗时操作或产生副作用。
> - 减少大型数据响应式开销
>   - 冻结对象：对于纯展示的大数据列表（如长列表数据），可以使用 Object.freeze() 冻结对象。这会阻止 Vue 给数据添加 Getter/Setter，大幅减少初始化时间和内存占用。
>   - 延迟响应式：对于部分需要动态添加的属性，使用 this.$set 替代直接赋值，或在创建时就初始化好所有属性（避免 Vue 遍历新增属性）。
> - 组件销毁与清理：在组件销毁时（`beforeDestroy` 或 `destroyed` 钩子），手动清理定时器、全局事件监听
> - 使用函数式组件：对于无状态（没有 `data`）、无实例（没有 `this`）的展示型组件，声明为 `functional: true`。这种组件开销极低，渲染速度快。

**基础框架层**

> - 路由懒加载
> - 合理使用 keep-alive：使用 `<keep-alive>` 包裹 `<router-view>` 或组件。注意缓存的组件不能太多，否则会占用大量内存。
> - 长列表虚拟滚动：使用虚拟滚动库（如 `vue-virtual-scroller`）
> - 服务端渲染 (SSR)
> - 骨架屏

**打包层面**

> - 第三方库按需引入：使用 Tree Shaking 或插件（如 babel-plugin-component）实现按需引入，减少打包体积
> - 图片资源优化：小图片使用 Base64 或转为雪碧图；大图片使用懒加载（vue-lazyload）；使用 WebP 格式替代 JPG/PNG
> - 开启生产环境优化：确保 vue.config.js 或 Webpack 配置中开启了代码压缩、开启 Gzip 压缩、开启 CDN 加速

# 源码

## 前言

**关于源码**

> - 为了面试
> - 为了在简历上写自己会源码
> - 了解底层原理 学习高手思路
> - 通过源码来学习一些小技巧(*骚操作*)
> - 对框架如何实现的各种功能感到好奇
> - 内卷严重 不看不行 逆水行舟 不进则退
> - 自己也想造轮子 先看看别人都是怎么做的
> - 各种公众号和卖课的都在贩卖焦虑 被洗脑洗的
>
> 

**怎样学习源码才是最科学的方式呢？**

> 我们来看一个例子：有一些听起来非常高大上的高科技产品，如`电磁轨道炮`。那么当我们拆解一个电磁轨道炮的时候，大概率你是看不懂它的。
>
> 但用了一些磁铁、若干钢珠、以及几个我们日常生活中能够搞到的材料来制作了一个`简易版的电磁轨道炮`。这样我们一下子就能够搞懂`电磁轨道炮的真正原理`。
>
> 虽然这样的轨道炮并不能真正的用于实战，但只要我们明白了最基础的那部分，我们就可以在此基础上一步步进行扩展，慢慢弄懂整个能够用于实战的复杂轨道炮。

## Vue源码调试

**1.下载源码**

[vue-v2.6.14版本](https://github.com/vuejs/vue/tree/v2.6.14)下载

**2.安装依赖**

```
npm i
```

安装依赖报错-phantomjs-prebuilt@2.1.14 install: `node install.js`

```
解决方案：npm install phantomjs-prebuilt@2.1.14 --ignore-scripts
```

安装依赖报错-(plugin Rollup Core) Error: Could not load或者提示 no such file or directory, src\core\config

```
手动下载依赖包https://github.com/ideayuye/rollup-plugin-alias，并覆盖掉本地文件夹 \node_modules\rollup-plugin-alias。进入rollup-plugin-alias文件夹，依次执行npm i
```

安装依赖报错-idealTree:vue: sill idealTree buildDeps

```
清除npm缓存npm cache clean --force
设置新的淘宝镜像源npm config set registry https://registry.npmmirror.com
```

**3.开启打包源文件**

```
// package.json
"dev": "rollup -w -c scripts/config.js --environment TARGET:web-full-dev --sourcemap",
```

**4.开始调试源码**

> 在源码目录中添加断点调试即可，比如\vue-2.6.14\src\core\instance\init.js

```
<!DOCTYPE html>
<html>
  <head>
    <style>
      #demo {
        font-family: "Helvetica", Arial, sans-serif;
        text-align: center;
      }
    </style>
    <script src="./dist/vue.js"></script>
  </head>
  <body>
    <div id="demo">
      <button @click="num++">Object类型自增加：{{num}}</button>
      <button @click="add">Array类型自增加：{{arr}}</button>
    </div>
    <script>
      new Vue({
        el: "#demo",
        data: {
          num: 0,
          arr: [1, 2, 3],
        },
        methods: {
          add() {
            this.arr.push(this.arr[this.arr.length - 1] + 1);
            // this.$set(this.arr, 0, this.arr[0] + 1);
          },
        },
      });
    </script>
  </body>
</html>
```

## Vue源码目录

```
├── benchmarks                  性能、基准测试
├── dist                        构建打包的输出目录
├── examples                    案例目录
├── flow                        因为Vue使用了Flow来进行静态类型检查，这里定义了声明了一些静态类型
├── packages                    一些额外的包，比如：负责服务端渲染的包 vue-server-renderer、配合 vue-loader 使用的 									vue-template-compiler，还有 weex 相关的
    ├── vue-server-renderer
    ├── vue-template-compiler
    ├── weex-template-compiler
    └── weex-vue-framework
├── scripts                     所有的配置文件的存放位置，比如 rollup 的配置文件
├── src                         vue 源码目录
│   ├── compiler                编译器
      |—codegen     根据ast生成render函数
         |—directives    通用生成render函数之前需要处理的指令
         |—parser     模板解析
│   ├── core                    运行时的核心包
│   │   ├── components          全局组件，比如 keep-alive
│   │   ├── config.js           一些默认配置项
│   │   ├── global-api          全局方法，也就是添加在Vue对象上的方法，比如Vue.use,Vue.extend,,Vue.mixin等
│   │   ├── instance            实例相关内容，包括实例方法，生命周期，事件等
│   │   ├── observer            响应式原理
│   │   ├── util                工具方法
│   │   └── vdom                虚拟 DOM 相关，比如熟悉的 patch 算法就在这儿
│   ├── platforms               平台相关的编译器代码
│   │   ├── web					
│   │   ├── weex 				类似react native跨端平台
    |— web web端独有文件
                |— compiler 编译阶段需要处理的指令和模块
                |— runtime 运行阶段需要处理的组件、指令和模块
                |— server 服务端渲染相关
                |— util 工具库
│   ├── server                  服务端渲染相关
├── test                        测试目录
├── types                       TS 类型声明
```

## Vue从实例化到渲染的完整流程

参考：[vue源码分析](https://segmentfault.com/a/1190000023649060)

> new Vue->init->mount->compile->render->vnode->patch->dom

**1. 定义Vue**构造函数

```
initMixin(Vue);  // 定义 _init
stateMixin(Vue);  // 定义 $set $get $delete $watch 等
eventsMixin(Vue);   // 定义事件  $on  $once $off $emit
lifecycleMixin(Vue); // 定义 _update  $forceUpdate  $destroy
renderMixin(Vue); // 定义 _render 返回虚拟dom  
```

**2. initMixin**

实例化Vue时，执行 _init, _init 定义在 initMixin 中

```
  Vue.prototype._init = function (options) {
    // 合并 options
    if (options && options._isComponent) {
      initInternalComponent(vm, options); // 组件合并
    } else {
      // 非组件合并
      vm.$options = mergeOptions(
        resolveConstructorOptions(vm.constructor), 
        options || {},
        vm
      );
    }
    initLifecycle(vm); // 定义 vm.$parent vm.$root vm.$children  vm.$refs 等
    initEvents(vm);   // 定义 vm._events  vm._hasHookEvent 等
    initRender(vm); // 定义 $createElement $c
    callHook(vm, 'beforeCreate'); // 挂载 beforeCreate 钩子函数
    initInjections(vm); // resolve injections before data/props
    initState(vm);  // 初始化 props methods data computed watch 等方法
    initProvide(vm); // resolve provide after data/props
    callHook(vm, 'created'); // 挂载 created 钩子函数
    if (vm.$options.el) {
      vm.$mount(vm.$options.el); // 实例挂载渲染dom
    }
  };
```

**3. $mount**

vue最终都是通过render函数将dom编译为虚拟dom

```
// 构建render函数
if (!options.render) {
  // 如果没有render属性，那么将template模版编译转为render
}
// 最后调用 mount
return mount.call(this, el, hydrating)
// mount 调用 mountComponent
return mountComponent(this, el, hydrating)
```

**4. mountComponent**

通过 new Watcher 调用执行 updateComponent, vm._render获取虚拟dom, vm._update将虚拟dom转为真实的dom并挂载到页面。

```
// hydrating 代表服务端渲染 hydrating => false
updateComponent = function () {
  vm._update(vm._render(), hydrating); // 关键点
};
```

**5. _render**

_render执行render函数 返回vnode。

```
Vue.prototype._render = function () {
    // 此处的 vm._renderProxy 等价于 vm
    vnode = render.call(vm._renderProxy, vm.$createElement);
}
```

$createElement 主要是参数重载，整合为统一格式后调用 _createElement函数。

**6. _update**

_update 主要实现 vnode 转化为实际的dom， 注入到页面的同时并销毁页面模版。

## Vue源码深度解析

**参考**

> - [Vue.js源码全方位深入解析-黄轶-video](https://www.1024zyz.com/3206.html)
> - [Vue.js源码全方位深入解析-黄轶](https://ustbhuangyi.github.io/vue-analysis/v2/prepare/)
> - [李永宁Vue源码解读-video](https://www.bilibili.com/video/BV1Jb4y1D7eA/?spm_id_from=333.999.0.0&vd_source=bd4c7d99d71adf64d6e88c65370e0247)
> - [珠峰公开课-vue2.0源码实现-video](https://www.bilibili.com/video/BV1aq4y1o7Ny/?spm_id_from=333.999.0.0&vd_source=bd4c7d99d71adf64d6e88c65370e0247)
> - [vue核心四大模块](https://winteroo.github.io/ylblog/docs/vue/01introduce.html#%E5%89%8D%E8%A8%80)
> - [Vue源码系列-Vue中文社区](https://vue-js.com/learn-vue/)
> - [李永宁Vue源码解读](https://juejin.cn/column/6960553066101735461)
> - [汪道南源码解析](https://wangtunan.github.io/blog/vueAnalysis/introduction/)
> - [推荐 7 个 Vue2、Vue3 源码解密分析的开源项目](https://github.com/FrontEndGitHub/FrontEndGitHub/issues/35)

**Vue核心四大模块**

- 生命周期过程
- 变化监测原理
- 模板编译原理
- 虚拟DOM原理

**生命周期过程-待续**

**变化监测原理-待续**

**模板编译原理-待续**

**虚拟DOM原理-待续**

## Vue.js源码全方位深入解析-黄轶

- [vue2源码分析仓库](https://github.com/fuyunjinglong/web-sourceCode-vue2)
- [2.x版本笔记](https://ustbhuangyi.github.io/vue-analysis/v2/prepare/)

### 准备工作

**1.认识Flow**

[Flow](https://flow.org/en/docs/getting-started/) 是 facebook 出品的 JavaScript 静态类型检查工具。Vue.js 的源码利用了 Flow 做了静态类型检查。

**为什么用 Flow**

> JavaScript 是动态类型语言，但是它过于灵活的副作用是很容易写出非常隐蔽的隐患代码，在编译期不会报错，但在运行阶段就可能出现各种奇怪的bug。
>
> 类型检查是当前动态类型语言的发展趋势，所谓类型检查，就是在编译期尽早发现（由类型错误引起的）bug，又不影响代码运行（不需要运行时动态检查类型），使编写 JavaScript 具有和编写 Java 等强类型语言相近的体验。
>
> 项目越复杂就越需要通过工具的手段来保证项目的维护性和增强代码的可读性。
>
> Vue.js 在做 2.0 重构的时候，引入了 Flow 做静态类型检查,之所以选择 Flow，主要是因为 Babel 和 ESLint 都有对应的 Flow 插件以支持语法,非常小成本的改动就可以拥有静态类型检查的能力。

**Flow 的工作方式**

> - 类型推断：通过变量的使用上下文来推断出变量类型，然后根据这些推断来检查类型。
> - 类型注释：事先注释好我们期待的类型，Flow 会基于这些注释来判断。

```
类型推断
/*@flow*/
function split(str) {
  return str.split(' ')
}
split(11)

类型注释
/*@flow*/
function add(x: number, y: number): number {
  return x + y
}
add('Hello', 11)
```

**类型注释**

更多请移步 Flow 的[官方文档](https://flow.org/en/docs/types/)。

数组

```
/*@flow*/
var arr: Array<number> = [1, 2, 3]
arr.push('Hello')
```

类和对象

```
/*@flow*/
class Bar {
  x: string;           // x 是字符串
  y: string | number | void;  // y 可以是字符串或者数字，void表示为空即可不传
  z: boolean;
  constructor(x: string, y: string | number| void) {
    this.x = x
    this.y = y
    this.z = false
  }
}

var bar: Bar = new Bar('hello', 4)
var obj: { a: string, b: number, c: Array<string>, d: Bar } = {
  a: 'hello',
  b: 11,
  c: ['hello', 'world'],
  d: new Bar('hello', 3)
}
```

Null

若想任意类型 `T` 可以为 `null` 或者 `undefined`，只需类似如下写成 `?T` 的格式即可。

```
/*@flow*/
var foo: ?string = null // 此时，foo 可以为字符串，也可以为 null。
```

**Flow 在 Vue.js 源码中的应用**

对于引用的第三方库，或者自定义一些类型，但 Flow 并不认识，因此检查的时候会报错。为了解决这类问题，Flow 提出了一个 `libdef` 的概念，可以用来识别这些第三方库或者是自定义类型。

在 Vue.js 的主目录下有 `.flowconfig` 文件， `[libs]` 部分用来描述包含指定库定义的目录，这里 `[libs]` 配置的是 `flow`，表示指定的库定义都在 `flow` 文件夹内。

```
flow
├── compiler.js        # 编译相关
├── component.js       # 组件数据结构
├── global-api.js      # Global API 结构
├── modules.js         # 第三方库定义
├── options.js         # 选项相关
├── ssr.js             # 服务端渲染相关
├── vnode.js           # 虚拟 node 相关
```

**2.Vue.js 源码构建**

Vue.js 源码是基于 [Rollup](https://github.com/rollup/rollup) 构建的，它的构建相关配置都在 scripts 目录下。

**构建脚本**

总共有 3 条命令，Vue.js 源码构建的脚本如下：

```
{
  "script": {
    "build": "node scripts/build.js",
    "build:ssr": "npm run build -- web-runtime-cjs,web-server-renderer",
    "build:weex": "npm run build -- weex"
  }
}
```

**构建过程**

> scripts/build.js

```
// 1.读取配置文件
let builds = require('./config').getAllBuilds()

// 2.根据package.json中脚本的配置参数，得到需要打包的平台，然后过滤配置
if (process.argv[2]) {
  const filters = process.argv[2].split(',')
  builds = builds.filter(b => {
    return filters.some(f => b.output.file.indexOf(f) > -1 || b._name.indexOf(f) > -1)
  })
} else {
  // filter out weex builds by default
  builds = builds.filter(b => {
    return b.output.file.indexOf('weex') === -1
  })
}
// 3.开始构建
build(builds)

function build (builds) {
  let built = 0
  const total = builds.length
  const next = () => {
    // 根据配置逐个构建对应平台的js文件
    buildEntry(builds[built]).then(() => {
      built++
      if (built < total) {
        next()
      }
    }).catch(logError)
  }

  next()
}

function buildEntry (config) {
  const output = config.output
  const { file, banner } = output
  const isProd = /(min|prod)\.js$/.test(file)
  return rollup.rollup(config)// 生成bundle
    .then(bundle => bundle.generate(output))// 生成输出文件
    .then(({ output: [{ code }] }) => {
      if (isProd) {// 如果是生产环境，是否需要压缩代码
        const minified = (banner ? banner + '\n' : '') + terser.minify(code, {
          toplevel: true,
          output: {
            ascii_only: true
          },
          compress: {
            pure_funcs: ['makeMap']
          }
        }).code
        // 最后生成打包文件
        return write(file, minified, true)
      } else {
        return write(file, code)
      }
    })
}
```

> scripts/config.js

```
if (process.env.TARGET) {
  module.exports = genConfig(process.env.TARGET)
} else {
  exports.getBuild = genConfig
  // 根据package.json的脚本配置，生成rollup所需要的配置文件格式数组，genConfig是最终格式
  exports.getAllBuilds = () => Object.keys(builds).map(genConfig)
}
// 所有平台需要配的配置
const builds = {
    // Runtime+compiler development build (Browser)
  'web-full-dev': {
    entry: resolve('web/entry-runtime-with-compiler.js'),// 后面分析的入口
    dest: resolve('dist/vue.js'),
    format: 'umd',
    env: 'development',
    alias: { he: './entity-decoder' },
    banner
  },
  'web-runtime-cjs-prod': {
    entry: resolve('web/entry-runtime.js'),
    dest: resolve('dist/vue.runtime.common.prod.js'),
    format: 'cjs',
    env: 'production',
    banner
  },
  ....
  }
  
// 转换为rollup最终需要的配置数据格式，并添加其他配置
function genConfig (name) {
  const opts = builds[name]
  const config = {
    input: opts.entry,
    external: opts.external,
    plugins: [
      flow(),
      alias(Object.assign({}, aliases, opts.alias))
    ].concat(opts.plugins || []),
    output: {
      file: opts.dest,
      format: opts.format,
      banner: opts.banner,
      name: opts.moduleName || 'Vue'
    },
    onwarn: (msg, warn) => {
      if (!/Circular/.test(msg)) {
        warn(msg)
      }
    }
  }
  ...
  return config
}
```

**3.Runtime Only VS Runtime + Compiler**

通常我们利用 vue-cli 去初始化我们的 Vue.js 项目的时候会询问我们用 Runtime Only 版本的还是 Runtime + Compiler 版本。下面我们来对比这两个版本。

- Runtime Only

我们在使用 Runtime Only 版本的 Vue.js 的时候，通常需要借助如 webpack 的 vue-loader 工具把 .vue 文件编译成 JavaScript，因为是在编译阶段做的，所以它只包含运行时的 Vue.js 代码，因此代码体积也会更轻量。

- Runtime + Compiler

我们如果没有对代码做预编译，但又使用了 Vue 的 template 属性并传入一个字符串，则需要在客户端编译模板

**4.从入口开始**

**核心**

> 本质上是一个Vue函数，通过`src\core\instance\index.js`重写原型方法和`src\core\global-api\index.js`挂载静态全局方法，扩展功能方法。

我们之前提到过 Vue.js 构建过程，在 web 应用下，我们来分析 Runtime + Compiler 构建出来的 Vue.js，它的入口是 `src/platforms/web/entry-runtime-with-compiler.js`：

```
import Vue from './runtime/index'
Vue.prototype.$mount = function (){
...// luwen重写了原型mount方法
}
export default Vue // luwen来自另外一个地方
```

`src\platforms\web\runtime\index.js`：

```
import Vue from 'core/index'
// luwen定义一些静态方法
Vue.config.mustUseProp = mustUseProp
Vue.prototype.$mount = function (
  ...// luwen重写了原型mount方法
  }
export default Vue // luwen来自另外一个地方
```

`src\core\index.js`：

```
import Vue from './instance/index'
// luwen定义全局方法
initGlobalAPI(Vue)
export default Vue // luwen来自另外一个地方
```

`src\core\instance\index.js`

```
// luwen最后发现Vue本质是一个函数
function Vue (options) {
  if (process.env.NODE_ENV !== 'production' &&
    !(this instanceof Vue)
  ) {
    warn('Vue is a constructor and should be called with the `new` keyword')
  }
  this._init(options)
}
// luwen-通过重写原型，扩展Vue函数的方法
initMixin(Vue)
stateMixin(Vue)
eventsMixin(Vue)
lifecycleMixin(Vue)
renderMixin(Vue)

export default Vue
```

`src\core\global-api\index.js`

```
export function initGlobalAPI (Vue: GlobalAPI) {
  // luwen定义了一些工具函数吗，但有可能会变化，所以有使用风险
  Vue.util = {
    warn,
    extend,
    mergeOptions,
    defineReactive
  }
// luwen定义了全局的set,delete,delete
  Vue.set = set
  Vue.delete = del
  Vue.delete = nextTick
// luwen定义了全局的方法component、directive、filter,合并到options上
  ASSET_TYPES.forEach(type => {
    Vue.options[type + 's'] = Object.create(null)
  })
  // luwen定义了全局内置组件KeepAlive
  extend(Vue.options.components, builtInComponents)
  // luwen-通过重写原型，扩展全局静态方法
  initUse(Vue)// luwen定义了全局use方法
  initMixin(Vue)// luwen定义了全局mixin方法
  initExtend(Vue)// luwen定义了全局extend方法
  initAssetRegisters(Vue)// luwen定义了全局component、directive、filter方法处理
}

```

### 数据驱动

**1.new Vue 发生了什么**

我们看下Vue的构造函数

`src\core\instance\index.js`

```
// luwen最后发现Vue本质是一个函数
function Vue (options) {
  if (process.env.NODE_ENV !== 'production' &&
    !(this instanceof Vue)
  ) {
    warn('Vue is a constructor and should be called with the `new` keyword')
  }
  // luwen-最初的初始化方法，_init是在initMixin函数中实现的原形重写定义
  this._init(options)
}
// luwen-通过重写原型，扩展Vue函数的方法
initMixin(Vue)// luwen-来自另外一个地方
```

`src\core\instance\init.js`

```
export function initMixin (Vue: Class<Component>) {
  Vue.prototype._init = function (options?: Object) {
  // luwen-最终将options合并并挂载到$options上,方便后续调用。这里的options就是Vue函数的入参
   vm.$options = mergeOptions(
        resolveConstructorOptions(vm.constructor),
        options || {},
        vm
      )
   initLifecycle(vm)// luwen-初始化生命周期
    initEvents(vm)// luwen-初始化事件中心
    initRender(vm)// luwen-初始化渲染函数
    callHook(vm, 'beforeCreate')
    initInjections(vm) // resolve injections before data/props
    initState(vm)// luwen-初始化用户数据
    initProvide(vm) // resolve provide after data/props
    callHook(vm, 'created')    
     // luwen-最后判断是否存在el,存在则挂载dom
    if (vm.$options.el) {
      vm.$mount(vm.$options.el)
    }
  }
  }
```

**为什么this.num就能访问data定义中的num？**

> this.num本质就是访问this._data.num

`src\core\instance\state.js`

```
function initData (vm: Component) {
  let data = vm.$options.data
  // luwen-data赋值到_data
  data = vm._data = typeof data === 'function'
    ? getData(data, vm)
    : data || {}
    
    // luwen-比较data和props有没有重复定义
  while (i--) {
    const key = keys[i]
    if (process.env.NODE_ENV !== 'production') {
      if (methods && hasOwn(methods, key)) {
        warn(
          `Method "${key}" has already been defined as a data property.`,
          vm
        )
      }
    }
    // luwen-就是访问this.num本质就是访问this._data.num。
    // luwen-将vm的数据通过代理访问到_data上
      proxy(vm, `_data`, key)
  }
```

