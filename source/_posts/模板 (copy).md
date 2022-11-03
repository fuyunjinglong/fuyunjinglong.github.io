# JS闭包

## 闭包是什么？

首先要理解全局变量和局部变量，函数内部可以读取全局变量，但函数外部无法读取函数内部局部变量。

闭包就是能够读取其他函数内部变量的函数。确定吗？

```js
function funOne(){    // 外部函数
    var num = 0;      // 局部变量
    function funTwo(){   // 内部函数
        num++; 
        console.log(num);           
    }
     funTwo();
}
执行funOne();//不是闭包

function funOne(){    // 外部函数
    var num = 0;      // 局部变量
    num++; 
    return num
}
var fun = funOne();
执行fun;//不是闭包
```

真正的闭包：闭包是将函数内部和函数外部连接的桥梁。

本质：funOne()的执行结果赋给了全局变量fun,导致的结果是funTwo和num始终在内存中没有回收。

```js
function funOne(){    // 外部函数
    var num = 0;      // 局部变量
    function funTwo(){   // 内部函数
        num++; 
        console.log('打印：'+num);           
        return num;//对于闭包来说，可有可无
    }
    return funTwo;
}
// funOne()的执行结果是闭包
var fun = funOne();
fun()

简化写法：
function funOne(){    // 外部函数
    var num = 0;      // 局部变量
    return function (){   // 内部函数
        num++; 
        console.log('打印：'+num);           
        return num;//对于闭包来说，可有可无
    }
}
var fun = funOne();
fun()
```

**闭包拥有自己独立的作用域**

```js
var fun = funOne();
var fun2 = funOne();
fun() // 1
fun() // 2
fun() // 3
fun2() // 1
fun2() // 2
```

## 为什么需要闭包

局部变量无法共享和长久保存，而全局变量可能造成变量污染，当我们希望有一种机制既可以长久保存变量，又不会造成全局污染，所有有了闭包。

## 利用闭包封装原生XMLHttpRequest请求

原始代码

```js
function sendData(mobile, password) {
      const xmlHttp = new XMLHttpRequest();
      xmlHttp.open('post', '//localhost:3333/form');
      xmlHttp.setRequestHeader('Content-Type', 'application/json');
      xmlHttp.send(JSON.stringify({ mobile, password }));
      xmlHttp.onreadystatechange = function () {
        if (xmlHttp.readyState === 4 && xmlHttp.status === 200) {
          alert(xmlHttp.responseText);
        }
      };
    },
```

闭包封装改造

```js
http() {
      // 对sendData简单封装
      const xmlHttp = new XMLHttpRequest();
      return {
        // 返回对象是方便后续扩展
        request: (method, url, data, success, error) => {
          xmlHttp.open(method, url);
          if (method === 'get') {
            xmlHttp.send();
          } else {
            xmlHttp.setRequestHeader('Content-Type', 'application/json');
            xmlHttp.send(data);
          }
          xmlHttp.onreadystatechange = function () {
            if (xmlHttp.readyState === 4 && xmlHttp.status === 200) {
              // 成功的回调函数
              success(xmlHttp.responseText);
            } else {
              // 失败的回调函数
              error();
            }
          };
        }
      };
    },
    
调用
const http_ = http;
const method = 'post';
const url = '//localhost:3333/form';
const data = JSON.stringify({ mobile: 1, password: 1 });
const success = res => {};
const error = () => {};
http_.request(method, url, data, success, error);
```

再看个例子

```js
var foo = ( function() {
    var secret = 'secret';
    // “闭包”内的函数可以访问 secret 变量，而 secret 变量对于外部却是隐藏的
    return {
        get_secret: function () {
            // 通过定义的接口来访问 secret
            return secret;
        },
        new_secret: function ( new_secret ) {
            // 通过定义的接口来修改 secret
            secret = new_secret;
        }
    };
} () );

foo.get_secret (); // 得到 'secret'
foo.secret; // Type error，访问不能
foo.new_secret ('a new secret'); // 通过函数接口，我们访问并修改了 secret 变量
foo.get_secret (); // 得到 'a new secret'
```



# Github仓库整理

1、software-template

整理为前后台代码仓，代码仓software-template，分支vue2-web,vue3-web,springboot-server

2.tem-xxx

3.fuyunjinglong.github.io

vuepress的一级目录，hexo子目录，vitePress子目录

# 划词翻译服务

百度

20221020001403389密GZ5jMi1SC9Tek7bMA4md

彩云

lax3hdplm6mnvnxkw17w

阿里

LTAI5tMHUUxWUcHvwTcWXFXE密L8GJS9zpIkLKY4FyoubjoOra5kL0l5

# leetcode基础班

[基础班视频](https://www.bilibili.com/video/BV1Zr4y1W7ww?p=37&spm_id_from=pageDriver&vd_source=bd4c7d99d71adf64d6e88c65370e0247)

[代码仓库](https://github.com/fuyunjinglong/algorith-systematiclearning)

基础班和进阶班：绝对的技术干活。

体系学习班和大厂刷题班：比前者多一些新题型而已。

## 位运算符

**题目：打印int类型数据的32位信息**

```java
public static void code_print(int num){
        // 打印int类型数据的32位信息
        for(int i = 31; i >=0;i--){
         // 1左移31位，即1000000...0可以取出第31位信息
         // <<带符号左移，<<<不带符号左移
            System.out.print((num&(1<<i))==0?0:1);
        }
    }
```

**原码，反码，补码**

- 原码：是最简单的机器数表示法，用最高位表示符号位，其他位存放该数的二进制的绝对值。

- 反码：正数的反码还是等于原码；负数的反码就是它的原码除符号位外，按位取反。

- 补码：正数的补码等于它的原码；负数的补码等于反码+1

**int类型的无符号和有符号数的数**

- 无符号：0---2的32次方即共有2的32次方个数
- 有符号：-2的31次方---2的31次方-1即共有2的32次方个数，相当于把无符号中的一半分给了负数。

```java
// 最小值，10000000000000000000000000000000
int a = Integer.MIN_VALUE;
// 最大值，01111111111111111111111111111111
int a = Integer.MAX_VALUE;
//一个数的相反数
int c = -a或 ~a+1即取反加1
```

**对于有符号的二进制转十进制**

- 非负数：最高位为0，不看最高位，其他位正常转十进制
- 负数：最高位为，不看最高位，其他位取反+1，再转十进制

多一句：为什么这么设计？方便底层对+2,-2统一做一套加减乘除的底层运算逻辑，提高计算机的运算性能。

## 算法

**第一句话：分析算法复杂度，必须对算法流程足够清楚才能大致推算出来**

**算法不挑语言，因为算法很少用到语言的特性，只要会伪代码就行。其次，你在JS中也能找到Java对应的数据结构，增加实际codeing能力。**

生活的意思不是一出生就会，是吃过苦会有的。算法也是，练过了，思维自然就有了。

- 有具体的问题-问题
- 有设计解决这个问题的具体流程-程序
- 有评价处理流程的可量化指标-复杂度

**分类**

- 明确知道怎么算的流程，如加减乘除
- 明确知道怎么尝试的流程，如质数。所以图灵是计算机算法的祖师爷。图灵在二战利用无数分支尝试破解德军密码。

## N的阶层和

题目：给定一个参数N,返回1!+2!+3!...N!的结果

解法二明显优于解法一。

解法一：先计算当前阶层值，然后求和

```java
//两层for循环
public static long code_f1(int num){
     int ans = 0;
     for(int i=1;i<=num;i++){
         ans+=code_factorial(i);
     }
     return ans;
 }
 public static long code_factorial(int N){
     int ans = 1;
     for(int i =1;i<=N;i++){
        ans*=i; 
     }
     return ans;
 }
```

解法二：每一个阶层值可以看成前一个阶层*当前N

```java
//一层for循环
public static long code_f2(int num){
     int ans = 0;//求和
     int cur =1;//cur记录前一个阶层值
     // 一边计算阶层，一边同时求值
     for(int i=1;i<=num;i++){
         cur*=i;
         ans+=cur;
     }
     return ans;
 }
```

## 排序

### **排序算法总结**

**术语说明**

- **稳定**：如果a原本在b前面，而a=b，排序之后a仍然在b的前面；
- **不稳定**：如果a原本在b的前面，而a=b，排序之后a可能会出现在b的后面；
- **内排序**：所有排序操作都在内存中完成；
- **外排序**：由于数据太大，因此把数据放在磁盘中，而排序通过磁盘和内存的数据传输才能进行；
- **时间复杂度：** 一个算法执行所耗费的时间。
- **空间复杂度**：运行完一个程序所需内存的大小。

|          | 时间复杂度 | 空间复杂度 | 稳定性 |
| :------: | :--------: | :--------: | :----: |
| 选择排序 |   O(N^2)   |    O(1)    |   无   |
| 冒泡排序 |   O(N^2)   |    O(1)    |   有   |
| 插入排序 |   O(N^2)   |    O(1)    |   有   |
| 归并排序 | O(N*logN)  |    O(N)    |   有   |
| 随机快排 | O(N*logN)  |  O(logN)   |   无   |
|  堆排序  | O(N*logN)  |    O(1)    |   无   |
|   界限   |    界限    |    界限    |  界限  |
| 计数排序 |    O(N)    |    O(M)    |   有   |
| 基数排序 |    O(N)    |    O(N)    |   有   |



### 通用排序算法代码

```java
/* package codechef; // don't place package name! */

import java.util.*;
import java.lang.*;
import java.io.*;

/* Name of the class has to be "Main" only if the class is public. */
class Codechef
{
 public static void main (String[] args) throws java.lang.Exception
 {
  int [] a = {2,4,3,6,12,8,5,6,7,2,3,9};
  print(a);
  //code_InsertSort1(a);
  print(a);
 }
 
 public static void print(int [] arr){
     for(int i =0;i<arr.length;i++){
         System.out.print(arr[i] + " ");
     }
     System.out.println();
 }
 
 public static void swap(int[]arr,int i,int j){
     // 常规交换
     int tem = arr[i];
     arr[i] = arr[j];
     arr[j] = tem;
 }
}
```

### 选择排序

**关键词：找最小放指定位置**

0~(N-1)上选出最小值放到0位置

1~(N-1)上选出最小值放到1位置

...

```java
public static void swap(int[]arr,int i,int j){
     // 常规交换
     int tem = arr[i];
     arr[i] = arr[j];
     arr[j] = tem;
 }

public static void code_SelectionSort(int [] arr){
 // 选择排序
     if(arr == null||arr.length<2){
         //所有算法优先考虑边界问题
         return;
     }
        //0-N-1,最小值放到0位置
        // 1-N-1，最小值放到1位置
        int N = arr.length;
        for(int i=0;i<N-1;i++){
            // 1.遍历第一层0~(N-1),1~(N-1)
            int minValIndex = i;
            for(int j=i+1;j<N;j++){
                // 2.找最小值
                minValIndex = arr[j]<arr[minValIndex]?j:minValIndex;
            }
            // 3.交换最小值
            swap(arr,i,minValIndex);
        }
 }
```

### 冒泡排序

**关键词：两两比较，交换**

0~(N-1)上，依次比较相邻数，谁大谁往后交换

0~(N-2)上，依次比较相邻数，谁大谁往后交换

...

```java
public static void code_BubbleSort(int [] arr){
 // 冒泡排序
     if(arr == null||arr.length<2){
         //所有算法优先考虑边界问题
         return;
     }
        int N = arr.length;
        for(int end=N-1;end>=0;end--){
            // 1.遍历0-N-1，0-N-2
            for(int j=0;j<end;j++){
                // 2.谁大谁往后排
                if(arr[j]>arr[j+1]){
                  // 3.交换
                swap(arr,j,j+1);
                }
            }
        }
 }
```

### 插入排序

**关键词：扑克牌斗地主，插牌，从右往左插。**

0~1上，从后往前两两相邻比较，谁小谁往前排

0~2上，从后往前两两相邻比较，谁小谁往前排

...

```java
// while版本
 public static void code_InsertSort(int [] arr){
 // 插入排序
     if(arr == null||arr.length<2){
         //所有算法优先考虑边界问题
         return;
     }
        int N = arr.length;
        for(int end=1;end<N;end++){
            // 1.遍历0-1，0-2...
            int pre = end;
            // 2.索引值不越界且左边小于后边相邻的，才停止。否则，一直交换下去，保证左边小右边大
            while(pre-1>=0&&arr[pre-1]>arr[pre]){
                swap(arr,pre-1,pre);
                pre--;
            }
        }
 }
 
// for优化版本
 public static void code_InsertSort1(int [] arr){
     if(arr == null||arr.length<2){
         //所有算法优先考虑边界问题
         return;
     }
        int N = arr.length;
        for(int end=1;end<N;end++){
            // 1.遍历0-1，0-2...
            // 2.索引值不越界且左边小于后边相邻的，才停止。否则，一直交换下去，保证左边小右边大
            for(int pre = end;pre-1>=0&&arr[pre-1]>arr[pre];pre--){
                swap(arr,pre-1,pre);
            }
        }
 }
```

## 什么是数据结构

就是2种结构：

- 连续结构：连续空间(数组)，寻址容易，增删难
- 跳转结构：不连续，指针跳转，增删容易，寻址难

## 数组范围和

**关键词：利用前缀和，两者相减即为范围和**

**题目：求arr的2-3的范围和，如3+6=9**

```
public static void main (String[] args) throws java.lang.Exception
 {
  int [] a = {2,4,3,6,12,8,5,6,7,2,3,9};
  int b = rangeNum(a,2,4,getHelp(a));
  System.out.println(b);
 }
 
 public static int[] getHelp(int[]  arr){
     // 利用前缀和数组辅助，差值就是范围和
     int N = arr.length;
     int [] help=new int[N];
     help[0]=arr[0];
     for(int i =1;i<N;i++){
         help[i]=help[i-1]+arr[i];
     }
     return help;
 }
 
 public static int rangeNum(int[] arr,int L,int R,int[] help){
     //求数组任意范围的和,如求arr的3-7范围和等于help[7]-help[2]
     // 注意边界0
     return L==0?help[R]:help[R]-help[L-1];
 }
```

## 随机数难倒英雄汉

**Math.random()等概率返回值**

```
/* package codechef; // don't place package name! */
import java.util.*;
import java.lang.*;
import java.io.*;

/* Name of the class has to be "Main" only if the class is public. */
class Codechef
{
 public static void main (String[] args) throws java.lang.Exception
 {
    int testTimes = 10000000;
    int k = 6;
  int counts[] = new int[k];
  for (int i = 0; i < testTimes; i++) {
   counts[f()]++;
  }
  for (int i = 0; i < k; i++) {
   System.out.println(i + "这个数，出现了 " + counts[i] + " 次");
  }
 }
 
    // 此函数只能用，不能修改
 // 等概率返回1~5
 public static int f() {
     // (int) (Math.random() * k)表示等概率返回[0,k-1]范围值
  return (int) (Math.random() * 5) + 1;
 }

}
```

**题目：已知1~5随机等概率，求1~7随机等概率**

```
/* package codechef; // don't place package name! */

import java.util.*;
import java.lang.*;
import java.io.*;

/* Name of the class has to be "Main" only if the class is public. */
class Codechef
{
 public static void main (String[] args) throws java.lang.Exception
 {
    int testTimes = 10000000;
    int k = 8;
  int counts[] = new int[k];
  for (int i = 0; i < testTimes; i++) {
   counts[f06()]++;
  }
  for (int i = 0; i < k; i++) {
   System.out.println(i + "这个数，出现了 " + counts[i] + " 次");
  }
 }
 
 public static int f01(){
     // 将1-5等概率转化为01等概率
     int ans = 0;
     // 
     do{
         ans = f();
     }while(ans == 3);
     return ans <3?0:1;
 }
 
 public static int f07(){
     // 通过01移位等概率返回0~7，
     return (f01()<<2)+(f01()<<1)+(f01());
 }
 
 public static int f06(){
  //1~7等概率
     // 将0~7等概率得到的7强制重新等概率，就变成了0~6等概率
     int ans = 0;
     // 
     do{
         ans = f07();
     }while(ans == 7);// 如果遇到7，则继续等概率，使之不要出现7
     return ans+1;//0~6等概率，然后+1，变成1~7等概率
 }
 
    // 此函数只能用，不能修改
 // 等概率返回1~5
 public static int f() {
     // (int) (Math.random() * k)表示等概率返回[0,k-1]范围值
  return (int) (Math.random() * 5) + 1;
 }

}
```

**题目：已知a~b随机等概率，求c~d随机等概率**

> 思路：
>
> 1.将a~b等概率转化为01等概率发生器，利用do.while均分，剔除一些不要的
>
> 2.c~d等价于0~(k)等概率+c,其中k=d-c
>
> 3.求0~k等概率，利用二进制特性左移，求取等概率，其中某些数据不要则利用do.while均分，剔除一些不要的

**题目：已知01随机不等概率，求01随机等概率**

```
// 你只能知道，x会以固定概率返回0和1，但是x的内容，你看不到！
 public static int x() {
  return Math.random() < 0.84 ? 0 : 1;
 }

 // 等概率返回0和1
 // f 0(p%) 1(1-p%)
 // 两两组合，只有01和10是等概率，另外两个推倒重做
 // 00 pp
 // 11 (1-p)(1-p)
 // 01 p(1-p)
 // 10 (1-p)p
 public static int y() {
  int ans = 0;
  do {
   ans = x();
  } while (ans == x());
   // 表示第一次和第二次的值相同，则继续循环即推倒重做
  return ans;
 }
```

##

## 对数器

定义：用于生成随机样本给自己做比对的机器。

利用随机性，生成任意数组，即对数器便于调试验证.

```
/* package codechef; // don't place package name! */

import java.util.*;
import java.lang.*;
import java.io.*;

/* Name of the class has to be "Main" only if the class is public. */
class Codechef
{
 public static void main (String[] args) throws java.lang.Exception
 {
    // 利用随机数特性，可以生成一个任意长度任意值的样本数组，便于验证。
    // 和后续的对数器一起使用，方便调试排查问题
    int testTimes = 10000000;
  for (int i = 0; i < testTimes; i++) {
   int[] arr = lengthRadomValueRadom(10,19);
            code_InsertSort1(arr);
         if(!isSortAsc(arr)){
             System.out.println("插入排序算法不正确");
         }
  }
       
 }
 
 public static int[] lengthRadomValueRadom(int maxLength,int maxvalue){
     // 随机生成最大长度，最大值的随机数组
     int N = (int)(Math.random()*maxLength);
     int [] arr = new int[N];
     for(int i =0;i<N;i++){
         arr[i] = (int)(Math.random()*maxvalue);
     }
     return arr;
 }
 
 public static boolean isSortAsc(int[] arr){
     // 判断数组是否为升序，本质是对数器
     int N = arr.length;
     if(N<2){
         // 注意边界条件
         return true;
     }
     int maxV = arr[0];
     for(int i = 1;i<N;i++){
         if(maxV >arr[i]){
           return false;  
         }
         maxV = arr[i];
     }
     return true;
 }
 
 public static void code_InsertSort1(int[] arr){
 // 插入排序
     if(arr == null||arr.length<2){
         //所有算法优先考虑边界问题
         return;
     }
        int N = arr.length;
        for(int end=1;end<N;end++){
            // 1.遍历0-1，0-2...
            // 2.索引值不越界且左边小于后边相邻的，才停止。否则，一直交换下去，保证左边小右边大
            for(int pre = end;pre-1>=0&&arr[pre-1]>arr[pre];pre--){
                swap(arr,pre-1,pre);
            }
        }
 }
 
 public static void swap(int[]arr,int i,int j){
     // 常规交换
     int tem = arr[i];
     arr[i] = arr[j];
     arr[j] = tem;
 }
}
```

## 二分法

**题目：利用二分法，在一个有序数组中，查找num是否存在**

```
import java.util.*;
import java.lang.*;
import java.io.*;
class Codechef
{
 public static void main (String[] args) throws java.lang.Exception
 {
    // 利用随机数特性，可以生成一个任意长度任意值的样本数组，便于验证。
    int testTimes = 1;
  for (int i = 0; i < testTimes; i++) {
   int[] arr = lengthRadomValueRadom(10,10);
   Arrays.sort(arr);
         if(findExist(arr,3) == test(arr,3)){
             System.out.println("二分查找算法正确");
         }else{
             System.out.println("二分查找算法fuck");
         }
  }
 }
 
 public static boolean findExist(int[] arr,int num){
     // 二分法查找有序数组中是否存在某个数
     if(arr == null || arr.length ==0){
         return false;
     }
     int L = 0;
     int R = arr.length -1;
     while(L<=R){
         int mid = (L+R)/2;// 不能整除，mid会偏左点点
         if(arr[mid] == num){
             // 找到了
             return true;
         }else if(arr[mid]>num){
             // 说明num需要往左边继续二分
             R = mid + 1;// R多放一点点
         }else{
             // 说明num需要往右边继续二分
             L = mid - 1;// L多放一点点
         }
     }
     return false;
 }
 
 public static boolean test(int[] arr,int num){
     // 对数器
     for(int n:arr){
         if(n == num){
             return true;
         }
     }
     return false;
 }
    public static int[] lengthRadomValueRadom(int maxLength,int maxvalue){
     // 随机生成最大长度，最大值的随机数组
     int N = (int)(Math.random()*(maxLength+1));
     int [] arr = new int[N];
     for(int i =0;i<N;i++){
         arr[i] = (int)(Math.random()*(maxvalue+1);
     }
     return arr;
 }

}
```

**题目：利用二分法，在一个有序数组中，查找>=num最左的位置**

1,2,2,3,4,4,5,6,7,7,10.中找>=4最左位置。即索引4

```
import java.util.*;
import java.lang.*;
import java.io.*;
class Codechef
{
 public static void main (String[] args) throws java.lang.Exception
 {
    // 利用随机数特性，可以生成一个任意长度任意值的样本数组，便于验证。
    int testTimes = 1;
    int len = 10;
    int val = 10;
  for (int i = 0; i < testTimes; i++) {
   int[] arr = lengthRadomValueRadom(len,val);
   // 升序排序
   Arrays.sort(arr);
   // 打印数组
   print(arr);
   // 对数器比较
         if(findMoreNum(arr,3) == test(arr,3)){
             System.out.println("算法正确");
         }else{
             System.out.println("找算法fuck");
         }
  }
       
 }
 
 public static int findMoreNum(int[] arr,int num){
     // 二分法查找有序数组中大于等于num的索引
     int ans = -1;
     if(arr == null || arr.length ==0){
         return ans;
     }
     int L = 0;
     int R = arr.length -1;
     while(L<=R){
     // 不断地二分下去，直至切完数组
         int mid = (L+R)/2;// 不能整除，mid会偏左点点
         if(arr[mid] >= num){
             // 先记录更新ans，因为这个值就是要求的最终值
             ans = mid;
             // 说明大于等于num的索引在mid左边，所以更新右边界
             R = mid -1;
         }else{
          // 说明大于等于num的索引在mid右边，所以更新左边界
             L = mid +1;
         }
     }
     return ans;
 }
 
 public static int test(int[] arr,int num){
     // 对数器，最暴力最粗糙的方法
     for (int i = 0; i < arr.length; i++) {
   if (arr[i] >= num) {
    return i;
   }
  }
  return -1;
 }
  public static void print(int[] arr){
     // 打印数组
     for(int j =0;j<arr.length;j++){
       System.out.print(arr[j]+" ");
   }
 }
    public static int[] lengthRadomValueRadom(int maxLength,int maxvalue){
     // 随机生成最大长度，最大值的随机数组
     int N = (int)(Math.random()*(maxLength+1));
     int [] arr = new int[N];
     for(int i =0;i<N;i++){
         arr[i] = (int)(Math.random()*(maxvalue+1));
     }
     return arr;
 }
}
```

**题目：利用二分法，在一个有序数组中，查找<=num最右的位置**

1,2,2,3,4,4,5,6,7,7,10.中找<=4最左位置。即索引5

```
public static int findLessNum(int[] arr,int num){
     // 二分法查找有序数组中小于等于num的索引
     int ans = -1;
     if(arr == null || arr.length ==0){
         return ans;
     }
     int L = 0;
     int R = arr.length -1;
     while(L<=R){
         int mid = (L+R)/2;// 不能整除，mid会偏左点点
         if(arr[mid] <= num){
             // 更新ans
             ans = mid;
             L = mid + 1;
         }else{
             R = mid - 1;
         }
     }
     return ans;
 }
```

**题目：利用二分法，查找任意局部最小值**

局部最小值定义，当前值小于等于相邻值

```
import java.util.*;
import java.lang.*;
import java.io.*;
class Codechef
{
 public static void main (String[] args) throws java.lang.Exception
 {
     // 二分法查找随机数组中局部最小值，返回任意一个就行
     // 局部最小值定义，当前值小于等于相邻值
    int testTimes = 1;
    int len = 10;
    int val = 10;
  for (int i = 0; i < testTimes; i++) {
   int[] arr = randomArray(len,val);
   // 打印数组
   print(arr);
   System.out.println();
    int ans = findOneMinIndex(arr);
   // 对数器比较
         if(test(arr,ans)){
             System.out.println("算法正确");
         }else{
             System.out.println("找算法fuck");
         }
  }
 }
 
 public static int findOneMinIndex(int[] arr){
     // 二分法查找随机数组中局部最小值
     // arr随机不相等且无序
     if(arr == null || arr.length ==0){
         return -1;
     }
     if(arr.length ==1){
       return 0;  
     }
     int N = arr.length;
     int L = 0;
     int R = arr.length -1;
     int ans = -1;
     if(arr[0]<arr[1]){
         // 边界
         return 0;
     }
     if(arr[N-2]>arr[N-1]){
         // 边界
         return N-1;
     }
     // 剩下的情况说明，开头是下降趋势，结尾是上升趋势，则局部最小值一定在中间.根据这个规律不断二分
     // 如果中间的是下降趋势，则往右继续二分查找。否则往左二分查找，直至切完
     while(L<=R){
         int mid = (L+R)/2;// 不能整除，mid会偏左点点
         if(arr[mid] <arr[mid-1]&&arr[mid] <arr[mid+1]){
             // 更新ans
             ans = mid;
             break;
         }
         if(arr[mid] >arr[mid-1]){
           // 说明局部最小值出现在左半边，因为开头是下降，中间是上升，最小值一定出现在这之间
           R = mid - 1;
           continue;
         }
         if(arr[mid] >arr[mid+1]){
             // 同上
             L = mid + 1;
             continue;
         }
     }
     return ans;
 }
 
 public static boolean test(int[] arr, int minIndex) {
     // 对数器
  if (arr.length == 0) {
   return minIndex == -1;
  }
  int left = minIndex - 1;
  int right = minIndex + 1;
  boolean leftBigger = left >= 0 ? arr[left] > arr[minIndex] : true;
  boolean rightBigger = right < arr.length ? arr[right] > arr[minIndex] : true;
  return leftBigger && rightBigger;
 }
  public static void print(int[] arr){
     // 打印数组
     for(int j =0;j<arr.length;j++){
       System.out.print(arr[j]+" ");
   }
 }
   // 生成随机数组，且相邻数不相等
 public static int[] randomArray(int maxLen, int maxValue) {
  int len = (int) (Math.random() * maxLen);
  int[] arr = new int[len];
  if (len > 0) {
   arr[0] = (int) (Math.random() * maxValue);
   for (int i = 1; i < len; i++) {
    do {
     arr[i] = (int) (Math.random() * maxValue);
    } while (arr[i] == arr[i - 1]);
   }
  }
  return arr;
 }
}
```

## 什么是常数操作

算法的执行时间与样本量无关，是一个固定值,表示为O(1)

## 什么是时间复杂度

比如冒泡排序的时间复杂度：n平方。只取最高阶，去掉系数，去掉低阶。时间复杂度一定是**最差的情况**。

二分法的复杂度是O(logN)

常见时间复杂度排序：O(1)<O(logN)<O(N)<O(N*logN)<O(N2)<O(2N)<O(3N)<...

## 单链表问题

没有复杂的数据结构，纯记忆多做即可

### 单链表反转

```
import java.util.*;
import java.lang.*;
import java.io.*;
class Codechef
{
 public static void main (String[] args) throws java.lang.Exception
 {
     // 单链表反转，注意一定要有返回值的头结点，否则容易断链
     Node node0 = new Node(0);
     node0.next = new Node(1);
     node0.next.next = new Node(2);
     node0.next.next.next = new Node(3);
     print(node0);
     System.out.println();
     node0 = reverseLinkedList(node0);
     print(node0);
 }
 
 public static Node reverseLinkedList(Node head){
     // 单链表反转。
     //注意一定要有返回值，让头结点指针指向第一个节点。否则头结点只能指向最后一个节点，导致其他节点丢失
     Node pre = null;
     Node next = null;
     while(head != null){
      // 先将当前节点的下个节点临时保存下
       next = head.next;
      // 把当前节点的下一个节点往前指
       head.next =  pre;
       // 把前一个节点变成当前，方便下一次继续往前指
       pre = head;
       // 上面就已经完成了反转，但还需要继续遍历下去，所以用到了第一步临时的next
       head = next;
     }
     // 当node为空，停止，并返回反转后的第一个节点pre
     return pre;
 }
 public static class Node{
  // 单链表结构
     public int value;
     public Node next;
     public Node(int val){
         value = val;
     }
 }
 
 public static void print(Node node){
     while(node !=null){
         System.out.print(node.value+"->");
         node = node.next;
     }
 }
}
```

### 双链表反转

```
public static Node reverseDoubleList(Node head){
     // 单链表反转。
     //注意一定要有返回值，让头结点指针指向第一个节点。否则头结点只能指向最后一个节点，导致其他节点丢失
     Node pre = null;
     Node next = null;
     while(head != null){
      // 先将当前节点的下个节点临时保存下
       next = head.next;
      // 把当前节点的下一个节点往前指
       head.next =  pre;
       // 把当前节点的上一个节点往后指
       head.last = next;
       // 把前一个节点变成当前，方便下一次继续往前指
       pre = head;
       // 上面就已经完成了反转，但还需要继续遍历下去，所以用到了第一步临时的next
       head = next;
     }
     // 当node为空，停止，并返回反转后的第一个节点pre
     return pre;
 }
```

### 用单链表结构实现队列

先进先出

```
import java.util.*;
import java.lang.*;
import java.io.*;
class Codechef
{
 public static void main (String[] args) throws java.lang.Exception
 {
     //基于单链表结构实现的队列
     MyQueue mq = new MyQueue();
     mq.offer(1);
     mq.offer(2);
     mq.offer(3);
     for(int i =0;i<3;i++){
         System.out.print(mq.poll()+"->");
     }
 }
 
 public static class Node<V> {
     // value的类型为泛型，单链表结构
  public V value;
  public Node<V> next;

  public Node(V v) {
   value = v;
   next = null;
  }
 }
 
 public static class MyQueue<V> {
     // 基于链表结构的队列，先进先出。只需要记录头尾指针，内部的跳转使用单链表关联起来。
     // 头指针
  private Node<V> head;
  // 尾指针
  private Node<V> tail;
  private int size;

  public MyQueue() {
   head = null;
   tail = null;
   size = 0;
  }

  public boolean isEmpty() {
   return size == 0;
  }

  public int size() {
   return size;
  }

  public void offer(V value) {
      // 队列添加数据
      // cur是单链表结构
   Node<V> cur = new Node<V>(value);
   if (tail == null) {
       // 全空，则头尾指针指向当前节点
    head = cur;
    tail = cur;
   } else {
       // 尾巴的节点先指向当前节点
    tail.next = cur;
    // 然后尾巴指针指向当前节点
    tail = cur;
   }
   size++;
  }

  // C/C++的同学需要做节点析构的工作
  public V poll() {
      // 队列弹出数据
   V ans = null;
   if (head != null) {
       // 直接取出头指针节点
    ans = head.value;
    // 头指针下移一个
    head = head.next;
    size--;
   }
   if (head == null) {
    tail = null;
   }
   return ans;
  }

  // C/C++的同学需要做节点析构的工作
  public V peek() {
      // 查询队列的头结点
   V ans = null;
   if (head != null) {
    ans = head.value;
   }
   return ans;
  }
 }
}
```

### 用单链表结构实现栈

先进后出

```
public static class MyStack<V> {
     // 基于链表结构的栈，先进后出。
     // 只需要用到一个头指针
  private Node<V> head;
  private int size;

  public MyStack() {
   head = null;
   size = 0;
  }

  public boolean isEmpty() {
   return size == 0;
  }

  public int size() {
   return size;
  }

  public void push(V value) {
      // 栈添加数据
   Node<V> cur = new Node<>(value);
   if (head == null) {
    head = cur;
   } else {
    // 当前节点的下一个指向老头节点
    cur.next = head;
    // 新头指向当前节点
    head = cur;
   }
   size++;
  }

  public V pop() {
      // 栈弹出数据
   V ans = null;
   if (head != null) {
    ans = head.value;
    head = head.next;
    size--;
   }
   return ans;
  }

  public V peek() {
      // 查看栈顶数据
   return head != null ? head.value : null;
  }
 }
```

### 用双链表结构实现双端队列

```
import java.util.*;
import java.lang.*;
import java.io.*;
class Codechef
{
 public static void main (String[] args) throws java.lang.Exception
 {
     //基于双链表结构实现的双端队列，队列的头部和尾部都可以添加和删除元素
     MyDeque mq = new MyDeque();
     mq.pushHead(1);
     mq.pushHead(2);
     mq.pushHead(3);
     for(int i =0;i<3;i++){
         System.out.print(mq.pollHead()+"->");
     }
 }
 
 public static class Node<V> {
     // 双链表，不复杂，就是两个指针，一个往前指，一个往后指
  public V value;
  public Node<V> last;
  public Node<V> next;

  public Node(V v) {
   value = v;
   last = null;
   next = null;
  }
 }

 public static class MyDeque<V> {
     // 基于双链表实现的双端队列，即头部可添加删除元素，尾部也可添加删除元素
     // 依然是头指针和尾指针
  private Node<V> head;
  private Node<V> tail;
  private int size;

  public MyDeque() {
    
   head = null;
   tail = null;
   size = 0;
  }

  public boolean isEmpty() {
   return size == 0;
  }

  public int size() {
   return size;
  }

  public void pushHead(V value) {
      // 头部添加元素
   Node<V> cur = new Node<>(value);
   if (head == null) {
       // 先判空，头尾指针都指向当前节点
    head = cur;
    tail = cur;
   } else {
       // 当前节点的下一个指针指向老头指针
    cur.next = head;
    // 老头指针指向当前节点
    head.last = cur;
    // 头指针变成当前节点
    head = cur;
   }
   // 队列长度+1
   size++;
  }

  public void pushTail(V value) {
      // 尾部添加元素
   Node<V> cur = new Node<>(value);
   if (head == null) {
    head = cur;
    tail = cur;
   } else {
    tail.next = cur;
    cur.last = tail;
    tail = cur;
   }
   size++;
  }

  public V pollHead() {
      // 头部弹出元素
   V ans = null;
   if (head == null) {
    return ans;
   }
   size--;
   ans = head.value;
   if (head == tail) {
    head = null;
    tail = null;
   } else {
    head = head.next;
    head.last = null;
   }
   return ans;
  }

  public V pollTail() {
      // 尾部弹出元素
   V ans = null;
   if (head == null) {
    return ans;
   }
   size--;
   ans = tail.value;
   if (head == tail) {
    head = null;
    tail = null;
   } else {
    tail = tail.last;
    tail.next = null;
   }
   return ans;
  }

  public V peekHead() {
      // 头部查询元素
   V ans = null;
   if (head != null) {
    ans = head.value;
   }
   return ans;
  }

  public V peekTail() {
      // 尾部查询元素
   V ans = null;
   if (tail != null) {
    ans = tail.value;
   }
   return ans;
  }

 }
}
```

### 单链表的k个节点的组内逆序调整

```
import java.util.*;
import java.lang.*;
import java.io.*;
class Codechef
{
 public static void main (String[] args) throws java.lang.Exception
 {
     // 该算法难度为hard,一定要画图，否则玩个6啊
     // 测试链接：https://leetcode.com/problems/reverse-nodes-in-k-group/
     //单链表的k个节点的组内逆序调整，不足k个的不需要逆序。
     // 1-2-3-4-5-6-7-8逆序后3-2-1-6-5-4-7-8
     ListNode node = new ListNode(1);
     node.next = new ListNode(2);
     node.next.next = new ListNode(3);
     node.next.next.next = new ListNode(4);
     node.next.next.next.next = new ListNode(5);
     node.next.next.next.next.next = new ListNode(6);
     node.next.next.next.next.next.next = new ListNode(7);
     node.next.next.next.next.next.next.next = new ListNode(8);
     node = reverseKGroup(node,3);
     for(int i =0;i<8;i++){
         System.out.print(node.val+"->");
         node = node.next;
     }
 }
 
 // 不要提交这个类
 public static class ListNode<V> {
  public V val;
  public ListNode<V> next;
  public ListNode(V value){
      val = value;
      next = null;
  }
 }

 public static ListNode reverseKGroup(ListNode head, int k) {
  ListNode start = head;
  ListNode end = getKGroupEnd(start, k);
  if (end == null) {
      // 不足一组k个的情况，不用反转，直接返回头结点
   return head;
  }
  // 第一组凑齐了！
  head = end;
  // 第一组直接反转
  reverse(start, end);
  // 当前组的最后一个节点是逆序后的原头节点
  ListNode lastEnd = start;
  while (lastEnd.next != null) {
      // 继续组内的头结点到尾节点的反转操作
   start = lastEnd.next;
   end = getKGroupEnd(start, k);
   if (end == null) {
       // 当前组不需要反转，直接返回外层的头结点
    return head;
   }
   reverse(start, end);
   // 逆序后，上一组的尾节点指向当前组的逆序后的头节点
   lastEnd.next = end;
   // 将上一组的尾节点变为当前组的逆序后的尾节点
   lastEnd = start;
  }
  return head;
 }

 public static ListNode getKGroupEnd(ListNode start, int k) {
     // 已知节点，获取同组第k个节点
  while (--k != 0 && start != null) {
  // k=0表示k个节点，同时节点不能为空
  // 根据链表特性，依次获取下去
   start = start.next;
  }
  // 返回从开始节点算起的第k个节点
  return start;
 }

 public static void reverse(ListNode start, ListNode end) {
     // 将一组内的k个节点，全部反转
     // 先将尾指针指向最后一个的下一个
  end = end.next;
  ListNode pre = null;
  // 将头节点给起当前节点
  ListNode cur = start;
  ListNode next = null;
  // 循环逆序当前这一组
  while (cur != end) {
      // 链表反转的经典常规操作
   next = cur.next;
   cur.next = pre;
   pre = cur;
   cur = next;
  }
  // 原来的头结点指向下一组的第一个节点
  start.next = end;
 }
}
```

### 两个链表相加

```
import java.util.*;
import java.lang.*;
import java.io.*;
class Codechef
{
 // 测试链接：https://leetcode.com/problems/add-two-numbers/
 public static void main (String[] args) throws java.lang.Exception
 {
     // 两个链表相加，计算进位信息
     // 1-2-3-4和9-4-8-9-9相加得0-7-1-4-0-1
     ListNode node = new ListNode(1);
     node.next = new ListNode(2);
     node.next.next = new ListNode(3);
     node.next.next.next = new ListNode(4);
     ListNode node1 = new ListNode(9);
     node1.next = new ListNode(4);
     node1.next.next = new ListNode(8);
     node1.next.next.next = new ListNode(9);
     node1.next.next.next.next = new ListNode(9);
     node = addTwoNumbers(node,node1);
     while(node != null){
         System.out.print(node.val+"->");
         node = node.next;
     }
 }
 
 // 不要提交这个类
 public static class ListNode {
  public int val;
  public ListNode next;

  public ListNode(int val) {
   this.val = val;
  }

  public ListNode(int val, ListNode next) {
   this.val = val;
   this.next = next;
  }
 }

 public static ListNode addTwoNumbers(ListNode head1, ListNode head2) {
     // 两个链表相加，从左到右依次为低位到高位，有进位要计算进位
  int len1 = listLength(head1);
  int len2 = listLength(head2);
  // 获取两个链表中的哪一个长，哪一个短一些
  ListNode l = len1 >= len2 ? head1 : head2;
  ListNode s = l == head1 ? head2 : head1;
  /*
   计算分三步走：
   第一步：l节点有值，s节点有值，则直接计算ls包括进位符，该进位进位
   第二步：l有值，s无值，则直接计算l包括进位符，该进位进位
   第三部：l无值，s无值，则看进位符是否有，高位新增一个节点，保存进位值
  */
  ListNode curL = l;
  ListNode curS = s;
  ListNode last = curL;
  // 表示当前进位符
  int carry = 0;
  int curNum = 0;
  while (curS != null) {
      // 第一步，l+s+carry进位符
   curNum = curL.val + curS.val + carry;
   // 取余，最终结果复制到长链表中
   curL.val = (curNum % 10);
   // 更新进位符
   carry = curNum / 10;
   // 时刻跟随最新的节点
   last = curL;
   // 长短链表，依次往下指
   curL = curL.next;
   curS = curS.next;
  }
  while (curL != null) {
       // 第二步
   curNum = curL.val + carry;
   curL.val = (curNum % 10);
   carry = curNum / 10;
   last = curL;
   curL = curL.next;
  }
  if (carry != 0) {
       // 第三步，如果最后一个还有进位，则追加一个链表节点到最后
   last.next = new ListNode(1);
  }
  return l;
 }

 // 求链表长度
 public static int listLength(ListNode head) {
  int len = 0;
  while (head != null) {
   len++;
   head = head.next;
  }
  return len;
 }
}
```

## KMP算法

### 定义

KMP算法指的是字符串模式匹配算法，问题是：在主串T中找到第一次出现完整子串P时的起始位置。该算法是三位大牛：D.E.Knuth、J.H.Morris和V.R.Pratt同时发现的，以其名字首字母命名。

KMP算法要解决的问题就是在字符串（也叫主串）中的模式（pattern）定位问题。说简单点就是我们平时常说的关键字搜索。

```
public class KMP {
    public static void main(String[] args) {
        System.out.println(getIndexOf("sssb","sb"));
    }
    public static int getIndexOf(String s, String m) {
        // KMP算法核心：分2步走，s为主串，m为模板串
        // 第一步：求解模板串的最长公共前后缀的长度值
        // 第二步：主串和模板串比较，采用不进行主串回溯的比较方法，高效
        if (s == null || m == null || m.length() < 1 || s.length() < m.length()) {
            return -1;
        }
        //下面就是KMP算法的全部步骤
        char[] str1 = s.toCharArray();
        char[] str2 = m.toCharArray();
        int i1 = 0;
        int i2 = 0;
        // 第一步：求解模板串的最长公共前后缀的长度值
        int[] next = getNextArray(str2);
        // 第二步：主串和模板串比较，采用不进行主串回溯的比较方法，高效
        while (i1 < str1.length && i2 < str2.length) {
            if (str1[i1] == str2[i2]) {
                // 主串和模板串值相同，则继续后移比较
                i1++;
                i2++;
                //-1为起始位置
            } else if (next[i2] == -1) {
                // -1表示模板串的指针到首位了，则主串继续后移
                i1++;
            } else {
                // 只要模板串的指针不是首位，则该指针继续回溯往前比较
                i2 = next[i2];
            }
        }
        //如果i2滑到最后了，那证明找到了，返回匹配的索引开始值；如果到最后都不等于，那返回负一，没找到
        return i2 == str2.length ? i1 - i2 : -1;
    }
    public static int[] getNextArray(char[] str2){
        // 求解最长公共前后缀表
        /*
        首先确定好第i个位置上的匹配长度L
        第i+1位置匹配长度判断时，需要判断第i位置上匹配长度中前半段A的下个字符和第i位置上的字符进行比较
        如果相等则第i+1位置匹配长度为L+1
        如果不相等将前半段A的匹配长度读出，再分出A的前半段B，再返回步骤2，进行判断。
        最后前半段中只包含整个字符串中的第一个字符，此时还不相等则返回0，相等则返回1。
        */
        if(str2.length == 1){
            return new int[] {-1};
        }
        int[] next = new int[str2.length];
        next[0] = -1;
        next[1] = 0;
        //i代表数组开始的位置
        int i = 2;
        //cn代表匹配的前后缀的最大长度
        int cn = 0;
        while(i<next.length){
            //如果前一个和最长串的相等，则直接最长串+1就是当前最长串
            if(str2[i-1] == str2[cn]){
             // 条件1
                next[i++] = ++cn;
            }else if(cn>0){
             // 条件2
                // 最长串有值且当前值不相等，则需要找上一个最长串，刚好是next[cn]，往前递归回溯，一直到满足条件1或3
                cn = next[cn];
            }else{
             // 条件3
                // cn=0表示前面没有最长串，同时又不相等，则直接计算为0
                next[i++] = 0;
            }
        }
        return next;
    }
}
```

### 判断旋转词

题目：旋转词是指，左侧部分字符整体搬移到右侧。例如：str="123456",str的旋转词有：“234561”，“345612”。。。判断str1="113332"是不是str的旋转词？

暴力方法：O(N2)，求出str所有旋转词，逐一匹配

最佳解法：str+str得到一个双倍长串，判断str1是否为长串的连续子串。很神奇喔，因为旋转后刚好和str+str长串一致。

### 判断二叉树T2是否为T1的子树

题目：子树是指所有节点值相同，且小数的叶子节点也是大树的叶子节点。

**解法1：暴力求解法**

**解法2：利用KMP算法**

解法1：暴力求解法，逐一比较所有节点

```
public class Test {
    public static void main (String[] args) throws java.lang.Exception
    {
        // 判断二叉树T2是否为T1的子树
        // T1 41235和T2 123
        TreeNode tree1 = new TreeNode(4);
        tree1.left = new TreeNode(1);
        tree1.right = new TreeNode(5);
        tree1.left.left = new TreeNode(2);
        tree1.left.right = new TreeNode(3);
        TreeNode tree2 = new TreeNode(1);
        tree2.left = new TreeNode(2);
        tree2.right = new TreeNode(3);
        System.out.println(containsTree1(tree1,tree2));
    }
    public static class TreeNode {
        public int val;
        public TreeNode left;
        public TreeNode right;
        public TreeNode(int value){
            val = value;
        }
    }
    public static boolean containsTree1(TreeNode big,TreeNode small){
        // 判断小树是否为大树的子树
        if(small == null){
            // 边界，小树为空
            return true;
        }
        if(big == null){
            // 边界，大树为空
            return false;
        }
        if(isSameValStructure(big,small)){
            // 大树和小树的是否完全一样
            return true;
        }
        // 说明当前节点的数结构与小数不一样，则继续递归左右两边的节点
        return containsTree1(big.left,small) || containsTree1(big.right,small);
    }
    public static boolean isSameValStructure(TreeNode head1,TreeNode head2){
        // 判断两棵树是否完全相等
        if(head1 == null && head2 != null){
            return false;
        }
        if(head1 != null && head2 == null){
            return false;
        }
        if(head1 == null && head2 == null){
            // 说明完全相等
            return true;
        }
        if(head1.val != head2.val){
            return false;
        }
        // 递归各个子节点
        return isSameValStructure(head1.left,head2.left)&&isSameValStructure(head1.right,head2.right);
    }
}
```

解法2：KMP算法，将T1，T2两棵树先序遍历转为数组，然后判断T2是否为T1的子串数组。

```
import java.util.ArrayList;

public class Test {
    public static void main (String[] args) throws java.lang.Exception
    {
        // 判断二叉树T2是否为T1的子树
        // T1 41235和T2 123
        TreeNode tree1 = new TreeNode(4);
        tree1.left = new TreeNode(1);
        tree1.right = new TreeNode(5);
        tree1.left.left = new TreeNode(2);
        tree1.left.right = new TreeNode(3);
        TreeNode tree2 = new TreeNode(1);
        tree2.left = new TreeNode(2);
        tree2.right = new TreeNode(3);
        System.out.println(containsTree2(tree1,tree2));
    }
    public static class TreeNode {
        public int val;
        public TreeNode left;
        public TreeNode right;
        public TreeNode(int value){
            val = value;
        }
    }
    public static boolean containsTree2(TreeNode big,TreeNode small){
        // 利用KMP子串特性巧妙求解，核心：先把树转为字符串数组，然后利用kmp算法求解
        // 判断小树是否为大树的子树
        if(small == null){
            // 边界，小树为空
            return true;
        }
        if(big == null){
            // 边界，大树为空
            return false;
        }
        ArrayList <String> b = preSerial(big);
        ArrayList <String> s = preSerial(small);
        String[] str = new String[b.size()];
        for(int i =0;i<str.length;i++){
            str[i] = b.get(i);
        }
        String[] match = new String[s.size()];
        for(int i =0;i<match.length;i++){
            match[i] = s.get(i);
        }
        return getIndexOf(str,match) != -1;
    }
    public static ArrayList <String> preSerial(TreeNode head){
        // 将树结构通过先序遍历转为数组
        ArrayList <String> ans = new ArrayList<>();
        pres(head,ans);
        return ans;
    }
    public static void pres(TreeNode head,ArrayList <String> ans){
        // 先序遍历
        if(head == null){
            // 树为空则填充空值
            ans.add(null);
        }else{
            ans.add(String.valueOf(head.val));
            pres(head.left,ans);
            pres(head.right,ans);
        }
    }
    public static int getIndexOf(String[] str1,String[] str2){
        // 判断字符串数组是否存在KMP子串数组
        if(str1 == null||str2 == null || str1.length == 0 ||str1.length < str2.length){
            return -1;
        }
        int x = 0;
        int y = 0;
        int[] next = getNextArray(str2);
        while(x<str1.length&&y<str2.length){
            if(isEqual(str1[x],str2[y])){
              x++;
              y++;
            }else if(next[y] == -1){
                x++;
            }else{
                y = next[y];
            }
        }
        return y == str2.length?x-y:-1;
    }
    public static int[] getNextArray(String[] ms){
        if(ms.length == 1){
            return new int[]{-1};
        }
        int[] next = new int[ms.length];
        next[0] = -1;
        next[1] = 0;
        int i =2;
        int cn = 0;
        while(i<next.length){
            if(isEqual(ms[i-1],ms[cn])){
                next[i++] = ++cn;
            }else if (cn>0){
                cn = next[cn];
            }else{
                next[i++] = 0;
            }
        }
        return  next;
    }
    public static boolean isEqual(String a,String b){
        // 判断两个字符串是否相等
        if(a == null && b==null){
            return true;
        }else{
            if(a==null||b==null){
                return false;
            }else{
                return a.equals(b);
            }
        }
    }
}
```

## BFPRT算法

简称：五个好朋友算法，是5个人共同提出的算法。开创了算法的优化一个新局面。

bfprt算法最牛逼划时代的意义是，在你还没有完全求解出来时，你就已经知道算法收敛于O(n),也叫五个好朋友算法。

题目：无序数组中，求第K小的数

- 解法1：常规解法，利用快排分组，利用荷兰国旗问题，获取值，笔试常用。平均复杂度nlog(n)，最差n2

- 解法2：bfprt算法也叫**五个好朋友算法**也叫**中位数的中位数算法**，只有第一步的选值特别讲究，后续都和1一样，面试装逼.平均复杂度n

解法1：利用快排，只不过没有快排的两边排序，只排序一边即可。流程：a随机选一个数；b划分区域值<p=p>p;c如果命中index,则返回。否则左侧或右侧递归

```
public class FindMinK {
    public static void main(String[] args) {
        int[] arr = {1,  3,  5, 7,  9, 11};
        int k = 2;
        System.out.println(select(arr, 0, arr.length - 1, k - 1));
    }

    //在arr[L..R]范围上，求如果排序的话，i位置的数是谁，返回
    //i一定且必须出现在L~R范围上
    public static int select(int[] arr, int L, int R, int i) {
        if (L == R) {
            return arr[L];
        }
        // 解法1：常规解法，a随机选一个数；b划分区域值<p=p>p;c如果命中index,则返回。否则左侧或右侧递归
        int pivot = arr[L+(int)(Math.random()*(R-L+1))];
        // partition过程 根据pivot做划分值  <p ==p <p 返回等于区域的左边界和右边界
        // range[0] 等于区域的左边界的索引值
        // range[1] 等于区域的右边界的索引值
        int[] range = partition(arr, L, R, pivot);
        // 注意range存放的是边界的索引值，不是数组值
        // 左右分组后，range左边的索引值数都是小于range值索引值数，右边都是大于值。比如range[6-10],说明左边有5个小数，右边是大数。
        if (i >= range[0] && i <= range[1]) {
            return arr[i];
        } else if (i < range[0]) {
            return select(arr, L, range[0] - 1, i);
        } else {
            return select(arr, range[1] + 1, R, i);
        }
    }
    
    public static int[] partition(int[] arr, int L, int R, int pivotValue) {
        // 常规荷兰国旗问题分组
        int small = L - 1;
        int cur = L;
        int big = R + 1;
        while (cur != big) {
            if (arr[cur] < pivotValue) {
                swap(arr, ++small, cur++);
            } else if (arr[cur] > pivotValue) {
                swap(arr, cur, --big);
            } else {
                cur++;
            }
        }
        int[] range = new int[2];
        range[0] = small + 1;
        range[1] = big - 1;
        return range;
    }

    public static void swap(int[] arr, int index1, int index2) {
        int tmp = arr[index1];
        arr[index1] = arr[index2];
        arr[index2] = tmp;
    }
}
```

解法2：利用bfprt算法，流程：a非常非常讲究的选一个数即中位数的中位数；b划分区域值<p=p>p;c如果命中index,则返回。否则左侧或右侧递归。

```
public class FindMinK {
    public static void main(String[] args) {
        int[] arr = {1, 3, 5, 7, 9, 11};
        int k = 2;
        System.out.println(bfprt(arr, 0, arr.length - 1, k - 1));
    }

    //在arr[L..R]范围上，求如果排序的话，i位置的数是谁，返回。
    //i一定且必须出现在L~R范围上
    public static int bfprt(int[] arr, int L, int R, int i) {
        if (L == R) {
            return arr[L];
        }
        // 解法2: bfprt算法，a非常非常讲究的选一个数即中位数的中位数；b划分区域值<p=p>p;c如果命中index,则返回。否则左侧或右侧递归
        int pivot = medianOfMedians(arr, L, R);
        // partition过程 根据pivot做划分值  <p ==p <p 返回等于区域的左边界和右边界
        // range[0] 等于区域的左边界的索引值
        // range[1] 等于区域的右边界的索引值
        int[] range = partition(arr, L, R, pivot);
        // 注意range存放的是边界的索引值，不是数组值
        // 左右分组后，range左边的索引值数都是小于range值索引值数，右边都是大于值。比如range[6-10],说明左边有5个小数，右边是大数。
        if (i >= range[0] && i <= range[1]) {
            return arr[i];
        } else if (i < range[0]) {
            return bfprt(arr, L, range[0] - 1, i);
        } else {
            return bfprt(arr, range[1] + 1, R, i);
        }
    }

    public static int medianOfMedians(int[] arr, int begin, int end) {
        /* 求解中位数
        1.每5个数分为一组
        2.内部排序，每组的中位数组成新数组marr
        3.继续调用中位数算法bfprt(marr,marr的中位数即长度一半)
         */
        // 数组总长度
        int num = end - begin + 1;
        // 每五个一组，查看是否有多余的数，有的话则单独成一位
        int offset = num % 5 == 0 ? 0 : 1;
        // 创建存储每五个数据排序后中位数的数组
        int[] mArr = new int[num / 5 + offset];
        // 遍历此数组
        for (int i = 0; i < mArr.length; i++) {
            // 当前mArr来源自原来数组中的起始位置
            int beginI = begin + i * 5;
            // 当前mArr来源自原来数组中的终止位置
            int endI = beginI + 4;
            // 计算出当前i位置5个数排序后的中位数
            mArr[i] = getMedian(arr, beginI, Math.min(end, endI));
        }
        // 在这些中位数的点中，挑选出排好序之后的中位数返回，即继续调用bfprt功能前一半小的数也就是中位数
        return bfprt(mArr, 0, mArr.length - 1, mArr.length / 2);
    }

    public static int getMedian(int[] arr, int begin, int end) {
        // 对数组排序，获取中位数或中间的偏左位置。因为可能刚好4个数，取第2个
        insertionSort(arr, begin, end);
        int sum = end + begin;
        int mid = (sum / 2) + (sum % 2);
        return arr[mid];
    }

    public static void insertionSort(int[] arr, int begin, int end) {
    // 插入排序
        for (int i = begin + 1; i != end + 1; i++) {
            for (int j = i; j != begin; j--) {
                if (arr[j - 1] > arr[j]) {
                    swap(arr, j - 1, j);
                } else {
                    break;
                }
            }
        }
    }

    public static int[] partition(int[] arr, int L, int R, int pivotValue) {
        int small = L - 1;
        int cur = L;
        int big = R + 1;
        while (cur != big) {
            if (arr[cur] < pivotValue) {
                swap(arr, ++small, cur++);
            } else if (arr[cur] > pivotValue) {
                swap(arr, cur, --big);
            } else {
                cur++;
            }
        }
        int[] range = new int[2];
        range[0] = small + 1;
        range[1] = big - 1;
        return range;
    }

    public static void swap(int[] arr, int index1, int index2) {
        int tmp = arr[index1];
        arr[index1] = arr[index2];
        arr[index2] = tmp;
    }
}
```

## Morris算法遍历

## Morris算法遍历

### Morris序

比如二叉树：第一层：1，第二层：2,3；第三层，4,5,6,7。Morris序是：1242513637

算法流程：

> 首先cur表示当前节点，cur指向树的头结点。直到最终cur指向null停止。
>
> 1. 如果cur无左树，cur=cur.right
>
> 2. 如果cur有左树，找到左树的最右节点mostRight,即左树的右右右...不为空的节点。
>
>    1)如果mostRight的右指针指向null,则mostRight.right =cur,cur=cur.left
>
>    2)如果mostRight的右指针指向cur,则mostRight.right =null,cur=cur.right

**时间复杂度**：O(N),因为每个节点的左树右边界最多趟过2次，即2N是N规模的复杂度。

**空间复杂度**：O(1)即不需要额外空间

```
    public static class Node {
        public int value;
        Node left;
        Node right;

        public Node(int data) {
            this.value = data;
        }
    }
    public static void morris(Node head) {
        if (head == null) {
            return;
        }
        // 从头结点开始
        Node cur = head;
        Node mostRight = null;
        // cur指向null停止，跳出while循环。
        while (cur != null) {
            // cur只要不为null,就一直跑下去
            mostRight = cur.left;
            if (mostRight != null) {
                // 2.如果cur有左孩子
                while (mostRight.right != null && mostRight.right != cur) {
                    // 找到cur左子树最右节点，要么节点的右指针为空，要么节点的右指针指向当前节点(因为人工改变了指向)
                    mostRight = mostRight.right;
                }
                if (mostRight.right == null) {
                 // 第一次到达cur
                 // 1)mostRight的右孩子指向空，让其指向cur，cur向左移动
                    mostRight.right = cur;
                    cur = cur.left;
                    continue;
                } else {
                 // 第二次到达cur
                    // 2)mostRight的右孩子指向cur，让其指向空，cur向右移动
                    mostRight.right = null;
                }
            }
            // 1.如果cur没有左孩子
            cur = cur.right;
        }
    }
```

### Morris遍历和传统二叉树遍历

Morris遍历是向传统遍历致敬，做到了优化的前序和中序遍历，后续遍历需要额外代码。

传统二叉树遍历代码：

```
public static void process(Node head) {
        if (head == null) {
            return;
        }
        // 先序遍历
        System.out.println(“先序遍历：头左右”);
        process(head.left);
        // 中序遍历
        System.out.println(“中序遍历：左头右”);
        process(head.right);
        // 后序遍历
        System.out.println(“后序遍历：左右头”);
    }
```

**先序遍历**

只打印没有左节点或第一次进入的节点

```
public static void morrisPre(Node head) {
        // 中序遍历
        if (head == null) {
            return;
        }
        // 从头结点开始
        Node cur = head;
        Node mostRight = null;
        // cur指向null停止，跳出while循环。
        while (cur != null) {
            // cur只要不为null,就一直跑下去
            mostRight = cur.left;
            if (mostRight != null) {
                // 2.如果cur有左孩子
                while (mostRight.right != null && mostRight.right != cur) {
                    // 找到cur左子树最右节点，要么节点的右指针为空，要么节点的右指针指向当前节点(因为人工改变了指向)
                    mostRight = mostRight.right;
                }
                // 1)mostRight的右孩子指向空，让其指向cur，cur向左移动
                if (mostRight.right == null) {
                    mostRight.right = cur;
                    // 只打印第一次进入的节点
                    System.out.println("先序遍历"+cur.value);
                    cur = cur.left;
                    continue;
                } else {
                    // 2)mostRight的右孩子指向cur，让其指向空，cur向右移动
                    mostRight.right = null;
                }
            }else{
                // 只打印没有左节点
                System.out.println("先序遍历"+cur.value);
            }
            // 1.如果cur没有左孩子
            cur = cur.right;
        }
    }
```

**中序遍历**

只打印没有左节点或第二次进入的节点

```
public static void morrisIn(Node head) {
        // 中序遍历
        if (head == null) {
            return;
        }
        // 从头结点开始
        Node cur = head;
        Node mostRight = null;
        // cur指向null停止，跳出while循环。
        while (cur != null) {
            // cur只要不为null,就一直跑下去
            mostRight = cur.left;
            if (mostRight != null) {
                // 2.如果cur有左孩子
                while (mostRight.right != null && mostRight.right != cur) {
                    // 找到cur左子树最右节点，要么节点的右指针为空，要么节点的右指针指向当前节点(因为人工改变了指向)
                    mostRight = mostRight.right;
                }
                // 1)mostRight的右孩子指向空，让其指向cur，cur向左移动
                if (mostRight.right == null) {
                    mostRight.right = cur;
                    cur = cur.left;
                    continue;
                } else {
                    // 2)mostRight的右孩子指向cur，让其指向空，cur向右移动
                    mostRight.right = null;
                }
            }
            // 一行代码，只打印没有左节点或第二次进入的节点
            System.out.println("中序遍历"+cur.value);
            // 1.如果cur没有左孩子
            cur = cur.right;
        }
    }
```

**后序遍历**

- 打印第二次进入节点的左树的右边界的逆序，其中Morris序是：1242513637。

第二个2的左树右边界只有4，第二个1的左树右边界逆序是52，第二个3的左树右边界逆序是6

- 打印整棵树的右边界逆序，731

最终结果为4526731

```
public static void morrisPos(Node head) {
        // 后序遍历
        if (head == null) {
            return;
        }
        // 从头结点开始
        Node cur = head;
        Node mostRight = null;
        // cur指向null停止，跳出while循环。
        while (cur != null) {
            // cur只要不为null,就一直跑下去
            mostRight = cur.left;
            if (mostRight != null) {
                // 2.如果cur有左孩子
                while (mostRight.right != null && mostRight.right != cur) {
                    // 找到cur左子树最右节点，要么节点的右指针为空，要么节点的右指针指向当前节点(因为人工改变了指向)
                    mostRight = mostRight.right;
                }
                // 1)mostRight的右孩子指向空，让其指向cur，cur向左移动
                if (mostRight.right == null) {
                    mostRight.right = cur;
                    cur = cur.left;
                    continue;
                } else {
                    // 2)mostRight的右孩子指向cur，让其指向空，cur向右移动
                    mostRight.right = null;
                    // 打印第二次进入节点的左树的右边界的逆序
                    printEdge(cur.left);
                }
            }
            // 打印整棵树的右边界逆序
            printEdge(head);
            // 1.如果cur没有左孩子
            cur = cur.right;
        }
    }
    public static void printEdge(Node head) {
        // 打印整棵树的右树逆序
        // 1.先逆序所有的右节点
        Node tail = reverseEdge(head);
        Node cur = tail;
        while (cur != null) {
            // 2.打印所有右节点
            System.out.print(cur.value + " ");
            cur = cur.right;
        }
        // 3.再还原回来，因为是在原树上处理，没有额外空间
        reverseEdge(tail);
    }
    public static Node reverseEdge(Node from) {
        // 逆序所有的右节点，和链表逆序原理一致
        Node pre = null;
        Node next = null;
        while (from != null) {
            next = from.right;
            from.right = pre;
            pre = from;
            from = next;
        }
        return pre;
    }
```

### 判断是否为二叉搜索树BST

利用Morris序判断是否为二叉搜索树BST,BST定义：左节点小于根，根小于右节点。即中序遍历是依次递增的就是BST.

```
public static boolean isBST(Node head) {
        // 利用Morris序判断是否为二叉搜索树BST,BST定义：左节点小于根，根小于右节点。即中序遍历是依次递增的就是BST.
        if (head == null) {
            // 空，则是BST
            return true;
        }
        // 从头结点开始
        Node cur = head;
        Node mostRight = null;
        Integer pre = null;
        // cur指向null停止，跳出while循环。
        while (cur != null) {
            // cur只要不为null,就一直跑下去
            mostRight = cur.left;
            if (mostRight != null) {
                // 2.如果cur有左孩子
                while (mostRight.right != null && mostRight.right != cur) {
                    // 找到cur左子树最右节点，要么节点的右指针为空，要么节点的右指针指向当前节点(因为人工改变了指向)
                    mostRight = mostRight.right;
                }
                // 1)mostRight的右孩子指向空，让其指向cur，cur向左移动
                if (mostRight.right == null) {
                    mostRight.right = cur;
                    cur = cur.left;
                    continue;
                } else {
                    // 2)mostRight的右孩子指向cur，让其指向空，cur向右移动
                    mostRight.right = null;
                }
            }
            // 中序遍历的所有值，判断前一个大于等于后一个，一定不是BST
            if (pre != null && pre >= cur.value) {
                return false;
            }
            // 指针下移，继续判断下一个
            pre = cur.value;
            // 1.如果cur没有左孩子
            cur = cur.right;
        }
        // 跑完了，不报错就是BST
        return true;
    }
```

### 求二叉树的最小高度

叶节点才有最小高度.

解法1：利用无脑递归

解法2：利用Morris序，有点复杂

```
public class MorrisMinHeight {
    public static void main(String[] args) {
        Node node1 = new Node(1);
        Node node2 = new Node(2);
        node1.right = node2;
        Node node3 = new Node(3);
        node2.left = node3;
        Node node4 = new Node(4);
        Node node5 = new Node(5);
        node3.left = node4;
        node3.right = node5;
        System.out.println(minDepth2(node1));
    }

    public static class Node {
        public int value;
        public Node left;
        public Node right;

        public Node(int data) {
            this.value = data;
        }
    }

    public static int minDepth1(Node head) {
        // 二叉树最小高度，常规递归遍历
        if (head == null) {
            return 0;
        }
        return p(head);
    }

    public static int minDepth2(Node head) {
        // 利用morris遍历改写获取二叉树最小高度
        /*
        1.需要知道当前节点的高度，即curLevel值
        2.每次比较相近的叶节点的高度，判定最小值，最终就是最小高度。
          1)比较左侧的所有叶节点高度
          2)在上面的基础上，比较最右叶节点高度，去最小值即可
        */
        if (head == null) {
            return 1;
        }
        // 从头结点开始
        Node cur = head;
        Node mostRight = null;
        // 当前节点的高度
        int curLevel = 0;
        // 最终返回的最小高度
        int minHeight = Integer.MAX_VALUE;
        // cur指向null停止，跳出while循环。
        while (cur != null) {
            // cur只要不为null,就一直跑下去
            mostRight = cur.left;
            if (mostRight != null) {
                // 定义cur左子树上，右边界的节点个数
                int leftTreeRightSize = 1;
                // 2.如果cur有左孩子
                while (mostRight.right != null && mostRight.right != cur) {
                    // 找到cur左子树最右节点，要么节点的右指针为空，要么节点的右指针指向当前节点(因为人工改变了指向)
                    mostRight = mostRight.right;
                    // 只要有右节点则高度加1
                    leftTreeRightSize++;
                }
                if (mostRight.right == null) {
                    // 第一次到达cur
                    // 说明往左节点去了，高度加1
                    curLevel++;
                    // 1)mostRight的右孩子指向空，让其指向cur，cur向左移动
                    mostRight.right = cur;
                    cur = cur.left;
                    continue;
                } else {
                    // 第二次到达cur
                    if (mostRight.left == null) {
                        // 左节点为空了，说明已经到达叶子节点，判定最小值
                        minHeight = Math.min(minHeight, curLevel);
                    }
                    // 因为是第二次到cur，所以是当前节点-当前树的右边界节点个数
                    curLevel -= leftTreeRightSize;
                    // 2)mostRight的右孩子指向cur，让其指向空，cur向右移动
                    mostRight.right = null;
                }
            } else {
                // 无左节点，直接往右，高度加1
                curLevel++;
            }
            // 1.如果cur没有左孩子
            cur = cur.right;
        }
        // 因为morris序上面的过程是没有计算整树的右边界的最右节点，所以人工把最右节点计算下
        int finalRight = 1;
        cur = head;
        while (cur.right != null) {
            // 不断寻找右节点
            finalRight++;
            cur = cur.right;
        }
        // 最后不要忘了单独看看整棵树的最右节点是不是叶节点
        if (cur.left == null && cur.right == null) {
            // 到了最右的叶子节点，取最小值
            minHeight = Math.min(minHeight, finalRight);
        }
        return minHeight;
    }

    public static int p(Node head) {
        // 左右节点都为空直接返回1
        if (head.left == null && head.right == null) {
            return 1;
        }
        int leftH = Integer.MAX_VALUE;
        if (head.left != null) {
            // 如果左节点为空，则继续遍历左子树
            leftH = p(head.left);
        }
        int rightH = Integer.MAX_VALUE;
        if (head.right != null) {
            // 如果右节点为空，则继续遍历右子树
            rightH = p(head.right);
        }
        // 每次迭代，都深度加1，且取左右子树的最小深度
        return 1 + Math.min(leftH, rightH);
    }
}
```

## 图

### 定义

1. 由点的集合和边的集合组成
2. 虽然存在有向图和无向图，但都可以用有向图来表示
3. 边上可能带有权值

### 图的结构表达

1. 邻接表法
2. 邻接矩阵法
3. 除此之外还有其他众多方法

**邻接表法**

每个节点直接指向的下一个节点。一个表，第一列是当前节点，后面是可到达节点。

A:(B3),(C1)

B:(C2)

C:(A5)

**邻接矩阵法**

节点的nxn矩阵，无穷表示不可达，有值则表示权值。

    A                              B       C

A  无穷(表示不连接)   3       1 

B 无穷                        无穷   2

C 5                              无穷  无穷

### 图的面试题如何搞定

图的算法不算难，只不过coding的代价比较高

1. 先用最熟悉的方式，实验图结构的表达
2. 在自己熟悉的结构上，实现所有常用的图算法作为模板
3. 把面试提供的图结构转化为自己熟悉的图结构，再调用模板或改写即可

```
import java.util.ArrayList;
import java.util.HashMap;
import java.util.HashSet;

public class GraphGenerator {

    public static void main(String[] args) {
        Node nodeA = new Node(0);
        Node nodeB = new Node(1);
        int[][] matrix = {{3, 0, 1}};
        Graph ga = createGraph(matrix);
        System.out.println(ga);
    }

    public static Graph createGraph(int[][] matrix) {
        // 将不熟悉的图结构转化为熟悉的图结构
        // 这种结构不是最精简，但能覆盖大多数题目
        Graph graph = new Graph();
        for (int i = 0; i < matrix.length; i++) {
            // 拿到每一条边， matrix[i]
            // 权值
            int weight = matrix[i][0];
            // 起点
            int from = matrix[i][1];
            // 终点
            int to = matrix[i][2];
            // 是否添加到节点集
            if (!graph.nodes.containsKey(from)) {
                graph.nodes.put(from, new Node(from));
            }
            // 是否添加到节点集
            if (!graph.nodes.containsKey(to)) {
                graph.nodes.put(to, new Node(to));
            }
            // 核心：上述完成图的节点集
            Node fromNode = graph.nodes.get(from);
            Node toNode = graph.nodes.get(to);
            // 创建一个边集
            Edge newEdge = new Edge(weight, fromNode, toNode);
            // 起点加了一个指出的邻接点
            fromNode.nexts.add(toNode);
            // 起点出度加1
            fromNode.out++;
            // 起点添加边集
            fromNode.edges.add(newEdge);
            // 终点入度加1
            toNode.in++;
            // 核心：完成图的边集
            graph.edges.add(newEdge);
        }
        return graph;
    }

    public static class Graph {
        // 熟悉的图结构信息
        // 节点的集合
        public HashMap<Integer, Node> nodes;
        // 节点出去的有向边的集合
        public HashSet<Edge> edges;
        public Graph() {
            nodes = new HashMap<>();
            edges = new HashSet<>();
        }
    }
    public static class Edge {
        // 有向边的信息
        // 权值
        public int weight;
        // 起点
        public Node from;
        // 终点
        public Node to;
        public Edge(int weight, Node from, Node to) {
            this.weight = weight;
            this.from = from;
            this.to = to;
        }
    }
    public static class Node {
        // 节点的信息
        // 节点值
        public int value;
        // 节点的入度即指入的有向边数
        public int in;
        // 节点的出度即指出的有向边数
        public int out;
        // 节点指出的邻接节点
        public ArrayList<Node> nexts;
        // 节点指出的邻接有向边
        public ArrayList<Edge> edges;

        public Node(int val) {
            this.value = val;
            this.in = 0;
            this.out = 0;
            this.nexts = new ArrayList<>();
            this.edges = new ArrayList<>();
        }
    }
}
```

### 图的宽度(广度)优先遍历BFS

**定义：BFS（Breadth First Search）,每一层逐一遍历，同层顺序可任意。**

1. 利用队列实现
2. 从源节点开始依次按照宽度进队列，然后弹出
3. 每弹出一个点，把该节点所有没有进过队列的邻接点放入队列
4. 直到队列变空

```
// 从node出发，进行宽度(广度)优先遍历
    public static void bfs(Node start) {
        if (start == null) {
            return;
        }
        // 准备一个队列，先进先出
        Queue<Node> queue = new LinkedList<>();
        // 准备一个set，登记不允许重复进入
        HashSet<Node> set = new HashSet<>();
        // 入队列
        queue.add(start);
        // 登记
        set.add(start);
        while (!queue.isEmpty()) {
            // 只要队列不为空，就弹出
            Node cur = queue.poll();
            // 出队列即打印
            System.out.println(cur.value);
            // 将当前节点的邻接节点都加入set
            for (Node next : cur.nexts) {
                if (!set.contains(next)) {
                    // 必须是没有被添加过set的节点,否则容易死循环
                    // 登记
                    set.add(next);
                    // 入队列
                    queue.add(next);
                }
            }
        }
    }
```

### 图的深度优先遍历DFS

**定义:DFS（Depth First Search）,一句话，每次都要走到死胡同才走新的路**

1. 利用栈实现
2. 从源节点开始把节点按照深度放入栈，然后弹出
3. 每弹出一个点，把该节点下一个没有进过栈的邻接点放入栈
4. 直到栈变空

```
// 深度优先遍历
    public static void dfs(Node node) {
        if (node == null) {
            return;
        }
        // 栈本质上保存了当前深度的一条路
        Stack<Node> stack = new Stack<>();
        // 登记表
        HashSet<Node> set = new HashSet<>();
        // 压栈
        stack.add(node);
        // 登记
        set.add(node);
        // 每次压栈时打印
        System.out.println(node.value);
        while (!stack.isEmpty()) {
            // 这里会不停的回溯到所有节点，一句话，每次都要走到死胡同才走新的路
            Node cur = stack.pop();
            // 遍历当前节点的所有邻接点
            for (Node next : cur.nexts) {
                if (!set.contains(next)) {
                    // 如果其中一个邻接点没有登记过，则登记并压栈当前节点和邻接点
                    stack.push(cur);
                    stack.push(next);
                    set.add(next);
                    // 每次压栈时打印
                    System.out.println(next.value);
                    // 后续的邻接点直接跳过，因为有回溯
                    break;
                }
            }
        }
    }
```

### 图的拓扑排序算法

1. 在图中找到所有入度为0的点输出
2. 把所有入度为0的点在图中删掉，继续找入度为0的点输出，周而复始
3. 图的所有点都被删除后，依次输出的顺序就是拓扑排序

要求：一定是**有向无环图**即有向图且没有环

应用：事件安排、编译顺序

```
// directed graph and no loop有向无环图的拓扑算法排序
    public static List<Node> sortedTopology(Graph graph) {
        // key 某个节点   value 剩余的入度
        HashMap<Node, Integer> inMap = new HashMap<>();
        // 只有剩余入度为0的点，才进入这个队列
        Queue<Node> zeroInQueue = new LinkedList<>();
        for (Node node : graph.nodes.values()) {
            // 遍历所有图的节点
            inMap.put(node, node.in);
            if (node.in == 0) {
                // 找到第一批入度为0的点
                zeroInQueue.add(node);
            }
        }
        List<Node> result = new ArrayList<>();
        while (!zeroInQueue.isEmpty()) {
            // 周而复始的查找入度为0的节点
            Node cur = zeroInQueue.poll();
            // 弹出队列，并添加到list
            result.add(cur);
            // 遍历当前节点的所有邻接节点
            for (Node next : cur.nexts) {
                // 邻接节点的入度减1
                inMap.put(next, inMap.get(next) - 1);
                if (inMap.get(next) == 0) {
                    // 找到入度为0的点
                    zeroInQueue.add(next);
                }
            }
        }
        return result;
    }
```

### 最小生成树之Kruskal即K算法

**最小生成树定义**：所有的点都连通且无环的最小权值边的集合。

1. 总是从权值最小的边开始考虑，依次考察权值依次变大的边，可用小根堆排序
2. 遍历所有边，当前的边要么进入最小生成树的集合，要么丢弃
3. 如果边的2个节点至少1个不在最小生成树的集合中，就要当前边
4. 如果边的2个节点都在最小生成树的集合中，就不要当前边
5. 考察完所有边之后，最小生成树的集合也得到了

```
import java.util.*;
public class Kruskal {
    public static Set<Edge> kruskalMST(Graph graph) {
        // K算法
        UnionFind unionFind = new UnionFind();
        unionFind.makeSets(graph.nodes.values());
        // 从小的边到大的边，依次弹出，小根堆！
        PriorityQueue<Edge> priorityQueue = new PriorityQueue<>(new EdgeComparator());
        for (Edge edge : graph.edges) { // M 条边
            priorityQueue.add(edge);  // O(logM)
        }
        Set<Edge> result = new HashSet<>();
        // 遍历所有的边集
        while (!priorityQueue.isEmpty()) { // M 条边
            // 依次弹出最小权值的边
            Edge edge = priorityQueue.poll(); // O(logM)
            // 判断边的2个节点是否在最小生成树的集合并查集里
            if (!unionFind.isSameSet(edge.from, edge.to)) { // O(1)
                // 不在，则添加
                result.add(edge);
                unionFind.union(edge.from, edge.to);
            }
        }
        return result;
    }

    // Union-Find Set左神的并查集
    public static class UnionFind {
        // key 某一个节点， value key节点往上的节点
        private HashMap<Node, Node> fatherMap;
        // key 某一个集合的代表节点, value key所在集合的节点个数
        private HashMap<Node, Integer> sizeMap;

        public UnionFind() {
            fatherMap = new HashMap<Node, Node>();
            sizeMap = new HashMap<Node, Integer>();
        }

        public void makeSets(Collection<Node> nodes) {
            fatherMap.clear();
            sizeMap.clear();
            for (Node node : nodes) {
                fatherMap.put(node, node);
                sizeMap.put(node, 1);
            }
        }

        private Node findFather(Node n) {
            Stack<Node> path = new Stack<>();
            while (n != fatherMap.get(n)) {
                path.add(n);
                n = fatherMap.get(n);
            }
            while (!path.isEmpty()) {
                fatherMap.put(path.pop(), n);
            }
            return n;
        }

        public boolean isSameSet(Node a, Node b) {
            return findFather(a) == findFather(b);
        }

        public void union(Node a, Node b) {
            if (a == null || b == null) {
                return;
            }
            Node aDai = findFather(a);
            Node bDai = findFather(b);
            if (aDai != bDai) {
                int aSetSize = sizeMap.get(aDai);
                int bSetSize = sizeMap.get(bDai);
                if (aSetSize <= bSetSize) {
                    fatherMap.put(aDai, bDai);
                    sizeMap.put(bDai, aSetSize + bSetSize);
                    sizeMap.remove(aDai);
                } else {
                    fatherMap.put(bDai, aDai);
                    sizeMap.put(aDai, aSetSize + bSetSize);
                    sizeMap.remove(bDai);
                }
            }
        }
    }

    public static class EdgeComparator implements Comparator<Edge> {
        @Override
        public int compare(Edge o1, Edge o2) {
            return o1.weight - o2.weight;
        }
    }
}
```

### 最小生成树之Prim即P算法

核心：点解锁边，边解锁点，点解锁边...不断重复下去，直到所有点加入集合中

定义一个已解锁点集合nodeSet和一个已解锁边集合edgeSet

1. 随机选择一个点加入nodeSet中，并将与它相连的边加入edgeSet。假设我们选择了A点
2. 选择已解锁边集合中权值最小且边的另一个点不在已解锁点集合中，选择后将该边从已解锁边集合删除，并把另一个点加入已解锁点集合中
3. 重复第②步直到所有的点加入了已解锁集合

```
import java.util.*;
public class Prim {
    //定义一个堆比较器，将边的权值从小到大排序
    public static class EdgeComparator implements Comparator<Edge> {
        @Override
        public int compare(Edge o1, Edge o2) {
            // TODO Auto-generated method stub
            return o1.weight - o2.weight;
        }
    }

    public static Set<Edge> primSet(Graph graph) {
        // P算法
        // 优先级队列，按照从小到大排序
        PriorityQueue<Edge> priorityQueue = new PriorityQueue<>(new EdgeComparator());
        //解锁出来的Node
        HashSet<Node> nodeSet = new HashSet<>();
        //解锁出来的edge,也可以不用，用了可以提高效率和去重
        HashSet<Edge> edgeSet = new HashSet<>();

        ArrayList<Integer> list = new ArrayList<>();
        Set<Edge> result = new HashSet<>();    //依次挑选的边放在result
        for (Node node : graph.nodes.values()) {    //随便挑了一个点,此for循环防止出现森林即多个独立的图
            //node是开始点，任意点开始
            if (!nodeSet.contains(node)) {
                // 当前节点不在集合中，则可解锁
                nodeSet.add(node);
                // 点解锁边
                for (Edge edge : node.edges) {    //由该点解锁所有相关的边
                    if (!edgeSet.contains(edge)) {
                        // 过滤当前节点没有被解锁的边集
                        priorityQueue.add(edge);
                        edgeSet.add(edge);
                    }
                }
                // 逐一遍历已解锁的最小权值的边集
                while (!priorityQueue.isEmpty()) {
                    Edge edge = priorityQueue.poll();    //弹出已解锁边中的最小边
                    Node toNode = edge.to;    //可能的新一个节点
                    // 边解锁点
                    if (!nodeSet.contains(toNode)) {
                        nodeSet.add(toNode);
                        result.add(edge);
                    }
                    // 点解锁边
                    for (Edge nextEdge : toNode.edges) {
                        if (!edgeSet.contains(nextEdge)) {
                            priorityQueue.add(nextEdge);
                            edgeSet.add(nextEdge);
                        }
                    }
                }
            }
            break;
        }
        return result;
    }
}
```

### 最短路径算法之Dijkstra算法

**狄利克斯拉算法**是从一个顶点到其余各顶点的最短路径算法，解决的是有权图中最短路径问题。 迪杰斯特拉算法主要特点是从起始点开始，采用贪心算法的策略，每次遍历到始点距离最近且未访问过的顶点的邻接节点，直到扩展到终点为止。

- 解法1：贪心法遍历所有节点
- 解法2：改进后的dijkstra算法，就是利用动态小根堆，优化getMinDistanceAndUnselectedNode方法。

```
import java.util.ArrayList;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Map.Entry;

public class Code06_Dijkstra {
    // 狄利克斯拉算法
    public static class Edge {
        // 有向边的信息
        // 权值
        public int weight;
        // 起点
        public Node from;
        // 终点
        public Node to;
        public Edge(int weight, Node from, Node to) {
            this.weight = weight;
            this.from = from;
            this.to = to;
        }
    }

    public static class Node {
        // 节点的信息
        // 节点值
        public int value;
        // 节点的入度即指入的有向边数
        public int in;
        // 节点的出度即指出的有向边数
        public int out;
        // 节点指出的邻接节点
        public ArrayList<Node> nexts;
        // 节点指出的邻接有向边
        public ArrayList<Edge> edges;

        public Node(int val) {
            this.value = val;
            this.in = 0;
            this.out = 0;
            this.nexts = new ArrayList<>();
            this.edges = new ArrayList<>();
        }
    }

    // 解法1：贪心法遍历所有节点
    public static HashMap<Node, Integer> dijkstra1(Node from) {
        // 狄利克斯拉算法:从任意一个点出发，得到一个map的最小距离表
        HashMap<Node, Integer> distanceMap = new HashMap<>();
        // 键表示默认form-key，比如from到from,所以距离为0
        distanceMap.put(from, 0);
        // 已经计算好的节点，把它锁定
        HashSet<Node> selectedNodes = new HashSet<>();
        // 在剩下已有的最短距离表中，剔除掉锁定算好的节点，依次找出最小距离的点。定义为当前最小距离点
        Node minNode = getMinDistanceAndUnselectedNode(distanceMap, selectedNodes);
        while (minNode != null) {
            //  原始点form  ->  minNode(跳转点)   最小距离distance
            int distance = distanceMap.get(minNode);
            // 取出最小距离点的所有指向边
            for (Edge edge : minNode.edges) {
                // 遍历所有的边，以便接下来完成该点的更新
                Node toNode = edge.to;
                if (!distanceMap.containsKey(toNode)) {
                    // 如果最小距离表中没有该节点，直接添加。注意需要加上之前的距离
                    distanceMap.put(toNode, distance + edge.weight);
                } else { // toNode
                    // 如果添加过，则判断过去的值与当前值，取最小值更新
                    distanceMap.put(edge.to, Math.min(distanceMap.get(toNode), distance + edge.weight));
                }
            }
            // 当前最小距离点计算完后，就锁定，后续不再更新它的最短距离，完成该点的更新
            selectedNodes.add(minNode);
            // 继续找下一个当前最小距离点
            minNode = getMinDistanceAndUnselectedNode(distanceMap, selectedNodes);
        }
        return distanceMap;
    }

    public static Node getMinDistanceAndUnselectedNode(HashMap<Node, Integer> distanceMap, HashSet<Node> touchedNodes) {
        // 方法名很长，很唬人，本质是返回最小距离表中，未被锁定且最小距离的节点。方便后续继续计算最短记录。
        Node minNode = null;
        int minDistance = Integer.MAX_VALUE;
        for (Entry<Node, Integer> entry : distanceMap.entrySet()) {
            // 遍历最小距离表
            Node node = entry.getKey();
            int distance = entry.getValue();
            if (!touchedNodes.contains(node) && distance < minDistance) {
                // 找出最小距离表中，未被锁定且最小距离的节点
                minNode = node;
                minDistance = distance;
            }
        }
        return minNode;
    }

    public static class NodeRecord {
        // 最小距离表的节点
        public Node node;
        // 最短距离
        public int distance;

        public NodeRecord(Node node, int distance) {
            this.node = node;
            this.distance = distance;
        }
    }

    public static class NodeHeap {
        // 动态小根堆结构
        private Node[] nodes; // 实际的堆结构
        // 节点索引记录表：key 某一个node， value 上面堆中的位置
        private HashMap<Node, Integer> heapIndexMap;
        // key 某一个节点， value 从源节点出发到该节点的目前最小距离
        private HashMap<Node, Integer> distanceMap;
        private int size; // 堆上有多少个点

        public NodeHeap(int size) {
            nodes = new Node[size];
            heapIndexMap = new HashMap<>();
            distanceMap = new HashMap<>();
            size = 0;
        }

        public boolean isEmpty() {
            return size == 0;
        }

        // 有一个点叫node，现在发现了一个从源节点出发到达node的距离为distance
        // 集成添加，更新，直接跳过
        public void addOrUpdateOrIgnore(Node node, int distance) {
            // 已经在小根堆里，更新最小距离，然后上窜
            if (inHeap(node)) {
                // 更新最短距离
                distanceMap.put(node, Math.min(distanceMap.get(node), distance));
                // 上窜
                insertHeapify(heapIndexMap.get(node));
            }
            // 没有进去过记录表的，直接添加，然后上窜
            if (!isEntered(node)) {
                nodes[size] = node;
                heapIndexMap.put(node, size);
                distanceMap.put(node, distance);
                // 上窜
                insertHeapify(size++);
            }
            // 已经记录并更新的节点，锁定，直接跳过
        }

        // 弹出小根堆顶部最小值，并继续小根堆化
        public NodeRecord pop() {
            NodeRecord nodeRecord = new NodeRecord(nodes[0], distanceMap.get(nodes[0]));
            swap(0, size - 1);
            heapIndexMap.put(nodes[size - 1], -1);
            distanceMap.remove(nodes[size - 1]);
            // free C++同学还要把原本堆顶节点析构，对java同学不必
            nodes[size - 1] = null;
            // 下窜
            heapify(0, --size);
            return nodeRecord;
        }

        // 上窜
        private void insertHeapify(int index) {
            while (distanceMap.get(nodes[index]) < distanceMap.get(nodes[(index - 1) / 2])) {
                swap(index, (index - 1) / 2);
                index = (index - 1) / 2;
            }
        }

        // 下窜
        private void heapify(int index, int size) {
            int left = index * 2 + 1;
            while (left < size) {
                int smallest = left + 1 < size && distanceMap.get(nodes[left + 1]) < distanceMap.get(nodes[left])
                        ? left + 1
                        : left;
                smallest = distanceMap.get(nodes[smallest]) < distanceMap.get(nodes[index]) ? smallest : index;
                if (smallest == index) {
                    break;
                }
                swap(smallest, index);
                index = smallest;
                left = index * 2 + 1;
            }
        }

        private boolean isEntered(Node node) {
            return heapIndexMap.containsKey(node);
        }

        private boolean inHeap(Node node) {
            return isEntered(node) && heapIndexMap.get(node) != -1;
        }

        private void swap(int index1, int index2) {
            heapIndexMap.put(nodes[index1], index2);
            heapIndexMap.put(nodes[index2], index1);
            Node tmp = nodes[index1];
            nodes[index1] = nodes[index2];
            nodes[index2] = tmp;
        }
    }

    // 解法2：改进后的dijkstra算法，就是利用动态小根堆，优化getMinDistanceAndUnselectedNode方法。
    // 从head出发，所有head能到达的节点，生成到达每个节点的最小路径记录并返回
    public static HashMap<Node, Integer> dijkstra2(Node head, int size) {
        NodeHeap nodeHeap = new NodeHeap(size);
        // 从0开始更新
        nodeHeap.addOrUpdateOrIgnore(head, 0);
        HashMap<Node, Integer> result = new HashMap<>();
        while (!nodeHeap.isEmpty()) {
            // 从小根堆汇总逐一弹出顶部节点
            NodeRecord record = nodeHeap.pop();
            Node cur = record.node;
            int distance = record.distance;
            // 遍历节点的所有指向边
            for (Edge edge : cur.edges) {
                // 继续更新最短距离点
                nodeHeap.addOrUpdateOrIgnore(edge.to, edge.weight + distance);
            }
            // 更新一个节点，锁定一个，返回一个
            result.put(cur, distance);
        }
        return result;
    }
}
```

### TSP问题

也叫商旅问题，非常之难。问题：给定一系列城市和每对城市之间的距离，求解访问每一座城市一次并回到起始城市的最短回路。

### 单词接龙 

题目：给出两个单词（`start`和`end`）和一个字典，找出所有从`start`到`end`的最短转换序列。

变换规则如下：

1. 每次只能改变一个字母。
2. 变换过程中的中间单词必须在字典中出现。

- 解法1：图的宽度优先遍历和深度优先遍历的最强综合应用。返回从start变换到end的所有最短路径集合

```
import java.util.ArrayList;
import java.util.HashMap;
import java.util.HashSet;
import java.util.LinkedList;
import java.util.List;
import java.util.Queue;
// 本题测试链接 : https://leetcode.com/problems/word-ladder-ii/
public class Code04_WordLadderII {
   // 解法1：图的宽度优先遍历和深度优先遍历的最强综合应用。返回从start变换到end的所有最短路径集合
   public static List<List<String>> findLadders(String start, String end, List<String> list) {
      list.add(start);
      // 返回list列表的,每个字符串对应的所有直接邻居(限制在当前list)。因为是所有list元素的直接邻居，可以认为是一张list节点的图
      HashMap<String, List<String>> nexts = getNexts(list);
      // 在图的结构中，获取所有节点到start节点的最短距离，利用宽度优先遍历求解，横向一直走，只保留距离+1的节点
      HashMap<String, Integer> fromDistances = getDistances(start, nexts);
      List<List<String>> res = new ArrayList<>();
      // 如果最短距离列表中，没有目的节点，那么一定不能变换，返回空
      if (!fromDistances.containsKey(end)) {
         return res;
      }
      // 同上
      HashMap<String, Integer> toDistances = getDistances(end, nexts);
      LinkedList<String> pathList = new LinkedList<>();
      // 获取最短路径，入参：从start当前节点变换到ends字符串，nexts是邻居表，fromDistances是当前节点到start节点的距离，toDistances是当前节点到end节点的距离，pathList表示实时路径，res是最终路径集合
      getShortestPaths(start, end, nexts, fromDistances, toDistances, pathList, res);
      return res;
   }

   public static HashMap<String, List<String>> getNexts(List<String> words) {
      HashSet<String> dict = new HashSet<>(words);
      HashMap<String, List<String>> nexts = new HashMap<>();
      for (int i = 0; i < words.size(); i++) {
         nexts.put(words.get(i), getNext(words.get(i), dict));
      }
      return nexts;
   }

   // word, 在表中，有哪些邻居，把邻居们，生成list返回
   public static List<String> getNext(String word, HashSet<String> dict) {
      ArrayList<String> res = new ArrayList<String>();
      char[] chs = word.toCharArray();
      for (char cur = 'a'; cur <= 'z'; cur++) {
         for (int i = 0; i < chs.length; i++) {
            if (chs[i] != cur) {
               char tmp = chs[i];
               chs[i] = cur;
               if (dict.contains(String.valueOf(chs))) {
                  res.add(String.valueOf(chs));
               }
               chs[i] = tmp;
            }
         }
      }
      return res;
   }

   // 图的宽度优先遍历：生成距离表，从start开始，根据邻居表，宽度优先遍历，对于能够遇到的所有字符串，生成(字符串，距离)这条记录，放入距离表中
   public static HashMap<String, Integer> getDistances(String start, HashMap<String, List<String>> nexts) {
      HashMap<String, Integer> distances = new HashMap<>();
      distances.put(start, 0);
      Queue<String> queue = new LinkedList<>();
      queue.add(start);
      HashSet<String> set = new HashSet<>();
      set.add(start);
      while (!queue.isEmpty()) {
         String cur = queue.poll();
         for (String next : nexts.get(cur)) {
            if (!set.contains(next)) {
               distances.put(next, distances.get(cur) + 1);
               queue.add(next);
               set.add(next);
            }
         }
      }
      return distances;
   }

   // cur 当前来到的字符串 可变
   // to 目标，固定参数
   // nexts 每一个字符串的邻居表
   // cur 到开头距离5 -> 到开头距离是6的支路 fromDistances距离表
   // cur 到结尾距离5 -> 到开头距离是4的支路 toDistances距离表
   // path : 来到cur之前，深度优先遍历之前的历史是什么
   // res : 当遇到cur，把历史，放入res，作为一个结果
   // 图的深度优先遍历
   public static void getShortestPaths(String cur, String to, HashMap<String, List<String>> nexts,
         HashMap<String, Integer> fromDistances, HashMap<String, Integer> toDistances, LinkedList<String> path,
         List<List<String>> res) {
      // 直接添加当前节点
      path.add(cur);
      if (to.equals(cur)) {
         // 当前节点和目的节点相同，说明变换成功了，直接记录一条路径
         res.add(new LinkedList<String>(path));
      } else {
         // 递归邻居表
         for (String next : nexts.get(cur)) {
            // 当下一个节点放进来后，往前的距离+1，往后的距离-1，才进行递归
            if (fromDistances.get(next) == fromDistances.get(cur) + 1
                  && toDistances.get(next) == toDistances.get(cur) - 1) {
               getShortestPaths(next, to, nexts, fromDistances, toDistances, path, res);
            }
         }
      }
      // 如果不满足上述条件，需要弹出前面添加的节点，路径重新添加分支走下去
      path.pollLast();
   }
}
```

## 动态规划

### 核心

重要重要重要：笔试最差也要改为傻缓存dp表跟随的动态规划（也就是记忆化搜索方法），面试尽可能改为精细化动态规划填dp表

**动态规划的终极套路**

1. 先写*暴力递归的尝试过程*
2. 将暴力递归改为为*记忆化搜索*即带缓存的暴力递归，leetcode能通过。记忆化搜索也是dp的一种。
3. 用dp状态转移方程精细化后变成*动态规划*，leetcode能通过

> **动态规划的4种经典尝试模型**
>
> 1. **DP1：从左往右的尝试模型**，关注i位置结尾，或者i位置开头的情况，或者看i联合i+1,i+2的情况，填表往往是上到下，或者下到上，左到右，右到左。
> 2. **DP2：从L–R范围上的尝试模型**，关注L和R的情况，填表格式非常固定，主对角，副对角，倒回来填
> 3. **DP3：多样本位置对应的尝试模型**，2个样本，一个样本做行，一个样本做列，关注i和j对应位置的情况，先填边界，再填中间
> 4. **DP4：业务限制类的尝试模型**，比如走棋盘，固定的几个方向可以走，先填边界，再填中间。

> **记忆化搜索即带缓存的暴力递归-leetcode通过**
>
> 用缓存dp替代暴力递归中的重复计算过程。
>
> 暴力递归改为记忆化搜索套路：
>
> * (1)先判断下重复过程，dp跟几个参数有关就是几维数组。
> * (2)递归过程一定携带dp,注意递归还是递归，不改
> * (3)return的地方改写为取dp值，注意先缓存，再返回值

> **动态规划-leetcode通过**
>
> 将记忆化搜索或暴力递归，直接改写为填写dp表，返回结果需要用到的dp值。前提：需要将记忆化搜索直观的转成可理解的dp表，最好画图。
>
> 暴力递归改为dp动态规划套路：
>
> * (1)return的地方就是设置dp值
> * (2)添加遍历，注意是dp是几维数组就是几维遍历，关键分析是从左到右，还是从上到下，这个重要
> * (3)所有递归调用的地方，直接改为dp。这里需要注意前面return的，就是这里的限制条件。
>   这里的本质：填写dp表，把最终的结果用dp表的值返回

**任何一个暴力递归优化成结构化描述的动态规划，需要满足两个条件：**

- 暴力递归中有重复计算的过程
- 有限的可变参数影响结果

不满足以上2个条件的暴力递归，要么无法改为动态规划(不是有限可变参数)，要么即使改成动态规划也意义不大(没有重复过程，缓存没有意义)。

### 暴力递归

暴力递归就是尝试

1. 把问题转化为规模缩小的同类问题的子问题
2. 有明确的不需要继续进行递归的条件(base case)
3. 有当得到了子问题的结果之后的决策过程
4. 不记录每一个子问题的解。如果真的要记录了，就是动态规划了

**熟悉什么叫尝试**

- 1.打印n层汉诺塔从最左边移动到最右边的全过程
- 2.打印一个字符串的全部子序列
- 3.打印一个字符串的全部子序列，要求不重复的字面值的子序列,如abcdac可能出现重复
- 4.打印一个字符串的全部排列
- 5.打印一个字符串的全部排列，要求不重复的排列

**子串、子序列、排列区别：**

例子：abcd

- 子串：连续的有序，a,ab,abc,abcd,b,bc,bcd,c,cd
- 子序列：不连续有序，是a,b,c,d,ab,ac,ad,bc,bd,cd,abc,abd,acd,abcd
- 全排列：不连续无序，abcd,abdc,acbd,acdb...
- 排列组合：不连续无序，a,b,c,ab,ac,ad....

**1.汉诺塔问题**

题目：三个柱子，A、B、C，在A柱子上从上到下依次放着从小到大的盘子，每次只能拿一个盘子，怎么把盘子搬动到另外的柱子上而保证盘子的大小顺序完全一致？要求搬动过程中，必须保证大盘子在下，小盘子在上。

思路：核心就是拆解为三大步,假设三个柱子是from other to。N层汉诺塔问题的步数一定是**2^N-1**步。

> 第一步：1到N-1个盘子从from移动到other,腾位置给后续第N个盘子移动
>
> 第二步：第N个盘子从from移动到to
>
> 第三步：1到N-1个盘子从other移动到to。搞定

- 解法1：暴力递归的三步曲
- 解法2：暴力递归的三部曲优化为from起点,to终点,other其他.推荐
- 解法3：非递归方法，利用栈模拟递归调用，关键参数base表示多少层，finish1表示第一步是否完成。

```
import java.util.Stack;
public class Code02_Hanoi {
    public static void hanoi1(int n) {
        // 解法1：暴力递归的三步曲
        leftToRight(n);
    }

    // 请把1~N层圆盘 从左 -> 右
    public static void leftToRight(int n) {
        // 明确的不需要继续进行递归的条件(base case)即左边只剩下一个N号盘子，直接移动过去
        if (n == 1) { // base case
            System.out.println("Move 1 from left to right");
            return;
        }
        // 第一步：1到N-1个盘子从from移动到other,腾位置给后续第N个盘子移动
        leftToMid(n - 1);
        // 第二步：第N个盘子从from移动到to
        System.out.println("Move " + n + " from left to right");
        // 第三步：1到N-1个盘子从other移动到to。
        midToRight(n - 1);
    }

    // 请把1~N层圆盘 从左 -> 中
    public static void leftToMid(int n) {
        // 同上一样的三步曲
        if (n == 1) {
            System.out.println("Move 1 from left to mid");
            return;
        }
        leftToRight(n - 1);
        System.out.println("Move " + n + " from left to mid");
        rightToMid(n - 1);
    }

    public static void rightToMid(int n) {
        // 同上一样的三步曲
        if (n == 1) {
            System.out.println("Move 1 from right to mid");
            return;
        }
        rightToLeft(n - 1);
        System.out.println("Move " + n + " from right to mid");
        leftToMid(n - 1);
    }

    public static void midToRight(int n) {
        // 同上一样的三步曲
        if (n == 1) {
            System.out.println("Move 1 from mid to right");
            return;
        }
        midToLeft(n - 1);
        System.out.println("Move " + n + " from mid to right");
        leftToRight(n - 1);
    }

    public static void midToLeft(int n) {
        // 同上一样的三步曲
        if (n == 1) {
            System.out.println("Move 1 from mid to left");
            return;
        }
        midToRight(n - 1);
        System.out.println("Move " + n + " from mid to left");
        rightToLeft(n - 1);
    }

    public static void rightToLeft(int n) {
        // 同上一样的三步曲
        if (n == 1) {
            System.out.println("Move 1 from right to left");
            return;
        }
        rightToMid(n - 1);
        System.out.println("Move " + n + " from right to left");
        midToLeft(n - 1);
    }

    public static void hanoi2(int n) {
        // 解法2：暴力递归的三部曲优化为from起点,to终点,other其他.
        if (n > 0) {
            func(n, "left", "right", "mid");
        }
    }

    // n个盘子，从from移动到to,借助other
    public static void func(int N, String from, String to, String other) {
        if (N == 1) { // base case
            // 最后form剩下N号盘子，直接移动过去
            System.out.println("Move 1 from " + from + " to " + to);
        } else {
            // from还有盘子话
            // 第一步：1到N-1个盘子从from移动到other,腾位置
            func(N - 1, from, other, to);
            // 第二步：第N个盘子从from移动到to
            System.out.println("Move " + N + " from " + from + " to " + to);
            // 第三步：1到N-1个盘子从other移动到to。搞定
            func(N - 1, other, to, from);
        }
    }

    public static class Record {
        public boolean finish1;
        public int base;
        public String from;
        public String to;
        public String other;

        public Record(boolean f1, int b, String f, String t, String o) {
            finish1 = false;
            base = b;
            from = f;
            to = t;
            other = o;
        }
    }

    // 解法3：非递归方法，利用栈模拟递归调用，关键参数base表示多少层，finish1表示第一步是否完成。
    public static void hanoi3(int N) {
        if (N < 1) {
            return;
        }
        Stack<Record> stack = new Stack<>();
        stack.add(new Record(false, N, "left", "right", "mid"));
        while (!stack.isEmpty()) {
            Record cur = stack.pop();
            if (cur.base == 1) {
                // 第二步：第N个盘子从from移动到to
                System.out.println("Move 1 from " + cur.from + " to " + cur.to);
                if (!stack.isEmpty()) {
                    stack.peek().finish1 = true;
                }
            } else {
                if (!cur.finish1) {
                    // 表示没完成
                    stack.push(cur);
                    // 第一步：1到N-1个盘子从from移动到other,腾位置
                    stack.push(new Record(false, cur.base - 1, cur.from, cur.other, cur.to));
                } else {
                    // 第一步完成了，执行下面
                    System.out.println("Move " + cur.base + " from " + cur.from + " to " + cur.to);
                    // 第三步：1到N-1个盘子从other移动到to。搞定
                    stack.push(new Record(false, cur.base - 1, cur.other, cur.to, cur.from));
                }
            }
        }
    }

    public static void main(String[] args) {
        int n = 3;
        hanoi1(n);
        System.out.println("============");
        hanoi2(n);
        System.out.println("============");
  hanoi3(n);
    }
}
```

**2.打印一个字符串的全部子序列**

```
// 打印一个字符串的全部子序列
public static List<String> subs(String s) {
        char[] str = s.toCharArray();
        String path = "";
        List<String> ans = new ArrayList<>();
        process1(str, 0, ans, path);
        return ans;
    }

    // str 固定参数
    // 来到了str[index]字符，index是位置
    // str[0..index-1]已经走过了！之前的决定，都在path上
    // 之前的决定已经不能改变了，就是path
    // str[index....]还能决定，之前已经确定，而后面还能自由选择的话，
    // 把所有生成的子序列，放入到ans里去
    public static void process1(char[] str, int index, List<String> ans, String path) {
        // 索引已经来到最后一个字符，找到了字符串，加入到list
        if (index == str.length) {
            ans.add(path);
            return;
        }
        // 分支左：没有要index位置的字符，path继续
        process1(str, index + 1, ans, path);
        // 分支右：要了index位置的字符，path拼接起来
        process1(str, index + 1, ans, path + String.valueOf(str[index]));
    }
```

**3.打印一个字符串的全部子序列，要求不重复的字面值的子序列,如abcdac可能出现重复**

```
   // 打印一个字符串的全部子序列，要求不重复的字面值的子序列,如abcdac可能出现重复。
   public static List<String> subsNoRepeat(String s) {
        // 最终结果使用set集合即可，同题目2，99%相似
        char[] str = s.toCharArray();
        String path = "";
        HashSet<String> set = new HashSet<>();
        process2(str, 0, set, path);
        List<String> ans = new ArrayList<>();
        for (String cur : set) {
            ans.add(cur);
        }
        return ans;
    }

    public static void process2(char[] str, int index, HashSet<String> set, String path) {
        if (index == str.length) {
            set.add(path);
            return;
        }
        String no = path;
        process2(str, index + 1, set, no);
        String yes = path + String.valueOf(str[index]);
        process2(str, index + 1, set, yes);
    }
```

**4.打印一个字符串的全部排列**

```
    public static List<String> permutation2(String s) {
        // 打印一个字符串的全部排列
        List<String> ans = new ArrayList<>();
        if (s == null || s.length() == 0) {
            return ans;
        }
        char[] str = s.toCharArray();
        g1(str, 0, ans);
        return ans;
    }

    public static void g1(char[] str, int index, List<String> ans) {
        // 索引已经来到最后一个字符，找到了字符串，加入到list
        if (index == str.length) {
            ans.add(String.valueOf(str));
        } else {
            // 尝试将索引值index及其后续的字符交换到index上，找到字符串
            for (int i = index; i < str.length; i++) {
                // 交换
                swap(str, index, i);
                // 递归下一个索引值
                g1(str, index + 1, ans);
                // 每次交换完，再恢复到原始现场，方便下次递归使用原始变量
                swap(str, index, i);
            }
        }
    }
```

**5.打印一个字符串的全部排列，要求不重复的排列**

最终结果也可以使用set集合即可，同题目4，99%相似。

优化方法：利用分支限界，提前杀死分支支路。即出现过的字符，则不再执行逻辑。

```
    public static List<String> permutation3(String s) {
        List<String> ans = new ArrayList<>();
        if (s == null || s.length() == 0) {
            return ans;
        }
        char[] str = s.toCharArray();
        g2(str, 0, ans);
        return ans;
    }
    public static void g2(char[] str, int index, List<String> ans) {
        if (index == str.length) {
            ans.add(String.valueOf(str));
        } else {
            // 分支限界，visited类似hash表记录字符是否已被使用过
            boolean[] visited = new boolean[256];
            for (int i = index; i < str.length; i++) {
                if (!visited[str[i] - 'a']) {
                    // 使用过的字符，不再使用
                    visited[str[i] - 'a'] = true;
                    swap(str, index, i);
                    g2(str, index + 1, ans);
                    swap(str, index, i);
                }
            }
        }
    }
```

**栈的逆序**

题目：给你一个栈，请你逆序这个栈。不能申请额外的数据结构。只能使用递归函数。如何实现。

思路：递归自己一级一级捋。

```
import java.util.Stack;
public class Code05_ReverseStackUsingRecursive {
    public static void reverse(Stack<Integer> stack) {
        if (stack.isEmpty()) {
            return;
        }
        // i临时记录栈底的元素，并剩余元素盖下来
        int i = f(stack);
        // 递归调用反转函数
        reverse(stack);
        // 先压入1，然后2，然后3
        stack.push(i);
    }

    // 功能：返回移除掉的栈底元素，上面的元素盖下来。
    /*
     * 1
     * 2         1
     * 3         2
     * 栈，返回3，栈
     * */
    public static int f(Stack<Integer> stack) {
        // r临时记录栈顶元素，最后是要返回的
        int result = stack.pop();
        if (stack.isEmpty()) {
            return result;
        } else {
            // l临时记录栈底元素
            int last = f(stack);
            // 栈底的元素再压进来，这样每次都是先压上面的
            stack.push(result);
            return last;
        }
    }

    public static void main(String[] args) {
        Stack<Integer> test = new Stack<Integer>();
        test.push(1);
        test.push(2);
        test.push(3);
        test.push(4);
        test.push(5);
        reverse(test);
        while (!test.isEmpty()) {
            System.out.println(test.pop());
        }
    }
}
```

### 尝试模型

#### 从左往右的尝试模型1-字符串转化

题目：规定1和A对应，2和B对应，3和C对应，那么一串“111”可以转化为“AAA”，“KA”，“AK”三种转化结果。问给定一个只有数字字符组成的字符串str,有多少种转化结果。

- 解法1：暴力递归的尝试过程
- 解法2：记忆化搜索即带缓存dp的暴力递归

```
public class Code02_ConvertToLetterString {
    // str只含有数字字符0~9
    // 返回多少种转化方案
    public static int number(String str) {
        // 解法1：暴力递归的尝试过程
        // 边界条件
        if (str == null || str.length() == 0) {
            return 0;
        }
        // 记录从0开始往后有多少种转换方法
        return process(str.toCharArray(), 0);
    }

    // str[0..i-1]转化无需过问
    // 表示str[i.....]去转化，返回有多少种转化方法
    public static int process(char[] str, int i) {
        // i到最后，说明没有有字符，记录一种转化方法
        if (i == str.length) {
            return 1;
        }
        // 单独的0是不能记录为一种转化方法的
        if (str[i] == '0') { // 之前的决定有问题
            return 0;
        }
        // str[i] != '0'
        // 可能性一，1-9都是可以单独转换的，i不用管,继续往后转换，从i+1开始，有多少种转换
        int ways = process(str, i + 1);
        // 可能性二，10到26即小于27的两位数都是可以转换的
        if (i + 1 < str.length && (str[i] - '0') * 10 + str[i + 1] - '0' < 27) {
            // 继续向后转换
            ways += process(str, i + 2);
        }
        return ways;
    }

    // 从右往左的动态规划
    // 就是上面方法的动态规划版本
    // dp[i]表示：str[i...]有多少种转化方式
    public static int dp1(String s) {
        // 解法2：暴力递归改为dp动态规划
        /*暴力递归改为dp动态规划的核心核心，重要重要重要
         * (1)return的地方就是设置dp值
         * (2)添加遍历，注意是dp是几维数组就是几维遍历，关键分析是从左到右，还是从上到下，这个重要
         * (3)所有递归调用的地方，直接改为dp。这里需要注意前面return的，就是这里的限制条件。
         * */
        if (s == null || s.length() == 0) {
            return 0;
        }
        char[] str = s.toCharArray();
        int N = str.length;
        // 开始改写为dp。因为每个所有的字符都要用到，所以N也要。那么久需要N+1的长度。
        int[] dp = new int[N + 1];
        /*dp对应的暴力代码
        if (i == str.length) {
            return 1;
        }*/
        // return的地方就是设置dp值
        dp[N] = 1;
        // 因为dp是一维数组
        // 前面的值依赖后面的值，所以从右往左遍历
        for (int i = N - 1; i >= 0; i--) {
            // 因为前面的return,所以加限制条件
            if (str[i] != '0') {
                // 递归调用的地方，直接改为dp
                int ways = dp[i + 1];
                if (i + 1 < str.length && (str[i] - '0') * 10 + str[i + 1] - '0' < 27) {
                    ways += dp[i + 2];
                }
                // return的地方就是设置dp值
                dp[i] = ways;
            }
        }
        // 因为暴力递归是要return process(str.toCharArray(), 0);返回0转态的，所以是0
        return dp[0];
    }

    // 从左往右的动态规划
    // dp[i]表示：str[0...i]有多少种转化方式
    public static int dp2(String s) {
        if (s == null || s.length() == 0) {
            return 0;
        }
        char[] str = s.toCharArray();
        int N = str.length;
        if (str[0] == '0') {
            return 0;
        }
        int[] dp = new int[N];
        dp[0] = 1;
        for (int i = 1; i < N; i++) {
            if (str[i] == '0') {
                // 如果此时str[i]=='0'，那么他是一定要拉前一个字符(i-1的字符)一起拼的，
                // 那么就要求前一个字符，不能也是‘0’，否则拼不了。
                // 前一个字符不是‘0’就够了嘛？不够，还得要求拼完了要么是10，要么是20，如果更大的话，拼不了。
                // 这就够了嘛？还不够，你们拼完了，还得要求str[0...i-2]真的可以被分解！
                // 如果str[0...i-2]都不存在分解方案，那i和i-1拼成了也不行，因为之前的搞定不了。
                if (str[i - 1] == '0' || str[i - 1] > '2' || (i - 2 >= 0 && dp[i - 2] == 0)) {
                    return 0;
                } else {
                    dp[i] = i - 2 >= 0 ? dp[i - 2] : 1;
                }
            } else {
                dp[i] = dp[i - 1];
                if (str[i - 1] != '0' && (str[i - 1] - '0') * 10 + str[i] - '0' <= 26) {
                    dp[i] += i - 2 >= 0 ? dp[i - 2] : 1;
                }
            }
        }
        return dp[N - 1];
    }

    // 为了测试
    public static String randomString(int len) {
        char[] str = new char[len];
        for (int i = 0; i < len; i++) {
            str[i] = (char) ((int) (Math.random() * 10) + '0');
        }
        return String.valueOf(str);
    }

    // 为了测试
    public static void main(String[] args) {
        int N = 30;
        int testTime = 1000000;
        System.out.println("测试开始");
        for (int i = 0; i < testTime; i++) {
            int len = (int) (Math.random() * N);
            String s = randomString(len);
            int ans0 = number(s);
            int ans1 = dp1(s);
            int ans2 = dp2(s);
            if (ans0 != ans1 || ans0 != ans2) {
                System.out.println(s);
                System.out.println(ans0);
                System.out.println(ans1);
                System.out.println(ans2);
                System.out.println("Oops!");
                break;
            }
        }
        System.out.println("测试结束");
    }
}
```

#### 从左往右的尝试模型2-背包问题

题目：给定两个长度都为N的weights和values,weights[i]和values[i]分别代表i号物品的重量和价值。给定一个正数bag,表示一个载重bag的袋子，你能装的物品不总重量不能超过bag。返回你能装下的最多价值是多少？

- 解法1：暴力递归
- 解法2：动态规划，将暴力递归改为动态规划，不太需要关注业务，只需要逻辑就行

```
public class Code01_Knapsack {
    // 所有的货，重量和价值，都在w和v数组里
    // 为了方便，其中没有负数
    // bag背包容量，不能超过这个载重
    // 返回：不超重的情况下，能够得到的最大价值
    public static int maxValue(int[] w, int[] v, int bag) {
        // 解法1：暴力递归
        if (w == null || v == null || w.length != v.length || w.length == 0) {
            return 0;
        }
        // 尝试函数！
        return process(w, v, 0, bag);
    }

    // 表示0到index-1已做好货物选择，后续做选择的情况返回
    // 返回-1，表示不能成立，不能选择
    // 返回非-1，表示返回值是货物的实际价值
    // rest 表示背包剩余的可用价值
    public static int process(int[] w, int[] v, int index, int rest) {
        // 剩余空间小于0，则不能选择
        if (rest < 0) {
            return -1;
        }
        // 重量没超，但是后面没货了，那就是0
        if (index == w.length) {
            return 0;
        }
        // 可能性一：不要当前货物，直接求后续货物
        int p1 = process(w, v, index + 1, rest);
        int p2 = 0;
        // 可能性二：要当前货物，计算后续货物实际价值
        int next = process(w, v, index + 1, rest - w[index]);
        if (next != -1) {
            // 后续货物还可以放，没超，即要了当前货物+后续货物实际价值
            p2 = v[index] + next;
        }
        // 取两种可能性的最大值，并返回能装下的货物的最终实际价值
        return Math.max(p1, p2);
    }

    public static int dp(int[] w, int[] v, int bag) {
        // 解法2：动态规划，将暴力递归改为动态规划，不太需要关注业务，只需要逻辑就行
        if (w == null || v == null || w.length != v.length || w.length == 0) {
            return 0;
        }
        int N = w.length;
        /*
        dp二维表，行表示已处理好的货物索引位置index,列表示剩余可用的重量bag。x表示不需要统计计算
        所以根据确定的最终结果，初始值是最后一行，那么后面一定是从第N行推出第N-1行，N-1行推出N-2行...以此类推
          0 1 2 3 4 5  ——bag
        0 x x x x x x
        1
        2
        3
        4 0 0 0 0 0 0(初始值)
        |
        index
        */
        int[][] dp = new int[N + 1][bag + 1];
        // 第一步：计算初始位置值,因为dp二维数组默认就给0，所以不用再计算赋值
        // dp[N][0到bag] = 0
        // 第二步：开始规划计算，根据确定的最终结果，初始值是最后一行，那么后面一定是从第N行推出第N-1行，N-1行推出N-2行...以此类推
        /*将以下过程改为dp
        * // 可能性一：不要当前货物，直接求后续货物
        int p1 = process(w, v, index + 1, rest);
        int p2 = 0;
        // 可能性二：要当前货物，计算后续货物实际价值
        int next = process(w, v, index + 1, rest - w[index]);
        if (next != -1) {
            // 后续货物还可以放，没超，即要了当前货物+后续货物实际价值
            p2 = v[index] + next;
        }
        // 取两种可能性的最大值，并返回能装下的货物的最终实际价值
        return Math.max(p1, p2);
        * */
        for (int index = N - 1; index >= 0; index--) {
            for (int rest = 0; rest <= bag; rest++) {
                // 拿暴力递归过程逐行转换为dp
                int p1 = dp[index + 1][rest];
                int p2 = 0;
                // 这里改造dp注意数组越界
                int next = rest - w[index] < 0 ? -1 : dp[index + 1][rest - w[index]];
                if (next != -1) {
                    p2 = v[index] + next;
                }
                dp[index][rest] = Math.max(p1, p2);
            }
        }
        // 返回0位置，剩余空间bag的对应值
        return dp[0][bag];
    }

    public static void main(String[] args) {
        int[] weights = {3, 2, 4, 7, 3, 1, 7};
        int[] values = {5, 6, 3, 19, 12, 4, 2};
        int bag = 15;
        // 解法1：暴力递归
        System.out.println(maxValue(weights, values, bag));
        // 解法2：动态规划，将暴力递归改为动态规划，不太需要关注业务，只需要逻辑就行
        System.out.println(dp(weights, values, bag));
    }
}
```

#### 范围上的尝试模型-纸牌游戏

题目：给定一个整形数组arr,代表数值不同的纸牌排成一条线，玩家A和玩家B依次拿走每张牌，规定玩家A先拿，B后拿。但每个玩家每次只能拿走最左或最右的牌。玩家AB都绝顶聪明(都是心机婊，只允许自己拿牌比下一次对方拿牌大)。请但会最后获胜者的分数。

- 解法1：暴力递归的尝试过程
- 解法2：记忆化搜索即带缓存dp的暴力递归
- 解法3：动态规划

```
public class Code02_CardsInLine {
    // 根据规则，返回获胜者的分数
    public static int win1(int[] arr) {
        // 解法1：暴力递归的尝试过程
        if (arr == null || arr.length == 0) {
            return 0;
        }
        // 先手人拿牌和后手人拿牌，看下谁大
        int first = f1(arr, 0, arr.length - 1);
        int second = g1(arr, 0, arr.length - 1);
        return Math.max(first, second);
    }

    // arr[L..R]，先手获得的最好分数返回
    public static int f1(int[] arr, int L, int R) {
        // 还剩一张牌，先手人直接拿走
        if (L == R) {
            return arr[L];
        }
        // 可能性1：先手的人拿走左边牌，然后变成当前的后手拿牌，求和
        int p1 = arr[L] + g1(arr, L + 1, R);
        // 可能性1：先手的人拿走右边牌，然后变成当前的后手拿牌，求和
        int p2 = arr[R] + g1(arr, L, R - 1);
        // 因为先手人是心机婊，他一定想拿最大值
        return Math.max(p1, p2);
    }

    // arr[L..R]，后手获得的最好分数返回
    public static int g1(int[] arr, int L, int R) {
        // 还剩一张牌，后手人一定是等先手人拿走最后一张，自己球都没有，得0分
        if (L == R) {
            return 0;
        }
        // 可能性1：先手人拿走左边牌，后手人被迫在剩下的进行先手拿牌
        int p1 = f1(arr, L + 1, R); // 对手拿走了L位置的数
        // 可能性2：先手人拿走右边牌，后手人被迫在剩下的进行先手拿牌
        int p2 = f1(arr, L, R - 1); // 对手拿走了R位置的数
        // 因为先手人是心机婊，他不会允许后手人拿到较大的牌，最会留较小牌给你
        return Math.min(p1, p2);
    }

    public static int win2(int[] arr) {
        // 解法2：记忆化搜索即带缓存dp的暴力递归
        if (arr == null || arr.length == 0) {
            return 0;
        }
        int N = arr.length;
        int[][] fmap = new int[N][N];
        int[][] gmap = new int[N][N];
        // 第一步：计算初始位置值，随便给值都行，-1也可以
        for (int i = 0; i < N; i++) {
            for (int j = 0; j < N; j++) {
                fmap[i][j] = -1;
                gmap[i][j] = -1;
            }
        }
        // 第二步：开始改写dp
        int first = f2(arr, 0, arr.length - 1, fmap, gmap);
        int second = g2(arr, 0, arr.length - 1, fmap, gmap);
        return Math.max(first, second);
    }

    // arr[L..R]，先手获得的最好分数返回
    public static int f2(int[] arr, int L, int R, int[][] fmap, int[][] gmap) {
        if (fmap[L][R] != -1) {
            return fmap[L][R];
        }
        int ans = 0;
        if (L == R) {
            ans = arr[L];
        } else {
            int p1 = arr[L] + g2(arr, L + 1, R, fmap, gmap);
            int p2 = arr[R] + g2(arr, L, R - 1, fmap, gmap);
            ans = Math.max(p1, p2);
        }
        fmap[L][R] = ans;
        return ans;
    }

    // // arr[L..R]，后手获得的最好分数返回
    public static int g2(int[] arr, int L, int R, int[][] fmap, int[][] gmap) {
        if (gmap[L][R] != -1) {
            return gmap[L][R];
        }
        int ans = 0;
        if (L != R) {
            int p1 = f2(arr, L + 1, R, fmap, gmap); // 对手拿走了L位置的数
            int p2 = f2(arr, L, R - 1, fmap, gmap); // 对手拿走了R位置的数
            ans = Math.min(p1, p2);
        }
        gmap[L][R] = ans;
        return ans;
    }

    public static int win3(int[] arr) {
        // 解法3：动态规划
        if (arr == null || arr.length == 0) {
            return 0;
        }
        int N = arr.length;
        int[][] fmap = new int[N][N];
        int[][] gmap = new int[N][N];
        for (int i = 0; i < N; i++) {
            // 第一步：计算初始位置值，设置对角线值
            fmap[i][i] = arr[i];
        }
        // 第二步：开始填写两张dp表，然后最终返回需要的dp表结果值
        for (int startCol = 1; startCol < N; startCol++) {
            int L = 0;
            int R = startCol;
            while (R < N) {
                // 根据解法2的物理逻辑，可以转成两张dp表的取值逻辑
                fmap[L][R] = Math.max(arr[L] + gmap[L + 1][R], arr[R] + gmap[L][R - 1]);
                gmap[L][R] = Math.min(fmap[L + 1][R], fmap[L][R - 1]);
                L++;
                R++;
            }
        }
        return Math.max(fmap[0][N - 1], gmap[0][N - 1]);
    }

    public static void main(String[] args) {
        int[] arr = {5, 7, 4};
        // 解法1：暴力递归的尝试过程
        System.out.println(win1(arr));
        // 解法2：记忆化搜索即带缓存dp的暴力递归
        System.out.println(win2(arr));
        // 解法3：动态规划
        System.out.println(win3(arr));
    }
}
```

#### **业务限制类的尝试模型**-N皇后

题目：N皇后问题是指在N*N的棋盘上要摆N个皇后，要求任何两个皇后不同行、不同列，也不在同一斜线上。给定一个整数n,返回n皇后的摆法有多少种。

- 解法1：暴力递归，返回所有的皇后的合理摆法


- 解法2：利用位运算，最多解决32个皇后问题。超过就不行了。因为二进制最多32位。两者时间复杂度均为N的N次方，只不过解法2比1常数项系数更小。**核心是基于位运算的左移右移和斜线逻辑刚好一致。**


```
public class Code03_NQueens {
    public static int num1(int n) {
        // 解法1：暴力递归
        if (n < 1) {
            return 0;
        }
        int[] record = new int[n];
        // 从0开始，所有的皇后摆法
        // 0是第0行开始，record是记录每一行的皇后列摆放位置，n是共多少行
        return process1(0, record, n);
    }

    // 潜台词：record[0...i-1]的皇后已摆好
    // 目前来到第i行，要求第i行的皇后与之前的任意皇后不共行，不共列，不共斜线
    // record[0...i-1]表示之前的行，摆放了皇后的位置
    // 例如int[] record record[x] = y 之前的第x行的皇后，放在了y列上
    // 返回：不关心i以上发生了什么。返回值是i.... 后续有多少合法的方法数
    public static int process1(int i, int[] record, int n) {
        // 暴力递归，摆完所有的行，统计一种情况
        if (i == n) {
            return 1;
        }
        int res = 0;
        // 对于第i行来说，遍历所有的列，尝试能不能摆皇后
        for (int j = 0; j < n; j++) {
            // 假设黑盒函数判断能摆皇后
            if (isValid(record, i, j)) {
                // record函数记录第i行的皇后的摆放位置j
                record[i] = j;
                // 同时记录累加递归计算下一行
                res += process1(i + 1, record, n);
            }
        }
        return res;
    }
    public static boolean isValid(int[] record, int i, int j) {
        // 判断第(i,j)的皇后位置不能合record数组中的皇后位置冲突
        for (int k = 0; k < i; k++) {
            // 遍历record所有之前的皇后位置，判断是否冲突
            // 注意不用判断同行，因为一定不同行
            // 如果同列或同斜线，则冲突，返回false。Math.abs是绝对值判断法，简单粗暴
            if (j == record[k] || Math.abs(record[k] - j) == Math.abs(i - k)) {
                return false;
            }
        }
        return true;
    }

    // 请不要超过32皇后问题
    public static int num2(int n) {
        // 解法2：巧妙的位运算
        if (n < 1 || n > 32) {
            return 0;
        }
        // 如果你是13皇后问题，limit 最右13个1，其他都是0
        // limit表示问题的规模，有多少个皇后，则表示右边有多少个连续的1
        int limit = n == 32 ? -1 : (1 << n) - 1;
        return process2(limit, 0, 0, 0);
    }

    // limit : 0....0 1 1 1 1 1 1 1
    // 之前皇后的列影响：colLim，列的限制即之前皇后已经摆放过的列，后续皇后就不能摆放这些列
    // 之前皇后的左下对角线影响：leftDiaLim，左斜线限制同上理解
    // 之前皇后的右下对角线影响：rightDiaLim，右斜线限制
    public static int process2(int limit, int colLim, int leftDiaLim, int rightDiaLim) {
        // 当列的限制等于原始规模，就表示所有皇后都摆完了，记录一种情况
        if (colLim == limit) {
            return 1;
        }
        // pos中所有是1的位置，是你可以去尝试皇后的位置
        int pos = limit & (~(colLim | leftDiaLim | rightDiaLim));
        // 提取出一个二进制的最右1的值
        int mostRightOne = 0;
        // 记录多少种最终返回情况
        int res = 0;
        // 只要pos不为0，表示当前还可以尝试放皇后
        while (pos != 0) {
            // 左神最常规的取出最右的1的值
            mostRightOne = pos & (~pos + 1);
            // 当前值减去最右1，这样最右的第2个1变成了最右的第1个1，继续循环提取pos上所有1即列的位置
            pos = pos - mostRightOne;
            // 当前的限制加上最右的位置成为最新的限制，继续递归统计
            res += process2(limit, colLim | mostRightOne, (leftDiaLim | mostRightOne) << 1, (rightDiaLim | mostRightOne) >>> 1);
        }
        return res;
    }

    public static void main(String[] args) {
        int n = 14;
        // 解法2：位运算算法
        long start = System.currentTimeMillis();
        System.out.println(num2(n));
        long end = System.currentTimeMillis();
        System.out.println("cost time: " + (end - start) + "ms");
        // 解法1：常规暴力递归算法
        start = System.currentTimeMillis();
        System.out.println(num1(n));
        end = System.currentTimeMillis();
        System.out.println("cost time: " + (end - start) + "ms");

    }
}
```

###

