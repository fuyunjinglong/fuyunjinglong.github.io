---
title: LLM_聚客第3期推荐
date: 2025-11-21 06:33:16
categories:
- B_LLM
toc: true # 是否启用内容索引
---

# 大纲

推荐学习第3期，每期都一样，只是迭代升级。

目前AI大模型开发主要集中在1.LLM 训练与微调应用，2.RAG 检索增强生成应用，3.Agent 智能体应用。多模态目前真实落地情况还有待解决。

推荐书籍：《大规模语言模型：从理论到实践》

# AI团队布局

AI产品经理

AI大模型应用开发

> - NL大模型
> - 跨模态，以图片为主
> - 模型平常

AI大模型算法工程师

> - 模型压缩技术-量化、蒸馏
> - 推理优化

![image](/img/聚客LLM大模型.png)

# 开发环境

cuda是用来加速训练和推理。cuda只能在N卡才有，mac电脑只能去算力平台租赁，如算力租赁网站：https://autodl.com/home。

- 科学上网
- conda-下载minicoda版本
- cuda驱动-去英伟达官网下载驱动,建议12.4版本，对应PyTorch2.5.1版本。查看window环境cuda最高支持的版本命令：nvidia-smi。查看当前cuda版本：nvcc -V
- 创建一个cuda新环境-安装pytorch和cuda对应版本的torch

# 主-前置知识

大模型是什么？

> 参数量在10亿(1b)以上的才叫大模型。

AI大模型是什么？

> 和写代码关系不大，核心是数学模型，也称为人工神经网络，本质是做矩阵运算的。

# 主-LLM 训练与微调应用

## Hugging Face / ModelScope 核心组件使用

目前要获取市面上所有的模型，只有2个途径，国外Hugging Face和国内阿里的ModelScope。阿里的可能不是那么及时和完整。

> 1.Hugging Face模型探索与下载
>
> 2.使用Hugging Face API调用模型(不推荐，实用性差，因为需要科学上网。大模型核心都是私有化部署)
>
> 3.Hugging Face核心组件Transformers、 datasets介绍
>
> 4.Hugging Face本地模型调用
