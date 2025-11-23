---
title: LLM_本地安装大模型
date: 2025-11-24 06:33:16
categories:
- B_LLM
toc: true # 是否启用内容索引
---

# windows安装大模型

- 安装ollama
- 使用ollama下载Deepseak-R1
- 安装Docker
- 安装Open WebUI

## 安装ollama

去[官网](https://ollama.com/)下载ollama,安装好后，ollama是后台运行的。地址栏输入localhost:11434,提示ollama is running就表示安装成功。

## 下载Deepseak-R1

去[ollama官网](https://ollama.com/library/deepseek-r1:1.5b)下载DeepSeek,选择1.5b试试，复制安装命令到本地cmd,执行命令：ollama run deepseek-r1:1.5b。

安装完成后，系统会自动启动Deepseek,只是是cmd这种不太友好的界面。

![image](/img/2025-11-23_12-17-59.png)

## 安装Docker

为了方便更好的图形化管理，我们需要安装Open WebUI。为了方便管理环境，统一使用Docker。去[官网](https://www.docker.com/)下载Docker。

## 安装Open WebUI

去[官网](https://github.com/open-webui/open-webui)最下面找到涉及ollama的安装命令：docker run -d -p 3000:8080 --add-host=host.docker.internal:host-gateway -v open-webui:/app/backend/data --name open-webui --restart always ghcr.io/open-webui/open-webui:main。

最后地址栏打开：localhost:3000，第一次可能要注册即可使用。

![image](/img/2025-11-23_12-31-53.png)

**如果需要安装其他模型，直接重复第二步下载即可，然后在Open WebUI界面左上角切换模型即可。**

# 搭建知识库-AnythingLLM

在安装本地大模型基础上，使用并安装AnythingLLM构建本地知识库。除此之外，也有其他类似的知识库管理软件，如Dify、MaxKB、RagFlow、notebooklm等，这些管理知识库要么效果不好或操作太复杂。而AnythingLLM除了提供聊天模式，还提供了查询模式即本地知识库。

其中notebooklm与AnythingLLM类似，准确率和总结效果比AnythingLLM还要好点，只是数据是存储在云端的。

去[官网](https://anythingllm.com/)下载AnythingLLM，安装好后，打开软件。搜索选择ollama,同时注意选择对应的本地模型。点击skip survey跳过。

接着进入主界面后，设置聊天模式为查询，这样大模型就只会使用本地知识库了。

在左侧工作区上传文档，选中上传的文件，move to workspace 然后save and embed即完成上传知识库。

# DeepSeak打造流程图

1.利用ds生成markdown文件，文件导入mindMaster即可

2.生成Mermaid格式数据，代码放入到在线生成器https://mermaid.live/，实时生成

3.将md代码，复制到在线生成器https://napkin.ai。鼠标选中内容后，点击左侧小闪电图标即可，有很多酷炫效果
