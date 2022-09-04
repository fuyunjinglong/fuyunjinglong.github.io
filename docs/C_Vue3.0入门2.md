# 课程指南

<img :src="$withBase('/images/v3_ts.JPG')" alt="vue3">

课程介绍:Vue 是一套用于构建用户界面的**渐进式框架**。Vue.js 3.0 "One Piece" 正式版在 2020 年 9 月份发布,经过了 2 年多开发, 100+位贡献者, 2600+次提交, 600+次 PR，同时 Vue3 也支持 Vue2 的大多数特性,且,更好的支持了 TypeScript,也增加了很多的新特性,如:Composition API,新组件(Fragment/Teleport/Suspense)等等.
课程内容如下:

- 1.TypeScript 快速上手

- 2.Vue3 快速上手

- 3.Vue3 新特性

# 一.TypeScript快速上手

## 1. 初识 TypeScript

![image-20220904122924529](C:\Users\fuyunjinglong\AppData\Roaming\Typora\typora-user-images\image-20220904122924529.png)

### TypeScript 的介绍

TypeScript 是一种由微软开发的开源、跨平台的编程语言。它是 JavaScript 的超集，最终会被编译为 JavaScript 代码。

2012 年 10 月，微软发布了首个公开版本的 TypeScript，2013 年 6 月 19 日，在经历了一个预览版之后微软正式发布了正式版 TypeScript

TypeScript 的作者是安德斯·海尔斯伯格，C#的首席架构师。它是开源和跨平台的编程语言。

TypeScript 扩展了 JavaScript 的语法，所以任何现有的 JavaScript 程序可以运行在 TypeScript 环境中。

TypeScript 是为大型应用的开发而设计，并且可以编译为 JavaScript。

TypeScript 是 JavaScript 的一个超集，主要提供了类型系统和对 ES6+ 的支持\*\*，它由 Microsoft 开发，代码开源于 GitHub 上

**TypeScript 是 JavaScript 的一个超集**，主要提供了**类型系统**和**对 ES6+ 的支持**，它由 Microsoft 开发，代码[开源于 GitHub](https://github.com/Microsoft/TypeScript) 上

### TypeScript 的特点

TypeScript 主要有 3 大特点：

- **始于 JavaScript，归于 JavaScript**

TypeScript 可以编译出纯净、 简洁的 JavaScript 代码，并且可以运行在任何浏览器上、Node.js 环境中和任何支持 ECMAScript 3（或更高版本）的 JavaScript 引擎中。

- **强大的类型系统**

**类型系统**允许 JavaScript 开发者在开发 JavaScript 应用程序时使用高效的开发工具和常用操作比如静态检查和代码重构。

- **先进的 JavaScript**

TypeScript 提供最新的和不断发展的 JavaScript 特性，包括那些来自 2015 年的 ECMAScript 和未来的提案中的特性，比如异步功能和 Decorators，以帮助建立健壮的组件。

### 总结

TypeScript 在社区的流行度越来越高，它非常适用于一些大型项目，也非常适用于一些基础库，极大地帮助我们提升了开发效率和体验。

## 2. 安装 TypeScript

命令行运行如下命令，全局安装 TypeScript：

```bash
npm install -g typescript
```

安装完成后，在控制台运行如下命令，检查安装是否成功(3.x)：

```bash
tsc -V
```

## 3. 第一个 TypeScript 程序

### 编写 TS 程序

src/helloworld.ts

```typescript
function greeter(person) {
  return 'Hello, ' + person
}

let user = 'Yee'

console.log(greeter(user))
```

### 手动编译代码

我们使用了 `.ts` 扩展名，但是这段代码仅仅是 JavaScript 而已。

在命令行上，运行 TypeScript 编译器：

```bash
tsc helloworld.ts
```

输出结果为一个 `helloworld.js` 文件，它包含了和输入文件中相同的 JavsScript 代码。

在命令行上，通过 Node.js 运行这段代码：

```bash
node helloworld.js
```

控制台输出：

```
Hello, Yee
```

### vscode 自动编译

    1). 生成配置文件tsconfig.json
        tsc --init
    2). 修改tsconfig.json配置
        "outDir": "./js",
        "strict": false,
    3). 启动监视任务:
        终端 -> 运行任务 -> 监视tsconfig.json

### 类型注解

接下来让我们看看 TypeScript 工具带来的高级功能。 给 `person` 函数的参数添加 `: string` 类型注解，如下：

```typescript
function greeter(person: string) {
  return 'Hello, ' + person
}

let user = 'Yee'

console.log(greeter(user))
```

TypeScript 里的类型注解是一种轻量级的为函数或变量添加约束的方式。 在这个例子里，我们希望 `greeter` 函数接收一个字符串参数。 然后尝试把 `greeter` 的调用改成传入一个数组：

```typescript
function greeter(person: string) {
  return 'Hello, ' + person
}

let user = [0, 1, 2]

console.log(greeter(user))
```

重新编译，你会看到产生了一个错误：

```bash
error TS2345: Argument of type 'number[]' is not assignable to parameter of type 'string'.
```

类似地，尝试删除 `greeter` 调用的所有参数。 TypeScript 会告诉你使用了非期望个数的参数调用了这个函数。 在这两种情况中，TypeScript 提供了静态的代码分析，它可以分析代码结构和提供的类型注解。

要注意的是尽管有错误，`greeter.js` 文件还是被创建了。 就算你的代码里有错误，你仍然可以使用 TypeScript。但在这种情况下，TypeScript 会警告你代码可能不会按预期执行。

### 接口

让我们继续扩展这个示例应用。这里我们使用接口来描述一个拥有 `firstName` 和 `lastName` 字段的对象。 在 `TypeScript` 里，只在两个类型内部的结构兼容，那么这两个类型就是兼容的。 这就允许我们在实现接口时候只要保证包含了接口要求的结构就可以，而不必明确地使用 `implements` 语句。

```typescript
interface Person {
  firstName: string
  lastName: string
}

function greeter(person: Person) {
  return 'Hello, ' + person.firstName + ' ' + person.lastName
}

let user = {
  firstName: 'Yee',
  lastName: 'Huang'
}

console.log(greeter(user))
```

### 类

最后，让我们使用类来改写这个例子。 TypeScript 支持 JavaScript 的新特性，比如支持基于类的面向对象编程。

让我们创建一个 `User` 类，它带有一个构造函数和一些公共字段。因为类的字段包含了接口所需要的字段，所以他们能很好的兼容。

还要注意的是，我在类的声明上会注明所有的成员变量，这样比较一目了然。

```typescript
class User {
  fullName: string
  firstName: string
  lastName: string

  constructor(firstName: string, lastName: string) {
    this.firstName = firstName
    this.lastName = lastName
    this.fullName = firstName + ' ' + lastName
  }
}

interface Person {
  firstName: string
  lastName: string
}

function greeter(person: Person) {
  return 'Hello, ' + person.firstName + ' ' + person.lastName
}

let user = new User('Yee', 'Huang')

console.log(greeter(user))
```

重新运行 `tsc greeter.ts`，你会看到 TypeScript 里的类只是一个语法糖，本质上还是 `JavaScript` 函数的实现。

### 总结

到这里，你已经对 TypeScript 有了一个大致的印象，那么下一章让我们来一起学习 TypeScript 的一些常用语法吧。

## 4. 使用 webpack 打包 TS

### 下载依赖

```bash
# 2021年2月8日

yarn add -D typescript
yarn add -D webpack webpack-cli
yarn add -D webpack-dev-server
yarn add -D html-webpack-plugin clean-webpack-plugin
yarn add -D ts-loader
yarn add -D cross-env
```

### 入口 JS: src/main.ts

```typescript
// import './01_helloworld'

document.write('Hello Webpack TS!')
```

### index 页面: public/index.html

```html
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <meta http-equiv="X-UA-Compatible" content="ie=edge" />
    <title>webpack & TS</title>
  </head>
  <body></body>
</html>
```

### build/webpack.config.js

```javascript
const { CleanWebpackPlugin } = require('clean-webpack-plugin')
const HtmlWebpackPlugin = require('html-webpack-plugin')
const path = require('path')

const isProd = process.env.NODE_ENV === 'production' // 是否生产环境

function resolve(dir) {
  return path.resolve(__dirname, '..', dir)
}

module.exports = {
  mode: isProd ? 'production' : 'development',
  entry: {
    app: './src/main.ts'
  },

  output: {
    path: resolve('dist'),
    filename: '[name].[contenthash:8].js'
  },

  module: {
    rules: [
      {
        test: /\.tsx?$/,
        use: 'ts-loader',
        include: [resolve('src')]
      }
    ]
  },

  plugins: [
    new CleanWebpackPlugin({}),

    new HtmlWebpackPlugin({
      template: './public/index.html'
    })
  ],

  resolve: {
    extensions: ['.ts', '.tsx', '.js']
  },

  devtool: isProd ? 'cheap-module-source-map' : 'eval-cheap-source-map',

  devServer: {
    host: 'localhost', // 主机名
    stats: 'errors-only', // 打包日志输出输出错误信息
    port: 8081,
    open: true
  }
}
```

### 配置打包命令

```bash
"dev": "cross-env NODE_ENV=development webpack serve --config build/webpack.config.js",
"build": "cross-env NODE_ENV=production webpack --config build/webpack.config.js"
```

### 运行与打包

```bash
yarn dev
yarn build
```

## TypeScript 常用语法 