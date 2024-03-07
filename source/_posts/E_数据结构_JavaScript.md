---
title: JavaScript
date: 2022-05-05 06:33:16
categories:
- E_数据结构
toc: true # 是否启用内容索引

---

# 大纲

- [JavaScript 数据结构与算法之美 - 十大经典排序算法](https://juejin.cn/post/6844903902484103182#heading-0)

# 初级算法

## 一维数组转为二维数组

```
function convertTo2DArray(arr, chunkSize) {
      var result = [];
      for (var i = 0; i < arr.length; i += chunkSize) {
        result.push(arr.slice(i, i + chunkSize));
      }
      return result;
}
 var inputArray = [1, 2, 3, 4, 5, 6, 7, 8, 9];
 // [[1, 2, 3], [4, 5, 6], [7, 8, 9]]
 var outputArray = convertTo2DArray(inputArray, 3);
```

## 数组扁平化

```
['a','b','c'] //这是一个拥有3个元素的数组，是一个一维数组（不存在数组嵌套）。`
 `[['a','b'],['c','d'],['e','f']] 从整体上看是一个数组，但是其中的元素又是数组，即数组中嵌套数组，这就是二维数组
```

以此类推·····
 `['a',['b',['c']]]//3维数组`
 `['a',['b',['c',[.....]]]]//n维数组`
 数组扁平化就是把多维数组转化成一维数组

- es6提供的新方法 flat(depth)
- reduce方法
- 利用扩展运算符
- split和toString共同处理
- 正则和 JSON方法共同处理
- for循环
- while循环

**es6提供的新方法 flat(depth)**

无需知道数组的维度，直接将目标数组变成1维数组。 depth的值设置为Infinity。

```
let a = [1,[2,3,[4,[5]]]];  
a.flat(Infinity); // [1,2,3,4,5]  a是4维数组
```

**reduce方法**

第一个参数就是就是处理扁平化的箭头函数
第二个参数是一个空数组，也是作为遍历的开始

```
 var arr1 = [1, 2, [3], [1, 2, 3, [4, [2, 3, 4]]]];
 function flatten(arr) {
      return arr.reduce((res,next) =>{
        return res.concat(Array.isArray(next)? flatten(next) : next);
      },[]);
    }
```

**利用扩展运算符**

```
function flatten(arr) {
    //  只要arr数组中还存在数组元素，循环就继续进行
    while (arr.some(item => Array.isArray(item))) {
        // 展开数组，拼接空数组
        arr = [].concat(...arr)
    }
    return arr
}
```

**split和toString共同处理**

```
function flatten(arr) {
    // toString()方法把数组转换为1,2,3,4,5
    return arr.toString().split(",")
}
```

**正则和 JSON方法共同处理**

```
function flatten(arr) {
  let str = JSON.stringify(arr);
  // 过滤所有的中中括号
  str = str.replace(/(\[|\])/g, '');
  str = '[' + str + ']';
  return JSON.parse(str); 
}
```

**for循环**

```
var arr1 = [1, 2, 3, [1, 2, 3, 4, [2, 3, 4]]];
  function flatten(arr) {
    var res = [];
    for (let i = 0, length = arr.length; i < length; i++) {
      if (Array.isArray(arr[i])) {
        res = res.concat(flatten(arr[i])); //concat 并不会改变原数组
      //res.push(...flatten(arr[i])); //扩展运算符  
      } else {
        res.push(arr[i]);
      }
    }
    return res;
  }
  flatten(arr1); //[1, 2, 3, 1, 2, 3, 4, 2, 3, 4]
```

**while循环**

```
 var arr1 = [1, 2, [3], [1, 2, 3, [4, [2, 3, 4]]]];
 function flatten(arr) {
      while (arr.some(item => Array.isArray(item))) {
        arr = [].concat(...arr);
        //arr = Array.prototype.concat.apply([],arr);
      }
      return arr;
    }
    flatten(arr1); //[1, 2, 3, 1, 2, 3, 4, 2, 3, 4]
```



## 树转扁平数组

```
var data = [{
  name: 'a',
  id: 101,
  children: [{
    name: 'bb',
    id: 101101,
    children: []
   },
   {
    name: 'bb',
    id: 101102,
    children: [{
     name: '101102101',
     id: 101102101,
     children: []
    }]
   }
  ]
 }];
// 递归调用
var idArr = []
function getId(treeData, arr) {
  data.forEach(ele => {
   idArr.push(ele.id)
   // 判断有子元素,并且子元素的长度大于0就再次调用自身
   if (ele.children && ele.children.length > 0) {
    getId(ele.children, arr)
   }
  })
 }
getId(data, idArr)
```



## 扁平数组转树

```
let arr = [
    {id: 1, name: '部门1', pid: 0},
    {id: 2, name: '部门2', pid: 1},
    {id: 3, name: '部门3', pid: 1},
    {id: 4, name: '部门4', pid: 3},
    {id: 5, name: '部门5', pid: 4},
]
/**
 * 0.不考虑性能实现，递归遍历查找
 */
 const getChildren0 = (data, result, pid) => {
  for (const item of data) {
    if (item.pid === pid) {
      const newItem = {...item, children: []};
      result.push(newItem);
      getChildren0(data, newItem.children, item.id);
    }
  }
}

/**
 * 1.不用递归，也能搞定
 * 主要思路是先把数据转成Map去存储，之后遍历的同时借助对象的引用，直接从Map找对应的数据做存储
 */
const getChildren1 = (items)=>{
    const result = [];   // 存放结果集
  const itemMap = {};  //   
  // 先转成map存储
  for (const item of items) {
    itemMap[item.id] = {...item, children: []}
  }
  
  for (const item of items) {
    const id = item.id;
    const pid = item.pid;
    const treeItem =  itemMap[id];
    if (pid === 0) {
      result.push(treeItem);
    } else {
      if (!itemMap[pid]) {
        itemMap[pid] = {
          children: [],
        }
      }
      itemMap[pid].children.push(treeItem)
    }
  }
  return result;
}

/**
 * 2.最优性能
 * 主要思路也是先把数据转成Map去存储，之后遍历的同时借助对象的引用，直接从Map找对应的数据做存储。
 * 不同点在遍历的时候即做Map存储,有找对应关系。性能会更好。
 */
 const getChildren2 = (items)=>{
    const result = [];   // 存放结果集
  const itemMap = {};  // 
  for (const item of items) {
    const id = item.id;
    const pid = item.pid;

    if (!itemMap[id]) {
      itemMap[id] = {
        children: [],
      }
    }

    itemMap[id] = {
      ...item,
      children: itemMap[id]['children']
    }

    const treeItem =  itemMap[id];

    if (pid === 0) {
      result.push(treeItem);
    } else {
      if (!itemMap[pid]) {
        itemMap[pid] = {
          children: [],
        }
      }
      itemMap[pid].children.push(treeItem)
    }

  }
  return result;
}
const arrayToTree = (data, pid) => {
  let result = [];
//  getChildren0(data, result, pid)
    // result = getChildren1(data)
    result = getChildren2(data)
  return result;
}
```

## 两个变量交换

- 临时变量
- 一次加，两次减
- 复用对象
- 利用数组
- 一行代码
- ES6 的解构赋值

```
// 临时变量
var t; 
t = a; 
a = b; 
b = t;
// 一次加，两次减
a = a + b; 
b = a - b; 
a = a - b;
// 复用对象
a = { a: b, b: a }; 
b = a.b; 
a = a.a;
// 利用数组
a = [a, b]; 
b = a[0]; 
a = a[1];
// 一行代码
a = [b, b = a][0];
// ES6 的解构赋值
[a,b]=[b,a]
```

##  js 实现斐波那契数列

定义：F(1)=1, F(2)=1, F(n)=F(n-1)+F(n-2)

解法：

> - 解法1：递归
> - 解法2：动态规划

解法1：递归

```
function f(n) {
  if (n === 1 || n === 2){
    return 1;
  } else {
    return f(n-1) + f(n-2);
  }
}
```

解法2：动态规划

```
function f(n) {
    let n1 = 1,
        n2 = 1,
        sum = 1;
    for(let i = 3; i <= n; i += 1) {
        sum = n1 + n2;
        n1 = n2;    // 往后移动一位数
        n2 = sum
    }
    return sum
}
```

## 随机生成指定长度的字符串

解法：可以手动指定字符库及随机字符长度 n，利用 Math.floor() 和 Math.random() 两个方法实现获取随机字符。

```
function randomString(n) {  
  let str = 'abcdefghijklmnopqrstuvwxyz9876543210';
  let tmp = '',i = 0,l = str.length;
  for (i = 0; i < n; i++) {
    tmp += str.charAt(Math.floor(Math.random() * l));
  }
  return tmp;
}
```

## 判断是否为回文

```
function checkPalindrom(str) {  
    return str == str.split('').reverse().join('');
}
```

## 数组去重

- ES6 的 Set 
- 扩展运算符（…）
- 对象数组方法去重

ES6 的 Set 

```
function dedupe(array) { 
  return Array.from(new Set(array)); 
} 
```

扩展运算符（…）

```
let arr = [1, 2, 3, 3];
let unique = [...new Set(arr)];
```

对象数组方法去重

```
function sort(arr){
    let obj = {};
    let newArr = [];
    for(let i = 0; i < arr.length; i++){
        if(!obj[arr[i]]){
            obj[arr[i]] = 1;
            newArr.push(arr[i]);
        }
    }
    return newArr;
}
```