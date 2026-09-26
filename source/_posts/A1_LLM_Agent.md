---
title: Agent
date: 2003-01-01 06:33:16
categories:
- A1_LLM
toc: true # 是否启用内容索引
---

# 初级

## Agent厂商

**一、选型建议**

> - **零成本个人/小团队入门**：国内选 Dify 或 FastGPT 自部署 + 硅基流动 2000 万免费 Token；国外选 LangChain + AutoGPT + Gemini API 免费层
> - **业务人员快速做 Bot**：国内扣子 SaaS 免费版够用，国外 ChatGPT GPTs 最简单，但需订阅 Plusc
> - **企业私有化部署**：国内 Dify/毕昇/MaxKB 开源自部署；国外 AutoGen/LangGraph 开源 + 云服务
> - **大型企业开箱即用**：国内阿里百炼/百度千帆；国外 Salesforce Agentforce、ServiceNow Now Assist、Microsoft Copilot Studio



**二、国内/国外**

> - 完全免费/开源
> - 提供免费额度
> - 完全商业收费

### AI编程助手

> CLI工具推荐
>
> - Gemini CLI（1000 次/天免费）> Qoder CLI 社区版 > Qwen Code + DeepSeek API
> - Claude Code

| 产品/项目                | 范围 | 形态                                                         | 使用门槛与获取方式                                           | 链接                                                    |
| ------------------------ | ---- | ------------------------------------------------------------ | ------------------------------------------------------------ | ------------------------------------------------------- |
| **Trae（字节跳动）**     | 国内 | IDE（国内版 + 海外版 trae.ai）                               | 国内版完全免费、无需科学上网，官网下载安装包（Win/macOS），手机号/微信登录即可；海外版 Pro 按订阅付费 | [https://www.trae.com.cn](https://www.trae.com.cn/)     |
| **通义灵码（Qoder CN）** | 国内 | IDE + 插件（VS Code、JetBrains 全家桶、Visual Studio）       | 零门槛：官网下载 IDE，或在插件市场搜"TONGYI Lingma"一键安装，登录阿里云账号即可；个人版免费，企业版按席位付费；国内网络直连 | https://lingma.aliyun.com/download                      |
| **CodeGeeX（智谱 AI）**  | 国内 | 插件（VS Code、JetBrains 全家桶、Vim、HBuilderX 等）         | 零门槛且个人永久免费：官网或 IDE 插件市场安装插件，注册账号即可；企业支持私有化部署；模型已开源 | https://codegeex.cn/downloadGuide                       |
| **CodeBuddy（腾讯云）**  | 国内 | IDE + 插件（VS Code、JetBrains）+ CLI（CodeBuddy Code）      | 低门槛：官网下载 IDE，或插件市场安装；个人版支持微信/手机号登录，含免费额度；CLI 通过 `npm install -g @tencent-ai/codebuddy-code` 安装 | https://www.codebuddy.cn/ide                            |
| **Cursor**               | 国外 | IDE（基于 VS Code）                                          | 门槛低：官网下载安装包（Win/macOS/Linux），注册账号即可；免费档可用，Pro $20/月解锁高级模型与高配额；国内访问需代理 | https://www.cursor.com/download                         |
| **Claude Code**          | 国外 | 终端 CLI Agent（亦提供 VS Code/JetBrains 插件）              | 需命令行：`npm install -g @anthropic-ai/claude-code` 或 `brew install --cask claude-code`；需登录 Claude Pro（$20/月）或绑定 Anthropic API Key；国内网络需代理 | https://code.claude.com/docs/en/setup                   |
| **GitHub Copilot**       | 国外 | 插件（VS Code、JetBrains 全家桶、Neovim、Xcode、Visual Studio 等） | 门槛最低：在 IDE 插件市场搜索安装，用 GitHub 账号登录即可；Free 档每月 2000 次补全，Pro $10/月；学生/教师/开源维护者免费 | https://github.com/features/copilot                     |
| **Windsurf**             | 国外 | IDE（VS Code 分叉）+ JetBrains 插件                          | 官网下载安装包，邮箱或 GitHub 注册；Free 档每月 25 credits + 无限补全，Pro $20/月；国内使用需代理 | https://windsurf.com/download                           |
| **Gemini Code Assist**   | 国外 | 插件（VS Code、JetBrains、Android Studio）+ Gemini CLI       | 免费：用个人 Google 账号登录，插件市场安装即可；个人版每天 6000 次补全 + 240 次对话，额度慷慨；国内访问需代理 | [https://codeassist.google](https://codeassist.google/) |
| **Amazon Q Developer**   | 国外 | 插件（VS Code、JetBrains、AWS Toolkit、CLI）                 | AWS Builder ID 免费注册即可用基础版，Pro $19/月；深度绑定 AWS 生态，非 AWS 用户价值有限；国内访问需代理 | https://aws.amazon.com/q/developer/                     |

### 国内-完全免费/开源

| 产品/项目                    | 使用场景                                      | 形态                                               | 使用门槛与获取方式                                           | 链接                                                         |
| ---------------------------- | --------------------------------------------- | -------------------------------------------------- | ------------------------------------------------------------ | ------------------------------------------------------------ |
| **Dify 社区版**              | 企业知识库问答、RAG 应用、复杂工作流编排      | Web 平台（可视化编排）+ API                        | 开源免费，Docker 一键部署，需自备大模型 API；中文文档完善    | [github.com/langgenius/dify](https://github.com/langgenius/dify) |
| **FastGPT**                  | 知识库问答、自动化数据预处理、Flow 可视化编排 | Web 平台（可视化编排）+ API                        | 开源免费（GitHub 20k+ Star），Docker 自部署，OpenAI 兼容 API | [github.com/labring/FastGPT](https://github.com/labring/FastGPT) |
| **MetaGPT**                  | 多角色协作模拟软件开发全流程、报告撰写        | Python 框架 + CLI                                  | 开源免费，pip 安装即可，需自行接入 LLM API                   | [github.com/geekan/MetaGPT](https://github.com/geekan/MetaGPT) |
| **AgentScope**（阿里）       | 多智能体对话/协作应用研发                     | Python 框架 + Studio 可视化面板                    | 开源，Python 框架，面向开发者                                | [github.com/modelscope/agentscope](https://github.com/modelscope/agentscope) |
| **毕昇 BISHENG**             | 文档审核、报告生成、企业级多 Agent 协作       | Web 平台（私有化部署）                             | 开源免费，支持私有化部署与 RBAC 权限                         | [github.com/dataelement/bisheng](https://github.com/dataelement/bisheng) |
| **JoyAgent-JDGenie**（京东） | 零售场景智能客服、自动生成 PPT/报表           | Web 平台（端到端产品级开源，前后端+引擎全开源）    | 开源，`pip install joyagent-jdgenie` 即用，内置零售模板      | [github.com/jd-opensource/joyagent-jdgenie](https://github.com/jd-opensource/joyagent-jdgenie) |
| **MaxKB**                    | 企业级知识库智能问答                          | Web 平台（Docker 部署），支持零代码嵌入            | 开源免费，5 分钟 Docker 部署，零代码嵌入                     | [github.com/1Panel-dev/MaxKB](https://github.com/1Panel-dev/MaxKB) |
| **扣子 Coze Studio 开源版**  | 低代码 Bot 搭建、插件编排                     | Web 平台（可视化低代码，自部署）+ OpenAPI/Chat SDK | 核心引擎已开源，可自部署；SaaS 版另算                        | [github.com/coze-dev/coze-studio](https://github.com/coze-dev/coze-studio) |

### 国内-提供免费额度(推荐)

| 产品/项目                    | 适用人群 | 使用场景                                                     | 形态                                          | 使用门槛与获取方式                                           | 链接                                                         |
| ---------------------------- | -------- | ------------------------------------------------------------ | --------------------------------------------- | ------------------------------------------------------------ | ------------------------------------------------------------ |
| **Trae**（字节跳动）         | 编程     | AI 原生 IDE，Chat/Builder 双模式，一句话生成完整项目，多模型（Claude、GPT-4o、DeepSeek、豆包） | IDE（兼容 VS Code 插件迁移）                  | 注册登录即可免费使用，支持 macOS/Windows                     | [https://www.trae.cn](https://www.trae.cn/)                  |
| **通义灵码**（阿里云）       | 编程     | 代码补全、智能注释、单测生成、自然语言生成代码，支持 Java/Python/Go/TS 等 | IDE 插件（VS Code / JetBrains）+ IDE          | 个人版免费不限量，IDE 插件市场搜索安装，或下载IDE。IDE没有内置模型可用 | https://tongyi.aliyun.com/lingma                             |
| **CodeGeeX**（智谱，不推荐） | 编程     | 代码补全、跨语言翻译、错误检测，支持 100+ 语言，可本地部署   | IDE 插件（VS Code / JetBrains），支持本地部署 | 完全免费且开源，VS Code/JetBrains 插件市场直接安装。vscode 提示报错 `<>frontend_server.view_file</>` | [https://codegeex.cn](https://codegeex.cn/)                  |
| **腾讯云 CodeBuddy**（腾讯） | 编程     | Craft 智能体一键全栈项目生成，深度集成微信/腾讯云生态，等保三级合规 | IDE 插件（VS Code / JetBrains）+ IDE          | 个人版永久免费（约 2000 次/月额度），VS Code 插件或IDE       | [https://copilot.tencent.com](https://copilot.tencent.com/)  |
| **DeepSeek**（深度求索）     | 编程     | 代码生成、逻辑推理、技术问答；日常问答写作亦可用             | Web / App / API                               | 网页/App 完全免费；API 注册即送额度，定价极低                | [https://www.deepseek.com](https://www.deepseek.com/)        |
| **快手 CodeFlicker**（快手） | 编程     | 独立 AI IDE，免费使用 Kimi-K2、DeepSeek、GLM 等多款模型      | IDE                                           | 下载IDE 注册即用，当前免费                                   | [https://codeflicker.kuaishou.com](https://codeflicker.kuaishou.com/) |
| **iFlow CLI**（心流）        | 编程     | 终端 AI 编程助手，支持项目分析、文件管理、工作流自动化       | CLI（终端形态）                               | 完全免费，命令行安装，支持 Kimi K2、Qwen Coder 等模型        | [https://iflow.cn](https://iflow.cn/)                        |
| **扣子 Coze**（字节跳动）    | 非编程   | 零代码搭建智能体，100+ 插件，可发布到豆包/微信小程序         | Web SaaS（零代码低代码平台）                  | 免费，网页注册即用，适合无编程经验用户                       | [https://www.coze.cn](https://www.coze.cn/)                  |
| **豆包**（字节跳动）         | 非编程   | 日常问答、写作、PPT、图片生成、AI 智能体调用                 | App / Web / 浏览器插件                        | 免费，手机 App/网页/浏览器插件                               | [https://www.doubao.com](https://www.doubao.com/)            |
| **Kimi**（月之暗面）         | 非编程   | 长文档分析（200 万字）、深度思考、一键 PPT、智能体广场       | Web / App / 小程序                            | 免费，网页/App/小程序                                        | [https://kimi.moonshot.cn](https://kimi.moonshot.cn/)        |
| **智谱清言**（智谱 AI）      | 非编程   | 复杂问题推理、联网搜索、AutoGLM 沉思、Agent 广场             | Web / App（另提供 GLM API）                   | 免费，网页/App；开发者可申请 GLM API 免费额度                | [https://chatglm.cn](https://chatglm.cn/)                    |
| **腾讯元宝**（腾讯）         | 非编程   | 内容生成、知识检索、接入满血 DeepSeek R1，微信生态联动       | App / Web / 小程序 / 微信好友入口             | 免费，网页/App/小程序/微信好友                               | [https://yuanbao.tencent.com](https://yuanbao.tencent.com/)  |
| **文心智能体平台**（百度）   | 非编程   | 低代码搭建智能体，模板丰富，支持发布到百度系流量入口         | Web SaaS（零代码平台）                        | 免费，百度账号登录即用                                       | [https://agents.baidu.com](https://agents.baidu.com/)        |
| **腾讯元器**（腾讯）         | 非编程   | 智能体深度集成微信小程序/公众号，社交属性强                  | Web 平台（一键发布至微信生态）                | 免费，微信/QQ 账号登录                                       | [https://yuanqi.tencent.com](https://yuanqi.tencent.com/)    |
| **通义千问**（阿里）         | 非编程   | 日常办公、会议纪要、PPT 创作、文档分析、代码辅助             | Web / App                                     | 免费，网页/App                                               | [https://tongyi.aliyun.com](https://tongyi.aliyun.com/)      |
| **秘塔 AI 搜索**（秘塔）     | 非编程   | 无广告 AI 搜索、学术检索、复杂内容结构化讲解                 | Web / App / 小程序                            | 免费，网页/App/小程序                                        | [https://metaso.cn](https://metaso.cn/)                      |
| **夸克 AI**（阿里）          | 非编程   | AI 搜索、PPT 生成、搜题解题、网盘+浏览器整合                 | App / 桌面客户端 / 浏览器                     | 基础功能免费，App/客户端                                     | [https://www.quark.cn](https://www.quark.cn/)                |

### 国内-完全商业收费/企业定制

| 产品/项目                | 使用场景                                | 形态                                | 使用门槛与获取方式                         | 链接                                              |
| ------------------------ | --------------------------------------- | ----------------------------------- | ------------------------------------------ | ------------------------------------------------- |
| **阿里云百炼企业版**     | 大型企业 Agent 落地、私有化部署         | 云平台（企业版）+ API + 私有化部署  | 按调用 token 计费 + 企业套餐，需商务对接   | https://www.aliyun.com/product/bailian            |
| **百度千帆·文心企业版**  | 政务/国企 Agent、知识图谱问答、信创适配 | 云平台 + 私有化一体机               | 企业套餐付费，需企业资质，支持私有化一体机 | https://cloud.baidu.com/product/qianfan           |
| **腾讯云大模型知识引擎** | 企业微信生态 Agent、私域运营            | 云平台（企业版，深度打通微信/企微） | 企业版付费，深度打通微信/企微              | https://cloud.tencent.com/product/lke             |
| **智谱 AI 企业服务**     | 金融/政务行业 Agent 定制                | API + 行业定制服务                  | 按项目报价，提供 AutoGLM 商业授权          | [https://www.zhipuai.cn](https://www.zhipuai.cn/) |
| **火山方舟（字节）**     | 豆包系列 Agent 企业落地、多模态应用     | 云平台 + API（按量计费）            | 按量计费，企业客户商务对接                 | https://www.volcengine.com/product/ark            |
| **扣子企业版**           | 组织级 Agent 统一管理、权限与数据治理   | Web SaaS（企业旗舰版）              | 企业旗舰版 8980 元/月起，含积分池          | [https://www.coze.cn](https://www.coze.cn/)       |

### 国外-完全免费/开源

| 产品/项目                     | 使用场景                            | 形态                                                   | 使用门槛与获取方式                                         | 链接                                                         |
| ----------------------------- | ----------------------------------- | ------------------------------------------------------ | ---------------------------------------------------------- | ------------------------------------------------------------ |
| **AutoGPT**                   | 全自主任务执行、探索性自动化        | Python 框架 + CLI（可搭建 Web 前端）                   | 开源（GitHub 182k+ Star），需 Python 环境 + 自备 LLM API   | [github.com/Significant-Gravitas/AutoGPT](https://github.com/Significant-Gravitas/AutoGPT) |
| **LangChain / LangGraph**     | 复杂状态工作流、生产级 Agent 应用   | Python/JS SDK 框架（托管版 LangGraph Platform 另付费） | MIT 开源免费，Python SDK，托管版 LangGraph Platform 另付费 | [github.com/langchain-ai/langchain](https://github.com/langchain-ai/langchain) / [github.com/langchain-ai/langgraph](https://github.com/langchain-ai/langgraph) |
| **CrewAI**                    | 角色分工多 Agent 协作（调研、报告） | Python 框架 + CLI                                      | MIT 开源，pip 安装，企业托管版另付费                       | [github.com/crewAIInc/crewAI](https://github.com/crewAIInc/crewAI) |
| **AutoGen（微软）**           | 多 Agent 对话协作、企业工作流自动化 | Python 框架（另提供 AutoGen Studio Web 界面）          | MIT 开源，微软官方维护，需自备模型 API                     | [github.com/microsoft/autogen](https://github.com/microsoft/autogen) |
| **OpenHands（原 OpenDevin）** | 自主编程 Agent、代码任务自动化      | Web 平台（Docker 部署，内含代码编辑器/终端）           | 开源，GitHub 获取，Docker 部署                             | [github.com/All-Hands-AI/OpenHands](https://github.com/All-Hands-AI/OpenHands) |
| **AgentGPT**                  | 零代码自主智能体、原型验证          | Web 平台（浏览器内运行，Docker 一键启动）              | 开源，`docker run -p 3000:3000 reworkd/agentgpt` 一键启动  | [github.com/reworkd/AgentGPT](https://github.com/reworkd/AgentGPT) |
| **LlamaIndex Agent**          | 私有文档问答、RAG Agent             | Python/TS SDK 框架（另提供 LlamaCloud 托管服务）       | 开源免费，Python 包，需自备 LLM                            | [github.com/run-llama/llama_index](https://github.com/run-llama/llama_index) |

### 国外-提供免费额度

| 产品/项目                             | 使用场景                          | 形态                                           | 使用门槛与获取方式                                           | 链接                                                    |
| ------------------------------------- | --------------------------------- | ---------------------------------------------- | ------------------------------------------------------------ | ------------------------------------------------------- |
| **ChatGPT（GPTs + Tasks）**           | 个人定制助手、定时任务            | Web / App（另提供 API）                        | 网页免费层 GPT-4o Mini 无限用，GPT-4o 约 80 条/3 小时；Plus 20 美元/月解锁 GPTs 创建与 Tasks | [https://chatgpt.com](https://chatgpt.com/)             |
| **Claude（Projects + Computer Use）** | 长文档分析、编程 Agent、桌面操作  | Web / 桌面 App / CLI（Claude Code）/ API       | 网页有免费额度，Pro 20 美元/月解锁更多；Claude Code 需订阅   | [https://claude.ai](https://claude.ai/)                 |
| **Gemini（Google）**                  | 长上下文问答、轻量 Agent          | Web / App / API                                | 网页免费层 Flash 模型可用，API 免费层 Gemini 2.5 Flash 每日 250 次请求 | [https://gemini.google.com](https://gemini.google.com/) |
| **Manus**                             | 全自主任务交付（报告、网站、PPT） | Web 云端 Agent（云端虚拟机执行，异步交付）     | 免费层每日 300 积分；Pro 20 美元/月起（4000 积分/月），复杂任务可能烧 500-900 积分 | [https://manus.im](https://manus.im/)                   |
| **Grok（xAI）**                       | X 平台内 AI 对话、轻 Agent        | Web / App（深度集成 X 平台）                   | X 免费用户每日有消息上限                                     | [https://grok.com](https://grok.com/)                   |
| **Zapier Agents**                     | SaaS 串联 + AI 自动化             | Web SaaS（8k+ 应用串联的自动化平台内嵌 Agent） | 有免费额度起步，Pro 79 美元/月（1000 次 AI run）             | https://zapier.com/agents                               |
| **Lindy**                             | 团队 AI 同事、跨工具自动化        | Web SaaS（可视化工作流 + AI 员工模板）         | 7 天免费试用，之后 Plus/Pro/Max 按席位订阅                   | [https://www.lindy.ai](https://www.lindy.ai/)           |

### 国外-完全商业收费/企业定制

| 产品/项目                             | 使用场景                                       | 形态                                                         | 使用门槛与获取方式                                           | 链接                                                         |
| ------------------------------------- | ---------------------------------------------- | ------------------------------------------------------------ | ------------------------------------------------------------ | ------------------------------------------------------------ |
| **Salesforce Agentforce**             | 销售/客服/营销 Agentic CRM                     | SaaS（CRM 平台内嵌 Agent）                                   | 约 0.1 美元/动作 或 2 美元/次会话，按用户许可约 125 美元/月起；中型团队落地成本 1.5 万-10 万+ 美元/年 | https://www.salesforce.com/agentforce/                       |
| **ServiceNow Now Assist / AI Agents** | ITSM/CSM/HRSD 内部服务自动化                   | SaaS（ServiceNow 平台内嵌，模块化按需启用）                  | 未公开定价，第三方估算 70-200 美元/用户/月 + AI 消耗计费，需已有 ServiceNow 平台 | https://www.servicenow.com/products/ai-agents.html           |
| **Microsoft Copilot Studio**          | M365 生态 Agent 搭建（Teams/Excel/SharePoint） | Web SaaS（低代码 Agent 构建器，深度集成 M365）               | 按 Microsoft 365 许可订阅，无独立免费层，少量试用            | https://www.microsoft.com/microsoft-copilot/microsoft-copilot-studio |
| **OpenAI Agents Platform**            | 生产级 Agent SDK、代码开发                     | Python SDK 框架（开源）+ Responses API（按量计费）+ 可视化 Traces | 框架开源，但按 GPT-4o/5 调用量计费（约 12 美元/千次查询），企业套餐另议 | [github.com/openai/openai-agents-python](https://github.com/openai/openai-agents-python) |
| **Intercom Fin**                      | 客服 Agent、按结果计费                         | SaaS（客服平台内嵌 AI Agent）                                | 约 0.99 美元/次成功解决，叠加席位订阅费                      | https://www.intercom.com/fin                                 |
| **CrewAI 企业托管版**                 | 企业级多 Agent 平台服务                        | 云托管平台（基于开源框架，企业版控制台）                     | 开源框架免费，企业托管/定制服务付费                          | [https://www.crewai.com](https://www.crewai.com/)            |
| **Google ADK + Vertex AI**            | 多模态 Agent、GCP 企业级部署                   | Python/Java SDK 框架（开源）+ GCP 云平台（另提供 Agent Builder） | 云服务按使用量计费，需 GCP 账户                              | [google.github.io/adk-docs](https://google.github.io/adk-docs/) / https://cloud.google.com/products/agent-builder |

## Agent的CLI/TUI/GUI

| 交互形态         | 核心特征                                                     | 典型代表                                                     | 痛点                                                         |
| ---------------- | ------------------------------------------------------------ | ------------------------------------------------------------ | ------------------------------------------------------------ |
| CLI 命令行界面   | **全文本、纯流水式**。输入一行命令，输出一堆文本，通过滚动查看，没有固定布局。 | [Claude Code](https://zhuanlan.zhihu.com/p/2029164197653541886)、[Aider](https://post.m.smzdm.com/p/al329kre/)、`codex-cli` | 信息一滚而过，很难一眼看出 Agent 到底修改了当前文件的哪一行，无法进行直观的视察。 |
| TUI 文本用户界面 | **运行在终端里的“伪图形界面”**。利用字符画出面板、菜单、进度条，支持键盘方向键快捷操作。 | [Claude Code](https://www.zhihu.com/question/2026125412049101416) 的交互面板、高级终端 Agent 工具 | 目前 **AI 编程 Agent 的绝对主流**。因为它既保留了命令行直接亲近代码库、运行快的优势，又提供了如同现代编辑器一般的“实时区域刷新”和“语法高亮”。 |
| GUI 图形用户界面 | **原生窗口、纯图形化**。包含传统的网页（Web）或桌面软件，拥有复杂的按钮、图表和弹窗。 | Cursor、[Artifacts](https://juejin.cn/post/7604697194795040778)、Bolt.new、v0 | 渲染重、启动慢，且难以脱离特定软件生态实现纯键盘的极客流操作。 |

# 中级

# 高级

# Agent

## 定义

**Agent（智能体，AI Agent）** 是一种能够自主感知环境、做出决策并执行动作以实现特定目标的人工智能系统。它超越了传统AI“被动回答”的局限，能够像人类一样主动规划、行动、协作，在数字或物理世界完成复杂任务。

> 简单比喻：如果说大语言模型（LLM）是“超级大脑”，那么 Agent 就是给大脑装上了“手脚”和“工具”，让AI能主动行动、完成实际任务。

## 工作原理

### ReAct模式

Reasoning and Acting即推理和行动。是目前比较主流的模式。

1. 思考（Thought）
   - 分析当前状态和任务目标，规划下一步行动。
2. 行动（Action）
   - 调用外部工具、API、数据库等，执行实际操作。
3. 观察（Observation）
   - 收集行动结果，评估是否符合预期。
4. 循环（Loop）
   - 若未完成，返回思考阶段，根据结果调整策略；若达成目标，输出最终答案。
5. 最终答案(Final Answer)

> 示例：查询天气
>
> - Thought：用户问今天某城市天气，需实时数据。
> - Action：调用天气API。
> - Observation：返回晴天，25°C。
> - Thought：结果准确，可输出答案。
> - Final Answer：今天某城市晴天，温度25°C，适合外出。

Agent内部工作流程如下图：

<img src="/img/2025-12-20_12-36-56.png" style="zoom:50%;" />

完整的Agent的问答流程如下图：

<img src="/img/2025-12-20_12-45-16.png" style="zoom:50%;" />

### 其他模式

如先规划-再执行，比如Manus。其中最著名的又langchain提出的plan-and-execute模式，只是其中引入了动态规划，动态修改规划。

**Plan-and-Execute模式**（先规划后执行模式）是一种用于AI智能体（Agent）的架构范式，其核心思想是：先对复杂任务进行全局分解，制定多步骤计划，然后逐一执行这些子任务，并在执行过程中根据实际情况动态调整计划。

1. 规划阶段（Planning）

- **任务分析**：理解用户目标、上下文、约束条件。
- **任务分解**：将复杂任务拆解为有序的、原子性的子任务（Subtasks）。
- **生成计划**：输出一个可执行的计划清单（如JSON或自然语言列表）。

2. 执行阶段（Execution）

- **逐项执行**：按顺序调用Agent或工具，完成每个子任务。
- **动态调整**：根据执行结果或环境变化，可触发“重新规划（Replan）”机制，更新后续计划。
- **汇总结果**：所有子任务完成后，整合输出最终结果。

> 示例：视频转音频任务
>
> 1. 规划：分解为“读取视频→提取音频→保存文件”。
> 2. 执行：按顺序调用相关工具，若某步失败则重新规划后续步骤。

<img src="/img/2025-12-20_12-54-48.png" style="zoom:50%;" />

# A2A协议

## **定义**

是由Google于2025年4月开源发布的首个标准化智能体交互协议，旨在让不同框架和供应商构建的AI智能体（Agent）能够安全、高效地互相通信、协作与任务委派。A2A协议解决了AI智能体生态中的“巴别塔困境”——即不同智能体之间缺乏统一通信标准、难以互通协作的问题

## **与MCP等协议的对比**

A2A与MCP并非替代关系，而是互补：MCP解决智能体与工具的连接，A2A解决智能体与智能体的协作，两者共同构成AI智能体的完整技术栈。

| 对比维度       | A2A协议                          | MCP协议（Model Context Protocol）           |
| :------------- | :------------------------------- | :------------------------------------------ |
| **核心目标**   | 智能体之间的任务协作与通信       | 智能体与外部工具/数据源的连接（Model→Tool） |
| **交互模式**   | 多智能体间协作、任务委派         | 单智能体调用外部工具、获取数据              |
| **协议层次**   | 高层协作框架                     | 底层资源接口                                |
| **标准化程度** | 基于HTTP/JSON-RPC，开放标准      | 基于JSON-RPC 2.0，标准化                    |
| **安全机制**   | 内置企业级认证、加密、审计       | 依赖开发者实现                              |
| **适用场景**   | 跨系统、跨智能体协作             | 单智能体工具调用、数据获取                  |
| **生态支持**   | Google、Salesforce、SAP等50+企业 | Anthropic、OpenAI、微软等                   |

## **A2A的核心链路**

举例1个Agent,也支持多个Agent

- Agent注册阶段
- 用户问答阶段

<img src="/img/2025-12-20_11-56-31.png" style="zoom:50%;" />

<img src="/img/2025-12-20_11-57-47.png" style="zoom:50%;" />

## A2A的流式返回

<img src="/img/2025-12-20_12-09-58.png" style="zoom:50%;" />

## A2A的多Agent协作

# 手写-Agent

agent.py:核心流程

```python
import ast
import inspect
import os
import re
from string import Template
from typing import List, Callable, Tuple

import click
from dotenv import load_dotenv
from openai import OpenAI
import platform

from prompt_template import react_system_prompt_template


class ReActAgent:
    def __init__(self, tools: List[Callable], model: str, project_directory: str):
        self.tools = { func.__name__: func for func in tools }
        self.model = model
        self.project_directory = project_directory
        self.client = OpenAI(
            base_url="https://openrouter.ai/api/v1",
            api_key=ReActAgent.get_api_key(),
        )

    def run(self, user_input: str):
        messages = [
            {"role": "system", "content": self.render_system_prompt(react_system_prompt_template)},
            {"role": "user", "content": f"<question>{user_input}</question>"}
        ]

        while True:

            # 请求模型
            content = self.call_model(messages)

            # 检测 Thought
            thought_match = re.search(r"<thought>(.*?)</thought>", content, re.DOTALL)
            if thought_match:
                thought = thought_match.group(1)
                print(f"\n\n💭 Thought: {thought}")

            # 检测模型是否输出 Final Answer，如果是的话，直接返回
            if "<final_answer>" in content:
                final_answer = re.search(r"<final_answer>(.*?)</final_answer>", content, re.DOTALL)
                return final_answer.group(1)

            # 检测 Action
            action_match = re.search(r"<action>(.*?)</action>", content, re.DOTALL)
            if not action_match:
                raise RuntimeError("模型未输出 <action>")
            action = action_match.group(1)
            tool_name, args = self.parse_action(action)

            print(f"\n\n🔧 Action: {tool_name}({', '.join(args)})")
            # 只有终端命令才需要询问用户，其他的工具直接执行
            should_continue = input(f"\n\n是否继续？（Y/N）") if tool_name == "run_terminal_command" else "y"
            if should_continue.lower() != 'y':
                print("\n\n操作已取消。")
                return "操作被用户取消"

            try:
                observation = self.tools[tool_name](*args)
            except Exception as e:
                observation = f"工具执行错误：{str(e)}"
            print(f"\n\n🔍 Observation：{observation}")
            obs_msg = f"<observation>{observation}</observation>"
            messages.append({"role": "user", "content": obs_msg})


    def get_tool_list(self) -> str:
        """生成工具列表字符串，包含函数签名和简要说明"""
        tool_descriptions = []
        for func in self.tools.values():
            name = func.__name__
            signature = str(inspect.signature(func))
            doc = inspect.getdoc(func)
            tool_descriptions.append(f"- {name}{signature}: {doc}")
        return "\n".join(tool_descriptions)

    def render_system_prompt(self, system_prompt_template: str) -> str:
        """渲染系统提示模板，替换变量"""
        tool_list = self.get_tool_list()
        file_list = ", ".join(
            os.path.abspath(os.path.join(self.project_directory, f))
            for f in os.listdir(self.project_directory)
        )
        return Template(system_prompt_template).substitute(
            operating_system=self.get_operating_system_name(),
            tool_list=tool_list,
            file_list=file_list
        )

    @staticmethod
    def get_api_key() -> str:
        """Load the API key from an environment variable."""
        load_dotenv()
        api_key = os.getenv("OPENROUTER_API_KEY")
        if not api_key:
            raise ValueError("未找到 OPENROUTER_API_KEY 环境变量，请在 .env 文件中设置。")
        return api_key

    def call_model(self, messages):
        print("\n\n正在请求模型，请稍等...")
        response = self.client.chat.completions.create(
            model=self.model,
            messages=messages,
        )
        content = response.choices[0].message.content
        messages.append({"role": "assistant", "content": content})
        return content

    def parse_action(self, code_str: str) -> Tuple[str, List[str]]:
        match = re.match(r'(\w+)\((.*)\)', code_str, re.DOTALL)
        if not match:
            raise ValueError("Invalid function call syntax")

        func_name = match.group(1)
        args_str = match.group(2).strip()

        # 手动解析参数，特别处理包含多行内容的字符串
        args = []
        current_arg = ""
        in_string = False
        string_char = None
        i = 0
        paren_depth = 0
        
        while i < len(args_str):
            char = args_str[i]
            
            if not in_string:
                if char in ['"', "'"]:
                    in_string = True
                    string_char = char
                    current_arg += char
                elif char == '(':
                    paren_depth += 1
                    current_arg += char
                elif char == ')':
                    paren_depth -= 1
                    current_arg += char
                elif char == ',' and paren_depth == 0:
                    # 遇到顶层逗号，结束当前参数
                    args.append(self._parse_single_arg(current_arg.strip()))
                    current_arg = ""
                else:
                    current_arg += char
            else:
                current_arg += char
                if char == string_char and (i == 0 or args_str[i-1] != '\\'):
                    in_string = False
                    string_char = None
            
            i += 1
        
        # 添加最后一个参数
        if current_arg.strip():
            args.append(self._parse_single_arg(current_arg.strip()))
        
        return func_name, args
    
    def _parse_single_arg(self, arg_str: str):
        """解析单个参数"""
        arg_str = arg_str.strip()
        
        # 如果是字符串字面量
        if (arg_str.startswith('"') and arg_str.endswith('"')) or \
           (arg_str.startswith("'") and arg_str.endswith("'")):
            # 移除外层引号并处理转义字符
            inner_str = arg_str[1:-1]
            # 处理常见的转义字符
            inner_str = inner_str.replace('\\"', '"').replace("\\'", "'")
            inner_str = inner_str.replace('\\n', '\n').replace('\\t', '\t')
            inner_str = inner_str.replace('\\r', '\r').replace('\\\\', '\\')
            return inner_str
        
        # 尝试使用 ast.literal_eval 解析其他类型
        try:
            return ast.literal_eval(arg_str)
        except (SyntaxError, ValueError):
            # 如果解析失败，返回原始字符串
            return arg_str

    def get_operating_system_name(self):
        os_map = {
            "Darwin": "macOS",
            "Windows": "Windows",
            "Linux": "Linux"
        }

        return os_map.get(platform.system(), "Unknown")


def read_file(file_path):
    """用于读取文件内容"""
    with open(file_path, "r", encoding="utf-8") as f:
        return f.read()

def write_to_file(file_path, content):
    """将指定内容写入指定文件"""
    with open(file_path, "w", encoding="utf-8") as f:
        f.write(content.replace("\\n", "\n"))
    return "写入成功"

def run_terminal_command(command):
    """用于执行终端命令"""
    import subprocess
    run_result = subprocess.run(command, shell=True, capture_output=True, text=True)
    return "执行成功" if run_result.returncode == 0 else run_result.stderr

@click.command()
@click.argument('project_directory',
                type=click.Path(exists=True, file_okay=False, dir_okay=True))
def main(project_directory):
    project_dir = os.path.abspath(project_directory)

    tools = [read_file, write_to_file, run_terminal_command]
    agent = ReActAgent(tools=tools, model="openai/gpt-4o", project_directory=project_dir)

    task = input("请输入任务：")

    final_answer = agent.run(task)

    print(f"\n\n✅ Final Answer：{final_answer}")

if __name__ == "__main__":
    main()
```

prompt_template.py：系统提示词，规范输入和输出

```python
react_system_prompt_template = """
你需要解决一个问题。为此，你需要将问题分解为多个步骤。对于每个步骤，首先使用 <thought> 思考要做什么，然后使用可用工具之一决定一个 <action>。接着，你将根据你的行动从环境/工具中收到一个 <observation>。持续这个思考和行动的过程，直到你有足够的信息来提供 <final_answer>。

所有步骤请严格使用以下 XML 标签格式输出：
- <question> 用户问题
- <thought> 思考
- <action> 采取的工具操作
- <observation> 工具或环境返回的结果
- <final_answer> 最终答案

⸻

例子 1:

<question>埃菲尔铁塔有多高？</question>
<thought>我需要找到埃菲尔铁塔的高度。可以使用搜索工具。</thought>
<action>get_height("埃菲尔铁塔")</action>
<observation>埃菲尔铁塔的高度约为330米（包含天线）。</observation>
<thought>搜索结果显示了高度。我已经得到答案了。</thought>
<final_answer>埃菲尔铁塔的高度约为330米。</final_answer>

⸻

例子 2:

<question>帮我找一个简单的番茄炒蛋食谱，并看看家里的冰箱里有没有西红柿。</question>
<thought>这个任务分两步。第一步，找到番茄炒蛋的食谱。第二步，检查冰箱里是否有西红柿。我先用 find_recipe 工具找食谱。</thought>
<action>find_recipe(dish="番茄炒蛋")</action>
<observation>简单的番茄炒蛋食谱：将2个鸡蛋打散，2个番茄切块。热油，先炒鸡蛋，盛出。再热油，炒番茄至软烂，加入鸡蛋，放盐调味即可。</observation>
<thought>好的，我已经有食谱了。食谱需要西红柿。现在我需要用 check_fridge 工具看看冰箱里有没有西红柿。</thought>
<action>check_fridge(item="西红柿")</action>
<observation>冰箱检查结果：有3个西红柿。</observation>
<thought>我找到了食谱，并且确认了冰箱里有西红柿。可以回答问题了。</thought>
<final_answer>简单的番茄炒蛋食谱是：鸡蛋打散，番茄切块。先炒鸡蛋，再炒番茄，混合后加盐调味。冰箱里有3个西红柿。</final_answer>

⸻

请严格遵守：
- 你每次回答都必须包括两个标签，第一个是 <thought>，第二个是 <action> 或 <final_answer>
- 输出 <action> 后立即停止生成，等待真实的 <observation>，擅自生成 <observation> 将导致错误
- 如果 <action> 中的某个工具参数有多行的话，请使用 \n 来表示，如：<action>write_to_file("/tmp/test.txt", "a\nb\nc")</action>
- 工具参数中的文件路径请使用绝对路径，不要只给出一个文件名。比如要写 write_to_file("/tmp/test.txt", "内容")，而不是 write_to_file("test.txt", "内容")

⸻

本次任务可用工具：
${tool_list}

⸻

环境信息：

操作系统：${operating_system}
当前目录下文件列表：${file_list}
"""
```

