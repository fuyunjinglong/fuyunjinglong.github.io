---
title: CSS_0基础
date: 2019-06-26 07:33:16
categories:
- C_H5和CSS
toc: true # 是否启用内容索引常
---

# 入门

## CSS模块化

模块化进程:BEM、OOCSS、SMACSS、ITCSS，以及 CSS Modules 和 CSS-in-JS 等,目前主流的是CSS Modules 和 CSS-in-JS

**一、CSS 命名方法论**

通过人工的方式来约定命名规则.

> 社区在早期诞生了一些 CSS 命名方法论，如 BEM、OOCSS、SMACSS、ITCSS、SUITCSS、Atomic CSS 等

**1.BEM**

[BEM](https://link.segmentfault.com/?enc=yvW7zwnlxk23Je688mavOg%3D%3D.slTmHPfpl7kIEsnMLdKdGAX34lkMbtmb9JbNK731ieY%3D)（Block Element Modifier）是一种典型的 CSS 命名方法论，在 2009 年前提出，它的核心思想是 **通过组件名的唯一性来保证选择器的唯一性，从而保证样式不会污染到组件外**。

BEM 命名规约是 `.block-name__element-name--modifier-name`，即 `.模块名__元素名--修饰器名` 三个部分。也可以自定义

```
<!-- 示例模块 -->
<div class="card">
  <div class="card__head">
    <ul class="card__menu">
      <li class="card__menu-item">menu item 1</li>
      <li class="card__menu-item">menu item 2</li>
      <li class="card__menu-item card__menu-item--active">menu item 3</li>
      <li class="card__menu-item card__menu-item--disable">menu item 4</li>
    </ul>
  </div>
  <div class="card__body"></div>
  <div class="card__foot"></div>
</div>

.card {}
.card__head {}
.card__menu {}
.card__menu-item {}
.card__menu-item--active {}
.card__menu-item--disable {}
.card__body {}
.card__foot {}

使用sass更简单
.card {
  &__head {}
  &__menu {
    &-item {
      &--active {}
      &--disable {}
    }
  }
  &__body {}
  &__foot {}
}
```

**2.OOCSS**

[OOCSS](https://link.segmentfault.com/?enc=xQLxwsdZQTlZ9EndBOEWoA%3D%3D.TTDNApcr2Fzcm68Lm17UVrYSn8HEGzQf%2FoNpnsV7rzI%3D)（Object-Oriented CSS）即面向对象的 CSS，它借鉴了 OOP（面向对象编程）的抽象思维，主张将元素的样式抽象成多个独立的小型样式类，来提高样式的灵活性和可重用性。

OOCSS 有两个基本原则：

1. **独立的结构和样式**。即不要将定位、尺寸等布局样式与字体、颜色等表现样式写在一个选择器中。
2. **独立的容器和内容**。即让对象的行为可预测，避免对位置的依赖，子元素即使离开了容器也应该能正确显示。

```
<div class="size1of4 bgBlue solidGray mt-5 ml-10 mr-10 mb-10"></div>

<style>
  .size1of4 { width: 25%; }
  .bgBlue { background: blue; }
  .solidGray { border: 1px solid #ccc; }
  .mt-5 { margin-top: 5px; }
  .mr-10 { margin-right: 10px }
  .mb-10 { margin-bottom: 10px; }
  .ml-10 { margin-left: 10px; }
</style>
```

**3.SMACSS**

[SMACSS](https://link.segmentfault.com/?enc=EPc3pUkONY6IB98KLpzuqA%3D%3D.lzbwbQHlVHy4FEbypLaauwhxlu9zjTEjZwvnMALKmrM%3D)（Scalable and Modular Architecture for CSS）即可伸缩及模块化的 CSS 结构，由 Jonathan Snook 在 2011 年雅虎时提出。

SAMCSS 按照部件的功能特性，将其划分为五大类：

1. 基础（Base）是为HTML元素定义默认样式，可以包含属性、伪类等选择器。
2. 布局（Layout）会将页面分为几部分，可作为高级容器包含一个或多个模块，例如左右分栏、栅格系统等。
3. 模块（Module）又名对象或块，是可重用的模块化部分，例如导航栏、产品列表等。
4. 状态（State）描述的是任一模块或布局在特定状态下的外观，例如隐藏、激活等。
5. 主题（Theme）也就是换肤，描述了页面的外观，它可修改前面四个类别的样式，例如链接颜色、布局方式等。

SMACSS 推荐使用前缀来区分不同部件：

1. 基础规则是直接作用于元素的，因此不需要前缀。
2. 布局的前缀是 `l-` 或 `layout-`，例如 `.l-table`、`.layout-grid` 等。
3. 模块的前缀是 `m-` 或模块自身的命名，例如 `.m-nav`、`.card`、`.field` 等。
4. 状态的前缀是 `is-`，例如 `.is-active`、`.is-current` 等。
5. 主题的前缀是 `theme-`，例如 `.theme-light`、`.theme-dark` 等。

**4.ITCSS**

[ITCSS](https://link.segmentfault.com/?enc=7puURltb2DMR9OvLY0hagA%3D%3D.GwUjYal62vVu4Sr6ZC8rwf%2BOw1p35zkM4pnVHzNsoJs%3D)（Inverted Triangle CSS，倒三角 CSS）是一套方便扩展和管理的 CSS 体系架构，它兼容 BEM、OOCSS、SMACSS 等 CSS 命名方法论。ITCSS 使用 **分层** 的思想来管理你的样式文件，类似服务端开发中的 MVC 分层设计。

ITCSS 将 CSS 的样式规则划分成以下的几个层次：

1. Settings：项目使用的全局变量，比如颜色，字体大小等等。
2. Tools：项目使用的 mixins 和 functions。到 Tools 为止，不会生成具体的 CSS 代码。
3. Generic：最基本的设定，比如 reset.css、normalize.css 等。
4. Base：最基础的元素（elements），比如 img、p、link、list 等。
5. Objects：某种设计模式，比如水平居中，
6. Components：UI 组件，比如 button、switch、slider 等。
7. Trumps：用于辅助和微调的样式，只有这一层才可以使用 `!important`。

ITCSS 的分层逻辑越往下就越具体。

**二、CSS Modules**

一个 CSS 文件就是一个独立的模块，参考 [官网](https://link.segmentfault.com/?enc=BJsoEYOSyS57lkiwMJLYnw%3D%3D.vh2xxHkCWj%2BQKZpJsHXPIUajJVVSZjVjfBsemBR5r%2BVf%2BMc%2FDKvK9%2F0DpFE%2Bvo48) 或 [阮老师的《CSS Modules 用法教程》](https://link.segmentfault.com/?enc=eAUflHKK1qn8%2FThzUP%2FR4A%3D%3D.houo%2FuVymgDZkoWrMpZteijNiFDjiyLdtnAu6BLApoDkRFGoQNaOBxdP%2BWbZhEQW2K6zSg2WtRewaQE2ZAvtFQ%3D%3D)

CSS Modules 特性：

- **作用域**：模块中的名称默认都属于本地作用域，定义在 `:local` 中的名称也属于本地作用域，定义在 `:global` 中的名称属于全局作用域，全局名称不会被编译成哈希字符串。
- **命名**：对于本地类名称，CSS Modules 建议使用 camelCase 方式来命名，这样会使 JS 文件更干净，即 `styles.className`。
  但是你仍然可以固执己见地使用 `styles['class-name']`，允许但不提倡。🤪
- **组合**：使用 `composes` 属性来继承另一个选择器的样式，这与 Sass 的 `@extend` 规则类似。
- **变量**：使用 `@value` 来定义变量，不过需要安装 PostCSS 和 [postcss-modules-values](https://link.segmentfault.com/?enc=6qRrTvtCeBEVMSaZinCvdg%3D%3D.BsxZmhP%2B%2FpbLWFfYbVDqPIZBmsJe5BRIoBln8De8oK2zWQeSHOvH9swE3OwSdkhyqCwuM3aMzTXOJ6RfU48csw%3D%3D) 插件。

使用 CSS Modules 时，推荐配合 CSS 预处理器（Sass/Less/Stylus）一起使用。

**三、CSS-in-JS**

在 JS 中写 CSS

一些流行的 CSS-in-JS 库：

- styled-components：[https://github.com/styled-com...](https://link.segmentfault.com/?enc=a6xFyjud2eLVlZQ5W2dCTg%3D%3D.O8yGJpTGR78T%2BKlvrGFRBPIl4j%2FiRGbhKVzgBCPGSSJ64j1gwCSrPUB6llUvUK3Kpr8Cg54GUvbw%2FWGpy109zQ%3D%3D) 33k（**推荐**）
- emotion：[https://github.com/emotion-js...](https://link.segmentfault.com/?enc=jphqNJAWNp2wv3ZHyS7EJw%3D%3D.fClomBedJyIu9HKokNoSCK9GLiXBBXv4fTKTlOU%2FAG7xqOJgchIEiJBmrcV0GHf0) 13k
- Radium：[https://github.com/Formidable...](https://link.segmentfault.com/?enc=LLhYeIIgaa2Y8%2FuEt%2FLclQ%3D%3D.guROpM%2F6%2Fkr%2BVF3x6BM8ImnwLK8obWjQln7RtS5pfVtTiFbbf56YFAnt6Z0sJhPj) 7k（已不再维护）
- Styled System：[https://github.com/styled-sys...](https://link.segmentfault.com/?enc=zMezLar1YHL%2FZ6dm9trvQA%3D%3D.BGxU7DGdgNRUEXGxmjOFj9TyUSA9KoR9bkTn3r4OB5x0CJl62JwuBrj5E7VQBH5P) 7k
- styled-jsx：[https://github.com/vercel/sty...](https://link.segmentfault.com/?enc=AwZY8bwO%2BaDAicthXeRp3Q%3D%3D.egjjKkwkd7TwqJPL9flUk32UBBQfdSbsJo3cpC%2FrIz0dD%2Fhs97MBmYy%2BBxjDSayU) 6k
- JSS：[https://github.com/cssinjs/jss](https://link.segmentfault.com/?enc=3N%2F6ppz5NgJENbDap%2BSOvQ%3D%3D.aUwJeWyfzuONqE%2BD%2FeEbu%2Fsw1yB5qPNwV%2FxUkMAs3Bc%3D) 6k

**参考**

[[CSS 模块化方案探讨（BEM、OOCSS、CSS Modules、CSS-in-JS ...）](https://segmentfault.com/a/1190000039772466)](https://segmentfault.com/a/1190000039772466)

[CSS模块化演进](https://codechina.gitcode.host/programmer/fe/20-CSS-modularization.html#css-%E6%A8%A1%E5%9D%97%E5%8C%96%E6%BC%94%E8%BF%9B)

## BFC

**定义**

`BFC` 全称：`Block Formatting Context`， 名为 "块级格式化上下文"。

`W3C`官方解释为：`BFC`它决定了元素如何对其内容进行定位，以及与其它元素的关系和相互作用，当涉及到可视化布局时，`Block Formatting Context`提供了一个环境，`HTML`在这个环境中按照一定的规则进行布局。

一句话：`BFC`是一个完全独立的空间（布局环境），让空间里的子元素不会影响到外面的布局。

**触发BFC的css属性**

- overflow: hidden
- display: inline-block
- position: absolute
- position: fixed
- display: table-cell
- display: flex

**BFC规则**

- BFC是块级元素，会按照瀑布流的方式从上到下排列
- BFC是隔离容器，容器里的标签不受外部影响
- 同一个`BFC`下的两个相邻的标签外边距会发生重叠
- 计算`BFC`的高度时，浮动元素也参与计算

**BFC应用**

- 使用Float脱离文档流，高度塌陷，如清除浮动
- Margin边距重叠
- 两栏布局

## 回流和重绘

1.概念：

> - Reflow回流，也称Layout，元素的**大小、位置**变了，需要重新计算布局。代价大。
> - Repaint重绘，元素的**颜色、背景、阴影**等外观变了，但不影响大小和位置，只需重新画一层。代价小。

2.常见引起回流和重绘的属性和方法：

任何会改变元素几何信息（元素的位置和尺寸大小）的操作都会触发回流。

- 添加或删除可见的 DOM 元素
- 元素尺寸改变--边距、填充、宽度、高度
- 浏览器尺寸改变-- resize 事件发生时
- 计算 offsetWidth 和 offsetHeight 属性
- 设置 style 属性的值
- 修改网页默认字体

3.如何减少回流？

- 使用 transform 代替 top
- 不要把节点的属性值放在一个循环里，当成循环里的变量
- 不要使用 table 布局，可能很小的一个改动会造成整个 table 的重新布局
- 把 DOM 离线后修改。如：使用 documentFragment 对象在内存里操作 DOM
- 不要一条一条的修改样式，可以预先定义好 class，然后修改 DOM 的 className
- 使用 absolute 或 fixed 使元素脱离文档流

## 外边距折叠

一句话：**外边距折叠，就是两个垂直相遇的 margin 合并成了一个，最终的大小取两者中的较大值，而不是相加。**

哪些情况会发生折叠：

> 1. 相邻兄弟元素之间
> 2. 父元素与首个/末尾子元素之间
> 3. 空的块级元素:一个没有内容、没有 border、没有 padding 的空元素，它自己的 `margin-top` 和 `margin-bottom` 会发生折叠

怎么防止折叠：

> 1. **给父元素加 `overflow: hidden`**（触发父元素 BFC，最常用，解决父子折叠）
> 2. **给父元素加 `padding` 或 `border`**（物理隔断了父子 margin 的接触）
> 3. **给父元素加 `display: flow-root`**（最正规的触发 BFC 方式，无副作用）
> 4. **改用 Flexbox 或 Grid 布局**（**重点！** Flex/Grid 容器内的子元素**绝对不会发生 margin 折叠**，这也是现代布局很少遇到这个问题的原因）

## z-index在position的值什么时候可以触发

在position的值是relative、absolute、fixed、sticky时候可以触发，在static时无效。

## Float浮动

**定义**

一句话：让block元素无视float元素，让inline元素像流水一样围绕着float元素实现浮动布局

**float特性**

- 包裹性
- 高度塌陷
- 块状化
- 没有任何margin合并

> 1.包裹性,是指包裹和自适应。
>
> 包裹：将浮动元素父元素宽度设置为200px，浮动元素的子元素是一个128px宽度的图片，则此时浮动元素宽度表现为”包裹”，即包裹了子元素，宽度也是128px.一句话：对内，浮动元素被内部撑起最小值
>
> 自适应：浮动元素自适应父元素的200px，一句话：对外，浮动元素被内部撑起最大值是父元素容器

```
/* CSS代码 */
.father{
    border: 1px solid deeppink;
    width: 200px;
}
.son {
    float: left;
    font-size: 0;
    border: 1px solid blue;
    padding: 5px;
}
.father img {
    width: 128px;
}

/* HTML代码 */
<div class="father">
    <div class="son">
     <!--包裹-->
        <img src="../../lib/img/mm1.png">
        <!--自适应-->
        <span style="font-size: 12px">美女1，美女2，美女3，美女4，美女5，美女6，后宫1，后宫2，后宫3，后宫</span>
    </div>
</div>
```

> 2.高度塌陷
>
> 会让父元素的高度塌陷，即无法撑开父元素高度

> 3.块状化
>
> 浮动元素的display值就是block或者table。注意它不是真正的块状元素，只是有块状的属性，如可以设置宽高。
>
> 以下是冗余写法，浮动元素加display: block;

> 4.没有任何margin合并
>
> 设置了float属性的元素没有任何的margin重叠

**清除浮动**

注意浮动一直还在，并没有清除！只能清除浮动带来的影响。

- 父级盒子元素触发BFC，overflow:hidden,auto（完美方法）
- 浮动元素设置clear:both。本质是让自己不和float元素在一行显示，并不是真正意义上的清除浮动
  - 如果`clear:both`元素前面的元素就是float元素，则设置margin-top无效
  - `clear:both`后面的元素依旧可能会发生文字环绕现象

**参考**

[CSS 深入理解之 float 浮动](https://juejin.cn/post/6844903616155746312#heading-1)

## 圣杯布局和双飞翼布局（经典三分栏布局）

|        | 优点                               | 缺点                     |
| ------ | ---------------------------------- | ------------------------ |
| 圣杯   | 使用padding，dom简单               | 中间宽度过小，会布局混乱 |
| 双飞翼 | 使用margin，支持各种宽高，通用型强 | dom复杂                  |

圣杯布局和双飞翼布局的目的：

- 三栏布局，中间一栏最先加载和渲染（**内容最重要，这就是为什么还需要了解这种布局的原因**）。
- 两侧内容固定，中间内容随着宽度自适应。
- 一般用于 PC 网页。

圣杯布局和双飞翼布局的技术总结：

- 使用 `float` 布局。
- 两侧使用 `margin` 负值，以便和中间内容横向重叠。
- 防止中间内容被两侧覆盖，圣杯布局用 `padding` ，双飞翼布局用 `margin` 。

**圣杯布局**

```
<div id="container" class="clearfix">
  <p class="center">我是中间</p>
  <p class="left">我是左边</p>
  <p class="right">我是右边</p>
</div>

#container {
  padding-left: 200px;
  padding-right: 150px;
  overflow: auto;
}
#container p {
  float: left;
}
.center {
  width: 100%;
  background-color: lightcoral;
}
.left {
  width: 200px;
  position: relative;
  left: -200px;
  margin-left: -100%;
  background-color: lightcyan;
}
.right {
  width: 150px;
  margin-right: -150px;
  background-color: lightgreen;
}
.clearfix:after {
  content: "";
  display: table;
  clear: both;
}
```

**双飞翼布局**

```
<div id="main" class="float">
  <div id="main-wrap">main</div>
</div>
<div id="left" class="float">left</div>
<div id="right" class="float">right</div>

.float {
  float: left;
}
#main {
  width: 100%;
  height: 200px;
  background-color: lightpink;
}
#main-wrap {
  margin: 0 190px 0 190px;
}
#left {
  width: 190px;
  height: 200px;
  background-color: lightsalmon;
  margin-left: -100%;
}
#right {
  width: 190px;
  height: 200px;
  background-color: lightskyblue;
  margin-left: -190px;
}
```

## CSS盒子模型

- `标准盒模型(box-sizing:content-box)`，width 指 content 的宽度，总宽度 = width+ padding内边距 + border边框 + margin；加了边框和内边距，盒子会**变大**
- `怪异盒模型/IE盒模型(box-sizing:border-box)`，width 指 content + padding内边距 + border边框，总宽度 = width + margin；无论内边距或边框多大，盒子**总大小不变**，内容自动缩水，推荐且浏览器默认

## 元素水平/垂直居中

1. 水平居中

- 行内元素：`text-align: center;`
- 对于确定宽度的块级元素
  - width 和 margin 实现： `mragin: 0 auto;`
  - 绝对定位和 margin-left 实现： `margin-left: (父width - 子 width)/2；`(前提是父元素相对定位)
- 对于宽度未知的块级元素
  - table 标签配合 margin 左右 auto 实现
  - inline-block 实现：`display: inline-block; text-align: center;`
  - 绝对定位和 transform 实现， translateX 可以移动本身元素的50%
  - flex 布局 `justify-content: center`

1. 垂直居中

- 纯文字类，设置 line-height 等于 height
- 子绝父相，子元素通过 margin 实现自适应居中
- 子绝父相，通过位移 transform 实现
- flex 布局，`align-items: center;`
- table 布局，父级通过转换为表格形式，子级设置 vertical-align 实现

## position、float和display的取值意思

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

## CSS常用3种引入方式

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

## CSS Sprites （雪碧图/精灵图）

css sprites 就是把网页中一些小图片整合到一张图片文件中，再利用 css 的 background-image、background-repeat、background-position 的组合进行背景定位。

优点： 减少图片体积；减少 http 请求次数

缺点：维护比较麻烦；不能随便改变大小，会失真模糊

## CSS选择器及优先级

1. 选择器
   - id选择器(#myid)
   - 类选择器(.myclass)
   - 属性选择器(a[rel="external"])
   - 伪类选择器(a:hover, li:nth-child)
   - 标签选择器(div, h1, p)
   - 伪元素选择器(p::first-line)
   - 相邻选择器（h1 + p）
   - 子选择器(ul > li)
   - 后代选择器(li a)
   - 通配符选择器(*)
2. 优先级
   - `!important`
   - 内联样式（1000）
   - ID选择器（0100）
   - 类选择器 / 属性选择器 / 伪类选择器（0010）
   - 标签选择器 / 伪元素选择器（0001）
   - 关系选择器 / 通配符选择器（0000）

带 !important 标记的样式属性优先级最高；样式表的来源相同时：`!important > 行内样式> ID选择器 > 类选择器 > 标签 > 通配符 > 继承 > 浏览器默认属性`

3.继承性

- 可继承的样式：font-size，font-family，color，ul，li，dl，dd，dt；
- 不可继承的样式：border padding margin width height 事实上，宽度也不是继承的，而是如果你不指定宽度，那么它就是 100%。由于你子 DIV 并没有指定宽度，那它就是 100%，也就是与父 DIV 同宽，但这与继承无关，高度自然也没有继承一说。

## rgba() 和 opacity 设置透明度的区别是什么？

rgba() 和 opacity 都能实现透明效果

-  opacity 作用于元素，以及元素内的所有内容的透明度
-  rgba() 只作用于元素的颜色或其背景色，设置 rgba() 透明的元素的子元素不会继承透明效果。

## 浏览器是如何解析 css 选择器的？

`从右向左解析的。`若从左向右匹配，发现不符合规则，需要回溯，会损失很多性能。若从右向左匹配，先找到所有的最后节点，对于每一个节点，向上寻找其父节点直到查找至根元素或满足条件的匹配规则，则结束这个分支的遍历。

## display: none 和 visibility: hidden 两者的区别

1. display: none 隐藏后不占用文档流；而 visibility: hidden 会占用文档流。
2. visibility 具有继承性，给父元素设置 "visibility: hidden"，子元素也会继承该属性，但如果重新给子元素设置 "visibility: visible"，则子元素又会显示出来。
3. visibility: hidden 不会影响计数器的计数，虽然隐藏了，但计数器依然运行着。
4. 在 css3 中 transition 支持 visibility 属性，但不支持 display。因为 transition 可以延迟执行，因此配合 visibility 使用纯 css 延时显示效果可以提高用户体验。
5. display: none 会引起回流（重排）和重绘；visibility: hidden 会引起重绘。

## 简述 transform，transition，animation 的作用

1. `transform`：描述了元素的静态样式，本身不会呈现动画效果，可以对元素进行旋转 rotate、扭曲 skew、缩放 scale 和移动 translate 以及矩阵变形 matrix。`transition` 和 `animation` 两者都能实现动画效果。`transform` 常配合`transition` 和 `animation` 使用。
2. `transition`：样式过渡，从一种效果逐渐改变为另一种效果，它是一个合写属性。transition: transition-property  transition-duration  transition-timing-function  transition-delay 从左到右，依次是：过渡效果的css属性名称、过渡效果花费时间、速度曲线、过渡开始的延迟时间  `transition` 通常和 hover 等事件配合使用，需要由事件来触发过渡。
3. `animation`：动画，有 `@keyframes` 来描述每一帧的样式。

区别：

- `transform` 仅描述元素的静态样式，常配合`transition` 和 `animation` 使用。
- `transition` 通常和 hover 等事件配合使用；`animation` 是自发的，立即播放。
- `animation` 可以设置循环次数。
- `animation` 可以设置每一帧的样式和时间，`transition` 只能设置头尾。
- `transition` 可以与 js 配合使用， js 设定要变化的样式，`transition` 负责动画效果。

## position 属性的值有哪些？

- `static`: 默认位置; 元素将会像通常那样流入页面。 `top`, `right`, `bottom`, `left` 和 `z-index` 属性不生效。
- `relative`：元素的位置相对于它自己进行调整，而不改变布局（从而在元素没有被定位的情况下为它留下一个缺口）。
- `absolute`：该元素从页面流中移除，并相对于其最近的祖先（如果有的话）或相对于初始包含块的指定位置定位。 绝对位置的方框可以有边距，而且它们不会与任何其他外边距一起折叠。 这些元素不影响其他元素的位置。
- `fixed`：该元素被从页面流中移除，并被定位在相对于视口的指定位置，滚动时不会移动。
- `sticky`：粘性定位是相对定位和固定定位的一种混合。 该元素被视为 `relative` 定位，直到它越过一个指定的阈值，超过这一阈值它将被视为 `fixed` 定位。

## 清除浮动

1.直接把 `<div style="clear: both;"></div>`作为最后一个子标签

- 优点：通俗易懂，容易掌握；
- 缺点：会添加较多无意义的空标签，有违结构与表现的分离，在后期维护中将是噩梦

2.clearfix { overflow: hidden; zoom: 1; }

- 优点：不存在结构和语义化问题，代码量极少
- 缺点：内容增多时容易造成不自动换行，导致内容被隐藏掉，无法显示需要溢出的元素

3.建立伪类选择器

```
.fix:after{
content:'';/*设置添加子元素的内容为空*/
display:block;
height:0;
visibility:hidden;
clear:both;
}
```

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

## flex=1代表什么，用于什么场景

- flex：1 适用等分布局，在尺寸不足时依然与其他元素保持等分，会优先压缩自身
- flex：auto 适用基于内容动态适配的布局，挤压其他元素的空间

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

## **first-child与:first-of-type的区别**

> :first-child 匹配的是某父元素的第一个子元素，可以说是结构上的第一个子元素。

> :first-of-type 匹配的是某父元素下相同类型子元素中的第一个，比如 p:first-of-type，就是指所有类型为p的子元素中的第一个。这里不再限制是第一个子元素了，只要是该类型元素的第一个就行了。

同样类型的选择器 :last-child 和 :last-of-type、:nth-child(n) 和 :nth-of-type(n) 也可以这样去理解。

## 页面样式导入link和@import区别

- link 属于 XHTML 标签，除了加载 CSS 外，还能用于定义 RSS(是一种描述和同步网站内容的格式，是使用最广泛的 XML 应用), 定义 rel 连接属性等作用；
- 而 @import 是 CSS 提供的，只能用于加载 CSS;
- 页面被加载的时，link 会同时被加载，而 @import 引用的 CSS 会等到页面被加载完再加载;
- import 是 CSS2.1 提出的，只在 IE5 以上才能被识别，而 link 是 XHTML 标签，无兼容问题。
- 总之，link 要优于 @import。

## Grid布局

[张鑫旭的grid](https://www.zhangxinxu.com/wordpress/2018/11/display-grid-css-css3/#grid-template-columns-rows)

[最大强大Grid](https://juejin.cn/post/6854573220306255880#heading-8)

[Grid布局相关属性](https://yqwoshuai.github.io/note/grid/#%E5%AE%B9%E5%99%A8%E5%B1%9E%E6%80%A7)

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



### 作用在grid容器上的CSS属性

**grid-template-columns**

纵向分块，分多少个块，每块多少单位

```
.container {
    grid-template-columns: 80px auto 100px;
    grid-template-rows: 25% 100px auto 60px;
}
```

**grid-template-rows**

横向分块，分多少个块，每块多少单位

```
.container {
    grid-template-columns: 80px auto 100px;
    grid-template-rows: 25% 100px auto 60px;
}
```

**grid-template-areas**

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

**grid-template**

行列分块的缩写

`grid-template`是`grid-template-rows`，`grid-template-columns`和[`grid-template-areas`](https://www.zhangxinxu.com/wordpress/2018/11/display-grid-css-css3/#grid-template-areas)属性的缩写。

```
.container {
    grid-template: <grid-template-rows> / <grid-template-columns>;
}
```

**grid-column-gap**

列块间距

**grid-row-gap**

行块间距

**grid-gap**

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

**justify-items**

每个子项的水平的左中右对齐

**align-items**

每个子项的垂直的上中下对齐

**place-items**

每个子项的水平垂直的缩写

place-items是align-items`和`justify-items的缩写

```
.container {
    place-items: <align-items> <justify-items>?;
}
```

**justify-content**

子项整体的水平的左中右对齐

**align-content**

子项整体的垂直的上中下对齐

**place-content**

子项整体的水平垂直的缩写

place-content是align-content`和`justify-content的缩写

```
.container {
    place-content: <align-content> <justify-content>?;
}
```

**grid-auto-columns**

对超出容器后的部分，纵向分块

**grid-auto-rows**

对超出容器后的部分，横向分块

**grid-auto-flow**

指定排列方式：默认row,横向排列。也可以column纵向排列

**grid**

大集合，[`grid-template-rows`](https://www.zhangxinxu.com/wordpress/2018/11/display-grid-css-css3/#grid-template-columns-rows)，[`grid-template-columns`](https://www.zhangxinxu.com/wordpress/2018/11/display-grid-css-css3/#grid-template-columns-rows)，[`grid-template-areas`](https://www.zhangxinxu.com/wordpress/2018/11/display-grid-css-css3/#grid-template-areas)，[`grid-auto-rows`](https://www.zhangxinxu.com/wordpress/2018/11/display-grid-css-css3/#grid-auto-columns-rows)，[`grid-auto-columns`](https://www.zhangxinxu.com/wordpress/2018/11/display-grid-css-css3/#grid-auto-columns-rows)和[`grid-auto-flow`](https://www.zhangxinxu.com/wordpress/2018/11/display-grid-css-css3/#grid-auto-flow)。

```
grid: <grid-template-rows> / [ auto-flow && dense? ] <grid-auto-columns>? 
```

**具体说明：**

- `auto-flow && dense?`其实就是`grid-auto-flow`属性的值，等同于`row`或`column`或`row dense`或`column dense`。

  但这里`row`和`column`这两个关键字却使用了`auto-flow`这一个关键字代替了。那岂不有问题：什么时候解析成`row`，什么时候解析成`column`呢？

  原来，是根据`auto-flow`关键字是在斜杠的左侧还是右侧决定的。如果`auto-flow`关键字在斜杠左侧，则解析为`row`，如果是在右侧，则解析为`column`。这里的语法是在斜杠的右侧，因此，会将`grid-auto-flow`解析为`column`。

- `<grid-auto-columns>`后面有个问号`?`，因此是可以省略的，如果省略，则将`grid-auto-columns`解析为`auto`。

### 作用在grid子项上的CSS属性

**grid-column-start**

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

**grid-column-end**

设置元素网格线的列终点

**grid-row-start**

设置元素网格线的行起点

**grid-row-end**

设置元素网格线的行终点

**grid-column**

子项的列起始点的缩写。

grid-column是`grid-column-start`+ `grid-column-end`的缩写

```
.item-b {
    grid-column: 2 / span 纵线3;
    grid-row: 第一行开始 / span 3;
}
```

**grid-row**

子项的行起始点的缩写。

grid-row是grid-row-start + grid-row-end的缩写

**grid-area**

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

**justify-self**

子项内部的水平对齐方式

**align-self**

子项内部的垂直对齐方式

**place-self**

子项内部的水平垂直的缩写

`place-self` 是设置 `align-self` 和 `justify-self` 的缩写。

```
.item {
    place-self: <align-self> <justify-self>?
}
```

**注意**

- 在Grid布局中，`float`，`display:inline-block`，`display:table-cell`，`vertical-align`以及`column-*`这些属性和声明对grid子项是没有任何作用的。这个可以说是Grid布局中的常识，面试经常会问的，一定要记得。
- Grid布局则适用于更大规模的布局（二维布局），而Flexbox布局最适合应用程序的组件和小规模布局（一维布局），关Flex布局请参见“[写给自己看的display: flex布局教程”一文](https://www.zhangxinxu.com/wordpress/?p=8063)。
- 命名虽然支持中文，但由于CSS文件中文存在乱码的风险，所以……创新还是保守就看大家自己的抉择了。
- IE10-IE15虽然名义上支持Grid布局，但支持的是老版本语法（本文是介绍的全是2.0全新语法），还需要加`-ms-`私有前缀，精力原因，IE下的使用并未深究，以后有机会再补充。

## Flex弹性布局

小技巧：剩余填充可以使用width:0;flex:1;

[flex实战原文](https://tsejx.github.io/css-guidebook/layout/basic/flexible-box-layout#flex-order)

### 容器属性

flex 布局，是一种弹性盒布局模型，给子元素提供了空间分布和对齐能力，由`container`（容器）及`item`（项目）组成。该布局模型提供了一种更加高效的方式来对容器中的项目进行布局、对齐和分配空间。适用于在不同尺寸的屏幕中创建可自动扩展和收缩布局，通常可用于`水平/垂直居中`，`两栏`、`三栏布局`等的场景里。

其中`flex`属性是`flex-grow`，`flex-shrink`和`flex-basis`的简写，默认值为`0 1 auto`。**该属性有两个快捷值：`auto (1 1 auto)` 和 `none (0 0 auto)`。**

- `flex-grow`：定义项目的放大比例，默认值为 0，即如果存在剩余空间，也不放大。如果所有项目的`flex-grow`属性都为 1，则它们将等分剩余空间（如果有的话）。如果一个项目的`flex-grow`属性为 2，其他项目都为 1，则前者占据的剩余空间将比其他项多一倍。
- `flex-shrink`：项目的缩小比例，默认为 1，即如果空间不足，项目将缩小。如果所有项目的`flex-shrink`属性都为 1，当空间不足时，都将等比例缩小。如果一个项目的`flex-shrink`属性为 0，其他项目都为 1，则空间不足时，前者不缩小。
- `flex-basis`：定义了在分配多余空间之前，项目占据的主轴空间。浏览器会根据该属性，计算主轴是否有多余空间。它的默认值为 auto，即项目的本来大小。当设置为 0 的是，会根据内容撑开。也可以设为跟`width`或`height`属性一样的值（比如 350px），则项目将占据固定空间。

`flex`常用的属性值：

- flex: 1 --> flex: 1 1 0%
- flex: 2 --> flex: 2 1 0%
- flex: auto --> flex: 1 1 auto
- flex: none --> flex: 0 0 auto【常用于固定尺寸不伸缩】

**flex-direction**

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

**flex-wrap**

`flex-wrap` 属性用于指定弹性布局中子项是否换行。

```css
.container {
  flex-wrap: nowrap | wrap | wrap-reverse;
}
```

- `nowrap`（默认值）：表示不换行，所有子项目单行排列，子项可能会溢出。
- `wrap`：表示换行，所有子项目多行排列，溢出的子项会被放到下一行，按从上向下顺序排列。
- `wrap-reverse`：所有子项目多行排列，按从下向上顺序排列。

**flex-flow**

`flex-flow` 属性是 `flex-direction` 属性和 `flex-wrap` 属性的简写形式，默认值为 `row nowrap`。

```css
.container {
  flex-flow: < 'flex-direction' > || < 'flex-wrap' >;
}
```

**justify-content**

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

**align-items**

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

**align-content**

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

### 子项属性

**order**

缺省情况下，Flex 子项是按照在代码中出现的先后顺序排列的。CSS3 新增加 `order` 属性定义项目的排列顺序，是数值类型。数值越小，排列越靠前，默认为 0。

> 注意此属性设置在子项上，浏览器自动按照 `order` 的大小排序盒子，默认都是 0，如果相同的 `order` 则按照编写标签的顺序排放盒子。

```css
.item {
  order: 1;
}
```

**flex-grow**

`flex-grow` 属性定义子项的**扩展比例**，取值必须是一个单位的正整数，表示放大的比例。默认为 0，即如果存在额外空间，也不放大，负值无效。Flex 容器会根据子项设置的扩展比例作为比率来分配剩余空间

如果所有项目的 `flex-grow` 属性都为 1，则它们将等分剩余空间（如果有的话）。如果一个项目的 `flex-grow` 属性为 2，其他项目都为 1，则前者占据的剩余空间将比其他项多一倍。

一行的子盒子同时设置 `flex-grow` 属性的话，会根据设置的值的大小按比例排放子项。

*flex-grow 属性决定了子项要占用父容器多少剩余空间*

计算方式：

- 假设剩余空间 `x`（弹性容器宽度与所有弹性子项宽度总和之差）
- 假设有三个弹性子项元素，`flex-grow` 设定值分别为 `a`、`b` 和 `c`
- 每个元素可以分配的剩余空间为：`a/(a+b+c) * x`、`b/(a+b+c) * x` 和 `c/(a+b+c) * x`

假设剩余空间为 `150px`，`a`、`b` 和 `c` 的 `flex-grow` 分别为 1、2 和 3，那么 `a` 占比剩余空间：`1/(1+2+3) = 1/6`，那么 `a` 瓜分到的剩余空间宽度是 `150*(1/6)=25`，加上 `a` 原本的宽度，实际的宽度为 `<origin-width> + 25`。

**flex-shrink**

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

**flex-basis**

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

**flex**

`flex` 属性是 `flex-grow`、`flex-shrink` 和 `flex-basis` 的简写，默认值为 `0 1 auto`。后两个属性可选。

```css
.item {
  flex: none | [ < 'flex-grow' > < 'flex-shrink' >? || < 'flex-basis' > ];
}
```

该属性有两个快捷值：`auto (1 1 auto)` 和 `none (0 0 auto)`。

建议优先使用这个属性，而不是单独写三个分离的属性，因为浏览器会推算相关值。

**align-self**

`align-self` 属性用于指定子项的对齐方式，可覆盖 `align-items` 属性。

默认值为 `auto`，表示继承父元素的 `align-items` 属性，如果没有父元素，则等同于 `stretch`。

```css
.item {
  align-self: auto || flex-start || flex-end || center || baseline || stretch;
}
```

## 重设样式

使用的是Yahoo(YUI) 的reset.css

```
body,div,dl,dt,dd,ul,ol,li,h1,h2,h3,h4,h5,h6,pre, 
form,fieldset,input,textarea,p,blockquote,th,td { 
    padding: 0; 
    margin: 0; 
} 
table { 
    border-collapse: collapse; 
    border-spacing: 0; 
} 
fieldset,img { 
    border: 0; 
} 
address,caption,cite,code,dfn,em,strong,th,var { 
    font-weight: normal; 
    font-style: normal; 
} 
ol,ul { 
    list-style: none; 
} 
caption,th { 
    text-align: left; 
} 
h1,h2,h3,h4,h5,h6 { 
    font-weight: normal; 
    font-size: 100%; 
} 
q:before,q:after { 
    content:”; 
} 
abbr,acronym { 
    border: 0; 
}
```

## line-height

- [腾讯ISD团队-深入理解CSS行高](https://cloud.tencent.com/developer/article/1534973)

line-height，是指同一个元素中，两个文本行基线间的垂直距离。

应用场景

- 单行文字的垂直居中对齐：把line-height设置为您需要的box的大小可以实现单行文字的垂直居中，不需要设置height
- 多行文字的垂直居中：使用`padding`就好了

# 进阶

## 伪类和伪元素

**伪类**

伪类即假的类，通常可以添加类来达到效果。伪类是选择器的一种，它用于选择处于特定状态的元素。它们表现得会像是你向你的文档的某个部分应用了一个类一样，帮你在你的标记文本中减少多余的类，让你的代码更灵活、更易于维护。伪类开头为冒号`:`

用户行为伪类，一些伪类只会在用户以某种方式和文档交互的时候应用。这些用户行为伪类，有时叫做动态伪类，如:hover，:focus。

> 常见伪类
>
> :active 在用户激活（例如点击）元素的时候匹配。
>
> :checked 匹配处于选中状态的单选或者复选框。
>
> :disabled 匹配处于关闭状态的用户界面元素
>
> :first-child 匹配兄弟元素中的第一个元素。
>
> :first-of-type 匹配兄弟元素中第一个某种类型的元素。
>
> :focus 当一个元素有焦点的时候匹配。
>
> :hover 当用户悬浮到一个元素之上的时候匹配。
>
> :last-child 匹配兄弟元素中最末的那个元素。
>
> :last-of-type 匹配兄弟元素中最后一个某种类型的元素。
>
> :is() 匹配传入的选择器列表中的任何选择器。
>
> :not 匹配作为值传入自身的选择器未匹配的物件。
>
> :nth-child 匹配一列兄弟元素中的元素——兄弟元素按照an+b形式的式子进行匹配（比如2n+1匹配元素1、3、5、7等。即所有的奇数个）。
>
> :nth-of-type 匹配某种类型的一列兄弟元素（比如，`<p>`元素）——兄弟元素按照an+b形式的式子进行匹配（比如2n+1匹配元素1、3、5、7等。即所有的奇数个）。
>
> :nth-last-child 匹配一列兄弟元素，从后往前倒数。兄弟元素按照an+b形式的式子进行匹配（比如2n+1匹配按照顺序来的最后一个元素，然后往前两个，再往前两个，诸如此类。从后往前数的所有奇数个）。
>
> :nth-last-of-type 匹配某种类型的一列兄弟元素（比如，`<p>`元素），从后往前倒数。兄弟元素按照an+b形式的式子进行匹配（比如2n+1匹配按照顺序来的最后一个元素，然后往前两个，再往前两个，诸如此类。从后往前数的所有奇数个）。
>
> :only-child 匹配没有兄弟元素的元素。
>
> :only-of-type 匹配兄弟元素中某类型仅有的元素。

**伪元素**

伪元素即假元素，需要通过添加元素才能达到效果。伪元素以类似方式表现，不过表现得是像你往文档中加入全新的HTML元素一样，而不是向现有的元素上应用类。伪元素开头为双冒号`::`

> 常见伪元素
>
> ::before在被选元素前插入内容,属性 `content` 是必须设置的，它的值可以为字符串，也可以有其它形式
>
> ::after在被元素后插入内容，属性 `content` 是必须设置的，它的值可以为字符串，也可以有其它形式
>
> ::first-line作用于第一行的所有字符
>
> ::first-letter作用于第一行的首字符

**伪类和伪元素的区别**

> - 伪类和伪元素都是用来表示文档树以外的"元素"。
> - 伪类和伪元素分别用单冒号`:`和双冒号`::`来表示。
> - 伪类和伪元素的区别，最关键的点在于如果没有伪元素(或伪类)，是否需要添加元素才能达到目的，如果是则是伪元素，反之则是伪类。

## sass（scss）、less、stylus、postcss

它们都是css预处理器。css预处理器的概念：CSS预处理器用一种专门的编程语言，进行Web页面样式设计，然后再编译成正常的CSS文件。

- sass:Sass是一种动态样式语言，Sass语法属于缩排语法，比css比多出好些功能(如变量、嵌套、运算,混入(Mixin)、继承、颜色处理，函数等)，更容易阅读。

  对Sass的缩排语法优化，用{}取代了原来的缩进，变成了Scss(sassy css)，与原来的语法兼容。变量符是$。

- less:也是一种动态样式语言. 受Sass影响较大,对CSS赋予了动态语言的特性，如变量，继承，运算， 函数。在客户端上和服务端都可以运行。变量符是@。

- Stylus：主要用来给Node项目进行CSS预处理支持。提供一个高效、动态、和使用表达方式来生成CSS，以供浏览器使用。支持缩进和CSS常规样式书写规则。写法更接近js,学习曲线陡峭。变量符是随意。

- PostCSS：它是一个对 CSS 进行处理的工具（平台），不能简单的把 PostCSS 归类成 CSS 预处理或后处理工具。PostCSS 一般不单独使用，而是与已有的构建工具进行集成。PostCSS 与主流的构建工具，如 Webpack、Grunt 和 Gulp 都可以进行集成。

## CSS动画

css实现动画有三种方式：

> - transition 实现渐变动画
> - transform 转变动画
> - animation 实现自定义动画

| 属性               | 含义                                                         |
| ------------------ | ------------------------------------------------------------ |
| transition（过度） | 用于设置元素的样式过度，和animation有着类似的效果，但细节上有很大的不同 |
| transform（变形）  | 用于元素进行旋转、缩放、移动或倾斜，和设置样式的动画并没有什么关系，就相当于color一样用来设置元素的“外表” |
| translate（移动）  | 只是transform的一个属性值，即移动                            |
| animation（动画）  | 用于设置动画属性，他是一个简写的属性，包含6个属性            |

**transition 实现渐变动画**

`transition`的属性如下：

- property:填写需要变化的css属性
- duration:完成过渡效果需要的时间单位(s或者ms)
- timing-function:完成效果的速度曲线
- delay: 动画效果的延迟触发时间

其中`timing-function`的值有如下：

| 值                            | 描述                                                         |
| ----------------------------- | ------------------------------------------------------------ |
| linear                        | 匀速（等于 cubic-bezier(0,0,1,1)）                           |
| ease                          | 从慢到快再到慢（cubic-bezier(0.25,0.1,0.25,1)）              |
| ease-in                       | 慢慢变快（等于 cubic-bezier(0.42,0,1,1)）                    |
| ease-out                      | 慢慢变慢（等于 cubic-bezier(0,0,0.58,1)）                    |
| ease-in-out                   | 先变快再到慢（等于 cubic-bezier(0.42,0,0.58,1)），渐显渐隐效果 |
| cubic-bezier(*n*,*n*,*n*,*n*) | 在 cubic-bezier 函数中定义自己的值。可能的值是 0 至 1 之间的数值 |

注意：并不是所有的属性都能使用过渡的，如`display:none<->display:block`

```
<div class="base"></div>
.base {
  width: 100px;
  height: 100px;
  display: inline-block;
  background-color: #0ea9ff;
  border-width: 5px;
  border-style: solid;
  border-color: #5daf34;
  // transition-property: width, height, background-color, border-width;
  // transition-duration: 2s;
  // transition-timing-function: ease-in;
  // transition-delay: 500ms;
  /*简写*/
  transition: all 2s ease-in 500ms;
}

.base:hover {
  width: 200px;
  height: 200px;
  background-color: #5daf34;
  border-width: 10px;
  border-color: #3a8ee6;
}   
```

**transform 转变动画**

包含四个常用的功能：

- translate：位移
- scale：缩放
- rotate：旋转
- skew：倾斜

一般配合`transition`过度使用

注意的是，`transform`不支持`inline`元素，使用前把它变成`block`

```
.base {
  width: 100px;
  height: 100px;
  display: inline-block;
  background-color: #0ea9ff;
  border-width: 5px;
  border-style: solid;
  border-color: #5daf34;
  // 搭配transition
  transition: all 2s ease-in 500ms;
}

.base:hover {
  width: 200px;
  height: 200px;
  background-color: #5daf34;
  border-width: 10px;
  border-color: #3a8ee6;
  transform: scale(0.8, 1.5) rotate(35deg) skew(5deg) translate(15px, 25px);
}
```

**animation 实现自定义动画**

`animation`是由 8 个属性的简写，分别如下：

| 属性                                   | 描述                                                         | 属性值                                        |
| -------------------------------------- | ------------------------------------------------------------ | --------------------------------------------- |
| animation-duration                     | 指定动画完成一个周期所需要时间，单位秒（s）或毫秒（ms），默认是 0 |                                               |
| animation-timing-function              | 指定动画计时函数，即动画的速度曲线，默认是 "ease"            | linear、ease、ease-in、ease-out、ease-in-out  |
| animation-delay                        | 指定动画延迟时间，即动画何时开始，默认是 0                   |                                               |
| animation-iteration-count              | 指定动画播放的次数，默认是 1                                 |                                               |
| animation-direction 指定动画播放的方向 | 默认是 normal                                                | normal、reverse、alternate、alternate-reverse |
| animation-fill-mode                    | 指定动画填充模式。默认是 none                                | forwards、backwards、both                     |
| animation-play-state                   | 指定动画播放状态，正在运行或暂停。默认是 running             | running、pauser                               |
| animation-name                         | 指定 @keyframes 动画的名称                                   |                                               |

`CSS` 动画只需要定义一些关键的帧，而其余的帧，浏览器会根据计时函数插值计算出来，

通过 `@keyframes` 来定义关键帧

```
.base {
  width: 100px;
  height: 100px;
  display: inline-block;
  background-color: #0ea9ff;
  border-width: 5px;
  border-style: solid;
  border-color: #5daf34;
}

.base:hover {
  animation: rotate 2s;
}
@keyframes rotate {
  from {
    transform: rotate(0deg);
  }
  to {
    transform: rotate(360deg);
  }
}
```

## ::before 和 :after 双冒号和单冒号的区别

- 单冒号 (:) 用于 CSS3 伪类，双冒号 (::) 用于 CSS3 伪元素。
- ::before 就是以一个子元素的存在，定义在元素主体内容之前的一个伪元素。并不存在于 dom 之中，只存在在页面之中。

:before 和 :after 这两个伪元素，是在 CSS2.1 里新出现的。 起初，伪元素的前缀使用的是单冒号语法，但随着 Web 的进化，在 CSS3 的规范里，伪元素的语法被修改成使用双冒号，成为 ::before、 ::after 。

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

## CSS3有哪些新特性？

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

## canvas与svg的区别？

Canvas是使用JavaScript程序绘图(动态生成)，SVG是使用XML文档描述来绘图。

SVG是基于矢量的，所有它能够很好的处理图形大小的改变。Canvas是基于位图的图像，它不能够改变大小，只能缩放显示；

历史对比

|      |            canvas             |              svg               |
| :--: | :---------------------------: | :----------------------------: |
| 历史 | 较新，由Apple私有技术发展而来 |   历史悠久,2003年成为W3C标准   |
| 功能 |      功能简单，2D绘图API      | 功能丰富，各种图形、滤镜、动画 |
| 特点 |       像素,只能脚本驱动       |     矢量，XML,CSS,元素操作     |
| 支持 |       主流浏览器，IE9+        | 主流浏览器，IE9+,其他svg阅读器 |

性能对比

|          |          canvas          |             svg              |
| :------: | :----------------------: | :--------------------------: |
| 操作对象 |   基于像素(动态点阵图)   |         基于图形元素         |
|   元素   |       单个HTML元素       | 多种图形元素(Rect,Path,Line) |
|   驱动   |       只能脚本驱动       |        支持脚本和CSS         |
| 事件交互 |    交互到像素点(x,y)     |  交互到图形元素(rect,path)   |
|   性能   | 适合小面积，大数量的场景 |   适合大面积，小数量的场景   |

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

## css2.0与css3.0

css3加强了css2的功能，增加了新的属性和新的标签，并且删除了一些冗余的标签，在布局方面减少了代码量。

例如圆角、阴影、:last-child与:nth-last-child()伪类选择器等。

- css3代码更简洁、结构更合理、性能和效果得到兼顾；

- css3兼容性没有css2兼容性好，很多新属性需要加上浏览器兼容前缀；
- css3能仅使用代码就实现的效果，css2需要使用图片来实现；
- css2请求服务器次数高于css3；

## CSS实现节流

实现过程：

1. 函数节流是一个非常常见的优化方式，可以有效避免函数过于频繁的执行
2. CSS 的实现思路和 JS 不同，重点在于在于找到和该场景相关联的属性
3. CSS 实现“节流”其实就是控制一个动画的精准控制，假设有一个动画控制按钮从**禁用**->**可点击**的变化，每次点击时让这个动画重新执行一遍，在执行的过程中，一直处于**禁用**状态，这样就达到了“节流”的效果
4. 还可以通过 transition 的回调函数动态设置按钮禁用态
5. 这种实现的好处在于禁用逻辑和业务逻辑是完全解耦的

```
<button onclick="console.log('保存1')">我是“普通”保存</button>
<button class="throttle" onclick="console.log('保存2')">我是“节流”保存</button>

  body{
    display: grid;
    place-content: center;
    height: 100vh;
    margin: 0;
    gap: 15px;
    background: #f1f1f1;
}
button{
  user-select: none;
}
.throttle{
  opacity: .99;
  transition: opacity 2s;
}
.throttle:not(:disabled):active{
  opacity: 1;
  transition: 0s;
}

document.addEventListener('transitionstart', function(ev){
      ev.target.disabled = true
    })
    document.addEventListener('transitionend', function(ev){
      ev.target.disabled = false
    })
```



# 高级

## Tailwind CSS

[[一次就能看懂的Tailwind CSS介绍]](https://segmentfault.com/a/1190000041152680)

### CSS 发展阶段

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

### 什么是Tailwind CSS 

Tailwind CSS 是一个利用公用程序类（`Utilize Class`，下文皆称Utilize Class）的 CSS 框架。许多人会想到 CSS 框架，有很多，例如 `Bootstrap、Bulma 和 Material UI`。Bootstrap 和 Bulma 等框架利用预先准备好的组件（例如按钮、菜单和面包屑）进行设计。在 Tailwind CSS 中，没有准备任何组件，而是使用`Utilize Class`来创建和设计自己的组件。

> Tailwind CSS 还提供了一个Headless UI ([https://headlessui.dev](https://link.segmentfault.com/?enc=SVI0nzk7qsZYqdPG%2FpzBEg%3D%3D.5QrLqST7P6RWcCnbCD7z%2FJq9MherxCBMIsMCAX5fpK0%3D))，如果你想创建复杂的组件（例如下拉菜单和对话框），你可以使用它。

原来Bootstrap等框架可以通过提前准备组件集合来高效地设计网站，但是有一个缺点，就是因为使用了相同的设计，所以没有原创性。相比之下，Tailwind CSS 没有组件集合，所以即使你创建一个名为相同按钮的组件，每个人都会应用不同的`Utilize Class`创建它，可以创建出一个高度原创的网站。

### Tailwind CSS优缺点

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

## 常见兼容性问题？

- 浏览器默认的 margin 和 padding 不同。解决方案是加一个全局的 *{margin: 0; padding: 0;} 来统一。
- IE下 event 对象有 event.x，event.y 属性，而 Firefox 下没有。Firefox 下有 event.pageX，event.PageY 属性，而 IE 下没有。 解决办法：var mx = event.x?event.x:event.pageX;
- Chrome 中文界面下默认会将小于 12px 的文本强制按照 12px 显示, 可通过加入 CSS 属性 -webkit-text-size-adjust: none; 解决.
- 超链接访问过后 hover 样式就不出现了，被点击访问过的超链接样式不在具有 hover 和 active 了，解决方法是改变 CSS 属性的排列顺序: L-V-H-A : a:link {} a:visited {} a:hover {} a:active {}

## 图片裁剪压缩技术

一张 4px × 4px 的彩色图片，未压缩的的原始图像数据，就是一个 4 × 4 矩形网格，每一个网格代表一个像素。每一个像素，又是由 红，绿，蓝 三基色构成，**1 个像素点需要 3 个字节**。

**一、图片压缩的原理**

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

**二、使用 Canvas 压缩图片**

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

**三、使用第三方库裁剪**

Cropper.js

# 常用CSS

## 巧用not选择器

> 有些情况下`所有`的元素都需要某些样式，唯独`最后一个`不需要，这时候使用not选择器将会特别方便

```
li:not(:last-child){
  border-bottom: 1px solid #ebedf0;
}
```

## 使用flex布局实现智能固定底部

> 内容不够时，`规则说明`要处于底部，内容足够多时，`规则说明`随着内容往下沉，大家一定也遇到过类似的需求，使用flex巧妙实现布局。

```
<div class="container">
  <div class="main">我是内容区域</div>
  <div class="footer">规则说明</div>
</div>

 .container{
  height: 100vh;
  /* 关键css处 */
  display: flex;
  flex-direction: column;
  justify-content: space-between;
}
.main{
  /* 关键css处 */
  flex: 1;
  background-image: linear-gradient(45deg, #ff9a9e 0%, #fad0c4 99%, #fad0c4 100%);
  display: flex;
  align-items: center;
  justify-content: center;
  color: #fff;
}
.footer{
  padding: 15px 0;
  text-align: center;
  color: #ff9a9e;
  font-size: 14px;
}
```

## 文本超出

中英文超过换行

- word-break:break-word
- word-wrap:break-word

单行文本超过部分显示省略号

```
overflow: hidden;
text-overflow: ellipsis;
white-space: nowrap;
```

多行文本超过部分显示省略号

```
overflow: hidden;
text-overflow: ellipsis;
display: -webkit-box;
-webkit-box-orient: vertical;
-webkit-line-clamp: 2;
word-break: break-all;
```

若使用vue，则可使用下面这种方式

```
display: -webkit-box;
-webkit-box-orient: vertical;
-webkit-line-clamp: 2;
overflow: hidden;
word-break: break-all;
```

## 禁止选择文本

```
user-select: none;
```

## 画三角形

```
<div class="box">
  <div class="box-inner">
    <div class="triangle bottom"></div>
    <div class="triangle right"></div>
    <div class="triangle top"></div>
    <div class="triangle left"></div>
  </div>
</div>

.triangle {
  display: inline-block;
  margin-right: 10px;
  /* 基础样式 */
  border: solid 10px transparent;
}
  /*下*/
.triangle.bottom {
  border-top-color: #0097a7;
}
  /*上*/
.triangle.top {
  border-bottom-color: #b2ebf2;
}
/*左*/
.triangle.left {
  border-right-color: #00bcd4;
}
/*右*/
.triangle.right {
  border-left-color: #009688;
}
```

## 画小箭头

```
<div class="box">
  <div class="box-inner">
    <div class="arrow bottom"></div>
    <div class="arrow top"></div>
    <div class="arrow right"></div>
    <div class="arrow left"></div>
  </div>
</div>

.arrow {
    display: inline-block;
    margin-right: 10px;
    /* 基础样式 */
    width: 0;
    height: 0;
    /* 基础样式 */
    border: 16px solid;
    border-color: transparent #CDDC39 transparent transparent;
    position: relative;
  }

  .arrow::after {
    content: "";
    position: absolute;
    /* 通过位移覆盖背景 */
    right: -20px;
    top: -16px;
    border: 16px solid;
    border-color: transparent #fff transparent transparent;
  }
  /*下*/
  .arrow.bottom {
    transform: rotate(270deg);
  }
  /*上*/
  .arrow.top {
    transform: rotate(90deg);
  }
  /*左*/
  .arrow.left {
    transform: rotate(180deg);
  }
  /*右*/
  .arrow.right {
    transform: rotate(0deg);
  }
```

## 网页呈现哀悼模式

```
body{
  filter: grayscale(1);
}
```

