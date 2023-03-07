---
title: Electron是什么
date: 2022-05-17 07:33:16
categories:
- H_工程热点
toc: true # 是否启用内容索引
---

# Electron 是什么

## 定义

[Electron](https://links.jianshu.com/go?to=https%3A%2F%2Felectronjs.org%2F)是由Github开发，用HTML，CSS和JavaScript来构建跨平台桌面应用程序的一个开源库。 Electron通过将[Chromium](https://links.jianshu.com/go?to=https%3A%2F%2Fwww.chromium.org%2FHome)和[Node.js](https://links.jianshu.com/go?to=https%3A%2F%2Fnodejs.org%2F)合并到同一个运行时环境中，并将其打包为Mac，Windows和Linux系统下的应用来实现这一目的。通过Node它提供了通常浏览器所不能提供的能力。

## 历史

2013年的时候，Atom编辑器问世，作为实现它的底层框架Electron也逐渐被熟知，到2014年时被开源，那时它还是叫`Atom Shell`。

接下来的几年，Electron在不断的更新迭代，几乎每年都有一个重大的里程碑

- 2013年4月11日，Electron以Atom Shell为名起步。
- 2014年5月6日，Atom以及Atom Shell以MIT许可证开源。
- 2015年4月17日，Atom Shell改名为Electron。
- 2016年5月11日，1.0版本发布。
- 2016年5月20日，允许向Mac应用商店提交软件包。
- 2016年8月2日，支持Windows商店。

在最新的稳定版本V3.x中，Electorn集成了Nodejs v10.2.0和内核为v66.0.3359.181的Chromium

## 底层实现

Electron 结合了 Chromium、Node.js 和用于调用操作系统本地功能的API。

***1）Chromium：\***

[Chromium](https://links.jianshu.com/go?to=https%3A%2F%2Fwww.chromium.org%2FHome) 是 Google 为发展 Chrome 浏览器而启动的开源项目，Chromium 相当于 Chrome 的工程版或称实验版，新功能会率先在 Chromium 上实现，待验证后才会应用在Chrome 上，故 Chrome 的功能会相对落后但较稳定。

Chromium为Electron提供强大的UI能力，可以在不考虑兼容性的情况下开发界面。

***2）Node.js：\***

[Node.js](https://links.jianshu.com/go?to=https%3A%2F%2Fnodejs.org%2Fen%2F)是一个让 JavaScript 运行在服务端的开发平台，Node 使用事件驱动，非阻塞I/O 模型而得以轻量和高效。

单单靠Chromium是不能具备直接操作原生GUI能力的，Electron内集成了Nodejs，这让其在开发界面的同时也有了操作系统底层 API 的能力，Nodejs 中常用的 Path、fs、Crypto 等模块在 Electron 可以直接使用。

***3）系统API：***

为了提供原生系统的GUI支持，Electron内置了原生应用程序接口，对调用一些系统功能，如调用系统通知、打开系统文件夹提供支持。

在开发模式上，Electron在调用系统API和绘制界面上是分离开发的，下面我们来看看Electron关于进程如何划分。

## 为什么要用Electron

以Windows平台为例，大部分人会首先想到使用QT(C++)，WPF(C#) 等语言去开发应用。不可否认的是，这些已经是非常成熟的开发方案了。但是，我们来看下如下两种场景：

- 公司要做个全新的APP，但是技术人员构成大部分都是前端开发
- 公司原本就有在线的web应用，但是想包个壳能在桌面直接打开，同时增加一些与系统交互的功能

对于第一种场景，团队中开发人员对于C++和C#并不熟悉，虽然可以现学，但是整个项目的技术管理和项目管理就会变得不可控。

对于第二种场景，对于应用的业务逻辑要求并不多，只是套一个具有浏览器的运行环境，单独为此配置一个C++、C#开发人员划不来。

对于这两种情况，如果现有的前端开发人员能直接搞定，那就非常完美了。

Electron的诞生提供了这种可能性。它可以帮助前端开发者在不需要学习其他语言和技能的前提下，快速开发跨平台的桌面应用。

传统的桌面应用开发方式，一般是下面两种：

***1）原生开发：\***

直接将语言编译成可执行文件，直接调用系统API，完成UI绘制等。这类开发技术，有着较高的运行效率，但一般来说，开发速度较慢，技术要求较高，例如：

> a. 使用C++ / MFC开发Windows应用；
> b. 使用Objective-C开发MAC应用。

***2）托管平台：\***

一开始就有本地开发和UI开发。一次编译后，得到中间文件，通过平台或虚机完成二次加载编译或解释运行。运行效率低于原生编译，但平台优化后，其效率也是比较可观的。就开发速度方面，比原生编译技术要快一些。例如：

> a. 使用C# / .NET Framework(只能开发Windows应用)；
> b. Java / Swing。

不过，上面两种对前端开发人员太不友好了，基本是前端人员不会涉及的领域，但是在这个"大前端"的时代，前端开发者正在想方设法涉足各个领域，使用WEB技术开发客户端的方式横空出世。

**为什么还要搬到PC客户端，这里有3个角度的回答：**

> a. 用户角度： 客户端是一款独立的软件，其综合体验一般都是比网站高的，尤其是涉及到「工具」范畴的应用，此外，特定的用户群体也会有类似的使用习惯；
> b. 发行方角度： 客户端是另一种产品形式，是一种产品的分发方式和入口，客户端可以实现很多本地应用独有的需求去触达用户，也能提供更加可靠的服务；
> c. 开发角度： 终于...不用考虑浏览器兼容了，Chromium 也足够开发使用一些先进的 CSS 或 JS 特性，我们现在还没计划引入 webpack 和 babel，因为现在好像够用，克制才是爱，除了写起来爽，对于开发来说，终于跳出了浏览器的沙盒，你可以自己去控制 Electron 中的“浏览器”，莫名的开心。

**Electron优势：**

> a. 使用具有强大生态的Web技术进行开发，开发成本低，可扩展性强，更炫酷的UI；**
> b. 跨平台，一套代码可打包为Windows、Linux、Mac三套软件，且编译快速；**
>
> c.可直接在现有Web应用上进行扩展，提供浏览器不具备的能力；

**缺点**：性能比原生桌面应用要低，最终打包后的应用比原生应用大很多。

**Electron开发体验：**

> a. **兼容性：**虽然你还在用WEB技术进行开发，但是你不用再考虑兼容性问题了，你只需要关心你当前使用Electron的版本对应Chrome的版本，一般情况下它已经足够新来让你使用最新的API和语法了，你还可以手动升级Chrome版本。同样的，你也不用考虑不同浏览器带的样式和代码兼容问题。
> b. **NodeJS环境：**这可能是很多前端开发者曾经梦想过的功能，在WEB界面中使用Node.js提供的强大API，这意味着你在WEB页面直接可以操作文件，调用系统API，甚至操作数据库。当然，除了完整的 Node API，你还可以使用额外的几十万个npm模块。
>
> c.**跨域：**你可以直接使用Node提供的request模块进行网络请求，这意味着你无需再被跨域所困扰。
>
> d.**强大的扩展性：**借助node-ffi，为应用程序提供强大的扩展性（更详细的介绍可以自行百度相关资料了解一下）。

# Electron项目和Web项目的区别

**Electron核心可以分成2个部分：**主进程和渲染进程。

主进程连接着操作系统和渲染进程，可以把她看做页面和计算机沟通的桥梁。渲染进程就是我们所熟悉前端环境了，只是载体改变了，从浏览器变成了window。

传统的Web环境我们是不能对用户的系统就行操作的，而Electron相当于NodeJS环境，我们可以在项目里使用所有的node api（Electron的作者相当机智...）。

**简单理解：**给Web项目套上一个NodeJS环境的壳，就是Electron技术。

**项目结构：**相比web项目，桌面项目多了一个进程

**项目迁移：**如果要迁移项目到Web端，就需要把项目中的Electron提供的API和NodeJS的API完全剥离出来，只能遗留Web的代码，比如 node fs模块，Electron提供ipc 模块，都需要剥离。如果你一开始就打算双端程序，在开始写代码时应该对Web代码和Elecctron的代码进行分离，以便后期的迁移。

# Electron的基本使用

新建一个目录，初始化npm

```
mkdir helloword
npm init
复制代码
```

修改package.json文件，增加npm run start命令

```
{
  "name": "electron demo",
  "version": "1.0.0",
  "description": "",
  "main": "main.js",   //修改为main.js
  "scripts": {
    "start": "electron ."  //增加start命令
  },
  "author": "",
  "license": "ISC",
  "dependencies": {
    "electron": "^3.0.10"
  }
}

复制代码
```

通过npm安装Electron

```
npm i electron --save-dev
复制代码
```

在根目录创建main.js和index.html

main.js

```
const { app, BrowserWindow } = require('electron')

function createWindow () {   
  // 创建浏览器窗口
  win = new BrowserWindow({ width: 800, height: 600 })

  // 然后加载应用的 index.html。
  win.loadFile('index.html')
}

app.on('ready', createWindow)
复制代码
```

index.html

```
<!DOCTYPE html>
<html>
  <head>
    <meta charset="UTF-8">
    <title>Hello World!</title>
  </head>
  <body>
    <h1>Hello World!</h1>
  </body>
</html>
复制代码
```

到这里，我们所有的准备工作都完成了，接下来就是运行它！

```
npm run start
复制代码
```

看看效果

# 参考

《[跨平台桌面应用开发：基于Electron与NW.js](https://links.jianshu.com/go?to=https%3A%2F%2Fbook.douban.com%2Fsubject%2F30185217%2F)》

**Electron资源：**

1）Electron官网：[https://electronjs.org](https://links.jianshu.com/go?to=https%3A%2F%2Felectronjs.org%2F)；

2）Electron Github：[https://github.com/electron](https://links.jianshu.com/go?to=https%3A%2F%2Fgithub.com%2Felectron)；

3）Electron开发手册：[https://electronjs.org/docs](https://links.jianshu.com/go?to=https%3A%2F%2Felectronjs.org%2Fdocs)。

