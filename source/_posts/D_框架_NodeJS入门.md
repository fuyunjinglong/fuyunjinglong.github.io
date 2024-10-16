---
title: NodeJS入门
date: 2022-04-03 06:33:16
categories:
- D_框架和类库
toc: true # 是否启用内容索引
---

# 大纲

**10套教程**

- [Node基础-尚硅谷-video](https://www.bilibili.com/video/BV1gM411W7ex/?spm_id_from=333.337.search-card.all.click&vd_source=bd4c7d99d71adf64d6e88c65370e0247)/[千峰前端Node.JS基础](https://www.bilibili.com/video/BV1rA4y1Z7fd/?spm_id_from=333.337.search-card.all.click&vd_source=bd4c7d99d71adf64d6e88c65370e0247)
- Node.js+Express+Koa2 开发Web Server博客-video-慕课网mk
- Vue Element＋Node.js开发企业通用管理后台系统-video-mk
- Node.js-Koa2框架生态实战－从零模拟新浪微博-video-mk
- Node.js+Koa2+MySQL 打造前后端分离精品项目《旧岛》-小程序服务端-video-mk
- 中级-Vue3 + TS仿知乎专栏企业级项目-mk
- 高级-Vue3.0+TS打造企业级组件库-mk
- Vue核心技术（Vue+Vue-Router+Vuex+SSR）实战精讲-mk

# 初始化项目

```
npm init -y
```

# package版本(^和~)区别

```
~1.15.2 :=  >=1.15.2 <1.16.0     

^3.3.4 := >=3.3.4 <4.0.0
```

# Node入门

## NodeJS是什么

Node.js 是一个开源与跨平台的 JavaScript 运行时环境
在浏览器外运行 V8 JavaScript 引擎(Google Chrome 的内核)，利用事件驱动、非阻塞和异步输入输出模型等技术提高性能
可以理解为 Node.js 就是一个服务器端的、非阻塞式I/O的、事件驱动的JavaScript运行环境

> 非阻塞异步
>
> Nodejs采用了非阻塞型I/O机制，在做I/O操作的时候不会造成任何的阻塞，当完成之后，以时间的形式通知执行操作
> 例如在执行了访问数据库的代码之后，将立即转而执行其后面的代码，把数据库返回结果的处理代码放在回调函数中，从而提高了程序的执行效率

> 事件驱动
>
> 事件驱动就是当进来一个新的请求的时，请求将会被压入一个事件队列中，然后通过一个循环来检测队列中的事件状态变化，如果检测到有状态变化的事件，那么就执行该事件对应的处理代码，一般都是回调函数

## 应用场景

场景如下：善于I/O，不善于计算。因为Nodejs是一个单线程，如果计算(同步)太多，则会阻塞这个线程。大量并发的I/O，应用程序内部并不需要进行非常复杂的处理。与 websocket 配合，开发长连接的实时交互应用程序。

- 用户表单收集系统、后台管理系统、实时交互系统、考试系统、联网软件、高并发量的web应用程序
- 基于web、canvas等多人联网游戏
- 基于web的多人实时聊天客户端、聊天室、图文直播
- 单页面浏览器应用程序
- 操作数据库、为前端和移动端提供基于json的API

# windows环境安装

## 下载nodejs

官网下载https://nodejs.org/en/

## 安装及配置

最好安装到非系统盘，依赖后续会越来越大。

检查第一步安装是否成功

```
node -v
npm -v
都需要出现版本号
```

1.配置node全局引用和缓存

在node安装目录下创建node_global和node_cache文件夹

```
npm config set prefix D:\programFiles\node\node_global
npm config set cache D:\programFiles\node\node_cache
```

测试下配置是否生效

```
npm install -g vue
```

成功后在node_global和node_cache中出现对应vue文件

2.配置全局模块环境变量

先检查是否正确配置：

```
输入node进入交互界面，然后输入require('vue')
查看是否出现vue相关的指令或生命周期，出现则环境变量正确，否则需要配置环境变量
```

我的电脑-高级属性-环境变量下：

先配置用户变量，将原有的AppData\Roaming\npm修改为D:\programFiles\node\node_global

再配置系统变量，新建NODE_PATH,值为D:\programFiles\node\node_global\node_modules。接着在path中添加%NODE_PATH%

最后使用require('vue')检查是否最终安装成功

cnpm install -g @vue/cli全局安装

vue -V查看vuecli版本

vue init是vuecli2的初始化方式

vue create 是vuecli3的初始化方式

## 安装常见镜像

**npm清空缓存**

```
npm cache clean --force
```

**npm淘宝镜像**

```
npm config set registry https://registry.npmmirror.com，切换国内镜像，使用淘宝镜像

npm config get registry，查看当前镜像使用的地址，返回成功，则代表设置成功
```

**cnpm淘宝镜像**

```
npm install -g cnpm --registry=https://registry.npmmirror.com，安装cnpm

cnpm install xxx，使用cnpm安装所想要的包
```

cnpm安装依赖包的方式和npm是一样，只是npm的命令变成cnpm

以上两种模式的对比，cnpm在安装某些包的时候，package环境不是很正确，所以推荐使用npm安装淘宝镜像即可

## 卸载nodejs重装

1.卸载程序卸载nodejs应用程序

2.删除以下文件夹下npm文件

C:\Program Files (x86)\Nodejs
C:\Program Files\Nodejs
C:\Users\{User}\AppData\Roaming\npm（或%appdata%\npm）
C:\Users\{User}\AppData\Roaming\npm-cache（或%appdata%\npm-cache）

3.检查您的%PATH%环境变量以确保没有引用Nodejs或npm存在。

4.重启

## 常见问题

**1.安装依赖报错npm EPERM mkdir**

使用cmd，管理员权限打开对话窗口

**2.出现unable to verify the first certificate**

npm config set strict-ssl false

**3.Error: EPERM: operation not permitted, mkdir...**

文件夹邮件，添加用户操作权限

<img src="/img/image-20220904121713944.png" alt="image-20220904121713944" style="zoom:67%;" />

## yarn安装

```
npm install -g yarn --registry=https://registry.npm.taobao.org
yarn config get registry // 查看淘宝源是否正确
```

修改 yarn的全局安装位置和缓存位置

```
yarn config set global-folder "D:\nvm\nvm\yarn\global"
yarn config set cache-folder "D:\nvm\nvm\yarn\cache"
```

查看版本

```
yarn -v
```

yarn 常用命令

```
npm init === yarn init
npm install === yarn 或者 yarn install
npm install taco --save === yarn add taco
npm uninstall taco --save === yarn remove taco
npm install taco --save-dev === yarn add taco --dev
npm update --save === yarn upgrade
npm install taco@latest --save === yarn add taco
npm install taco --global === yarn global add taco
npm init --yes/-y === yarn init --yes/-y
npm link === yarn link
npm outdated === yarn outdated
npm publish === yarn publish
npm run === yarn run
npm cache clean === yarn cache clean
npm login === yarn login
npm test === yarn test
```

```
初始化项目:
yarn init // 同npm init，执行输入信息后，会生成package.json文件

yarn的配置项：
yarn config list // 显示所有配置项
yarn config get <key> //显示某配置项
yarn config delete <key> //删除某配置项
yarn config set <key> <value> [-g|--global] //设置配置项

安装包：
yarn install //安装package.json里所有包，并将包及它的所有依赖项保存进yarn.lock
yarn install --flat //安装一个包的单一版本
yarn install --force //强制重新下载所有包
yarn install --production //只安装dependencies里的包
yarn install --no-lockfile //不读取或生成yarn.lock
yarn install --pure-lockfile //不生成yarn.lock

添加包（会更新package.json和yarn.lock）：
yarn add [package] // 在当前的项目中添加一个依赖包，会自动更新到package.json和yarn.lock文件中
yarn add [package]@[version] // 安装指定版本，这里指的是主要版本，如果需要精确到小版本，使用-E参数
yarn add [package]@[tag] // 安装某个tag（比如beta,next或者latest）

//不指定依赖类型默认安装到dependencies里，你也可以指定依赖类型：
yarn add --dev/-D // 加到 devDependencies
yarn add --peer/-P // 加到 peerDependencies
yarn add --optional/-O // 加到 optionalDependencies

//默认安装包的主要版本里的最新版本，下面两个命令可以指定版本：
yarn add --exact/-E // 安装包的精确版本。例如yarn add foo@1.2.3会接受1.9.1版，但是yarn add foo@1.2.3 --exact只会接受1.2.3版
yarn add --tilde/-T // 安装包的次要版本里的最新版。例如yarn add foo@1.2.3 --tilde会接受1.2.9，但不接受1.3.0

发布包
yarn publish

移除一个包
yarn remove <packageName>：移除一个包，会自动更新package.json和yarn.lock

更新一个依赖
yarn upgrade 用于更新包到基于规范范围的最新版本

运行脚本
yarn run 用来执行在 package.json 中 scripts 属性下定义的脚本

显示某个包的信息
yarn info <packageName> 可以用来查看某个模块的最新版本信息
```

**两者比较**

1. 并行安装：无论 npm 还是 Yarn 在执行包的安装时，都会执行一系列任务。npm 是按照队列执行每个 package，也就是说必须要等到当前 package 安装完成之后，才能继续后面的安装。而 Yarn 是同步执行所有任务，提高了性能。
2. 离线模式：如果之前已经安装过一个软件包，用Yarn再次安装时之间从缓存中获取，就不用像npm那样再从网络下载了。

- 安装**版本统一**：为了防止拉取到不同的版本，Yarn 有一个锁定文件 (lock file) 记录了被确切安装上的模块的版本号。每次只要新增了一个模块，Yarn 就会创建（或更新）yarn.lock 这个文件。这么做就保证了，每一次拉取同一个项目依赖时，使用的都是一样的模块版本。npm 其实也有办法实现处处使用相同版本的 packages，但需要开发者执行 npm shrinkwrap 命令。这个命令将会生成一个锁定文件，在执行 npm install 的时候，该锁定文件会先被读取，和 Yarn 读取 yarn.lock 文件一个道理。npm 和 Yarn 两者的不同之处在于，Yarn 默认会生成这样的锁定文件，而 npm 要通过 shrinkwrap 命令生成 npm-shrinkwrap.json 文件，只有当这个文件存在的时候，packages 版本信息才会被记录和更新。
- **更简洁的输出**：npm 的输出信息比较冗长。在执行 npm install 的时候，命令行里会不断地打印出所有被安装上的依赖。相比之下，Yarn 简洁太多：默认情况下，结合了 emoji直观且直接地打印出必要的信息，也提供了一些命令供开发者查询额外的安装信息。
- **多注册来源处理：**所有的依赖包，不管他被不同的库间接关联引用多少次，安装这个包时，只会从一个注册来源去装，要么是 npm 要么是 bower, 防止出现混乱不一致。
- **更好的语义化**： yarn改变了一些npm命令的名称，比如 yarn add/remove，感觉上比 npm 原本的 install/uninstall 要更清晰。

## pnpm安装

全局安装

```
npm install pnpm -g
```

设置淘宝源

```
//查看源
pnpm config get registry 
//切换淘宝源
pnpm config set registry http://registry.npm.taobao.org 
```

查看

```
pnpm -v
```

# linux环境安装

## 1.安装nodejs环境

```
1.卸载npm和node  
npm uninstall npm -g  
yum remove nodejs npm -y  
看看是否有残留  
 进入 /usr/local/lib 删除所有 node 和 node_modules文件夹  
进入 /usr/local/include 删除所有 node 和 node_modules 文件夹  
进入 /usr/local/bin 删除 node 的可执行文件,这里删除所有软连接rm- rf ./node  
2.到nodejs官网下载并解压  
wget https://nodejs.org/dist/v10.16.0/node-v10.16.0-linux-x64.tar.xz  
tar -xvf node-v10.16.0-linux-x64.tar.xz  
3.重命名文件夹，将软连接变为全局
ln -snf /newen/programfiles/node-v10.16.0-linux-x64/bin/npm /usr/local/bin/  
ln -snf /newen/programfiles/node-v10.16.0-linux-x64/bin/node /usr/local/bin/  
4.查看nodejs是否安装成功
node -v
v10.16.0
```

