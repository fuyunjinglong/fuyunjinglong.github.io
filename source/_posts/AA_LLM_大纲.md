---
title: LLM_大纲
date: 2025-11-01 06:33:16
categories:
- B_LLM
toc: true # 是否启用内容索引
---

# 大纲

- LLM 训练与微调应用
- RAG 检索增强生成应用
- Agent 智能体应用

# AI全栈进阶体系

## 妙码学院

- TypeScript 100%-大多数大模型都是采用ts或python
- Vue
- Vite
- Nust
- 桌面端(electron)、web(小程序)，server(nextjs+nustjs+prisma+Postgresql+docker)

# 大模型发展史

![image](/img/LLM_Time.png)

> - 1936-2022：ChatGPT智能
> - 2023：Gemini多模态
> - 2024：GPT4o(过渡的一年)
> - 2025：Gemini3 pro全模态

<img src="/img/2026-06-27_11-34-52.png" style="zoom:50%;" />

<img src="/img/2026-06-27_11-36-51.png" style="zoom:50%;" />

<img src="/img/2026-06-27_11-39-18.png" style="zoom:50%;" />

<img src="/img/2026-06-27_11-43-38.png" style="zoom:50%;" />

## 按照里程碑

1. **Transformer（2017年）**：Transformer架构的引入，为构建大规模、高效的模型奠定了基础，这些模型能够以前所未有的精度和灵活性处理复杂任务。
2. **GPT-3（2020年）**：该模型展示了规模在人工智能领域的变革力量，证明了在大量数据集上训练的大规模模型可以在广泛的应用中实现接近人类的性能，为人工智能的发展树立了新的标杆。
3. **ChatGPT（2022年）**：ChatGPT将对话式人工智能带入主流，使先进的人工智能对普通用户来说更易获取、交互性更强。它还引发了关于广泛采用人工智能所带来的伦理和社会影响的重要讨论。
4. **DeepSeek-R1（2025年）**：DeepSeek-R1在成本效益方面取得了巨大飞跃，它采用混合专家架构和优化算法，与许多美国的模型相比，运营成本降低了多达50倍。其开源特性使前沿人工智能技术得以更广泛应用，赋能各行业的创新者，凸显了在塑造人工智能未来的过程中，可扩展性、校准性和可及性的重要性。

## 按照时间线

**一、技术奠基期（2017年之前）**

1. **早期神经网络与深度学习基础**
   - **1950-1980年代**：感知机、反向传播算法等基础理论奠定神经网络框架。
   - **2012年**：AlexNet在ImageNet竞赛中夺冠，深度学习进入爆发期。
   - **2014年**：Seq2Seq模型（用于机器翻译）和注意力机制（Attention）提出，为后续模型设计铺路。
2. **预训练思想的萌芽**
   - **2015年**：Word2Vec、GloVe等词嵌入技术普及，通过预训练词向量提升下游任务效果。
   - **2017年**：**Transformer架构诞生（Google《Attention Is All You Need》）**，彻底改变了序列建模方式，成为大模型的核心技术基础。

**二、预训练模型兴起（2017-2018年）**

**第一代预训练模型**

- 2018年：
  - **BERT**（Google）：基于Transformer编码器，通过掩码语言建模（MLM）实现双向语义理解。
  - **GPT-1**（OpenAI）：基于Transformer解码器，采用自回归生成式预训练，参数规模1.17亿。
- **核心突破**：通过海量无标注数据预训练+任务微调（Fine-tuning），模型泛化能力显著提升。

**三、参数规模跃升（2018-2020年）**

**模型参数突破十亿级**

- 2019年：
  - **GPT-2**（OpenAI）：参数15亿，首次展示Few-Shot Learning能力（无需微调即可完成多任务）。
  - **T5**（Google）：将自然语言任务统一为“文本到文本”框架，参数达110亿。
- 2020年：
  - **GPT-3**（OpenAI）：参数1750亿，Few-Shot/Zero-Shot能力颠覆传统AI开发范式，引发行业震动。
  - **Turing-NLG**（微软）：参数170亿，推动大模型落地应用。

**四、多模态与通用智能探索（2020-2022年）**

1. **从单一模态到多模态融合**
   - 2021年：
     - **CLIP**（OpenAI）：图文跨模态对比学习，实现零样本图像分类。
     - **DALL·E**（OpenAI）：文本生成图像，开启多模态生成时代。
   - 2022年：
     - **Stable Diffusion**：开源文生图模型，推动AIGC普及。
     - **Florence**（微软）、**BEiT-3**（微软）：多模态统一建模。
2. **大模型生态爆发**
   - **开源社区活跃**：Hugging Face平台推动模型共享，Meta发布LLaMA系列开源模型。
   - **垂直领域应用**：医疗、法律、编程等场景涌现专用模型（如Codex、Galactica）。

**五、通用人工智能（AGI）的探索与争议（2023年至今）**

1. **技术突破与产品化**
   - 2023年：
     - **GPT-4**（OpenAI）：支持多模态输入，逻辑推理能力显著提升，参数规模未公开。
     - **PaLM 2**（Google）、**LLaMA 2**（Meta）：优化训练效率与安全性。
     - **Claude 2**（Anthropic）、**Bard**（Google）：对话模型竞争白热化。
   - **国内进展**：百度“文心一言”、阿里“通义千问”、华为“盘古”、智谱AI“GLM”、“DeepSeek”等。
2. **技术争议与挑战**
   - **算力与成本**：千亿级模型训练需数百万美元投入，中小企业难以参与。
   - **伦理与安全**：生成内容偏见、虚假信息、版权问题引发监管关注。
   - **环境成本**：大模型训练碳排放高，可持续发展受质疑。

**六、未来趋势**

1. **模型高效化**：降低训练成本（如MoE架构、模型压缩技术）。
2. **多模态融合**：视频、3D等多维度数据建模。
3. **具身智能**：结合机器人、传感器实现物理世界交互。
4. **可信AI**：提升可解释性、安全性和伦理对齐。

# 全网最全名词

- [一口气拆穿Skill/MCP/RAG/Agent/OpenClaw底层逻辑](https://www.bilibili.com/video/BV1ojfDBSEPv/?spm_id_from=333.1007.top_right_bar_window_history.content.click&vd_source=bd4c7d99d71adf64d6e88c65370e0247)
- [思维脑图](https://www.processon.com/mindmap/6a2e0fe952e2c91543829054)

<img src="/img/2026-06-14_13-30-25.png" style="zoom:50%;" />

## **LLM(Large Language Model)大语言模型**

本质：弱智的语言模型在参数量逐渐扩大时，突破临界值，涌现了只能。

LLM 是基于 Transformer 架构、参数量达到十亿～万亿级，通过“预测下一个词”的方式在海量文本上训练，再经过指令微调和人类对齐，从而能聊天、写代码、做推理等通用任务的 AI 模型。

## **对话**

LLM只能“预测下一个词”，对话让它开始快速使用。只能一问一答，不能自动追问。

## **Prompt提示词**

分为背景信息+最终指令

## **Context上下文**

也就是上面的背景信息

## **Memory记忆**

将之前的对话历史放到context部分，作为背景信息，这样大模型就有记忆

## **智能体Agent**

用户想让小L帮忙查询天气，但它没有上网的能力，所以智能体来了(一段程序)，能上网。

以前的智能体其实就是加了一段提示词Prompt，再去问大模型，其实就是诈骗。

## **RAG检索增强生成**

既然Agent能上网，那么也可以搜索本地文件(向量数据库)，将匹配好的语义的向量数据，加入到context，实现搜索功能，就是RAG

## **Function Calling**

LLM与Agent之间交互，不能总使用自然语言(汉字)，Agent是不知道LLM怎么描述需求(LLM可能会胡说)，所以需要一套固定的约定的对话格式，就是Function Calling。

## **MCP模型上下文协议**

之前Agent是把上网能力，搜索本地文件能力放到自己内部，没有解耦。现在优化下，解耦出来，但是也需要Agent与工具一套固定的约定的对话格式，就是MCP

> 所以目前形成:LLM(只会说不会做的弱智)，MCP服务提供各种服务，Agent就是传话筒(不生产信息，只是信息的搬运工)。

> 后续可能会退化。常用的MCP会内化到Agent主程序内部，基础的MCP会被封装到常用的skill中。

## **LangChain编程框架**

接下来我们专注用户与Agent之间交互，形式有多种多样，主要分为三类：CLI、TUI、GUI，

> - CLI：纯文本命令行，敲字执行，效率高、资源少、适合自动化和服务器运维。
> - TUI：在终端里用字符“画”出来的界面，有菜单/窗口，但仍是文本，比 CLI 更直观，比 GUI 更轻量。
> - GUI：常见窗口/图标/鼠标那种图形界面，直观好用，但资源消耗大、自动化弱。

比如：

> - CLI命令行：iFlow，Codex，Claude Code
> - IDE界面:Trae，Antigravity，Cursor
> - 桌面助手：OpenClaw，Moltbot，Clawdbot

有一种场景，用户需要智能体完成pdf翻译任务：PDF文件-提取-翻译-保存文件。我们可以把提取和保存环节固化为程序，翻译交给LLM。这样一套流程可以用编程实现，就是LangChain。

## **workflow工作流**

为了照顾非程序员，用低代码的拖拉拽替代编程的LangChain，就是workflow。个人认为是比较鸡肋的存在。

## **Skill技能**

在上述pdf翻译任务，如果源文件换成其他格式如word,excell等，要么你要增加大量if else，要么用脚本事先控制好，如from_doc.py,from_txt.py,to_pdf.py,to_word.py。用自然语言动态调用脚本，就是skill。

在未来，skill可能也只是一个中间产物，未来会有更灵活更好用的形式出现，更符合人直觉无脑使用。

## SubAgent子任务

Agent处理复杂任务可能上下文非常庞大，且耦合。这时就可以拆分为子任务，且上下文隔离。这就是SubAgent

# Loop Engineering

**2026 年 6 月在 AI 编程社区爆火的一种新工程范式，核心思想是：开发者不再手动一轮一轮地给 Agent 写提示词，而是设计一套让 Agent 自主发现工作、执行、验证、迭代，直到目标达成的自动循环系统。**

本质就是一个定时任务，国内厂商早就支持了

# 1M Context

1M上下文：模型支持用户一次输入喂给100万Token的信息量。

以GLM5.2为例，解决的痛点，[原文](https://z.ai/blog/glm-5.2)：

> - 计算量：IndexShare。复用注意力机制的层，减少计算量的层级。
> - 存储空间(KV缓存)：LayerSplit解决KV缓存占用。只存部分层的KV Cache，减少显存占用。
> - 有效性：Slime RL。

# 文生图/视频架构

**架构演进**

<img src="/img/2026-06-27_11-58-02.png" style="zoom:50%;" />

**核心原理**

<img src="/img/2026-06-27_10-55-33.png" style="zoom:50%;" />

**AI视频**

> - 可行：(适合解空间较大的视频)适合人工成本巨大，视觉冲击力强，对内容本身影响不大
> - 不可行：人工成本小，视觉冲击力弱，需要和内容深度配合

# 蒸馏/开源

大模型本质Fn(x) =  ax + b

|      | 传统语境   | 大模型语境                   |
| ---- | ---------- | ---------------------------- |
| 开源 | 开放源代码 | 开放参数权重                 |
| 蒸馏 | 知识蒸馏KD | 使用模型输出作为输入训练数据 |

# 小龙虾OpenClaw

（曾用名Clawdbot/Clawbot/Moltbot）

**基础版Agent**

带有记忆功能的聊天机器人，本质就是缓存了历史对话

<img src="/img/2026-06-26_18-05-06.png" style="zoom:50%;" />

**高级版Agent**

小龙虾本质：带有提示词Skill的工具。当然它会更智能，还要基于自主的ReAct范式。

<img src="/img/2026-06-26_18-10-42.png" style="zoom:50%;" />

Agent.md：智能体的调度逻辑

```
你的目标是完成用户的任务，你必须选择下面的其中一种格式进行回复：
1：如果你认为需要执行命令，则输出命令：XXX"，XXX为命令本身，不要用任何的格式，不要解释，每次只进行一条命令，不要多条放一起
2.如果你认为不需要执行命令，则输出完成：XXX，XXX为你的总结信息
我们的沟通过程是个循环，你每次回复一条命令后，要等我给你返回命令执行的结果，然后你再继续回复。

比如：
用户：创建一个hello.txt和helloworid.txt文件
AI：命令：echoihellohello.txt
用户：执行成功
AI：命令：echoThettoworld”helloworld.txt
用户：执行成功
AI：完成：我已经完成了用户的需求、hello.txt和helloworld.txt文件已经创建成功
```

Skill.md：工具的执行逻辑

```
如果需要获取新闻，使用如下命令，XXX为用户希望搜索的关键词
curl-L-AMozilla/5.0！“https://news.google.com/rss/search？q=XXX&hl=zh-CN&gL=CN&ceid=CN:zh-Hans'
```

当然前面这些都是命令行，太丑了，小龙虾火爆，主要是因为换皮。启动一个http服务，然后部署到页面中，手机访问页面，输入需求，就能远程任意操作电脑了。

<img src="/img/2026-06-26_18-20-35.png" style="zoom:50%;" />

# Claude源码泄露

[github仓库地址](https://github.com/fuyunjinglong/LLM/tree/claudecode-haha)

<img src="/img/2026-06-23_21-42-12.png" style="zoom:50%;" />

# Harness

<img src="/img/2026-06-15_21-24-49.png" style="zoom:30%;" />

一句话：驾驭工程，增加限制条件，限制输出。

比如用户驾驭Agent,Agent驾驭大模型LLM,都属于Harness。用户驾驭Agent,常用的有OpenSpec,SpecKit等中间层

# 韬（τ）定律

历史的摩尔定律(Scalling Law缩放定律在元器件上的应用)：把晶体管越做越小（几何缩微），在单位面积塞更多晶体管。

华为的T定律：*τ*=*R*×*C*，电路从一个状态切换到另一个状态所需的时间。不再执着于尺寸，而是**系统性降低信号传播时延（τ）**，让数据在芯片里“跑得更快、绕路更少”

华为给出的框架，是**器件–电路–芯片–系统**四层协同，围绕“降低 τ”一起优化

# Vibe Coding

# Transformer演进

[Transformer架构图](https://www.processon.com/mindmap/6a2e40300bc6156068f379d1)，如下图：

<img src="/img/2026-06-14_15-54-48.png" style="zoom:50%;" />

**优化-Positional Embedding 位置编码**

定义：原向量+新向量

新向量计算，有多种算法“

> - 固定位置编码PE
> - 旋转位置编码RoPE：向量在计算点积时，得到更友好的位置特性
> - 旋转位置编码的扩展方法YaPE：支持更长的上下文位置计算
> - 没有位置的编码NoPE

**优化-Norm归一化**

1.作用于词向量

为了稳定训练，需要把向量的位置控制在一个可控范围，且之间的相对差距不变。即把数据变换到一个更稳定的范围。

在原始论文叫LayerNorm层归一化，在LLM中叫*RMSNorm*。

Norm归一化放在Attenttion注意力层的前面，叫Pre-Norm前向归一化。放到后面叫Post-Norm后向归一化。

Pre-Norm放在残差链接前面，叫Pre-Norm before Residual。放到后面叫Pre-Norm after Residual。

> - Pre-Norm
> - Post-Norm
> - Pre-Norm & Post-Norm：前面放一个，后面放一个
> - Pre-Norm before Residual
> - Pre-Norm after Residual
> - ...

2.作用于注意力层里面(QKV)

作用于Q向量，叫Q-Norm。也可以同时作用于QK,叫QK-Norm

> - Q-Norm
> - K-Norm
> - V-Norm
> - QK-Norm
> - ...

**优化-残差连接**

原始论文中的算法是简单加法计算，后优化算法：

> - HC超连接：字节
> - mHC流形约束的超连接：DeepSeek
> - AttentionResidual注意力残差：Kimi

**优化-FFN前馈神经网络层**

1.MoE架构

原始是一个普通的全连接神经网络。因为LLM的FFN太过于庞大，所以拆分成很多个小的FFN,也叫Expert专家。增加一个底座叫可训练的Router路由层，每次Token计算只路由到一个小FFN上。这就实现了总参数量很多，但推理时只激活少量的参数到小FFN。这就是MoE（混合专家模型）

<img src="/img/2026-06-14_14-43-01.png" style="zoom:20%;" />

2.DeepSeek进一步优化Expert

拆分为更小的Expert，引入共享Expert概念。就叫做DeepSeek MoE。

> - 目前很多模型名称上，比如397B-A17B，类似AxxxB就是MoE架构，表示总参数量397B，推理只激活17B参数量。
> - FFN架构分类
>   - Dense稠密类型：以前的所有参数参与计算的模型
>   - Sparse稀疏类型：目前只激活部分参数的模型即MoE

**优化-Attenttion注意力层(卷王)**

核心解决的问题：每个Token向量需要与其他向量进行一次计算，所以烧Token。

所以为了降低成本，要么缩短向量长度，要么减少计算次数。

> - 缩短向量长度：Dense(MQA/GQA/MLA)
> - 固定窗口计算或部分计算：Sparse(DSA/SWA/CSA/HCA)
> - n2转为n的线性计算：Linear

1.Dense稠密类型

> - MHA：多头注意力
> - MQA：多查询注意力
> - GQA：分组查询注意力
> - MLA：多头潜在注意力

2.Sparse稀疏类型

> - DSA：DeepSeek Sparse Attention
> - SWA：滑动窗口注意力
> - CSA/HCA：Compressed Sparse Attention

3.Linear Attention(hybrid)线性注意力(混合架构)

> - KDA：Kimi Delta Attention
> - GatedDeltaNet：Gated Delta Networks
> - Lighting Attention：Lighting Attention-2
> - Manba：一种SSM(State Space Model)状态空间模型，新出的

# Kimi的注意力残差

<img src="/img/2026-06-24_18-16-38.png" style="zoom:30%;" />

梯度消失与梯度爆炸

> - 两者都是影响神经网络训练的稳定度
> - 梯度消失：输入参数基本不影响输出参数
> - 梯度爆炸：输入参数完全影响输出参数

1.传统的残差连接

> a1 = a0 + F(a0)，其中F函数可以是任意的，比如注意层，MoE层等等
>
> 缺点：输出参数不可控

<img src="/img/2026-06-24_18-21-35.png" style="zoom:30%;" />

2.字节的HC超连接

> 优点：解决传统的不可控，通过复制多分参数和连乘矩阵，限制输出
>
> 缺点：连乘矩阵可能导致参数不可控

<img src="/img/2026-06-24_18-24-48.png" style="zoom:50%;" />

3.DeepSeek的mHC流形约束的超连接

> 优点：连乘矩阵进控制下，替换为限制矩阵，进一步限制输出

4.Kimi的注意力残差

> - 在深度上模仿RNN在时间维度上的做法，依次累加传递
> - 既然是从左到右，依次传递，那么是不是也可以采用注意力机制的方法，进行各个参数的加权求值，每个参数都记录前面参数的信息
> - 基于Scalling Law定律，最终可以提升训练的效率，提升了1.25倍

<img src="/img/2026-06-24_18-36-11.png" style="zoom:50%;" />

# Scalling Law定律

**Scaling Law 描述的是：大语言模型的测试损失（Loss）会随着模型参数量 N、训练数据量 D、计算量 C 的增长，按照稳定的幂律关系下降**

Scaling Law 围绕三个核心变量展开：

| 变量  | 含义                         | 说明             |
| ----- | ---------------------------- | ---------------- |
| **N** | 模型参数量（不含嵌入层）     | 模型的"大脑容量" |
| **D** | 训练数据规模（Token 数）     | 模型的"学习资料" |
| **C** | 计算量（FLOPs 浮点运算次数） | 模型的"学习时间" |

# DeekSeek演进

<img src="/img/2026-06-15_20-09-56.png" style="zoom:50%;" />

- DS LLM：基于Scalling Law缩放定律，在大模型中应用就是参数越多，模型性能越强。研究参数量，batch size、学习率、训练数据、算力。
- DS MoE：优化底层Transform，拆分FFN为更小专家和共享专家。
- DS V2：优化底层Transform，优化多头注意力机制MLA
- DS V3：引入auxiliary-loss-free(无辅助损失的负载均衡策略)、MTP(多Token预测)、FP8 Training，总参数量671B,激活参数37B
- DS R1：优化训练范式，采用RL奖惩(没有用SFT)训练推理，在结合自己的GRPO强化学习算法，举世闻名。
- DS mHC：优化底层Transform，优化残差连接，mHC流形约束。
- DS V4：优化底层Transform，优化多头注意力机制，旧的多采用滑动窗口。优化为DSA(主动找相关Token)，CSA(压缩历史Token)，HCA(长短距离不同压缩策略)

# 大模型测试

> - Reasoning and Academic Knowledge 推理和学术知识
>   - Humanity's Last Exam人类最后一次考试
>   - ARC-AGI-2 通用智商测试
>   - GPQA Diamond 谷歌搜不到答案的题目
>   - AIME 2025 全美数学邀请赛
>   - MathAreng Apex MaithAreng数学题最难版
>   - MMMLU 多语言学科知识
>   - Global PIQA 全球化的常识推理题
> - image 图像
>   - MMMU-Pro 多学科多模态测试
>   - ScreenSpot-Pro 屏幕截图理解
>   - CharXiV Reasoning 图表理解能力
>   - OmniDocBench 1.5 文档识别
> - video 视频
>   - video-MMMU 各个学科知识
> - code 代码
>   - LiveCodeBench Pro 是持续更新的
>   - Terminal-Bench 2.0  大模型在终端里完成的操作测试
>   - SWE-Bench Verified 目前测试大模型最权威的，测试落地的真实工程能力
> - Factuality 事实性
>   - FACTS Benchmark Suite 用一个模型判断另一个模型是否存在幻觉
>   - SimpleQA Verified
> - Tool Use 工具使用
>   - t2-bench 在双重控制环境中评估对话代理
>   - Vending-Bench2
> - Long Context 长文本
>   - MRCR v2 多轮长文本

# 张量

本质就是多维数组，只是在深度学习领域的一个特殊叫法。Pytorch框架为了方便大家写代码，设计了TensorFlow库来操作张量。基本思路：在内存中尽量保证张量只存一份。

<img src="/img/2026-06-29_18-16-32.png" style="zoom:50%;" />

# CPU/GPU/NPU

> - CPU：处理复杂的通用任务，串行执行
> - GPU：处理简单的加减乘除运算，并行计算
> - NPU：神经处理单元，增加了Tensor Cores张量核心，更强的张量矩阵计算能力

以英伟达的RTX5090显卡为例，内部是Blackwell架构的GB202核心，共有12个GPC，每个GPC有8个TPC，每个TPC有2个SM单元，每个单元有128个流处理器(CUDA核心)。最终共有24000个CUDA核心，CUDA核心就是张量计算的基本单元。

再比如，英特尔酷睿ultra9，内核数16(SM单元)，总线程数22(CUDA核心)，最终有12x8x2x16x22=24511个CUDA核心。

# 3000多个开源模型归一化

大模型框架本质：模型结构(层)+模型权重(传递参数)。一般说开源模型，指的是开源模型的权重文件。

**模型结构如下，**

<img src="/img/2026-06-29_19-09-11.png" style="zoom:50%;" />

**模型权重如下，**

<img src="/img/2026-06-29_19-11-11.png" style="zoom:50%;" />

**逐步归一化，以Qwen为例：**

> - Qwen模型总数：355
> - 只保留文本类型的模型总数：还剩255
> - 去掉量化后的模型：还剩109
> - 去掉微调后的模型：还剩39
> - 忽略不同模型权重的模型：还剩8
> - 合并相同模型架构的：还剩6个(Qwen，Qwen2 ，Qwen3，qwen2_moe,qwen3_moe,qwen3_next)
> - 最后万物归一
>   - Transform：大模型理论鼻祖
>   - Llama：大模型实践鼻祖

# AI编程工具

编程工具-国外

- Copilot:github出品
- Cursor:能用御三家模型但定位尴尬，能用claude模型就用CC，能用GPT就用Codex，能用Gemini就用AntiGravity。
- CloudeCode:上手门槛高,简称CC，主力
- Codex:CC的竞争对手，只能接入自家模型，辅助
- AntiGravity:介于Codex和Cursor之间
- Windsurf：Cursor的竞争对手，有flow强大上下文管理能力，与openAI有争议，公司稳定性待定

编程工具-国内

- Trae：国内阿里第一
- Qoder:阿里，上下文管理和工程能力弱于Trae，agent和harness弱于Trae
- 通义灵码
- Codebuddy:腾讯，上下文管理和工程能力弱于Trae，agent和harness弱于Trae
- 文心快码(百度/Comate)
- CodeGeeX(智普AI)

无代码编程工具

- replit：美观且周全
- lovable：
- iFlow：一键创建网页的Agent，[官网](https://iflow.cn/)

UI设计工具

- Figma：老牌原型图软件，支持MCP
- Pencil:Figma的竞争对手
- Stitch：手绘方式生成设计稿

御三家模型
