---
title: LLM_RAG
date: 2025-11-01 06:33:16
categories:
- A1_LLM
toc: true # 是否启用内容索引
---

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

# OpenAI的无向量化RAG

<img src="/img/2025-12-20_11-13-32.png" style="zoom:50%;" />

| 环节     | 模型         | 理由                 |
| -------- | ------------ | -------------------- |
| 内容挑选 | GPT-4.1-mini | 上下文窗口大、成本低 |
| 生成答案 | GPT-4.1      | 保证答案的准确性     |
| 答案验证 | o4-mini      | 推理强               |

# windows搭建本地知识库

**要求**

> - 本地知识库文件，向量数据库，LLM处理的数据都是个人私有数据，不允许上传云端公开，也不允许拿来做训练
> - 在windows上部署，要求不使用docker,因为doker配置环境太复杂且占用内存
> - 本地知识库文件夹有100G大小，每个文件大小不超过10M，文件中内容主要以中文和英文为主，文件类型都是常规的txt、word、ppt、excel、png等，限制只基于本地知识库回答，不要胡编乱造，不会的就说不会
> - 目前已采购在线DeepSeek Api的Token,可以直接使用
> - Embedding模型是采用工具软件内置的，还是其他更好的模型？
> - 将100G文件夹，划分为20个5G文件夹，每次拖拽1个到工作区解析，全部处理完后，本地电脑会不会多占用100G存储空间？会不会卡死？
> - 我的电脑是荣耀笔记本电脑，型号是14Pro,内存只有6G,具体有什么方案实现？

**方案**

核心：AnythingLLM DeskTop+DeepSeek Api+ollama

AnythingLLM DeskTop

> - AnythingLLM 安装在固态硬盘C最好，否则需要手动迁移数据，并做软连接
> - 向量库采用LanceDB，设置 → 向量数据库 → 显示为「Built-in LanceDB (Local)」
> - Setting-Document Processing 填3
> - 在工作区设置，将Chuck Size设为500-1000
> - 禁用全文检索(FTS)索引：工作区设置关闭Full-Text Search
> - 智能清理暂存区：每次5G文件解析保存后，在Document 中将这些文件"un-map"(取消映射)。此时向量已写入LanDB，而暂存区缓存会被清空。
> - 严格控制向量检索返回数量：在工作区的Chat Settings,将LLMContext window Item（Top-K）限制在3-5
> - 建议先将png转为txt
> - 多个是混合的切片调整：在工作区设置，将Overlap(切片重叠度)设为10%-15%
> - 私有数据不上传：侧边栏最下方 → “Privacy & Data” → 把 “Anonymous Telemetry Enabled” 关掉（绿色变灰）
> - AnythingLLM如果需要移动存储目录的话：
>   - 把 storage 整个文件夹复制到 D 盘目标目录
>   - rd /s /q "C:\Users\lw\AppData\Roaming\anythingllm-desktop\storage"
>   - mklink /J "C:\Users\lw\AppData\Roaming\anythingllm-desktop\storage" "D:\profilegram\LLM\anythingllm\storage"

DeepSeek Api

> - 私有数据不上传：登录 DeepSeek 开放平台：platform.deepseek.com，进入右上角头像 → 设置 → 隐私设置，关闭「数据用于优化体验 / 模型训练」开关

ollama

> - Embedding模型选择：bge-large-zh-v1.5/bge-small-zh-v1.5/nomic-embed-text
> - 限制ollama内存常驻：添加系统变量，变量名是OLLAMA_KEEP_ALIVE，值是5m
> - GPU加速确认：荣耀14 Pro部分型号带有NVIDA独显(RTX系列)，部分是核显
> - 任务管理器，切换到性能，在解析文件时，观察GPU0/GPU1利用率
> - 如果ollama自动调用了显卡，速度回避纯CPU快5-10倍。如果发现它只利用了CPU，查看显卡驱动是否最新
> - 环境变量并发控制：添加系统变量，变量名是OLLAMA_NUM_PARALLEL，值是1
> - 私有数据不上传：关闭匿名统计：Ollama可能默认收集匿名使用统计。在系统环境变量中，新建 OLLAMA_NO_TELEMETRY，将其值设为 1

本地电脑优化配置

> - 开启高性能模式：按win+i,打开设置-系统-电源与电池-电源模式调整为"最佳性能"
> - 防止自动休眠：同样页面，屏幕和睡眠在接通电源后，关闭设备设为"永不"
> - 设置磁盘写入缓存：设备管理器-磁盘驱动器-右键固态硬盘选择属性-在策略中，确保勾选"启动设备上的写入缓存"。这样可大幅提高LanceDB写入向量速度
> - 开启windows虚拟缓存：高级系统设置-性能设置-高级-虚拟内存更改，取消勾选。选中固态硬盘盘符，初始大小填16384（16G）,最大填32G,重启电脑
> - 让ollama吃满显卡：右键-打开NVIDIA面板-管理3D设置-程序设置，点击添加，找到并选择ollama.exe(c:/users/xx/appData/local/programs),图形处理器改为"高性能NVIDIA处理器"
> - 每次解析完5G文件后，重启电脑，完全释放内存
> - 调大NVIDIA虚拟显存(独显型号)：在NVIDIA控制面板，管理3D设置-全局设置-确保"CUDA-系统内存回退策略"设置为"驱动程序默认值"
> - 按下Fn+P，直接开启荣耀笔记本的"高能模式"

