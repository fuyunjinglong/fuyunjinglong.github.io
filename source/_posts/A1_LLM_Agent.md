---
title: Agent
date: 2004-01-01 06:33:16
categories:
- A1_LLM
toc: true # 是否启用内容索引
---

# Agent厂商

**选型建议**

> - **个人写作/资料研究**：国内首选智谱 AutoGLM、Kimi；国外首选 Perplexity、Manus Free、ChatGPT 免费层。
> - **自媒体/电商内容与客服机器人**：扣子 Coze（分发到抖音/微信）、腾讯元器、文心智能体。
> - **开发者做 RAG 与工作流**：自部署选 Dify（国内）/ n8n（国外）/ LangGraph（代码向）；中文生态优先 Dify + Qwen-Agent。
> - **编程 Agent**：轻度用 Cursor Pro、Claude Code Pro；重度/团队上 Devin 或 Claude Max。
> - **企业级落地**：M365 生态选 Copilot Studio，CRM 场景选 Agentforce，知识管理选 Glean，传统行业跨系统自动化选实在 Agent，阿里云体系选百炼/AgentCore，百度体系选千帆 AppBuilder。

## 国内

**完全免费 / 开源(仅需自备算力/API Key)**

| 产品                                                        | 核心定位                                                     | 使用门槛               | 免费情况                                                 | 典型场景                                   |
| ----------------------------------------------------------- | ------------------------------------------------------------ | ---------------------- | -------------------------------------------------------- | ------------------------------------------ |
| **Dify**（langgenius/dify）                                 | 低代码 LLM 应用 + Agent 开发平台，支持 50+ 模型、RAG、可视化编排 | 低（Docker 一键部署）  | Apache 2.0，自部署完全免费zooz.com                       | 企业内部知识库问答、客服 Agent、RAG 应用   |
| **Qwen-Agent**（QwenLM/Qwen-Agent）                         | 通义千问官方 Agent 框架，内置代码解释器、搜索、RAG 工具      | 中（Python，pip 安装） | 开源免费，可接 DashScope API 或本地 vLLM/Ollamaiaiol.com | 长文档分析、代码助手、中文 Agent 应用      |
| **AgentScope**（阿里通义实验室）                            | Actor 模型多 Agent 分布式框架，原生支持 MCP + A2A 协议       | 中高（分布式工程化）   | Apache 2.0，GitHub 31.7k 星agentlist.top                 | 多 Agent 协作系统、Agent-as-Service 部署   |
| **MetaGPT**（DeepWisdom）                                   | 多角色协作框架，模拟产品经理/架构师/工程师协作               | 中高                   | 开源免费csdn.net                                         | 软件工程全流程自动化、辩论模拟、供应链协同 |
| **FastGPT**                                                 | 国内流行的开源知识库问答 + 工作流平台                        | 低                     | 开源可自部署                                             | 中小企业知识库、RAG 客服                   |
| **ChatDev**（面壁智能）                                     | 软件公司模拟多 Agent 开发框架                                | 中                     | 开源                                                     | 研究、原型级软件开发演示                   |
| NoWorries (无事) ，WorkAny， QwenPaw ，DeepThink / MyAgents |                                                              |                        |                                                          |                                            |

**免费额度**

| 产品                           | 核心定位                                                     | 使用门槛             | 免费情况                                                     | 典型场景                                         |
| ------------------------------ | ------------------------------------------------------------ | -------------------- | ------------------------------------------------------------ | ------------------------------------------------ |
| **扣子 Coze**（字节）          | 零代码 Agent 搭建平台，1 万+ 插件生态                        | 低（拖拽式，零代码） | 基础功能免费，专业版/高级模型付费，月活已超 200 万ai-indeed.com | 新媒体内容、电商客服、抖音/微信/飞书分发csdn.net |
| **智谱清言 AutoGLM**           | 基于自研 GLM-4/沉思模型的执行型 Agent，能边推理边浏览数十网页生成报告 | 低（网页/App）       | 个人使用免费，API 按调用计费csdn.net                         | 深度调研、长报告撰写、学术润色、法律文书         |
| **Kimi 智能体**（月之暗面）    | 200 万字长文本 Agent，深度分析长文档                         | 低                   | 免费为主，付费会员增值toutiao.com                            | 律师卷宗分析、研报提炼、长文档问答               |
| **腾讯元器**                   | 微信/QQ 生态 Agent，支持 3D 数字人                           | 低                   | 免费                                                         | 微信客服、教育陪练、社交场景分发betteryeah.com   |
| **文心智能体平台**（百度）     | 依托文心大模型 + 搜索/地图生态                               | 低（零代码）         | 免费                                                         | 电商导购、本地生活、企业内部知识问答toutiao.com  |
| **通义千问 / 夸克 App**        | 阿里 C 端全能助手 + Agent 应用                               | 低                   | 免费                                                         | 办公写作、学习辅导、旅行规划等日常任务           |
| **天工 SkyAgents**（昆仑万维） | PPT/表格/网页多格式生成                                      | 低                   | 免费                                                         | 办公汇报、市场分析、论文初稿toutiao.com          |
| **WorkBuddy**                  |                                                              |                      |                                                              |                                                  |

**商业收费定制**

| 产品                          | 核心定位                                            | 使用门槛           | 收费模式                                              | 典型场景                                           |
| ----------------------------- | --------------------------------------------------- | ------------------ | ----------------------------------------------------- | -------------------------------------------------- |
| **实在 Agent**（实在智能）    | TARS 模型 + 屏幕理解，无需 API 即可操作任意软件系统 | 中（企业实施为主） | 企业版订阅/私有化定制，已服务 4000+ 企业ai-indeed.com | 财务、政务、金融、制造等跨系统自动化"数字员工"     |
| **百度智能云千帆 AppBuilder** | 企业级 Agent 开发 + 模型托管                        | 中                 | 按调用量/席位计费csdn.net                             | 企业客服、知识管理、对数据安全要求高的行业         |
| **阿里云百炼 / AgentCore**    | Qwen 模型 + 企业 Agent 构建/部署/治理平台           | 中                 | 按模型 Token 与服务实例计费c-sharpcorner.com          | 多 Agent 业务工作流、DBA/数据 Agent 等企业级 Agent |
| **腾讯云智能体开发平台**      | RAG + 多 Agent 协同架构                             | 中                 | 云服务订阅                                            | 客服对话、Excel/数据库自然语言查询ai-indeed.com    |
| **京东云言犀**                | 电商基因的智能体平台                                | 中                 | 企业版收费                                            | 电商导购、营销、供应链客服                         |
| **火山引擎 HiAgent**          | 字节企业版 Agent 平台（与 Coze 互补）               | 中                 | 私有化/订阅                                           | 大中型企业内部 Agent 中台                          |
| **迈富时 AI-Agentforce**      | 营销垂类智能体中台                                  | 中                 | SaaS 订阅                                             | 获客、销售、CRM 自动化csdn.net                     |

## 国外

**完全免费 / 开源(仅需自备算力/API Key)**

| 产品                          | 核心定位                                                | 使用门槛                 | 免费情况                     | 典型场景                                        |
| ----------------------------- | ------------------------------------------------------- | ------------------------ | ---------------------------- | ----------------------------------------------- |
| **LangChain / LangGraph**     | 事实标准 LLM 编排框架，LangGraph 支持有状态图与人在回路 | 中高                     | MIT 开源appsinsight.co       | 复杂 Agent 工作流、RAG、多步推理                |
| **Microsoft AutoGen**         | 事件驱动多 Agent 对话编排                               | 中高                     | MIT 开源appsinsight.co       | 团队模拟、多 Agent 协作研究                     |
| **CrewAI**                    | 角色化多 Agent 协作框架                                 | 中                       | 开源appsinsight.co           | 团队角色分工型任务（如写作小组、研究小组）      |
| **n8n**                       | 400+ 节点的可视化工作流平台，原生集成 AI Agent          | 低中（自部署 Fair-code） | 自部署免费，云版收费zooz.com | DevOps 自动化、API 集成、AI 工作流编排          |
| **OpenHands（原 OpenDevin）** | 开源编程 Agent，对标 Devin                              | 中                       | MIT 开源bitcot.com           | 软件开发辅助、Issue 自动修复                    |
| **AutoGPT / BabyAGI**         | 自主任务循环早期代表                                    | 中                       | 开源                         | 学习/原型验证（生产慎用，易循环）appsinsight.co |
| **Semantic Kernel**（微软）   | 跨平台企业集成 SDK（C#/Python）                         | 中                       | MIT 开源                     | .NET/Azure 生态企业集成bitcot.com               |

**免费额度**

| 产品                                  | 核心定位                                 | 使用门槛 | 免费情况                                                     | 典型场景                                                    |
| ------------------------------------- | ---------------------------------------- | -------- | ------------------------------------------------------------ | ----------------------------------------------------------- |
| **ChatGPT**（含 GPTs、ChatGPT Agent） | 通用对话 + 自主任务执行 Agent            | 低       | 免费层有限额，Plus $20/月，Pro$200/月                        | 通用助手、深度研究、数据分析                                |
| **Claude.ai / Claude Code**           | Anthropic 长文本 + 编程 Agent（含 MCP）  | 低中     | 免费层有限，Pro $20/月、Max$100/$200/月finout.io             | 编程 Agent、长文档处理、MCP 工具调用                        |
| **Cursor**                            | AI 编程 IDE + 自主编程 Agent             | 中       | 免费层有限，Pro $20/月cursor.com                             | 代码生成、PR 评审、并行 Agent 构建                          |
| **Manus**（Butterfly Effect）         | 通用自主 Agent，云端沙箱异步执行多步任务 | 低       | Free 每日 300 credits + 注册 1000，Pro $20–$200/月leadion.ai+1 | 竞品调研报告、网站搭建、长任务研究（GAIA L1 86.5%）hokai.io |
| **Perplexity**                        | 搜索增强问答 + 深度研究 Agent            | 低       | 免费层有限，Pro $20/月                                       | 资料检索、带引用的研究报告                                  |
| **Zapier Agents**                     | 工作流自动化 + AI Agent                  | 低       | 免费层 100 任务/月，付费 $20 起                              | 跨应用自动化、销售线索处理                                  |
| **Relevance AI**                      | 低代码 AI Agent 团队搭建                 | 低       | 免费层，付费 $19 起                                          | 销售/市场 Agent 团队                                        |

**商业收费定制**

| 产品                               | 核心定位                                                     | 使用门槛       | 收费模式                                                     | 典型场景                                                     |
| ---------------------------------- | ------------------------------------------------------------ | -------------- | ------------------------------------------------------------ | ------------------------------------------------------------ |
| **Devin**（Cognition）             | 自主编程 Agent，端到端承接工程任务                           | 中（工程团队） | Free/$20 Pro/$200 Max/$500 Team（250 ACU/月）cognition.com+1 | 代码迁移、on-call 处理、PR 修复，与 GitHub/Linear/Slack 集成devin.ai |
| **Glean**                          | 企业级 Work AI + Agent 平台，连接 Slack/Drive/Jira/Salesforce 等 | 中（企业部署） | 约 $50+/用户/月，100 席起gosearch.ai                         | 企业知识搜索、员工 Agent、权限感知 RAGglean.com              |
| **Microsoft Copilot Studio**       | M365 生态低代码 Agent 平台                                   | 中             | $30/用户/月 +$200/25,000 messages 消息包microsoft.com        | Teams/SharePoint 内的客服、流程 Agent                        |
| **Google Vertex AI Agent Builder** | 云原生 Agent 构建 + Gemini 模型托管                          | 中高           | 按用量计费（训练节点约 $21.25/小时起）lindy.ai               | 多模态企业 Agent、GCP 用户生产级部署                         |
| **AWS Bedrock Agents**             | 云厂商托管 Agent 服务                                        | 中高           | 按调用量计费                                                 | AWS 生态企业 Agent、多模型接入                               |
| **Salesforce Agentforce**          | CRM 场景 Agent 平台                                          | 中             | $2/对话 或 Flex Credits 按动作计费salesforce.com+1           | 客服/销售/营销 Agent，与 Salesforce 数据原生打通             |
| **Intercom Fin**                   | 客服 AI Agent SaaS                                           | 低             | 按解决量计费                                                 | SaaS 客服自动化                                              |

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

