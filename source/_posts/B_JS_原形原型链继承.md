---
title: 原形原型链继承
date: 2022-05-29 07:33:16
categories:
- B_JS
toc: true # 是否启用内容索引
---

# 原型、原型链、继承

## **核心**

> **原型存在的意义就是组成原型链**：引用类型皆对象，每个对象都有原型，原型也是对象，也有它自己的原型，一层一层，组成原型链。
>
> **原型链存在的意义就是继承**：访问对象属性时，在对象本身找不到，就在原型链上一层一层找。说白了就是一个对象可以访问其他对象的属性。
>
> **继承存在的意义就是属性共享**：好处有二：一是代码重用，字面意思；二是可扩展，不同对象可能继承相同的属性，也可以定义只属于自己的属性。

## 标准

js之父在设计js原型、原型链的时候遵从以下两个准则

>  **准则1：原型对象（即Person.prototype）的constructor指向构造函数本身**
>
>  Person.prototype.constructor == Person //
>
>  **准则2：实例的__proto__ 保存着构造函数的prototype即实例（即person01）的__proto__和原型对象指向同一个地方**
>
>  person01.__proto__ == Person.prototype

- Person.prototype是显示原形属性
- person01.__proto__是隐式原形属性

## 定义

原型：proto是对象object的原形属性，所以proto叫对象的原形

原型对象：prototype是函数fn的原形属性，所以prototype叫fn的原形对象。注意原型对象中默认有一个`constructor`属性，指回该构造函数。

原型链：一句话就是以对象为基准，以proto为连接点，一直到Object.prototype为止的一条链条。(原型链顶层Object.prototype._proto__=null)

> 官方描述
>
> 在 JavaScript 中，实例对象在读取属性时总是先检查私有属性。如果存在，则会返回私有属性值；否则就会检索 prototype 原型；如果找到同名属性，则返回 prototype 原型的属性值。
>
> prototype 原型允许引用其他对象。如果在 prototype 原型中没有找到指定的属性，则 JavaScript 将会根据引用关系，继续检索 prototype 原型对象的 prototype 原型，以此类推。

```
// 原型
var Test = function(){
    a:111
}
Test.prototype.b=222;
Object.prototype.c=333;
const test = new Test();
console.log(test);
console.log(test.__proto__);
console.log(Test.prototype);
console.log(test.__proto__===Test.prototype);//true
console.log(Test.prototype.__proto__===Object.prototype);//true
console.log(Object.prototype.__proto__);// 顶层null
// 原型链
test:{
    a:111,
    __proto__:Test.prototype={
        b:222,
        __proto__:Object.prototype={
            c:333,
            __proto__:null
        }
    }
}
// 模拟一下js引擎读取对象属性
function getProperty(obj, propName) {
    // 在对象本身查找
    if (obj.hasOwnProperty(propName)) {
        return obj[propName]
    } else if (obj.__proto__ !== null) {
    // 如果对象有原型，则在原型上递归查找
        return getProperty(obj.__proto__, propName)
    } else {
    // 直到找到Object.prototype，Object.prototype.__proto__为null，返回undefined
        return undefined
    }
}
```

## 创建对象

对象的创建方式主要有两种，一种是`new`操作符后跟函数调用，另一种是字面量表示法。(字面量表示法可以理解为语法糖，本质还是new)。

**任何一个函数都可以当做构造函数**。

```
// 惯例，构造函数应以大写字母开头
function Person(name) {
  // 函数内this指向构造的对象
  // 构造一个name属性
  this.name = name
  // 构造一个sayName方法
  this.sayName = function() {
    console.log(this.name)
  }
}

// 使用自定义构造函数Person创建对象
let person = new Person('logan')
person.sayName() // 输出：logan
```

## 函数对象的原型链

函数都是由`Function`原生构造函数创建的，所以函数的`__proto__`属性指向`Function`的`prototype`属性。

注意一个特例：Function`的`__proto__`属性指向`Function.prototype

```
let fn = function() {}
// 函数（包括原生构造函数）的原型对象为Function.prototype
fn.__proto__ === Function.prototype // true
Array.__proto__ === Function.prototype // true
Object.__proto__ === Function.prototype // true
```

## Foo经典原型图

<img src="/img/image-20220605092641925.png" alt="image-20220605092641925" style="zoom:80%;" />

分3条线路分析一清二楚：

- 第1条路：左上角f1,f2
- 第2条路：构造函数Foo
- 第3条路：左侧o1,o2
- 第4条路：原生构造函数`Object`和`Function`

**第1条路：左上角f1,f2**

```
// f1、f2都是通过new Foo()创建的对象，构造函数为Foo，所以有
f1.__proto__ === Foo.prototype
// Foo.prototype为普通对象，构造函数为Object，所以有
Foo.prototype.__proto === Object.prototype
// Object.prototype没有原型对象
Object.prototype.__proto__ === null
```

**第2条路：构造函数Foo**

```
// Foo是个函数对象，构造函数为Function
Foo.__proto__ === Function.prototype
// Function.prototype为普通对象，构造函数为Object，所以有
Function.prototype.__proto__ === Object.prototype
```

**第3条路：左侧o1,o2**

对原生构造函数`Object`创建的`o1`、`o2`下手：

```javascript
// o1、o2构造函数为Object
o1.__proto__ === Object.prototype
```

**第4条路：原生构造函数`Object`和`Function`**

```
// 原生构造函数也是函数对象，其构造函数为Function
Object.__proto__ === Function.prototype
// 特例
Function.__proto__ === Function.prototype
```

## 举一反三

### `instanceof`操作符

`typeof`运算符判断基本类型可以，但对引用类型无法判断(函数对象会返回`function`外，其他都返回`object`)。

**关键一句话**：`instanceof`用于检查右边变量的原型存在于左边变量的原型链上。其实它表示的是一种原型链继承的关系

> MDN描述：instanceof运算符用于测试构造函数的prototype属性是否出现在对象的原型链中的任何位置

```html
instanceof`操作符左边是一个对象，右边是一个构造函数，在左边对象的原型链上查找，直到找到右边构造函数的prototype属性就返回`true`，或者查找到顶层`null`（也就是`Object.prototype.__proto__`），就返回`false
```

**实现思路：**

> 1. 首先 instanceof 左侧必须是对象, 才能找到它的原型链
> 2. instanceof 右侧必须是函数, 函数才会prototype属性
> 3. 迭代 , 左侧对象的原型不等于右侧的 prototype时, 沿着原型链重新赋值左侧

```
// 手写instanceOf-递归版本
function instanceOfMe(obj, Constructor) { // obj 表示左边的对象，Constructor表示右边的构造函数
  let leftP = obj.__proto__ // 取对象隐式原型
    let rightP = Constructor.prototype // 取构造函数显示原型
    // 到达原型链顶层还未找到则返回false
    if (leftP === null) {
        return false
    }
    // 对象实例的隐式原型等于构造函数显示原型则返回true
    if (leftP === rightP) {
        return true
    }
    // 查找原型链上一层
    return instanceOfMe(obj.__proto__, Constructor)
}
// 手写instanceOf-非递归版本
function instanceOfMe(L, R) { // L 表示左边的对象，R表示右边的构造函数
    // 验证如果为基本数据类型，就直接返回false
    const baseType = ['string', 'number','boolean','undefined','symbol']
    if(baseType.includes(typeof(L))) { return false }
    
    let RP  = R.prototype;  //取 R 的显示原型
    L = L.__proto__;       //取 L 的隐式原型
    while(true){           // 无线循环的写法（也可以使 for(;;) ）
        if(L === null){    //找到最顶层
            return false;
        }
        if(L === RP){       //严格相等
            return true;
        }
        L = L.__proto__;  //没找到继续向上一层原型链查找
    }
}
```

可以解释令人费解的现象：

```
fn instanceof Object //true
// 1. fn.__proto__ === Function.prototype
// 2. fn.__proto__.__proto__ === Function.prototype.__proto__ === Object.prototype
arr instanceof Object //true
// 1. arr.__proto__ === Array.prototype
// 2. arr.__proto__.__proto__ === Array.prototype.__proto__ === Object.prototype
Object instanceof Object // true
// 1. Object.__proto__ === Function.prototype
// 2. Object.__proto__.__proto__ === Function.prototype.__proto__ === Object.prototype
Function instanceof Function // true
// Function.__proto__ === Function.prototype
```

### `Object.create`

其实是创建对象的第三种方法，是ES5提供的，原理：将传入的对象作为原型

```
// 手写Object.create
function createObj(proto) {
    function F() {}
    F.prototype = proto
    return new F()
}
```

### `new`操作符

四件事：

1.创建一个空对象

2.把该对象的`__proto__`属性指向`Sub.prototype`

3.让构造函数里的`this`指向新对象，然后执行构造函数，

4.返回该对象

依然来模拟实现一下：

```javascript
function myNew (fun) {
  return function () {
    // 创建一个新对象且将其隐式原型指向构造函数原型
    let obj = {
      __proto__ : fun.prototype
    }
    // 执行构造函数
    fun.call(obj, ...arguments)
    // 返回该对象
    return obj
  }
}

function person(name, age) {
  this.name = name
  this.age = age
}
let obj = myNew(person)('chen', 18) // {name: "chen", age: 18}
```

### Function & Object 鸡蛋问题

不必深究，[鸡蛋问题原文](https://github.com/yygmind/blog/issues/35)

**参考**

[深入JavaScript系列（六）：原型与原型链](https://juejin.cn/post/6844903749345886216#heading-5)

[深入理解javascript原型和闭包（完结）](https://www.cnblogs.com/wangfupeng1988/p/3977924.html)

# 闭包大合集

## **定义**

闭包就是能够读取其他函数内部变量的函数

闭包的形成条件是内部函数需要通过外部函数 return 给返回出来，如下例所示：

```js
function funOne(){    // 外部函数
    var num = 0;      // 局部变量
    function funTwo(){   // 内部函数
        num++;                 
        return num;
    }
    return funTwo;
}
var fun = funOne();             // 返回函数 funTwo
```

首先要理解全局变量和局部变量，函数内部可以读取全局变量，但函数外部无法读取函数内部局部变量。

闭包就是能够读取其他函数内部变量的函数。确定吗？

```js
function funOne(){    // 外部函数
    var num = 0;      // 局部变量
    function funTwo(){   // 内部函数
        num++; 
        console.log(num);           
    }
     funTwo();
}
执行funOne();//不是闭包

function funOne(){    // 外部函数
    var num = 0;      // 局部变量
    num++; 
    return num
}
var fun = funOne();
执行fun;//不是闭包
```

真正的闭包：闭包是将函数内部和函数外部连接的桥梁。

本质：funOne()的执行结果赋给了全局变量fun,导致的结果是funTwo和num始终在内存中没有回收。

```js
function funOne(){    // 外部函数
    var num = 0;      // 局部变量
    function funTwo(){   // 内部函数
        num++; 
        console.log('打印：'+num);           
        return num;//对于闭包来说，可有可无
    }
    return funTwo;
}
// funOne()的执行结果是闭包
var fun = funOne();
fun()

简化写法：
function funOne(){    // 外部函数
    var num = 0;      // 局部变量
    return function (){   // 内部函数
        num++; 
        console.log('打印：'+num);           
        return num;//对于闭包来说，可有可无
    }
}
var fun = funOne();
fun()
```

**闭包拥有自己独立的作用域**

```js
var fun = funOne();
var fun2 = funOne();
fun() // 1
fun() // 2
fun() // 3
fun2() // 1
fun2() // 2
```

## 为什么需要闭包

局部变量无法共享和长久保存，而全局变量可能造成变量污染，当我们希望有一种机制既可以长久保存变量，又不会造成全局污染，所有有了闭包。

## **闭包的作用**

- 读取函数内部的变量
- 让这些变量的值始终保持在内存中
- 方便调用上下文的局部变量，利于代码封装

## **闭包的9个使用场景**

1. 返回值（最常用）
2. 函数赋值
3. 函数参数
4. IIFE（自执行函数）
5. 循环赋值
6. getter和setter
7. 迭代器（执行一次函数往下取一个值）
8. 首次区分（相同的参数，函数不会重复执行）
9. 缓存

**1.返回值（最常用）**

```
//1.返回值 最常用的
    function fn(){
        var name="hello";
        return function(){
            return name;
        }
    }
    var fnc = fn();
    console.log(fnc())//hello
```

**2.函数赋值**

```
var fn2;
function fn(){
    var name="hello";
    //将函数赋值给fn2
    fn2 = function(){
        return name;
    }
}
fn()//要先执行进行赋值，
console.log(fn2())//执行输出fn2
```

在闭包里面给fn2函数设置值，闭包的形式把name属性记忆下来，执行会输出 hello。

**3.函数参数**

```
function fn(){
    var name="hello";
    return function callback(){
        return name;
    }
}
var fn1 = fn()//执行函数将返回值（callback函数）赋值给fn1，
 
function fn2(f){
    //将函数作为参数传入
    console.log(f());//执行函数，并输出
}
fn2(fn1)//执行输出fn2
```

用闭包返回一个函数，把此函数作为另一个函数的参数，在另一个函数里面执行这个函数，最终输出 hello

**4.IIFE（自执行函数）**

```
(function(){
        var name="hello";
        var fn1= function(){
            return name;
        }
        //直接在自执行函数里面调用fn2，将fn1作为参数传入
        fn2(fn1);
    })()
    function fn2(f){
        //将函数作为参数传入
        console.log(f());//执行函数，并输出
    }
```

直接在自执行函数里面将封装的函数fn1传给fn2，作为参数调用同样可以获得结果 hello

**5.循环赋值**

```
//每秒执行1次，分别输出1-10
for(var i=1;i<=10;i++){
    (function(j){
        //j来接收
        setTimeout(function(){
            console.log(j);
        },j*1000);
    })(i)//i作为实参传入
}
```

如果不采用闭包的话，会有不一样的情况，可以看我自己 闭包 的文章。

**6.getter和setter**

```
function fn(){
        var name='hello'
        setName=function(n){
            name = n;
        }
        getName=function(){
            return name;
        }
         
        //将setName，getName作为对象的属性返回
        return {
            setName:setName,
            getName:getName
        }
    }
    var fn1 = fn();//返回对象，属性setName和getName是两个函数
    console.log(fn1.getName());//getter
        fn1.setName('world');//setter修改闭包里面的name
    console.log(fn1.getName());//getter
```

第一次输出 hello 用setter以后再输出 world ，这样做可以封装成公共方法，防止不想暴露的属性和函数暴露在外部。

**7.迭代器（执行一次函数往下取一个值）**

```
var arr =['aa','bb','cc'];
function incre(arr){
    var i=0;
    return function(){
        //这个函数每次被执行都返回数组arr中 i下标对应的元素
         return arr[i++] || '数组值已经遍历完';
    }
}
var next = incre(arr);
console.log(next());//aa
console.log(next());//bb
console.log(next());//cc
console.log(next());//数组值已经遍历完
```

**8.首次区分（相同的参数，函数不会重复执行）**

```
var fn = (function(){
               var arr=[];//用来缓存的数组
                   return function(val){
                       if(arr.indexOf(val)==-1){//缓存中没有则表示需要执行
                           arr.push(val);//将参数push到缓存数组中
                           console.log('函数被执行了',arr);
                           //这里写想要执行的函数
                       }else{
                           console.log('此次函数不需要执行');
                       }
                       console.log('函数调用完打印一下，方便查看已缓存的数组：',arr);
                   }
               })();
        
       fn(10);
       fn(10);
       fn(1000);
       fn(200);
       fn(1000);
```

可以明显的看到首次执行的会被存起来，再次执行直接取。

**9.缓存**

```
//比如求和操作，如果没有缓存，每次调用都要重复计算，采用缓存已经执行过的去查找，查找到了就直接返回，不需要重新计算
      
     var fn=(function(){
        var cache={};//缓存对象
        var calc=function(arr){//计算函数
            var sum=0;
            //求和
            for(var i=0;i<arr.length;i++){
                sum+=arr[i];
            }
            return sum;
        }
         
        return function(){
            var args = Array.prototype.slice.call(arguments,0);//arguments转换成数组
            var key=args.join(",");//将args用逗号连接成字符串
            var result , tSum = cache[key];
            if(tSum){//如果缓存有   
                console.log('从缓存中取：',cache)//打印方便查看
                result = tSum;
            }else{
                //重新计算，并存入缓存同时赋值给result
                result = cache[key]=calc(args);
                console.log('存入缓存：',cache)//打印方便查看
            }
            return result;
        }
     })();
    fn(1,2,3,4,5);
    fn(1,2,3,4,5);
    fn(1,2,3,4,5,6);
    fn(1,2,3,4,5,8);
    fn(1,2,3,4,5,6);
```





**1.闭包结合匿名函数使用，如setTimeout**

```js
//原生的setTimeout传递的第一个函数不能带参数
 //通过闭包可以实现传参效果
    function func(param){
        return function(){
            alert(param)
        }
    }
    var f1 = func(1);
    setTimeout(f1,1000);
```

**2.参数回调**

```js
function changeSize(size){
        return function(){
            document.body.style.fontSize = size + 'px';
        };
    }

    var size12 = changeSize(12);
    ocument.getElementById('size-12').onclick = size12;
```

**3.封装变量**

```js
//用闭包定义能访问私有函数和私有变量的公有函数。
    var counter = (function(){
        var privateCounter = 0; //私有变量
        function change(val){
            privateCounter += val;
        }
        return {
            increment:function(){   //三个闭包共享一个词法环境
                change(1);
            },
            decrement:function(){
                change(-1);
            },
            value:function(){
                return privateCounter;
            }
        };
    })();
counter.increment();
counter.increment();//2
```

闭包相关例子

[闭包例子1](https://cnodejs.org/topic/5d39c5259969a529571d73a8)

# JS的8种继承方案

## 原型链继承

继承的本质就是复制，即重写原型对象，代之以一个新类型的实例。

```
function SuperType() {
    this.property = true;
}

SuperType.prototype.getSuperValue = function() {
    return this.property;
}

function SubType() {
    this.subproperty = false;
}

// 这里是关键，创建SuperType的实例，并将该实例赋值给SubType.prototype
SubType.prototype = new SuperType(); 

SubType.prototype.getSubValue = function() {
    return this.subproperty;
}

var instance = new SubType();
console.log(instance.getSuperValue()); // true
```

缺点：多个实例对引用类型的操作会被篡改。

```
function SuperType(){
  this.colors = ["red", "blue", "green"];
}
function SubType(){}

SubType.prototype = new SuperType();

var instance1 = new SubType();
instance1.colors.push("black");
alert(instance1.colors); //"red,blue,green,black"

var instance2 = new SubType(); 
alert(instance2.colors); //"red,blue,green,black"
```

## 借用构造函数继承

使用父类的构造函数来增强子类**实例**，等同于复制父类的实例给子类（不使用原型）

```js
function  SuperType(){
    this.color=["red","green","blue"];
}
function  SubType(){
    //继承自SuperType
    SuperType.call(this);
}
var instance1 = new SubType();
instance1.color.push("black");
alert(instance1.color);//"red,green,blue,black"

var instance2 = new SubType();
alert(instance2.color);//"red,green,blue"
复制代码
```

核心代码是`SuperType.call(this)`，创建子类实例时调用`SuperType`构造函数，于是`SubType`的每个实例都会将SuperType中的属性复制一份。

缺点：

- 只能继承父类的**实例**属性和方法，不能继承原型属性/方法
- 无法实现复用，每个子类都有父类实例函数的副本，影响性能

## 组合继承

组合上述两种方法就是组合继承。用原型链实现对**原型**属性和方法的继承，用借用构造函数技术来实现**实例**属性的继承。

```js
function SuperType(name){
  this.name = name;
  this.colors = ["red", "blue", "green"];
}
SuperType.prototype.sayName = function(){
  alert(this.name);
};

function SubType(name, age){
  // 继承属性
  // 第二次调用SuperType()
  SuperType.call(this, name);
  this.age = age;
}

// 继承方法
// 构建原型链
// 第一次调用SuperType()
SubType.prototype = new SuperType(); 
// 重写SubType.prototype的constructor属性，指向自己的构造函数SubType
SubType.prototype.constructor = SubType; 
SubType.prototype.sayAge = function(){
    alert(this.age);
};

var instance1 = new SubType("Nicholas", 29);
instance1.colors.push("black");
alert(instance1.colors); //"red,blue,green,black"
instance1.sayName(); //"Nicholas";
instance1.sayAge(); //29

var instance2 = new SubType("Greg", 27);
alert(instance2.colors); //"red,blue,green"
instance2.sayName(); //"Greg";
instance2.sayAge(); //27
复制代码
```

缺点：

- 第一次调用`SuperType()`：给`SubType.prototype`写入两个属性name，color。
- 第二次调用`SuperType()`：给`instance1`写入两个属性name，color。

实例对象`instance1`上的两个属性就屏蔽了其原型对象SubType.prototype的两个同名属性。所以，组合模式的缺点就是在使用子类创建实例对象时，其原型中会存在两份相同的属性/方法。

## 原型式继承

利用一个空对象作为中介，将某个对象直接赋值给空对象构造函数的原型。

```js
function object(obj){
  function F(){}
  F.prototype = obj;
  return new F();
}
复制代码
```

object()对传入其中的对象执行了一次`浅复制`，将构造函数F的原型直接指向传入的对象。

```js
var person = {
  name: "Nicholas",
  friends: ["Shelby", "Court", "Van"]
};

var anotherPerson = object(person);
anotherPerson.name = "Greg";
anotherPerson.friends.push("Rob");

var yetAnotherPerson = object(person);
yetAnotherPerson.name = "Linda";
yetAnotherPerson.friends.push("Barbie");

alert(person.friends);   //"Shelby,Court,Van,Rob,Barbie"
复制代码
```

缺点：

- 原型链继承多个实例的引用类型属性指向相同，存在篡改的可能。
- 无法传递参数

另外，ES5中存在`Object.create()`的方法，能够代替上面的object方法。

## 寄生式继承

核心：在原型式继承的基础上，增强对象，返回构造函数

```js
function createAnother(original){
  var clone = object(original); // 通过调用 object() 函数创建一个新对象
  clone.sayHi = function(){  // 以某种方式来增强对象
    alert("hi");
  };
  return clone; // 返回这个对象
}
复制代码
```

函数的主要作用是为构造函数新增属性和方法，以**增强函数**

```js
var person = {
  name: "Nicholas",
  friends: ["Shelby", "Court", "Van"]
};
var anotherPerson = createAnother(person);
anotherPerson.sayHi(); //"hi"
复制代码
```

缺点（同原型式继承）：

- 原型链继承多个实例的引用类型属性指向相同，存在篡改的可能。
- 无法传递参数

## 寄生组合式继承

结合借用构造函数传递参数和寄生模式实现继承

```js
function inheritPrototype(subType, superType){
  var prototype = Object.create(superType.prototype); // 创建对象，创建父类原型的一个副本
  prototype.constructor = subType;                    // 增强对象，弥补因重写原型而失去的默认的constructor 属性
  subType.prototype = prototype;                      // 指定对象，将新创建的对象赋值给子类的原型
}

// 父类初始化实例属性和原型属性
function SuperType(name){
  this.name = name;
  this.colors = ["red", "blue", "green"];
}
SuperType.prototype.sayName = function(){
  alert(this.name);
};

// 借用构造函数传递增强子类实例属性（支持传参和避免篡改）
function SubType(name, age){
  SuperType.call(this, name);
  this.age = age;
}

// 将父类原型指向子类
inheritPrototype(SubType, SuperType);

// 新增子类原型属性
SubType.prototype.sayAge = function(){
  alert(this.age);
}

var instance1 = new SubType("xyc", 23);
var instance2 = new SubType("lxy", 23);

instance1.colors.push("2"); // ["red", "blue", "green", "2"]
instance1.colors.push("3"); // ["red", "blue", "green", "3"]
复制代码
```

这个例子的高效率体现在它只调用了一次`SuperType` 构造函数，并且因此避免了在`SubType.prototype` 上创建不必要的、多余的属性。于此同时，原型链还能保持不变；因此，还能够正常使用`instanceof` 和`isPrototypeOf()`

**这是最成熟的方法，也是现在库实现的方法**

## 混入方式继承多个对象

```js
function MyClass() {
     SuperClass.call(this);
     OtherSuperClass.call(this);
}

// 继承一个类
MyClass.prototype = Object.create(SuperClass.prototype);
// 混合其它
Object.assign(MyClass.prototype, OtherSuperClass.prototype);
// 重新指定constructor
MyClass.prototype.constructor = MyClass;

MyClass.prototype.myMethod = function() {
     // do something
};
复制代码
```

`Object.assign`会把  `OtherSuperClass`原型上的函数拷贝到 `MyClass`原型上，使 MyClass 的所有实例都可用 OtherSuperClass 的方法。

## ES6类继承extends

`extends`关键字主要用于类声明或者类表达式中，以创建一个类，该类是另一个类的子类。其中`constructor`表示构造函数，一个类中只能有一个构造函数，有多个会报出`SyntaxError`错误,如果没有显式指定构造方法，则会添加默认的 `constructor`方法，使用例子如下。

```js
class Rectangle {
    // constructor
    constructor(height, width) {
        this.height = height;
        this.width = width;
    }
    
    // Getter
    get area() {
        return this.calcArea()
    }
    
    // Method
    calcArea() {
        return this.height * this.width;
    }
}

const rectangle = new Rectangle(10, 20);
console.log(rectangle.area);
// 输出 200

-----------------------------------------------------------------
// 继承
class Square extends Rectangle {

  constructor(length) {
    super(length, length);
    
    // 如果子类中存在构造函数，则需要在使用“this”之前首先调用 super()。
    this.name = 'Square';
  }

  get area() {
    return this.height * this.width;
  }
}

const square = new Square(10);
console.log(square.area);
// 输出 100
复制代码
```

`extends`继承的核心代码如下，其实现和上述的寄生组合式继承方式一样

```js
function _inherits(subType, superType) {
  
    // 创建对象，创建父类原型的一个副本
    // 增强对象，弥补因重写原型而失去的默认的constructor 属性
    // 指定对象，将新创建的对象赋值给子类的原型
    subType.prototype = Object.create(superType && superType.prototype, {
        constructor: {
            value: subType,
            enumerable: false,
            writable: true,
            configurable: true
        }
    });
    
    if (superType) {
        Object.setPrototypeOf 
            ? Object.setPrototypeOf(subType, superType) 
            : subType.__proto__ = superType;
    }
}
复制代码
```

## 总结

1、函数声明和类声明的区别

函数声明会提升，类声明不会。首先需要声明你的类，然后访问它，否则像下面的代码会抛出一个ReferenceError。

```js
let p = new Rectangle(); 
// ReferenceError

class Rectangle {}
复制代码
```

2、ES5继承和ES6继承的区别

- ES5的继承实质上是先创建子类的实例对象，然后再将父类的方法添加到this上（Parent.call(this)）.
- ES6的继承有所不同，实质上是先创建父类的实例对象this，然后再用子类的构造函数修改this。因为子类没有自己的this对象，所以必须先调用父类的super()方法，否则新建实例报错。

> [《javascript高级程序设计》笔记：继承](https://link.juejin.cn?target=https%3A%2F%2Fsegmentfault.com%2Fa%2F1190000011917606)
> [MDN之Object.create()](https://link.juejin.cn?target=https%3A%2F%2Fdeveloper.mozilla.org%2Fzh-CN%2Fdocs%2FWeb%2FJavaScript%2FReference%2FGlobal_Objects%2FObject%2Fcreate)
> [MDN之Class](https://link.juejin.cn?target=https%3A%2F%2Fdeveloper.mozilla.org%2Fzh-CN%2Fdocs%2FWeb%2FJavaScript%2FReference%2FClasses)

**参考**

[JavaScript常用八种继承方案](https://juejin.cn/post/6844903696111763470#heading-3)
