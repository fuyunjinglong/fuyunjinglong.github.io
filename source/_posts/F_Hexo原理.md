---
title: F_hexo原理20220503
date: 2022-05-03 06:33:16
categories:
- F_新技术
toc: true # 是否启用内容索引
---

# 1.介绍

Hexo 是一个快速、简洁且高效的博客框架。Hexo 使用 Markdown（或其他渲染引擎）解析文章。

```
├── node_modules：             #依赖包-安装插件及所需nodejs模块。
├── public          #最终网页信息。即存放被解析markdown、html文件。
├── scaffolds         #模板文件夹。即当您新建文章时，根据 scaffold生成文件。
├── source          #资源文件夹。即存放用户资源。
|   └── _posts         #博客文章目录。
└── themes             #存放主题。Hexo根据主题生成静态页面。
├── _config.yml       #网站的配置信息。标题、网站名称等。
├── db.json：        #source解析所得到的缓存文件。
├── package.json      # 应用程序信息。即配置Hexo运行需要js包。
```

主题内的结构

```
├── LICENSE
├── README.en.md       // READEME 英文版
├── README.md          // READEME 中文文件
├── _config.yml        // 主题配置文件
├── bower.json
├── gulpfile.coffee
├── languages         // 多语言配置文件
├── layout            // 模板文件
├── package.json      // 项目的依赖文件
├── scripts           // 主题的脚本文件
├── source            // 主题的资源文件 CSS IMG
└── test
```

# 2.Hexo命令总览

- hexo-cli
- hexo core
- hexo plugins

<img src="/img/image-20220503153102827.png" alt="image-20220503153102827" style="zoom:67%;" />

**hexo-cli**作用：

- 启动hexo命令进程和参数解析机制
- 实现hexo命令的三个初始参数：init/version/plugins
- 加载hexo核心模块，并初始化

**hexo core**作用：

- 实现hexo的new、generate、publish等功能

**hexo plugins**扩展hexo的插件

- 扩展hexo命令的参数，如`hexo-server`
- 扩展hexo解析文件的”能力”，如增加jade模版解析功能的hexo-render-jade插件

# 3.Hexo的模板引擎

模板引擎的作用，就是将界面与数据分离。最简单的原理是将模板内容中指定的地方替换成数据，实现业务代码与逻辑代码分离。

我们就可以将source文件夹理解为数据库，而主题文件夹相当于界面。

Hexo 的模板引擎是默认使用 ejs 编写的。hexo首先会解析 md 文件，然后根据 layout 判断布局类型，再调用其他的文件，这样每一块的内容都是独立的，提高代码的复用性。最终会生成一个 html 页面。

`layout` 文件文档结构如下：

```
├── _custom                           // 通用布局
├── _layout.swig                      // 默认布局布局
├── _macro                            // 插件模板
├── _partials                         // 局部布局
├── _scripts                          // script模板
├── _third-party                      // 第三方插件模板
├── archive.swig                      // 归档模板
├── category.swig                     // 分类模板
├── index.swig                        // 首页模板
├── page.swig                         // 其他模板
├── photo.swig                        // 照片模板（自定义）
├── post.swig                         // 文章模板
├── schedule.swig                     // 归档模板
└── tag.swig                          // 标签模板
```



# 4.从markdown到html的旅程

hexo中，从markdown到html的generate过程中做了两件事：模板渲染和模板渲染。

<img src="/img/image-20220503154055374.png" alt="image-20220503154055374" style="zoom:67%;" />

第一次渲染:主要目的就是给这个对象添加title,content等属性

第二次渲染:需要引入对应模板文件格式的插件，如.ejs文件就需要使用hexo-render-ejs插件，.jade文件需要使用hexo-render-jade插件，而.sass文件则需要hexo-render-sass插件来转换成css文件。hexo的这一设计有点类似webpack中的loader。

# 5.Hexo 每次部署的流程

1. hexo g：生成静态文件。将我们的数据和界面相结合生成静态文件的过程。会遍历主题文件中的 `source` 文件夹（js、css、img 等静态资源），然后建立索引，然后根据索引生成 `pubild` 文件夹中，此时的 `publid` 文件是由 html、 js、css、img 建立的纯静态文件可以通过 `index.html` 作为入口访问你的博客。
2. hexo d：部署文件。部署主要是根据在 `_config.yml` 中配置的 `git` 仓库或者 `coding` 的地址，将 `public` 文件上传至 github 或者 coding 中。然后再根据上面的 github 提供的 pages 服务呈现出页面。当然你也可以直接将你生成的 `public` 文件上传至你自己的服务器上。

