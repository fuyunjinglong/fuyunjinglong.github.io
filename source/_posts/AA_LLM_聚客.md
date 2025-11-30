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

大模型是什么？

> 参数量在10亿(1b)以上的才叫大模型。以前有个叫深度学习，当深度学习参数超过10亿后，出现了智能化。

AI大模型是什么？

> 和写代码关系不大，核心是数学模型，也称为人工神经网络，本质是做矩阵运算的。

AI大模型如何分类？

> - 自然语义大模型(大模型的核心技术)
> - 多模块大模型(图片、音视频等)

AI项目开发流程(对应下面Bert情感分析中的流程)

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
>   - 欠拟合：模型分布弱于真实数据分布(训练时间不够；模型过于简单)。loss过大，就是欠拟合，加大训练量即可。
>
>   - 拟合：模型分布恰好能够表达真实数据分布(训练的理想状态)
>
>   - 过拟合：模型分布过度拟合真实数据分布，使得模型结果依赖数据中的噪声信息，一旦数据变化，可能结果错误。如：识别猫狗。猫的背景是红色，狗的背景是蓝色。如果测试数据换成猫的背景蓝色，可能就出错，因为依赖了背景色判断猫狗。
>
>     validation验证数据集主要用来验证模型是否存在过拟合。

泛化性如下图：

![image](/img/2025-12-01_07-25-07.png)

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

## 基于Bert的中文评价情感分析(AI开发流程)

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

### 2.1模型选型/设计-增量微调(增加模型并对增加的模型微调)

Transform本质是Mlp全连接+Att注意力机制。它是不具备位置模型，不能处理顺序问题。

一般我们AI开发是增加模型微调，核心是在原有的大模型基础上，增加业务模型，并对业务模型微调，叫增量微调。

> 内部涉及3个模块处理，如下图：
>
> #1.embeddings(BertEmbeddings模型)
> #1.1word_embeddings，将词转换成向量的模型。输出768维向量
> #1.2position_embeddings,记录词的前后位置顺序，也是768维向量
> #2.encoder(BertEncoder)-预训练模型
> #即特征学习，特征提取
> #3.pooler(BertPoller)
> #即池化层，池化数据，也是输出768维向量

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

