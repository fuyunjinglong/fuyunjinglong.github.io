---
title: B_0H5CSSJSES基础
date: 2021-11-02 06:33:16
categories:
- B_H5CSSJSES基础
toc: true # 是否启用内容索引
---

# HTML

## web基础及演进史

**(1)js组成**
 ECMAScript(js核心)，DOM(文档对象模型),BOM(浏览器对象模型)。
 ECMAScript：主要定义JS的语法和数据类型。
 DOM：一套操作页面的API.
 BOM:一套操作浏览器功能的API.

**(2)web技术演进史**
 (1.1)历史进程

-  2005年以前：前后端耦合；
-  2005年Ajax时代：前后端分离；
-  2006-2012Jquery时代；
-  2009年nodejs服务端能力发布；
-  2012-2016后jquery时代：模块化，MV架构；
-  2016至今三大框架；

 1)前端耦合
 前端代码只是View视图层。
 2)Ajax时代，允许客户端向服务器异步发送请求，处理后，异步局部刷新页面。划时代意义：前后端分离，服务端更专注于数据处理，前端更专注于数据展示。
 3)Jquery时代，精简dom操作和浏览器兼容性
 4)NodeJs时代
 开始用js开发服务端程序，同时构建了用NPM包管理工具的NodeJs生态系统。
 5)后Jquery时代
 前端引入模块化。具体有CMD/AMD/commonJS，后面ES6 Module。
 **AMD/CMD**：异步的，主要用于浏览器。模块定义和加载机制稍有不同。AMD推崇前置依赖，CMD推崇就近依赖。AMD是定义时声明依赖，CMD是懒加载，仅在require时才会加载。
 **CommonJS**:是同步的，主要服务端。
 **ES6 Module**:满足ES6标准的模块化输出，设计思想静态化。编译时就确定了依赖关系，是浏览器和服务端的通用模块解决方案。
 **MV*框架**
 前端的复杂功能驱动MV*框架引入。
 **MVC框架**
 View指令传送到Controller;
 Controller完成业务逻辑后，要求Model改变;
 Model将新的数据发送到View，用户得到反馈
 **MVVM框架**
 双向绑定，view改变自动反馈到viewmodel。view与model不发生联系。
 **(1.2)三大框架介绍**
 **1)angular**
 **历史**:2012开始1.0版本，16年升级2.0版本。新版本支持es6和ts。
 **基本特点**：
 双向绑定；
 依赖注入；
 基于ts的组件；
 良好的应用架构；
 工具生态完整，angular-cli用于创建、开发、测试等。有整套的解决方案，适合大型项目。
 **缺点**：中文文档较少，框架较重，学习成本高。
 **2)react**
 **历史**：2013年facebook发布版本。2015年版本稳定，同年发布reacr-native。
 **基本特点**：
 虚拟dom，跨浏览器兼容，性能较好；
 组件化，代码复用;
 JSX,js语法的扩展，模板简单、直接、语义化。
 单项数据流：数据流清晰，组件状态更可控。
 **缺点**：
 本身只是view，大型项目需要加上React Router和Redux。
 **3)VUE**
 **历史**：
 2015年1.0版本发布，同年vue-router、vuex、vue-cli出现，标志从一个视图层发展成一个渐进式框架。
 2016年vue2.0发布，引入虚拟dom，性能大幅提升。
 2019年vue2.0公布源码。
 **基本特点**：
 渐进式、轻量级框架;
 简单易用;
 双向数据绑定;
 组件化;
 轻量高效(使用虚拟dom，压缩后只有20kb)
 **缺点**：
 vue不支持IE8，生态比较差(语法提示不友好，插件数量比较少)

## XML与JSON

最根本上来说，XML是一个markup language（标记语言），而JSON是一种用于数据交换（data-interchange）的序列化对象的语言。

标记语言除了文本信息，还包括了一些元信息，这些元信息用来标注如何处理文本信息，比如：

```js
<Document>
    <Paragraph Align="Center">         Align是元信息
        Here <Bold>is</Bold> some text.
    </Paragraph>
</Document>
```

假如试图用JSON完完整整的表述上述的信息：

```json
{
    "Paragraphs": [
        {
            "align": "center",
            "content": [
                "Here ", {
                    "style" : "bold",
                    "content": [ "is" ]
                },
                " some text."
            ]
        }
    ]
}
```

原因在于，JSON里面没有**元数据和数据的区别**，**所有的东西都是数据**。同样的，XML也不擅长做JSON所擅长做的事，那就是序列化对象。

JSON有2点优于XML：

- 对象的内部结构一目了然，简洁明了。
- JSON语法规定[]是数组，{}是对象，而XML没有如此的语法规定，我们只能临时发明一种方式来表示数组，然后自己添加代码来识别这个数组。

作用为：

**两者比较：***JSON**比**XML**更小，更快，更易解析**

**两者作用范围：***JSON**适用于简单的传值，**XML**适用于元数据的标识。*

![image-20211107230640963](/img/image-20211107230640963.png)



## BOM和DOM对象

**1.BOM**

BOM（Browser Object Model）是指浏览器对象模型，可以对浏览器窗口进行访问和操作。

window对象核心

- Location对象
- History对象 
- document
- navigation
- screen

(1)window对象

```js
alert()            显示带有一段消息和一个确认按钮的警告框。
confirm()          显示带有一段消息以及确认按钮和取消按钮的对话框。
prompt()           显示可提示用户输入的对话框。

open()             打开一个新的浏览器窗口或查找一个已命名的窗口。
close()            关闭浏览器窗口。
setInterval()      按照指定的周期（以毫秒计）来调用函数或计算表达式。
clearInterval()    取消由 setInterval() 设置的 timeout。
setTimeout()       在指定的毫秒数后调用函数或计算表达式。
clearTimeout()     取消由 setTimeout() 方法设置的 timeout。
```

(2)Location对象

Location 对象包含有关当前 URL 的信息。

```js
location.reload()  //重新加载页面，即刷新
// 跳转到指定页面（可以返回上一个页面）
location.assign("URL")
location.href="URL"
// 跳转到指定页面（不可以返回上一个页面）
location.replace("URL")
```

(3)History对象 

History 对象包含用户（在浏览器窗口中）访问过的 URL。

```js
history.forward()  // 前进一页
history.back()  // 后退一页
```

**2.DOM**

根据 W3C 的 HTML DOM 标准，HTML 文档中的所有内容都是节点(NODE)：

导航属性：

- parentNode - 节点（元素）的父节点 （一般用这个）
- firstChild – 节点下第一个子元素
- lastChild – 节点下最后一个子元素
- childNodes - 节点（元素）的子节点

**(1)查找标签**

```js
document.getElementsByClassName   根据class属性获取
document.getElementsByTagName     根据标签名获取标签合集
document.getElementById           根据id属性值获取一个标签
document.getElementsByName()      根据name属性值获取一个标签
```

间接查找

```
parentElement　　　　　　　//父节点标签元素
children　　　　  　　　　 //所有子标签
firstElementChild　　　　 //第一个子标签元素
lastElementChild　　　　  //最后一个子标签元素
nextElementtSibling　　  //下一个兄弟标签元素
previousElementSibling  //上一个兄弟标签元素

示例:
var ele1=document.getElementsByTagName("a")[0];
var ele2=ele1.parentElement;
console.log(ele2);
```

**(2)节点操作**

创建节点

```
var divEle = document.createElement("div");
```

添加节点

```
// 追加一个子节点（作为最后的子节点）
Anode.appendChild(Bnode)；
// 把增加的节点放到某个节点的前边。
Anode.insertBefore(Bnode,Cnode); // 在Anode节点下，将Cnode节点插入Bnode节点前面
// 示例
var imgEle = document.createElement("img");
imgEle.src = "#"; 
var d1Ele = document.getElementById("d1");
d1Ele.appendChild(imgEle);
```

替换节点

```
Anode.replaceChild(Bnode,Cnode);
```

属性节点

```
// 获取文本节点的值
var ele = document.getElementById("d1")
// 1.如果id为d1的标签内嵌套其他标签
ele.innerText  // 只取d1标签内的所有文本内容
ele.innerHTML  // d1标签内嵌套的标签和所有文本内容都取
```

设置文本节点的值

```
var ele = document.getElementById("d1")
ele.innerText = "在干嘛"
ele.innerHTML = "<p>在干嘛<p/>"
```

attribute操作

```
var ele = document.getElementsByClassName("c1")[0];
ele.setAttribute("hobby","swimming");
console.log(ele.getAttribute("hobby"));
ele.removeAttribute("hobby");
// 自带的属性可以直接.属性名来获取和设置
ele.id;
ele.id = "xxx";
```

获取值操作

```
var ele = document.getElementById("i1");
console.log(ele.value);
```

class的操作

```
// elementNode（节点名，简化用ele，像上面那样）
ele.className  获取所有样式类名(字符串)
ele.classList.remove(cls)    删除指定类
ele.classList.add(cls)       添加类
ele.classList.contains(cls)  存在返回true，否则返回false
ele.classList.toggle(cls)    存在就删除，否则添加
```

指定CSS操作

```
var ele = document.getElementById("d1");
ele.style.color = "red";
```

JS操作CSS属性的规律

①对于没有中横线的CSS属性一般直接使用style.属性名即可。如：

```
ele.style.margin
ele.style.width
ele.style.left
ele.style.position
```

②对含有中横线的CSS属性，将中横线后面的第一个字母换成大写即可。如：

```
ele.style.marginTop
ele.style.borderLeftWidth
ele.style.zIndex
ele.style.fontFamily
```

事件

```
onclick        当用户点击某个对象时调用的事件句柄。
ondblclick     当用户双击某个对象时调用的事件句柄。

onfocus        元素获得焦点。  //练习：输入框
onblur         元素失去焦点。  //应用场景：用于表单验证，用户离开某个输入框时，代表已经输入完了，我们可以对它进行验证。
onchange       域的内容被改变。//应用场景：通常用于表单元素,当元素内容被改变时触发，（三级联动）

onkeydown      某个键盘按键被按下。//应用场景: 当用户在最后一个输入框按下回车按键时，表单提交。
onkeypress     某个键盘按键被按下并松开。
onkeyup        某个键盘按键被松开。
onload         一张页面或一幅图像完成加载。
onmousedown    鼠标按钮被按下。
onmousemove    鼠标被移动。
onmouseout     鼠标从某元素移开。
onmouseover    鼠标移到某元素之上。
onmouseleave   鼠标从元素离开

onselect       文本被选中。
onsubmit       确认按钮被点击。
```

绑定方式

```
<div id="d1" onclick="changeColor(this);">点我字体变颜色</div>

var ele= document.getElementById("d1");
    ele.onclick = function () {
    this.innerText="想干嘛呢？";
    }
```

Event对象

```
 var ele1 = document.getElementsByClassName("inner")[0];
    ele1.onclick = function (e) {
        alert("I am inner!");
        e.stopPropagation();
    };
    var ele2 = document.getElementsByClassName("outer")[0];
    ele2.onclick = function () {
        alert("I am outer!")
    };
```

## Web语义化

Web语义化是指使用恰当语义的html标签、class类名等内容，让页面具有良好的结构与含义，从而让人和机器都能快速理解网页内容。语义化的web页面一方面可以让机器在更少的人类干预情况下收集并研究网页的信息，从而可以读懂网页的内容，然后将收集汇总的信息进行分析，结果为人类所用；另一方面它可以让开发人员读懂结构和用户以及屏幕阅读器（如果访客有视障）能够读懂内容。 简单来说就是利于 SEO，便于阅读维护理解。

总结起来就是：

- 正确的标签做正确的事情
- 页面内容结构化
- 无CSS样子时也容易阅读，便于阅读维护和理解
- 便于浏览器、搜索引擎解析。 利于爬虫标记、利于SEO

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

# JavaScript

## 三大山-堆栈内存及闭包作用域

<img src="C:\Users\fuyunjinglong\AppData\Roaming\Typora\typora-user-images\image-20220912183546292.png" alt="image-20220912183546292" style="zoom:80%;" />

### JS的8种数据类型

- 基本类型：Number,String,Boolean,Null,undefined,symbol
- 引用类型：Object,Array,function

**Undefined、Null的区别**

- Undefined 类型表示未定义，它的类型只有一个值，就是 undefined，判空：if(a===undefined)

- Null表示的是：“定义了但是为空”,判空：if(a)

### JS堆栈内存运行机制-深浅拷贝

var obj={}

obj存放在栈内存中，{}实例存在在堆中。

```
//example 1
let a={}, b='0', c=0;
a[b]='珠峰';
a[c]='培训';
console.log(a[b]); // '培训', 对象的key数字和字符串等效

// ---------------------
//example 2
let a={}, b=Symbol('1'), c=Symbol('1');
a[b]='珠峰';
a[c]='培训';
console.log(a[b]); // '珠峰', Symbol的特点，都是唯一的

// ---------------------
//example 3
let a={}, b={n:'1'}, c={m:'2'};
a[b]='珠峰';
a[c]='培训';
console.log(a[b]); // '培训', key会转化成字符串[Obejct object]
```

**赋值、浅拷贝、深拷贝**

赋值：把一个对象赋给一个新变量，赋的其实是该对象在栈中的地址，所有值都会相互影响

浅拷贝：重新在堆中创建内存，拷贝后的基本数据类型不影响，但是引用类型属性是相互影响共用

深拷贝：重新在堆中创建内存，所有值都不相互影响

```js
//赋值，全部影响
var person={
    name:'jack',
    play:['篮球','足球']
}
var person2 =person;
person2.name='lucy';
person2.play[0]='爵士';
console.log(person);
console.log(person2);
```

```js
//浅拷贝，基本类型不影响，引用类型数据共用
var person={
    name:'jack',
    play:['篮球','足球']
}
function qian(obj){
var target={};
for(var key in obj){
    if(obj.hasOwnProperty(key)){
        target[key]= obj[key];
    }
}
return target;
}
var person2 =qian(person);
person2.name='lucy';
person2.play[0]='爵士';
console.log(person);
console.log(person2);
```

```js
//深拷贝，所有数据不影响
var person={
    name:'jack',
    play:['篮球','足球'],
    date:new RegExp('\\w+'),
    function(){}
}
function deep(obj){
var target={};
if(obj === null) return obj;
if(obj instanceof Date)return new Date(obj);// a instanceof b一句话表示:b的prototypey在a的原型链上
if(obj instanceof RegExp)return new RegExp(obj);
if(typeof obj !== 'object')return obj;
for(var key in obj){
    if(obj.hasOwnProperty(key)){
        target[key]= deep(obj[key]);
    }
}
return target;
}
var person2 =deep(person);
person2.name='lucy';
person2.play[0]='爵士';
console.log(person);
console.log(person2);
```

JSON.parse()对于正则和函数无法拷贝

**浅拷贝的实现方式**

Object.assign()

...扩展运算符

lodash clone

**深拷贝的实现**

$.extend

lodash deepClone

### 变量提升机制

var上升为全局，let是块级作用域，作用于当前。

- var：声明提升，没有局部作用域，声明覆盖
- let:

```
    for(var i =0;i<5;i++){
        setTimeout(()=>{
            console.log('var的事件循环机制:',i);// 输出55555
        },500)
    }
    for(let j =0;j<5;j++){
        setTimeout(()=>{
            console.log('let的块级作用域：',j);// 输出01234
        },500)
    }
```

### 作用域和作用域链

### 闭包的两大作用：保存、保护

1.先要说到作用域和作用域链，即AO和GO

js代码在预编译阶段，会有一个AO函数作用域和GO全局作用域。

AO是指函数作用域，GO是指全局作用域。

```js
function a(){
    var aa=111;
    function b(){
        var bb=22;
        console.log(aa)
    }
    return  b;
}
var t=a();

var a = 0, b = 0;
function A(a) {
  A = function (b) {
    alert(a + b++);
  };
  alert(a++);
}
A(1);
A(2); // ‘1’，‘4’
```

a的作用域scope：scope[0]=AO{aa,function b},scope[1]=GO{function a}

b的作用域scope:scope[0]=AO{bb},scope[1]=AO{aa,function b},scope[2]=GO{function a}

通俗理解：**闭包函数(被包裹的函数)中必须要使用到外部函数中的变量**

优点：1.读取函数内部变量；2.让这些变量的值始终保持在内存中，不会在f1调用后被自动清除；

缺点：滥用闭包导致内存泄漏，能不用尽量不用，即时释放内存。（闭包会加深作用域链，加长变量查找时间）

场景：setTimeout的函数携带参数；回调；变量封装

### JS编译机制：VO/AO/GO

JS有两个特性，一个是单线程，一个是解释性语言。

JS运行步骤：1.语法分析2.预编译3.解释执行

函数执行四部曲：

1.创建AO对象，供js引擎自己去访问

activation object （活跃对象/执行期上下文）

2.找变量和形参的声明，作为AO对象的属性名，值是undefined

3.实参和形参相统一，实参赋值给形参

4.找函数声明(注意不是函数表达式)，会覆盖变量的声明。

```js
   function fn(a,c){
console.log(a);//function a(){}
var a=123;
console.log(a);//123
console.log(c);//function c(){}
function a(){}
if(false){
var d= 678;
}
console.log(d);//undefined
console.log(b);//undefined
var b=function(){}
console.log(b);//function (){}
function c(){}
console.log(c);//function c(){}
}
fn(1,2);

AO{
a:undefined,1,function a(){}
c:undefined,2,function c(){}
d:undefined,
b:undefined,
}
```

### JS高阶编程技巧：惰性函数/柯里化/高阶函数

**JS函数式编程思想**

**1.概述**

中心思想是指：**一个函数的返回值，仅仅依赖于参数的值，而不会因为其他外部的状态而不同。**

我们很难将所有函数都构建成符合函数式编程思维的范式，但如果应用函数式编程，则它的好处主要体现于：

- 引用透明（Referential Transparency）
- 无副作用（No Side Effect）
- 无竞争态 (No Race Condition)
- 惰性求值 (Lazy Evaluation)

**(1)无副作用（no side effects）**

任意一个函数，只要输入是确定的，输出就是确定的，这种**纯函数**称之为没有副作用的。

 函数在表现方式上，我们可以将其区分为 `纯函数` 和 `非纯函数`。他们有以下区分：

```
纯函数：返回值仅依赖于参数，输入相同的值，便会得到相同的值的函数。
let seed = 0; // 定义一个外部变量
// 一个用于求和的函数
const sum = (x, y) => x + y;

非纯函数：在参数一致的情况下，返回值可能不一致的函数。
let seed = 0; // 定义一个外部变量
// 另一个用于求和的函数
const sum = (x, y) => x + y + (++seed);
```

```
纯函数` 和 `非纯函数` 最大的两个不同的表现在于：`副作用性` 和 `引用透明性
```

`副作用性` 是指，该函数的调用过程中，是否对主函数（调用者）产生了附加影响，例如修改了函数外的变量或参数，我们就认为该函数是 `有副作用` 的函数。

**副作用主要表现于：**

- **I/O 操作**：其结果本身就是无法预估的，因此无法判断给定了的参数，是否能给予我们预期的返回结果；比如接收输入、或者将结果输出。
- **改变全局变量原有值**，或者**改变参数对象值及其属性**：其执行结果也是带有副作用的。
- **抛出异常或以错误中止**：函数除了返回一个值之外，还可能发生不太确定的执行结果。

**(2)引用透明**

引用透明（Referential transparency），指的是函数的运行不依赖于外部变量或"状态"，只依赖于输入的参数，任何时候只要参数相同，引用函数所得到的返回值总是相同的。

非纯函数造成的最大的问题，就是其 `不可预知性` 。如果代码比较复杂时，会为我们梳理程序运行逻辑造成一定的困难。因此，在函数式编程思维中，我们应尽可能的确保我们编写的函数是 `纯函数`。

```
JavaScript内置对象中的 非纯函数有：
Math.random()
console.log()
element.addEventListener()
Date.now()
Array.prototype.sort()
ajax操作等
```

在一段程序中，我们无法保证所有的函数都是纯函数。但纯函数的覆盖面越大，对于调试、缓存数据及线程安全都会提供越多的便利。有一种说法是，保证80%的函数是纯函数即可。

**(3)数据不可变**

在React中，强调一个组件不能去修改传入的prop值，这遵循了Immutable的原则

```
let a = 1;
let b = a + 1;
=> a = 1  b = 2;
```

变量b出现，虽然使用了变量a的值，但是没有修改a的值。

再看我们熟悉的react中的代码，假如初始化了this.state = { count: 1 }

```
componentDidMount() {
    const newState = { ...state, count: 2 }; // { count: 2 }
    this.setState(newState);
}
```

虽然我们使用了this.state，但是没有修改this.state的引用地址和直接修改count的值，对待this.props也一样。

React官网中给出三点好处：

- 简化复杂的功能

不可变性使得复杂的特性更容易实现。

- 跟踪数据的改变

如果直接修改数据，那么就很难跟踪到数据的改变。跟踪数据的改变需要可变对象可以与改变之前的版本进行对比，这样整个对象树都需要被遍历一次。

跟踪不可变数据的变化相对来说就容易多了。如果发现对象变成了一个新对象，那么我们就可以说对象发生改变了。

- 确定在 React 中何时重新渲染

不可变性最主要的优势在于它可以帮助我们在 React 中创建 pure components。我们可以很轻松的确定不可变数据是否发生了改变，从而确定何时对组件进行重新渲染。



- 纯函数
- 柯里化
- 高阶函数

**1.尾调用**

**PS:ES6尾调用优化只能在严格模式下使用，详见[尾调用优化 阮一峰](https://link.jianshu.com/?t=http%3A%2F%2Fwww.ruanyifeng.com%2Fblog%2F2015%2F04%2Ftail-call.html)**

**定义：**某个函数的最后一步是调用另一个函数。

```
function f(x){
  return g(x);
}//尾调用
// 情况一 非尾调用
function f(x){
  let y = g(x);
  return y;
}
// 情况二 非尾调用
function f(x){
  return g(x) + 1;
}
//尾调用不一定出现在函数尾部，只要是最后一步操作即可。
    function f(x) {
  if (x > 0) {
    return m(x)
  }
  return n(x);
}
```

(1)尾调用优化（Tail call optimization）

如图所示，函数调用会在内存形成[调用栈（call stack）](https://link.jianshu.com?t=http%3A%2F%2Fzh.wikipedia.org%2Fwiki%2F%E8%B0%83%E7%94%A8%E6%A0%88)，尾调用由于是函数的最后一步操作，所以不需要保留外层函数的调用记录，因为调用位置、内部变量等信息都不会再用到了，只要直接用内层函数的调用记录，取代外层函数的调用记录就可以了。

**优点：**减小调用栈，节省内存使用。

![image-20220114072242443](/img/image-20220114072242443.png)

```
function f() {
  let m = 1;
  let n = 2;
  return g(m + n);
}
f();
// 等同于
function f() {
  return g(3);
}
f();
// 等同于
g(3);
```

(2)尾递归

**定义：**尾调用自身。
 "尾调用优化"对递归操作意义重大。ES6中第一次明确规定，所有 ECMAScript 的实现，都必须部署"尾调用优化"。这就是说，在 ES6 中，只要使用尾递归（在严格模式下），就不会发生栈溢出，相对节省内存

**2.柯里化**

**柯里化是把多参数的函数转换成少参数的函数的过程。**

```
function sum(a) {
  return function (b) {
    return function(c) {
        return a + b + c;
        } 
    }
}
// 调用
let sum1 = sum(1);
let sum2 = sum1(2);
sum2(3); // 6
```

高阶柯里化：

```
function curry(func) {
  return function curried(...args) {
    if (args.length >= func.length) {
      return func.apply(this, args);
    } else {
      return function(...args2) {
        return curried.apply(this, args.concat(args2));
      }
    }
  };
}

function sum(a, b, c) {
  return a + b + c;
}

let curriedSum = curry(sum);
let cu1 = curriedSum(1)
alert( curriedSum( 1,2, 3) );// 6 任意柯里化
alert( cu1( 2, 3) );// 6 任意柯里化
```

当我们运行它时，这里有两个 `if` 执行分支：

1. 现在调用：如果传入的 `args` 长度与原始函数所定义的（`func.length`）相同或者更长，那么只需要将调用传递给它即可。
2. 获取一个偏函数：否则，`func` 还没有被调用。取而代之的是，返回另一个包装器 `pass`，它将重新应用 `curried`，将之前传入的参数与新的参数一起传入。然后，在一个新的调用中，再次，我们将获得一个新的偏函数（如果参数不足的话），或者最终的结果。

例如，让我们看看 `sum(a, b, c)` 这个例子。它有三个参数，所以 `sum.length = 3`。

对于调用 `curried(1)(2)(3)`：

1. 第一个调用 `curried(1)` 将 `1` 保存在词法环境中，然后返回一个包装器 `pass`。
2. 包装器 `pass` 被调用，参数为 `(2)`：它会获取之前的参数 `(1)`，将它与得到的 `(2)` 连在一起，并一起调用 `curried(1, 2)`。由于参数数量仍小于 3，`curry` 函数依然会返回 `pass`。
3. 包装器 `pass` 再次被调用，参数为 `(3)`，在接下来的调用中，`pass(3)` 会获取之前的参数 (`1`, `2`) 并将 `3` 与之合并，执行调用 `curried(1, 2, 3)` — 最终有 `3` 个参数，它们被传入最原始的函数中

### 模块化思想

> **(1)CommonJS规范---cjs**

CJS是**同步**的，适用于**后端**环境，Nodejs中使用的是这个规范。

CommonJS的核心是通过 module.exports 暴露模块接口，通过 require 引入模块。

模块可以多次加载，但是只会在第一次加载时运行一次，然后运行结果就被缓存了，以后再加载，就直接读取缓存结果。要想让模块再次运行，必须清除缓存。

> **(2)AMD(Asynchronous Module Definition ，异步模块定义)/CMD**(Common Module Definition，通用模块定义)

AMD是**异步**的，适用于**前端**环境。AMD推崇的是**依赖前置**.

CMD是**同步**的，适用于**前端**环境**。**CMD推崇**就近依赖**。

AMD是RequireJS在推广过程中对模块定义的规范化产出。CMD是SeaJS在推广过程中对模块定义的规范化产出。

有的人说AMD用户体验好，因为没有延迟，依赖模块提前执行了，CMD性能好，因为只有用户需要的时候才执行

requireJS主要解决两个问题：

- 1 多个js文件可能有依赖关系，被依赖的文件需要早于依赖它的文件加载到浏览器。
- 2 js加载的时候浏览器会停止页面渲染，加载文件愈多，页面失去响应的时间愈长。

```
AMD与CMD区别
模块定义时对依赖的处理不同：
1.AMD推崇依赖前置，在定义模块的时候就要声明其依赖的模块
2.CMD推崇就近依赖，只有在用到某个模块的时候再去require
同为异步加载模块的区别：
1.AMD在加载模块完成后就会执行该模块
2.CMD加载完某个依赖模块后并不执行，只是下载而已,这样模块的执行顺序和书写顺序是完全一致的。性能较好，只有用户需要时才执行
```

> (3)ES6---ESM

ECMAScript 6 的一个目标是解决作用域的问题，也为了使 JS 应用程序显得有序，于是引进了模块。目前部分主流浏览器已原生支持 ES Module，使用 type = module 指定为模块引入即可
注意：使用该方式执行 JS 时自动应用 defer 属性。

ESM由于具有简单的语法，**同步异步**加载的特性，适用于前后端，以及**Tree-shakeable**的特性.具有Tree-shakeable的特性，这是由于**ES6的静态模块**结构。

> (4)UMD(Universal Module Definition，万能模块定义)

UMD可以在任何环境下使用，并且在ESM不能使用的情况下回选择UMD。兼容 CommonJS 和 AMD 规范，兼容ESM。

> UMD 实现原理：
>
> 先判断是否支持 AMD（define 是否存在），存在则使用 AMD 方式加载模块；
> 再判断是否支持 Node.js 模块格式（exports 是否存在），存在则使用 Node.js 模块格式；
> 前两个都不存在，则将模块公开到全局（window 或 global）
> UMD 使得你可以直接使用`<script>`标签引用

```
CommonJS和es6区别
- 因为CommonJS的`require`语法是同步的，所以就导致了CommonJS模块规范只适合用在服务端，而ES6模块无论是在浏览器端还是服务端都是可以使用的，但是在服务端中，还需要遵循一些特殊的规则才能使用 ；
- CommonJS 模块输出的是一个值的拷贝，而ES6 模块输出的是值的引用；
- CommonJS 模块是动态引入，执行时引入，而ES6 模块是静态引入，编译时引入；
- 因为两个模块加载机制的不同，所以在对待循环加载的时候，它们会有不同的表现。CommonJS遇到循环依赖的时候，只会输出已经执行的部分，后续的输出或者变化，是不会影响已经输出的变量。而ES6模块相反，使用`import`加载一个变量，变量不会被缓存，真正取值的时候就能取到最终的值；
- 关于模块顶层的`this`指向问题，在CommonJS顶层，`this`指向当前模块；而在ES6模块中，`this`指向`undefined`；
```

## 三大山-面向对象和this处理

### 单例设计模式

### constructor构造函数模式

### 类和实例

### 原形和原型链

**1.从属关系**

proto是对象object的原形属性

prototype是函数fn的原形属性

对象的proto保存着对象的构造函数的prototype

**2.构造函数的原形属性也是一个对象**

```js
var Test = function(){
    a:111
}
Test.prototype.b=222;
Object.prototype.c=333;
const test = new Test();
console.log(test);
console.log(test.__proto__);
console.log(Test.prototype);
console.log(test.__proto__===Test.prototype);//true
console.log(Test.prototype.__proto__===Object.prototype);//true
console.log(Object.prototype.__proto__);// 顶层null
```

**3.原型链**

以对象为基准，以proto为连接点，一直到Object.prototype为止的一条链条。

```js
test:{
    a:111,
    __proto__:Test.prototype={
        b:222,
        __proto__:Object.prototype={
            c:333,
            __proto__:null
        }
    }
}
```

对象的proto保存着对象的构造函数的prototype属性，从而实现原形继承。自己的属性没有会去构造函数汇总找属性，一层一层找，直到Object.prototype。

**4.Function和Object特殊性**

他们既是函数又是对象，因为Test=new Function()

```js
Test = new Function();//Test是函数，那么也应该是函数构造来的
console.log(Test.__proto__===Function.prototype);// true
console.log(Function.__proto__);
console.log(Function.prototype);
console.log(Function.__proto__===Function.prototype);//true,1,js规定的，可以理解为Function既是函数又是对象，那么它的proto也等于prototype

console.log(Object.__proto__===Function.prototype);//true,2,Object既是函数又是对象

//1,2最终得到
console.log(Object.__proto__===Function.__proto__);//true
```

**5.是否存在属性**

test.hasOwnProperty('a')//判断自己对象内部是否存在属性

'b'  in test //判断原型链中是否存在属性

6.constructor是构造函数，可以更改

console.log(test.constructor===Test);//true

//构造函数可以被修改

function Test2(){

  this.a=000;

}

test.constructor = Test2

### new运算符的实现机制

- 1：检查类是否已经被加载，运行时常量池中查找该引用所指向的类有没有被加载；
- 2：为对象分配内存空间，通过类元信息来确定类型和后面需要申请的内存大小；
- 3：为分配的内存空间初始化零值（为对象字段设置零值）；
- 4：对对象进行其他设置（设置对象头），类的元数据信息，对象的hashcode，GC分代年龄等；
- 5：执行构造方法

**js中的new()做了什么？**

专业解释：

> 1、创建一个空对象，并且 this 变量引用该对象，同时还继承了该函数的原型。
>
> 2、属性和方法被加入到 this 引用的对象中。
>
> 3、新创建的对象由 this 所引用，并且最后隐式的返回 this 。

经历以下 4个步骤：
(1) 创建一个新对象；
(2) 将构造函数的作用域赋给新对象（因此 this 就指向了这个新对象） ；
(3) 执行构造函数中的代码（为这个新对象添加属性） ；
(4) 返回新对象。

举个栗子：

```js
var obj = new Base();
```

本质干了三件事：

> var obj = {}
>
> obj.__proto__ = Base.prototype
>
> Base.call(obj)

第一行，我们创建了一个空对象obj
第二行，我们将这个空对象的__proto__成员指向了Base函数对象prototype成员对象
第三行，我们将Base函数对象的this指针替换成obj，然后再调用Base函数，于是我们就给obj对象赋值了一个id成员变量，这个成员变量的值是”base”，关于call函数的用法。

`new` 的实现很简单，就是一步一步把它要做的操作给实现出来：

```js
function myNew(Con, ...args) {
  // 创建一个新的空对象
  let obj = {};
  // 将这个空对象的__proto__指向构造函数的原型
  // obj.__proto__ = Con.prototype;
  Object.setPrototypeOf(obj, Con.prototype);
  // 将this指向空对象
  let res = Con.apply(obj, args);
  // 对构造函数返回值做判断，然后返回对应的值
  return res instanceof Object ? res : obj;
}
```

### JS的this五种情况的梳理

- 事件绑定
- 普通函数执行
- 构造函数执行
- 箭头函数
- `call、apply、bind`

**情况一：事件绑定**

`this`：给元素的某个事件行为绑定方法，事件触发，方法执行，此时方法中的 *`this`一般都是当前元素本身*

```
    <button id="btn">点我</button>
    <script>  
    // 方法一
     btn.onclick=function anonymous(){
  		console.log(this);   
     }
     // 方法二
      btn.addEventListener('click',function anonymous(){
   		console.log(this); 
     },false)
     // 方法三，兼容iE 6/7/8 DOM2事件绑定
     btn.attachEvent('onclick',function anonymous(){
      console.log(this);//this指向window
     })
     // 方法四
     function fn(){
         console.log(this);
     }
     btn.onclick=fn.bind(window)
    </script>
```

**情况二：普通函数执行**

**'点'前面是谁this就是谁** 普通函数执行，它里面的`this`是谁，取决于方法执行前面是否有`"点"` 有的话，`“点”前面`是谁`this`就是谁，没有`this`指向`window`（严格模式下是`undefined`）。

默认情况下，指向window对象，只有当有对象时，才指向对象。关键看调用的时候是fn()还是obj.fn()

```js
function get (p){
console.log(p);
}
get('黄山');
等效于get.call(window,'大理')---this指向window
var person={
    name:'凤凰',
    fn:function(a){
        console.log(`我在${this.name}${a}`);
    }
}
person.fn('划水');
person.fn.call(person,'划水');---this指向person
```

```js
var name =222;
var a={
    name:111,
    say:function(){
        console.log(this.name);
    }
}
var fun=a.say;
fun(); //window 222
a.say();// a 111
var b={
    name:333,
    say:function(fn){
        fn();
    }
}
b.say(a.say);//window 222
b.say=a.say;
b.say();//b 333
```

**情况三：构造函数执行(new xxx)**

函数中的this是当前类的实列。

<script>
    function Fn(){
        console.log(this);
          //this.xxx=xxx是给当前实列设置私有属性
      }
      let f= new Fn;
</script>

**情况四：箭头函数**

箭头函数中this在定义函数的时候就绑定了，而不是在执行函数时候绑定。

箭头函数中，this指向的固定化，并不是因为箭头函数有绑定this机制。是因为箭头函数中根本没有自己的this.它所用的this，是共用父继承下来的this。所以也不能作构造函数

```js
var x=11;
var obj={
    x:22,
    say:()=>{
        console.log(this.x); // 同级是obj内部
    }
}
obj.say();//指向obj，但this指向父级，同级是obj，父级是window,11

var obj={
    birth:1990,
    getAge:function(){
        var birth=0;
        var b = this.birth;
        var fn = ()=>new Date().getFullYear()-b//同级是getAge内部
        return fn()
    }
}
console.log(obj.getAge());//指向obj，但遇到箭头函数this指向父级obj
```

**情况五：、call、apply、bind**

`call` `apply` `bind`都可以改变函数调用的`this`指向

```js
// 有只猫叫小黑，小黑会吃鱼
const cat = {
    name: '小黑',
    eatFish(...args) {
        console.log('this指向=>', this);
        console.log('...args', args);
        console.log(this.name + '吃鱼');
    },
}
// 有只狗叫大毛，大毛会吃骨头
const dog = {
    name: '大毛',
    eatBone(...args) {
        console.log('this指向=>', this);
        console.log('...args', args);
        console.log(this.name + '吃骨头');
    },
}

console.log('=================== call =========================');
// 有一天大毛想吃鱼了，可是它不知道怎么吃。怎么办？小黑说我吃的时候喂你吃
cat.eatFish.call(dog, '汪汪汪', 'call')
// 大毛为了表示感谢，决定下次吃骨头的时候也喂小黑吃
dog.eatBone.call(cat, '喵喵喵', 'call')

console.log('=================== apply =========================');
cat.eatFish.apply(dog, ['汪汪汪', 'apply'])
dog.eatBone.apply(cat, ['喵喵喵', 'apply'])

console.log('=================== bind =========================');
// 有一天他们觉得每次吃的时候再喂太麻烦了。干脆直接教对方怎么吃
const test1 = cat.eatFish.bind(dog, '汪汪汪', 'bind')
const test2 = dog.eatBone.bind(cat, '喵喵喵', 'bind')
test1()
test2()
```

**`call`语法**

- `fun.call(thisArg, arg1, arg2, ...)`
- `thisArg`: 在fun函数运行时指定的this值。需要注意的是，指定的this值并不一定是该函数执行时真正的this值，如果这个函数处于非严格模式下，则指定为null和undefined的this值会自动指向全局对象(浏览器中就是window对象)，同时值为原始值(数字，字符串，布尔值)的this会指向该原始值的自动包装对象。
- `arg1, arg2, ...` 指定的参数列表

**`apply`语法**

- `fun.apply(thisArg, [argsArray])`
- `thisArg` 在 fun 函数运行时指定的 this 值。需要注意的是，指定的 this 值并不一定是该函数执行时真正的 this 值，如果这个函数处于非严格模式下，则指定为 null 或 undefined 时会自动指向全局对象（浏览器中就是window对象），同时值为原始值（数字，字符串，布尔值）的 this 会指向该原始值的自动包装对象。
- `argsArray` 一个数组或者类数组对象，其中的数组元素将作为单独的参数传给 fun 函数。如果该参数的值为null 或 undefined，则表示不需要传入任何参数。从ECMAScript 5 开始可以使用类数组对象。

**`bind`语法**

- `fun.bind(thisArg[, arg1[, arg2[, ...]]])`
- `thisArg` 当绑定函数被调用时，该参数会作为原函数运行时的 this 指向。当使用new 操作符调用绑定函数时，该参数无效。
- `arg1, arg2, ...` 当绑定函数被调用时，这些参数将置于实参之前传递给被绑定的方法。

**小结：**

> 1. 当我们使用一个函数需要改变`this`指向的时候才会用到`call``apply``bind`
> 2. 如果你要传递的参数不多，则可以使用`fn.call(thisObj, arg1, arg2 ...)`
> 3. 如果你要传递的参数很多，则可以用数组将参数整理好调用`fn.apply(thisObj, [arg1, arg2 ...])`
> 4. 如果你想生成一个新的函数长期绑定某个函数给某个对象使用，则可以使用`const newFn = fn.bind(thisObj); newFn(arg1, arg2...)`

### JS的四大数据类型检查方案

### JS的四大继承方案

- 原型链继承
- 构造函数继承
- 组合式继承
- 寄生组合式继承

**原型链继承**

定义：让子类的原型指向父类的实列。

- 弊端：父类的某个实例的修改，会影响到所有子类的实例

```js
    // 原型链继承
function Parent(){
    this.name = '李连杰'
}
Parent.prototype.getName=function(){
    return this.name
}
function Child(){}
// 子类的原形指向父类的实例
Child.prototype = new Parent()
const child = new Child()
console.log(child.name);//李连杰
console.log(child.getName());//李连杰
// 弊端：父类的某个实例的修改，会影响到所有子类的实例
const child2 = new Child()
child2.name = '成龙'
console.log(child2.name);//成龙
console.log(child.name);//成龙
```

**构造函数继承**

定义：在子类构造函数中，执行父类的构造函数，并为其绑定子类的this(改变this指向)

- 弊端：子类无法继承父类的属性和方法

```
    // 构造函数继承
function Animals(name){
    this.name = name
}
Animals.prototype.age=3
Animals.prototype.getName=function(){
    return this.name
}
function Dog(){
    Animals.call(this,'柴犬')// call的应用
}

const dog = new Dog()
const dog1 = new Dog()
dog.name = '金毛'
console.log(dog.name);//金毛
console.log(dog1.name);//柴犬
// 弊端:子类无法继承父类的属性和方法
dog.age
dog.getName()
```

**组合式继承**

定义：结合了原型链继承和构造函数继承

- 优点：子类继承父类的属性和方法，且不影响其他子类

```
    // 组合式继承：结合了原型链继承和构造函数继承
function Car(name){
    this.name = name
}
Car.prototype.getName=function(){
    return this.name
}
// 结合了构造函数继承
function Bmw(name){
    Car.call(this,name)// call的应用
}
// 结合了原型链继承
Bmw.prototype = new Car()
const bmw1 = new Bmw('宝马3系')
const bmw2 = new Bmw('宝马7系')
bmw1.name = '宝马5系'
console.log(bmw1.name);//宝马5系
console.log(bmw2.name);//宝马7系
```

**寄生组合式继承**

定义：父类原形赋值给子类原形

- 弊端：如果没有Object.create浅拷贝，这里父类的实例可以调用子类的方法

  car.getCar()

```js
<script>
    // 寄生式组合：父类原形赋值给子类原形
function Car(name){
    this.name = name
}
// 结合了构造函数继承
function Bmw(name){
    Car.call(this,name)// call的应用
}
Bmw.prototype.getCar=function(){
    console.log("这是子类的getCar()");
}
// 寄生式组合的关键，利用Object.create浅拷贝，父类原形赋值给子类原形
Bmw.prototype = Object.create(Car.prototype)
// 原型链的一个规则
Bmw.prototype.constructor = Bmw
const bmw1 = new Bmw('宝马3系')
const bmw2 = new Bmw('宝马7系')
bmw1.name = '宝马5系'
console.log(bmw1.name);//宝马5系
console.log(bmw2.name);//宝马7系
let car = new Car()
// 弊端：如果没有Object.create浅拷贝，这里父类的实例可以调用子类的方法
car.getCar()
</script>
```



## 三大山-DOM和BOM及事件处理机制

### DOM/BOM的核心操作

### DOM2级事件的核心运行机制

### 事件委托

定义：当事件触发时，把要做的事委托给父元素来处理。

事件传播分成三个阶段：

- 捕获阶段：从window对象传导到目标节点（上层传到底层）称为“捕获阶段”（capture phase），捕获阶段不会响应任何事件；
- 目标阶段：在目标节点上触发，称为“目标阶段”
- 冒泡阶段：从目标节点传导回window对象（从底层传回上层），称为“冒泡阶段”（bubbling phase）。事件代理即是利用事件冒泡的机制把里层所需要响应的事件绑定到外层；

```js
document.addEventListener("click", function (event) {
      var target = event.target;
      switch (target.id) {
        case "doSomething":
          document.title = "事件委托";
          break;
        case "goSomewhere":
          location.href = "http://www.baidu.com";
          break;
        case "sayHi": alert("hi");
          break;
      }
    })
```

使用“事件委托”时，并不是说把事件委托给的元素越靠近顶层就越好。事件冒泡的过程也需要耗时，越靠近顶层，事件的”事件传播链”越长，也就越耗时。

### 事件循环

**1.JavaScript是单线程，非阻塞的**

单线程：JavaScript的主要用途是与用户互动，以及操作DOM。如果它是多线程的会有很多复杂的问题要处理.

非租塞：多线程和异步是通过通过 event loop 实现。

**2.任务类型**

**同步任务**指的是，在主线程上排队执行的任务，只有前一个任务执行完毕，才能执行后一个任务；

**异步任务**指的是，不进入主线程、而进入"任务队列"（task queue）的任务，只有"任务队列"通知主线程，某个异步任务可以执行了，该任务才会进入主线程执行。

异步任务**按照优先级**，又分为微任务和宏任务。

**宏任务**:每次执行栈执行的代码就是一个宏任务（包括每次从事件队列中获取一个事件回调并放到执行栈中执行）

```js
主代码块
setTimeout
setInterval
postMessage
MessageChannel
setImmediate(Node.js 环境)
script(可以理解为外层同步代码)
I/O（Node.js）
UI交互事件
```

**微任务**：当前宏任务执行结束后立即执行的任务

```js
Promise.then
MutationObserver
Object.observe（已废弃；Proxy 对象替代）
process.nextTick(Node.js 环境)
```

**3.Event Loop执行流程**

定义："**Event Loop是一个程序结构，用于等待和发送消息和事件。**

主要涉及**调用栈**(call stack是一个存储函数调用的**栈结构**，遵循**先进后出**的原则)、**宏任务队列**(macrotaskqueue)、**微任务队列**(microtask quene).

**特别强调**：根据规范，**宏任务**的队列可以有多个，而**微任务**队列只能有一个。这个过程中，如果产生新的微任务，是可以加入到微任务队列，但如果产生宏任务，则需要添加到下一个宏任务队列。**与先微任务后宏任务流程一致**



在一次Tick循环中，执行流程：**当前执行栈即也属于宏任务-当前微任务**-声明的(下一个)宏任务-声明的(下一个)宏任务。。。无限循环

- 执行**一个宏任务**（栈中没有就从事件队列中获取）
- 执行过程中如果遇到微任务，就将它添加到**微任务的任务队列**中
- 宏任务执行完毕后，立即执行当前微任务队列中的所有微任务（依次执行）
- 当前宏任务执行完毕，开始检查渲染，然后GUI线程接管渲染
- 渲染完毕后，JS线程继续接管，开始**下一个宏任务(主线程中当前执行栈的宏任务就是下一个宏任务，所以当前执行栈总是先执行执行栈，然后微任务，再(下一个)宏任务)**（从事件队列中获取，也就是 callbacke queue）**与先微任务后宏任务流程一致**

![image-20211024222114449](/img/image-20211024222114449.png)

![image-20220123200002149](/img/image-20220123200002149.png)

```
加强版练习
console.log('script start')
async function async1() {
  await async2()
  console.log('async1 end')
}
async function async2() {
  console.log('async2 end')
}
async1()
setTimeout(function() {
  console.log('setTimeout')
}, 0)
new Promise(resolve => {
  console.log('Promise')
  resolve()
})
  .then(function() {
    console.log('promise1')
  })
  .then(function() {
    console.log('promise2')
  })
console.log('script end')
```

async await 本身就是 promise+generator 的语法糖。所以 await 后面的代码是 microtask。所以对于上面代码中的

```
async function async1() {
	console.log('async1 start');
	await async2();
	console.log('async1 end');
}
等价于
async function async1() {
	console.log('async1 start');
	Promise.resolve(async2()).then(() => {
                console.log('async1 end');
        })
}
```

总结：

- 微任务队列优先于宏任务队列执行；
- 微任务队列上创建的宏任务会被后添加到当前宏任务队列的尾端；
- 微任务队列中创建的微任务会被添加到微任务队列的尾端；
- 只要微任务队列中还有任务，宏任务队列就只会等待微任务队列执行完毕后再执行；
- 只有运行完 `await` 语句，才把 `await` 语句后面的全部代码加入到微任务行列；

## 节流和防抖

**本质上是优化高频率执行代码的一种手段**

- 节流: n 秒内只运行一次，若在 n 秒内重复触发，只有一次生效

- 防抖: n 秒后在执行该事件，若在 n 秒内被重复触发，则重新计时

  一个经典的比喻:

  想象每天上班大厦底下的电梯。把电梯完成一次运送，类比为一次函数的执行和响应

  假设电梯有两种运行策略 `debounce` 和 `throttle`，超时设定为15秒，不考虑容量限制

  电梯第一个人进来后，15秒后准时运送一次，这是**节流**

  电梯第一个人进来后，等待15秒。如果过程中又有人进来，15秒等待重新计时，直到15秒后开始运送，这是**防抖**

  **节流**

  完成节流可以使用**时间戳与定时器**的写法

  使用时间戳写法，事件会立即执行，停止触发后没有办法再次执行

  ```js
  function throttled1(fn, delay = 500) {
      let oldtime = Date.now()
      return function (...args) {
          let newtime = Date.now()
          if (newtime - oldtime >= delay) {
              fn.apply(null, args)
              oldtime = Date.now()
          }
      }
  }
  ```

  使用定时器写法，`delay`毫秒后第一次执行，第二次事件停止触发后依然会再一次执行

  ```js
  function throttled2(fn, delay = 500) {
      let timer = null
      return function (...args) {
          if (!timer) {
              timer = setTimeout(() => {
                  fn.apply(this, args)
                  timer = null
              }, delay);
        }
      }
  }
  ```

  可以将时间戳写法的特性与定时器写法的特性相结合，实现一个更加精确的节流。实现如下

  ```js
  function throttled(fn, delay) {
      let timer = null
      let starttime = Date.now()
      return function () {
          let curTime = Date.now() // 当前时间
          let remaining = delay - (curTime - starttime)  // 从上一次到现在，还剩下多少多余时间
          let context = this
          let args = arguments
          clearTimeout(timer)
          if (remaining <= 0) {
              fn.apply(context, args)
              starttime = Date.now()
        } else {
              timer = setTimeout(fn, remaining);
        }
      }
  }
  ```

**防抖**

  简单版本

  ```js
  function debounce(func, wait) {
      let timeout;
  return function () {
      let context = this; // 保存this指向
      let args = arguments; // 拿到event对象
      clearTimeout(timeout)
    timeout = setTimeout(function(){
          func.apply(context, args)
    }, wait);
  }
    }
  ```

  防抖如果需要立即执行，可加入第三个参数用于判断，实现如下：

  ```js
  function debounce(func, wait, immediate) {
  let timeout;
  return function () {
      let context = this;
      let args = arguments;
      if (timeout) clearTimeout(timeout); // timeout 不为null
      if (immediate) {
          let callNow = !timeout; // 第一次会立即执行，以后只有事件执行后才会再次触发
          timeout = setTimeout(function () {
              timeout = null;
          }, wait)
          if (callNow) {
              func.apply(context, args)
          }
      }
      else {
        timeout = setTimeout(function () {
              func.apply(context, args)
        }, wait);
      }
}
  }
  ```

  **区别**

  相同点：

  - 都可以通过使用 `setTimeout` 实现
  - 目的都是，降低回调执行频率。节省计算资源

  不同点：

  - 函数防抖，在一段连续操作结束后，处理回调，利用`clearTimeout `和 `setTimeout`实现。函数节流，在一段连续操作中，每一段时间只执行一次，频率较高的事件中使用来提高性能

- 函数防抖关注一定时间连续触发的事件，只在最后执行一次，而函数节流一段时间内只执行一次

  **应用场景**

防抖在连续的事件，只需触发一次回调的场景有：

- 搜索框搜索输入。只需用户最后一次输入完，再发送请求

  - 手机号、邮箱验证输入检测
  - 窗口大小`resize`。只需窗口调整完成后，计算窗口大小。防止重复渲染。

  节流在间隔一段时间执行一次回调的场景有：

  - 滚动加载，加载更多或滚到底部监听
  - 搜索框，搜索联想功能

## Ajax原理

`AJAX`全称(Async Javascript and XML)即异步的`JavaScript` 和`XML`，是一种创建交互式网页应用的网页开发技术，可以在不重新加载整个网页的情况下，与服务器交换数据，并且更新部分网页.

```
(1)创建对象

var xhr = new XMLHttpRequest();

(2)打开请求

xhr.open('GET', 'example.txt', true);

(3)发送请求

xhr.send(); 发送请求到服务器

(4)接收响应

xhr.onreadystatechange =function(){}

(1)当readystate值从一个值变为另一个值时，都会触发readystatechange事件。

(2)当readystate==4时，表示已经接收到全部响应数据。

(3)当status ==200时，表示服务器成功返回页面和数据。

(4)如果(2)和(3)内容同时满足，则可以通过xhr.responseText，获得服务器返回的内容。
```

**服务器响应处理**

同步处理

```
	1. xhr.open("GET","info.txt",false);  
	2. xhr.send();  
	3. document.getElementById("myDiv").innerHTML=xhr.responseText; //获取数据直接显示在页面上
```

异步处理

```
	1. xhr.onreadystatechange=function()  { 
	2.    if (xhr.readyState==4 &&xhr.status==200)  { 
	3.       document.getElementById("myDiv").innerHTML=xhr.responseText;  
	4.      }
	5.    } 
```

什么是**readyState**？

readyState是XMLHttpRequest对象的一个属性，用来标识当前XMLHttpRequest对象处于什么状态。 readyState总共有5个状态值，分别为0~4，每个值代表了不同的含义。

0：未初始化 -- 尚未调用.open()方法；

1：启动 -- 已经调用.open()方法，但尚未调用.send()方法；

2：发送 -- 已经调用.send()方法，但尚未接收到响应；

3：接收 -- 已经接收到部分响应数据；

4：完成 -- 已经接收到全部响应数据，而且已经可以在客户端使用了；

**什么是status？**

1：服务器收到请求

2：成功

3：重定向

4：客户端错误

5：服务端错误

setTimeout模拟setInterval

背景：

某些间隔会被跳过（丢帧现象）
定时器之间的间隔会比预期小

核心思想：递归调用+闭包

```
function mySetInterval(func,millisecond){
//使用闭包，如果没有闭包，则没办法递归调用下去
    function inside(){
    	func();
		setTimeout(inside,millisecond);
    }
    // 如果是inside();则没有人任务队列的概念，第一次就会立即执行
    setTimeout(inside,millisecond);
}

mySetInterval(like,100);
function like(){
console.log(1)
}
```

## **垃圾回收算法**

**(1)定义**

JavaScript 中自动垃圾回收机制的原理为：

```
找出那些不再使用的变量，然后释放其占用的内存。
垃圾收集器会按照固定的时间间隔(或预定的收集时间)周期性地执行此操作。
```

**(2)内存生命周期**

不管什么程序语言，内存生命周期基本是一致的：

- 分配你所需要的内存
- 使用分配到的内存（读、写）
- 不需要时将其释放归还

对于javascript而言，

- 简单类型，内存是保存在栈（stack）空间
- 复杂数据类型，内存是保存在堆（heap）空间

**(3)为什么需要垃圾回收机制？**

在Chrome中，v8被限制了内存的使用（64位约1.4G/1464MB ， 32位约0.7G/732MB），为什么要限制？

- 表层原因是，V8最初为浏览器而设计，不太可能遇到用大量内存的场景。JS的单线程机制，垃圾回收的过程阻碍了主线程逻辑的执行。
- 深层原因是，V8的垃圾回收机制的限制（垃圾回收的过程缓慢，也就会导致主线程的等待时间越长，那么性能和应用直线下降）

**(4)垃圾收集机制**

V8的垃圾回收策略主要是基于`分代垃圾回收机制`，其根据**对象的存活时间**将内存的垃圾回收进行不同的分代，然后对不同的分代采用不同的垃圾回收算法。

(1.1)内存模型

- 新生代：生存时间短的对象，支持 1～8M 的容量
- 老年代：生存时间长的对象，容量较大

为了提高回收效率，V8 分别使用两个不同的垃圾回收器，

- 副垃圾回收器 - Scavenge：主要负责新生代的垃圾回收。
- 主垃圾回收器 - Mark-Sweep & Mark-Compact：主要负责老生代的垃圾回收。

(1.2)新生代回收

在新生代中，主要使用`Scavenge`算法进行垃圾回收，`Scavenge`算法是一个典型的牺牲空间换取时间的复制算法，在占用空间不大的场景上非常适用。

Scavange算法将新生代堆分为两部分，分别叫`from-space`和`to-space`。

工作过程如下：

- 标记活动对象和非活动对象
- 复制 from space 的活动对象到 to space 并对其进行排序
- 释放 from space 中的非活动对象的内存
- 将 from space 和 to space 角色互换

<img src="/img/image-20220222215742735.png" alt="image-20220222215742735" style="zoom: 80%;" />

新生代又细分为`nursery`子代和`intermediate`子代两个区域。一个对象第一次分配内存时会被分配到新生代中的`nursery`子代，如果进过下一次垃圾回收这个对象还存在新生代中，这时候我们移动到 `intermediate` 子代，再经过下一次垃圾回收，如果这个对象还在新生代中，副垃圾回收器会将该对象移动到老生代中，这个移动的过程被称为**晋升**。

对象晋升的条件主要有以下两个：

- 对象是否经历过一次`Scavenge`算法
- `To`空间的内存占比是否已经超过`25%`(之所以有`25%`的内存限制是因为`To`空间在经历过一次`Scavenge`算法后会和`From`空间完成角色互换，会变为`From`空间，后续的内存分配都是在`From`空间中进行的，如果内存使用过高甚至溢出，则会影响后续对象的分配，因此超过这个限制之后对象会被直接转移到老生代来进行管理)

(1.3)老年代回收

scavenge算法缺陷：

- scavenge为复制算法，重复复制活动对象会使得效率低下
- scavenge是牺牲空间来换取时间效率的算法，而老生代支持的容量较大，会出现空间资源浪费问题

老年代采用 Mark-Sweep（标记清除） 和 Mark-Compact（标记整理） 算法。

1.）Mark-Sweep

Mark-Sweep处理时分为两阶段，标记阶段和清理阶段。看起来与Scavenge类似，不同的是，Mark-Sweep在标记了活动对象和非活动对象之后，直接把非活动对象清除。

- 标记阶段：对老生代进行第一次扫描，标记活动对象
- 清理阶段：对老生代进行第二次扫描，清除未被标记的对象，即清理非活动对象

<img src="/img/image-20220504095928130.png" alt="11" style="zoom: 80%;" />

但是遗留一个问题，被清除的对象遍布于各内存地址，产生很多内存碎片。

2.)Mark-Compact

若不清理这些内存碎片，如果出现需要分配一个大对象的时候，这时所有的碎片空间都完全无法完成分配，就会提前触发垃圾回收,而这次回收其实不是必要的。

Mark-Compact被提出，它是在 Mark-Sweep的基础上演进而来的，相比Mark-Sweep，Mark-Compact添加了活动对象整理阶段，将所有的活动对象往一端移动，移动完成后，直接清理掉边界外的内存。

<img src="/img/image-20220222220554956.png" alt="image-20220222220554956" style="zoom: 80%;" />

(1.4)全停顿 Stop-The-World

由于垃圾回收是在JS引擎中进行的，而Mark-Compact算法在执行过程中需要移动对象，而当活动对象较多的时候，它的执行速度不可能很快，为了避免JavaScript应用逻辑和垃圾回收器的内存资源竞争导致的不一致性问题，垃圾回收器会将JavaScript应用暂停，这个过程，被称为`全停顿`（stop-the-world）。

在新生代中，由于空间小、存活对象较少、Scavenge算法执行效率较快，所以全停顿的影响并不大。而老生代中就不一样，如果老生代中的活动对象较多，垃圾回收器就会暂停主线程较长的时间，使得页面变得卡顿。

**(5)标记活动对象和非活动对象的策略**

通常有两个：**引用计数**和**标记清除**

- 引用计数-dom的垃圾回收机制
- 标记清除-js的垃圾回收机制

(1.1)引用计数

定义：每个值被引用的次数。声明一个变量后，当使用引用类型值赋值时，+1，当这个变量又赋值另外一值，计数-1。

这是最初级的垃圾收集算法，如果没有引用指向该对象（零引用），对象将被垃圾回收机制回收。

缺陷:在循环的情况下，引用计数算法存在很大的局限性。

```
存在内存泄漏
function problem() {
var objA = new Object();
var objB = new Object();
objA.someOtherObject = objB;
objB.anotherObject = objA;
}
objectA 和objectB 通过各自的属性相互引用，即这两个对象的引用次数都是2，在采用标记清除策略的实现中，由于函数执行之后，这两个对象都离开了作用域，因此这种相互引用不是个问题。但在采用引用计数策略的实现中，当函数执行完毕后，objectA 和objectB 还说明将继续存在，因为它们的引用次数永远不会是0。

DOM中也如此
var element=document.getElementById（''）；
var myObj=new Object();
myObj.element=element;
element.someObject=myObj;
```

(1.2)标记清除

定义：当变量进入环境时，标记“进入环境”。当变量离开环境时，标记“离开环境”。

垃圾回收器创建了一个“roots”列表,“window”对象是一个全局变量，被当作root.

从root开始的所有对象如果是可达的，它就不被当作垃圾。所有未被标记的内存会被当做垃圾，收集器现在可以释放内存。

循环引用的问题迎刃而解，缺点: 算法运行时程序执行被暂停。

```
以下几种情况都可以作为根节点：
全局对象
本地函数的局部变量和参数
当前嵌套调用链上的其他函数的变量和参数
```



## 内存溢出和内存泄漏

**1.概念**

内存溢出：当程序需要的内存超过了剩余内存，就会抛出内存溢出错误。

内存泄漏：**不再用到的内存，没有及时释放，就叫做内存泄漏。**应用程序不再需要占用内存的时候，由于某些原因，内存没有被操作系统或可用内存池回收。

**2.内存溢出的几种场景**

**1.1前端溢出**

**(1)溢出原因**

由于过多的函数调用，导致调用堆栈无法容纳这些调用的[返回地址](https://link.jianshu.com/?t=https%3A%2F%2Fbaike.baidu.com%2Fitem%2F%E8%BF%94%E5%9B%9E%E5%9C%B0%E5%9D%80)，一般在[递归](https://link.jianshu.com/?t=https%3A%2F%2Fbaike.baidu.com%2Fitem%2F%E9%80%92%E5%BD%92)中产生。堆栈溢出很可能由[无限](https://link.jianshu.com/?t=https%3A%2F%2Fbaike.baidu.com%2Fitem%2F%E6%97%A0%E9%99%90)[递归](https://link.jianshu.com/?t=https%3A%2F%2Fbaike.baidu.com%2Fitem%2F%E9%80%92%E5%BD%92)（Infinite recursion）产生，但也可能仅仅是过多的堆栈层级

**(2)如何解决堆栈溢出**

解决方案：1，引入闭包； 2，引入计时器； 3，尾调优化

(2.1)引入闭包

错误代码

```
  function isEven(num){
     if(num == 0){return true;}
     if(num == 1){return false;}
     return isEven(Math.abs(num)-2);
 }
 console.log(isEven(100000))//堆栈溢出
```

引入闭包代码

```
function isEven(num){
    function isEvenInner(num){
        if(num === 0){return true;}
        if(num === 1){return false;}
        return function(){
        return isEvenInner(Math.abs(num)-2);
        }
    }
    function simplify(func,num){
        var value=func(num);
        while(typeof value == 'function'){
            value=value();
        }
        return value;
    }
    return simplify.bind(null,isEvenInner)(num)
}
console.log(isEven(100000));//这种方法num太大也不可以
```

(2.3)使用尾递归(尾调用)

错误代码

```
  function tailFactorial(n, total) {
    if (n === 1) return total;
    return tailFactorial(n - 1, n * total);
  }
  console.log(tailFactorial(5,1))
```

尾调优化（新增简化函数）

```
function tailFactorial(n, total) {
  if (n === 1) return total;
  return tailFactorial(n - 1, n * total);
}
console.log(tailFactorial(5,1))
function factorial(n) {
  return tailFactorial(n, 1);
}
console.log(factorial(10000))
```

尾调优化（柯里化）

```
function currying(fn,n){//柯里化要绑定的参数
    return function(m){//柯里化的函数，m对应输入的唯一一个参数
        return fn.call(this,m,n)  
}//柯里化
}
var factorial_1=currying(tailFactorial,1);
console.log(factorial_1(5));
```

尾调优化（ES6）

```
function factorial(n, total = 1) {
  if (n === 1) return total;
  return factorial(n - 1, n * total);
}
factorial(5) // 120
```

**1.2后端溢出**

1. 堆溢出(OutOfMemoryError:Java heap space)
2. 栈溢出(StackOverflowError)
3. 永久代溢出(OutOfMemoryError: PermGen space)
4. 直接内存溢出



**(1)堆溢出OOM**

```
public static void main(String[] args) {
    List<byte[]> list = new ArrayList<>();
    int i=0;
    while(true){
        list.add(new byte[5*1024*1024]);
        System.out.println("分配次数："+(++i));
    }
}
```

**(2)栈溢出**

栈空间不足时，需要分下面两种情况处理：

- 线程请求的栈深度大于虚拟机所允许的最大深度，将抛出StackOverflowError
- 虚拟机在扩展栈深度时无法申请到足够的内存空间，将抛出OutOfMemberError

```
public class StackSOFTest {

    int depth = 0;

    public void sofMethod(){
        depth ++ ;
        sofMethod();
    }

    public static void main(String[] args) {
        StackSOFTest test = null;
        try {
            test = new StackSOFTest();
            test.sofMethod();
        } finally {
            System.out.println("递归次数："+test.depth);
        }
    }
}

执行结果:
递归次数：982
Exception in thread "main" java.lang.StackOverflowError
    at com.ghs.test.StackSOFTest.sofMethod(StackSOFTest.java:8)
```

**(3)永久代溢出**

永久代溢出可以分为两种情况，第一种是常量池溢出，第二种是方法区溢出。

**(4)直接内存溢出**

```
public class DirectMemoryOOMTest {
    /**
     * VM Args:-Xms20m -Xmx20m -XX：MaxDirectMemorySize=10m
     * @param args
     */
    public static void main(String[] args) {
        int i=0;
        try {
            Field field = Unsafe.class.getDeclaredFields()[0];
            field.setAccessible(true);
            Unsafe unsafe = (Unsafe) field.get(null);
            while(true){
                unsafe.allocateMemory(1024*1024);
                i++;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }finally {
            System.out.println("分配次数："+i);
        }
    }
}
运行结果：
Exception in thread "main" java.lang.OutOfMemoryError
    at sun.misc.Unsafe.allocateMemory(Native Method)
```

- 栈内存溢出：程序所要求的栈深度过大。
- 堆内存溢出： 分清内存泄露还是 内存容量不足。泄露则看对象如何被 GC Root 引用，不足则通过调大-Xms，-Xmx参数。
- 永久代溢出：Class对象未被释放，Class对象占用信息过多，有过多的Class对象。
- 直接内存溢出：系统哪些地方会使用直接内存。

**3.内存泄漏的几种原因**

(1)意外的全局变量

```
function foo(arg) {
    bar = "this is a hidden global variable";
    this.bar = "potential accidental global"
}

真相是：
function foo(arg) {
    window.bar = "this is an explicit global variable";
}

实战：
<html>
<head></head>
<body>
<botton onclick="grow()">点击测试内存泄漏</botton>
<botton onclick="clearGrow()">点击释放内存</botton>
<div id="nodes"></div>
<script>
var largeObj = []
function grow(){
grow3()
}
function clearGrow(){
clearGrow3()
}
function getBigData(){
let res = []
for (var i = 0; i < 100; i++) {
let obj = {}
for(let i=0;i<10000;i++){
  obj[`key-${i}`] = `js创建一个很大内存的对象？`
}
res.push(obj)
}
return res
}
function grow0(){
 largeObj=[...largeObj,getBigData()]
}
var timer
function grow1(){
let someResource = getBigData();
 timer = setInterval(function() {
    var node = document.getElementById('nodes');
    if(node) {
        node.innerHTML = JSON.stringify(someResource);
        // 定时器也没有清除
    }
    // node、someResource 存储了大量数据 无法回收
}, 1000);
}
function clearGrow1(){
window.clearInterval(timer)
}
var childNode = document.createElement('p');
function grow2(){
let someResource = getBigData();
var node = document.getElementById('nodes');
    if(node) {
childNode.innerHTML = JSON.stringify(someResource);
node.appendChild(childNode)
  }
}
function clearGrow2(){
var node = document.getElementById('nodes');
node.remove();
//childNode = null;
}
function grow3(){
var theThing = null
    var replaceThing = function () {
        var originalThing = theThing
        var unused = function () {
            if (originalThing)
                console.log("hi")
        }
        theThing = {
            longStr: new Array(1000000).join('*'),
            someMethod: function someMethod() {
                console.log('someMessage')
            }
        };
    };
    setInterval(replaceThing,100)
}
function clearGrow3(){
解决: 去除unuserd函数或者在replaceThing函数最后一行加上 originlThing = null.
}
</script>
</body>
</html>
```

![image-20220313115045079](/img/image-20220313115045079.png)

解决方法：

- 避免创建全局变量
- 在 JavaScript 文件头部加上 `'use strict'`，可以避免此类错误发生。启用严格模式解析 JavaScript ，避免意外的全局变量

(2)被遗忘的定时器和回调函数

```
var timer
function grow1(){
let someResource = getBigData();
 timer = setInterval(function() {
    var node = document.getElementById('nodes');
    if(node) {
        node.innerHTML = JSON.stringify(someResource);
        // 定时器也没有清除
    }
    // node、someResource 存储了大量数据 无法回收
}, 1000);
}
function clearGrow1(){
window.clearInterval(timer)
}

原因:与节点或数据关联的计时器不再需要，node 对象可以删除，整个回调函数也不需要了。可是，计时器回调函数仍然没被回收（计时器停止才会被回收）。同时，someResource 如果存储了大量的数据，也是无法被回收的。
解决方法： 在定时器完成工作的时候，手动清除定时器和回调函数。
现代的浏览器（包括 IE 和 Microsoft Edge）使用了更先进的垃圾回收算法，已经可以正确检测和处理循环引用了。换言之，回收节点内存时，不必非要调用 removeEventListener 了。
```

![image-20220313115410595](/img/image-20220313115410595.png)

![image-20220313120537563](/img/image-20220313120537563.png)

(3)分离的dom引用

```
function grow2(){
let someResource = getBigData();
var node = document.getElementById('nodes');
    if(node) {
childNode.innerHTML = JSON.stringify(someResource);
node.appendChild(childNode)
  }
}

function clearGrow2(){
var node = document.getElementById('nodes');
node.remove();
//childNode = null;必须主动释放dom引用
}
```

![image-20220320214519742](/img/image-20220320214519742.png)

**原因**: 保留了DOM节点的引用,导致GC没有回收

**解决办法**：断开引用，childNode=null

(4)闭包

使用闭包只是让内存常驻，滥用闭包才会导致内存泄漏。

```
function grow3(){
var theThing = null
    var replaceThing = function () {
        var originalThing = theThing
        var unused = function () {
            if (originalThing)
                console.log("hi")
        }
        theThing = {
            longStr: new Array(1000000).join('*'),
            someMethod: function someMethod() {
                console.log('someMessage')
            }
        };
    };
    setInterval(replaceThing,100)
}

function clearGrow3(){
解决: 去除unuserd函数或者在replaceThing函数最后一行加上 originlThing = null.
}
```

首先我们明确一下，unused是一个闭包，因为它引用了自由变量 originalThing，虽然它被没有使用，但v8引擎并不会把它优化掉，因为 JavaScript里存在eval函数，所以v8引擎并不会随便优化掉暂时没有使用的函数。

theThing 引用了someMethod，someMethod这个函数作用域隐式的和unused这个闭包共享一个闭包上下文。所以someMethod也引用了originalThing这个自由变量。

```
GCHandler -> replaceThing -> theThing -> someMethod -> originalThing -> someMethod(old) -> originalThing(older)-> someMethod(older)
```

这里面的引用链是：

随着setInterval的不断执行，这条引用链是不会断的，所以内存会不断泄漏，直致程序崩溃。
因为是闭包作用域引起的内存泄漏，这时候最好的选择是使用 chrome的heap snapshot的container视图，我们通过container视图能清楚的看到这条不断泄漏内存的引用链

![image-20220320221047255](/img/image-20220320221047255.png)

这是一段糟糕的代码,每次调用 replaceThing ，theThing 得到一个包含一个大数组和一个新闭包（someMethod）的新对象。同时，变量 unused 是一个引用 originalThing 的闭包（先前的 replaceThing 又调用了theThing）。思绪混乱了吗？最重要的事情是，闭包的作用域一旦创建，它们有同样的父级作用域，作用域是共享的。someMethod 可以通过 theThing 使用，someMethod 与 unused 分享闭包作用域，尽管 unused 从未使用，它引用的 originalThing 迫使它保留在内存中（防止被回收）。当这段代码反复运行，就会看到内存占用不断上升，垃圾回收器（GC）并无法降低内存占用。本质上，闭包的链表已经创建，每一个闭包作用域携带一个指向大数组的间接的引用，造成严重的内存泄漏。

**解决**: 去除unuserd函数或者在replaceThing函数最后一行加上 originlThing = null.

**4.内存泄漏排查手段**

垃圾回收会导致主线程停下，产生交互的卡顿。

(1)chrome devtools-memory工具

主要功能分为：Head snapshot堆快照，Allocaiton instrumentastion on timeline(js堆内存在时间线上的回收情况)

```
<botton @click="grow()"></botton>
function largeObj(){
var largeArr= new Array(1000_10000);
}
var x= [];
fucntion grow(){
var o = new larfeObj();
x.push(new Array(1000_10000));
}

```

1)Head snapshot堆快照

```
1.核心参数
Summary：摘要视图
Comparison：对比视图，与其它快照对比，看增、删、Delta数量及内存大小
Containment：俯瞰视图，自顶向下看堆的情况，根节点包括window对象，GC root，原生对象等等列头
Shallow Size   ： 对象本身占用的内存
Retained Size ： 对象本身及其引用总共占用的内存
Distance ：当前对象到根的引用层级距离
Alloc. Size : 新分配的内存
Freed  Size ： 释放的内存
2.其他参数
Detached DOM tree：表示它已经不在DOM树上了，但Javascript仍旧对它有引用
(compiled code) — 未知，估计是程序代码区
(closure) — 闭包(array) — 未知
Object — JS对象类型(system) — 未知
(string) — 字符串类型，有时对象里添加了新属性，属性的名称也会出现在这里
Array — JS数组类型cls — 游戏大厅特有的继承类
Window — JS的window对象
Quark.DisplayObjectContainer — Quark引擎的显示容器类
Quark.ImageContainer — Quark引擎的图片类
Quark.Text — Quark引擎的文本类
Quark.ToggleButton — Quark引擎的开关按钮类

```

功能：查看两次快照之间的新建对象情况

录制两次可以操作之间的快照，使用object allocation between snashot1 and snapshot选项，比较两次快照间创建的对象，常用这个功能；

使用comparison，比较两次快照的内存增减情况

![image-20211207073137249](/img/image-20211207073137249.png)

largeObj的第0个元素，被window全局变量x引用着。

2)Allocaiton instrumentastion on timeline分配栈时间轴

功能：查看内存分配在代码中的位置，查看内存回收的时机和频率，要勾选Record stack

蓝色竖条表示内存未被回收，灰色表示内存回收。

![image-20211207073246002](/img/image-20211207073246002.png)

选中蓝色竖条，不仅可以查看Retainer表示的泄漏的对象，还可以通过Allocaiton stack分配栈，定位具体代码位置。

![image-20211207235441427](/img/image-20211207235441427.png)

在class filter中输入detached,查看是否存在分离的dom节点，如果能搜索出结果，说明有分离的dom节点

![image-20211208000338908](/img/image-20211208000338908.png)

查看Constructor构造器中出现system/Context,说明有函数导致闭包留存，下面的Retainer可以找到是inner函数引起的闭包内存泄漏。

![image-20211208001049548](/img/image-20211208001049548.png)

(2)在控制台使用ctrl+shift+p打开command menu，输入performance monitor来监听

## **V8引擎**

1.定义

`V8`是一个由`Google`开源的采用`C++`编写的高性能`JavaScript`和`WebAssembly`引擎。

主要工作：

- 编译和执行js代码，即将js代码转换为机器代码；
- 处理调用栈；
- 内存分配和垃圾回收；

2.原理

`V8`的内部有很多模块，其中最重要的4个：

- **Parser**解析器:负责将js源代码解析成AST抽象语法树
- **Interpreter**解释器:负责将AST解释为bytecode字节码文件，同时也有直接解释执行bytecode能力
- **complier**编译器:负责编译出运行更加高效的机器代码
- **Orinoco**: 垃圾回收器，负责进行内存空间回收

![image-20211209072317064](/img/image-20211209072317064.png)

(1)AST抽象语法树

![image-20211209072730664](/img/image-20211209072730664.png)

Parser解析器在转换过程中有两个重要的阶段：`词法分析（Lexical Analysis）`和`语法分析（Syntax Analysis）`.

- 词法分析,也称为分词，是将字符串形式的代码转换为标记（token）序列的过程。
- 语法分析,语法分心是将词法分析产生的`token`按照某种给定的形式文法转换成`AST`的过程。也就是把单词组合成句子的过程.

(2)byteCode

![image-20211209072755682](/img/image-20211209072755682.png)

(3)machine code

![image-20211209072828890](/img/image-20211209072828890.png)

3.V8发展史

(1)早期的V8

早期的版本5.8以前，V8没有解释器，只有2个编译器。

所以流程是这样的：

- 解析器对js解析成AST，**Full-codegen**编译器(也叫基准编译器)对AST编译成机器代码(省去了bytecode，执行效率更高)。
- 在执行的过程，有分析线程对机器代码进行优化，需要解析器对js解析成AST，**Crankshaft**编译器(也称为优化编译器)对代码进行优化。

```
优点：省去了bytecode的转化，直接生成更加高效的machine code机器代码.

缺点：V8团队的官方博客这样说,
a.生成的机器码占用了大量内存
b.缺少中间层的bytecode，很多性能优化策略无法实施
c.js引擎无法很好的支持新的语法
```

![image-20211209073441948](/img/image-20211209073441948.png)

(2)2017年4月新的V8架构

V8团队这样评价新架构：**它代表了V8团队通过实际测量Javascript性能，并仔细研究Full-codegen和Crankshaft的缺点后收集到的共同见解的顶峰**。

所以新的流程是这样的：

- 解析器对js解析成AST，**Igniton**基准解释器解释成bytecode字节码，并执行
- 执行一段时间后，**TruboFan**优化编译对bytecode字节码优化为更加高效的机器码

有几个优化点：

1.函数**只声明未被调用**，不会被解析成AST

2.函数**只被调用一次**，bytecode直接被解释执行，TruboFan不会进行优化编译

3.函数**被调用多次**，可能被标记为热点函数，可能被编译成机器代码

![image-20211209074403859](/img/image-20211209074403859.png)

(3)新架构的特点

将优化后的bytecode和machine code形成共存的状态。

这里要注意**deoptimization**即回退字节码，即由解释器解释执行。函数类型发生变化时，**Igniton**会检测到变化，会将字节码回退，重新解释为新的字节码。

建议：

1.不要将函数的类型变来变去，尽量保证类型一致，如sum(x,y) x一会是int,一会儿是num

优点：

1.第一次执行，直接使用中间层的字节码，省去了机器码，同时编译器生成字节码的速度远远大于机器码

2.优化线程不需要从源码从新编译，而是从bytecode字节码开始优化就可以了。同时**deoptimization**只需要回退到字节码即可。

优化点：

```
1.隐藏类（hidden class）
2.内联缓存（incline caching）
3.优化 Orinoco
3.1增量标记 - Incremental marking
3.2懒性清理 - Lazy sweeping
3.3并发 - Concurrent
3.4并行 - Parallel
```

## HTML页面乱码问题

HTML中的编码方式有三个：gb2312，gbk，utf-8；现在大部分浏览器默认编码的是utf-8。

```
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
```

●　http-equiv="Content-Type"表示描述文档类型

●　content="text/HTML;文档类型，这里为html,如果JS就是text/javascript，

●　charset=utf-8 页面字符集，编码，eg:gb2312,iso-8859-1,utf-8

## slice(),splice()两种方法

slice(start,end)有两个参数(start必需,end选填),都是索引,返回值不包括end,**不改变原数组**

```
var heroes=["0",'1','2','3','4'];
console.log(heroes.slice(1,4))//  [ "1", "2", "3" ]开始索引为1 结束索引为4(不包括4)
console.log(heroes)// 不改变原数组  ["0",'1','2','3','4']
```

splice(index,howmany,item1...itemX)只返回被删除的数据,类型为数组(**改变原数组**)

```
var heroes=["0",'1','2','3','4'];
console.log(heroes.splice(1,2))//  [ "1", "2"]开始索引为1 删除2个元素
console.log(heroes)// 不改变原数组  ["0",'3','4']
```

## typeof 与 instanceof 区别

6种基本数据类型：string,Number,boolean,undefined,null,symbol,其他类型如object,function,Array等

- `typeof`会返回一个变量的基本类型，typeof '1' // 'string'
- `instanceof` 可以准确地判断复杂引用数据类型，[1] instanceof Array //true

其中instance原理参考：

```
function myInstanceof(left, right) {
    // 这里先用typeof来判断基础数据类型，如果是，直接返回false
    if(typeof left !== 'object' || left === null) return false;
    // getProtypeOf是Object对象自带的API，能够拿到参数的原型对象
    let proto = Object.getPrototypeOf(left);
    while(true) {                  
        if(proto === null) return false;
        if(proto === right.prototype) return true;//找到相同原型对象，返回true
        proto = Object.getPrototypeof(proto);
    }
}
```

终极检查数据类型工具

```
Object.prototype.toString({})       // "[object Object]"
Object.prototype.toString.call({})  // 同上结果，加上call也ok
Object.prototype.toString.call(1)    // "[object Number]"
Object.prototype.toString.call('1')  // "[object String]"
Object.prototype.toString.call(true)  // "[object Boolean]"
Object.prototype.toString.call(function(){})  // "[object Function]"
Object.prototype.toString.call(null)   //"[object Null]"
Object.prototype.toString.call(undefined) //"[object Undefined]"
Object.prototype.toString.call(/123/g)    //"[object RegExp]"
Object.prototype.toString.call(new Date()) //"[object Date]"
Object.prototype.toString.call([])       //"[object Array]"
Object.prototype.toString.call(document)  //"[object HTMLDocument]"
Object.prototype.toString.call(window)   //"[object Window]"

function getType(obj){
  let type  = typeof obj;
  if (type !== "object") {    // 先进行typeof判断，如果是基础数据类型，直接返回
    return type;
  }
  // 对于typeof返回结果是object的，再进行如下的判断，正则返回结果
  return Object.prototype.toString.call(obj).replace(/^\[object (\S+)\]$/, '$1'); 
}
getType('123')  // "string"
```

## JS创建私有变量的方法

**1.使用闭包**

使用闭包可以使用私有属性或者方法的封装。利用闭包可以访问外部函数的变量特征

```js
function MyProfile() {
    const myTitle = "DevPoint";

    return {
        getTitle: function () {
            return myTitle;
        },
    };
}
const myProfile = MyProfile();
console.log(myProfile.getTitle()); // DevPoint
```

**2.在constructor中用Symbol代替key**

```js
// 类的开发者， 调用者
class Login{
    constructor(username,password){
        const PASSWORD = Symbol();
        this.username = username
        // 使用Symbol 规避了公共访问
        this[PASSWORD] = password;
        // 1. {} key
        // 2. 怎么存进对象？ key不可访问呢？私有
        // 3. symbol
    }
    checkPassword(pwd){
        return this[PASSWORD] == pwd
    }
}
var userA = new Login('aa','123456');
// userA.password = '123456';
console.log(userA.username)  //aa
console.log(userA.password)  //undefined
```

**3.用对象以Symbol定义**

```
const gender = Symbol('gender');
const obj = {
    name:'大胖猫',
    age:'3',
    [gender]:'公'
}
//obj.name  
obj[gender]  //调用成功 
// 不可枚举
console.log(Object.keys(obj));
console.log(JSON.stringify(obj));
```

**4.使用Class优化面向对象的读写操作**

```
class Person{
    constructor(name){
        this.name = name;   // 公有属性

    }
    get name(){
        console.log('get 方法');
        return this.name;
    }
    set name(str){
        console.log('设置了name 方法');
        this.name = str;
    }
}
let coco = new Person('coco');
console.log(coco.name);
```

**5.使用 ES2020 提案**

还处于 ES2020 试验草案中，引入了私有方法或者属性的定义，语法比较奇怪，以 `#` 作为前缀。

```
class ButtonCreator {
    #width;
    #height;
    constructor(width, height) {
        this.#width = width;
        this.#height = height;
    }
    // 私有方法
    #calculateWidth() {
        return this.#width;
    }

    getWidth = () => this.#calculateWidth();
    getHeight = () => this.#height;
    setWidth = (width) => (this.#width = width);
    setHeight = (height) => (this.#height = height);
}
const button = new ButtonCreator(600, 360);
console.log(button.width); // undefined
console.log(button.getWidth()); // 600
```

**6.使用 WeakMap**

这种方法建立在闭包方法之上，使用作用域变量方法创建一个私有 `WeakMap`，然后使用该 `WeakMap` 检索与此相关的私有数据。这比作用域变量方法更快，因为所有实例都可以共享一个 `WeakMap`，所以不需要每次创建实例时都重新创建方法。

```
const ButtonCreator = (function () {
    const privateProps = new WeakMap();
    class ButtonCreator {
        constructor(width, height, name) {
            this.name = name; // 公共属性
            privateProps.set(this, {
                width, // 私有属性
                height, // 私有属性
                calculateWidth: () => privateProps.get(this).width, // 私有方法
            });
        }

        getWidth = () => privateProps.get(this).calculateWidth();
        getHeight = () => privateProps.get(this).height;
    }
    return ButtonCreator;
})();
const button = new ButtonCreator(600, 360);
console.log(button.width); // undefined
console.log(button.getWidth()); // 600
```

**7.使用 TypeScript**

可以将 `TypeScript` 用作 JavaScript 的一种风格，可以使用 `private` 关键字从面向对象的语言中真正重新创建功能。

## 手写发布订阅

```js
<script>
let shoeObj = {}
shoeObj.list = []
// 增加订阅者
shoeObj.listen = function(key, fn){
    if(!this.list[key]){
        // 如果不存在key的订阅事件，则置为空
        this.list[key] = []
    }
    // 把函数fn加入回调数组
    this.list[key].push(fn)
}
// 发布消息
shoeObj.trigger=function(){
    // 取出key
    let key = Array.prototype.shift.call(arguments)
    let fns =this.list[key]
    // 遍历数组，执行函数fn
    if(!fns||!fns.length){
        return
    }
    for(let i = 0;i<fns.length;i++){
        fns[i].apply(this,arguments)
    }
}
shoeObj.listen('red',function(size){
 console.log(`小红订阅了${size}`);
})
shoeObj.listen('blue',function(size){
 console.log(`小蓝订阅了${size}`);
})
shoeObj.trigger('red',12)
shoeObj.trigger('blue',18)
</script>
```



# ES6

## set和map

`Set`是一种叫做集合的数据结构，`Map`是一种叫做字典的数据结构.

Set是由一堆无序的、相关联的，且不重复的内存结构;

Map是一些元素的集合。每个元素有一个称作key 的域，不同元素的key 各不相同

**Set**

set常用方法：add(),delete();has();clear();

遍历方法：keys();values();entires();foreach();

扩展运算符和` Set` 结构相结合实现数组或字符串去重

```js
// 数组
let arr = [3, 5, 2, 2, 5, 5];
let unique = [...new Set(arr)]; // [3, 5, 2]
```

实现并集、交集、和差集

```js
// 并集
let union = new Set([...a, ...b]);
// Set {1, 2, 3, 4}

// 交集
let intersect = new Set([...a].filter(x => b.has(x)));
// set {2, 3}

// （a 相对于 b 的）差集
let difference = new Set([...a].filter(x => !b.has(x)));
```

手写set

```
class Set {
  //Symbol.iterator 为每个对象定义了默认的迭代器。
  //该迭代器可以被for... of循环使用
  constructor(iterator = []) {
    //传递的对象必须是一个可迭代对象
    //所以需要判断传递的参数是否是可迭代对象
    if (typeof iterator[Symbol.iterator] !== 'function') {
      //不是可迭代对象就抛出一个错误
      throw new TypeError(`您所提供的 ${iterator}不是一个可迭代对象`)
    }
    //创建一个空数组
    this._datas = []
    //取出数组iterator里面的值，用for of循环
    for (const item of iterator) {
      // 将值添加到空数组中
      this.add(item)
    }
  }

  //判断两个值是否相等
  isEqual(data1, data2) {
    //1.存在两个都为0的情况
    if (data1 === 0 && data2 === 0) {
      return true
    }
    //2.Object.is()方法判断两个值是否为同一个值
    return Object.is(data1, data2)
  }

  //判断数据是否存在数组中
  has(data) {
    //遍历数组中的值(用for of)
    for (const item of this._datas) {
      //调用isEqual()方法判断 data(输入的数据)跟item(数组中的数据)
      if (this.isEqual(data, item)) {
        //相同返回true
        return true
      }
      //不相同返回false
      return false
    }
  }

  //添加数据的方法
  add(data) {
    //首先判断添加的值是否存在在当前数组中，存在的话就默认返回undefined，
    //不存在就把数据添加到之前定义的空数组中，
    // 此时已经不是空数组，而是存入了item值
    if (!this.has(data)) {
      //不存在就添加到数组中
      this._datas.push(data)
    }
    return this._datas
  }

  // 删除数据，返回结果true/false,删除成功/删除失败
  delete(data) {
    //遍历数组中的数据,i为下标,element为每个数据
    for (let i = 0; i < this._datas.length; i++) {
      const element = this._datas[i]
      //判断data跟element是否相同,相同说明数组中存在数据，可以删除
      if (this.isEqual(data, element)) {
        //删除数据利用splice()方法
        this._datas.splice(i, 1)
        //删除成功
        return true
      }
    }
    //删除失败
    return false
  }

  //清除数据
  clear() {
    //数组长度为0
    this._datas.length = 0
    return this._datas
  }

  //获取数组长度
  get size() {
    return this._datas.length
  }

  //forEach方法(里层用for of)
  forEach(callback) {
    for (const item of this._datas) {
      callback(item, item, this)
    }
  }

  values() {
    return this._datas
  }
  entries() {
    return this._datas.map(item => [item, item])
  }

  //*[Sysbol.iterator]
  *[Symbol.iterator]() {
    for (const item of this._datas) {
      yield item
    }
  }
}

const s = new Set([1, 1, '1'])
console.log([...s]) // [ 1, '1' ]
console.log(s.size) // 2
s.clear() // 清空重新来
console.log(s.size) // 0
s.add(1)
console.log(s.size) // 1
s.add(1) // 检测重复
console.log(s.size) // 1
s.add('1') // 检测 数字1 与 字符串 '1'
console.log(s.size) // 2
console.log(s.values()) // [ 1, '1' ]
s.add(2)
console.log(s.size) // 3
console.log(s.values()) //[ 1, '1', 2 ]
console.log(s.entries()) // [ [ 1, 1 ], [ '1', '1' ], [ 2, 2 ] ]
console.log([...s]) // [ 1, '1', 2 ]
s.delete(1)
console.log(s.size) // 2
s.clear()
console.log(s.size) // 0
```

**Map**

size 属性,set();get();has();delete();clear()

遍历：同set

手写map

map函数接收两个参数,迭代器函数fn和迭代器函数的this指向

```
class Map {
  //Symbol.iterator 为每个对象定义了默认的迭代器。
  //该迭代器可以被for... of循环使用
  constructor(iterator = []) {
    //传递的对象必须是一个可迭代对象
    //所以需要判断传递的参数是否是可迭代对象
    if (typeof iterator[Symbol.iterator] !== 'function') {
      //不是可迭代对象就抛出一个错误
      throw new TypeError(`您所提供的 ${iterator}不是一个可迭代对象`)
    }
    //创建一个空数组
    this._datas = []
    //取出数组iterator里面的值，用for of循环
    for (const item of iterator) {
      const [k, v] = item
      // 将值添加到空数组中
      this.set(k, v)
    }
  }

  //判断两个值是否相等
  isEqual(data1, data2) {
    //1.存在两个都为0的情况
    if (data1 === 0 && data2 === 0) {
      return true
    }
    //2.Object.is()方法判断两个值是否为同一个值
    return Object.is(data1, data2)
  }

  //判断数据是否存在数组中
  has(key) {
    //遍历数组中的值(用for of)
    for (const [k, _] of this._datas) {
      //调用isEqual()方法判断 data(输入的数据)跟item(数组中的数据)
      if (this.isEqual(key, k)) {
        //相同返回true
        return true
      }
      //不相同返回false
      return false
    }
  }

  //添加数据的方法
  set(key, val) {
    //首先判断添加的值是否存在在当前数组中，存在的话就默认返回undefined，
    //不存在就把数据添加到之前定义的空数组中，
    // 此时已经不是空数组，而是存入了item值
    if (!this.has(key)) {
      //不存在就添加到数组中
      this._datas.push([key, val])
    } else {
      const item = this._datas.find(([k, _]) => k === key)
      item[1] = val
    }
    return this._datas
  }
  //添加数据的方法
  get(key) {
    //首先判断添加的值是否存在在当前数组中，存在的话就默认返回undefined，
    //不存在就把数据添加到之前定义的空数组中，
    // 此时已经不是空数组，而是存入了item值
    if (!this.has(key)) {
      //不存在就添加到数组中
      return undefined
    }
    const item = this._datas.find(([k, _]) => k === key)
    return item[1]
  }

  // 删除数据，返回结果true/false,删除成功/删除失败
  delete(key) {
    if (!this.has(key)) {
      //不存在返回false
      return false
    }
    const idx = this._datas.findIndex(([k, _]) => k === key)
    //删除数据利用splice()方法
    this._datas.splice(idx, 1)
    //删除成功，返回true
    return true
  }

  //清除数据
  clear() {
    //数组长度为0
    this._datas.length = 0
    return this._datas
  }

  //获取数组长度
  get size() {
    return this._datas.length
  }

  //forEach方法(里层用for of)
  forEach(callback) {
    for (const [k, v] of this._datas) {
      callback(v, k, this)
    }
  }

  keys() {
    return this._datas.reduce((acc, cur) => {
      acc.push(cur[0])
      return acc
    }, [])
  }
  values() {
    return this._datas.reduce((acc, cur) => {
      acc.push(cur[1])
      return acc
    }, [])
  }
  entries() {
    return this._datas.reduce((acc, cur) => {
      acc.push([cur[0], cur[1]])
      return acc
    }, [])
  }

  //*[Sysbol.iterator]
  *[Symbol.iterator]() {
    for (const item of this._datas) {
      yield item
    }
  }
}

const m = new Map([[1], [2, 3]])
console.log([...m]) // [ [ 1, undefined ], [ 2, 3 ] ]
console.log(m.keys()) // [ 1, 2 ]
console.log(m.values()) // [ undefined, 3 ]
console.log(m.entries()) // [ [ 1, undefined ], [ 2, 3 ] ]
console.log(m.size) // [ [ 1, undefined ], [ 2, 3 ] ]
m.clear()
m.set(1, 2)
console.log(m.entries()) // [ [ 1, 2 ] ]
m.set(1, 3)
console.log(m.entries()) // [ [ 1, 3 ] ]
m.delete(1)
console.log(m.entries()) // []
```

1 迭代器函数 ，该函数有三个参数
数组项的值
数组项下标
数组对象本身
2 迭代器函数的this指向
（注：当传了该值，迭代器函数不能为箭头函数了。原因是箭头函数没有this隐式指向。箭头函数在定义时候就已经绑定了上层上下文中非箭头函数this）

```
Array.prototype.copyMap = function (fn, toThis) {
let arr = this;
const result = [];
const redirectThis = toThis || Object.create(null);
for (let i = 0; i < arr.length; i++) {
const item = fn.call(redirectThis, arr[i], i, arr);
result.push(item);
}
return result;
};
```



## Promise原理

[promise原理及手写]: https://juejin.cn/post/6850037281206566919#heading-6

1.promise解决的问题

它是一个异步解决方案，比如：以前嵌套调用即回调地域，处理多个异步请求并发。现在可以消灭嵌套调用和合并多个任务请求。

以前异步方案有四种：

- calllback回调函数；
- generator+co库；
- promise;
- aysnc+await;

2.promise/A+规范

- **解决（fulfill）**：指一个 promise 成功时进行的一系列操作，如状态的改变、回调的执行。虽然规范中用 `fulfill` 来表示解决，但在后世的 promise 实现多以 `resolve` 来指代之。
- **拒绝（reject）**：指一个 promise 失败时进行的一系列操作。
- **终值（eventual value）**：所谓终值，指的是 promise 被**解决**时传递给解决回调的值，由于 promise 有**一次性**的特征，因此当这个值被传递时，标志着 promise 等待态的结束，故称之终值，有时也直接简称为值（value）。
- **据因（reason）**：也就是拒绝原因，指在 promise 被**拒绝**时传递给拒绝回调的值。

[promise/A+]: http://www.ituring.com.cn/article/66566

promise状态有三种：等待态（Pending）、执行态（Fulfilled）和拒绝态（Rejected）。

promise提供一个 then 方法以访问其当前值、终值和据因。入参分别是 promise 成功的回调 onFulfilled, 和 promise 失败的回调 onRejected

3.原理

new promise时， 需要传递一个executor()执行器，入参是resolve和reject函数。结合settimeout异步+回调数组实现then异步，then的new promise实现链式调用

4.手写promise

4.1基础版

```js
Promise.js
class Promise{
    constructor(executor){
        if(typeof executor !=='function')
        throw new TypeError('executor 不是一个函数');
        const resolve =(value)=>{
            //接收终值，成功时回调
            console.log('接收终值');
        };
        const reject=(res)=>{
            //接收据因，失败时回调
            console.log('接收据因');
        };
        executor(resolve,reject);
    }
}
module.exports= Promise

index.js
const  Promise = require('./promise.js') 
new Promise((resolve,reject)=>{
    console.log('开始了');
    resolve(1)
})
```

代码优化版本

```js
class Promise{
    constructor(executor){
        if(typeof executor !=='function')
        throw new TypeError('executor 不是一个函数');

        this.initValue();
        this.initBind();
        executor(this.resolve,this.reject);
    }
    initValue(){
        //初始化
        this.value = null;//终值
        this.reason=null;//据因
        this.state='pending';//状态
    }
    initBind(){
        // 初始化改变this指向
        //如果是箭头函数，就不要改变this指向，因为箭头函数自动继承父的this即当前实例
        this.resolve = this.resolve.bind(this);
        this.reject = this.reject.bind(this);
    }
    resolve(value){
        //接收终值，成功时回调
        console.log('接收终值');
        if(this.state='pending'){
            this.state='fulfilled';
            this.value = value;
        }
    }
    reject(reason){
        //接收据因，失败时回调
        console.log('接收据因');
        if(this.state='pending'){
            this.state='fulfilled';
            this.reason = reason;
        }
    }
}

module.exports= Promise
```

4.2then异步实现

先上同步代码

```js
class Promise{
    constructor(executor){
        if(typeof executor !=='function')
        throw new TypeError('executor 不是一个函数');

        this.initValue();
        this.initBind();
        executor(this.resolve,this.reject);
    }
    initValue(){
        //初始化
        this.value = null;//终值
        this.reason=null;//据因
        this.state=Promise.PENDING;//状态
    }
    initBind(){
        // 初始化改变this指向
        //如果是箭头函数，就不要改变this指向，因为箭头函数自动继承父的this即当前实例
        this.resolve = this.resolve.bind(this);
        this.reject = this.reject.bind(this);
    }
    resolve(value){
        //接收终值，成功时回调
        console.log('接收终值');
        if(this.state=Promise.PENDING){
            this.state=Promise.FULFILLED;
            this.value = value;
        }
    }
    reject(reason){
        //接收据因，失败时回调
        console.log('接收据因');
        if(this.state=Promise.PENDING){
            this.state=Promise.REJECTED;
            this.reason = reason;
        }
    }
    then(onFulfilled,onRejected){
        //参数校验
        if(typeof onFulfilled !=='function' ){
            //不是函数则返回一个函数
            onFulfilled = function(value){
                return value;
            }
        }
        if(typeof onRejected !=='function' ){
            //不是函数则返回一个函数
            onRejected = function(reason){
                return reason;
            }
        }
        if(this.state ===Promise.FULFILLED){
            //有结果后，直接回调
            onFulfilled(this.value);
        }
        if(this.state ===Promise.REJECTED){
            onRejected(this.reason);
        }

    }
}

//也称为魔法数字
Promise.PENDING = 'pending';
Promise.FULFILLED = 'fulfilled';
Promise.REJECTED = 'rejected';
module.exports= Promise


console.log(1);
const  Promise = require('./promise.js') 
new Promise((resolve,reject)=>{
    console.log(2);
    setTimeout(()=>{
        resolve('我要执行')
    })
}).then(value=>{
    console.log(4);
    console.log('value:',value);
},reason=>{
    console.log('reason:',reason); 
})
console.log(3);
打印
1,2,3； 4不执行了，这是不对的
```

上异步代码

```
class Promise{
    constructor(executor){
        if(typeof executor !=='function')
        throw new TypeError('executor 不是一个函数');

        this.initValue();
        this.initBind();
        executor(this.resolve,this.reject);
    }
    initValue(){
        //初始化
        this.value = null;//终值
        this.reason=null;//据因
        this.state=Promise.PENDING;//状态
        this.onFulfilledCallbacks=[];//成功回调数组
        this.onRejectedCallbacks=[];//失败回调数组
    }
    initBind(){
        // 初始化改变this指向
        //如果是箭头函数，就不要改变this指向，因为箭头函数自动继承父的this即当前实例
        this.resolve = this.resolve.bind(this);
        this.reject = this.reject.bind(this);
    }
    resolve(value){
        //接收终值，成功时回调
        console.log('接收终值');
        if(this.state=Promise.PENDING){
            this.state=Promise.FULFILLED;
            this.value = value;
            // 成功后，执行成功的回调数组
            this.onFulfilledCallbacks.forEach(fn=>fn(this.value));
        }
    }
    reject(reason){
        //接收据因，失败时回调
        console.log('接收据因');
        if(this.state=Promise.PENDING){
            this.state=Promise.REJECTED;
            this.reason = reason;
            this.onRejectedCallbacks.forEach(fn=>fn(this.reason));
        }
    }
    then(onFulfilled,onRejected){
        //参数校验
        if(typeof onFulfilled !=='function' ){
            //不是函数则返回一个函数
            onFulfilled = function(value){
                return value;
            }
        }
        if(typeof onRejected !=='function' ){
            //不是函数则返回一个函数
            onRejected = function(reason){
                return reason;
            }
        }
        if(this.state ===Promise.FULFILLED){
            //有结果后，直接回调
            onFulfilled(this.value);
        }
        if(this.state ===Promise.REJECTED){
            onRejected(this.reason);
        }

        if(this.state ===Promise.PENDING){
            //还在执行中，将异步回调函数加入到数组中存放起来
            this.onFulfilledCallbacks.push(value=>{
                setTimeout(()=>{
                    onFulfilled(value);
                })
            })
            this.onRejectedCallbacks.push(reason=>{
                setTimeout(()=>{
                    onRejected(reason);
                })
            })
        }

    }
}

//也称为魔法数字
Promise.PENDING = 'pending';
Promise.FULFILLED = 'fulfilled';
Promise.REJECTED = 'rejected';
module.exports= Promise
```

4.3链式调用

```
promise.js文件
class Promise{
    constructor(executor){
        if(typeof executor !=='function')
        throw new TypeError('executor 不是一个函数');

        this.initValue();
        this.initBind();
        executor(this.resolve,this.reject);
    }
    initValue(){
        //初始化
        this.value = null;//终值
        this.reason=null;//据因
        this.state=Promise.PENDING;//状态
        this.onFulfilledCallbacks=[];//成功回调数组
        this.onRejectedCallbacks=[];//失败回调数组
    }
    initBind(){
        // 初始化改变this指向
        //如果是箭头函数，就不要改变this指向，因为箭头函数自动继承父的this即当前实例
        this.resolve = this.resolve.bind(this);
        this.reject = this.reject.bind(this);
    }
    resolve(value){
        //接收终值，成功时回调
        console.log('接收终值');
        if(this.state=Promise.PENDING){
            this.state=Promise.FULFILLED;
            this.value = value;
            // 成功后，执行成功的回调数组
            this.onFulfilledCallbacks.forEach(fn=>fn(this.value));
        }
    }
    reject(reason){
        //接收据因，失败时回调
        console.log('接收据因');
        if(this.state=Promise.PENDING){
            this.state=Promise.REJECTED;
            this.reason = reason;
            this.onRejectedCallbacks.forEach(fn=>fn(this.reason));
        }
    }
    then(onFulfilled,onRejected){
        //参数校验
        if(typeof onFulfilled !=='function' ){
            //不是函数则返回一个函数
            onFulfilled = function(value){
                return value;
            }
        }
        if(typeof onRejected !=='function' ){
            //不是函数则返回一个函数
            onRejected = function(reason){
                return reason;
            }
        }

        //链式调用，需要返回一个新实例
        let promise2=new Promise((resolve,reject)=>{
            if(this.state ===Promise.FULFILLED){
                //有结果后，直接回调
              try {
                const x=  onFulfilled(this.value);
                resolve(x);
              } catch (e) {
                  reject(e);
              }
            }
            if(this.state ===Promise.REJECTED){
                try {
                    const x= onRejected(this.reason);
                    resolve(x);
                } catch (e) {
                    reject(e);
                }
                
            }
    
            if(this.state ===Promise.PENDING){
                //还在执行中，将异步回调函数加入到数组中存放起来
                this.onFulfilledCallbacks.push(value=>{
                    setTimeout(()=>{
                        try {
                            const x = onFulfilled(value);
                        resolve(x);
                        } catch (e) {
                            reject(e);
                        }
                        
                    })
                })
                this.onRejectedCallbacks.push(reason=>{
                    setTimeout(()=>{
                        try {
                            const x=  onRejected(reason);
                        resolve(x);
                        } catch (e) {
                            reject(e);
                        }
                        
                    })
                })
            }
        })
        return promise2

    }
}

//也称为魔法数字
Promise.PENDING = 'pending';
Promise.FULFILLED = 'fulfilled';
Promise.REJECTED = 'rejected';
module.exports= Promise

index.js文件
console.log(1);
const  Promise = require('./promise.js') 
new Promise((resolve,reject)=>{
    console.log(2);
    setTimeout(()=>{
        resolve('我要执行')
    })
}).then(value=>{
    console.log(4);
    console.log('value:',value);
},reason=>{
    console.log('reason:',reason); 
}).then(value=>{
    console.log(5);
    console.log('value:',value);
})
console.log(3);
```

4.4终极解决方案

解决promise的then返回一个promise和循环递归调用自己

```js
Promise.js文件
class Promise{
    constructor(executor){
        if(typeof executor !=='function')
        throw new TypeError('executor 不是一个函数');

        this.initValue();
        this.initBind();
        executor(this.resolve,this.reject);
    }
    initValue(){
        //初始化
        this.value = null;//终值
        this.reason=null;//据因
        this.state=Promise.PENDING;//状态
        this.onFulfilledCallbacks=[];//成功回调数组
        this.onRejectedCallbacks=[];//失败回调数组
    }
    initBind(){
        // 初始化改变this指向
        //如果是箭头函数，就不要改变this指向，因为箭头函数自动继承父的this即当前实例
        this.resolve = this.resolve.bind(this);
        this.reject = this.reject.bind(this);
    }
    resolve(value){
        //接收终值，成功时回调
        console.log('接收终值');
        if(this.state=Promise.PENDING){
            this.state=Promise.FULFILLED;
            this.value = value;
            // 成功后，执行成功的回调数组
            this.onFulfilledCallbacks.forEach(fn=>fn(this.value));
        }
    }
    reject(reason){
        //接收据因，失败时回调
        console.log('接收据因');
        if(this.state=Promise.PENDING){
            this.state=Promise.REJECTED;
            this.reason = reason;
            this.onRejectedCallbacks.forEach(fn=>fn(this.reason));
        }
    }
    then(onFulfilled,onRejected){
        //参数校验
        if(typeof onFulfilled !=='function' ){
            //不是函数则返回一个函数
            onFulfilled = function(value){
                return value;
            }
        }
        if(typeof onRejected !=='function' ){
            //不是函数则返回一个函数
            onRejected = function(reason){
                return reason;
            }
        }

        //链式调用，需要返回一个新实例
        let promise2=new Promise((resolve,reject)=>{
            if(this.state ===Promise.FULFILLED){
                //有结果后，直接回调
              try {
                const x=  onFulfilled(this.value);
                // x可能是一个proimise
                Promise.resolvePromise(promise2, x, resolve, reject);
              } catch (e) {
                  reject(e);
              }
            }
            if(this.state ===Promise.REJECTED){
                try {
                    const x= onRejected(this.reason);
                    // x可能是一个proimise
                    Promise.resolvePromise(promise2, x, resolve, reject);
                } catch (e) {
                    reject(e);
                }
                
            }
    
            if(this.state ===Promise.PENDING){
                //还在执行中，将异步回调函数加入到数组中存放起来
                this.onFulfilledCallbacks.push(value=>{
                    setTimeout(()=>{
                        try {
                            const x = onFulfilled(value);
                        // x可能是一个proimise
                        Promise.resolvePromise(promise2, x, resolve, reject);
                        } catch (e) {
                            reject(e);
                        }
                        
                    })
                })
                this.onRejectedCallbacks.push(reason=>{
                    setTimeout(()=>{
                        try {
                            const x=  onRejected(reason);
                        // x可能是一个proimise
                        Promise.resolvePromise(promise2, x, resolve, reject);
                        } catch (e) {
                            reject(e);
                        }
                        
                    })
                })
            }
        })
        return promise2

    }
}

//也称为魔法数字
Promise.PENDING = 'pending';
Promise.FULFILLED = 'fulfilled';
Promise.REJECTED = 'rejected';
// 循环调用
Promise.resolvePromise=function(promise2,x,resolve,reject){
// x与promise相等，说明自己在调用自己
let called; //是否调用过，防止无限循环调用
if(promise2===x){
    reject(new TypeError('Chaining cycle detected for promise'));
}
 if(x instanceof Promise){
//判断x是promise
x.then(value=>{
    // 如果返回的是promise,则要继续调用
    if(called) return;
    called = true;
    Promise.resolvePromise(promise2,value,resolve,reject);
},reason=>{
reject(reason);
})
}else if(x !==null && (typeof x ==='object'||typeof x ==='function')){
// x为对象或函数
let then = x.then;//官方推荐这么写，不明原因
if(typeof then === 'function'){
then.call(x,value=>{
    // 如果返回的是promise,则要继续调用
    if(called) return;
    called = true;
    Promise.resolvePromise(promise2,value,resolve,reject);
},reason=>{
    reject(reason);
})
}else{
    reject(x);
}
}else{
    resolve(x);
}
}
module.exports= Promise

index.js文件
console.log(1);
const  Promise = require('./promise.js') 
new Promise((resolve,reject)=>{
    console.log(2);
    setTimeout(()=>{
        resolve('我要执行')
    })
}).then(value=>{
    console.log(4);
    console.log('value:',value);
    // then返回一个promise
    return new Promise(resolve=>{
        resolve('promise');
    })
},reason=>{
    console.log('reason:',reason); 
}).then(value=>{
    console.log(5);
    console.log('value:',value);
})
console.log(3);
```

```js
//循环调用
// let p1=new Promise(resolve=>{
//     console.log('p1');
//     resolve(1);
// })
// let p2=p1.then(()=>{
//     console.log('p2');
//     return p2
// })
```

```js
//简约版手写Promise
class MyPromise {
  constructor(executor) {
    this.status = 'pending' // 初始状态为等待
    this.value = null // 成功的值
    this.reason = null // 失败的原因
    this.onFulfilledCallbacks = [] // 成功的回调函数数组
    this.onRejectedCallbacks = [] // 失败的回调函数数组
    let resolve = value => {
      if (this.status === 'pending') {
        this.status = 'fulfilled'
        this.value = value;
        this.onFulfilledCallbacks.forEach(fn => fn()) // 调用成功的回调函数
      }
    }
    let reject = reason => {
      if (this.status === 'pending') {
        this.status = 'rejected'
        this.reason = reason
        this.onRejectedCallbacks.forEach(fn => fn()) // 调用失败的回调函数
      }
    };
    try {
      executor(resolve, reject)
    } catch (err) {
      reject(err)
    }
  }
  then(onFulfilled, onRejected) {
    return new MyPromise((resolve, reject) => {
      if (this.status === 'fulfilled') {
        setTimeout(() => {
          const x = onFulfilled(this.value);
          x instanceof MyPromise ? x.then(resolve, reject) : resolve(x)
        })
      }
      if (this.status === 'rejected') {
        setTimeout(() => {
          const x = onRejected(this.reason)
          x instanceof MyPromise ? x.then(resolve, reject) : resolve(x)
        })
      }
      if (this.status === 'pending') {
        this.onFulfilledCallbacks.push(() => { // 将成功的回调函数放入成功数组
          setTimeout(() => {
            const x = onFulfilled(this.value)
            x instanceof MyPromise ? x.then(resolve, reject) : resolve(x)
          })
        })
        this.onRejectedCallbacks.push(() => { // 将失败的回调函数放入失败数组
          setTimeout(() => {
            const x = onRejected(this.reason)
            x instanceof MyPromise ? x.then(resolve, reject) : resolve(x)
          })
        })
      }
    })
  }
}

// 测试
function p1() {
  return new MyPromise((resolve, reject) => {
    setTimeout(resolve, 1000, 1)
  })
}
function p2() {
  return new MyPromise((resolve, reject) => {
    setTimeout(resolve, 1000, 2)
  })
}
p1().then(res => {
  console.log(res) // 1
  return p2()
}).then(ret => {
  console.log(ret) // 2
})
```

4.5自动化测试Promise代码

```
Promise.defer = Promise.deferred = function () {
  let dfd = {};
  dfd.promise = new Promise((resolve,reject)=>{
      dfd.resolve = resolve;
      dfd.reject = reject;
  })
  return dfd;
}

```

安装测试脚本

```
npm install -g promises-aplus-tests
```

执行自动化脚本

```
promises-aplus-tests promise.js
```

4.6promise.all原理

```
Promise.all = function(values) {
  if (!Array.isArray(values)) {
    const type = typeof values;
    return new TypeError(`TypeError: ${type} ${values} is not iterable`)
  }
  
  return new Promise((resolve, reject) => {
    let resultArr = [];
    let orderIndex = 0;
    const processResultByKey = (value, index) => {
      resultArr[index] = value;
      if (++orderIndex === values.length) {
          resolve(resultArr)
      }
    }
    for (let i = 0; i < values.length; i++) {
      let value = values[i];
      if (value && typeof value.then === 'function') {
        value.then((value) => {
          processResultByKey(value, i);
        }, reject);
      } else {
        processResultByKey(value, i);
      }
    }
  });
}

```

4.7如何中断promise

注意这里是中断而不是终止，因为 Promise 无法终止，这个中断的意思是：在合适的时候，把 pending 状态的 promise 给 reject 掉。例如一个常见的应用场景就是希望给网络请求设置超时时间，一旦超时就就中断，我们这里用定时器模拟一个网络请求，随机 3 秒之内返回

```js
function timeoutWrapper(p, timeout = 2000) {
  const wait = new Promise((resolve, reject) => {
    setTimeout(() => {
      reject('请求超时')
    }, timeout)
  })
  return Promise.race([p, wait])
}
```

## Promise、Generator、Async三者的区别

**Promise**

Promise有三种状态：pending(进行中)、resolved(成功)、rejected(失败)。

缺点：

- 无法取消Promise，一旦新建它就会立即执行，无法中途取消。
- 如果不设置回调函数，Promise内部抛出的错误，不会反应到外部。
- 当处于Pending状态时，无法得知目前进展到哪一个阶段（刚刚开始还是即将完成）。
- Promise 真正执行回调的时候，定义 Promise 那部分实际上已经走完了，所以 Promise 的报错堆栈上下文不太友好。

**Generator**

Generator 是ES6引入的新语法，Generator是一个可以暂停和继续执行的函数。

简单的用法，可以当做一个Iterator来用，进行一些遍历操作。复杂一些的用法，他可以在内部保存一些状态，成为一个状态机。

```
Generator 基本语法包含两部分：函数名前要加一个星号；函数内部用 yield 关键字返回值。
yield，表达式本身没有返回值，或者说总是返回undefined。
next，方法可以带一个参数，该参数就会被当作上一个yield表达式的返回值。
```

```
function * foo(x) {
    var y = 2 * (yield (x + 1));
    var z = yield (y / 3);
    return (x + y + z);

}

var b = foo(5); 
b.next() // { value:6, done:false }
b.next(12) // { value:8, done:false } 
b.next(13) // { value:42, done:true }

```

**Async(推荐使用～～)**

async await 本身就是 promise+generator 的语法糖

Async 是 Generator 的一个语法糖。

async 对应的是 * 。

await 对应的是 yield 。

async/await 自动进行了 Generator 的流程控制。

**为什么Async/Await更好？**

1. 使用async函数可以让代码简洁很多，不需要像Promise一样需要些then，不需要写匿名函数处理Promise的resolve值，也不需要定义多余的data变量，还避免了嵌套代码。
2. 错误处理：Async/Await 让 try/catch 可以同时处理同步和异步错误。

## reduce,every,some

reduce累加器

var total = [ 0, 1, 2, 3 ].reduce(( acc, cur ) => {    return acc + cur }, 0);

every一假即假

const flag=[ 0, 1, 2, 3 ].every(ele=> {    return ele>3 });

some一真即真

const flag=[ 0, 1, 2, 3 ].some(ele=> {    return ele>3 });

## Symbol

ES6引入了一种新的原始数据类型Symbol，表示**独一无二的值**。

基本数据类型有6种：Undefined、Null、布尔值（Boolean）、字符串（String）、数值（Number）、对象（Object）。

`Symbol`函数前不能使用`new`命令，否则会报错。这是因为生成的Symbol是一个原始类型的值，不是对象。

```
// 没有参数的情况
var s1 = Symbol();
var s2 = Symbol();
s1 === s2 // false

// 有参数的情况
var s1 = Symbol("foo");
var s2 = Symbol("foo");
s1 === s2 // false
```

**1)应用场景1：使用Symbol来作为对象属性名(key)**

```
const PROP_NAME = Symbol()
const PROP_AGE = Symbol()

let obj = {
  [PROP_NAME]: "一斤代码"
}
obj[PROP_AGE] = 18
obj[PROP_NAME] // '一斤代码'
obj[PROP_AGE] // 18
```

Symbol类型的key是不能通过`Object.keys()`或者`for...in`来枚举的，它未被包含在对象自身的属性名集合(property names)之中。所以，利用该特性，我们可以把一些不需要对外操作和访问的属性使用Symbol来定义。

也正因为这样一个特性，当使用`JSON.stringify()`将对象转换成JSON字符串的时候，Symbol属性也会被排除在输出内容之外。

```
let obj = {
   [Symbol('name')]: '一斤代码',
   age: 18,
   title: 'Engineer'
}

Object.keys(obj)   // ['age', 'title']

for (let p in obj) {
   console.log(p)   // 分别会输出：'age' 和 'title'
}

Object.getOwnPropertyNames(obj)   // ['age', 'title']
JSON.stringify(obj)  // {"age":18,"title":"Engineer"}
```

还是会有一些专门针对Symbol的API

```
// 使用Object的API
Object.getOwnPropertySymbols(obj) // [Symbol(name)]

// 使用新增的反射API
Reflect.ownKeys(obj) // [Symbol(name), 'age', 'title']
```

**2)应用场景2：使用Symbol来替代常量**

```
const TYPE_AUDIO = Symbol()
const TYPE_VIDEO = Symbol()
const TYPE_IMAGE = Symbol()

function handleFileResource(resource) {
  switch(resource.type) {
    case TYPE_AUDIO:
      playAudio(resource)
      break
    case TYPE_VIDEO:
      playVideo(resource)
      break
    case TYPE_IMAGE:
      previewImage(resource)
      break
    default:
      throw new Error('Unknown type of resource')
  }
}
```

**3)应用场景3：使用Symbol定义类的私有属性/方法**

在JavaScript中，是没有如Java等面向对象语言的访问控制关键字`private`的，类上所有定义的属性或方法都是可公开访问的。因此这对我们进行API的设计时造成了一些困扰。

而有了`Symbol`以及`模块化机制`，类的私有属性和方法才变成可能。例如：

```
a.js
const PASSWORD = Symbol()

class Login {
  constructor(username, password) {
    this.username = username
    this[PASSWORD] = password
  }

  checkPassword(pwd) {
      return this[PASSWORD] === pwd
  }
}

export default Login
```

```
b.js
import Login from './a'

const login = new Login('admin', '123456')

login.checkPassword('admin')  // true

login.PASSWORD  // oh!no!
login[PASSWORD] // oh!no!
login["PASSWORD"] // oh!no!
```

**4)Symbol.for()，Symbol.keyFor()**

**Symbol.for**机制有点类似于单例模式，首先在全局中搜索有没有以该参数作为名称的Symbol值，如果有，就返回这个Symbol值，否则就新建并返回一个以该字符串为名称的Symbol值。和直接的Symbol就点不同了。

```
var s1 = Symbol.for('foo');
var s2 = Symbol.for('foo');

s1 === s2 // true
```

**Symbol.keyFor**方法返回一个已登记的Symbol类型值的key。实质就是检测该Symbol是否已创建

```
var s1 = Symbol.for("foo");
Symbol.keyFor(s1) // "foo"

var s2 = Symbol("foo");
Symbol.keyFor(s2) // undefined
```



## weakset 和 weakmap

ES6 考虑到防止内存泄漏，推出了两种新的数据结构： weakset 和 weakmap 。他们对值的引用都是不计入垃圾回收机制的，也就是说，如果其他对象都不再引用该对象，那么垃圾回收机制会自动回收该对象所占用的内存。

```
const wm = new WeakMap()const element = document.getElementById('example') vm.set(element, 'something') vm.get(element)
```

上面代码中，先新建一个 Weakmap 实例。然后，将一个 DOM 节点作为键名存入该实例，并将一些附加信息作为键值，一起存放在 WeakMap 里面。这时，WeakMap 里面对 element 的引用就是弱引用，不会被计入垃圾回收机制。

注册监听事件的 listener 对象很适合用 WeakMap 来实现。

```
// 代码1
ele.addEventListener('click', handler, false)// 
代码2
const listener = new WeakMap() 
listener.set(ele, handler) 
ele.addEventListener('click', listener.get(ele), false)
```

代码 2 比起代码 1 的好处是：由于监听函数是放在 WeakMap 里面，一旦 dom 对象 ele 消失，与它绑定的监听函数 handler 也会自动消失。

## for in、for of、forEach的区别

**for…of与for…in的区别**

- for…in循环会遍历（当前对象及其原型上的）每一个**属性名称**。
- for…of只能应用于**可迭代对象**，循环遍历（当前对象上的）每一个属性值.

**forEach**

是数组的一个方法，用于遍历数组的每一项，没有返回值，返回值总是undefined。

**for…of**

ES6提出的语句，在**可迭代对象**（Array，Map，Set，String，TypedArray，arguments）上创建一个迭代循环。

```
//遍历数组
let array = [10,20];
for(let val of array){
    console.log(val);
}
// 10
// 20

//遍历字符串
let str = "bo";
for(let val of str){
    console.log(val);
}
// "b"
// "o"

//遍历map
let map = new Map([["a", 1], ["b", 2], ["c", 3]]);
for(let entry of map){
    console.log(entry);
}
// ["a", 1]
// ["b", 2]
// ["c", 3]

for(let [key,value] of map){
    console.log(value);
}
// 1
// 2
// 3

//遍历set
let set = new Set([1,1,2,2,3,3]);
for(let value of set){
    console.log(value);
}
// 1
// 2
// 3

//遍历DOM
let divs = document.querySelectorAll("div");
for(let div of divs){
    div.className = "red";
}

//遍历生成器
function* fibonacci(){
    let [prev,curr] = [0,1];
    for(;;){
        [prev,curr] = [curr,curr+prev];
        yield curr;
    }
}

for(let n of fibonacci()){
    if(n>1000) break;
    console.log(n);
}
```

**for…in**

for…in 语句以任意顺序遍历**一个对象的可枚举属性的属性名**。所有可枚举属性和从它原型继承而来的可枚举属性，因此如果想要仅迭代对象本身的属性，要结合hasOwnProperty（）来使用

```
var obj = {a:1, b:2, c:3};
for(var prop in obj){
    console.log(prop);
}
//a
//b
//c

var obj= {
a:1,
[Symbol('level')]:2
}
Reflect.ownKeys(obj) // 遍历所有属性，包括Symbol
```



# Jquery

## unbind 和off的区别

off() 方法移除用.on()绑定的事件处理程序。

unbind() 方法移除用.bind()绑定的事件处理程序。

对比发现off 和unbind的 差别不大， 但是off多一个[selector] 可以过滤指定元素。

查看jQuery源码可知，.unbind()是通过.off()来实现的。

从 jQuery 1.7开始， .on() 和 .off()方法是最好的元素上附加和移除事件处理程序的方法

# TypeScript

**1.概念**

1)定义
 JavaScript的超集，支持es6标准，可以编译成普通js，可以在任何浏览器和操作系统上运行。
 2)历史
 2012年公开0.8第一个版本。
 3)背景
 JS设计最初是用于脚本语言，缺少大型项目的基础特性，如静态类型、类、模块等。最初ts是微软内部项目，致力于提升大型JS项目可靠性和维护性.
 4)特征
 静态类型批注和编译时类型检查，类、接口等