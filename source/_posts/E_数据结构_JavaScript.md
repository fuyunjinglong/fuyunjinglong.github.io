---
title: JavaScript
date: 2022-05-05 06:33:16
categories:
- E_数据结构
toc: true # 是否启用内容索引

---

# 大纲

- [JS数据结构与算法-video](https://www.bilibili.com/video/BV1yD4y127vy/?spm_id_from=333.999.0.0&vd_source=bd4c7d99d71adf64d6e88c65370e0247)
- 数据结构与算法-千峰教育kript-video
- 数据结构与算法专题课-珠峰-video
- [JavaScript 数据结构与算法之美 - 十大经典排序算法](https://juejin.cn/post/6844903902484103182#heading-0)

# [JS数据结构算法-coderwhy王红元](https://www.bilibili.com/video/BV1yD4y127vy?p=9&vd_source=bd4c7d99d71adf64d6e88c65370e0247)

- [笔记](https://juejin.cn/post/7017349585446125575)

## 字符串

**1.字符串-判断是否为回文**

```
// 方法1，允许使用reverse
function isPalindromicStr(str) {  
    return str == str.split('').reverse().join('');
}

// 方法12，不允许使用reverse
function isPalindromicStr(str){
    if(!str.length){
        return true
    }
    str = str.toLowerCase().split('');
    let start =0;
    let end = str.length-1;
    while(start<end){
        if(str[start]===str[end]){
            start++;
            end--;
        }else{
            return false
        }
    }
    return true
}
```

**2.字符串-去重**

```
<html>
<script >
// 借助json实现    
function removeDuplicateChar(str){
    let result =[];
    let json ={}
    for(let i =0;i<str.length;i++){
        let char = str[i]
        if(!json[char]){
            result.push(char);
            json[char] = true
        }
    }
    return result.join('');
}
// 借助filter实现
function removeDuplicateChar1(str){
   let result = Array.prototype.filter.call(str,function(char,index,arr){
       return arr.indexOf(char) === index;
    })
    return result.join('');
}
// set实现
function removeDuplicateChar2(str){
    let set = new Set(str.split(''));
    return [...set].join('')
}
alert(removeDuplicateChar2('abac'))
 </script>
</html>
```

**3.输出字符串中次数最多的字符和次数**

```
function findMostFrequentChar(str) {
  if (typeof str !== 'string') {
    return '输入必须是字符串。';
  }
  if (str.length === 0) {
    return '字符串不能为空！';
  }
  const occurrenceMap = new Map();
  for (const char of str) {
    occurrenceMap.set(char, (occurrenceMap.get(char) || 0) + 1);
  }
  let maxChar = { char: '', occur: -Infinity };
  for (const [char, occur] of occurrenceMap) {
    if (occur > maxChar.occur) {
      maxChar = { char, occur };
    }
  }
  return `出现次数最多的字符是 "${maxChar.char}"，出现次数为 ${maxChar.occur} 次。`;
}

console.log(findMostFrequentChar("Hello")); // 输出：出现次数最多的字符是 "l"，出现次数为 2 次。
```

**4.字符串逆序输出**

```
<html>
<script >
// 方法1:借助数组的reverse
function reverseString(str) {
  return str.split("").reverse().join("");
}
// 方法2：借助字符串的charAt()
function reverseString2(str) {
  let res = '';
  for(let i =str.length-1;i>=0;i--){
  	res += str.charAt(i);
  }
  return res;
}
// 方法3：借助递归
function reverseString3(str,pos,res) {
    // str原始字符串，pos字符串的最后一个索引值，res返回值
  if(pos <0){
    return res;
  }
  res += str.charAt(pos);
  pos--;
  return reverseString3(str,pos,res)
}
// 方法4：借助slice将字符串转为数组
function reverseString4(str) {
    let arr = Array.prototype.slice.call(str);
    return arr.reverse().join("");
}
alert(reverseString4('abcd'))
 </script>
</html>
```



## 数组

**1.一维数组转为二维数组**

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

**2.数组扁平化**

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

**3.树转扁平数组**

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

**4.扁平数组转树**

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

## 栈

**1.实现栈有两种常用方式**

- 数组
- 链表

数组实现

```html
<html>
    <head>
    </head>
<body>
    <h1>栈</h1>
</body>
<script >
function Stack(){
    this.item =[]
    // 这种写法会在所有实例对象中添加函数，不推荐
    this.push = function(el){
        this.item.push(el)
    }
    // 这种写法只在原型上添加函数，节省内存，推荐
    Stack.prototype.push=function(el){
        this.item.push(el)
    }
    Stack.prototype.pop=function(el){
       return this.item.pop()
    }
    Stack.prototype.peek=function(el){
       return  this.item[this.item.length-1]
    }
    Stack.prototype.isEmpty=function(el){
       return  this.item.length===0
    }
    Stack.prototype.size=function(el){
       return this.item.length
    }
    Stack.prototype.toString=function(el){
       return this.item.reduce((pre,cur)=>pre+cur+'','')
    }
}

let a = new Stack()
a.push(1)
a.push(2)
console.log(a.toString())
 </script>
</html>
```

**2.栈的作用**

- js中基本数据类型存储栈内存中

- js执行时有执行栈,事件循环中将以次执行执行栈中的回调

**3.栈的应用**

**3.1用栈实现十进制转二进制**

```html
<html>
<script >
function dec2bin(decNumber){
    // 定义栈对象,Stack是前文声明的对象
    let stack = new Stack();
    // 循环操作
    while(decNumber>0){
        // 获取余数，入栈(算法：第一次的余数对应二进制的第一位)
        stack.push(decNumber%2);
        // 向下取整，继续循环
        decNumber = Math.floor(decNumber/2);
    }
    let res='';
    while(!stack.isEmpty()){
        res+=stack.pop()
    }
    return res
}
alert(dec2bin(2))
 </script>
</html>
```

## 链表

## 队列

**1.实现队列方式：**

- 数组-简单但效率低
- 链表-复杂但效率高

数组实现

```
<html>
<script >
function Queue(){
    this.item =[]
    // 入队，这种写法只在原型上添加函数，节省内存，推荐
    Queue.prototype.enqueue=function(el){
        this.item.push(el)
    }
    // 出队
    Queue.prototype.dequeue=function(el){
       return this.item.shift()
    }
    // 查看队列头部元素
    Queue.prototype.font=function(el){
       return  this.item[0]
    }
    Queue.prototype.isEmpty=function(el){
       return  this.item.length===0
    }
    Queue.prototype.size=function(el){
       return this.item.length
    }
    Queue.prototype.toString=function(el){
       return this.item.reduce((pre,cur)=>pre+cur+'','')
    }
}

let queue = new Queue()
queue.enqueue(1)
queue.enqueue(2)
alert(queue.toString())
 </script>
</html>
```

**2.队列的作用**

- 所有先进先出的场景
- 打印队列、线程队列等
- js 异步中的任务队列 一个leetcode题 第933题

**3.队列的应用**

**3.1击鼓传花升级版**

```
<html>
<script >
// 击鼓传花的升级版：每数到第n个人就淘汰，循环往复，最后剩下的人就是冠军
function passGame(arr,n){
    let queue = new Queue();
    arr.forEach(a => {
        queue.enqueue(a)
    });
    while(queue.size()>1){
        for(let i=0;i<n-1;i++){
        // 轮询到不是第n个人，直接先出队再入队
        queue.enqueue(queue.dequeue())
    }
    // 第n个人出队淘汰
    queue.dequeue()
    }
    alert('最后的冠军是：'+queue.font())
}
passGame(['lw','mm','aj'],2)
 </script>
</html>
```

## 优先级队列

**1.什么是优先级队列**

定义：它会自动根据元素的优先级将其插入到合适的位置。当你从 PriorityQueue 中删除一个元素时，它会自动将优先级最高的元素出队。

**2.优先级队列的应用**

- **数据压缩**：赫夫曼编码算法；
- **最短路径算法**：Dijkstra 算法；
- **最小生成树算法**：Prim 算法；
- **任务调度器**：根据优先级执行系统任务；
- **事件驱动仿真**：顾客排队算法；
- **排序问题**：查找第 k 个最小元素。

**3.实现优先级队列**

三种方案实现优先级队列：

- **数组（顺序存储）实现优先队列**：入队操作直接插入到数组队尾，时间复杂度为 *O*(1)。出队操作需要遍历整个数组，找到优先级最高的元素，返回并删除该元素，时间复杂度为 O*(*n)。
- **链表（链式存储）实现优先队列**：链表中的元素按照优先级排序，入队操作需要为待插入元素创建节点，并在链表中找到合适的插入位置，时间复杂度为 O*(*n)。出队操作直接返回链表队头元素，并删除队头元素，时间复杂度为 O(1)。
- **二叉堆结构实现优先队列**：构建一个二叉堆结构，二叉堆按照优先级进行排序。入队操作就是将元素插入到二叉堆中合适位置，时间复杂度为 (log⁡2)*O*(log2*n*)。出队操作则返回二叉堆中优先级最大节点并删除，时间复杂度也是 O*(log*n*)。

**3.1数组实现优先级队列**

```
// MinPriorityQueue Implementation
class PriorityQueue {
  constructor() {
    this.values = [];
  }

  enqueue(node, priority) {
    var flag = false;
    for (let i = 0; i < this.values.length; i++) {
      if (this.values[i].priority > priority) {
        this.values.splice(i, 0, { node, priority });
        flag = true;
        break;
      }
    }
    if (!flag) {
      this.values.push({ node, priority });
    }
  }

  dequeue() {
    return this.values.shift();
  }

  size() {
    return this.values.length;
  }
}

// Example Usage
var a = new PriorityQueue();
a.enqueue(10, 1);
a.enqueue(1, 0);
a.enqueue(8, 2);
```

## 链表

**1.链表特点**

- 每个元素（通常称为节点）包含两个部分：存储的数据和指向下一个节点的链接
- 不必连续空间

与数组的比较：

- 内存不必连续，充分利用内存，内存动态管理
- 必须不必确定大小，大小可无限延伸
- 插入和删除数据，可达到O(1),效率高

**2.实现链表常见操作**

![image](/img/2024-04-24_07-07-15.png)

```html
<html>
<script >
function LinkList(){
  // 内部类
  function Node(data){
    this.data =data;
    this.next = null
  }
  // 属性
  this.head = null;
  this.length = 0;
  // 添加节点
  LinkList.prototype.append=function(data){
    let node = new Node(data);
    if(this.length === 0){
      this.head = node;
    }else{
      // 遍历，找到链表的最后一个节点
      let curNode = this.head;
      while(curNode.next){
        curNode = curNode.next
      }
      curNode.next = node;
    }
    this.length+=1;
  }
    // 打印
    LinkList.prototype.toString=function(data){
      let curNode = this.head;
      let str='';
      while(curNode){
        str += ','+curNode.data;
        curNode = curNode.next;
      }
      return str.slice(1);// 把第一个逗号去掉
    }
    // 指定位置插入元素
    LinkList.prototype.insert=function(position,data){
      if(position<0||position>this.length){
        return false;
      }
      let node = new Node(data);
      if(position === 0){
        // 插入的是第一个元素：换头，先换后再换前
        node.next = this.head;
        this.head = node;
      }else{
        // 中间插入
        let index =0;
        let curNode = this.head;
        let preNode = null;
        while(index++<position){
          preNode = curNode;
          curNode = curNode.next;
        }
        node.next = curNode;
        preNode.next = node;

      }
      this.length+=1;
      return true;
    }    
    // 获取第i个元素
    LinkList.prototype.get=function(position){
        // 越界判断
        if(position<0||position>=this.length) return null;
        let index =0;
        let curNode = this.head;
        while(index++<position){
            curNode=curNode.next;
        }
        return curNode.data;
    }
    // 获取元素位置
    LinkList.prototype.indexOf=function(data){
        let index =0;
        let curNode = this.head;
        // 开始查找
        while(curNode){
            // 找到即返回索引值
            if(curNode.data===data){
                return index;
            }
            curNode=curNode.next;
            index++;
        }
        // 找到了最后
        return -1;
    }
    // 更新元素
    LinkList.prototype.update=function(position,data){
         // 越界判断
         if(position<0||position>=this.length) return false;
        let index =0;
        let curNode = this.head;
        while(index++<position){
            curNode=curNode.next;
        }
        curNode.data = data;
        return true
    }
        // 从指定位置删除元素，类似插入元素
    LinkList.prototype.removeAt=function(position){
         // 越界判断
         if(position<0||position>=this.length) return false;
          if(position === 0){
          // 删除的是第一个元素：换头，先换后再换前
            this.head = this.head.next
          }else{
            // 中间删除
            let index =0;
            let curNode = this.head;
            let preNode = null;
            while(index++<position){
              // 循环查找
              preNode = curNode;
              curNode = curNode.next;
            }
            // 前一个节点的next,指向当前节点的next
            preNode.next = curNode.next;
            }
            this.length--;
          }

           // 删除元素
     LinkList.prototype.removeAt=function(data){
          const index = this.indexOf(data);
          return this.removeAt(index)
        }
          // 是否为空
     LinkList.prototype.isEmpty=function(){
          return this.length===0;
        }
            // 链表大小
     LinkList.prototype.size=function(){
          return this.length;
        }

}
let linkList = new LinkList();
linkList.append('abc');
linkList.append('edf');
// linkList.insert(0,'123')
// linkList.removeAt(0)
alert(linkList.size())
 </script>
</html>
```

## 双向链表

**1.链表特点**

**2.实现双向链表常见操作**

![image](/img/2024-04-27_10-54-06.png)

# 初级算法

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