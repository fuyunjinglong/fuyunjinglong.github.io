---
title: Vue2.0_入门
date: 2022-04-17 06:33:16
categories:
  - D_框架和类库
toc: true # 是否启用内容索引
---

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

**修饰符**

- lazy：改变输入框的值时value不会改变，当光标离开输入框时，v-model绑定的value才会改变
- trim：给v-model绑定值的首尾空格过滤掉
- number：将值转成数字。对于先输入数字，只取前面数字部分。对于先输入字母，则无效
- stop：阻止冒泡
- capture：事件默认是往外冒泡，capture表示反过来，由外往内捕获
- self：只有点击事件绑定的本身才会触发事件
- once：事件只执行一次
- prevent：阻止默认事件，如a标签的跳转
- native：加在自定义组件上，保证事件能执行
- sync：父子传值，子组件想更新值

**指令**

- v-html：更新innerHtml
- v-text：更新textContent
- v-bind：绑定变量属性
- v-once：只渲染一次
- v-if/v-for/v-show等

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
