---
title: LLM_windows安装大模型
date: 2025-11-24 06:33:16
categories:
- A1_LLM
toc: true # 是否启用内容索引
---

# windows_Ollama下载大模型

- 安装ollama
- 使用ollama下载Deepseak-R1
- 安装Docker
- 安装Open WebUI

## 安装ollama

去[官网](https://ollama.com/)下载ollama,安装好后，ollama是后台运行的。地址栏输入localhost:11434,提示ollama is running就表示安装成功。

> ollama下载的模型基本属于本地离线大模型。

在安装Ollama后，配置ollama环境变量-用户变量

> OLLAMA_HOST:0.0.0.0:11434  //配置主机服务端口
>
> OLLAMA_MODELS :D:\ollamaModels // 模型下载地址

开始下载模型

> ollama run deepseek-r1:1.5b

## 下载Deepseak-R1

去[ollama官网](https://ollama.com/library/deepseek-r1:1.5b)下载DeepSeek,选择1.5b试试，复制安装命令到本地cmd,执行命令：ollama run deepseek-r1:1.5b。

安装完成后，系统会自动启动Deepseek,只是是cmd这种不太友好的界面。

## 安装Docker

去[官网](https://www.docker.com/)下载Docker。后续的所有工具都是安装在Docker上的，一整套环境方便管理。

# 搭建知识库

知识库管理软件，如Dify、MaxKB、RagFlow、notebooklm等，这些知识库既可以连接本地大模型，也可以通过ApiKey方式连接在线大模型。注意某些工具需要设置嵌入模型即量化模型，用来解析量化你的知识库文件，用于模型读取。

## Open WebUI-ollama

参考：

- [5分钟教会你如何本地部署DeepSeek-R1](https://www.bilibili.com/video/BV1tjFVezEK5/?spm_id_from=333.1391.0.0&vd_source=bd4c7d99d71adf64d6e88c65370e0247)

先安装好Docker环境，

去[官网](https://github.com/open-webui/open-webui)最下面找到涉及ollama的安装命令：

> docker run -d -p 3000:8080 --add-host=host.docker.internal:host-gateway -v open-webui:/app/backend/data --name open-webui --restart always ghcr.io/open-webui/open-webui:main。

最后地址栏打开：localhost:3000，第一次可能要注册即可使用。

![image](/img/2025-11-23_12-31-53.png)

**如果需要安装其他模型，直接重复第二步下载即可，然后在Open WebUI界面左上角切换模型即可。**

## AnythingLLM客户端-ollama

也支持在线大模型Api调用方式

参考：

- [使用 DeepSeek-R1 与 AnythingLLM 搭建本地知识库](https://www.bilibili.com/video/BV1ioFyekEWj/?spm_id_from=333.1391.0.0&vd_source=bd4c7d99d71adf64d6e88c65370e0247)

先安装好Docker环境，AnythingLLM除了提供聊天模式，还提供了查询模式即本地知识库。与notebooklm相比，数据是存储在本地，但效果会差点。

去[官网](https://anythingllm.com/)下载，安装好后，打开软件客户端，搜索选择ollama,同时注意选择对应的本地大模型。下一步下一步，点击skip survey跳过。

![image](/img/2025-12-07_12-21-09.png)

![image](/img/2025-12-07_12-19-52.png)

接着进入主界面后，设置聊天模式为查询，这样大模型就只会使用本地知识库了。

在左侧工作区上传文档，选中上传的文件，move to workspace 然后save and embed即完成上传知识库。

![image](/img/2025-12-07_12-24-18.png)

## RAGFlow-ollama(推荐)

也支持在线大模型Api调用方式

参考：

- [【喂饭教程】30分钟教会你用DeepSeek+RAGFlow构建个人知识库](https://www.bilibili.com/video/BV1cxsHzGEyQ/?spm_id_from=333.1391.0.0&vd_source=bd4c7d99d71adf64d6e88c65370e0247)

先安装好Docker环境，然后去[官网github仓库](https://github.com/infiniflow/ragflow/blob/main/README_zh.md)下载压缩包

> 注意：在 `v0.22.0` 之前的版本，我们会同时提供包含 embedding 模型的镜像和不含 embedding 模型的 slim 镜像。具体如下：

| RAGFlow image tag | Image size (GB) | Has embedding models? | Stable?        |
| ----------------- | --------------- | --------------------- | -------------- |
| v0.21.1           | ≈9              | ✔️                     | Stable release |
| v0.21.1-slim      | ≈2              | ❌                     | Stable release |

> 从 `v0.22.0` 开始，我们只发布 slim 版本，并且不再在镜像标签后附加 **-slim** 后缀。

这里我们要使用自带的embedding模型的版本，否则我们要自己去下载一个embedding模型做词向量化。

修改压缩包文件/docker/.env，搜索download关键字

> RAGFLOW_IMAGE=infiniflow/ragflow:v0.22.1  改为v0.21.1 

启动RAGFlow,压缩包根目录下执行

> docker compose -f  docker/docker-compose.yml up -d

最后地址栏打开：localhost:80，然后配置大模型

![image](/img/2025-12-07_12-50-24.png)

再设置系统模型设置

![image](/img/2025-12-07_12-54-04.png)

新建知识库，开始上传文档，并解析

![image](/img/2025-12-07_12-55-23.png)

新建助理，选择知识库

![image](/img/2025-12-07_12-57-48.png)

## Cherry Studio客户端

参考:

- [Cherry Studio：一键连接所有AI语言模型！](https://www.bilibili.com/video/BV1mwAZeBEco/?spm_id_from=333.1387.favlist.content.click&vd_source=bd4c7d99d71adf64d6e88c65370e0247)
- [完全体DeepSeek-R1，5分钟用硅基流动API](https://www.bilibili.com/video/BV1pCPDenEC3/?spm_id_from=333.1387.favlist.content.click&vd_source=bd4c7d99d71adf64d6e88c65370e0247)

[官网](https://www.cherry-ai.com/)下载使用即可，支持知识库。Cherry Studio是一个客户端，支持多种平台模型的Api调用，如硅基流动.

**硅基流动是一个大模型整合平台。**

> 先在网页的硅基流动上，设置一个Api秘钥

![image](/img/2025-12-07_17-23-50.png)

> Cherry Studio上配置选中硅基流动，配置Api秘钥和添加的大模型

![image](/img/2025-12-07_17-23-17.png)

> 添加的大模型,先复制硅基流动上的大模型完整配置，然后复制粘贴到Cherry Studio配置上

![image](/img/2025-12-07_17-27-18.png)

![image](/img/2025-12-07_17-32-31.png)

如果要使用联网功能，需要按提示去配置，然后在使用时开启搜索联网功能

![image](/img/2025-12-07_17-45-36.png)

## ChatBox客户端-不推荐

与Cherry Studio功能类似，但是没有知识库的功能。

## notebooklm网页版-内置在线大模型

参考:

- [NotebookLM快速上手（2025）](https://www.bilibili.com/video/BV1njcoepEsp/?spm_id_from=333.1387.upload.video_card.click&vd_source=bd4c7d99d71adf64d6e88c65370e0247)

[notebooklm官网](https://notebooklm.google.com/)，直接使用google邮箱登录注册使用，上传的资料会进入到云端解析，默认使用在线的google大模型Gemini。

# DeepSeak打造流程图

1.利用ds生成markdown文件，文件导入mindMaster即可

2.生成Mermaid格式数据，代码放入到在线生成器https://mermaid.live/，实时生成

3.将md代码，复制到在线生成器https://napkin.ai。鼠标选中内容后，点击左侧小闪电图标即可，有很多酷炫效果
