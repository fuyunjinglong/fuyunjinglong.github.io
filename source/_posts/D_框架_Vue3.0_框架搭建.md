---
title: Vue3.0_框架搭建
date: 2022-06-26 07:33:16
categories:
- D_框架和类库
toc: true # 是否启用内容索引
---

# Vue3模板及目录

- [从 0 开始手把手带你搭建一套规范的 Vue3.x 项目工程环境](https://juejin.cn/post/6951649464637636622#heading-5)

**模板工具：**

- `编程语言`：**TypeScript 4.x 、JavaScript**
- `前端框架`：**Vue 3.x**
- `构建工具`：**Vite 2.x**
- `UI 框架`：**Element Plus**
- `图标工具`：**icones**
- `CSS预编译`：**Sass**
- `CSS框架`：**Windi CSS**
- `HTTP工具`：**Axios**
- `路由管理`：**Vue Router 4.x**
- `状态管理`：**Pinia**
- `代码规范`：**EditorConifg、Prettier、ESLint、Airbnb JavaScript Style Guide**
- `提交规范`：**husky、Commitlint 、lint-staged**
- `实现自动按需加载`（**`墙裂推荐`**）：**unplugin-auto-import、unplugin-vue-components、unplugin-icons**
- `实现 SVG图标 的组件化`：**vite-svg-loader**
- `让各种 API 支持响应式`：**VueUse**
- `让加载页面时有所反馈`：**NProgress**
- `支持 markdown`：**vite-plugin-md**
- vetur -> volar:对于 vue3 的支持，`vetur` 很明显的不如 `volar`，这边建议小伙伴们禁用vuetur而使用volor
- 单元测试：[vue-test-utils](https://link.juejin.cn/?target=https%3A%2F%2Fnext.vue-test-utils.vuejs.org%2F) + [jest](https://link.juejin.cn/?target=https%3A%2F%2Fjestjs.io%2F) + [vue-jest](https://link.juejin.cn/?target=https%3A%2F%2Fgithub.com%2Fvuejs%2Fvue-jest) + [ts-jest](https://link.juejin.cn/?target=https%3A%2F%2Fkulshekhar.github.io%2Fts-jest%2F)
- 自动部署：[GitHub Actions](https://link.juejin.cn/?target=https%3A%2F%2Fdocs.github.com%2Fcn%2Factions%2Flearn-github-actions)

**模板代码目录结构：**

```
├── publish/
└── src/
    ├── assets/                    // 静态资源目录(js,css,img)
    ├── common/                    // 通用类库目录
    ├── components/                // 公共组件目录
    ├── router/                    // 路由配置目录
    ├── store/                     // 状态管理目录
    ├── style/                     // 通用 CSS 目录
    ├── utils/                     // 工具函数目录
    ├── api/                       // http接口配置
    ├── layout/                    // 项目的布局
    ├── views/                     // 页面组件目录
    ├── App.vue
    ├── main.ts
    ├── shims-vue.d.ts
├── tests/                         // 单元测试目录
├── index.html
├── tsconfig.json                  // TypeScript 配置文件
├── vite.config.ts                 // Vite 配置文件
└── package.json
```



# 环境搭建-vue3+vite+ts(大崔哥)

创建基本模板

```
npm create vite@latest my-vue-app --template vue-ts
```

安装jest

```
npm i jest -D
```

配置package.json

```
"scripts": {
    "test:unit": "jest"
  },
```

编写第一个测试用例

test/unit/index.spec.js

```
test("1+1=2", () => {
  expect(1 + 1).toBe(2);
});
```

执行单元测试命令

```
npm run test:unit
```

# 使用vite初始化

```
npm init @vitejs/app
```

**安装常用依赖包(router,element-plus,axios)**

```
npm i vue-router@next  element-plus axios -S
```

## 安装自动按需引入包

最佳实践：按需引入

```
npm i unplugin-vue-components unplugin-auto-import -D
```

vite.config.js配置

```
import { defineConfig } from 'vite';
import vue from '@vitejs/plugin-vue';
import AutoImport from 'unplugin-auto-import/vite';
import Components from 'unplugin-vue-components/vite';
import { ElementPlusResolver } from 'unplugin-vue-components/resolvers';
import { join } from 'path';
import eslintPlugin from 'vite-plugin-eslint';

// https://vitejs.dev/config/
export default defineConfig({
  resolve: {
    alias: {
      '@': join(__dirname, 'src'),
    },
  },
  plugins: [
    vue(),
    AutoImport({
      // 自动引入ref,computed等钩子
      imports: ['vue', 'vue-router', 'pinia'],
      // 第三方组件库的解析器
      resolvers: [ElementPlusResolver()],
    }),
    Components({
      resolvers: [ElementPlusResolver()],
    }),
    eslintPlugin({
      // 配置
      cache: false, // 禁用 eslint 缓存
    }),
  ],
  // 静态资源服务的文件夹
  publicDir: 'public',
  base: './',
  // 本地运行配置，以及反向代理配置
  server: {
    host: 'localhost.huawei.com',
    port: 8082,
    strictPort: false, // 设为true时端口被占用则直接退出，不会尝试下一个可用端口
    cors: true, // 为开发服务器配置 CORS , 默认启用并允许任何源
    open: true, // 服务启动时自动在浏览器中打开应用,
    // 反向代理配置
    // proxy: {
    //   "/api": {
    //     target: "https://xxxx.com/",
    //     changeOrigin: true,
    //     rewrite: (path) => path.replace(/^\/api/, ""),
    //   },
    // },
  },
  build: {
    // 指定输出路径
    outDir: 'Vue3New2',
    // 生成静态资源的存放路径
    assetsDir: 'assets',
    // 小于此阈值的导入或引用资源将内联为 base64 编码，以避免额外的 http 请求。设置为 0 可以完全禁用此项
    assetsInlineLimit: 4096,
    // 构建后是否生成 source map 文件
    sourcemap: true,
  },
});
```

App.vue

```
<el-config-provider :locale="locale">
  <HelloWorld msg="Hello Vue 3 + TypeScript + Vite" />
  </el-config-provider>
//国际化  
import zhCn from 'element-plus/es/locale/lang/zh-cn'
import en from 'element-plus/es/locale/lang/en'
const locale =en
```

## 配置router4

创建src/router/index.js

```
import { createRouter, createWebHashHistory } from 'vue-router'
const he = ()=>import('@/components/HelloWorld.vue')

export default createRouter({
  history: createWebHashHistory(),
  routes: [
    {
      path: '/',
      component: he
    },
    {
      path: '/he',
      component: he
    },
  ]
})
```

main.js

```
import { createApp } from 'vue'
import App from './App.vue'
import router from './router';
const Vue = createApp(App)
Vue.use(router)
Vue.mount('#app')
```

## 配置axios

```
// 调用http
import { httpAxios, Api } from '@/fetch';
httpAxios('get','http://www.baidu.com')
```

```
// /api.axios.js
import axios, { isCancel } from 'axios';
import { randomNum } from '@/utils';
import { useComStore } from '@/store';

const instance = axios.create({
  timeout: 60000, // 设置超时
  withCredentials: true, // 跨域携带cookie
});

instance.interceptors.request.use(
  (config) => {
    if (config) {
      const { lang, userno, uniteCode } = useComStore(); // 获取vuex参数
    }
    // url上面加上随机数 防止缓存
    config.url = config.url.indexOf('?') !== -1 ? `${config.url}&k=${randomNum()}` : `${config.url}?k=${randomNum()}`;
    return config;
  },
  (error) => {
    // 对请求错误做些什么
    return Promise.reject(error);
  }
);

// 请求拦截器
instance.interceptors.response.use(
  (response) => {
    const { data, config } = response;
    // 用户登录cookie过期，跳转登录页面
    if (String(data.code) === '403') {
      if (typeof window.publicNavBarModelNew.bindEvent.loginPage === 'function') {
        // 新版本导航头跳转登录
        window.publicNavBarModelNew.bindEvent.loginPage.call(window.publicNavBarModelNew);
      } else {
        // 旧版本导航头跳转登录
        window.publicNavBarModelNew.bindEvent.logoutDo();
      }
      return Promise.reject(new Error(0));
    }
    // 导出文件
    if (config.type === 'file') {
      return response; // 导出文件需要整个响应data
    }
    return data; // 返回响应数据
  },
  (error) => {
    // 对响应错误做点什么
    if (isCancel(error)) {
      return new Promise(() => {
        // 取消请求的时候中断promise
      });
    }
    // 拦截器报错
    return Promise.reject(error);
  }
);
// 请求方法
const httpAxios = function (method, url, data = null, config = {}) {
  method = method.toLowerCase();
  if (method === 'post') {
    // post请求
    return instance.post(url, data, config);
  }
  if (method === 'get') {
    // get请求
    return instance.get(url, { params: data, ...config });
  }
  if (method === 'delete') {
    // delete请求
    return instance.delete(url, {
      params: data,
      ...config,
    });
  }
  if (method === 'put') {
    // put请求
    return instance.put(url, data, config);
  }
  return false;
};

// 导出请求方法
export default httpAxios;
```



## 安装pinia

**pinia没有module概念，全是扁平结构**

```
npm install pinia@next
```

创建store/index.js

```
import { defineStore } from "pinia";

export const useComStore = defineStore({
  id: "com",
  state: () => ({
    counter: 1,
    name: "Eduardo",
  }),
  getters: {
    doubleCount: (state) => state.counter * 2,
  },
  actions: {
    setCounter(val) {
      this.counter = val;
    },
    resetCounter(param) {
      this.counter = this.counter * param;
    },
  },
});
```

main.ts

```
import { createApp } from 'vue'
import App from './App.vue'
import router from './router';
import { createPinia } from 'pinia'
const Vue = createApp(App)
Vue.use(router)
Vue.use(createPinia())
Vue.mount('#app')
```

使用pinia

```
<script setup lang="ts">
import { ref } from 'vue'
import { useComStore } from '@/store'
import { storeToRefs } from 'pinia'
//action可以直接通过comStore使用
const comStore = useComStore()
const {counter,doubleCount } = storeToRefs(comStore)
cosnt {setCounter} = comStore
defineProps<{ msg: string }>()
</script>

<template>
  <h1 @click="setCounter(8)">设置counter参数{{counter}}</h1>
  <h2>{{doubleCount}}</h2>
</template>
```

**Vue3工程里使用Vue2生命周期**

```
<script lang="ts">
export default {
  computed: {
    ...mapState(useComStore, ['counter', 'doubleCount']),
  },
  methods: {
    ...mapActions(useComStore, ['setCounter']),
  },
};
</script>
```



## 安装Echart

```
npm install echarts --save
```

使用echart

```
<script setup lang="ts">
import { ref,onMounted } from 'vue'
import { useComStore } from '@/store'
import { storeToRefs } from 'pinia'
import * as echarts from 'echarts'
const comStore = useComStore()
const {counter,doubleCount } = storeToRefs(comStore)
defineProps<{ msg: string }>()
const value = ref(new Date())
const width = '800px'
const height = '400px'
onMounted(()=>{
      let myChart = echarts.init(document.getElementById("myChart"));
      // 绘制图表
      myChart.setOption({
        tooltip: {},
        xAxis: {
            data: ['衬衫', '羊毛衫', '雪纺衫', '裤子', '高跟鞋', '袜子']
        },
        yAxis: {},
        series: [
          {
            name: "销量",
            type: "bar",
            data: [5, 20, 36, 10, 10, 20, 20, 36, 10, 10, 20],
          },
        ]
      });

})
</script>

<template>
  <h1 @click="comStore.setCounter(8)">设置counter参数{{counter}}</h1>
  <h2>{{doubleCount}}</h2>
-----------------------------------
   <el-calendar v-model="value" />
   
<div id="myChart" :style="{ width: width, height: height }"></div>
</template>

<style scoped>
</style>

```

## 安装CSS 预编译器 Stylus/Sass/Less

```
npm i sass -D
# or
npm i stylus -D
npm i less -D
// 使用
<style lang="scss">
  ...
</style>
```



## 引入Eslint和Prettier

### **通用引入Eslint**

安装全局eslint

```
npm i eslint -g
```

执行eslint初始化，自动创建.eslintrc.js文件

```
npx eslint --init
```

```
module.exports = {
  env: {
    browser: true,
    es2021: true,
  },
  //解决eslint和prettier冲突，优先prettier
  extends: ['eslint:recommended', 'standard', 'plugin:prettier/recommended'],
  parserOptions: {
    ecmaVersion: 'latest',
  },
  plugins: [],
  rules: {
    //0是忽略，1是警告，2是报错
    quotes: 1,
    // 每行末尾添加分号
    semi: 2,
    'no-console': 0,
  },
};
```

### 通用引入Prettier

```
npm i prettier -D
```

手动创建.prettierrc.js文件

```
//.prettierrc.js文件,0是忽略，1是警告，2是报错
module.exports = {
    // 每行末尾添加分号
  semi: true,
  // 使用双引号
  singleQuote: true,
  'no-console': 2,
  printWidth: 200, //单行长度
  tabWidth: 2, //缩进长度
  endOfLine: 'auto', //不让prettier检测文件每行结束的格式
};
```

### 通用Eslint和Prettier冲突问题

安装插件完美解决两者冲突

```
npm i eslint-config-prettier eslint-plugin-prettier -D
```

.eslintrc.js配置

```
//解决eslint和prettier冲突，优先prettier
  extends: ['eslint:recommended', 'standard', 'plugin:prettier/recommended'],
```

## VScode自动修复代码

一定安装vscode的eslint和prettier插件，使用eslint检查规则，并使用prettier自动修复。**每次修改完规则后，都需要重启vscode才会生效**

setting.json

```
{
  "files.associations": {
    "*.vue": "vue",
    "*.wpy": "vue",
    "*.wxml": "html",
    "*.wxss": "css"
  },
  "terminal.integrated.shell.windows": "C:\\Windows\\System32\\cmd.exe",
  "git.enableSmartCommit": true,
  "git.autofetch": true,
  "emmet.triggerExpansionOnTab": true,
  "emmet.showAbbreviationSuggestions": true,
  "emmet.showExpandedAbbreviation": "always",
  "emmet.includeLanguages": {
    "vue-html": "html",
    "vue": "html",
    "wpy": "html"
  },
  //主题颜色
  //"workbench.colorTheme": "Monokai",
  "git.confirmSync": false,
  "explorer.confirmDelete": false,
  "editor.fontSize": 16,
  "editor.wordWrap": "on",
  "editor.detectIndentation": false,
  // 重新设定tabsize
  "editor.tabSize": 2,
  //失去焦点后自动保存
  // "files.autoSave": "onFocusChange",
  // #值设置为true时，每次保存的时候自动格式化；
  "editor.formatOnSave": true,
  //每120行就显示一条线
  "editor.rulers": [],
  // 在使用搜索功能时，将这些文件夹/文件排除在外
  "search.exclude": {
    "**/node_modules": true,
    "**/bower_components": true,
    "**/target": true,
    "**/logs": true
  },
  "editor.defaultFormatter": "esbenp.prettier-vscode" // 默认格式化工具选择prettier
}
```

## Vue3引入规则检查插件

### 引入eslint

```
npx eslint --init
默认引入ts文件，注意不要安装三个ts的依赖库，最好手动安装
```

```
npm i eslint-plugin-vue@latest @typescript-eslint/eslint-plugin@latest @typescript-eslint/parser@latest -D
```

```
package.json配置
{
    "scripts":{
        // lint当前项目中的文件并且开启自动修复
        "lint": "eslint . --ext .vue,.js,.ts,.jsx,.tsx --fix",
    }
}
```

.eslint.js配置文件

```
module.exports = {
  globals: {
    defineProps: 'readonly',
  },
  // 设置我们的运行环境为浏览器 + es2021 + node ,否则eslint在遇到 Promise，window等全局对象时会报错
  env: {
    browser: true,
    es2021: true,
    node: true,
    // 开启setup语法糖环境
    'vue/setup-compiler-macros': true,
  },
  // 新增，解析vue文件
  parser: 'vue-eslint-parser',
  // 继承eslint推荐的规则集，vue基本的规则集，typescript的规则集
  extends: [
    'eslint:recommended',
    // "plugin:vue/essential",
    // 使用vue3的规则集
    'plugin:vue/vue3-recommended',
    // 使用airbnb规则集
    'airbnb-base',
    'plugin:@typescript-eslint/recommended',
    'plugin:prettier/recommended',
  ],
  // 支持ts的最新语法
  parserOptions: {
    ecmaVersion: 13,
    // 解析vue文件中<script>标签中的代码
    parser: '@typescript-eslint/parser',
    sourceType: 'module',
  },
  // 添加vue和@typescript-eslint插件，增强eslint的能力
  plugins: ['vue', '@typescript-eslint'],
  rules: {
    // 解决Unable to resolve path to module报错，eslint不识别vite别名
    'import/no-unresolved': 'off',
    'import/extensions': 'off',
    'import/no-absolute-path': 'off',
    'import/no-extraneous-dependencies': 'off',
    'no-param-reassign': 0,
    'no-console': 0,
    'import/prefer-default-export': 0, // 强制导出必须有default
    'import/no-mutable-exports': 0, // 强制导出为常量
    '@typescript-eslint/no-this-alias': 0, // eslint 为了防止this变量和局部变量混淆
    'prefer-rest-params': 0, // 永远不要定义一个参数为 arguments
    'no-unused-expressions': 0, // 期待是一个函数，而不是表达式
    'prefer-const': 0, // 优先使用const申明
    'global-require': 0, // 防止require引入资源报错
    'no-debugger': 0,
    'vue/no-multiple-template-root': 0, // 关闭唯一根元素提示
  },
};
```

**vite热启动自动进行eslint检测**

```
npm i vite-plugin-eslint --dev
```

配置vite.config.js

```
...
import eslintPlugin from 'vite-plugin-eslint'
...
 plugins: [
   ...
   eslintPlugin({
     // 配置
     cache: false // 禁用 eslint 缓存
   })
 ]
```

### **引入**[airbnb](https://juejin.cn/post/6844903620648026120#heading-1)

```
// npm version > 5
npx install-peerdeps --dev eslint-config-airbnb-base
```

```
// .eslintrc.js
...
extends: [
    'plugin:vue/vue3-recommended',
    'airbnb-base', // ++
],
...
```

### 引入@别名

```
// vite.config.js
import { defineConfig } from 'vite';
import vue from '@vitejs/plugin-vue';
import AutoImport from 'unplugin-auto-import/vite';
import Components from 'unplugin-vue-components/vite';
import { ElementPlusResolver } from 'unplugin-vue-components/resolvers';
import { join } from 'path';
import eslintPlugin from 'vite-plugin-eslint';

// https://vitejs.dev/config/
export default defineConfig({
  resolve: {
    alias: {
      '@': join(__dirname, 'src'),
    },
  },
  plugins: [
    vue(),
    AutoImport({
      resolvers: [ElementPlusResolver()],
    }),
    Components({
      resolvers: [ElementPlusResolver()],
    }),
    eslintPlugin({
      // 配置
      cache: false, // 禁用 eslint 缓存
    }),
  ],
  //静态资源服务的文件夹
  publicDir: 'public',
  base: './',
  //本地运行配置，以及反向代理配置
  server: {
    host: 'localhost',
    port: 8082,
    strictPort: false, //设为true时端口被占用则直接退出，不会尝试下一个可用端口
    cors: true, //为开发服务器配置 CORS , 默认启用并允许任何源
    open: true, //服务启动时自动在浏览器中打开应用,
    // 反向代理配置
    // proxy: {
    //   "/api": {
    //     target: "https://xxxx.com/",
    //     changeOrigin: true,
    //     rewrite: (path) => path.replace(/^\/api/, ""),
    //   },
    // },
  },
  build: {
    //指定输出路径
    outDir: 'Vue3New2',
    //生成静态资源的存放路径
    assetsDir: 'assets',
    //小于此阈值的导入或引用资源将内联为 base64 编码，以避免额外的 http 请求。设置为 0 可以完全禁用此项
    assetsInlineLimit: 4096,
    //构建后是否生成 source map 文件
    sourcemap: true,
  },
});
```

```
// .eslint.js
rules: {
    // 解决Unable to resolve path to module报错，eslint不识别vite的@别名
    'import/no-unresolved': 'off',
    'import/extensions': 'off',
    'import/no-absolute-path': 'off',
    'import/no-extraneous-dependencies': 'off',
    'no-param-reassign': 0,
    'no-console': 0,
  }
```

```
// tsconfig.json
"compilerOptions": {
    //ts文件支持别名,防止ts编译报错
    "noImplicitThis": false, // js/ts 混用时设为false
    "experimentalDecorators": true,//部分使用esbuild转化，部分使用官方typescript转化
    "baseUrl": ".",
    "paths": {
      "@/*": ["src/*"]
    }
  }
```



### 引入Prettier

同前面的通用引入Prettier

```
//.prettierrc.js文件,0是忽略，1是警告，2是报错
module.exports = {
  // 每行末尾添加分号
  semi: true,
  // 使用双引号
  singleQuote: true,
  'no-console': 2,
  printWidth: 200, //单行长度
  tabWidth: 2, //缩进长度
  endOfLine: 'auto', //不让prettier检测文件每行结束的格式
};
```

Hellow.vue

```
<script setup lang="ts">
import * as echarts from 'echarts';
import { storeToRefs } from 'pinia';
import { ref, onMounted } from 'vue';
import { useComStore } from '@/store';

const comStore = useComStore();
const { counter, doubleCount } = storeToRefs(comStore);
defineProps<{ msg: string }>();
const value = ref(new Date());
const width = '800px';
const height = '400px';
onMounted(() => {
  let myChart = echarts.init(document.getElementById('myChart'));
  // 绘制图表
  myChart.setOption({
    tooltip: {},
    xAxis: {
      data: ['衬衫', '羊毛衫', '雪纺衫', '裤子', '高跟鞋', '袜子'],
    },
    yAxis: {},
    series: [
      {
        name: '销量',
        type: 'bar',
        data: [5, 20, 36, 10, 10, 20, 20, 36, 10, 10, 20],
      },
    ],
  });
});
</script>

<template>
  <h1 @click="comStore.setCounter(8)">设置counter参数{{ counter }}</h1>
  <h2>{{ doubleCount }}</h2>
  -----------------------------------
  <el-calendar v-model="value" />

  <div id="myChart" :style="{ width: width, height: height }"></div>
</template>
<style scoped></style>
```

## 最终package.json

```
{
  "name": "vue3new2",
  "private": true,
  "version": "0.0.0",
  "scripts": {
    "dev": "vite",
    "build": "vite build",
    "preview": "vite preview",
    "lint": "eslint . --ext .vue,.js,.ts,.jsx,.tsx --fix"
  },
  "dependencies": {
    "axios": "^0.27.2",
    "echarts": "^5.3.3",
    "element-plus": "^2.2.6",
    "pinia": "^2.0.0-rc.10",
    "vite-plugin-eslint": "^1.6.1",
    "vue": "^3.2.25",
    "vue-router": "^4.0.13"
  },
  "devDependencies": {
    "@typescript-eslint/eslint-plugin": "^5.30.6",
    "@typescript-eslint/parser": "^5.30.6",
    "@vitejs/plugin-vue": "^2.3.3",
    "eslint": "^8.2.0",
    "eslint-config-airbnb-base": "^15.0.0",
    "eslint-config-prettier": "^8.5.0",
    "eslint-plugin-import": "^2.25.2",
    "eslint-plugin-prettier": "^4.2.1",
    "eslint-plugin-vue": "^9.2.0",
    "prettier": "^2.7.1",
    "sass": "^1.54.0",
    "typescript": "^4.7.3",
    "unplugin-auto-import": "^0.9.2",
    "unplugin-vue-components": "^0.20.1",
    "vite": "^2.9.9",
    "vite-plugin-windicss": "^1.8.7",
    "vue-tsc": "^0.34.7",
    "windicss": "^3.5.6"
  }
}
```
