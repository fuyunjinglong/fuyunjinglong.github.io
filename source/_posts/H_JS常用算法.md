---
title: H_JS常用算法
date: 2022-05-05 06:33:16
categories:
- H_数据结构与算法
toc: true # 是否启用内容索引
---

# 初级算法

递归遍历树形结构

```
// 用来保存id
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
			},
			{
				name: 'bb',
				id: 101103,
				children: []
			}, {
				name: '101104',
				id: 101104,
				children: []
			}
		]
	}];
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

