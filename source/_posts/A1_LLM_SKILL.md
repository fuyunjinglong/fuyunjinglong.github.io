---
title: SKILL
date: 2004-01-01 06:33:16
categories:
- A1_LLM
toc: true # 是否启用内容索引
---

# 初级

## SKILL入门

**一、定义**

> 每个 Skill 的核心是一个 Markdown 文件，头部是 **YAML Frontmatter**(机器读)，正文是自然语言指令(模型读)。规范允许的 frontmatter 字段包括 `name`、`description`、`license`、`allowed-tools`、`metadata`、`compatibility`

**二、目录结构**

```
meeting-skill/
├── SKILL.md              # 必需：元数据 + 主指令
├── scripts/
│   ├── extract.py        # 可执行脚本（Python/Bash 等）
├── references/
│   ├── table_rules.md    # 补充文档，只在需要时读
├── assets/
│   └── template.json     # 模板、静态资源、json
│   └── config.json       # 模板、静态资源、json
└── README.md             # 调用示例
```

**三、SKILL.md书写**

1.单一功能

```js
---
name: meeting-skill
description: 会议总结助手。当用户需要用到会议总结助手时使用。
---

# 会议总结助手
## 总结会议内容
按照时间，人物，地点，内容进行总结输出
样例：

> 输入：会议总结助手，总结会议内容：张三2026年9月23日在公司楼下聚众闹事
>
> 输出：
>
> - 时间：2026年9月23日
> - 地点：公司楼下
> - 人物：张三
> - 内容：聚众闹事

如果需要上传文件，则执行上传脚本。调用方式：
python script/upload.py
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

**四、SKILL.md调用**

> - 事先可以执行：skills或技能列表。看下技能是否被识别到了。
> - 项目级有些.trae是必须的，是为了IDE能自动识别skill。否则调用时，需要显性引入skill根目录。

| 调用方式       | 样例                                                         | 缺点            |
| -------------- | ------------------------------------------------------------ | --------------- |
| 自动选择       | Qoder。比如：会议总结助手，总结会议内容：张三xx              | 关键字唤起skill |
| 显式调用(推荐) | Trae。采用#或/或@。比如：GUI中，#meeting-skill 。CLI中，/meeting-skill | 无需明显关键词  |



## SKILL的4大级别

**一、定义**

> 主流skill 划分为四个级别：**企业级、用户级（个人级）、项目级、插件级**

**二、比较**

| 级别                 | 存放位置（典型）                                             | 作用范围               | 加载优先级                             | 典型用途                                                     |
| -------------------- | ------------------------------------------------------------ | ---------------------- | -------------------------------------- | ------------------------------------------------------------ |
| **企业级**           | 企业统一注册表 / 托管路径（如 `~/.agent/cache/org-skills/`） | 组织内所有用户与项目   | **最高**（强制基线，不可被下级覆盖）   | 安全合规、代码规范、内部 API 约定等强制统一的 SOP            |
| **用户级（个人级）** | `~/.claude/skills/`、`~/.copilot/skills/` 或 `~/.agents/skills/` | 当前用户的**所有项目** | 次高（可覆盖项目和插件，不能覆盖企业） | 个人工作流偏好、常用写作/测试/调试套路，不提交 Git           |
| **项目级**           | `{project}/.claude/skills/`、`.github/skills/` 等            | 仅当前项目             | 中等（可覆盖插件，被企业和个人覆盖）   | 项目专属的部署流程、测试规范、code review 清单，随 Git 提交团队共享 |
| **插件级**           | 随插件包安装（`<plugin>/skills/...`）                        | 启用该插件的所有项目   | **最低**（可被所有上级覆盖）           | 第三方能力补充，如 Atlassian、Figma、Stripe 等官方分发的技能包 |

# 中级

## SKILL编写原则

**好的skill**

> - 单一职责：一个skill只做一个事情
> - 描述清晰：自然语言明确输入输出
> - 可组合：与其他skill可自由搭配使用

**5大原则**

> - 原子性：单一原则，一个skill负责一个功能
> - 给样例：给出清晰的输入和输出
> - 定角色：设定专家人设等
> - 造接口：定义清晰的json或md输出格式
> - 复盘优化：重构skill

## 渐进式加披露

这是 Skills 架构的核心创新，解决"装很多技能但不爆上下文"的问题：

| 层级          | 功能     | 加载内容                                | 时机                           | 典型开销             |
| ------------- | -------- | --------------------------------------- | ------------------------------ | -------------------- |
| **L1 元数据** | 意图匹配 | name + description                      | 启动时全部加载进 system prompt | 每个技能约几十 token |
| **L2 正文**   | 读取手册 | SKILL.md 的完整指令                     | 任务匹配到描述时才读           | 数百至数千 token     |
| **L3 资源**   | 按需执行 | scripts/、references/、assets/ 中的文件 | 指令中明确指向时才读取/执行    | 按需，无上限         |

启动时 Agent 只扫描所有技能的 frontmatter(几十 token/个)，装 100 个技能可能也只占几千 token;真正干活时才把对应 SKILL.md 全文读入上下文，再根据指令去调脚本、读参考文件。这就是为什么"技能商店"能装几十万技能而不会撑爆模型。



# 高级

## 经典SKILL合集

> - [女娲.skill](https://github.com/alchaincyf/nuwa-skill)

