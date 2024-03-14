---
title: React入门
date: 2023-03-11 07:33:16
categories:
- D_框架和类库
toc: true # 是否启用内容索引
---

# 大纲

- [尚硅谷React教程](https://www.bilibili.com/video/BV1wy4y1D7JT/?spm_id_from=333.999.0.0&vd_source=bd4c7d99d71adf64d6e88c65370e0247)
- React18+TS 通用后台管理系统解决方案落地实战-video-mk
- React16.4 开发简书项目 从零基础入门到实战(欢乐购旧版)-video-mk
- 2023 React18 系统入门 进阶实战《欢乐购》-video-mk
- [全栈萧晨](https://xiaochen1024.com/)
- [scrimba 的互动式 React 教程](https://scrimba.com/learn/learnreact)

# React入门

```
<html>
<head>
    <title>Document</title>
    <script crossorigin src="https://unpkg.com/react@16/umd/react.development.js"></script>
    <script crossorigin src="https://unpkg.com/react-dom@16/umd/react-dom.development.js"></script>
    <script src="https://unpkg.com/babel-standalone@6/babel.min.js"></script>
</head>
<body>
    <div id="app"></div>
</body>
</html>
<script type="text/babel">
    // OH的右边的内容就是JSX的语法：类似XML的js的扩展语法
    // 需要这么写，不然就会报错，需要告诉babel需要转哪些，只需要在script标签写type="text/babel"就可以了）
    let oH = <div id='xx'>hello react!</div>;
    // ReactDOM.render(要渲染什么内容，渲染到哪里)
    // 只有用了这个才会创建虚拟DOM，先创建再更新
    ReactDOM.render(oH, document.querySelector("#app"));
</script>
```

**基本语法规则**

- 遇到<>开头的代码，以标签的语法解析
- 遇到{}开头的代码，以js的语法解析

**渲染虚拟dom**

- 使用纯JS方式创建
- 使用JSX方式创建

```
// 使用纯JS方式创建
let oH = React.createElement('h1',{id:'xx'},'hello react!')
// 使用JSX方式创建'
let oH = <div id='xx'>hello react!</div>;
```

**声明组件的两种方式**

类组件->函数组件就好像vue2->vue3进化过程一样

- 类组件
- 函数组件及react-hooks

```
// 类组件

// 函数组件及react-hooks，要求：函数名首字母大写，div根节点只能有一个。
function App(){
        return (<div>这是函数组件</div>)
    }
ReactDOM.render(<App/>, document.querySelector("#app"));
```



# 用了Vue-两天学会React(实战)

## 组件传值

vue

```javascript
// 父组件
<GoodsList v-if="!isGoodsIdShow" :goodsList="goodsList"/>
// 子组件 -- 通过props获取即可
props: {
    goodsList:{
      type:Array,
      default:function(){
        return []
      }
    }
  }
```

react

```typescript
// 父组件
export default function tab(props:any) {
    const [serverUrl, setServerUrl] = useState<string | undefined>('https://');
    console.log(props);
 // 父组件接收子组件的值并修改
    const changeMsg = (msg?:string) => {
        setServerUrl(msg);
     };

    return(
        <View className='tab'>
            <View className='box'>
                <TabName msg={serverUrl} changeMsg={changeMsg} />
            </View>
        </View>
    )
}

// 子组件
function TabName(props){
    console.log('props',props);
 // 子传父
    const handleClick = (msg:string) => {
      props.changeMsg(msg);
    };
    return (
        <View>
            <Text>{props.msg}</Text>
            <Button onClick={()=>{handleClick('77777')}}>测试</Button>
        </View>
    );
};
```

## 获取DOM

**vue**

```javascript
this.$refs['ref']
```

react

```typescript
// 声明ref    
const domRef = useRef<HTMLInputElement>(null);
// 通过点击事件选择input框
const handleBtnClick = ()=> {
     domRef.current?.focus();
     console.log(domRef,'domRef')
}

return(
        <View className='home'>
            <View className='box'>
                <Input ref={domRef} type="text" />
                <button onClick={handleBtnClick}>增加</button>
            </View>
        </View>
    )
```

## 列表渲染

vue

```html
<div v-for="(item, index) in mealList" :key="index">
 {{item}}
</div>
```

react

```typescript
//声明对象类型
  type Coordinates = {
    name:string,
    age:number
  };
 // 对象
  let [userState, setUserState] = useState<Coordinates>({ name: 'John', age: 30 });
 // 数组
  let [list, setList] = useState<Coordinates[]>([{ name: '李四', age: 30 }]);

// 如果你的 => 后面跟了一对花括号 { ，那你必须使用 return 来指定返回值！
const listItem = list.map((oi)=>{
    return <View key={oi.age}>{oi.name}</View>
  });

return (
      {
        list.map((oi)=>{
          return <Text className='main-list-title' key={oi.age}>{oi.name}</Text>
        })
      }
      <View>{ listItem }</View>
    </View>
  )
```

## 条件渲染

react

```
render() {
    const { showBgView, bgType, lang, showView, industryList } = this.state
    return (
      <div className='change-product-pop'>
        {
          showView ? (
            <div className='change-product-pop-list'>
            ):[]
         }
        </div>
        )
```

## 计算属性

vue

```javascript
computed: {
    userinfo() {
      return this.$store.state.userinfo;
    },
  },
```

react

```typescript
const [serverUrl, setServerUrl] = useState('https://localhost:1234');
let [age, setAge] = useState(2);

const name = useMemo(() => {
        return serverUrl + " " + age;
}, [serverUrl]);
console.log(name) // https://localhost:1234 2
```

## 监听器

vue

```javascript
watch: {
    // 保证自定义菜单始终显示在页面中
    customContextmenuTop(top) {
      ...相关操作
    }
  },
```

react

```typescript
import { useEffect, useState } from 'react';

export default function home() {
    const [serverUrl, setServerUrl] = useState('https://localhost:1234');
    const [age, setAge] = useState(2);

   /**
     * useEffect第二个参数中所传递的值才会进行根据值的变化而出发;
     * 如果没有穿值的话,就不会监听数据变化
     */
    useEffect(()=>{
        if (age !== 5) {
            setAge(++age)
        }
    },[age])

    useEffect(()=>{
        if(serverUrl !== 'w3c') {
            setServerUrl('w3c');
        }
    },[serverUrl])

    return(78)
}
```
