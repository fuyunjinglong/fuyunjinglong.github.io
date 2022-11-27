---
title: H_左神数据结构与算法
date: 2022-11-13 07:33:16
categories:
- H_数据结构与算法
toc: true # 是否启用内容索引
---

# 前言

[基础班视频](https://www.bilibili.com/video/BV1Zr4y1W7ww?p=37&spm_id_from=pageDriver&vd_source=bd4c7d99d71adf64d6e88c65370e0247)

[代码仓库](https://github.com/fuyunjinglong/algorith-systematiclearning)

基础班和进阶班：绝对的技术干活。

体系学习班和大厂刷题班：比前者多一些新题型而已。

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



## 通用排序算法代码

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

## 选择排序

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

## 冒泡排序

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

## 插入排序

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

## 