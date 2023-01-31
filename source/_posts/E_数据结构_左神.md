---
title: E_左神
date: 2022-11-13 07:33:16
categories:
- E_数据结构
toc: true # 是否启用内容索引
---

# 前言

[基础班视频](https://www.bilibili.com/video/BV1Zr4y1W7ww?p=37&spm_id_from=pageDriver&vd_source=bd4c7d99d71adf64d6e88c65370e0247)

[代码仓库](https://github.com/fuyunjinglong/algorith-systematiclearning)

基础班和进阶班：绝对的技术干活。

体系学习班和大厂刷题班：比前者多一些新题型而已。

**书**

大话数据结构，算法图解

**视频**

[数据结构-浙江大学(opens new window)](https://www.bilibili.com/video/av18586085?from=search&seid=15275956372728133584)
[清华大学-邓俊辉MOOC数据结构与算法全套](https://www.bilibili.com/video/av49361421?from=search&seid=2756779141930403558)

# 数据结构与算法本质

## 数据结构

就是2种结构：

- 连续结构：连续空间(数组)，寻址容易，增删难
- 跳转结构：不连续，指针跳转，增删容易，寻址难

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

## 什么是常数操作

算法的执行时间与样本量无关，是一个固定值,表示为O(1)

## 什么是时间复杂度

比如冒泡排序的时间复杂度：n平方。只取最高阶，去掉系数，去掉低阶。时间复杂度一定是**最差的情况**。

二分法的复杂度是O(logN)

常见时间复杂度排序：O(1)<O(logN)<O(N)<O(N*logN)<O(N2)<O(2N)<O(3N)<...

## 评估算法优劣的核心指标

- 时间复杂度(流程决定)
- 额外空间复杂度(流程决定)
- 常数项时间(实现细节决定)

### 时间复杂度(流程决定)

**常数时间的操作**

如果一个操作的执行时间不以具体样本量为转移，每次执行时间都是固定值，这样的操作为常数时间操作。

比如：

- 常见的算术运算(+-*/)
- 常见的位运算(>>,<<,|,&,^)
- 赋值、比较、自增、自减
- 数组寻址操作

**算法的总操作流程与样本数量的关系确定**

1. 想象算法流程所处理的数据状况，按照最差情况来。比如时间复杂度，通常说的就是最差时间复杂度
2. 把整个流程彻底拆分为一个个基本动作，保证每个动作都是常数时间的操作
3. 如果数据量为N,看看基本动作的数量和N是什么关系

**如何确定算法流程的时间复杂度**

当完成表达式建立后，只保留最高阶项，低阶项去掉，高阶项系数也去掉，记为O(忽略掉系数的高阶项)

**问题的最优解**

一般情况下，认为解决一个问题的算法流程，在时间复杂度的指标上，一定要尽可能的低，先满足了时间复杂度最低指标后，使用最少空间复杂度，叫这个问题的最优解。最优解可以忽略常数项因素。

**常见时间复杂度从好到差**

- O(1)
- O(logN)
- O(N)
- O(N*logN)
- O(N^2) O(N^3)...O(N^K)
- O(2^N) O(3^N)...O(K^N)
- O(N!)

**算法学习脉络**

- 知道算法的严格流程
- 知道算法的尝试流程(递归)

### 额外空间复杂度(流程决定)

在实现算法流程中，你需要开辟一些空间来支持你的算法流程。这部分空间就是额外空间。

如果你的流程只需要开辟有限几个变量，额外空间复杂度就是O(1)

### 常数项时间(实现细节决定)

放弃理论分析，利用随机样本实际测试常数项时间差异性。

# 位运算符

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

## N的阶层和

题目：给定一个参数N,返回1!+2!+3!...N!的结果

- 解法二明显优于解法一。


- 解法一：先计算当前阶层值，然后求和


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

# 对数器

找到一个实现算法流程的最简单的算法，与最终的算法，进行比较。

1. 有一个你想要测的方法a；
2. 实现一个绝对正确但是复杂度不好的方法b；
3. 实现一个随机样本产生器；
4. 实现对比算法a和b的方法；
5. 把方法a和方法b比对多次来验证方法a是否正确；
6. 如果有一个样本使得比对出错，打印样本分析是哪个方法出错；
7. 当样本数量很多时比对测试依然正确，可以确定方法a已经正确。

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

# 二分法

经常看到在有序数组上，开展二分搜索。但有序是所有问题使用二分的必要条件吗？不是，只要能正确构建左右两侧的淘汰逻辑，就可以用二分。

- 题目1:在一个有序数组中，找某个数是否存在
- 题目2:在一个有序数组中，找>=某个数最左侧的位置
- 题目3:在一个有序数组中，找<=某个数最右侧的位置
- 题目4:局部最小值问题，无序数组，任意两个相邻的数不相等，返回一个局部最小值。注意：这个局部最小值可能有多个，只要找到一个就可以。

```
 // 题目1:在一个有序数组中，找某个数是否存在
 public static boolean exist(int[] sortedArr, int num) {
  // 默认sortedArr是升序的
  if (sortedArr == null || sortedArr.length == 0) {
   return false;
  }
  int L = 0;
  int R = sortedArr.length - 1;
  int mid = 0;
  // L..R
  while (L < R) { // L..R 至少两个数的时候
   mid = L + ((R - L) >> 1);
   if (sortedArr[mid] == num) {
    return true;
   } else if (sortedArr[mid] > num) {
    // 因为数组是升序的，中间>num,去左半边查询
    R = mid - 1;
   } else {
    // 去右半边查询
    L = mid + 1;
   }
  }
  return sortedArr[L] == num;
 }
 // 题目2:在一个有序数组中，找>=某个数最左侧的位置
 public static int nearestIndex(int[] arr, int value) {
  int L = 0;
  int R = arr.length - 1;
  int index = -1; // 记录最左的对号
  // 相当于，在大于等于value区域，一直往左收缩，直到index左边没有数为止
  while (L <= R) { // 至少一个数的时候
   int mid = L + ((R - L) >> 1);
   if (arr[mid] >= value) {
    // 记录mid,往左收缩
    index = mid;
    R = mid - 1;
   } else {
    // 往右收缩
    L = mid + 1;
   }
  }
  return index;
 }
 // 题目3:在一个有序数组中，找<=某个数最右侧的位置
 public static int nearestIndex(int[] arr, int value) {
  int L = 0;
  int R = arr.length - 1;
  int index = -1; // 记录最右的对号
  // 相当于，在小于等于value区域，一直往右收缩，直到index右边没有数为止
  while (L <= R) {
   int mid = L + ((R - L) >> 1);
   if (arr[mid] <= value) {
    // 记录mid,往右收缩
    index = mid;
    L = mid + 1;
   } else {
    // 往左收缩
    R = mid - 1;
   }
  }
  return index;
 }
 // 题目4:局部最小值问题
 public static int getLessIndex(int[] arr) {
  if (arr == null || arr.length == 0) {
   return -1;
  }
  // 情况1：如果一个数组(0~1)(0 1)是升序排列，则局部最小值是 0 位置
  if (arr.length == 1 || arr[0] < arr[1]) {
   return 0;
  }
  // 情况2：如果一个数组(n-2, n-1)(n−2,n−1)是降序排列，则局部最小值是 n - 1n−1 位置
  if (arr[arr.length - 1] < arr[arr.length - 2]) {
   return arr.length - 1;
  }
  int left = 1;
  int right = arr.length - 2;
  int mid = 0;
  // 情况3：数组开头向下，结尾向上，那这个局部最小位置一定在中间
  while (left < right) {
   mid = (left + right) / 2;
   if (arr[mid] > arr[mid - 1]) {
    right = mid - 1;
   } else if (arr[mid] > arr[mid + 1]) {
    left = mid + 1;
   } else {
    return mid;
   }
  }
  return left;
 }
```

# 异或运算

异或运算：相同为0，不同为1

同或运算：相同为1，不同为0

能长时间记住的概率为0%，所以记住异或运算是**无进位相加**即可。

**异或运算的性质**

- 0^N=N  N^N=0
- 异或运算满足交换律和结合律

**如何不用额外变量交换两个数**

```
利用交换律和结合律：注意a,b的内存地址一定要不同，值相同是可以的。之所以能这么来回倒，是因为有2个空间操作，如果变成一个空间，就挂了。
int a=甲;int b=乙;
a = a^b;
b = a^b;//a^b^b a^0 a
a = a^b;//a^b^a 0^b b
```

**怎么把一个int类型的数N，提取出最右侧的1来**

```
int rightOne = N & ((~N) + 1)
其中(~N) + 1也等于-N
```

**经典题目**

- 题目1：一个数组中，只有一种数出现了奇数次，其余数出现了偶数次，怎么找到该数？
- 题目2：一个数组中，有两种数出现了奇数次，其余数出现了偶数次，怎么找到这两个数？
- 题目3：提取出一个int类型数N的出现1的次数

```
 // 题目1：一个数组中，只有一种数出现了奇数次，其余数出现了偶数次，怎么找到该数？
 public static void printOddTimesNum1(int[] arr) {
    /*
     * 因为偶数的数异或结果为0,0^N=N,这就提取出来了
     */
  int eor = 0;
  for (int i = 0; i < arr.length; i++) {
   eor ^= arr[i];
  }
  System.out.println(eor);
 }
 // 题目2：一个数组中，有两种数出现了奇数次，其余数出现了偶数次，怎么找到这两个数？
 public static void printOddTimesNum2(int[] arr) {
  int eor = 0;
  for (int i = 0; i < arr.length; i++) {
   eor ^= arr[i];
  }
  // eor=a^b, a 和 b是两种数
  // eor != 0
  // eor最右侧的1，提取出来
  // eor :     00110010110111000
  // rightOne :00000000000001000
  int rightOne = eor & (-eor); // 提取出最右的1
  int onlyOne = 0; // eor'只异或最右为1的数，提取出a
  for (int i = 0 ; i < arr.length;i++) {
   //  arr[1] =  111100011110000
   // rightOne=  000000000010000
   if ((arr[i] & rightOne) != 0) {
    onlyOne ^= arr[i];
   }
  }
    // b=a^b^a
  System.out.println(onlyOne + " " + (eor ^ onlyOne));
 }
 // 题目3：提取出一个int类型数N的出现1的次数
 public static int bit1counts(int N) {
  int count = 0;
  //   011011010000
  //   000000010000     1
  //   011011000000
  while(N != 0) {
   int rightOne = N & ((~N) + 1);
   count++;
   N ^= rightOne;
   // N -= rightOne
  }
  return count;
 }
```

# 排序

## **排序算法总结**

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

## 工具函数

```java
 // 排序算法验证函数for test
 public static void main(String[] args) {
  int testTime = 500000;//测试次数
  int maxSize = 100;//最大测试容量
  int maxValue = 100;//最大测试数据
  boolean succeed = true;
  for (int i = 0; i < testTime; i++) {
   int[] arr1 = generateRandomArray(maxSize, maxValue);
   int[] arr2 = copyArray(arr1);//这两个数组除了数值相同内存地址完全没关系，请看copyArray()方法实现
   selectionSort(arr1);//用自己的算法排序
   comparator(arr2);//用java.util.Arrays包的排序算法排序
   if (!isEqual(arr1, arr2)) {
    succeed = false;
    printArray(arr1);
    printArray(arr2);
    break;
   }
  }
  System.out.println(succeed ? "Nice!" : "Fucking fucked!");
  int[] arr = generateRandomArray(maxSize, maxValue);
  printArray(arr);// 排序前，打印数组
  selectionSort(arr);// 排序
  printArray(arr);// 排序后，打印数组
 } 
 // 交换arr的i和j位置上的值
 public static void swap(int[] arr, int i, int j) {
  int tmp = arr[i];
  arr[i] = arr[j];
  arr[j] = tmp;
        // 更骚的交换，但i和j是一个位置的话，会出错
  /*arr[i] = arr[i] ^ arr[j];
  arr[j] = arr[i] ^ arr[j];
  arr[i] = arr[i] ^ arr[j];
  */
 }
 // 排序对数器for test
 public static void comparator(int[] arr) {
  Arrays.sort(arr);
 }
 // 返回随机长度，随机值的数组for test
 public static int[] generateRandomArray(int maxSize, int maxValue) {
  // Math.random() -> [0,1) 所有的小数，等概率返回一个
  // Math.random() * N -> [0,N) 所有小数，等概率返回一个
  // (int)(Math.random() * N) -> [0,N-1] 所有的整数，等概率返回一个
  int[] arr = new int[(int) ((maxSize + 1) * Math.random())]; // 长度随机
  for (int i = 0; i < arr.length; i++) {
   arr[i] = (int) ((maxValue + 1) * Math.random()) - (int) (maxValue * Math.random());
  }
  return arr;
 }
 // 数组深拷贝for test
 public static int[] copyArray(int[] arr) {
  if (arr == null) {
   return null;
  }
  int[] res = new int[arr.length];
  for (int i = 0; i < arr.length; i++) {
   res[i] = arr[i];
  }
  return res;
 }
 // 数组值比较for test
 public static boolean isEqual(int[] arr1, int[] arr2) {
  if ((arr1 == null && arr2 != null) || (arr1 != null && arr2 == null)) {
   return false;
  }
  if (arr1 == null && arr2 == null) {
   return true;
  }
  if (arr1.length != arr2.length) {
   return false;
  }
  for (int i = 0; i < arr1.length; i++) {
   if (arr1[i] != arr2[i]) {
    return false;
   }
  }
  return true;
 }
 // 数组值打印for test
 public static void printArray(int[] arr) {
  if (arr == null) {
   return;
  }
  for (int i = 0; i < arr.length; i++) {
   System.out.print(arr[i] + " ");
  }
  System.out.println();
 }
```



## 选择排序

过程：

arr[0 ~ N-1]范围上，找到最小值所在位置，然后把最小值交换到0位置

arr[1 ~ N-1]范围上，找到最小值所在位置，然后把最小值交换到1位置

arr[2 ~ N-1]范围上，找到最小值所在位置，然后把最小值交换到2位置

...

arr[N-1 ~ N-1]范围上，找到最小值所在位置，然后把最小值交换到N-1位置

估算：

明显，如果arr长度为N,每一步都是常数操作的数量，如等差数列一般。所以总的常数操作数量=a(N^2)+bN+c,其中abc都是常数。所以是O(N^2)

```
public static void selectionSort(int[] arr) {
  if (arr == null || arr.length < 2) {
   return;
  }
  // 0 ~ N-1  找到最小值，在哪，放到0位置上
  // 1 ~ n-1  找到最小值，在哪，放到1 位置上
  // 2 ~ n-1  找到最小值，在哪，放到2 位置上
  for (int i = 0; i < arr.length - 1; i++) {
   int minIndex = i;
   for (int j = i + 1; j < arr.length; j++) { // i ~ N-1 上找最小值的下标 
    minIndex = arr[j] < arr[minIndex] ? j : minIndex;
   }
   swap(arr, i, minIndex);
  }
 }
```

## 冒泡排序

过程：

在arr[0 ~ N-1]范围上，

arr[0]和arr[1],谁大谁来到1位置；arr[1]和arr[2],谁大谁来到2位置...arr[N-2]和arr[N-1],谁大谁来到N-1位置

在arr[0 ~ N-1]范围上，重复上面的过程，但最后一步是arr[N-3]和arr[N-2],谁大谁来到N-2位置

在arr[0 ~ N-1]范围上，重复上面的过程，但最后一步是arr[N-4]和arr[N-3],谁大谁来到N-3位置

...

最后在arr[0 ~ 1]范围上，重复上面的过程，但最后一步是arr[0]和arr[1],谁大谁来到1位置

估算：

很明显，如果arr长度为N,每一步都是常数操作的数量，如等差数列一般。所以总的常数操作数量=a(N^2)+bN+c,其中abc都是常数。所以是O(N^2)

```
public static void bubbleSort(int[] arr) {
  if (arr == null || arr.length < 2) {
   return;
  }
  // 0 ~ N-1
  // 0 ~ N-2
  // 0 ~ N-3
  for (int e = arr.length - 1; e > 0; e--) { // 0 ~ e
   for (int i = 0; i < e; i++) {
    if (arr[i] > arr[i + 1]) {
     swap(arr, i, i + 1);
    }
   }
  }
 }
```

## 插入排序

过程：

想让arr[0~0]上有序，这个范围只有一个数，当然有序

想让arr[0~1]上有序，所以从arr[1]往前看，如果arr[1]<arr[0],就交换。否则什么都不做

...

想让arr[0~i]上有序，所以从arr[i]往前看，arr[i]这个数不停向左移动，一直移动到左边数字>=自己，停止移动。

估算时发现，复杂度明显会因数据状况不同而不同。最好情况是只看不交换O(N),最差情况就是O(N^2)

```
public static void insertionSort(int[] arr) {
  if (arr == null || arr.length < 2) {
   return;
  }
  // 不只1个数
  for (int i = 1; i < arr.length; i++) { // 0 ~ i 做到有序
   for (int j = i - 1; j >= 0 && arr[j] > arr[j + 1]; j--) {
    swap(arr, j, j + 1);
   }
  }
 }
```



# 比较器与堆

**堆结构是比堆排序重要得多的知识。**

## 堆结构

1. 堆结构就是用数组实现的完全二叉树。(完全二叉树，上面的层是满的，即使不满，那么一定是从左到右逐渐变满)
2. 完全二叉树如果每棵子树的最大值都在顶部就是大根堆
3. 完全二叉树如果每棵子树的最小值都在顶部就是小根堆
4. 堆结构关键就是heapInsert和heapify操作
5. 堆结构的增大和减少
6. 优先级队列结构，就是堆结构

heap堆结构[0,1,2,3,4,5]，对应到我们想象的堆结构是：

>      0
>
>      1   2
>
>      3  4  5
>
>      这里有一个关系heap的数组索引为i。假设当前节点为i,且节点索引从0开始使用。那么它的
>
>      - 左节点：2i+1
>      - 右节点：2i+2
>      - 父节点：(i-1)/2
>
>      当然某些题目可能节点索引从1开始。为什么这么奸？因为可以用位运算。那么它的，
>
>      - 左节点：2i
>      - 右节点：2i+1
>      - 父节点：(i)/2

```
import java.util.Comparator;
import java.util.PriorityQueue;

public class Code02_Heap {
    public static class MyMaxHeap {
        // O(longN)的大根堆数组
        private int[] heap;
        // 限制堆的大小
        private final int limit;
        // 当前堆的实时大小
        private int heapSize;

        public MyMaxHeap(int limit) {
            heap = new int[limit];
            this.limit = limit;
            heapSize = 0;
        }

        public boolean isEmpty() {
            return heapSize == 0;
        }

        public boolean isFull() {
            return heapSize == limit;
        }

        public void push(int value) {
            // 大根堆数组尾部添加节点
            if (heapSize == limit) {
                throw new RuntimeException("heap is full");
            }
            // 大根堆添加节点，一定是来到最后的位置。原来的最后是heapSize-1索引处
            heap[heapSize] = value;
            // 先将最新的索引作为参数传入，然后heapSize长度+1
            heapInsert(heap, heapSize++);
        }


        public int pop() {
            // 大根堆数组弹出顶部节点
            /*
             * 用户此时，让你返回最大值，并且在大根堆中，把最大值删掉.剩下的数，依然保持大根堆组织
             * */
            // 先把最大值记录下来
            int ans = heap[0];
            // 然后把最后一个节点和第一个位置交换，然后长度--
            swap(heap, 0, --heapSize);
            // 接下来就是0索引节点值从上往下窜
            heapify(heap, 0, heapSize);
            return ans;
        }

        private void heapInsert(int[] arr, int index) {
            /*
             * 从下往上窜，添加节点，生成大根堆，可以用于建堆
             * index表示大根堆添加节点的索引，比较当前节点和父节点值，直到要么index到顶，要么父节点比当前节点大.
             * 新加进来的数，现在停在了index位置，请依次往上移动，
             * 移动到0位置，或者干不掉自己的父亲了，停！
             * [index]是当前节点， [index-1]/2是父节点
             * index == 0是顶部，即使到顶部arr[0]>arr[0]也可以跳出循环
             */
            while (arr[index] > arr[(index - 1) / 2]) {
                // 只要当前值大于父节点值，就交换，并且索引更新为父节点索引，一直往上窜
                swap(arr, index, (index - 1) / 2);
                index = (index - 1) / 2;
            }
        }

        private void heapify(int[] arr, int index, int heapSize) {
            /*
             * 从上往下窜，将当前节点调整为大根堆，可以用于建堆
             * index表示当前节点的索引，比较当前节点和子节点最大的一个，直到要么index到底，要么父节点比当前节点大
             * 从index位置，往下看，不断的下沉
             * 停：较大的孩子都不再比index位置的数大；已经没孩子了
             * */
            // left表示左子节点
            int left = index * 2 + 1;
            // 如果有左孩子
            while (left < heapSize) { // 如果有左孩子，有没有右孩子，可能有可能没有！
                // 如果有右孩子且右大于左，则右孩子给largest。否则给左孩子。
                int largest = left + 1 < heapSize && arr[left + 1] > arr[left] ? left + 1 : left;
                // 比较当前节点和子节点最大的一个，哪一个大
                largest = arr[largest] > arr[index] ? largest : index;
                // 如果父节点比当前节点大，直接跳出循环。index就是当前父节点，largest是子节点最大的一个
                if (largest == index) {
                    break;
                }
                // index和较大孩子，要互换
                swap(arr, largest, index);
                // 当前节点往下更新索引
                index = largest;
                // 同时更新左子节点
                left = index * 2 + 1;
            }
        }

        private void swap(int[] arr, int i, int j) {
            int tmp = arr[i];
            arr[i] = arr[j];
            arr[j] = tmp;
        }
    }

    public static class RightMaxHeap {
        // O(N)的大根堆数组，巨暴力的一个大根堆
        private int[] arr;
        private final int limit;
        private int size;

        public RightMaxHeap(int limit) {
            arr = new int[limit];
            this.limit = limit;
            size = 0;
        }

        public boolean isEmpty() {
            return size == 0;
        }

        public boolean isFull() {
            return size == limit;
        }

        public void push(int value) {
            // 暴力的往后添加节点
            if (size == limit) {
                throw new RuntimeException("heap is full");
            }
            arr[size++] = value;
        }

        public int pop() {
            // 每次找到最大值，并弹出
            int maxIndex = 0;
            for (int i = 1; i < size; i++) {
                if (arr[i] > arr[maxIndex]) {
                    maxIndex = i;
                }
            }
            int ans = arr[maxIndex];
            arr[maxIndex] = arr[--size];
            return ans;
        }

    }

    public static class MyComparator implements Comparator<Integer> {
        @Override
        public int compare(Integer o1, Integer o2) {
            return o2 - o1;
        }
    }

    public static void main(String[] args) {
        // 小根堆
        PriorityQueue<Integer> heap = new PriorityQueue<>(new MyComparator());
        heap.add(5);
        heap.add(5);
        heap.add(5);
        heap.add(3);
        // 5 , 3
        System.out.println(heap.peek());
        heap.add(7);
        heap.add(0);
        heap.add(7);
        heap.add(0);
        heap.add(7);
        heap.add(0);
        System.out.println(heap.peek());
        while (!heap.isEmpty()) {
            System.out.println(heap.poll());
        }

        int value = 1000;
        int limit = 100;
        int testTimes = 1000000;
        for (int i = 0; i < testTimes; i++) {
            int curLimit = (int) (Math.random() * limit) + 1;
            MyMaxHeap my = new MyMaxHeap(curLimit);
            // 对数器
            RightMaxHeap test = new RightMaxHeap(curLimit);
            int curOpTimes = (int) (Math.random() * limit);
            for (int j = 0; j < curOpTimes; j++) {
                if (my.isEmpty() != test.isEmpty()) {
                    System.out.println("Oops!");
                }
                if (my.isFull() != test.isFull()) {
                    System.out.println("Oops!");
                }
                if (my.isEmpty()) {
                    int curValue = (int) (Math.random() * value);
                    my.push(curValue);
                    test.push(curValue);
                } else if (my.isFull()) {
                    if (my.pop() != test.pop()) {
                        System.out.println("Oops!");
                    }
                } else {
                    if (Math.random() < 0.5) {
                        int curValue = (int) (Math.random() * value);
                        my.push(curValue);
                        test.push(curValue);
                    } else {
                        if (my.pop() != test.pop()) {
                            System.out.println("Oops!");
                        }
                    }
                }
            }
        }
        System.out.println("finish!");
    }
}

```

## 堆排序

1. 第一步：先生成大根堆
2. 第二步：先将最大值交换到最后，循环逻辑：heapify调整当前值在剩下范围内为大根堆，再交换。

```
import java.util.Arrays;
import java.util.PriorityQueue;
public class Code03_HeapSort {
    // 堆排序额外空间复杂度O(1)
    public static void heapSort(int[] arr) {
        // 小根堆排序
        if (arr == null || arr.length < 2) {
            return;
        }
        // 解法1：第一步：先生成大根堆。复杂度：O(N*logN)
        for (int i = 0; i < arr.length; i++) { // O(N)
            // 建堆，注意这是每次只给一个节点
            heapInsert(arr, i); // O(logN)
        }
        // 解法2：第一步：先生成大根堆，注意是从右往左的。复杂度：O(N)
//        for (int i = arr.length - 1; i >= 0; i--) {
//            // 建堆,注意这是一次给所有arr节点
//            heapify(arr, i, arr.length);
//        }
        int heapSize = arr.length;
        // 第二步：先将最大值交换到最后，循环逻辑：heapify调整当前值在剩下范围内为大根堆，再交换。复杂度:O(N*logN)
        // 先size--。将大根堆的最大值交换到最后，即最大值下沉。
        swap(arr, 0, --heapSize);
        // O(N*logN)
        // 在剩下的0到size-1上，heapify调整当前值为大根堆，再交换。下沉第二大的值，size--
        while (heapSize > 0) { // O(N)
            // heapify调整当前值在剩下范围内为大根堆
            heapify(arr, 0, heapSize); // O(logN)
            // 先size--
            // 将当前最大值交换到最后，即最大值下沉
            swap(arr, 0, --heapSize); // O(1)
        }
    }

    private static void heapInsert(int[] arr, int index) {
        /*
         * 从下往上窜，添加节点，生成大根堆。可以用于建堆，注意这是每次只给一个节点
         * index表示大根堆添加节点的索引，比较当前节点和父节点值，直到要么index到顶，要么父节点比当前节点大.
         * 新加进来的数，现在停在了index位置，请依次往上移动，
         * 移动到0位置，或者干不掉自己的父亲了，停！
         * [index]是当前节点， [index-1]/2是父节点
         * index == 0是顶部，即使到顶部arr[0]>arr[0]也可以跳出循环
         */
        while (arr[index] > arr[(index - 1) / 2]) {
            // 只要当前值大于父节点值，就交换，并且索引更新为父节点索引，一直往上窜
            swap(arr, index, (index - 1) / 2);
            index = (index - 1) / 2;
        }
    }

    private static void heapify(int[] arr, int index, int heapSize) {
        /*
         * 从上往下窜，将当前节点调整为大根堆。可以用于建堆，注意这是一次给所有arr节点
         * index表示当前节点的索引，比较当前节点和子节点最大的一个，直到要么index到底，要么父节点比当前节点大
         * 从index位置，往下看，不断的下沉
         * 停：较大的孩子都不再比index位置的数大；已经没孩子了
         * */
        // left表示左子节点
        int left = index * 2 + 1;
        // 如果有左孩子
        while (left < heapSize) { // 如果有左孩子，有没有右孩子，可能有可能没有！
            // 如果有右孩子且右大于左，则右孩子给largest。否则给左孩子。
            int largest = left + 1 < heapSize && arr[left + 1] > arr[left] ? left + 1 : left;
            // 比较当前节点和子节点最大的一个，哪一个大
            largest = arr[largest] > arr[index] ? largest : index;
            // 如果父节点比当前节点大，直接跳出循环。index就是当前父节点，largest是子节点最大的一个
            if (largest == index) {
                break;
            }
            // index和较大孩子，要互换
            swap(arr, largest, index);
            // 当前节点往下更新索引
            index = largest;
            // 同时更新左子节点
            left = index * 2 + 1;
        }
    }

    public static void swap(int[] arr, int i, int j) {
        int tmp = arr[i];
        arr[i] = arr[j];
        arr[j] = tmp;
    }

    // for test
    public static void comparator(int[] arr) {
        Arrays.sort(arr);
    }

    // for test
    public static int[] generateRandomArray(int maxSize, int maxValue) {
        int[] arr = new int[(int) ((maxSize + 1) * Math.random())];
        for (int i = 0; i < arr.length; i++) {
            arr[i] = (int) ((maxValue + 1) * Math.random()) - (int) (maxValue * Math.random());
        }
        return arr;
    }

    // for test
    public static int[] copyArray(int[] arr) {
        if (arr == null) {
            return null;
        }
        int[] res = new int[arr.length];
        for (int i = 0; i < arr.length; i++) {
            res[i] = arr[i];
        }
        return res;
    }

    // for test
    public static boolean isEqual(int[] arr1, int[] arr2) {
        if ((arr1 == null && arr2 != null) || (arr1 != null && arr2 == null)) {
            return false;
        }
        if (arr1 == null && arr2 == null) {
            return true;
        }
        if (arr1.length != arr2.length) {
            return false;
        }
        for (int i = 0; i < arr1.length; i++) {
            if (arr1[i] != arr2[i]) {
                return false;
            }
        }
        return true;
    }

    // for test
    public static void printArray(int[] arr) {
        if (arr == null) {
            return;
        }
        for (int i = 0; i < arr.length; i++) {
            System.out.print(arr[i] + " ");
        }
        System.out.println();
    }

    // for test
    public static void main(String[] args) {
        // 系统自带的优先级队列，默认小根堆
        PriorityQueue<Integer> heap = new PriorityQueue<>();
        heap.add(6);
        heap.add(8);
        heap.add(0);
        heap.add(2);
        heap.add(9);
        heap.add(1);
        System.out.println("hello");
        while (!heap.isEmpty()) {
            System.out.println(heap.poll());
        }

        int testTime = 500000;
        int maxSize = 100;
        int maxValue = 100;
        boolean succeed = true;
        for (int i = 0; i < testTime; i++) {
            int[] arr1 = generateRandomArray(maxSize, maxValue);
            int[] arr2 = copyArray(arr1);
            heapSort(arr1);
            comparator(arr2);
            if (!isEqual(arr1, arr2)) {
                succeed = false;
                break;
            }
        }
        System.out.println(succeed ? "Nice!" : "Fucking fucked!");

        int[] arr = generateRandomArray(maxSize, maxValue);
        printArray(arr);
        heapSort(arr);
        printArray(arr);
    }
}
```

**与堆有关的题目**

题目：已知一个几乎有序的数组，几乎有序是指，如果把数组排好顺序的话，每个元素的移动距离可以不超过k，并且k相对于整个数组来说比较小。请选择一个合适的排序算法针对这个数据进行排序。

1. 第一步：先建一个小根堆，0...K。这里一定有最小值，因为题目给出排序移动距离不超过k.
2. 第二步：先弹出小根堆的最小值，然后再添加，再弹出
3. 第三步：最后发现没有可以添加的节点了，直接逐个弹出节点。

```
import java.util.Arrays;
import java.util.PriorityQueue;

public class Code04_SortArrayDistanceLessK {
    public static void sortedArrDistanceLessK(int[] arr, int k) {
     // 复杂度O(N*logK)
        if (k == 0) {
            return;
        }
        // 默认小根堆
        PriorityQueue<Integer> heap = new PriorityQueue<>();
        int index = 0;
        // 第一步：先建一个小根堆，0...K。这里一定有最小值，因为题目给出排序移动距离不超过k.
        // 比如k=3,则下标索引0,1,2,3。
        for (; index <= Math.min(arr.length - 1, k); index++) {
            heap.add(arr[index]);
        }
        int i = 0;
        // 第二步：先弹出小根堆的最小值，然后再添加，再弹出
        for (; index < arr.length; i++, index++) {
            arr[i] = heap.poll();
            heap.add(arr[index]);

        }
        // 第三步：最后发现没有可以添加的节点了，直接逐个弹出节点。最后arr就是升序排好序的结果
        while (!heap.isEmpty()) {
            arr[i++] = heap.poll();
        }
    }

    // for test
    public static void comparator(int[] arr, int k) {
        Arrays.sort(arr);
    }

    // for test
    public static int[] randomArrayNoMoveMoreK(int maxSize, int maxValue, int K) {
        int[] arr = new int[(int) ((maxSize + 1) * Math.random())];
        for (int i = 0; i < arr.length; i++) {
            arr[i] = (int) ((maxValue + 1) * Math.random()) - (int) (maxValue * Math.random());
        }
        // 先排个序
        Arrays.sort(arr);
        // 然后开始随意交换，但是保证每个数距离不超过K
        // swap[i] == true, 表示i位置已经参与过交换
        // swap[i] == false, 表示i位置没有参与过交换
        boolean[] isSwap = new boolean[arr.length];
        for (int i = 0; i < arr.length; i++) {
            int j = Math.min(i + (int) (Math.random() * (K + 1)), arr.length - 1);
            if (!isSwap[i] && !isSwap[j]) {
                isSwap[i] = true;
                isSwap[j] = true;
                int tmp = arr[i];
                arr[i] = arr[j];
                arr[j] = tmp;
            }
        }
        return arr;
    }

    // for test
    public static int[] copyArray(int[] arr) {
        if (arr == null) {
            return null;
        }
        int[] res = new int[arr.length];
        for (int i = 0; i < arr.length; i++) {
            res[i] = arr[i];
        }
        return res;
    }

    // for test
    public static boolean isEqual(int[] arr1, int[] arr2) {
        if ((arr1 == null && arr2 != null) || (arr1 != null && arr2 == null)) {
            return false;
        }
        if (arr1 == null && arr2 == null) {
            return true;
        }
        if (arr1.length != arr2.length) {
            return false;
        }
        for (int i = 0; i < arr1.length; i++) {
            if (arr1[i] != arr2[i]) {
                return false;
            }
        }
        return true;
    }

    // for test
    public static void printArray(int[] arr) {
        if (arr == null) {
            return;
        }
        for (int i = 0; i < arr.length; i++) {
            System.out.print(arr[i] + " ");
        }
        System.out.println();
    }

    // for test
    public static void main(String[] args) {
        System.out.println("test begin");
        int testTime = 500000;
        int maxSize = 100;
        int maxValue = 100;
        boolean succeed = true;
        for (int i = 0; i < testTime; i++) {
            int k = (int) (Math.random() * maxSize) + 1;
            int[] arr = randomArrayNoMoveMoreK(maxSize, maxValue, k);
            int[] arr1 = copyArray(arr);
            int[] arr2 = copyArray(arr);
            sortedArrDistanceLessK(arr1, k);
            comparator(arr2, k);
            if (!isEqual(arr1, arr2)) {
                succeed = false;
                System.out.println("K : " + k);
                printArray(arr);
                printArray(arr1);
                printArray(arr2);
                break;
            }
        }
        System.out.println(succeed ? "Nice!" : "Fucking fucked!");
    }
}
```

## 比较器

1. 比较器的实质是重载比较运算符
2. 比较器可以很好的应用在特殊标准的排序上
3. 写代码变得异常容易，还用于泛型编程

**比较器通用规则**

a-b的return返回值，如果结果为：

- 负数,表示a排前，b在后，即升序
- 正数,表示b排前，a在后，即降序
- 0,表示ab相等

```js
var arr=[3,12,23,43,11,6,123];
function cmp(a,b){return a-b;}//比较器
arr.sort(cmp);//使用比较器
console.log(String(arr));//3,6,11,12,23,43,123
```

**利用比较器，自己实现动态小根堆**

```
import java.util.ArrayList;
import java.util.Comparator;
import java.util.HashMap;
import java.util.List;
public class HeapGreater<T> {
    // 利用比较器，自己实现动态的小根堆.即增删改后，始终都是小根堆。因为系统不提供动态的小根堆，只是一个静态的小根堆.关键就是节点索引记录表，知道了i,可以上窜或下窜。
    // 加入小根堆的节点
    private ArrayList<T> heap;
    // 节点索引记录表：加入过小根堆的节点对应的索引值
    private HashMap<T, Integer> indexMap;
    private int heapSize;
    // 比较器规则
    private Comparator<? super T> comp;

    public HeapGreater(Comparator<? super T> c) {
        heap = new ArrayList<>();
        indexMap = new HashMap<>();
        heapSize = 0;
        comp = c;
    }

    public boolean isEmpty() {
        return heapSize == 0;
    }

    public int size() {
        return heapSize;
    }

    public boolean contains(T obj) {
        // 判断是否加入过小根堆
        return indexMap.containsKey(obj);
    }

    // 去除小根堆的顶部
    public T peek() {
        return heap.get(0);
    }

    // 添加节点到小根堆
    public void push(T obj) {
        // 直接先添加
        heap.add(obj);
        // 节点表添加节点索引
        indexMap.put(obj, heapSize);
        // 上窜，并且按照cop比较器规则上窜
        heapInsert(heapSize++);
    }

    // 弹出小根堆顶部节点
    public T pop() {
        // 先取出要返回的节点，然后小根堆化
        T ans = heap.get(0);
        // 交换到最后
        swap(0, heapSize - 1);
        // 两个map同步删除
        indexMap.remove(ans);
        heap.remove(--heapSize);
        // 把顶部节点下窜，并且按照cop比较器规则下窜
        heapify(0);
        return ans;
    }

    // 删除一个小根堆节点
    public void remove(T obj) {
        T replace = heap.get(heapSize - 1);
        int index = indexMap.get(obj);
        indexMap.remove(obj);
        heap.remove(--heapSize);
        if (obj != replace) {
            heap.set(index, replace);
            indexMap.put(replace, index);
            resign(replace);
        }
    }

    // 更新了节点值，重置小根堆，使其小根堆化
    public void resign(T obj) {
        // 因为不确定节点是上窜还是下窜，关键就是这个索引值即记录表
        // 要么上窜
        heapInsert(indexMap.get(obj));
        // 要么下窜
        heapify(indexMap.get(obj));
    }

    // 请返回堆上的所有元素
    public List<T> getAllElements() {
        List<T> ans = new ArrayList<>();
        for (T c : heap) {
            ans.add(c);
        }
        return ans;
    }

    // 上窜
    private void heapInsert(int index) {
        // 按照比较器规则上窜，因为是负数，所以整体是升序，对应小根堆
        while (comp.compare(heap.get(index), heap.get((index - 1) / 2)) < 0) {
            swap(index, (index - 1) / 2);
            index = (index - 1) / 2;
        }
    }

    // 下窜
    private void heapify(int index) {
        int left = index * 2 + 1;
        while (left < heapSize) {
            // 按照比较器规则下窜，因为是负数，所以整体是升序，对应小根堆
            int best = left + 1 < heapSize && comp.compare(heap.get(left + 1), heap.get(left)) < 0 ? (left + 1) : left;
            best = comp.compare(heap.get(best), heap.get(index)) < 0 ? best : index;
            if (best == index) {
                break;
            }
            swap(best, index);
            index = best;
            left = index * 2 + 1;
        }
    }

    // 交换
    private void swap(int i, int j) {
        T o1 = heap.get(i);
        T o2 = heap.get(j);
        // heap有变动，indexMap也变动，强同步
        heap.set(i, o2);
        heap.set(j, o1);
        indexMap.put(o2, i);
        indexMap.put(o1, j);
    }
}
```

# 数组

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

# 字符串

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

## 

# 单链表

没有复杂的数据结构，纯记忆多做即可

## 单链表反转

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

## 双链表反转

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

## 用单链表结构实现队列

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

## 用单链表结构实现栈

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

## 用双链表结构实现双端队列

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

## 单链表的k个节点的组内逆序调整

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

## 两个链表相加

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

## 链表套路

套路：

- 对于笔试，不用关注空间复杂度，一切为了时间复杂度。比如：hash表，数组等
- 对于面试，时间复杂度依然第一，还要找到空间最省的方法。比如：快慢指针

### 快慢指针

定义：一般情况下，快指针的移动步长为慢指针的两倍。利用快慢指针，我们把一个链表看成一个跑道，假设**a**的速度是**b**的两倍，那么当**a**跑完全程后，**b**刚好跑一半，以 此来 达到找到中间节点的目的。

题目：

1. 输入链表头结点，奇数长度返回中点，偶数长度返回上中点
2. 输入链表头结点，奇数长度返回中点，偶数长度返回下中点
3. 输入链表头结点，奇数长度返回中点前一个，偶数长度返回上中点前一个
4. 输入链表头结点，奇数长度返回中点前一个，偶数长度返回下中点前一个

- 解法1：暴力求解，把节点加入到数组中，二分取值---用于笔试
- 解法2：快慢指针，---用于面试，如果笔试中能写出也可以

```
import java.util.ArrayList;
public class Code01_LinkedListMid {
   public static class Node {
      public int value;
      public Node next;
      public Node(int v) {
         value = v;
      }
   }
   // 判断链表中是否存在环
   public boolean hasCycle(Node head) {
      if (head == null)
         return false;
      //快慢两个指针，初始时都指向链表的头结点
      Node slow = head;
      Node fast = head;
      while (fast != null && fast.next != null) {
         //慢指针每次走一步
         slow = slow.next;
         //快指针每次走两步
         fast = fast.next.next;
         //如果相遇，说明有环，直接返回true
         if (slow == fast)
            return true;
      }
      //否则就是没环
      return false;
   }

   // 题目1：解法2：快慢指针，---用于面试，如果笔试中能写出也可以
   public static Node midOrUpMidNode(Node head) {
      // 链表没有节点，有1个节点，2个节点
      if (head == null || head.next == null || head.next.next == null) {
         return head;
      }
      // 链表有3个点或以上
      // 根据题意，确定快慢指针的起始位置，起始值位置不用记忆，直接按照结果尝试奇偶即可
      Node slow = head.next;
      Node fast = head.next.next;
      // 快慢指针的走法都是每次慢指针走一步，快指针走两步
      while (fast.next != null && fast.next.next != null) {
         slow = slow.next;
         fast = fast.next.next;
      }
      return slow;
   }
   // 题目2
   public static Node midOrDownMidNode(Node head) {
      if (head == null || head.next == null) {
         return head;
      }
      Node slow = head.next;
      Node fast = head.next;
      while (fast.next != null && fast.next.next != null) {
         slow = slow.next;
         fast = fast.next.next;
      }
      return slow;
   }
   // 题目3
   public static Node midOrUpMidPreNode(Node head) {
      if (head == null || head.next == null || head.next.next == null) {
         return null;
      }
      Node slow = head;
      Node fast = head.next.next;
      while (fast.next != null && fast.next.next != null) {
         slow = slow.next;
         fast = fast.next.next;
      }
      return slow;
   }
   // 题目4
   public static Node midOrDownMidPreNode(Node head) {
      if (head == null || head.next == null) {
         return null;
      }
      if (head.next.next == null) {
         return head;
      }
      Node slow = head;
      Node fast = head.next;
      while (fast.next != null && fast.next.next != null) {
         slow = slow.next;
         fast = fast.next.next;
      }
      return slow;
   }
   // 题目1：解法1：暴力求解，把节点加入到数组中，二分取值---用于笔试
   public static Node right1(Node head) {
      if (head == null) {
         return null;
      }
      Node cur = head;
      ArrayList<Node> arr = new ArrayList<>();
      while (cur != null) {
         arr.add(cur);
         cur = cur.next;
      }
      return arr.get((arr.size() - 1) / 2);
   }

   public static Node right2(Node head) {
      if (head == null) {
         return null;
      }
      Node cur = head;
      ArrayList<Node> arr = new ArrayList<>();
      while (cur != null) {
         arr.add(cur);
         cur = cur.next;
      }
      return arr.get(arr.size() / 2);
   }

   public static Node right3(Node head) {
      if (head == null || head.next == null || head.next.next == null) {
         return null;
      }
      Node cur = head;
      ArrayList<Node> arr = new ArrayList<>();
      while (cur != null) {
         arr.add(cur);
         cur = cur.next;
      }
      return arr.get((arr.size() - 3) / 2);
   }

   public static Node right4(Node head) {
      if (head == null || head.next == null) {
         return null;
      }
      Node cur = head;
      ArrayList<Node> arr = new ArrayList<>();
      while (cur != null) {
         arr.add(cur);
         cur = cur.next;
      }
      return arr.get((arr.size() - 2) / 2);
   }

   public static void main(String[] args) {
      Node test = null;
      test = new Node(0);
      test.next = new Node(1);
      test.next.next = new Node(2);
      test.next.next.next = new Node(3);
      test.next.next.next.next = new Node(4);
      test.next.next.next.next.next = new Node(5);
      test.next.next.next.next.next.next = new Node(6);
      test.next.next.next.next.next.next.next = new Node(7);
      test.next.next.next.next.next.next.next.next = new Node(8);

      Node ans1 = null;
      Node ans2 = null;

      ans1 = midOrUpMidNode(test);
      ans2 = right1(test);
      System.out.println(ans1 != null ? ans1.value : "无");
      System.out.println(ans2 != null ? ans2.value : "无");

      ans1 = midOrDownMidNode(test);
      ans2 = right2(test);
      System.out.println(ans1 != null ? ans1.value : "无");
      System.out.println(ans2 != null ? ans2.value : "无");

      ans1 = midOrUpMidPreNode(test);
      ans2 = right3(test);
      System.out.println(ans1 != null ? ans1.value : "无");
      System.out.println(ans2 != null ? ans2.value : "无");

      ans1 = midOrDownMidPreNode(test);
      ans2 = right4(test);
      System.out.println(ans1 != null ? ans1.value : "无");
      System.out.println(ans2 != null ? ans2.value : "无");
   }
}
```

### 链表是否回文

题目：给定一个单链表头结点head,请判断该链表是否为回文结构

- 栈方法特别简单---笔试用
- 改原链表的方法就需要注意边界---面试用

解法：

- 解法1：把链表所有节点放进栈中，然后逐一出栈(相当于逆序)和链表逐一比对
- 解法2：利用快慢指针，找到中点或上中点。中点以后的节点全部入栈，然后逐一出栈(相当于逆序)和链表逐一比对，直到栈空为止。可以想象成纸对折逐一比对。
- 解法3：不使用额外空间，利用快慢指针，找到中点或上中点。中点以后的节点全部逆序指向，定义左右两个指针，逐一比较。

```
import java.util.Stack;
public class Code02_IsPalindromeList {
   public static class Node {
      public int value;
      public Node next;
      public Node(int data) {
         this.value = data;
      }
   }

   // 解法1：把链表所有节点放进栈中，然后逐一出栈(相当于逆序)和链表逐一比对
   public static boolean isPalindrome1(Node head) {
      Stack<Node> stack = new Stack<Node>();
      Node cur = head;
      while (cur != null) {
         stack.push(cur);
         cur = cur.next;
      }
      while (head != null) {
         if (head.value != stack.pop().value) {
            return false;
         }
         head = head.next;
      }
      return true;
   }

   // 解法2：利用快慢指针，找到中点或上中点。中点以后的节点全部入栈，然后逐一出栈(相当于逆序)和链表逐一比对，直到栈空为止。可以想象成纸对折逐一比对。
   public static boolean isPalindrome2(Node head) {
      if (head == null || head.next == null) {
         return true;
      }
      Node right = head.next;
      Node cur = head;
      while (cur.next != null && cur.next.next != null) {
         right = right.next;
         cur = cur.next.next;
      }
      Stack<Node> stack = new Stack<Node>();
      while (right != null) {
         stack.push(right);
         right = right.next;
      }
      while (!stack.isEmpty()) {
         if (head.value != stack.pop().value) {
            return false;
         }
         head = head.next;
      }
      return true;
   }

   // 解法3：不使用额外空间，利用快慢指针，找到中点或上中点。中点以后的节点全部逆序指向，定义左右两个指针，逐一比较。
   public static boolean isPalindrome3(Node head) {
      /*
      * 1->2->3->->3->2->1
      *    null
      *     ^
      *      |
      * 1->2-3<<-3<-2<-1
      * n2             n1 n3
      * */
      if (head == null || head.next == null) {
         return true;
      }
      Node n1 = head;// 慢指针
      Node n2 = head;// 快指针
      while (n2.next != null && n2.next.next != null) { // find mid node
         n1 = n1.next; // n1 -> mid
         n2 = n2.next.next; // n2 -> end
      }
      // n1 中点
      // 把n1以后的节点全部逆序指向
      n2 = n1.next; // n2 -> right part first node
      n1.next = null; // mid.next -> null
      Node n3 = null;
      while (n2 != null) { // right part convert
         n3 = n2.next; // n3 -> save next node
         n2.next = n1; // next of right node convert
         n1 = n2; // n1 move
         n2 = n3; // n2 move
      }
      // 临时记录下右节点
      n3 = n1; // n3 -> save last node
      n2 = head;// n2 -> left first node
      boolean res = true;
      // 比较左右节点是否相等
      while (n1 != null && n2 != null) { // check palindrome
         if (n1.value != n2.value) {
            res = false;
            break;
         }
         n1 = n1.next; // left to mid
         n2 = n2.next; // right to mid
      }
      // 将n3-...>n1指向逆序还原回来
      n1 = n3.next;
      n3.next = null;
      while (n1 != null) { // recover list
         n2 = n1.next;
         n1.next = n3;
         n3 = n1;
         n1 = n2;
      }
      return res;
   }

   public static void printLinkedList(Node node) {
      System.out.print("Linked List: ");
      while (node != null) {
         System.out.print(node.value + " ");
         node = node.next;
      }
      System.out.println();
   }

   public static void main(String[] args) {
      Node head = null;
      printLinkedList(head);
      System.out.print(isPalindrome1(head) + " | ");
      System.out.print(isPalindrome2(head) + " | ");
      System.out.println(isPalindrome3(head) + " | ");
      printLinkedList(head);
      System.out.println("=========================");

      head = new Node(1);
      printLinkedList(head);
      System.out.print(isPalindrome1(head) + " | ");
      System.out.print(isPalindrome2(head) + " | ");
      System.out.println(isPalindrome3(head) + " | ");
      printLinkedList(head);
      System.out.println("=========================");

      head = new Node(1);
      head.next = new Node(2);
      printLinkedList(head);
      System.out.print(isPalindrome1(head) + " | ");
      System.out.print(isPalindrome2(head) + " | ");
      System.out.println(isPalindrome3(head) + " | ");
      printLinkedList(head);
      System.out.println("=========================");

      head = new Node(1);
      head.next = new Node(1);
      printLinkedList(head);
      System.out.print(isPalindrome1(head) + " | ");
      System.out.print(isPalindrome2(head) + " | ");
      System.out.println(isPalindrome3(head) + " | ");
      printLinkedList(head);
      System.out.println("=========================");

      head = new Node(1);
      head.next = new Node(2);
      head.next.next = new Node(3);
      printLinkedList(head);
      System.out.print(isPalindrome1(head) + " | ");
      System.out.print(isPalindrome2(head) + " | ");
      System.out.println(isPalindrome3(head) + " | ");
      printLinkedList(head);
      System.out.println("=========================");

      head = new Node(1);
      head.next = new Node(2);
      head.next.next = new Node(1);
      printLinkedList(head);
      System.out.print(isPalindrome1(head) + " | ");
      System.out.print(isPalindrome2(head) + " | ");
      System.out.println(isPalindrome3(head) + " | ");
      printLinkedList(head);
      System.out.println("=========================");

      head = new Node(1);
      head.next = new Node(2);
      head.next.next = new Node(3);
      head.next.next.next = new Node(1);
      printLinkedList(head);
      System.out.print(isPalindrome1(head) + " | ");
      System.out.print(isPalindrome2(head) + " | ");
      System.out.println(isPalindrome3(head) + " | ");
      printLinkedList(head);
      System.out.println("=========================");

      head = new Node(1);
      head.next = new Node(2);
      head.next.next = new Node(2);
      head.next.next.next = new Node(1);
      printLinkedList(head);
      System.out.print(isPalindrome1(head) + " | ");
      System.out.print(isPalindrome2(head) + " | ");
      System.out.println(isPalindrome3(head) + " | ");
      printLinkedList(head);
      System.out.println("=========================");

      head = new Node(1);
      head.next = new Node(2);
      head.next.next = new Node(3);
      head.next.next.next = new Node(2);
      head.next.next.next.next = new Node(1);
      printLinkedList(head);
      System.out.print(isPalindrome1(head) + " | ");
      System.out.print(isPalindrome2(head) + " | ");
      System.out.println(isPalindrome3(head) + " | ");
      printLinkedList(head);
      System.out.println("=========================");
   }
}
```

### 链表的复制

题目：一种特殊的单链表结构，其中有个Node rand随机属性。rand可能指向任意节点，也可能指向null.请设计一个函数完成这个链表的复制，返回复制的链表的头结点。

- 解法1：把所有节点放入hashmap,从头结点开始遍历，依次copy出新链表
- 解法2：在每个节点后面插入前一个节点的copy节点，然后设置radom，再分离新老节点

```
import java.util.HashMap;
// 测试链接 : https://leetcode.com/problems/copy-list-with-random-pointer/
public class Code04_CopyListWithRandom {
 public static class Node {
  int val;
  Node next;
  Node random;

  public Node(int val) {
   this.val = val;
   this.next = null;
   this.random = null;
  }
 }

 // 解法1：把所有节点放入hashmap,从头结点开始遍历，依次copy出新链表
 public static Node copyRandomList1(Node head) {
  // key 老节点
  // value 新节点
  HashMap<Node, Node> map = new HashMap<Node, Node>();
  Node cur = head;
  // 所有节点放入hashmap
  while (cur != null) {
   map.put(cur, new Node(cur.val));
   cur = cur.next;
  }
  cur = head;
  // 从头结点开始遍历，依次copy
  while (cur != null) {
   // cur 老节点
   // map.get(cur) 新节点
   // 新.next ->  cur.next克隆节点找到
   map.get(cur).next = map.get(cur.next);
   map.get(cur).random = map.get(cur.random);
   cur = cur.next;
  }
  return map.get(head);
 }

 // 解法2：在每个节点后面插入前一个节点的copy节点，然后设置radom，再分离新老节点
 public static Node copyRandomList2(Node head) {
  if (head == null) {
   return null;
  }
  Node cur = head;
  Node next = null;
  // 1 -> 2 -> 3 -> null
  // 1 -> 1' -> 2 -> 2' -> 3 -> 3'
  // 每个节点后面插入前一个节点的copy节点
  while (cur != null) {
   next = cur.next;
   cur.next = new Node(cur.val);
   cur.next.next = next;
   cur = next;
  }
  cur = head;
  Node copy = null;
  // 1 1' 2 2' 3 3'， 其中1‘是1的复制节点
  // 依次设置 1' 2' 3' 的random指针
  while (cur != null) {
   next = cur.next.next;
   copy = cur.next;
   // 注意cur.random的节点 一定是对应cur.random.next。因为下一个节点是当前节点的复制。
   copy.random = cur.random != null ? cur.random.next : null;
   cur = next;
  }
  Node res = head.next;
  cur = head;
  // 老 新 混在一起，next方向上，random正确
  // next方向上，把新老链表分离，一定动手实际画图，想是想不清楚的
  while (cur != null) {
   next = cur.next.next;
   copy = cur.next;
   cur.next = next;
   copy.next = next != null ? next.next : null;
   cur = next;
  }
  return res;
 }
}
```

### 两链表是否相交

题目：给定两个可能有环也可能无环的单链表，头节点head1和head2。请实 现一个函数，如果两个链表相交，请返回相交的 第一个节点。如果不相交，返 回null。要求时间复杂度O(N),空间复杂度O(1)

思路：这是一个超大题目。涉及知识点：

- 必考知识点：找到链表第一个入环节点，如果无环，返回null
- 必考知识点：如果两个链表都无环，返回第一个相交节点，如果不想交，返回null
- 必考知识点：两个有环链表，返回第一个相交节点，如果不想交返回null

解法：

- 解法：先求链表的入环节点，然后按照无环和有环分情况讨论

```java
public class Code01_FindFirstIntersectNode {
   public static class Node {
      public int value;
      public Node next;
      public Node(int data) {
         this.value = data;
      }
   }

   public static Node getIntersectNode(Node head1, Node head2) {
      // 解法：先求链表的入环节点，然后按照无环和有环分情况讨论
      if (head1 == null || head2 == null) {
         return null;
      }
      // 找到链表第一个入环节点，如果无环，返回null
      Node loop1 = getLoopNode(head1);
      Node loop2 = getLoopNode(head2);
      // 如果两个链表都是无环链表
      if (loop1 == null && loop2 == null) {
         return noLoop(head1, head2);
      }
      // 如果两个链表都是有环链表
      if (loop1 != null && loop2 != null) {
         return bothLoop(head1, loop1, head2, loop2);
      }
      // 一链表有环，一链表无环，一定不会相交。画画图就知道了
      return null;
   }

   // 必考知识点：找到链表第一个入环节点，如果无环，返回null
   public static Node getLoopNode(Node head) {
      /*
      * 解法1：用额外空间，遍历链表，每到一个节点就判断是否在Set里，如果突然发现在了。说明是第一个入环节点。
      * 解法2：快慢指针，慢指针一定不会走够两圈以上，在环内相遇时，将快指针放到开头，慢指针原地不动。然后两个开始一次走一步，最后会在入环节点相遇。本文采用解法2.
      * */
      if (head == null || head.next == null || head.next.next == null) {
         return null;
      }
      // n1 慢指针  n2 快指针，让n1,n2都先走一次，方便下面的while判断
      Node slow = head.next; // n1 -> slow
      Node fast = head.next.next; // n2 -> fast
      while (slow != fast) {
         if (fast.next == null || fast.next.next == null) {
            return null;
         }
         fast = fast.next.next;
         slow = slow.next;
      }
      // 到这里，说明slow fast  相遇了
      // 抖机灵做法：快指针回到头结点，然后快慢指针再次相遇，就是入环节点
      fast = head; // n2 -> walk again from head
      while (slow != fast) {
         slow = slow.next;
         fast = fast.next;
      }
      return slow;
   }

   // 必考知识点：如果两个链表都无环，返回第一个相交节点，如果不想交，返回null
   public static Node noLoop(Node head1, Node head2) {
      /*
      * 先统计head1到end1并且记住长度假设是100，然后统计head2和end2并且记住长度假设是80。如果end1！=end2则没有相交部分。
      * 如果一样，则head1先走20步，然后一起走直到找到相同内存的节点，即相交节点。可以通过n记录链表一和二的长度之差，节约一个变量。
      * */
      if (head1 == null || head2 == null) {
         return null;
      }
      Node cur1 = head1;
      Node cur2 = head2;
      int n = 0;
      while (cur1.next != null) {
         n++;
         cur1 = cur1.next;
      }
      while (cur2.next != null) {
         n--;
         cur2 = cur2.next;
      }
      // 因为是无环链表，如果最后的节点都不相同，结果一定是不相交，后续不用执行
      if (cur1 != cur2) {
         return null;
      }
      // n 表示链表1长度减去链表2长度的值
      cur1 = n > 0 ? head1 : head2; // 谁长，谁的头变成cur1
      cur2 = cur1 == head1 ? head2 : head1; // 谁短，谁的头变成cur2
      n = Math.abs(n);
      // 长链表减去多余的部分，然后一起往下走
      while (n != 0) {
         n--;
         cur1 = cur1.next;
      }
      // 如果相遇，则是相交点
      while (cur1 != cur2) {
         cur1 = cur1.next;
         cur2 = cur2.next;
      }
      return cur1;
   }

   // 必考知识点：两个有环链表，返回第一个相交节点，如果不想交返回null
   public static Node bothLoop(Node head1, Node loop1, Node head2, Node loop2) {
      /*
      * 情况1：如果有入环节点相同
      * 情况2:如果有入环点不同，可能有两个入环点
      * 情况3：如果有入环点不同，可能不相交
      * */
      Node cur1 = null;
      Node cur2 = null;
      // 情况1：和前面的无环链表判断类似，只不过节点找到入环节点就可以，也没有入环节点的判断
      if (loop1 == loop2) {
         cur1 = head1;
         cur2 = head2;
         int n = 0;
         while (cur1 != loop1) {
            n++;
            cur1 = cur1.next;
         }
         while (cur2 != loop2) {
            n--;
            cur2 = cur2.next;
         }
         cur1 = n > 0 ? head1 : head2;
         cur2 = cur1 == head1 ? head2 : head1;
         n = Math.abs(n);
         while (n != 0) {
            n--;
            cur1 = cur1.next;
         }
         while (cur1 != cur2) {
            cur1 = cur1.next;
            cur2 = cur2.next;
         }
         return cur1;
      } else {
         // 情况2
         cur1 = loop1.next;
         // 链表1从自己的入环点开始遍历一圈，找下是否有节点和链表2的入环点相同，相同即返回节点
         while (cur1 != loop1) {
            if (cur1 == loop2) {
               return loop1;// 或返回loop2都行，因为有2个入环点，随便一个都可以
            }
            cur1 = cur1.next;
         }
         //情况3
         return null;
      }
   }

   public static void main(String[] args) {
      // 1->2->3->4->5->6->7->null
      Node head1 = new Node(1);
      head1.next = new Node(2);
      head1.next.next = new Node(3);
      head1.next.next.next = new Node(4);
      head1.next.next.next.next = new Node(5);
      head1.next.next.next.next.next = new Node(6);
      head1.next.next.next.next.next.next = new Node(7);

      // 0->9->8->6->7->null
      Node head2 = new Node(0);
      head2.next = new Node(9);
      head2.next.next = new Node(8);
      head2.next.next.next = head1.next.next.next.next.next; // 8->6
      System.out.println(getIntersectNode(head1, head2).value);

      // 1->2->3->4->5->6->7->4...
      head1 = new Node(1);
      head1.next = new Node(2);
      head1.next.next = new Node(3);
      head1.next.next.next = new Node(4);
      head1.next.next.next.next = new Node(5);
      head1.next.next.next.next.next = new Node(6);
      head1.next.next.next.next.next.next = new Node(7);
      head1.next.next.next.next.next.next = head1.next.next.next; // 7->4

      // 0->9->8->2...
      head2 = new Node(0);
      head2.next = new Node(9);
      head2.next.next = new Node(8);
      head2.next.next.next = head1.next; // 8->2
      System.out.println(getIntersectNode(head1, head2).value);

      // 0->9->8->6->4->5->6..
      head2 = new Node(0);
      head2.next = new Node(9);
      head2.next.next = new Node(8);
      head2.next.next.next = head1.next.next.next.next.next; // 8->6
      System.out.println(getIntersectNode(head1, head2).value);
   }
}
```

### 不给头结点删除节点

题目：能不能不给单链表的头结点，只给想要删除的节点，就能做到在链表上把这个点删除掉？

解法：抖机灵的做法，把删除节点的下一个节点复制到当前节点，删除下一个节点。

弊端：无法删除链表最后一个节点；因为是复制节点，如果节点表示服务器，那就不可能这么操作。

# 二叉树

## 二叉树遍历

- 先序遍历：对于所有子树，先访问头结点-左节点-右节点
- 中序遍历：对于所有子树，先访问左结点-头节点-右节点
- 后序遍历：对于所有子树，先访问左结点-右节点-头节点

题目：二叉树节点结构 第一层1 第二层2 3 第三层 4 5 6 7。

**递归遍历**

递归序：1，2，4，4，4，5，5，5，2，1，3，6，6，6，3，7，7，7，3，1 相当于第一次到自己的时候输出一下，然后左子树走完后输出一下，右子树走完后输出一下。这是递归实现，所有的递归都可以用非递归替代。

先序遍历（头左右）：1，2，4，5，3，6，7 相当于递归序里第一次来到的时候打印，第二三次到的时候什么也不做

中序遍历（左头右）：4，2，5，1，6，3，7 相当于递归序里第二次来到的时候打印，第一三次到的时候什么也不做

后序遍历（左右头）：4，2，5，1，6，3，7 相当于递归序里第三次来到的时候打印，第一二次到的时候什么也不做

```
// 传统二叉树递归遍历
public static void pre(Node head) {
    if (head == null) {
        return;
    }
    System.out.println("先序遍历" + head.value);
    pre(head.left);
    System.out.println("中序遍历" + head.value);
    pre(head.right);
    System.out.println("后序遍历" + head.value);
}

// 递归序遍历
public static void f(Node head) {
    if (head == null) {
        return;
    }
    // 1-第1次到达
    f(head.left);
    // 2-第2次到达
    f(head.right);
    // 3-第2次到达
}
```

**非递归遍历**

```
import java.util.Stack;
public class Code03_UnRecursiveTraversalBT {
    public static class Node {
        public int value;
        public Node left;
        public Node right;
        public Node(int v) {
            value = v;
        }
    }

    // 先序遍历
    /*用栈实现：因为栈的特性是先进后出，右比左先压入，所以先打印左然后右
     * 1.栈压入头结点
     * 2.栈弹出节点，打印
     * 3.如果右节点存在，压入右节点
     * 4.如果左节点存在，压入左节点
     * 5.循环2,3,4
     * */
    public static void pre(Node head) {
        System.out.print("pre-order: ");
        if (head != null) {
            Stack<Node> stack = new Stack<Node>();
            stack.add(head);
            while (!stack.isEmpty()) {
                head = stack.pop();
                System.out.print(head.value + " ");
                if (head.right != null) {
                    stack.push(head.right);
                }
                if (head.left != null) {
                    stack.push(head.left);
                }
            }
        }
        System.out.println();
    }

    // 中序遍历
    /*用栈实现：因为栈的特性是先进后出，右比左先压入，所以先打印左然后右
     * 1.初始化当前cur为头结点
     * 2.从cur出发，依次压入所有左节点。直到为null.
     * 3.栈弹出节点，打印
     * 4.cur来到cur的右节点
     * 5.循环2,3,4
     * */
    public static void in(Node cur) {
        System.out.print("in-order: ");
        if (cur != null) {
            Stack<Node> stack = new Stack<Node>();
            while (!stack.isEmpty() || cur != null) {
                if (cur != null) {
                    // 第2步
                    stack.push(cur);
                    cur = cur.left;
                } else {
                    // 第3,4步
                    cur = stack.pop();
                    System.out.print(cur.value + " ");
                    cur = cur.right;
                }
            }
        }
        System.out.println();
    }

    // 后续遍历：解法1
    /*用栈实现：准备2个栈。因为栈的特性是先进后出，初步得到是头-右-左。直接利用栈s2逆序弹出就是左右头。
     * 1.栈压入头结点
     * 2.栈弹出节点，打印
     * 3.如果左节点存在，压入左节点
     * 4.如果右节点存在，压入右节点
     * 5.循环2,3,4
     * */
    public static void pos1(Node head) {
        System.out.print("pos-order: ");
        if (head != null) {
            Stack<Node> s1 = new Stack<Node>();
            Stack<Node> s2 = new Stack<Node>();
            s1.push(head);
            while (!s1.isEmpty()) {
                head = s1.pop(); // 头 右 左
                s2.push(head);
                if (head.left != null) {
                    s1.push(head.left);
                }
                if (head.right != null) {
                    s1.push(head.right);
                }
            }
            // 左 右 头
            while (!s2.isEmpty()) {
                System.out.print(s2.pop().value + " ");
            }
        }
        System.out.println();
    }

    // 后续遍历：解法2，很难想到这种思路
    /*思路：
     * 先看栈顶元素有无左孩子，有就入栈，这里完成左边界入栈。
     * 然后从栈顶peek，如果该节点没有左右孩子，则pop掉并打印，并且将该元素赋给变量h，再peek栈顶元素，这个节点因为是h的父元素，所以看有没有右孩子，如果有，将右孩子压入栈。
     * 将该节点右孩子处理完后，此节点被pop，以此类推。
     * */
    public static void pos2(Node h) {
        System.out.print("pos-order: ");
        if (h != null) {
            Stack<Node> stack = new Stack<Node>();
            stack.push(h);
            Node c = null;
            while (!stack.isEmpty()) {
                c = stack.peek();
                if (c.left != null && h != c.left && h != c.right) {
                    // 先压入所有左节点
                    stack.push(c.left);
                } else if (c.right != null && h != c.right) {
                    // 然后压入右节点
                    stack.push(c.right);
                } else {
                    // 先处理左树，然后处理右树，再处理头节点
                    System.out.print(stack.pop().value + " ");
                    h = c;
                }
            }
        }
        System.out.println();
    }

    public static void main(String[] args) {
        Node head = new Node(1);
        head.left = new Node(2);
        head.right = new Node(3);
        head.left.left = new Node(4);
        head.left.right = new Node(5);
        head.right.left = new Node(6);
        head.right.right = new Node(7);
        pre(head);
        System.out.println("========");
        in(head);
        System.out.println("========");
        pos1(head);
        System.out.println("========");
        pos2(head);
        System.out.println("========");
    }
}
```

## 二叉树宽度优先遍历

本质就是按照层遍历，用队列实现

```
// 二叉树宽度优先遍历，利用队列实现
public static void level(Node head) {
   if (head == null) {
      return;
   }
   Queue<Node> queue = new LinkedList<>();
   // 头结点入队列
   queue.add(head);
   while (!queue.isEmpty()) {
      // 节点先出队列
      Node cur = queue.poll();
      System.out.println(cur.value);
      // 如果有左子节点，加入队列
      if (cur.left != null) {
         queue.add(cur.left);
      }
      // 如果有右子节点，加入队列。循环上面操作
      if (cur.right != null) {
         queue.add(cur.right);
      }
   }
}
```

## 二叉树的最大宽度

题目：求每一层二叉树中最大宽度的层的宽度

- 解法1，利用map记录node来到的层数，方便遍历完一层后，才开始比较大小
- 解法2，不使用map,通过设置flag变量的方式，来发现某一层的结束

```
// 二叉树的最大宽度：解法1，利用map记录node来到的层数，方便遍历完一层后，才开始比较大小
public static int maxWidthUseMap(Node head) {
    if (head == null) {
        return 0;
    }
    Queue<Node> queue = new LinkedList<>();
    queue.add(head);
    // key 在 哪一层，value,
    HashMap<Node, Integer> levelMap = new HashMap<>();
    // 头结点在第1层，从第1层开始
    levelMap.put(head, 1);
    int curLevel = 1; // 当前你正在统计哪一层的宽度
    int curLevelNodes = 0; // 当前层curLevel层，宽度目前是多少
    // 最大宽度
    int max = 0;
    while (!queue.isEmpty()) {
        Node cur = queue.poll();
        int curNodeLevel = levelMap.get(cur);
        // 利用队列进行宽度优先遍历
        if (cur.left != null) {
            // 记录节点层数
            levelMap.put(cur.left, curNodeLevel + 1);
            queue.add(cur.left);
        }
        if (cur.right != null) {
            // 记录节点层数
            levelMap.put(cur.right, curNodeLevel + 1);
            queue.add(cur.right);
        }
        if (curNodeLevel == curLevel) {
            // 当前节点还在当前记录的层数上，宽度+1
            curLevelNodes++;
        } else {
            // 当前节点的层数不是当前记录的层数，那么一定是来到了下一层，可以小结比较了
            max = Math.max(max, curLevelNodes);
            // 记录的层数+1，已经来到新的下一层
            curLevel++;
            // 已经来到下新的下一层，宽度记录为1
            curLevelNodes = 1;
        }
    }
    // 最后比较全局最大宽度和最后一层的宽度
    max = Math.max(max, curLevelNodes);
    return max;
}

// 二叉树的最大宽度：解法2，不使用map,通过设置flag变量的方式，来发现某一层的结束
public static int maxWidthNoMap(Node head) {
    if (head == null) {
        return 0;
    }
    Queue<Node> queue = new LinkedList<>();
    queue.add(head);
    Node curEnd = head; // 当前层，最右节点是谁
    Node nextEnd = null; // 下一层，最右节点是谁
    int max = 0;
    int curLevelNodes = 0; // 当前层的节点数
    while (!queue.isEmpty()) {
        // 常规的宽度优先遍历
        Node cur = queue.poll();
        if (cur.left != null) {
            queue.add(cur.left);
            // 在当前层，就已经拿到下一层的最右一个节点
            nextEnd = cur.left;
        }
        if (cur.right != null) {
            queue.add(cur.right);
            nextEnd = cur.right;
        }
        // 当前层宽度++
        curLevelNodes++;
        // 当前节点来到当前层的最右节点时
        if (cur == curEnd) {
            max = Math.max(max, curLevelNodes);
            // 下一层马上要变成当前层了
            // 初始化下一层的宽度为0
            curLevelNodes = 0;
            // 把当前层的最右节点更新为下一层的最右节点，继续循环
            curEnd = nextEnd;
        }
    }
    return max;
}
```

## 二叉树的序列化和反序列化

内存里的一棵树如何变成字符串形式，又如何从字符串形式变成内存里的树。

思路：先序列化，将一棵树遍历（先序遍历），然后空就用#代替，存储成一个字符串。然后反序列化就是用一个队列将字符串拆成值并一一压入，再递归构建树。不是很难，**用什么逻辑序列化就是相同逻辑反序列化**。

- 按照先序遍历的逻辑，序列化和反序列化
- 按照宽度优先遍历逻辑，序列化和反序列化

```
/*
 * 二叉树可以通过先序、后序或者按层遍历的方式序列化和反序列化，
 * 以下代码全部实现了。
 * 但是，二叉树无法通过中序遍历的方式实现序列化和反序列化
 * 因为不同的两棵树，可能得到同样的中序序列，即便补了空位置也可能一样。
 * 比如如下两棵树
 *         __2
 *        /
 *       1
 *       和
 *       1__
 *          \
 *           2
 * 补足空位置的中序遍历结果都是{ null, 1, null, 2, null}
 *
 * */
  // 序列化：先序遍历，在遍历的时候，序列节点
    public static Queue<String> preSerial(Node head) {
        Queue<String> ans = new LinkedList<>();
        pres(head, ans);
        return ans;
    }
    public static void pres(Node head, Queue<String> ans) {
        if (head == null) {
            // 空需要补空，序列化空
            ans.add(null);
        } else {
            // 先序遍历，先加入到队列中，序列化节点
            ans.add(String.valueOf(head.value));
            pres(head.left, ans);
            pres(head.right, ans);
        }
    }
    
     // 反序列化：按照先序遍历的逻辑，反向操作
    public static Node buildByPreQueue(Queue<String> prelist) {
        if (prelist == null || prelist.size() == 0) {
            return null;
        }
        return preb(prelist);
    }
    public static Node preb(Queue<String> prelist) {
        // 和先序遍历的逻辑如出一辙
        String value = prelist.poll();
        if (value == null) {
            // 空返回空节点，反序列化节点
            return null;
        }
        // 反序列化的节点
        Node head = new Node(Integer.valueOf(value));
        // 反序列化的节点，补齐它的左子节点
        head.left = preb(prelist);
        // 反序列化的节点，补齐它的右子节点
        head.right = preb(prelist);
        return head;
    }
    
        // 序列化：按照层遍历即宽度优先遍历，在遍历的时候，序列节点
    public static Queue<String> levelSerial(Node head) {
        Queue<String> ans = new LinkedList<>();
        if (head == null) {
            // 空节点序列化补空
            ans.add(null);
        } else {
            // 在遍历的时候，序列节点
            ans.add(String.valueOf(head.value));
            Queue<Node> queue = new LinkedList<Node>();
            queue.add(head);
            while (!queue.isEmpty()) {
                head = queue.poll(); // head 父   子
                if (head.left != null) {
                    //  添加节点的时候，序列化
                    ans.add(String.valueOf(head.left.value));
                    queue.add(head.left);
                } else {
                    // 空节点也要序列化
                    ans.add(null);
                }
                if (head.right != null) {
                    ans.add(String.valueOf(head.right.value));
                    queue.add(head.right);
                } else {
                    ans.add(null);
                }
            }
        }
        return ans;
    }

    // 反序列化：按照宽度优先遍历，反向逻辑操作
    public static Node buildByLevelQueue(Queue<String> levelList) {
        // 边界条件
        if (levelList == null || levelList.size() == 0) {
            return null;
        }
        // 先反序列生成头结点
        Node head = generateNode(levelList.poll());
        // 建立需要while遍历的队列
        Queue<Node> queue = new LinkedList<Node>();
        if (head != null) {
            queue.add(head);
        }
        Node node = null;
        // 借助队列，遍历所有节点
        while (!queue.isEmpty()) {
            // 弹出反序列化的节点
            node = queue.poll();
            // 反序列化的节点的左子节点
            node.left = generateNode(levelList.poll());
            // 反序列化的节点的右子节点
            node.right = generateNode(levelList.poll());
            if (node.left != null) {
                // 不为空的节点，要加入到循环队列，方便后面继续宽度优先遍历
                queue.add(node.left);
            }
            if (node.right != null) {
                queue.add(node.right);
            }
        }
        return head;
    }

    // 节点生成函数
    public static Node generateNode(String val) {
        if (val == null) {
            return null;
        }
        return new Node(Integer.valueOf(val));
    }
```

## 二叉树任意节点的后继节点

题目：给你二叉树中的某个节点，返回该节点的后继节点

后继节点定义：对一棵二叉树进行中序遍历，遍历后的顺序，当前节点的后一个节点为该节点的后继节点。前驱结点：也是相对于中序遍历而言的。一个节点的前一个节点。

**中序遍历：对于每个节点，都按照左头右访问。**

- 解法1：先中序遍历然后存入一个List,然后再遍历找到当前节点的下一个节点，但是时间复杂度是O(N)
- 解法2：要求时间复杂度为O(K)，其中K为两个节点的距离

```
public class Code06_SuccessorNode {
    public static class Node {
        public int value;
        public Node left;
        public Node right;
        public Node parent;

        public Node(int data) {
            this.value = data;
        }
    }

    public static Node getSuccessorNode(Node node) {
        // 解法2：返回后继节点，利用中序遍历中后继节点的特性
        if (node == null) {
            return node;
        }
        if (node.right != null) {
            // 如果该节点有右孩子，那么右子树的最左节点就是后继节点。
            return getLeftMost(node.right);
        } else {
            // 如果该节点无右孩子，那么它的后继节点一定是往上找父节点，直到节点是其父节点的左孩子，返回。因为左头
            Node parent = node.parent;
            // 父节点不能为null,null表示到根节点了。同时只要当前节点是其父节点的右孩子，循环继续。直到节点是其父节点的左孩子，跳出循环。
            while (parent != null && parent.right == node) { // 当前节点是其父亲节点右孩子
                // 更新当前节点
                node = parent;
                // 取出当前节点的父节点
                parent = node.parent;
            }
            // 返回那个节点是其父节点的左孩子的节点，就是后继节点
            return parent;
        }
    }

    // 返回该节点的最左节点
    public static Node getLeftMost(Node node) {
        if (node == null) {
            return node;
        }
        // 只要节点的左节点不为空，就循环找，直到该节点的左节点为空。返回该节点
        while (node.left != null) {
            node = node.left;
        }
        return node;
    }

    public static void main(String[] args) {
        Node head = new Node(6);
        head.parent = null;
        head.left = new Node(3);
        head.left.parent = head;
        head.left.left = new Node(1);
        head.left.left.parent = head.left;
        head.left.left.right = new Node(2);
        head.left.left.right.parent = head.left.left;
        head.left.right = new Node(4);
        head.left.right.parent = head.left;
        head.left.right.right = new Node(5);
        head.left.right.right.parent = head.left.right;
        head.right = new Node(9);
        head.right.parent = head;
        head.right.left = new Node(8);
        head.right.left.parent = head.right;
        head.right.left.left = new Node(7);
        head.right.left.left.parent = head.right.left;
        head.right.right = new Node(10);
        head.right.right.parent = head.right;

        Node test = head.left.left;
        System.out.println(test.value + " next: " + getSuccessorNode(test).value);
        test = head.left.left.right;
        System.out.println(test.value + " next: " + getSuccessorNode(test).value);
        test = head.left;
        System.out.println(test.value + " next: " + getSuccessorNode(test).value);
        test = head.left.right;
        System.out.println(test.value + " next: " + getSuccessorNode(test).value);
        test = head.left.right.right;
        System.out.println(test.value + " next: " + getSuccessorNode(test).value);
        test = head;
        System.out.println(test.value + " next: " + getSuccessorNode(test).value);
        test = head.right.left.left;
        System.out.println(test.value + " next: " + getSuccessorNode(test).value);
        test = head.right.left;
        System.out.println(test.value + " next: " + getSuccessorNode(test).value);
        test = head.right;
        System.out.println(test.value + " next: " + getSuccessorNode(test).value);
        test = head.right.right; // 10's next is null
        System.out.println(test.value + " next: " + getSuccessorNode(test));
    }
}
```

## 折纸问题

请把一段纸条竖着放在桌子上，然后从纸条的下边向上方对折1次，压出折痕后 展开。
此时折痕是凹下去的，即折痕突起的方向指向纸条的背面。
如果从纸条的下边向上方连续对折2次，压出折痕后展开，此时有三条折痕，从 上到下依次是下折痕、下折痕和上折痕。
给定一个输入参数N，代表纸条都从下边向上方连续对折N次。
请从上到下打印所有折痕的方向。
例如:N=1时，打印: down N=2时，打印: down down up
思路：试验一下会发现，每次折完之后，会在每个上一次出现的痕迹处上面出现一个凹痕下面出现一个凸痕，其实可以理解为树，这个数根节点是凹痕，然后所有左子树的根节点都是凹痕，所有右子树的根节点都是凸痕。然后通过中序遍历递归去实现打印。

```
public class Code07_PaperFolding {
    public static void printAllFolds(int N) {
        process(1, N, true);
        System.out.println();
    }

    // 当前你来了一个节点，脑海中想象的！
    // 这个节点在第i层，一共有N层，N固定不变的
    // 这个节点如果是凹的话，down = T
    // 这个节点如果是凸的话，down = F
    // 函数的功能：中序打印以你想象的节点为头的整棵树！
    public static void process(int i, int N, boolean down) {
        if (i > N) {
            return;
        }
        process(i + 1, N, true);
        // 这里打印，本质就是用递归模拟中序遍历
        System.out.print(down ? "凹 " : "凸 ");
        process(i + 1, N, false);
    }

    public static void main(String[] args) {
        int N = 4;
        printAllFolds(N);
    }
}
```

## 二叉树递归套路

本质利用递归遍历二叉树的便利性。

1. 假设以X节点为头，假设可以向X左子树和X右子树获取任何信息
2. 在上一步的假设下，套路以X为头结点的树，得到答案的可能性。(最重要)
3. 列出所有可能性后，确定到底需要向左树和右树获取什么样的信息
4. 把左树信息和右树信息整合，就是任何一棵子树需要返回的信息S
5. 递归函数都返回S,每棵子树都这么要求
6. 写代码，在代码中考虑如何把左树的信息和右树信息整合出整棵树的信息

### **套路实践-判断平衡二叉树**

题目：给定一棵二叉树的头结点head,返回这棵树是否为平衡二叉树ALV.

ALV平衡二叉树定义：必须是二叉搜索树；每个节点的左子树和右子树的高度差至多为1

```
public static boolean isBalanced2(Node head) {
    // 返回根节点的平衡性
    return process(head).isBalanced;
}

public static class Info {
    // 先组织定义任意节点的平衡性信息数据结构
    // 该节点下，是否是平衡二叉树ALV
    public boolean isBalanced;
    // 该节点下，树的高度
    public int height;

    public Info(boolean i, int h) {
        isBalanced = i;
        height = h;
    }
}

public static Info process(Node x) {
    // 返回任意节点的平衡性信息数据结构
    // 叶子节点，一定是平衡二叉树ALV,且高度为0
    if (x == null) {
        return new Info(true, 0);
    }
    // 获取左子树的平衡信息---套路步骤1
    Info leftInfo = process(x.left);
    // 获取右子树的平衡信息---套路步骤1
    Info rightInfo = process(x.right);
    // 当前节点的树的高度信息，就是取左右子树最大高度+1自己
    int height = Math.max(leftInfo.height, rightInfo.height) + 1;
    boolean isBalanced = true;
    // ---套路步骤2
    if (!leftInfo.isBalanced) {
        // 左子树不平衡，不是平衡树
        isBalanced = false;
    }
    // ---套路步骤2
    if (!rightInfo.isBalanced) {
        // 右子树不平衡，不是平衡树
        isBalanced = false;
    }
    // ---套路步骤2
    if (Math.abs(leftInfo.height - rightInfo.height) > 1) {
        // 左右子树的高度差大于1，也不是平衡树
        isBalanced = false;
    }
    return new Info(isBalanced, height);
}
```

### 套路实践-判断满二叉树

- 解法1：收集整棵树的高度h，和节点数n。满二叉树满足 : 2 ^ h - 1 == n

```
 // 解法1：收集整棵树的高度h，和节点数n。满二叉树满足 : 2 ^ h - 1 == n
 public static boolean isFull1(Node head) {
  if (head == null) {
   return true;
  }
  Info1 all = process1(head);
    // 满二叉树：节点数=(2^height) - 1
  return (1 << all.height) - 1 == all.nodes;
 }

 public static class Info1 {
    // 二叉树高度
  public int height;
    // 二叉树节点个数
  public int nodes;

  public Info1(int h, int n) {
   height = h;
   nodes = n;
  }
 }

 public static Info1 process1(Node head) {
  if (head == null) {
   return new Info1(0, 0);
  }
  Info1 leftInfo = process1(head.left);
  Info1 rightInfo = process1(head.right);
    // 高度，取左右子树中最高的那个+1自己
  int height = Math.max(leftInfo.height, rightInfo.height) + 1;
    // 节点个数，同理
  int nodes = leftInfo.nodes + rightInfo.nodes + 1;
  return new Info1(height, nodes);
 }
```

### 套路实践-判断完全二叉树

完全二叉树：上面的层是满的，即使不满，那么一定是从左到右逐渐变满。

- 解法1：利用宽度优先遍历，排除两种情况后，一定是满二叉树。
- 解法2：二叉树递归套路，完全二叉树有4种情况。

```
import java.util.LinkedList;
// 测试链接 : https://leetcode.com/problems/check-completeness-of-a-binary-tree/
public class Code01_IsCBT {
   // 不要提交这个类
   public static class TreeNode {
      public int val;
      public TreeNode left;
      public TreeNode right;
      public TreeNode(int v) {
         val = v;
      }
   }

  //解法1：利用宽度优先遍历，排除两种情况后，一定是满二叉树。
   public static boolean isCompleteTree1(TreeNode head) {
      /*
      * 情况a：无左孩子，有右孩子
      * 情况b：遇到过节点的左右孩子不全的节点，且节点不是叶子节点。
      * */
      /* 具体分析：
      * 对一个节点而言有四种可能：
         1. 当前节点有两个孩子
         2.当前节点有左孩子 没有右孩子
         3，当前节点 没有左孩子  有 右孩子
         4，当前节点 没有孩子
         我们层次遍历每一个节点，若碰到3的情况 一定不是完全二叉树 ，直接返回，
         当我们 第一次碰到：  2 或者 4 的情况的时候， 这意味着我们之后遍历的节点都必须是叶子，否则不是完全二叉树。
         若程序能执行到结束， 返回 true；
      * */
      if (head == null) {
         return true;
      }
      LinkedList<TreeNode> queue = new LinkedList<>();
      // 是否遇到过左右两个孩子不双全的节点
      boolean leaf = false;
      TreeNode l = null;
      TreeNode r = null;
      queue.add(head);
      // 基于队列的宽度优先遍历
      while (!queue.isEmpty()) {
         head = queue.poll();
         l = head.left;
         r = head.right;
         if (
         // 情况a||情况b
               (l == null && r != null)||(leaf && !(l == null || r == null))

         ) {
            return false;
         }
         if (l != null) {
            queue.add(l);
         }
         if (r != null) {
            queue.add(r);
         }
         // 遇到了叶子节点，左右都没孩子，不双全，标记true
         if (l == null || r == null) {
            leaf = true;
         }
      }
      return true;
   }

   public static boolean isCompleteTree2(TreeNode head) {
      return process(head).isCBT;
   }

   public static class Info {
      // 节点的子树为满二叉树
      public boolean isFull;
      // 节点的子树为完全二叉树
      public boolean isCBT;
      // 节点的子树高度
      public int height;
      public Info(boolean full, boolean cbt, int h) {
         isFull = full;
         isCBT = cbt;
         height = h;
      }
   }

   // 解法2：二叉树递归套路，完全二叉树有4种情况。
   public static Info process(TreeNode x) {
      /*假设树有3层，
          1         1       1          1
         2    3     2  3    2   3     2   3
       4  5  6 7   4       4  5     4  5 6
      * 情况1：最后一层都满了，一定要求：左树是满树&右树是满树&左树高度=右树高度
      * 情况2：最后一层只有1个节点，一定要求：左树是完全树&右树是满树&左树高度=右树高度+1
      * 情况3：最后一层只有2个节点，一定要求：左树是满树&右树是满树&左树高度=右树高度+1
      * 情况4：最后一层只有3个节点，一定要求：左树是满树&右树是完全树&左树高度=右树高度
      * */
      if (x == null) {
         return new Info(true, true, 0);
      }
      Info leftInfo = process(x.left);
      Info rightInfo = process(x.right);
      int height = Math.max(leftInfo.height, rightInfo.height) + 1;
      boolean isFull = leftInfo.isFull && rightInfo.isFull && leftInfo.height == rightInfo.height;
      boolean isCBT = false;
      if (leftInfo.isFull && rightInfo.isFull && leftInfo.height == rightInfo.height) {
         // 情况1
         isCBT = true;
      } else if (leftInfo.isCBT && rightInfo.isFull && leftInfo.height == rightInfo.height + 1) {
         // 情况2
         isCBT = true;
      } else if (leftInfo.isFull && rightInfo.isFull && leftInfo.height == rightInfo.height + 1) {
         // 情况3
         isCBT = true;
      } else if (leftInfo.isFull && rightInfo.isCBT && leftInfo.height == rightInfo.height) {
         // 情况4
         isCBT = true;
      }
      return new Info(isFull, isCBT, height);
   }

   // for test
   public static TreeNode generateRandomBST(int maxLevel, int maxValue) {
      return generate(1, maxLevel, maxValue);
   }

   // for test
   public static TreeNode generate(int level, int maxLevel, int maxValue) {
      if (level > maxLevel || Math.random() < 0.5) {
         return null;
      }
      TreeNode head = new TreeNode((int) (Math.random() * maxValue));
      head.left = generate(level + 1, maxLevel, maxValue);
      head.right = generate(level + 1, maxLevel, maxValue);
      return head;
   }

   public static void main(String[] args) {
      int maxLevel = 5;
      int maxValue = 100;
      int testTimes = 1000000;
      for (int i = 0; i < testTimes; i++) {
         TreeNode head = generateRandomBST(maxLevel, maxValue);
         if (isCompleteTree1(head) != isCompleteTree2(head)) {
            System.out.println("Oops!");
         }
      }
      System.out.println("finish!");
   }
}
```

### **套路实践-二叉树的最大距离**

题目：给定一棵二叉树的头结点head,任何两个节点之间都存在距离。返回整颗二叉树的最大距离

```
    public static class Info {
        // 先组织节点的最远距离的信息数据结构
        // 该节点作为树根节点的最大距离
        public int maxDistance;
        // 该节点作为树根节点的高度
        public int height;

        public Info(int m, int h) {
            maxDistance = m;
            height = h;
        }
    }

    public static Info process(Node x) {
        // 如果空节点，则00
        if (x == null) {
            return new Info(0, 0);
        }
        // 左子树信息---套路步骤1
        Info leftInfo = process(x.left);
        // 右子树信息---套路步骤1
        Info rightInfo = process(x.right);
        // 节点的树高度
        int height = Math.max(leftInfo.height, rightInfo.height) + 1;
        // 节点下的最大距离
        // 情况1：最大距离不经过x节点：左子树的最大距离 ---套路步骤2
        int p1 = leftInfo.maxDistance;
        // 情况2：最大距离不经过x节点：右子树的最大距离 ---套路步骤2
        int p2 = rightInfo.maxDistance;
        // 情况3：最大距离经过x节点：左子树+左子树的高度+1自己 ---套路步骤2
        int p3 = leftInfo.height + rightInfo.height + 1;
        // 节点的最大距离一定是情况123中的最大值，好好想想
        int maxDistance = Math.max(Math.max(p1, p2), p3);
        return new Info(maxDistance, height);
    }
```

### 套路实践-二叉搜索子树头结点

题目：给定一棵二叉树的头结点head,返回这颗二叉树中最大的二叉搜索子树的头结点。

思路：

> (1)最大二叉搜索树不经过X节点
>
> a)最大二叉搜索树要么是左子树
>
> b)最大二叉搜索树要么是右子树
>
> (2)最大二叉搜索树经过X节点
>
> c)左子树是BST且右子树是BST且左子树的最大值<x<右子树的最小值
>
> 最终结果取a,b,c中的一种

```
public static int maxSubBSTHead2(Node head) {
        if (head == null) {
            return -1;
        }
        // 解法1：初始化就是传入头结点，并返回最大二叉搜索树的头结点
        return process(head).maxSubBSTSize;
        // 解法2：提前处理好null节点
       //  return dfs(head).ans;
    }

    // 先定义每一棵子树,二叉搜索树的信息数据结构
    public static class Info {
        // 最大二叉搜索子树的头节点，如果存在则有值。不存在，则是null
        public Node maxSubBSTHead;
        // 最大二叉搜索子树的大小，就是最大二叉搜索子树的所有节点个数
        public int maxSubBSTSize;
        // 最大二叉搜索子树的最小值
        public int min;
        // 最大二叉搜索子树的最大值
        public int max;

        public Info(Node h, int size, int mi, int ma) {
            maxSubBSTHead = h;
            maxSubBSTSize = size;
            min = mi;
            max = ma;
        }
    }

    public static Info process(Node X) {
        // 判空的时候，不知道返回什么，就返回空，后续自己处理
        if (X == null) {
            return null;
        }
        // ---套路步骤1,假设拿到左树信息
        Info leftInfo = process(X.left);
        // ---套路步骤1,假设拿到右树信息
        Info rightInfo = process(X.right);
        /*
         *---套路步骤2
         * (1)最大二叉搜索树不经过X节点
         * a)最大二叉搜索树要么是左子树
         * b)最大二叉搜索树要么是右子树
         * (2)最大二叉搜索树经过X节点
         * c)左子树是BST且右子树是BST且左子树的最大值<x<右子树的最小值
         * 最终结果取a,b,c中的一种
         * */
        // 先假设最大最小为当前值
        int min = X.value;
        int max = X.value;
        // 先假设最大二叉搜索子树为空
        Node maxSubBSTHead = null;
        // 先假设最大二叉搜索子树的大小为0
        int maxSubBSTSize = 0;
        // 情况1：套路步骤2中的a
        if (leftInfo != null) {
            // 比较全局最小和当前子树最小值，取最小的值
            min = Math.min(min, leftInfo.min);
            max = Math.max(max, leftInfo.max);
            maxSubBSTHead = leftInfo.maxSubBSTHead;
            maxSubBSTSize = leftInfo.maxSubBSTSize;
        }
        // 情况2：套路步骤2中的b
        if (rightInfo != null) {
            min = Math.min(min, rightInfo.min);
            max = Math.max(max, rightInfo.max);
            // 这里要看一眼右节点比之前的值是不是更大，更大才更新
            if (rightInfo.maxSubBSTSize > maxSubBSTSize) {
                maxSubBSTHead = rightInfo.maxSubBSTHead;
                maxSubBSTSize = rightInfo.maxSubBSTSize;
            }
        }
        // 情况3：套路步骤2中的c
        /*
         * 如果leftInfo == null，表示左子树为空，没有节点。那么也属于BST，直接给true
         * 如果leftInfo != null，leftInfo.maxSubBSTHead == X.left表示X的左子节点是X左子树的最大搜索二叉树的节点即左子树是BST，
         * leftInfo.max < X.value表示左子树的最大值<x，这种才满足c的一部分条件。右子树也是同样判断
         * */
        if ((leftInfo == null ? true : (leftInfo.maxSubBSTHead == X.left && leftInfo.max < X.value))
                && (rightInfo == null ? true : (rightInfo.maxSubBSTHead == X.right && rightInfo.min > X.value))) {
            // 满足以上条件的，X节点才是X为头结点的最大二叉搜索树的头节点
            maxSubBSTHead = X;
            // 二叉搜索树的大小就是左+有+1自己节点
            maxSubBSTSize = (leftInfo == null ? 0 : leftInfo.maxSubBSTSize)
                    + (rightInfo == null ? 0 : rightInfo.maxSubBSTSize) + 1;
        }
        // ---套路步骤5,终极目的就是递归这四个值
        return new Info(maxSubBSTHead, maxSubBSTSize, min, max);
    }

    public static class SuperNode {
        int ans;
        int small, large;
        boolean isBST;

        public SuperNode() {
            ans = 0;
            isBST = true;
            small = Integer.MAX_VALUE;
            large = -Integer.MAX_VALUE;
        }
    }

    public static SuperNode dfs(Node node) {
        // 解法2：提前处理好null节点
        if (node == null) {
            return new SuperNode();
        }
        SuperNode now = new SuperNode();
        SuperNode left = dfs(node.left);
        SuperNode right = dfs(node.right);
        now.small = Math.max(left.small, node.value);
        now.large = Math.max(right.large, node.value);
        if (left.isBST && right.isBST && left.large <= node.value && right.small >= node.value) {
         // 最大二叉搜索树经过X节点
            now.ans = left.ans + right.ans + 1;
            now.isBST = true;
        } else {
         // 如果最大二叉搜索树不经过X节点，则最大值一定在左右中最大的一个
            now.ans = Math.max(left.ans, right.ans);
            // 标记为非BST
            now.isBST = false;
        }
        return now;
    }
```

### 套路实践-员工快乐值

题目：定义员工Employee信息，每个员工可能有多个直接下级，但只有一个上级。基层员工没有下级。现在公司办party,要决定哪些人来或不来。规则如下：

1.如果某个员工来了，那么这个员工的所有**直接下级**都不能来
2.派对的整体快乐值是所有到场员工快乐值的累加
3.你的目标是让派对的整体快乐值尽量大
给定一棵多叉树的头节点boss，请返回派对的最大快乐值。

思路：员工X,假设有a,b,c三个下属

(1)X来时,yes快乐值=a不来的快乐值+b不来的快乐值+c不来的快乐值

(2)X不来时，no快乐值=max(a来的快乐值,a不来的快乐值)+max(b来的快乐值,b不来的快乐值)+max(c来的快乐值,c不来的快乐值)

```
public class Code04_MaxHappy {
    public static class Employee {
        // 员工可以带来的快乐值
        public int happy;
        // 该员工的直接下属员工
        public List<Employee> nexts;

        public Employee(int h) {
            happy = h;
            nexts = new ArrayList<>();
        }
    }
    public static int maxHappy2(Employee head) {
        Info allInfo = process(head);
        return Math.max(allInfo.no, allInfo.yes);
    }
    // 先定义员工节点的快乐值，因为是树结构，要考虑其下属来不来
    public static class Info {
        // 员工不来的情况下，他的快乐值
        public int no;
        // 员工来的情况下，他的快乐值
        public int yes;

        public Info(int n, int y) {
            no = n;
            yes = y;
        }
    }
    public static Info process(Employee x) {
        /*
         * 思路：X,假设有a,b,c三个下属
         * (1)X来时,yes快乐值=a不来的快乐值+b不来的快乐值+c不来的快乐值
         * (2)X不来时，no快乐值=max(a来的快乐值,a不来的快乐值)+max(b来的快乐值,b不来的快乐值)+max(c来的快乐值,c不来的快乐值)
         * */
        // base case 没有员工了
        if (x == null) {
            return new Info(0, 0);
        }
        // 员工不来的初始快乐值为0
        int no = 0;
        // 员工来的初始快乐值为自己的happy
        int yes = x.happy;
        // 遍历所有下属
        for (Employee next : x.nexts) {
            // 假设能获取下属的信息
            Info nextInfo = process(next);
            // X不来时，快乐值就是如下
            no += Math.max(nextInfo.no, nextInfo.yes);
            // X来时，快乐值就是如下
            yes += nextInfo.no;
        }
        return new Info(no, yes);
    }
}
```

### 套路实践-最低公共祖先节点

题目：给定两个二叉树的节点node1和node2，找到他们的最低公共祖先节点。

- 解法1：利用一个map构件节点向上找父节点的效果，利用set查找两者第一个相同的向上找到的父节点
- 解法2：二叉树递归套路。构建基本信息，递归分情况讨论

```
 public static class Node {
  public int value;
  public Node left;
  public Node right;
  public Node(int data) {
   this.value = data;
  }
 }

 // 解法1：利用一个map构件节点向上找父节点的效果，利用set查找两者第一个相同的向上找到的父节点
 public static Node lowestAncestor1(Node head, Node o1, Node o2) {
  if (head == null) {
   return null;
  }
  // key的父节点是value
  HashMap<Node, Node> parentMap = new HashMap<>();
  parentMap.put(head, null);
  // 构建所有节点的父节点表
  fillParentMap(head, parentMap);
  HashSet<Node> o1Set = new HashSet<>();
  Node cur = o1;
  o1Set.add(cur);
  // 递归取出o1节点的所有父节点，加入o1Set
  while (parentMap.get(cur) != null) {
   cur = parentMap.get(cur);
   o1Set.add(cur);
  }
  cur = o2;
  // 递归取出o2节点的所有父节点，判断是否存在o1Set中，存在了就是最近的公共祖先。
  while (!o1Set.contains(cur)) {
   cur = parentMap.get(cur);
  }
  return cur;
 }

 // 递归调用，填写map,含义key:当前节点,value：当前节点的父节点
 public static void fillParentMap(Node head, HashMap<Node, Node> parentMap) {
  if (head.left != null) {
   // 存在左节点，加入map
   parentMap.put(head.left, head);
   // 继续递归左节点
   fillParentMap(head.left, parentMap);
  }
  if (head.right != null) {
   parentMap.put(head.right, head);
   fillParentMap(head.right, parentMap);
  }
 }

 // 解法2：二叉树递归套路。构建基本信息，递归分情况讨论
 public static Node lowestAncestor2(Node head, Node a, Node b) {
  return process(head, a, b).ans;
 }
 // 任何节点作为头结点的子树信息
 public static class Info {
  // 子树上是否存在a节点
  public boolean findA;
  // 子树上是否存在b节点
  public boolean findB;
  // 子树上的a,b的最初交汇点即最近的公共祖先，可能存在，也可能不存在为null
  public Node ans;
  public Info(boolean fA, boolean fB, Node an) {
   findA = fA;
   findB = fB;
   ans = an;
  }
 }
 public static Info process(Node x, Node a, Node b) {
  // base case
  if (x == null) {
   return new Info(false, false, null);
  }
  // 二叉树递归套路，先要来左右子树的信息
  Info leftInfo = process(x.left, a, b);
  Info rightInfo = process(x.right, a, b);
  // 判断子树上是否存在a节点.要么当前节点就是a,要么a在左子树上，要么a在右子树上
  boolean findA = (x == a) || leftInfo.findA || rightInfo.findA;
  boolean findB = (x == b) || leftInfo.findB || rightInfo.findB;
  // 接下来就是对于当前子树，它对于a,b的交汇点在哪
  Node ans = null;
  /*
  * 最低公共祖先一定在以下三种情况：
  * 情况1：如果左子树的交汇点不为空，那么交汇点就是它
  * 情况2：如果右子树的交汇点不为空，那么交汇点就是它
  * 情况3：如果都不在，但是又有最低祖先，那么一定在当前节点上
  * */
  if (leftInfo.ans != null) {
   // 情况1
   ans = leftInfo.ans;
  } else if (rightInfo.ans != null) {
   // 情况2
   ans = rightInfo.ans;
  } else {
   // 情况3
   if (findA && findB) {
    ans = x;
   }
  }
  // 不满足情况123的就表示没有最低公共祖先
  return new Info(findA, findB, ans);
 }
```

# BFPRT算法

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

# Morris算法遍历

## Morris序

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

## Morris遍历和传统二叉树遍历

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

## 判断是否为二叉搜索树BST

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

## 求二叉树的最小高度

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

# 图

## 定义

1. 由点的集合和边的集合组成
2. 虽然存在有向图和无向图，但都可以用有向图来表示
3. 边上可能带有权值

## 图的结构表达

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

## 图的面试题如何搞定

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

## 图的宽度(广度)优先遍历BFS

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

## 图的深度优先遍历DFS

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

## 图的拓扑排序算法

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

## 最小生成树之Kruskal即K算法

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

## 最小生成树之Prim即P算法

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

## 最短路径算法之Dijkstra算法

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

## TSP问题

也叫商旅问题，非常之难。问题：给定一系列城市和每对城市之间的距离，求解访问每一座城市一次并回到起始城市的最短回路。

## 单词接龙 

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

# 动态规划

## 核心

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

## 暴力递归

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

## 尝试模型

### 从左往右的尝试模型1-字符串转化

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

### 从左往右的尝试模型2-背包问题

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

### 范围上的尝试模型-纸牌游戏

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

### **业务限制类的尝试模型**-N皇后

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

## 单链表按照划分值分组

题目：将单链表按照某划分值分成左边小、中间相等、右边大的形式。

- 解法1：(笔试用)将链表节点全部入数组，在数组上玩荷兰国旗的Partition，然后按照顺序串成链表
- 解法2：(面试用)利用6个变量指针，分成3个区域的链表，小于pivot区域，等于pivot区域，大于pivot区域，然后前后串起来即可。

```
public class Code03_SmallerEqualBigger {
   public static class Node {
      public int value;
      public Node next;
      public Node(int data) {
         this.value = data;
      }
   }

   // 解法1：(笔试用)将链表节点全部入数组，在数组上玩荷兰国旗的Partition，然后按照顺序串成链表
   public static Node listPartition1(Node head, int pivot) {
      if (head == null) {
         return head;
      }
      Node cur = head;
      int i = 0;
      while (cur != null) {
         i++;
         cur = cur.next;
      }
      Node[] nodeArr = new Node[i];
      i = 0;
      cur = head;
      for (i = 0; i != nodeArr.length; i++) {
         nodeArr[i] = cur;
         cur = cur.next;
      }
      arrPartition(nodeArr, pivot);
      for (i = 1; i != nodeArr.length; i++) {
         nodeArr[i - 1].next = nodeArr[i];
      }
      nodeArr[i - 1].next = null;
      return nodeArr[0];
   }

   public static void arrPartition(Node[] nodeArr, int pivot) {
      int small = -1;
      int big = nodeArr.length;
      int index = 0;
      while (index != big) {
         if (nodeArr[index].value < pivot) {
            swap(nodeArr, ++small, index++);
         } else if (nodeArr[index].value == pivot) {
            index++;
         } else {
            swap(nodeArr, --big, index);
         }
      }
   }

   public static void swap(Node[] nodeArr, int a, int b) {
      Node tmp = nodeArr[a];
      nodeArr[a] = nodeArr[b];
      nodeArr[b] = tmp;
   }

   // 解法2：(面试用)利用6个变量指针，分成3个区域的链表，小于pivot区域，等于pivot区域，大于pivot区域，然后前后串起来即可。
   public static Node listPartition2(Node head, int pivot) {
      Node sH = null; // small head小于划分值pivot区域的头结点
      Node sT = null; // small tail小于划分值pivot区域的尾结点
      Node eH = null; // equal head
      Node eT = null; // equal tail
      Node mH = null; // big head
      Node mT = null; // big tail
      Node next = null; // save next node
      // every node distributed to three lists
      while (head != null) {
         // 先记录下当前节点的下一个节点，方便下一次while遍历
         next = head.next;
         // 开始断开当前节点的next指针
         head.next = null;
         if (head.value < pivot) {
            // 小于pivot区域
            if (sH == null) {
               // 一个节点都没有，直接加进来，调整头尾指针
               sH = head;
               sT = head;
            } else {
               // 老尾巴的下一个节点指向当前节点
               sT.next = head;
               // 尾指针移动到当前插入的节点
               sT = head;
            }
         } else if (head.value == pivot) {
            // 等于pivot区域，逻辑同上
            if (eH == null) {
               eH = head;
               eT = head;
            } else {
               eT.next = head;
               eT = head;
            }
         } else {
            // 大于pivot区域，逻辑同上
            if (mH == null) {
               mH = head;
               mT = head;
            } else {
               mT.next = head;
               mT = head;
            }
         }
         //下一次while遍历赋值
         head = next;
      }
      // 接下来就是链表前后串起来：小于区域的尾巴，连等于区域的头，等于区域的尾巴连大于区域的头。注意因为划分值不同，可能小于区域，等于区域，大于区域不存在。
      if (sT != null) { // 如果小于区域存在
         // 第一步：小于区域的尾节点连接到等于区域的头节点
         sT.next = eH;
         // 找下等于区域的尾指针在哪里，
         eT = eT == null ? sT : eT; // 下一步，谁去连大于区域的头，谁就变成eT
      }
      // 第二步：一定是需要用eT 去接 大于区域的头
      // 有等于区域，eT -> 等于区域的尾结点
      // 无等于区域，eT -> 小于区域的尾结点
      // eT 尽量不为空的尾巴节点
      if (eT != null) { // 如果小于区域和等于区域，不是都没有
         // 第三步：等于区域的尾指针连接大于区域的头指针。至此链表全部串起来了
         eT.next = mH;
      }
      // 最后返回头结点，注意各个头结点是否存在
      return sH != null ? sH : (eH != null ? eH : mH);
   }

   public static void printLinkedList(Node node) {
      System.out.print("Linked List: ");
      while (node != null) {
         System.out.print(node.value + " ");
         node = node.next;
      }
      System.out.println();
   }

   public static void main(String[] args) {
      Node head1 = new Node(7);
      head1.next = new Node(9);
      head1.next.next = new Node(1);
      head1.next.next.next = new Node(8);
      head1.next.next.next.next = new Node(5);
      head1.next.next.next.next.next = new Node(2);
      head1.next.next.next.next.next.next = new Node(5);
      printLinkedList(head1);
      // head1 = listPartition1(head1, 4);
      head1 = listPartition2(head1, 5);
      printLinkedList(head1);
   }
}
```



## 暴力递归到动态规划

**该方法可以解决所有的动态规划问题**

**什么叫动态规划？**

把暴力递归中的重复计算想办法用缓存替代，就是动态规划。只不过这种叫记忆化搜索的动态规划。

### 斐波那契数列

题目：在数学当中，由斐波那契数字（Fibonacci number，记作 Fn ）构成的序列，被称为斐波那契数列（Fibonacci sequence）。该数列中的每一个数字等于排在它前面的两个数字之和。

- 数列从0和1开始： F0=0 , F1=1
- 数列第n个（n>1）数字为：Fn=Fn−1+Fn−2

按照上述公式，计算得到斐波那契数列为：0,1,1,2,3,5,8,13,21,34,55,89,...

- 解法1：最暴力的方法，之所以暴力，是因为有大量重复的计算

```
public static int f(int N) {
        // 解法1：斐波那契数列的最暴力解法
        if (N < 2) {
         return N;
     }
        return f(N - 2) + f(N - 1);
    }
```

### 阿里面试题爬楼

题目：假设有排成一行的N个位置，几位1~N,N一定大于或等于2。

开始时机器人在其中的N位置上(M一定是1~N中的一个)；

如果机器人来到1位置，那么下一步只能往右走来到2位置；

如果机器人来到N位置，那么下一步只能往左走来到N-1位置;

如果机器人来到中间位置，那么下一步可以往左走也可以往右走；

规定机器人必须走K步，最终能来到P位置。

给定四个参数N,M,K,P,返回机器人能走的多少种方法数。

- 解法1：暴力递归，中间有重复计算的冗余过程。leetcode提交代码一定超时，不通过

- 解法2：带缓存的暴力递归，本质：在暴力递归的基础上，利用缓存数组，去掉中间有重复计算的冗余过程。leetcode可以通过

- 解法3：动态规划，将解法2的暴力递归过程优化为结构化描述的动态规划。因为此题有重复计算过程和有限个参数的相关计算(M,k两个变量)。leetcode可以通过

从解法1到解法2，总结：不是所有的暴力递归都可以改为动态规划，**所有的动态规划都来自于暴力递归的改写**。

**任何一个暴力递归优化成结构化描述的动态规划，需要满足两个条件：**

- 暴力递归中有重复计算的过程
- 有限的可变参数影响结果

不满足以上2个条件的暴力递归，要么无法改为动态规划(不是有限可变参数)，要么即使改成动态规划也意义不大(没有重复过程，缓存没有意义)。

```
public class Code01_RobotWalk {
    public static int ways1(int N, int M, int K, int P) {
        // 解法1：暴力递归，中间有重复计算的冗余过程
        // 参数无效直接返回 0
        if (N < 2 || K < 1 || M < 1 || M > N || P < 1 || P > N) {
            return 0;
        }
        // 总共N个位置，从M点出发，还剩K步，返回最终能达到P的方法数
        return walk1(N, M, K, P);
    }

    // 机器人当前来到的位置是cur，
    // 机器人还有rest步需要去走，
    // 最终的目标是P，
    // 返回：机器人从cur出发，走过rest步之后，最终停在P的方法数，是多少？
    public static int walk1(int N, int cur, int rest, int P) {
        // 如果没有剩余步数了，看下当前cur位置在哪里
        if (rest == 0) {
            // cur当前位置在最终位置P,则之前的移动有效，记录为一种情况。否则，无效记为0.
            return cur == P ? 1 : 0;
        }
        // 如果cur当前位置在1位置上，那么接下来只能往右边的2移动
        if (cur == 1) { // 1 -> 2
            return walk1(N, cur + 1, rest - 1, P);
        }
        // 如果cur当前位置在N位置上，那么接下来只能往左边的N-1移动
        if (cur == N) { // N-1 <- N
            return walk1(N, cur - 1, rest - 1, P);
        }
        // 如果cur当前位置在中间，那么有可能性往左移动、有可能往右移动，累加起来
        return walk1(N, cur - 1, rest - 1, P) + walk1(N, cur + 1, rest - 1, P);
    }

    public static int ways2(int N, int M, int K, int P) {
        // 解法2：带缓存的暴力递归，本质：在暴力递归的基础上，利用缓存数组，去掉中间有重复计算的冗余过程
        // 参数无效直接返回 0
        if (N < 2 || K < 1 || M < 1 || M > N || P < 1 || P > N) {
            return 0;
        }
        // dp就是缓存表，M有可能从1-N，K的话最多K，所以用长度N+1,K+1
        // dp[cur][rest] == -1 -> process1(cur, rest)之前没算过！
        // dp[cur][rest] != -1 -> process1(cur, rest)之前算过！返回值，dp[cur][rest]
        // N+1 * K+1
        int[][] dp = new int[N + 1][K + 1];
        for (int i = 0; i <= N; i++) {
            for (int j = 0; j <= K; j++) {
                dp[i][j] = -1;
            }
        }
        // 总共N个位置，从M点出发，还剩K步，返回最终能达到P的方法数
        return walk2(N, M, K, P, dp);
    }

    public static int walk2(int N, int cur, int rest, int P, int[][] dp) {
        // 先去找缓存表，因为N和P是固定值，返回值只与cur、rest有关
        if (dp[cur][rest] != -1) {
            // 先去缓存表找一下，如果找到有缓存，直接把结果返回
            return dp[cur][rest];
        }
        // 如果没有缓存，说明之前没算过！那就先缓存，再把缓存结果返回
        int ans = 0;
        if (rest == 0) {
            ans = cur == P ? 1 : 0;
        } else if (cur == 1) {
            ans = walk2(N, cur + 1, rest - 1, P, dp);
        } else if (cur == N) {
            ans = walk2(N, cur - 1, rest - 1, P, dp);
        } else {
            ans = walk2(N, cur - 1, rest - 1, P, dp) + walk2(N, cur + 1, rest - 1, P, dp);
        }
        // 先缓存
        dp[cur][rest] = ans;
        // 再返回结果
        return ans;

    }

    public static int ways3(int N, int M, int K, int P) {
        // 解法3：动态规划，将解法2的暴力递归过程优化为动态计算的动态规划。因为此题是关于有限个参数的相关计算(M,k两个变量)
        // 参数无效直接返回 0
        if (N < 2 || K < 1 || M < 1 || M > N || P < 1 || P > N) {
            return 0;
        }
        /*
        二维表，行表示cur,列表示rest。假设N=5,P=3.x表示不存在的情况，不要统计计算。
          0 1 2 3 4 5  ——rest
        0 x x x x x x
        1 0 0 取左下斜线值
        2 0 取左上斜线值和左下斜线值
        3 1
        4 0 取左上斜线值
        |
        cur
        */
        int[][] dp = new int[N + 1][K + 1];
        // 第一步：根据确定的最终结果，计算初始位置值,dp[其他值][0]=0.所以初始值是第一列，那么后面一定是从第1列推出第2列，2列推出3列...以此类推
        dp[P][0] = 1;
        // 因为cur=P且rest=0.已经初始化了，接下啦只需要计算rest从1到K,cur从1到N
        // 第二步：开始规划计算
        for (int rest = 1; rest <= K; rest++) {
            // 当cur在1的位置,取左下斜线值
            dp[1][rest] = dp[2][rest - 1];
            // 当cur在2到N-1的位置,取左上斜线值和左下斜线值
            for (int cur = 2; cur < N; cur++) {
                dp[cur][rest] = dp[cur - 1][rest - 1] + dp[cur + 1][rest - 1];
            }
            // 当cur在N位置，取左上斜线值
            dp[N][rest] = dp[N - 1][rest - 1];
        }
        return dp[M][K];
    }

    public static void main(String[] args) {
        System.out.println(ways1(7, 4, 9, 5));
        System.out.println(ways2(7, 4, 9, 5));
        System.out.println(ways3(7, 4, 9, 5));
    }
}
```

### 货币面值问题

题目：不同金额的货币，可以使用多张，凑成目标值的方法数。现在有arr[1元，5元，10元].确定每种面额的纸币有多少张，最终来判断，不同张数的组合最终是否等于x元。比如x=10,那么有10张1元，2张5元，1张10元...

- 解法1：暴力递归的尝试过程
- 解法2：暴力递归的尝试过程改为记忆化搜索
- 解法3：动态规划，根据暴力递归填写dp表。
- 解法4：动态规划的优化版，将解法3中枚举的遍历人为直观的转变下。

```
public class Code03_CoinsWayNoLimit {

    public static int way(int[] arr, int aim) {
        // 解法1：暴力递归的尝试过程
        if (arr == null || arr.length == 0 || aim < 0) {
            return 0;
        }
        return process(arr, 0, aim);
    }

    // arr[index....] 所有的面值，每一个面值都可以任意选择张数，组成正好rest这么多钱，方法数多少？
    public static int process(int[] arr, int index, int rest) {
        /* 剩余的钱数都为负数了，说明这方法不行，记为0。这段可以去掉，因为在调用zhang * arr[index] <= rest保证了不小于0
        if (rest < 0) {
            return 0;
        }
        */
        // 后续没有钱可以选了，那么看下剩余的可用钱是否都刚好用完。如果刚好用完，记为一种用法。否则无效记为0
        if (index == arr.length) { // 没钱了
            return rest == 0 ? 1 : 0;
        }
        int ways = 0;
        // 先不要抽象画过程，先具象化过程
        /*
         * arr[10,...] 要完成1000元任务
         * 情况1 不用10元，f(1,1000)
         * 情况2 用1个10元，f1(1,1000-10)
         * 情况3 用2个10元，f1(1,1000-20)
         * 直到1000-x>=0
         * 那么可以设置变量可用的钱的张数为张，rest-(张数Xarr[index]面值)>=0。循环遍历即可，把每种情况累加起来。
         * */
        for (int zhang = 0; zhang * arr[index] <= rest; zhang++) {
            ways += process(arr, index + 1, rest - (zhang * arr[index]));
        }
        // 最后返回累加的结果值
        return ways;
    }

    public static int way1(int[] arr, int aim) {
        // 解法2：暴力递归的尝试过程改为记忆化搜索
        if (arr == null || arr.length == 0 || aim < 0) {
            return 0;
        }
        // arr[10,100,...],用了10张10元和用了1张100元，剩余情况是相同，有重复过程。所以dp是二维表，记录剩下的。
        // dp记录了所有情况
        int[][] dp = new int[arr.length + 1][aim + 1];
        return process1(arr, 0, aim, dp);
    }

    // arr[index....] 所有的面值，每一个面值都可以任意选择张数，组成正好rest这么多钱，方法数多少？
    public static int process1(int[] arr, int index, int rest, int[][] dp) {
        // 判断是否有缓存，默认是0.不为0，说明写入了，就返回
        if (dp[index][rest] != 0) {
            // return地方改为dp
            return dp[index][rest];
        }
        // 后续没有钱可以选了，那么看下剩余的可用钱是否都刚好用完。如果刚好用完，记为一种用法。否则无效记为0
        if (index == arr.length) { // 没钱了
            // return地方改为dp，先写入缓存，再返回
            dp[index][rest] = rest == 0 ? 1 : 0;
            return dp[index][rest];
        }
        int ways = 0;
        // 先不要抽象画过程，先具象化过程
        /*
         * arr[10,...] 要完成1000元任务
         * 情况1 不用10元，f(1,1000)
         * 情况2 用1个10元，f1(1,1000-10)
         * 情况3 用2个10元，f1(1,1000-20)
         * 直到1000-x>=0
         * 那么可以设置变量可用的钱的张数为张，rest-(张数Xarr[index]面值)>=0。循环遍历即可，把每种情况累加起来。
         * */
        for (int zhang = 0; zhang * arr[index] <= rest; zhang++) {
            ways += process1(arr, index + 1, rest - (zhang * arr[index]), dp);
        }
        // 最后返回累加的结果值
        // return地方改为dp，先写入缓存，再返回
        dp[index][rest] = ways;
        return dp[index][rest];
    }

    public static int dp1(int[] arr, int aim) {
        // 解法3：动态规划，根据暴力递归填写dp表。
        if (arr == null || arr.length == 0 || aim < 0) {
            return 0;
        }
        int N = arr.length;
        int[][] dp = new int[N + 1][aim + 1];
        // 第一步：根据确定的最终结果，计算初始位置值.最后知道的结果一定是index来到N,同时剩余空间为0.这是一种情况，记录为1.
        dp[N][0] = 1;
        for (int index = N - 1; index >= 0; index--) {
            for (int rest = 0; rest <= aim; rest++) {
                // 二维表dp填写
                // 按照原来的逻辑逐行替代为dp
                int ways = 0;
                for (int zhang = 0; zhang * arr[index] <= rest; zhang++) {
                    ways += dp[index + 1][rest - (zhang * arr[index])];
                }
                // return的地方改为dp赋值
                dp[index][rest] = ways;
            }
        }
        // 最终结果是[arr从0开始,aim]的dp返回值
        return dp[0][aim];
    }

    public static int dp2(int[] arr, int aim) {
        // 解法4：动态规划的优化版，将解法3中枚举的遍历人为直观的转变下。
        /*
         * 要想做出解法4，必须经过解法1，2,3。某些奸人也是经过解法123，但不说，直接告诉解法4.然后强行
         * 拿某种关系解释。看起来很牛，太奸了。
         * */
        if (arr == null || arr.length == 0 || aim < 0) {
            return 0;
        }
        int N = arr.length;
        int[][] dp = new int[N + 1][aim + 1];
        // 第一步：根据确定的最终结果，计算初始位置值.最后知道的结果一定是index来到N,同时剩余空间为0.这是一种情况，记录为1.
        dp[N][0] = 1;
        // 第二步：从最后一行往前推，因为最后一行已知。每行从左往右推。
        for (int index = N - 1; index >= 0; index--) {
            for (int rest = 0; rest <= aim; rest++) {
                // 这个关系是画图看出来的
                dp[index][rest] = dp[index + 1][rest];
                // 这个关系是画图和递归逻辑看出来的
                if (rest - arr[index] >= 0) {
                    dp[index][rest] += dp[index][rest - arr[index]];
                }
            }
        }
        // 最终结果是[arr从0开始,aim]的dp返回值
        return dp[0][aim];
    }

    // 为了测试
    public static int[] randomArray(int maxLen, int maxValue) {
        int N = (int) (Math.random() * maxLen);
        int[] arr = new int[N];
        boolean[] has = new boolean[maxValue + 1];
        for (int i = 0; i < N; i++) {
            do {
                arr[i] = (int) (Math.random() * maxValue) + 1;
            } while (has[arr[i]]);
            has[arr[i]] = true;
        }
        return arr;
    }

    // 为了测试
    public static void printArray(int[] arr) {
        for (int i = 0; i < arr.length; i++) {
            System.out.print(arr[i] + " ");
        }
        System.out.println();
    }

    // 为了测试
    public static void main(String[] args) {
        int maxLen = 10;
        int maxValue = 30;
        int testTime = 1000000;
        System.out.println("测试开始");
        for (int i = 0; i < testTime; i++) {
            int[] arr = randomArray(maxLen, maxValue);
            int aim = (int) (Math.random() * maxValue);
            int ans1 = way(arr, aim);
            int ans4 = way1(arr, aim);
            int ans2 = dp1(arr, aim);
            int ans3 = dp2(arr, aim);
            if (ans1 != ans2 || ans1 != ans3 || ans1 != ans4) {
                System.out.println("Oops!");
                printArray(arr);
                System.out.println(aim);
                System.out.println(ans1);
                System.out.println(ans2);
                System.out.println(ans3);
                System.out.println(ans4);
                break;
            }
        }
        System.out.println("测试结束");
//        int[] arr = randomArray(maxLen, maxValue);
//        int aim = (int) (Math.random() * maxValue);
//        printArray(arr);
//        System.out.println(aim);
//        System.out.println(way(arr, aim));
//        System.out.println(way1(arr, aim));
//        System.out.println(dp1(arr, aim));
//        System.out.println(dp2(arr, aim));
    }
}
```

# 贪心算法

- 最自然智慧的算法
- 用一种局部最功利的标准，总是做出当前看来最好的选择
- 难点在于证明局部最功利的标准可以得到全局最优解
- 对于贪心算法的学习主要以增加阅历和经验为主

**字典序**

定义：表示英文单词在字典中的先后顺序，类似中文的拼音目录。ab abc abd.

排序规则：字母单词在字典中的顺序，位数一样的依次比较，如果位数不一样，将短的补长为和长的一样长，多的位用0补。逐一从左到右依次比较，小的放前，大的放后。

## 贪心-最小字典序

题目：给定一个由字符串组成的数组arrs,必须把所有的字符串拼接起来，返回所有可能的拼接结果中，字典序最小的结果。

- 解法1：列出所有的字符串的全排列，找到全局最小。注意求解全排列，有多层循环递归和深度优先遍历两种方法。
- 解法2：将字符串数组按照字典序排序，直接拼接

```
import java.util.Arrays;
import java.util.Comparator;
import java.util.HashSet;
import java.util.TreeSet;

public class Code05_LowestLexicography {
    // 解法1：列出所有的字符串的全排列，找到全局最小
    public static String lowestString1(String[] strs) {
        if (strs == null || strs.length == 0) {
            return "";
        }
        TreeSet<String> all = new TreeSet<>();
        // 解法a:多层循环递归，返回全排列
        all = process(strs);
        // 解法b:深度优先遍历，返回全排列
//        HashSet<Integer> use = new HashSet<>();
//        String path = "";
//        process2(strs, use, path, all);
        String lowest = null;
        // 遍历找到全局最小
        for (String str : all) {
            if (lowest == null) {
                lowest = str;
            } else {
                lowest = str.compareTo(lowest) < 0 ? str : lowest;
            }
        }
        return lowest;
    }

    // 解法a：多层循环递归，返回全排列。strs中所有字符串全排列，返回所有可能的结果
    public static TreeSet<String> process(String[] strs) {
        TreeSet<String> ans = new TreeSet<>();
        if (strs.length == 0) {
            // 数组为空，直接返回
            ans.add("");
            return ans;
        }
        // 从前往后遍历，使用当前元素+(剩余元素的组合list)一一匹配
        for (int i = 0; i < strs.length; i++) {
            String first = strs[i];
            // 排除当前元素，剩余还有哪些元素
            String[] nexts = removeIndexString(strs, i);
            // 返回剩余元素的所有排列组合
            TreeSet<String> next = process(nexts);
            // 当前元素+剩余元素，遍历组合，一一匹配
            for (String cur : next) {
                ans.add(first + cur);
            }
        }
        return ans;
    }

    // 解法b：深度优先遍历，strs中所有字符串全排列，返回所有可能的结果
    public static void process2(String[] strs, HashSet<Integer> use, String path, TreeSet<String> all) {
        // str放着所有字符串，use表示使用过的字符串索引，path表示当前的字符串拼接路径，all就是所有字符串的排列组合
        if (use.size() == strs.length) {
            // 全部都用了，就加入一条路径
            all.add(path);
        } else {
            for (int i = 0; i < strs.length; i++) {
                // 遍历所有元素，找到没加入过的元素，更新use,更新path,递归剩下元素
                if (!use.contains(strs[i])) {
                    // 更新use
                    use.add(i);
                    // 更新path,递归剩下元素
                    process2(strs, use, path + strs[i], all);
                    // 注意，深度优先遍历，一定要回溯，就要删除刚加的元素，恢复现场
                    use.remove(i);
                }
            }
        }
    }

    // {"abc", "cks", "bct"}
    // 0 1 2
    // removeIndexString(arr , 1) -> {"abc", "bct"}
    // 返回arr删除index索引的元素剩下的元素
    public static String[] removeIndexString(String[] arr, int index) {
        int N = arr.length;
        String[] ans = new String[N - 1];
        int ansIndex = 0;
        for (int i = 0; i < N; i++) {
            if (i != index) {
                ans[ansIndex++] = arr[i];
            }
        }
        return ans;
    }

    public static class MyComparator implements Comparator<String> {
        @Override
        public int compare(String a, String b) {
            return (a + b).compareTo(b + a);
        }
    }
    // 解法2：将字符串数组按照字典序排序，直接拼接
    public static String lowestString2(String[] strs) {
        if (strs == null || strs.length == 0) {
            return "";
        }
        Arrays.sort(strs, new MyComparator());
        String res = "";
        for (int i = 0; i < strs.length; i++) {
            res += strs[i];
        }
        return res;
    }

    // for test
    public static String generateRandomString(int strLen) {
        char[] ans = new char[(int) (Math.random() * strLen) + 1];
        for (int i = 0; i < ans.length; i++) {
            int value = (int) (Math.random() * 5);
            ans[i] = (Math.random() <= 0.5) ? (char) (65 + value) : (char) (97 + value);
        }
        return String.valueOf(ans);
    }

    // for test
    public static String[] generateRandomStringArray(int arrLen, int strLen) {
        String[] ans = new String[(int) (Math.random() * arrLen) + 1];
        for (int i = 0; i < ans.length; i++) {
            ans[i] = generateRandomString(strLen);
        }
        return ans;
    }

    // for test
    public static String[] copyStringArray(String[] arr) {
        String[] ans = new String[arr.length];
        for (int i = 0; i < ans.length; i++) {
            ans[i] = String.valueOf(arr[i]);
        }
        return ans;
    }

    public static void main(String[] args) {
        int arrLen = 6;
        int strLen = 5;
        int testTimes = 10000;
        System.out.println("test begin");
        for (int i = 0; i < testTimes; i++) {
            String[] arr1 = generateRandomStringArray(arrLen, strLen);
            String[] arr2 = copyStringArray(arr1);
            if (!lowestString1(arr1).equals(lowestString2(arr2))) {
                for (String str : arr1) {
                    System.out.print(str + ",");
                }
                System.out.println();
                System.out.println("Oops!");
            }
        }
        System.out.println("finish!");
    }
}
```

# 线段树

定义：是一棵二叉树。它的特点是：每个结点表示的是一个线段，或者说是一个区间。

```java
public class Code01_SegmentTree {
    // 线段树的实现
    public static class SegmentTree {
        // arr[]为原序列的信息从0开始，但在arr里是从1开始的，注意从下标1开始是为了方便使用位运算。
        // MAXN是拷贝数组的长度
        // sum[]模拟线段树维护区间和
        // lazy[]为累加和标记即懒加和标记
        // change[]为更新的值
        // update[]为更新标记即懒更新标记
        private int[] arr;
        private int MAXN;
        private int[] sum;
        private int[] lazy;
        private int[] change;
        private boolean[] update;

        // 构造函数,初始化所有数组空间
        public SegmentTree(int[] origin) {
            // 创建原数组origin对应的拷贝数组arr，从下标1开始，方便后续的位运算
            MAXN = origin.length + 1;
            arr = new int[MAXN]; // arr[0] 不用 从1开始使用
            for (int i = 1; i < MAXN; i++) {
                arr[i] = origin[i - 1];
            }
            // 为了把所有数都刚好让左右等范围cover住，申请长度MAXN*4即左移2位
            sum = new int[MAXN << 2]; // 用来支持脑补概念中，某一个范围的累加和信息
            lazy = new int[MAXN << 2]; // 用来支持脑补概念中，某一个范围沒有往下傳遞的纍加任務
            change = new int[MAXN << 2]; // 用来支持脑补概念中，某一个范围有没有更新操作的任务
            update = new boolean[MAXN << 2]; // 用来支持脑补概念中，某一个范围更新任务，更新成了什么
        }

        // 当前节点收集左右子节点的和信息。懒加和，懒更新后，都需要执行这个操作
        private void pushUp(int rt) {
            /*
             * rt是当前节点索引
             * rt对应的左子节点是rt*2即rt << 1
             * rt对应的右子节点是rt*2+1即rt << 1|1
             * */
            sum[rt] = sum[rt << 1] + sum[rt << 1 | 1];
        }

        // 下发懒更新和懒加和。懒加和，懒更新，都需要把自己的任务下发给左右子节点。分发策略:从父范围，分发给左右边界
        private void pushDown(int rt, int ln, int rn) {
            /*
             * ln表示左子树元素结点个数，rn表示右子树结点个数
             * */
            // 如果当前节点懒更新标记为true,则下发懒更新
            if (update[rt]) {
                /*
                 * 下发给左右节点懒更新时，
                 * 左右节点的懒更新标记为true
                 * 左右节点的懒更新值为父节点值
                 * 左右节点的懒加和清空，置为0
                 * 左右节点的区间和，直接计算为长度*懒更新值
                 * 当前自己节点的懒更新标记为false，清空，表示后续不用再下发
                 * */
                update[rt << 1] = true;
                update[rt << 1 | 1] = true;
                change[rt << 1] = change[rt];
                change[rt << 1 | 1] = change[rt];
                lazy[rt << 1] = 0;
                lazy[rt << 1 | 1] = 0;
                sum[rt << 1] = change[rt] * ln;
                sum[rt << 1 | 1] = change[rt] * rn;
                update[rt] = false;
            }
            // 如果当前节点懒加和标记不为0,则下发懒加和
            if (lazy[rt] != 0) {
                /*
                 * 下发给左右节点懒加和时，
                 * 左右节点的懒加和=之前的值+当前父节点的值
                 * 左右节点的区间和=当前懒加和*长度
                 * 当前自己节点的懒加和标记为0，清空，表示后续不用再下发
                 * */
                lazy[rt << 1] += lazy[rt];
                lazy[rt << 1 | 1] += lazy[rt];
                sum[rt << 1] += lazy[rt] * ln;
                sum[rt << 1 | 1] += lazy[rt] * rn;
                lazy[rt] = 0;
            }
        }

        // 初始化线段树：构建线段树的初值，sum数组填充。
        public void build(int l, int r, int rt) {
            /*
             * 在arr[l~r]范围上，去build构建sum数组信息。
             * rt是sum数组的下标索引
             * */
            if (l == r) {
                sum[rt] = arr[l];
                return;
            }
            int mid = (l + r) >> 1;
            build(l, mid, rt << 1);
            build(mid + 1, r, rt << 1 | 1);
            pushUp(rt);
        }

        // 在L到R索引范围上，每个元素都加上C
        public void add(int L, int R, int C, int l, int r, int rt) {
            /*
             *L~R, C 表示任务的3个变量
             * l,r是线段树的某个节点的左右区间，rt是某个节点的索引。这三个值可以认为是固定值。
             * */
            // 任务如果把此时的范围全包了！那么这个节点区间直接命中
            if (L <= l && r <= R) {
                // 区间和=之前值+c*区间长度
                sum[rt] += C * (r - l + 1);
                // 懒加载和=之前值+当前值C
                lazy[rt] += C;
                return;
            }
            // 如果任务没有把你全包！
            // 取二分中点，l  r  mid = (l+r)/2
            int mid = (l + r) >> 1;
            // 先下发懒更新和懒加和
            pushDown(rt, mid - l + 1, r - mid);
            // 如果任务的左边界越过区间的中点，去左边了，则去左子节点继续递归。rt << 1等于rt*2
            if (L <= mid) {
                add(L, R, C, l, mid, rt << 1);
            }
            // 如果任务的右边界越过区间的中点，去右边了，则去右子节点继续递归.rt << 1|1等于rt*2+1
            if (R > mid) {
                add(L, R, C, mid + 1, r, rt << 1 | 1);
            }
            // 等前面的子节点信息填好了后，再当前节点收集左右子节点的和信息
            pushUp(rt);
        }

        // 在L到R索引范围上，每个元素都更新为C
        public void update(int L, int R, int C, int l, int r, int rt) {
            /*
             *L~R, C 表示任务的3个变量
             * l,r是线段树的某个节点的左右区间，rt是某个节点的索引。这三个值可以认为是固定值。
             * */
            // 任务如果把此时的范围全包了！那么这个节点区间直接命中
            if (L <= l && r <= R) {
                /*
                 * 当前节点的懒更新标记为true
                 * 当前节点的懒更新值为C
                 * 当前节点的区间和=C*区间长度
                 * 当前节点的懒加和清空，为0
                 * */
                update[rt] = true;
                change[rt] = C;
                sum[rt] = C * (r - l + 1);
                lazy[rt] = 0;
                return;
            }
            // 当前任务躲不掉，无法懒更新，要往下发
            int mid = (l + r) >> 1;
            // 先下发懒更新和懒加和
            pushDown(rt, mid - l + 1, r - mid);
            // 如果任务的左边界越过区间的中点，去左边了，则去左子节点继续递归。rt << 1等于rt*2
            if (L <= mid) {
                update(L, R, C, l, mid, rt << 1);
            }
            // 如果任务的右边界越过区间的中点，去右边了，则去右子节点继续递归.rt << 1|1等于rt*2+1
            if (R > mid) {
                update(L, R, C, mid + 1, r, rt << 1 | 1);
            }
            // 等前面的子节点信息填好了后，再当前节点收集左右子节点的和信息
            pushUp(rt);
        }

        // 查询L~R上的累加和是多少
        public long query(int L, int R, int l, int r, int rt) {
            /*
             *L~R 表示任务的2个变量
             * l,r是线段树的某个节点的左右区间，rt是某个节点的索引。这三个值可以认为是固定值。
             * */
            // 任务区间包括了节点的区间值，命中
            if (L <= l && r <= R) {
                return sum[rt];
            }
            int mid = (l + r) >> 1;
            // 先下发懒更新和懒加和
            pushDown(rt, mid - l + 1, r - mid);
            long ans = 0;
            // 如果任务的左边界越过区间的中点，去左边了。去左节点收集和
            if (L <= mid) {
                ans += query(L, R, l, mid, rt << 1);
            }
            // 如果任务的右边界越过区间的中点，去右边了。去右节点收集和
            if (R > mid) {
                ans += query(L, R, mid + 1, r, rt << 1 | 1);
            }
            // 最后返回
            return ans;
        }

    }

    public static class Right {
        // 对数器：最暴力的直接求和
        public int[] arr;

        public Right(int[] origin) {
            arr = new int[origin.length + 1];
            for (int i = 0; i < origin.length; i++) {
                arr[i + 1] = origin[i];
            }
        }

        public void update(int L, int R, int C) {
            for (int i = L; i <= R; i++) {
                arr[i] = C;
            }
        }

        public void add(int L, int R, int C) {
            for (int i = L; i <= R; i++) {
                arr[i] += C;
            }
        }

        public long query(int L, int R) {
            long ans = 0;
            for (int i = L; i <= R; i++) {
                ans += arr[i];
            }
            return ans;
        }

    }

    public static int[] genarateRandomArray(int len, int max) {
        int size = (int) (Math.random() * len) + 1;
        int[] origin = new int[size];
        for (int i = 0; i < size; i++) {
            origin[i] = (int) (Math.random() * max) - (int) (Math.random() * max);
        }
        return origin;
    }

    public static boolean test() {
        int len = 100;
        int max = 1000;
        int testTimes = 5000;
        int addOrUpdateTimes = 1000;
        int queryTimes = 500;
        for (int i = 0; i < testTimes; i++) {
            int[] origin = genarateRandomArray(len, max);
            SegmentTree seg = new SegmentTree(origin);
            /*
             * S,N是线段树的某个节点的左右区间，root是某个节点的索引。这三个值可以认为是固定值。
             * */
            int S = 1;
            int N = origin.length;
            int root = 1;
            // 初始化线段树
            seg.build(S, N, root);
            // 对数器的数组
            Right rig = new Right(origin);
            for (int j = 0; j < addOrUpdateTimes; j++) {
                int num1 = (int) (Math.random() * N) + 1;
                int num2 = (int) (Math.random() * N) + 1;
                int L = Math.min(num1, num2);
                int R = Math.max(num1, num2);
                int C = (int) (Math.random() * max) - (int) (Math.random() * max);
                if (Math.random() < 0.5) {
                    // 等概率小于0.5的添加值
                    seg.add(L, R, C, S, N, root);
                    rig.add(L, R, C);
                } else {
                    // 等概率大于等于0.5的更新值
                    seg.update(L, R, C, S, N, root);
                    rig.update(L, R, C);
                }
            }
            // 测试500次，和对数器逐一比对，死都测出来
            for (int k = 0; k < queryTimes; k++) {
                int num1 = (int) (Math.random() * N) + 1;
                int num2 = (int) (Math.random() * N) + 1;
                int L = Math.min(num1, num2);
                int R = Math.max(num1, num2);
                long ans1 = seg.query(L, R, S, N, root);
                long ans2 = rig.query(L, R);
                if (ans1 != ans2) {
                    return false;
                }
            }
        }
        return true;
    }

    public static void main(String[] args) {
        int[] origin = {2, 1, 1, 2, 3, 4, 5};
        SegmentTree seg = new SegmentTree(origin);
        int S = 1; // 整个区间的开始位置，规定从1开始，不从0开始 -> 固定
        int N = origin.length; // 整个区间的结束位置，规定能到N，不是N-1 -> 固定
        int root = 1; // 整棵树的头节点位置，规定是1，不是0 -> 固定
        int L = 2; // 操作区间的开始位置 -> 可变
        int R = 5; // 操作区间的结束位置 -> 可变
        int C = 4; // 要加的数字或者要更新的数字 -> 可变
        // 区间生成，必须在[S,N]整个范围上build
        seg.build(S, N, root);
        // 区间修改，可以改变L、R和C的值，其他值不可改变
        seg.add(L, R, C, S, N, root);
        // 区间更新，可以改变L、R和C的值，其他值不可改变
        seg.update(L, R, C, S, N, root);
        // 区间查询，可以改变L和R的值，其他值不可改变
        long sum = seg.query(L, R, S, N, root);
        System.out.println(sum);
        
        System.out.println("对数器测试开始...");
        System.out.println("测试结果 : " + (test() ? "通过" : "未通过"));
    }
}
```

# 经典面试题

### 每种能力的最高报酬

题目：每种工作有难度和报酬，规定如下：class Job{public int hard;public int money;}。给定一个Job类型的数组jobarr，表示所有岗位，每个岗位都可以提供任意份工作，选工作的标准是难度不超过自身能力值，选择报酬最高的岗位。求返回int数组，表示每个人按照标准选择的最高报酬。

思路：

- 先将job数组按照难度值升序且报酬值降序排列，难度值相同的情况下，只保留最大报酬值的那个
- 在剩余数组中，逐一比较，如果难度值上升，报酬值也上升，这样的数据保留。否则，删除。

```
import java.util.*;
public class Problem07_ChooseWork {
    public static void main(String[] args) {
        List<Job> job = new ArrayList<Job>();
        Job job1 = new Job(1,1);
        Job job2 = new Job(2,5);
        Job job3 = new Job(4,4);
        Job job4 = new Job(5,7);
        Job job5 = new Job(8,8);
        job.add(job1);
        job.add(job2);
        job.add(job3);
        job.add(job4);
        job.add(job5);
        int[] ans = getMoneys((job.toArray(new Job[job.size()])),new int[]{1,2,3});
        System.out.println("结束");
    }
    public static class Job {
        public int money;
        public int hard;

        public Job(int m, int h) {
            money = m;
            hard = h;
        }
    }
    public static class JobComparator implements Comparator<Job> {
        @Override
        public int compare(Job o1, Job o2) {
            return o1.hard != o2.hard ? (o1.hard - o2.hard) : (o2.money - o1.money);
        }
    }

    public static int[] getMoneys(Job[] job, int[] ability) {
        Arrays.sort(job, new JobComparator());
        // key : 难度   value：报酬
        TreeMap<Integer, Integer> map = new TreeMap<>();
        map.put(job[0].hard, job[0].money);
        // pre : 上一份进入map的工作
        Job pre = job[0];
        for (int i = 1; i < job.length; i++) {
            if (job[i].hard != pre.hard && job[i].money > pre.money) {
                // hard值相同的只取一个，报酬也要递增，很巧妙
                pre = job[i];
                map.put(pre.hard, pre.money);
            }
        }
        // map中就是各个难度岗位的最高报酬值，接下来就是匹配目标值向下取整即不超过目标能力值的报酬。
        int[] ans = new int[ability.length];
        for (int i = 0; i < ability.length; i++) {
            // ability[i] 当前人的能力 <= ability[i]  且离它最近的
            Integer key = map.floorKey(ability[i]);
            ans[i] = key != null ? map.get(key) : 0;
        }
        return ans;
    }
}
```

### 简单背包问题

题目：背包容量为w,一共有n袋零食，第i袋零食体积为v[i]>0.总体积不超过背包容量的情况下，一共有多少种零食放法(总体积为0也算是一种放法)

思路：

- 解法1：暴力递归的尝试过程
- 解法2：暴力递归改写的dp
- 解法3：另一种解法的dp

```
public class Code02_SnacksWays {
   public static int ways1(int[] arr, int w) {
      // 解法1：暴力递归的尝试过程
      return process(arr, 0, w);
   }
   // 从左往右的经典模型
   // 还剩的容量是rest，arr[index...]自由选择，
   // 返回选择方案
   // index ： 0～N，当前来到的零食索引值，表示纵坐标
   // rest : 0~w，当前还剩余的可用容积，表示横坐标
   public static int process(int[] arr, int index, int rest) {
      if (rest < 0) { // 没有容量了
         // -1 无方案的意思
         return 0;
      }
      // rest>=0,
      if (index == arr.length) { // 无零食可选
         return 1;
      }
      // rest >=0
      // 有零食index
      // index号零食，要 or 不要
      // index, rest
      // (index+1, rest)
      // (index+1, rest-arr[i])
      int next1 = process(arr, index + 1, rest); // 不要
      int next2 = process(arr, index + 1, rest - arr[index]); // 要
      return next1 + next2;
   }

   public static int ways2(int[] arr, int w) {
      // 解法2：暴力递归改简单动态规划，从下到上，从左到右改写。利用未使用容量求解
      // dp[i][j]中i：0～N中，第i个位置，剩余容量j的方法数
      int N = arr.length;
      int[][] dp = new int[N + 1][w + 1];
      // 从N袋零食后，无零食可选了，就是一种方法了
      for (int j = 0; j <= w; j++) {
         dp[N][j] = 1;
      }
      for (int i = N - 1; i >= 0; i--) {
         for (int j = 0; j <= w; j++) {
            dp[i][j] = dp[i + 1][j] + ((j - arr[i] >= 0) ? dp[i + 1][j - arr[i]] : 0);
         }
      }
      // 返回index号零食开始，容量还剩w的方法数
      return dp[0][w];
   }

   public static int ways3(int[] arr, int w) {
      // 解法3：暴力递归改简单动态规划，利用已使用容量求解，不太好理解就使用解法2.
      // dp[i][j]中i：0～N中，第i个位置，已使用的容量j的方法数
      int N = arr.length;
      int[][] dp = new int[N][w + 1];
      for (int i = 0; i < N; i++) {
         dp[i][0] = 1;
      }
      if (arr[0] <= w) {
         dp[0][arr[0]] = 1;
      }
      for (int i = 1; i < N; i++) {
         for (int j = 1; j <= w; j++) {
            dp[i][j] = dp[i - 1][j] + ((j - arr[i]) >= 0 ? dp[i - 1][j - arr[i]] : 0);
         }
      }
      int ans = 0;
      for (int j = 0; j <= w; j++) {
         ans += dp[N - 1][j];
      }
      return ans;
   }

   public static void main(String[] args) {
      int[] arr = { 4, 3, 2, 9 };
      int w = 8;
      System.out.println(ways1(arr, w));
      System.out.println(ways2(arr, w));
      System.out.println(ways3(arr, w));
   }
}
```

### 最长公共子串

题目：注意区分子串和子序列的不同。给定两个字符串str1和str2，求两个字符串的最长公共子串。

思路：动态规划的空间压缩技巧

- 解法1：直接填写dp表，并统计最大值，返回max和i.
- 解法2：不使用dp二维数组，而是用有限的几个变量记录。将dp二维空间压缩到有限的几个变量

```
// 最长公共子串问题是面试常见题目之一
public class Code03_LongestCommonSubstringConquerByHeight {
    public static String lcs1(String str1, String str2) {
        // 解法1：直接填写dp表，并统计最大值，返回max和i.
        if (str1 == null || str2 == null || str1.equals("") || str2.equals("")) {
            return "";
        }
        char[] chs1 = str1.toCharArray();
        char[] chs2 = str2.toCharArray();
        int[][] dp = getdp(chs1, chs2);
        int end = 0;
        int max = 0;
        // 遍历找到最大值
        for (int i = 0; i < chs1.length; i++) {
            for (int j = 0; j < chs2.length; j++) {
                if (dp[i][j] > max) {
                    end = i;
                    max = dp[i][j];
                }
            }
        }
        return str1.substring(end - max + 1, end + 1);
    }

    public static int[][] getdp(char[] str1, char[] str2) {
        // 填写dp表，dp[i][j]表示以str1的第i个字符结尾，以str2的第j个字符结尾的公共子串的长度
        int[][] dp = new int[str1.length][str2.length];
        // 对于第一列，只有ij对应的字符相等，长度才为1
        for (int i = 0; i < str1.length; i++) {
            if (str1[i] == str2[0]) {
                dp[i][0] = 1;
            }
        }
        // 对于第一行，只有ij对应的字符相等，长度才为1
        for (int j = 1; j < str2.length; j++) {
            if (str1[0] == str2[j]) {
                dp[0][j] = 1;
            }
        }
        // 其他的行列，就需要根据前面的值推导
        for (int i = 1; i < str1.length; i++) {
            for (int j = 1; j < str2.length; j++) {
                if (str1[i] == str2[j]) {
                    // 如果当前字符相同，则当前长度在前面的基础上+1.不相同，则默认为0
                    dp[i][j] = dp[i - 1][j - 1] + 1;
                }
            }
        }
        return dp;
    }

    public static String lcs2(String s1, String s2) {
        // 解法2：不使用dp二维数组，而是用有限的几个变量记录。将dp二维空间压缩到有限的几个变量
        if (s1 == null || s2 == null || s1.length() == 0 || s2.length() == 0) {
            return "";
        }
        char[] str1 = s1.toCharArray();
        char[] str2 = s2.toCharArray();
        // 用行列两个变量简单记录，替代dp的二维表结构
        // 定义行索引
        int row = 0;
        // 定义列索引
        int col = str2.length - 1;
        int max = 0;
        int end = 0;
        // 遍历行索引(遍历行，遍历列)
        /*
         * --------<---
         * |
         * |
         * V
         * |
         * */
        while (row < str1.length) {
            // 局部变量i,j
            int i = row;
            int j = col;
            int len = 0;
            // 相当于斜着扫一遍
            while (i < str1.length && j < str2.length) {
                if (str1[i] != str2[j]) {
                    // 字符不相同，当前字符串的公共长度为0
                    len = 0;
                } else {
                    // 字符相同，则在前者的基础上累加。除非遇到不同，才置0.
                    len++;
                }
                if (len > max) {
                    // 每次都找到全局最大值
                    max = len;
                    end = i;
                }
                // 斜着扫一遍
                i++;
                j++;
            }
            if (col > 0) {
                // 遍历列
                col--;
            } else {
                // 遍历行
                row++;
            }
        }
        return s1.substring(end - max + 1, end + 1);
    }

    //  随机生成字符串
    public static String randomNumberString(int len, int range) {
        char[] str = new char[len];
        for (int i = 0; i < len; i++) {
            str[i] = (char) ((int) (Math.random() * range) + 'a');
        }
        return String.valueOf(str);
    }

    public static void main(String[] args) {
        long start;
        long end;
        String str1 = "zxcvbn";
        String str2 = "2e8ucvboi9u";
        start = System.currentTimeMillis();
        end = System.currentTimeMillis();
        // 解法1：直接填写dp表，并统计最大值，返回max和i.
        System.out.println("方法1结果 : " + lcs1(str1, str2) + " , 运行时间 : " + (end - start) + " ms");
        // 解法2：不使用dp二维数组，而是用有限的几个变量记录。将dp二维空间压缩到有限的几个变量
        System.out.println("方法2结果 : " + lcs2(str1, str2) + " , 运行时间 : " + (end - start) + " ms");
    }
}

```

### 最长公共子序列

题目：给出两个字符串，找到最长公共子序列(LCS)，返回LCS的长度。

- 解法1：暴力递归的尝试模型，leetcode超时
- 解法2：暴力递归改写dp。leetcode通过

```
// 这个问题leetcode上可以直接测
// 链接：https://leetcode.com/problems/longest-common-subsequence/
public class Code04_LongestCommonSubsequence {
    public static int longestCommonSubsequence1(String s1, String s2) {
        // 解法1：暴力递归的尝试模型，leetcode超时
        if (s1 == null || s2 == null || s1.length() == 0 || s2.length() == 0) {
            return 0;
        }
        char[] str1 = s1.toCharArray();
        char[] str2 = s2.toCharArray();
        // 尝试
        return process1(str1, str2, str1.length - 1, str2.length - 1);
    }

    // str1[0...i]和str2[0...j]，这个范围上最长公共子序列长度是多少？
    // 可能性分类:
    // a) 最长公共子序列，不以str1[i]字符结尾、不以str2[j]字符结尾
    // b) 最长公共子序列，以str1[i]字符结尾、不以str2[j]字符结尾
    // c) 最长公共子序列，不以str1[i]字符结尾、以str2[j]字符结尾
    // d) 最长公共子序列，以str1[i]字符结尾、以str2[j]字符结尾
    // 注意：a)、b)、c)、d)并不是完全互斥的，他们可能会有重叠的情况
    // 但是可以肯定，答案不会超过这四种可能性的范围
    // 那么我们分别来看一下，这几种可能性怎么调用后续的递归。
    // a) 最长公共子序列，一定不以str1[i]字符结尾、也一定不以str2[j]字符结尾
    //    如果是这种情况，那么有没有str1[i]和str2[j]就根本不重要了，因为这两个字符一定没用啊
    //    所以砍掉这两个字符，最长公共子序列 = str1[0...i-1]与str2[0...j-1]的最长公共子序列长度(后续递归)
    // b) 最长公共子序列，可能以str1[i]字符结尾、但是一定不以str2[j]字符结尾
    //    如果是这种情况，那么我们可以确定str2[j]一定没有用，要砍掉；但是str1[i]可能有用，所以要保留
    //    所以，最长公共子序列 = str1[0...i]与str2[0...j-1]的最长公共子序列长度(后续递归)
    // c) 最长公共子序列，一定不以str1[i]字符结尾、但是可能以str2[j]字符结尾
    //    跟上面分析过程类似，最长公共子序列 = str1[0...i-1]与str2[0...j]的最长公共子序列长度(后续递归)
    // d) 最长公共子序列，必须以str1[i]字符结尾、也必须以str2[j]字符结尾
    //    同时可以看到，可能性d)存在的条件，一定是在str1[i] == str2[j]的情况下，才成立的
    //    所以，最长公共子序列总长度 = str1[0...i-1]与str2[0...j-1]的最长公共子序列长度(后续递归) + 1(共同的结尾)
    // 综上，四种情况已经穷尽了所有可能性。四种情况中取最大即可
    public static int process1(char[] str1, char[] str2, int i, int j) {
        // base case
        if (i == 0 && j == 0) {
            // str1[0..0]和str2[0..0]，都只剩一个字符了
            // 那如果字符相等，公共子序列长度就是1，不相等就是0
            return str1[i] == str2[j] ? 1 : 0;
        } else if (i == 0) {
            // 这里的情况为：
            // str1[0...0]和str2[0...j]，str1只剩1个字符了，但是str2不只一个字符
            // 因为str1只剩一个字符了，所以str1[0...0]和str2[0...j]公共子序列最多长度为1
            // 如果str1[0] == str2[j]，那么此时相等已经找到了！公共子序列长度就是1，也不可能更大了
            // 如果str1[0] != str2[j]，只是此时不相等而已，那么str2[0...j-1]上有没有字符等于str1[0]呢？不知道，所以递归继续找
            if (str1[i] == str2[j]) {
                return 1;
            } else {
                return process1(str1, str2, i, j - 1);
            }
        } else if (j == 0) {
            // 和上面的else if同理
            if (str1[i] == str2[j]) {
                return 1;
            } else {
                return process1(str1, str2, i - 1, j);
            }
        } else { // i != 0 && j != 0
            // 这里的情况为：
            // str1[0...i]和str2[0...i]，str1和str2都不只一个字符
            // 对应可能性a
            int p1 = process1(str1, str2, i - 1, j - 1);
            // 对应可能性c
            int p2 = process1(str1, str2, i - 1, j);
            // 对应可能性b
            int p3 = process1(str1, str2, i, j - 1);
            // 对应可能性d
            // 如果str1[i] == str2[j]，那么p3就求出来，参与pk
            // 如果str1[i] != str2[j]，那么让p3等于0，然后去参与pk，反正不影响
            int p4 = 0;
            if (str1[i] == str2[j]) {
                p4 = 1 + p1;
            }
            // 取p1,p2,p3,p4中的最大值
            return Math.max(Math.max(p1, p2), Math.max(p3, p4));
        }
    }

    public static int longestCommonSubsequence2(String s1, String s2) {
        // 解法2：暴力递归改写dp。leetcode通过
        if (s1 == null || s2 == null || s1.length() == 0 || s2.length() == 0) {
            return 0;
        }
        char[] str1 = s1.toCharArray();
        char[] str2 = s2.toCharArray();
        int N = str1.length;
        int M = str2.length;
        // dp[i][j]表示以str1以i结尾，str2以j结尾的最长公共子序列长度
        int[][] dp = new int[N][M];
        dp[0][0] = str1[0] == str2[0] ? 1 : 0;
        for (int j = 1; j < M; j++) {
            dp[0][j] = str1[0] == str2[j] ? 1 : dp[0][j - 1];
        }
        for (int i = 1; i < N; i++) {
            dp[i][0] = str1[i] == str2[0] ? 1 : dp[i - 1][0];
        }
        for (int i = 1; i < N; i++) {
            for (int j = 1; j < M; j++) {
                int p1 = dp[i - 1][j];
                int p2 = dp[i][j - 1];
                int p3 = dp[i-1][j - 1];
                int p4 = str1[i] == str2[j] ? (1 + p3) : 0;
                // 取p1,p2,p3,p4中的最大值填写到dp表
                dp[i][j] = Math.max(Math.max(p1, p2), Math.max(p3, p4));
            }
        }
        return dp[N - 1][M - 1];
    }

}
```

### 词频最大前K个字符串

题目：给定一个由字符串组成的数组String[] strs,给定一个正数K.返回词频最大的前K个字符串，假设结果是唯一的。

**思路**：先搞一个HashMap，遍历整个数组。

- 解法1：搞一个大根堆，然后遍历HashMap建立，最后从堆顶拿K个。
- 解法2：搞一个Size大小规定为K的小根堆，每次从HashMap里拿的时候直接跟栈顶比较，如果小于栈顶直接不考虑（即，进入小根堆的门槛），大于栈顶则丢掉栈顶，加入这个元素.最后的小根堆就是最大的前K个字符串。这个比较经典。

```
import java.util.*;
public class Code06_TopKTimes {
    public static void main(String[] args) {
        String[] s = {"abc","ab","ab","bc","ac","abc","ef","kisd","ef","ef"};
        printTopKAndRank(s,2);
    }
    public static class Node {
        public String str;
        public int times;

        public Node(String s, int t) {
            this.str = s;
            this.times = t;
        }
    }

    // 按照词频规则排序
    public static class  NodeComparator implements Comparator<Node> {
        @Override
        public int compare(Node o1, Node o2) {
            return o1.times - o2.times;
        }
    }

    // 解法2：创建小根堆，遍历剔除顶部值，最终留下的小根堆就是topk的字符串
    public static void printTopKAndRank(String[] arr, int topK) {
        if (arr == null || arr.length == 0 || topK < 1 || topK > arr.length) {
            return;
        }
        // 构建字符串和词频的键值对
        HashMap<String, Integer> map = new HashMap<>();
        for (String str : arr) {
            if (!map.containsKey(str)) {
                map.put(str, 1);
            } else {
                map.put(str, map.get(str) + 1);
            }
        }
        topK = Math.min(arr.length,topK);
        // 按照词频建立小根堆
        PriorityQueue heap = new PriorityQueue<>(new NodeComparator());
        for(Map.Entry<String, Integer> entry : map.entrySet()) {
            // 新建节点
            Node cur = new Node(entry.getKey(), entry.getValue());
            if (heap.size() < topK) {
                // 如果小根堆不足k个，直接添加
                heap.add(cur);
            } else {
                Node node = (Node)heap.peek();
                if (node.times < cur.times) {
                    // 如果当前值大于小根堆的顶部值，把当期值替换顶部值，小根堆内部heapfy
                    heap.poll();
                    heap.add(cur);
                }
            }
        }
        while(!heap.isEmpty()) {
            // 依次弹出所有的小根堆数据，刚好就是前K个最大词频字符串
            Node node = (Node)heap.poll();
            System.out.println(node.str);
        }
    }
}
```

### 词频最大的K个元素

题目：在实时数据流中找到最常使用的k个单词.实现*TopK*类中的三个方法:
`TopK(k)`, 构造方法
`add(word)`, 增加一个新单词
`topk()`, 得到当前最常使用的k个单词.

- 解法：小根堆加入节点，注意只有比小根堆顶点值大的节点才能加入，始终保证大值入堆。因为复杂度要求是O(logk),所以只能是自己实现的动态小根堆。

```
import java.util.*;
// 本题测试链接：https://www.lintcode.com/problem/top-k-frequent-words-ii/
// 以上的代码不要粘贴, 把以下的代码粘贴进java环境编辑器
// 把类名和构造方法名改成TopK, 可以直接通过
public class Code02_TopK {
    private Node[] heap;
    private int heapSize;
    // 词频表   key  abc   value  (abc,7)
    private HashMap<String, Node> strNodeMap;
    // 自己实现的动态小根堆-索引表
    private HashMap<Node, Integer> nodeIndexMap;
    private NodeHeapComp comp;
    // 自己实现的动态小根堆
    private TreeSet<Node> treeSet;

    public Code02_TopK(int K) {
        heap = new Node[K];
        heapSize = 0;
        strNodeMap = new HashMap<String, Node>();
        nodeIndexMap = new HashMap<Node, Integer>();
        comp = new NodeHeapComp();
        treeSet = new TreeSet<>(new NodeTreeSetComp());
    }

    public static class Node {
        public String str;
        public int times;
        public Node(String s, int t) {
            str = s;
            times = t;
        }
    }

    public static class NodeHeapComp implements Comparator<Node> {
        @Override
        public int compare(Node o1, Node o2) {
            return o1.times != o2.times ? (o1.times - o2.times) : (o2.str.compareTo(o1.str));
        }
    }

    public static class NodeTreeSetComp implements Comparator<Node> {
        @Override
        public int compare(Node o1, Node o2) {
            return o1.times != o2.times ? (o2.times - o1.times) : (o1.str.compareTo(o2.str));
        }
    }

    // 解法：小根堆加入节点，注意只有比小根堆顶点值大的节点才能加入，始终保证大值入堆。因为复杂度要求是O(logk),所以只能是自己实现的动态小根堆。
    public void add(String str) {
        if (heap.length == 0) {
            return;
        }
        // str   找到对应节点  curNode
        Node curNode = null;
        // 对应节点  curNode  在堆上的位置
        int preIndex = -1;
        if (!strNodeMap.containsKey(str)) {
            curNode = new Node(str, 1);
            strNodeMap.put(str, curNode);
            nodeIndexMap.put(curNode, -1);
        } else {
            curNode = strNodeMap.get(str);
            // 要在time++之前，先在treeSet中删掉
            // 原因是因为一但times++，curNode在treeSet中的排序就失效了
            // 这种失效会导致整棵treeSet出现问题
            if (treeSet.contains(curNode)) {
                treeSet.remove(curNode);
            }
            curNode.times++;
            preIndex = nodeIndexMap.get(curNode);
        }
        if (preIndex == -1) {
            if (heapSize == heap.length) {
                if (comp.compare(heap[0], curNode) < 0) {
                    treeSet.remove(heap[0]);
                    treeSet.add(curNode);
                    nodeIndexMap.put(heap[0], -1);
                    nodeIndexMap.put(curNode, 0);
                    heap[0] = curNode;
                    heapify(0, heapSize);
                }
            } else {
                treeSet.add(curNode);
                nodeIndexMap.put(curNode, heapSize);
                heap[heapSize] = curNode;
                heapInsert(heapSize++);
            }
        } else {
            treeSet.add(curNode);
            heapify(preIndex, heapSize);
        }
    }

    // 返回topK个最大的节点即最终的小根堆
    public List<String> topk() {
        ArrayList<String> ans = new ArrayList<>();
        for (Node node : treeSet) {
            ans.add(node.str);
        }
        return ans;
    }

    private void heapInsert(int index) {
        while (index != 0) {
            int parent = (index - 1) / 2;
            if (comp.compare(heap[index], heap[parent]) < 0) {
                swap(parent, index);
                index = parent;
            } else {
                break;
            }
        }
    }

    private void heapify(int index, int heapSize) {
        int l = index * 2 + 1;
        int r = index * 2 + 2;
        int smallest = index;
        while (l < heapSize) {
            if (comp.compare(heap[l], heap[index]) < 0) {
                smallest = l;
            }
            if (r < heapSize && comp.compare(heap[r], heap[smallest]) < 0) {
                smallest = r;
            }
            if (smallest != index) {
                swap(smallest, index);
            } else {
                break;
            }
            index = smallest;
            l = index * 2 + 1;
            r = index * 2 + 2;
        }
    }

    private void swap(int index1, int index2) {
        nodeIndexMap.put(heap[index1], index2);
        nodeIndexMap.put(heap[index2], index1);
        Node tmp = heap[index1];
        heap[index1] = heap[index2];
        heap[index2] = tmp;
    }
}
```

### 已知树的先序和中序，求后序

题目：已知一棵二叉树中没有重复节点，给定它的先序和中序遍历数组，求后序遍历数组。比如int[] pre={1,2,4,5,3,6,7},int[] in={4,2,5,1,6,3,7}返回{4,5,2,6,7,3,1}

- 解法1：暴力递归，每次查询树范围索引mid,不断左树右树递归，恢复pos数组
- 解法2：暴力递归，提前缓存好中序遍历的所有节点索引，方便直接取出

```java
import java.util.ArrayList;
import java.util.HashMap;
import java.util.HashSet;
public class Code01_PreAndInArrayToPosArray {
 public static class Node {
  public int value;
  public Node left;
  public Node right;

  public Node(int v) {
   value = v;
  }
 }

 public static int[] preInToPos1(int[] pre, int[] in) {
  // 解法1：暴力递归，每次查询树范围索引
  if (pre == null || in == null || pre.length != in.length) {
   return null;
  }
  int N = pre.length;
  int[] pos = new int[N];
  // 传入2个数组和索引值，将后序数组pos排好即可
  process1(pre, 0, N - 1, in, 0, N - 1, pos, 0, N - 1);
  return pos;
 }

 // 传入2个数组和索引值，将后序数组pos排好即可
 // L1...R1 L2...R2 L3...R3
 public static void process1(int[] pre, int L1, int R1, int[] in, int L2, int R2, int[] pos, int L3, int R3) {
  // 边界，索引值不对，直接返回
  if (L1 > R1) {
   return;
  }
  // 如果只有一个元素了，先序的第一个节点即根节点就是后续的最后一个节点
  if (L1 == R1) {
   pos[L3] = pre[L1];
   return;
  }
  // 首先，先序的第一个节点即根节点就是后续的最后一个节点。取出了根节点，然后就要取出左右节点范围
  pos[R3] = pre[L1];
  int mid = L2;
  for (; mid <= R2; mid++) {
   // 在中序数组中，找到对应头结点的索引。mid索引值大小就是区分左右节点的范围
   if (in[mid] == pre[L1]) {
    break;
   }
  }
  int leftSize = mid - L2;
  // [L1 + 1, L1 + leftSize]对应先序的左树，[L2, mid - 1]对应中序的左树，[L3, L3 + leftSize - 1]对应后序的左树。剩余的左树范围的pos后序数组继续填充
  process1(pre, L1 + 1, L1 + leftSize, in, L2, mid - 1, pos, L3, L3 + leftSize - 1);
  // ...右树，右树，右树。剩余的右树范围的pos后序数组继续填充
  process1(pre, L1 + leftSize + 1, R1, in, mid + 1, R2, pos, L3 + leftSize, R3 - 1);
 }

 public static int[] preInToPos2(int[] pre, int[] in) {
  // 解法2：暴力递归，提前缓存好中序遍历的所有节点索引，方便直接取出
  if (pre == null || in == null || pre.length != in.length) {
   return null;
  }
  int N = pre.length;
  // 缓存map
  HashMap<Integer, Integer> inMap = new HashMap<>();
  for (int i = 0; i < N; i++) {
   inMap.put(in[i], i);
  }
  int[] pos = new int[N];
  process2(pre, 0, N - 1, in, 0, N - 1, pos, 0, N - 1, inMap);
  return pos;
 }

 public static void process2(int[] pre, int L1, int R1, int[] in, int L2, int R2, int[] pos, int L3, int R3,
   HashMap<Integer, Integer> inMap) {
  if (L1 > R1) {
   return;
  }
  if (L1 == R1) {
   pos[L3] = pre[L1];
   return;
  }
  pos[R3] = pre[L1];
  // 直接取出索引值
  int mid = inMap.get(pre[L1]);
  int leftSize = mid - L2;
  process2(pre, L1 + 1, L1 + leftSize, in, L2, mid - 1, pos, L3, L3 + leftSize - 1, inMap);
  process2(pre, L1 + leftSize + 1, R1, in, mid + 1, R2, pos, L3 + leftSize, R3 - 1, inMap);
 }
 public static  void print(int[] arr){
  for(int i=0;i<arr.length;i++){
   System.out.print(arr[i]+" ");
  }
  System.out.println();
 }
 public static void main(String[] args) {
  int[] pre={1,2,4,5,3,6,7};
  int[] in={4,2,5,1,6,3,7};
  int[] ans1 = preInToPos1(pre, in);
  int[] ans2 = preInToPos2(pre, in);
  print(ans1);
  print(ans2);
 }
}
```

### 最长递增子序列

题目：给出数组{4,10,4,3,8,9}，求最长的递增子序列的长度。

思路：子序列可以不连续，但要按照原数组顺序。还要递增。所以{3,8,9}或{4,8,9}等等 长度为3.

- 解法1：定义dp[i]表示第i个位置的最长递增子序列长度.必须双重循环来做
- 解法2：ends数组辅助加速获取最大递增子序列的长度。

```java
// 本题测试链接 : https://leetcode.com/problems/longest-increasing-subsequence
public class Code03_LIS {
   public static void main(String[] args) {
      int[] arr={4,10,4,3,8,9};
      System.out.println(lengthOfLIS0(arr));
      System.out.println(lengthOfLIS1(arr));
   }
   public static int lengthOfLIS0(int[] arr) {
      // 解法1：定义dp[i]表示第i个位置的最长递增子序列长度.必须双重循环来做
      int [] dp = new int[arr.length];
      // 取dp数组最大值返回
      int dpMax = 0;
      for(int i=0;i<arr.length;i++){
         int max = 1;
         for(int j=0;j<i;j++){
            // 逐一比较,找到前面的所有序列的最大长度值
            // 固定i,j从0到i-1扫一遍，如果arr[i]>arr[j]，长度是dp[j]+1.否则长度就是1.记录全局最大值即可
            max=Math.max(max,arr[i]>arr[j]?dp[j]+1:1);
         }
         dp[i]=max;
         dpMax = Math.max(dpMax,max);
      }
      return dpMax;
   }
   public static int lengthOfLIS1(int[] arr) {
      // 解法2：ends数组辅助加速获取最大递增子序列的长度。
      if (arr == null || arr.length == 0) {
         return 0;
      }
      // ends数组,非常难以理解，它是一个递增数组。更新ends规则：要么更新，要么扩容添加。它用来加速获取最大递增子序列值，避免了双重循环。
      // ends[i]表示 : 目前所有长度为i+1的递增子序列的最小结尾元素
      int[] ends = new int[arr.length];
      // 根据含义, 一开始ends[0] = arr[0]
      ends[0] = arr[0];
      // ends有效区范围是0...right，right往右为无效区
      // 所以一开始right = 0, 表示有效区只有0...0范围
      int right = 0;
      // 寻找 >= 当前数(arr[i])的最左位置，赋值给l
      int max = 1;
      for (int i = 1; i < arr.length; i++) {
         int l = 0;
         int r = right;
         // 在ends[l...r]范围上二分
         // 如果 当前数(arr[i]) > ends[m]，砍掉左侧
         // 如果 当前数(arr[i]) <= ends[m]，砍掉右侧
         // 整个二分就是在ends里寻找 >= 当前数(arr[i])的最左位置,即l
         // 如果存在l,则更新值。如果不存在l,则扩容添加
         // 比如存在l : ends = { 3, 5, 9, 12, 再往右无效}
         // 如果当前数为8, 从while里面出来时，l将来到2位置，ends更新为{ 3, 5, 8, 12, 再往右无效}
         // 比如不存在l : ends = { 3, 5, 9, 12, 再往右无效}
         // 如果当前数为13, 从while里面出来时，l将来到有效区的越界位置，扩容到4位置，ends扩容添加为{ 3, 5, 9, 12, 13,再往右无效}
         while (l <= r) {
            int m = (l + r) / 2;
            if (arr[i] > ends[m]) {
               l = m + 1;
            } else {
               r = m - 1;
            }
         }
         // 从while里面出来，看l的位置
         // 如果l比right大，说明扩充了有效区，那么right变量要随之变大--->扩容
         // 如果l不比right大，说明l没有来到有效区的越界位置，right不变--->更新
         right = Math.max(right, l);
         // l的位置，就是当前数应该填到ends数组里的位置，更新或扩容添加，都要赋值
         ends[l] = arr[i];
         // 更新全局变量，一定是end中最大值的索引+1
         max = Math.max(max, l + 1);
      }
      return max;
   }
}
```

### **俄罗斯套娃信封**

题目：给一定数量的信封，带有整数对 `(w, h)` 分别代表信封宽度和高度。一个信封的宽高均大于另一个信封时可以放下另一个信封。
求最大的信封嵌套层数。

```java
输入：[[5,4],[6,4],[6,7],[2,3]]
输出：3
解释：
最大的信封嵌套层数是 3 ([2,3] => [5,4] => [6,7])。

```

- 解法1：对象数组按照长度升序高度降序排序，然后把各自的高度挑出来，组成数组，它的最大递增子序列长度就是返回值

```
import java.util.Arrays;
import java.util.Comparator;
// 本题测试链接 : https://leetcode.com/problems/russian-doll-envelopes/
public class Code04_EnvelopesProblem {
 public static int maxEnvelopes(int[][] matrix) {
  // 解法1：对象数组按照长度升序高度降序排序，然后把各自的高度挑出来，组成数组，它的最大递增子序列长度就是返回值
  Envelope[] arr = sort(matrix);
  int[] ends = new int[matrix.length];
  ends[0] = arr[0].h;
  int right = 0;
  int l = 0;
  int r = 0;
  int m = 0;
  // 二分法，查找l
  for (int i = 1; i < arr.length; i++) {
   l = 0;
   r = right;
   while (l <= r) {
    m = (l + r) / 2;
    if (arr[i].h > ends[m]) {
     l = m + 1;
    } else {
     r = m - 1;
    }
   }
   right = Math.max(right, l);
   ends[l] = arr[i].h;
  }
  return right + 1;
 }

 public static class Envelope {
  public int l;
  public int h;

  public Envelope(int weight, int hight) {
   l = weight;
   h = hight;
  }
 }

 public static class EnvelopeComparator implements Comparator<Envelope> {
  @Override
  // l升序，h降序
  public int compare(Envelope o1, Envelope o2) {
   return o1.l != o2.l ? o1.l - o2.l : o2.h - o1.h;
  }
 }

 public static Envelope[] sort(int[][] matrix) {
  Envelope[] res = new Envelope[matrix.length];
  for (int i = 0; i < matrix.length; i++) {
   res[i] = new Envelope(matrix[i][0], matrix[i][1]);
  }
  Arrays.sort(res, new EnvelopeComparator());
  return res;
 }
}

```

### 最大累加和

题目：给定一个数组arr,返回子数组的最大累加和

```java
// 本题测试链接 : https://leetcode.com/problems/maximum-subarray/
public class Code02_SubArrayMaxSum {
   public static int maxSubArray(int[] arr) {
    // 解法1：利用两个变量记录cur和max.
      if (arr == null || arr.length == 0) {
         return 0;
      }
      int max = Integer.MIN_VALUE;
      int cur = 0;
      for (int i = 0; i < arr.length; i++) {
      // 记录实时累加值
         cur += arr[i];
      // 比较获取全局最大值
         max = Math.max(max, cur);
      // 如果实时累加值为负数的，则前面的直接丢弃，从0重新开始累加计算
         cur = cur < 0 ? 0 : cur;
      }
      return max;
   }
}
```

### 二叉树转为双向链表

题目：将BST二叉搜索树转换为已排序的循环双向链表。可以将左右指针视为双向链表中上一个和下一个指针的同义词。

- 解法1：使用二叉树递归套路，利用中序遍历

```
// 本题测试链接 : https://leetcode.com/problems/convert-binary-search-tree-to-sorted-doubly-linked-list/
public class Code04_BSTtoDoubleLinkedList {
   // 提交时不要提交这个类
   public static class Node {
      public int value;
      public Node left;
      public Node right;
      public Node(int data) {
         this.value = data;
      }
   }
   // 提交下面的代码
   public static Node treeToDoublyList(Node head) {
      // 解法1：使用二叉树递归套路，利用中序遍历
      if (head == null) {
         return null;
      }
      Info allInfo = process(head);
      // 因为是双向链表，最后还要首尾连接起来
      allInfo.end.right = allInfo.start;
      allInfo.start.left = allInfo.end;
      return allInfo.start;
   }

   // 组装头尾节点数据结构，头节点和尾节点
   public static class Info {
      public Node start;
      public Node end;
      public Info(Node start, Node end) {
         this.start = start;
         this.end = end;
      }
   }

   // 给定一个根节点为x的树，转化为链表后，返回头尾节点数据结构
   public static Info process(Node X) {
      if (X == null) {
         return new Info(null, null);
      }
      // 得到左子树的头尾节点
      Info lInfo = process(X.left);
      // 得到右子树的头尾节点
      Info rInfo = process(X.right);
      // 将x与左子树串起来
      X.left = lInfo.end;
      // 将x与右子树串起来
      X.right = rInfo.start;
      // 将左子树与x串起来
      if (lInfo.end != null) {
         lInfo.end.right = X;
      }
      // 将右子树与x串起来
      if (rInfo.start != null) {
         rInfo.start.left = X;
      }
      // 整体链表的头，继续往左子树找    lInfo.start != null ? lInfo.start : X
      // 整体链表的尾，继续往右子树找    rInfo.end != null ? rInfo.end : X
      return new Info(lInfo.start != null ? lInfo.start : X, rInfo.end != null ? rInfo.end : X);
   }
}
```

### **str1编辑成str2的最小代价**

题目：给定两个字符串str1和str2，再给定三个整数ic、dc和rc，分别代表插入、删除和替换一个字符的代价，返回将str1编辑成str2的最小代价。

【举例】

str1="abc"，str2="adc"，ic=5，dc=3，rc=2 从"abc"编辑成"adc"，把'b'替换成'd'是代价最小的，所以返回2

str1="abc"，str2="adc"，ic=5，dc=3，rc=100 从"abc"编辑成"adc"，先删除'b'，然后插入'd'是代价最小的，所以返回8

str1="abc"，str2="abc"，ic=5，dc=3，rc=2 不用编辑了，本来就是一样的字符串，所以返回0

```java
public class Code03_EditCost {
   public static int minCost1(String s1, String s2, int ic, int dc, int rc) {
      // 解法1：直接写dp，dp[i][j]表示s1的前i个字符串变成s2的前j个字符串的最小代价
      if (s1 == null || s2 == null) {
         return 0;
      }
      char[] str1 = s1.toCharArray();
      char[] str2 = s2.toCharArray();
      int N = str1.length + 1;
      int M = str2.length + 1;
      int[][] dp = new int[N][M];
      // dp[0][0] = 0，不用任何操作
      // dp边界，从有字符串变成空，需要依次删除的代价
      for (int i = 1; i < N; i++) {
         dp[i][0] = dc * i;
      }
      // dp边界，从空变成有字符串，需要依次添加的代价
      for (int j = 1; j < M; j++) {
         dp[0][j] = ic * j;
      }
      /*s1变成s2,正常的四种情况
      * s1 0---i-1,i
      * s2 0---j-1,j
      * 1.如果s1的前i-1和s2的前j-1是相等的
      * a.s1[i]==s2[j],代价就是dp[i-1][j-1]
      * b.s1[i]!=s2[j],代价就是dp[i-1][j-1]+rc(一个替换的代价)
      * 2.如果s1的前i-1和s2的前j-1是不等的
      * c.s1[0---i]替换s2[0---j-1],代价是dp[i][j-1]+ic(一个新增的代价，因为从i变成了j-1,理论上字符变少了一个，所以最后要追加一个)
      * d.s1[0---i-1]替换s2[0---j],代价是dp[i-1][j]+dc(一个删除的代价，因为从i-1变成了j,理论上字符变多了一个，所以最后要删除一个)
      * */
      for (int i = 1; i < N; i++) {
         for (int j = 1; j < M; j++) {
            // 情况a,情况b
            dp[i][j] = dp[i - 1][j - 1] + (str1[i - 1] == str2[j - 1] ? 0 : rc);
            // 情况c
            dp[i][j] = Math.min(dp[i][j], dp[i][j - 1] + ic);
            // 情况d
            dp[i][j] = Math.min(dp[i][j], dp[i - 1][j] + dc);
         }
      }
      // 最后返回s1前N个字符串变成s2前M个字符串的代价。N个对应N-1的索引
      return dp[N - 1][M - 1];
   }
}
```

**str1删除成str2的最小个数字符**

题目：给定两个字符串s1和s2，问s2最少删除多少字符可以成为s1的子串？比如 s1 = "abcde"，s2 = "axbc"。返回 1

- 解法1：求出str2所有的子序列，然后按照长度排序，长度大的排在前面。然后考察哪个子序列字符串和s1的某个子串相等(KMP)，答案就出来了。

```
public class Code04_DeleteMinCost {
 // 解法一
 // 求出str2所有的子序列，然后按照长度排序，长度大的排在前面。
 // 然后考察哪个子序列字符串和s1的某个子串相等(KMP)，答案就出来了。
 // 分析：
 // 因为题目原本的样本数据中，有特别说明s2的长度很小。所以这么做也没有太大问题，也几乎不会超时。
 // 但是如果某一次考试给定的s2长度远大于s1，这么做就不合适了。
 public static int minCost1(String s1, String s2) {
  List<String> s2Subs = new ArrayList<>();
  // 递归求解s2的所有子序列
  process(s2.toCharArray(), 0, "", s2Subs);
  // 对所有子序列的长度按照降序排列
  s2Subs.sort(new LenComp());
  for (String str : s2Subs) {
   // 查看s2的所有子序列是否是s1的子串
   if (s1.indexOf(str) != -1) { // indexOf底层和KMP算法代价几乎一样，也可以用KMP代替
    // 只要找到了，那么删除的长度就是s2-当前子序列的长度
    return s2.length() - str.length();
   }
  }
  // 如果一个都没找到，说明要全删除
  return s2.length();
 }
 public static class LenComp implements Comparator<String> {
  @Override
  public int compare(String o1, String o2) {
   return o2.length() - o1.length();
  }
 }
}
```

### 求完全二叉树节点的个数

题目：要求时间复杂度低于O(N).

- ```
  解法1：递归套路，O(h2)即O((logN)2)，之前是O(n)
   * a.计算出最大深度，一直向左窜
   * b.如果右子树的最左节点的深度达到最大深度，则说明左树满的，直接计算左树节点个数+1根节点+递归右子树
   * c.否则右树是满的，直接计算右树节点个数+1根节点+递归左子树
   * d.直到某个节点来到最大深度，节点个数为1
  ```

```
//本题测试链接 : https://leetcode.cn/problems/count-complete-tree-nodes/
public class Code04_CompleteTreeNodeNumber {
    // 提交时不要提交这个类
    public class TreeNode {
        int val;
        TreeNode left;
        TreeNode right;
    }

    /*
     * 解法1：递归套路，O(h2)即O((logN)2)，之前是O(n)
     * a.计算出最大深度，一直向左窜
     * b.如果右子树的最左节点的深度达到最大深度，则说明左树满的，直接计算左树节点个数+1根节点+递归右子树
     * c.否则右树是满的，直接计算右树节点个数+1根节点+递归左子树
     * d.直到某个节点来到最大深度，节点个数为1
     * */
    public static int countNodes(TreeNode head) {
        if (head == null) {
            return 0;
        }
        // 给定头结点，节点的所在层数，节点的树高度，返回节点个数
        return bs(head, 1, mostLeftLevel(head, 1));
    }

    // 当前来到node节点，node节点在level层，总层数是h
    // 返回node为头的子树(必是完全二叉树)，有多少个节点
    public static int bs(TreeNode node, int Level, int h) {
        // base case:说明节点来到了最后一层
        if (Level == h) {
            return 1;
        }
        // 判断节点的右子树的最左节点是否到达最后一层
        if (mostLeftLevel(node.right, Level + 1) == h) {
            // 如果到达最后一层，说明左子树是满的，继续递归右子树
            // 已知高度h计算节点个数：(2^h)-1,所以2^(h - Level)左树节点 -1 +1根节点
            return (1 << (h - Level)) + bs(node.right, Level + 1, h);
        } else {
            // 如果没有到达最后一层，说明右子树是满的，继续递归左子树
            // 2^(h - Level-1)右树节点 —1 +1根节点
            return (1 << (h - Level - 1)) + bs(node.left, Level + 1, h);
        }
    }

    // 如果node在第level层，求以node为头的子树，最大深度是多少。这是一个固定值
    // 二叉树节点的深度：指从根节点到该节点的最长简单路径边的条数。定义根节点是第1层
    public static int mostLeftLevel(TreeNode node, int level) {
        // 因为是完全二叉树，所以可以左节点一直往下扎，计算树的高度
        while (node != null) {
            level++;
            node = node.left;
        }
        // 高度
        return level - 1;
    }
}
```

### LRU算法

LRU算法全称是最近最少使用算法（Least Recently Use），广泛的应用于缓存机制中。如果一个信息项正在被访问，那么在近期它很可能还会被再次访问。所以顾名思义，LRU算法会选出最近最少使用的数据进行淘汰。

- 解法1：哈希表+双向链表实现LRU最近最少使用算法，关键是链表的头部是最远使用，尾部是最近使用。put()和get()操作的时间复杂度都是O(1)，空间复杂度为O(N)
- 解法2：基于LinkedHashMap实现的LRU

```
import java.util.HashMap;
// 本题测试链接 : https://leetcode.com/problems/lru-cache/
// 提交时把类名和构造方法名改成 : LRUCache
public class Code01_LRUCache {
    public Code01_LRUCache(int capacity) {
        cache = new MyCache<>(capacity);
    }
    private MyCache<Integer, Integer> cache;

    public int get(int key) {
        Integer ans = cache.get(key);
        return ans == null ? -1 : ans;
    }

    public void put(int key, int value) {
        cache.set(key, value);
    }
    public static class Node<K, V> {
        public K key;
        public V value;
        public Node<K, V> last;
        public Node<K, V> next;

        public Node(K key, V value) {
            this.key = key;
            this.value = value;
        }
    }

    // 双向链表，LRU的关键，头结点是最不常使用，尾节点是最长使用。所以LRU是删除头结点，更新尾节点
    public static class NodeDoubleLinkedList<K, V> {
        private Node<K, V> head;
        private Node<K, V> tail;

        public NodeDoubleLinkedList() {
            head = null;
            tail = null;
        }

        // 现在来了一个新的node，请挂到尾巴上去
        public void addNode(Node<K, V> newNode) {
            if (newNode == null) {
                return;
            }
            if (head == null) {
                head = newNode;
                tail = newNode;
            } else {
                tail.next = newNode;
                newNode.last = tail;
                tail = newNode;
            }
        }

        // 将当前节点挂到整个链表的尾巴上
        public void moveNodeToTail(Node<K, V> node) {
            if (tail == node) {
                return;
            }
            if (head == node) {
                // 如果要移动的节点是头结点
                // 当前节点的下一个节点变成新头
                head = node.next;
                // 头结点的上一节点指向空
                head.last = null;
            } else {
                // 如果要移动的节点是其他结点，那么这个节点前后节点要重新粘起来。如：当前节点的上一个节点的下一个指向当前节点的下一个节点。
                node.last.next = node.next;
                node.next.last = node.last;
            }
            // 当前节点的上一个节点指向老尾巴节点
            node.last = tail;
            // 老尾巴节点的下一个节点指向当前节点
            tail.next = node;
            // 当前节点的下一节点指向空
            node.next = null;
            // 新尾巴更新为当前节点
            tail = node;
        }

        // 双向链表删除头结点
        public Node<K, V> removeHead() {
            if (head == null) {
                return null;
            }
            // 先提取出返回值
            Node<K, V> res = head;
            // 调整头尾指针
            if (head == tail) {
                // 头尾节点相同，说明只有一个节点，直接全指向空
                head = null;
                tail = null;
            } else {
                // 说明至少有2个节点
                // 新头部指向当前节点下一个节点
                head = res.next;
                // 新头部的前一个节点指向空
                head.last = null;
                // 当前节点的下一个节点 断开
                res.next = null;
            }
            return res;
        }

    }

    // 解法1：哈希表+双向链表实现LRU最近最少使用算法，关键是链表的头部是最远使用，尾部是最近使用。put()和get()操作的时间复杂度都是O(1)，空间复杂度为O(N)
    public static class MyCache<K, V> {
        // map中key对应节点key，value对应节点的内存地址
        private HashMap<K, Node<K, V>> keyNodeMap;
        // 节点的双向链表
        private NodeDoubleLinkedList<K, V> nodeList;
        // LRU的容量
        private final int capacity;

        public MyCache(int cap) {
            keyNodeMap = new HashMap<K, Node<K, V>>();
            nodeList = new NodeDoubleLinkedList<K, V>();
            capacity = cap;
        }

        // 读取节点，更新链表尾巴
        public V get(K key) {
            if (keyNodeMap.containsKey(key)) {
                Node<K, V> res = keyNodeMap.get(key);
                // 节点移动到尾巴
                nodeList.moveNodeToTail(res);
                // 返回节点value值
                return res.value;
            }
            return null;
        }

        // 新增或更新节点，更新链表尾巴和更新哈希表
        public void set(K key, V value) {
            // 如果是更新节点，直接移动节点到链表尾巴
            if (keyNodeMap.containsKey(key)) {
                Node<K, V> node = keyNodeMap.get(key);
                node.value = value;
                // 直接移动节点到链表尾巴
                nodeList.moveNodeToTail(node);
            } else {
                // 如果是新增节点，直接添加到链表尾巴
                // 新增！注意先删除，再添加
                if (keyNodeMap.size() == capacity + 1) {
                    // 超出容量，移除头结点
                    removeMostUnusedCache();
                }
                Node<K, V> newNode = new Node<K, V>(key, value);
                keyNodeMap.put(key, newNode);
                nodeList.addNode(newNode);
            }
        }

        // 删除LRU缓存时，要删除链表头节点和哈希表中的节点
        private void removeMostUnusedCache() {
            Node<K, V> removeNode = nodeList.removeHead();
            keyNodeMap.remove(removeNode.key);
        }
    }
}
```

### Easy Equation

题目：求助

已知有n个整数，x1,x2,x3….xn.(1<=n<=10，0<=xi<=30)，以及m个整数a1,a2,a3….am(1<=m<=20,0<=ai<=25);
现在取出所有的a1,a2,a3…am.将他们随意分成n组，每组求和的值为b1,b2,b3…bn，然后成为x1,x2,x3…xn的系数。
（可以选择0个ai，组成一个对应的bj=0,但是数组a中的所有的ai必须选完）。
求满足b1*x1+b2*x2+b3*x3+…+bn*xn=s的分组方法数。其中s为输入的一个数据（0<=s<=20000）。
但是这个方法数也许会比较巨大,请输出分组方法数mod 1000000007 的结果。

```
输入：
4 4 68
1 2 4 8
1 2 4 8
输出：
3
```

```
public class 139 {
  public static void main(String[] args) {
      Scanner scanner = new Scanner(System.in);
      int n = scanner.nextInt();
      int m = scanner.nextInt();
      int s = scanner.nextInt();
      int[] x = new int[n];
      int[] a = new int[m];
      for (int i = 0; i < n; i++) {
          x[i] = scanner.nextInt();
      }
      for (int i = 0; i < m; i++) {
          a[i] = scanner.nextInt();
      }
      // result[i] 表示取a前i个参数（后面参数视为0）所构成的等式的结果种数
      int[][] result = new int[m][s + 1];
      for (int i = 0; i < n; i++) {
          // 初始化第一行，表示取a中第一个参数构成的等式的的结果种数
          // 如x = {1,1,2,2} ，a={1,2}，那么 取a的第一个参数就构成的等式结果 为{0，2，2}
          result[0][x[i] * a[0]] += 1;
      }
      for (int i = 1; i < m; i++) {
          for (int j = 0; j <= s; j++) {
              for (int k = 0; k < n; k++) {
                  // 等式构成的结果减去增加的新项，无需管分组求和
                  // 因为(a1+a2) * x1 = a1*x1 + a2*x1，这里的a[i] * x[k]就是 a2*x1，index就是a1*x1
                  int index = j - a[i] * x[k];
                  if (index < 0) {
                      continue;
                  }
                  // 增加的新项构成的等式结果种树 就等于 index的结果+已经有的
                  result[i][j] += result[i - 1][index];
                  result[i][j] = result[i][j] % 1000000007;
              }
          }
      }
      System.out.println(result[m - 1][s]);
  }
}
```
