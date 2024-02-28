---
title: 第三方库
date: 2024-02-29 07:33:16
categories:
- D_框架和类库
toc: true # 是否启用内容索引
---

# vex-table

```
<template>
  <el-button @click="loadColumnAndData(20, 20)">20列20行</el-button>
  <el-button @click="loadColumnAndData(50, 50)">50列50行</el-button>
  <el-button @click="loadColumnAndData(100, 100)">100列100行</el-button>
  <el-button @click="loadColumnAndData(500, 500)">500列500行</el-button>
  <el-button @click="loadColumnAndData(1000, 1000)">1000列1000行</el-button>
  <el-button @click="loadColumnAndData(2000, 2000)">2000列2000行</el-button>
  <el-button @click="loadColumnAndData(4500, 4500)">4500列4500行</el-button>
  <!-- <el-button @click="loadColumnAndData(5000, 5000)">5000列5000行</el-button>
  <el-button @click="loadColumnAndData(50000, 50000)">5w列5w行</el-button>
  <el-button @click="loadColumnAndData(100000, 100000)">10w列10w行</el-button> -->
  <div class="VexTable">
    <vxe-grid ref="xGrid" class="xGrid" v-bind="gridOptions" height="auto" v-on="gridEvents">
      <template v-for="(col, cIndex) in columns" #[`${col.slots.header}`]="{ row, column }" :key="col.field">
        <div class="first-col-top">{{ column.title }}</div>
      </template>
    </vxe-grid>
  </div>
</template>

<script setup lang="tsx">
// 功能：支持大容量自定义表头,自定义单元格，上限4500x4500
import { ref, reactive, toRefs, computed, watch, nextTick, onMounted, h } from 'vue';
import { VXETable } from 'vxe-table';
import { randomNum } from '@/utils';
import FCalendar from '@/components/FCalendar.vue';

const props = defineProps([]);
const emits = defineEmits([]);
const xGrid = ref(null);
const columnList: any[] = [];
const dataList: any[] = [];
const gridOptions = reactive({
  border: true,
  showOverflow: true,
  loading: false,
  height: 400,
  columnConfig: {
    resizable: true,
  },
  editConfig: {
    trigger: 'click',
    mode: 'cell',
    showIcon: false,
  },
});
const gridEvents = {
  // headerCellClick(params) {
  //   const { column } = params;
  //   console.log(`表头单元格点击${column.title}`);
  // },
  // headerCellDblclick(params) {
  //   const { column } = params;
  //   console.log(`表头单元格双击${column.title}`);
  // },
  // headerCellMenu(params) {
  //   const { column } = params;
  //   console.log(`表头右键单元格 ${column.title}`);
  // },
  // cellClick(params) {
  //   const { column } = params;
  //   console.log(`单元格点击${column.title}`);
  // },
  // cellDblclick(params) {
  //   const { column } = params;
  //   console.log(`单元格双击${column.title}`);
  // },
  // cellMenu(params) {
  //   const { row } = params;
  //   console.log(`单元格右键行 ${row.name}`);
  // },
  // footerCellClick(params) {
  //   const { column } = params;
  //   console.log(`表尾单元格点击${column.title}`);
  // },
  // footerCellDblclick(params) {
  //   const { column } = params;
  //   console.log(`表尾单元格双击${column.title}`);
  // },
  // footerCellMenu(params) {
  //   const { column } = params;
  //   console.log(`表尾右键单元格 ${column.title}`);
  // },
  // checkboxChange(params) {
  //   console.log(`复选框切换 ${params.checked}`);
  // },
  // checkboxAll(params) {
  //   console.log(`复选框全选切换 ${params.checked}`);
  // },
  // scroll(params) {
  //   console.log(`滚动事件scrollTop=${params.scrollTop} scrollLeft=${params.scrollLeft}`);
  // },
  // zoom(params) {
  //   console.log(`表格全屏 type=${params.type}`);
  // },
  // custom(params) {
  //   console.log(`表格自定义列表 type=${params.type}`);
  // },
};
const duble = reactive({
  row: {},
  column: {},
  val: '',
});
function judgeSame(row, column, value) {
  // if (row.rowId === duble.row.rowId && column.field === duble.column.field && value === duble.val) {
  //   return false;
  // }
  duble.row = row;
  duble.column = column;
  duble.val = value;
  console.log('column:' + duble.column.field + ';row:' + JSON.stringify(duble.row) + ';value:' + duble.val);
}

function myRender(type, colT) {
  // 内置渲染器
  const t = {
    input: () => inputRender(),
    select: () => selectRender(),
    date: () => dateRender(),
    slot: () => slotRender(),
  };
  let r = t[type] ? t[type]() : {};
  r = {
    editRender: colT === 0 ? r : {},
    slots: colT === 0 ? { header: `header_${randomNum()}` } : r,
  };

  return r;
}

function inputRender() {
  // 单元组件-输入框
  return {
    name: 'input',
    props: { placeholder: '请输入名称' },
    events: {
      change({ row, column }) {
        judgeSame(row, column, column.model.value);
      },
    },
  };
}

function selectRender() {
  // 单元组件-下拉框
  return {
    name: '$select',
    options: [
      {
        label: '男',
        value: '男',
      },
      {
        label: '女',
        value: '女',
      },
    ],
    events: {
      change({ row, column }, { value }) {
        judgeSame(row, column, value);
      },
    },
  };
}

function dateRender() {
  // 单元组件-日期
  return {
    header: `header_${randomNum()}`,
    edit({ row, column }) {
      return h(FCalendar, {
        row,
        column,
        onChange({ row, column }) {
          judgeSame(row, column, row[column.property]);
        },
      });
    },
  };
}

function slotRender() {
  // 单元组件-自定义
  return {
    header: `header_${randomNum()}`,
    default: ({ row, column: { field } }) => {
      return row[field];
    },
    edit: ({ row, column }) => {
      return h('div', {}, [
        h(
          'span',
          {
            class: 'btn',
            onClick(event) {
              judgeSame(row, column, event);
            },
          },
          '点击'
        ),
      ]);
    },
  };
}
function createColT(field, t, others = {}) {
  // 模拟各种创建列
  const ty = {
    0: 'input',
    1: 'select',
    2: 'date',
    3: 'slot',
  };

  return createCol({ field, type: ty[t], colT: t > 1 ? 1 : 0, ...others });
}
function createCol({ colT = 0, title, field, type, ...others }) {
  // 创建列
  const renders = myRender(type, colT);
  return {
    title: title ? title : field, // 表头别名
    field, // 表数据映射字段
    ...renders,
    ...others,
  };
}
const columns = ref([
  createCol({ field: 'name', type: 'input' }),
  createCol({ field: 'sex', type: 'select' }),
  createCol({ field: 'time', type: 'date', colT: 1 }),
  createCol({ field: 'age', type: 'slot', colT: 1 }),
]);
// 双向数据绑定，一般不要轻易用，会一定程度上影响性能
const datas = ref([
  { rowId: 0, name: `师傅`, sex: '男', time: '2023-09-03', age: 8 },
  { rowId: 1, name: `大师兄`, sex: '女', time: '2023-09-03', age: 18 },
  { rowId: 2, name: `大师兄1`, sex: '男', time: '2023-09-03', age: 181 },
]);

onMounted(() => {
  nextTick(() => {
    // gridOptions.loading = true;
    // const $grid = xGrid.value;
    // if ($grid) {
    //   gridOptions.columns = columns.value;
    //   gridOptions.data = datas.value;
    // }
    // gridOptions.loading = false;
    // 官方支持简单单元格10wX10w,实测自定义单元格4500X4500
    loadColumnAndData(20, 20);
  });
});

const mockColumns = (colSize: number): Promise<any[]> => {
  // 模拟创建列
  return new Promise((resolve) => {
    setTimeout(() => {
      const currSize = 0;
      columnList.length = 0;
      if (currSize < colSize) {
        for (let i = currSize; i < colSize; i++) {
          columnList.push(
            createColT('attr' + i, 1, { width: i === 0 ? 60 : 140 })
            //   {
            //   field: 'attr' + i,
            //   title: i === 0 ? '' : 'Attr' + i,
            //   width: i === 0 ? 60 : 140,
            //   type: i === 0 ? 'checkbox' : 'FInput',
            //   fixed: i < 1 ? 'left' : null,
            //   editRender: {
            //     //该处是列可编辑状态下的编辑框，这里是一个静态下拉框，下面有一个动态下拉框也是我踩雷的地方
            //     name: '$select',
            //     options: [
            //       { label: '待处理', value: '待处理' },
            //       { label: '处理中', value: '处理中' },
            //       { label: '已计划', value: '已计划' },
            //       { label: '已完成', value: '已完成' },
            //       { label: '已关闭', value: '已关闭' },
            //     ],
            //     props: { placeholder: '请选择工单状态' },
            //   },
            // }
          );
        }
      }
      resolve(columnList);
    }, 100);
  });
};

const mockList = (rowSize: number): Promise<any[]> => {
  // // 模拟创建行
  return new Promise((resolve) => {
    setTimeout(() => {
      const d = {};
      columns.value.forEach((c, ci) => {
        d['attr' + ci] = 'attr_row_' + ci;
      });
      dataList.length = 0;
      for (let i = 0; i < rowSize; i++) {
        dataList.push(d);
      }
      // 模拟数据
      const result = JSON.parse(JSON.stringify(dataList.slice(0, rowSize)));
      resolve(result);
    }, 100);
  });
};

const loadColumnAndData = async (colSize: number, rowSize: number) => {
  // 核心:加载行列数据
  gridOptions.loading = true;
  const res0 = await mockColumns(colSize);
  columns.value = res0;
  Promise.all([mockList(rowSize)]).then((rest) => {
    const startTime = Date.now();
    const $grid = xGrid.value;
    // 使用函数式加载
    if ($grid) {
      Promise.all([$grid.reloadColumn(columns.value), $grid.reloadData(rest[0])]).then(() => {
        VXETable.modal.message({ content: `渲染 ${colSize} 列 ${rowSize} 行，用时 ${Date.now() - startTime}毫秒`, status: 'info' });
        gridOptions.loading = false;
      });
    } else {
      gridOptions.loading = false;
    }
  });
};
</script>

<style scoped>
.VexTable {
  width: 100%;
  height: calc(100% - 50px);
}
</style>
```



# 