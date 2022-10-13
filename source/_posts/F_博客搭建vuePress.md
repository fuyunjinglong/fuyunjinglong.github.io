---
title: F_vuePress博客搭建
date: 2022-09-12 07:33:16
categories:
- F_新技术
toc: true # 是否启用内容索引
---

[vuePress官网](https://www.vuepress.cn/guide/)

# 快速上手

1. 创建并进入一个新目录

   ```bash
   mkdir vuepress-starter && cd vuepress-starter
   ```

2. 使用你喜欢的包管理器进行初始化

   ```bash
   yarn init # npm init
   ```

3. 将 VuePress 安装为本地依赖

   我们已经不再推荐全局安装 VuePress

   ```bash
   yarn add -D vuepress # npm install -D vuepress
   ```

   注意

   如果你的现有项目依赖了 webpack 3.x，我们推荐使用 [Yarn (opens new window)](https://classic.yarnpkg.com/zh-Hans/)而不是 npm 来安装 VuePress。因为在这种情形下，npm 会生成错误的依赖树。

4. 创建你的第一篇文档

   ```bash
   mkdir docs && echo '# Hello VuePress' > docs/README.md
   ```

5. 在 `package.json` 中添加一些 [scripts(opens new window)](https://classic.yarnpkg.com/zh-Hans/docs/package-json#toc-scripts)

   这一步骤是可选的，但我们推荐你完成它。在下文中，我们会默认这些 scripts 已经被添加。

   ```json
   {
     "scripts": {
       "docs:dev": "vuepress dev docs",
       "docs:build": "vuepress build docs"
     }
   }
   ```

6. 在本地启动服务器

   ```bash
   yarn docs:dev # npm run docs:dev
   ```

# vuePress配置

```
module.exports = {
  base: '/' /* 基础虚拟路径 */,
  dest: 'dist' /* 打包文件基础路径, 在命令所在目录下 */,
  title: 'yuman', // 标题
  description: '前端研究院', // 标题下的描述
  themeConfig: {
    // 主题配置
    // logo: '/images/logo.png',
    nav: [
      { text: '前端',  items: [
        { text: 'Vue3', link: 'C_Vue3.0入门2' },
      ] },
      {
        text: '学习路线',
        items: [
          { text: '前端', link: 'http://www.atguigu.com/web/' }
        ]
      },
    ],
    markdown: {
      lineNumbers: false // 代码块显示行号
    },
    sidebar: 'auto', // 侧边栏配置
    // sidebarDepth: 2, // 侧边栏显示2级
    // sidebar: [
    //   // 左侧导航
    //   '00_课程介绍',
    //   {
    //     title: '一.TypeScript快速上手',
    //     collapsable: false,
    //     children: [
    //       {
    //         title: '初识 TypeScript', // 标题
    //         children: [
    //           // 下级列表
    //           'chapter1/01_初识TS',
    //           'chapter1/02_安装TS',
    //           'chapter1/03_HelloWorld',
    //           'chapter1/04_webpack打包'
    //         ]
    //       },
    //       {
    //         title: 'TypeScript 常用语法',
    //         children: ['chapter2/1_type', 'chapter2/2_interface', 'chapter2/3_class', 'chapter2/4_function', 'chapter2/5_generic', 'chapter2/6_other']
    //       }
    //     ]
    //   },

    //   {
    //     title: '二.Vue3快速上手',
    //     collapsable: false,
    //     children: ['chapter3/01_认识Vue3', 'chapter3/02_创建vue3项目']
    //   },
    //   {
    //     title: '三.Composition API',
    //     collapsable: false,
    //     children: [
    //       'chapter4/01_Composition API_常用部分',
    //       'chapter4/02_Composition API_其它部分',
    //       'chapter4/03_手写组合API',
    //       'chapter4/04_Composition VS Option'
    //     ]
    //   },
    //   {
    //     title: '四.其它新组合和API',
    //     collapsable: false,
    //     children: ['chapter5/01_新组件', 'chapter5/02_其他新API']
    //   },
    //   {
    //     title: '五.Vue3综合案例',
    //     collapsable: false,
    //     children: ['chapter6/']
    //   },
    //   'chapter7/快速搭建在线文档'
    // ]
  },

  head: [['link', { rel: 'shortcut icon', type: 'image/x-icon', href: `./images/favicon.ico` }]]
}

```

# 部署Github page

- 手动部署：本地打包，上传编译后的文件到git仓库

- 自动部署：借助gh-pages插件，自动上传编译后文件到固定分支

  > 其实这里的原理就是在github上重建一个分支，然后将build后的代码放到这个分支，在访问这个地址的时候就可以正常运行了,我们可以看到有一个gh-pages的分支，里面的内容恰恰就是build后的内容

```
#！因为远程仓库一直报错，'origin' does not appear to be a git repository
#1 所以采用手动上传编译后的文件到vuePressPage仓库
```

## **手动部署**

*本地编译*

```
npm run docs:build
```

*本地代码提交git仓库*

```
git init // 初次初始化
git remote add origin git@github.com:fuyunjinglong/fuyunjinglong.github.io.git // 建立远程仓库链接
git checkout -b vuePressPage //初次创建分支并拉取分支代码
git pull origin vuePressPage // 拉取代码
git add . // 提交代表到本地仓
git commit -m 'hello' // 提交代表到本地仓
git push -u origin vuePressPage // 推送代码
```

## **自动部署到gh-pages分支**

```bash
# 下载工具包
npm i add -D gh-pages
# 执行打包命令
npm run doc:build
# 执行部署命令
npm run doc:deploy
```