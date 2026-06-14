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

# Transformer演进

Transformer架构图，如下图：

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
