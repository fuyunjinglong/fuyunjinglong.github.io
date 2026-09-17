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

# windows搭建本地知识库

**要求**

> - 本地知识库文件，向量数据库，LLM处理的数据都是个人私有数据，不允许上传云端公开，也不允许拿来做训练
> - 在windows上部署，要求不使用docker,因为doker配置环境太复杂且占用内存
> - 本地知识库文件夹有100G大小，每个文件大小不超过10M，文件中内容主要以中文和英文为主，文件类型都是常规的txt、word、ppt、excel、png等，限制只基于本地知识库回答，不要胡编乱造，不会的就说不会
> - 目前已采购在线DeepSeek Api的Token,可以直接使用
> - Embedding模型是采用工具软件内置的，还是其他更好的模型？
> - 将100G文件夹，划分为20个5G文件夹，每次拖拽1个到工作区解析，全部处理完后，本地电脑会不会多占用100G存储空间？会不会卡死？
> - 我的电脑是荣耀笔记本电脑，型号是14Pro,内存只有6G,具体有什么方案实现？

**方案**

核心：AnythingLLM DeskTop+DeepSeek Api+ollama

AnythingLLM DeskTop

> - AnythingLLM 安装在固态硬盘C最好，否则需要手动迁移数据，并做软连接
> - 向量库采用LanceDB，设置 → 向量数据库 → 显示为「Built-in LanceDB (Local)」
> - Setting-Document Processing 填3
> - 在工作区设置，将Chuck Size设为500-1000
> - 禁用全文检索(FTS)索引：工作区设置关闭Full-Text Search
> - 智能清理暂存区：每次5G文件解析保存后，在Document 中将这些文件"un-map"(取消映射)。此时向量已写入LanDB，而暂存区缓存会被清空。
> - 严格控制向量检索返回数量：在工作区的Chat Settings,将LLMContext window Item（Top-K）限制在3-5
> - 建议先将png转为txt
> - 多个是混合的切片调整：在工作区设置，将Overlap(切片重叠度)设为10%-15%
> - 私有数据不上传：侧边栏最下方 → “Privacy & Data” → 把 “Anonymous Telemetry Enabled” 关掉（绿色变灰）
> - AnythingLLM如果需要移动存储目录的话：
>   - 把 storage 整个文件夹复制到 D 盘目标目录
>   - rd /s /q "C:\Users\lw\AppData\Roaming\anythingllm-desktop\storage"
>   - mklink /J "C:\Users\lw\AppData\Roaming\anythingllm-desktop\storage" "D:\profilegram\LLM\anythingllm\storage"

DeepSeek Api

> - 私有数据不上传：登录 DeepSeek 开放平台：platform.deepseek.com，进入右上角头像 → 设置 → 隐私设置，关闭「数据用于优化体验 / 模型训练」开关

ollama

> - Embedding模型选择：bge-large-zh-v1.5/bge-small-zh-v1.5/nomic-embed-text
> - 限制ollama内存常驻：添加系统变量，变量名是OLLAMA_KEEP_ALIVE，值是5m
> - GPU加速确认：荣耀14 Pro部分型号带有NVIDA独显(RTX系列)，部分是核显
> - 任务管理器，切换到性能，在解析文件时，观察GPU0/GPU1利用率
> - 如果ollama自动调用了显卡，速度回避纯CPU快5-10倍。如果发现它只利用了CPU，查看显卡驱动是否最新
> - 环境变量并发控制：添加系统变量，变量名是OLLAMA_NUM_PARALLEL，值是1
> - 私有数据不上传：关闭匿名统计：Ollama可能默认收集匿名使用统计。在系统环境变量中，新建 OLLAMA_NO_TELEMETRY，将其值设为 1

本地电脑优化配置

> - 开启高性能模式：按win+i,打开设置-系统-电源与电池-电源模式调整为"最佳性能"
> - 防止自动休眠：同样页面，屏幕和睡眠在接通电源后，关闭设备设为"永不"
> - 设置磁盘写入缓存：设备管理器-磁盘驱动器-右键固态硬盘选择属性-在策略中，确保勾选"启动设备上的写入缓存"。这样可大幅提高LanceDB写入向量速度
> - 开启windows虚拟缓存：高级系统设置-性能设置-高级-虚拟内存更改，取消勾选。选中固态硬盘盘符，初始大小填16384（16G）,最大填32G,重启电脑
> - 让ollama吃满显卡：右键-打开NVIDIA面板-管理3D设置-程序设置，点击添加，找到并选择ollama.exe(c:/users/xx/appData/local/programs),图形处理器改为"高性能NVIDIA处理器"
> - 每次解析完5G文件后，重启电脑，完全释放内存
> - 调大NVIDIA虚拟显存(独显型号)：在NVIDIA控制面板，管理3D设置-全局设置-确保"CUDA-系统内存回退策略"设置为"驱动程序默认值"
> - 按下Fn+P，直接开启荣耀笔记本的"高能模式"

# DeepSeak打造流程图

1.利用ds生成markdown文件，文件导入mindMaster即可

2.生成Mermaid格式数据，代码放入到在线生成器https://mermaid.live/，实时生成

3.将md代码，复制到在线生成器https://napkin.ai。鼠标选中内容后，点击左侧小闪电图标即可，有很多酷炫效果
