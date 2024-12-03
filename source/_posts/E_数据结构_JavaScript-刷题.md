---
title: JavaScript-刷题
date: 2024-05-05 06:33:16
categories:
- E_数据结构
toc: true # 是否启用内容索引

---

# 大纲

- [《代码随想录》](https://github.com/fuyunjinglong/leetcode-master)
- [《算法通关手册》](https://github.com/fuyunjinglong/LeetCode-Py)
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

```js
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

### 荷兰国旗问题

题目1：给定一个包含红色、白色和蓝色、共 `n` 个元素的数组 `nums` ，原地对它们进行排序，使得相同颜色的元素相邻，并按照红色、白色、蓝色顺序排列。

我们使用整数 `0`、 `1` 和 `2` 分别表示红色、白色和蓝色。输入：nums = [2,0,2,1,1,0]输出：[0,0,1,1,2,2]

```
题目1：荷兰国旗问题(颜色分类)
测试链接：https://leetcode.cn/problems/sort-colors/description/
// 解法1：利用快排的子函数partition实现
function sortColors (nums) {
  return  partition(nums, 0, nums.length - 1, 1)
};

function partition(arr, l, r, x) {
// 将小于x的放左边，大于x的放右边
  let first = l;
  let last = r;
  let i = l;
  while (i <= last) {
    if (arr[i] == x) {
      i++;
    } else if (arr[i] < x) {
      swap(arr, first++, i++);
    } else {
      swap(arr, i, last--);
    }
  }
  return arr;
}

// 解法2：刷腻子
function sortColors(nums) {
  let n0 = 0,
    n1 = 0;
  for (let i = 0; i < nums.length; i++) {
    let num = nums[i];
    // 先刷22222222222 先全变成2
    nums[i] = 2;
    // 再刷11111122222 再变成1
    if (num < 2) {
      nums[n1++] = 1;
    }
    // 再刷00011122222 再变成0
    if (num < 1) {
      nums[n0++] = 0;
    }
  }
  return nums;
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

经常看到在有序数组上，开展二分搜索。但有序是所有问题使用二分的必要条件吗？不是，只要能**正确构建左右两侧的淘汰逻辑**，就可以用二分。

- 题目1：在一个有序数组中，找某个数是否存在。
- 题目2：在一个有序数组中，找>=某个数最左侧的位置
- 题目3：在一个有序数组中，找<=某个数最右侧的位置
- 题目4：局部最小值问题即寻找局部波谷值。无序数组，任意两个相邻的数不相等，返回一个局部最小值。注意：这个局部最小值可能有多个，只要找到一个就可以。
- 题目5：局部最大值问题即寻找局部波峰值。同局部最小值
- 题目6：在特殊数组为山脉数组中，找到匹配目标值对应的下标索引值中的最小的那个返回。

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

// 题目2和题目3：在一个有序数组中，找>=某个数最左/右侧的位置，flag为true表示最左，false表示最右
// 测试链接：类似https://leetcode.cn/problems/find-first-and-last-position-of-element-in-sorted-array/
function nearFarIndex(arr, value, flag = true) {
  let L = 0;
  let R = arr.length - 1;
  let index = -1; // 记录最左的对号
  // 相当于，在大于等于value区域，一直往左收缩，直到index左边没有数为止
  while (L <= R) {
    // 至少一个数的时候
    let mid = L + ((R - L) >> 1);
    const a = flag ? arr[mid] >= value : arr[mid] <= value;
    if (a) {
      // 记录mid,往左收缩，或往右收缩
      index = mid;
      flag ? (R = mid - 1) : (L = mid + 1);
    } else {
      // 往右收缩
      flag ? (L = mid + 1) : (R = mid - 1);
    }
  }
  return index;
}

// 题目4:局部最小值问题即寻找局部波谷值
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

// 题目5：局部最大值问题即寻找局部波峰值
// 测试链接：https://leetcode.cn/problems/find-peak-element/
// 测试链接：https://leetcode.cn/problems/peak-index-in-a-mountain-array/description/
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

// 题目6：在特殊数组为山脉数组中，找到匹配目标值对应的下标索引值中的最小的那个返回。
// 测试链接：https://leetcode.cn/problems/find-in-mountain-array/description/
function findInMountainArray(arr,target) {
  let peek = -1,
    n = mountainArr.length();
  let l = 1,
    r = n - 1;
  //寻找峰值
  while (l < r) {
    let mid = (l + r) >> 1;
    if (mountainArr.get(mid) > mountainArr.get(mid + 1)) r = mid;
    else l = mid + 1;
  }

  r = peek = l;
  l = 0;

  //左区间寻找
  while (l < r) {
    let mid = (l + r) >> 1;
    if (mountainArr.get(mid) >= target) r = mid;
    else l = mid + 1;
  }
  if (mountainArr.get(l) == target) return l;

  //右区间寻找
  l = peek;
  r = n - 1;
  while (l < r) {
    let mid = (l + r) >> 1;
    if (mountainArr.get(mid) <= target) r = mid;
    else l = mid + 1;
  }

  if (mountainArr.get(l) == target) return l;
  else return -1;
}
```

题目：在排序数组中查找元素的第一个和最后一个位置

```
// 题目:在排序数组中查找元素的第一个和最后一个位置
// 测试链接：https://leetcode.cn/problems/find-first-and-last-position-of-element-in-sorted-array/
function searchRange(arr, target) {
  let left = nearFarIndex(arr, target);
  let right = nearFarIndex(arr, target, false);
  if (arr[left] !== target) {
    left = -1;
  }
  if (arr[right] !== target) {
    right = -1;
  }
  return [left, right];
}

// 在一个有序数组中，找>=某个数最左/右侧的位置，flag为true表示最左，false表示最右
function nearFarIndex(arr, value, flag = true) {
  let L = 0;
  let R = arr.length - 1;
  let index = -1; // 记录最左的对号
  // 相当于，在大于等于value区域，一直往左收缩，直到index左边没有数为止
  while (L <= R) {
    // 至少一个数的时候
    let mid = L + ((R - L) >> 1);
    const a = flag ? arr[mid] >= value : arr[mid] <= value;
    if (a) {
      // 记录mid,往左收缩，或往右收缩
      index = mid;
      flag ? (R = mid - 1) : (L = mid + 1);
    } else {
      // 往右收缩
      flag ? (L = mid + 1) : (R = mid - 1);
    }
  }
  return index;
}
```



## 二分查找题目

**二分下标题目**

- [猜数字大小](https://leetcode.cn/problems/guess-number-higher-or-lower/)
- [搜索插入位置](https://leetcode.cn/problems/search-insert-position/)
- [寻找旋转排序数组中的最小值](https://leetcode.cn/problems/find-minimum-in-rotated-sorted-array/)
- [寻找旋转排序数组中的最小值 II](https://leetcode.cn/problems/find-minimum-in-rotated-sorted-array-ii/)
- [搜索旋转排序数组](https://leetcode.cn/problems/search-in-rotated-sorted-array/)
- [搜索旋转排序数组 II](https://leetcode.cn/problems/search-in-rotated-sorted-array-ii/)
- [第一个错误的版本](https://leetcode.cn/problems/first-bad-version/)
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

**数组操作题目**

- [轮转数组](https://leetcode.cn/problems/rotate-array/)
- [加一](https://leetcode.cn/problems/plus-one/)
- [寻找数组的中心下标](https://leetcode.cn/problems/find-pivot-index/)
- [最大连续 1 的个数](https://leetcode.cn/problems/max-consecutive-ones/)
- [除自身以外数组的乘积](https://leetcode.cn/problems/product-of-array-except-self/)

**二维数组题目**

- [对角线遍历](https://leetcode.cn/problems/diagonal-traverse/)
- [旋转图像](https://leetcode.cn/problems/rotate-image/)
- [矩阵置零](https://leetcode.cn/problems/set-matrix-zeroes/)
- [螺旋矩阵](https://leetcode.cn/problems/spiral-matrix/)
- [螺旋矩阵 II](https://leetcode.cn/problems/spiral-matrix-ii/)
- [生命游戏](https://leetcode.cn/problems/game-of-life/)

## 双指针

题目：两数之和。在一个非降序数组(升序数组）中，找出满足相加之和等于目标数 target 的两个数

```
// 题目：两数之和。在一个非降序数组(升序数组）中，找出满足相加之和等于目标数 target 的两个数
// 测试链接：https://leetcode.cn/problems/two-sum-ii-input-array-is-sorted/description/
// 解法一：通过二分法
function twoSum(numbers, target) {
  for (let i = 0; i < numbers.length; ++i) {
    let low = i + 1;
    let high = numbers.length - 1;
    while (low <= high) {
      let mid = low + ((high - low) >> 1);
      if (numbers[i]+numbers[mid] == target  ) {
        return [i + 1, mid + 1];
      } else if (numbers[i]+numbers[mid] > target) {
        high = mid - 1;
      } else {
        low = mid + 1;
      }
    }
  }
  return [-1, -1];
}

// 解法二：双指针法
function twoSum(numbers, target) {
  let low = 0,
    high = numbers.length - 1;
  while (low < high) {
    let sum = numbers[low] + numbers[high];
    if (sum == target) {
      return [low + 1, high + 1];
    } else if (sum < target) {
      ++low;
    } else {
      --high;
    }
  }
  return [-1, -1];
}

// 解法三：二分结合双指针
function twoSum(numbers, target) {
  let i = 0;
  let j = numbers.length - 1;
  while (i < j) {
    let m = (i + j) >>> 1;
    if (numbers[i] + numbers[m] > target) {
      j = m - 1;
    } else if (numbers[m] + numbers[j] < target) {
      i = m + 1;
    } else if (numbers[i] + numbers[j] > target) {
      j--;
    } else if (numbers[i] + numbers[j] < target) {
      i++;
    } else {
      return [i + 1, j + 1];
    }
  }
  return [0, 0];
}
```

题目：三数之和。给你一个整数数组 `nums` ，判断是否存在三元组 `[nums[i], nums[j], nums[k]]` 满足 `i != j`、`i != k` 且 `j != k` ，同时还满足 `nums[i] + nums[j] + nums[k] == 0` 。请你返回所有和为 `0` 且不重复的三元组。

```
// 排序+双指针
算法流程：
1.特判，对于数组长度 n，如果数组为 null 或者数组长度小于 3，返回 []。
2.对数组进行排序。
3.遍历排序后数组：
3.1若 nums[i]>0：因为已经排序好，所以后面不可能有三个数加和等于 0，直接返回结果。
3.2对于重复元素：跳过，避免出现重复解
3.3令左指针 L=i+1，右指针 R=n−1，当 L<R 时，执行循环：
 a.当 nums[i]+nums[L]+nums[R]==0，执行循环，判断左界和右界是否和下一位置重复，去除重复解。并同时将 L,R 移到下一位置，寻找新的解
 b.若和大于 0，说明 nums[R] 太大，R 左移
 c.若和小于 0，说明 nums[L] 太小，L 右移

function threeSum  (nums) {
    // 题目提到数组的 length 至少为3, 就不做边界处理了
    let result = [];
    // 原数组先原地排序
    nums.sort((a, b) => a - b);

    for (let i = 0; i < nums.length - 2; i++) {
        let first = nums[i]; // 第一个元素
        if (first > 0) break; // 第一个元素大于0了, 剩余的元素之和肯定也大于0
        if (i > 0 && first === nums[i - 1]) continue;
        let L = i + 1 //第二个元素下标
        let R = nums.length - 1; // 第三个元素下标

        while (L < R) {
            const sum = first + nums[L] + nums[R]
            if (sum === 0) {
                result.push([first, nums[L], nums[R]])
                // 继续看L 的右边和 R 的左边, 是不是重复
                while (L < R && nums[L] === nums[L + 1]) {
                    L = L + 1
                }
                while (L < R && nums[R] === nums[R - 1]) {
                    R = R - 1
                }
                // 移动 L 和 R
                L = L + 1
                R = R - 1
            } else if (sum > 0) {
                // 大于0, 说明第三个元素太大了
                R = R - 1
            } else {
                // 小于0, 说明第二个元素太小了
                L = L + 1
            }
        }
    }

    return result;
};

```

题目2：数组中的第K个最大元素

```
题目2：数组中的第K个最大元素
测试链接：https://leetcode.cn/problems/kth-largest-element-in-an-array/description/
// 利用荷兰国旗问题求解
function findKthLargest(nums, k) {
  return randomizedSelect(nums, nums.length - k);
}

let first, last;
// 如果arr排序的话，在i位置的数字是什么
function randomizedSelect(arr, i) {
  let ans = 0;
  for (let l = 0, r = arr.length - 1; l <= r; ) {
    // 随机这一下，常数时间比较大
    // 但只有这一下随机，才能在概率上把时间复杂度收敛到O(n)
    partition(arr, l, r, arr[l + parseInt(Math.random() * (r - l + 1))]);
    // 因为左右两侧只需要走一侧
    // 所以不需要临时变量记录全局的first、last
    // 直接用即可
    if (i < first) {
      r = first - 1;
    } else if (i > last) {
      l = last + 1;
    } else {
      ans = arr[i];
      break;
    }
  }
  return ans;
}

function partition(arr, l, r, x) {
  first = l;
  last = r;
  let i = l;
  while (i <= last) {
    if (arr[i] == x) {
      i++;
    } else if (arr[i] < x) {
      swap(arr, first++, i++);
    } else {
      swap(arr, i, last--);
    }
  }
}
```



## 双指针题目

**对撞指针**

- [ 两数之和 II - 输入有序数组](https://leetcode.cn/problems/two-sum-ii-input-array-is-sorted/)
- [三数之和](https://leetcode.cn/problems/3sum/)
- [反转字符串](https://leetcode.cn/problems/reverse-string/)
- [反转字符串中的元音字母](https://leetcode.cn/problems/reverse-vowels-of-a-string/)
- [验证回文串](https://leetcode.cn/problems/valid-palindrome/)
- [盛最多水的容器](https://leetcode.cn/problems/container-with-most-water/)
- [有效三角形的个数](https://leetcode.cn/problems/valid-triangle-number/)
- [最接近的三数之和](https://leetcode.cn/problems/3sum-closest/)
- [四数之和](https://leetcode.cn/problems/4sum/)
- [较小的三数之和](https://leetcode.cn/problems/3sum-smaller/)
- [找到 K 个最接近的元素](https://leetcode.cn/problems/find-k-closest-elements/)
- [小于 K 的两数之和](https://leetcode.cn/problems/two-sum-less-than-k/)
- [颜色分类](https://leetcode.cn/problems/sort-colors/)
- [有序转化数组](https://leetcode.cn/problems/sort-transformed-array/)
- [有序数组的平方](https://leetcode.cn/problems/squares-of-a-sorted-array/)
- [救生艇](https://leetcode.cn/problems/boats-to-save-people/)
- [接雨水](https://leetcode.cn/problems/trapping-rain-water/)
- [压缩字符串](https://leetcode.cn/problems/string-compression/)

**快慢指针**

- [删除有序数组中的重复项](https://leetcode.cn/problems/remove-duplicates-from-sorted-array/)
- [删除有序数组中的重复项 II](https://leetcode.cn/problems/remove-duplicates-from-sorted-array-ii/)
- [移除元素](https://leetcode.cn/problems/remove-element/)
- [移动零](https://leetcode.cn/problems/move-zeroes/)
- [数组中的最长山脉](https://leetcode.cn/problems/longest-mountain-in-array/)
- [合并两个有序数组](https://leetcode.cn/problems/merge-sorted-array/)
- [找出第 K 小的数对距离](https://leetcode.cn/problems/find-k-th-smallest-pair-distance/)
- [递增的三元子序列](https://leetcode.cn/problems/increasing-triplet-subsequence/)
- [最长湍流子数组](https://leetcode.cn/problems/longest-turbulent-subarray/)
- [调整数组顺序使奇数位于偶数前面](https://leetcode.cn/problems/diao-zheng-shu-zu-shun-xu-shi-qi-shu-wei-yu-ou-shu-qian-mian-lcof/)

**分离双指针**

- [两个数组的交集 II](https://leetcode.cn/problems/intersection-of-two-arrays-ii/)
- [长按键入](https://leetcode.cn/problems/long-pressed-name/)
- [比较含退格的字符串](https://leetcode.cn/problems/backspace-string-compare/)
- [安排会议日程](https://leetcode.cn/problems/meeting-scheduler/)
- [字符串相加](https://leetcode.cn/problems/add-strings/)
- [判断子序列](https://leetcode.cn/problems/is-subsequence/)

# 字符串

## 模式匹配

**1.单模式串匹配问题**

> **单模式匹配问题（Single Pattern Matching）**：给定一个文本串 T=t1t2...tn，再给定一个特定模式串 p=p1p2...pn。要求从文本串 T 找出特定模式串 p 的所有出现位置。

有很多算法可以解决单模式匹配问题。而根据在文本中搜索模式串方式的不同，我们可以将单模式匹配算法分为以下几种：

- **基于前缀搜索方法**：在搜索窗口内从前向后（沿着文本的正向）逐个读入文本字符，搜索窗口中文本和模式串的最长公共前缀。
  - 著名的「Knuth-Morris-Pratt (KMP) 算法」和更快的「Shift-Or 算法」使用的就是这种方法。
- **基于后缀搜索方法**：在搜索窗口内从后向前（沿着文本的反向）逐个读入文本字符，搜索窗口中文本和模式串的最长公共后缀。使用这种搜索算法可以跳过一些文本字符，从而具有亚线性的平均时间复杂度。
  - 最著名的「Boyer-Moore 算法」，以及「Horspool 算法」、「Sunday（Boyer-Moore 算法的简化）算法」都使用了这种方法。
- **基于子串搜索方法**：在搜索窗口内从后向前（沿着文本的反向）逐个读入文本字符，搜索满足「既是窗口中文本的后缀，也是模式串的子串」的最长字符串。与后缀搜索方法一样，使用这种搜索方法也具有亚线性的平均时间复杂度。这种方法的主要缺点在于需要识别模式串的所有子串，这是一个非常复杂的问题。
  - 「Rabin-Karp 算法」、「Backward Dawg Matching（BDM）算法」、「Backward Nondeterministtic Dawg Matching（BNDM）算法」和 「Backward Oracle Matching（BOM）算法」 使用的就是这种思想。其中，「Rabin-Karp 算法」使用了基于散列的子串搜索算法。

**2.多模式串匹配问题**

> **多模式匹配问题（Multi Pattern Matching）**：给定一个文本串 T=t1t2...tn，再给定一组模式串 P=p1,p2,...,pr，其中每个模式串 pi 是定义在有限字母表上的字符串 pi=p1ip2i...pni。要求从文本串 T 中找到模式串集合 P 中所有模式串 pi 的所有出现位置。

模式串集合 P 中的一些字符串可能是集合中其他字符串的子串、前缀、后缀，或者完全相等。解决多模式串匹配问题最简单的方法是利用「单模式串匹配算法」搜索 r 遍。这将导致预处理阶段的最坏时间复杂度为 O(|P|)，搜索阶段的最坏时间复杂度为 O(r×n)。

如果使用「单模式串匹配算法」解决多模式匹配问题，那么根据在文本中搜索模式串方式的不同，我们也可以将多模式串匹配算法分为以下三种：

- **基于前缀搜索方法**：搜索从前向后（沿着文本的正向）进行，逐个读入文本字符，使用在P上构建的自动机进行识别。对于每个文本位置，计算既是已读入文本的后缀，同时也是P中某个模式串的前缀的最长字符串。
  - 著名的 「Aho-Corasick Automaton（AC 自动机）算法」、「Multiple Shift-And 算法」使用的这种方法。
- **基于后缀搜索方法**：搜索从后向前（沿着文本的反向）进行，搜索模式串的后缀。根据后缀的下一次出现位置来移动当前文本位置。这种方法可以避免读入所有的文本字符。
  - 「Commentz-Walter（Boyer-Moore 算法的扩展算法）算法」 、「Set Horspool（Commentz-Walter 算法的简化算法）算法」、「Wu-Manber 算法」都使用了这种方法。
- **基于子串搜索方法**：搜索从后向前（沿着文本的反向）进行，在模式串的长度为min(len(pi))的前缀中搜索子串，以此决定当前文本位置的移动。这种方法也可以避免读入所有的文本字符。
  - 「Multiple BNDM 算法」、「Set Backward Dawg Matching（SBDM）算法」、「Set Backwrad Oracle Matching（SBOM）算法」都使用了这种方法。

需要注意的是，以上所介绍的多模式串匹配算法大多使用了一种基本的数据结构：**「字典树（Trie Tree）」**。著名的 **「Aho-Corasick Automaton (AC 自动机) 算法」** 就是在「KMP 算法」的基础上，与「字典树」结构相结合而诞生的。而「AC 自动机算法」也是多模式串匹配算法中最有效的算法之一。

所以学习多模式匹配算法，重点是要掌握 **「字典树」** 和 **「AC 自动机算法」** 。

## KMP算法

>  KMP的主要思想是**当出现字符串不匹配时，可以知道一部分之前已经匹配的文本内容，可以利用这些信息避免从头再去做匹配了。**
>
>  KMP算法核心：分2步走，s为主串，m为模板串。其中核心是**getNextArray**求解的过程
>
>  第一步：求解数组中模板串的最长公共前后缀的长度值(数组的值表示索引前的字符串存在的最长前缀与最长后缀相等的长度)
>
>  第二步：主串和模板串比较，采用不进行主串回溯的比较方法，通过右移模版串快速高效匹配。

题目：找出字符串中第一个匹配项的下标

```js
// 题目：找出字符串中第一个匹配项的下标(可能有多处，返回第一处的索引就行)
// 测试链接：https://leetcode.cn/problems/find-the-index-of-the-first-occurrence-in-a-string/description/?envType=problem-list-v2&envId=string
function getIndexOf(s, m) {
  // s是主串,m是子串既模式串
  if (s == null || m == null || m.length < 1 || s.length < m.length) {
    return -1;
  }
  //下面就是KMP算法的全部步骤
  let str1 = s.split("");
  let str2 = m.split("");
  let i1 = 0;
  let i2 = 0;
  // 第一步：求解数组中模板串的最长公共前后缀的长度值(数组的值表示索引前的字符串存在的最长前缀与最长后缀相等的长度)
  let next = getNextArray(str2);
  // 第二步：主串和模板串比较，采用不进行主串回溯的比较方法，通过右移模版串快速高效匹配。
  while (i1 < str1.length && i2 < str2.length) {
    if (str1[i1] == str2[i2]) {
      // a.主串和模板串值相同，则继续后移比较
      i1++;
      i2++;
      //-1为起始位置
    } else if (next[i2] == -1) {
      // c.-1表示模板串的指针到首位了，则主串继续后移
      i1++;
    } else {
      // b.出现值不等时，则子串后移，该指针继续回溯往前比较，索引值一定是减小相当于模板串后移
      // 这里碰巧使用了next数组的特性，通过移动到某一个值，达到子串快速移动，忽略掉主串中不会匹配的串。
      // 为什么可以快速移动？反证法：假如中间出现了匹配上的情况，则主串的k...i1和子串前缀相等，
      // 同时i1和i2是对其的，表示k...i1和子串的后缀是对应的，结果就是子串发现了新的最长公共前后缀，与我们定义的数组矛盾。
      i2 = next[i2];
    }
  }
  // 跳出while循环只有两种可能：i1越界或i2越界
  // 如果i2越界，则说明找到了，则索引开始处为i2-i1
  // 如果i1越界，则说明没找到
  return i2 == str2.length ? i1 - i2 : -1;
}
// 大多数题目这个才是关键
function getNextArray(str2) {
  // 求解数组中模板串的最长公共前后缀的长度值(数组的值表示索引前的字符串存在的最长前缀与最长后缀相等的长度)
  /*
  首先确定好第i-1个位置上的匹配长度L
  第i位置匹配长度判断时，需要判断第i-1位置上匹配长度中前半段cn下标的字符和第i-1位置上的字符进行比较
  如果相等则第i位置匹配长度为L+1
  如果不相等将前半段cn的匹配长度读出，再分出cn的前半段，与i-1继续比较
  如果以上都不满足，则表示值不匹配且cn为0(前面没有最长公共前缀)，那么i位置一定也是为0。
  */
  if (str2.length == 1) {
    return [-1];
  }
  let next = new Array(str2.length);
  next[0] = -1;
  next[1] = 0;
  // 目前下标在哪个位置上求的next数组的值
  let i = 2;
  // cn代表前缀的下一个下标，也代表匹配的前后缀的最大长度
  // 因为i=2时，就是比较0和1的值是否相等,0就是cn,1就是i-1
  let cn = 0;
  while (i < next.length) {
    //如果前缀的下一个下标值和i-1的值相等，则i位置的值就是i-1位置值加1
    if (str2[cn] === str2[i - 1]) {
      // 先移动了cn位置，同时cn+1赋给了i位置上，同时i继续递增遍历
      next[i++] = ++cn;
    } else if (cn > 0) {
      // 如果不相等，同时cn需要找上一个最长串，但要保证cn还能递归跳即cn>0
      cn = next[cn];
    } else {
      // 如果cn<=0，前面没有最长串，同时又不相等，则直接计算为0，同时i继续递增遍历
      next[i++] = 0;
    }
  }
  return next;
}
```

题目：最长公共前缀

```
// 题目：最长公共前缀
// 测试链接：https://leetcode.cn/problems/longest-common-prefix/
function longestCommonPrefix(strs) {
  var re = "";
  if (!strs.length) return re;
  for (var j = 0; j < strs[0].length; j++) {
    //第j位
    for (var i = 1; i < strs.length; i++) {
      //第i个
      // 如果中间发现有字符不相等，则直接跳出双层循环，返回最长公共前缀
      if (strs[i][j] != strs[0][j]) return re;
    }
    // 只要还相等，则继续累计下去
    re += strs[0][j];
  }
  // 假如第一个就是最长公共前缀，则直接返回
  return re;
}
```

题目：验证回文串

```
// 题目：验证回文串
// 测试链接：https://leetcode.cn/problems/valid-palindrome/description/
// 第一步：使用正则替换掉所有非字母、数字还有空格，用toLowerCase()将字符串转换成小写
// 第二步：将字符串转化成数组，用reverse()颠倒元素顺序，再用join()将其转换成字符串于原字符串进行对比
function isPalindrome(s) {
    //先替换掉所有非字母和数字
    //再替换掉所有的空格
    //然后后reverse()方法颠倒顺序
    //最后两者进行对比
     s=s.replace(/[^a-zA-Z0-9]/g,"").replace(/\s/g,"").toLowerCase();
     return s===[...s].reverse().join("")
}
```



## 题目

- [验证回文串](https://leetcode.cn/problems/valid-palindrome/)
- [最长公共前缀](https://leetcode.cn/problems/longest-common-prefix/)
- [最长回文子串](https://leetcode.cn/problems/longest-palindromic-substring/)
- [无重复字符的最长子串](https://leetcode.cn/problems/longest-substring-without-repeating-characters/)
- [反转字符串](https://leetcode.cn/problems/reverse-string/)
- [反转字符串中的单词 III](https://leetcode.cn/problems/reverse-words-in-a-string-iii/)
- [字母异位词分组](https://leetcode.cn/problems/group-anagrams/)
- [字符串相加](https://leetcode.cn/problems/add-strings/)
- [反转字符串中的单词](https://leetcode.cn/problems/reverse-words-in-a-string/)
- [字符串相乘](https://leetcode.cn/problems/multiply-strings/)

# 链表

## 题目

- [回文链表](https://leetcode.cn/problems/palindrome-linked-list/)
- [设计链表](https://leetcode.cn/problems/design-linked-list/)
- [删除排序链表中的重复元素](https://leetcode.cn/problems/remove-duplicates-from-sorted-list/)
- [删除排序链表中的重复元素 II](https://leetcode.cn/problems/remove-duplicates-from-sorted-list-ii/)
- [反转链表](https://leetcode.cn/problems/reverse-linked-list/)
- [ 反转链表 II](https://leetcode.cn/problems/reverse-linked-list-ii/)
- [K 个一组翻转链表](https://leetcode.cn/problems/reverse-nodes-in-k-group/)
- [移除链表元素](https://leetcode.cn/problems/remove-linked-list-elements/)
- [奇偶链表](https://leetcode.cn/problems/odd-even-linked-list/)
- [扁平化多级双向链表](https://leetcode.cn/problems/flatten-a-multilevel-doubly-linked-list/)
- [复制带随机指针的链表](https://leetcode.cn/problems/copy-list-with-random-pointer/)
- [旋转链表](https://leetcode.cn/problems/rotate-list/)

# 哈希表

# 栈

# 队列

# 树

# 递归

# 回溯

# 堆

# 图

