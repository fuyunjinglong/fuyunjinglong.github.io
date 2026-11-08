---
title: 量化交易
date: 2000-01-01 08:33:16
categories:
- D_规划
toc: true # 是否启用内容索引
---

# 初级

## 入门视频

> - [黑马程序员]Python数据分析三剑客(Numpy，Pandas，Matplotlib)，《2026/最新AkShare/Tushare金融数据获取极速上手》
> - 聚宽账号注册，去聚宽的"策略学院"。《聚宽joinQuant》或《同花顺MindGo量化交易入门》
> - 《陈卓清华大学五道口金融学院：量化投资(公开课)》，《[QuantLabs]量化策略回测与实盘避坑指南》
> - [开源量化工具-Vibe-Trading](https://github.com/HKUDS/Vibe-Trading/blob/main/README_zh.md)
> - 闭源量化工具-国金证券QMT
> - [访谈-世界交易大赛冠军 chris Creamer](https://www.youtube.com/watch?v=PL7LKUsCgIQ)
> - [访谈-Words of Rizdom](https://www.youtube.com/watch?v=1NhqL2i5WkM&list=PL6OFPkfvvWybZH4qoUSjIV2xRJqv9qkz6&index=1)

## 策略

核心：盈亏比+胜率+仓位管理

**3.终极数学控仓-凯利公式**

核心：根据盈亏比+胜率动态计算出仓位，最后除以2，防止黑天鹅事件

**实操的策略(暂时)**

核心：等权重分散仓位+严格固定止损

> - 仓位：在聚宽里，每次选股10只，每只10%仓位
> - 盈亏比：在代码中写死，单只股票亏算达到5%，立刻无条件割肉，盈利达到15%或均线死叉卖出(确保盈亏比至少3：1)
> - 胜率：哪怕胜率只有35%，你在数学上也立于不败之地

个人策略案例

> - 换手率>5%，开盘30分钟内量比>2，股价放量冲过20或60天平台最高点，市值在30-100亿
> - 股价>5日线>20日线>60日线>120日线
> - 近3天或近5天内，龙虎榜上榜且知名游资买入
> - Beta>1.2或者RS指标在全市场排名10%

## 经典策略

> - [四大投资流派之吉姆·西蒙斯](https://quant-wiki.com/industry/master/Jim-Simons/)
> - 四大投资流派之索罗斯的宏观对冲
> - 四大投资流派之巴菲特的价值投资
> - 四大投资流派之利弗莫尔的趋势交易
> - [凯利公式](https://zhuanlan.zhihu.com/p/38279377)

# 中级

## 量化

**实操**

> - 云端一体化平台
> - 本地生态组合
> - 其他定制工具

云端一体化平台

> 聚宽(JoinQuant)/优矿(UQuant):适合云端一站式研究与投研体系

本地生态组合

> - 数据抓取：AkShare或Tushare（提供基础与）
> - 因子计算：
> - 极速回测：
> - 生成报告：
