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

## RAG的工作机制

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

## Python构建RAG系统

[github代码仓](https://github.com/fuyunjinglong/LLM-RAG/tree/main)

安装依赖

首先请确保你的系统已经安装了 uv 和 Jupyter notebook，否则请参照如下链接安装：

- uv: https://docs.astral.sh/uv/getting-started/installation/  python包管理
- Jupyter: https://jupyter.org/install 交互式代码执行环境

> 初始化项目，执行uv init 。因为使用Jupyter notebook，我们不需要main.py，可以删除。

> 安装依赖，执行uv add sentence_transformers chromadb google-genai python-dotenv

各个依赖说明如下图：

![image](/img/2025-11-13_19-18-22.png)

> 使用 uv包管理器启动Jupyter Notebook，执行uv run --with jupyter jupyter lab

开始在Jupyter Notebook编写交互式代码，新建main.ipynb文件

```python
#分片代码
from typing import List
# 定义分片函数
def split_into_chunks(doc_file: str) -> List[str]:
    with open(doc_file, 'r') as file:
        content = file.read()
    # 按照换行符，段落分片
    return [chunk for chunk in content.split("\n\n")]
# 读取本地文件
chunks = split_into_chunks("doc.md")
for i, chunk in enumerate(chunks):
    print(f"[{i}] {chunk}\n")
    
#索引，会从hugging face下载模型
from sentence_transformers import SentenceTransformer
embedding_model = SentenceTransformer("shibing624/text2vec-base-chinese")
#定义向量化函数：使用embedding模型，将文本转化为向量
def embed_chunk(chunk: str) -> List[float]:
    embedding = embedding_model.encode(chunk, normalize_embeddings=True)
    return embedding.tolist()

#索引-测试内容
embedding = embed_chunk("测试内容")
print(len(embedding))
print(embedding)
# 索引-循环调用向量化函数
embeddings = [embed_chunk(chunk) for chunk in chunks]
print(len(embeddings))
print(embeddings[0])
#索引-存入内存型向量数据库chromadb
import chromadb
chromadb_client = chromadb.EphemeralClient()
#如果想存入本地文件持久化向量数据库，可换成chromadb.PersistentClient("./chroma.db")
chromadb_collection = chromadb_client.get_or_create_collection(name="default")
#定义向量数据库函数
def save_embeddings(chunks: List[str], embeddings: List[List[float]]) -> None:
    for i, (chunk, embedding) in enumerate(zip(chunks, embeddings)):
        chromadb_collection.add(
            # 文本片段列表
            documents=[chunk],
            # 向量片段列表
            embeddings=[embedding],
            # ids是chromadb需要用的列表，即['0','1','2'...  ]
            ids=[str(i)]
        )
save_embeddings(chunks, embeddings)

#召回
#定义召回函数
def retrieve(query: str, top_k: int) -> List[str]:
    # 将用户的提问转化为向量
    query_embedding = embed_chunk(query)
    # 将向量拿到向量库中搜索，取topk
    results = chromadb_collection.query(
        query_embeddings=[query_embedding],
        n_results=top_k
    )
    return results['documents'][0]
query = "哆啦A梦使用的3个秘密道具分别是什么？"
# 获取最相关的前5个片段
retrieved_chunks = retrieve(query, 5)
for i, chunk in enumerate(retrieved_chunks):
    print(f"[{i}] {chunk}\n")
    
#重排 
from sentence_transformers import CrossEncoder
# 定义重排函数：将用户问题和召回的片段列表，进行相似度打分
def rerank(query: str, retrieved_chunks: List[str], top_k: int) -> List[str]:
    cross_encoder = CrossEncoder('cross-encoder/mmarco-mMiniLMv2-L12-H384-v1')
    pairs = [(query, chunk) for chunk in retrieved_chunks]
    scores = cross_encoder.predict(pairs)
    scored_chunks = list(zip(retrieved_chunks, scores))
    scored_chunks.sort(key=lambda x: x[1], reverse=True)
    return [chunk for chunk, _ in scored_chunks][:top_k]
# 去除重排后的前3个
reranked_chunks = rerank(query, retrieved_chunks, 3)
for i, chunk in enumerate(reranked_chunks):
    print(f"[{i}] {chunk}\n")
    
#生成-使用免费的gemini
from dotenv import load_dotenv
from google import genai
#读取目录下env环境文件，识别GEMINI_API_KEY
load_dotenv()
google_client = genai.Client()
# 定义生成函数：用户问题和重排的3个结果列表作为输入
def generate(query: str, chunks: List[str]) -> str:
    prompt = f"""你是一位知识助手，请根据用户的问题和下列片段生成准确的回答。
用户问题: {query}
相关片段:
{"\n\n".join(chunks)}
请基于上述内容作答，不要编造信息。"""
    print(f"{prompt}\n\n---\n")
    response = google_client.models.generate_content(
        model="gemini-2.5-flash",
        contents=prompt
    )
    return response.text
#调用函数
answer = generate(query, reranked_chunks)
print(answer)
```

注意生成环节，使用免费的gemini，然在根目录下创建名为 `.env` 的文件，并添加以下内容：

```
GEMINI_API_KEY=xxx
```

其中 xxx 为你的 Google Gemini API 密钥。没有密钥的用户可以在 https://aistudio.google.com/apikey 上申请。

