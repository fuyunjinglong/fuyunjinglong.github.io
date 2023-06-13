---
title: 项目经验
date: 2021-11-08 06:33:16
categories:
- Z_业务和面经
toc: true # 是否启用内容索引
---

# 项目实战

搜索github上优秀的javascript 项目

项目可以是商城、SCRM 系统、OA 系统、物流系统、ERP 系统、CMS 系统、HIS 系统、支付系统、IM 聊天、微信公众号、微信小程序等等。

# 项目难点

## Vue2的CSP安全策略-202301

**总结**：因为看了Vue3的源码，基于Vue.js 3.0 的编译过程，发现它在离线编译的时候也会把结果编译成带前缀的，核心代码借过来，然后再做一些修改来支持自己特定的一些 feature，这个难题就被我解决了。

**背景**：今年1月份，在我们的 Web 项目中开启了 CSP 安全策略，其中把 `unsafe-eval` 从 `script-src` 中拿掉了，但是这么操作导致了一个很严重的问题，由于运行在 Web 的项目有一部分组件是通过 Vue.js 开发的，这部分代码全部不能正常工作了。

**问题**：目前老项目是直接通过 CDN 的方式引入 Vue.js，并在后端的 Java 模板中写组件的 template，然后用在运行时编译模板。我们知道编译的过程最后是生成一段 code 字符串，然后通过 `new Function` 的方式转成 render 函数，但是 CSP 安全策略开启后，`new Function` 和 `eval` 都被禁用了，导致整个编译后的流程不能进行下去。

**解决**：

- 使用 runtime-only 版本的 Vue.js，涉及大量使用vue.js的页面，成本高，短期实现不了
- 开发一个CSP 兼容版本的 Vue.js，但是到了 Vue.js 2.x 后，官方就不再提供 CSP 兼容版本了，因为从官方的视角看，我都提供了 runtime-only 版本的解决方案了，完全没必要提供 CSP 兼容版本了。

现阶段最小成本解决问题的方式就是使用一个 CSP 兼容版本的 Vue.js，所以只能魔改 Vue.js 了。

**一、new Function替换为notevil库** 

> `new Function` 不能用了，那么生成的 code 字符串如何执行呢？经过调研，我选用了 notevil 这个库。
>
> 它其实就是用 JavaScript 去实现 JavsScript 的解析引擎，大致原理是先把源码解析成 AST 树，再去遍历 AST 树，对不同类型的节点做不同的处理，达到最终执行 JavaScript 代码的目的。
>
> 但 notevil 的实现还是不够完整，致命的是对 `with` 的语法不支持。还如一些 ES6 的语法，像箭头函数、数组对象的解构赋值，是不支持的

Vue.js 2.x 组件模板最终编译的代码，是使用 `with` 语法做了一层包装：

```
<div>  
  {{ message }}
</div>
编译后：
with(this){return _c('div',[_v(_s(message))])}
```

Vue.js 为了让用户使用方便，在模板中访问数据不用手动加 `this`。Vue自己将this定义在组件实例上。

如果不用 `with(this)` 的话，我们需要生成如下的代码：

```
function(_ctx) {
  return _ctx._c('div,[_ctx._v(_ctx._s(_ctx.message))])
}
```

我们定义一个函数，接受一个 `_ctx` 参数，这个 `_ctx` 在运行时就是组件传入的实例对象 `this`。

这个时候，你可能会说，这有何难的，我们给所有的变量和函数的对象前面加上 `_ctx` 前缀不就可以了吗，但事情并没有你想的那么简单。**尤其对于复杂的表达式。**

**二、该加this的添加this**

Vue.js 2.x 的编译会经过三个过程：template 解析生成 AST ——> AST 优化 ——> AST 生成 code。我的思路是不改变这三个过程，最后追加一个转换生成的 code的过程。

具体思路：先把转换前的代码解析生成 AST，再去遍历这颗 AST，根据语法在相关的位置上加上前缀（修改 AST 的 节点），最后再把修改后的 AST 转换成代码。

- recast 库完成了code → AST 和 AST → code
- estree-walker 库去遍历 AST 的节点，通过一系列判断条件去判断这个节点需不需要加前缀

> 注意：
>
> 1.函数的参数不能加前缀，局部变量不能加前缀，全局内置变量不能加前缀，已经加过前缀的节点不能加前缀等。
>
> 2.函数嵌套函数，存在闭包情况。需要设计一个堆栈的数据结构，在函数进入入栈，函数退出出栈，如果是外层函数中定义的变量，内部函数是不能加前缀的。
>
> 3.recast、estree-walker 原本都是在 node.js 端跑的，为了让它们在前端运行，我也分别 clone 了它们的代码， 用 rollup 对它们做打包，并删除了内部一些 node only 的代码和一定程度的魔改，最终编译出一份在 web 端跑的代码，放到了 lib 目录。

为什么 Vue.js 编译生成的代码需要用 `with` 包一层？

缺点： 在 ECMAScript 5 的严格模式中是被禁用的。优点：利用 `with` 的特性动去指定的对象中查找即可，完全不用做多余的转换，也不用引入这些 AST 解析库了，因为引入这些库(recast,estree-walker)要让 Vue.js 最终打包的体积大了约四倍。

题外话

> 我们平时经常会强调技术选型的能力，其实技术选型的一个标准，就是你选择的第三方依赖，你能不能 hold 住。首先是你知道它的职责边界，知道它能做什么不能做什么，怎么利用它帮助你开发需求；其次是出了错你能不能快速定位到原因，知道是依赖的问题还是自身使用的问题；最后就是当它不能满足你的需求，并且官方不愿意解决或者不维护的情况下，你能不能去 fork 这个库，自己开发解决并实现。那么显然拥有这些能力就需要你对它的源码实现非常了解，所以这也是一些高阶岗位为什么会在面试中考察你对技术原理掌握的一方面原因

## 盈利测算轮询接口内存泄漏-20220506

盈利测算轮询接口，发现有些大数据量场景下，页面出现卡顿，使用chrome memory打印内存快照，发现发起测算后内存使用率比较高。

(1)内存泄露原因
JS和DOM垃圾回收是两套机制，增加了回收难度。
JS对象使用标记清除；DOM对象使用引用计数。其中DOM的引用计数在循环引用场景下，结合闭包容易造成内存泄露。
(2)引发内存泄露
(2.1)使用完毕对象后，没有主动销毁
(2.2)循环引用
DOM对象和Javascript对象循环引用
function leakTest(){
let x=nee Object();
x.obj=document.createElement('div');
x.obj.jsobj=x;
}
(3)分析内存泄露工具
chrome的memory内存快照工具

(4)避免内存泄露
(4.1)创建dom或大数组后，也要对应删除dom，数组
(4.2)事件监听
页面组件销毁时，要解绑事件监听，能解决90%的内存泄露
(4.3)禁止使用console.log打印大量数据，setInterval启动定时器后必要时销毁，尽量避免使用iframe。

## nginx安全组策略配置错误引起的性能问题-20220108

问题：用户反馈系统时不时出现响应慢的问题，查询产品列表接口，经常出现一次5秒的转圈，影响用户体验
**定位：**

(1)微服务接口分析，f12查看接口比对tomcat后台日志，时间基本吻合，排除微服务本身问题；

(2)nginx路由分析，登录深圳region的两台nginx，打印耗时也只有255ms;

(3)域名服务器，东莞部署的域名服务器，终于找到5s耗时，大胆推测是因为某种机制导致额外耗时，要么流控，要么失败重试。首先排查流控，流量访问量较低，远远没有达到流控的阈值-qps50。5s有可能是重试机制的请求间隔时间。

(4)顺着重试的机制可能性，对比正常日志，分析两者差异，发现有5s间隔时间，本来想找504网关超时，但没找到，后来发现，nginx根本没进去。最后发现另外一台nginx访问不通。后来发现其他域名能正常访问这台ip89结尾的nginx服务器，排除防火墙问题，对比nginx配置，也一样，联想到504日志也没有，请求进入nginx前就被拒了，最后怀疑是云服务的安全组策略问题。ip以89结尾的nginx服务器缺少routerservice-front-sg策略
**解决与反思：**

添加安全组策略。

(1)因为更换了域名，该问题一直以性能问题暴露，没及时处理，主要是历史原因，性能一直不高，潜意识里已经默认接受，没有引起关注(2)从正常思维来考虑，性能问题大多数出现在微服务自身，有可能之前有人发现过，但又不了了之。

**改进：**

(1)增加系统告警策略，当域名请求异常时，增加短信电话通知关系人(2)动员团队成员学习问题排除流程，加快问题定位。

## 前端渲染10w数据-20230604

### 前置工作

**后端模拟服务**

新建一个`server.js`文件，简单起个服务，并返回给前端`10w`条数据，并通过`nodemon server.js`开启服务

> 没有安装`nodemon`的同学可以先全局安装`npm i nodemon -g`

```
// server.js

const http = require('http')
const port = 8000;

http.createServer(function (req, res) {
  // 开启Cors
  res.writeHead(200, {
    //设置允许跨域的域名，也可设置*允许所有域名
    'Access-Control-Allow-Origin': '*',
    //跨域允许的请求方法，也可设置*允许所有方法
    "Access-Control-Allow-Methods": "DELETE,PUT,POST,GET,OPTIONS",
    //允许的header类型
    'Access-Control-Allow-Headers': 'Content-Type'
  })
  let list = []
  let num = 0

  // 生成10万条数据的list
  for (let i = 0; i < 100000; i++) {
    num++
    list.push({
      src: 'https://p3-passport.byteacctimg.com/img/user-avatar/d71c38d1682c543b33f8d716b3b734ca~300x300.image',
      text: `我是${num}号嘉宾林三心`,
      tid: num
    })
  }
  res.end(JSON.stringify(list));
}).listen(port, function () {
  console.log('server is listening on port ' + port);
})
```

**前端页面**

```
// index.html
<style>
    * {
      padding: 0;
      margin: 0;
    }
    #container {
      height: 100vh;
      overflow: auto;
    }
    .sunshine {
      display: flex;
      padding: 10px;
    }
    img {
      width: 150px;
      height: 150px;
    }
  </style>

// html部分
<body>
  <div id="container">
  </div>
  <script src="./index.js"></script>
</body>
```

```
// index.js
// 请求函数
const getList = () => {
    return new Promise((resolve, reject) => {
        //步骤一:创建异步对象
        var ajax = new XMLHttpRequest();
        //步骤二:设置请求的url参数,参数一是请求的类型,参数二是请求的url,可以带参数
        ajax.open('get', 'http://127.0.0.1:8000');
        //步骤三:发送请求
        ajax.send();
        //步骤四:注册事件 onreadystatechange 状态改变就会调用
        ajax.onreadystatechange = function () {
            if (ajax.readyState == 4 && ajax.status == 200) {
                //步骤五 如果能够进到这个判断 说明 数据 完美的回来了,并且请求的页面是存在的
                resolve(JSON.parse(ajax.responseText))
            }
        }
    })
}

// 获取container对象
const container = document.getElementById('container')
```

### 方案1:直接渲染

一次性渲染出`10w`个节点,耗时12s。

```
const renderList = async () => {
    console.time('列表时间')
    const list = await getList()
    list.forEach(item => {
        const div = document.createElement('div')
        div.className = 'sunshine'
        div.innerHTML = `<img src="${item.src}" /><span>${item.text}</span>`
        container.appendChild(div)
    })
    console.timeEnd('列表时间')
}
renderList()
```

### 方案2:setTimeout分页渲染

把`10w`按照每页数量`limit`分成总共`Math.ceil(total / limit)`页，然后利用`setTimeout`，每次渲染1页数据，这样的话，渲染出首页数据的时间大大缩减了。

```
const renderList = async () => {
    console.time('列表时间')
    const list = await getList()
    console.log(list)
    const total = list.length
    const page = 0
    const limit = 200
    const totalPage = Math.ceil(total / limit)

    const render = (page) => {
        if (page >= totalPage) return
        setTimeout(() => {
            for (let i = page * limit; i < page * limit + limit; i++) {
                const item = list[i]
                const div = document.createElement('div')
                div.className = 'sunshine'
                div.innerHTML = `<img src="${item.src}" /><span>${item.text}</span>`
                container.appendChild(div)
            }
            render(page + 1)
        }, 0)
    }
    render(page)
    console.timeEnd('列表时间')
}
```

### 方案3:requestAnimationFrame

使用`requestAnimationFrame`代替`setTimeout`，减少了`重排`的次数，极大提高了性能，建议大家在渲染方面多使用`requestAnimationFrame`。

```
const renderList = async () => {
    console.time('列表时间')
    const list = await getList()
    console.log(list)
    const total = list.length
    const page = 0
    const limit = 200
    const totalPage = Math.ceil(total / limit)

    const render = (page) => {
        if (page >= totalPage) return
        // 使用requestAnimationFrame代替setTimeout
        requestAnimationFrame(() => {
            for (let i = page * limit; i < page * limit + limit; i++) {
                const item = list[i]
                const div = document.createElement('div')
                div.className = 'sunshine'
                div.innerHTML = `<img src="${item.src}" /><span>${item.text}</span>`
                container.appendChild(div)
            }
            render(page + 1)
        })
    }
    render(page)
    console.timeEnd('列表时间')
}
```

### 方案4:fragment文档碎片 + requestAnimationFrame

优点

> 1、之前都是每次创建一个`div`标签就`appendChild`一次，但是有了`文档碎片`可以先把1页的`div`标签先放进`文档碎片`中，然后一次性`appendChild`到`container`中，这样减少了`appendChild`的次数，极大提高了性能
>
> 2、页面只会渲染`文档碎片`包裹着的元素，而不会渲染`文档碎片`

```
const renderList = async () => {
    console.time('列表时间')
    const list = await getList()
    console.log(list)
    const total = list.length
    const page = 0
    const limit = 200
    const totalPage = Math.ceil(total / limit)

    const render = (page) => {
        if (page >= totalPage) return
        requestAnimationFrame(() => {
            // 创建一个文档碎片
            const fragment = document.createDocumentFragment()
            for (let i = page * limit; i < page * limit + limit; i++) {
                const item = list[i]
                const div = document.createElement('div')
                div.className = 'sunshine'
                div.innerHTML = `<img src="${item.src}" /><span>${item.text}</span>`
                // 先塞进文档碎片
                fragment.appendChild(div)
            }
            // 一次性appendChild
            container.appendChild(fragment)
            render(page + 1)
        })
    }
    render(page)
    console.timeEnd('列表时间')
}
```

### 方案5:懒加载

原理

> 在列表尾部放一个空节点`blank`，然后先渲染第1页数据，向上滚动，等到`blank`出现在视图中，就说明到底了，这时候再加载第二页，往后以此类推。
>
> 至于怎么判断`blank`出现在视图上，可以使用`getBoundingClientRect`方法获取`top`属性。
>
> 其中`IntersectionObserver` 性能更好，但是我这里就拿`getBoundingClientRect`来举例

<img src="/img/image-20230614065329214.png" alt="image-20230614065329214" style="zoom:70%;" />

```vue
<script setup lang="ts">
import { onMounted, ref, computed } from 'vue'
const getList = () => {
  // 跟上面一样的代码
}

const container = ref<HTMLElement>() // container节点
const blank = ref<HTMLElement>() // blank节点
const list = ref<any>([]) // 列表
const page = ref(1) // 当前页数
const limit = 200 // 一页展示
// 最大页数
const maxPage = computed(() => Math.ceil(list.value.length / limit))
// 真实展示的列表
const showList = computed(() => list.value.slice(0, page.value * limit))
const handleScroll = () => {
  // 当前页数与最大页数的比较
  if (page.value > maxPage.value) return
  const clientHeight = container.value?.clientHeight
  const blankTop = blank.value?.getBoundingClientRect().top
  if (clientHeight === blankTop) {
    // blank出现在视图，则当前页数加1
    page.value++
  }
}

onMounted(async () => {
  const res = await getList()
  list.value = res
})
</script>

<template>
  <div id="container" @scroll="handleScroll" ref="container">
    <div class="sunshine" v-for="(item) in showList" :key="item.tid">
      <img :src="item.src" />
      <span>{{ item.text }}</span>
    </div>
    <div ref="blank"></div>
  </div>
</template>
```

### 方案6:虚拟列表

参考

- [「前端进阶」高性能渲染十万条数据(虚拟列表)](https://juejin.cn/post/6844903982742110216#heading-4)

原理

> 虚拟滚动，就是根据`容器可视区域`的`列表容积数量`，监听用户滑动或滚动事件，动态截取`长列表数据`中的`部分数据`渲染到页面上，动态使用空白站位填充容器`上下滚动区域内容`，模拟实现`原生滚动效果`。总结一句话：使用绝对定位和滚动监听实现。

<img src="/img/image-20230614065430330.png" alt="image-20230614065430330" style="zoom:80%;" />

> - 浏览器渲染===康熙选秀：一次性渲染10000个肯定会使浏览器压力大，造成用户体验差
> - 容器可视区域===选秀大殿：10000个排队去渲染，比如一次渲染10个
> - 上方下方区域===左右偏殿：轮不到你渲染，你就乖乖进空白区待着

**基本实现过程**

> - 步骤1:计算列表总高度listHeight和可视区域高度screenHeight
> - 步骤2:根据可视区域高度计算可显示的列表项数visibleCount
> - 步骤3:在滚动时，重新计算起始索引start和结束索引end，核心滚动偏移量startOffset。

**固定高度代码**

```vue
<VirtualList :listData="d" :itemSize="100" />
let d = ref([]);
for (let i = 0; i < 1000; i++) {
  d.value.push({ id: i, value: i });
}
                         
// VirtualList.vue                       
<template>
  <div ref="list" class="infinite-list-container" @scroll="scrollEvent($event)">
    <div class="infinite-list-phantom" :style="{ height: listHeight + 'px' }"></div>
    <div class="infinite-list" :style="{ transform: getTransform }">
      <div ref="items" class="infinite-list-item" v-for="item in visibleData" :key="item.id" :style="{ height: itemSize + 'px', lineHeight: itemSize + 'px' }">{{ item.value }}</div>
    </div>
  </div>
</template>
<script>
export default {
  name: 'VirtualList',
  props: {
    //所有列表数据
    listData: {
      type: Array,
      default: () => [],
    },
    //每项高度
    itemSize: {
      type: Number,
      default: 200,
    },
  },
  data() {
    return {
      //可视区域高度
      screenHeight: 0,
      //核心滚动偏移量
      startOffset: 0,
      //起始索引
      start: 0,
      //结束索引
      end: null,
    };
  },
  computed: {
    //列表总高度
    listHeight() {
      return this.listData.length * this.itemSize;
    },
    //可显示的列表项数
    visibleCount() {
      return Math.ceil(this.screenHeight / this.itemSize);
    },
    //偏移量对应的style
    getTransform() {
      return `translate3d(0,${this.startOffset}px,0)`;
    },
    //获取真实显示列表数据
    visibleData() {
      return this.listData.slice(this.start, Math.min(this.end, this.listData.length));
    },
  },
  mounted() {
    this.screenHeight = this.$el.clientHeight;
    this.start = 0;
    this.end = this.start + this.visibleCount;
  },
  methods: {
    scrollEvent() {
      //当前滚动位置
      let scrollTop = this.$refs.list.scrollTop;
      //此时的开始索引
      this.start = Math.floor(scrollTop / this.itemSize);
      //此时的结束索引
      this.end = this.start + this.visibleCount;
      //此时的偏移量
      this.startOffset = scrollTop - (scrollTop % this.itemSize);
    },
  },
};
</script>
<style scoped>
.infinite-list-container {
  height: 100%;
  overflow: auto;
  position: relative;
  -webkit-overflow-scrolling: touch;
}
.infinite-list-phantom {
  position: absolute;
  left: 0;
  top: 0;
  right: 0;
  z-index: -1;
}
.infinite-list {
  left: 0;
  right: 0;
  top: 0;
  position: absolute;
  text-align: center;
}
.infinite-list-item {
  padding: 10px;
  color: #555;
  box-sizing: border-box;
  border-bottom: 1px solid #999;
}
</style>
```

html元素

- `infinite-list-container` 为`可视区域`的容器
- `infinite-list-phantom` 为容器内的占位，高度为总列表高度，用于形成滚动条
- `infinite-list` 为列表项的`渲染区域`

参数

- 假定`可视区域`高度固定，称之为`screenHeight`
- 假定`列表每项`高度固定，称之为`itemSize`
- 假定`列表数据`称之为`listData`
- 假定`当前滚动位置`称之为`scrollTop`

则可推算出：

- 列表总高度`listHeight` = listData.length * itemSize
- 可显示的列表项数`visibleCount` = Math.ceil(screenHeight / itemSize)
- 数据的起始索引`startIndex` = Math.floor(scrollTop / itemSize)
- 数据的结束索引`endIndex` = startIndex + visibleCount
- 列表显示数据为`visibleData` = listData.slice(startIndex,endIndex)

**重要参数**

当滚动后，由于`渲染区域`相对于`可视区域`已经发生了偏移，此时我需要获取一个偏移量`startOffset`，通过样式控制将`渲染区域`偏移至`可视区域`中。

> 滚动偏移量`startOffset` = scrollTop - (scrollTop % itemSize);

为什么不写成this.startOffset = scrollTop？

> 通俗理解：如果写成这个，数据都是固定跳变，没有滚动的动画变化效果。
>
> 具体解释：
>
> 比如说，列表第0项，高度100px，你现在滚动条滚动了50px，期望的效果必然是第0项，一半在屏幕外，一半在屏幕内，此时是没有偏移量的，完全由滚动条来控制页面显示内容。此时又发生了滚动，滚动到了100px，此时我们期望的的：可视区域已经没有第0项了，变成第1项。由于我们是虚拟列表，所以第0项的dom发生了修改变成了第1项的dom，第一项的dom变成了第2项dom，如果没有偏移量，可视区域的第一条内容就变成了第2项，所以我们需要修改偏移量，让列表像下偏移100px，将第1项的dom显示出来。
>
> 没有达到换一个item的时候就设置没有偏移量 这个scrollTop - (scrollTop % this.itemSize)就是没达到一个itemSize的时候就是多余的减掉多余的变成o这个内容会被浏览器带着走 就会看到动画 如果你有设置等于scrollTop的话 你浏览器滚动了 那你偏移量和scrollTop一样的话 相当于没有动画 和浏览器同步走了 然后到了换数据item1变成item2的时候就会突然给你换掉 就没有动画了 这样写就让浏览器带着走有动画

**列表项动态高度代码**

对于不是固定高度的列表，上述方案就不能解决这个问题。

目前虚拟列表动态高度的解决方案有3种：

- 方案1:包含所有列表项高度的数据，如 [50, 20, 100, 80, ...]
- 方案2:将列表项`渲染到屏幕外`，对其高度进行测量并缓存，然后再将其渲染至可视区域内。
- 方案3:以`预估高度`先行渲染，然后获取真实高度并缓存。

> - 方案1虽然灵活，但需要事先知道高度，无法解决列表项高度由内容撑开的情况
> - 方案2:由于预先渲染至屏幕外，再渲染至屏幕内，这导致渲染成本增加一倍，这对于数百万用户在低端移动设备上使用的产品来说是不切实际的。
> - 方案3:可以解决前面2种方案的缺陷

实现过程

- 定义组件属性`estimatedItemSize`,用于接收`预估高度`
- 定义`positions`，用于列表项渲染后存储`每一项的高度以及位置`信息
- `列表高度`实际就等于列表中最后一项的底部距离列表顶部的位置。

完整代码

```vue
<VirtualList :listData="data" :estimatedItemSize="100" />
  import faker from "faker";
let data = [];
for (let id = 0; id < 1000; id++) {
  data.push({
    id,
    value: faker.lorem.sentences() // 长文本
  });
}
                           
// VirtualList.vue
<template>
  <div ref="list" :style="{ height }" class="infinite-list-container" @scroll="scrollEvent($event)">
    <div ref="phantom" class="infinite-list-phantom"></div>
    <div ref="content" class="infinite-list">
      <div class="infinite-list-item" ref="items" :id="item._index" :key="item._index" v-for="item in visibleData">
        <p>
          <span style="color: red">{{ item.id }}</span>
          {{ item.value }}
        </p>
      </div>
    </div>
  </div>
</template>
<script>
export default {
  props: {
    //所有列表数据
    listData: {
      type: Array,
      default: () => [],
    },
    //预估高度
    estimatedItemSize: {
      type: Number,
      required: true,
    },
    //容器高度 100px or 50vh
    height: {
      type: String,
      default: '100%',
    },
  },
  data() {
    return {
      //可视区域高度
      screenHeight: 0,
      //起始索引
      start: 0,
      //结束索引
      end: 0,
    };
  },
  computed: {
    _listData() {
      return this.listData.map((item, index) => {
        return {
          _index: `_${index}`,
          item,
        };
      });
    },
    visibleCount() {
      return Math.ceil(this.screenHeight / this.estimatedItemSize);
    },
    visibleData() {
      return this._listData.slice(this.start, this.end);
    },
  },
  created() {
    this.initPositions();
  },
  mounted() {
    this.screenHeight = this.$el.clientHeight;
    this.start = 0;
    this.end = this.start + this.visibleCount;
  },
  updated() {
    this.$nextTick(function () {
      if (!this.$refs.items || !this.$refs.items.length) {
        return;
      }
      //获取真实元素大小，修改对应的尺寸缓存
      this.updateItemsSize();
      //更新列表总高度
      let height = this.positions[this.positions.length - 1].bottom;
      this.$refs.phantom.style.height = height + 'px';
      //更新真实偏移量
      this.setStartOffset();
    });
  },
  methods: {
    initPositions() {
      this.positions = this.listData.map((d, index) => ({
        index,
        height: this.estimatedItemSize,
        top: index * this.estimatedItemSize,
        bottom: (index + 1) * this.estimatedItemSize,
      }));
    },
    //获取列表起始索引
    getStartIndex(scrollTop = 0) {
      //二分法查找
      return this.binarySearch(this.positions, scrollTop);
    },
    //二分法查找
    binarySearch(list, value) {
      let start = 0;
      let end = list.length - 1;
      let tempIndex = null;
      while (start <= end) {
        let midIndex = parseInt((start + end) / 2);
        let midValue = list[midIndex].bottom;
        if (midValue === value) {
          return midIndex + 1;
        } else if (midValue < value) {
          start = midIndex + 1;
        } else if (midValue > value) {
          if (tempIndex === null || tempIndex > midIndex) {
            tempIndex = midIndex;
          }
          end = end - 1;
        }
      }
      return tempIndex;
    },
    //获取列表项的当前尺寸
    updateItemsSize() {
      let nodes = this.$refs.items;
      nodes.forEach((node) => {
        let rect = node.getBoundingClientRect();
        let height = rect.height;
        let index = +node.id.slice(1);
        let oldHeight = this.positions[index].height;
        let dValue = oldHeight - height;
        //存在差值
        if (dValue) {
          this.positions[index].bottom = this.positions[index].bottom - dValue;
          this.positions[index].height = height;

          for (let k = index + 1; k < this.positions.length; k++) {
            this.positions[k].top = this.positions[k - 1].bottom;
            this.positions[k].bottom = this.positions[k].bottom - dValue;
          }
        }
      });
    },
    //获取当前的偏移量
    setStartOffset() {
      let startOffset = this.start >= 1 ? this.positions[this.start - 1].bottom : 0;
      this.$refs.content.style.transform = `translate3d(0,${startOffset}px,0)`;
    },
    //滚动事件
    scrollEvent() {
      //当前滚动位置
      let scrollTop = this.$refs.list.scrollTop;
      //此时的开始索引
      this.start = this.getStartIndex(scrollTop);
      //此时的结束索引
      this.end = this.start + this.visibleCount;
      //此时的偏移量
      this.setStartOffset();
    },
  },
};
</script>
<style scoped>
.infinite-list-container {
  overflow: auto;
  position: relative;
  -webkit-overflow-scrolling: touch;
}
.infinite-list-phantom {
  position: absolute;
  left: 0;
  top: 0;
  right: 0;
  z-index: -1;
}
.infinite-list {
  left: 0;
  right: 0;
  top: 0;
  position: absolute;
}
.infinite-list-item {
  padding: 5px;
  color: #555;
  box-sizing: border-box;
  border-bottom: 1px solid #999;
  /* height:200px; */
}
</style>
```

**不足与改进**

- 监听scroll事件，会频繁触发，重复计算，性能上浪费，可使用[IntersectionObserver](https://link.juejin.cn/?target=https%3A%2F%2Fdeveloper.mozilla.org%2Fzh-CN%2Fdocs%2FWeb%2FAPI%2FIntersectionObserver)替换监听scroll事件
- 动态高度下的虚拟列表，如果是图片，可能由于网络请求加载时机导致高度不准确，如果我们能监听列表项的大小变化就能获取其真正的高度了。我们可以使用[ResizeObserver](https://link.juejin.cn/?target=https%3A%2F%2Fdeveloper.mozilla.org%2Fzh-CN%2Fdocs%2FWeb%2FAPI%2FResizeObserver)来监听列表项内容区域的高度改变，从而实时获取每一列表项的高度。

### 方案7:第三方库

- [vue-virtual-scroller](https://link.juejin.cn?target=https%3A%2F%2Fgithub.com%2FAkryum%2Fvue-virtual-scroller): 这是一个基于 Vue 3 的虚拟滚动列表组件，可以用于大型数据集的渲染。它支持水平和垂直方向的滚动，并且具有无限滚动、缓存、动态高度等功能。
- [vue3-virtual-scroll-list](https://link.juejin.cn?target=https%3A%2F%2Fgithub.com%2Fzuolei828%2Fvue3-virtual-scroll-list): 这是一个支持垂直方向的无限滚动列表组件，可以用于渲染大量数据。它支持异步加载、滚动到指定位置、动态高度等功能。
- [vue3-infinite-scroll](https://link.juejin.cn?target=https%3A%2F%2Fgithub.com%2FDevTony101%2Fvue3-infinite-scroll): 这是一个支持无限滚动的 Vue 3 组件，可以用于渲染大量数据。它支持异步加载、滚动到指定位置、动态高度等功能。
- [vue-lazy-render](https://link.juejin.cn?target=https%3A%2F%2Fgithub.com%2Fyeyan1996%2Fvue-lazy-render): 这是一个基于 Vue 3 的懒加载组件，可以用于渲染大量数据。它支持滚动监听、动态高度、动画效果等功能。

# PSP产品选型

基于运营商BG（carrier network business group）产品360平台，在地区部代表处运营商不同区域下，按照不同产品线无限数通光划分，对不同产品按照不同维度进行量化分析。其中包括射频bbu主控基带天线等购物车功能，以图表结合的形式分析其商务盈利、现网存量，对产品进行规格、特性、策略多维度数据对比展示。

**职位描述**
1.负责组件库与业务页面开发。
2.带领团队完成技术产品实现。
3.负责大型多应用架构设计。
4.利用前端技术与服务端协同完成团队业务目标。

**职位要求**
0.掌握图形学，webgl或熟练使用threejs框架，熟练canvas相关渲染及动画操作的优先。
1.熟练掌握JavaScript。
2.熟悉常用工程化工具，掌握模块化思想和技术实现方案。
3.熟练掌握React前端框架，了解技术底层。同时了解vue以及angular等其他框架者优先。
4.熟练掌握react生态常用工具，redux/react-router等。
5.熟悉各种Web前端技术，包括HTML/XML/CSS等，有基于Ajax的前端应用开发经验。
6.有良好的编码习惯，对前端技术有持续的热情，个性乐观开朗,逻辑性强，善于和各种背景的人合作。
7.具有TS/移动设备上前端开发/NodeJS/服务端开发等经验者优先。

# 项目中遇到比较棘手的问题

## 1.项目的架构设计

从0-1开始项目，前期规划，整个项目框架结构，工程化、模块化、组件化，哪些需要抽取。

## 2.复杂的业务场景

- 复杂的数据结构处理
- 性能优化
- 兼容性问题
- 团队协作冲突问题

# **接单项目**

1.接单网站

猿急送：按需雇佣互联网坐班兼职工程师

外包大师：快速发布外包项目，以高质量为驱动

开源众包：为客户提供解决方案

英选：可信赖的软件外包服务

人人开发：让管理软件更简单

我爱方案网：

智筹：牛人为我所用

开发邦：服务众多客户

码市：互联网软件外包服务平台

自由职客：

解放号：数字化平台

程序员客栈：云端开发团队

任务栈：

猪八戒：

一品威客：

SXSOFT:众包模式

智诚Taskcity:零交易佣金

码易：

yespmp:

云沃克：

实现网：

电鸭社区：
