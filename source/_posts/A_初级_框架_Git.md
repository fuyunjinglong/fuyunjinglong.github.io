---
title: Git
date: 2021-09-06 07:33:16
categories:
- A_初级
toc: true # 是否启用内容索引
---

**参考**

> - [Git入门教程](https://www.w3cschool.cn/git/git-tutorial.html)
>
>   [Github入门教程](https://www.w3cschool.cn/githubcn/)

# 初级

## Husky+lint-staged

**一句话**：Husky 提供"触发时机 + 强制约束"，lint-staged 提供"精准文件范围 + 快速校验"

**Husky 是管理 Git Hooks 的工具，负责在 `git commit`/`git push` 等动作前后触发自定义脚本；lint-staged 则负责只对 Git 暂存区（已 `git add`）的文件执行 lint/格式化命令。** 两者通常配合使用：Husky 负责"什么时候做"，lint-staged 负责"对哪些文件做"

> 执行 `git commit` 时，Husky 触发 pre-commit → 调用 lint-staged → 只对暂存区的 js/ts 文件跑 ESLint 修复和 Prettier 格式化，对 json/css/md 跑 Prettier；任一命令失败就以非零退出码中断提交。

**Q1: lint-staged 是如何只拿到暂存区代码的？**

> 答：lint-staged 底层使用了 `git` 命令。它通过类似 `git diff --staged --diff-filter=d --name-only` 的命令，获取到被修改且已 `git add`，同时未被删除的文件列表，然后把这个列表传给 ESLint 或 Prettier。

**Q2: 如果 pre-commit 时 Prettier 自动修改了文件格式，提交会中断吗？**

> 答：早期可能会有提交中断的问题，但现在的 `lint-staged` 做了优化。它在执行完带有 `--write` 或 `--fix` 的命令后，如果发现文件被修改了，会自动将修改后的内容重新 `git add` 到暂存区。只要最终代码符合规范，提交就不会中断。

**Q3: 为什么不用 CI/CD（如 GitHub Actions / GitLab CI）去检查，而要在本地做？**

> 答：本地检查是“防御前置”，能在代码推送到远程之前就把问题拦截住，成本最低。CI/CD 是最后一道防线，虽然也能拦截，但反馈链路长（需要 Push -> 等待构建 -> 看结果），而且浪费 CI 服务器资源。两者是互补关系。

**Q4: Husky v8 和早期版本（如 v4）有什么区别？**

> 答：Husky v4 是通过在 `package.json` 中配置 hooks 来实现的，依赖 Git 的 `core.hooksPath`。Husky v5/v8 进行了重构，改用独立脚本的方式，不再依赖 `package.json` 中的配置，启动速度更快，且不再需要 `postinstall` 脚本来安装 hooks，更加安全和解耦。

## Git 的工作流程

Git 的核心在于：工作区、暂存区（索引区）和本地仓库，以及远程仓库。文件在这四个区域之间流转，形成不同的状态。

**详细解析：**

1. **工作区：** 我们实际在电脑上看到的目录，也就是当前正在操作的文件。
2. **暂存区：** 这是一个虚拟的中间层，用于临时存放下次提交的文件信息（`git add`  工作区 -> 暂存区）。
3. **本地仓库：** 本地保存版本信息的地方（`git commit`  暂存区 -> 本地仓库）。里面保存了提交的历史记录和具体的文件快照。
4. **远程仓库：** 如 GitHub、GitLab 等托管代码的服务器(`git push` 本地仓库 -> 远程仓库)。

**文件流转与状态：**

- **Untracked (未跟踪)：** 新建的文件，未被 Git 管理。
- **Modified (已修改)：** 文件被修改了，但还没保存到暂存区。
- **Staged (已暂存)：** 文件已放入暂存区，等待提交。
- **Committed (已提交)：** 数据已安全保存在本地仓库。

## Git 提交规范

最常采用的是 **Angular** 规范：

> 1. **feat:** 新功能
> 2. **fix:** 修复 Bug
> 3. **docs:** 文档变更
> 4. **style:** 代码格式（不影响代码运行的变动，如空格、缩进、分号等）
> 5. **refactor:** 重构（既不是新增功能，也不是修改 Bug 的代码变动）
> 6. **perf:** 性能优化
> 7. **test:** 增加测试或修改测试
> 8. **chore:** 构建过程或辅助工具的变动（如修改 webpack 配置、更新 npm 包）
> 9. **revert:** 回滚之前的 commit

## Git 解决代码冲突

- **核心考点**：实际工程冲突解决流程。
- **标准回答**：Git 会在冲突文件插入 `<<<<<<<` 标记，开发者需手动删除标记并决定最终代码，随后 `git add` 标记冲突解决，最后 `git commit` 完成合并。
- **深入拓展**：前端常冲突点为 `package.json`、路由配置及公共组件。
- **最佳实践**：频繁同步主干减少分支偏离；遇到 `lock` 文件冲突，保留主干版本后重新 `npm install`。

## Git 分支管理策略

- **核心考点**：团队工程化协作规范。
- 标准回答：
  - Git Flow：重型，含 `master`、`develop`、`feature`、`release`、`hotfix`，适合长周期发版。
  - GitHub Flow：轻量，仅 `main` 和 `feature`，靠 PR 合并即部署，适合 CI/CD 敏捷开发。
- **深入拓展**：现代前端工程随着 CI/CD 普及，越来越倾向使用轻量级策略。
- **最佳实践**：统一分支命名（如 `feature/xxx`），严格执行 PR 评审机制。

## Git 最常用命令

**日常五步曲（最常用）**

- `git status` — 看看改了啥
- `git add .` — 全部放进暂存区
- `git commit -m "说明"` — 提交到本地
- `git pull` — 拉取远端最新代码
- `git push` — 推送到远端

**分支管理**

- `git checkout -b <分支名>` — 新建并切换分支
- `git branch` — 查看分支
- `git checkout <分支名>` — 切换分支
- `git merge <分支名>` — 将某分支合并到当前分支

**查看记录**

- `git log --oneline` — 简洁查看提交历史
- `git diff` — 查看未提交的代码修改

**撤销操作**

- `git checkout -- <文件名>` — 撤销工作区的修改
- `git reset HEAD <文件名>` — 撤销暂存（退回工作区）
- `git reset --hard HEAD^` — 彻底回退到上个版本（慎用）

**暂存救急**

- `git stash` — 临时藏起当前修改
- `git stash pop` — 恢复修改

## git add和 git stash的区别

`git add`：

- **作用**：工作区内容存到暂存区。
- **状态变化**：文件修改依然保留在你的电脑硬盘上，只是 Git 记录了这些修改“准备被提交”。
- **目的**：为了精细控制下一次 `git commit` 将包含哪些文件的哪些修改。

`git stash`：

- **作用**：工作区+暂存区存到Git储藏区（Stash栈），然后**重置**工作区。
- **状态变化**：修改从你的当前工作区“消失”了（被隐藏在 Git 的内部储藏区中），你需要通过 `git stash pop` 或 `git stash apply` 才能把它们找回来。
- **目的**：为了临时切换上下文（比如切换分支、拉取最新代码），但又不想把写了一半的烂代码提交到版本库中。

## git pull 和 git fetch 的区别

- **核心考点**：远程仓库同步机制。
- **标准回答**：`fetch` 仅将远程最新代码拉取到本地，不自动合并；`pull` 等同于 `fetch` + `merge`，拉取并自动合并到当前分支。
- **深入拓展**：`pull` 自动合并时，若本地有修改易产生意料之外的 Merge commit，导致历史混乱。
- **最佳实践**：推荐使用 `fetch` 配合手动 `merge` 或 `rebase`，以掌控合并过程。

## git merge 和 git rebase 的区别

- **核心考点**：分支整合策略。
- **标准回答**：`merge` 保留双方历史，交汇处生成新合并节点，历史呈非线性；`rebase` 将当前分支提交“移”到目标分支最新节点之后，历史呈线性。
- **深入拓展**：`rebase` 会重写历史生成新的 commit hash。
- **最佳实践**：黄金法则——绝不在公共分支执行 `rebase`，只在本地特性分支使用。

## git stash 的作用

- **核心考点**：工作区状态暂存。
- **标准回答**：`stash` 将未提交的修改临时保存，使工作区恢复到 HEAD 干净状态，之后可用 `stash pop` 恢复。
- **深入拓展**：支持多次暂存形成栈结构，通过 `stash list` 查看和 `stash apply` 恢复指定记录。
- **最佳实践**：开发半路需切分支修紧急 Bug 时，先 `stash` 暂存进度，修完再切回 `pop` 恢复。

## git reset 的三种模式

- **核心考点**：版本回退原理。
- 标准回答：
  - `--soft`：移动 HEAD，保留暂存区和工作区。
  - `--mixed`（默认）：移动 HEAD，重置暂存区，保留工作区。
  - `--hard`：移动 HEAD，重置暂存区和工作区（代码丢失）。
- **深入拓展**：本质是控制 HEAD 指针回退时，对暂存区和工作区状态的清理程度。
- **最佳实践**：`--hard` 属破坏性操作，执行前建议先 `git stash` 留底。

# 中级

## git reset 和 git revert 的区别

- **核心考点**：撤销提交的安全性。
- **标准回答**：`reset` 通过移动 HEAD 指针回退，直接丢弃后续历史；`revert` 通过生成一个逆向新提交来抵消目标提交，不改变历史。
- **深入拓展**：`reset` 修改历史，若已推送到公共分支会导致他人冲突；`revert` 安全。
- **最佳实践**：代码已推送到远程公共分支必须用 `revert`；本地未推送的误提交用 `reset` 更干净。

## git cherry-pick 是什么

- **核心考点**：选择性提取提交能力。
- **标准回答**：将指定的单个或多个 commit 应用到当前分支，而非合并整个分支。
- **深入拓展**：若提取时冲突，解决后需执行 `cherry-pick --continue`。
- **最佳实践**：线上 Bug 修复后，需将 `hotfix` 分支的修复提交同步到 `develop` 分支时使用。

## Git如何进行版本发布管理

- **核心考点**：Tag 版本标记。
- **标准回答**：使用 `git tag` 为特定 commit 打标签。分轻量标签（仅指针）和附注标签（含元数据，推荐）。推送到远程需 `git push origin --tags`。
- **深入拓展**：附注标签存储在 Git 独立对象中，更安全，不可被轻易篡改。
- **最佳实践**：遵循语义化版本规范，打 Tag 后触发 CI/CD 自动构建和 NPM 包发布。



# 高级

## git reset --hard 误删代码，如何找回

- **心考点**：Git 底层恢复机制。
- **标准回答**：使用 `git reflog` 查看 HEAD 所有的移动历史，找到误操作前的 commit hash，再执行 `git reset --hard <hash>` 恢复。
- **深入拓展**：`reflog` 记录了所有指针变动，只要底层 commit 对象未被垃圾回收（默认 30-90 天），均可找回。
- **最佳实践**：发现代码丢失立刻查 `reflog`，切勿在恢复前执行大量 Git 操作触发 GC。

## git rebase -i 的作用

- **核心考点**：高级历史记录整理。
- **标准回答**：交互式变基，在编辑器中对多个 commit 进行 `pick`（保留）、`squash`（合并）、`reword`（改信息）、`drop`（删除）等编排。
- **深入拓展**：它允许开发者将零碎的本地提交揉合成一个完整的功能提交。
- **最佳实践**：Feature 分支合并主干前，先用 `rebase -i` 整理提交，保持主干历史线性且清晰，提升 CR 效率。

## Git 的底层数据结构

- **核心考点**：对版本控制系统本质的理解。
- **标准回答**：Git 是基于内容寻址的文件系统。核心包含四种对象：`Blob`（文件内容）、`Tree`（目录结构）、`Commit`（提交快照）、`Tag`（标签）。
- **深入拓展**：Git 存储全量快照而非差异，未修改的文件 Tree 会复用之前的 Blob 哈希，故分支切换极快。
- **最佳实践**：理解底层有助于排查仓库体积膨胀问题，合理利用 Git GC 机制。

## 线上Bug，如何在海量提交中快速定位引入点

- **核心考点**：二分查找 Debug 能力。
- **标准回答**：使用 `git bisect`。`bisect start` 启动，标记当前为 `bad`，标记正常旧版本为 `good <hash>`。Git 自动切到中间版本供测试，反馈 `good/bad` 缩小范围，最终输出首恶 commit。
- **深入拓展**：支持自动化，`git bisect run <test-script>` 可根据测试脚本退出码自动完成二分。
- **最佳实践**：依赖升级或重构引发的隐蔽 Bug，`bisect` 是定位效率最高的终极杀器。

## 不用 rebase，如何合并本地已推送到远程的多个零碎 Commit

- **核心考点**：`git reset --soft` 的高级运用。
- **标准回答**：先找到合并目标前的 commit hash，执行 `git reset --soft <hash>`。HEAD 回退但所有代码修改保留在暂存区，重新 `git commit` 后，执行 `git push -f` 强推覆盖远程。
- **深入拓展**：相比 `rebase -i`，`reset --soft` 揉合提交更直接，但彻底重写了远程历史。
- **最佳实践**：强推极其危险！仅限个人独立分支使用，且必须用 `git push --force-with-lease` 防止覆盖他人提交。

## 给开源项目贡献代码

参考

> - [三咲智子的开源之路-2022年](https://xlog.sxzz.moe/2022)
> - [Element-plus提交pr有感](https://juejin.cn/post/7113606000967417863#heading-9)

**pr问题**

> 对有些项目是可以的，但是对有些项目不行，因为你如果merge了已经fork的仓库，会产生merge commit，你再pull request的时候，源仓库的管理人员会退回你的request，因为他们想要保持git history干净整洁，你应该用git rebase自己的分支，这样你提交上去后人家才愿意合并（前提是你的改动是已经被接纳）。可以看看github的help页面有详细解释。

**贡献代码步骤**

- fork开源项目
- 创建新分支：git checkout -b new-user-contribution，git add.,git commit,git push
- 提交pr

**参考**

[开源指北-科普](https://oschina.gitee.io/opensource-guide/guide/%E7%AC%AC%E4%B8%80%E9%83%A8%E5%88%86%EF%BC%9A%E5%88%9D%E8%AF%86%E5%BC%80%E6%BA%90/%E7%AC%AC%201%20%E5%B0%8F%E8%8A%82%EF%BC%9A%E4%BB%80%E4%B9%88%E6%98%AF%E5%BC%80%E6%BA%90/#%E5%BC%80%E6%BA%90%E7%9A%84%E6%A6%82%E5%BF%B5)

# 常见问题

## rebase变基

参考

> - [直接使用git pull拉取代码，被同事狠狠地diss了！](https://juejin.cn/post/7389650358539255845#heading-7)

# 常用命令

[git命令详解](https://www.itqaq.com/index/cate/37.html)

[Git 的 4 个阶段的撤销更改](https://segmentfault.com/a/1190000011969554)

[惊艳！小姐姐用动画图解 Git 的 10 大命令，这也太秀了吧！](https://github.com/biaochenxuying/blog/issues/67)

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

如果已经建立好链接的，直接git clone xxxxssh项目地址
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
ssh-keygen -t rsa -C 806435328@qq.com
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

## 问题汇总

问题1：执行ssh -T git@github.com报错ssh: connect to host github.com port 22: Connection timed out fatal。

> 原因：存在某些应用占用了22端口
>
> 解决：找到应用，关闭它。
>
> netstat -aon|findstr "20"  查看端口被占用的PID
>
> tasklist|findstr "10120" 查看PID对应的应用，最后手动关闭应用

# GitHub Pages免费站点

### 创建站点

[官方说明](https://docs.github.com/cn/pages/getting-started-with-github-pages/creating-a-github-pages-site)

### 配置发布源

在对应fuyunjinglong.github.io仓库里，打开setting->pages->branch，指定分支和目录层级。

保存后，访问https://fuyunjinglong.github.io/即可访问该仓库的指定分支的指定目录层级的index.html