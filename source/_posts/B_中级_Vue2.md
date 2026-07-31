---
title: Vue2
date: 2000-01-01 06:33:16
categories:
  - B_中级
toc: true # 是否启用内容索引
---

# 初级

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
   // path或者name: 'User'都可以
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

    // 跳转 (只能使用name，params 。如果用 path则无效)
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

| 特性         | Vue 2 (Object.defineProperty)    | Vue 3                            |
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

> 1. **性能优化（减少 DOM 操作）**：
>    - 真实 DOM 的操作（重排、重绘）性能开销大。
>    - 通过 Diff 算法对比新旧 VNode，计算出最小变化量，最后一次性更新真实 DOM（批量更新），避免了无效的频繁操作。
> 2. **跨平台能力**：
>    - 虚拟 DOM 是 JS 对象，与平台无关。Vue 2 不仅能渲染到浏览器 DOM，还可以通过适配层渲染到原生应用、Canvas 或 SVG 等平台。

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

本质上是：**模板字符串 → AST →（优化）→ 渲染函数代码字符串 → 真正的 render 函数**，核心由 `parse`、`optimize`、`generate` 三个阶段完成，通常由 `vue-template-compiler` 在构建时预编译，或在运行时使用 `Vue.compile` 动态编译。

> 分为三步：`parse` 将模板字符串解析成 AST；`optimize` 标记静态节点；`generate` 将 AST 转成渲染函数代码字符串，再通过 `new Function` 得到真正的 render 函数。

**二、整体流程**

> - template 字符串
> - parseHTML 解析模板
> - AST 抽象语法树
> - optimize 标记静态节点
> - generate 生成代码字符串
> - new Function 创建 render 函数
> - 组件实例执行 render 生成 VNode

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



# 入门

**定义**

vue2 是一套基于**声明式渲染**和**渐进式**的轻量级响应式框架，它可以设计为自底向上的逐层应用。

缺点：单页面不利于seo，不支持IE8以下，首屏加载时间长

## 声明式渲染

**声明式渲染和命令式渲染比较**

- 命令式渲染 ： 命令我们的程序去做什么，程序就会跟着你的命令去一步一步执行
- 声明式渲染 ： 我们只需要告诉程序我们想要什么效果，其他的交给程序来做。

## **渐进式框架**

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

## **Vue2框架特点**

- 轻量：内置 bunding 和 tree-shaking,打包后体积 30k,而 angular 是 65k
- 学习成本低：文档组织结构清晰，采用组件化模式，提高代码复用性
- 性能优化：虚拟dom和优化的diff算法,避免子组件渲染
- 国内生态良好：众多厂商使用，持续增长

## 从 0 开始构建

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

# 进阶

## 插件

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

## **双向绑定**

**v-model原理**

```
<input type="text" v-model="age">
<input type="text" v-bind="age" v-on:input="age = $event.target.value">
```

v-model的原理就是: v-bind 和 v-on的语法糖

**第一种: v-bind**

**原理: 子组件通过监听父组件数据，子组件改变数据之后通知给父组件**

错误写法: 不可以直接修改props的值

父组件：

```
// Users.vue 
<template>
  <div>
    <Son :ageValue="age" @changeInput="changeInput"/>
    <el-button @click="age = Math.floor(Math.random()*10)">添加</el-button>
  </div>
</template>

<script>
export default {
  data() {
    return {
      age: ''
    }
  },
  methods: {
    changeInput(val) {
      this.age = val
    }
  }
}
</script>
```

子组件：

```
// Son.vue
<template>
  <div>
    <input type="text" v-model="sonAge" @input="changeInput">
  </div>
</template>

<script>
export default {
  props: {
    ageValue: {
      typeof: String
    }
  },
  data() {
    return {
      sonAge: ''
    }
  },
  methods: {
    changeInput() {
      this.$emit('changeInput', this.sonAge)
    }
  },

  /*
   为什么要监听:
   因为父组件传递过来属性, 可能有默认值,
   子组件的input需要根据默认值回显,或者别的地方需要
  */
  watch: {
    ageValue: {
      immediate: true, // 立即执行 :当刷新页面时会立即执行一次handler函数
      handler(val) {
        this.sonAge = val
      }
    }
  }
}
</script>
```

**第二种.sync修饰符**

原理:.sync:名字 是自己起的, 通过update:名字进行触发对象的事件。update：是vue为我们约定好的名称部分

父组件：

```
// Users.vue
<template>
  <div>
    <Son :ageValue.sync="age" />
    <el-button @click="age = Math.floor(Math.random()*10)">添加</el-button>
  </div>
</template>

<script>
export default {
  data() {
    return {
      age: ''
    }
  },
  methods: {
  }
}
</script>
```

子组件：

```
// Son.vue
<template>
  <div>
    <input type="text" v-model="sonAge" @input="changeInput">
  </div>
</template>

<script>
export default {
  props: {
    ageValue: {
      typeof: String
    }
  },
  data() {
    return {
      sonAge: ''
    }
  },
  methods: {
    changeInput() {
      // this.$emit('changeInput', this.sonAge)
      // 这样父组件内的值也同时被更改,省略了监听事件这一步
      this.$emit('update:ageValue', this.sonAge)
    }
  },
  watch: {
    ageValue: {
      immediate: true, // 立即执行 :当刷新页面时会立即执行一次handler函数
      handler(val) {
        this.sonAge = val
      }
    }
  }
}
</script>
```

**第三种 v-model**

原理: 通过 model新属性: 配置一个 props:接受的属性, 和一个事件名。

父组件：

```
// Users.vue
<template>
  <div>
    <Son v-model="age" />
    <el-button @click="age = Math.floor(Math.random()*10)">添加</el-button>
  </div>
</template>

<script>
export default {
  data() {
    return {
      age: ''
    }
  }
}
</script>
```

子组件：

```
// Son.vue
<template>
  <div>
    <input type="text" v-model="sonAge" @input="changeInput">
  </div>
</template>

<script>
export default {
  props: {
    value: {
      typeof: String
    }
  },
  data() {
    return {
      sonAge: ''
    }
  },
  // 超级牛
  model: {
    prop: 'value',
    event: 'change'
  },
  methods: {
    changeInput() {
      this.$emit('change', this.sonAge)
    }
  },
  watch: {
    value: {
      immediate: true, // 立即执行 :当刷新页面时会立即执行一次handler函数
      handler(val) {
        this.sonAge = val
      }
    }
  }
}
</script>
```

## 修饰符与指令

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

## 动态class/动态style

- 动态class对象：`<div :class="{ 'is-active': true, 'red': isRed }"></div>`
- 动态class数组：`<div :class="['is-active', isRed ? 'red' : '' ]"></div>`
- 动态style对象：`<div :style="{ color: textColor, fontSize: '18px' }"></div>`
- 动态style数组：`<div :style="[{ color: textColor, fontSize: '18px' }, { fontWeight: '300' }]"></div>`

## 全局组件

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

## 动态组件和异步组件

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

**Vue 的异步组件放在哪个生命周期**

结论：created 和 mounted 都可以。

- 对于作为子组件被调用的组件里，异步请求应当在`mounted`里调用，因为这个时候子组件可能需要涉及到对 dom 的操作；
- 对于页面级组件，当我们需要使用`ssr`（服务端渲染）的时候，只有`created`是可用的，所以这个时候请求数据只能用它；
- 对于页面级组件， 当我们做异步操作时，涉及到要访问 dom 的操作，我们仍旧只能使用`mounted`;
- 对于一般情况，`created`和`mounted`都是可以的；

## Socpe样式

```
<style lang='less'></style>
不指定lang，则默认按照css处理。否则按照less,sass等处理器处理
```

## 自定义事件

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

## 路由

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

## v-if 与 v-for 比较

- 2.x 版本中在一个元素上同时使用 `v-if` 和 `v-for` 时，`v-for` 会优先作用
- 3.x 版本中 `v-if` 总是优先于 `v-for` 生效。

# 高级

## 高级技巧

- 多用Array.includes()
- 提前退出/提前返回。如果不使用，可能有多层if
- 用字面量替代switch,如用obj的属性取值替代switch

**提前退出/提前返回**

```
a({type}={})=>{
 if(!type) return 'no type';
 if(type==='dog') return 'is dog';
 return type
}
```

## 接口权限-路由权限-菜单权限-按钮权限

[控制到按钮级别怎么做？](https://github.com/febobo/web-interview/issues/29)

**接口权限**

接口权限目前一般采用`jwt`的形式来验证，没有通过的话一般返回`401`，跳转到登录页面重新进行登录

登录完拿到`token`，将`token`存起来，通过`axios`请求拦截器进行拦截，每次请求的时候头部携带`token`

**路由权限**

> **方案一**

初始化即挂载全部路由，并且在路由上标记相应的权限信息，每次路由跳转前做校验

缺点：加载所有的路由，菜单信息写死在前端，不易维护，菜单跟路由耦合

> **方案二**

初始化的时候先挂载不需要权限控制的路由，比如登录页，404等错误页。如果用户通过URL进行强制访问，则会直接进入404，相当于从源头上做了控制

登录后，获取用户的权限信息，然后筛选有权限访问的路由，在全局路由守卫里进行调用`addRoutes`添加路由

缺点：全局路由守卫里，每次路由跳转都要做判断；菜单跟路由耦合

**菜单权限**

菜单权限可以理解成将页面与理由进行解耦

> **方案一**

菜单与路由分离，菜单由后端返回.

缺点:菜单需要与路由做一一对应，前端添加了新功能

>方案二

菜单和路由都由后端返回.

缺点：全局路由守卫里，每次路由跳转都要做判断。前后端的配合要求高

**按钮权限**

> **方案一**

按钮权限也可以用`v-if`判断

但是如果页面过多，每个页面页面都要获取用户权限`role`和路由表里的`meta.btnPermissions`，然后再做判断

这种方式就不展开举例了

> **方案二**

通过自定义指令进行按钮权限的判断

**参考文献**

- https://mp.weixin.qq.com/s/b-D2eH1mLwL_FkaZwjueSw
- https://segmentfault.com/a/1190000020887109
- https://juejin.cn/post/6844903648057622536#heading-6

## vuecli 定制化模板

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

## 实现防抖截流函数

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

## vue-router动态路由

**动态路由的 2 种方案**

1. 前端将全部路由规定好，登录时根据用户角色权限来动态展示路由；
2. 路由存储在数据库中，前端通过接口获取当前用户对应路由列表并进行渲染；

**实战-大致思路**

> - 若未登录，跳转至登录页面
> - 若已经登录，判断是否已获取路由列表
>   - 若未获取，从后端获取、解析并保存到 `Vuex` 中
>   - 若已获取，跳转至目标页面

**实战-路由列表解析**

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

**常见问题**

**1.页面卡在登录页面而且不断刷新**

主要原因是把两种未登录的状态混在一起判断

**2.动态路由刷新后 404**

是因为在创建「基本静态路由」的时候回把 404 页面的路由也加入在里面，从而导致页面加载初期动态路由还没有加入到路由实例中，匹配范围最广的 404 页面就会跳出来。解决方法就是将 404 页面的路由也加入到动态路由中。

## vuex

Vuex**集中式**存储管理应用的所有组件的状态，规定所有的数据操作必须通过 `action -> mutation -> state(响应式数据)` ->update view

<img src="/img/image-20220529182549936.png" alt="image-20220529182549936" style="zoom:67%;" />

**核心模块：**

> State：定义了应用状态的数据结构，可以在这里设置默认的初始状态。
>
> Getter：允许组件从 Store 中获取数据，mapGetters 辅助函数仅仅是将 store 中的 getter 映射到局部计算属性。
>
> Mutation：是唯一更改 store 中状态的方法，且必须是同步函数。
>
> Action：用于提交 mutation，而不是直接变更状态，可以包含任意异步操作。
>
> Module：允许将单一的 Store 拆分为多个 store 且同时保存在单一的状态树中。

**vuex 的组成**

<img src="/img/image-20220530070800925.png" alt="image-20220530070800925" style="zoom:50%;" />

**为什么 Vuex 的 mutation 中不能做异步操作？**

- Vuex中所有的状态更新的唯一途径都是mutation，异步操作通过 Action 来提交 mutation实现，这样使得我们可以方便地跟踪每一个状态的变化，从而让我们能够实现一些工具帮助我们更好地了解我们的应用。
- 每个mutation执行完成后都会对应到一个新的状态变更，这样devtools就可以打个快照存下来，然后就可以实现 time-travel 了。如果mutation支持异步操作，就没有办法知道状态是何时更新的，无法很好的进行状态的追踪，给调试带来困难。

**为什么不直接分发mutation,而要通过分发action之后提交 mutation变更状态**

- mutation 必须同步执行，我们可以在 action 内部执行异步操作
- 可以进行一系列的异步操作，并且通过提交 mutation 来记录 action 产生的副作用（即状态变更）

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

自定义实现一个 Vuex

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

## 事件总线EventBus 发布订阅

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

## nodeJS 手写 mock 数据服务器

**前言**

- koa 基本使用
- koa-router 的基本用法
- koa-logger 的使用
- glob 支持文件遍历查寻
- node 几个核心 api 的使用
- 使用 nodemon 做自动重启

**核心代码**

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
