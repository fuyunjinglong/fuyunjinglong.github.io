---
title: 多端_移动端
date: 2022-05-10 06:33:16
categories:
- I_多端
toc: true # 是否启用内容索引
---

**参考**

- [Flutter学习仓库](https://github.com/chinabrant/flutter_study)
- [Github Flutter源码仓库](https://github.com/flutter/flutter)
- [Flutter中文网](https://flutterchina.club/)

# 移动端适配怎么解决

1. meta viewport视口
2. 图片适配
3. 媒体查询
4. 动态rem方案

**1.meta viewport视口**

大多数PC网页的宽度为980px，如果不做移动端适配，文字会缩小的很小。device-width表示等于设备宽度，不写的化就变成默认的980了。initial-scale缩放比例为1。

```html
<head>
<meta names="viewport"content="width=device-width,initial-scale=1.0"
<title>测试</title>
</head>
```

**2.图片适配**

使用img{max-width:100%}，而不是img{width:100%}。后者在容器大于图片时，图片会无线拉伸。前者最大显示自身图片那么大。

**3.媒体查询**

```
@media screen and（min-width:1200px）{
 body{
  background-color:red;
 }
}
```

**4.动态rem方案**

px，em，rem有什么不同？

px时屏幕上显示像素的基本单位。em是一个相对大小，相当于父元素的font-size的百分比大小(如果使用的话，要一层层计算，太复杂)。rem也是相对大小，是相对于根元素的font-size。

参考

- [2022 年移动端适配方案指南 — 全网最新最全](https://juejin.cn/post/7046169975706353701#heading-20)
- [响应式设计 - 理解设备像素、设备独立像素和 css 像素](https://link.juejin.cn?target=https%3A%2F%2Fwww.jianshu.com%2Fp%2F6b1f94bfa263)
- [移动前端开发之viewport的深入理解](https://link.juejin.cn?target=https%3A%2F%2Fwww.cnblogs.com%2F2050%2Fp%2F3877280.html)
- [使用 Flexible 实现手淘 H5 页面的终端适配](https://link.juejin.cn?target=https%3A%2F%2Fgithub.com%2Famfe%2Farticle%2Fissues%2F17)
- [VW: 是时候放弃 REM 布局了](https://link.juejin.cn?target=https%3A%2F%2Fwww.jianshu.com%2Fp%2Fe8ae1c3861dc)
- [lib-flexible](https://link.juejin.cn?target=https%3A%2F%2Fgithub.com%2Famfe%2Flib-flexible)
- [postcss-px-to-viewport](https://link.juejin.cn?target=https%3A%2F%2Fgithub.com%2Fevrone%2Fpostcss-px-to-viewport)
- [网页适配 iPhoneX](https://link.juejin.cn?target=https%3A%2F%2Faotu.io%2Fnotes%2F2017%2F11%2F27%2Fiphonex%2Findex.html)

## CSS媒体查询

通过 CSS 的 @media  媒体查询设置不同的 style。通过媒体查询，我们可以根据不同屏幕设置不同样式，这样就可以实现不同屏幕的适配。

如果我们选择`600px`,`900px`,`1200px`,`1800px`作为分割点，可以适配到常见的14个机型。

link 元素中的 CSS 媒体查询，不同屏幕加载不同样式文件：

```html
<link rel="stylesheet" media="(max-width: 500px)" href="mobile.css" />
<link rel="stylesheet" media="(min-width: 980px)" href="pc.css" />
```

CSS 样式表中的媒体查询：

```css
/* pc width > 1024px */
    body {
        background-color: yellow;
    }
/* ipad pro */
@media screen and (max-width: 1024px) {
    body {
        background-color: #FF00FF;
    }
}
/* ipad */
@media screen and (max-width: 768px) {
    body {
        background-color: green;
    }
}
/* iphone6 7 8 plus */
@media screen and (max-width: 414px) {
    body {
        background-color: blue;
    }
}
/* iphoneX */
@media screen and (max-width: 375px) and (-webkit-device-pixel-ratio: 3) {
    body {
        background-color: #0FF000;
    }
}
/* iphone6 7 8 */
@media screen and (max-width: 375px) and (-webkit-device-pixel-ratio: 2) {
    body {
        background-color: #0FF000;
    }
}
/* iphone5 */
@media screen and (max-width: 320px) {
    body {
        background-color: #0FF000;
    }
}
```

## 使用rem单位

rem（font size of the root element）是指相对于根元素的字体大小的单位，如果我们设置 html 的 font-size 为 16px，则如果需要设置元素字体大小为 16px，则写为 1rem。但是其还是必须得借助 @media 属性来为不同大小的设备设置不同的 font-size，相对上一种方案，可以减少重复编写相同属性的代价，简单示例如下所示。
 我们也能看到该方案存在以下问题：

- 不同的尺寸需要写多个 @media；
- 所有涉及到使用 rem 的地方，全部都需要调用方法 calc() ，这个也挺麻烦的；

```
@media only screen and (min-width: 375px) {
  html {
    font-size : 375px;
  }
}

@media only screen and (min-width: 360px) {
  html {
    font-size : 360px;
  }
}

@media only screen and (min-width: 320px) {
  html {
    font-size : 320px;
  }
}

//定义方法：calc
@function calc($val){
    @return $val / 1080;
}

.logo{
 width : calc(180rem);
}
```

## flexible适配(淘宝旧方案)

在 rem 方案上进行改进，我们可以使用 js 动态来设置根字体，这种方案的典型代表就是 [flexible 适配方案](https://link.juejin.cn/?target=https%3A%2F%2Fgithub.com%2Famfe%2Flib-flexible)。

**使用 rem 模拟 vw 特性适配多种屏幕尺寸**

核心代码

```
// set 1rem = viewWidth / 10
function setRemUnit () {
    var rem = docEl.clientWidth / 10
    docEl.style.fontSize = rem + 'px'
}
setRemUnit();
```

上面的代码中，将 html 节点的 font-size 设置为页面 clientWidth(布局视口)的 1/10，即 1rem 就等于页面布局视口的 1/10，这就意味着我们后面使用的 rem 都是按照页面比例来计算的。

**控制 viewport 的 width 和 scale 值适配高倍屏显示**

设置 viewport 的 width 为 device-width，改变浏览器 viewport（布局视口和视觉视口）的默认宽度为理想视口宽度，从而使得用户可以在理想视口内看到完整的布局视口的内容。
 等比设置 viewport 的 initial-scale、maximum-scale、minimum-scale 的值，从而实现 1 物理像素=1 css像素，以适配高倍屏的显示效果（就是在这个地方规避了大家熟知的“1px 问题”）

核心代码

```
var metaEL= doc.querySelector('meta[name="viewport"]');
var dpr = window.devicePixelRatio;
var scale = 1 / dpr
metaEl.setAttribute('content', 'width=device-width, initial-scale=' + scale + ', maximum-scale=' + scale + ', minimum-scale=' + scale + ', user-scalable=no'); 
```

**flexible 的缺陷**

> - 由于其缩放的缘故，video 标签的视频频播放器的样式在不同 dpr 的设备上展示差异很大；
> - 如果你去研究过 lib-flexible 的源码，那你一定知道 lib-flexible 对安卓手机的特殊处理，即：一律按 dpr = 1 处理；
> - 不再兼容 @media 的响应式布局，因为 @media 语法中涉及到的尺寸查询语句，查询的尺寸依据是当前设备的物理像素，和 flexible 的布局理论（即针对不同 dpr 设备等比缩放视口的 scale 值，从而同时改变布局视口和视觉视口大小）相悖，因此响应式布局在“等比缩放视口大小”的情境下是无法正常工作的；

其实 flexible 方案是在 模拟 viewport 功能，只是随着浏览器的发展及兼容性增强，viewport 已经能兼容绝大部分主流浏览器，并且 flexible 方案自身存在的问题，所有其也已几乎退出历史潮流。

引用 [lib-flexible](https://link.juejin.cn/?target=https%3A%2F%2Fgithub.com%2Famfe%2Flib-flexible) 的 github 主页的原话：

> 由于 viewport 单位得到众多浏览器的兼容，lib-flexible 这个过渡方案已经可以放弃使用，不管是现在的版本还是以前的版本，都存有一定的问题。建议大家开始使用 viewport 来替代此方案。

## Viewport适配(主流方案)

原理：类似近大远小，每一个元素在不同设备上占据的css像素的个数是一样的。但是css像素和物理像素的比例是不一样的，等比的。`vw`作为布局单位，从底层根本上解决了不同尺寸屏幕的适配问题，因为每个屏幕的百分比是固定的、可预测、可控制的。

由于 viewport 单位得到众多浏览器的兼容，所以目前基于 viewport 的移动端适配方案被各大厂团队所采用。

vw 作为布局单位，从底层根本上解决了不同尺寸屏幕的适配问题，因为每个屏幕的百分比是固定的、可预测、可控制的。 viewport 相关概念如下：

- vw：是 viewport's width 的简写，1vw 等于 window.innerWidth 的 1%；
- vh：和 vw 类似，是 viewport's height 的简写，1vh 等于 window.innerHeihgt 的 1%；
- vmin：vmin 的值是当前 vw 和 vh 中较小的值；
- vmax：vmax 的值是当前 vw 和 vh 中较大的值；

假设我们拿到的视觉稿宽度为 750px，视觉稿中某个字体大小为 75px，则我们的 css 属性只要如下这么写，不需要额外的去用 js 进行设置，也不需要去缩放屏幕等；

```css
.logo {
  font-size: 10vw; // 1vw = 750px * 1% = 7.5px
}
```

实现步骤

- 设置 meta 标签
- px 自动转换为 vw
- 标注不需要转换的属性
- Retina 屏预留坑位

**设置 meta 标签**

在 html 头部设置 mata 标签如下所示，让当前 viewport 的宽度等于设备的宽度，同时不允许用户手动缩放。

```
<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0">
```

**px 自动转换为 vw**

设计师一般给宽度大小为 375px 或 750px 的视觉稿，我们采用 vw 方案的话，需要将对应的元素大小单位 px 转换为 vw 单位，这是一项影响开发效率（需要手动计算将 px 转换为 vw）且不利于后续代码维护（css 代码中一堆 vw 单位，不如 px 看的直观）的事情；好在社区提供了 [postcss-px-to-viewport](https://link.juejin.cn?target=https%3A%2F%2Fgithub.com%2Fevrone%2Fpostcss-px-to-viewport) 插件，来将 px 自动转换为 vw。

**标注不需要转换的属性**

在项目中，如果设计师要求某一场景不做自适配，需为固定的宽高或大小，这时我们就需要利用 postcss-px-to-viewport 插件的 Ignoring 特性，对不需要转换的 css 属性进行标注，示例如下所示：

- /* px-to-viewport-ignore-next */  —> 下一行不进行转换.
- /* px-to-viewport-ignore */  —> 当前行不进行转换

**Retina 屏预留坑位**

考虑 Retina 屏场景，可能对图片的高清程度、1px 等场景有需求，所以我们预留判断 Retina 屏坑位。 相关方案如下：在入口的 html 页面进行 dpr 判断，以及 data-dpr 的设置；然后在项目的 css 文件中就可以根据 data-dpr 的值根据不同的 dpr 写不同的样式类；

# React Native

**参考**

- [react native入门到实战](https://www.bilibili.com/video/BV1Pt4y1n7bD/?spm_id_from=333.337.search-card.all.click&vd_source=bd4c7d99d71adf64d6e88c65370e0247)

# Flutter

## 1.Flutter是什么?

- [Flutter官网](https://flutter.dev/)

Flutter是一款移动应用程序SDK，一份代码可以同时生成iOS和Android两个高性能、高保真的应用程序。

Flutter诞生过程：

- 2017 年 Google I/O 大会上，Google 首次推出了一款新的用于创建跨平台、高性能的移动应用框架——Flutter。
- 2018年2月，Flutter发布了第一个Beta版本，同年五月， 在2018年Google I/O 大会上，Flutter 更新到了 beta 3 版本。
- 2018年6月，Flutter发布了首个预览版本，这意味着 Flutter 进入了正式版（1.0）发布前的最后阶段。

## 2.Flutter优势

- 提高开发效率
  - 同一份代码开发iOS和Android
  - 用更少的代码做更多的事情
  - 轻松迭代
    - 在应用程序运行时更改代码并重新加载（通过热重载）
    - 修复崩溃并继续从应用程序停止的地方进行调试
- 创建美观，高度定制的用户体验
  - 受益于使用Flutter框架提供的丰富的Material Design和Cupertino（iOS风格）的widget
  - 实现定制、美观、品牌驱动的设计，而不受原生控件的限制

## 3.核心模块

<img src="/img/image-20220510071129446.png" alt="image-20220510071129446" style="zoom:67%;" />

Flutter包括一个现代的响应式框架、一个2D渲染引擎、现成的widget和开发工具。

**跨平台自绘引擎**

Flutter与其他用于构建App的大多数框架不同，因为Flutter既不使用WebView，也不使用平台（Android、iOS等）的原生控件。相反，Flutter使用自己的高性能渲染引擎来绘制Widget。这样不仅可以保证在Android和iOS平台上UI的一致性，而且也可以避免对原生控件依赖而带来的限制及高昂的维护成本。

Flutter使用Skia作为其2D渲染引擎，Skia是Google的一个2D图形处理函数库，包含字型、坐标转换以及点阵图都有高效能且简洁的表现，Skia是跨平台的，并提供了非常友好的API，目前Google Chrome浏览器和Android均采用Skia作为其绘图引擎，值得一提的是，由于Android系统已经内置了Skia，所以Flutter在打包APK（Android应用安装包）时，不需要再将Skia打入APK中，但iOS系统并未内置Skia，所以构建iPA时，也必须将Skia一起打包，这也是为什么Flutter APP的Android应用安装包比iOS应用安装包小的主要原因。

**高性能**

Flutter采用GPU渲染技术，Flutter编写的应用是可以达到120fps（每秒传输帧数），这也就是说，它完全可以胜任游戏的制作，而我们常说的RN的性能只能达到60fps，这也算是Flutter的一个超高竞争力，官方宣称Flutter甚至会超过原生性能。

Flutter高性能主要靠两点来保证：

- 首先，Flutter App采用Dart语言开发，Dart在JIT（即时编译）模式下，速度与JavaScript基本持平；而且Dart还支持AOT（提前编译）模式，当以AOT模式运行时，JavaScript便远远追不上了。速度的提升对高帧率下的视图数据计算很有帮助。
- 其次，Flutter使用自己的渲染引擎来绘制UI，布局数据等由Dart语言直接控制，所以在布局过程中不需要像RN那样通过JavaScriptCore在JavaScript和原生之间进行通信，这在一些滑动和拖动的场景下具有明显优势，因为在滑动和拖动过程中往往都会引起布局发生变化，所以JavaScript需要和原生之间不停的同步布局信息，这和在浏览器中要JavaScript频繁操作DOM所带来的问题是相同的，都会带来比较可观的性能开销。

**为什么Flutter采用Dart语言开发？**

- [为什么 Flutter 选择了 Dart 语言](https://juejin.cn/post/6870286147541696525)

介绍两个概念：JIT和AOT。

目前，程序主要有两种运行方式：静态编译和动态解释。

- 静态编译：静态编译的程序在执行前全部被翻译为机器码，通常将这种类型称为AOT（Ahead of time）即“提前编译”；
- 动态解释：动态解释的程序是在执行中一句一句边翻译边运行的，通常将这种类型称为JIT（Just-in-time）即“即时编译”。

AOT程序的典型代表是用C/C++开发的应用，它们必须在执行前编译成机器码，而JIT的代表则非常多，如JavaScript、Python等，事实上，所有脚本语言都支持JIT模式。但值得一提的是JIT和AOT指的是程序运行方式，它们和编程语言并非强关联，有些语言既可以以JIT方式运行也可以以AOT方式运行，如Java、Python，它们可以在第一次执行时编译成中间字节码，然后在之后执行时可以直接执行字节码，也许有人会说，中间字节码并非机器码，在程序执行时仍然需要动态将字节码转为机器码，是的，不过通常我们区分是否为AOT的标准就是看代码在执行之前是否需要编译，只要需要编译，无论其编译产物是字节码还是机器码，都属于AOT。

Dart和JavaScript比较：

1. 开发效率高

- 基于JIT的快速开发周期：Flutter在开发阶段采用JIT模式，这样就避免了每次改动都要进行编译，极大的节省了开发时间；（Dart运行时支持）
- 基于AOT的发布包：Flutter在发布时可以通过AOT生成高效的ARM代码以保证应用性能，而JavaScript则不具有这个能力。（编译器支持）

1. 高性能

   Flutter旨在提供流畅、高保真的UI体验。为了实现这一点，Flutter需要能够在每个动画帧中运行大量的代码，这意味着需要一种既能提供高性能的语言，又不会出现丢帧的周期性暂停，而Dart支持AOT，在这一点上可以做的比JavaScript更好。

2. 快速内存分配

   Flutter框架使用函数式流，这使得它在很大程度上依赖于底层的内存分配器。因此，拥有一个能够有效的处理琐碎任务的内存分配器将显得十分重要，如果Dart语言缺乏此功能，Flutter将无法有效地工作。当然Chrome V8的JavaScript引擎在内存分配上也已经做的很好了，事实上Dart开发团队的很多成员都是来自Chrome团队的，所以在内存分配上Dart并不能作为超越JavaScript的优势，但对于Flutter来说，它需要这样的特性，而Dart也正好满足而已。

3. 类型安全

   由于Dart是类型安全的语言，支持静态类型检测，所以可以在编译前发现一些类型的错误，并排除潜在问题，这一点对于前端开发者来说可能会更具有吸引力。与之不同的，JavaScript是一个弱类型语言，也因此前端社区出现了很多给JavaScript代码添加静态类型检测的扩展语言和工具，如：微软的TypeScript以及Facebook的Flow。相比之下，Dart本身就支持静态类型，就是它的一个重要优势。

4. Dart团队的支持

   由于有Dart团队的积极投入，Flutter团队可以获得更多、更方便的支持，正如Flutter官网所诉：“我们正与Dart社区进行密切合作，以改进Dart在Flutter中的使用。例如，当我们最初使用Dart时，该语言并没有提供生成原生二进制文件的工具链（工具链对于实现可预测的高性能具有很大的帮助），但是现在它实现了，因为Dart团队专门为Flutter构建了它。同样，Dart VM之前已经针对吞吐量进行了优化，但团队现在正在优化VM的延迟时间，这对于Flutter的工作负载更为重要。”



## 4.一切皆为widget

Widget是Flutter应用程序用户界面的基本构建块。每个Widget都是用户界面一部分的不可变声明。 与其他将视图、控制器、布局和其他属性分离的框架不同，Flutter具有一致的统一对象模型：widget。

Widget可以被定义为:

- 一个结构元素（如按钮或菜单）
- 一个文本样式元素（如字体或颜色方案）
- 布局的一个方面（如填充）
- 等等…

## 5.Flutter与React Native、Weex比较

React Native、Weex等一直存在一个问题，就是性能跟原生App存在很大的差异

**原生app**

苹果2008年发布iOS，Google 2009年发布Android，它们的SDK是基于两种不同的编程语言Objective-C 和 Jave.现在又有了Swift和Kotlin。

**WebViews**

最早的跨平台方案是基于JaveScript 和 WebView的，像PhoneGap、Cordova、Ionic等。

**React Native**

RN不仅桥接系统服务，也将系统UI也桥接到了JaveScript中，这样写出来的UI最终也会渲染成原生的控件。

**Flutter**

Flutter使用Dart语言开发，Dart可以被编译（AOT）成不同平台的本地代码，让Flutter可以直接和平台通讯而不需要一个中间的桥接过程，从而提高了性能。
