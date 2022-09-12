---
title: F_Hexo博客搭建
date: 2021-11-06 06:33:16
categories:
- F_新技术
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

# hexo常用语法

```
1.代码段
{% codeblock %}
{% endcodeblock %}

2.图片
{% img /img/20200302_1_9.png  "imgPIC'alt text'" %}

3.加粗
**加粗**

4.链接
{% link 深入理解分布式事务 http://wwwe/distributed-transaction.html [external] [title] %}

5.点点
- 风格1
- 风格2

6.换行符
末尾两个空格表示换行

7.本地图片使用服务器绝对路径
/img/
/img/

8.竖线段落
使用>回车即可
```