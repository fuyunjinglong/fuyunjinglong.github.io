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
- [基本算法题汇总](https://github.com/fuyunjinglong/leetcode-master/blob/master/problems/0001.%E4%B8%A4%E6%95%B0%E4%B9%8B%E5%92%8C.md)
- [基本算法题汇总-video](https://www.bilibili.com/video/BV1aT41177mK/?vd_source=bd4c7d99d71adf64d6e88c65370e0247)

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

## **冒泡排序**-傻O(N^2)

> 一句话：通过相邻元素之间的比较与交换，把当前最大的泡泡冒泡到水面/右区间
>
> - 数组元素想象成泡泡
> - 从左到右依次比较，如果左侧泡泡比右侧泡泡大，则交换。[0,i]
> - 这1趟完，最大泡泡就在最右侧。然后循环。[0-,j]

```
// 测试链接 : https://leetcode.cn/problems/sort-an-array/
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

## **选择排序**-傻O(N^2)

> 一句话：数组分两个区间，左侧为已排序区间，右侧为未排序区间。每次从未排序区间找到最小值放到左区间末尾。
>
> - 数组分为左右两个区间：左边是已排序区间，右边是未排序区间。
> - 遍历右区间，找到最小值，并放到左区间末尾
> - 这一趟完，最小值出现在左区间最左侧。然后循环

```
// 测试链接 : https://leetcode.cn/problems/sort-an-array/
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

## 插入排序-傻O(N^2)

> 一句话：将数组分为两个区间：左侧为有序区间，右侧为无序区间。每趟从无序区间取出一个元素，然后将其插入到有序区间的适当位置。类似打扑克牌

```
// 测试链接 : https://leetcode.cn/problems/sort-an-array/
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

## **快速排序**-O(N*logN)

> 一句话：采用经典的分治策略，选择数组中某个元素作为基准数，通过一趟排序将数组分为独立的两个子数组，一个子数组中所有元素值都比基准数小，另一个子数组中所有元素值都比基准数大。然后再按照同样的方式递归的对两个子数组分别进行快速排序，以达到整个数组有序。

```
// 测试链接 : https://leetcode.cn/problems/sort-an-array/
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

## 归并排序-O(N*logN)

> 一句话：采用经典的分治策略，先递归地将当前数组平均分成两半，然后将有序数组两两合并，最终合并成一个有序数组。

```
// 测试链接 : https://leetcode.cn/problems/sort-an-array/
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

## **堆排序**--O(N*logN)

> 一句话：是一种基于「堆结构」实现的高效排序算法

```
// 从底到顶建立大根堆，O(n)
// 依次弹出堆内最大值并排好序，O(n * logn)
// 整体时间复杂度O(n * logn)
// 测试链接 : https://leetcode.cn/problems/sort-an-array/
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
>
> 1、设定初始步长，按照步长比较元素大小并交换
> 2、步长减一，比较元素大小并交换

```
// 测试链接 : https://leetcode.cn/problems/sort-an-array/
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

## **桶排序**-O(N)

> 一句话：是分治策略的一个典型应用。它通过设置一些具有大小顺序的桶，每个桶对应一个数据范围，将数据平均分配到各个桶中；然后，在每个桶内部分别执行排序（使用插入排序、归并排序、快排排序等算法）；最终按照桶的顺序将所有数据合并。
>
> 桶排序、计数排序、基数排序都是线性排序，都是非基于比较的排序算法，都不涉及元素之间的比较操作。

```
function bucketSort(arr) {
  let max = Math.max(...arr);
  let min = Math.min(...arr);
  // 桶的数量 = （最大值 - 最小值）/ 数组长度 + 1。
  let bucketNum = parseInt((max - min) / arr.length) + 1;
  let bucketArr = new Array(bucketNum);
  for (var i = 0; i < bucketNum; i++) {
    bucketArr[i] = new Array();
  }
  // 元素位置 =（ 元素大小 - 最小值）/ 数组长度
  for (let i of arr) {
    let num = parseInt((i - min) / arr.length);
    bucketArr[num].push(i);
  }
  // 使用系统自带的快排
  for (let i of bucketArr) {
    i.sort();
  }
  let k = 0;
  // 最后合并
  for (let i = 0; i < bucketArr.length; i++) {
    for (let j = 0; j < bucketArr[i].length; j++) {
      arr[k++] = bucketArr[i][j];
    }
  }
  return arr;
}
```

## **计数排序**-O(N)

> 一句话：通过统计元素数量来实现排序，通常应用于正整数数组。
>
> 适用于数据量 n 较大但数据范围 m 较小的情况。
>
> 1、建立0-M号桶
> 2、把元素按大小放入对应桶
> 3、依次把0-M号桶中的元素倒出

```
// 测试链接 : https://leetcode.cn/problems/sort-an-array/
function countSort(arr) {
  if (arr == null || arr.length < 2) {
    return;
  }
  let max = Math.max(...arr);
  let bucket = new Array(max + 1).fill(0);
  for (let i = 0; i < arr.length; i++) {
    bucket[arr[i]]++;
  }
  let i = 0;
  for (let j = 0; j < bucket.length; j++) {
    while (bucket[j]-- > 0) {
      arr[i++] = j;
    }
  }
  return arr;
}
```

## **基数排序**-O(N)

> 1、准备0-9号桶
> 2、元素按个位数放入对应桶
> 3、依次把0-9号桶中的元素倒出（先进先出），成为序列
> 4、按序列把元素按十位数放入对应桶
>
> 注：计数排序和基数排序都属于桶排序的实现，桶排序是一种排序思想。计数排序必须是非负数组，不是则需要提前转换。

```
// 测试链接 : https://leetcode.cn/problems/sort-an-array/
function radixSort(arr) {
  if (arr == null || arr.length < 2) {
    return;
  }
  // 数组中的每个数字，减去数组中的最小值，就把arr转成了非负数组
  let min = Math.min(...arr);
  for (let i = 0; i < arr.length; i++) {
    // 数组中的每个数字，减去数组中的最小值，就把arr转成了非负数组
    arr[i] -= min;
  }
  handel(arr, 0, arr.length - 1, maxbits(arr));
  // 数组中所有数都减去了最小值，所以最后不要忘了还原
  for (let i = 0; i < arr.length; i++) {
    arr[i] += min;
  }
  return arr;
}

// arr[L..R]排序  ,  最大值的十进制位数digit
function handel(arr, L, R, digit) {
  let radix = 10;
  let i = 0,
    j = 0;
  // 有多少个数准备多少个辅助空间
  let help = new Array(R - L + 1);
  for (let d = 1; d <= digit; d++) {
    // 有多少位就进出几次
    // 10个空间
    // count[0] 当前位(d位)是0的数字有多少个
    // count[1] 当前位(d位)是(0和1)的数字有多少个
    // count[2] 当前位(d位)是(0、1和2)的数字有多少个
    // count[i] 当前位(d位)是(0~i)的数字有多少个
    let count = new Array(radix).fill(0); // count[0..9]
    for (i = L; i <= R; i++) {
      // 103  1   3
      // 209  1   9
      j = getDigit(arr[i], d);
      count[j]++;
    }
    for (i = 1; i < radix; i++) {
      count[i] = count[i] + count[i - 1];
    }
    for (i = R; i >= L; i--) {
      j = getDigit(arr[i], d);
      help[count[j] - 1] = arr[i];
      count[j]--;
    }
    for (i = L, j = 0; i <= R; i++, j++) {
      arr[i] = help[j];
    }
  }
}
// 返回最大值的位数
function maxbits(arr) {
  let max = 0;
  for (let i = 0; i < arr.length; i++) {
    max = Math.max(max, arr[i]);
  }
  let res = 0;
  while (max != 0) {
    res++;
    max /= 10;
  }
  return res;
}

// 返回x这个数在倒数第d位上的数是几
function getDigit(x, d) {
  return (x / parseInt(Math.pow(10, d - 1))) % 10;
}
```

# 数组

## 二分查找

经常看到在有序数组上，开展二分搜索。但有序是所有问题使用二分的必要条件吗？不是，只要能正确构建左右两侧的淘汰逻辑，就可以用二分。

- 题目1:在一个有序数组中，找某个数是否存在。
- 题目2:在一个有序数组中，找>=某个数最左侧的位置
- 题目3:在一个有序数组中，找<=某个数最右侧的位置
- 题目4:局部最小值问题，无序数组，任意两个相邻的数不相等，返回一个局部最小值。注意：这个局部最小值可能有多个，只要找到一个就可以。
- 题目5：局部最大值问题即寻找峰值。

```
// 题目1
// 测试链接：https://leetcode.cn/problems/binary-search/submissions/580111267/
function exist(sortedArr, num) {
  // 默认sortedArr是升序的
  if (sortedArr == null || sortedArr.length == 0) {
    return -1;
  }
  let L = 0;
  let R = sortedArr.length - 1;
  let mid = 0;
  // L..R
  while (L <= R) {
    // 防止溢出 等同于(left + right)/2
    mid = L + ((R - L) >> 1);
    if (sortedArr[mid] == num) {
      return mid;
    } else if (sortedArr[mid] > num) {
      // 因为数组是升序的，中间>num,去左半边查询
      R = mid - 1;
    } else {
      // 去右半边查询
      L = mid + 1;
    }
  }
  // 最终没找到
  return -1;
}

// 题目4:局部最小值问题
function getLessIndex(arr) {
  if (arr == null || arr.length == 0) {
    return -1;
  }
  // 情况1：先看先0位置。如果一个数组(0~1)(0 1)是升序排列，则局部最小值是 0 位置
  if (arr.length == 1 || arr[0] < arr[1]) {
    return 0;
  }
  // 情况2：再看下n-1位置。如果一个数组(n-2, n-1)(n−2,n−1)是降序排列，则局部最小值是 n - 1n−1 位置
  if (arr[arr.length - 1] < arr[arr.length - 2]) {
    return arr.length - 1;
  }
  let left = 1;
  let right = arr.length - 2;
  let mid = 0;
  // 情况3：数组开头向下，结尾向上，那这个局部最小位置一定在中间
  while (left <= right) {
    mid = left + ((right - left) >> 1);
    if (arr[mid] > arr[mid - 1]) {
      left = mid - 1;
    } else if (arr[mid] > arr[mid + 1]) {
      right = mid + 1;
    } else {
      return mid;
    }
  }
  // 这里不需要判断，因为一定有局部最小值或局部最大值
  // return -1;
}

// 测试链接：https://leetcode.cn/problems/find-peak-element/
// 题目5：局部最大值即寻找峰值
function getMoreIndex(arr) {
     if (arr == null || arr.length == 0) {
    return -1;
  }
  // 情况1：先看先0位置。如果一个数组(0~1)(0 1)是升序排列，则局部最大值是 0 位置
  if (arr.length == 1 || arr[0] > arr[1]) {
    return 0;
  }
  // 情况2：再看下n-1位置。如果一个数组(n-2, n-1)(n−2,n−1)是降序排列，则局部最大值是 n - 1n−1 位置
  if (arr[arr.length - 1] > arr[arr.length - 2]) {
    return arr.length - 1;
  }
  let left = 1;
  let right = arr.length - 2;
  let mid = 0;
  // 情况3：数组开头向下，结尾向上，那这个局部最大位置一定在中间
  while (left <= right) {
    mid = left + ((right - left) >> 1);
    if ( arr[mid - 1]>arr[mid]) {
      right = mid -1
    } else if (arr[mid] < arr[mid + 1]) {
      left = mid+1
    } else {
      return mid;
    }
  }
}
```

**二分下标题目**

- [ 二分查找](https://leetcode.cn/problems/binary-search/)
- [猜数字大小](https://leetcode.cn/problems/guess-number-higher-or-lower/)
- [搜索插入位置](https://leetcode.cn/problems/search-insert-position/)
- [在排序数组中查找元素的第一个和最后一个位置](https://leetcode.cn/problems/find-first-and-last-position-of-element-in-sorted-array/)
- [两数之和 II - 输入有序数组](https://leetcode.cn/problems/two-sum-ii-input-array-is-sorted/)
- [寻找旋转排序数组中的最小值](https://leetcode.cn/problems/find-minimum-in-rotated-sorted-array/)
- [寻找旋转排序数组中的最小值 II](https://leetcode.cn/problems/find-minimum-in-rotated-sorted-array-ii/)
- [搜索旋转排序数组](https://leetcode.cn/problems/search-in-rotated-sorted-array/)
- [搜索旋转排序数组 II](https://leetcode.cn/problems/search-in-rotated-sorted-array-ii/)
- [第一个错误的版本](https://leetcode.cn/problems/first-bad-version/)
- [寻找峰值](https://leetcode.cn/problems/find-peak-element/)
- [ 山脉数组的峰顶索引](https://leetcode.cn/problems/peak-index-in-a-mountain-array/)
- [山脉数组中查找目标值](https://leetcode.cn/problems/find-in-mountain-array/)
- [寻找比目标字母大的最小字母](https://leetcode.cn/problems/find-smallest-letter-greater-than-target/)
- [寻找两个正序数组的中位数](https://leetcode.cn/problems/median-of-two-sorted-arrays/)
- [搜索二维矩阵](https://leetcode.cn/problems/search-a-2d-matrix/)
- [搜索二维矩阵 II](https://leetcode.cn/problems/search-a-2d-matrix-ii/)

**二分答案题目**

- [x 的平方根](https://leetcode.cn/problems/sqrtx/)
- [寻找重复数](https://leetcode.cn/problems/find-the-duplicate-number/)
- [Pow(x, n)](https://leetcode.cn/problems/powx-n/)
- [有效的完全平方数](https://leetcode.cn/problems/valid-perfect-square/)
- [ 转变数组后最接近目标值的数组和](https://leetcode.cn/problems/sum-of-mutated-array-closest-to-target/)
- [第 N 位数字](https://leetcode.cn/problems/nth-digit/)

**复杂的二分查找问题**

- [爱吃香蕉的珂珂](https://leetcode.cn/problems/koko-eating-bananas/)
- [分割数组的最大值](https://leetcode.cn/problems/split-array-largest-sum/)
- [长度最小的子数组](https://leetcode.cn/problems/minimum-size-subarray-sum/)
- [找到 K 个最接近的元素](https://leetcode.cn/problems/find-k-closest-elements/)
- [最接近的二叉搜索树值](https://leetcode.cn/problems/closest-binary-search-tree-value/)
- [搜索长度未知的有序数组](https://leetcode.cn/problems/search-in-a-sorted-array-of-unknown-size/)
- [ 两个数组的交集](https://leetcode.cn/problems/intersection-of-two-arrays/)
- [两个数组的交集 II](https://leetcode.cn/problems/intersection-of-two-arrays-ii/)
- [寻找重复数](https://leetcode.cn/problems/find-the-duplicate-number/)
- [找出第 K 小的数对距离](https://leetcode.cn/problems/find-k-th-smallest-pair-distance/)
- [较小的三数之和](https://leetcode.cn/problems/3sum-smaller/)
- [在 D 天内送达包裹的能力](https://leetcode.cn/problems/capacity-to-ship-packages-within-d-days/)
- [制作 m 束花所需的最少天数](https://leetcode.cn/problems/minimum-number-of-days-to-make-m-bouquets/)

## **数组操作题目**

- [二分查找](https://leetcode.cn/problems/binary-search/submissions/)
- [轮转数组](https://leetcode.cn/problems/rotate-array/)
- [加一](https://leetcode.cn/problems/plus-one/)
- [寻找数组的中心下标](https://leetcode.cn/problems/find-pivot-index/)
- [最大连续 1 的个数](https://leetcode.cn/problems/max-consecutive-ones/)
- [除自身以外数组的乘积](https://leetcode.cn/problems/product-of-array-except-self/)

## **二维数组题目**

- [对角线遍历](https://leetcode.cn/problems/diagonal-traverse/)
- [旋转图像](https://leetcode.cn/problems/rotate-image/)
- [矩阵置零](https://leetcode.cn/problems/set-matrix-zeroes/)
- [螺旋矩阵](https://leetcode.cn/problems/spiral-matrix/)
- [螺旋矩阵 II](https://leetcode.cn/problems/spiral-matrix-ii/)
- [生命游戏](https://leetcode.cn/problems/game-of-life/)

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

