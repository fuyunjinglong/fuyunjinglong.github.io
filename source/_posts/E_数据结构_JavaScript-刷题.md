---
title: JavaScript-刷题
date: 2024-05-05 06:33:16
categories:
- E_数据结构
toc: true # 是否启用内容索引

---

# 大纲

- [《算法通关手册》](https://github.com/fuyunjinglong/LeetCode-Py)
- [《代码随想录》](https://github.com/fuyunjinglong/leetcode-master)
- [Hello 算法](https://www.hello-algo.com/chapter_sorting/selection_sort/)
- [Leecode-CN](https://leetcode.cn/problemset/)

# 工具函数

交换位置上的值

```
// 交换arr的i和j位置上的值
function swap(arr,  i, j) {
    let tmp = arr[i];
    arr[i] = arr[j];
    arr[j] = tmp;
          // 更骚的交换，但i和j是一个位置的话，会出错
    /*arr[i] = arr[i] ^ arr[j];
    arr[j] = arr[i] ^ arr[j];
    arr[i] = arr[i] ^ arr[j];
    */
   }
```

# 排序算法

## **冒泡排序**-傻

> 一句话：通过相邻元素之间的比较与交换，把当前最大的泡泡冒泡到水面/右区间
>
> - 数组元素想象成泡泡
> - 从左到右依次比较，如果左侧泡泡比右侧泡泡大，则交换。[0,i]
> - 这1趟完，最大泡泡就在最右侧。然后循环。[0-,j]

```
function bubbleSort(arr){
    // 外循环：未排序区间为 [0, j]
    for(let j=arr.length-1;j>0;j--){
        let flag = false; // 初始化标志位
        // 内循环：将未排序区间 [0, i] 中的最大元素交换至该区间的最右端
        for(let i=0;i<j;i++){
            if(arr[i]>arr[i+1]){
                swap(arr,i,i+1);
                flag=true
            }
        }
        //如果本轮没有任何元素交换，在表示已排好序，直接跳出循环
        if(!flag){
            break;
        }
    }
    return arr
}
```

## **选择排序**-傻

> 一句话：数组分两个区间，左侧为已排序区间，右侧为未排序区间。每次从未排序区间找到最小值放到左区间末尾。
>
> - 数组分为左右两个区间：左边是已排序区间，右边是未排序区间。
> - 遍历右区间，找到最小值，并放到左区间末尾
> - 这一趟完，最小值出现在左区间最左侧。然后循环

```
function selectionSort(arr) {
  // 外循环：未排序区间为 [0, n-1]
  for (let j = 0; j < arr.length - 1; j++) {
    let minIndex = j;
    // 内循环：找到未排序区间内的最小元素
    for (let i = j; i < arr.length - 1; i++) {
      if (arr[i + 1] < arr[minIndex]) {
        minIndex = i + 1;
      }
    }
    // 最小值放到左区间的末尾
    swap(arr, j, minIndex);
  }
  return arr;
}
```

## 插入排序-傻

> 一句话：将数组分为两个区间：左侧为有序区间，右侧为无序区间。每趟从无序区间取出一个元素，然后将其插入到有序区间的适当位置。类似打扑克牌

```
function insertionSort(arr) {
  // 外层循环0 ~ i 做到有序
  for (let i = 1; i < arr.length; i++) {
    // 内层始终保持最大值在左区间末尾
    for (let j = i - 1; j >= 0 && arr[j] > arr[j + 1]; j--) {
      swap(arr, j, j + 1);
    }
  }
  return arr;
}
```

## 归并排序

> 一句话：采用经典的分治策略，先递归地将当前数组平均分成两半，然后将有序数组两两合并，最终合并成一个有序数组。

测试链接：https://leetcode.cn/problems/sort-an-array/description/

```
function mergeSort(arr) {
  if (arr == null || arr.length < 2) {
    return;
  }
  process(arr, 0, arr.length - 1);
  return arr;
}

function process(arr, L, R) {
  if (L == R) {
    return;
  }
  let mid = L + ((R - L) >> 1);
  process(arr, L, mid);
  process(arr, mid + 1, R);
  merge(arr, L, mid, R);
}

function merge(arr, L, M, R) {
  let help = [];
  let i = 0;
  let p1 = L;
  let p2 = M + 1;
  while (p1 <= M && p2 <= R) {
    help[i++] = arr[p1] <= arr[p2] ? arr[p1++] : arr[p2++];
  }

  while (p1 <= M) {
    help[i++] = arr[p1++];
  }

  while (p2 <= R) {
    help[i++] = arr[p2++];
  }

  for (let i = 0; i < help.length; i++) {
    arr[L + i] = help[i];
  }
  return;
}
```

## **快速排序**

> 一句话：采用经典的分治策略，选择数组中某个元素作为基准数，通过一趟排序将数组分为独立的两个子数组，一个子数组中所有元素值都比基准数小，另一个子数组中所有元素值都比基准数大。然后再按照同样的方式递归的对两个子数组分别进行快速排序，以达到整个数组有序。

测试链接：https://leetcode.cn/problems/sort-an-array/description/

```
function quickSort(arr) {
  if (arr == null || arr.length < 2) {
    return;
  }
  process(arr, 0, arr.length - 1);
  return arr;
}

// arr[L...R]排有序
function process(arr, L, R) {
  if (L >= R) {
    return;
  }
  // 利用荷兰国旗问题优化快排
  const equalArea = netherlandsFlag(arr, L, R);
  process(arr, L, equalArea[0] - 1);
  process(arr, equalArea[1] + 1, R);
}

function netherlandsFlag(arr, L, R) {
  // 不存在荷兰国旗问题
  if (L > R) {
    return [-1, -1];
  }
  // 已经都是等于区域，由于用R做划分返回R位置
  if (L === R) {
    return [L, R];
  }
  let less = L - 1; // <区 右边界
  let more = R; // >区 左边界
  let index = L;
  while (index < more) {
    // 当前位置，不能和>区的左边界撞上
    if (arr[index] == arr[R]) {
      index++;
      // 小于交换当前值和左边界的值
    } else if (arr[index] < arr[R]) {
      // swap(arr, index++, ++less);
      // less++
      // index++
      swap(arr, index++, ++less);
      // 大于右边界的值
    } else {
      swap(arr, index, --more);
    }
  }
  swap(arr, more, R);
  return [less + 1, more];
}
```

## **堆排序**

> 一句话：是一种基于「堆结构」实现的高效排序算法

测试链接：https://leetcode.cn/problems/sort-an-array/description/

```
// 从底到顶建立大根堆，O(n)
// 依次弹出堆内最大值并排好序，O(n * logn)
// 整体时间复杂度O(n * logn)
function heapSort(arr) {
  let n = arr.length;
  for (let i = n - 1; i >= 0; i--) {
    heapify(arr, i, n);
  }
  let size = n;
  while (size > 1) {
    swap(arr, 0, --size);
    heapify(arr, 0, size);
  }
  return arr;
}
// i位置的数，变小了，又想维持大根堆结构
// 向下调整大根堆
// 当前堆的大小为size
function heapify(arr, i, size) {
  let l = i * 2 + 1;
  while (l < size) {
    // 有左孩子，l
    // 右孩子，l+1
    // 评选，最强的孩子，是哪个下标的孩子
    let best = l + 1 < size && arr[l + 1] > arr[l] ? l + 1 : l;
    // 上面已经评选了最强的孩子，接下来，当前的数和最强的孩子之前，最强下标是谁
    best = arr[best] > arr[i] ? best : i;
    if (best == i) {
      break;
    }
    swap(arr, best, i);
    i = best;
    l = i * 2 + 1;
  }
}
```



## **希尔排序**

> 一句话：将整个数组切按照一定的间隔取值划分为若干个子数组，每个子数组分别进行插入排序。然后逐渐缩小间隔进行下一轮划分子数组和对子数组进行插入排序。直至最后一轮排序间隔为 1，对整个数组进行插入排序。是插入排序的一种高速而稳定的改进版本。

```
function shellSort(arr) {
  //增量gap，并逐步缩小增量
  for (let gap = arr.length / 2; gap > 0; gap /= 2) {
    //从第gap个元素，逐个对其所在组进行直接插入排序操作
    for (let i = gap; i < arr.length; i++) {
      let j = i;
      while (j - gap >= 0 && arr[j] < arr[j - gap]) {
        //插入排序采用交换法
        swap(arr, j, j - gap);
        j -= gap;
      }
    }
  }
  return arr;
}
```

## **计数排序**

> 一句话：通过统计元素数量来实现排序，通常应用于整数数组。

```
function countingSort(arr) {
  // 1. 统计数组最大元素 m
  let m = 0;
  for (const num of arr) {
    m = Math.max(m, num);
  }
  // 2. 统计各数字的出现次数
  // counter[num] 代表 num 的出现次数
  const counter = new Array(m + 1).fill(0);
  for (const num of arr) {
    counter[num]++;
  }
  // 3. 遍历 counter ，将各元素填入原数组 arr
  let i = 0;
  for (let num = 0; num < m + 1; num++) {
    for (let j = 0; j < counter[num]; j++, i++) {
      arr[i] = num;
    }
  }
  return arr;
}
```



## **桶排序**

> 一句话：是分治策略的一个典型应用。它通过设置一些具有大小顺序的桶，每个桶对应一个数据范围，将数据平均分配到各个桶中；然后，在每个桶内部分别执行排序；最终按照桶的顺序将所有数据合并。
>
> 前述几种排序算法都属于“基于比较的排序算法”，它们通过比较元素间的大小来实现排序。

## **基数排序**

# 查找算法

# 数组

# 字符串

# 链表

# 哈希表

# 栈

# 队列

# 树

# 递归

# 回溯

# 堆

# 图

