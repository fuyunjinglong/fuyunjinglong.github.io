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
- anaconda-下载对应版本，是python的集成环境。(傻瓜式安装，注意安装时要选当前用户，然后下一步选中自动配置环境变量)
- cuda驱动-去英伟达官网下载驱动,建议12.4版本，对应PyTorch2.5.1版本。查看window环境cuda最高支持的版本命令：nvidia-smi。查看当前cuda版本：nvcc -V。(网上大量安装教程，需要英伟达的独立显卡，建议显存16GB以上)
- 创建一个cuda新环境-去[官网](http://pytorch.org/)获取命令安装cuda对应的pytorch版本(使用pip命令)
- 下载安装pucharm的社区版本(专业版收费)，它是用来python编程的
- 一定是**window10专业版**(不能是家庭版)，安装所有东西前一定要**重装系统**，否则环境无法正常搭建

# 主-前置知识

大模型是什么？

> 参数量在10亿(1b)以上的才叫大模型。以前有个叫深度学习，当深度学习参数超过10亿后，出现了智能化。

AI大模型是什么？

> 和写代码关系不大，核心是数学模型，也称为人工神经网络，本质是做矩阵运算的。

AI大模型如何分类？

> - 自然语义大模型(大模型的核心技术)
> - 多模块大模型(图片、音视频等)

# 主-LLM 训练与微调应用

## Hugging Face / ModelScope 核心组件使用

> 1.Hugging Face模型探索与下载
>
> 2.使用Hugging Face API调用模型(不推荐，实用性差，因为需要科学上网。大模型核心都是私有化部署)
>
> 3.Hugging Face本地模型调用(推荐)
>
> 4.Hugging Face核心组件Transformers、 datasets介绍

目前要获取市面上所有的模型，只有2个途径，国外Hugging Face和国内阿里的ModelScope。阿里的可能不是那么及时和完整。hf相当于AI界的github。

去[官网](https://huggingface.co/)邮箱注册，注意点击ascess key，生成自己的key,一定要本地保存好。后续会使用。

安装基本依赖库

> pip install transformers datasets tokenizers  

打开pucharm开发软件

> 创建本地环境previously configured interpreter,并选择anaconda下的python，没有则右侧添加一个。弹窗中选择system interpreter,选中本地anaconda安装目录下的python.exe即可。

**1.Hugging Face模型探索与下载**

Hugging Face 

提供了一个庞大的模型库，你可以通过以下步骤来查找所需的模型：

1. 访问 模型库页面。

2. 在搜索栏中输入关键字，如 "GPT-2" 或 "BERT"，然后点击搜索。

3. 你可以使用左侧的过滤器按任务、框架、语言等条件筛选模型

**2.使用Hugging Face API调用模型(不推荐，实用性差，因为需要科学上网。大模型核心都是私有化部署)**

```python
import requests
#使用Token访问在线模型

API_URL = "https://api-inference.huggingface.co/models/uer/gpt2-chinese-cluecorpussmall"
API_TOKEN = "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"
headers = {"Authorization": f"Bearer {API_TOKEN}"}

response = requests.post(API_URL,headers=headers,json={"inputs":"你好，Hugging face"})
print(response.json())
```

**3.Hugging Face本地模型调用(推荐)**

*注意：模型可先离线下载模型，也可以在线下载模型*

基本用法

在线下载模型，使用GPT2

```python
#将模型下载到本地调用，AutoModelForCausalLM模块是请求模型头用的， AutoTokenizer是分词器即将文本转为模型可识别的数据
from transformers import AutoModelForCausalLM,AutoTokenizer

#将模型和分词器下载到本地，并指定保存路径
# hf官方复制模型名称
model_name = "uer/gpt2-chinese-cluecorpussmall"
# 本地相对路径
cache_dir = "model/uer/gpt2-chinese-cluecorpussmall"

#下载模型
AutoModelForCausalLM.from_pretrained(model_name,cache_dir=cache_dir)
#下载分词工具
AutoTokenizer.from_pretrained(model_name,cache_dir=cache_dir)

print(f"模型分词器已下载到：{cache_dir}")
```

离线下载模型，使用GPT2，pipeline优化参数(3个核心参数)

```python
#本地离线调用GPT2
from transformers import AutoModelForCausalLM,AutoTokenizer,pipeline

#设置具体包含config.json的目录，只支持绝对路径
model_dir = r"D:\PycharmProjects\demo_1\trsanformers_test\model\uer\gpt2-chinese-cluecorpussmall\models--uer--gpt2-chinese-cluecorpussmall\snapshots\c2c0249d8a2731f269414cc3b22dff021f8e07a3"

#加载模型和分词器
model = AutoModelForCausalLM.from_pretrained(model_dir)
tokenizer = AutoTokenizer.from_pretrained(model_dir)

#使用加载的模型和分词器创建生成文本的pipeline，device可选cpu或cuda(显存跑模型)
generator = pipeline("text-generation",model=model,tokenizer=tokenizer,device="cuda")

#生成文本
# output = generator("你好，我是一款语言模型，",max_length=50,num_return_sequences=1)
output = generator(
    "你好，我是一款语言模型，",#生成文本的输入种子文本（prompt）。模型会根据这个初始文本，生成后续的文本
    max_length=50,#指定生成文本的最大长度。这里的 50 表示生成的文本最多包含 50 个标记（tokens）
    num_return_sequences=1,#参数指定返回多少个独立生成的文本序列。值为 1 表示只生成并返回一段文本。
    truncation=True,#该参数决定是否截断输入文本以适应模型的最大输入长度。如果 True，超出模型最大输入长度的部分将被截断；如果 False，模型可能无法处理过长的输入，可能会报错。
    temperature=0.7,#重要-该参数控制生成文本的随机性。值越低，生成的文本越保守（倾向于选择概率较高的词）；值越高，生成的文本越多样（倾向于选择更多不同的词）。0.7 是一个较为常见的设置，既保留了部分随机性，又不至于太混乱。
    top_k=50,#重要-该参数限制模型在每一步生成时仅从概率最高的 k 个词中选择下一个词。这里 top_k=50 表示模型在生成每个词时只考虑概率最高的前 50 个候选词，从而减少生成不太可能的词的概率。
    top_p=0.9,#重要-该参数（又称为核采样）进一步限制模型生成时的词汇选择范围。它会选择一组累积概率达到 p 的词汇，模型只会从这个概率集合中采样。top_p=0.9 意味着模型会在可能性最强的 90% 的词中选择下一个词，进一步增加生成的质量。
    clean_up_tokenization_spaces=True#该参数控制生成的文本中是否清理分词时引入的空格。如果设置为 True，生成的文本会清除多余的空格；如果为 False，则保留原样。默认值即将改变为 False，因为它能更好地保留原始文本的格式。
)
print(output)
```

**4.Hugging Face核心组件Transformers、 datasets介绍**

下载后的模型文件如下图：

![image](/img/2025-11-28_20-07-08.png)

*Transformers核心有两部分：Bert(分类)和GPT(生成)*

在线下载模型，使用Transform的Bert分类模型

```
# 在线下载模型，使用Transform的Bert
from transformers import BertTokenizer,BertForSequenceClassification,pipeline

#设置具体包含config.json的目录，只支持绝对路径(在线下载模型，使用相对路径)
model_dir = r"model\bert-base-chinese"

#加载模型和分词器(在线下载模型，声明模型名称)
model = BertForSequenceClassification.from_pretrained("bert-base-chinese",cache_dir=model_dir)
tokenizer = BertTokenizer.from_pretrained("bert-base-chinese",cache_dir=model_dir)

#创建分类pipleine
classifier = pipeline("text-classification",model=model,tokenizer=tokenizer,device="cuda")

#进行文本分类
result = classifier("你好，我是一款语言模型")
print(result)// {'label':'Label1','score':'0.75002'}
print(model)
```

后续如何将应用开发与分类模型落地?

基于Bert分类模型，可以做电商的好评差评的分类等。

## 基于Bert的中文评价情感分析

> 1.使用Tokenizer实现字符编码、 vocab字典操作
>
> 2.模型微调的基本概念
>
> 3.下游任务模型设计
>
> 4.自定义模型训练
>
> 案例： 自定义下游任务实现中文评价分析模型的本地化训练

**1.AI模型是如何处理字符数据的**

![image](/img/2025-11-28_21-06-31.png)

![image](/img/2025-11-28_20-46-51.png)

```python
#本节小结核心介绍AI模型是如何处理字符数据的
from transformers import BertTokenizer

#第一步：加载字典和分词器
token = BertTokenizer.from_pretrained(r"D:\PycharmProjects\demo_02\model\bert-base-chinese\models--bert-base-chinese\snapshots\c30a6ed22ab4564dc1e3b2ecbf6e766b0611a33f")
# print(token) python中万物皆对象，都可以print

#准备要编码的文本数据
sents = ["白日依山尽，",
         "价格在这个地段属于适中, 附近有早餐店,小饭店, 比较方便,无早也无所"]

#第二步：批量语句编码
out = token.batch_encode_plus(
    # 需要的编码的词
    batch_text_or_text_pairs=[sents[0],sents[1]],
    # 是否需要添加特殊字符，一般选是
    add_special_tokens=True,
    #当句子长度大于max_length(上限是model_max_length)时，截断
    truncation=True,
    max_length=15,
    #一律补0到max_length，注意是往后补齐0
    padding="max_length",
    #设置编码后的返回值类型，可取值为tf,pt,np,默认为None表示list
    return_tensors=None,
    return_attention_mask=True,
    return_token_type_ids=True,
    return_special_tokens_mask=True,
    #返回序列长度
    return_length=True
)
#input_ids 就是编码后的词即文字在字典中对应的数字编码
#token_type_ids上下文编码(本例子用的批量语句编码，已淘汰)，第一个句子和特殊符号的位置是0，第二个句子的位置1。
#special_tokens_mask 特殊符号的位置是1，其他位置是0
#length 编码之后的序列长度
# 打印编码后的数据
for k,v in out.items():
    print(k,":",v)

# 打印解码后的数据 再转回为文本数据
print(token.decode(out["input_ids"][0]),token.decode(out["input_ids"][1]))
```

**2.下载hugging face数据集**

hs上的数据集的格式是专有的，都是xxx.arrow文件

打印切分后的数据集如下图：

![image](/img/2025-11-28_21-24-46.png)

打印数据集的最终内容，如测试数据集部分

![image](/img/2025-11-28_21-29-01.png)

```python
from datasets import load_dataset,load_from_disk

#在线加载数据，如果未指定下载目录，则默认到c:\用户\.cache\hugging face\
# dataset = load_dataset(path="lansinuote/ChnSentiCorp",cache_dir="data/")
# print(dataset)
#arrow文件可以转为csv格式
# dataset.to_csv(path_or_buf=r"D:\PycharmProjects\demo_02\data\ChnSentiCorp.csv")

#加载缓存数据
datasets = load_from_disk(r"D:\PycharmProjects\demo_02\data\ChnSentiCorp")
# 打印切分后的数据集(有3部分：train训练数据集，validation验证数据集，test测试数据集)
print(datasets)
# 打印数据集的最终内容，如测试数据集部分
train_data = datasets["test"]
for data in train_data:
    print(data)

#一般我们数据是csv,hs平台加载CSV格式数据
# dataset = load_dataset(path="csv",data_files=r"D:\PycharmProjects\demo_02\data\hermes-function-calling-v1.csv")
# print(dataset)
```

