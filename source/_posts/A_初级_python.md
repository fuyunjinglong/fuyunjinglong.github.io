---
title: python
date: 2018-01-02 08:33:16
categories:
- A_初级
toc: true # 是否启用内容索引
---

# 黑马python教程

**参考**

> - [python语法基础](https://www.bilibili.com/video/BV1sHU9BmEne/?cid=34278674060&spm_id_from=333.788.videopod.episodes&vd_source=bd4c7d99d71adf64d6e88c65370e0247&p=4)

<img src="/img/2026-11-14_11-13-36.png" style="zoom:50%;" />

## 入门

**python环境安装**

> - 下载：[python官网下载](https://www.python.org/downloads/windows/)
> - 安装：右键管理员安装，勾选add to path，选择customize自定义安装，勾选install for all users，安装到D盘

**PyCharm开发工具**

> - 下载：[官网下载](https://www.jetbrains.com/zh-cn/pycharm/download/?section=windows)
> - 安装：右键管理员安装，打开新项目时，右上角设置当前目录env,勾选 "Inherit global site-packages"（可选，能复用全局已装的包）

## 核心语法

**一、存储与运算**

1.字面量与变量

> - 字面量：写死的数据，即常量。
>   - 整数int,小数float：10，3.14
>   - 字符串str：'wo'
>   - 布尔值：True False。运算时自动转为1和0
>   - 空置：None
> - 变量：变量名=值。a=1。命名规则：字母,数字，下划线，且数字不能开头。多用小写和下划线。[PEP8命名规范](https://peps.python.org/pep-0008/)

2.数据类型

> - 5种基础类型：int，float，str，bool，NoneType
> - 判断数据类型
>   - type：type(a) --><class 'int'>
>   - isinstance：isinstance(a,float) 返回True或False

3.字符串

> - 字符串3种定义：单引号，双引号，三引号。a="""支持多行且换行"""
> - 常见4种转义字符： \ ' 表示单引号,\ "表示双引号,\n表示换行符,\t表示制表符tab。比如a='it\ 's good'。
> - str：转成字符串类型，str(a)
> - 字符串拼接
>   - +加号：s3 = s1 + str(s2)。拼接需要注意类型转换。
>   - 占位符%s：s3 = '今天是%s的%s岁生日'  % (s1,s2)。后面的按照顺序替换前面的占位符，类型会自动转换。

**二、逻辑处理**

**三、存储容器**

**四、函数**

**五、面向对象基础**

## AI应用

## 网络爬虫

## 数据分析

## Web应用
