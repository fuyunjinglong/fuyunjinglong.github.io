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

**1.字面量与变量**

> - 字面量：写死的数据，即常量。
>   - 整数int,小数float：10，3.14
>   - 字符串str：'wo'
>   - 布尔值：True False。运算时自动转为1和0
>   - 空置：None
> - 变量：变量名=值。a=1。命名规则：字母,数字，下划线，且数字不能开头。多用小写和下划线。[PEP8命名规范](https://peps.python.org/pep-0008/)

**2.数据类型**

> - 5种基础类型：int，float，str，bool，NoneType。
> - 判断数据类型
>   - type：type(a) --><class 'int'>
>   - isinstance：isinstance(a,float) 返回True或False

**3.字符串**

> - 字符串3种定义：单引号，双引号，三引号。a="""支持多行且换行"""
> - 常见4种转义字符： \ ' 表示单引号,\ "表示双引号,\n表示换行符,\t表示制表符tab。比如a='it\ 's good'。
> - str：转成字符串类型，str(a)
> - 字符串拼接
>   - +加号：s3 = s1 + str(s2)。拼接需要注意类型转换。
>   - %s占位符：s3 = '今天是%s的%s岁生日'  % (s1,s2)。后面的按照顺序替换前面的占位符，类型会自动转换。
>   - f格式化：f"我是{s1}"。注意类型转换。

**4.输入/输出**

```
s=input('请输入金额:') # 默认输入都是字符串类型
print(f"结果：{total- float(s)}") # 注意int('0.3')会报错,所以float更好
```

5.运算符

```
# 注意int('0.3')会报错，只能是float('0.3')，要么只能是int('3')
a=0.1;b='0.3';c=a+float(a)
aa=3;bb=3.0
print(aa==bb) # True,数值比较是忽略浮点0

#精度损失问题：计算机底层的二进制无法表示所有小数，所以可能损失精度
a=0.1;b=0.2;c=a+b # 0.30000000000000004

# 比较运算符
==	!=	>=

# 逻辑运算符
and or not
```

**二、逻辑处理**

> debug调试：F8单步执行

```python
# 1.条件判断
# python是识别缩进来语法判断，缩进相同表示同一个代码块。最好是一个tab等于4个空格，也可以任意空格。if嵌套时注意缩进要一致。
a=float(input('请输入数字：'))
b=3
if a>b:
    print('我是')
    print('大于')
elif a<b:
    print('小于')
else:
    print('等于')
print('外部结束')

# 2.模式匹配
match a:
    case 1:
        print('11')
    case 2|3: # 这里竖线表示多个条件都可以匹配，特殊含义的。
        print('22或33')
    case 4|5 if a<5: # if条件成立，才能匹配这个case
        print('44')
    case _:
        print('其他')


# 3.循环
```



**三、存储容器**

**四、函数**

**五、面向对象基础**

## AI应用

## 网络爬虫

## 数据分析

## Web应用
