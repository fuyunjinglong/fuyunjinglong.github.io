---
title: A_模板
date: 2023-03-05 07:33:16
categories:
- A_编码规范
toc: true # 是否启用内容索引
---

# H5

- <a target="_blank" href="{% post_path 'B_JS_原形闭包' %}#闭包">为什么利用多个域名来存储网站资源会更有效 ？</a>
- <a target="_blank" href="{% post_path 'B_JS_原形闭包' %}#闭包">HTML5 的离线缓存原理</a>
- <a target="_blank" href="{% post_path 'B_JS_原形闭包' %}#闭包">cookies，sessionStorage 和 localStorage 的区别</a>
- <a target="_blank" href="{% post_path 'B_JS_原形闭包' %}#闭包">iframe 内嵌框架缺点</a>

# CSS

- <a target="_blank" href="{% post_path 'B_JS_原形闭包' %}#闭包">对 reflow 和 repaint 的理解</a>
- <a target="_blank" href="{% post_path 'B_JS_原形闭包' %}#闭包">盒子模型</a>
- <a target="_blank" href="{% post_path 'B_JS_原形闭包' %}#闭包">页面样式导入link 和 @import 区别</a>
- <a target="_blank" href="{% post_path 'B_JS_原形闭包' %}#闭包">常见兼容性问题？</a>
- <a target="_blank" href="{% post_path 'B_JS_原形闭包' %}#闭包">清除浮动</a>
- <a target="_blank" href="{% post_path 'B_JS_原形闭包' %}#闭包">如何保持水平垂直居中 ？</a>
- <a target="_blank" href="{% post_path 'B_JS_原形闭包' %}#闭包">position 、float 和 display 的取值意思</a>
- <a target="_blank" href="{% post_path 'B_JS_原形闭包' %}#闭包">CSS 常用3种引入方式</a>
- <a target="_blank" href="{% post_path 'B_JS_原形闭包' %}#闭包">CSS 选择符有哪些 ？哪些属性可以继承 ？优先级？</a>
- <a target="_blank" href="{% post_path 'B_JS_原形闭包' %}#闭包">CSS3 有哪些新特性 ?</a>
- <a target="_blank" href="{% post_path 'B_JS_原形闭包' %}#闭包">对BFC规范的理解</a>
- <a target="_blank" href="{% post_path 'B_JS_原形闭包' %}#闭包">canvas 与 svg 的区别 ？</a>
- <a target="_blank" href="{% post_path 'B_JS_原形闭包' %}#闭包">rem、em、px、vh 与 vw 的区别 ？</a>

# JS

- <a target="_blank" href="{% post_path 'B_JS_原形闭包' %}#闭包">call、apply、bind用法</a>
- <a target="_blank" href="{% post_path 'B_JS_原形闭包' %}#闭包">浏览器内核的理解</a>
- <a target="_blank" href="{% post_path 'B_JS_原形闭包' %}#闭包">null 和 undefined</a>
- <a target="_blank" href="{% post_path 'B_JS_原形闭包' %}#闭包">原型、原型链、继承</a>
- <a target="_blank" href="{% post_path 'B_JS_原形闭包' %}#闭包">闭包</a>
- <a target="_blank" href="{% post_path 'B_JS_原形闭包' %}#闭包">JS的8种继承方案</a>
- <a target="_blank" href="{% post_path 'B_JS_原形闭包' %}#闭包">实现 add(1)(2)(3) = 6</a>
- <a target="_blank" href="{% post_path 'B_JS_原形闭包' %}#闭包">从输入url到渲染完成整个过程</a>
- <a target="_blank" href="{% post_path 'B_JS_原形闭包' %}#闭包">垃圾回收机制</a>
- <a target="_blank" href="{% post_path 'B_JS_原形闭包' %}#闭包">JS 判断变量是对象还是数组</a>
- <a target="_blank" href="{% post_path 'B_JS_原形闭包' %}#闭包">继承在ES5和 ES6 的区别 ？</a>
- <a target="_blank" href="{% post_path 'B_JS_原形闭包' %}#闭包">JS类型判断---typeof, constructor, instanceof, toString</a>
- <a target="_blank" href="{% post_path 'B_JS_原形闭包' %}#闭包">消息队列和事件循环</a>
- <a target="_blank" href="{% post_path 'B_JS_原形闭包' %}#闭包">防抖和节流</a>
- <a target="_blank" href="{% post_path 'B_JS_原形闭包' %}#闭包">常见六大Web安全攻防解析</a>

# ES6

# 计算机网络

- <a target="_blank" href="{% post_path 'B_JS_原形闭包' %}#闭包">一文读懂 HTTP/1、HTTP/2、HTTP/3</a>

# 框架

## vue2

## vue3

# 性能优化

- <a target="_blank" href="{% post_path 'B_JS_原形闭包' %}#闭包">性能优化总策略</a>

# inter-h5

## 为什么利用多个域名来存储网站资源会更有效 ？

- 确保用户在不同地区能用最快的速度打开网站，其中某个域名崩溃用户也能通过其他域名访问网站。
- CDN 缓存更方便。简单来说，CDN 主要用来使用户就近获取资源。
- 突破浏览器并发限制。同一时间针对同一域名下的请求有一定数量限制，超过限制数目的请求会被阻塞。大多数浏览器的并发数量都控制在6以内。有些资源的请求时间很长，因而会阻塞其他资源的请求。因此，对于一些静态资源，如果放到不同的域名下面就能实现与其他资源的并发请求

## 行内、块级、空元素

- 行内元素有：a b span img input select strong（强调的语气）
- 块级元素有：div ul ol li dl dt dd h1 h2 h3 h4 p
- 常见的空元素： img input link meta br hr ，鲜为人知的是：area base col command embed keygen param source track wbr

## H5新特性

- 绘画 canvas;
- 用于媒介回放的 video 和 audio 元素;
- 本地离线存储 localStorage 长期存储数据，浏览器关闭后数据不丢失;
- sessionStorage 的数据在浏览器关闭后自动删除;
- 语意化更好的内容元素，比如 article、footer、header、nav、section;
- 表单控件：calendar、date、time、email、url、search;
- 新的技术：webworker, websocket, Geolocation;

## **HTML 语义化的理解 ？**

- 1、用正确的标签做正确的事情。
- 2、html 语义化让页面的内容结构化，结构更清晰，
- 3、便于对浏览器、搜索引擎解析;
- 4、即使在没有样式 CSS 情况下也以一种文档格式显示，并且是容易阅读的;
- 5、搜索引擎的爬虫也依赖于 HTML 标记来确定上下文和各个关键字的权重，利于 SEO;
- 6、使阅读源代码的人对网站更容易将网站分块，便于阅读维护理解。

## HTML5 的离线缓存原理

**定义**

在用户没有与因特网连接时，可以正常访问站点或应用

**原理**

HTML5离线缓存是基于manifest(缓存清单文件，后缀名为.appcache)的缓存机制，通过这个文件上的清单解析存储离线资源，就像cookie一样被存在本地，之后当处于离线状态时，就直接使用离线存储的资源进行页面的展示。

好处：

- 离线浏览，不再需要网络
- 速度快，已缓存的资源加载更快
- 减轻服务器压力，用户无需网络请求缓存资源

**使用**

1. h5头部标签引入manifest属性，值为manifest清单文件
2. 在manifest清单文件中编写离线存储的资源
3. 操作window.applicationCache进行缓存数据处理

manifest清单文件：

```
CACHE MANIFEST
#v0.11
CACHE: // 需要缓存的
js/app.js
css/style.css
NETWORK: // 不缓存的
resourse/logo.png
FALLBACK: // 网络失败时的替换页面
//offline.html
```

window.applicationCache.status的属性值如下：

- 0：（UNCACHED）无缓存，代表没有与当前页面相关的缓存资源；
- 1：（IDLE）闲置，代表应用缓存未得到更新；
- 2：（CHECKING）检查中，正在下载描述文件，并检查有无更新；
- 3：（DOWNLOADING）下载中，应用缓存正在下载描述文件中的资源；
- 4：（UPDATEREADY）更新完成，所有资源下载完毕；
- 5：（）废弃，即应用缓存的描述文件不存在了，因此页面无法在访问应用缓存；

**更新缓存时机**

1. 用户清空浏览器缓存；
2. manifest文件被修改；
3. 由程序来更新应用缓存；

**h5缓存与浏览器缓存区别**

- 离线缓存是针对整个应用，但是浏览器缓存是针对单个文件；
- 离线缓存断网了还可以继续访问，浏览器缓存不行；
- 离线缓存可以主动通知浏览器更新；

## cookies，sessionStorage 和 localStorage 的区别 

- cookie 是网站为了标示用户身份而储存在用户本地终端（Client Side）上的数据（通常经过加密）。
- cookie 数据始终在同源的 http 请求中携带（即使不需要），也会在浏览器和服务器间来回传递。
- sessionStorage 和 localStorage 不会自动把数据发给服务器，仅在本地保存。

存储大小

- cookie 数据大小不能超过 4k。
- sessionStorage 和 localStorage 虽然也有存储大小的限制，但比 cookie 大得多，可以达到 5M 或更大。

有期时间

- localStorage 存储持久数据，浏览器关闭后数据不丢失除非主动删除数据；
- sessionStorage 数据在当前浏览器窗口关闭后自动删除。
- cookie  设置的 cookie 过期时间之前一直有效，即使窗口或浏览器关闭。

## iframe 内嵌框架缺点

- iframe 会阻塞主页面的 onload 事件；
- 搜索引擎的检索程序无法解读这种页面，不利于 SEO 搜索引擎优化（Search Engine Optimization）
- iframe 和主页面共享连接池，而浏览器对相同域的连接有限制，所以会影响页面的并行加载。

如果需要使用 iframe，最好是通过 javascript 动态给 iframe 添加 src 属性值，这样可以绕开以上两个问题

# inter-css

## 页面样式导入link 和 @import 区别

- link 属于 XHTML 标签，除了加载 CSS 外，还能用于定义 RSS(是一种描述和同步网站内容的格式，是使用最广泛的 XML 应用), 定义 rel 连接属性等作用；
- 而 @import 是 CSS 提供的，只能用于加载 CSS;
- 页面被加载的时，link 会同时被加载，而 @import 引用的 CSS 会等到页面被加载完再加载;
- import 是 CSS2.1 提出的，只在 IE5 以上才能被识别，而 link 是 XHTML 标签，无兼容问题。
- 总之，link 要优于 @import。

## **常见兼容性问题？**

- 浏览器默认的 margin 和 padding 不同。解决方案是加一个全局的 *{margin: 0; padding: 0;} 来统一。
- IE下 event 对象有 event.x，event.y 属性，而 Firefox 下没有。Firefox 下有 event.pageX，event.PageY 属性，而 IE 下没有。 解决办法：var mx = event.x?event.x:event.pageX;
- Chrome 中文界面下默认会将小于 12px 的文本强制按照 12px 显示, 可通过加入 CSS 属性 -webkit-text-size-adjust: none; 解决.
- 超链接访问过后 hover 样式就不出现了，被点击访问过的超链接样式不在具有 hover 和 active 了，解决方法是改变 CSS 属性的排列顺序: L-V-H-A : a:link {} a:visited {} a:hover {} a:active {}

## 如何保持水平垂直居中 ？

一、水平居中 

（1）行内元素解决方案

只需要把行内元素包裹在一个属性 display 为 block 的父层元素中，并且把父层元素添加如下属性即可。

```
.parent {
    text-align: center;
}
```

（2）块状元素解决方案  

```
.item {
    /* 这里可以设置顶端外边距 */
    margin: 10px auto;
}
```

（3）多个块状元素解决方案将元素的 display 属性设置为 inline-block，并且把父元素的 text-align 属性设置为 center 即可:

```
.parent {
    text-align:center;
}
```

（4）多个块状元素解决方案

使用 flexbox 布局，只需要把待处理的块状元素的父元素添加属性 display: flex 及 justify-content: center 即可。

```
.parent {
    display: flex;
    justify-content: center;
}
```

二、垂直居中

（1）单行的行内元素解决方案

```
.parent {
    background: #222;
    height: 200px;
}

/* 以下代码中，将 a 元素的 height 和 line-height 设置的和父元素一样高度即可实现垂直居中 */
a {
    height: 200px;
    line-height:200px; 
    color: #FFF;
}
```

（2）多行的行内元素解决方案组合

使用 display: table-cell 和 vertical-align: middle 属性来定义需要居中的元素的父容器元素生成效果，如下：

```
.parent {
    background: #222;
    width: 300px;
    height: 300px;
    /* 以下属性垂直居中 */
    display: table-cell;
    vertical-align: middle;
}
```

（3）已知高度的块状元素解决方案

```
.item{
    position: absolute;
    top: 50%;
    margin-top: -50px;  /* margin-top值为自身高度的一半 */
    padding:0;
}
```

三、水平垂直居中

（1）已知高度和宽度的元素解决方案 1

这是一种不常见的居中方法，可自适应，比方案 2 更智能，如下：

```
.item{
    position: absolute;
    margin:auto;
    left:0;
    top:0;
    right:0;
    bottom:0;
}
```

（2）已知高度和宽度的元素解决方案 2

```
.item{
    position: absolute;
    top: 50%;
    left: 50%;
    margin-top: -75px;  /* 设置margin-left / margin-top 为自身高度的一半 */
    margin-left: -75px;
}
```

（3）未知高度和宽度元素解决方案

```
.item{
    position: absolute;
    top: 50%;
    left: 50%;
    transform: translate(-50%, -50%);  /* 使用 css3 的 transform 来实现 */
}
```

（4）使用 flex 布局实现

```
.parent{
    display: flex;
    justify-content: center;
    align-items: center;
    /* 注意这里需要设置高度来查看垂直居中效果 */
    background: #AAA;
    height: 300px;
}
```

------

## position 、float 和 display 的取值意思

position

- position 属性取值：static(默认)、relative、absolute、fixed、inherit、sticky。
- postision：static；始终处于文档流给予的位置。看起来好像没有用，但它可以快速取消定位，让 top，right，bottom，left 的值失效。在切换的时候可以尝试这个方法。
- 除了 static 值，在其他三个值的设置下，z-index 才会起作用。确切地说 z-index 只在定位元素上有效。
- position：relative 和 absolute 都可以用于定位，区别在于前者的 div 还属于正常的文档流，后者已经是脱离了正常文档流，不占据空间位置，不会将父类撑开。 定位原点 relative 是相对于它在正常流中的默认位置偏移，它原本占据的空间任然保留；absolute 相对于第一个 position 属性值不为 static 的父类。所以设置了 position：absolute，其父类的该属性值要注意，而且 overflow：hidden 也不能乱设置，因为不属于正常文档流，不会占据父类的高度，也就不会有滚动条。
- fixed 旧版本 IE 不支持，却是很有用，定位原点相对于浏览器窗口，而且不能变。 常用于 header，footer 或者一些固定的悬浮 div，随滚动条滚动又稳定又流畅，比 JS 好多了。fixed 可以有很多创造性的布局和作用，兼容性是问题。
- position：inherit。 规定从父类继承 position 属性的值，所以这个属性也是有继承性的，但需要注意的是 IE8 以及往前的版本都不支持 inherit 属性。
- sticky ：设置了sticky 的元素，在屏幕范围（viewport）时该元素的位置并不受到定位影响（设置是 top、left 等属性无效），当该元素的位置将要移出偏移范围时，定位又会变成 fixed，根据设置的 left、top 等属性成固定位置的效果。

float

- float：left (或 right)，向左（或右）浮动，直到它的边缘碰到包含框或另一个浮动框为止。 且脱离普通的文档流，会被正常文档流内的块框忽略。不占据空间，无法将父类元素撑开。
- 任何元素都可以浮动，浮动元素会生成一个块级框，不论它本身是何种元素。因此，没有必要为浮动元素设置 display：block。
- 如果浮动非替换元素，则要指定一个明确的 width，否则它们会尽可能的窄。 什么叫替换元素 ？根据元素本身的特点定义的， (X)HTML中的 img、input、textarea、select、object 都是替换元素，这些元素都没有实际的内容。 (X)HTML 的大多数元素是不可替换元素，他们将内容直接告诉浏览器，将其显示出来。

display

- display 属性取值：none、inline、inline-block、block、table 相关属性值、inherit。
- display 属性规定元素应该生成的框的类型。文档内任何元素都是框，块框或行内框。
- display：none 和 visiability：hidden 都可以隐藏 div，区别有点像 absolute 和 relative，前者不占据文档的空间，后者还是占据文档的位置。
- display：inline 和 block，又叫行内元素和块级元素。 表现出来的区别就是 block 独占一行，在浏览器中通常垂直布局，可以用 margin 来控制块级元素之间的间距（存在 margin 合并的问题，只有普通文档流中块框的垂直外边距才会发生外边距合并。行内框、浮动框或绝对定位之间的外边距不会合并。）； 而 inline 以水平方式布局，垂直方向的 margin 和 padding 都是无效的，大小跟内容一样，且无法设置宽高。 inline 就像塑料袋，内容怎么样，就长得怎么样；block 就像盒子，有固定的宽和高。
- inline-block 就介于两者之间。
- table 相关的属性值可以用来垂直居中，效果一般。
- flex

## **css3 动画效果属性有哪些 ?**

- animation-name：规定需要绑定到选择器的 keyframe 名称。。
- animation-duration：规定完成动画所花费的时间，以秒或毫秒计。
- animation-timing-function：规定动画的速度曲线。
- animation-delay：规定在动画开始之前的延迟。
- animation-iteration-count：规定动画应该播放的次数。
- animation-direction：规定是否应该轮流反向播放动画。

## CSS 常用3种引入方式

第一：外链式

这种方法可以说是现在占统治地位的引入方法。

如同 IE 与浏览器。这也是最能体现 CSS 特点的方法；

最能体现 DIV+CSS 中的内容离的思想，也最易改版维护，代码看起来也是最美观的一种。

第二：内部样式表

这种方法的使用情况要少的多，最长见得就是访问量大的门户网站。或者访问量较大的企业网站的首页。

与第一种方法比起来，优弊端也明显。

优点：速度快，所有的 CSS 控制都是针对本页面标签的，没有多余的 CSS 命令；再者不用外链 CSS 文件。直接在文档中读取样式。

缺点：就是改版麻烦些，单个页面显得臃肿，CSS 不能被其他 HTML 引用造成代码量相对较多，维护也麻烦些采用这种方法的公司大多有钱，对他们来说用户量是关键，他们不缺人进行复杂的维护工作。

第三：行内样式

认为 HTML 里不能出现 CSS 命令。其实有时候没有什么大不了。比如通用性差，效果特殊，使用 CSS 命令较少，并且不常改动的地方，使用这种方法反而是很好的选择。

第四、@import 引入方式

```
<style type="text/css">
@import url(my.css);
</style>
```

## **CSS Sprite雪碧图精灵图** 

将一个页面涉及到的所有图片都包含到一张大图中去，然后利用 CSS 的 background-image，background-repeat，background-position 的组合进行背景定位。

- 能很好地减少了网页的 http 请求，从而大大的提高了页面的性能，
- CSS Sprites 能减少图片的字节，曾经比较过多次 3 张图片合并成 1 张图片的字节总是小于这 3 张图片的和。
- 解决了网页设计师在图片命名上的困扰
- 更换风格方便，只需要在一张图片上修改样式，整个网页的风格就可以改变。维护起方便。

也存在一些不可忽视的缺点，如下：

- 在图片合并的时候，你要把多张图片有序的合理的合并成一张图片，还要留好足够的空间，防止板块内不不必要的背景；这些还好，最痛苦的是在宽屏，高分辨率的屏幕下的自适应页面，你的图片如果不够宽，很容背景断裂；
- CSS Sprites 在开发的时候比较麻烦，你要通过 photoshop 或其他工具测量计算每一个背景单元的精确位是针线活，没什么难度，但是很繁琐；
- CSS Sprites 在维护的时候比较麻烦，如果页面背景有少许改动，一般就要改这张合并的图片，无需改的好不要动，这样避免改动更多的 css，如果在原来的地方放不下，又只能（最好）往下加图片，这样图片的字加了，还要改动 css。

## CSS 选择符有哪些 ？哪些属性可以继承 ？优先级？

CSS 选择符

1. id选择器（ # myid）
2. 类选择器（.myclassname）
3. 标签选择器（div, h1, p）
4. 相邻选择器（h1 + p）
5. 子选择器（ul > li）
6. 后代选择器（li a）
7. 通配符选择器（ * ）
8. 属性选择器（a[rel = "external"]）
9. 伪类选择器（a: hover, li: nth - child）

可继承的样式

font-size，font-family，color，ul，li，dl，dd，dt；

不可继承的样式

border padding margin width height 事实上，宽度也不是继承的，而是如果你不指定宽度，那么它就是 100%。由于你子 DIV 并没有指定宽度，那它就是 100%，也就是与父 DIV 同宽，但这与继承无关，高度自然也没有继承一说。

优先级算法

 优先级为: !important > id > class > tag , important 比 内联优先级高

## **CSS3 新增伪类举例**

- :root 选择文档的根元素，等同于 html 元素
- :empty 选择没有子元素的元素
- :target 选取当前活动的目标元素
- :not(selector) 选择除 selector 元素以外的元素
- :enabled 选择可用的表单元素
- :disabled 选择禁用的表单元素
- :checked 选择被选中的表单元素
- :after 选择器在被选元素的内容后面插入内容
- :before 选择器在被选元素的内容前面插入内容
- :nth-child(n) 匹配父元素下指定子元素，在所有子元素中排序第 n
- :nth-last-child(n) 匹配父元素下指定子元素，在所有子元素中排序第 n，从后向前数
- :nth-child(odd) 奇数
- :nth-child(even) 偶数
- :nth-child(3n+1)
- :first-child
- :last-child
- :only-child
- :nth-of-type(n) 匹配父元素下指定子元素，在同类子元素中排序第 n
- :nth-last-of-type(n) 匹配父元素下指定子元素，在同类子元素中排序第 n，从后向前数
- :nth-of-type(odd)
- :nth-of-type(even)
- :nth-of-type(3n+1)
- :first-of-type
- :last-of-type
- :only-of-type
- ::selection 选择被用户选取的元素部分
- :first-line 选择元素中的第一行
- :first-letter 选择元素中的第一个字符

## **CSS3 有哪些新特性 ?**

- CSS3 实现圆角（border-radius:8px）
- 阴影（box-shadow:10px）
- 对文字加特效（text-shadow）
- 线性渐变（gradient）
- 旋转、缩放、定位、倾斜

```
 transform: rotate(9deg) scale(0.85,0.90) translate(0px,-30px) skew(-9deg,0deg); 
```

- 增加了更多的 CSS 选择器
- 多背景 rgba

canvas 与 svg 的区别 ？

- Canvas 是基于像素的即时模式图形系统，最适合较小的表面或较大数量的对象，Canvas 不支持鼠标键盘等事件。
- SVG 是基于形状的保留模式图形系统，更加适合较大的表面或较小数量的对象。
- Canvas 和 SVG 在修改方式上还存在着不同。 Canvas 输出的是一整幅画布，不能使用脚本和 CSS 对它进行修改。因为 SVG 绘制出来的每一个图形的元素都是独立的 DOM 节点，能够方便的绑定事件或用来修改

现在对两种技术做对比归纳如下：

Canvas

1. 依赖分辨率
2. 不支持事件处理器
3. 弱的文本渲染能力
4. 能够以 .png 或 .jpg 格式保存结果图像
5. 最适合图像密集型的游戏，其中的许多对象会被频繁重绘

SVG

1. 不依赖分辨率
2. 支持事件处理器
3. 最适合带有大型渲染区域的应用程序（比如谷歌地图）
4. 复杂度高会减慢渲染速度（任何过度使用 DOM 的应用都不快）
5. 不适合游戏应用

## ::before 和 :after 双冒号和单冒号的区别

- 单冒号 (:) 用于 CSS3 伪类，双冒号 (::) 用于 CSS3 伪元素。
- ::before 就是以一个子元素的存在，定义在元素主体内容之前的一个伪元素。并不存在于 dom 之中，只存在在页面之中。

:before 和 :after 这两个伪元素，是在 CSS2.1 里新出现的。 起初，伪元素的前缀使用的是单冒号语法，但随着 Web 的进化，在 CSS3 的规范里，伪元素的语法被修改成使用双冒号，成为 ::before、 ::after 。

## rem、em、px、vh 与 vw 的区别 ？

一、 rem 的特点

1. rem 的大小是根据 `html` 根目录下的字体大小进行计算的。
2. 当我们改变根目录下的字体大小的时候，下面字体都改变。
3. rem 不仅可以设置字体的大小，也可以设置元素宽、高等属性。
4. rem 是 CSS3 新增的一个相对单位（root em，根em），这个单位与 em 区别在于使用 rem 为元素设定字体大小时，仍然是相对大小，但相对的只是 HTML 根元素。

这个单位可谓集相对大小和绝对大小的优点于一身，通过它既可以做到只修改根元素就成比例地调整所有字体大小，又可以避免字体大小逐层复合的连锁反应。 目前，除了 IE8 及更早版本外，所有浏览器均已支持 rem。 对于不支持它的浏览器，应对方法也很简单，就是多写一个绝对单位的声明。这些浏览器会忽略用 rem 设定的字体大小。

二、px 特点

1. px 像素（Pixel）。相对长度单位。像素 px 是相对于显示器屏幕分辨率而言的。

三、em 特点 

1. em 的值并不是固定的；
2. em 会继承父级元素的字体大小。
3. em 是相对长度单位。当前对行内文本的字体尺寸未被人为设置，相对于当前对象内文本的字体尺寸。如则相对于浏览器的默认字体尺寸。
4. 任意浏览器的默认字体高都是 16px。

所有未经调整的浏览器一般都符合: 1em = 16px。那么 12px = 0.75em，10px = 0.625em。 为了简化 font-size 的换算，需要在 css 中的 body 选择器中声明 Fontsize = 62.5%，这就使 em 值变为 16px*62.5%=10px, 这样 12px = 1.2em, 10px = 1em, 也就是说只需要将你的原来的 px 数值除以 10，然后换上 em 作为单位就行了。

四、vh 与 vw

视口

- 在桌面端，指的是浏览器的可视区域；
- 在移动端，它涉及 3个 视口：Layout Viewport（布局视口），Visual Viewport（视觉视口），Ideal Viewport（理想视口）。
- 视口单位中的 “视口”，桌面端指的是浏览器的可视区域；移动端指的就是 Viewport 中的 Layout Viewport。

vh / vw 与 %

| 单位 | 解释                       |
| ---- | -------------------------- |
| vw   | 1vw = 视口宽度的 1%        |
| vh   | 1vh = 视口高度的 1%        |
| vmin | 选取 vw 和 vh 中最小的那个 |
| vmax | 选取 vw 和 vh 中最大的那个 |

比如：浏览器视口尺寸为 370px，那么 1vw = 370px * 1% = 6.5px (浏览器会四舍五入向下取 7)

vh / vw 与 % 区别

| 单位    | 解释           |
| ------- | -------------- |
| %       | 元素的祖先元素 |
| vh / vw | 视口的尺寸     |

不过由于 vw 和 vh 是 css3 才支持的长度单位，所以在不支持 css3 的浏览器中是无效的。

# inter-js

## call、apply、bind用法

1. 怎么利用 call、apply 来求一个数组中最大或者最小值 ?
2. 如何利用 call、apply 来做继承 ?
3. apply、call、bind 的区别和主要应用场景 ?

利用 call、apply 来求一个数组中最大或者最小值

```
const arr = [1,8,6]
Math.max.apply(Math或null, arr); //8
Math.max.call(Math或null, 1,8,6); //8
Math.max(...arr); //8 es6扩展运算符法
```

手写 bind

```
Function.prototype.myBind = function(context, ...args) {
  // 设置 fn 为调用 myCall 的方法
  const fn = this
  args = args ? args : []

  // 设置返回的一个新方法
  const result = function(...newFnArgs) {

    // 如果是通过 new 调用的，绑定 this 为实例对象
    if (this instanceof result) {
      fn.apply(this, [...args, ...newFnArgs]);
    } else { // 否则普通函数形式绑定 context
      fn.apply(context, [...args, ...newFnArgs]);
    }
  }

  // 绑定原型链
  result.prototype = Object.create(fn.prototype);

  // 返回结果
  return result;
};

this.a = 1;

const fn = function() {
  this.a = 2;
  console.log(this.a);
}

fn.myBind(fn);
fn();
```

实现 apply

```
Function.prototype.myApply = function (context, args) {
    //这里默认不传就是给window,也可以用es6给参数设置默认参数
    context = context || window
    args = args ? args : []
    //给context新增一个独一无二的属性以免覆盖原有属性
    const key = Symbol()
    context[key] = this
    //通过隐式绑定的方式调用函数
    const result = context[key](...args)
    //删除添加的属性
    delete context[key]
    //返回函数调用的返回值
    return result
}
```

实现 call

```
//传递参数从一个数组变成逐个传参了,不用...扩展运算符的也可以用arguments代替
Function.prototype.myCall = function (context, ...args) {
    //这里默认不传就是给window,也可以用es6给参数设置默认参数
    context = context || window
    args = args ? args : []
    //给context新增一个独一无二的属性以免覆盖原有属性
    const key = Symbol()
    context[key] = this
    //通过隐式绑定的方式调用函数
    const result = context[key](...args)
    //删除添加的属性
    delete context[key]
    //返回函数调用的返回值
    return result
}
```

## 浏览器内核的理解

内核分为2部分：渲染引擎(layout engineer 或 Rendering Engine) 和 JS 引擎

渲染引擎

负责取得网页的内容（HTML、XML、图像等等）、整理讯息（例如加入 CSS 等），以及计算网页的显示方式，然后会输出至显示器或打印机。 浏览器的内核的不同对于网页的语法解释会有不同，所以渲染的效果也不相同。 所有网页浏览器、电子邮件客户端以及其它需要编辑、显示网络内容的应用程序都需要内核。

JS 引擎

解析和执行 javascript 来实现网页的动态效果。

最开始渲染引擎和 JS 引擎并没有区分的很明确，后来 JS 引擎越来越独立，内核就倾向于只指渲染引擎。

## null 和 undefined

null 表示"没有对象"，即该处不应该有值。null 典型用法是： 

- 作为函数的参数，表示该函数的参数不是对象。 
- 作为对象原型链的终点。

undefined 表示"缺少值"，就是此处应该有一个值，未定义的值和定义未赋值的为 undefined

- 变量被声明了，但没有赋值时，就等于 undefined。 
- 调用函数时，应该提供的参数没有提供，该参数等于 undefined。 
- 对象没有赋值的属性，该属性的值为 undefined。 
- 函数没有返回值时，默认返回 undefined。

## 原型、原型链、继承

### **核心**

> **原型存在的意义就是组成原型链**：引用类型皆对象，每个对象都有原型，原型也是对象，也有它自己的原型，一层一层，组成原型链。
>
> **原型链存在的意义就是继承**：访问对象属性时，在对象本身找不到，就在原型链上一层一层找。说白了就是一个对象可以访问其他对象的属性。
>
> **继承存在的意义就是属性共享**：好处有二：一是代码重用，字面意思；二是可扩展，不同对象可能继承相同的属性，也可以定义只属于自己的属性。

### 标准

js之父在设计js原型、原型链的时候遵从以下两个准则

>  **准则1：原型对象（即Person.prototype）的constructor指向构造函数本身**
>
>  Person.prototype.constructor == Person //
>
>  **准则2：实例的__proto__ 保存着构造函数的prototype即实例（即person01）的__proto__和原型对象指向同一个地方**
>
>  person01.__proto__ == Person.prototype

- Person.prototype是显示原形属性
- person01.__proto__是隐式原形属性

### 定义

原型：proto是对象object的原形属性，所以proto叫对象的原形

原型对象：prototype是函数fn的原形属性，所以prototype叫fn的原形对象。注意原型对象中默认有一个`constructor`属性，指回该构造函数。

原型链：一句话就是以对象为基准，以proto为连接点，一直到Object.prototype为止的一条链条。(原型链顶层Object.prototype._proto__=null)

> 官方描述
>
> 在 JavaScript 中，实例对象在读取属性时总是先检查私有属性。如果存在，则会返回私有属性值；否则就会检索 prototype 原型；如果找到同名属性，则返回 prototype 原型的属性值。
>
> prototype 原型允许引用其他对象。如果在 prototype 原型中没有找到指定的属性，则 JavaScript 将会根据引用关系，继续检索 prototype 原型对象的 prototype 原型，以此类推。

```
// 原型
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
// 原型链
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
// 模拟一下js引擎读取对象属性
function getProperty(obj, propName) {
    // 在对象本身查找
    if (obj.hasOwnProperty(propName)) {
        return obj[propName]
    } else if (obj.__proto__ !== null) {
    // 如果对象有原型，则在原型上递归查找
        return getProperty(obj.__proto__, propName)
    } else {
    // 直到找到Object.prototype，Object.prototype.__proto__为null，返回undefined
        return undefined
    }
}
```

### 创建对象

对象的创建方式主要有两种，一种是`new`操作符后跟函数调用，另一种是字面量表示法。(字面量表示法可以理解为语法糖，本质还是new)。

**任何一个函数都可以当做构造函数**。

```
// 惯例，构造函数应以大写字母开头
function Person(name) {
  // 函数内this指向构造的对象
  // 构造一个name属性
  this.name = name
  // 构造一个sayName方法
  this.sayName = function() {
    console.log(this.name)
  }
}

// 使用自定义构造函数Person创建对象
let person = new Person('logan')
person.sayName() // 输出：logan
```

### 函数对象的原型链

函数都是由`Function`原生构造函数创建的，所以函数的`__proto__`属性指向`Function`的`prototype`属性。

注意一个特例：Function`的`__proto__`属性指向`Function.prototype

```
let fn = function() {}
// 函数（包括原生构造函数）的原型对象为Function.prototype
fn.__proto__ === Function.prototype // true
Array.__proto__ === Function.prototype // true
Object.__proto__ === Function.prototype // true
```

### Foo经典原型图

<img src="/img/image-20220605092641925.png" alt="image-20220605092641925" style="zoom:80%;" />

分3条线路分析一清二楚：

- 第1条路：左上角f1,f2
- 第2条路：构造函数Foo
- 第3条路：左侧o1,o2
- 第4条路：原生构造函数`Object`和`Function`

**第1条路：左上角f1,f2**

```
// f1、f2都是通过new Foo()创建的对象，构造函数为Foo，所以有
f1.__proto__ === Foo.prototype
// Foo.prototype为普通对象，构造函数为Object，所以有
Foo.prototype.__proto === Object.prototype
// Object.prototype没有原型对象
Object.prototype.__proto__ === null
```

**第2条路：构造函数Foo**

```
// Foo是个函数对象，构造函数为Function
Foo.__proto__ === Function.prototype
// Function.prototype为普通对象，构造函数为Object，所以有
Function.prototype.__proto__ === Object.prototype
```

**第3条路：左侧o1,o2**

对原生构造函数`Object`创建的`o1`、`o2`下手：

```javascript
// o1、o2构造函数为Object
o1.__proto__ === Object.prototype
```

**第4条路：原生构造函数`Object`和`Function`**

```
// 原生构造函数也是函数对象，其构造函数为Function
Object.__proto__ === Function.prototype
// 特例
Function.__proto__ === Function.prototype
```

### 举一反三

#### `instanceof`操作符

`typeof`运算符判断基本类型可以，但对引用类型无法判断(函数对象会返回`function`外，其他都返回`object`)。

**关键一句话**：`instanceof`运算符用于检查右边构造函数的`prototype`属性是否出现在左边对象的原型链中的任何位置。其实它表示的是一种原型链继承的关系

> MDN描述：instanceof运算符用于测试构造函数的prototype属性是否出现在对象的原型链中的任何位置

```html
instanceof`操作符左边是一个对象，右边是一个构造函数，在左边对象的原型链上查找，直到找到右边构造函数的prototype属性就返回`true`，或者查找到顶层`null`（也就是`Object.prototype.__proto__`），就返回`false
```

```
// 手写instanceOf
function instanceOfMe(obj, Constructor) { // obj 表示左边的对象，Constructor表示右边的构造函数
    let rightP = Constructor.prototype // 取构造函数显示原型
    let leftP = obj.__proto__ // 取对象隐式原型
    // 到达原型链顶层还未找到则返回false
    if (leftP === null) {
        return false
    }
    // 对象实例的隐式原型等于构造函数显示原型则返回true
    if (leftP === rightP) {
        return true
    }
    // 查找原型链上一层
    return instanceOfMe(obj.__proto__, Constructor)
}
```

可以解释令人费解的现象：

```
fn instanceof Object //true
// 1. fn.__proto__ === Function.prototype
// 2. fn.__proto__.__proto__ === Function.prototype.__proto__ === Object.prototype
arr instanceof Object //true
// 1. arr.__proto__ === Array.prototype
// 2. arr.__proto__.__proto__ === Array.prototype.__proto__ === Object.prototype
Object instanceof Object // true
// 1. Object.__proto__ === Function.prototype
// 2. Object.__proto__.__proto__ === Function.prototype.__proto__ === Object.prototype
Function instanceof Function // true
// Function.__proto__ === Function.prototype
```

#### `Object.create`

其实是创建对象的第三种方法，是ES5提供的，会创建一个新对象。

```
// 手写Object.create
function createObj(proto) {
    function F() {}
    F.prototype = proto
    return new F()
}
```

#### `new`操作符

当我们使用`new`时，做了些什么？

1. 创建一个全新对象，并将其`__proto__`属性指向构造函数的`prototype`属性。
2. 将构造函数调用的this指向这个新对象，并执行构造函数。
3. 如果构造函数返回对象类型Object(包含Functoin, Array, Date, RegExg, Error等)，则正常返回，否则返回这个新的对象。

依然来模拟实现一下：

```javascript
function newOperator(func, ...args) {
    if (typeof func !== 'function') {
        console.error('第一个参数必须为函数，您传入的参数为', func)
        return
    }
    // 创建一个全新对象，并将其`__proto__`属性指向构造函数的`prototype`属性
    let newObj = Object.create(func.prototype)
    // 将构造函数调用的this指向这个新对象，并执行构造函数
    let result = func.apply(newObj, args)
    // 如果构造函数返回对象类型Object，则正常返回，否则返回这个新的对象
    return (result instanceof Object) ? result : newObj
}
```

#### Function & Object 鸡蛋问题

不必深究，[鸡蛋问题原文](https://github.com/yygmind/blog/issues/35)

### 参考

[深入JavaScript系列（六）：原型与原型链](https://juejin.cn/post/6844903749345886216#heading-5)

[深入理解javascript原型和闭包（完结）](https://www.cnblogs.com/wangfupeng1988/p/3977924.html)

## JS的8种继承方案

### 原型链继承

继承的本质就是复制，即重写原型对象，代之以一个新类型的实例。

```
function SuperType() {
    this.property = true;
}

SuperType.prototype.getSuperValue = function() {
    return this.property;
}

function SubType() {
    this.subproperty = false;
}

// 这里是关键，创建SuperType的实例，并将该实例赋值给SubType.prototype
SubType.prototype = new SuperType(); 

SubType.prototype.getSubValue = function() {
    return this.subproperty;
}

var instance = new SubType();
console.log(instance.getSuperValue()); // true
```

缺点：多个实例对引用类型的操作会被篡改。

```
function SuperType(){
  this.colors = ["red", "blue", "green"];
}
function SubType(){}

SubType.prototype = new SuperType();

var instance1 = new SubType();
instance1.colors.push("black");
alert(instance1.colors); //"red,blue,green,black"

var instance2 = new SubType(); 
alert(instance2.colors); //"red,blue,green,black"
```

### 借用构造函数继承

使用父类的构造函数来增强子类**实例**，等同于复制父类的实例给子类（不使用原型）

```js
function  SuperType(){
    this.color=["red","green","blue"];
}
function  SubType(){
    //继承自SuperType
    SuperType.call(this);
}
var instance1 = new SubType();
instance1.color.push("black");
alert(instance1.color);//"red,green,blue,black"

var instance2 = new SubType();
alert(instance2.color);//"red,green,blue"
复制代码
```

核心代码是`SuperType.call(this)`，创建子类实例时调用`SuperType`构造函数，于是`SubType`的每个实例都会将SuperType中的属性复制一份。

缺点：

- 只能继承父类的**实例**属性和方法，不能继承原型属性/方法
- 无法实现复用，每个子类都有父类实例函数的副本，影响性能

### 组合继承

组合上述两种方法就是组合继承。用原型链实现对**原型**属性和方法的继承，用借用构造函数技术来实现**实例**属性的继承。

```js
function SuperType(name){
  this.name = name;
  this.colors = ["red", "blue", "green"];
}
SuperType.prototype.sayName = function(){
  alert(this.name);
};

function SubType(name, age){
  // 继承属性
  // 第二次调用SuperType()
  SuperType.call(this, name);
  this.age = age;
}

// 继承方法
// 构建原型链
// 第一次调用SuperType()
SubType.prototype = new SuperType(); 
// 重写SubType.prototype的constructor属性，指向自己的构造函数SubType
SubType.prototype.constructor = SubType; 
SubType.prototype.sayAge = function(){
    alert(this.age);
};

var instance1 = new SubType("Nicholas", 29);
instance1.colors.push("black");
alert(instance1.colors); //"red,blue,green,black"
instance1.sayName(); //"Nicholas";
instance1.sayAge(); //29

var instance2 = new SubType("Greg", 27);
alert(instance2.colors); //"red,blue,green"
instance2.sayName(); //"Greg";
instance2.sayAge(); //27
复制代码
```

缺点：

- 第一次调用`SuperType()`：给`SubType.prototype`写入两个属性name，color。
- 第二次调用`SuperType()`：给`instance1`写入两个属性name，color。

实例对象`instance1`上的两个属性就屏蔽了其原型对象SubType.prototype的两个同名属性。所以，组合模式的缺点就是在使用子类创建实例对象时，其原型中会存在两份相同的属性/方法。

### 原型式继承

利用一个空对象作为中介，将某个对象直接赋值给空对象构造函数的原型。

```js
function object(obj){
  function F(){}
  F.prototype = obj;
  return new F();
}
复制代码
```

object()对传入其中的对象执行了一次`浅复制`，将构造函数F的原型直接指向传入的对象。

```js
var person = {
  name: "Nicholas",
  friends: ["Shelby", "Court", "Van"]
};

var anotherPerson = object(person);
anotherPerson.name = "Greg";
anotherPerson.friends.push("Rob");

var yetAnotherPerson = object(person);
yetAnotherPerson.name = "Linda";
yetAnotherPerson.friends.push("Barbie");

alert(person.friends);   //"Shelby,Court,Van,Rob,Barbie"
复制代码
```

缺点：

- 原型链继承多个实例的引用类型属性指向相同，存在篡改的可能。
- 无法传递参数

另外，ES5中存在`Object.create()`的方法，能够代替上面的object方法。

### 寄生式继承

核心：在原型式继承的基础上，增强对象，返回构造函数

```js
function createAnother(original){
  var clone = object(original); // 通过调用 object() 函数创建一个新对象
  clone.sayHi = function(){  // 以某种方式来增强对象
    alert("hi");
  };
  return clone; // 返回这个对象
}
复制代码
```

函数的主要作用是为构造函数新增属性和方法，以**增强函数**

```js
var person = {
  name: "Nicholas",
  friends: ["Shelby", "Court", "Van"]
};
var anotherPerson = createAnother(person);
anotherPerson.sayHi(); //"hi"
复制代码
```

缺点（同原型式继承）：

- 原型链继承多个实例的引用类型属性指向相同，存在篡改的可能。
- 无法传递参数

### 寄生组合式继承

结合借用构造函数传递参数和寄生模式实现继承

```js
function inheritPrototype(subType, superType){
  var prototype = Object.create(superType.prototype); // 创建对象，创建父类原型的一个副本
  prototype.constructor = subType;                    // 增强对象，弥补因重写原型而失去的默认的constructor 属性
  subType.prototype = prototype;                      // 指定对象，将新创建的对象赋值给子类的原型
}

// 父类初始化实例属性和原型属性
function SuperType(name){
  this.name = name;
  this.colors = ["red", "blue", "green"];
}
SuperType.prototype.sayName = function(){
  alert(this.name);
};

// 借用构造函数传递增强子类实例属性（支持传参和避免篡改）
function SubType(name, age){
  SuperType.call(this, name);
  this.age = age;
}

// 将父类原型指向子类
inheritPrototype(SubType, SuperType);

// 新增子类原型属性
SubType.prototype.sayAge = function(){
  alert(this.age);
}

var instance1 = new SubType("xyc", 23);
var instance2 = new SubType("lxy", 23);

instance1.colors.push("2"); // ["red", "blue", "green", "2"]
instance1.colors.push("3"); // ["red", "blue", "green", "3"]
复制代码
```

这个例子的高效率体现在它只调用了一次`SuperType` 构造函数，并且因此避免了在`SubType.prototype` 上创建不必要的、多余的属性。于此同时，原型链还能保持不变；因此，还能够正常使用`instanceof` 和`isPrototypeOf()`

**这是最成熟的方法，也是现在库实现的方法**

### 混入方式继承多个对象

```js
function MyClass() {
     SuperClass.call(this);
     OtherSuperClass.call(this);
}

// 继承一个类
MyClass.prototype = Object.create(SuperClass.prototype);
// 混合其它
Object.assign(MyClass.prototype, OtherSuperClass.prototype);
// 重新指定constructor
MyClass.prototype.constructor = MyClass;

MyClass.prototype.myMethod = function() {
     // do something
};
复制代码
```

`Object.assign`会把  `OtherSuperClass`原型上的函数拷贝到 `MyClass`原型上，使 MyClass 的所有实例都可用 OtherSuperClass 的方法。

### ES6类继承extends

`extends`关键字主要用于类声明或者类表达式中，以创建一个类，该类是另一个类的子类。其中`constructor`表示构造函数，一个类中只能有一个构造函数，有多个会报出`SyntaxError`错误,如果没有显式指定构造方法，则会添加默认的 `constructor`方法，使用例子如下。

```js
class Rectangle {
    // constructor
    constructor(height, width) {
        this.height = height;
        this.width = width;
    }
    
    // Getter
    get area() {
        return this.calcArea()
    }
    
    // Method
    calcArea() {
        return this.height * this.width;
    }
}

const rectangle = new Rectangle(10, 20);
console.log(rectangle.area);
// 输出 200

-----------------------------------------------------------------
// 继承
class Square extends Rectangle {

  constructor(length) {
    super(length, length);
    
    // 如果子类中存在构造函数，则需要在使用“this”之前首先调用 super()。
    this.name = 'Square';
  }

  get area() {
    return this.height * this.width;
  }
}

const square = new Square(10);
console.log(square.area);
// 输出 100
复制代码
```

`extends`继承的核心代码如下，其实现和上述的寄生组合式继承方式一样

```js
function _inherits(subType, superType) {
  
    // 创建对象，创建父类原型的一个副本
    // 增强对象，弥补因重写原型而失去的默认的constructor 属性
    // 指定对象，将新创建的对象赋值给子类的原型
    subType.prototype = Object.create(superType && superType.prototype, {
        constructor: {
            value: subType,
            enumerable: false,
            writable: true,
            configurable: true
        }
    });
    
    if (superType) {
        Object.setPrototypeOf 
            ? Object.setPrototypeOf(subType, superType) 
            : subType.__proto__ = superType;
    }
}
复制代码
```

### 总结

1、函数声明和类声明的区别

函数声明会提升，类声明不会。首先需要声明你的类，然后访问它，否则像下面的代码会抛出一个ReferenceError。

```js
let p = new Rectangle(); 
// ReferenceError

class Rectangle {}
复制代码
```

2、ES5继承和ES6继承的区别

- ES5的继承实质上是先创建子类的实例对象，然后再将父类的方法添加到this上（Parent.call(this)）.
- ES6的继承有所不同，实质上是先创建父类的实例对象this，然后再用子类的构造函数修改this。因为子类没有自己的this对象，所以必须先调用父类的super()方法，否则新建实例报错。

> [《javascript高级程序设计》笔记：继承](https://link.juejin.cn?target=https%3A%2F%2Fsegmentfault.com%2Fa%2F1190000011917606)
> [MDN之Object.create()](https://link.juejin.cn?target=https%3A%2F%2Fdeveloper.mozilla.org%2Fzh-CN%2Fdocs%2FWeb%2FJavaScript%2FReference%2FGlobal_Objects%2FObject%2Fcreate)
> [MDN之Class](https://link.juejin.cn?target=https%3A%2F%2Fdeveloper.mozilla.org%2Fzh-CN%2Fdocs%2FWeb%2FJavaScript%2FReference%2FClasses)

### 参考

[JavaScript常用八种继承方案](https://juejin.cn/post/6844903696111763470#heading-3)

## 实现 add(1)(2)(3) = 6

柯里化就是把接收多个参数的函数变换成接收一个单一参数(最初函数的第一个参数)的函数。

```
const curry = (fn, ...args) => 
            args.length < fn.length 
            // 参数长度不足时,重新柯里化函数,等待接受新参数
            ? (...arguments) => curry(fn, ...args, ...arguments)
            // 函数长度满足时,执行函数
             : fn(...args);

function sumFn(a, b, c){
    return a + b + c;
}
var sum = curry(sumFn);
console.log(sum(1)(2)(3)); //6
```

## script 标签的 defer 和 async

defer

> 解析完js脚本后不会立刻执行，而是在DOMContentLoaded 事件触发之前开始执行。defer 是顺序执行
>
> 使用场景(依赖dom)：
>
> - 评论框
> - 代码语法高亮
> - polyfill.js

async

> 解析完js脚本后会立即执行，与html解析过程异步同时执行。async是乱序执行
>
> 使用场景：
>
> - 百度统计

## **JS 识别不同浏览器信息**

```
function myBrowser() {
  var userAgent = navigator.userAgent; //取得浏览器的userAgent字符串  
  var isOpera = userAgent.indexOf("Opera") > -1;
  if (isOpera) {
    return "Opera"
  }; //判断是否Opera浏览器  
  if (userAgent.indexOf("Firefox") > -1) {
    return "Firefox";
  }  //判断是否Firefox浏览器  
  if (userAgent.indexOf("Chrome") > -1) {
    return "Chrome";
  }   //判断是否Google浏览器  
  if (userAgent.indexOf("Safari") > -1) {
    return "Safari";
  } //判断是否Safari浏览器  
  if (userAgent.indexOf("compatible") > -1 && userAgent.indexOf("MSIE") > -1 && !isOpera) {
    return "IE";
  }; //判断是否IE浏览器  
} 
```

## 合并数组

使用 Array.concat()

```
var array1 = [1, 2, 3];
var array2 = [4, 5, 6];
console.log(array1.concat(array2)); // [1,2,3,4,5,6];
```

不适用于合并大的数组，因为它需要创建一个新的数组，而这会消耗很多内存.

可以使用 Array.push.apply(arr1, arr2) 来代替创建新的数组，它可以把第二个数组合并到第一个中，从而较少内存消耗。

```
console.log(array1.push.apply(array1, array2)); // [1, 2, 3, 4, 5, 6]
```

## 闭包

[js闭包的9个使用场景](https://www.jb51.net/article/203104.htm)

## JS 判断变量是对象还是数组

第一，使用 typeof 加 length 属性

数组有 length 属性，object 没有，而 typeof 数组与对象都返回 object，所以我们可以这么判断

```
var getDataType = function(o){
    if(typeof o == 'object'){
        if( typeof o.length == 'number' ){
            return 'Array';
        } else {
            return 'Object';   
        }
    } else {
        return 'param is no object type';
    }
};
```

第二，使用 instanceof

利用 instanceof 判断数据类型是对象还是数组时应该优先判断 array，最后判断 object。

```
var getDataType = function(o){
    if(o instanceof Array){
        return 'Array'
    } else if ( o instanceof Object ){
        return 'Object';
    } else {
        return 'param is no object type';
    }
};
```

## 继承在ES5和 ES6 的区别 ？

ES5 的继承时通过 prototype 或构造函数机制来实现。

- `ES5 的继承实质上是先创建子类的实例对象，然后再将父类的方法添加到 this 上（Parent.apply(this)）`。
- `ES6 的继承机制完全不同，实质上是先创建父类的实例对象 this（所以必须先调用父类的 super()方法），然后再用子类的构造函数修改 this`。

具体的：ES6 通过 class 关键字定义类，里面有构造方法，类之间通过 extends 关键字实现继承。子类必须在 constructor 方法中调用 super 方法，否则新建实例报错。因为子类没有自己的 this 对象，而是继承了父类的 this 对象，然后对其进行加工。如果不调用 super 方法，子类得不到 this 对象。

ps：super 关键字指代父类的实例，即父类的 this 对象。在子类构造函数中，调用 super 后，才可使用 this 关键字，否则报错。



## 防抖和节流

**小结**

- 函数防抖和函数节流都是防止某一时间频繁触发，但原理不一样。
- 函数防抖是某一段时间内只执行一次，而函数节流是间隔时间执行。

**应用场景**

- debounce防抖
  - search搜索联想，用户在不断输入值时，用防抖来节约请求资源。
  - window触发resize的时候，不断的调整浏览器窗口大小会不断的触发这个事件，用防抖来让其只触发一次
- throttle节流
  - 鼠标不断点击触发，mousedown(单位时间内只触发一次)
  - 监听滚动事件，比如是否滑到底部自动加载更多，用throttle来判断

**九种跨域方式原理**

[九种跨域方式实现原理（完整版）](https://juejin.cn/post/6844903767226351623)

## 常见六大Web安全攻防解析

### XSS

XSS (Cross-Site Scripting)，跨站脚本攻击，因为缩写和 CSS重叠，所以只能叫 XSS。

跨站脚本攻击是指通过存在安全漏洞的Web网站注册用户的浏览器内运行非法的HTML标签或JavaScript进行的一种攻击。

按照攻击方式分：

- 非持久型跨站（也叫反射型）
- 持久型跨站（也叫存储型）
- DOM跨站

**一、反射型**

一般是通过给别人发送**带有恶意脚本代码参数的 URL**，当 URL 地址被打开时，特有的恶意代码参数被 HTML 解析、执行。

特点：

> - 即时性，不经过服务器存储，直接通过 HTTP 的 GET 和 POST 请求就能完成一次攻击，拿到用户隐私数据。
> - 攻击者需要诱骗点击,必须要通过用户点击链接才能发起
> - 反馈率低，所以较难发现和响应修复
> - 盗取用户敏感保密信息

反制：

> - Web 页面渲染的所有内容或者渲染的数据都必须来自于服务端。
>
> - 尽量不要从 `URL`，`document.referrer`，`document.forms` 等这种 DOM API 中获取数据直接渲染。
>
> - 尽量不要使用 `eval`, `new Function()`，`document.write()`，`document.writeln()`，`window.setInterval()`，`window.setTimeout()`，`innerHTML`，`document.createElement()` 等可执行字符串的方法。
>
> - 如果做不到以上几点，也必须对涉及 DOM 渲染的方法传入的字符串参数做 escape 转义。
>
> - 前端渲染的时候对任何的字段都需要做 escape 转义编码。

**二、存储型**

黑客利用的 XSS 漏洞，将内容经正常功能提交进入数据库持久保存，当前端页面获得后端从数据库中读出的注入代码时，恰好将其渲染执行。

特点：

> - 持久性，植入在数据库中
> - 盗取用户敏感私密信息
> - 危害面广

反制：

> - CSP即白名单
> - 转义字符
> - HttpOnly Cookie

 **CSP**

CSP 本质上就是建立白名单，开发者明确告诉浏览器哪些外部资源可以加载和执行。我们只需要配置规则，如何拦截是由浏览器自己实现的。我们可以通过这种方式来尽量减少 XSS 攻击。

通常可以通过两种方式来开启 CSP：

- 设置 HTTP Header 中的 Content-Security-Policy
- 设置 meta 标签的方式 

这里以设置 HTTP Header 来举例：

- 只允许加载本站资源

```arduino
Content-Security-Policy: default-src 'self'
复制代码
```

- 只允许加载 HTTPS 协议图片

```less
Content-Security-Policy: img-src https://*
复制代码
```

- 允许加载任何来源框架

```css
Content-Security-Policy: child-src 'none'
复制代码
```

如需了解更多属性，请查看[Content-Security-Policy文档](https://link.juejin.cn?target=https%3A%2F%2Fdeveloper.mozilla.org%2Fen-US%2Fdocs%2FWeb%2FHTTP%2FHeaders%2FContent-Security-Policy)

**HttpOnly Cookie。**

这是预防XSS攻击窃取用户cookie最有效的防御手段。Web应用程序在设置cookie时，将其属性设为HttpOnly，就可以避免该网页的cookie被客户端恶意JavaScript窃取，保护用户cookie信息。

**三、DOM跨站**

- 攻击者构造出特殊的 `URL` ，其中包含恶意代码。
- 用户打开带有恶意代码的 `URL` 。
- 用户浏览器接收到响应后解析执行，前端 `JavaScript` 取出 `URL` 中的恶意代码并执行。
- 恶意代码窃取用户数据并发送到攻击者的网站，或者冒充用户的行为，调用目标网站接口执行攻击者指定的操作。

DOM 型跟前两种区别是：

DOM 型 XSS 攻击中，取出和执行恶意代码由**浏览器端**完成，属于前端 JavaScript 自身的安全漏洞，而其他两种 XSS 都属于**服务端**的安全漏洞。

### CSRF

CSRF(Cross Site Request Forgery)，即跨站请求伪造，是一种常见的Web攻击，它利用用户已登录的身份，在用户毫不知情的情况下，以用户的名义完成非法操作。

**攻击流程**：

> 1. 受害者登录 `a.com`，并保留了登录凭证（`Cookie`）。
> 2. 攻击者引诱受害者访问了 `b.com`。
> 3. `b.com` 向 `a.com` 发送了一个请求：`a.com/act=xx`。浏览器会**默认携带** `a.com` 的 `Cookie`。
> 4. `a.com` 接收到请求后，对请求进行验证，并确认是受害者的凭证，误以为是受害者自己发送的请求。
> 5. `a.com` 以受害者的名义执行了 `act=xx`。
> 6. 攻击完成，攻击者在受害者不知情的情况下，冒充受害者，让 `a.com` 执行了自己定义的操作。

反制：

> - Get 请求不对数据进行修改
> - 不让第三方网站访问到用户 Cookie
> - 阻止第三方网站请求接口
> - 请求时附带验证信息，比如验证码或者 Token

具体反制：

> 1) SameSite
>
> 可以对 Cookie 设置 SameSite 属性。该属性表示 Cookie 不随着跨域请求发送，可以很大程度减少 CSRF 的攻击，但是该属性目前并不是所有浏览器都兼容。
>
> 2) Referer Check同源检测
>
> referer 和 origin 的区别，只有 post 请求会携带 origin 请求头，而 referer不论何种情况下都带。
>
> HTTP Referer是header的一部分，当浏览器向web服务器发送请求时，一般会带上Referer信息告诉服务器是从哪个页面链接过来的，服务器籍此可以获得一些信息用于处理。可以通过检查请求的来源来防御CSRF攻击。正常请求的referer具有一定规律，如在提交表单的referer必定是在该页面发起的请求。所以**通过检查http包头referer的值是不是这个页面，来判断是不是CSRF攻击**。
>
> 但在某些情况下如从https跳转到http，浏览器处于安全考虑，不会发送referer，服务器就无法进行check了。若与该网站同域的其他网站有XSS漏洞，那么攻击者可以在其他网站注入恶意脚本，受害者进入了此类同域的网址，也会遭受攻击。出于以上原因，无法完全依赖Referer Check作为防御CSRF的主要手段。但是可以通过Referer Check来监控CSRF攻击的发生。
>
> 3)  Anti CSRF Token
>
> 目前比较完善的解决方案是加入Anti-CSRF-Token。即发送请求时在HTTP 请求中以参数的形式加入一个随机产生的token，并在服务器建立一个拦截器来验证这个token。服务器读取浏览器当前域cookie中这个token值，会进行校验该请求当中的token和cookie当中的token值是否都存在且相等，才认为这是合法的请求。否则认为这次请求是违法的，拒绝该次服务。
>
> **这种方法相比Referer检查要安全很多**，token可以在用户登陆后产生并放于session或cookie中，然后在每次请求时服务器把token从session或cookie中拿出，与本次请求中的token 进行比对。由于token的存在，攻击者无法再构造出一个完整的URL实施CSRF攻击。但在处理多个页面共存问题时，当某个页面消耗掉token后，其他页面的表单保存的还是被消耗掉的那个token，其他页面的表单提交时会出现token错误。
>
> 4) 验证码
>
> 应用程序和用户进行交互过程中，特别是账户交易这种核心步骤，强制用户输入验证码，才能完成最终请求。在通常情况下，验证码够很好地遏制CSRF攻击。**但增加验证码降低了用户的体验，网站不能给所有的操作都加上验证码**。所以只能将验证码作为一种辅助手段，在关键业务点设置验证码。

**cookie和token**

> **cookie 是不能跨域访问的，为什么还会有 csrf？**
>
> 浏览器会依据加载的域名附带上对应域名 cookie。如用户在 a 网站登录且生成了授权的 cookies，然后访问 b 网站，b 站故意构造请求 a 站的请求，如删除操作之类的，用不受同源影响的 script，img 或者 iframe 之类的标签加载 a 地址，浏览器会附带上 a 站此登录用户的授权 cookie 信息，这样就构成 crsf，会删除掉当前用户的数据。cookie和session都会有csrf问题，localstorge没有这个问题，因为它有同源策略。
>
> Token
>
> **示例：** 用户登录输入账号密码，请求登录接口，后端在用户登录信息正确的情况下将 `token` 放到**数据库**中，并返回 `token` 给前端，前端把 `token` 存放在 `localstorage` 中，之后再发送请求都会将 `token` 放到 `header` 中。 后端写一个过滤器，拦截 `POST` 请求，注意忽略掉不需要 `token` 的请求，比如登录接口，获取 `token` 的接口，以免还没有获取 `token` 就开始检验 `token` 。 校验原则：**数据库**中的 `token` 和前端 `header` 中的 `token` 一致的 `post` 请求，则说明校验成功，给客户端放行。

### 点击劫持

点击劫持是一种视觉欺骗的攻击手段。攻击者将需要攻击的网站通过 iframe 嵌套的方式嵌入自己的网页中，并将 iframe 设置为透明，在页面中透出一个按钮诱导用户点击。

特点：

> - 隐蔽性较高，骗取用户操作
> - "UI-覆盖攻击"
> - 利用iframe或者其它标签的属性

具体反制：

> 1）X-FRAME-OPTIONS
>
> `X-FRAME-OPTIONS`是一个 HTTP 响应头，在现代浏览器有一个很好的支持。这个 HTTP 响应头 就是为了防御用 iframe 嵌套的点击劫持攻击。
>
> 该响应头有三个值可选，分别是
>
> - DENY，表示页面不允许通过 iframe 的方式展示
> - SAMEORIGIN，表示页面可以在相同域名下通过 iframe 的方式展示
> - ALLOW-FROM，表示页面可以在指定来源的 iframe 中展示
>
> 2）JavaScript 防御
>
> ```
> if (self == top) {...}
> ```

### SQL注入

**SQL注入的本质:数据和代码未分离，即数据当做了代码来执行。**

反制：

> - **严格限制Web应用的数据库的操作权限**，给此用户提供仅仅能够满足其工作的最低权限，从而最大限度的减少注入攻击对数据库的危害
>
> - **后端代码检查输入的数据是否符合预期**，严格限制变量的类型，例如使用正则表达式进行一些匹配处理。
>
> - **对进入数据库的特殊字符（'，"，\，<，>，&，\*，; 等）进行转义处理，或编码转换**。基本上所有的后端语言都有对字符串进行转义处理的方法，比如 lodash 的 lodash._escapehtmlchar 库。
>
> - **所有的查询语句建议使用数据库提供的参数化查询接口**，参数化的语句使用参数而不是将用户输入变量嵌入到 SQL 语句中，即不要直接拼接 SQL 语句。例如 Node.js 中的 mysqljs 库的 query 方法中的 ? 占位参数

**参考**

- [常见六大Web安全攻防解析](https://juejin.im/post/5c446eb1e51d45517624f7db)

# inter-计算机网络

## 一文读懂 HTTP/1、HTTP/2、HTTP/3

**一、HTTP/1**

缺陷：

> 1. 高延迟 — 队头阻塞(Head-Of-Line Blocking)
> 2. 无状态特性 — 阻碍交互
> 3. 明文传输 — 不安全性
> 4. 不支持服务端推送

**队头阻塞**

队头阻塞是指当顺序发送的请求序列中的一个请求因为某种原因被阻塞时，在后面排队的所有请求也一并被阻塞，会导致客户端迟迟收不到数据。

针对队头阻塞：

1.将同一页面的资源分散到不同域名下，提升连接上限。虽然能公用一个 TCP 管道，但是在一个管道中同一时刻只能处理一个请求，在当前的请求没有结束之前，其他的请求只能处于阻塞状态。

2.减少请求数量

3.内联一些资源：css、base64 图片等

4.合并小文件减少资源数

**无状态特性**

无状态是指协议对于连接状态没有**记忆能力**。纯净的 HTTP 是没有 cookie 等机制的，每一个连接都是一个新的连接。上一次请求验证了用户名密码，而下一次请求服务器并不知道它与上一条请求有何关联，换句话说就是**掉登录态**。

**不安全性**

传输内容没有加密，中途可能被篡改和劫持。

**二、SPDY 协议**

SPDY 是由 google 推行的改进版本的 HTTP1.1 （那时候还没有 HTTP2）

特点：

> 1. 多路复用 — 解决队头阻塞
> 2. 头部压缩 — 解决巨大的 HTTP 头部
> 3. 请求优先级 — 先获取重要数据
> 4. 服务端推送 — 填补空缺
> 5. 提高安全性

**多路复用**

SPDY 允许在一个连接上无限制并发流。因为请求在一个通道上，TCP 效率更高（参考 [TCP 拥塞控制](https://link.juejin.cn?target=https%3A%2F%2Fzhuanlan.zhihu.com%2Fp%2F37379780) 中的**慢启动**）。更少的网络连接，发出更密集的包。

**头部压缩**

使用专门的 HPACK 算法，每次请求和响应只发送差异头部，一般可以达到 50% ~90% 的高压缩率。

**请求优先级**

虽然无限的并发流解决了队头阻塞的问题，但如果带宽受限，客户端可能会因防止堵塞通道而阻止请求。在网络通道被非关键资源堵塞时，高优先级的请求会被优先处理。

**服务端推送**

[服务端推送（ServerPush）](https://link.juejin.cn?target=http%3A%2F%2Fwww.ruanyifeng.com%2Fblog%2F2018%2F03%2Fhttp2_server_push.html)，可以让服务端主动把资源文件推送给客户端。当然客户端也有权利选择是否接收。

**提高安全性**

支持使用 HTTPS 进行加密传输。



**三、HTTP/2**

HTTP2 基于 SPDY，专注于性能，最大的一个目标是在用户和网站间只用一个连接。

特点：

> 1. 二进制分帧 - HTTP2 性能增强的核心
> 2. 多路复用 - 解决串行的文件传输和连接数过多

**二进制分帧**

首先，HTTP2 没有改变 HTTP1 的语义，只是在应用层使用二进制分帧方式传输。因此，也引入了新的通信单位：**帧、消息、流**。

分帧有什么好处？服务器单位时间接收到的请求数变多，可以提高并发数。最重要的是，为多路复用提供了底层支持。

**多路复用**

一个域名对应一个连接，一个流代表了一个完整的**请求-响应**过程。**帧**是最小的数据单位，每个**帧**会标识出该帧属于哪个**流**，**流**也就是多个帧组成的数据流。多路复用，就是在一个 TCP 连接中可以存在多个流。

缺点：

> 1. TCP 以及 TCP+TLS 建立连接的延时
> 2. TCP 的队头阻塞并没有彻底解决
> 3. 多路复用导致服务器压力上升
> 4. 多路复用容易 Timeout

**建连延时**

TCP 连接需要和服务器进行**三次握手**，即消耗完 1.5 个 RTT 之后才能进行数据传输。

TLS 连接有两个版本—— TLS1.2 和 TLS1.3，每个版本建立连接所花的时间不同，大致需要 1~2 个 RTT。

RTT（Round-Trip Time）:往返时延。表示从发送端发送数据开始，到发送端收到来自接收端的确认（接收端收到数据后便立即发送确认），总共经历的时延。

**队头阻塞没有彻底解决**

TCP 为了保证可靠传输，有一个“超时重传”机制，丢失的包必须等待重传确认。HTTP2 出现丢包时，整个 TCP 都要等待重传，那么就会阻塞该 TCP 连接中的所有请求。

![img](C:/Program%20Files/Typora)

RTO：英文全称是 Retransmission TimeOut，即重传超时时间；RTO 是一个动态值，会根据网络的改变而改变。RTO 是根据给定连接的往返时间 RTT 计算出来的。接收方返回的 ack 是希望收到的下一组包的序列号。

**多路复用导致服务器压力上升**

多路复用没有限制同时请求数。请求的平均数量与往常相同，但实际会有许多请求的短暂爆发，导致瞬时 QPS 暴增。

**多路复用容易 Timeout**

大批量的请求同时发送，由于 HTTP2 连接内存在多个并行的流，而网络带宽和服务器资源有限，每个流的资源会被稀释，虽然它们开始时间相差更短，但却都可能超时。

即使是使用 Nginx 这样的负载均衡器，想正确进行节流也可能很棘手。其次，就算你向应用程序引入或调整排队机制，但一次能处理的连接也是有限的。如果对请求进行排队，还要注意在响应超时后丢弃请求，以避免浪费不必要的资源。



**四、HTTP/3**

Google在推 SPDY 的时候就已经意识到了这些问题，于是就另起炉灶搞了一个基于 UDP 协议的 QUIC 协议。而这个就是 HTTP3。它真正“完美”地解决了“队头阻塞”问题。

特点：

> 1. 改进的拥塞控制、可靠传输
> 2. 快速握手
> 3. 集成了 TLS 1.3 加密
> 4. 多路复用
> 5. 连接迁移

**改进的拥塞控制、可靠传输**

从拥塞算法和可靠传输本身来看，QUIC 只是按照 TCP 协议重新实现了一遍，那么 QUIC 协议到底改进在哪些方面呢？主要有如下几点：

1. 可插拔 — 应用程序层面就能实现不同的拥塞控制算法。

一个应用程序的不同连接也能支持配置不同的拥塞控制。应用程序不需要停机和升级就能实现拥塞控制的变更，可以针对不同业务，不同网络制式，甚至不同的 RTT，使用不同的拥塞控制算法。

关于应用层的可插拔拥塞控制模拟，可以对 socket 上的流为对象进行实验。

2. 单调递增的 Packet Number — 使用 Packet Number 代替了 TCP 的 seq。

每个 Packet Number 都严格递增，也就是说就算 Packet N 丢失了，重传的 Packet N 的 Packet Number 已经不是 N，而是一个比 N 大的值。而 TCP 重传策略存在二义性，比如客户端发送了一个请求，一个 RTO 后发起重传，而实际上服务器收到了第一次请求，并且响应已经在路上了，当客户端收到响应后，得出的 RTT 将会比真实 RTT 要小。当 Packet N 唯一之后，就可以计算出正确的 RTT。

3. 不允许 Reneging — 一个 Packet 只要被 Ack，就认为它一定被正确接收。

Reneging 的意思是，接收方有权把已经报给发送端 [SACK（Selective Acknowledgment）](https://link.juejin.cn?target=https%3A%2F%2Fallen-kevin.github.io%2F2017%2F03%2F01%2FTCP%E9%87%8D%E7%82%B9%E7%B3%BB%E5%88%97%E4%B9%8Bsack%E4%BB%8B%E7%BB%8D%2F) 里的数据给丢了（如接收窗口不够而丢弃乱序的包）。

QUIC 中的 ACK 包含了与 TCP 中 SACK 等价的信息，但 QUIC 不允许任何（包括被确认接受的）数据包被丢弃。这样不仅可以简化发送端与接收端的实现难度，还可以减少发送端的内存压力。

4. 前向纠错（FEC）

早期的 QUIC 版本存在一个丢包恢复机制，但后来由于增加带宽消耗和效果一般而**废弃**。FEC 中，QUIC 数据帧的数据混合原始数据和冗余数据，来确保无论到达接收端的 n 次传输内容是什么，接收端都能够恢复所有 n 个原始数据包。FEC 的实质就是异或。示意图：

![img](C:/Program%20Files/Typora)

5. 更多的 Ack 块和增加 Ack Delay 时间。

QUIC 可以同时提供 256 个 Ack Block，因此在重排序时，QUIC 相对于 TCP（使用 SACK）更有弹性，这也使得在**重排序**或**丢失**出现时，QUIC 可以在网络上保留更多的[在途字节](https://link.juejin.cn?target=https%3A%2F%2Fblog.csdn.net%2Fu014023993%2Farticle%2Fdetails%2F85299434)。在丢包率比较高的网络下，可以提升网络的恢复速度，减少重传量。

TCP 的 Timestamp 选项存在一个问题：发送方在发送报文时设置发送时间戳，接收方在确认该报文段时把时间戳字段值复制到确认报文时间戳，但是没有计算接收端接收到包到发送 Ack 的时间。这个时间可以简称为 Ack Delay，会导致 RTT 计算误差。现在就是把这个东西加进去计算 RTT 了。

6. 基于 stream 和 connection 级别的流量控制。

为什么需要两类流量控制呢？主要是因为 QUIC 支持多路复用。Stream 可以认为就是一条 HTTP 请求。Connection 可以类比一条 TCP 连接。多路复用意味着在一条 Connetion 上会同时存在多条 Stream。

QUIC 接收者会通告每个流中最多想要接收到的数据的绝对字节偏移。随着数据在特定流中的发送，接收和传送，接收者发送 WINDOW_UPDATE 帧，该帧增加该流的通告偏移量限制，允许对端在该流上发送更多的数据。

除了每个流的流控制外，QUIC 还实现连接级的流控制，以限制 QUIC 接收者愿意为连接分配的总缓冲区。连接的流控制工作方式与流的流控制一样，但传送的字节和最大的接收偏移是所有流的总和。

最重要的是，我们可以在内存不足或者上游处理性能出现问题时，通过流量控制来限制传输速率，保障服务可用性。

**快速握手**

由于 QUIC 是基于 UDP 的，所以 QUIC 可以实现 0-RTT 或者 1-RTT 来建立连接，可以大大提升首次打开页面的速度。

**集成了 TLS 1.3 加密**

TLS 1.3 支持 3 种基本密钥交换模式：

```scss
(EC)DHE (基于有限域或椭圆曲线的 Diffie-Hellman)
PSK - only
PSK with (EC)DHE
```

在完全握手情况下，需要 1-RTT 建立连接。TLS1.3 恢复会话可以直接发送加密后的应用数据，不需要额外的 TLS 握手，也就是 0-RTT。

但是 TLS1.3 也并不完美。TLS 1.3 的 0-RTT 无法保证前向安全性(Forward secrecy)。简单讲就是，如果当攻击者通过某种手段获取到了 Session Ticket Key，那么该攻击者可以解密以前的加密数据。

要缓解该问题可以通过设置使得与 Session Ticket Key 相关的 DH 静态参数在短时间内过期（一般几个小时）。

**多路复用**

QUIC 是为多路复用从头设计的，携带个别流的的数据的包丢失时，通常只影响该流。QUIC 连接上的多个 stream 之间并没有依赖，也不会有底层协议限制。假如 stream2 丢了一个包，也只会影响 stream2 的处理。

**连接迁移**

TCP 是按照 4 要素（客户端 IP、端口, 服务器 IP、端口）确定一个连接的。而 QUIC 则是让客户端生成一个 Connection ID （64 位）来区别不同连接。只要 Connection ID 不变，连接就不需要重新建立，即便是客户端的网络发生变化。由于迁移客户端继续使用相同的会话密钥来加密和解密数据包，QUIC 还提供了迁移客户端的自动加密验证。

**参考**

[一文读懂 HTTP/1、HTTP/2、HTTP/3](https://juejin.cn/post/7175344580638801975#heading-29)

# inter-性能优化

## 性能优化总策略

web 前端是应用服务器处理之前的部分，前端主要包括：HTML、CSS、javascript、image 等各种资源，针对不同的资源有不同的优化方式。

内容优化

- 减少 HTTP 请求数。这条策略是最重要最有效的，因为一个完整的请求要经过 DNS 寻址，与服务器建立连接，发送数据，等待服务器响应，接收数据这样一个消耗时间成本和资源成本的复杂的过程。 常见方法：合并多个 CSS 文件和 js 文件，利用 CSS Sprites 整合图像，Inline Images (使用 data：URL scheme 在实际的页面嵌入图像数据 )，合理设置 HTTP 缓存等。
- 减少 DNS 查找
- 避免重定向
- 使用 Ajax 缓存
- 延迟加载组件，预加载组件
- 减少 DOM 元素数量。页面中存在大量 DOM 元素，会导致 javascript 遍历 DOM 的效率变慢。
- 最小化 iframe 的数量。iframes 提供了一个简单的方式把一个网站的内容嵌入到另一个网站中。但其创建速度比其他包括 JavaScript 和 CSS 的 DOM 元素的创建慢了 1-2 个数量级。
- 避免 404。HTTP 请求时间消耗是很大的，因此使用 HTTP 请求来获得一个没有用处的响应（例如 404 没有找到页面）是完全没有必要的，它只会降低用户体验而不会有一点好处。

服务器优化

- 使用内容分发网络（CDN）。把网站内容分散到多个、处于不同地域位置的服务器上可以加快下载速度。
- GZIP 压缩
- 设置 ETag：ETags（Entity tags，实体标签）是 web 服务器和浏览器用于判断浏览器缓存中的内容和服务器中的原始内容是否匹配的一种机制。
- 提前刷新缓冲区
- 对 Ajax 请求使用 GET 方法
- 避免空的图像 src

Cookie 优化

- 减小 Cookie 大小
- 针对 Web 组件使用域名无关的 Cookie

CSS 优化

- 将 CSS 代码放在 HTML 页面的顶部
- 避免使用 CSS 表达式
- 使用 < link> 来代替 @import
- 避免使用 Filters

javascript 优化

- 将 JavaScript 脚本放在页面的底部。
- 将 JavaScript 和 CSS 作为外部文件来引用。 在实际应用中使用外部文件可以提高页面速度，因为 JavaScript 和 CSS 文件都能在浏览器中产生缓存。
- 缩小 JavaScript 和 CSS
- 删除重复的脚本
- 最小化 DOM 的访问。使用 JavaScript 访问 DOM 元素比较慢。
- 开发智能的事件处理程序
- javascript 代码注意：谨慎使用 with，避免使用 eval Function 函数，减少作用域链查找。

图像优化

- 优化图片大小
- 通过 CSS Sprites 优化图片
- 不要在 HTML 中使用缩放图片
- favicon.ico 要小而且可缓存

[前端性能优化 24 条建议（2020）](https://juejin.cn/post/6892994632968306702)

# interview-imporant

## 手写vue3源码之pnpm实现monorepo包管理

[video](https://www.bilibili.com/video/BV1WP4y1u7qi/?spm_id_from=333.337.search-card.all.click&vd_source=bd4c7d99d71adf64d6e88c65370e0247)

## 手写vue2源码之rollup打包

[video](https://www.bilibili.com/video/BV1aq4y1o7Ny/?spm_id_from=333.788.recommend_more_video.0&vd_source=bd4c7d99d71adf64d6e88c65370e0247)