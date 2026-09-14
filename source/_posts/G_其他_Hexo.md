---
title: Hexo
date: 2020-01-01 06:33:16
categories:
- G_其他
toc: true # 是否启用内容索引
---
# 认识Hexo

Hexo 使用 Node.js 编写。得益于 Node.js，使得 Hexo 生成上百个页面游刃有余。

只需要一条指令就可以部署到 GitHub Pages、Heroku、Coding Pages 等其他网站。

# 准备工作

## 安装Node.js

见本博客相关文档

## 安装Git

yum install -y git

## 安装Nginx

- 在线下载解压

  ```
  wget http://nginx.org/download/nginx-1.5.9.tar.gz
  tar -zxvf nginx-1.5.9.tar.gz
  ```

- 安装

  ```
  ./configure
  make
  make install
  ```

- 配置

  ```
  /usr/local/nginx/conf目录下的nginx.conf文件
  upstream  myserver{        #定义upstream名字，下面会引用
          server 120.79.33.76:5000 weight=3;        #指定后端服务器地址
          server 123.206.218.36:5000 weight=2;
      }
  
  server {
          listen       80;
          server_name  anandasuper.top;
  
          location / {
              root   html;
              index  index.html index.htm;
        proxy_pass http://myserver; 
          }
  }
  ```

- 启动

  ```
  ./sbin/nginx 初次启动
  ./sbin/nginx -s reload 重启
  ./sbin/nginx -s stop 停止
  ```



# 安装Hexo

- 1.全局安装依赖

  ```
  npm install hexo-cli -g
  ```

- 配置hexo软连接到全局

  ```
  ln -snf /newen/programfiles/node-v10.16.0-linux-x64/lib/node_modules/hexo-cli/bin/hexo   /usr/local/bin/hexo
  ```

- 初始化工程目录

  ```
  mkdir hexo2022
  cd hexo2022
  hexo init
  ```

# 配置Hexo

## 下载主题

- 1.将主题git到themes目录下

  ```
  git clone https://github.com/cofess/hexo-theme-pure.git themes/pure
  ```
  
- 2.修改博客根目录的config配置，theme更改为pure

- 3.如果使用后台启动，建议使用js脚本;如果调试的话，hexo s即可。在博客根目录下面创建一个hexo_run.js

  ```
  //run
  const { exec } = require('child_process')
  exec('hexo server -p 5001',(error, stdout, stderr) => {
          if(error){
                  console.log('exec error: ${error}')
                  return
          }
          console.log('stdout: ${stdout}');
          console.log('stderr: ${stderr}');
  })
  ```

- 4.安装依赖

  ```
  npm i
  ```

## PM2进程管理

 PM2 是一个带有负载均衡功能的 Node 应用的进程管理器。我们都知道nodejs是单进程执行的，当程序出现错误死掉之后需要能够自动，这时候就需要PM2了。

- 安装pm2

  ```
  npm install -g pm2
  ```

- 配置软连接到全局

  ```
  ln -snf /newen/programfiles/node-v10.16.0-linux-x64/lib/node_modules/pm2/bin/pm2     /usr/local/bin/
  ```

- 启动进程

  ```
  pm2 start hexo_run.js
  ```

**常用命令**

查看所有任务

```
pm2 list
```

停止所有任务

```
pm2 stop all或pm2 delete all
```

停止某个任务

```
pm2 stop 1 
```

# 部署Github Page

## **创建远程仓库连接**

详情见Github入门的ssh秘钥

## **引入deployer插件**

要将hexo生成的文章部署到GitHub上，首先要编辑**站点配置文件**，将hexo和GitHub关联起来，其中`username`为GitHub用户名。
在博客文件夹里，修改**站点配置文件**`_config.yml`，在文件最后加上（已有则修改）：

```
deploy:
  type: git # 提交类型git
  repo: git@github.com:fuyunjinglong/fuyunjinglong.github.io.git # 提交仓库地址
  branch: hexoPage # 分支GitHub的默认分支是main Gitee的分支是master 可以填branch让hexo默认提交
  message: '初始化博客' # 提交信息
```

**注意：**需要先安装Git部署插件，才能用命令部署到GitHub，输入以下命令安装`hexo-deployer-git`插件。

```
$ npm install hexo-deployer-git --save
```

```
$ hexo clean    #清除缓存和已生成的静态文件
$ hexo generate #等于hexo g
$ hexo deploy   #等于hexo d

# 可将上述命令合并为“一键三连”
package.json配置
"deployGithub": "hexo clean && hexo g && hexo d"
一键部署github page
npm run deployGithub
```

## github博客仓库设置

**博客仓库-settings-Pages,选择对应分支和访问目录**

<img src="/img/image-20220912120301069.png" alt="image-20220912120301069" style="zoom:67%;" />

浏览器中访问**`https://<username>.github.io`**即可看到你的博客了！！





# Hexo命令

## 创建分类

```
hexo new page categories自动生成目录结构
```

categories/index.md 设置分类

```
---
title: 分类
date: 2019-09-04 07:13:04
layout: categories
type: categories
---
```

## 清理缓存

```
hexo clean
```

## 重启服务

```
hexo s -p 5001或者
pm2 stop all和pm2 start hexo_run.js
```

## `hexo server`

```
hexo s -p 端口号,也可不加端口
```

## `hexo generate`

这个命令是生成网站静态文件的时候用的，生成后网页将会放在根目录下面的 `public` 文件夹里。

## `hexo deploy`

这个命令用来部署网站，使用此命令将会把生成好的页面（即 `public` 文件夹里的内容）部署到指定的地方上。

# hexo常见问题

**基本**

```
0.目录结构
    可展示的大纲目录采用：
    一级标题
    二级标题
    ...
    不需要展示的大纲目录采用：
    一、加粗
    1.加粗
    1.1不加粗

1.代码段
{% codeblock %}
{% endcodeblock %}
2.图片
<img src="/img/2026-01-18_18-09-01.png" style="zoom:50%;" />
或
C:\Users\fuyunjinglong\AppData\Roaming\Typora\typora-user-images\
/img/
3.加粗
**加粗**
4.链接
{% link 深入理解分布式事务 http://wwwe/distributed-transaction.html [external] [title] %}
5.点点li
- 风格1
- 风格2
```

**高级**

```
1.页面内跳转
i.跳转到任意位置
[跳转到指定锚点上面](#锚点)
<a name="锚点"> </a>

ii.跳转到标题位置
[跳转到标题](#任意标题名)

2.页面外跳转
内部跳转页面
{% post_link E_数据结构_0基础 可点击%}
内部跳转页面锚点
<a target="_blank" href="{% post_path 'E_数据结构_0基础' %}#LRU-K">LRU-K</a>

3.取消文章目录的自动编号
./node_modules/hexo/lib/plugins/helper/toc.js
list_number: false

4.页面外跳转定位锚点过慢
删除av-min.js无效cdn
```

**魔改**

> 1.取消右侧目录下的序号
>
> ./node_modules/hexo/lib/plugins/helper/toc.js
>
> list_number: true  // 自行修改，true/false

# Hexo原理

## 介绍

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

## Hexo命令总览

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

## Hexo的模板引擎

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



## 从markdown到html的旅程

hexo中，从markdown到html的generate过程中做了两件事：模板渲染和模板渲染。

<img src="/img/image-20220503154055374.png" alt="image-20220503154055374" style="zoom:67%;" />

第一次渲染:主要目的就是给这个对象添加title,content等属性

第二次渲染:需要引入对应模板文件格式的插件，如.ejs文件就需要使用hexo-render-ejs插件，.jade文件需要使用hexo-render-jade插件，而.sass文件则需要hexo-render-sass插件来转换成css文件。hexo的这一设计有点类似webpack中的loader。

## Hexo 每次部署的流程

1. hexo g：生成静态文件。将我们的数据和界面相结合生成静态文件的过程。会遍历主题文件中的 `source` 文件夹（js、css、img 等静态资源），然后建立索引，然后根据索引生成 `pubild` 文件夹中，此时的 `publid` 文件是由 html、 js、css、img 建立的纯静态文件可以通过 `index.html` 作为入口访问你的博客。
2. hexo d：部署文件。部署主要是根据在 `_config.yml` 中配置的 `git` 仓库或者 `coding` 的地址，将 `public` 文件上传至 github 或者 coding 中。然后再根据上面的 github 提供的 pages 服务呈现出页面。当然你也可以直接将你生成的 `public` 文件上传至你自己的服务器上。

