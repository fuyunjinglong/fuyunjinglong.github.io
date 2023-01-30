---
title: Flutter
date: 2022-05-10 06:33:16
categories:
- I_移动端
toc: true # 是否启用内容索引
---

# 1.Flutter是什么?

[Flutter官网](https://flutter.dev/)

Flutter是一款移动应用程序SDK，一份代码可以同时生成iOS和Android两个高性能、高保真的应用程序。

Flutter诞生过程：

- 2017 年 Google I/O 大会上，Google 首次推出了一款新的用于创建跨平台、高性能的移动应用框架——Flutter。
- 2018年2月，Flutter发布了第一个Beta版本，同年五月， 在2018年Google I/O 大会上，Flutter 更新到了 beta 3 版本。
- 2018年6月，Flutter发布了首个预览版本，这意味着 Flutter 进入了正式版（1.0）发布前的最后阶段。

# 2.Flutter优势

- 提高开发效率
  - 同一份代码开发iOS和Android
  - 用更少的代码做更多的事情
  - 轻松迭代
    - 在应用程序运行时更改代码并重新加载（通过热重载）
    - 修复崩溃并继续从应用程序停止的地方进行调试
- 创建美观，高度定制的用户体验
  - 受益于使用Flutter框架提供的丰富的Material Design和Cupertino（iOS风格）的widget
  - 实现定制、美观、品牌驱动的设计，而不受原生控件的限制

# 3.核心模块

<img src="/img/image-20220510071129446.png" alt="image-20220510071129446" style="zoom:67%;" />

Flutter包括一个现代的响应式框架、一个2D渲染引擎、现成的widget和开发工具。

## 跨平台自绘引擎

Flutter与其他用于构建App的大多数框架不同，因为Flutter既不使用WebView，也不使用平台（Android、iOS等）的原生控件。相反，Flutter使用自己的高性能渲染引擎来绘制Widget。这样不仅可以保证在Android和iOS平台上UI的一致性，而且也可以避免对原生控件依赖而带来的限制及高昂的维护成本。

Flutter使用Skia作为其2D渲染引擎，Skia是Google的一个2D图形处理函数库，包含字型、坐标转换以及点阵图都有高效能且简洁的表现，Skia是跨平台的，并提供了非常友好的API，目前Google Chrome浏览器和Android均采用Skia作为其绘图引擎，值得一提的是，由于Android系统已经内置了Skia，所以Flutter在打包APK（Android应用安装包）时，不需要再将Skia打入APK中，但iOS系统并未内置Skia，所以构建iPA时，也必须将Skia一起打包，这也是为什么Flutter APP的Android应用安装包比iOS应用安装包小的主要原因。

## 高性能

Flutter采用GPU渲染技术，Flutter编写的应用是可以达到120fps（每秒传输帧数），这也就是说，它完全可以胜任游戏的制作，而我们常说的RN的性能只能达到60fps，这也算是Flutter的一个超高竞争力，官方宣称Flutter甚至会超过原生性能。

Flutter高性能主要靠两点来保证：

- 首先，Flutter App采用Dart语言开发，Dart在JIT（即时编译）模式下，速度与JavaScript基本持平；而且Dart还支持AOT（提前编译）模式，当以AOT模式运行时，JavaScript便远远追不上了。速度的提升对高帧率下的视图数据计算很有帮助。
- 其次，Flutter使用自己的渲染引擎来绘制UI，布局数据等由Dart语言直接控制，所以在布局过程中不需要像RN那样通过JavaScriptCore在JavaScript和原生之间进行通信，这在一些滑动和拖动的场景下具有明显优势，因为在滑动和拖动过程中往往都会引起布局发生变化，所以JavaScript需要和原生之间不停的同步布局信息，这和在浏览器中要JavaScript频繁操作DOM所带来的问题是相同的，都会带来比较可观的性能开销。

## 为什么Flutter采用Dart语言开发？

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



# 4.一切皆为widget

Widget是Flutter应用程序用户界面的基本构建块。每个Widget都是用户界面一部分的不可变声明。 与其他将视图、控制器、布局和其他属性分离的框架不同，Flutter具有一致的统一对象模型：widget。

Widget可以被定义为:

- 一个结构元素（如按钮或菜单）
- 一个文本样式元素（如字体或颜色方案）
- 布局的一个方面（如填充）
- 等等…

# 5.Flutter与React Native、Weex比较

React Native、Weex等一直存在一个问题，就是性能跟原生App存在很大的差异

## 原生app

苹果2008年发布iOS，Google 2009年发布Android，它们的SDK是基于两种不同的编程语言Objective-C 和 Jave.现在又有了Swift和Kotlin。

## WebViews

最早的跨平台方案是基于JaveScript 和 WebView的，像PhoneGap、Cordova、Ionic等。

## React Native

RN不仅桥接系统服务，也将系统UI也桥接到了JaveScript中，这样写出来的UI最终也会渲染成原生的控件。

## Flutter

Flutter使用Dart语言开发，Dart可以被编译（AOT）成不同平台的本地代码，让Flutter可以直接和平台通讯而不需要一个中间的桥接过程，从而提高了性能。

# 参考

[Flutter学习仓库](https://github.com/chinabrant/flutter_study)

[Github Flutter源码仓库](https://github.com/flutter/flutter)

[Flutter中文网](https://flutterchina.club/)