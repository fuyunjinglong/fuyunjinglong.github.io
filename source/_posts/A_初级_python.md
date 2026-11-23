---
title: python
date: 2018-01-02 08:33:16
categories:
- A_初级
toc: true # 是否启用内容索引
---

# 黑马python教程

**参考**-53

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
>   - 整数int,小数float：10，3.14。f"{a:0.1f}"保留一位小数
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

**5.运算符**

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

> - debug调试：F8单步执行
> - range语句：生成自然数数列，且不包括end本身
>   - range(end)：从0开始的自然数数列，range(5)是0，1，2，3，4
>   - range(start,end)：range(1,3)是1，2
>   - range(start,end,step)：range(1,8,2)是1,3,5,7
> - break：跳出所有循环，else中的代码不会执行。
> - continue：跳出当次循环
> - random随机数：import random; random_num = random.randint(1,100)

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
while a<3:
    print('循环1')
    print('循环2')
    a+=1
else:# 可选
    print('循环结束')
    
for s in a:
    print(s)
else:# 可选
    print('循环结束',end='')# 默认end是\n即换行符，如果想不换行，则设置为空
    print('循环结束')
```

**三、数据容器**

> - 列表（list）：重复，有序，可修改 s=['A','B','C','D','E']
>
>   - 修改：s[1]='X'
>   - 删除：del s[3]
>   - 切片：s[startX:endX:stepX]，比如s[0:3:2]  得到['A', 'C']。s[:3]可以省略后面的引号
>   - 添加到最后：s.append('F') 
>     索引2前添加：s.insert(2,'A') 
>     移除第一个匹配值：s.remove('A') 
>     移除索引处的值：s.pop()/s.pop(0)
>     排序或反转：s.sort()/s.reverse()
>   - 判断元素是否存在列表中：a in s  或 a not in s
>   - 合并列表：通过解包和组包方式实现，s3=[\*s1,\*s2]
>   - 列表推导式：按照一定规则生成列表，if语法式可选，[插入的值 for语法 if语法]。比如：s=[[i*2 for i in range(1,5) if i>2]
>   - 组包：t=[1,2,3,4]
>   - 解包：[a,b,c,d] = t。扩展解包:a,*b = t，则a为1，b为[2,3,4]列表list
>   - 值交换：[c,b,a ]=[a,b,c] ，利用组装和解包语法
>   - 嵌套元组：t=((1,2),(3,4))
>
> - 字符串（str）：不可变，有序，可迭代
>
>   - 不能改值，顺序的，for a in s
>
>   - 切片：同list
>
>   - 查找子串索引：s.find('aa')
>
>     统计字串出现次数：s.count('aa')
>
>     转换大小写：s.upper(),s.lower()
>
>     按分隔符分割成列表：s.split('+')
>
>     去除前后空格或指定字符：s.strip()，s.strip('#')
>
>     替换子串：s.replace('aa','bb')
>
>     检查是否子串开头或结尾：s.startwith('aa')，s.endswith('aa')
>
> - 元组（tuple）：重复，有序，不可修改。除了不可修改，其他均与list一致。
>
>   - 定义：t=(1,2,3)，也可以t=1,2,3
>   - 访问：t[0]
>   - 查找子元素索引：t.index(2)
>   - 统计元素出现次数：t.count(1)
>
> - 集合（set）：无序，不可重复，可修改
>
>   - 定义：s={'a','b'}或s=set()。不能用s={}定义空set。
>
>   - 新增：s.add('c')
>
>     删除：s.remove('A') 
>
>     随机删除：s.pop()
>
>     清空：s.clear()
>
>     差集：s1.difference(s2) 或 s1-s2
>
>     并集：s1.union(s2) 或 s1|s2
>
>     交集：s1.intersection(s2) 或 s1& s2
>
> - 字典（dict）：键值对
>
>   - 定义：d={'tom':5,'jerry':10}
>
>   - 访问：d['tom']
>
>   - 新增：d['xx'] = 1
>
>     删除：d.pop('tom')或del d['tom']
>
>     修改：d['tom'] = 2
>
>     查询-key：d.keys()
>
>     查询-value：d.values(),d['tom'],d.get('tom')
>
>     查询-键值对：d.items()
>
>   

**四、函数**

**五、面向对象基础**

## AI应用

## 网络爬虫

## 数据分析

## Web应用
