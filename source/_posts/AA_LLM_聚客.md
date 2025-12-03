---
title: LLM_聚客第3期推荐
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

**大模型是什么？**

> 参数量在10亿(1b)以上的才叫大模型。以前有个叫深度学习，当深度学习参数超过10亿后，出现了智能化。

**AI大模型是什么？**

> 和写代码关系不大，核心是数学模型，也称为人工神经网络，本质是做矩阵运算的。

**AI大模型如何分类？**

> - 自然语义大模型(大模型的核心技术)
> - 多模块大模型(图片、音视频等)

**AI项目开发流程(对应下面Bert情感分析中的流程)**

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

![image](/img/2025-12-01_07-25-07.png)

**Transformers核心**

Transformers是从sep2seq自然语义模型改进来的，

> - Bert(分类)-编码器，独立可做分类模型。提取特征向量，输入到解码器。
> - GPT(生成)-解码器，独立可做生成模型。

**微调方式**

> - 全量微调
>   - 对所有参数进行微调
>   - 对算力和显存要求高
>   - 效果最佳，也可能效果不如以前
> - 局部微调-生成式模型采用这种模式
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

![image](/img/2025-12-01_06-26-49.png)

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

### 本地训练GPT2中文模型 -全量微调 

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

不加载训练权重，如下图

![image](/img/2025-12-03_20-24-15.png)

加载训练权重即模型训练的结果net.pt，如下图

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

定制化的控制内容和格式输出，需要人为强制干预，如下图

![image](/img/2025-12-03_20-28-11.png)

```python
#定制化的控制内容和格式输出
import torch
from transformers import AutoTokenizer,AutoModelForCausalLM

tokenizer = AutoTokenizer.from_pretrained(r"D:\BaiduNetdiskDownload\gpt2-chinese模型\models--uer--gpt2-chinese-cluecorpussmall\snapshots\c2c0249d8a2731f269414cc3b22dff021f8e07a3")
model = AutoModelForCausalLM.from_pretrained(r"D:\BaiduNetdiskDownload\gpt2-chinese模型\models--uer--gpt2-chinese-cluecorpussmall\snapshots\c2c0249d8a2731f269414cc3b22dff021f8e07a3")

#加载我们自己训练的权重（中文古诗词）
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



### 服务器训练GPT2中文模型

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
