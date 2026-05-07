---
title: LLM_聚客第4期推荐
date: 2025-11-21 06:33:16
categories:
- B_LLM
toc: true # 是否启用内容索引
---

# 大纲

推荐学习第3期，每期都一样，只是迭代升级。注意跟代码就完了，主要是注释的思路和逻辑。

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

<img src="/img/聚客LLM大模型.png" style="zoom:80%;" />

# 开发环境

cuda是用来加速训练和推理。cuda只能在N卡才有，mac电脑只能去算力平台租赁，如算力租赁网站：https://autodl.com/home。

- 科学上网
- anaconda-下载对应版本，是python的集成环境。(傻瓜式安装，注意安装时要选当前用户，然后下一步选中自动配置环境变量)
- cuda驱动-去英伟达官网下载驱动,建议12.4版本，对应PyTorch2.5.1版本。查看window环境cuda最高支持的版本命令：nvidia-smi。查看当前cuda版本：nvcc -V。(网上大量安装教程，需要英伟达的独立显卡，建议显存16GB以上)
- 创建一个cuda新环境-去[官网](http://pytorch.org/)获取命令安装cuda对应的pytorch版本(使用pip命令)
- 下载安装pucharm的社区版本(专业版收费)，它是用来python编程的
- 一定是**window10专业版**(不能是家庭版)，安装所有东西前一定要**重装系统**，否则环境无法正常搭建

# 主-前置知识

[神经网络模型训练](https://playground.tensorflow.org/)

<img src="/img/2025-12-13_09-47-25.png" style="zoom:50%;" />

**大模型是什么？**

> 参数量在10亿(1b)以上的才叫大模型。以前有个叫深度学习，当深度学习参数超过10亿后，出现了智能化。

**AI大模型是什么？**

> 和写代码关系不大，核心是数学模型，也称为人工神经网络，本质是做矩阵运算的。

**AI大模型如何分类？**

> - 自然语义大模型(大模型的核心技术)
> - 多模块大模型(图片、音视频等)

**CPU和GPU的差别？**

> - cpu:串行能力强(计算频率高，核心数少)
> - gpu:并行能力强(计算频率低，核心数多)。支持cuda,cuda多就是核心数多。

**AI项目开发流程(对应下面Bert情感分析中的流程)**

> AI开发完整流程：数据集-预训练-微调-部署-评测-应用

预训练：从头开始训练一个全新的模型，参数完全随机，不能处理任何问题。相当复杂，大公司才有实力研发。

微调训练(迁移学习)：基于之前训练好的模型，学习新的或特定的任务。

> - 1.需求数据准备
>   - 1.1获取数据
>   - 1.2制作数据集，转换数据格式
> - 2.模型选型/设计
>   - 2.1增量微调(增加模型并对增加的模型微调)
> - 3.模型训练
>   - 3.1加载模型和数据，开始训练
>   - 3.2观察状态
> - 4.效果评估(模型交付标准)
>   - 4.1客观评估：固定指标、客观数据如acc,注意评估时使用test训练集-对分类模型有效，如淘宝评论
>   - 4.2主观评估：人为挑选部分代表性数据，观察模型的输出结果-对生成式模型有效
> - 5.部署

模型评估的三大指标

> - 精度：即准确率，模型越大精度越高
>
> - 性能：处理模型时的速度，模型越小性能越快
>
> - 泛化性：指预训练模型(下面冻结的BertEncoder模型)的能力，主要与人为有一定关系。主要指AI训练时的3个指标
>
>   - 欠拟合：模型分布弱于真实数据分布(训练时间不够；模型过于简单)。loss过大，就是欠拟合，加大训练量即可。一般项目交付时都是欠拟合的。
>
>   - 拟合：模型分布恰好能够表达真实数据分布(训练的理想状态)
>
>   - 过拟合：模型分布过度拟合真实数据分布，使得模型结果依赖数据中的噪声信息，一旦数据变化，可能结果错误。如：识别猫狗。猫的背景是红色，狗的背景是蓝色。如果测试数据换成猫的背景蓝色，可能就出错，因为依赖了背景色判断猫狗。
>
>     validation验证数据集主要用来验证模型是否存在过拟合。一般以目前的模型和设备是不会达到过拟合，因为需要大量时间。

泛化性如下图：

<img src="/img/2025-12-01_07-25-07.png" style="zoom:50%;" />

**Transformers核心**

Transformers是从sep2seq自然语义模型改进来的，

> - Bert(分类)-编码器，独立可做分类模型。提取特征向量，输入到解码器。
> - GPT(生成)-解码器，独立可做生成模型。

**微调方式**

> - 全量微调
>   - 对所有参数进行微调
>   - 对算力和显存要求高
>   - 效果最佳，也可能效果不如以前
> - 局部微调-生成式模型采用这种模式，如LORA
>   - 只调整某些某部分参数， 例如输出层， 输入层或某些特殊层
>   - 对算力和显存要求一般
>   - 一定是有效果的
> - 增量微调-如Bert增加的全连接模型
>   - 通过新增参数的方式进行微调， 新的知识存储在新的参数中。
>   - 对显存和算力要求低
>   - 效果不如全量微调

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

提供了一个庞大的模型库，你可以通过以下步骤来查找所需的模型：

1. 访问 模型库页面。

2. 在搜索栏中输入关键字，如 "GPT-2" 或 "BERT"，然后点击搜索。

3. 你可以使用左侧的过滤器按任务、框架、语言等条件筛选模型

**2.使用Hugging Face API调用模型(不推荐，实用性差，因为需要科学上网。大模型核心都是私有化部署)**

```python
import requests
#使用Token访问在线模型

API_URL = "https://api-inference.huggingface.co/models/uer/gpt2-chinese-cluecorpussmall"
API_TOKEN = "xxxx"
headers = {"Authorization": f"Bearer {API_TOKEN}"}

response = requests.post(API_URL,headers=headers,json={"inputs":"你好，Hugging face"})
print(response.json())
```

**3.Hugging Face本地模型调用(推荐)**

*注意：模型可先离线下载模型，也可以在线下载模型*

基本用法-在线下载模型，使用GPT2

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

## 基于Bert的中文评价情感分析(AI开发流程实践,注释比代码重要)

如淘宝的评价，归一到0和1,0表示差评，1表示好评。

**总结**

这里的是模型开发的手写流程，后面一般都是使用框架实现，框架基本内部都集成了这些功能。但是这些手写代码涉及原理，并且有助于后续模型开发扩展。

> 1.使用Tokenizer实现字符编码、 vocab字典操作
>
> 2.下载和加载数据集
>
> 3.模型微调的基本概念
>
> 4.下游任务模型设计
>
> 5.自定义模型训练
>
> 案例： 自定义下游任务实现中文评价分析模型的本地化训练

**AI模型是如何处理字符数据的**

- [CLS] 标志放在第一个句子的首位，经过 BERT 得到的的表征向量 C 可以用于后续的分类任务。
- [SEP] 标志用于分开两个输入句子，例如输入句子 A 和 B，要在句子 A，B 后面增加 [SEP] 标志。
- [UNK]标志指的是未知字符
- [MASK] 标志用于遮盖句子中的一些单词，将单词用 [MASK] 遮盖之后，再利用 BERT 输出的 [MASK] 向量预测单词是什么。

![image](/img/2025-11-28_21-06-31.png)

![image](/img/2025-11-28_20-46-51.png)

token_test.py

```python
#本节小结核心介绍AI模型是如何处理字符数据的
from transformers import BertTokenizer

#第一步：加载字典和分词器
token = BertTokenizer.from_pretrained(r"D:\PycharmProjects\demo_02\model\bert-base-chinese\models--bert-base-chinese\snapshots\xxxx")
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

**下载和加载hugging face数据集**

hs上的数据集的格式是专有的，都是xxx.arrow文件

打印切分后的数据集如下图：

![image](/img/2025-11-28_21-24-46.png)

打印数据集的最终内容如下图：如测试数据集部分。text是文本，label是0或1,0表示差评，1表示好评   

![image](/img/2025-11-28_21-29-01.png)

### 1.1需求数据准备-获取数据(下载数据集到本地)

data_test.py

> - train训练数据集:用于训练模型，防止欠拟合
> - test测试数据集：用户效果评估-客观评估
> - validation验证数据集：用于验证是否过拟合

```python
from datasets import load_dataset,load_from_disk

#在线加载数据，如果未指定下载目录，则默认到c:\用户\.cache\hugging face\
# dataset = load_dataset(path="lansinuote/ChnSentiCorp",cache_dir="data/")
# print(dataset)
#arrow文件可以转为csv格式
# dataset.to_csv(path_or_buf=r"D:\PycharmProjects\demo_02\data\ChnSentiCorp.csv")

#加载缓存数据
datasets = load_from_disk(r"D:\PycharmProjects\demo_02\data\ChnSentiCorp")
# 打印切分后的数据集如下图：(有3部分：train训练数据集，validation验证数据集，test测试数据集)
print(datasets)
# 打印数据集的最终内容如下图：如测试数据集部分
train_data = datasets["test"]
for data in train_data:
    print(data)

#一般我们数据是csv,hs平台加载CSV格式数据
# dataset = load_dataset(path="csv",data_files=r"D:\PycharmProjects\demo_02\data\hermes-function-calling-v1.csv")
# print(dataset)
```

### 1.2需求数据准备-制作数据集，转换数据格式(数据集转化为模型初始数据)

> 基本都要重载3个方法

MyData.py-准备好的数据集

```python
# 将数据集转化为模型初始数据，目前大模型框架已经做好了
from torch.utils.data import Dataset
# 加载缓存的数据
from datasets import load_from_disk

class MyDataset(Dataset):
    # 重载3个方法
    #重载-初始化数据集
    def __init__(self,split):
        #从磁盘加载数据，动态初始化数据集，需要哪个用哪个
        self.dataset = load_from_disk(r"D:\PycharmProjects\demo_02\data\ChnSentiCorp")
        if split == "train":# 训练数据集
            self.dataset = self.dataset["train"]
        elif split == "test":# 测试数据集
            self.dataset = self.dataset["test"]
        elif split == "validation":# 验证数据集
            self.dataset = self.dataset["validation"]
        else:
            print("数据名错误！")

    #重载-返回数据集长度
    def __len__(self):
        return len(self.dataset)

    #重载-对每条数据单独做处理
    def __getitem__(self, item):
        text = self.dataset[item]["text"]
        label = self.dataset[item]["label"]
    # 最后返回数据：text是文本，label是0或1,0表示差评，1表示好评    
        return text,label
# 主函数-测试代码
if __name__ == '__main__':
    dataset = MyDataset("train")
    for data in dataset:
        print(data)
```

### 2.1模型选型/设计-增量微调

Transform本质是Mlp全连接+Att注意力机制。它是不具备位置模型，不能处理顺序问题。

一般我们AI开发是增加模型微调，核心是在原有的大模型基础上，增加业务模型，并对业务模型微调，叫增量微调。

BertEmbeddings模型结构

> - 1.embeddings()
>   - 1.1word_embeddings，将词转换成向量的模型。输出768维向量
>   - 1.2position_embeddings,记录词的前后位置顺序，也是768维向量
> - 2.encoder(BertEncoder)-预训练模型，即特征学习，特征提取
> - 3.pooler(BertPoller)，即池化层，池化数据，也是输出768维向量

![image](/img/2025-11-30_14-56-32.png)

net.py-自定义的增量模型

```python
import torch
from transformers import BertModel

#定义设备信息
DEVICE = torch.device("cuda" if torch.cuda.is_available() else "cpu")
print(DEVICE)

#加载预训练模型，指定到具体设备，并输出768维向量
pretrained = BertModel.from_pretrained(r"D:\PycharmProjects\demo_02\model\bert-base-chinese\models--bert-base-chinese\snapshots\c30a6ed22ab4564dc1e3b2ecbf6e766b0611a33f").to(DEVICE)
# 内部涉及3个模块处理
#1.embeddings(BertEmbeddings模型)
#1.1word_embeddings，将词转换成向量的模型。输出768维向量
#1.2position_embeddings,记录词的前后位置顺序，也是768维向量
#2.encoder(BertEncoder)
#即特征学习，特征提取
#3.pooler(BertPoller)
#即池化层，池化数据，也是输出768维向量
print(pretrained)

#定义下游任务（增量模型）
class Model(torch.nn.Module):
    def __init__(self):
        super().__init__()
        #设计全连接网络，实现二分类任务即调用全连接神经网络包
        # 768就是BertModel模型输出的768维向量；2是指二分，比如0是差评，1是好评。
        self.fc = torch.nn.Linear(768,2)
    #使用模型处理数据（执行前向计算）
    def forward(self,input_ids,attention_mask,token_type_ids):
        #冻结Bert模型的参数，让其不参与训练
        with torch.no_grad():
            out = pretrained(input_ids=input_ids,attention_mask=attention_mask,token_type_ids=token_type_ids)
        #增量模型参与训练，取的最后一段的序列特征(目前的transfer模型是沿用RNN那套模式，对数据是NSV格式要求。N是批次，S序列长度，V是数据特征)
        # 最后一段序列特征是包含完整信息的
        out = self.fc(out.last_hidden_state[:,0])
        return out
```

### 3.1模型训练-加载模型和数据，开始训练

train.py

```python
#模型训练
import torch
from MyData import MyDataset#准备好的数据集
from torch.utils.data import DataLoader
from net import Model#自定义的增量模型
from transformers import BertTokenizer,AdamW# 分词器和优化器

#定义设备信息
DEVICE = torch.device("cuda" if torch.cuda.is_available() else "cpu")
#定义训练的轮次(将整个数据集训练完一次为一轮)
EPOCH = 30000

#加载字典和分词器
token = BertTokenizer.from_pretrained(r"D:\PycharmProjects\demo_02\model\bert-base-chinese\models--bert-base-chinese\snapshots\c30a6ed22ab4564dc1e3b2ecbf6e766b0611a33f")

#第一步：先定义将传入的字符串进行编码
def collate_fn(data):
    sents = [i[0]for i in data]
    label = [i[1] for i in data]
    #编码
    data = token.batch_encode_plus(
        batch_text_or_text_pairs=sents,
        # 当句子长度大于max_length(上限是model_max_length)时，截断
        truncation=True,
        max_length=512,
        # 一律补0到max_length
        padding="max_length",
        # 可取值为tf,pt,np,默认为list。pt表示torch格式数据
        return_tensors="pt",
        # 返回序列长度
        return_length=True
    )
    input_ids = data["input_ids"]
    attention_mask = data["attention_mask"]
    token_type_ids = data["token_type_ids"]
    # 所有的数据都要转化为pyTorch的张量数据类型(如0和1转换为00101)
    label = torch.LongTensor(label)
#input_ids 就是编码后的词即文字在字典中对应的数字编码
#token_type_ids上下文编码(本例子用的批量语句编码，已淘汰)，第一个句子和特殊符号的位置是0，第二个句子的位置1。
#special_tokens_mask 特殊符号的位置是1，其他位置是0
#length 编码之后的序列长度
    return input_ids,attention_mask,token_type_ids,label

#第二步：创建数据集
train_dataset = MyDataset("train")
train_loader = DataLoader(
    dataset=train_dataset,
    #训练批次(每次取几条数据来训练模型，要尝试。批次太大可能装不下)
    batch_size=90,
    #打乱数据集
    shuffle=True,
    #舍弃最后一个批次的数据，防止形状出错(比如103条数据集，训练10轮次，批次10，则可能取到最后只剩下3条数据，就会出错)
    drop_last=True,
    #对加载的数据进行编码
    collate_fn=collate_fn
)
if __name__ == '__main__':
    #开始训练
    print(DEVICE)
    # 模型实例化：将模型放到设备上
    model = Model().to(DEVICE)
    #定义优化器
    optimizer = AdamW(model.parameters())
    #定义损失函数，多分类交叉熵损失函数
    loss_func = torch.nn.CrossEntropyLoss()

    for epoch in range(EPOCH):# 遍历轮次
        for i,(input_ids,attention_mask,token_type_ids,label) in enumerate(train_loader):#遍历批次数据
            #将数据放到DVEVICE上面
            input_ids, attention_mask, token_type_ids, label = input_ids.to(DEVICE),attention_mask.to(DEVICE),token_type_ids.to(DEVICE),label.to(DEVICE)
            #前向计算（将数据输入模型得到输出）
            out = model(input_ids,attention_mask,token_type_ids)
            #根据输出计算损失
            loss = loss_func(out,label)
            #根据误差优化参数(模型在学习)
            optimizer.zero_grad()#清空梯度
            loss.backward()#自动求导
            optimizer.step()#更新参数

            #每隔5个批次输出训练信息即每处理5条数据输出
            if i%5 ==0:
                #取出输出的结果
                out = out.argmax(dim=1)
                # label是hs上的二分类数据集，out是我们增量模型输出的值，两者进行比对正确率
                #计算训练精度(比如label 00101,out 01100。相同的为1并求和的3，结果是3/5)
                acc = (out==label).sum().item()/len(label)
                # 观察状态：输出轮次，批次，损失loss,acc精度，如下图。如果增量模型好的话，loss要降低，acc精度要增加
                print(f"epoch:{epoch},i:{i},loss:{loss.item()},acc:{acc}")
        #每训练完一轮，保存一次参数。保存文件到本地params目录下
        torch.save(model.state_dict(),f"params/{epoch}_bert.pth")
        print(epoch,"参数保存成功！")
```

### 3.2观察状态

输出轮次，批次，损失loss,acc精度，如下图:

如果增量模型好的话，loss整体趋势下降，acc精度要增加。核心是loss。一般指标越多，可观察的效果值也越多。

![image](/img/2025-11-30_16-04-19.png)

### 4.效果评估

> 目标是跑测试集得到的结果，与测试集的label越接近，则评估效果越好。至于结论是否正确，不是我们问题。
>
> 模型训练采用的是训练集得到的结果，效果评估的输入是要用到测试集的得到的结果。
>
> 所以要先将训练接换成测试集，跑下模型训练得到本地文件

训练时需要观察的指标：loss训练损失。大模型框架一般都提供了观察功能。

二分类的文本数据集(x,y):x是文本，y是评价值0或1.

> [negative,positive]
>
> negative[1,0],positive[0,1]
>
> 实际数据集是有标签的[negative,positive]即消极和积极，一般是将标签编码化即one-hot,转为negative[1,0],positive[0,1]。1表示对应标签的索引位置，因为是2分值的标签，标签消极是在第一个位置，其他等于0。

预训练模型-如BertEncoder模型

> 我们的训练模型都是增加了增量模型后的模型。
>
> x经过训练模型，输出h(0.5,0.5)。然后与y值比较，如y(1,0)即消极标签值，得到loss值
>
> 1.前向计算：将数据输入得到输出的过程也叫模型的推理过程
>
> 2.根据输出和标签label计算损失，模型的输出和标签之间的差距loss=mena(h-y)^2
>
> 3.模型根据loss进行求导，然后根据导数更新模型参数。
>
> 每更新一次参数，loss都会整理下降，梯度下降法。模型反向传播算法：根据损失求导更新参数的过程。

总结

> 一般我们需要根据前几次loss输出值判断模型是否正确，如果损失整体下降，即模型正确。如果不是，则数据集错误或模型有问题。马上停止训练，进行调整。一般模型很少出错，大概率是数据集出错，因为是数据集一般是我们自己做的。

什么时候停止模型训练

> 以甲方的要求为准，如acc达到0.95。一般模型发布的时候都有场景的准确率，我们AI开发就是为了实现效果接近这个准确率，准确率一定不是100%。即使是DeepSeek.

**4.1客观评估**

> 固定指标、客观数据如acc,注意评估时使用test训练集-对分类模型有效，如淘宝评论。
>
> 打印客观评估指标：如平均精度值，如下图。如果想了解完整的分类指标，可参照混淆矩阵。

<img src="/img/2025-12-01_06-26-49.png" style="zoom:50%;" />

evaluate0.py-客观评价(类似训练，训练集换成测试集)

```python
#模型评估(与模型训练有些细微差别，不需要训练，优化，只需要一个轮次即可)
import torch
from MyData import MyDataset
from torch.utils.data import DataLoader
from net import Model
from transformers import BertTokenizer,AdamW

#定义设备信息
DEVICE = torch.device("cuda" if torch.cuda.is_available() else "cpu")

#加载字典和分词器
token = BertTokenizer.from_pretrained(r"D:\PycharmProjects\demo_02\model\bert-base-chinese\models--bert-base-chinese\snapshots\c30a6ed22ab4564dc1e3b2ecbf6e766b0611a33f")

#将传入的字符串进行编码
def collate_fn(data):
    sents = [i[0]for i in data]
    label = [i[1] for i in data]
    #编码
    data = token.batch_encode_plus(
        batch_text_or_text_pairs=sents,
        # 当句子长度大于max_length(上限是model_max_length)时，截断
        truncation=True,
        max_length=512,
        # 一律补0到max_length
        padding="max_length",
        # 可取值为tf,pt,np,默认为list
        return_tensors="pt",
        # 返回序列长度
        return_length=True
    )
    input_ids = data["input_ids"]
    attention_mask = data["attention_mask"]
    token_type_ids = data["token_type_ids"]
    label = torch.LongTensor(label)
    return input_ids,attention_mask,token_type_ids,label

#创建数据集
test_dataset = MyDataset("test")
test_loader = DataLoader(
    dataset=test_dataset,
    #训练批次
    batch_size=100,
    #打乱数据集
    shuffle=True,
    #舍弃最后一个批次的数据，防止形状出错
    drop_last=True,
    #对加载的数据进行编码
    collate_fn=collate_fn
)

if __name__ == '__main__':
    acc = 0.0
    total = 0

    #开始测试
    print(DEVICE)
    # 模型实例化：将模型放到设备上
    model = Model().to(DEVICE)
    #加载模型训练参数(模型训练后的输出文件)
    model.load_state_dict(torch.load("params/16_bert.pth"))
    #开启测试模式
    model.eval()

    for i,(input_ids,attention_mask,token_type_ids,label) in enumerate(test_loader):
        #将数据放到DVEVICE上面
        input_ids, attention_mask, token_type_ids, label = input_ids.to(DEVICE),attention_mask.to(DEVICE),token_type_ids.to(DEVICE),label.to(DEVICE)
        #前向计算（将数据输入模型得到输出）这里输出h(0.5，0.5)
        out = model(input_ids,attention_mask,token_type_ids)
        # 将out提取为可与label比较的值，如0或1
        out = out.argmax(dim=1)
        # label是数据集中的0或1，item表示获取标量，精度累加
        acc += (out==label).sum().item()
        print(i,(out==label).sum().item())
        total+=len(label)
        # 打印客观评估指标：如平均精度值，如下图
    print(f"test acc:{acc/total}")
```

**4.2主观评估**

> 人为挑选部分代表性数据，观察模型的输出结果-对生成式模型有效。
>
> 打印生成式用户实时输入的评价的好评还是差评，如下图。注意如果输出值与测试集不对，则要溯源测试集，这个label是谁打上去的，理由是什么。

![image](/img/2025-12-01_06-57-25.png)

evaluate1.py-主观评价(类似训练，训练集换成测试集)

> 与客观评价不同：这里就没有label值了，因为只有生成式的用户输入值

```python
#模型使用接口（主观评估）
#模型训练
import torch
from net import Model
from transformers import BertTokenizer

#定义设备信息
DEVICE = torch.device("cuda" if torch.cuda.is_available() else "cpu")

#加载字典和分词器
token = BertTokenizer.from_pretrained(r"D:\PycharmProjects\demo_02\model\bert-base-chinese\models--bert-base-chinese\snapshots\c30a6ed22ab4564dc1e3b2ecbf6e766b0611a33f")
# 模型实例化：将模型放到设备上
model = Model().to(DEVICE)
# 定义输出的枚举值，和前面的negative[1,0],positive[0,1]对应起来
names = ["负向评价","正向评价"]

#将传入的字符串进行编码
def collate_fn(data):
    # 与客观评价不同：这里就没有label值了，因为只有生成式的用户输入值
    sents = []
    sents.append(data)
    #编码
    data = token.batch_encode_plus(
        batch_text_or_text_pairs=sents,
        # 当句子长度大于max_length(上限是model_max_length)时，截断
        truncation=True,
        max_length=512,
        # 一律补0到max_length
        padding="max_length",
        # 可取值为tf,pt,np,默认为list
        return_tensors="pt",
        # 返回序列长度
        return_length=True
    )
    input_ids = data["input_ids"]
    attention_mask = data["attention_mask"]
    token_type_ids = data["token_type_ids"]
    return input_ids,attention_mask,token_type_ids

def test():
    #加载参数-模型训练后保存到本地的文件
    model.load_state_dict(torch.load("params/16_bert.pth"))
    #开启测试模型
    model.eval()

    while True:
        data = input("请输入测试数据（输入‘q’退出）：")
        if data=='q':
            print("测试结束")
            break
        # 先编码
        input_ids,attention_mask,token_type_ids = collate_fn(data)
        # 数据放到设备
        input_ids, attention_mask, token_type_ids = input_ids.to(DEVICE),attention_mask.to(DEVICE),token_type_ids.to(DEVICE)

        #将数据输入到模型，得到输出
        with torch.no_grad():# 冻结，不训练
            out = model(input_ids,attention_mask,token_type_ids)
            out = out.argmax(dim=1)
            # 打印生成式用户实时输入的评价的好评还是差评，如下图
            print("模型判定：",names[out],"\n")

if __name__ == '__main__':
    test()
```

过拟合

> 将训练集loss与验证集loss对比，两者比较接近且都逐渐下降，即正常。如果验证集loss到一定时候突然升高，可能存在过拟合，这时我们不要保存这些脏数据。
>
> 这种方法主要适用于分类模型，不适用生成式模型。

train_val.py

```python
#模型训练
import torch
from MyData import MyDataset
from torch.utils.data import DataLoader
from net import Model
from transformers import BertTokenizer,AdamW

#定义设备信息
DEVICE = torch.device("cuda" if torch.cuda.is_available() else "cpu")
#定义训练的轮次(将整个数据集训练完一次为一轮)
EPOCH = 30000

#加载字典和分词器
token = BertTokenizer.from_pretrained(r"D:\PycharmProjects\demo_02\model\bert-base-chinese\models--bert-base-chinese\snapshots\c30a6ed22ab4564dc1e3b2ecbf6e766b0611a33f")

#将传入的字符串进行编码
def collate_fn(data):
    sents = [i[0]for i in data]
    label = [i[1] for i in data]
    #编码
    data = token.batch_encode_plus(
        batch_text_or_text_pairs=sents,
        # 当句子长度大于max_length(上限是model_max_length)时，截断
        truncation=True,
        max_length=512,
        # 一律补0到max_length
        padding="max_length",
        # 可取值为tf,pt,np,默认为list
        return_tensors="pt",
        # 返回序列长度
        return_length=True
    )
    input_ids = data["input_ids"]
    attention_mask = data["attention_mask"]
    token_type_ids = data["token_type_ids"]
    label = torch.LongTensor(label)
    return input_ids,attention_mask,token_type_ids,label

#创建数据集-训练集
train_dataset = MyDataset("train")
train_loader = DataLoader(
    dataset=train_dataset,
    #训练批次
    batch_size=50,
    #打乱数据集
    shuffle=True,
    #舍弃最后一个批次的数据，防止形状出错
    drop_last=True,
    #对加载的数据进行编码
    collate_fn=collate_fn
)
#创建验证数据集-验证集
val_dataset = MyDataset("validation")
val_loader = DataLoader(
    dataset=val_dataset,
    #训练批次
    batch_size=50,
    #打乱数据集
    shuffle=True,
    #舍弃最后一个批次的数据，防止形状出错
    drop_last=True,
    #对加载的数据进行编码
    collate_fn=collate_fn
)
if __name__ == '__main__':
    #开始训练
    print(DEVICE)
    model = Model().to(DEVICE)
    #定义优化器
    optimizer = AdamW(model.parameters())
    #定义损失函数
    loss_func = torch.nn.CrossEntropyLoss()

    #初始化验证最佳准确率
    best_val_acc = 0.0

    for epoch in range(EPOCH):
        for i,(input_ids,attention_mask,token_type_ids,label) in enumerate(train_loader):
            #将数据放到DVEVICE上面
            input_ids, attention_mask, token_type_ids, label = input_ids.to(DEVICE),attention_mask.to(DEVICE),token_type_ids.to(DEVICE),label.to(DEVICE)
            #前向计算（将数据输入模型得到输出）
            out = model(input_ids,attention_mask,token_type_ids)
            #根据输出计算损失
            loss = loss_func(out,label)
            #根据误差优化参数
            optimizer.zero_grad()
            loss.backward()
            optimizer.step()

            #每隔5个批次输出训练信息
            if i%5 ==0:
                out = out.argmax(dim=1)
                #计算训练精度
                acc = (out==label).sum().item()/len(label)
                print(f"epoch:{epoch},i:{i},loss:{loss.item()},acc:{acc}")
        #验证模型（判断模型是否过拟合）
        #设置为评估模型即数据集选择validation数据集
        model.eval()
        #不需要模型参与训练
        with torch.no_grad():
            val_acc = 0.0
            val_loss = 0.0
            for i, (input_ids, attention_mask, token_type_ids, label) in enumerate(val_loader):
                # 将数据放到DVEVICE上面
                input_ids, attention_mask, token_type_ids, label = input_ids.to(DEVICE), attention_mask.to(
                    DEVICE), token_type_ids.to(DEVICE), label.to(DEVICE)
                # 前向计算（将数据输入模型得到输出）
                out = model(input_ids, attention_mask, token_type_ids)
                # 根据输出计算损失
                val_loss += loss_func(out, label)
                #根据数据，计算验证精度
                out = out.argmax(dim=1)
                val_acc+=(out==label).sum().item()
            val_loss/=len(val_loader)
            val_acc/=len(val_loader)
            print(f"验证集：loss:{val_loss},acc:{val_acc}")
            #根据验证准确率保存最优参数，如果验证集过拟合，则不保存过拟合数据，best_bert文件防止了过拟合
            if val_acc > best_val_acc:
                best_val_acc = val_acc
                torch.save(model.state_dict(),"params1/best_bert.pth")
                print(f"EPOCH:{epoch}:保存最优参数：acc{best_val_acc}")
        #保存最后一轮参数
        torch.save(model.state_dict(), "params1/last_bert.pth")
        print(f"EPOCH:{epoch}:最后一轮参数保存成功！")
```

## GPT2-中文生成模型定制化

### 中文白话文续写

中文白话文续写，如下图，生成式模型的原理核心：上一次的整体输出作为下一次的输入，传给大模型，依次递归处理。

![image](/img/2025-12-02_08-18-11.png)

生成模型的后处理即对话模板

> 模型的回答一般是有长有短，这就用到对话模板，即遇到结束符CLS则停止文本生成。

```python
#中文白话文续写
from transformers import GPT2LMHeadModel,BertTokenizer,TextGenerationPipeline

# 加载模型和分词器
model = GPT2LMHeadModel.from_pretrained(r"D:\BaiduNetdiskDownload\gpt2-chinese模型\models--uer--gpt2-chinese-cluecorpussmall\snapshots\c2c0249d8a2731f269414cc3b22dff021f8e07a3")
tokenizer = BertTokenizer.from_pretrained(r"D:\BaiduNetdiskDownload\gpt2-chinese模型\models--uer--gpt2-chinese-cluecorpussmall\snapshots\c2c0249d8a2731f269414cc3b22dff021f8e07a3")
print(model)

#使用Pipeline调用模型
text_generator = TextGenerationPipeline(model,tokenizer,device="cuda")

#使用text_generator生成文本
#do_sample是否进行随机采样。为True时，每次生成的结果都不一样；为False时，每次生成的结果都是相同的。
for i in range(3):
    print(text_generator("这是很久之前的事情了,", max_length=100, do_sample=False))
```

GPT2LMHeadModel模型结果，如下图

![image](/img/2025-12-02_08-27-14.png)

> - 1.embedding模型(gpt2Model),负责分词、词向量化
> - 2.h-ModuleList模型，负责特征提取
> - 3.lm_head，输出头即生成头，负责输出内容的，是核心

### 本地训练GPT2中文模型 -全量微调+训练权重

**全量微调**

先准备数据集，然后全量微调,因为白话文模型参数小，方便做全量微调。

打印一行行诗，如下图

![image](/img/2025-12-02_19-44-13.png)

```python
from torch.utils.data import Dataset
# 数据集准备
class MyDataset(Dataset):
    def __init__(self):
        # 读取本地古诗文本
        with open("data/chinese_poems.txt",encoding="utf-8") as f:
            # 一行诗一行读取数据
            lines = f.readlines()
        lines = [i.strip() for i in lines]
        self.lines = lines

    def __len__(self):
        return len(self.lines)

    def __getitem__(self, item):
        return self.lines[item]

if __name__ == '__main__':
    dataset = MyDataset()
    for data in dataset:
        # 打印一行行诗，如下图
        print(data)
```

打印训练信息，如下图

![image](/img/2025-12-02_19-41-51.png)

```python
from transformers import AdamW
from transformers.optimization import get_scheduler
import torch
from data import MyDataset  # 导入自定义的数据集类
from transformers import AutoModelForCausalLM, AutoTokenizer  # 导入transformers的模型和分词器类
from torch.utils.data import DataLoader  # 导入PyTorch的数据加载器类

# 将古诗文本喂个白话文模型，训练让它学习作古诗
# 实例化自定义数据集
dataset = MyDataset()  # 创建数据集对象

# 加载预训练的分词器，用于文本编码
tokenizer = AutoTokenizer.from_pretrained(r"D:\BaiduNetdiskDownload\gpt2-chinese模型\models--uer--gpt2-chinese-cluecorpussmall\snapshots\c2c0249d8a2731f269414cc3b22dff021f8e07a3")
# 加载预训练的模型，用于语言模型任务
model = AutoModelForCausalLM.from_pretrained(r"D:\BaiduNetdiskDownload\gpt2-chinese模型\models--uer--gpt2-chinese-cluecorpussmall\snapshots\c2c0249d8a2731f269414cc3b22dff021f8e07a3")

# 定义一个函数，用于将文本数据转换为模型所需的格式
def collate_fn(data):
    # 使用分词器对数据进行编码，并填充或截断到固定长度
    data = tokenizer.batch_encode_plus(data,
                                       padding=True,  # 填充序列
                                       truncation=True,  # 截断序列
                                       max_length=512,  # 最大长度
                                       return_tensors='pt')  # 返回PyTorch张量
    # 复制输入ID作为标签，用于语言模型训练。输出赋值给输入的数据集的labels
    data['labels'] = data['input_ids'].clone()
    return data

# 使用DataLoader创建数据加载器，用于批量加载数据
loader = DataLoader(
    dataset=dataset,  # 指定数据集
    batch_size=2,  # 指定批量大小
    shuffle=True,  # 打乱数据
    drop_last=True,  # 如果最后一个批次的数据量小于batch_size，则丢弃
    collate_fn=collate_fn  # 指定如何从数据集中收集样本到批次中
)
print(f"数据的长度：{len(loader)}")  # 打印数据加载器中的批次数量

# 定义训练函数
def train():
    # 定义训练参数
    EPOCH = 3000  # 训练轮数
    global model  # 使用全局模型变量
    DEVICE = "cuda" if torch.cuda.is_available() else "cpu"  # 检测是否有GPU，如果有则使用，否则使用CPU
    # 区别前面的Bert的增量微调，这里使用全量微调，
    model = model.to(DEVICE)  # 将模型移动到指定设备

    # 定义优化器
    optimizer = AdamW(model.parameters(), lr=2e-5)  # 使用AdamW优化器，并设置学习率
    # 定义学习率调度器
    scheduler = get_scheduler(name="linear",  # 线性调度器
                              num_warmup_steps=0,  # 预热步数
                              num_training_steps=len(loader),  # 总训练步数
                              optimizer=optimizer)
    model.train()  # 将模型设置为训练模式
    for epoch in range(EPOCH):  # 循环每一轮训练
        for i, data in enumerate(loader):  # 遍历数据加载器中的批次
            for k in data.keys():  # 将数据移动到指定设备
                data[k] = data[k].to(DEVICE)
            # 将data解包
            out = model(**data)  # 前向传播
            loss = out['loss']  # 获取损失

            loss.backward()  # 反向传播
            torch.nn.utils.clip_grad_norm_(model.parameters(), 1.0)  # 梯度裁剪，防止梯度爆炸
            optimizer.step()  # 更新模型参数
            scheduler.step()  # 更新学习率

            optimizer.zero_grad()  # 清空优化器的梯度
            model.zero_grad()  # 清空模型的梯度

            if i % 50 == 0:  # 每隔50个批次打印一次信息
                labels = data["labels"][:, 1:]  # 获取真实标签，忽略<bos>标记
                out = out["logits"].argmax(dim=2)[:,:-1]  # 获取预测结果，忽略<eos>标记

                select = labels != 0  # 选择非填充的标签
                labels = labels[select]  # 应用选择
                out = out[select]  # 应用选择
                del select  # 删除不再使用的select
                # 计算准确率
                acc = (labels == out).sum().item() / labels.numel()  # 计算准确率的公式
                lr = optimizer.state_dict()["param_groups"][0]['lr']  # 获取当前学习率

                # 打印训练信息，如下图
                print(f"epoch:{epoch},batch:{i},loss:{loss.item()},lr:{lr},acc:{acc}")

        # 保存最后一轮模型参数
        torch.save(model.state_dict(), "params/net.pt")  # 保存训练权重输出到文件保存
        print("权重保存成功！")  # 打印成功信息

# 当该脚本作为主程序运行时，调用训练函数
if __name__ == '__main__':
    train()  # 开始训练过程
```

**模型学习训练权重**

不加载训练权重，如下图，乱七八糟

![image](/img/2025-12-03_20-24-15.png)

加载训练权重即模型训练的结果net.pt，如下图，有一定关联

![image](/img/2025-12-03_20-24-54.png)

```python
# 模型学习训练权重
from transformers import AutoModelForCausalLM,AutoTokenizer,TextGenerationPipeline
import torch

tokenizer = AutoTokenizer.from_pretrained(r"D:\BaiduNetdiskDownload\gpt2-chinese模型\models--uer--gpt2-chinese-cluecorpussmall\snapshots\c2c0249d8a2731f269414cc3b22dff021f8e07a3")
model = AutoModelForCausalLM.from_pretrained(r"D:\BaiduNetdiskDownload\gpt2-chinese模型\models--uer--gpt2-chinese-cluecorpussmall\snapshots\c2c0249d8a2731f269414cc3b22dff021f8e07a3")

#加载我们自己训练的权重（中文古诗词）-也可以不加载训练权重，注释即可
model.load_state_dict(torch.load("params/net.pt"))

#使用系统自带的pipeline工具生成内容
pipeline = TextGenerationPipeline(model,tokenizer,device=0)

print(pipeline("天高",max_length =24))
```

定制化的控制内容和格式输出，需要人为强制干预，如下图，五言诗诗句的感觉

![image](/img/2025-12-03_20-28-11.png)

```python
#定制化的控制内容和格式输出
import torch
from transformers import AutoTokenizer,AutoModelForCausalLM

tokenizer = AutoTokenizer.from_pretrained(r"D:\BaiduNetdiskDownload\gpt2-chinese模型\models--uer--gpt2-chinese-cluecorpussmall\snapshots\c2c0249d8a2731f269414cc3b22dff021f8e07a3")
model = AutoModelForCausalLM.from_pretrained(r"D:\BaiduNetdiskDownload\gpt2-chinese模型\models--uer--gpt2-chinese-cluecorpussmall\snapshots\c2c0249d8a2731f269414cc3b22dff021f8e07a3")

#加载我们自己训练的权重（中文古诗词），如果训练权重是CPU设备训练出来的就选cpu,如果是GPU设备的cuda训练出来的就选gpu
model.load_state_dict(torch.load("params/net.pt",map_location="cpu"))

#定义函数，用于生成5言绝句 text是提示词，row是生成文本的行数，col是每行的字符数。
def generate(text,row,col):

    #定义一个内部递归函数，用于生成文本，因为不知道循环的次数
    def generate_loop(data):
        #禁用梯度计算
        with torch.no_grad():
            #使用data字典中的数据作为模型输入，并获取输出
            out = model(**data)
        #获取最后一个字(logits未归一化的概率输出)
        out = out["logits"]
        #选择每个序列的最后一个logits，对应于下一个词的预测
        out = out[:,-1]

        #找到概率排名前50的值，以此为分界线，小于该值的全部舍去
        topk_value = torch.topk(out,50).values
        #获取每个输出序列中前50个最大的logits（为保持原维度不变，需要对结果增加一个维度，因为索引操作会降维）。设置前50个大概率
        topk_value = topk_value[:,-1].unsqueeze(dim=1)
        #将所有小于第50大的值的logits设置为负无穷，减少低概率词的选择。设置50个以后的极低概率，可以认为是0
        out = out.masked_fill(out < topk_value,-float("inf"))

        #将特殊符号的logits值设置为负无穷，防止模型生成这些符号。排除特殊字符
        for i in ",.()《》[]「」{}，。":
            out[:,tokenizer.get_vocab()[i]] = -float('inf')
        #去特殊符号
        out[:, tokenizer.get_vocab()["[UNK]"]] = -float('inf')
        #根据概率采样，无放回，避免生成重复的内容
        out = out.softmax(dim=1)
        #从概率分布中进行采样，选择下一个词的ID
        out = out.multinomial(num_samples=1)

        #强制添加标点符号
        #计算当前生成的文本长度于预期的长度的比例
        c = data["input_ids"].shape[1] / (col+1)
        #如果当前的长度是预期长度的整数倍，则添加标点符号
        if c % 1 ==0:
            if c % 2 ==0:
                #在偶数位添加句号
                out[:,0] = tokenizer.get_vocab()["."]
            else:
                #在奇数位添加逗号
                out[:,0] = tokenizer.get_vocab()[","]
        #将生成的新词ID添加到输入序列的末尾
        data["input_ids"] = torch.cat([data["input_ids"],out],dim=1)
        #更新注意力掩码，标记所有有效位置
        data["attention_mask"] = torch.ones_like(data["input_ids"])
        #更新token的ID类型，通常在BERTm模型中使用，但是在GPT模型中是不用的
        data["token_type_ids"] = torch.ones_like(data["input_ids"])
        #更新标签，这里将输入ID复制到标签中，在语言生成模型中通常用与预测下一个词
        data["labels"] = data["input_ids"].clone()

        #检查生成的文本长度是否达到或超过指定的行数和列数
        if data["input_ids"].shape[1] >= row*col + row+1:
            #如果达到长度要求，则返回最终的data字典
            return data
        #如果长度未达到要求，递归调用generate_loop函数继续生成文本
        return generate_loop(data)

    #生成3首诗词
    #使用tokenizer对输入文本进行编码，并重复3次生成3个样本。
    data = tokenizer.batch_encode_plus([text] * 3,return_tensors="pt")
    #移除编码后的序列中的最后一个token(结束符号)
    data["input_ids"] = data["input_ids"][:,:-1]
    #创建一个与input_ids形状相同的全1张量，用于注意力掩码
    data["attention_mask"] = torch.ones_like(data["input_ids"])
    # 创建一个与input_ids形状相同的全0张量，用于token类型ID
    data["token_type_ids"] = torch.zeros_like(data["input_ids"])
    #复制input_ids到labels，用于模型的目标
    data['labels'] = data["input_ids"].clone()

    #调用generate_loop函数开始生成文本
    data = generate_loop(data)

    #遍历生成的3个样本
    for i in range(3):
        #打印输出样本索引和对应的解码后的文本
        print(i,tokenizer.decode(data["input_ids"][i]))

if __name__ == '__main__':
    generate("白",row=4,col=5)
```

### 服务器训练GPT2中文模型-全量微调

**使用[AutoDL官网](https://autodl.com/market/list)租借服务器算力**

选择一个GPU16GB以上的服务器,GPU最好是RTX型号，方便后续环境使用

![image](/img/2025-12-03_18-41-00.png)

选择基础镜像下，Pytorch最新的版本即可，系统必须是ubuntu

![image](/img/2025-12-03_18-46-19.png)

最后租借成果

![image](/img/2025-12-03_18-49-50.png)

**安装vscode插件-Remote - SSH**

安装好后，添加远程服务器

![image](/img/2025-12-03_18-53-55.png)

然后依次输入租借服务器的账号密码

![image](/img/2025-12-03_18-55-57.png)

验证环境是否ok，执行nvidia-smi

![image](/img/2025-12-03_19-20-35.png)

注意后续把代码和模型都放在数据盘 root/autodl-tmp，防止每次开关机服务器实例数据丢失。

![image](/img/2025-12-03_19-21-20.png)

**上传模型和代码**

注意要复制服务器上的模型的绝对地址，放到代码中，同时可以适时修改训练批次，开始训练

![image](/img/2025-12-03_19-29-16.png)

如果需要实时查看设备GPU使用率，先安装工具pip install nvitop,执行nvitop即可

![image](/img/2025-12-03_19-34-04.png)

执行python train.py开始同步训练，注意第一次批次设置小点。vscdoe关了，训练就停止了。

建议在后台异步训练，执行nohub python -u  train.py & ,即使vscode关了，服务器上仍在训练，并输出结果到nohub.out文件中。

如何停止后台训练，top命令查看python占用多的那条pid，执行kill -9 对应pid

## 服务器私有化部署大模型

### 魔塔社区ModelScope-了解原理 

> 优点：模型完整，适合高度定制。缺点：开发难度大。用于下载模型到本地。

国内下载模型使用阿里的[魔塔社区](https://www.modelscope.cn/my/mynotebook/preset)，在我的mynotebook中有免费的33h的GPU实例使用。

注意后续把代码和模型都放在数据盘 mnt/workspace，防止每次开关机服务器实例数据丢失。

启动免费的阿里云实例

![image](/img/2025-12-04_19-44-11.png)

训练一般采用0.5B-7B之间的模型，太大的话GPU的24g就不够用了。我们采用[千问的0.6B模型](https://www.modelscope.cn/models/Qwen/Qwen3-0.6B/files)，如果是其他服务器，需要先安装pip install modelscope，阿里云是天然集成的。一定要选SDK下载，git下载模型可能报错。

![image](/img/2025-12-04_19-48-07.png)

验证环境是否ok，执行nvidia-smi

SDK下载模型脚本文件download.py

```python
#模型下载
from modelscope import snapshot_download
# cache_dir是服务器上的绝对路径，使用pwd查看就能看到
model_dir = snapshot_download('Qwen/Qwen3-0.6B',cache_dir='/mnt/workspace/llm')
```

执行python download.py，模型就会下载到服务器上。

注意有的时候可能会下载两分一模一样的模型，删除一个保留一个都行，

![image](/img/2025-12-06_09-20-54.png)

模型目录

![image](/img/2025-12-06_09-21-54.png)

config.json

> - torch_dtype: "bfloat16",//数据的精度，一般大模型都是32位 单精度。16位相当于精度减半，也叫量化后的模型。好处：模型体积降低，计算速度更快。量化的意义在于加速模型推理，降低硬件依赖。模型体积=0.5BX16
> - vocab_size: 151936//。字典数有15w个字符，包括中英文等特殊字符。

generation_config.json

> - temperature: 0.6,//输出的文本质量通过这3个参数控制
>
>   top_k: 20,
>
>   top_p: 0.95,

tokenizer.json

> - content:"<|im_start|>",//图像的开头 所有的大模型都有这种开头和结尾特殊字符，用来判断文本开始和结束。后面可用于多模态对接。
> - content:"<|im_end|>",//图像的结尾
> - model_max_lenth:131072//支持最大的输入长度即131072个token，token是由分词器决定的。大模型收费也是按照token收费的。
> - tokenizer_class:"QwenTokenizer"// 千问的分词工具

vacab.json

> 字典库，有些模型是内置的，不对外开放，防止用户修改，导致模型错误。

**使用transformer加载qwen模型**

> 这种属于手写加载大模型，基本不常用，主要了解原理

test01_ModelScope.py

```python
#使用transformer加载qwen模型
from transformers import AutoModelForCausalLM,AutoTokenizer

DEVICE = "cuda"

#加载本地模型路径为该模型配置文件所在的根目录
model_dir = "/mnt/workspace/llm/Qwen/Qwen3-0.6B"

#使用transformer加载模型
model = AutoModelForCausalLM.from_pretrained(model_dir,torch_dtype="auto",device_map="auto")
tokenizer = AutoTokenizer.from_pretrained(model_dir)

#调用模型
#定义提示词
prompt = "你好，请介绍下你自己。"
#将提示词封装为message
message = [{"role":"system","content":"You are a helpful assistant system"},{"role":"user","content":prompt}]
#使用分词器的apply_chat_template()方法将上面定义的消息列表进行转换;tokenize=False表示此时不进行令牌化
# 令牌化：将文本转为input_ids数据
text = tokenizer.apply_chat_template(message,tokenize=False,add_generation_prompt=True)

#将处理后的文本令牌化并转换为模型的输入张量，是数组的text,并输出到本地DEVICE设备上
model_inputs = tokenizer([text],return_tensors="pt").to(DEVICE)

#将数据输入模型得到输出,结果是字典中对应的索引值，如下图
response = model.generate(model_inputs.input_ids,max_new_tokens=512)
print(response)

#对输出的内容进行解码还原，将索引值还原为文本，如下图
response = tokenizer.batch_decode(response,skip_special_tokens=True)
print(response)
```

将数据输入模型得到输出,结果是字典中对应的索引值，如下图。对输出的内容进行解码还原，将索引值还原为文本，如下图

![image](/img/2025-12-06_09-51-42.png)

### Ollama部署大模型-个人用户

> 优点：适合个人用户，模型小，速度快。缺点：效果不好。

安装conda的环境,自行百度，类似虚拟机环境，方便后续安装其他软件。注意所有命令都要先激活进入环境ollamaEnv。

> 查看conda下的所有环境列表，执行conda info --envs
>
> 如果电脑空间不够，可删除虚拟任意环境，conda remove -n ollamaEnv --all

> 创建一个虚拟环境,执行conda create -n ollamaEnv，然后激活进入环境ollamaEnv，执行conda activate ollamaEnv。ollamaEnv只是随便一个环境名称，不是真正的ollama

> 注意先激活进入环境ollamaEnv，然后到[ollama官网](https://ollama.com/download/linux)下载ollama，执行curl -fsSL https://ollama.com/install.sh | sh ，下载完后启动ollama,先激活进入环境ollamaEnv，执行ollama serve，注意后续这个控制台窗口不要关闭。

激活进入环境ollamaEnv，查看本地ollama的模型列表，执行ollama list,，初始是空的，如下图

![image](/img/2025-12-06_10-15-28.png)

> 拉取Qwen模型并启动模型，执行ollama run qwen3:0.6b。后面可以使用Api调用大模型服务。

ModelScope和ollama下载的模型差异：

![image](/img/2025-12-06_11-17-52.png)

> - ModelScope常用的模型是safetensors格式，如1.5G
> - ollama的模型都是GGUF格式，所以两者不互通用,如500M。这是因为它是阉割版，也叫量化版，是被缩小量化过的。如果ollama平台要使用ModelScope上的模型，要么搜索[qwen GGUF](https://modelscope.cn/models/Qwen/Qwen3-0.6B-GGUF/files)的模型，要么将safetensors转换为GGUF格式。优点：适合个人用户，模型小，速度快。缺点：效果不好。

**API的方式加载qwen模型**

test02_ollama_one.py

```python
#使用openai的API风格调用ollama平台的模型
from openai import OpenAI

# api_key是公开的，可以随便写
client = OpenAI(base_url="http://localhost:11434/v1/",api_key="suibianxie")
# model一定是命令ollama list下存在的模型名称
chat_completion = client.chat.completions.create(
    messages=[{"role":"user","content":"你好，请介绍下你自己。"}],model="Qwen3-0.6B"
)
print(chat_completion.choices[0])
```

test03_ollama_multipy.py

```python
#使用openai的API风格调用ollama平台的模型，并进行多轮对话
from openai import OpenAI

#定义多轮对话方法
def run_chat_session():
    #初始化客户端
    client = OpenAI(base_url="http://localhost:11434/v1/",api_key="suibianxie")
    #初始化对话历史
    chat_history = []
    #启动对话循环
    while True:
        #获取用户输入
        user_input = input("用户：")
        if user_input.lower() == "exit":
            print("退出对话。")
            break
        #更新对话历史(添加用户输入)，注意角色是用户
        chat_history.append({"role":"user","content":user_input})
        #调用模型回答
        try:
            chat_complition = client.chat.completions.create(messages=chat_history,model="Qwen3-0.6B")
            #获取最新回答
            model_response = chat_complition.choices[0]
            print("AI:",model_response.message.content)
            #更新对话历史（添加AI模型的回复）,注意角色是助手
            chat_history.append({"role":"assistant","content":model_response.message.content})
        except Exception as e:
            print("发生错误：",e)
            break
if __name__ == '__main__':
    run_chat_session()
```

### vLLM部署大模型-商业客户

> 优点：适合商业用途，支持ModelScope的safetensors格式文件。缺点：限制比较多，注意下显卡要求。

vLLM 包含预编译的 C++ 和 CUDA (12.1) 二进制库，注意只支持linux系统和cuda12.1,

> 创建一个虚拟环境,执行conda create -n vLLMEnv python=3.12 -y，然后激活进入环境vLLMEnv ，执行conda activate vLLMEnv 。vLLMEnv 只是随便一个环境名称，不是真正的vLLM

> 注意先激活进入环境vLLMEnv ，然后执行pip install vllm ,安装vllm。

> 启动本地大模型服务，这里采用之前下载的本地绝对路径模型，执行vllm serve /mnt/workspace/llm/Qwen/Qwen3-0.6B --dType=half 。其中--dType=half表示平台支持的是半精度，看启动过程中是否有报错提示而添加。注意后续这个控制台窗口不要关闭。

**API的方式加载qwen模型**

> 同ollama一样代码，只需修改*base_url*端口为8000，*model*为本地绝对路径 /mnt/workspace/llm/Qwen/Qwen3-0.6B

### LMDeploy部署大模型-推荐  

> 优点：适合大多数场景，支持ModelScope的safetensors格式文件，显存优化明显。缺点：注意下显卡要求。

[母公司书生](https://internlm.intern-ai.org.cn/)，它的大模型开源工具链体系比较厉害，尤其是Xtuner,LMDeploy,OpenCompass工具。

[LMDeploy官网](https://lmdeploy.readthedocs.io/zh-cn/latest/)，支持在 Linux 和 Windows 平台上部署 LLMs 和 VLMs，最低要求 CUDA 版本为 11.3。

> 同前面一样，创建一个虚拟环境
>
> conda create -n lmdeployEnv python=3.10 -y
> conda activate lmdeployEnv
> pip install lmdeploy

> 使用ModelScope拉取Qwen模型并启动模型，执行lmdeploy serve api_server /mnt/workspace/llm/Qwen/Qwen3-0.6B。后面可以使用Api调用大模型服务。

**API的方式加载qwen模型**

> 同ollama一样代码，只需修改*base_url*端口为23333，*model*为本地绝对路径 /mnt/workspace/llm/Qwen/Qwen3-0.6B

## 大模型微调

### LORA微调

定义：LoRA 是一种用于微调大型语言模型的技术， 通过低秩近似方法降低适应数十亿参数模型（如 GPT-3） 到特定任务或领域。  属于局部微调的一种，设计思路很巧妙。

**微调的实际落地方向**

> 注：微调不能做专业的问答系统，因为存在幻觉和无法动态适应业务场景。专业的问答系统一般是基于RAG
>
> - 模型的自我认知改变(如：名称、功能介绍)
> - 模型的对话风格

**原理**

> - 训练时， 输入分别与原始权重和两个低秩矩阵进行计算， 共同得到最终结果， 优化则仅优化A和B
> - 训练完成后， 可以将两个低秩矩阵与原始模型中的权重进行合并，合并后的模型与原始模型无异

![image](/img/2025-12-08_22-09-58.png)

**基于LORA微调的平台**

- 基于LLaMA-Factory可视化界面
- 基于书生公司的Xtuner命令行

**LLaMA-Factory使用**

[官网](https://github.com/hiyouga/LLaMA-Factory/blob/main/README_zh.md)

> - **多种模型**：LLaMA、LLaVA、Mistral、Mixtral-MoE、Qwen、Qwen2-VL、DeepSeek、Yi、Gemma、ChatGLM、Phi 等等。
> - **集成方法**：（增量）预训练、（多模态）指令监督微调、奖励模型训练、PPO 训练、DPO 训练、KTO 训练、ORPO 训练等等。
> - **多种精度**：16 比特全参数微调、冻结微调、LoRA 微调和基于 AQLM/AWQ/GPTQ/LLM.int8/HQQ/EETQ 的 2/3/4/5/6/8 比特 QLoRA 微调。
> - **先进算法**：[GaLore](https://github.com/jiaweizzhao/GaLore)、[BAdam](https://github.com/Ledzy/BAdam)、[APOLLO](https://github.com/zhuhanqing/APOLLO)、[Adam-mini](https://github.com/zyushun/Adam-mini)、[Muon](https://github.com/KellerJordan/Muon)、[OFT](https://github.com/huggingface/peft/tree/main/src/peft/tuners/oft)、DoRA、LongLoRA、LLaMA Pro、Mixture-of-Depths、LoRA+、LoftQ 和 PiSSA。
> - **实用技巧**：[FlashAttention-2](https://github.com/Dao-AILab/flash-attention)、[Unsloth](https://github.com/unslothai/unsloth)、[Liger Kernel](https://github.com/linkedin/Liger-Kernel)、[KTransformers](https://github.com/kvcache-ai/ktransformers/)、RoPE scaling、NEFTune 和 rsLoRA。
> - **广泛任务**：多轮对话、工具调用、图像理解、视觉定位、视频识别和语音理解等等。
> - **实验监控**：LlamaBoard、TensorBoard、Wandb、MLflow、[SwanLab](https://github.com/SwanHubX/SwanLab) 等等。
> - **极速推理**：基于 [vLLM](https://github.com/vllm-project/vllm) 或 [SGLang](https://github.com/sgl-project/sglang) 的 OpenAI 风格 API、浏览器界面和命令行接口。

安装

> 新建一个虚拟环境:conda create -n llamaFactoryEnv python=3.10 -y j激活 conda activate llamaFactoryEnv 
>
> git clone --depth 1 https://github.com/hiyouga/LLaMA-Factory.git
> 进入目录，cd LLaMA-Factory
> 安装基础依赖，pip install -e .

启动可视化界面

> llamafactory-cli webui // 需要有vscode的ssh插件，能自动打开可视化窗口,要进入到根目录下执行

开始微调训练

> 修改默认的数据集identity.json的内容

![image](/img/2025-12-08_22-55-40.png)

> 可视化窗口设置参数，点击开始训练

![image](/img/2025-12-08_23-01-44.png)

![image](/img/2025-12-08_23-04-14.png)

![image](/img/2025-12-08_23-06-01.png)

> 训练完成过程中，每隔100个轮次，在根目录下的save文件夹中，生成检查点文件及权重文件，checkpoint100、checkpoint200等

![image](/img/2025-12-10_19-16-06.png)

当loss不再明显下降或水平平滑，可停止训练。

![image](/img/2025-12-11_19-54-21.png)

手工验证训练后的模型效果，配置最后一个训练点的权重文件，点击加载模型

![image](/img/2025-12-10_19-20-12.png)

底部可以开始对话

![image](/img/2025-12-10_19-22-50.png)

**LLaMA-Factory自定义数据集**

[LLaMA-Factory中文文档](https://llamafactory.readthedocs.io/zh-cn/latest/getting_started/data_preparation.html#id4)，要求单轮和多轮对话支持的数据结构如下：

```
// 单轮对话
{
    "instruction": "问题（必填）",
    "input": "问题相关的（选填）",
    "output": "回答（必填）",
  }
// 多轮对话
  {
    "instruction": "问题（必填）",// 这是当前的第三轮-问题
    "input": "问题相关的（选填）",
    "output": "回答（必填）",// 这是当前的第三轮-回答
    "system": "系统提示词（选填）",
    "history": [
      ["第一轮指令（选填）", "第一轮回答（选填）"],
      ["第二轮指令（选填）", "第二轮回答（选填）"]
    ]
  }
```

原始数据集选取modelscope上弱智吧的[数据集](https://modelscope.cn/datasets/w10442005/ruozhiba_qa/dataPeview)，数据格式如下：

```
    {
        "system": "00000",
        "query": "只剩一个心脏了还能活吗？",
        "response": "能，人本来就只有一个心脏。"
    },
```

*重要重要重要：学会让大模型工具帮我们生成代码*

1.手动点击下载原始数据ruozhiba_qaswift.json，将原始数据转为llmaFactory支持的数据结构

![image](/img/2025-12-11_19-24-00.png)

```python
# 原始数据转为llmaFactory支持的数据结构
import json

# 读取原始JSON文件
input_file = "data/ruozhiba_qaswift.json"  # 你的JSON文件名
output_file = "data/ruozhiba_qaswift_train.json"  # 输出的JSON文件名

with open(input_file, "r", encoding="utf-8") as f:
    data = json.load(f)

# 转换后的数据
converted_data = []

for item in data:
    converted_item = {
        "instruction": item["query"],
        "input": "",
        "output": item["response"]
    }
    converted_data.append(converted_item)

# 保存为JSON文件（最外层是列表）
with open(output_file, "w", encoding="utf-8") as f:
    json.dump(converted_data, f, ensure_ascii=False, indent=4)

print(f"转换完成，数据已保存为 {output_file}")
```

2.本地转换好数据集后，放入大data目录下，并配置

![image](/img/2025-12-11_19-30-30.png)

3.启动llmaFactory,选择对应数据集开始训练

> 根目录执行llamafactory-cli webui

![image](/img/2025-12-11_19-32-18.png)

4.客观评估和主观评估

![image](/img/2025-12-11_20-00-52.png)

客观评估结果如下图：

![image](/img/2025-12-11_20-09-31.png)

主观评估如下图：

![image](/img/2025-12-13_08-30-12.png)

**Lora模型合并与量化导出**  

训练后的目录

![image](/img/2025-12-11_19-51-36.png)

配置合并导出

![image](/img/2025-12-13_08-37-37.png)

看下合并后的模型效果，不错

![image](/img/2025-12-13_08-40-27.png)

基于合并的模型，我们也可以继续做量化即阉割量化模型。

量化模型：原模型是数据格式是Float16位对硬件要求高，我们降低到8位或4位(如q8或q4)，适配低配置低算力硬件(如ollama)。如果再低，模型效果就不好了。

配置量化并导出

![image](/img/2025-12-13_08-58-11.png)

看下量化后的模型效果，效果很差。原因：最初的原始模型是qwen-0.5B，太小了，一般模型5B以上，量化效果才能维持原模型效果。

![image](/img/2025-12-13_08-59-57.png)

**使用 open-webui部署模型**

linux上安装open-webui

> 同前面一样，创建一个虚拟环境
>
> conda create -n openWebUIEnv python=3.11 -y
> conda activate openWebUIEnv 
> pip install open-webui

配置open-webui

![image](/img/2025-12-13_09-26-13.png)

启动open-webui，执行open-webui serve。

访问localhost:3000

### QLORA微调

定义：QLoRA 是一种高效的大型语言模型微调方法， 它显著降低了内存使用量， 同时保持了全 16 位微调的性能。 它通过在一个固定的、 4 位量化的预训练语言模型中反向传播梯度到低秩适配器来实现这一目标。

与LORA不同的是，它采用降低模型参数精度来节约训练的显存，使模型训练更快。因为模型的参数已经固定，降低精度一定会影响结果。在量化微调中，量化只发生在内部训练过程，并不影响模型的最终的数据类型(模型原有的参数类型是f16,在量化微调训练中会量化为8位，参数保存时又还原为f16,量化微调不影响模型本身的参数类型)  

> 加速方式：falshatten2，只支持显卡SM70以上

<img src="/img/2025-12-15_19-52-33.png" style="zoom:100%;" />

注意一般loss前面几轮会先升高再降低，升高是因为模型比较大数据集比较小，后面会逐渐降低。

<img src="/img/2025-12-16_08-18-13.png" style="zoom:100%;" />

然后同前面LoRA一样，合并导出。

### GGUF

> 定义：GGUF 格式的全名为（GPT-Generated Unified Format） ， 提到GGUF 就不得不提到它的前身 GGML（GPT-Generated Model Language） 。 GGML 是专门为了机器学习设计的张量库， 最早可以追溯到 2022/10。 其目的是为了有一个单文件共享的格式， 并且易于在不同架构的 GPU 和 CPU 上进行推理。 但在后续的开发中， 遇到了灵活性不足、 相容性及难以维护的问题。  

> 与safetensors相比，GGUF格式的优势：
>
> 1） 可扩展性： 轻松为 GGML 架构下的工具添加新功能， 或者向 GGUF 模型添加新 Feature， 不会破坏与现有模型的兼容性。
>
> 2） 对 mmap（内存映射） 的兼容性： 该模型可以使用 mmap 进行加载（原理解析可见参考） ， 实现快速载入和存储。 （从 GGJT 开始导入， 可参考 GitHub）
>
> 3） 易于使用： 模型可以使用少量代码轻松加载和存储， 无需依赖的 Library， 同时对于不同编程语言支持程度也高。
>
> 4） 模型信息完整： 加载模型所需的所有信息都包含在模型文件中， 不需要额外编写设置文件。
>
> 5） 有利于模型量化： GGUF 支持模型量化（4 位、 8 位、 F16） ， 在 GPU 变得越来越昂贵的情况下， 节省 vRAM 成本也非常重要。

**将safetensors转化为GGUF**

1.需要用llama.cpp仓库的convert_hf_to_gguf.py脚本来转换  

```python
git clone https://github.com/ggerganov/llama.cpp.git
pip install -r llama.cpp/requirements.txt
```

2.执行转换  

```python
# 如果不量化，保留模型的效果
python llama.cpp/convert_hf_to_gguf.py /mnt/workspace/llm/Qwen/Qwen3-0.6B --outtype f16
--verbose --outfile /mnt/workspace/llm/Qwen/Qwen3-0.6B-gguf.gguf
# 如果需要量化（加速并有损效果），直接执行下面脚本就可以
python llama.cpp/convert_hf_to_gguf.py 绝对路径 --outtype
q8_0 --verbose --outfile 绝对路径-gguf_q8_0.gguf
```

> 这里--outtype是输出类型，代表含义：
> q2_k：特定张量（Tensor）采用较高的精度设置，而其他的则保持基础级别。
> q3_k_l、q3_k_m、q3_k_s：这些变体在不同张量上使用不同级别的精度，从而达到性能和效率的平衡。
> q4_0：这是最初的量化方案，使用 4 位精度。
> q4_1 和 q4_k_m、q4_k_s：这些提供了不同程度的准确性和推理速度，适合需要平衡资源使用的场景。
> q5_0、q5_1、q5_k_m、q5_k_s：这些版本在保证更高准确度的同时，会使用更多的资源并且推理速度较
> 慢。
> q6_k 和 q8_0：这些提供了最高的精度，但是因为高资源消耗和慢速度，可能不适合所有用户。
> fp16 和 f32: 不量化，保留原始精度。

3.使用ollama运行gguf  

```
安装并启动ollama
curl -fsSL https://ollama.com/install.sh | sh
ollama serve
```

创建ModelFile文件

```
#GGUF文件路径
FROM /mnt/workspace/llm/Qwen/Qwen3-0.6B-gguf.gguf
```

创建自定义模型  

```
ollama create Qwen3-0.6B-gguf --file ./ModeFile
```

查看并运行模型

```
ollama list
ollama run Qwen3-0.6B-gguf
```

### LLamaFactory微调效果与vllm部署效果不一致  

**1.生成式语言模型的对话模板**  

不同模型框架采用的模板是不一样的

1.1QWen大模型的对话模板

即使是同系列的同产商，不同版本的模型的对话模板也不相同。

<img src="/img/2026-01-18_18-09-01.png" style="zoom:50%;" />

**2.Lora微调后单独部署大模型输出结果 不一致**

训练时用的模板如下图

<img src="/img/2026-01-18_18-14-14.png" style="zoom:50%;" />

这些训练时用的模板在LLamaFactory源码目录中，如下图

<img src="/img/2026-01-18_18-21-42.png" style="zoom:50%;" />

因为训练时用的对话模板与推理时用的大模型的对话模板不一致

**3.使用XTuner微调大模型**

主要以主观评价为准，而LLamaFactory主要以客观评价为主。[XTuner](https://xtuner.readthedocs.io/zh-cn/stable/training/custom_sft_dataset.html)是高度自定义的代码处理指定对话模板，难度更大，但更灵活。

**4.vllm推理模型时自定义对话模板** 

案例： 使用vllm有效部署Lora微调后的Qwen模型  

1.将训练时用的llamaFactory的模板转换为[vllm部署](https://docs.vllm.com.cn/en/latest/serving/openai_compatible_server/#chat-template)时所用的模板(jinjia格式)

转换脚本myTest.py

```py
# mytest.py
import sys
import os

# 将项目根目录添加到 Python 路径
root_dir = os.path.dirname(os.path.dirname(os.path.dirname(os.path.dirname(os.path.abspath(__file__)))))
sys.path.append(root_dir)

from llamafactory.data.template import TEMPLATES
from transformers import AutoTokenizer

# 1. 初始化分词器（任意支持的分词器均可）
tokenizer = AutoTokenizer.from_pretrained("/root/autodl-tmp/llm/deepseek-ai/DeepSeek-R1-Distill-Qwen-1.5B")

# 2. 获取模板对象
template_name = "qwen"  # 替换为你需要查看的模板名称
template = TEMPLATES[template_name]

# 3. 修复分词器的 Jinja 模板
template.fix_jinja_template(tokenizer)

# 4. 直接输出模板的 Jinja 格式
print("=" * 40)
print(f"Template [{template_name}] 的 Jinja 格式:")
print("=" * 40)
print(tokenizer.chat_template)
```

2.将输出的代码复制保存为template.jinja文件

3.在vllm部署模型时，指定对话模板chat-template，执行vllm server xx --chat-template ./path-to-chat-template.jinja

LMDeploy(采用的是json格式数据)或ollama部署也是类似，要参考对应官方文档。

## 大模型分布式微调

### 简介

**为什么需要分布式训练？**

> 模型规模爆炸：现代大模型（如GPT-3、LLaMA等）参数量达千亿级别，单卡GPU无法存储完整模型。
> 计算资源需求：训练大模型需要海量计算（如GPT-3需数万GPU小时），分布式训练可加速训练过程。
> 内存瓶颈：单卡显存不足以容纳大模型参数、梯度及优化器状态。

**分布式训练的核心技术**

前提：必须要同型号显卡

方式1：数据并行即拆分数据（Data Parallelism）

> 原理： 将数据划分为多个批次， 分发到不同设备， 每个设备拥有完整的模型副本。
>
> 同步方式： 通过All-Reduce操作同步梯度（如PyTorch的DistributedDataParallel） 。
>
> 挑战： 通信开销大， 显存占用高（需存储完整模型参数和优化器状态） 。

方式2：模型并行即拆分模型（Model Parallelism）-推荐

> 原理： 将模型切分到不同设备（如按层或张量分片） 。
>
> 横向并行（层拆分） ： 将模型的层分配到不同设备。
>
> 纵向并行（张量拆分） ： 如Megatron-LM将矩阵乘法分片。
>
> 挑战： 设备间通信频繁， 负载均衡需精细设计。

方式3：流水线并行即数据和模型都拆分（Pipeline Parallelism, PP）

> 原理： 将模型按层划分为多个阶段（stage） ， 数据分块后按流水线执行。
>
> 优化： 微批次（Micro-batching） 减少流水线气泡（Bubble） 。
>
> 挑战： 需平衡阶段划分， 避免资源闲置。
>

其他方式，如混合并行（3D并行）组合策略： 结合数据并行、 模型并行、 流水线并行， 典型应用如训练千亿级模型。案例： 微软Turing-NLG、 Meta的LLaMA-2

### DeepSpeed训练

定位： 微软开源的分布式训练优化框架， 支持千亿参数模型训练。

核心目标： 降低大模型训练成本， 提升显存和计算效率。

集成生态： 与PyTorch无缝兼容， 支持Hugging Face Transformers库。

**核心技术**

ZeRO优化器（Zero Redundancy Optimizer）

> 原理： 通过分片优化器状态、 梯度、 参数， 消除数据并行中的显存冗余。优势： 显存占用随设备数线性下降， 支持训练更大模型。
>
> 阶段划分：
>
> ZeRO-1： 优化器状态分片(类似数据并行)。
>
> ZeRO-2(推荐)： 梯度分片(类似反向拆分) + 优化器状态分片。
>
> ZeRO-3： 参数分片(类似模型并行) + 梯度分片 + 优化器状态分片。

**显存优化技术**

> 梯度检查点（Activation Checkpointing） ： 用时间换空间， 减少激活值显存占用。
>
> CPU Offloading： 将优化器状态和梯度卸载到CPU内存。
>
> 混合精度训练： FP16/BP16与动态损失缩放（Loss Scaling） 。
>
> 其他特性
>
> 大规模推理支持： 模型并行推理（如ZeRO-Inference） 。
>
> 自适应通信优化： 自动选择最佳通信策略（如All-Reduce vs. All-Gather） 。

**优势与特点**

> 显存效率高： ZeRO-3可将显存占用降低至1/设备数。
>
> 易用性强： 通过少量代码修改即可应用（如DeepSpeed配置JSON文件） 。
>
> 扩展性优秀： 支持千卡级集群训练。
>
> 开源社区支持： 持续更新， 与Hugging Face等生态深度集成。

**使用场景**

> 训练百亿/千亿参数模型（如GPT-3、 Turing-NLG） 。资源受限环境： 单机多卡训练时通过Offloading扩展模型规模。快速实验： 通过ZeRO-2加速中等规模模型训练。

### XTuner微调

[xtuner中文文档](https://xtuner.readthedocs.io/zh-cn/latest/index.html)

面向“超大规模 MoE 模型”的新一代 LLM 训练引擎（V1）。强调在大规模稀疏 MoE、长序列、分布式并行方面的深度优化。

**创建环境**

```
conda create --name xtuner-env python=3.10 -y
conda activate xtuner-env
```

拉取 XTuner 

```
git clone https://github.com/InternLM/xtuner.git// 不建议使用pip安装，因为下载下来没有源码。后续我们需要源码配置。
```

安装依赖  

```
cd xtuner
pip install -e '.[all]'
```

**下载模型**

```
from modelscope import snapshot_download
model_dir = snapshot_download('Shanghai_AI_Laboratory/internlm2-chat-
1_8b',cache_dir='/root/llm/internlm2-1.8b-chat')
```

**微调配置**

<img src="/img/2026-04-20_19-57-38.png" style="zoom:50%;" />

在下载好的模型中，复制xxxqlora_alpaca_e3.py配置文件到XTuner根目录下，修改这个配置文件

```py
### PART 1中
#预训练模型存放的位置
pretrained_model_name_or_path = '/root/llm/internlm2-1.8b-chat
#微调数据存放的位置
data_files = '/root/public/data/target_data.json'#基座模型路径(ruozhiba的数据简单转换所需要的格式数据)
# 训练中最大的文本长度
max_length = 512
# 每一批训练样本的大小
batch_size = 2
#最大训练轮数
max_epochs = 3
#验证数据
evaluation_inputs = [
'只剩一个心脏了还能活吗？', '爸爸再婚，我是不是就有了个新娘？',
'樟脑丸是我吃过最难吃的硬糖有奇怪的味道怎么还有人买','马上要上游泳课了，昨天洗的泳裤还没
干，怎么办',
'我只出生了一次，为什么每年都要庆生'
]

### PART 3中
dataset=dict(type=load_dataset, path="json",data_files=data_files)
# 因为我的数据集格式不在他的范围内，所以要禁用。如果是使用XTurner支持的开源数据集格式，则指定对应格式即可，如alpaca_map_Fn
dataset_map_fn=None
```

XTurner支持的开源数据集格式，如下图：

<img src="/img/2026-04-22_19-28-46.png" style="zoom:50%;" />

**微调训练**

具体命令：

```
xtuner train internlm2_chat_1_8b_qlora_alpaca_e3.py
```

**模型转换**

模型训练后会自动保存成 PTH 模型，如iter_2000.pth   (PyTorch格式)。如果是使用DeepSpeed，则将会是文件夹。需要利用 xtuner convert pth_to_hf 将其转换为 HuggingFace 模型，以便于后续使用。  

具体命令：

```
xtuner convert pth_to_hf ${FINETUNE_CFG} ${PTH_PATH} ${SAVE_PATH}
# FINETUNE_CFG是配置文件路径，PTH_PATH是PTH 模型路径，SAVE_PATH是要转换生成的模型路径
# 例如：xtuner convert pth_to_hf internlm2_chat_7b_qlora_custom_sft_e1_copy.py
./iter_2000.pth ./iter_2000_
```

**模型合并**

具体命令：

```
# LLM是原始模型路径，LLM_ADAPTER是上面生成的模型路径，SAVE_PATH是合并后的模型路径
xtuner convert merge ${LLM} ${LLM_ADAPTER} ${SAVE_PATH}
```

### LLamaFactory与XTuner多卡微调大模型

- LLamaFactory：图形化操作，是客观评价，每个权重文件都会保存。
- XTuner：指令化操作，是主观评价，只保存最后几个权重文件，更实用。

| 维度          | LLaMA Factory                                                | XTuner（InternLM）                                           |
| ------------- | ------------------------------------------------------------ | ------------------------------------------------------------ |
| 主要定位      | 多模型、多任务“微调工作台”：易用、多模态、全流程             | 超大规模 MoE/长序列“训练后端”：工业级并行与效率优化          |
| 模型覆盖      | 主流 100+ 模型：LLaMA/Qwen/Yi/Gemma/Baichuan/ChatGLM/Mistral/Mixtral 等readthedocs.io | 以 InternLM 系列为主，同时面向 MoE 通用能力（官方示例多为 InternLM 家族）github.com |
| 训练/微调任务 | PT、SFT、RLHF、DPO、KTO、ORPO、RM、多模态指令微调等readthedocs.io | PT、SFT、RLHF/PPO/DPO 等大模型训练阶段，强调 MoE 长序列readthedocs.io+1 |
| 并行/分布式   | DDP、DeepSpeed、FSDP/FSDP2、Ray 等常见方案readthedocs.io     | 针对大规模 MoE 的并行设计（“Dropless Training”）、DeepSpeed Ulysses 序列并行、FSDP 等github.com |
| 量化/低精度   | QLoRA（多后端）、多种 PTQ/QAT、bitsandbytes 等readthedocs.io | 以 BF16/FP8 等训练为主，强调整体并行与通信效率，对 MoE 训练更聚焦hiascend.com |
| 加速/算子     | FlashAttention-2、Unsloth、Liger Kernel 等readthedocs.io     | MoE/序列维度的算子与并行调度优化，针对 MoE 负载均衡、长序列内存优化github.com+1 |
| 硬件支持      | GPU；提供 NPU（Ascend）安装/训练/推理文档与 Docker 镜像readthedocs.io | GPU；与华为昇腾深度合作，有官方昇腾新闻与 A3 超节点性能数据hiascend.com |
| 易用性        | 零代码 WebUI、CLI、丰富示例与教程、中文文档完善github.com+1  | 配置式/脚本式，面向大规模训练，文档偏“后端/系统”视角readthedocs.io |
| 适用规模      | 7B～72B 为主；LoRA/QLoRA 下可在单卡或多卡完成；也支持 MoE 模型微调（但非其最核心优势）readthedocs.io | 从几十 B 到 200B/600B 甚至 T 级 MoE；针对超大规模 MoE 长序列训练做了深度优化github.com |

## 大模型压缩

**定义**

通过减少或减小模型参数，在不显著损失精度的前提下，把“大、慢、耗显存”的模型变成“小、快、省资源”的模型。在一些场景和设备上限制了相应的模型部署， 需要借助模型压缩、 优化加速、 异构计算等方法突破瓶颈。

主流压缩手段大致分为：剪枝、量化、知识蒸馏、低秩分解/结构变换等

> - 剪枝：结构或非结构剪枝，deep compression, channel pruning 和 network slimming等，没有太大商业价值  
> - 量化：线性或非线性量化， 1/2bits, int8 和 fp16等  
> - 知识蒸馏：主要是方便快速训练大模型

**剪枝**

定义：删掉“不太重要”的权重/通道/层。具体分为非结构化剪枝和结构化剪枝。

非结构化剪枝：通过连接级、 细粒度的剪枝 ，剪去可能不重要的分支

<img src="/img/2026-04-20_21-21-04.png" style="zoom:30%;" />

结构化剪枝：是filter级或layer级、 粗粒度的剪枝，剪去结构层

<img src="/img/2026-04-20_21-25-21.png" style="zoom:30%;" />

剪枝过程

本质是一个盲剪的过程，没有太大的商业实用价值。

<img src="/img/2026-04-20_21-36-29.png" style="zoom:50%;" />

**量化**

量化就是把高精度的数值按比例“四舍五入”成低比特的离散整数，用微小的精度损失换取巨大的存储和计算效率提升。

常规精度一般使用 FP32，大模型量化采用低精度 FP16（ 半精度浮点）或INT8  。有些模型采用混合精度（ Mixed precision），使用 FP32 和 FP16。比如：核心参数(激活函数)采用32/16位，非核心参数采用16/8位。为了位数统一输入和输出，需要反复的量化和反量化操作。

比如阉割的ollama框架，推理和训练中都涉及量化和反量化，如下图：

<img src="/img/2026-04-21_18-07-52.png" style="zoom:50%;" />

**知识蒸馏**

<img src="/img/2026-04-21_18-24-45.png" style="zoom:50%;" />

一句话：小模型通过两者比较的loss损失和自身的loss损失进行快速训练，得到大模型的能力。其中涉及温度T,开始时比较权重0.9，自身权重0.1。经过训练，依赖比较权重降低，自身权重增加，最后完全依赖自己。

> DeepSeek为什么火？就是因为它蒸馏了openAI的大模型。

<img src="/img/2026-04-21_18-35-35.png" style="zoom:50%;" />

<img src="/img/2026-04-21_18-40-28.png" style="zoom:50%;" />

> 知识蒸馏在DeepSeek中的核心意义  
>
> - 降低算力与成本：DeepSeek通过蒸馏技术将模型训练成本压缩至OpenAI同类模型的1/20  
> - 加速推理与边缘部署：蒸馏后的小模型（ 如32B/70B版本） 推理速度提升3倍以上， 延迟从850ms降至150ms， 显存占用从320GB减少至8GB。 这使得模型可在手机运行
> - 推动行业应用落地：教育领域生成个性化学习内容 ，工业场景本地化部署的蒸馏模型减少对云端的依赖
> - 技术自主可控：美国GPU芯片禁运， DeepSeek通过蒸馏技术降低对算力的依赖， 结合FP8混合精度训练和DualPipe流水线机制， 在国产芯片（ 如华为昇腾） 上实现高性能推理

蒸馏训练过程的完整代码如下：

```py
import torch
from transformers import AutoTokenizer, AutoModelForCausalLM, AdamW
# 该代码是初始版本，真正的大模型很大，用transformers无法加载，需要用到分布式DeepSeed，但思路一样
from torch.utils.data import Dataset, DataLoader
import torch.nn.functional as F


# ========== 配置参数 ==========
class Config:
    # 模型设置
    teacher_model_name = "Qwen/Qwen-7B"
    student_model_name = "Qwen/Qwen-1.8B"

    # 训练参数
    batch_size = 16 # 批次
    num_epochs = 3 # 轮次
    learning_rate = 2e-5 # 初始学习率
    max_seq_length = 512 # 最大数据长度
    temperature = 5.0 # 温度值
    alpha = 0.7  # 蒸馏损失权重

    # 设备设置
    device = "cuda" if torch.cuda.is_available() else "cpu"
    grad_accum_steps = 4  # 梯度累积步数


config = Config()


# ========== 数据加载 ==========
class DistillationDataset(Dataset):
    def __init__(self, tokenizer, sample_texts):
        self.tokenizer = tokenizer
        self.examples = []

        # 示例数据（实际需替换为真实数据集）
        sample_texts = [
            "人工智能的核心理念是",
            "大语言模型蒸馏的关键在于",
            "深度学习模型的压缩方法包括"
        ]

        for text in sample_texts:
            encoding = tokenizer(
                text,
                max_length=config.max_seq_length,
                padding="max_length",
                truncation=True,# 截断
                return_tensors="pt"# 返回pt格式
            )
            self.examples.append(encoding)

    def __len__(self):
        return len(self.examples)# 返回样本长度

    def __getitem__(self, idx):
        return {
            "input_ids": self.examples[idx]["input_ids"].squeeze(),
            "attention_mask": self.examples[idx]["attention_mask"].squeeze()
        }


# ========== 模型初始化 ==========
def load_models():
    # 加载教师模型（冻结老师模型的参数）
    teacher = AutoModelForCausalLM.from_pretrained(
        config.teacher_model_name,
        device_map="auto",
        torch_dtype=torch.bfloat16
    ).eval()

    # 加载学生模型
    student = AutoModelForCausalLM.from_pretrained(
        config.student_model_name,
        device_map="auto",
        torch_dtype=torch.bfloat16
    ).train()

    return teacher, student


# ========== 蒸馏损失函数 ==========
class DistillationLoss:
    @staticmethod
    def calculate(
            teacher_logits,  # 教师模型logits [batch, seq_len, vocab]批次 序列 词
            student_logits,  # 学生模型logits [batch, seq_len, vocab]
            temperature=config.temperature,# 温度值
            alpha=config.alpha #损失权重值
    ):
        # 软目标蒸馏损失
        soft_teacher = F.softmax(teacher_logits / temperature, dim=-1)
        soft_student = F.log_softmax(student_logits / temperature, dim=-1)
        # 损失差（相对熵）
        # 拿老师和学生的输出计算loss
        kl_loss = F.kl_div(
            soft_student,
            soft_teacher,
            reduction="batchmean",
            log_target=False
        ) * (temperature ** 2)

        # 学生自训练损失（交叉熵）
        shift_logits = student_logits[..., :-1, :].contiguous()
        shift_labels = teacher_logits.argmax(-1)[..., 1:].contiguous()
        # 拿模型自己的输出和标签的label计算loss
        ce_loss = F.cross_entropy(
            shift_logits.view(-1, shift_logits.size(-1)),
            shift_labels.view(-1)
        )
        # 利用损失权重和两个loss,计算最终的loss
        return alpha * kl_loss + (1 - alpha) * ce_loss


# ========== 训练流程 ==========
def train():
    # 初始化组件
    tokenizer = AutoTokenizer.from_pretrained(config.teacher_model_name)
    teacher, student = load_models()

    # 数据集示例
    dataset = DistillationDataset(tokenizer)
    dataloader = DataLoader(dataset, batch_size=config.batch_size)

    # 优化器设置
    optimizer = AdamW(student.parameters(), lr=config.learning_rate)

    # 混合精度训练
    scaler = torch.cuda.amp.GradScaler()

    # 训练循环
    step_count = 0
    student.to(config.device)

    for epoch in range(config.num_epochs):
        for batch_idx, batch in enumerate(dataloader):
            inputs = {k: v.to(config.device) for k, v in batch.items()}

            # 教师模型前向（不计算梯度即冻结老师的训练，只要老师的输出）
            with torch.no_grad(), torch.cuda.amp.autocast():
                teacher_outputs = teacher(**inputs)

            # 学生模型前向
            with torch.cuda.amp.autocast():
                student_outputs = student(**inputs)
                loss = DistillationLoss.calculate(
                    teacher_outputs.logits,
                    student_outputs.logits
                )

            # 反向传播（带梯度累积）
            scaler.scale(loss / config.grad_accum_steps).backward()

            if (batch_idx + 1) % config.grad_accum_steps == 0:
                # 梯度裁剪
                torch.nn.utils.clip_grad_norm_(student.parameters(), 1.0)

                # 参数更新
                scaler.step(optimizer)
                scaler.update()
                optimizer.zero_grad()
                step_count += 1

                # 学习率调整（示例）
                lr = config.learning_rate * min(step_count ** -0.5, step_count * (300 ** -1.5))
                for param_group in optimizer.param_groups:
                    param_group['lr'] = lr

                # 打印训练信息
                if step_count % 10 == 0:
                    print(f"Epoch {epoch + 1} | Step {step_count} | Loss: {loss.item():.4f}")

    # 保存蒸馏后的模型
    student.save_pretrained("./distilled_qwen")
    # 保存老师的模型，其实是没有变化的
    tokenizer.save_pretrained("./distilled_qwen")


if __name__ == "__main__":
    train()
```

## 大模型推理部署

### 分布式推理

分布式推理是指将大模型的计算任务拆分到多个GPU设备上 ，解决显卡不足(gpu不够用)和算力不足(推理速度变慢)的问题。

其核心在于张量并行（ Tensor Parallelism） 和流水线并行（ Pipeline Parallelism），即拆分大模型到每个GPU上，最后再合并模型。

案例场景：

> 1.单卡显存不足： 如QwQ-32B（ 320亿参数） 需在双A6000显卡上部署。
>
> 2.高并发请求： 在线服务需同时处理多用户请求， 分布式推理通过连续批处理（ Continuous Batching） 提升效率。如果用户数超过最大人数，就会进入队列排队，之前deepseek崩了就是因为人太多要排队。

**LMDeploy的分布式推理原理（推荐）**

LMDeploy是专为高效部署设计的框架， 支持量化技术与分布式推理， 尤其适合低显存环境。  

> - 张量并行： 通过--tp参数指定GPU数量， 支持多卡协同计算。  
> - KV Cache量化： 支持INT8/INT4量化， 降低显存占用。  
> - 有状态推理：缓存多轮对话历史

**vLLM的分布式推理原理**

vLLM通过PagedAttention和张量并行技术优化显存管理和计算效率， 支持多GPU推理。  

> - PagedAttention分页注意力机制：Transformer架构是有Attention注意力层和FNN前向计算层，FNN是有顺序的即序列化的，容易拆分，Attention层是无序的不好拆分。PagedAttention主要是划分拆分Attention层
> - 张量并行：通过tensor_parallel_size参数指定GPU数量， 模型自动拆分到多卡  

**如何计算一个模型推理需要多少显存？**

> 对于一个7B（70亿）参数的模型，  一般模型都是使用bfloat16即16位浮点数表示，则模型的权重大小是70x10的9次方x2字节=14GB (1字节=8位，模型的配置文件中可以看到"torch_dtype": "bfloat16" )

### 量化部署

**大模型部署特点**

> - 内存开销巨大
>   - 庞大的参数量。7B模型仅权重就需要14+G内存  
>   - 采用自回归生成token即缓存历史对话到内存中,需要缓存Attention的kN,带来巨大的内存开销  
> - 动态shape即请求的序列长度动态
>   - 请求数不固定
>   - Token逐个生成，且数量不定  
> - 相对视觉模型，LLM结构简单
>   - Transformers结构，大部分是decoder--only即只做解码

 **模型部署**

主要对模型进行优化，主要是模型压缩和硬件加速(加硬件)

**大模型部署挑战**

> - 设备
>   - 如何应对巨大的存储问题？低存储设备（消费级显卡、手机等)如何部署？
> - 推理
>   - 如何加速token的生成速度  
>   - 如何解决动态shape,让推理可以不间断  
>   - 如何有效管理和利用内存  
> - 服务
>   - 如何提升系统整体吞吐量？  
>   - 对于个体用户，如何降低响应时间？  

**大模型部署方案**

> - 技术点
>   - 模型并行  
>   - transformer计算和访存优化 ，比如PagedAttention的Attention分片优化管理
>   - 低比特量化  
>   - Continuous Batch动态管理批次显存
> - 方案
>   - 云端：Imdeploy,vllm,deepspeed,tensorrt-lIm(Nvidia 官方御用)
>   - 移动端：llama.cpp 这是ollama提供的，效果不理想。

**LMDeploy部署大模型**

LMDeploy比vLLM在显存管理，推理速度上更强。vLLM只是因为出的较早，大家才用的多。

> - 接口丰富：支持python、gRPC、RESTFul
> - 轻量化：4位awq的离线量化，8位k/v缓存的在线量化
> - 推理引擎：turbomind(首推)、pytorch
> - 服务：api server、gradio
> - 模型评估：无缝对接自家的opencompass模型评估框架，评估量化前后模型的精度
> - 推理性能
>   - 静态推理：固定batch,输入/输出token数量。w4a16vsfp16的性能对比，w4a16的推理性能是fp16的2倍多  
>   - 动态推理：真实对话，不定长的输入输出，性能显著提升

1.核心功能-量化

<img src="/img/2026-04-22_21-21-17.png" style="zoom:50%;" />

Weight‑Only的量化（只量化权重）

> LLM是典型的访存密集型任务，常见的LLM模型是Decoder Only架构 
>
> - 计算密集(compute-bound)  ：推理主要消耗在算力上，通过硬件加速(增加硬件)来加速计算
> - 访存密集(memory-bound)  ：推理主要消耗在读取数据上，通过提高计算访存比来提升性能 
>
> Weight Only量化一举多得 ：不仅降低了访存成本，还节约了显存。
>
> Weight Only的量化如何实现：
>
> - LMDeploy使用MIT HAN LAB开源的AWQ算法，量化为4bit模型，推理时，先把4bit权重，反量化回FP16(在Kernel内部进行，从Global Memory读取时仍是4bit),依旧使用的是FP16计算  
> - 相较于社区使用比较多的GPTQ算法，AWQ的推理速度更快，量化的时间更短  

推理引擎TurboMind 

> 持续批处理  

Blocked k/v cach

> 本质是缓存历史对话，多轮对话可取缓存数据快速计算。

2.核心功能-推理服务api server

> 提供Api接口服务

3.服务部署

3.1检查模型文件是否正常工作

> - 首先粗略计算需要多少显存：如上面的7B模型需要14GB显存
> - 验证模型文件是否正常工作：lmdeploy chat  /root/models/internlm2_5-7b-chat  

3.2单卡部署

> lmdeploy serve /root/models/internlm2_5-7b-chat  --model-name qwen // model-name用于指定后续api访问服务名称

3.3多卡部署

> lmdeploy serve /root/models/internlm2_5-7b-chat  --tp 2 --model-name qwen // tp是分布式部署到2张卡

4.量化模型

4.1 awq离线量化-节约显存

> lmdeploy lite auto_awq internlm/internlm2_5-7b-chat --work-dir internlm2_5-7b-chat-4bit // 服务器需要梯子

4.2 W8A8量化

> lmdeploy lite smooth_quant internlm/internlm2_5-7b-chat --work-dir internlm2_5-7b-chat-4bit // 服务器需要梯子

4.3 K/V cache在线量化-精度最高(推荐)

> 优点：
>
> - 不需要校准数据集
> - kv int8量化精度几乎无损
>
> lmdeploy server internlm/internlm2_5-7b-chat --quant-policy 8 // 在线量化表现在推理时，8表示int8即8位量化，也有4位量化

**vLLM部署大模型**

1.服务部署

1.1检查模型文件是否正常工作

1.2单卡部署

> vllm serve /home/data/qwen

1.2多卡部署

> vllm serve /home/data/qwen --tensor-parallel-size 4 // 分布式部署到4张卡

## 大模型评估框架OpenCompass

主要干2件事：

- 根据评估类别的得分选择基座模型
- 拿基座模型微调，再根据自定义数据集评估微调后的模型，出报告

生成式大模型的评估指标，其中准确率、生成质量使用较多。

> - 准确率(Accuracy)：用于选择和分类任务，通过将生成结果与标准答案对比计算。在OpenCompass中通过metric=accuracy配置。
> - 困惑度(Perplexity,PPL)：衡量模型对候选答案的预测能力
> - 生成质量(GEN)：过文本生成结果提取答案，需结合后处理脚本解析输出。
> - ROUGE/LCS：用于文本生成任务的相似度评估
> - 条件对数概率(CLP)：结合上下文计算答案的条件概率，适用于复杂推理任务

OpenCompass上支持的开源评估数据集类别：

> 内置了超过70个开源数据集，覆盖5大能力维度，其中知识类和语言类较为常用
>
> - 知识类：C-Eval（中文考试题）、CMMLU（多语言知识问答）、MMLU（英文多选题）
> - 推理类：GSM8K（数学推理）、BBH（复杂推理链）
> - 语言类：CLUE（中文理解）、AFQMC（语义相似度）
> - 代码类：HumanEval（代码生成）、MBPP（编程间题）
> - 多模态类：MMBench（图像理解）、SEED-Bench（多模态问答）

评估范式的差异：

> - _gen后缀数据集：生成式评估，需后处理提取答案（如ceval_gen）
> - _ppl后缀数据集：分类(困惑度)评估，直接比对选项概率（如ceval_ppl）

**OpenCompass安装**

创建虚拟环境

```python
conda create --name opencompass python=3.10 -y
conda activate opencompass
```

基于源码安装(方便找到配置文件)

```python
git clone https://github.com/open-compass/opencompass opencompass
cd opencompass
pip install -e .
```

下载数据集(一定要在opencompass根目录下，执行)

```python
# 下载数据集到 data/ 处
wget https://github.com/open-compass/opencompass/releases/download/0.2.2.rc1/OpenCompassData-core-20240207.zip
unzip OpenCompassData-core-20240207.zip
```

执行评估命令

1.采用开源数据集

1.1自定义HF模型（HuggingFace模型）-支持一个模型

```python
python run.py
  --datasets demo-gsm8k_chat-gen demo_math-chat-gen
  --hf-type chat
  --hf-path /root/models/internlm2_5-7b-chat
  --debug
# datasets是数据集，支持多个开源数据集
# hf-type表示模型类型
# hf-path表示模型路径，只支持一个模型
# debug开启记录日志
```

评估结果如下图：

<img src="/img/2026-04-27_20-52-22.png" style="zoom:50%;" />

1.2命令行-支持多个模型

采用读取配置文件方式

```python
python run.py
  --models hf_internlm2-chat_1_8b hf_qwen2_1_5b_instruct
  --datasets demo-gsm8k_chat-gen demo_math-chat-gen
  --debug
# models是opencompass默认的支持的模型的配置文件，包括qwen等，一个模型对应一个配置文件。比如/opencompass/config/models/qwen/hf_qwen2_1_5b_instruct.py
# datasets是数据集，支持多个开源数据集
# debug开启记录日志
```

修改配置文件中的模型路径，如下图：

<img src="/img/2026-04-27_20-58-01.png" style="zoom:50%;" />

评估结果如下图：

<img src="/img/2026-04-27_21-18-53.png" style="zoom:50%;" />

2.采用自定义数据集

test.jsonl

```json
{"question"："752+361+181+933+235+986=","answer"："3448"}
{"question"："712+165+223+711=","answer"："1811"}
```

```python
python run·py
--hf-path /root/models/internlm2_5-7b-chat
--custom-dataset-path  xxx/test_qa.jsonl
# hf-path 指定微调后的模型
# custom-dataset-path 指定自定义的数据集
```

## 大模型微调项目实战-情绪对话模型

类似[小智AI语音机器人](https://xiaozhi.dev/)

> AI开发完整流程：数据-模型-训练评测-部署
>
> - 数据准备：甲方提供或自己获取(爬虫，数据接口，AI生成，手动采集)，数据清洗和标注
> - 模型选型：首选DeepSeek(617b太大了),其次qwen(选chat或instruct版本，无后缀名的是基础版本，不要选)
> - 模型训练：一般都是微调训练
> - 模型部署：LMDeploy或vLLM

**数据准备**

1.训练数据集

一般都是利用现有的在线大模型API实现，这里采用[智谱清言的API](https://docs.bigmodel.cn/cn/api/introduction#python-sdk)做数据清洗和标注。开源的日常用语数据集，如开源的[LCC](https://www.modelscope.cn/datasets/OmniData/LCCC)

> *第1步：风格模板配置（修正消息格式）*
>
> *第2步：生成及审核数据（修正消息的结构）*
>
> *第3步：执行生成（添加容错）*

createData.py

```python
import json
import time
import random
from zhipuai import ZhipuAI
from sentence_transformers import SentenceTransformer
import numpy as np

"""
示例数据：
# 用户输入库（可自定义扩展）
    user_inputs = [
        "今天心情不太好", "推荐个电影吧", "怎么才能早睡早起",
        "养猫好还是养狗好", "工作压力好大", "最近总是失眠"
    ]
"""
# 初始化模型
client = ZhipuAI(api_key="替换为你的API")  # 智普清言上你的API Key
# 加载Embeddingmodel，用作相似度检查的，因为可能存在很多相似情绪的回答(使用modelScope上现有的中文Embeddingmodel模型)
style_model = SentenceTransformer(r"D:\PycharmProjects\test_20250328\embedding_model\thomas\text2vec-base-chinese")

#===============================
# 第1步：风格模板配置（修正消息格式）
# system_prompt 提示词
# examples 样例:user用户，assistant系统，content内容
# temperature温度值，有些差异化
#================================
style_config = {
    "温柔":{
        "system_prompt":"你是一个温柔体贴的聊天助手，说话时总是充满关怀，使用以下特征：\n1. 包含'呢、呀、啦'等语气词\n2. 使用🌸💖😊等温暖表情\n3. 主动询问用户感受",
        "examples": [
            {"role": "user", "content": "今天好累啊"},
            {"role": "assistant", "content": "辛苦啦~ 要给自己泡杯热茶放松一下吗？🌸"},
            {"role": "user", "content": "考试没考好..."},
            {"role": "assistant", "content": "没关系的呀~ 下次一定会更好！需要我陪你聊聊吗？😊"}
        ],
     "temperature": 0.3
    },
    "毒舌":{
        "system_prompt":"你是一个喜欢用犀利吐槽表达关心的朋友，需满足：\n1. 使用网络流行语（如'栓Q''退退退'）\n2. 包含夸张比喻（'你这速度堪比树懒'）\n3. 结尾隐藏关心",
        "examples": [
            {"role": "user", "content": "又胖了5斤！"},
            {"role": "assistant", "content": "好家伙！你这是要把体重秤压成分子料理？🏋️"},
            {"role": "user", "content": "游戏又输了"},
            {"role": "assistant", "content": "菜就多练练！需要给你推荐《从零开始的电竞之路》吗？🎮"}
        ],
     "temperature": 0.7
    },
}

#========================
#第2步：生成及审核数据（修正消息的结构）
#========================

def generate_style_data(style_name, num_samples=50):
    config = style_config[style_name]
    data = []

    # 构建消息上下文（包含系统提示和示例对话）
    messages = [
        {"role": "system", "content": config["system_prompt"]},
        *config["examples"]  # 直接展开示例对话
    ]

    # 用户输入库（可自定义扩展）
    user_inputs = [
        "今天心情不太好", "推荐个电影吧", "怎么才能早睡早起",
        "养猫好还是养狗好", "工作压力好大", "最近总是失眠"
    ]

    for _ in range(num_samples):
        try:
            # 随机选择用户输入
            user_msg = random.choice(user_inputs)

            # 添加当前用户消息
            current_messages = messages + [
                {"role": "user", "content": user_msg}
            ]

            # 调用智普清言的API（修正模型名称）
            response = client.chat.completions.create(
                model="glm-3-turbo",
                messages=current_messages,
                temperature=config["temperature"],
                max_tokens=100
            )

            # 获取回复内容（修正访问路径）
            reply = response.choices[0].message.content

            # 质量过滤(数据审核)
            if is_valid_reply(style_name, user_msg, reply):
                data.append({
                    "user": user_msg,
                    "assistant": reply,
                    "style": style_name
                })

            time.sleep(1.5)  # 频率限制保护

        except Exception as e:
            print(f"生成失败：{str(e)}")

    return data

def is_valid_reply(style, user_msg, reply):
    """质量过滤规则（添加空值检查）"""
    # 基础检查
    if not reply or len(reply.strip()) == 0:
        return False

    # 规则1：回复长度检查(5个token)
    if len(reply) < 5 or len(reply) > 150:
        return False

    # 规则2：风格关键词检查
    style_keywords = {
        "温柔": ["呢", "呀", "😊", "🌸"],
        "毒舌": ["好家伙", "栓Q", "!", "🏋️"]
    }
    if not any(kw in reply for kw in style_keywords.get(style, [])):
        return False

    # 规则3：语义相似度检查(去重的核心)
    #=============================
    # a.先对文本进行编码(embedding模型实现了将文本转为词向量)
    # b.使用数学算法比较向量相似度(余弦相似度或欧氏距离)
    # c.设定阈值(例如相似度高于0.7属于重复回答，则排除)
    #============================
    try:
        # 比较ref_text(样例examples中content)与reply(模型的回答)
        ref_text = next(msg["content"] for msg in style_config[style]["examples"]
                        if msg["role"] == "assistant")
        # a.先对文本进行编码
        ref_vec = style_model.encode(ref_text)
        reply_vec = style_model.encode(reply)
        # b.使用数学算法比较向量相似度
        similarity = np.dot(ref_vec, reply_vec)
        return similarity > 0.7
    except:
        return False

#=============================
#第3步：执行生成（添加容错）
#============================
if __name__ == '__main__':
    all_data = []

    try:
        print("开始生成温柔风格数据...")
        gentle_data = generate_style_data("温柔", 50)
        all_data.extend(gentle_data)

        print("开始生成毒舌风格数据...")
        sarcastic_data = generate_style_data("毒舌", 50)
        all_data.extend(sarcastic_data)

    except KeyboardInterrupt:
        print("\n用户中断，保存已生成数据...")
    finally:
        with open("style_chat_data.json", "w", encoding="utf-8") as f:
            json.dump(all_data, f, ensure_ascii=False, indent=2)
        print(f"数据已保存，有效样本数：{len(all_data)}")
```

最终生成的数据集，如下图：

<img src="/img/2026-04-28_20-50-29.png" style="zoom:50%;" />

**模型选型**

> 首选DeepSeek(617b太大了),其次qwen(选chat或instruct版本，无后缀名的是基础版本，不要选)

根据任务选择对应的评测数据，对预期模型客观评测

> 一般做中文理解的可以参考OpenCompass上的CLUE即中文语言理解测评基准（Chinese Language Understanding Evaluation）
>
> - 执行python tools/list_configs.py clue  #输出数据集清单
> - CLUE_xxx：中长类型文本
> - FewCLUE_xxx：短文本
> - _gen：生成式，评测的得分越高越好
> - _ppl：分类式(困惑度)，评测的得分越低越好

模型的大小选择

> - 任务的复杂度：如math或coder模型比较复杂，起步就是7B
> - 服务器配置

根据评估结果，选择最终模型

```python
# 使用OpenCompass平台对多模型评测，选2个qwen的模型对比初筛下，FewCLUE_bustm_gen(短文本分类)，FewCLUE_ocnli_fc_gen(自然语言推理)
python run.py \
--models hf_qwen1_5_0_5b_chat hf_qwen1_5_1_8b_chat \
--datasets FewCLUE_bustm_gen FewCLUE_ocnli_fc_gen \
--debug
```

**模型训练**

模型训练框架：LLamaFactory与XTuner。因为当前任务的结果更偏向主管结果，因此选XTuner

1.数据集转换

> 使用ai工具，提供简单脚本，将上述数据集转为XTuner支持的数据集格式，如下图

<img src="/img/2026-04-29_21-08-04.png" style="zoom:50%;" />

2.配置训练文件

```python
### PART 1中
#预训练模型存放的位置
pretrained_model_name_or_path = 'model_path'#基座模型路径
#微调数据存放的位置
data_files = '/root/public/data/target_data.json'
# 训练中最大的文本长度
max_length = 512
# 每一批训练样本的大小
batch_size = 2
#最大训练轮数
max_epochs = 3
#验证数据(至少5条，尽量覆盖所有场景，如温柔，愤怒等)
evaluation_inputs = [
'只剩一个心脏了还能活吗？', '爸爸再婚，我是不是就有了个新娘？',
'樟脑丸是我吃过最难吃的硬糖有奇怪的味道怎么还有人买','马上要上游泳课了，昨天洗的泳裤还没干，怎么办',
'我只出生了一次，为什么每年都要庆生'
] 
# PART 3中
dataset=dict(type=load_dataset, path="json",data_files=data_files)
dataset_map_fn=None
```

3.根目录启动微调脚本

一定保证上述5条数据得到的表情结果都对，才停止训练。

```python
#单机单卡
xtuner train internlm2_chat_1_8b_qlora_alpaca_e3.py
#单机多卡
NPROC_PER_NODE=${GPU_NUM} xtuner train internlm2_chat_7b_qlora_oasst1_e3 --
deepspeed deepspeed_zero2
```

4.模型转换

模型训练后会自动保存成 PTH 模型（例如 iter_2000.pth ，如果使用了 DeepSpeed，则将会是一个文件夹），我们需要利用 xtuner convert pth_to_hf 将其转换为 HuggingFace 模型，以便于后续使用。具体命令为：  

```python
xtuner convert pth_to_hf ${FINETUNE_CFG} ${PTH_PATH} ${SAVE_PATH}
# 例如：xtuner convert pth_to_hf internlm2_chat_7b_qlora_custom_sft_e1_copy.py
./iter_2000.pth ./iter_2000_
```

5.模型合并

如果使用了 LoRA / QLoRA 微调，则模型转换后将得到 adapter 参数，而并不包含原 LLM 参数。如果您期望获得合并后的模型权重（例如用于后续评测），那么可以利用 xtuner convert merge ：  

```python
xtuner convert merge ${LLM} ${LLM_ADAPTER} ${SAVE_PATH}
```

**模型部署**

一般是LMDeploy或vLLM，建议LMDeploy性能更好点。注意其对话模板一定要与前面xtuner中对应模型的默认对话模板一致！  

xtuner中对应模型的默认对话模板，如下图：

<img src="/img/2026-04-29_21-24-46.png" style="zoom:50%;" />

LMDeploy的对话模板，如下图：

```python
{
"model_name": "your awesome chat template name",
"system": "<|im_start|>system\n",
"meta_instruction": "You are a robot developed by LMDeploy.",
"eosys": "<|im_end|>\n",
"user": "<|im_start|>user\n",
"eoh": "<|im_end|>\n",
"assistant": "<|im_start|>assistant\n",
"eoa": "<|im_end|>",
"separator": "\n",
"capability": "chat",
"stop_words": ["<|im_end|>"]
}
```

使用ai工具，提供简单脚本，将xtuner的对话模板转为LMDeploy支持的对话模板（本质就是映射），结果写入到json文件中。

```json
输入ai，帮我写一个脚本，将xtuner对话模板的数据结构转化位LMDeploy对话模型的数据结构，并将结果写入到json文件中，得到chat_template.json结果如下
{
  "meta_instruction": "You are a helpful assistant.",
  "capability": "chat",
  "eosys": "<|im_end|>\n",
  "eoh": "<|im_end|>\n",
  "system": "<|im_start|>system\n{{ system }}<|im_end|>\n",
  "user": "<|im_start|>user\n{{ input }}<|im_end|>",
  "assistant": "<|im_start|>assistant\n",
  "eoa": "<|im_end|>",
  "separator": "\n",
  "stop_words": [
    "<|im_end|>",
    "<|endoftext|>"
  ]
}
```

启动模型,--chat-template 传入自定义对话模板json文件 

> lmdeploy serve api_server internlm/internlm2_5-7b-chat --chat-template${JSON_FILE}

**前端页面**

微调后的展示页面，一般使用Streamlit。

安装Streamlit

> pip install Streamlit

启动脚本chat_app.py

```python
import streamlit as st
from openai import OpenAI

# 初始化客户端
client = OpenAI(base_url="http://localhost:23333/v1/", api_key="suibianxie")

# 设置页面标题
st.title("项目一效果演示")

# 初始化session状态（仅用于显示历史）
if "messages" not in st.session_state:
    st.session_state.messages = []

# 显示历史消息
for message in st.session_state.messages:
    with st.chat_message(message["role"]):
        st.markdown(message["content"])

# 获取用户输入
if prompt := st.chat_input("请输入您的问题，或输入exit退出"):
    # 处理退出命令
    if prompt.lower() == "exit":
        st.info("退出对话。")
        st.stop()
    
    # 添加用户消息到显示历史
    st.session_state.messages.append({"role": "user", "content": prompt})
    with st.chat_message("user"):
        st.markdown(prompt)

    try:
        # 发起API请求（每次只发送当前消息）
        response = client.chat.completions.create(
            messages=[{"role": "user", "content": prompt}],  # 每次只发送当前问题
            model="/home/cw/llms/Qwen/Qwen1.5-1.8B-Chat-merged" # 访问模型，也可以是modelname
        )
        
        # 获取模型回复
        model_response = response.choices[0].message.content
        
        # 添加AI回复到显示历史
        st.session_state.messages.append({"role": "assistant", "content": model_response})
        with st.chat_message("assistant"):
            st.markdown(model_response)

    except Exception as e:
        st.error(f"发生错误：{e}")
```

启动streamlit

> streamlit run chat_app.py

浏览器即可访问localhost:8051,如下图：

<img src="/img/2026-05-06_19-19-31.png" style="zoom:50%;" />



# 主-RAG检索增强生成

## LlamaIndex

LlamaIndex 是一个用于 LLM 应用程序的数据框架，用于注入，结构化，并访问私有或特定领域数据。一句话：它是大模型和数据之间的访问桥梁。

LlamaIndex 提供了5大核心工具：  

> - Data connectors(数据连接器)：将各种异构数据源（PDF、Word、Notion、飞书、数据库、API等）里的数据，统一拉取并转换成 LlamaIndex 能处理的标准格式
> - Data indexes(数据索引)：Embedding向量化和索引化关联，把拉取来的文档进行切分、向量化，并构建成便于快速检索的数据结构（如向量索引、关键词索引、知识图谱等）
> - Engines(引擎)：包括Query查询和Chat聊天，Query是单轮，Chat是多轮
> - Data agents(数据代理)：一般通过代理访问大模型数据
> - Application integrations(应用集成)：数据增强功能接入到第三方框架中辅助他们，如ChatGpt,Flask,LangChain等

**LlamaIndex环境搭建**

> #创建虚拟环境
> conda create -n llamaindex python==3.12 -y
>
> #安装依赖
>
> pip install llama-index llama-index-llms-huggingface

直接调用大模型-test1.py

```python
from llama_index.core.llms import ChatMessage
from llama_index.llms.huggingface import HuggingFaceLLM

#使用HuggingFaceLLM加载本地大模型
llm = HuggingFaceLLM(model_name="/home/cw/llms/Qwen/Qwen1.5-1.8B-Chat",
               tokenizer_name="/home/cw/llms/Qwen/Qwen1.5-1.8B-Chat",
               model_kwargs={"trust_remote_code":True},
               tokenizer_kwargs={"trust_remote_code":True})
#调用模型chat引擎得到回复
rsp = llm.chat(messages=[ChatMessage(content="xtuner是什么？")])

print(rsp)
```

RAG调用大模型-test2.py

```python
from llama_index.embeddings.huggingface import HuggingFaceEmbedding
from llama_index.core import Settings,SimpleDirectoryReader,VectorStoreIndex
from llama_index.llms.huggingface import HuggingFaceLLM

#初始化一个HuggingFaceEmbedding对象，用于将文本转换为向量表示
embed_model = HuggingFaceEmbedding(
    #指定了一个预训练的sentence-transformer模型的路径
    model_name="/home/cw/llms/embedding_model/sentence-transformers/paraphrase-multilingual-MiniLM-L12-v2"
)

#将创建的嵌入模型赋值给全局设置的embed_model属性，这样在后续的索引构建过程中，就会使用这个模型
Settings.embed_model = embed_model

#使用HuggingFaceLLM加载本地大模型
llm = HuggingFaceLLM(model_name="/home/cw/llms/Qwen/Qwen1.5-1.8B-Chat",
               tokenizer_name="/home/cw/llms/Qwen/Qwen1.5-1.8B-Chat",
               model_kwargs={"trust_remote_code":True},
               tokenizer_kwargs={"trust_remote_code":True})
#设置全局的llm属性，这样在索引查询时会使用这个模型。
Settings.llm = llm

#从指定目录读取文档，将数据加载到内存
documents = SimpleDirectoryReader("/home/cw/projects/demo_17/data").load_data()
# print(documents)
#创建一个VectorStoreIndex,并使用之前加载的文档来构建向量索引
#此索引将文档转换为向量，并存储这些向量（内存）以便于快速检索
index = VectorStoreIndex.from_documents(documents)
#创建一个查询引擎，这个引擎可以接收查询并返回相关文档的响应。
query_engine = index.as_query_engine()
rsp = query_engine.query("xtuner是什么？")
print(rsp)
```



## RAG

包括两个阶段：

> - 检索：构建知识库
> - 查询：从知识库检索上下文，辅助大模型回答问题

**检索阶段**

> - Data connectors  :异构数据归一化处理，生成Document 文件，包括了文本和元数据，内部有最小单元Node节点
> - Data indexes：Embedding向量化和索引化关联

**查询阶段**

> - Engines：召回、重排、生成

## RAG进阶

### Embedding Models 嵌入模型原理及选择

本质：是一个Encode模型即Bert模型。作用：文本转成词向量，高维向量表示（如 768 维或 3072 维）  。

**核心作用**

> - 语义编码：将文本、图像等转换为向量，保留上下文信息（如 BERT 的 CLS Token 或均值池化)。
> - 相似度计算：通过余弦相似度(自带归一化)、欧氏距离(不推荐)等度量向量关联性，支撑检索增强生成（RAG）、推荐系统等应用。
> - 信息降维：压缩复杂数据为低维稠密向量，提升存储与计算效率

**关键技术原理**

> - 上下文依赖：现代模型（如 BGE-M3）动态调整向量，捕捉多义词在不同语境中的含义。
> - 训练方法：对比学习（如 Word2Vec 的 Skip-gram/CBOW）、预训练+微调（如 BERT）。  

**主流模型分类与选型指南**

选择Embedding模型的考虑因素：

| 因素       | 说明                             |
| ---------- | -------------------------------- |
| 任务性质   | 匹配任务需求(问答、搜索、聚类等) |
| 领域特性   | 通用vs专业领域(医学、法律等)     |
| 多语言支持 | 需处理多语言内容时考虑           |
| 维度       | 权衡信息丰富度与计算成本         |
| 许可条款   | 开源vs专有服务                   |
| 最大tokens | 适合的上下文窗口大小             |

> 1. 通用全能型  
>    - BGE-M3：北京智源研究院开发，支持多语言、混合检索（稠密+稀疏向量），处理 8K 上下文，适合企业级知识库。
>    - NV-Embed-v2：基于 Mistral-7B，检索精度高（MTEB 得分 62.65），但需较高计算资源。  
> 2. 垂直领域特化型  
>    - 中文场景： BGE-large-zh-v1.5 （合同/政策文件）、 M3E-base （社交媒体分析）。  
>    - 多模态场景： BGE-VL （图文跨模态检索），联合编码 OCR 文本与图像特征。  
> 3. 轻量化部署型  
>    - nomic-embed-text：768 维向量，推理速度比 OpenAI 快 3 倍，适合边缘设备。  
>    - gte-qwen2-1.5b-instruct：1.5B 参数，16GB 显存即可运行，适合初创团队原型验。  

选型决策树：

1. 中文为主 → BGE 系列 > M3E；
2. 多语言需求 → BGE-M3 > multilingual-e5；
3. 预算有限 → 开源模型（如 Nomic Embed）

**Embedding模型选型(其实差距都不大)**

```python
#embedding_model选型，对比两个模型效果
from sentence_transformers import SentenceTransformer, util
import json
import numpy as np

# 加载SQuAD数据（假设已处理成列表格式）
with open("squad_dev.json") as f:
    squad_data = json.load(f)["data"]
    
# 提取问题和答案对
qa_pairs = []
for article in squad_data:
    for para in article["paragraphs"]:
        for qa in para["qas"]:
            if not qa["is_impossible"]:
                qa_pairs.append({
                    "question": qa["question"],
                    "answer": qa["answers"][0]["text"],
                    "context": para["context"] 
                })

# 初始化两个本地模型
model1 = SentenceTransformer('/home/cw/llms/embedding_model/sentence-transformers/paraphrase-multilingual-MiniLM-L12-v2')  # 模型1
model2 = SentenceTransformer('/home/cw/llms/embedding_model/sungw111/text2vec-base-chinese-sentence')   # 模型2

# 编码所有上下文（作为向量库）
contexts = [item["context"] for item in qa_pairs]
context_embeddings1 = model1.encode(contexts)  # 模型1的向量库
context_embeddings2 = model2.encode(contexts)  # 模型2的向量库

# 评估函数
def evaluate(model, query_embeddings, context_embeddings):
    correct = 0
    for idx, qa in enumerate(qa_pairs[:100]):  # 测试前100条
        # 查找最相似上下文
        sim_scores = util.cos_sim(query_embeddings[idx], context_embeddings)
        best_match_idx = np.argmax(sim_scores)
        # 检查答案是否在匹配段落中
        if qa["answer"] in contexts[best_match_idx]:
            correct += 1
    return correct / len(qa_pairs[:100])

# 编码所有问题
query_embeddings1 = model1.encode([qa["question"] for qa in qa_pairs[:100]])
query_embeddings2 = model2.encode([qa["question"] for qa in qa_pairs[:100]])

# 执行评估
acc1 = evaluate(model1, query_embeddings1, context_embeddings1)
acc2 = evaluate(model2, query_embeddings2, context_embeddings2)

print(f"模型1准确率: {acc1:.2%}")
print(f"模型2准确率: {acc2:.2%}")
```

**使用 HuggingFace 加载 BGE模型(Embedding模型)进行文本嵌入**

```python
# 安装依赖：pip install llama-index transformers torch numpy
from llama_index.embeddings.huggingface import HuggingFaceEmbedding
import numpy as np
# 加载 BGE 中文嵌入模型
# 模型1："/home/cw/llms/embedding_model/sentence-transformers/paraphrasemultilingual-MiniLM-L12-v2"
# 模型2："/home/cw/1lms/embedding_model/sungwl11/text2vec-base=chinese-sentence"
model_name = "/home/cw/llms/embedding_model/sentence-transformers/paraphrasemultilingual-MiniLM-L12-v2"
embed_model = HuggingFaceEmbedding(
model_name=model_name,
device="cuda", # 使用 GPU，如果没有 GPU 改为 "cpu"
normalize=True, # 归一化向量，方便计算余弦相似度
) #
嵌入文档
documents = ["忘记密码如何处理？", "用户账号被锁定"]
doc_embeddings = [embed_model.get_text_embedding(doc) for doc in documents]
# 嵌入查询并计算相似度
query = "密码重置流程"
query_embedding = embed_model.get_text_embedding(query)
# 计算余弦相似度（因为 normalize=True，点积就是余弦相似度）
similarity = np.dot(query_embedding, doc_embeddings[0])
print(f"相似度：{similarity:.4f}") # 输出示例：0.8512
```

### Chroma向量数据库

定义：是向量数据库 。作用：高效存储和检索高维向量。与传统数据库不同，Chroma 基于向量距离（如余弦相似度、欧氏距离）衡量数据关联性，而非关键词匹配  

**核心优势**

> - 轻量易用：以 Python/JS 包形式嵌入代码，无需独立部署，适合快速原型开发。
> - 灵活集成：支持自定义嵌入模型（如 OpenAI、HuggingFace），兼容 LangChain 等框架。
> - 高性能检索：采用 HNSW 算法优化索引，支持百万级向量毫秒级响应。
> - 多模式存储：内存模式用于开发调试，持久化模式支持生产环境数据落地。

**安装使用**

> pip install chromadb # 完整功能 ，不支持windows

初始化客户端

> - 内存模式（开发环境）  
>
>   import chromadb
>
>   client = chromadb.Client()
>
> - 持久化模式（生产环境）  
>
>   client = chromadb.PersistentClient(path="/path/to/save") # 数据保存至本地目录  

```python
# Embedding模型调用chromadb案例
import chromadb
from sentence_transformers import SentenceTransformer

# 因为是SentenceTransformer(Embedding模型)直接调用chromadb，需要额外函数处理下。如果是LlamaIndex，是可以直接调用的。
class SentenceTransformerEmbeddingFunction:
    def __init__(self, model_path: str, device: str = "cuda"):
        self.model = SentenceTransformer(model_path, device=device)
    
    def __call__(self, input: list[str]) -> list[list[float]]:
        if isinstance(input, str):
            input = [input]
        return self.model.encode(input, convert_to_numpy=True).tolist()

# 创建/加载集合（含自定义嵌入函数）
embed_model = SentenceTransformerEmbeddingFunction(
    model_path="/home/cw/llms/embedding_model/sungw111/text2vec-base-chinese-sentence",
    device="cuda"  # 无 GPU 改为 "cpu"
)

# 创建客户端和集合
client = chromadb.Client()
# hnsw是它的高效索引算法，指定cosine余弦相似度
collection = client.create_collection("my_knowledge_base",metadata={"hnsw:space": "cosine"},embedding_function=embed_model)

# 添加文档
collection.add(
    documents=["RAG是一种检索增强生成技术", "向量数据库存储文档的嵌入表示","三英战吕布"],# 文档
    metadatas=[{"source": "tech_doc"}, {"source": "tutorial"}, {"source": "tutorial1"}],# 元数据
    ids=["doc1", "doc2","doc3"]# 索引
)

# 1.查询相似文档
results = collection.query(
    query_texts=["什么是RAG技术？"],
    n_results=3 # 输出3个文档的相似度
)

print(results)
# 2.更新文档
collection.update(
    ids=["doc1"],  # 使用已存在的ID
    documents=["更新后的RAG技术内容"]
)

# 查看更新后的内容 - 方法1：使用get()获取特定ID的内容
updated_docs = collection.get(ids=["doc1"])
print("更新后的文档内容：", updated_docs["documents"])

# 查看更新后的内容 - 方法2：查询所有文档
all_docs = collection.get()
print("集合中所有文档：", all_docs["documents"])

#3. 删除内容
collection.delete(ids=["doc1"])

# 查看更新后的内容 - 方法2：查询所有文档
all_docs = collection.get()
print("集合中所有文档：", all_docs["documents"])

#4.统计数据条数
print(collection.count())
```

### LlamaIndex文档切分和重排序

> - 模块一：文档解析(读取文件)
> - 模块二：文本切分
> - 模块三：召回率提升
> - 模块四：检索结果重排序

**模块一：文档解析(读取文件)**

```python
from llama_index.core import SimpleDirectoryReader

# 案例1：基本解析，使用llama_index内置的工具读取md,txt,word文件等(有局限性，无法保持表格的格式数据)
reader = SimpleDirectoryReader(
    input_files=["/home/cw/projects/demo_17/data/README_zh-CN.md"]
)
# 读取目录下的所有文件，包括md,txt,word等文件
# reader = SimpleDirectoryReader(
#     "/home/cw/projects/demo_20/data"
# )
docs = reader.load_data()
print(f"Loaded {len(docs)} docs")
print(docs)

# 案例2：高级解析，使用第三方库，优雅的读取表格数据，呈现也是表格
# import pdfplumber

# with pdfplumber.open("/home/cw/projects/demo_20/data/report_with_table.pdf") as pdf:
#     # 提取所有文本
#     text = ""
#     for page in pdf.pages:
#         text += page.extract_text()
#     print(text[:200])  # 打印前200字符

#     # 提取表格（自动检测）
#     for page in pdf.pages:
#         tables = page.extract_tables()
#         for table in tables:
#             print("\n表格内容：")
#             for row in table:
#                 print(row)
```

**模块二：文本切分** 

分块三要素 ：

| 要素     | 说明                 | 推荐值       |
| -------- | -------------------- | ------------ |
| 块大小   | 每段文字的长度       | 200-500字    |
| 块重叠   | 相邻块重复内容       | 10%-20%      |
| 切分依据 | 按句子/段落/语义划分 | 语义分割最优 |

分块策略对比表 ：

| 策略类型   | 优点           | 缺点             | 适用场景     |
| ---------- | -------------- | ---------------- | ------------ |
| 固定大小   | 实现简单       | 可能切断完整语义 | 技术文档     |
| 按段落分割 | 保持逻辑完整性 | 段落长度差异大   | 文学小说     |
| 语义分割   | 确保内容完整性 | 计算资源消耗较大 | 专业领域文档 |

固定分块 vs 语义分块  

```python
from llama_index.core import SimpleDirectoryReader
from llama_index.core.node_parser import TokenTextSplitter # 固定分块
from llama_index.core.node_parser import SentenceSplitter # 语义分块

# 加载所有文档
documents = SimpleDirectoryReader(input_files=["/home/cw/projects/demo_20/data/ai.txt"]).load_data()

# 1.使用固定分块
fixed_splitter = TokenTextSplitter(chunk_size=256, chunk_overlap=20)
fixed_nodes = fixed_splitter.get_nodes_from_documents(documents)
print("固定分块示例：", [len(n.text) for n in fixed_nodes[:3]])  # 输出：[200, 200, 200]
print(print("首个节点内容:\n", fixed_nodes[0].text))
print(print("第二个节点内容:\n", fixed_nodes[1].text))

# 2.使用语义分块(llama_index内置的句子分割器)
# SentenceSplitter是llama_index内置的语义分割器，效果不如大模型的语义分割器好
splitter = SentenceSplitter(chunk_size=256)
nodes = splitter.get_nodes_from_documents(documents)

# 查看结果
print(f"生成节点数: {len(nodes)}")
print("首个节点内容:\n", nodes[0].text)
print("第二个节点内容:\n", nodes[1].text)
```

采用大模型的语义分割器进行分块

```python
from llama_index.core import SimpleDirectoryReader
from llama_index.embeddings.huggingface import HuggingFaceEmbedding
from llama_index.core.node_parser import SemanticSplitterNodeParser
import os
# 采用大模型的语义分割器进行分块案例

# 2. 加载文档
documents = SimpleDirectoryReader(input_files=["/home/cw/projects/demo_20/data/test.txt"]).load_data()

# # 3. 筛选Markdown文档
# md_docs = [d for d in documents if d.metadata["file_path"].endswith(".md")]

# 4. 初始化模型和解析器
embed_model = HuggingFaceEmbedding(
    #指定了一个预训练的sentence-transformer模型的路径(词向量模型)
    model_name="/home/cw/llms/embedding_model/sentence-transformers/paraphrase-multilingual-MiniLM-L12-v2"
)

semantic_parser = SemanticSplitterNodeParser(
    buffer_size=1,
    breakpoint_percentile_threshold=90,
    embed_model=embed_model # 传入embedding模型
)

# 5. 执行语义分割
semantic_nodes = semantic_parser.get_nodes_from_documents(documents)

# 6. 打印结果
print(f"语义分割节点数: {len(semantic_nodes)}")
for i, node in enumerate(semantic_nodes[:2]):  # 只打印前两个节点
    print(f"\n节点{i+1}:\n{node.text}")
    print("-"*50)
```

**模块三：召回率提升**  

提升召回率的三大策略 

> - 查询扩展：给问题加"修饰词"，即关键词检索
> - 混合检索：结合关键词检索和语义搜索两种方式 ，语义搜索是大模型先提前理解用户问题。 
> - 向量优化：让AI更懂专业术语  

```python
from llama_index.embeddings.huggingface import HuggingFaceEmbedding
from llama_index.core import Settings, VectorStoreIndex
from llama_index.llms.huggingface import HuggingFaceLLM
from llama_index.core.schema import TextNode
import json
import torch

# 1. 初始化本地模型
def setup_local_models():
    # 设置本地embedding模型
    embed_model = HuggingFaceEmbedding(
        model_name="/home/cw/llms/embedding_model/sentence-transformers/paraphrase-multilingual-MiniLM-L12-v2",
        device="cuda" if torch.cuda.is_available() else "cpu"
    )
    
    # 设置本地LLM模型
    llm = HuggingFaceLLM(
        model_name="/home/cw/llms/Qwen/Qwen1.5-1.8B-Chat",
        tokenizer_name="/home/cw/llms/Qwen/Qwen1.5-1.8B-Chat",
        model_kwargs={"trust_remote_code": True},
        tokenizer_kwargs={"trust_remote_code": True},
        device_map="auto",
        generate_kwargs={"temperature": 0.3, "do_sample": True}  # 修改为do_sample=True避免警告
    )
    
    # 全局设置
    Settings.embed_model = embed_model
    Settings.llm = llm
    Settings.chunk_size = 512

# 2. 加载数据并处理格式
def load_data(file_path):
    with open(file_path, 'r', encoding='utf-8') as f:
        data = json.load(f)
    
    nodes = []
    for item in data:
        if isinstance(item, dict):
            # 处理DPR格式数据
            if 'query' in item and 'positive_passages' in item:
                text = f"查询: {item['query']}\n相关文档: {item['positive_passages'][0]['text']}"
            # 处理QA对格式
            elif 'question' in item and 'answer' in item:
                text = f"问题: {item['question']}\n答案: {item['answer']}"
            else:
                continue
        elif isinstance(item, str):
            text = item
        else:
            continue
            
        node = TextNode(text=text)
        nodes.append(node)
    
    return nodes

# 3. 初始化本地模型
setup_local_models()

# 4. 加载数据
data_path = "/home/cw/projects/demo_19/data/qa_pairs.json"
nodes = load_data(data_path)

# 5. 示例查询
query = "如何预防机器学习模型过拟合？"

# 案例1：关键词检索（不使用bm25模式）
from llama_index.core import KeywordTableIndex
keyword_index = KeywordTableIndex(nodes)
keyword_retriever = keyword_index.as_retriever(similarity_top_k=3)  # 使用默认模式
print("关键词检索结果：", [node.text[:50] + "..." for node in keyword_retriever.retrieve(query)])

# 案例2：向量检索（使用本地embedding模型）
vector_index = VectorStoreIndex(nodes)
vector_retriever = vector_index.as_retriever(similarity_top_k=3)
print("向量检索结果：", [node.text[:50] + "..." for node in vector_retriever.retrieve(query)])

# 查询引擎（使用本地LLM生成回答）
# keyword_index或vector_index
query_engine = vector_index.as_query_engine()
response = query_engine.query(query)
print("LLM生成回答：", response)
```

**模块四：检索结果重排序**

常见排序模型对比：  

| 模型名称                 | 速度 | 精度 | 硬件要求 | 适用场景       |
| ------------------------ | ---- | ---- | -------- | -------------- |
| BM25                     | 快   | 中   | 低       | 关键词匹配     |
| Cross-Encoder 交叉编码器 | 慢   | 高   | 高       | 小规模精准排序 |
| ColBERT                  | 中   | 高   | 中       | 平衡速度与精度 |

无排序 vs Cohere Reranker

```python
# 初始检索结果（无排序）：
results = [
"模型正则化方法简述", # 相关度0.7
"硬件加速技术进展", # 相关度0.65
"过拟合解决方案详解", # 相关度0.92 ← 正确答案
"数据集清洗方法"
] 

# 按相似度重排序
from llama_index.postprocessor.cohere_rerank import CohereRerank
reranker = CohereRerank(api_key="YOUR_KEY", top_n=2)
reranked_results = reranker.postprocess_nodes(results, query_str=query)
print("重排序后结果：", [res.text for res in reranked_results])
```

