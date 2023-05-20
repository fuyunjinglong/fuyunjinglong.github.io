---
title: Github入门
date: 2022-09-06 07:33:16
categories:
- D_框架和类库
toc: true # 是否启用内容索引
---

[Git入门教程](https://www.w3cschool.cn/git/git-tutorial.html)

[Github入门教程](https://www.w3cschool.cn/githubcn/)

# 仓库关系

![image-20211107141510723](/img/image-20211107141510723.png)

- 工作区：用来编辑保存项目文件的地方，也是用户能直接操作到的地方。
- 暂存区：保存了下次将提交的文件列表信息，一般在 Git 仓库目录中，是一个叫index的文件，通常多数说法还是叫暂存区域；
- 版本库：也叫本地版本库，之所以说git 快，是因为它是分布式版本控制系统，大部分提交都是对本地仓库而言的，不依赖网络，最后一次会推送的到远程仓库。

# 主流开发流程

## 代码分支

Gitflow工作流(Gitflow Workflow)是2010年由Vincent Driessen在他的一篇[博客](https://nvie.com/posts/a-successful-git-branching-model)里提出来的。它定义了一整套完善的基于Git分支模型的框架，结合了版本发布的研发流程，适合管理具有固定发布周期的大型项目。

- **master** 生产主分支,发布到生产环境使用这个分支,由hotfix或者release分支合并过来，不直接提交代码。
- **develop** 主开发分支 , 基于master分支克隆，由feature分支合并过来，一般不直接提交代码。
- **feature** 功能开发分支 , 基于develop分支克隆 , 主要用于新需求新功能的开发，同时存在多个。
- **release** 预发布分支 , 基于feature分支合并到develop之后 , 从develop分支克隆，测试完成后合并到master并打上版本号，同时也合并到develop。
- **hotfix** 补丁分支 , 基于master分支克隆 , 主要用于对线上的版本进行BUG修复,完成后合并到master分支和develop分支。

> --no-ff 在这的作用是**禁止快进式合并**

**develop分支管理**

```
// 从master分支上创建develop分支，并推送到远端
git checkout –b develop
git push -u origin develop
```

**feaeure分支管理**

```
# feaeure分支基于develop创建
git checkout -b some-feature develop
# 或者, 推送至远程服务器:
git push -u origin some-feature    

# 一波骚操作   
git status
git add .
git commit  -m 'xx'  
git push

# 切换develop分支
git checkout develop 
git pull origin develop

# 合并到develop分支并push
git merge --no-ff some-feature
git push origin develop

# 删除feature分支(也可以不删除)
git branch -d some-feature
git push origin --delete some-feature  
```

**Release分支管理**

```
# Release分支基于develop创建
git checkout -b some-release develop
# ...一波骚操作
# 代码发布后合并到master分支并提交
git checkout master
git merge --no-ff some-release
git tag -a 0.1

# 合并到develop分支并提交
git checkout 
git merge --no-ff some-release

# 删除release分支
git branch -d some-release
git push origin --delete some-release  
```

**Hotfix分支管理**

```
# Hotfix分支基于master创建
git checkout -b hotfix-0.1.1 master  
# ...一波骚操作
# 合并到master分支并提交
git checkout master
git merge --no-ff hotfix-0.1.1
git tag -a 0.1.1

# 合并到develop分支并提交
git checkout develop
git merge --no-ff hotfix-0.1.1

# 删除hotfix分支
git branch -d hotfix-0.1
git push origin --delete  hotfix-0.1.1
```

## 代码合并-基操

假设有：

- alias-主分支
- alias-zhangsan-某个组员分支

**建立新组员分支**

> 建立新分支alias-zhangsan，git checkout -b alias-zhangsan

**分支合并拉取**

> alias-zhangsan先上传代码：
>
> git add .
>
> git commit -m 'xx'
>
> git push
>
> git checkout alias
>
> alias合并分支:
>
> git pull(此处可能有冲突，可以先提交当前，再拉取)
>
> git merge alias-zhangsan
>
> git push

## git merge和git rebase

当前分支状态：

> a—>b—>c—>d  master分支
>
> |—>e—>f dev分支

**定义**

- git merge：会把当前分支和待合入分支commit合并在一起，形成一个新的commit
- git rebase：会把待合入分支插入到当前分支的最前面，叫做变基。

1.git merge

```
$ git merge master  // 合并master分支代码
$ git log --graph --oneline // 查看log点线图
  * 表示一个commit， 注意不要管*在哪一条主线上 
  | 表示分支前进 
  / 表示分叉 
  \ 表示合入
```

执行后变为：

当前分支状态：

> a—>b——————————g  dev分支
>
> |—>e—>f—>c—>d—| 

2.git rebase

执行后变为：

当前分支状态：

> a—>b—>c—>d—>e—>f  dev分支

**git merge和git rebase的优缺点**

git merge

- 优点：不会破坏原分支的提交记录。
- 缺点：会产生额外的提交记录，并进行两条分支线的合并。

git rebase

- 优点：无需新增提交记录到目标分支，reabse后可以直接将对象分支的提交历史加到目标分支上，形成线性提交历史记录，更加直观。
- 缺点：不能在一个共享分支上进行reabse操作，会带来分支安全问题。

**git merge和git rebase的应用场景**

- 合代码到公共分支的时候使用**git merge**，书写正确规范的**merge commits**留下记录。
- 合代码到个人分值的时候使用**git rebase**，可以不污染分支的历史提交记录，形成简介的线性记录。开源项目代码合并常使用。

**参考**

- [一文搞懂 git rebase](https://juejin.cn/post/7038093620628422669#heading-5)
- [【Git】 什么！？都快2023年了还搞不清楚 git rebase 与 git merge](https://juejin.cn/post/7135261815935598600#heading-3)

## Git合并那些事儿

| [认识几种Merge方法](https://morningspace.github.io/tech/git-merge-stories-1) | 介绍什么是快进式合并，三方合并，压缩合并       |
| ------------------------------------------------------------ | ---------------------------------------------- |
| [Merge策略（上）](https://morningspace.github.io/tech/git-merge-stories-2) | 认识Criss-Cross现象，以及Recursive，Ours等策略 |
| [Merge策略（下）](https://morningspace.github.io/tech/git-merge-stories-3) | 认识Octopus和Subtree策略                       |
| [当冲突发生的时候](https://morningspace.github.io/tech/git-merge-stories-4) | 讲述冲突发生时，那些你也许不曾知道的事儿       |
| [撤销合并](https://morningspace.github.io/tech/git-merge-stories-5) | 讲述冲各种撤销合并的方法                       |
| [神奇的Rebase](https://morningspace.github.io/tech/git-merge-stories-6) | 认识Rebase及其用法，以及什么时候用到它         |
| [交互式Rebase](https://morningspace.github.io/tech/git-merge-stories-7) | 介绍更多有关Rebase的玩法                       |
| [Rebase的烦恼](https://morningspace.github.io/tech/git-merge-stories-8) | 通过一个例子来演示Rebase使用不当带来的麻烦     |

## Git工作流面面观

| [分支模型](https://morningspace.github.io/tech/git-workflow-1) | Git强大的分支模型，所有Git工作流的基础                  |
| ------------------------------------------------------------ | ------------------------------------------------------- |
| [集中式工作流](https://morningspace.github.io/tech/git-workflow-2) | 最为基本的一种Git工作流，适合习惯传统版本控制方式的团队 |
| [特性分支工作流](https://morningspace.github.io/tech/git-workflow-3) | 非常重要的一种Git工作流，充分发挥分支模型的优势         |
| [Gitflow工作流](https://morningspace.github.io/tech/git-workflow-4) | 广泛应用的一种Git工作流，适合管理有固定发布周期的大项目 |
| [Forking工作流](https://morningspace.github.io/tech/git-workflow-5) | 开源项目的标准Git工作流，灵活与约束并存的分布式工作流   |

| 课程                            | 中文资源                                                     | 英文资源                             |
| :------------------------------ | :----------------------------------------------------------- | :----------------------------------- |
| 《如何使用Hello Git》           | [视频](http://v.youku.com/v_show/id_XMzk2NjQ5NzcyNA==.html)  | [视频](https://youtu.be/14pBZSXHz-Y) |
| 《新建本地库》                  | [视频](http://v.youku.com/v_show/id_XMzk3NzM3OTIxMg==.html)  | [视频](https://youtu.be/q2De0LrOZFk) |
| 《添加新文件》                  | [视频](http://v.youku.com/v_show/id_XMzk3ODM0NjU4MA==.html)  | [视频](https://youtu.be/yP9v4egMQwA) |
| 《连接远程库》                  | [视频](http://v.youku.com/v_show/id_XMzk3ODQzMTU5Ng==.html)  | [视频](https://youtu.be/KjsexSUOdNA) |
| 《理解暂存》                    | [视频](http://v.youku.com/v_show/id_XMzk5MTU2NDk3Mg==.html)  | [视频](https://youtu.be/dJSmmtiOoTM) |
| 《恢复到指定版本》              | [视频](http://v.youku.com/v_show/id_XMzk5OTA3MzE2NA==.html)  | [视频](https://youtu.be/4361HjW1ldA) |
| 《撤销本地更改》                | [视频](http://v.youku.com/v_show/id_XMzk5OTA4NzY5Mg==.html)  | [视频](https://youtu.be/7SpAQgzp0h8) |
| 《删除文件》                    | [视频](http://v.youku.com/v_show/id_XMzk5OTA4ODI1Mg==.html)  | [视频](https://youtu.be/MN0FMGIPMVM) |
| 《理解分支》                    | [视频](http://v.youku.com/v_show/id_XNDAxMTgxMjg4NA==.html)  | [视频](https://youtu.be/1xx7-QDcQsY) |
| 《解决分支冲突》                | [视频](http://v.youku.com/v_show/id_XNDAyMzk0MTY1Ng==.html)  | [视频](https://youtu.be/wjz9tbGEvRg) |
| 《利用分支修复bug》             | [视频](http://v.youku.com/v_show/id_XNDA1NTQ0Mzc2OA==.html)  | [视频](https://youtu.be/G4M-ofXOqHg) |
| 《利用分支开发特性》            | [视频](http://v.youku.com/v_show/id_XNDA2NzQwMzU0MA==.html)  | [视频](https://youtu.be/0W1ylLgdwG4) |
| 《解决多人开发冲突》            | [视频](http://v.youku.com/v_show/id_XNDA2NzQyNzMyNA==.html)  | [视频](https://youtu.be/mMSTEy5wbK0) |
| 《理解rebase》                  | [视频](http://v.youku.com/v_show/id_XNDA3NTQ0OTk3Mg==.html)  | [视频](https://youtu.be/XraY8PGivxg) |
| 《管理标签》                    | [视频](http://v.youku.com/v_show/id_XNDA3NTQ1MzYzNg==.html)  | [视频](https://youtu.be/DI1_FastrNY) |
| 《Hello Git Cheat Sheet(小抄)》 | [查看](https://morningspace.github.io/tech/lab/hello-git-cheat-sheet/) |                                      |

# 给开源项目贡献代码

**pr问题**

> 对有些项目是可以的，但是对有些项目不行，因为你如果merge了已经fork的仓库，会产生merge commit，你再pull request的时候，源仓库的管理人员会退回你的request，因为他们想要保持git history干净整洁，你应该用git rebase自己的分支，这样你提交上去后人家才愿意合并（前提是你的改动是已经被接纳）。可以看看github的help页面有详细解释。

**贡献代码步骤**

- fork开源项目
- 创建新分支：git checkout -b new-user-contribution，git add.,git commit,git push
- 提交pr

**参考**

[开源指北-科普](https://oschina.gitee.io/opensource-guide/guide/%E7%AC%AC%E4%B8%80%E9%83%A8%E5%88%86%EF%BC%9A%E5%88%9D%E8%AF%86%E5%BC%80%E6%BA%90/%E7%AC%AC%201%20%E5%B0%8F%E8%8A%82%EF%BC%9A%E4%BB%80%E4%B9%88%E6%98%AF%E5%BC%80%E6%BA%90/#%E5%BC%80%E6%BA%90%E7%9A%84%E6%A6%82%E5%BF%B5)

# 常用命令

[git命令详解](https://www.itqaq.com/index/cate/37.html)

[Git 的 4 个阶段的撤销更改](https://segmentfault.com/a/1190000011969554)

[惊艳！小姐姐用动画图解 Git 的 10 大命令，这也太秀了吧！](https://github.com/biaochenxuying/blog/issues/67)

## git最常用命令

```
git init // 初始化
git add . // 提交代表到本地仓
git commit -m 'hello' // 提交代表到本地仓
git branch -M main // 重命名分支
git remote add origin git@github.com:fuyunjinglong/fuyunjinglong.github.io.git // 建立远程仓库链接
git pull origin master // 拉取代码
git push -u origin master // 推送代码
git checkout -b newBranch //创建并切换到新分支
git reset --hard 97ea0f9 //回退并删除提交记录
git revert -n 97ea0f9 // 回退但不删除提交记录

如果你在开发着业务，突然另一个分支有一个bug要改，你怎么办
git stash       //将本次修改存到暂存区（紧急切换分支时）
git stash pop   //将所有暂存区的内容取出来
```

## 新建代码库

```
# 在当前目录新建一个Git代码库
$ git init
# 新建一个目录，将其初始化为Git代码库
$ git init [project-name]
# 下载一个项目和它的整个代码历史
$ git clone [url]
# 建立远程仓库链接
$ git remote add origin git@github.com:fuyunjinglong/fuyunjinglong.github.io.git
```

## 配置

Git 的设置文件为`.gitconfig`，它可以在用户主目录下（全局配置），也可以在项目目录下（项目配置）。

```
# 显示当前的Git配置
$ git config --list

# 编辑Git配置文件
$ git config -e [--global]

# 设置提交代码时的用户信息
$ git config [--global] user.name "[name]"
$ git config [--global] user.email "[email address]"
```

## 增加 / 删除文件

```
# 添加指定文件到暂存区
$ git add [file1] [file2] ...

# 添加指定目录到暂存区，包括子目录
$ git add [dir]

# 添加当前目录的所有文件到暂存区
$ git add .

# 添加每个变化前，都会要求确认
# 对于同一个文件的多处变化，可以实现分次提交
$ git add -p

# 删除工作区文件，并且将这次删除放入暂存区
$ git rm [file1] [file2] ...

# 停止追踪指定文件，但该文件会保留在工作区
$ git rm --cached [file]

# 改名文件，并且将这个改名放入暂存区
$ git mv [file-original] [file-renamed]
```

## 代码提交

```
# 提交暂存区到仓库区
$ git commit -m [message]

# 提交暂存区的指定文件到仓库区
$ git commit [file1] [file2] ... -m [message]

# 提交工作区自上次commit之后的变化，直接到仓库区
$ git commit -a

# 提交时显示所有diff信息
$ git commit -v

# 使用一次新的commit，替代上一次提交
# 如果代码没有任何新变化，则用来改写上一次commit的提交信息
$ git commit --amend -m [message]

# 重做上一次commit，并包括指定文件的新变化
$ git commit --amend [file1] [file2] ...
```

## 分支

```
# 列出所有本地分支
$ git branch

# 列出所有远程分支
$ git branch -r

# 列出所有本地分支和远程分支
$ git branch -a

# 新建一个分支，但依然停留在当前分支
$ git branch [branch-name]

# 新建一个分支，并切换到该分支
$ git checkout -b [branch]

# 新建一个分支，指向指定commit
$ git branch [branch] [commit]

# 新建一个分支，与指定的远程分支建立追踪关系
$ git branch --track [branch] [remote-branch]

# 切换到指定分支，并更新工作区
$ git checkout [branch-name]

# 切换到上一个分支
$ git checkout -

# 建立追踪关系，在现有分支与指定的远程分支之间
$ git branch --set-upstream [branch] [remote-branch]

# 合并指定分支到当前分支
$ git merge [branch]

# 选择一个commit，合并进当前分支
$ git cherry-pick [commit]

# 删除分支
$ git branch -d [branch-name]

# 删除远程分支
$ git push origin --delete [branch-name]
$ git branch -dr [remote/branch]
```

## 标签

```
# 列出所有tag
$ git tag

# 新建一个tag在当前commit
$ git tag [tag]

# 新建一个tag在指定commit
$ git tag [tag] [commit]

# 删除本地tag
$ git tag -d [tag]

# 删除远程tag
$ git push origin :refs/tags/[tagName]

# 查看tag信息
$ git show [tag]

# 提交指定tag
$ git push [remote] [tag]

# 提交所有tag
$ git push [remote] --tags

# 新建一个分支，指向某个tag
$ git checkout -b [branch] [tag]
```

## 查看信息

```
# 显示有变更的文件
$ git status

# 显示当前分支的版本历史
$ git log

# 显示commit历史，以及每次commit发生变更的文件
$ git log --stat

# 搜索提交历史，根据关键词
$ git log -S [keyword]

# 显示某个commit之后的所有变动，每个commit占据一行
$ git log [tag] HEAD --pretty=format:%s

# 显示某个commit之后的所有变动，其"提交说明"必须符合搜索条件
$ git log [tag] HEAD --grep feature

# 显示某个文件的版本历史，包括文件改名
$ git log --follow [file]
$ git whatchanged [file]

# 显示指定文件相关的每一次diff
$ git log -p [file]

# 显示过去5次提交
$ git log -5 --pretty --oneline

# 显示所有提交过的用户，按提交次数排序
$ git shortlog -sn

# 显示指定文件是什么人在什么时间修改过
$ git blame [file]

# 显示暂存区和工作区的差异
$ git diff

# 显示暂存区和上一个commit的差异
$ git diff --cached [file]

# 显示工作区与当前分支最新commit之间的差异
$ git diff HEAD

# 显示两次提交之间的差异
$ git diff [first-branch]...[second-branch]

# 显示今天你写了多少行代码
$ git diff --shortstat "@{0 day ago}"

# 显示某次提交的元数据和内容变化
$ git show [commit]

# 显示某次提交发生变化的文件
$ git show --name-only [commit]

# 显示某次提交时，某个文件的内容
$ git show [commit]:[filename]

# 显示当前分支的最近几次提交
$ git reflog
```

## 远程同步

```
# 下载远程仓库的所有变动
$ git fetch [remote]

# 显示所有远程仓库
$ git remote -v

# 显示某个远程仓库的信息
$ git remote show [remote]

# 增加一个新的远程仓库，并命名
$ git remote add [shortname] [url]

# 取回远程仓库的变化，并与本地分支合并
$ git pull [remote] [branch]

# 上传本地指定分支到远程仓库
$ git push [remote] [branch]

# 强行推送当前分支到远程仓库，即使有冲突
$ git push [remote] --force

# 推送所有分支到远程仓库
$ git push [remote] --all
```

## 撤销

```
# 恢复暂存区的指定文件到工作区
$ git checkout [file]

# 恢复某个commit的指定文件到暂存区和工作区
$ git checkout [commit] [file]

# 恢复暂存区的所有文件到工作区
$ git checkout .

# 重置暂存区的指定文件，与上一次commit保持一致，但工作区不变
$ git reset [file]

# 重置暂存区与工作区，与上一次commit保持一致
$ git reset --hard

# 重置当前分支的指针为指定commit，同时重置暂存区，但工作区不变
$ git reset [commit]

# 重置当前分支的HEAD为指定commit，同时重置暂存区和工作区，与指定commit一致
$ git reset --hard [commit]

# 重置当前HEAD为指定commit，但保持暂存区和工作区不变
$ git reset --keep [commit]

# 新建一个commit，用来撤销指定commit
# 后者的所有变化都将被前者抵消，并且应用到当前分支
$ git revert [commit]

# 暂时将未提交的变化移除，稍后再移入
$ git stash
$ git stash pop
```



# Github仓库使用

## git拉取远程代码

```
git init
git add .
git commit -m 'h'
git remote add origin git@github.com:fuyunjinglong/fuyunjinglong.github.io.git
git pull origin main
git checkout -b vue2-zhufeng
git checkout  vue2-zhufeng
git push origin vue2-zhufeng
```

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

