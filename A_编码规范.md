---
title: A_编码规范
date: 2021-11-01 06:33:16
categories:
- A_编码规范
toc: true # 是否启用内容索引
---
常规命名，命名全小写，多个单词用中划线-间隔，用于：class,id，属性，组件名，文件名
camelCase小驼峰，首字母小写，其他大写，用于：函数
PascalCase 帕斯卡，首字母全大写，用于：常量

# 1.通用编码规范规则

```
规则1 访问外部对象时，需先判断该对象是否为空
规则2 功能失效时必须彻底删除对应的功能代码
规则3 禁止注释中含有员工个人信息
规则4 禁止硬编码用户账户密码
规则5 在客户端对外部输入进行校验，对输入字符转义，防止sql注入和XSS注入
规则7 禁止使用eval()函数，IE9下使用eval()存在内存泄露问题
规则8 禁止直接对不可信的JS对象进行序列化，可能有代码注入的安全漏洞
规则10 禁止未验证的输入作为重定向URL
规则12 禁止直接将不可信数据插入到WEB页面中，防止XSS攻击盗取cookie和会话信息。可以先转义js，再插入dom
规则13 禁止在 localStorage存储敏感信息。开发人员可能希望在旅游应用程序中使用多个浏览器选项卡或实例,以支持用户打开多个选项卡来比较住宿选择，同时保留用户最初的搜索条件。开发人员必须多加小心，以免将敏感信息从 sessionStorage 范围移至 localStorage。
```

# **2.HTML编码规范**

```
规则1：语法规范，嵌套的节点应该缩进； • 在属性上，使用双引号，不要使用单引号； • 属性名全小写，用中划线做分隔符；
规则3：文件编码，所有的文件以UTF-8的方式进行编码
规则4：文件命名，命名全小写，多个单词用中划线-间隔，注意：class,id，属性，组件名等命名规格也要这样
规则2：Class 与 ID，应以功能或内容命名，规则同文件，id作为唯一标识
规则3：属性顺序， • id • class • name • data-xxx • src, for, type, href • title, alt • aria-xxx, role规则7：多媒体标签的alt属性，资源无法加载时，指定备份文字
规则8：正确使用闭合标签，自定义标签一定要闭合，void element标签不要闭合。如：<br标签> 。根据w3的规范，void元素有area，base，br，col，command，embed，hr，img，input，keygen，link，meta，param，source，track，wbr。
规则9：IE 兼容模式。IE 支持通过特定的标签来确定绘制当前页面所应该采用的IE版本。除非有强烈的特殊需求，否则最好是设置为 edge mode，从而通知 IE 采用其所支持的最新的模式。
规则12：层级简单，避免多余的父元素，html尽量简化
```

# 3.CSS编码规范

（1）代码规范

- [styleguide 2.3k](https://link.juejin.cn/?target=https%3A%2F%2Fgithub.com%2Ffex-team%2Fstyleguide%2Fblob%2Fmaster%2Fcss.md)
- [spec 3.9k](https://link.juejin.cn/?target=https%3A%2F%2Fgithub.com%2Fecomfe%2Fspec%2Fblob%2Fmaster%2Fcss-style-guide.md)

```
规则1：代码缩进，4个空格缩进，不能使用tab字符
规则1：css文件的引用总是放在head区
规则4：css加限定。针对多级class时，避免直接使用class,要带层级的访问。
规则8：属性值前用空格分开，选择器后用空格分开
规则9：不同css规则之间用空行隔开
规则13：选择器。当一个 rule 包含多个 selector 时，每个选择器声明必须独占一行。
规则15：属性书写顺序。以Formatting Model（布局方式、位置） > Box Model（尺寸） > Typographic（文本相关） > Visual（视觉效果） 的顺序书写，以提高代码的可读性。 • Formatting Model 相关属性包括：position / top / right / bottom / left / float / display / overflow 等 • Box Model 相关属性包括：border / margin / padding / width / height 等 • Typographic 相关属性包括：font / line-height / text-align / word-wrap 等 • Visual 相关属性包括：background / color / transition / list-style 等
```

其中LESS编码规则:

```
规则2：@import 语句。.less 后缀不得省略。@import "mixins/size.less";
规则4：避免嵌套层级过多。嵌套深度限制在2级
```

# 4.eslint编码

**(1)js代码规范**

- [airbnb-中文版](https://link.juejin.cn/?target=https%3A%2F%2Fgithub.com%2Flin-123%2Fjavascript)，更为主流
- [standard (24.5k star) 中文版](https://link.juejin.cn/?target=https%3A%2F%2Fgithub.com%2Fstandard%2Fstandard%2Fblob%2Fmaster%2Fdocs%2FREADME-zhcn.md)
- [百度前端编码规范 3.9k](https://link.juejin.cn/?target=https%3A%2F%2Fgithub.com%2Fecomfe%2Fspec)

**(2)eslint-config-airbnb规则**

eslint-config-airbnb规则， airbnb官方的规则过于庞大，有10多个规则文件。维护起来成本较高。

大型团队和小团队（或独立开发者）的差异性：

技术层面上：

- **技术场景更加广泛：**对于大型团队，其开发场景一般不会局限在传统 Web 领域内，往往还会涉及 Node.js、React Native、小程序、桌面应用（例如 Electron）等更广泛的技术场景。
- **技术选型更加分散：**团队内工程技术选型往往并不统一，如 React/Vue、JavaScript/TypeScript 等。
- **工程数量的增加和工程方案离散化导致 ESLint 方案的复杂度提升：**这样会进一步增加工程接入成本、升级成本和方案维护成本。

在团队层面，随着人员的增加和组织结构的复杂化：

- 人员风格差异性更大、沟通协调成本更高。
- 方案宣导更难触达，难以保证规范执行的落实。
- 执行状况和效果难以统计和分析。

因为存在诸多差异，我们在设计具体方案时，需要考虑和解决更多问题，以保证规范的落实。针对上述分析，我们梳理了以下需要解决的问题：

- 如何制定统一的代码规范和对应的 ESLint 配置？
  - **场景支撑：**如何实现对场景差异的支持？如何保证不同场景间一致部分（例如 JavaScript 基础语法）的规范一致性？
  - **技术选型支撑：**如何在支撑不同技术选型的前提下，保证基础规则（例如缩进）的一致性？
  - **可维护性：**具体到规则配置上，能否提升可复用性？在方案升级迭代时成本是否可控？

该配置架构采用了分层、分类的结构，其中：

- **基础层：**制定统一的基础语法和格式规范，提供通用的代码风格和语法规则配置，例如缩进、尾逗号等等。
- **框架支撑层（可选）：**提供对通用的一些技术场景、框架的支持，包括 Node.js、React、Vue、React Native 等；这一层借助开源社区的各种插件进行配置，并对各种框架的规则都进行了一定的调整。
- **TypeScript 层（可选）：**这一层借助 typescript-eslint，提供对 TypeScript 的支持。
- **适配层（可选）：**提供对特殊场景的定制化支持，例如 MRN（美团内部的 React Native 定制化方案）、配合 prettier 使用、或者某些团队的特殊规则诉求。

具体的实际项目中，可以灵活的选择各层级、各类型的搭配，获得和项目匹配的 ESLint 规则集。例如，对于使用 TypeScript 语言的 React 项目，可以将基础层、框架层的 React 分支、以及 TypeScript 支撑层的 React 分支层叠到一起，最终形成适用于该项目的 ESLint 配置。如果项目不再使用 TypeScript 语言，只需要将 ts-react 这一层去掉即可。

最终，形成了如下所示的 ESLint 配置集：

![image-20211130234536293](C:\Users\fuyunjinglong\AppData\Roaming\Typora\typora-user-images\image-20211130234536293.png)

# 5.ES6编码规范

```
规则1 导出默认的函数使用驼峰式命名
规则2 导出单例、函数库、空对象时使用帕斯卡式命名即所有首字母大写
规则5 变量必须显式声明作用域，尽量使用const,let，慎用var
规则9 使用对象属性值的简写.ES6 允许在对象之中，只写属性名，不写属性值。这时，属性值等于属性名所代表的变量。const obj = {    lukeSkywalker,};
规则13 不要使用 arguments。可以选择 rest 语法 ... 替代.// 不推荐function concatenateAll() {    const args = Array.prototype.slice.call(arguments);    return args.join('');  }// 推荐function concatenateAll(...args) {    return args.join('');}
规则14 直接给函数的形参数指定默认值
规则16 使用大括号包裹所有的多行代码块
规则18 代码中总是使用ES6标准的模块(import/export)方式， 而不是使用非标准的模块化加载器commonjs。
规则19 不要使用通配符 * 的 import。确保被import的模块只有一个默认的export项。
规则24 如果一个函数适合用一行写出并且只有一个参数，那就把花括号、圆括号和 return 都省略掉。
规则27 使用解构存取和使用多属性对象或数组
规则31 构建字符串时，使用字符串模板而不是字符串连接
```

# 6.vue编码规范

```
prop定义尽量详细，如require,default等
v-for设置键值避免 v-if 和 v-for 同时使用
为组件样式设置作用域基础组件名，使用Base
和父组件紧密耦合的子组件应该以父组件名作为前缀命名
```

