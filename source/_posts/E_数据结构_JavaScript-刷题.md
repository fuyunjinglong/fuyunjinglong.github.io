---
title: JavaScript-刷题
date: 2024-05-05 06:33:16
categories:
- E_数据结构
toc: true # 是否启用内容索引

---

# 大纲

- [《代码随想录》](https://github.com/fuyunjinglong/leetcode-master)
- [《算法通关手册》](https://github.com/itcharge/LeetCode-Py)
- [Hello 算法](https://www.hello-algo.com/chapter_sorting/selection_sort/)
- [Leecode-CN](https://leetcode.cn/problemset/)

# 工具函数

# 排序算法

**冒泡排序**

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

**选择排序**

> - 数组分为左右两个区间：左边是已排序区间，右边是未排序区间。
> - 遍历右区间，找到最小值，并放到左区间末尾
> - 这一趟完，最小值出现在左区间最左侧。然后循环

**插入排序**

**希尔排序**

**归并排序**

**快速排序**

**堆排序**

**计数排序**

**桶排序**

**基数排序**

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

