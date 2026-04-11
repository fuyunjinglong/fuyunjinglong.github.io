---
title: 项目经验
date: 2021-11-08 06:33:16
categories:
- Z_业务和面经
toc: true # 是否启用内容索引
---

# 开源项目

## 202405-阿崔cxr-打飞机

参考

> - [打飞机-video](https://www.bilibili.com/video/BV1jF411g7hq?spm_id_from=333.788.videopod.sections&vd_source=bd4c7d99d71adf64d6e88c65370e0247)
> - [pixi.js官网](https://pixijs.com/)

项目地址

> https://github.com/fuyunjinglong/view-model-explore

项目简介

> 项目介绍：通过打飞机小游戏，实现UI层和业务逻辑分离层架构分离
>
> 负责内容：整体架构搭建，搭建vue3自定义canvas模型，飞机发射子弹，子弹碰撞敌机逻辑等
>
> 项目难点：采用 Functional Core, Imperative Shell 模式实现逻辑分层，pnpm实现monorepo包管理
>
> 项目成果：UI和业务逻辑分离，方便高效快速单元测试

验证vitest是否安装成果

> 创建文件 app.spec.ts
>
> import { expect, test } from "vitest";
>
> test("", () *=>* {
>
>  expect(true).toBe(true);
>
> });
>
> 在package.json增加*"test"*: "vitest"
>
> 执行pnpm test看是否成功

**准备工作**

> - 创建vue-ts项目   pnpm create vite 
> - 进入根目录安装依赖 pnpm i 
> - 引入vitest  pnpm add -D vitest

**核心流程**

> 1.基于 custom render api 实现把视图渲染到 canvas
>
> - 1.1 引入 init pixi.js
> - 1.2 重写 renderer{({}) 渲染接口
>
> 2.核心游戏逻辑
>
> - 我方飞机
> - 发射子弹
> - 敌军
> - 碰撞检测(子弹和敌军)

1.引入pixi.js

> pnpm i pixi.js  注意6.3.0，高版本可能api有更新

# 项目问题

## Echarts

- [Echarts常见问题及解决方法](https://bbchin.com/archives/echart-cases#%E5%89%8D%E8%A8%80)

**如何处理大量数据渲染**

设置datazoom，类似分页效果

**如何动态适配容器宽高**

window.resize

window.resizeObserver

echart.resize()

**文件超长如何处理**

对formatter显示的文字长度做个截断展示，如a.slice(0,5)+'...'

**切换图表卡顿**

原因：可能内存溢出了

解决：echarts.clear()和echarts.dispose()

> `echarts.clear()`是清空当前实例，会移除实例中所有的组件和图表。类似v-show
>
> `echarts.dispose()`是销毁实例，销毁后实例无法再被使用。类似v-if

## ElelemtUI

**如何实现table组件自定义功能**

开启slot插槽功能

**如何覆盖组件样式**

使用样式穿透,deep

**popover组件二次封装**

自定义虚拟手动触发

```
v-model:visible="isPop"
```

是否将内容插入到body

```
:teleported="false" 
```

**elementplus2.8.2多选移除字符串值，仅支持数组**

参考：https://github.com/element-plus/element-plus/pull/18030/files

**国际化配置**

```
import zhCn from 'element-plus/es/locale/lang/zh-cn';
import en from 'element-plus/es/locale/lang/en';

<el-config-provider :locale="locale"> // zhCn : en
    <router-view v-if="comStore.leaf" />
     <div v-else class="noPermit">
         <span>抱歉，您暂无访问权限！</span>
     </div>
</el-config-provider>
```

**el-table插槽+递归**

父组件

```vue
<el-table
<TableCol v-for="(tTitle, tIndex) in showColumns"
          :key="tIndex + tTitle.colId + isUpdate"
          v-bind="{ tTitle, ...colProps() }"
></TableCol>
</el-table>
```

子组件-TableCol

```vue
<template>
  <el-table-column :prop="tTitle.colId" :label="tTitle[colNameCnEn]">
    <!--一级表头-->
    <template #header="{ row, column, $index }">
      <div>表头</div>
    </template>
    <template v-if="!tTitle.isDirector" #default="{ row, column, $index }">
      <div>表内容</div>
    </template>
     <!--表头递归-->
    <TableCol v-for="(tTitleChild, tIndexChild) in tTitle.children" :key="tIndexChild + tTitleChild.colId" v-bind="{ ...props, tTitle: tTitleChild }"></TableCol>
  </el-table-column>
</template>
<script setup name="TableCol">
const props = defineProps([
  'tTitle'
]);
</script>
```

# 项目难点

## 202101-Vue2的CSP安全策略

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

## 202205-盈利测算轮询接口内存泄漏

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

## 202206-nginx安全组策略配置错误引起的性能问题

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

## 202207-RouterView 配合KeepAilve组件使用后create钩子函数执行两次黄轶

参考

> - https://juejin.cn/post/7016628275074039815#heading-2

版本：’2.0.0-rc.17‘
问题：当在三级菜单下，切换到另外的三级菜单。会出现setup执行两次的情况。
操作步骤：进入基础表格，点击进入基础表单。再次点击进入基础表格，这个时候就会发现，基础表格下的setup就执行了两次，有两次打印输出。其实这个时候，任何一个三级菜单下的页面都会执行两次。

## 202306-前端渲染10w数据

**前置工作**

*后端模拟服务*

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

*前端页面*

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

**方案1:直接渲染**

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

**方案2:setTimeout分页渲染**

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

**方案3:requestAnimationFrame**

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

**方案4:fragment文档碎片 + requestAnimationFrame**

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

**方案5:懒加载**

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

**方案6:虚拟滚动**

参考

- [「前端进阶」高性能渲染十万条数据(虚拟列表)](https://juejin.cn/post/6844903982742110216#heading-4)

本质

> **“只渲染视口里的少量 DOM，用一个‘假的大容器’把滚动条撑到真实尺寸，再用偏移量把真实内容移到该在的位置。”**

核心三步：

> 1. 算出当前“视口区间（startIndex～endIndex）”
> 2. 只拿这段数据去渲染 DOM
> 3. 用 totalHeight + offsetY（translateY/top）让滚动条与位置都看起来像全部都渲染了

实现

> - 外层：viewport有滚动条，固定高度（比如 500px）。
> - 中间：phantom一个“假容器”，高度 = 行数 × 行高（或动态累计），只为了让滚动条正确。
> - 内层：content真正放列表 DOM 的容器，只放“视口+缓冲区”的几条/几十条 DOM。
>
> 1. *关键变量*
>
> - `viewportHeight`：外层可见高度（如 500px）
> - `itemHeight`：固定行高（40px）
> - `scrollTop`：当前滚动距离
> - `totalHeight`：itemHeight × data.length（总高度）
> - `startIndex`：当前视口第一行在原数组中的索引
> - `endIndex`：当前视口最后一行索引
> - `bufferCount`：上下缓冲条数（防止快速滚动时白屏）
> - `offsetY`：内容容器相对视口的垂直偏移（用 `translateY` 实现）
>
> 2. *计算流程（固定行高）*
>
> - `startIndex`：
>   `startIndex = Math.floor(scrollTop / itemHeight)`
> - `endIndex`（含缓冲）：
>   `visibleCount = Math.ceil(viewportHeight / itemHeight)`
>   `endIndex = Math.min(data.length - 1, startIndex + visibleCount + bufferCount)`
> - `offsetY`（内容容器“往下推”多远）：
>   `offsetY = startIndex * itemHeight`
> - `totalHeight`（占位容器的高度）：
>   `totalHeight = data.length * itemHeight`baidu.com
> - 实际要渲染的数据：
>   `visibleData = data.slice(startIndex, endIndex + 1)`
>
> 3. *滚动时发生什么？*
>
> - 监听滚动事件，拿到 `scrollTop`。
> - 用上面的公式算出新的 `startIndex/endIndex/offsetY`。
> - 切片数据：`data.slice(startIndex, endIndex + 1)`。
> - 渲染少量 DOM，用 `translateY(offsetY)` 把内容“推”到正确位置
>
> 4.动态高度
>
> 现实场景中，每行高度不一样（树形表格、富文本、自适应行高）。这时“startIndex = scrollTop / itemHeight” 就不成立了。
>
> 增加positions位置索引 + 缓存高度：
>
> - 第 i 行的顶部位置：`positions[i]`
> - 总高度：`totalHeight = positions[positions.length - 1]`
> - 预估高度estimatedRowHeight：先占坑，后结算。(先按照预估高度50px&个数，等实际选然后，动态修正totalHeigh=预估高度+30即可，这样偏差就不大)
> - startIndex或endIndex等于positions数组的二分查找值
> - offsetY = positions[startIndex]

问题

> 1.缓冲区与“白屏/闪烁”问题?
>
> 快速滚动时，纯“视口内那几行”还不够，滚动一帧就会露出空白区域，所以上下多渲染 `bufferCount` 行（比如各 5 行）
>
> 2.滚动条、滚动位置同步与“滚动跳跃”?
>
> - 滚动条忽长忽短；
> - 拖动滚动条时，内容位置对不上。
>
> 关键totalHeight 要尽量稳定，动态高度时用 `estimatedRowHeight` 去预估未渲染行的高度，避免频繁改写 phantom 的高度。滚动事件要做节流（throttle），避免每一帧都做大量计算。



**方案7:第三方库**

- [vue-virtual-scroller](https://link.juejin.cn?target=https%3A%2F%2Fgithub.com%2FAkryum%2Fvue-virtual-scroller): 这是一个基于 Vue 3 的虚拟滚动列表组件，可以用于大型数据集的渲染。它支持水平和垂直方向的滚动，并且具有无限滚动、缓存、动态高度等功能。
- [vue3-virtual-scroll-list](https://link.juejin.cn?target=https%3A%2F%2Fgithub.com%2Fzuolei828%2Fvue3-virtual-scroll-list): 这是一个支持垂直方向的无限滚动列表组件，可以用于渲染大量数据。它支持异步加载、滚动到指定位置、动态高度等功能。
- [vue3-infinite-scroll](https://link.juejin.cn?target=https%3A%2F%2Fgithub.com%2FDevTony101%2Fvue3-infinite-scroll): 这是一个支持无限滚动的 Vue 3 组件，可以用于渲染大量数据。它支持异步加载、滚动到指定位置、动态高度等功能。
- [vue-lazy-render](https://link.juejin.cn?target=https%3A%2F%2Fgithub.com%2Fyeyan1996%2Fvue-lazy-render): 这是一个基于 Vue 3 的懒加载组件，可以用于渲染大量数据。它支持滚动监听、动态高度、动画效果等功能。



# 项目亮点

## 2026.2-NATA

**FCIS分离模式**

是Functional Core和Imperative Shell(Composables即组合式API也叫Hook)的缩写

| 概念                 | 在 Vue 中的体现                              | 特点                                                 |
| -------------------- | -------------------------------------------- | ---------------------------------------------------- |
| **Functional Core**  | 纯 `.ts/.js` 文件，导出纯函数，有利于单测    | **不引入 Vue**，不用 `ref`, `reactive`, `computed`。 |
| **Imperative Shell** | `<script setup>`、Composables、Pinia Actions | 管理 Vue 响应式状态、调接口、操作路由。挂了          |

> 1. **入参解包，出参包装**：传入core 的数据一定是死物(非响应式)，如果是ref，则传.value。如果是reactive,则传toRaw()。core的返回值，如果是ref，则直接赋值。如果是reactive，则用Object.assign(errors, errorsRes)。如果一定要传入reactive，一定不能直接修改属性值，否则就不是纯函数。
> 2. **Shell只管何时做，Core 只管怎么做**：`watch` 监听到变化、`onMounted` 挂载完毕、用户点击了按钮——这是**何时做**。数据该怎么过滤、规则该怎么算、状态该怎么流转——这是**怎么做**。
> 3. **报错找 Core，挂了找 Shell**

Functional Core (logic/login.core.ts) // 逻辑处理core

```js
export interface LoginFormState {
  username: string
  password: string
  rememberMe: boolean
}
export interface FormErrors {
  username?: string
  password?: string
  general?: string
}

// 纯函数：给定状态，返回错误。不需要知道 UI 长什么样
export function validateLoginForm(form: LoginFormState): FormErrors {
  const errors: FormErrors = {}
  
  if (!form.username.trim()) {
    errors.username = '用户名不能为空'
  } else if (form.username.length < 3) {
    errors.username = '用户名至少3个字符'
  }
  
  if (!form.password) {
    errors.password = '密码不能为空'
  } else if (form.password.length < 6) {
    errors.password = '密码至少6个字符'
  }
  return errors
}
// 纯函数：准备提交给 API 的数据
export function formatLoginPayload(form: LoginFormState) {
  return {
    user: form.username.trim().toLowerCase(),
    pass: form.password,
    keepSignedIn: form.rememberMe
  }
```

Imperative Shell(useLogin.ts)// 响应式处理Shell(Composables即组合式API也叫Hook)

```js
import { ref, reactive,toRaw } from 'vue'
import { validateLoginForm, formatLoginPayload, type LoginFormState } from './login.core.ts'
import { authApi } from '@/api/auth'
import { useRouter } from 'vue-router'

export function useLogin() {
  const router = useRouter()
  // Shell 负责绑定 UI 的状态
  const form = reactive<LoginFormState>({
    username: '',
    password: '',
    rememberMe: false
  })
  
  const errors = reactive<FormErrors>({})
  const isSubmitting = ref(false)

  // Shell 编排流程：收集状态 -> 调用核心 -> 处理副作用
  async function handleSubmit() {
    // 1. 调用核心做校验（把 reactive 对象当成普通对象传进去）
    const errorsRes = validateLoginForm(toRaw(form))
    Object.assign(errors, errorsRes)
    if (Object.keys(validationErrors).length > 0) return
    // 2. 调用核心做数据转换
    const payload = formatLoginPayload(form)
    // 3. Shell 处理副作用（网络请求、路由跳转）
    isSubmitting.value = true
    try {
      await authApi.login(payload)
      router.push('/dashboard')
    } catch (err: any) {
      errors.general = err.message // Shell 处理异常展示
    } finally {
      isSubmitting.value = false
    }
  }
  return { form, errors, isSubmitting, handleSubmit }
}
```

**基于pnpm workspaces的Monorepo架构**

pnpm采用软连接引用以来，缓存寻址。Monorepo生态的任务调度Turborepo/NX+版本管理Changesets

## 202506-PPS策略制定

**组件卡顿严重**

> 引入了**配置驱动+动态插槽**解决了复用问题。

**万级数据渲染**

> 加入了**虚拟滚动+数据冻结**

**树形节点高度动态偏移适配**

> 用 `Object.freeze` 冻结原始数据节省 Proxy 性能开销，同时在内存中单独维护一个 `expandedKeys` 的响应式集合。并在虚拟滚动和真实 DOM 之间加了一层**扁平化数据适配器**，每次展开时动态重算一维可见数组和高度缓存数组，最终在保持极高灵活性的前提下，让万级嵌套数据的滚动帧率稳定在 60fps。

> 难点1：数据冻结 vs 交互状态维护
>
> - **冲突点**：数据被冻结了（不可变），那用户点击“展开/折叠”按钮时，状态存哪里？如果存回数据里，就打破了冻结；如果单独存，怎么和冻结的数据对应？
> - **解法思路**：必须进行**数据与视图状态的分离**。维护一个平铺的、独立的响应式状态池（例如 `const expandedKeys = reactive(new Set(['row_1', 'row_1_2']))`）。渲染时，通过判断当前行的 id 是否在 `expandedKeys` 中来决定是否递归渲染子组件，而原始数据始终保持冷冻状态。

> 难点 2：虚拟滚动 vs 多级递归（死敌对决）
>
> 虚拟滚动的基石是：每一行的高度必须是可预测的（固定高度，或者提前计算好缓存起来的高度）。
>
> - **冲突点**：树形表格在展开/折叠子节点时，会导致下方所有行的绝对位置发生剧烈变化。
> - **具体表现**：你展开第 2 行，它下面突然多出 50 个子节点，虚拟滚动原本计算好的 `scrollTop` 和 `transform: translateY()` 全部错乱，导致白屏或行重叠。
> - **解法思路**：不能简单地用固定行高乘以索引。必须实现**动态高度测量与缓存机制**（渲染过一次的行，将其真实 DOM 高度存入一个数组/Map 中，如 `[300, 40, 40, 120...]`，每次滚动时累加这个数组来计算偏移量）。

> 难点3：动态插槽在递归中的上下文传递（作用域泄漏）
>
> - **冲突点**：第 1 层传入了一个自定义的操作插槽，到了第 3 层递归时，这个插槽需要读取第 3 层的行数据。如果直接透传，很容易导致闭包引用错误，或者插槽内部的变量作用域混乱。
> - **解法思路**：在递归组件内部，需要严格规范作用域插槽的转发机制。每次递归调用子组件时，必须将**当前层级的行数据、层级深度**作为新的作用域参数，重新绑定到插槽上。

> 难点 4：条件渲染与虚拟滚动的 DOM 回收冲突
>
> - **冲突点**：虚拟滚动本身有一套 DOM 节点池的复用逻辑（滚出视口的节点会被拿去渲染新进入视口的数据）。如果你在节点内部用了大量的 `v-if`，当 DOM 被虚拟滚动回收并复用时，`v-if` 的销毁和重建时机可能与虚拟滚动的更新周期产生冲突，导致闪屏或事件绑定失效。
> - **解法思路**：尽量在虚拟滚动计算“哪些数据应该渲染”的阶段就做过滤（数据级条件渲染），而不是把数据交给组件后，在组件内部用 `v-if` 做拦截。

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
