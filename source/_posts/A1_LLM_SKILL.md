---
title: SKILL
date: 2003-01-01 06:33:16
categories:
- A1_LLM
toc: true # 是否启用内容索引
---

# SKILL

## 定义

> 每个 Skill 的核心是一个 Markdown 文件，头部是 **YAML Frontmatter**(机器读)，正文是自然语言指令(模型读)。规范允许的 frontmatter 字段包括 `name`、`description`、`license`、`allowed-tools`、`metadata`、`compatibility`

## 目录结构

```
my-skill/
├── SKILL.md              # 必需：元数据 + 主指令
├── scripts/
│   ├── extract.py        # 可执行脚本（Python/Bash 等）
│   └── ocr.py
├── references/
│   ├── table_rules.md    # 补充文档，只在需要时读
│   └── api_details.md
├── assets/
│   └── template.docx     # 模板、静态资源
└── LICENSE

```

**SKILL.md**  

1.单一功能

```js
---
name: pdf-processor
description: 提取 PDF 中的表格和文本，用于数据处理任务。当用户需要解析 PDF 文件时使用。
allowed-tools: Read, Write, Bash
---

# PDF 处理流程

## 步骤
1. 先检查 PDF 是否加密，若加密则提示用户提供密码
2. 使用 pdfplumber 提取文本（脚本见 scripts/extract.py）
3. 表格结构复杂时，参考 references/table_rules.md 中的规则

## 注意事项
- 扫描件需先 OCR，调用 scripts/ocr.py
```

2.多功能-分节

```
---
name: data-report
description: 生成数据报告的多种格式：导出 Excel 表格、生成 PDF 汇总、制作图表。当用户要求导出数据、生成报表或画图时使用。
---

# 数据报告技能

本技能支持三种功能，根据用户需求选择对应章节执行。

## 功能 1:导出 Excel
当用户要求导出表格数据时：
1. 使用 pandas 将数据写入 xlsx
2. 数字列保留两位小数，日期列用 YYYY-MM-DD 格式

## 功能 2:生成 PDF 汇总
当用户要求生成 PDF 报告时：
1. 先调用功能 1 获取数据
2. 使用 reportlab 按 assets/pdf_template.py 的模板排版

## 功能 3:制作图表
当用户要求可视化时：
1. 确认数据维度后选择图表类型（趋势用折线、占比用饼图）
2. 用 matplotlib 生成，中文字体设置为 SimHei
```

3.多功能-分路由

```
---
name: office-tools
description: Office 文档处理工具集：创建/编辑 Excel、转换 PDF、生成 PPT。当任务涉及 xls、csv、pdf、pptx 等文件操作时使用。
---

# Office 工具集

先判断用户任务类型，再读取对应指南后执行：

| 任务 | 读取指南 | 可能用到的脚本 |
|---|---|---|
| Excel 读写、公式、透视表 | references/excel-guide.md | scripts/excel_helper.py |
| PDF 合并、拆分、转 Word | references/pdf-guide.md | scripts/pdf_convert.py |
| PPT 生成与排版 | references/ppt-guide.md | scripts/ppt_build.py |

## 通用规则
- 所有输出文件保存到用户指定目录，未指定则用当前目录
- 处理前先备份原文件为 .bak
```

## 三级加载机制

这是 Skills 架构的核心创新，解决"装很多技能但不爆上下文"的问题：

| 层级          | 加载内容                                | 时机                           | 典型开销             |
| ------------- | --------------------------------------- | ------------------------------ | -------------------- |
| **L1 元数据** | name + description                      | 启动时全部加载进 system prompt | 每个技能约几十 token |
| **L2 正文**   | SKILL.md 的完整指令                     | 任务匹配到描述时才读           | 数百至数千 token     |
| **L3 资源**   | scripts/、references/、assets/ 中的文件 | 指令中明确指向时才读取/执行    | 按需，无上限         |

启动时 Agent 只扫描所有技能的 frontmatter(几十 token/个)，装 100 个技能可能也只占几千 token;真正干活时才把对应 SKILL.md 全文读入上下文，再根据指令去调脚本、读参考文件。这就是为什么"技能商店"能装几十万技能而不会撑爆模型。

# 使用Trae集成skill

- 打开Trae，右上角齿轮设置，左侧的规则和技能，技能中添加github下载的项目，zip即可。注意最好是按照项目维度添加，不要全局。
- 使用：输入“用张雪峰的技能，告诉我学校和专业选哪个好？”使用张雪峰的技能。如果不使用，则直接右上角新建对话即可。

# skill

## 女娲.skill

参考

- https://github.com/fuyunjinglong/LLM-SKILL/tree/nvwa-skill
- https://github.com/alchaincyf/nuwa-skill

## 张雪峰.skill

参考

- https://github.com/fuyunjinglong/LLM-SKILL/tree/zhangxuefeng-skill
- https://github.com/alchaincyf/zhangxuefeng-skill

