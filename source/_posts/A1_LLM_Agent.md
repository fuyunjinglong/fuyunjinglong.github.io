---
title: LLM_Agent
date: 2025-12-01 06:33:16
categories:
- A1_LLM
toc: true # 是否启用内容索引
---

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

