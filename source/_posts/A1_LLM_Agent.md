---
title: Agent
date: 2003-01-01 06:33:16
categories:
- A1_LLM
toc: true # 是否启用内容索引
---

# 参考

> - [吴恩达大佬-AI入门](https://datawhalechina.github.io/llm-cookbook/#/)
> - 

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

# 智泊-Agent开发

## 环境准备

**Gradio**

> 定义：方便用界面展示调用大模型的结果

> 安装 pip install gradio openai
>
> 查看版本 pip show gradio

test.py

```python
# 步骤1：导入 gradio 库
import gradio as gr

# 步骤2：定义处理函数，拼接问候语并计算长度
def greet(name):
    res = "Hello," + name
    length = len(res)
    return res,length

# 步骤3：创建界面，绑定函数与输入输出类型
demo = gr.Interface(
    fn=greet,            # 要包装的函数
    inputs=["text"],     # 输入类型：文本框
    outputs=["text","number"]  # 输出类型：文本和长度
)

# 步骤4：启动 Web 服务
demo.launch()
```

chat.py

```python
import gradio as gr  # 步骤 1：导入 gradio 网页界面库
from openai import OpenAI  # DeepSeek 兼容 OpenAI 协议，复用其 SDK

# 步骤 2：创建 DeepSeek 客户端（密钥建议改用环境变量）
# https://platform.deepseek.com/api_keys
client = OpenAI(api_key="sk-28e63a85283342b6882d967b8fd4a7ea", base_url="https://api.deepseek.com")

# 步骤 3：聊天回调函数（message=本次输入，history=历史对话）
def chat(message, history):
    # 3.1 拼接历史消息和本次输入
    messages = history + [{"role": "user", "content": message}]
    # 3.2 调用模型，取出回复文本并返回
    return client.chat.completions.create(
        model="deepseek-chat", messages=messages
    ).choices[0].message.content

# 步骤 4：启动界面，访问 http://127.0.0.1:7860 对话
gr.ChatInterface(fn=chat).launch()
```

## 提示词工程

> 是最简单的**RAG雏形**

```
prompt = fn(instruction指示,content内容或样例,query问题)
instruction = "根据上下文回答问题，如果不确定，则回答不确定"
content = "当前是AI爆炸的新时代"
query = "qwen是什么"
```

## 概述

**一、定义**

> Agent是具备**自主规划、环境感知、记忆检索、工具调用与反思迭代**能力的智能系统。
>
> **Agent = LLM + Planning（规划）+ Memory（记忆）+ Tools（工具）+ 动作（Action）**。

**二、四层架构**

主流框架（LangGraph、CrewAI、Dify、Coze）本质上都是对这套架构的封装。

> - **规划（Planning）**：任务分解、自我反思（Reflection/ReAct）
> - **记忆（Memory）**：上下文窗口 + 外部记忆（RAG、向量数据库）
> - **工具（Tools）**：函数调用、浏览器、代码执行、检索
> - **动作（Action）**：执行

## 理论的开发范式

https://zhuanlan.zhihu.com/p/2044794782246073710

<img src="/img/2026-10-17_11-55-40.png" style="zoom:50%;" />

**一、四阶段**

> - 早期 Agent（被动式ReAct）：基于ReAct范式
> - 工作流 Agent（结构化与可控性）：引入工作流/状态机
> - 自主 Agent（复杂规划与长任务）：具备自主规划决策与自我改进
> - 自进化 Agent（持续学习与自我升级）：持续学习与自我改进

**二、详细对比**

| 维度     | 早期 Agent                       | 工作流 Agent                      | 自主 Agent                        | 自进化 Agent                                  |
| -------- | -------------------------------- | --------------------------------- | --------------------------------- | --------------------------------------------- |
| 核心思想 | 推理与行动交替的循环             | 显式图状态机编排                  | 模型在运行时决策控制流            | 系统从经验中持续学习与自我改进                |
| 控制流   | Prompt 循环（线性）              | 预定义边，路径可枚举              | LLM 动态选路，路径不可枚举        | 系统级闭环：执行→反思→沉淀→增强               |
| 记忆形态 | 上下文即记忆（易污染）           | 状态变量 + 检查点                 | 短期/长期/工作记忆分层            | 终身记忆 + 经验固化为技能                     |
| 规划方式 | 逐步 Thought                     | 节点即步骤                        | Plan-and-Execute + 反思           | 规划策略本身可被进化                          |
| 可控性   | 低                               | 最高（可审计、可回放）            | 中（需护栏约束）                  | 中（进化需评估门控）                          |
| 典型代表 | LangChain Agent、基础 ReAct 实现 | LangGraph、Dify 画布、Coze 工作流 | AutoGen、CrewAI、Deep Research 类 | In-Situ Self-Evolving、CMA、MemSkill、Voyager |
| 适用任务 | 单点问答、简单工具调用           | 流程固定、需合规审计              | 开放式长任务                      | 持续交互、个性化、能力需积累的场景            |
| 主要瓶颈 | 上下文污染、易循环、失败恢复弱   | 流程外无法应对                    | 成本高、评估难                    | 进化稳定性、灾难性遗忘、评估标准              |

**三、Agent类型分类**

按照场景

> - Action
> - Simulation
> - Autonomous

按智能

> - Simple Reflex（简单反射型智能体）
> - Model-based Reflex（基于模型的反射型）
> - Goal-based（基于目标的）
> - Utility-based（基于效用的）
> - Learning（学习型的）

按技术

| Agent类型(基于技术实现)             | 子类型                   | 应用场景             |
| ----------------------------------- | ------------------------ | -------------------- |
| Chatbots（对话机器人）              | 客服机器人、代码辅助助手 | 聊天辅助             |
| Multi-Agent Systems（多智能体系统） |                          | 多个智能体协助长任务 |
| RAG（检索增强生成）                 | graph RAG                | 私有知识库           |
| Planning Agents（规划智能体）       |                          | 规划与执行智能体     |
| Reflection & Critique（反思与批判） |                          | 反思和激励驱动智能体 |
| Evaluation（评估）                  |                          | 通过模拟用户交互评估 |

## 开发选型及范式

### 三大基建

> - MCP协议
> - A2A协议
> - Context Engineering 理念普及

**MCP协议（Model Context Protocol）**

> - 定义：由Anthropic在2024年底提出的标准化协议，定义了大模型与外部工具和数据源的交互标准
> - 重要性：可将其理解为Agent工具调用领域的USB接口。
> - 历史对比：
>   - MCP之前：每个框架都有自己的工具接口定义方式，工具跨框架使用需要重写
>   - 2026年现状：十个主流框架中至少八个已原生支持MCP
> - 影响：工具生态壁垒正在消失，MCP标准封装的工具几乎可在任何框架中直接使用。工具支持数量不再是选框架的
>   关键维度。

**A2A协议(Agent to Agent Protocol）**

> - 定义：由Google在2025年提出的协议，定义了不同框架构建的Agent之间的通信方式
> - 解决的问题：
>   - MCP解决Agent如何使用工具
>   - A2A解决Agent如何与其他Agent通信
> - 支持现状：
>   - 原生支持：Microsoft Agent Framework、Google ADK、AgentScope
>   - 社区插件支持：CrewAI、LangGraph
> - 发展趋势：Agent生态正在从框架孤岛走向互操作网络，尽管采纳周期较长，但方向确定。

**Context Engineering 理念普及**

> - 定义：2025年兴起的新共识-仅做PromptEngineering已不够，需要进行Context Engineering。
> - 核心要求：精心管理送进大模型上下文窗口的信息质量和结构。主要包括Instructions、Knowledge、Tools。
> - 技术影响：推动了框架在以下方面的创新
>   - 记忆压缩
>   - 上下文过滤
>   - 动态工具选择

### 五大架构范式

**范式一：图状态机**

> - 代表框架：LangGraph
> - 核心哲学：少抽象，多控制
> - 核心原理：Node节点、Edge边、State状态
> - 设计理念：提供最基础的构建块，让开发者自行搭建任意复杂的执行图。灵感来自Google
> - 特点：
>   - 不做任何架构决策预设
>   - 不预设Agent的思考和协作方式
>   - 开发者需要自行设计状态模式、编排逻辑、错误处理
> - 官方理念：“当我们必须在易用性和生产就绪性之间做取舍时，我们选择了生产就绪性。
> - 优势：
>   - 灵活性极高
>   - 内置checkpointer支持状态持久化
>   - 支持时间旅行调试
>   - 内置interrupt函数支持人工审批
>   - token级流式传输，零额外开销
> - 应用场景：
>   - Klarna：客户服务Agent
>   - Vodafone：数据工程AI助手
>   - Replit：代码生成工作流编排
> - 能力评分：
>   - 多Agent编排：⭐⭐⭐⭐⭐
>   - 生产部署成熟度：⭐⭐⭐⭐⭐
>   - 生态丰富程度：可观测性：⭐⭐⭐⭐⭐
>   - 灵活可定制性：⭐⭐⭐⭐⭐
>   - 上手难度：⭐⭐
> - 定位：Agent框架中的Linux-—强大，但需要技术深度。

**范式二：角色驱动**

> - 代表框架CrewAI
>
> - 核心哲学：像组建真实团队一样组建Agent团队
>
> - 核心概念：
>
>   - Role（角色）
>   - Goal（目标）
>   - Backstory（背景故事）
>
> - 使用流程：
>
>   1. 定义角色
>   2. 分配任务
>   3. 启动团队
>
> - 技术特点：
>
>   - 完全独立于Langchain，从零构建
>   - 无外部依赖
>   - 提供两种编排方式：
>     - Crews：强调自主协作，Agent可自主委派任务
>     - Flows：提供事件驱动的精确控制路径
>
> - 社区规模：45900+GitHubstars，超过10万开发者通过官方课程完成认证
>
> - 能力评分
>
>   - 上手难度：⭐⭐⭐⭐⭐
>   - API稳定性：⭐⭐⭐
>   - 底层控制力：⭐⭐⭐
>   - 复杂逻辑表达：⭐⭐⭐
>
> - 适用场景：
>
>   ✅️内容创作管线
>   ✅️市场调研
>   ✅️快速原型开发
>
> - 不适用场景：
>
>   ❌️极致状态控制的金融交易系统
>   ❌️需要精确错误恢复的长时间运行工作流

**范式三：事件驱动**
代表框架：LlamaIndex、AgentScope
LlamaIndex

> - 核心理念：数据是Agent智能的基石
> - 核心优势：
>   - 数据层有300多个连接器
>   - LlamaParse文档解析引擎支持130+文件格式
>   - 支持复杂嵌套表格和手写笔记解析
>   - 编排层使用Workflows1.0：事件驱动、异步优先、步骤化执行
> - 应用场景：
>   - 私募基金：复杂金融文档处理
>   - 保险公司：保单分析
>   - 制造业：技术规格书洞察提取
> - 市场地位：数据密集型Agent领域的护城河极深，几乎没有替代品。

AgentScope

> - 来源：阿里巴巴通义实验室
> - 核心理念：透明可控
> - 独特优势：
>   1. 内置模型微调支持，可直接在框架内做Agent强化学习微调
>   2. Python+java双版本
>   3. 原生适配国内生态（通义干问、阿里云函数计算、钉钉）

**范式四SDK封装**

代表框架：OpepAI Agents SDK、PydanticAI

OpenAI Agents SDK

> - 核心概念：仅包含三个核心概念
>   - Agent
>   - Handoff
>   - Guardrail
> - 核心创新：Handoff机制，Agent完成任务后可将控制权移交给更合适的Agent。
> - 技术优势：
>   - 上手门槛极低：5行代码即可启动
>   - 与OpenAI生态深度集成
>   - 原生支持RealtimeVoiceAgent，包括中断检测、实时流式语音
> - 局限性：
>   - 缺乏持久化执行和检查点机制
>   - 编排模式有限
>   - 不支持并行和循环

PydanticAI

> - 核心理念：把FastAPI的体验带给Agent开发
> - 核心优势：
>   - 所有输入输出通过Pydantic模型验证
>   - 结构化输出自动解析
>   - 失败自动重试
>   - 支持25+模型提供商，切换模型无需重写业务逻辑
>   - 内置TestMode和mock工具，支持确定性测试
> - 行业评价：可能成为类型安全Agent基础设施层的事实标准

**范式五：低代码平台**

> - 代表框架：Dify
> - 核心数据：131,000+GitHubstars，全球排名第51位
> - 技术特点：
>   - 非Python库，是完整的Web平台
>   - 提供拖搜式工作流编辑器
>   - 支持模型管理、知识库管理
>   - API一键发布、日志监控
>   - 全在浏览器中操作，非技术人员也能使用
> - 应用场景：
>   - Maersk（全球航运巨头）
>   - Novartis（制药公司)
> - 商业进展：2026年3月完成3000万美元Pre-A轮融资，估值1.8亿美元
> - 核心价值：让AI应用开发民主化
> - 局限性：灵活性受限于可视化编辑器的表达能力

**另外两大企业级框架**

Microsoft Agent Framework

> - 背景：2025年10月，微软宣布合并AutoGen和SemanticKernel
> - 合并背景：
>   - AutoGen：学术界最前沿的多Agent研究框架（50,400+stars）
>   - SemanticKernel：企业级稳定的AI编排引擎（21,000+sstars）
> - 技术优势：
>   1. 唯一同时原生支持.NET和Python的主流框架
>   2. 原生支持A2A、AG-UI、MCP三大标准
>   3. 与AzureAIFoundry深度集成
> - 发展状态：2026年2月达到Release candidate状态，预计2026年Q1未发布

GoogleADK

> - 技术特点：多语言路线，同时覆盖Python、TypeScript，Java、Go也在开发中
> - Agent类型：
>   - LlmAgent：智能推理
>   - SequentialAgent:顺序编排
>   - ParallelAgent:并行编排
>   - LoopAgent:循环编排
>   - BaseAgent:自定义扩展
> - 云集成：与VertexAI和CloudRun原生集成
> - 局限性：框架仍为0.×版本，社区规模不及Langchain

### **五步法选型**

**第一步：技术栈匹配**

> - NET/C#技术栈→Microsoft Agent Framework
> - Java技术栈→Gooqle ADK或AgentScope Java版
> - Typescript全栈→OpenAI Agents SDKJS/TS版 或 LangGraph.js
> - 多语言混合团队→Google ADK
> - 纯Python团队→选择最多

**第二步：场景匹配**

> - 数据密集型RAG/文档问答→LlamaIndex
> - 角色化多Agent协作→CrewAI
> - 复杂有状态工作流→LangGraph
> - 决速原型/MVP→CrewAI或OpenAI Agents SDK
> - 企业低代码平台→Dify
> - 国内企业私有化部署→AgentScope或Dify

**第三步：云平台匹配**

> - Azure→Microsoft Agent Framework
> - GoogleCloud→Google ADK
> - 阿里云→AgentScope
> - 自托管/私有化→Dify
> - 无特定偏好→根据场景选择

**第四步：模型偏好匹配**

> - 深度依赖OpenAI→OpenAI Agents SDK
> - 依赖Gemini→GoogleADK
> - 使用国内模型→Agentscope或Dify
> - 追求模型无关性→PydanticAI（支持25+提供商）

**第五步：成本分析**

> 1. 开源与生产可用性的差异
>    许多框架在GitHub上免费，但进入生产环境时往往伴随着隐性成本。
>
>    - LangGraph:开源免费，但生产部署几乎必须使用付费的LangGraph Platform以获得状态持久化等关键能力。
>    - LlamaIndex:核心库免费，但其核心优势—高质量文档解析依赖付费的LlamaParse服务。
>    - Dify：开源版功能有限，企业级功能（如SSO、高级日志）需购买商业版或承担高昂的自行维护成本
>    - Microsoft/Google框架：虽然框架本身免费，但深度绑定各自云服务的付费组件，迁移成本高。
>    - PydanticAI:隐性成本最低，无强制绑定的付费平台，是真正轻量的选择。
>
> 2. 运行时的Token经济学
>    架构选型直接决定了Token的消耗效率，低效的框架可能成为预算的黑洞”
>
>    - 警惕Token黑洞”：根据2026年的最新数据，类似Openclaw等第三方框架因上下文管理低效（如频繁的心跳
>
>      机制、重复计算），可能导致API调用量是原生框架的数倍。Anthropic已切断此类订阅套利通道，强制按量付
>
>      费，使得低效框架的成本风险剧增。
>
>    - 架构选型影响：
>
>      - 图状态机（LangGraph）：控制力最强，可精细化裁剪上下文，Token利用率最高，
>      - 角色驱动（CrewAI）：自主协作可能导致冗余对话，Token消耗相对不可控。
>
>    - 端云协同趋势：对于高频、重复性任务（如客服、数据录入），可考虑AgentComputer或Tiny Box等本地化
>
>      部署方案。通过一次性硬件投入（约1-2万元）替代持续的Token支出，可将长期TCO（总拥有成本）降低
>
>      90%以上。

### **未来趋势**

**行业趋势**

> 1. 框架数量减少：微软合并AutoGen和SemanticKernel，预示未来框架数量将继续减少
> 2. 核心能力模块化：LlamaIndex将Workflows独立，反映核心能力可独立复用的趋势
> 3. 多模态成为标配：语音和视觉正在成为Agent的基本要求
> 4. 国内生态发展：Dify和AgentScope展现国内框架的独特优势

**对三类人群的建议**

1.独立开发者和技术探索者

> - 推荐路径：从PydanticAI或OpenAI Agents SDK起步
> - 优势：学习曲线最平缓，能最快建立Agent开发的核心认知
> - 进阶方案：需要复杂编排时再使用LangGraph

2.初创公司技术团队

> - 推荐路径：用CrewAI快速验证想法做原型
> - 生产方案：验证通过后迁移到LangGraph做生产系统
> - 备选方案：考虑Agno的全栈方案，一站式解决从原型到部署

3.大型企业技术委员会
云战略优先

> - Azure→微软框架
> - GoogleCloud→Google框架
> - 多云混合→LangGraph+Dify组合

技术考量：

> 1. 优先考虑MCP和A2A协议支持
> 2. 确保未来的互操作能力
> 3. 建立长期技术路线图



## 生产部署

## 关键技术

## 最佳实践

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

