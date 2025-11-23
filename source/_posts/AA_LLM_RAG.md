---
title: LLM_RAG
date: 2025-11-01 06:33:16
categories:
- B_LLM
toc: true # 是否启用内容索引
---

# 大纲

- 一句话理解RAG

# 一句话理解RAG

参考：

- [RAG的工作机制](https://www.bilibili.com/video/BV1JLN2z4EZQ/?spm_id_from=333.1007.top_right_bar_window_default_collection.content.click&vd_source=bd4c7d99d71adf64d6e88c65370e0247)

全称Retrieval-Augmented Generation 检索增强生成。

**1.总体介绍**

RAG的基本流程如下图：

![image](/img/2025-11-13_19-06-19.png)

**2.逐步拆解**

2.1分片

分片方式主要有按照字数(如每1000字划分一个片段)，或者按照一个段落或章节或页码划分。

2.2检索

核心流程：通过*Embedding*将片段文本转换为*向量*，将片段文本和片段向量存入*向量数据库*中。

*Embedding*

Embedding模型主要将将片段文本转换为*向量*。

其中可以登录 http://huggingface.co/spaces/mteb 查询比较好用的Embedding模型。如gemini-Embedding-001等

*向量*

是一个多维的有大小和方向的数据，维度越多，信息越丰富。

*向量数据库*

是用于存储和查询向量的数据库，提供了计算向量相似度的函数等功能。一般向量数据库中会存量向量和原始文本，做好一一映射。

分片和检索如下图：

![image](/img/2025-11-12_20-29-11.png)

2.3召回

Embedding模型将用户的问题转换为向量，给到向量数据库，通过向量相似度计算，得到相似度最高的前10个结果。

流程如下图：

![image](/img/2025-11-12_20-33-53.png)

目前比较流行的向量相似度计算方法：余弦相似度、欧氏距离、点积。

> 余弦相似度：计算两个向量之间角度的cos值。值越小，夹角越小，相似度越高。
>
> 欧氏距离：计算两个向量重点的距离。值越小，相似度越高。
>
> 点积：一个向量向另一个向量做垂直线，可能有正负值，正值越大，相似度越高。

2.4重排

通过使用cross-encoder模型提取相似度更高的前3个结果返回。

召回与重排对比如下图：

![image](/img/2025-11-13_19-01-20.png)

2.5生成

我们将3个结果输送给大模型，让大模型帮忙生成答案即可。

**3.使用Python构建RAG系统，手写RAG全流程**

安装依赖

首先请确保你的系统已经安装了 uv 和 Jupyter notebook，否则请参照如下链接安装：

- uv: https://docs.astral.sh/uv/getting-started/installation/
- Jupyter: https://jupyter.org/install

初始化项目

```
uv init .
```

因为使用Jupyter notebook，我们不需要main.py，可以删除。

然后在项目根目录下创建一个名为 `.env` 的文件，并添加以下内容：

```
GEMINI_API_KEY=xxx
```

其中 xxx 为你的 Google Gemini API 密钥。没有密钥的用户可以在 https://aistudio.google.com/apikey 上申请。

然后使用 uv 安装如下 Python 依赖：

```
uv add sentence_transformers chromadb google-genai python-dotenv
```

各个依赖说明如下图：

![image](/img/2025-11-13_19-18-22.png)

再使用 uv 运行 Jupyter Notebook：

```
uv run --with jupyter jupyter lab
```
