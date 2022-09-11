---
title: C_Github入门
date: 2022-09-06 07:33:16
categories:
- C_框架及工具
toc: true # 是否启用内容索引
---

# 仓库关系

![image-20211107141510723](/img/image-20211107141510723.png)

- 工作区：用来编辑保存项目文件的地方，也是用户能直接操作到的地方。
- 暂存区：保存了下次将提交的文件列表信息，一般在 Git 仓库目录中，是一个叫index的文件，通常多数说法还是叫暂存区域；
- 版本库：也叫本地版本库，之所以说git 快，是因为它是分布式版本控制系统，大部分提交都是对本地仓库而言的，不依赖网络，最后一次会推送的到远程仓库。

# 常用命令

## git常用命令

```
git init // 初始化
git add . // 提交代表到本地仓
git commit -m 'hello' // 提交代表到本地仓
git branch -M main // 重命名分支
git remote add origin git@github.com:fuyunjinglong/fuyunjinglong.github.io.git // 建立远程仓库链接
git pull origin master // 拉取代码
git push -u origin master // 推送代码
```



## git 拉取并创建新分支

git branch newBranch 9a891305807db590af4c63e809b5fef600d922ce
git checkout newBranch

## reset还是revert?

reset:版本回退会删除之后的所有提交的记录。

```text
42eae13 (HEAD -> master) 第四次修改
97ea0f9 第三次修改
e50b7c2 第二次修改
3a52650 第一次修改

执行 
git reset --hard 97ea0f9，
执行后变为
97ea0f9 (HEAD -> master) 第三次修改
e50b7c2 第二次修改
3a52650 第一次修改
```

revert:会保留之后的所有提交，只删除当前的修改

```text
执行
git revert -n 97ea0f9
git commit -m "恢复第三次修改"
执行后变为
33b8b30 (HEAD -> master) Revert "恢复第三次修改"
42eae13 第四次修改
97ea0f9 第三次修改
e50b7c2 第二次修改
3a52650 第一次修改
```

在确认要回滚的版本之后，如果别人没有最新提交，那么就可以直接用reset命令进行版本回退。

否则，就可以考虑使用revert命令进行还原修改，不能影响到别人的提交。

## 本地仓库临时保存

如果你在开发着业务，突然另一个分支有一个bug要改，你怎么办

```cpp
git stash       //将本次修改存到暂存区（紧急切换分支时）
git stash pop   //将所有暂存区的内容取出来
```

# Github仓库使用

## 建立github远程仓库和本地仓库连接

**创建远程仓库及SSH秘钥**

- **创建个人仓库**

**注意：**仓库名称必须为`<username>.github.io`，其中`username`是GitHub的用户名即图中`Owner`所对应的。

- **初始化git**

进入到博客文件夹运行`git init`

```
$ git config --global user.name fuyunjinglong
$ git config --global user.email 806435328@qq.com

# 可以用以下两条命令检查是否输入正确
$ git config  –global user.name
$ git config  –global user.email
```

- **配置SSH密钥**

创建SSH密钥，输入如下命令，根据提示输入三次回车（`email`为GitHub邮箱）：

```
ssh-keygen -t rsa -C <email>
```

完成后会生成一幅圈圈星星图，这个时候就已经生成了`.ssh`的文件夹，文件一般位于用户文件夹下，即`C:\Users\<Administrator>\.ssh`，其中`<Administrator>`为Windows用户名。文件夹内容如下：

- `id_rsa`，私钥。
- `id_rsa.pub`，公钥。
- `known_hosts`，顾名思义，此文件保存着**`其他主机远程登陆本机`**的信息。

先将公钥文件`id_rsa.pub`以记事本方式打开，复制全部信息到剪切板。

然后在GitHub**主页的设置Settings**（**不是仓库的设置**）中，页面左侧找到`SSH and GPG keys`的设置选项，点击右上角`New SSH key`，把复制的`id_rsa.pub`内容粘贴到`Key`中，写个标题，点击`Add SSH key`即可。

回到命令行输入如下命令，查看是否成功：

```
$ ssh -T git@github.com
# 最后一行输出如下信息即为成功
# Hi hwame! You've successfully authenticated...
```

# GitHub Pages免费站点

### 创建站点

[官方说明](https://docs.github.com/cn/pages/getting-started-with-github-pages/creating-a-github-pages-site)

### 配置发布源

在对应fuyunjinglong.github.io仓库里，打开setting->pages->branch，指定分支和目录层级。

保存后，访问https://fuyunjinglong.github.io/即可访问该仓库的指定分支的指定目录层级的index.html