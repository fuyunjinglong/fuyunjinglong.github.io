---
title: CSS_0基础
date: 2022-06-26 07:33:16
categories:
- C_H5和CSS
toc: true # 是否启用内容索引常
---

# CSS

## 盒子的水平居中方案

**五种方案**

- 定位的三种
- display:flex
- javascript
- display:table-cell

```
<body>
	<div class="box" id="box"></div>
</body>

body{
	position:relative;
}
// 定位方案1必须要有宽高
.box{
	position:absolute;
	top:50%;
	left:50%;
	margin-top:-25px;
	margin-left:-25px;
}
// 定位方案2必须要有宽高
.box{
	position:absolute;
	top:0;
	left:0;
	right:0;
	bottom:0;
	margin:auto;
}
// 定位方案3，不兼容IE
.box{
	position:absolute;
	top:50%;
	left:50%;
	transform:translate(-50%,-50%);
}

// flex水平垂直居中
.box{
	display:flex;
.con{
	margin:auto;
}
}

JS方案
let html = document.documentElement,
	winW = html.clientWidth,
	winH = html.clientHeight,
	boxW = box.offsetWidth,.// box为id,可以直接用，不需要声明
	boxH = box.offsetHeight
box.style.position = 'absolute';
box.style.left = (winW - boxW)/2 + 'px';
box.style.top = (winH - boxH)/2 + 'px';

table-cell方案，比较少用,要求父元素必须有宽高
body{
	display:table-cell;
	vertical-align:middle;
	tex-align:center;
	width:500px;
	height:300px;
}
.box{
	display:inline-block;
}
```

## 盒模型

盒子由四个属性组成，从内到外分别是：**content 内容**、**padding 内填充**、**border 边框**、**外边距 margin**

**盒子分类：**

- **W3C 盒子模型(标准盒模型)**
- **IE 盒子模型(怪异盒模型)**

**宽度和高度的计算方式:**

- 标准盒模型：width = content
- 怪异盒模型:  width = content+ padding+ border

**CSS 设置这两个模型:**

- 标准盒模型  box-sizing：content-box,如果加了padding，高度会变化。
- 怪异盒模型 box-sizing: border-box,比较方便，常用，大量第三方库默认使用此模型。

**外边距合并**

块的顶部外边距和底部外边距有时被组合(折叠)为单个外边距，其大小是组合到其中的最大外边距，这种行为称为**外边距合并**。

[CSS 的两种盒模型](https://zhuanlan.zhihu.com/p/110617108)

## Less/Sass等css预处理器

 1)历史
 Sass:2007年诞生，对css层叠式样式的扩展。Scss是Sass3.0引入的新语法，是Sass CSS的简写。
 Less:2009年的开源项目。
 2)背景
 因为css是单纯的属性描述，不具变量和条件语句。没有变量和合理的样式复用机制。
 3)共同特征
 1.混入Mixins;2.参数混入；3.嵌套规则，class嵌套class.4.颜色功能，能编辑颜色。5.作用域，局部修改。6.js赋值，css中使用js表达式
 4)不同之处
 1.less基于js,可直接引入less.js；sass引入需要安装ruby
 2.less使用简单，没有裁剪css原特性；
 3.sass功能更强大，有配套的二次开发库Compass。

## BFC和外边距重叠

三种常见方案：
普通流 (normal flow)
浮动 (float)
绝对定位

BFC 即 Block Formatting Contexts (块级格式化上下文)，它属于上述定位方案的普通流。
具有 BFC 特性的元素可以看作是隔离了的独立容器，容器里面的元素不会在布局上影响到外面的元素，并且 BFC 具有普通容器所没有的一些特性。

**触发 BFC**

- body 根元素
- 浮动元素：float 除 none 以外的值
- 绝对定位元素：position (absolute、fixed)
- display 为 inline-block、table-cells、flex
- overflow 除了 visible 以外的值 (hidden、auto、scroll)

**BFC特性应用**

1.同一个 BFC 下外边距会发生折叠,如果想要避免外边距的重叠，可以将其放在不同的 BFC 容器中。
2.BFC 可以包含浮动的元素（清除浮动）

3.BFC 可以阻止元素被浮动元素覆盖

## 清除浮动

1.父级div定义 overflow: auto（注意：是父级div也就是这里的 div.outer），最常用。
2.添加新的子元素 、应用 clear：both；

## css2.0与css3.0

css3加强了css2的功能，增加了新的属性和新的标签，并且删除了一些冗余的标签，在布局方面减少了代码量。

例如圆角、阴影、:last-child与:nth-last-child()伪类选择器等。

- css3代码更简洁、结构更合理、性能和效果得到兼顾；

- css3兼容性没有css2兼容性好，很多新属性需要加上浏览器兼容前缀；
- css3能仅使用代码就实现的效果，css2需要使用图片来实现；
- css2请求服务器次数高于css3；

## css样式各种浏览器适配问题

待续

## [css modules和scoped区别](https://segmentfault.com/a/1190000021670036)

vue项目中有两种解决css冲突的方案，一种是比较常见的使用scoped。另一种就是css modules。

(1)scoped方案

当在style标签中加上scoped，编译后会在该vue组件元素上加上hash标识属性，在vue组件里的每个元素都有同一个hash标识属性。无法完全避开css权重和类名重复的问题。

```
 <div class="example" data-v-f3f3eg9>hi</div> 
```

(2)css modules方案

产生局部作用域的唯一方法，就是使用一个独一无二的`class`的名字，为所有类名重新生成类名，有效避开了css权重和类名重复的问题，这就是 CSS Modules 的做法。css module直接替换了类名，排除了用户设置类名影响组件样式的可能性。

区别：

- scoped方案在其他地方使用相同类名可能还是会影响组件样式，如果你子组件的某元素上有一个类已经在这个父组件中定义过了，那么这个父组件的样式就会泄露到子组件中。但是css modules方案通过算法计算出唯一类名替换原始类名避免了这种样式冲突。
- 还有一些情况是我们需要对我们的子组件的深层结构设置样式——虽然这种做法并不受推荐且应该避免。为了简便起见，我们假设我们的父组件现在要对子组件设置样式，在 scoped 样式中，这种情况可以使用 `>>>` 连接符（或者 `/deep/` ）实现。
- scoped会使**标签选择器**渲染变慢很多倍，而使用class或id则不会。
- 模块式 CSS 与 JS 有着很好的互操作性 (interoperability)，这一点不只局限于 CSS 类。

## flex = 1问题

flex: 1等价于`flex: 1 1 0`，也就是

> ```css
> flex-grow : 1;
> flex-shrink : 1;
> flex-basis : 0;
> ```

- flex-grow 表示当有剩余空间的时候，分配给项目的比例,应用到内容区域高度不够的时候。
- flex-shrink 表示空间不足的时候，项目缩小的比例
- flex-basis 表示分配空间之前，项目占据主轴的空间

**flex-grow**

假设有一个宽度为 800 的容器，里面有 3 个项目，宽度分别是 100，200，300：

```js
<div class="container">
  <div class="left">left</div>
  <div class="middle">middle</div>
  <div class="right">right</div>
</div>

.container {
  display: flex;
  width: 800px;
  height: 300px;
  background: grey;
}

.left {
  flex-basis: 100px;
  background: linear-gradient(to bottom right, green, white);
}

.middle {
  flex-basis: 200px;
  background: linear-gradient(to bottom right, yellow, white);
}

.right {
  flex-basis: 300px;
  background: linear-gradient(to bottom right, purple, white);
}
```

这时候就出现了多余的 200 的空间（灰色部分）。这时候如果我们对左中右分别设置`flex-grow`为 2，1，1，各个项目的计算逻辑如下：

1. 首先将多余空间 200 除以 4（2 + 1 + 1），等于 50
2. left = 100 + 2 x 50 = 200
3. middle = 200 + 1 x 50 = 250
4. right = 300 + 1 x 50 = 350

**flex-shrink（默认值 1）**

假设父容器宽度调整为 550，里面依然是 3 个项目，宽度分别是 100，200，300，这时候空间就不够用溢出了。首先要理解清楚，当我们定义一个固定宽度容器为`flex`的时候，`flex`会尽其所能不去改变容器的宽度，而是压缩项目的宽度。这时我们对左中右分别设置`flex-shrink`为 1，2，3，计算逻辑如下：

1. 溢出空间 = 100 + 200 + 300 - 550 = 50
2. 总权重 = 1 x 100 + 2 x 200 + 3 x 300 = 1400
3. left = 100 - (50 x 1 x 100 / 1400) = 96.42
4. middle = 200 - (50 x 2 x 200 / 1400) = 185.72
5. right = 300 - (50 x 3 x 300 / 1400) = 267.86

**flex-basis（默认值 auto）**

`flex-basis`指定项目占据主轴的空间，如果不设置，则等于内容本身的空间

## 回流和重绘

**回流比重绘的代价要更高。**

![image-20220301072618199](/img/image-20220301072618199.png)

**1.回流**(对应排列)

当`Render Tree`中部分或全部元素的尺寸、结构、或某些属性发生改变时，浏览器重新渲染部分或全部文档的过程称为回流。

```
会导致回流的操作：
页面首次渲染
浏览器窗口大小发生改变
元素尺寸或位置发生改变
元素内容变化（文字数量或图片大小等等）
元素字体大小变化
添加或者删除可见的DOM元素
激活CSS伪类（例如：:hover）
查询某些属性或调用某些方法

导致回流的属性和方法：
clientWidth、clientHeight、clientTop、clientLeft
offsetWidth、offsetHeight、offsetTop、offsetLeft
scrollWidth、scrollHeight、scrollTop、scrollLeft
scrollIntoView()、scrollIntoViewIfNeeded()
getComputedStyle()
getBoundingClientRect()
scrollTo()
```

**2.重绘**(对应绘制)

当页面中元素样式的改变并不影响它在文档流中的位置时（例如：`color`、`background-color`、`visibility`等），浏览器会将新样式赋予给元素并重新绘制它。

**3.为什么要优化？**

浏览器会维护一个队列，把所有引起回流和重绘的操作放入队列中，如果队列中的任务数量或者时间间隔达到一个阈值的，浏览器就会将队列清空，进行一次批处理，这样可以把多次回流和重绘变成一次。

重排和重绘不只是对单个的dom元素进行操作，而是对整个【图层】进行操作，需要花费时间，如果频率高，非常的影响性能。所以有时候有必要开启另一个图层操作。

```
那么什么情况可以开启图层？
1、css 3D变化的图形 ---- transform: translateX(0)
2、html5中的<video>标签
3、canvas绘图中的节点
4、css 动画的节点 --- keyframes animation
5、拥有css加速属性 --- will-change: transform
```

**优化手段：**

(1)CSS

```
使用 transform 替代 top
使用 visibility 替换 display: none ，因为前者只会引起重绘，后者会引发回流（改变了布局
避免使用table布局，可能很小的一个小改动会造成整个 table 的重新布局。
尽可能在DOM树的最末端改变class，回流是不可避免的，但可以减少其影响。尽可能在DOM树的最末端改变class，可以限制了回流的范围，使其影响尽可能少的节点。
避免设置多层内联样式，CSS 选择符从右往左匹配查找，避免节点层级过多。
将动画效果应用到position属性为absolute或fixed的元素上，避免影响其他元素的布局，这样只是一个重绘，而不是回流，同时，控制动画速度可以选择 requestAnimationFrame，详见探讨 requestAnimationFrame。
避免使用CSS表达式，可能会引发回流。
将频繁重绘或者回流的节点设置为图层，图层能够阻止该节点的渲染行为影响别的节点，例如will-change、video、iframe等标签，浏览器会自动将该节点变为图层。
CSS3 硬件加速（GPU加速），使用css3硬件加速，可以让transform、opacity、filters这些动画不会引起回流重绘 。但是对于动画的其它属性，比如background-color这些，还是会引起回流重绘的，不过它还是可以提升这些动画的性能。
```

(2)JS

```
避免频繁操作样式，最好一次性重写style属性，或者将样式列表定义为class并一次性更改class属性。
避免频繁操作DOM，创建一个documentFragment，在它上面应用所有DOM操作，最后再把它添加到文档中。
避免频繁读取会引发回流/重绘的属性，如果确实需要多次使用，就用一个变量缓存起来。
对具有复杂动画的元素使用绝对定位，使它脱离文档流，否则会引起父元素及后续元素频繁回流。
```

## **first-child与:first-of-type的区别**

> :first-child 匹配的是某父元素的第一个子元素，可以说是结构上的第一个子元素。

> :first-of-type 匹配的是某父元素下相同类型子元素中的第一个，比如 p:first-of-type，就是指所有类型为p的子元素中的第一个。这里不再限制是第一个子元素了，只要是该类型元素的第一个就行了。

同样类型的选择器 :last-child 和 :last-of-type、:nth-child(n) 和 :nth-of-type(n) 也可以这样去理解。

# 

# CSS常见布局

- 圣杯布局-左右固定，中间自适应
- 双飞翼布局-左右固定，中间自适应
- 使用flex布局

圣杯式布局代码：

```
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport"
        content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>圣杯式布局</title>
    <style>
        * {
            padding: 0;
            margin: 0;
        }

       
        .con{
            padding-left:150px ;
            padding-right: 190px;
        }
        .left {
            width: 150px;
            background: red;
            float: left;
            position: relative;
            margin-left: -100%;
            left: -150px;
        }

        .main {
            width: 100%;
            background: yellow;
            float: left;
        }

        .right {
            width: 190px;
            background: tomato;
            float: left;
            position: relative;
            margin-right: -190px;
            left: -190px;
        }
    </style>
</head>

<body>
    <div class="con"> 
        <div class="main">main</div>
        <div class="left">Left</div>
       <div class="right">right</div>
    </div>

</body>
</html>
```

双飞翼布局代码：

```
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport"
        content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>双飞翼布局</title>
    <style>
        * {
            padding: 0;
            margin: 0;
        }

        .left {
            background: #E79F6D;
            width: 150px;
            float: left;
            margin-left: -100%;
        }

        .main {
            background: #D6D6D6;
            width: 100%;
            float: left;
        }

        .mc {
            margin-left: 150px;
            margin-right:190px;
        }

        .right {
            background: #77BBDD;
            width: 190px;
            float: left;
            margin-left: -190px;
          
        }
    </style>
</head>

<body>
    <div class="con">
        <div class="main">
            <div class="mc">Main</div>
        </div>
        <div class="left">Left</div>
        <div class="right">Right</div>
    </div>

</body>
</html>
```

flex布局代码：

```
.main{
	display:flex;
	justify-content:space-between;
	height:100%;
}
.left,.right{
	flex:0 0 200px;
	height:200px;
	background:lightblue;
}
.mc{
	flex:1;
	min-height:400px;
	background:red;
}
```

# 行内元素和块级元素

- 块级元素：单独占一行，默认继承父元素的宽高
- 行级元素：宽高由内容撑开。

# Tailwind CSS

[[一次就能看懂的Tailwind CSS介绍]](https://segmentfault.com/a/1190000041152680)

## CSS 发展阶段

基本经历了三个阶段。

**第一个阶段**，原生写法
是类似于编程中面向过程的写法，需要什么样式，自己在 css 中写什么样式。对代码有洁癖的程序员会进行简单的 css 复用。但是也只是简单的复用，大多数时候还是需要什么写什么，想怎么写怎么写。

**第二个阶段**，CSS 组件化。
类似于编程中面向对象的写法，将相同视觉的 UI 封装成一个组件。比如一个按钮，整个项目中，这个按钮被多次使用，并且样式一致。那么就可以封装成一个按钮类。使用的时候直接使用这个类名称就 OK。

这也是 bootstrap，element ui，Antd，bulma 的做法。

这种框架的优势在于，封装了大量常见的 UI。比如你需要一个表单，，需要一个导航，需要一个弹窗，Card 卡片。有现成的 class。直接拿过来用，就可以快速的完成效果。完全不需要动手写 css。

这也是目前比较流行的方法。这几年几乎很少有项目是自己一点一点手写样式的了，多多少少都会使用到一些 css 框架。

对于一些需要快速交付的项目，非常适合使用这种组件化 css 框架。

**第三个阶段**，CSS 零件化。
也叫做 CSS 原子化。和上面第一个阶段第二个阶段都有类似的地方。依旧是组件，只是每个组件都是一个单一功能的 css 属性。

上面第一个阶段的时候，我们讲了有些有对代码有追求的人，会开始复用 css。
比如页面中大量的用到 float:left。那么就可以封装一个类，比如是这样

.left {float:left}
然后需要使用 float:left 的时候，直接使用.left 就可以。

## 什么是Tailwind CSS 

Tailwind CSS 是一个利用公用程序类（`Utilize Class`，下文皆称Utilize Class）的 CSS 框架。许多人会想到 CSS 框架，有很多，例如 `Bootstrap、Bulma 和 Material UI`。Bootstrap 和 Bulma 等框架利用预先准备好的组件（例如按钮、菜单和面包屑）进行设计。在 Tailwind CSS 中，没有准备任何组件，而是使用`Utilize Class`来创建和设计自己的组件。

> Tailwind CSS 还提供了一个Headless UI ([https://headlessui.dev](https://link.segmentfault.com/?enc=SVI0nzk7qsZYqdPG%2FpzBEg%3D%3D.5QrLqST7P6RWcCnbCD7z%2FJq9MherxCBMIsMCAX5fpK0%3D))，如果你想创建复杂的组件（例如下拉菜单和对话框），你可以使用它。

原来Bootstrap等框架可以通过提前准备组件集合来高效地设计网站，但是有一个缺点，就是因为使用了相同的设计，所以没有原创性。相比之下，Tailwind CSS 没有组件集合，所以即使你创建一个名为相同按钮的组件，每个人都会应用不同的`Utilize Class`创建它，可以创建出一个高度原创的网站。

## Tailwind CSS优缺点

**优点：**

1.可定制化程度极高。
你可以随心所欲写出自己的样式。想怎么折腾怎么折腾。
如果使用 bootstrap，你如果想改变一个按钮的样式，就会比较困难。你得用覆盖式的写法，通过自己的样式覆盖掉 bootstrap 自带的样式。如果框架本身不支持修改，你通过自己的写法去修改框架本身的特性，这是一种很脏的写法。非常别扭。
但是这个问题在 Tailwind CSS 完全不存在。Tailwind CSS 没有自以为是的封装任何样式给你。

2.不需要在写 css。
使用 Tailwind CSS，基本可以不用再写 css。所有的效果都可以通过 class 名来完成。我用 Tailwind CSS 写了几个页面，到目前为止，还没有写过一行 css。

3.不需要再为 class 取个什么名字而苦恼。
对于经常手写 css 的程序员来说，最大的噩梦可能就是怎么给 class 取名了。尤其是在同一个区块里面，区块名称，子元素名称，等等，一个页面动辄几十个几百个类名。非常痛苦。而这其中，真正能复用的 class 可能就个别几个。

使用 Tailwind CSS 完全不用为取名字烦恼，因为所有的 css 属性都被框架语义化封装好了。只需要在 class 里面引用就好。

4.响应式设计
Tailwind CSS 遵循移动优先的设计模式。断点系统很灵活。也是目前所有 css 框架里做的最好的。比如你要实现一个媒体查询，根据不同的屏幕宽度实现不同的图片宽度。

**缺点：**

1.类名很长
正如 Tailwind CSS 官网首页的口号一样，从此让你写样式不再离开 html 页面。Tailwind CSS 将 HTML 与 CSS 高度解耦，把本来 CSS 的一些工作转嫁给了 HTML。好处是使用 Tailwind CSS 你可以从此不再写 css。但坏处是你的 html 标签的类名会很长很长。比如

```
<a href="#" class="text-sm font-medium bg-purple-600 rounded-full py-4 px-11 text-white inline-block border border-solid shadow hover:text-purple-600 hover:bg-white hover:border-purple-600 transition duration-300" role="button">Start Ticketing</a>
```

2.熟悉使用有成本
这一点逃避不了，所有的新技术，所有的 css 框架都有熟悉成本。Tailwind CSS 也一样。比如你想做一个圆角，那你得知道 Tailwind CSS 里面的圆角属性怎么写，边框怎么写，边框样式怎么写等等。你需要不断的去看文档。

# CSS选择器优先级

ID > 类 > 标签 > 相邻 > 子选择器 > 后代选择器 > * > 属性 > 伪类

# Grid布局

[张鑫旭的grid](https://www.zhangxinxu.com/wordpress/2018/11/display-grid-css-css3/#grid-template-columns-rows)

[最大强大Grid](https://juejin.cn/post/6854573220306255880#heading-8)

**`flex` 布局是一维布局，主要用于局部布局，`Grid` 布局是二维布局，用于大结构布局**

给`<div>`这类块状元素元素设置`display:grid`或者给`<span>`这类内联元素设置`display:inline-grid`，Grid布局即创建

基础概念的[演示地址](https://link.juejin.cn/?target=https%3A%2F%2Fcodepen.io%2Fgpingfeng%2Fpen%2FQWyoexm%3Feditors%3D1100)

| **作用在grid容器上**                                         | **作用在grid子项上**                                         |
| ------------------------------------------------------------ | ------------------------------------------------------------ |
| [grid-template-columns：纵向分块](#grid-template-columns)    | [grid-column-start：设置元素网格线的列起点](#grid-column-start) |
| [grid-template-rows：横向分块](#grid-template-rows)          | [grid-column-end：设置元素网格线的列终点](#grid-column-end)  |
| [grid-template-areas：定制区域结构](#grid-template-areas)    | [grid-row-start：设置元素网格线的行起点](#grid-row-start)    |
| [grid-template：行列分块的缩写](#grid-template)              | [grid-row-end：设置元素网格线的行终点](#grid-row-end)        |
| [grid-column-gap：列块间距](#grid-column-gap)                | [grid-column：子项的列起始点的缩写](#grid-column)            |
| [grid-row-gap：行块间距](#grid-row-gap)                      | [grid-row：子项的行起始点的缩写](#grid-row)                  |
| [grid-gap：行列块间距的缩写](#grid-gap)                      | [grid-area：子项的行列起始点的缩写](#grid-area)              |
| [justify-items：每个子项的水平的左中右对齐](#justify-items)  | [justify-self：子项内部的水平对齐方式](#justify-self)        |
| [align-items：每个子项的垂直的上中下对齐](#align-items)      | [align-self：子项内部的垂直对齐方式](#align-self)            |
| [place-items：每个子项的水平垂直的缩写](#place-items)        | [place-self：子项内部的水平垂直的缩写](#place-self)          |
| [justify-content：子项整体的水平的左中右对齐](#justify-content) |                                                              |
| [align-content：子项整体的垂直的上中下对齐](#align-content)  |                                                              |
| [place-content：子项整体的水平垂直的缩写](#place-content)    |                                                              |
| [grid-auto-columns：超出容器的部分，纵向分块](#grid-auto-columns) |                                                              |
| [grid-auto-rows：超出容器的部分，横向分块](#grid-auto-rows)  |                                                              |
| [grid-auto-flow：排列方式为先行或先列](#grid-auto-flow)      |                                                              |
| [grid：大集合](#grid)                                        |                                                              |

**双命名**

由于网格中中间区域的网格线是两边格子公用的，就像道路有两边，因此，我们起名字的时候可以起两个名称（使用空格分隔），分别表示两侧。例如：

```css
.container {
    grid-template-columns: [第一根纵线] 80px [第1根纵线结束 第2根纵线开始] 100px [最后的结束线];
}
```

**repeat语法**

有时候，我们网格的划分是很规律的，例如，基于`40px`创建栅格，要是我们布局宽度`960px`，岂不是要写24次`40px`，实在套啰嗦了，此时，就可以使用`repeat()`语法，如下示意：

```css
.container {
    grid-template-columns: repeat(24, 40px);
}
```

等同于：

```cpp
.container {
    grid-template-columns: 40px, 40px, /* ...省略20个...*/, 40px, 40px;
}
```

**fr单位是什么？**

`fr`是单词fraction的缩写，表示分数。

- 先从简单例子看起：

  ```css
  .container {
      grid-template-columns: 1fr 1fr 1fr;
  }
  ```

  1:1:1，网格宽度三等分

- 如果有固定尺寸值，则划分剩余空间大小，例如：

  ```css
  .container {
      grid-template-columns: 200px 1fr 1fr 1fr;
  }
  ```

  4列，后面3列宽度是grid容器宽度减去200像素后的1/3大小

- 如果和auto混用会如何呢？

  ```cpp
  .container {
      grid-template-columns: auto 1fr 1fr 1fr;
  }
  ```

  `auto`的尺寸表现为“包裹”，为内容宽度



## 作用在grid容器上的CSS属性

### grid-template-columns

纵向分块，分多少个块，每块多少单位

```
.container {
    grid-template-columns: 80px auto 100px;
    grid-template-rows: 25% 100px auto 60px;
}
```

### grid-template-rows

横向分块，分多少个块，每块多少单位

```
.container {
    grid-template-columns: 80px auto 100px;
    grid-template-rows: 25% 100px auto 60px;
}
```

### grid-template-areas

定制区域结构。

张老板承包了一块地，然后划分成了3*4共12个小格子，然后张老板希望最上面3个格子种葡萄，最下面3个格子种西瓜，中间6个格子，左边2个养龙虾，右边4个养鱼。

```
.container {
    grid-template-columns: 1fr 1fr 1fr;
    grid-template-rows: 1fr 1fr 1fr 1fr;
    grid-template-areas: 
        "葡萄 葡萄 葡萄"
        "龙虾 养鱼 养鱼"
        "龙虾 养鱼 养鱼"
        "西瓜 西瓜 西瓜";
}
```

```
<div class="container">
    <div class="putao"></div>
    <div class="longxia"></div>
    <div class="yangyu"></div>
    <div class="xigua"></div>
</div>
```

```
.putao { grid-area: 葡萄; }
.longxia { grid-area: 龙虾; }
.yangyu { grid-area: 养鱼; }
.xigua { grid-area: 西瓜; }
```

### grid-template

行列分块的缩写

`grid-template`是`grid-template-rows`，`grid-template-columns`和[`grid-template-areas`](https://www.zhangxinxu.com/wordpress/2018/11/display-grid-css-css3/#grid-template-areas)属性的缩写。

```
.container {
    grid-template: <grid-template-rows> / <grid-template-columns>;
}
```

### grid-column-gap

列块间距

### grid-row-gap

行块间距

### grid-gap

行列块间距的缩写

`grid-gap`属性是`grid-column-gap`和`grid-row-gap`属性的缩写

推荐使用`gap`属性作为缩写，`grid-gap`已经很老了。

```
.container {
    grid-gap: <grid-row-gap> <grid-column-gap>;
}
```

**`align-items`和`align-content`的区别**

>1. **`align-items`属性是针对单独的每一个flex子项起作用，它的基本单位是每一个子项，在所有情况下都有效果（当然要看具体的属性值）。**
>2. **`align-content`属性是将flex子项作为一个整体起作用，它的基本单位是子项构成的行，只在两种情况下有效果：①子项多行且flex容器高度固定 ②子项单行，flex容器高度固定且设置了`flex-wrap:wrap;`**

### justify-items

每个子项的水平的左中右对齐

### align-items

每个子项的垂直的上中下对齐

### place-items

每个子项的水平垂直的缩写

place-items是align-items`和`justify-items的缩写

```
.container {
    place-items: <align-items> <justify-items>?;
}
```

### justify-content

子项整体的水平的左中右对齐

### align-content

子项整体的垂直的上中下对齐

### place-content

子项整体的水平垂直的缩写

place-content是align-content`和`justify-content的缩写

```
.container {
    place-content: <align-content> <justify-content>?;
}
```

### grid-auto-columns

对超出容器后的部分，纵向分块

### grid-auto-rows

对超出容器后的部分，横向分块

### grid-auto-flow

指定排列方式：默认row,横向排列。也可以column纵向排列

### grid

大集合，[`grid-template-rows`](https://www.zhangxinxu.com/wordpress/2018/11/display-grid-css-css3/#grid-template-columns-rows)，[`grid-template-columns`](https://www.zhangxinxu.com/wordpress/2018/11/display-grid-css-css3/#grid-template-columns-rows)，[`grid-template-areas`](https://www.zhangxinxu.com/wordpress/2018/11/display-grid-css-css3/#grid-template-areas)，[`grid-auto-rows`](https://www.zhangxinxu.com/wordpress/2018/11/display-grid-css-css3/#grid-auto-columns-rows)，[`grid-auto-columns`](https://www.zhangxinxu.com/wordpress/2018/11/display-grid-css-css3/#grid-auto-columns-rows)和[`grid-auto-flow`](https://www.zhangxinxu.com/wordpress/2018/11/display-grid-css-css3/#grid-auto-flow)。

```
grid: <grid-template-rows> / [ auto-flow && dense? ] <grid-auto-columns>? 
```

**具体说明：**

- `auto-flow && dense?`其实就是`grid-auto-flow`属性的值，等同于`row`或`column`或`row dense`或`column dense`。

  但这里`row`和`column`这两个关键字却使用了`auto-flow`这一个关键字代替了。那岂不有问题：什么时候解析成`row`，什么时候解析成`column`呢？

  原来，是根据`auto-flow`关键字是在斜杠的左侧还是右侧决定的。如果`auto-flow`关键字在斜杠左侧，则解析为`row`，如果是在右侧，则解析为`column`。这里的语法是在斜杠的右侧，因此，会将`grid-auto-flow`解析为`column`。

- `<grid-auto-columns>`后面有个问号`?`，因此是可以省略的，如果省略，则将`grid-auto-columns`解析为`auto`。

## 作用在grid子项上的CSS属性

### grid-column-start

设置元素网格线的列起点。索引从1开始。

```
<div class="container">
    <div class="item-a"></div>
</div>

.container {
  display:grid;
    grid-template-columns:  80px auto  100px ;
    grid-template-rows:  25% 100px auto ;
    height:300px;
    backGround-color:red;
}
.item-a {
    grid-column-start: 2;
    grid-column-end: 3;
    grid-row-start: 2;
    grid-row-end: 3;
    backGround-color:blue;
}
```

### grid-column-end

设置元素网格线的列终点

### grid-row-start

设置元素网格线的行起点

### grid-row-end

设置元素网格线的行终点

### grid-column

子项的列起始点的缩写。

grid-column是`grid-column-start`+ `grid-column-end`的缩写

```
.item-b {
    grid-column: 2 / span 纵线3;
    grid-row: 第一行开始 / span 3;
}
```

### grid-row

子项的行起始点的缩写。

grid-row是grid-row-start + grid-row-end的缩写

### grid-area

子项的行列起始点的缩写。

grid-area其实是grid-row-start, grid-column-start, grid-row-end 以及 grid-column-end属性的缩写。

```
.item {
    grid-area: <name> | <row-start> / <column-start> / <row-end> / <column-end>;
}

.container {
    grid-template: 1fr 1fr 1fr/1fr 1fr 1fr 1fr;
}
.item-c { 
    grid-area: 1 / 2 / 3 / 4;
}
```

### justify-self

子项内部的水平对齐方式

### align-self

子项内部的垂直对齐方式

### place-self

子项内部的水平垂直的缩写

`place-self` 是设置 `align-self` 和 `justify-self` 的缩写。

```
.item {
    place-self: <align-self> <justify-self>?
}
```

## 注意

- 在Grid布局中，`float`，`display:inline-block`，`display:table-cell`，`vertical-align`以及`column-*`这些属性和声明对grid子项是没有任何作用的。这个可以说是Grid布局中的常识，面试经常会问的，一定要记得。
- Grid布局则适用于更大规模的布局（二维布局），而Flexbox布局最适合应用程序的组件和小规模布局（一维布局），关Flex布局请参见“[写给自己看的display: flex布局教程”一文](https://www.zhangxinxu.com/wordpress/?p=8063)。
- 命名虽然支持中文，但由于CSS文件中文存在乱码的风险，所以……创新还是保守就看大家自己的抉择了。
- IE10-IE15虽然名义上支持Grid布局，但支持的是老版本语法（本文是介绍的全是2.0全新语法），还需要加`-ms-`私有前缀，精力原因，IE下的使用并未深究，以后有机会再补充。

# Flex弹性布局

[flex实战原文](https://tsejx.github.io/css-guidebook/layout/basic/flexible-box-layout#flex-order)

## 容器属性

### flex-direction

`flex-direction` 属性决定主轴的方向，继而决定子项在容器中的位置。

```css
.container {
  flex-direction: row | row-reverse | column | column-reverse;
}
```

- `row`（默认值）：表示子项从左向右排列。此时**水平方向轴**为主轴。
- `row-reverse`：表示子项从右向左排列。
- `column`：表示子项从上向下排列。此时**垂直方向轴**为主轴。
- `column-reverse`：表示子项从下向上排列。

### flex-wrap

`flex-wrap` 属性用于指定弹性布局中子项是否换行。

```css
.container {
  flex-wrap: nowrap | wrap | wrap-reverse;
}
```

- `nowrap`（默认值）：表示不换行，所有子项目单行排列，子项可能会溢出。
- `wrap`：表示换行，所有子项目多行排列，溢出的子项会被放到下一行，按从上向下顺序排列。
- `wrap-reverse`：所有子项目多行排列，按从下向上顺序排列。

### flex-flow

`flex-flow` 属性是 `flex-direction` 属性和 `flex-wrap` 属性的简写形式，默认值为 `row nowrap`。

```css
.container {
  flex-flow: < 'flex-direction' > || < 'flex-wrap' >;
}
```

### justify-content

`justify-content` 属性定义了子项在 **主轴**（水平方向）上的对齐方式。

```css
.container {
  justify-content: flex-start | flex-end | center | space-between | space-around;
}
```

- `flex-start`（默认值）：表示弹性容器子项按主轴起点线对齐
- `flex-end`：表示弹性容器子项按主轴终点线对齐
- `center`： 居中排列
- `space-between`：弹性容器子项均匀分布，第一项紧贴主轴起点线，最后一项紧贴主轴终点线，子项目之间的间隔都相等。要注意特殊情况，当剩余空间为负数或者只有一个项时，效果等同于 `flex-start`。
- `space-around`：弹性容器子项均匀分布，每个项目两侧的间隔相等，相邻项目之间的距离是两个项目之间留白的和。所以，项目之间的间隔比项目与边框的间隔大一倍。要注意特殊情况，当剩余空间为负数或者只有一个项时，效果等同于`center`。
- `space-evenly`：弹性容器子项均匀分布，所有项目之间及项目与边框之间的距离相等。

仅当 `flex-direction` 为 `row` 时生效，因为 `justify-content` 仅定义子项在水平方向上的对齐方式

### align-items

`align-items` 属性定义弹性容器子项在交叉轴（垂直方向）上的对齐方式。

```css
.container {
  align-items: flex-start | flex-end | center | baseline | stretch;
}
```

- `stretch`（默认值）：当子项未设置高度或者高度为 `atuo` 时，子项的高度设为行高。这里需要注意，在只有一行的情况下，行的高度为容器的高度，即子项高度为容器的高度。（当子项设定了高度时无法展开）
- `flex-start`：表示子项与交叉轴的起点线对齐。
- `flex-end`：表示子项与交叉轴的终点线对齐。
- `center`：表示与交叉轴的中线对齐。
- `baseline`：表示基线对齐，当行内轴与侧轴在同一线上，即所有子项的基线在同一线上时，效果等同于`flex-start`。

### align-content

`align-content` 属性定义了多根轴线的对齐方式。如果项目只有一根轴线，该属性不起作用。

核心是一定是盒子内部的元素超过了盒子项的宽度（默认）出现了换行，也就是有多行才可以。

```css
.container {
  align-content: flex-start | flex-end | center | space-between | space-around | stretch;
}
```

- `stretch`（默认值）：轴线占满整个交叉轴。（当子项设定了高度时无法展开）
- `flex-start`：表示各行与交叉轴的起点线对齐。
- `flex-end`：表示各行与交叉轴的终点线对齐。
- `center`：表示各行与交叉轴的中线对齐。
- `space-between`：与交叉轴两端对齐，轴线之间的间隔平均分布。要注意特殊情况，当剩余空间为负数时，效果等同于`flex-start`。
- `space-around`：每根轴线两侧的间隔都相等。所以，轴线之间的间隔比轴线与边框的间隔大一倍。要注意特殊情况，当剩余空间为负数时，效果等同于`center`。

⚠️ **注意**：该属性只作用于多行的情况（`flex-warp: wrap / warp-reverse`），在只有一行的弹性容器上无效，另外该属性可以很好的处理，换行以后相邻行之间产生的间距。

## 子项属性

### order

缺省情况下，Flex 子项是按照在代码中出现的先后顺序排列的。CSS3 新增加 `order` 属性定义项目的排列顺序，是数值类型。数值越小，排列越靠前，默认为 0。

> 注意此属性设置在子项上，浏览器自动按照 `order` 的大小排序盒子，默认都是 0，如果相同的 `order` 则按照编写标签的顺序排放盒子。

```css
.item {
  order: 1;
}
```

### flex-grow

`flex-grow` 属性定义子项的**扩展比例**，取值必须是一个单位的正整数，表示放大的比例。默认为 0，即如果存在额外空间，也不放大，负值无效。Flex 容器会根据子项设置的扩展比例作为比率来分配剩余空间

如果所有项目的 `flex-grow` 属性都为 1，则它们将等分剩余空间（如果有的话）。如果一个项目的 `flex-grow` 属性为 2，其他项目都为 1，则前者占据的剩余空间将比其他项多一倍。

一行的子盒子同时设置 `flex-grow` 属性的话，会根据设置的值的大小按比例排放子项。

*flex-grow 属性决定了子项要占用父容器多少剩余空间*

计算方式：

- 假设剩余空间 `x`（弹性容器宽度与所有弹性子项宽度总和之差）
- 假设有三个弹性子项元素，`flex-grow` 设定值分别为 `a`、`b` 和 `c`
- 每个元素可以分配的剩余空间为：`a/(a+b+c) * x`、`b/(a+b+c) * x` 和 `c/(a+b+c) * x`

假设剩余空间为 `150px`，`a`、`b` 和 `c` 的 `flex-grow` 分别为 1、2 和 3，那么 `a` 占比剩余空间：`1/(1+2+3) = 1/6`，那么 `a` 瓜分到的剩余空间宽度是 `150*(1/6)=25`，加上 `a` 原本的宽度，实际的宽度为 `<origin-width> + 25`。

### flex-shrink

如果子容器宽度超过父容器宽度，即使是设置了 `flex-grow`，但是由于没有剩余空间，就分配不到剩余空间了。这时候有两个办法：换行和压缩。由于 `flex` 默认不换行，那么压缩的话，怎么压缩呢，压缩多少？此时就需要用到 `flex-shrink` 属性了。

`flex-shrink` 属性定义了项目的**缩小比例**，默认为 1，即如果空间不足，该项目将缩小。

此时，剩余空间的概念就转化成了 **溢出空间**。

```css
.item {
  flex-shrink: <number>; /* default 1 */
}
```

如果所有项目的 `flex-shrink` 属性都为 1，当空间不足时，都将等比例缩小。如果一个项目的 `flex-shrink` 属性为 0，其他项目都为 1，则空间不足时，前者不缩小。

*负值对该属性无效。且如果弹性子项总和没有超出父容器，设置 `flex-shrink` 将无效。*

计算方式：

- 假设三个子项的 `width` 为：`w1`、`w2`、`w3`
- 假设三个子项的 `flex-shrink` 为：`a`、`b`、`c`
- 计算总压缩权重：`sum = a * w1 + b * w2 + c * w3`
- 计算每个元素压缩率：`s1 = a * w1 / sum`、`s2 = b * w2 / sum`、`s3 = c * w3 / sum`
- 计算每个元素宽度：`width - 压缩率 * 溢出空间`

### flex-basis

`flex-basis` 属性定义了在分配多余空间之前，项目占据的主轴空间（main size）。浏览器根据这个属性，计算主轴是否有多余空间。它的默认值为 `auto`，即项目的本来大小。

```css
.item {
  flex-basis: <number> | <percentage> | auto; /* default auto */
}
```

⚠️ **注意**：

1. 设置 `flex-grow` 进行分配剩余空间，或者使用 `flex-shrink` 进行收缩都是在 `flex-basis` 的基础上进行的；
2. 当 `flex-basis` 的值以及 `width`（或者 `height`）的值均为非 `auto` 时，
   - 若 `content` 长度同时大于 `flex-basis` 的值以及 `width`（或者 `height`）的值，此时以 `flex-basis` 与 `width`（或者 `height`）中值大的为准 ，**但是**，如果子项设置了`overflow: hidden` 或者 `overflow: auto`，此时以`flex-basis`值为准；
   - 若 `content` 长度同时小于 `flex-basis` 的值以及 `width`（或者 `height`）的值，此时以 `flex-basis` 值为准
   - 若 `content` 长度小于 `flex-basis` 的值，大于 `width`（或者 `height`）的值，此时以 `flex-basis` 值为准
   - 若 `content` 长度大于 `flex-basis` 的值，小于 `width`（或者 `height`）的值，此时以 `content` 自身长度值为准；
3. 当 `width`（或者 `height`）的值为 `auto` 时，且内容的长度大于 `flex-basis`设置的值，此时以 `content` 自身长度值为准，且**不能进行 `flex-shrink` 收缩**。相反如果内容的长度小于 `flex-basis` 设置的值，则会使用 `flex-basis` 设置的值
4. 当存在最小值 `min-width`（`min-height`）时，且 `flex-basis` 的值小于最小值时，宽度以最小值为准，当 `flex-basis` 的值大于最小值时，以 `flex-basis` 的值为准。

> 属性优先级：`max-width / min-width -> flex-basis -> width -> box`

### flex

`flex` 属性是 `flex-grow`、`flex-shrink` 和 `flex-basis` 的简写，默认值为 `0 1 auto`。后两个属性可选。

```css
.item {
  flex: none | [ < 'flex-grow' > < 'flex-shrink' >? || < 'flex-basis' > ];
}
```

该属性有两个快捷值：`auto (1 1 auto)` 和 `none (0 0 auto)`。

建议优先使用这个属性，而不是单独写三个分离的属性，因为浏览器会推算相关值。

### align-self

`align-self` 属性用于指定子项的对齐方式，可覆盖 `align-items` 属性。

默认值为 `auto`，表示继承父元素的 `align-items` 属性，如果没有父元素，则等同于 `stretch`。

```css
.item {
  align-self: auto || flex-start || flex-end || center || baseline || stretch;
}
```



# 图片裁剪压缩技术

一张 4px × 4px 的彩色图片，未压缩的的原始图像数据，就是一个 4 × 4 矩形网格，每一个网格代表一个像素。每一个像素，又是由 红，绿，蓝 三基色构成，**1 个像素点需要 3 个字节**。

## 图片压缩的原理

**1.有损压缩**

有损压缩是利用了人类对图像或声波中的某些频率成分`不敏感`的特性，允许压缩过程中`损失一定的信息`；虽然不能完全恢复原始数据，但是所损失的部分对理解原始图像的影响缩小，却换来了大得多的压缩比

本质和尺寸压缩本质上一样，用最中间的一个像素点代替周围的像素点

**2.行程长度编码法（无损压缩）**

常用的无损压缩算法，将一扫描行中`颜色值相同`的相邻像素用两个字节来表示， 第一个字节是一个**计数值**， 用于指定像素重复的次数； 第二个字节是具体**像素的值**。能够比较好地保存图像的质量，但是相对`有损压缩`来说这种方法的`压缩率比较低`

例如：499 500 500 500 501 → 499 500×3 501

**3.熵编码法（无损压缩）**

熵编码法是一种进行无损数据压缩的技术，在这个技术中一段文字中的**每个字母**被一段**不同长度的比特**(Bit)所代替。与此相对的是`LZ77`或者`LZ78`等数据压缩方法，在这些方法中原文的一段字母列被其它字母取代。

本质上看就是利用一个算法，把一段字母用一个或单个字母代替（端到端之间可以存一个压缩字符映射表）

例如：499 500 500 500 501 → -1 0 500 0 1

## 使用 Canvas 压缩图片

[图片的本质和图片压缩原理及实现](https://juejin.cn/post/7005931841672708109#heading-1)

**压缩思路：**

- 获取上传 Input 中的图片对象 File
- 将图片转换成 base64 格式
- base64 编码的图片通过 Canvas 转换压缩，这里会用到的 Canvas 的 drawImage 以及 toDataURL 这两个 Api，一个调节图片的分辨率的，一个是调节图片压缩质量并且输出的，后续会有详细介绍
- 转换后的图片生成对应的新图片，然后输出

> base64 编码指的是把二进制变成字符的过程，base64 解码就是把字符变回二进制的过程示例：
>
> - 转换前 10101101,10111010,01110110
> - 按照 [编码规则](https://link.juejin.cn?target=https%3A%2F%2Fbaike.baidu.com%2Fitem%2Fbase64%2F8545775%3Ffr%3Daladdin) 转换后 00101011, 00011011 ,00101001 ,00110110
> - 十进制 43 27 41 54
> - 对应 [码表](https://link.juejin.cn?target=https%3A%2F%2Fbaike.baidu.com%2Fitem%2Fbase64%2F8545775%3Ffr%3Daladdin) 中的值 r b p 2
> - 所以上面的24位编码，编码后的Base64值为 rbp2

- 优点：实现简单，参数可以配置化，`自定义`图片的尺寸，指定区域`裁剪`等等。
- 缺点：只有 jpeg 、webp 支持原图尺寸下图片质量的调整来达到压缩图片的效果，其他图片格式，仅能通过调节尺寸来实现

```
<template>
  <div class="container">
    <input type="file" id="input-img" @change="compress" />
    <a :download="fileName" :href="compressImg" >普通下载</a>
    <button @click="downloadImg">兼容 IE 下载</button>
    <div>
      <img :src="compressImg" />
    </div>
  </div>
</template>
<script>
export default {
  name: 'compress',
  data: function() {
    return {
      compressImg: null,
      fileName: null,
    };
  },
  components: {},
  methods: {
    compress() {
      // 获取文件对象
      const fileObj = document.querySelector('#input-img').files[0];
      // 获取文件名称，后续下载重命名
      this.fileName = `${new Date().getTime()}-${fileObj.name}`;
      // 获取文件后缀名
      const fileNames = fileObj.name.split('.');
      const type = fileNames[fileNames.length-1];
      // 压缩图片
      this.handleCompressImage(fileObj, type);
    },
    handleCompressImage(img, type) {
      const vm = this;
      let reader = new FileReader();
      // 读取文件
      reader.readAsDataURL(img);
      reader.onload = function(e) {
        let image = new Image(); //新建一个img标签
        image.src = e.target.result;
        image.onload = function() {
          let canvas = document.createElement('canvas');
          let context = canvas.getContext('2d');
          // 定义 canvas 大小，也就是压缩后下载的图片大小
          let imageWidth = image.width; //压缩后图片的大小
          let imageHeight = image.height;
          canvas.width = imageWidth;
          canvas.height = imageHeight;
          
          // 图片不压缩，全部加载展示
          context.drawImage(image, 0, 0);
          // 图片按压缩尺寸载入
          // let imageWidth = 500; //压缩后图片的大小
          // let imageHeight = 200;
          // context.drawImage(image, 0, 0, 500, 200);
          // 图片去截取指定位置载入
          // context.drawImage(image,100, 100, 100, 100, 0, 0, imageWidth, imageHeight);
          vm.compressImg = canvas.toDataURL(`image/${type}`);
        };
      };
    },
    // base64 图片转 blob 后下载
    downloadImg() {
      let parts = this.compressImg.split(';base64,');
      let contentType = parts[0].split(':')[1];
      let raw = window.atob(parts[1]);
      let rawLength = raw.length;
      let uInt8Array = new Uint8Array(rawLength);
      for(let i = 0; i < rawLength; ++i) {
        uInt8Array[i] = raw.charCodeAt(i);
      }
      const blob = new Blob([uInt8Array], {type: contentType});
      this.compressImg = URL.createObjectURL(blob);
      if (window.navigator.msSaveOrOpenBlob) {
        // 兼容 ie 的下载方式
        window.navigator.msSaveOrOpenBlob(blob, this.fileName);
      }else{
        const a = document.createElement('a');
        a.href = this.compressImg;
        a.setAttribute('download', this.fileName);
        a.click();
      }
    },
  }
};
</script>

```

## 使用第三方库裁剪

Cropper.js