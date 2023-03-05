---
title: 集线器交换机路由器等
date: 2022-05-04 06:33:16
categories:
- F_计算机网络
toc: true # 是否启用内容索引
---

# 集线器（HUB）

集线器起到了一个将网线集结起来的作用，实现最初级的网络互通。集线器是通过网线直接传送数据的，我们说他工作在**物理层**。

类似网吧的CS精英。

**第1层（物理层）**上运行

<img src="/img/image-20220504160952342.png" alt="image-20220504160952342" style="zoom:50%;" />

# 交换机

集线器会广播所有消息，但我只需要告知某人消息，这就需要交换机

将资料从A的电脑传送到C的电脑中，而不让小B、小D和小E收到。也就是说，这台设备解决了冲突的问题，实现了任意两台电脑间的互联，大大地提升了网络间的传输速度，我们把它叫做交换机。由于交换机是根据网口地址传送信息，比网线直接传送多了一个步骤，我们也说交换机工作在**数据链路层**。

**第2层（数据链路层）**运行

<img src="/img/image-20220504161205348.png" alt="image-20220504161205348" style="zoom:50%;" />

# 路由器

其他村也想加入进来，路由器就出现了。路由器上有 WAN 口和 LAN 接口，而交换机没有这些接口。

**第3层（网络层）**上运行

<img src="/img/image-20220504161317346.png" alt="image-20220504161317346" style="zoom:67%;" />

# 猫

猫的学名叫[调制解调器](https://www.zhihu.com/search?q=调制解调器&search_source=Entity&hybrid_search_source=Entity&hybrid_search_extra={"sourceType"%3A"answer"%2C"sourceId"%3A402261894})，它的作用是将数字信号（电脑想要发送的信息）转换成模拟信号（网线中的电流脉冲）从而使信息在网线中传输。

目前的家用路由器一般都是路由猫，即路由器兼顾了猫和简单交换机的功能。

# 总结

用快递解释：

数据帧：快递

二层MAC地址:你的身份证号，全球唯一

三层IP地址:你的当前的住宅地址，你随时可能会搬去其他地址住

额外的规则:一个住宅地址只能住一个人，否则会导致收发快递不正常

[交换机](https://www.zhihu.com/search?q=交换机&search_source=Entity&hybrid_search_source=Entity&hybrid_search_extra={"sourceType"%3A"answer"%2C"sourceId"%3A21177598})：给你派件的快递员，但是只认身份证号的数字(MAC)，不认地址上的中文(IP)

路由器：物流公司的集散中心，占有一个身份证号(MAC)，同时占有一个住宅地址(IP)

[载波](https://www.zhihu.com/search?q=载波&search_source=Entity&hybrid_search_source=Entity&hybrid_search_extra={"sourceType"%3A"answer"%2C"sourceId"%3A21177598})：运输快递的火车/飞机/船

猫：将快递装上/卸下火车/飞机/船的地方

