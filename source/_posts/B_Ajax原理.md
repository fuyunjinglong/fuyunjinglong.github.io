---
title: B_Ajax原理
date: 2022-05-04 07:33:16
categories:
- B_H5CSSJSES基础
toc: true # 是否启用内容索引
---

# 1.Ajax是什么

AJAX即“Asynchronous Javascript And XML”，是指一种创建交互式网页应用的网页开发技术。AJAX 是一种用于创建快速动态网页的技术。

# 2.Ajax原理

其中最核心的依赖是浏览器提供的XMLHttpRequest对象。

## 创建XMLHttpRequest

```
	1. var xhr=null;  
	2. if (window.XMLHttpRequest)  
	3.   {// 兼容 IE7+, Firefox, Chrome, Opera, Safari  
	4.   xhr=new XMLHttpRequest();  
	5.   } else{// 兼容 IE6, IE5 
	6.     xhr=new ActiveXObject("Microsoft.XMLHTTP");  
	7.   } 

```

## 向服务器发送请求

```
    1. xhr.open(method,url,async);  
    2. send(string);//post请求时才使用字符串参数，否则不用带参数。
```

- method：请求的类型；GET 或 POST
- url：文件在服务器上的位置
- async：true（异步）或 false（同步） **注意：post请求一定要设置请求头的格式内容**

```
xhr.open("POST","test.html",true);  
xhr.setRequestHeader("Content-type","application/x-www-form-urlencoded");  
xhr.send("fname=Henry&lname=Ford");  //post请求参数放在send里面，即请求体
```

## 服务器响应处理

返回数据类型：

- responseText 获得字符串形式的响应数据。
- responseXML 获得XML 形式的响应数据。

**同步处理**

```
	1. xhr.open("GET","info.txt",false);  
	2. xhr.send();  
	3. document.getElementById("myDiv").innerHTML=xhr.responseText; //获取数据直接显示在页面上
```

**异步处理**

在请求状态改变事件中处理

```
	1. xhr.onreadystatechange=function()  { 
	2.    if (xhr.readyState==4 &&xhr.status==200)  { 
	3.       document.getElementById("myDiv").innerHTML=xhr.responseText;  
	4.      }
	5.    } 
```

# 3.什么是readyState？

readyState是XMLHttpRequest对象的一个属性，用来标识当前XMLHttpRequest对象处于什么状态。 readyState总共有5个状态值，分别为0~4。

- 0：未初始化 -- 尚未调用.open()方法；
- 1：启动 -- 已经调用.open()方法，但尚未调用.send()方法；
- 2：发送 -- 已经调用.send()方法，但尚未接收到响应；
- 3：接收 -- 已经接收到部分响应数据；
- 4：完成 -- 已经接收到全部响应数据，而且已经可以在客户端使用了；