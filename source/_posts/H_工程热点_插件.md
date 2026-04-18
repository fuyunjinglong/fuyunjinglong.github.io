---
title: 插件
date: 2023-01-12 07:33:16
categories:
- H_工程热点
toc: true # 是否启用内容索引
---

# VSCode

## 插件

- Chinese（Simplified）界面汉化
- Auto Rename Tag 标签修改自动同步，不用改两次
- Path Intellisense 自动补全文件路径
- Code Spell Checker 检查英文拼写错误
- Prettier Code formatter 自动格式化代码
- Live Server 本地服务器
- ESLint 代码规范检查
- Material Icon Theme文件树爽心悦目

## 主题

选择主题,执行命令

> Ctrl k Ctrl T

```
  "workbench.colorTheme": "Monokai Dark Soda", //让函数(名)和后面的括号之间加个空格
  "editor.tokenColorCustomizations": {
    "comments": "#C17F39" //春天绿
  },
  "workbench.colorCustomizations": {
    // "tab.inactiveBackground": "#a8a8a6", //非活动选项卡的背景色
    "tab.activeBackground": "#C17F39" //活动选项卡的背景色。
  }
```

## 配置模板片段

执行命令

```
Ctrl + Shift + P
```

输入snippets, 点击 代码片段：配置用户代码片段

```
{
"vue3 template": {
"prefix": "vue3-template",
"body": [
"<template>",
" <div>",
"$1",
" </div>",
"</template>\n",
"<script lang=\"ts\" setup>",
"import { ref } from \"vue\" ",
"$2",
"</script>\n",
"<style lang=\"scss\" scoped>",
"$3",
"</style>"
],
"description": "vue3 template"
}
}
```

## 关掉顶部固定的代码行

> Sticky Scroll: Enabled  取消勾选

## 顶部标签页自动换行

> workbench.editor.wrapTabs 勾选
