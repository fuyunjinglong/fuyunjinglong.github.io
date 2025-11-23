---
title: LLM_国内外大模型2
date: 2025-11-23 06:33:16
categories:
- B_LLM
toc: true # 是否启用内容索引
---

**本周更新（2025/11/17~2025/11/21）**

- **Hunyuan：**国内开源组更新视频模型 **Hunyuan Video 1.5** 及[技术报告](https://zhuanlan.zhihu.com/p/1975510501715878703)，音频模型 **HunyuanVideo-Foley**；
- **Gemini：**国外闭源组更新推理模型 **Gemini 3 Pro** 和 **Gemini 3 DeepThink ；**新增图像模型 **Gemini 3 Pro Image(Nanano Banana Pro)**；
- **Grok:** 国外闭源组更新通用模型 **Grok 4.1，**推理模型 **Grok 4.1 Thinking。**

![image](/img/20251123-LLM.png)

LMSYS竞技场总榜前10（2025/11/17快照）。Grok 4.1的头把交椅还没坐热，Gemini 3 Pro就新王登基了，而且估计又能统治很久。国内的面子靠Kimi和Qwen撑着。

**11月更新**

- **[OpenAI](https://zhida.zhihu.com/search?content_id=237146705&content_type=Article&match_order=1&q=OpenAI&zhida_source=entity)：**国外闭源组更新通用模型 **GPT-5.1**，推理模型 **GPT-5.1-Thinking**；
- **百度文心：**国内闭源组更新 **Ernie-5.0-preview**；
- **Kimi：**国内开源组更新推理模型 **Kimi-K2-Thinking**；
- **Qwen：**国内闭源组更新推理模型 **Qwen3-Max-Thinking-Preview**；

**注：目前由于All in One的模型较少，暂时归到通用类，如Qwen-Omni系列；混合推理模型也还在兴起初期，暂时将其拆分为一个通用模型和一个推理模型，如GPT-5，Claude Sonnet 4.x，DeepSeek-3.2，Kimi-VL，GLM-4.5V等；还有OCR模型、世界模型、3D模型也还不足以成类，先不加入本文。**

## ----- **国外部分** -----

经过了两年的发展，国内外AI大模型的差距在不断缩小，但整体国外仍有一个身位的领先优势，尤其是通用模型，OpenAI，Google，[Anthropic](https://zhida.zhihu.com/search?content_id=237146705&content_type=Article&match_order=1&q=Anthropic&zhida_source=entity)这三家公司除了性能交替领先，更重要的是**行业趋势目前仍然一直由这几家公司把握**。

国外的大模型大多数都需要架梯翻墙才能访问，而且由于生成的内容相对自由，国内企业使用起来可能会要注意合规风险。

## 闭源组

### 通用类

- **ChatGPT**: [https://chatgpt.com](https://link.zhihu.com/?target=https%3A//chatgpt.com/)

OpenAI研发的大模型应用。2025年11月推出最新的通用模型**GPT-5.1。**和能力不及预期的GPT-相比，**对话风格更加亲切**，**更善于对话，指令遵循也做得更好。***目前OpenAI模型整体实力确实不如\*[Deepmind](https://zhida.zhihu.com/search?content_id=237146705&content_type=Article&match_order=1&q=Deepmind&zhida_source=entity)\*，但加上整个应用生态还是有一战之力。*

- **Gemini**: [https://gemini.google.com](https://link.zhihu.com/?target=https%3A//gemini.google.com/)

Google Deepmind研发的大模型。2025年3月份发布了**Gemin 2.5 Flash**，默认采用thinking模式拥有地表最长上下文10M(2M稳定) token。详见[【LLM技术报告】《Gemini 2.5：通过先进推理、多模态、长上下文和下一代智能体能力推动前沿发展》](https://zhuanlan.zhihu.com/p/1918678603194938170)。*Gemini目前模型性能综合实力最强，结合搜索业务的Deep Research是行业标杆**。***

- **Claude**: [https://claude.ai/](https://link.zhihu.com/?target=https%3A//claude.ai/)

Anthropic研发的大模型。

2025年10月发布**Haiku 4.5**，在保持与Claude Sonnet 4相近性能的同时，实现了超过**2倍的响应速度**和仅为**1/3的运营成本**；

9月发布**Sonnet 4.5**，在**构建复杂智能体**和**Computer Use**方面表现最为出色。新增了**上下文编辑**功能和**内存工具**，使智能体能够运行更长时间，处理更复杂的任务能够在复杂的、多步骤的任务上保持超过30小时的专注；

8月发布了**Opus 4.1**，将**编码性能**提升至SWE-bench Verified基准测试的74.5%，还显著增强了Claude的**深度研究**和**数据分析**能力，尤其在**细节追踪**和**智能体搜索**方面表现突出。

*曾经有段时间在\*[LMSYS Arena](https://zhida.zhihu.com/search?content_id=237146705&content_type=Article&match_order=1&q=LMSYS+Arena&zhida_source=entity)\*跑分占据过首位，但后续并不热衷于刷分，版本更新也比较佛系，公认最强的领域是**Coding***。

- **Grok**: [https://grok.x.ai/](https://link.zhihu.com/?target=https%3A//grok.x.ai/)

一龙马斯克旗下的xAI研发的大模型，采用**最新版本闭源早期版本开源**的策略，其中v3.0版本已经开源。2025年11月发布最新版本v**4.1**。在LMSYS当了一天的老大就被友商Gemini超越。和4.0版本相比，4.1通过创新的**智能体奖励模型训练方法**，提升了**模型的情商**以及**写作时“人味”**，并**大幅降低幻觉率**。

- **Mistral**: [https://mistral.ai/news/mistral-large-2407/](https://link.zhihu.com/?target=https%3A//mistral.ai/news/mistral-large-2407/)

法国[Mistral AI](https://zhida.zhihu.com/search?content_id=237146705&content_type=Article&match_order=1&q=Mistral+AI&zhida_source=entity)发布的闭源大模型。2025年5月发布**Mistral 3 Medium**。*除了便宜，没有更多量化的公开指标*。2024年7月发布了**Mistral Large 2**，拥有**128K** 上下文，参数**123B，**详见[《Large Enough》——Mistral Large 2简介](https://zhuanlan.zhihu.com/p/712607460)。尽管作为欧洲独苗，MistralAI最近不太参与通用模型的竞争，专注于小模型和一些细分领域的小创新，但业内人士应该还记得[Mixtral 8x7B](https://zhuanlan.zhihu.com/p/678442100)发布时对行业的贡献。

### 推理类

- **OpenAI**

2025年11月发布**GPT-5.1 thinking**，和 GPT-5 相比，能更精确地**根据问题调整其思考时间**——在复杂问题上花费更多时间，同时对简单问题做出更快的响应。回应也**更清晰**，**使用的专业术语和未定义的术语更少。**

2025年6月推出最新的推理模型**o3 pro**，*多模态推理能力大大提升***。**

- **Gemini**：

Google Deepmind发布的推理模型，2025年11月份发布了 **Gemin 3 Pro** 和**Gemin 3 Deep Think***。*在推理、多模态理解和智能体能力上实现了质的飞跃。**Gemini 3 Pro**在几乎所有主要的 AI 基准测试中都显著优于 2.5 Pro；**Gemini 3 Deep Think** 作为全新的增强推理模式，在高难度测试中表现卓越，并在 ARC-AGI-2 上取得了 **45.1%** 的突破性成绩。详见《[如何评价谷歌在2025年11月18日凌晨发布的gemini3.0pro模型？](https://www.zhihu.com/question/1974268445404177395/answer/1974428193382488040)》

- **Claude**

Anthropic发布的推理模型，2025年9月发布**Claude Sonnet 4.5 Extended Thinking**。8月发布**Claude Opus** 4.1 **Extended Thinking。**

- **Grok**

xAI发布的推理模型，2025年11月发布**Grok 4.1 Thinking**。

- **Magistral**

Mistral发布的推理模型，2025年9月发布了的**Magistral** **Medium v1.2**，增加了多模态支持，提升了模型本身和工具使用时的智能。*整体性能在第二梯队*，*主要优点是快*。

### 图像类

- **Google Deepmind**

**Gemini 3 Pro Image(Nano Banana Pro)：**[https://blog.google/technology/ai/nano-banana-pro/](https://link.zhihu.com/?target=https%3A//blog.google/technology/ai/nano-banana-pro/)

2025年11月Google Deepmind更新的Gemini原生的图像生成能力。相比于前一个版本更擅长二创的Nano Banana，Pro版本基于Gemini 3强大的推理能力和世界知识，**文生图**的能力也显著加强，**多语言文本的渲染**大幅升级；二创时支持参考多达**14张图像**，并保持多达**5个人物**的一致性和相似度，以及更加精细化的**图片局部编辑**。详见《[如何评价谷歌发布新一代图像生成模型 Nano Banana Pro，有哪些亮点？](https://www.zhihu.com/question/1974981372130116043/answer/1975151243409237258)》

**Gemini 2.5 Flash Image(Nano Banana)：**[https://gemini.google.com/](https://link.zhihu.com/?target=https%3A//gemini.google.com/)

2025年8月Google Deepmind更新的Gemini原生的图像生成能力。相比于强大的专业生图模型Imagen，Gemini在生图质量不输前者的前提下，吸取更多**对话模型的优点**，让图像在多轮对话中可以保持更好的**一致性**，让图像生成和修改**更可控**。*相比Imagen 4的原创能力，nano banana的强项是二创能力。*

**Imagen 4**：[https://deepmind.google/models/imagen/](https://link.zhihu.com/?target=https%3A//deepmind.google/models/imagen/)

Google Deepmind 2025年5月发布的AI图像生成模型。*在LMSYS竞技场T2I子榜上Image 3长期霸榜，Imagen 4生图质量比3高，速度比3快，很可能扩大领先优势。*

- **OpenAI**

**GPT-4o**

2025年4月OpenAI更新的GPT-4o原生的图像生成能力。*似乎超越DALL·E 3了？*

**DALL·E 3**: [https://openai.com/dall-e-3](https://link.zhihu.com/?target=https%3A//openai.com/dall-e-3)

OpenAI研发的AI图像生成器。

- **[Midjourney](https://zhida.zhihu.com/search?content_id=237146705&content_type=Article&match_order=1&q=Midjourney&zhida_source=entity)**: [https://www.midjourney.com/](https://link.zhihu.com/?target=https%3A//www.midjourney.com/)

Midjourney研究实验室开发的生图模型，可以实现文字生图和图生图。2025年3月发布**v7.0**。*和Stable Diffusion一起出道的生图元老，但是更新太过缓慢，听闻主程已离职，不知是否要退出历史年舞台了。*

### 视频类

- **[Veo 3.1](https://zhida.zhihu.com/search?content_id=237146705&content_type=Article&match_order=1&q=Veo+3.1&zhida_source=entity)**: [https://deepmind.google/technologies/veo/](https://link.zhihu.com/?target=https%3A//deepmind.google/technologies/veo/)

Google Deepmind在2025年10月发布的AI视频生成模型。相比5月份发布的3.0版本，**音频生成**、**指令遵循**、**视频真实感**这几个维度都有显著增强的同时*，***新增“插入”工具***，*可在视频中添加新元素并自动匹配光影**。**

- **[Gen-4](https://zhida.zhihu.com/search?content_id=237146705&content_type=Article&match_order=1&q=Gen-4&zhida_source=entity)**: [https://app.runwayml.com/](https://link.zhihu.com/?target=https%3A//app.runwayml.com/)

Runway在2025年4月发布的AI视频生成模型，在3.0的基础上，大幅增强了角色、场景的一致性， 让生成视频可以支持更长的叙事，从前几代的创意玩具开始变得更接近可用的生产力工具。

- **Pika**: [https://www.pika.art/](https://link.zhihu.com/?target=https%3A//www.pika.art/)

Glen Pika在2023年11月发布的AI视频生成产品，支持文生视频、图生视频和视频生视频，2025年2月推出2.2版本，生成效果提升，加入了好玩但没啥实用性的Pikaafferts。

- **Luma AI**: [https://www.lumalabs.ai/dream-machine/](https://link.zhihu.com/?target=https%3A//www.lumalabs.ai/dream-machine/)

Luma Labs在2025年9月发布的电影级视频生成产品，增加了CoT推理生成功能，使用专业ACES2065-1 EXR标准生成真正的高动态范围视频，支持10位、12位和16位格式，可以生成时长约**10秒**。

- **Stable Video Diffusion**: [https://stability.ai/stable-video](https://link.zhihu.com/?target=https%3A//stability.ai/stable-video)

Stablility AI发布的AI视频生成模型，以两个图像到视频模型的形式发布，能够以每秒 3 到 30 帧的可定制帧速率生成 14 帧和 25 帧，生成视频时长2-5秒。需下载代码布署本机使用，对电脑硬件配置有一定的要求。

- **[Sora 2](https://zhida.zhihu.com/search?content_id=237146705&content_type=Article&match_order=1&q=Sora+2&zhida_source=entity)**: [https://openai.com/index/sora-2/](https://link.zhihu.com/?target=https%3A//openai.com/index/sora-2/)

OpenAI在2025年9月发布的AI视频生成模型，其Pro版本能够生成**20秒**的**1080p**视频，而plus版本则生成**10秒**的**720p**视频 。和去年12月被迫上线的Sora相比，其进步体现在对**真实物理世界的模拟**、多模态的整合以及对生成过程的精细控制上

- **Midjourney：**[https://www.midjourney.com/](https://link.zhihu.com/?target=https%3A//www.midjourney.com/)

Midjourney研究实验室开发的视频生成模型，2025年6月发布**v1.0**。采用图像转视频（I2V）的工作流程，支持用户上传外部图像并进行动画处理。

### 音乐类

- **Suno**: [https://suno.ai](https://link.zhihu.com/?target=https%3A//suno.ai/)

[Suno AI](https://zhida.zhihu.com/search?content_id=237146705&content_type=Article&match_order=1&q=Suno+AI&zhida_source=entity)研发的音频大模型。2025年9月发布了**v5.0**，相对于v4.0，完成了**音质升级**，达到了录音室级别；还能像**专业工作站**一样，拆解歌曲的鼓点、合成器、人声等 12 个分轨，随意替换、重组；对**音乐风格**也有更强的掌控力

### 音频类

- **[Stable Audio](https://zhida.zhihu.com/search?content_id=237146705&content_type=Article&match_order=1&q=Stable+Audio&zhida_source=entity)**: [https://www.stableaudio.com/](https://link.zhihu.com/?target=https%3A//www.stableaudio.com/)

Stablility AI发布的AI音频生成模型。

- **[MuseNet](https://zhida.zhihu.com/search?content_id=237146705&content_type=Article&match_order=1&q=MuseNet&zhida_source=entity)**: [https://openai.com/research/musenet](https://link.zhihu.com/?target=https%3A//openai.com/research/musenet)

OpenAI研发的AI音频生成模型。

- **V2A**: [Generating audio for video - DeepMind](https://link.zhihu.com/?target=https%3A//deepmind.google/discover/blog/generating-audio-for-video/)

Google Deepmind 2024年6月研发的音频生成大模型，可以根据源视频和文字prompt给源视频配上合适的BGM。详见[Generating audio for video——Google V2A简介](https://zhuanlan.zhihu.com/p/704353167)

## 开源组

### 通用类

- **[Llama](https://zhida.zhihu.com/search?content_id=237146705&content_type=Article&match_order=1&q=Llama&zhida_source=entity)**: [https://llama.meta.com/](https://link.zhihu.com/?target=https%3A//llama.meta.com/)

Meta研发的开源大模型，2025年4月发布了4.0版本，三个版本均为MoE架构，参数量分别为**17B╳16(Scout)/17B╳128(Marverick)/288B╳16(Behemoth)，**目前Scout和Marverick已上线。*四个字概括下，口碑崩了*。

- **Mistral**: [https://mistral.ai/](https://link.zhihu.com/?target=https%3A//mistral.ai/)

法国的大模型初创企业MistralAI于2023年9月份发布的模型系列。2023年12月发布了**Mixtral-of-Expert-7B**，是一个拥有8个专家层的MoE模型，详见[《Mixtral of Expert》精华摘译](https://zhuanlan.zhihu.com/p/678442100)。2024年4月发布了**Mixtral-of-Expert-22B。**2024年11月发布了多模态大模型**Pixtral Large**，124B参数，支持128K上下文，具备前沿级图像理解能力，能理解文本、图表和图像。2025年3月发布**Mistral Small 3.1**，参数量24B。

- **Gemma**: [Gemma 3: Google’s new open model based on Gemini 2.0](https://link.zhihu.com/?target=https%3A//blog.google/technology/developers/gemma-3/)

Google Deepmind发布的开源小语言模型，2025年3月发布了3.0版本，包括**1B**, **4B**, **12B**和**27B**几个大小。详见[【LLM技术报告】Gemma 3技术报告（全文）](https://zhuanlan.zhihu.com/p/29797829035)

- **Phi**: [Introducing Phi-4](https://link.zhihu.com/?target=https%3A//techcommunity.microsoft.com/blog/aiplatformblog/introducing-phi-4-microsoft%E2%80%99s-newest-small-language-model-specializing-in-comple/4357090)

微软发布的大语言模型，2024年12月发布了v4.0，截止目前只发布了**14B**参数的版本，虽然架构和phi-3类似但通过改进的数据质量、优化的训练课程以及创新的后期训练方案**，**展现出相较其参数规模的卓越表现，详见[《Phi-4技术报告》](https://zhuanlan.zhihu.com/p/12270688172)。

### 推理类

- **gpt-oss**：[https://huggingface.co/openai/gpt-oss-120b](https://link.zhihu.com/?target=https%3A//huggingface.co/openai/gpt-oss-120b)

OpenAI于2025年8月发布的开源推理模型，MoE架构，有**120B（A5.1B）**和**20B（A3.6B）**两个版本，性能分别于o4-mini和o3-mini相当。

- **Phi**

微软2025年5月发布的推理模型**Phi-reasoning**系列，包括加强版plus，和效率版mini。参数量和通用版本一致为**14B**。

- **Magistral**

Mistral发布的推理模型，2025年9月发布了并开源了**24B**参数的**Magistral Small v1.2**版本，增加了多模态支持，提升了模型本身和工具使用时的智能。

### 图像类

- **[Flux.1 Kontext](https://zhida.zhihu.com/search?content_id=237146705&content_type=Article&match_order=1&q=Flux.1+Kontext&zhida_source=entity)**: [https://bfl.ai/models/flux-kontext](https://link.zhihu.com/?target=https%3A//bfl.ai/models/flux-kontext)

2025年6月由Black Forrest Lab发布，参数量1.2B。和前版本**Flux.1**相比，当前版本亮点在于其上下文感知图像生成与编辑能力。与传统仅基于文本提示的图像生成模型不同，该模型能够同时理解文本和图像输入，实现真正的上下文生成与编辑

- **Stable Diffusion**: [https://stability.ai/stable-diffusion/](https://link.zhihu.com/?target=https%3A//stability.ai/stable-diffusion/)

由CompVis、Stability AI 和 LAION 的研究人员创建文本到图像潜在扩散模型，需下载代码布署本机使用，对电脑硬件配置有一定的要求，目前更新到了3.5版本。



## ----- **国内部分** -----

国内的大语言模型一开始都是为了想在这个市场中分一杯羹赶鸭子上架陆续上线的，不过在经历了一年多的发展后，和国外领先团队的差距在不断缩小，尤其是在**音乐**、**生图**、**生视频**和**推理模型**这几个细分领域大有赶超之势。

## 闭源组

### 通用类

- **深度求索（DeepSeek）**：[http://www.deepseek.com](https://link.zhihu.com/?target=http%3A//www.deepseek.com/)

幻方量化团队核心成员创立的AI大模型公司。目前通用模型（混合推理模型）为**V3.1-Terminus**版，推理模型为**R1**版本。*服务能力普通，没有多余的应用生态，全凭模型实力出圈。*

- **字节豆包**：[https://www.doubao.com/](https://link.zhihu.com/?target=https%3A//www.doubao.com/)（国内版），[https://www.ciciai.com/](https://link.zhihu.com/?target=https%3A//www.ciciai.com/) （海外版）。

字节跳动研发的大语言模型应用，通用模型版本为**Doubao-Seed-1.6**，国内首个支持256K token上下文长度的模型。*豆包系列整体性能中上，比较擅长的领域是**K12教育**，国内模型厂中在应用端最接近OpenAI。*

- **通义千问**：[https://qianwen.aliyun.com/](https://link.zhihu.com/?target=https%3A//qianwen.aliyun.com/)（国内版）[Qwen Chat](https://link.zhihu.com/?target=https%3A//chat.qwen.ai/)（海外版）

阿里通义团队研发的大语言模型应用，闭源模型版本为**Qwen3-Max。**拥有超过**1T**参数，在Qwen3的基础上，代码能力和agent能力方面进一步提升，在涵盖知识、推理、编程、指令遵循、人类偏好对齐、智能体任务和多语言理解的全面基准测试中均达到业界领先水平，详见《[Qwen3-Max：大就是好](https://zhuanlan.zhihu.com/p/1954142735188628684)》

*相对于只专注于模型性能的DeepSeek，Qwen更贴近应用，更全面。*

- **智谱清言（ChatGLM）**：[智谱清言](https://link.zhihu.com/?target=https%3A//chatglm.cn/) （国内版）[https://z.ai](https://link.zhihu.com/?target=https%3A//z.ai/) （海外版）。

清华大学 KEG 实验室和智谱 AI 公司于2023年共同训练的语言模型，目前模型版本为4.5，支持多模态。*模型性能和应用开发能力并存，股东实力较强。*

- **月之暗面(Kimi)**: [https://kimi.moonshot.cn/](https://link.zhihu.com/?target=https%3A//kimi.moonshot.cn/)

月之暗面研发的大语言模型应用。*曾经国内的**长文档阅读**之王，进入2025年后有些沉寂*。

- **腾讯元宝（混元）**：[https://yuanbao.tencent.com/](https://link.zhihu.com/?target=https%3A//hunyuan.tencent.com/)

腾讯研发的大语言模型应用，前身为腾讯混元，目前语言模型版本为**Hunyuan-TurboS**。2024年5月应用品牌升级为**腾讯元宝**，加入了微信公众号文章RAG搜索功能；2024年8月加入**深度阅读**功能。*2025年2月接入DeepSeek-R1后，下载量飚升，但后续的动作存在感都不强。*

- **Minimax：**[https://chat.minimaxi.com](https://link.zhihu.com/?target=https%3A//chat.minimaxi.com/)

MiniMax研发的大语言模型应用，主打出海C端用户。

- **阶跃AI：**[https://www.stepfun.com/chats/new](https://link.zhihu.com/?target=https%3A//www.stepfun.com/chats/new)

阶跃星辰研发的大语言模型应用。

- **文心一言**：[https://yiyan.baidu.com/](https://link.zhihu.com/?target=https%3A//yiyan.baidu.com/)

百度研发的国内首个大语言模型应用，2024年9月移动端APP品牌再次升级，将“文小言”改为“文心”。2025年11月发布通用模型**Enrie-5.0-preview，**采用**超稀疏MoE**架构，进行庞大的**全模态训练**，总参数规模超过 **2.4T**，激活参数比例低于3%。*起了个大早，赶了个晚集。目前在国内团队中也是全方位落后，正在全力追赶。*

- **百川智能**：[https://www.baichuan-ai.com/](https://link.zhihu.com/?target=https%3A//www.baichuan-ai.com/)

搜狗系研发的大语言模型应用，2024年5月发布4.0版本，应用品牌升级为**百小应**，加入联网搜索RAG功能。*近一年了没有什么动静，存在感比较薄弱。最近投身于医疗行业开发垂类大模型。*

### 推理类

- **字节豆包**

2025年6月发布推理模型**Doubao-Seed-1.6-Thinking，**独创**边搜边想**模式，支持256K上下文和多模态推理。1.5版本详见[《Seed-Thinking-v1.5：通过强化学习推进卓越的推理模型》](https://zhuanlan.zhihu.com/p/1894458400596796473)。2025年5月发布多模态推理模型Seed1.5-VL，详见[《Seed1.5-VL技术报告》](https://zhuanlan.zhihu.com/p/1906281736050050265)。

- **月之暗面**

2025年4月发布**K1.6推理版。**

- **阶跃AI**

2025年4月发布多模态推理模型**step-r1-v-mini。**

- **文心一言**

2025年4月发布推理模型**X1 Turbo；**9月发布了**X1.1**，上下文长度64K，其余参数不详**。**

- **腾讯混元**

腾讯混元团队2025年3月推出的推理模型 **Hunyuan-T1**，由于元宝集成了DeepSeek-R1，导致T1长期生存在R1的阴影之下没有存在感。

### 视频类

- **可灵AI**：[https://kling.kuaishou.com/](https://link.zhihu.com/?target=https%3A//kling.kuaishou.com/)

快手2025年9月发布的视频生成大模型**v2.5 Turbo**。相比于2.1版本，在**文本响应、动态效果、风格一致性**和**美学质量**等方面取得了实质性改进，并进一步增强了视频生成过程中的**可控性、稳定性**和**一致性，**且生成高质量视频相比2.1版本同档位价格**低近30%**。*与Google Veo 3并列行业top 2地位*。

- **doubao-seedance**：[https://www.volcengine.com/docs/82379/1587798](https://link.zhihu.com/?target=https%3A//www.volcengine.com/docs/82379/1587798)

字节豆包的视频生成模型，2025年6月份发布**1.0**版本。作为该模型系列的大参数量版本，具备独特的多镜头叙事能力，在各维度表现出色。它在语义理解与指令遵循能力上取得突破，能生成运动流畅、细节丰富、风格多样且具备影视级美感的 1080P 高清视频。

- **(MiniMax) Hailuo 2.3**：《[MiniMax Hailuo 2.3 视频复杂表现新高度 & Media Agent](https://link.zhihu.com/?target=https%3A//www.minimaxi.com/news/minimax-hailuo-23)》

MiniMax在2025年10月底推出的视频生成模型**。**和6月发布并更名为**Hailuo**的版本**02**相比，2.3版本**身体动态**和**面部表情更逼真传神**，对**物理世界的理解更深刻**，对**用户指令的遵循更透彻**，并增加了**AI视觉特效（VFX）**和**生成模式选择***。*

- **智谱清影**：[https://chatglm.cn/video](https://link.zhihu.com/?target=https%3A//chatglm.cn/video)

智谱AI推出的视频生成模型，默认生成视频时长为6秒钟，支持**视频风格、情感氛围、运镜方式**这些进阶参数。

- **通义万相（生视频）**： [https://tongyi.aliyun.com/wanxiang/videoCreation](https://link.zhihu.com/?target=https%3A//tongyi.aliyun.com/wanxiang/videoCreation)

阿里通义团队发布的视频生成模型产品，目前最新模型版本是2025年9月发布的 **Wan-2.5-Preview**。支持**文生视频**、**图生视频**、画面同步的声音生成，支持10秒长视频生成

### 音乐类

- **(MiniMax) Music-2**：《[MiniMax Music 2.0：让音乐创作属于每一个人](https://link.zhihu.com/?target=https%3A//www.minimaxi.com/news/minimax-music-20)》

Minimax在2025年10月底推出的端到端音乐生成模型。和9月份发布的 **Music 1.5** 相比，2.0能够驾驭**更多变的演唱风格**，能**更精准地控制乐器进行编曲**，输出表现**更专业的音频音质**，歌词容量也从 600 提升到 **2000** 字符。

- **Mureka：**《[Mureka.ai - AI Music Generator for Original Tracks](https://link.zhihu.com/?target=http%3A//www.mureka.cn/)》

昆仑万维发布的音乐生成模型，2025年7月发布**V7。**支持MusicCoT，区别于音乐生成模型常见的next token prediction生成方式，Mureka V7先搭音乐框架，再填充内容。在Song Quality Evaluation中的考分高过Suno v4.5。

### 音频类

- **(MiniMax) Speech-2.6**：[https://www.minimax.io/news/minimax-speech-26](https://link.zhihu.com/?target=https%3A//www.minimax.io/news/minimax-speech-26)

Minimax在2025年10月底升级的文转语音模型。相比8月发布的Speech 2.5，Speech 2.6的**延时更低**，端到端延迟降至**250ms**以下；支持**特殊格式文本解析**，URL、EMail、电话号码、日期不需要预处理也能正常表述；引入“**Fluent LoRA**”技术，解决**不完美音源声音克隆**的需求难点。

- **Qwen3-TTS：**[https://huggingface.co/spaces/Qwen/Qwen3-TTS-Demo](https://link.zhihu.com/?target=https%3A//huggingface.co/spaces/Qwen/Qwen3-TTS-Demo)

通义团队在2025年9月发布的文本转语音模型，拥有领先的中文和英文稳定性，17种表现力丰富的声音 × 10 种语言，在中文、英文、意大利语、法语方面达到 SOTA水平，其中中文支持超过9种方言。

### 图像类

- **快手可图**：[https://kolors.kuaishou.com/](https://link.zhihu.com/?target=https%3A//kolors.kuaishou.com/)

快手2025年5月发布的图像生成大模型，最新版为**v2.1**。

- **doubao-seedream：**[https://www.volcengine.com/docs/82379/1555133](https://link.zhihu.com/?target=https%3A//www.volcengine.com/docs/82379/1555133)

字节豆包的图像生成模型，最新版为v3.0。支持原生高分辨率的中英双语图像生成基础模型，响应速度更快，小字生成更准确，文本排版效果增强；指令遵循能力强，美感&结构提升，保真度和细节表现较好。

- **通义万相（生图）**：[https://tongyi.aliyun.com/wanxiang/creation](https://link.zhihu.com/?target=https%3A//tongyi.aliyun.com/wanxiang/creation)

阿里通义团队发布的图像生成模型产品，目前模型版本是2025年2月发布的v2.1。支持多种图像生成模板，即将支持图生图。

## 开源组

### 通用类

- **DeepSeek**

**V3.2-Exp**: [https://huggingface.co/deepseek-ai/DeepSeek-V3.2-Exp](https://link.zhihu.com/?target=https%3A//huggingface.co/deepseek-ai/DeepSeek-V3.2-Exp)

DeepSeek团队2025年9月发布的混合推理模型，引入**DeepSeek Sparse Attention（DSA）**，大幅降低训练和推理算力成本的同时，性能和V3.1-Terminus基本保持一致，详见《[DeepSeek-V3.2-Exp：利用DeepSeek稀疏注意力提升长上下文效率](https://zhuanlan.zhihu.com/p/1957048527470458326)》。

**V3.1-Terminus：** [https://huggingface.co/deepseek-ai/DeepSeek-V3.1-Terminus](https://link.zhihu.com/?target=https%3A//huggingface.co/deepseek-ai/DeepSeek-V3.1-Terminus)

DeepSeek团队2025年9月发布的混合推理模型，修复了V3.1的BUG并优化了Agent维度的性能。

**V3：**[https://github.com/deepseek-ai/DeepSeek-V3](https://link.zhihu.com/?target=https%3A//github.com/deepseek-ai/DeepSeek-V3)

2024年12月发布了通用模型**V3.0**并在3月份更新，参数量**671B**，详见[《DeepSeek-V3技术报告（全文）》](https://zhuanlan.zhihu.com/p/14890557782)。

- **Qwen**

**Qwen3：**[https://github.com/QwenLM/Qwen3](https://link.zhihu.com/?target=https%3A//github.com/QwenLM/Qwen3)

通义千问开源版本。2025年4月发布最新版本v3.0，包含**0.6B/1.7B/4B/8B/17B/32B** 六个dense model，以及**30B-A3B**和**235B-A22B**两个MoE模型，详见[《Qwen3技术报告》](https://zhuanlan.zhihu.com/p/1905945819108079268)。2025年9月发布

**Qwen3-VL：**[https://github.com/QwenLM/Qwen3-VL](https://link.zhihu.com/?target=https%3A//github.com/QwenLM/Qwen3-VL)

2025年9月发布多模态通用模型Qwen3-VL，参数量为**235B-A22B**，拥有**视觉智能体操作图形界面、视觉编程、精确空间理解、超长上下文，超长视频理解**等能力，详见《[千问家族最强视觉模型！Qwen3-VL来了](https://zhuanlan.zhihu.com/p/1954137743031502336)》

**Qwen3-Omni：**[https://github.com/QwenLM/Qwen3-Omni](https://link.zhihu.com/?target=https%3A//github.com/QwenLM/Qwen3-Omni)

2025年9月发布All in one模型**Qwen3-Omni**，参数量为**30B-A3B**，这是一个原生端到端全模态 AI，统一整合文本、图像、音频和视频于单一模型——无模态权衡。详见《[原生全模态！Qwen3-Omni视频通话来咯](https://zhuanlan.zhihu.com/p/1954212708586100134)》

**Qwen3-Next：**[Qwen3-Next](https://link.zhihu.com/?target=https%3A//modelscope.cn/collections/Qwen3-Next-c314f23bd0264a)

9月发布全新架构的**Qwen3-Next**，参数量为**80B-A3B**，核心改进包括**混合注意力机制**、**高稀疏度 MoE 结构**、一系列**训练稳定友好的优化**，以及提升推理效率的**MTP机制**。其它的训练成本仅为Qwen3-32B的**十分之一不到**，在32k以上的上下文下的推理吞吐则是Qwen3-32B的**十倍以上。**详见《[Qwen3-Next：迈向更极致的训练推理性价比](https://zhuanlan.zhihu.com/p/1949631642294522105)》

- **GLM**

**GLM-4.5V：** [https://github.com/zai-org/GLM-V](https://link.zhihu.com/?target=https%3A//github.com/zai-org/GLM-V)

智谱团队于2025年8月初发布**4.5V**版本多模态MoE混合推理模型，总参数为**106B（A12B）**，多模态能力涵盖图像、视频、文档理解和图形用户界面任务等常见应用。模型还引入了全新的“思维推理模式”开关功能，用户可以在快速响应和深度推理之间自由切换，根据具体任务需求灵活调节处理速度与输出质量的平衡。

**GLM-4.6：**[https://github.com/zai-org/GLM-4.5](https://link.zhihu.com/?target=https%3A//github.com/zai-org/GLM-4.5)

智谱团队2025年9月底发布**4.6**版本的MoE模型，总参数达**355B（A32B）**。上下文窗口由128K提升至**200K**，编程能力**、**推理能力、搜索能力、写作能力、多语言翻译能力较4.5版本均有明显提升**。**技术细节详见[《GLM-4.5：智能体、推理与编程（ARC）基础模型》——GLM-4.5技术报告](https://zhuanlan.zhihu.com/p/1938635944178721930)

- **Hunyuan**

**Hunyuan-A13B**：[https://github.com/Tencent-Hunyuan/Hunyuan-A13B](https://link.zhihu.com/?target=https%3A//github.com/Tencent-Hunyuan/Hunyuan-A13B)

腾讯混元团队2025年6月发布并开源MoE模型，总参数**80B（A13B）。**拥有**256K**上下文窗口，强大的Agent 能力，用户可以在回答效率与深度间自由切换。

- **Kimi**

**Kimi-K2**：[https://github.com/MoonshotAI/Kimi-K2](https://link.zhihu.com/?target=https%3A//github.com/MoonshotAI/Kimi-K2)

月之暗面团队2025年7月发布通用模型，拥有**32B**激活参数和**1T**总参数,是目前业界**总参数量最大的开源模型。**模型采用Muon优化器进行训练，在前沿知识、推理和编码任务方面表现卓越，并针对Agent能力进行了特别优化。详见[《KIMI K2: 开放智能体智能》——Kimi K2技术报告](https://zhuanlan.zhihu.com/p/1933619657589384402)

**Kimi-VL：**[https://github.com/MoonshotAI/Kimi-VL](https://link.zhihu.com/?target=https%3A//github.com/MoonshotAI/Kimi-VL)

月之暗面团队2025年4月发布开源多模态通用模型**。**MoE架构，参数量**16B**（激活**3B**），详见[【LLM技术报告】Kimi-VL技术报告（全文）](https://zhuanlan.zhihu.com/p/1894825825708273809)。

- **MiniMax**

**MiniMax-Text-01**和**MiniMax-VL-01：**[https://www.minimaxi.com/news/minimax-01](https://link.zhihu.com/?target=https%3A//www.minimaxi.com/news/minimax-01-%E7%B3%BB%E5%88%97) 去年专注出海业务的MiniMax在2025年1月发布的开源通用模型和多模态通用模型，采用MoE架构，总参数量**456B，**激活参数**45.9B，**专家数量**32个**。详见[【LLM技术报告】MiniMax-01技术报告（全文）](https://zhuanlan.zhihu.com/p/19366579496)

- **Enrie**

**Enrie 4.5：**[https://github.com/PaddlePaddle/ERNIE](https://link.zhihu.com/?target=https%3A//github.com/PaddlePaddle/ERNIE)

2025年7月，文心4.5系列开源模型共10款，涵盖了激活参数规模分别为**47B**和**3B**的MoE模型（最大的模型总参数量为**424B**），以及**0.3B**的稠密参数模型。

### 推理类

- **DeepSeek**

**DeepSeek-R1：**[https://github.com/deepseek-ai/DeepSeek-R1](https://link.zhihu.com/?target=https%3A//github.com/deepseek-ai/DeepSeek-R1)

深度求索2025年1月发布了**R1**正式版，5月28日做了一次小更新，LMSYS总榜前10名的常客。详见[《DeepSeek-R1技术报告（全文）》](https://zhuanlan.zhihu.com/p/19744278380)。

**DeepSeek-V3.2-Exp-Thinking**: [https://huggingface.co/deepseek-ai/DeepSeek-V3.2-Exp](https://link.zhihu.com/?target=https%3A//huggingface.co/deepseek-ai/DeepSeek-V3.2-Exp)

**DeepSeek-V3.1-Terminus-Thinking：**[https://huggingface.co/deepseek-ai/DeepSeek-V3.1-Terminus](https://link.zhihu.com/?target=https%3A//huggingface.co/deepseek-ai/DeepSeek-V3.1-Terminus)

2025年9月发布混合推理模型**V3.2-Exp-Thinking**和**V3.1-Terminus-Thinking**。

- **Qwen**

**Qwen3-Max-Thinking-Preview：**[chat.qwen.ai](https://link.zhihu.com/?target=http%3A//chat.qwen.ai/)

通义千问团队2025年11月发布的推理模型，目前预览版的能力和口碑都一般，先等等正式版再来评价。

**Qwen3-235B-A22B-Thinking**：[https://github.com/QwenLM/Qwen3](https://link.zhihu.com/?target=https%3A//github.com/QwenLM/Qwen3)

通义千问团队2025年7月发布的推理模型，详见（[《Qwen3推理模型来咯！》](https://zhuanlan.zhihu.com/p/1932142506243491417)）。

**Qwen3-Next-80B-A3B-Thinking：**[Qwen3-Next](https://link.zhihu.com/?target=https%3A//modelscope.cn/collections/Qwen3-Next-c314f23bd0264a)

通义千问团队2025年9月发布的推理模型，详见（《[Qwen3-Next：迈向更极致的训练推理性价比](https://zhuanlan.zhihu.com/p/1949631642294522105)》）。

**Qwen3-VL-Thinking：**[https://github.com/QwenLM/Qwen3-VL](https://link.zhihu.com/?target=https%3A//github.com/QwenLM/Qwen3-VL)

通义千问团队2025年9月发布的多模态推理模型，详见（《[千问家族最强视觉模型！Qwen3-VL来了](https://zhuanlan.zhihu.com/p/1954137743031502336)》）。

- **GLM**

**GLM-4.5V（Thinking Mode）**

智谱AI 2025年8月初发布并开源的多模态混合推理模型**，**参数**106B（A12B）**；

**GLM-4.1V-Thinking**

智谱AI 2025年8月初发布并开源的多模态混合推理模型**，**参数**9B**，详见[《GLM-4.1V-Thinking：通过可扩展强化学习实现通用多模态推理》](https://zhuanlan.zhihu.com/p/1924133956292420224)。

**GLM-4.5-X**

智谱AI 2025年7月底发布并开源推理模型。

- **Seed**

**Seed-OSS**：[https://github.com/ByteDance-Seed/seed-oss](https://link.zhihu.com/?target=https%3A//github.com/ByteDance-Seed/seed-oss)

字节Seed 2025年8月发布并开源的推理模型，参数量**36B**，长达**512K**的上下文窗口。针对推理任务进行优化的同时保持均衡且优秀的通用能力，允许用户根据需要灵活调整推理长度，并且在智能体任务（如工具使用和问题解决）方面表现卓越。

- **Hunyuan**

**Hunyuan-A13B-Thinking：**[https://github.com/Tencent-Hunyuan/Hunyuan-A13B](https://link.zhihu.com/?target=https%3A//github.com/Tencent-Hunyuan/Hunyuan-A13B)

腾讯混元团队2025年6月推出的混合推理模型，总参数量**80B**，激活数量**13B**，拥有**快/慢思考**模式，集成了**深度研究**智能体。

- **Kimi**

**Kimi-K2-Thinking：**[https://huggingface.co/moonshotai/Kimi-K2-Thinking](https://link.zhihu.com/?target=https%3A//huggingface.co/moonshotai/Kimi-K2-Thinking)

月之暗面团队2025年11月推出的推理模型，拥有**32B**激活参数和**1T**总参数。显示提升**推理**、**Agentic编程**、**自主搜索和浏览**以及其他**通用能力**，可无人工干预下自主实现高达 **300轮** 的工具调用和持续稳定的多轮思考能力。详见《[Kimi K2 Thinking 模型发布并开源，全面提升 Agent 和推理能力](https://zhuanlan.zhihu.com/p/1969908447005873171)》

**Kimi-VL-Thinking：**[https://github.com/MoonshotAI/Kimi-VL](https://link.zhihu.com/?target=https%3A//github.com/MoonshotAI/Kimi-VL)

月之暗面团队2025年3月推出多模态推理模型，MoE架构，参数量**16B**（激活**3B**），详见[《Kimi-VL技术报告（全文）》](https://zhuanlan.zhihu.com/p/1894825825708273809)。

- **Step**

**Step 3**：[https://huggingface.co/stepfun-ai/step3](https://link.zhihu.com/?target=https%3A//huggingface.co/stepfun-ai/step3)

阶跃AI2025年7月发布多模态推理模型，MoE架构，参数量 **321B（A38B）**。拥有强大的视觉感知和复杂推理能力，可准确完成跨领域的复杂知识理解、数学与视觉信息的交叉分析，以及日常生活中的各类视觉分析问题。

- **MiniMax**

**MiniMax-M2：**[https://github.com/MiniMax-AI/MiniMax-M2](https://link.zhihu.com/?target=https%3A//github.com/MiniMax-AI/MiniMax-M2)

MiniMax团队在2025年10月推理模型，参数量为**230B（A10B），**和参数量为**456B（A45.9B）**的M1相比，M2在技术架构和设计理念上均有大幅“创新”。架构上从M1（详见[《MiniMax-M1：通过闪电注意力高效扩展测试时计算》](https://zhuanlan.zhihu.com/p/1918225390457054514)）的**稠密混合注意力（Dense Hybrid-Attention）**改变为M2的**稀疏混合专家（Sparse MoE）**，缩小的不仅只有总参数量和激活参数量，还包括将上下文窗口从**1M**调整为**400K**。设计理念从通用能力转向**特定场景应用**，从追求极限上下文长度转向**满足主流应用需求的窗口大小**，从追求模型能力转向追求**推理速度**和**成本**。

### 视频类

**Hunyuan Video**：[https://github.com/Tencent-Hunyuan/HunyuanVideo-1.5](https://link.zhihu.com/?target=https%3A//github.com/Tencent-Hunyuan/HunyuanVideo-1.5)

腾讯混元团队2025年11月发布的开源视频生成模型，参数量 **8.3B**，小于1.0版本时的 **13B**。采用的是 **DiT** 与 **3D 因果 VAE** 相结合的先进架构和**多阶段**、**渐进式**的训练策略，从整体上优化了**运动连贯性**、**美学质量**和**对人类偏好的对齐**，实现了专业级的内容生成。详见《[Hunyuan Video 1.5 技术报告](https://zhuanlan.zhihu.com/p/1975510501715878703)》。

**Wan**: [https://github.com/Wan-Video/Wan2.2](https://link.zhihu.com/?target=https%3A//github.com/Wan-Video/Wan2.2)

阿里通义团队发布的开源视频生成模型，最新版是2025年7月发布的**v2.2**，这是一个基于先进**Wan2.2-VAE**构建的**5B**和**14B**参数模型。该模型支持720P分辨率、24fps的文本到视频和图像到视频生成，同时可在4090等消费级显卡上运行。这是目前可用的最快**720P@24fps**模型之一，能够同时满足工业界和学术界的需求。

### 图像类

- **Qwen-Image**：[https://github.com/QwenLM/Qwen-Image](https://link.zhihu.com/?target=https%3A//github.com/QwenLM/Qwen-Image)

阿里通义团队2025年8月发布并开源的MMDiT图像基础模型，**20B**参数，在**复杂文本渲染**和**精确图像编辑**领域实现了重大突破，对中文文本的处理尤为出色。9月升级了多图编辑功能。

- **Hunyuan Image**：[https://github.com/Tencent-Hunyuan/HunyuanImage-3.0](https://link.zhihu.com/?target=https%3A//github.com/Tencent-Hunyuan/HunyuanImage-3.0)

腾讯混元团队2025年9月发布的文本到图像生成模型 **3.0** 版本。这是开源界规模最大的生图MoE模型，包含 **64** 个专家，总参数量高达 **80B**，每 token 激活参数量为 **13B**。它突破了目前主流的基于DiT 的架构限制，采用了一种**统一的自回归框架**，这一设计实现了对文本和图像模态更直接、更一体化的建模；它还利用混元团队世界模型里丰富的**世界知识**，智能解读用户意图，能够自动为简短稀疏的提示词补充语境合理的细节。

- **CogView**：[https://github.com/zai-org/CogView4/](https://link.zhihu.com/?target=https%3A//github.com/zai-org/CogView4/)

智谱AI团队发布并开源的DiT生图模型，2025年3月发布**v4，**参数量**6B**。模型具有较强的复杂语义对齐和指令跟随能力，支持任意长度的中英双语输入，能够生成在给定范围内的任意分辨率图像，同时具备较强的文字生成能力。

### 音频类

- **HunyuanVideo-Foley**：[https://github.com/Tencent-Hunyuan/HunyuanVideo-Foley](https://link.zhihu.com/?target=https%3A//github.com/Tencent-Hunyuan/HunyuanVideo-Foley)

腾讯混元团队2025年8月发布并开源的音频生成模型，参数 **3B** ，是开源模型中参数最多、性能最强的视频音效生成模型。Foley采用包含**双流MMDiT与单流音频DiT**的多模态音频生成架构，在DAC的基础上设计了**改进的DAC-VAE**，在**10万小时高质量多模态数据集**上完成了训练，能理解视频画面并结合文字描述，自动平衡不同信息源生成层次丰富的复合音效。

### 音乐类

- **ACE-Step（音跃）：**[https://github.com/ace-step/ACE-Step](https://link.zhihu.com/?target=https%3A//github.com/ace-step/ACE-Step)

阶跃星辰与数字音乐平台 ACE Studio ，2025年5月联合发布的开源音乐大模型，参数量为**3.5B**，详见《[开源音乐大模型 ACE-Step 上线](https://zhuanlan.zhihu.com/p/1903839688155960414)》

------

## 更新日志

### 10月更新

- **MiniMax：**国内开源组更新推理模型 **MiniMax-M2**；国内闭源组更新生视频模型 **Hailuo 2.3**，音乐模型 **Music 2**，语音模型 **Speech 2.6**。
- **Google Deepmind：**国外闭源组更新视频类模型**Veo 3.1**；
- **Anthropic：**国外闭源组更新通用类模型**Claude Haiku 4.5。**

### 9月更新

- **GLM：**国内开源组更新通用模型**GLM-4.6**；
- **DeepSeek：**国内开源组更新通用模型**DeepSeek-V3.2-Exp**，推理模型**DeepSeek-V3.2-Exp-Thinking**；
- **Claude**：国外闭源组更新通用模型**Claude Sonnet 4.5**；推理模型**Claude Sonnet 4.5 Extended Thinking**；
- **OpenAI**：国外闭源组更新视频类模型**Sora 2**；
- **Suno**：国内闭源组更新音乐类模型**Suno v5**；**可灵AI：**国内闭源组视频类更新**可灵2.5 Turbo**；
- **Qwen：**国内闭源组通用类填坑**Qwen3-Max**，推理类新增**Qwen3-Max-Thinking**，音频类新增**Qwen3-TTS；**国内开源组通用类新增**Qwen3-Omni**、**Qwen3-VL**、**Qwen3-Next**，推理类新增**Qwen3-VL-Thinking**、**Qwen3-Next-Thinking**；
- **DeepSeek：**国内开源组通用类更新**DeepSeek-V3.1-Terminus**；推理类更新**DeepSeek-V3.1-Terminus-Thinking**；
- **Luma AI**：国外闭源组视频类更新**Ray 3**；
- **Mistral：**国外闭源组推理类更新**Magistral Small 1.2**，国外闭源组推理类更新**Magistral Medium 1.2。**
- **MiniMax：**国内闭源组音乐类更新**Music-1.5**；
- **文心一言**：国内闭源组推理类更新**X1.1**；
- **Hunyuan Image**：国内开源组图片类新增**v2.1**；

### **8月更新**

- **Gemini：**国外闭源组新增生图模型**Gemini 2.5 Flash Image**；
- **字节Seed：**国内开源组更新推理模型**Seed-OSS；**
- **DeepSeek**：国内开源组更新混合推理模型**DeepSeek-V3.1**；
- **GLM**：国内开源组更新多模态混合推理模型**GLM-4.5V**；
- **OpenAI**：国内闭源组更新通用模型**GPT-5**，推理模型**GPT-5 Thinking**；国外开源组更新推理模型**gpt-oss**；
- **Claude**：国外闭源组更新通用模型**Opus 4.1**；
- **Qwen**：国内开源组新增生图模型**Qwen-Image；**
- **MiniMax**：国内闭源组更新音频模型**Speech 2.5**。

### **7月更新**

- **Mureka：**国内闭源组新增音乐模型**Mureka V7；**
- **Step：**国内开源组新增推理模型**Step 3；**
- **Wan：**国内开源组更新视频生成模型**Wan2.2**；
- **Kimi：**新增**K2**[技术报告](https://zhuanlan.zhihu.com/p/1933619657589384402)；
- **GLM：**国内开源组更新通用模型**GLM-4.5**，更新推理模型**GLM-4.5-X**；
- **Qwen：**国内开源组新增推理模型**Qwen3-235B-A22B-Thinking。**
- **Kimi：**国内开源组通用模型更新**K2。**
- **Grok：**推理模型更新**Grok 4；**
- **GLM：**国内开源组推模模型新增**GLM-4.1V-Thinking；**
- **Black Forest Labs：**更新开源生图模型**Flux.1 Kontext**；
- **百度文心：**国内开源组新增**Enrie 4.5**系列。

### **6月更新**

- **MidJourney：**新增生视频模型**V1**；
- **Hunyuan**：国内开源组新增混合推理模型**Hunyuan-A13B**。
- **MiniMax：**国内开源组新增推理模型**MiniMax-M1，**闭源组更新生视频模型**Hailuo-02。**
- **Google Gemini：**新增[Gemini2.5技术报告](https://zhuanlan.zhihu.com/p/1918678603194938170)链接
- **Mistral：**新增推理模型**Magistral Small**(开源组)，**Medium**(闭源组)；
- **字节豆包：**更新通用模型**Doubao-Seed-1.6，**推理模型**Doubao-Seed-1.6-Thinking，**生视频模型**doubao-seedance 1.0**。生图模型**doubao-seedream 3.0**。
- **OpenAI：**更新推理模型**o3 pro。**

### **5月更新**

- **可灵：**更新至2.1版本；
- **可图：**更新至2.1版本；
- **Google Imagen**：更新至**v4.0；**
- **Google Veo**：更新至**v3.0；**
- **Google Gemini**：新增**Gemini Diffusion**，**Gemini 2.5 Pro Deep Think；**
- **Claude**：更新**Claude Opus 4(Extend Thinking)**，**Claude Sonnet 4(Extend Thinking)；**
- **Minimax**：升级语音模型**Speech-02**；
- **Phi**：新增推理模型**Phi-4-Reasoning**系列；
- **阶跃AI**：新增推理模型**step-r1-v-mini**；
- **字节豆包：**新增多模态推理模型**Seed1.5-VL**；
- **Mistral：**新增**Mistral Medium 3**；
- **ACE-Step：**新增音乐模型。

### **4月更新**

- **通义千问**：新增3.0版相关模型
- **Qwen：**新增Qwen3相关模型
- **文心一言**：新增**4.5 Turbo**和**X1 Turbo**；
- **ChatGPT**: 新增**GPT-4.1，o3，o4-mini**；
- **智谱清言：**新增海外版应用 **[z.ai](https://link.zhihu.com/?target=http%3A//z.ai/)；**
- **GLM：**新增**GLM-4-0414**、**GLM-Z1**、**GLM-Z1-Rumination；**
- **可灵：**新增2.0版本；
- **可图**：新增2.0版本。



