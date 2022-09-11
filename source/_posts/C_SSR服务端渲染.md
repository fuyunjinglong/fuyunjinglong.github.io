---
title: C_SSR服务端渲染
date: 2022-05-19 07:33:16
categories:
- C_框架及工具
toc: true # 是否启用内容索引
---

# 1.渲染的客户端与服务端

![image-20220520065208264](/img/image-20220520065208264.png)

# 2.6 种前端渲染模式

客户端逻辑越重，初始化需要执行的 JS 越多，首屏性能就越慢，因而出现了*更多的渲染模式*探索。

[Google开发者大会对于前端渲染的介绍](https://link.juejin.cn/?target=https%3A%2F%2Fdevelopers.google.com%2Fweb%2Fupdates%2F2019%2F02%2Frendering-on-the-web%23server-vs-static)

## 1.CSR

CSR（Client-side rendering），即客户端渲染，是指用 JS 直接在浏览器里渲染页面，*包括数据请求、视图模板、路由在内的所有逻辑都在客户端处理*.

渲染流程如下图：

<img src="/img/image-20220520065347571.png" alt="image-20220520065347571" style="zoom: 50%;" />

P.S.其中出现的 FCP 与 TTI 是两个重要的性能指标：

- FCP（First Contentful Paint）：用户所请求的内容在屏幕上可见的时间点
- TTI（Time To Interactive）：页面可交互的时间点

主要缺陷在于随着应用程序的更新迭代，*客户端所要执行 JS 代码量越来越多*，前置的第三方类库/框架、polyfill 等都会在一定程度上拖慢首屏性能，在（中低端）移动设备上尤为明显

Code splitting、lazy-load等优化措施能够缓解一部分，但优化空间相对有限，无助于从根本上解决问题

此时，只有改变渲染模式才能创造更多的可能性

## 2.SSR

SSR（Server-Side Rendering）前后端分层之前很长的一段时间里都是以服务端渲染为主（JSP、PHP），在服务端生成完整的 HTML 页面：

省去了客户端二次请求数据的网络开销，以及渲染视图模板的性能负担。与 CSR 相比，其 FCP、TTI 通常会更快：

<img src="/img/image-20220520065454057.png" alt="image-20220520065454057" style="zoom:50%;" />

P.S.另一方面，服务端的网络环境要优于客户端，内部[服务器](https://cloud.tencent.com/product/cvm?from=10680)之间通信路径也更短

因为页面逻辑（包括即时数据请求）和模板渲染工作都放在服务端完成，减少了客户端的 JS 代码量，流式文档解析（streaming document parsing）等浏览器优化机制也能发挥其作用，在低端设备和弱网情况下表现更好。但*在服务器上生成页面同样需要时间*，会导致页面内容响应时间（TTFB, Time to First Byte）变慢

一种办法是可以通过流式 SSR、组件级缓存、模板化、HTML 缓存等技术来进一步优化

另一种办法是继续在渲染模式上探索，采用静态渲染（Static Rendering）

<img src="/img/image-20220520070208555.png" alt="image-20220520070208555" style="zoom:67%;" />

### SSR 的困境

SSR 那么优秀，但是为什么却没能成为 Web 主流的开发模式呢，我想这是因为构建 SSR 应用并不容易：



- 但当你开始开发一个 SSR 应用时，就已经不在是一个简单的前端开发工程师了，而将被迫成为全栈工程师。交付产物从原来的 JS  Bundle 变成了 Node 应用，随之而来的是，需要选型一个 Node 框架，搭建一个 Node 应用，并且应对性能开销、保障应用稳定性等等。

- 其次，还需要考虑如何让现有的前端代码跑到 Server 端上，虽然类似 React 这些主流的框架都提供了 Server 端渲染的能力，但是，不同端上渲染原理和执行环境的差异，会导致编码上的很多差异，比如在 Node 端调用了 window 变量，那么就会报错了，同样的 Hooks 之类的异步更新机制在 Server 端也不适用。

- 最后，当你完成应用的开发，还需要考虑这些问题：如何部署环境、如何负载均衡、如何应对服务器宕机、如何应对用户请求峰值等等

因此，虽然 SSR 在性能上完胜 CSR ，但却因为其高昂的开发和维护成本，使人们转而投向 CSR 的怀抱。

### SSR 遇上 Serverless

[当 SSR 遇上 Serverless，轻松实现页面瞬开原文](https://fed.taobao.org/blog/taofed/do71ct/rax-ssr-serverless-quicker/)

近年来，随着 Serverless 生态建设的不断完善，我们也在思考，Serverless 的模式是否能为 SSR 带来新的生命力，答案是肯定的。

一方面，借助于函数即服务（FaaS）的能力，不需要再去搭建传统的 Node 应用，一个函数就可以变成一个服务，开发者可以更纯粹的关注于业务逻辑。

另一方面，FaaS 以函数为单位的形式以及弹性机制，为 SSR 应用带来了天然的隔离性和动态修复能力，可以更好的避免页面间的交叉污染，或一些边界的异常场景对应用带来致命性的伤害。

再者，无需运维、按需执行、弹性伸缩这些特性，大大降低了 SSR 应用对开发者的门槛。

因此，借助于 Serverless 带来的想象空间，以及 Rax 在工程和 SSR 渲染引擎上所做的工作，我们是完全可以做到媲美目前 CSR 模式的开发体验的。

### 三大框架

React、Vue和Angular分别对应Next、Nuxt和Nest



## 3.Static Rendering

将生成 HTML 页面的工作放到编译时，而不必在请求带来时动态完成。为每个 URL 预先单独生成 HTML 文件，并进一步借助[CDN](https://cloud.tencent.com/product/cdn?from=10680)加速访问：

<img src="/img/image-20220520065547435.png" alt="image-20220520065547435" style="zoom: 33%;" />

P.S.SSR 第一部分的 Server Rendering 渲染工作变成了 Streaming 传递静态 HTML 文件

静态渲染也并非完美，其关键问题在于*“静态”*：

- 需要为每个 URL 单独生成一份 HTML 文件：对于无法预知所有可能的 URL，或者存在大量不同页面的网站，静态渲染就不那么容易，甚至根本不可行
- 只适用于偏静态内容：对于动态的、个性化的内容作用不大

另外，还有个与静态渲染相似的概念，叫预渲染（Prerendering）

## 4.Prerendering

主要区别在于，静态渲染得到的页面已经是可交互的，无需在客户端额外执行大量 JS 代码，而*预渲染必须经客户端渲染才真正可交互*：

也就是说，禁用 JS 后，静态渲染的页面几乎不受影响，而预渲染的页面将只剩下超链接之类的基本功能

## 5.Rehydration

Rehydration： “启动”客户端上的JavaScript视图，以便它们重用服务器渲染的HTML的DOM树和数据。

Rehydration 模式将 CSR 与 SSR 结合起来了，*服务端渲染出基本内容后，在客户端进行二次渲染（Rehydration）*：

<img src="/img/image-20220520065738032.png" alt="image-20220520065738032" style="zoom:67%;" />

<img src="/img/image-20220520065816717.png" alt="image-20220520065816717" style="zoom: 67%;" />

注意`bundle.js`仍然是*全量的 CSR 代码*，这些代码执行完毕页面才真正可交互。因此，这种模式下，FP（First Paint）虽然有所提升，但 TTI（Time To Interactive）可能会变慢，因为在客户端二次渲染完成之前，页面无法响应用户输入（被 JS 代码执行阻塞了）

对于二次渲染造成交互无法响应的问题，可能的优化方向是增量渲染（例如React Fiber），以及渐进式渲染/部分渲染

## 6.Trisomorphic Rendering

如果把Service Worker也考虑进来的话，还有一种*涉及三方的渲染模式*：

> SSR + CSR + ServiceWorker rendering = Trisomorphic Rendering

<img src="/img/image-20220520065940915.png" alt="image-20220520065940915" style="zoom:67%;" />

首先通过流式 SSR 渲染初始页面，接着由 Service Worker 根据路由规则，借助 SSR 渲染出目标 HTML 页面：

主要优势在于能够跨三方共享模板渲染和路由控制逻辑：

**总结**

![image-20220520070032107](/img/image-20220520070032107.png)

# Vue-SSR实战

## SSR是什么？

SSR是 Server-Side Rendering(服务器端渲染)的缩写，简单的理解就是将原本在浏览器上渲染编译的组件、页面，现在通过服务器编译渲染生成html字符串，发送到浏览器，最后将静态标记，混合为客户端上交互的应用程序。

**优势：**

- 1、解决SEO的问题 。 当百度搜索引擎爬虫爬取的时候 通过URL 产生对服务器的请求，服务器根据URL，响应页面，因此百度就获取到了我们站点的数据。
- 2、一定程度解决了SPA程序首屏白屏的问题。在首屏刷新的时候，通过后端计算并模板渲染，再将html相应给客户端，省去了浏览器端首次渲染的时间。（当然在服务端渲染增加了服务端的压力）

## CSR与SSR流程比较

CSR:输入url-返回入口文件-请求静态资源-渲染html-请求数据-页面更新。

SSR:输入url-服务端处理成html字符串-返回html到浏览器-完成渲染。

## Vue_SSR服务端渲染Demo

**package.json**

```
{
  "name": "ssr1",
  "version": "0.1.0",
  "private": true,
  "scripts": {
    "serve": "vue-cli-service serve",
    "build": "vue-cli-service build",
    "lint": "vue-cli-service lint"
  },
  "dependencies": {
    "core-js": "^3.6.5",
    "express": "^4.17.1",
    "vue": "^2.6.12",
    "vue-router": "^3.4.6",
    "vue-server-renderer": "^2.6.12"
  },
  "devDependencies": {
    "@vue/cli-plugin-babel": "~4.5.0",
    "@vue/cli-plugin-eslint": "~4.5.0",
    "@vue/cli-service": "~4.5.0",
    "babel-eslint": "^10.1.0",
    "eslint": "^6.7.2",
    "eslint-plugin-vue": "^6.2.2",
    "vue-template-compiler": "^2.6.11"
  },
  "eslintConfig": {
    "root": true,
    "env": {
      "node": true
    },
    "extends": [
      "plugin:vue/essential",
      "eslint:recommended"
    ],
    "parserOptions": {
      "parser": "babel-eslint"
    },
    "rules": {}
  },
  "browserslist": [
    "> 1%",
    "last 2 versions",
    "not dead"
  ]
}
```

**index.template.html**

```
<html>
  <head>
    <!-- 使用双花括号(double-mustache)进行 HTML 转义插值(HTML-escaped interpolation) -->
    <title>{{ title }}</title>

    <!-- 使用三花括号(triple-mustache)进行 HTML 不转义插值(non-HTML-escaped interpolation) -->
    {{{ meta }}}
  </head>
  <body>
    <!--vue-ssr-outlet-->
  </body>
</html>
```

一、简单的Vue实例渲染成html字符串，不再加载Vue.js等文件

```js
// 第 1 步：创建一个 Vue 实例，注意这里没有el
const Vue = require('vue');
const app = new Vue({
  data: {
    hello: 'Hello World',
  },
  template: `<div><h1>{{hello}}</h1></div>`,
});

// 第 2 步：创建一个 renderer,用于将客户端的Vue实例与服务端数据混合处理
const renderer = require('vue-server-renderer').createRenderer();

// 第 3 步：renderer将 Vue 实例渲染为 HTML，并返回给前端页面
renderer
  .renderToString(app)
  .then(html => {
    console.log(html);
  })
  .catch(err => {
    console.error(err);
  });
//结果标记为服务端渲染 <div data-server-rendered="true"><h1>Hello World</h1></div>
```

二、简单的Vue实例指定模板文件，并传递context上下文变量渲染成html

```js
const Vue = require('vue');
//读取需要渲染的模板文件
const template = require('fs').readFileSync('./index.template.html', 'utf-8');
//服务端renderer支持引入模板文件
const renderer = require('vue-server-renderer').createRenderer({
  template,
});
//上下文变量，供renderer进行读取写入变量
const context = {
  title: 'vue ssr',
  meta: `
        <meta name="keyword" content="vue,ssr">
        <meta name="description" content="vue srr demo">
    `,
};

const app = new Vue({
  data: {
    hello2: 'Hello World222222222',
  },
  //此处会替换模板文件标记的 <!--vue-ssr-outlet-->位置
  template: `<div><h1>{{hello2}}</h1></div>`,
});

//服务端renderer支持引入上下文变量
renderer
  .renderToString(app, context)
  .then(html => {
    console.log(html);
  })
  .catch(err => {
    console.error(err);
  });
//结果为：
/*
<html>
  <head>
    <!-- 使用双花括号(double-mustache)进行 HTML 转义插值(HTML-escaped interpolation) -->
    <title>vue ssr</title>
    <!-- 使用三花括号(triple-mustache)进行 HTML 不转义插值(non-HTML-escaped interpolation) -->
        <meta name="keyword" content="vue,ssr">
        <meta name="description" content="vue srr demo">
  </head>
  <body>
    <div data-server-rendered="true"><h1>Hello World222222222</h1></div>
  </body>
</html>
*/
```

三、简单的Vue实例通过express模块渲染成html并在页面显示

```js
const Vue = require('vue');
const server = require('express')();

const template = require('fs').readFileSync('./index.template.html', 'utf-8');

const renderer = require('vue-server-renderer').createRenderer({
  template,
});

const context = {
  title: 'vue ssr',
  meta: `
        <meta charset="UTF-8">
        <meta name="keyword" content="vue,ssr">
        <meta name="description" content="vue srr demo">
    `,
};

server.get('*', (req, res) => {
  const app = new Vue({
    data: {
      url: req.url,
    },
    template: `<div>访问的 URL 是： {{ url }}</div>`,
  });

  renderer.renderToString(app, context, (err, html) => {
    if (err) {
      res.status(500).end('Internal Server Error');
      return;
    }
    res.end(html);
  });
});

server.listen(8080, () => {
  console.log('服务启动成功');
});
//浏览器地址栏输入http://localhost:8080/PageRenderingCase
```

四、简单的Vue实例结合router路由渲染页面，切换路由也是服务端处理返回html文件

```js
const server = require('express')();
//读取数据和需要填充到<!--vue-ssr-outlet-->占位符的内容
const createApp = require('./app.js');
const template = require('fs').readFileSync('./index.template.html', 'utf-8');

const renderer = require('vue-server-renderer').createRenderer({
  template,
});

const context = {
  title: 'vue ssr',
  meta: `
        <meta charset="UTF-8">
        <meta name="keyword" content="vue,ssr">
        <meta name="description" content="vue srr demo">
    `,
};

const getData = function() {
  return new Promise((reslove, reject) => {
    let str = 'this is a async data!';
    reslove(str);
  });
};

server.get('*', async (req, res) => {
  let appServer;
  try {
    const ctx = {
      url: req.url,
    };

    // 调用接口获取数据
    // 数据传递
    ctx.propsData = 'this is a data from props!';
    ctx.asyncData = await getData();

    appServer = await new Promise((reslove, reject) => {
      console.log(req.url);
      let { app, router } = createApp(ctx);
      router.push(req.url);

      //  router回调函数
      //  当所有异步请求完成之后就会触发
      //服务端匹配路由，匹配到则返回给客户端
      router.onReady(() => {
        let matchedComponents = router.getMatchedComponents();
        console.log(matchedComponents);
        if (!matchedComponents.length) {
          return reject({
            code: 404,
          });
        }
        reslove(app);
      }, reject);
    });
  } catch (error) {
    console.log(error);
  }
  renderer.renderToString(appServer, context, (err, html) => {
    if (err) {
      res.status(500).end('Internal Server Error');
      return;
    }
    res.end(html);
  });
});

server.listen(8080, () => {
  console.log('服务启动成功 http://127.0.0.1:8080');
});

```

其他文件

**app.js**

```js
const Vue = require('vue');
const createRouter = require('./router');

module.exports = context => {
  const router = createRouter();
  const app = new Vue({
    router,
    data: {
      message: 'Hello,Vue SSR!',
      propsData: context.propsData,
      asyncData: context.asyncData,
    },
    template: `
            <div>
                <h1>{{message}}</h1>
                <p>{{asyncData}}</p>
                <p>{{propsData}}</p>
                <ul>
                    <li>
                        <router-link to="/">home</router-link>
                    </li>
                    <li>
                        <router-link to="/about">about</router-link>
                    </li>
                </ul>
                <router-view></router-view>
            </div>
        `,
  });
  return {
    app,
    router,
  };
};
```

**router.js**

```js
const vueRouter = require('vue-router');
const Vue = require('vue');

Vue.use(vueRouter);

module.exports = () => {
  return new vueRouter({
    mode: 'history',
    routes: [
      {
        path: '/',
        component: {
          template: `<h1>this is home page</h1>`,
        },
        name: 'home',
      },
      {
        path: '/about',
        component: {
          template: `<h1>this is about page</h1>`,
        },
        name: 'about',
      },
      {
        path: '/about1',
        component: {
          template: `<h1>this is about1 page</h1>`,
        },
        name: 'about1',
      },
    ],
  });
};
```

## Vue_SSR自定义

打包后，核心是生产客户端文件vue-ssr-client-manifest.json和服务端vue-ssr-server-bundle.json，然后访问地址栏。Nuxt解决方案本质也是这个逻辑。

编译脚本为：

```js
  "scripts": {
    "serve": "vue-cli-service serve",
    "build": "vue-cli-service build",
    "lint": "vue-cli-service lint",
    "build:client": "vue-cli-service build",
    "build:server": "cross-env WEBPACK_TARGET=node vue-cli-service build",
    "build:win": "npm run build:server && move dist\\vue-ssr-server-bundle.json bundle && npm run build:client && move bundle dist\\vue-ssr-server-bundle.json && move dist\\index.html . && node server.js"
  }
```

**vue.config.js**：配置打包编译

```js
const VueSSRServerPlugin = require('vue-server-renderer/server-plugin');
const VueSSRClientPlugin = require('vue-server-renderer/client-plugin');
const nodeExternals = require('webpack-node-externals');
const merge = require('lodash.merge');
const TARGET_NODE = process.env.WEBPACK_TARGET === 'node';
const target = TARGET_NODE ? 'server' : 'client';

module.exports = {
  configureWebpack: () => ({
    // 将 entry 指向应用程序的 server / client 文件
    entry: `./src/entry-${target}.js`,
    // 对 bundle renderer 提供 source map 支持
    devtool: 'source-map',
    target: TARGET_NODE ? 'node' : 'web',
    node: TARGET_NODE ? undefined : false,
    output: {
      libraryTarget: TARGET_NODE ? 'commonjs2' : undefined,
    },
    // https://webpack.js.org/configuration/externals/#function
    // https://github.com/liady/webpack-node-externals
    // 外置化应用程序依赖模块。可以使服务器构建速度更快，
    // 并生成较小的 bundle 文件。
    // externals: nodeExternals({
    //   // 不要外置化 webpack 需要处理的依赖模块。
    //   // 你可以在这里添加更多的文件类型。例如，未处理 *.vue 原始文件，
    //   // 你还应该将修改 `global`（例如 polyfill）的依赖模块列入白名单
    //   whitelist: [/\.css$/]
    // }),
    optimization: {
      splitChunks: {
        chunks: 'async',
        minSize: 30000,
        minChunks: 2,
        maxAsyncRequests: 5,
        maxInitialRequests: 3,
      },
    },
    plugins: [TARGET_NODE ? new VueSSRServerPlugin() : new VueSSRClientPlugin()],
  }),
  chainWebpack: config => {
    config.module
      .rule('vue')
      .use('vue-loader')
      .tap(options => {
        merge(options, {
          optimizeSSR: false,
        });
      });
  },
  // css不要分割打包
  css: {
    extract: false,
  },
};
```

**entry-client.js**

```js
import { createApp } from './main';
const { app, router, store } = createApp();
if (window.__INITIAL_STATE__) {
  //window.__INITIAL_STATE__全局数据，保存了后台返回的数据
  store.replaceState(window.__INITIAL_STATE__);
}
router.onReady(() => {
  // 添加路由钩子函数，用于处理 asyncData.
  // 在初始路由 resolve 后执行，
  // 以便我们不会二次预取(double-fetch)已有的数据。
  // 使用 `router.beforeResolve()`，以便确保所有异步组件都 resolve。
  router.beforeResolve((to, from, next) => {
    const matched = router.getMatchedComponents(to);
    const prevMatched = router.getMatchedComponents(from);

    // 我们只关心非预渲染的组件
    // 所以我们对比它们，找出两个匹配列表的差异组件
    let diffed = false;
    const activated = matched.filter((c, i) => {
      return diffed || (diffed = prevMatched[i] !== c);
    });
    console.log(activated);
    if (!activated.length) {
      return next();
    }

    // 这里如果有加载指示器 (loading indicator)，就触发

    Promise.all(
      activated.map(c => {
        if (c.asyncData) {
          return c.asyncData({ store, route: to });
        }
      })
    )
      .then(() => {
        // 停止加载指示器(loading indicator)

        next();
      })
      .catch(next);
  });

  app.$mount('#app');
});
```

**entry-server.js**

```js
import { createApp } from './main';

export default context => {
  console.log(context);
  return new Promise((resolve, reject) => {
    const { app, router, store } = createApp();

    router.push(context.url);

    router.onReady(() => {
      const matchedComponents = router.getMatchedComponents();
      if (!matchedComponents.length) {
        return reject({ code: 404 });
      }
      console.log(matchedComponents);
      // 对所有匹配的路由组件调用 `asyncData()`
      Promise.all(
        matchedComponents.map(Component => {
          if (Component.asyncData) {
            return Component.asyncData({
              store,
              route: router.currentRoute,
            });
          }
        })
      )
        .then(() => {
          // 在所有预取钩子(preFetch hook) resolve 后，
          // 我们的 store 现在已经填充入渲染应用程序所需的状态。
          // 当我们将状态附加到上下文，
          // 并且 `template` 选项用于 renderer 时，
          // 状态将自动序列化为 `window.__INITIAL_STATE__`，并注入 HTML。
          console.log(store.state);
          context.state = store.state;

          resolve(app);
        })
        .catch(reject);
    }, reject);
  });
};
```

**server.js**：启动服务，访问编译后文件的部署页面

```js
const serverBundle = require('./dist/vue-ssr-server-bundle.json');
const fs = require('fs');
const path = require('path');
const express = require('express');
const server = express();
// 渲染打包后的结果
const template = fs.readFileSync('./index.template.html', 'utf-8');
// 客户端的manifest.json
const clientManifest = require('./dist/vue-ssr-client-manifest.json');
const renderer = require('vue-server-renderer').createBundleRenderer(serverBundle, {
  template,
  clientManifest, // 渲染的时候， 可以找到客户端的js文件, 自动引入到html中
});

//引入静态文件  否则运行报错
server.use(express.static(path.resolve(__dirname, './dist')));

server.get('*', (req, res) => {
  const context = {
    title: 'ssr demo',
    url: req.url,
  };
  renderer.renderToString(context, (err, html) => {
    if (err) {
      console.log(err);
      res.status(500).end('Internal Server Error');
      return;
    }
    res.end(html);
  });
});

server.listen(8080, () => {
  console.log('已监听 localhost:8080');
});
```

## Nuxt框架

**基本原理**

nuxt 前端路由沿用了history模式，通过history.pushState 更改url，进而局部渲染组件（history router的实现思路是：监听页面中和路由有关的a标签点击事件，阻止默认的跳转行为，然后调用history.pushState()方法，让浏览器记住路由，然后手动更新相应视图。同时为了监听用户手点击浏览器的前进后退按钮，还需要监听popstate事件，动态的修改相应视图)

**Nuxt基本流程**

- 浏览器访问url
- 执行store中操作，发起请求数据等
- 执行中间件，包括读取nuxt.config.js,匹配layout布局，匹配路由和组件
- 动态路由检测，如_id.vue文件等
- 加载异步数据，取回数据，asyncData(),fetch()
- 页面渲染

**Nuxt路由**

基本路由，动态路由(_id.vue,page/123),嵌套路由，动态嵌套路由

**Vuex 状态树**

Nuxt.js 会尝试找到 src 目录（默认是应用根目录）下的 `store` 目录，如果该目录有多个文件存在，则自动进行合并