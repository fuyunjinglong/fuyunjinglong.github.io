---
title: TypeScript
date: 2024-01-01 07:33:16
categories:
- B_中级
toc: true # 是否启用内容索引入门
---

# 大纲

- [TypeScript5 极速进阶完全指南](https://www.bilibili.com/video/BV1VkPjzeEoW?spm_id_from=333.788.videopod.sections&vd_source=bd4c7d99d71adf64d6e88c65370e0247)
- [TS 学习指南1.8w字-阿宝哥](https://qingyewei.github.io/typeScript/guide#%E4%B8%80%E3%80%81typescript-%E6%98%AF%E4%BB%80%E4%B9%88)
- TS从入门到深度掌握-video
- 2022升级版typescript系统入门到项目实战-video
- TypeScript 全面进阶指南-video
- TypeScript 类型体操通关秘籍-video
- [轻松学 TypeScript-video-阿宝哥](https://www.bilibili.com/video/BV1sY4y1H7vk/?spm_id_from=333.1387.0.0&vd_source=bd4c7d99d71adf64d6e88c65370e0247)
- [20 道 TS 练习题-阿宝哥](https://mp.weixin.qq.com/s?__biz=MzI2MjcxNTQ0Nw==&mid=2247495521&idx=1&sn=dd26b5b4f2cd2c78dcbcc9fd15b27df7&scene=21#wechat_redirect)
- [三小时快速上手TypeScript](https://www.bilibili.com/video/BV1YS411w7Bf/?spm_id_from=333.337.search-card.all.click&vd_source=bd4c7d99d71adf64d6e88c65370e0247)
- [ts类型体操](https://github.com/type-challenges/type-challenges/blob/main/README.zh-CN.md)

**参考**

[TypeScript 入门教程](https://github.com/xcatliu/typescript-tutorial)

[深入理解 TypeScript](https://github.com/jkchao/typescript-book-chinese)

# 初级

## TypeScript 是什么

**一、定义**

> TS 是 JavaScript 的**超集**，增加了**静态类型系统**，编译成纯 JS 运行。

**二、优势**

> - **编译期发现错误**：类型问题写代码时就暴露，而非上线后
> - **智能提示**：补全、跳转、重构更可靠
> - **类型即文档**：利于团队协作

## TS 的基础类型

**一、定义**

按统一维度（类型本身的性质）分四类：

| 类别        | 类型                                                         | 判断标准                                   |
| ----------- | ------------------------------------------------------------ | ------------------------------------------ |
| ① 原始类型  | `string` `number` `boolean` `bigint` `symbol` `null` `undefined` | 对应单个原始值                             |
| ② 特殊类型  | `any` `unknown` `never` `void`                               | 类型系统的“元类型”，描述检查行为而非具体值 |
| ③ 结构类型  | 数组 `T[]` 元组 `[A, B]` 对象 `{...}` 函数 `(a) => b`        | 描述值的"形状"                             |
| ④ 组合/推导 | 联合 `A | B` 交叉 `A & B` 字面量 `'success'`                 | 由已有类型**运算或收窄**得到               |

**二、具体细节**

**特殊类型**

> - **enum（枚举）**：给一组命名常量赋予友好名称，是 TypeScript 相对 JavaScript 新增的类型typescriptlang.org
> - **unknown**：类型安全的 `any`，任何值都能赋给它，但使用前必须收窄
> - **never**：表示永远不会发生的值（如抛出异常或死循环的函数返回值）
> - **void**：表示"没有返回值"，常用于函数
> - **any**：关闭类型检查的"逃生舱口"，可以对它做任何操作

**结构类型**

> - **Array（数组）**：写法为 `number[]` 或 `Array<number>`，注意 `[number]` 是元组而非数组typescriptlang.org
> - **Tuple（元组）**：长度和每个元素类型都固定的数组，如 `[string, number]`typescriptlang.org
> - **Object（对象）**：用对象字面量形式描述属性和类型，如 `{ name: string; id: number }`
> - **Function（函数）**：通过箭头语法描述参数与返回值类型，如 `(a: string) => void`typescriptlang

**组合/推导**

> - **Union（联合类型）**：`string | number` 表示值可以是二者之一
> - **Literal（字面量类型）**：如 `"left" | "right"`，把值精确限定在几个字面量内

## any 和 unknown

**一、定义**

> - `any`：完全放弃检查，可任意赋值和调用，**会传染**整个调用链
> - `unknown`：可以接收任何值，但**使用前必须类型收窄**，类型安全
> - **结论**：接收不确定的外部数据用 `unknown`，新项目尽量不用 `any`。

```js
let u: unknown = 'hello';
u.toUpperCase(); // ❌ 报错
if (typeof u === 'string') {
  u.toUpperCase(); // ✅ 收窄后可用
}
```

## void 和 never

**一、定义**

**定义 → 场景 → 加分：never 穷举检查**

> - `void`：函数**没有返回值**（有返回但值为空）
> - `never`：**永远不会正常返回**（抛异常、死循环），是所有类型的底部类型

```js
function log(): void { console.log('hi'); }        // 正常执行完，无返回值
function fail(): never { throw new Error(); }       // 永不返回

// never 实战：穷举检查，漏分支编译报错
type Shape = 'circle' | 'square';
function area(s: Shape) {
  switch (s) {
    case 'circle': return 1;
    case 'square': return 2;
    default:
      const _check: never = s; // 新增类型但没写 case 时，此处报错
      return _check;
  }
}
```

## interface 和 type

**一、定义**

**相同点 → 不同点 → 选型建议**

**相同点**：都能描述对象、函数，都能被 extends/implements。

**选型**：对象结构用 `interface`，联合/工具类型用 `type`，团队统一即可。

| 维度     | interface      | type                         |
| -------- | -------------- | ---------------------------- |
| 描述范围 | 只能对象/函数  | 任意类型（联合、原始类型等） |
| 重复定义 | ✅ 自动声明合并 | ❌ 报错                       |
| 扩展方式 | `extends`      | `&` 交叉                     |

## 类型推论

**一、推论**

**定义 → 规则 → 必标场景**

> TS 能自动推断变量类型，多数情况无需手写。

```js
let count = 0;       // 推断为 number
const name = 'Tom';  // const 推断为字面量类型 'Tom'
```

**二、必须手动标注**

**必须显式标注的场景：**

```js
let x: number;                    // ① 声明时无初值
function add(a: number) { }       // ② 函数参数（必须标）
let list: string[] = [];          // ③ 空数组等推断不出预期类型
```

**三、进阶**

> **实践**：入口标注（参数、返回值），中间靠推论。

## 类型断言

**一、定义**

**定义 → 语法 → 风险**

> 断言是告诉编译器“我比它更清楚类型”，**纯编译期标注，无运行时转换**。

```js
const el = document.getElementById('app') as HTMLDivElement; // 推荐写法
```

**二、风险**

> **风险提示（加分）**：断言会骗过编译器，可能埋运行时雷。

```js
const num = 123 as unknown as string; // 双重断言绕过检查
num.toUpperCase(); // ❌ 运行时崩溃
```

## 联合类型要注意什么

**一、定义**

**定义 → 公共成员限制 → 收窄**

> 联合类型（`|`）表示“或”，但**只能访问所有类型的公共成员**，需先收窄。

```js
function format(x: string | number) {
  console.log(x.length); // ❌ number 没有 length
  if (typeof x === 'string') {
    console.log(x.length); // ✅ 收窄后可用
  }
}
```

## 可选属性 ? 和readonly

**一、定义**

**语法 → 语义**

> **加分点**：`readonly` 只是编译期检查，运行时无保护；真不可变需 `Object.freeze`。

```js
interface User {
  id: number;               // 必填
  name?: string;            // 可选：实际类型是 string | undefined
  readonly createdAt: Date; // 只读：初始化后不可改
}

u.createdAt = new Date(); // ❌ 报错
```

## tsconfig.json常用配置

**一、定义**

**作用 → 分组讲 → 强调 strict**

> **结论**：新项目必须开 `strict`；老项目优先开 `strictNullChecks`。

**二、代码**

```js
{
  "compilerOptions": {
    "target": "ES2020",       // 编译目标版本
    "module": "ESNext",       // 模块规范
    "outDir": "./dist",       // 输出目录
    "strict": true,           // ⭐ 严格模式总开关
    "strictNullChecks": true, // ⭐ null 检查（收益最高）
    "paths": { "@/*": ["src/*"] }, // 路径别名
    "skipLibCheck": true      // 跳过 node_modules 检查，提速
  },
  "include": ["src/**/*"]
}
```

# 中级

## 泛型是什么

**一、定义**

**定义 → 解决的矛盾 → 约束 → 场景**

> 泛型是**类型的参数化**：定义时不写死，使用时才确定，实现**类型安全的复用**。

```js
// 两难：写死不能复用；用 any 丢失检查
// 泛型两全其美
function identity<T>(arg: T): T { return arg; }
identity(1);     // T 推断为 number
identity('str'); // T 推断为 string
```

**二、泛型约束（extends）**

```js
// 限制 T 必须有 length
function logLen<T extends { length: number }>(arg: T) {
  return arg.length;
}

// keyof 约束：属性名合法 + 返回值类型精确
function getProp<T, K extends keyof T>(obj: T, key: K): T[K] {
  return obj[key];
}
getProp({ name: 'Tom' }, 'age'); // ❌ 编译期报错
```

**三、场景**

> `request<T>` 请求封装、`Promise<T>`、泛型组件。

## 常用工具类型

**一、定义**

**分类列举 → 底层关键字 → 手写**

**二、代码**

**1、工具类型**

```
Partial<T> / Required<T> / Readonly<T>  // 属性可选/必选/只读
Pick<T, K> / Omit<T, K>                 // 挑选/排除属性
Record<K, V>                            // 键值对
ReturnType<T> / Parameters<T>           // 提取返回值/参数类型
```

**2、手写实现**

**底层三大关键字**：`keyof`（取键联合）、`typeof`（值→类型）、`in`（遍历构造）。

```js
type MyPartial<T> = { [K in keyof T]?: T[K] };
type MyPick<T, K extends keyof T> = { [P in K]: T[P] };
type MyExclude<T, U> = T extends U ? never : T;   // 联合类型分发
type MyReturnType<T extends (...args: any) => any> =
  T extends (...args: any) => infer R ? R : never;
type MyOmit<T, K extends keyof T> = MyPick<T, MyExclude<keyof T, K>>; // 组合拳
```

## 条件类型和 infer

**一、定义**

**条件类型 → 分发特性（高频坑）→ infer**

**二、代码**

```js
// 条件类型：类型层面的三元表达式
type IsString<T> = T extends string ? true : false;

// 分布式：裸类型参数遇到联合类型会自动分发（高频考点）
type ToArray<T> = T extends any ? T[] : never;
type R = ToArray<string | number>; // string[] | number[]，不是 (string|number)[]

// 禁止分发：包一层元组
type NoDist<T> = [T] extends [any] ? T[] : never;

// infer：条件类型中"捕获"某个位置的类型
type ElementType<T> = T extends (infer U)[] ? U : never;
type Awaited<T> = T extends Promise<infer V> ? Awaited<V> : T; // 递归版
type R2 = Awaited<Promise<Promise<number>>>; // number
```

## 类型收窄

**一、定义**

**定义 → 内置方式 → 可辨识联合 → 自定义保护**

> 类型收窄是编译器通过**控制流分析**，在分支中把宽类型缩小为精确类型。
>
> **辨析（加分）**：`is` 谓词基于运行时逻辑，编译与运行一致；`as` 断言纯编译期欺骗，前者更安全。

**二、代码**

```js
// 内置：typeof / instanceof / in / 字面量相等
if (typeof x === 'string') x.toUpperCase();
if ('swim' in pet) pet.swim();

// 可辨识联合（重点）：kind 字段自动收窄
interface Circle { kind: 'circle'; radius: number }
interface Square { kind: 'square'; size: number }
type Shape = Circle | Square;

function area(s: Shape) {
  if (s.kind === 'circle') return Math.PI * s.radius ** 2; // 自动为 Circle
  return s.size ** 2; // 剩余自动为 Square
}

// 自定义类型保护：is 谓词
function isFish(pet: Fish | Bird): pet is Fish {
  return 'swim' in pet;
}
```

## keyof 和 typeof 联合使用

**一、定义**

**拆开讲 → 组合 → 场景**

> - `typeof`：**值世界 → 类型世界**的桥梁
> - `keyof`：类型 → 键的联合
> - **场景**：枚举替代方案、类型安全的配置读取。

**二、代码**

```js
const STATUS = { PENDING: 0, SUCCESS: 1 } as const;

type Status = typeof STATUS[keyof typeof STATUS]; // 0 | 1
type Keys = keyof typeof STATUS;                  // 'PENDING' | 'SUCCESS'

function handle(s: Status) {}
handle(STATUS.SUCCESS); // ✅
handle(99);             // ❌ 编译期拦截
```

## 声明文件（.d.ts）和 declare

**一、定义**

**场景 → 语法 → 实战**

> - 声明文件为 **JS 库 / 全局变量 / 非 TS 资源**提供类型描述，不产生运行时代码。
> - **要点**：优先装 `@types/xxx`；`declare` 的东西必须运行时真实存在。

**二、代码**

```js
// declare var/function：全局声明
declare const VERSION: string;

// declare module：给无类型 npm 包补类型、声明资源模块
declare module '*.module.css' {
  const classes: { [key: string]: string };
  export default classes;
}

// declare global：扩展全局对象（工程中极常见）
declare global {
  interface Window {
    __APP_CONFIG__: { apiUrl: string };
  }
}
```

## 枚举

**一、定义**

**坑 → as const 方案 → 对比**

**二、代码**

**坑**

```js
// 坑 ①：数字枚举不安全，任意 number 都能通过
enum E { A, B }
const e: E = 99; // ✅ 竟然不报错
// 坑 ②：产生运行时代码（TS 少数不"擦除"的特性）
```

**as const 替代（推荐）**

零运行时开销、类型更严格，是现代 TS 项目推荐做法。

```js
const Status = { Loading: 'LOADING', Success: 'SUCCESS' } as const;
type Status = typeof Status[keyof typeof Status]; // 'LOADING' | 'SUCCESS'
```

## strictNullChecks 开启后如何处理空值

**一、定义**

**为什么开 → 手段列表 → 优先级**

> **优先级**：可选链 / `??` > 收窄 > `!`（最后手段）。`||` 与 `??` 的区别是经典追问。

**二、代码**

```js
// ① 可选链 ?.
const city = user?.address?.city;

// ② 空值合并 ??（注意与 || 区别：0 和 '' 不被吞）
const count = input ?? 0; // input 为 0 时得到 0；用 || 会得到 10

// ③ 类型收窄
if (user !== null) user.name;

// ④ 非空断言 !（慎用，骗编译器）
user!.name;
```

## React 如何正确使用 TS

> - **Props → 事件 → Hooks → 泛型组件**
> - **加分**：`React.FC` 现在不推荐——隐式 children、泛型支持差。

## 动态key的对象类型怎么定义

**结论**：能用 `Record<K extends keyof any, V>` 限定范围，就不要用纯 `string` 索引。

```js
// ① 索引签名
type Scores = { [subject: string]: number };

// ② Record（更常用）
type Scores2 = Record<string, number>;

// ③ 限定 key 范围（最安全）
type Subject = 'math' | 'english';
type Scores3 = Record<Subject, number>;

// 混合：已知 key + 任意扩展
type Config = {
  name: string;
  [key: string]: string | number; // 索引签名会约束已知 key 的类型
};
```



# 高级

## 类型兼容是结构化的还是名义

**一、定义**

**结论 → 验证 → 隐患与品牌类型解法**

**二、代码**

TS 采用**结构化类型**：兼容性由成员结构决定，与类型名无关。

```js
interface Point { x: number; y: number }
interface Coord { x: number; y: number }
const p: Point = { x: 1, y: 2 };
const c: Coord = p; // ✅ 结构相同即兼容，无需显式关联
```

**隐患与解法（高级加分点）**：结构相同但语义不同的类型会误兼容。

```js
type UserId = string;
type OrderId = string;
const uid: UserId = someOrderId; // ✅ 通过，但可能是业务 bug

// 品牌类型解决
type Brand<T, B extends string> = T & { readonly __brand: B };
type UserId = Brand<string, 'UserId'>;
type OrderId = Brand<string, 'OrderId'>;
const uid2: UserId = someOrderId; // ❌ 现在拦截了
```

## 协变与逆变

**一、定义**

**定义 → 函数双位置规则 → 口诀 → 方法双变特例**

> - **协变**：兼容方向与泛型参数方向一致（**返回值位置**）
> - **逆变**：方向相反（**函数参数位置**，strictFunctionTypes 下）
> - **口诀**：“**输入要宽，输出可窄**”（里氏替换原则的体现）。
> - **特例**：方法的参数是**双变的**（既协变又逆变），为兼容传统 OOP 继承写法。

**二、代码**

```js
interface Animal { name: string }
interface Dog extends Animal { bark(): void }

type HandleDog = (d: Dog) => void;
type HandleAnimal = (a: Animal) => void;

const h: HandleDog = (a: Animal) => {}; // ✅ 参数逆变：能处理父类的函数可替换
// 反向赋值不安全：只能处理 Dog 的函数被传入普通 Animal 会崩
```

## 类型擦除

**一、定义**

**编译流程 → 擦除概念 → 三个推论**

> **流程**：Scanner → Parser → AST → **Checker（类型检查）** → Emitter（输出 JS）。
>
> **擦除**：编译产物中**所有类型信息被删除**，类型只存在于编译期。

**三个工程推论（高级思维）：**

> 1. TS **零运行时开销**，可放心用复杂类型
> 2. TS **无运行时保护**——接口数据不匹配 TS 拦不住，需 zod 等做运行时校验并与类型联动
> 3. 枚举、装饰器是少数产生运行时代码的例外，所以现代项目用 `as const` 替代枚举

## 手写递归工具类型：DeepPartial / DeepReadonly

**一、定义**

**需求 → 单层回顾 → 递归版 → 边界处理**

> **延伸**：递归过深会触发 “Type instantiation is excessively deep” 错误，可用延迟求值缓解。

**二、代码**

```js
// DeepPartial：递归可选化（配置合并、表单草稿场景）
type DeepPartial<T> = {
  [K in keyof T]?: T[K] extends object
    ? T[K] extends Function ? T[K]   // 边界：函数不递归
    : T[K] extends any[] ? T[K]      // 边界：数组按需处理
    : DeepPartial<T[K]>
    : T[K];
};

// DeepReadonly：深度只读（Redux state）
type DeepReadonly<T> = {
  readonly [K in keyof T]: T[K] extends object
    ? T[K] extends Function ? T[K] : DeepReadonly<T[K]>
    : T[K];
};

// 实战：类型安全的 merge
function merge<T>(base: T, patch: DeepPartial<T>): T {
  return { ...base, ...patch };
}
```

## 类型体操操作元组和字符串

**一、定义**

**递归元组套路 → 模板字面量 → 库的应用**

> 核心套路：`extends [infer F, ...infer R]` 拆元组 + 递归。
>
> **应用**：Vue3 `defineProps`、tRPC 端到端类型安全都建立在这些能力上。

**二、代码**

```js
// ① 数组扁平化
type Flatten<T extends any[]> =
  T extends [infer F, ...infer R]
    ? F extends any[] ? [...Flatten<F>, ...Flatten<R>] : [F, ...Flatten<R>]
    : [];
type F1 = Flatten<[1, [2, [3]], 4]>; // [1, 2, 3, 4]

// ② 模板字面量类型：提取路由参数（vue-router 原理）
type ExtractParams<T extends string> =
  T extends `${string}:${infer P}/${infer Rest}`
    ? P | ExtractParams<Rest>
    : T extends `${string}:${infer P}` ? P : never;

type Params = ExtractParams<'/user/:id/post/:postId'>; // 'id' | 'postId'
```

## 装饰器原理

**一、定义**

**本质 → IoC 实现 → NestJS 关联 → 标准化进展**

> 装饰器本质是**高阶函数**：`@dec` 等价于 `dec(Class)`。
>
> **NestJS**：配合 `reflect-metadata` 存储设计时类型元数据，实现构造函数自动注入。
> **标准化**：TS 5.0 已支持 ECMAScript 标准装饰器，与旧实验性语法**不兼容**。

二、代码

```js
// 简易 IoC依赖注入（NestJS 原理）
const container = new Map<string, any>();

function Injectable(): ClassDecorator {
  return (target: any) => container.set(target.name, new target());
}

function Inject(token: string): PropertyDecorator {
  return (target: any, key: string) => {
    Object.defineProperty(target, key, {
      get: () => container.get(token), // 延迟获取
    });
  };
}

@Injectable()
class DbService { query() { return 'data'; } }

@Injectable()
class UserService {
  @Inject('DbService') db!: DbService;
  getUser() { return this.db.query(); }
}
```

## 端到端类型安全

**一、定义**

**问题定义 → 三方案对比 → zod + tRPC**

> **问题**：手动定义的接口类型与后端实际返回易不一致，且类型擦除后运行时无校验。
>
> **结论**：TS 解决“编译期正确”，zod 解决“运行时正确”，通过 `z.infer` 打通才是完整闭环。

**二、代码**

| 方案        | 原理                               | 代表               |
| ----------- | ---------------------------------- | ------------------ |
| Schema 生成 | 从 OpenAPI 自动生成类型            | openapi-typescript |
| 运行时校验  | schema 定义类型 + 校验，单一数据源 | zod                |
| RPC 端到端  | 前端直接导入后端函数类型           | tRPC               |

```js
// zod：运行时校验 + 编译期类型同步，永不失联
const UserSchema = z.object({ id: z.number(), name: z.string() });
type User = z.infer<typeof UserSchema>; // 类型由 schema 推导

function parseUser(raw: unknown): User {
  return UserSchema.parse(raw); // 运行时校验失败直接抛错
}
```

## 路径别名运行报错

**一、定义**

**解析策略 → 三处配置对齐问题 → 解法**

> **本质**：别名涉及**三个环节各一套配置**，必须对齐：
>
> 只配一处就会出现“IDE 不飘红但运行 `Cannot find module '@/xxx'`”。
> **解法**：`vite-tsconfig-paths` 等插件复用 tsconfig，保证**单一数据源**。

**二、代码**

```js
① 类型检查/IDE：tsconfig.json → paths
② 构建运行：Vite/webpack → resolve.alias
```

```js
// tsconfig.json —— 只管类型和 IDE
{ "compilerOptions": { "baseUrl": ".", "paths": { "@/*": ["src/*"] } } }
```

```js
// vite.config.ts —— 只管实际构建
resolve: { alias: { '@': '/src' } }
```

## 存量 JS 项目做 TS 迁移

**一、定义**

**策略 → 分步计划 → 度量指标**

> **策略**：渐进式迁移（`allowJs: true`），不搞大爆炸重写。
>
> **度量**：type-coverage 类型覆盖率、`any` 数量趋势。
> **关键原则**：**类型错误数量只减不增**。

**二、代码**

```js
第 1 步：基建 —— allowJs 开启，strict 先降级
第 2 步：外围先行 —— 工具函数、常量先转 .ts（依赖少、收益高）
第 3 步：由底向上 —— utils → api 层 → store → 组件 → 页面
        先 any 顶住，逐步补类型
第 4 步：收紧 —— 开 noImplicitAny、strictNullChecks，
        CI 加 tsc --noEmit 卡口
```

## 类型体操的能力边界

**能力清单 → 边界问题 → 态度总结**

**能力**

> 条件类型、映射类型、递归类型、模板字面量类型、infer，可组合实现复杂推导（Vue3、tRPC 大量使用）。

**边界**

> 1. 递归深度限制：报 “Type instantiation is excessively deep”
> 2. 复杂类型导致 **IDE 卡顿、编译变慢**
> 3. 类型报错信息可读性差，排查成本高

**正确态度（高分总结）**

> - 类型体操的目的是**提升类型安全和开发体验**，不是炫技
> - 当类型复杂到“看不懂报错”时，宁可简化类型或用少量断言
> - **可维护性 > 类型完备性**；运行时正确靠 zod 补位，而非把所有约束塞进类型层

# TS类型体操

- [TS类型体操1](https://juejin.cn/post/7073070819219505166)
- [TS类型体操2](https://juejin.cn/post/7077464587313872932)

**一、定义**

> 利用 TS 类型系统（泛型、infer、条件、映射类型）写复杂类型计算。业务上用于：封装通用工具类型、组件 props 自动推导、接口响应自动生成类型；不要过度写复杂体操，会增加编译负担、可读性变差。



