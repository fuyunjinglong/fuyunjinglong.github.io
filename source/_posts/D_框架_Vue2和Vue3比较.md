---
title: Vue2和Vue3比较
date: 2023-09-12 07:33:16
categories:
- D_框架和类库
toc: true # 是否启用内容索引
---

# 进阶

## 双向绑定

**vue2在组件中这样设置:**

父组件

```
<ChildComponent v-model = "title">
```

子组件

```
export default {
  model: {
    prop: 'title', // v-model绑定的属性名称
    event: 'change' // v-model绑定的事件
  },
  props: {
    value: String, // value跟v-model无关
    title: { // title是跟v-model绑定的属性
      type: String,
      default: 'Default title'
    }
  },
  methods: {
    handle() {
      // 这里的 change, 对应 event
      this.$emit('change', 'xxx')
    }
  }
}
```

**vue3在组件中这样设置**

父组件

```
<!-- 两个方法等价 -->
<Son v-model="message" />
<!-- <Son :modelValue="message" @update:modelValue="message = $event" /> -->
```

子组件

```
export default defineComponent({
  props: {
    modelValue: {
      type: String
    }
  },
  emits: ['update:modelValue'],
  setup(props, { emit }) {
    const newValue = computed({
      get: () => props.modelValue,
      set: (nv) => {
        console.log(nv)
        emit('update:modelValue', nv)
      }
    })

    return {
      newValue
    }
  }
})
```

**小结**

**vue2:**

1. v-model: 会把 `value` 用作 prop 且把 `input` 用作 event;
2. 可以通过 `.sync`修饰符 指定传递名字
3. 支持model: 可以指定v-model的 value属性名 和 event事件名字

![image-20230223074721472](C:\Users\fuyunjinglong\AppData\Roaming\Typora\typora-user-images\image-20230223074721472.png)

**组件v-model原理:**

```
<Son v-model="age" />
<Son :value="age"  @change="age = $event" />
```

**vue3:**

1. v-model: 不在绑定 value 而是 `modelValue`, 接受方法也不再是 input 而是 `update:modelValue`
2. 组件支持多个 v-model, 并且可以指定名字 v-model:名字

![image-20230223074833400](C:\Users\fuyunjinglong\AppData\Roaming\Typora\typora-user-images\image-20230223074833400.png)

**组件v-model原理:**

```
<Son v-model="formData" />
<Son :modelValue="formData" @update:modelValue="formData = $event" />
```

