---
title: B_继承原形闭包专题
date: 2022-05-29 07:33:16
categories:
- B_H5CSSJSES基础
toc: true # 是否启用内容索引
---

# 闭包

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

**js链式作用域**

子对象会一级一级向上寻找所有父对象的变量，反之不行

## **闭包的作用**

- 读取函数内部的变量
- 让这些变量的值始终保持在内存中
- 方便调用上下文的局部变量，利于代码封装

## **闭包的使用场景**

### **1.闭包结合匿名函数使用，如setTimeout**

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

### **2.参数回调**

```js
function changeSize(size){
        return function(){
            document.body.style.fontSize = size + 'px';
        };
    }

    var size12 = changeSize(12);
    ocument.getElementById('size-12').onclick = size12;
```

### **3.封装变量**

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



# 原形

js之父在设计js原型、原型链的时候遵从以下**两个准则**

>  **准则1：原型对象（即Person.prototype）的constructor指向构造函数本身**
>
> Person.prototype.constructor == Person //
>
> **准则2：实例的__proto__ 保存着构造函数的prototype即实例（即person01）的__proto__和原型对象指向同一个地方**
>
> person01.__proto__ == Person.prototype

- Person.prototype是显示原形属性
- person01.__proto__是隐式原形属性

**原形前言**

> 1.`__proto__`、 `constructor`属性是对象所独有的；
> 2.`prototype`属性是函数独有的；
> 3.上面说过js中函数也是对象的一种，那么函数同样也有属性`__proto__`、 `constructor`；

**原形定义**

proto是对象object的原形属性，所以proto叫对象的原形

**原形对象定义**

prototype是函数fn的原形属性，所以prototype叫fn的原形对象

**原型链定义**

> 在 JavaScript 中，实例对象在读取属性时总是先检查私有属性。如果存在，则会返回私有属性值；否则就会检索 prototype 原型；如果找到同名属性，则返回 prototype 原型的属性值。
>
> prototype 原型允许引用其他对象。如果在 prototype 原型中没有找到指定的属性，则 JavaScript 将会根据引用关系，继续检索 prototype 原型对象的 prototype 原型，以此类推。

下面示例演示了对象属性查找原型的基本方法和规律。

```js
function a (x) {  //构造函数a
    this.x = x;
}
a.prototype.x = 0;  //原型属性x的值为0
function b (x) {  //构造函数b
    this.x = x;
}
b.prototype = new a (1);  //原型对象为构造函数a的实例
function c (x) {  //构造函数c
    this.x = x;
}
c.prototype = new b (2);  //原型对象为构造函数b的实例
var d = new c (3);  //实例化构造函数c
console.log(d.x);  //调用实例对象d的属性x，返回值为3
delete d.x;  //删除实例对象的私有属性x
console.log(d.x);  //调用实例对象d的属性x，返回值为2
delete c.prototype.x;  //删除c类的原型属性x
console.log(d.x);  //调用实例对象d的属性x，返回值为1
delete b.prototype.x;  //删除b类的原型属性x
console.log(d.x);  //调用实例对象d的属性x，返回值为0
delete a.prototype.x;  //删除a类的原型属性x
console.log(d.x);  //调用实例对象d的属性x，返回值为undefined
```

## function Foo()原型图

<img src="/img/image-20220605092641925.png" alt="image-20220605092641925" style="zoom:80%;" />

```js
// 从上方 function Foo() 开始分析这一张经典之图
function Foo()
let f1 = new Foo();
let f2 = new Foo();

f1.__proto__ = Foo.prototype; // 准则2
f2.__proto__ = Foo.prototype; // 准则2
Foo.prototype.__proto__ = Object.prototype; // 准则2 (Foo.prototype本质也是普通对象，可适用准则2)
Object.prototype.__proto__ = null; // 原型链到此停止
Foo.prototype.constructor = Foo; // 准则1
Foo.__proto__ = Function.prototype; // 准则2
Function.prototype.__proto__  = Object.prototype; //  准则2 (Function.prototype本质也是普通对象，可适用准则2)
Object.prototype.__proto__ = null; // 原型链到此停止
// **此处注意Foo 和 Function的区别， Foo是 Function的实例**

// 从中间 function Object()开始分析这一张经典之图
function Object()
let o1 = new  Object();
let o2 = new  Object();

o1.__proto__ = Object.prototype; // 准则2
o2.__proto__ = Object.prototype; // 准则2
Object.prototype.__proto__ = null; // 原型链到此停止
Object.prototype.constructor = Object; // 准则1
// 所有函数的__proto__  都和 Function.prototype指向同一个地方
Object.__proto__ = Function.prototype // 准则2 (Object本质也是函数)；
// 此处有点绕
Function.prototype.__proto__ =  Object.prototype; // 准则2 (Function.prototype本质也是普通对象，可适用准则2)
Object.prototype.__proto__ = null; // 原型链到此停止

// 从下方 function Function()开始分析这一张经典之图
function Function()
Function.__proto__ = Function.prototype // 准则2
Function.prototype.constructor = Function; // 准则1
```

## 原形的作用

使用原型对象的好处是可以让所有对象实例共享它所包含的属性和方法。

## 原形的操作

**1.访问原形**

- obj.__proto__。
- obj.constructor.prototype。
- Object.getPrototypeOf(obj)。

```js
var F = function () {};  //构造函数
var obj = new F();  //实例化
var proto1 = Object.getPrototypeOf(obj);  //引用原型
var proto2 = obj.__proto__;  //引用原型，注意，IE暂不支持
var proto3 = obj.constructor.prototype;  //引用原型
var proto4 = F.prototype;  //引用原型
console.log(proto1 === proto2);  //true
console.log(proto1 === proto2);  //true
console.log(proto1 === proto4);  //true
console.log(proto2 === proto3);  //true
console.log(proto2 === proto4);  //true
console.log(proto3 === proto4);  //true
```

**2.设置原型**

设置原型对象有 3 种方法，简单说明如下：

- obj.__proto__=prototypeObj.
- Object.setPrototypeOf(obj, prototypeObj)。
- Object.create(prototypeObj)。

其中，obj 表示一个实例对象，prototypeObj 表示原型对象。注意，IE 不支持前面两种方法。

示例

下面代码简单演示利用上述三种方法为对象直接量设置原型。

```js
var proto = {name : "prototype"};  //原型对象
var obj1 = {};  //普通对象直接量
obj1.__proto__ = proto;  //设置原型
console.log(obj1.name);
var obj2 = {};  //普通对象直接量
Object.setPrototypeOf(obj2, proto);  //设置原型
console.log(obj2.name);
var obj3 = Object.create(proto);  //创建对象，并设置原型
console.log(obj3.name);
```

**3.检测原型**

使用 isPrototypeOf() 方法可以判断该对象是否为参数对象的原型。isPrototypeOf() 是一个原型方法，可以在每个实例对象上调用。

示例

下面代码简单演示如何检测原型对象。

```js
var F = function () {};  //构造函数
var obj = new F();  //实例化
var proto1 = Object.getPrototypeOf(obj);  //引用原型
console.log(proto1.isPrototypeOf(obj));  //true
```

也可以使用下面代码检测不同类型的实例。

```js
var proto = Object.prototype;
console.log(proto.isPrototypeOf({}));  //true
console.log(proto.isPrototypeOf([]));  //true
console.log(proto.isPrototypeOf(//));  //true
console.log(proto.isPrototypeOf(function () {}));  //true
console.log(proto.isPrototypeOf(null));  //false
```

## 原形的使用场景

### 1.为对象设置默认值

利用原型为对象设置默认值。当原型属性与私有属性同名时，删除私有属性之后，可以访问原型属性，即可以把原型属性值作为初始化默认值。

```js
function p (x) {  //构造函数
    if (x) {  //如果参数存在，则设置属性，该条件是关键
        this.x = x;  //使用参数初始化私有属性x的值
    }
}
p.prototype.x = 0;  //利用原型属性，设置私有属性x的默认值
var p1 = new p ();  //实例化一个没有带参数的对象
console.log(p1.x);  //返回0，即显示私有属性的默认值
var p2 = new p (1);  //再次实例化，传递一个新的参数
console.log(p2.x);  //返回1，即显示私有属性的初始化值
```

### 2.本地数据备份

利用原型间接实现本地数据备份。把本地对象的数据完全赋值给原型对象，相当于为该对象定义一个副本，也就是备份对象。这样当对象属性被修改时，就可以通过原型对象来恢复本地对象的初始值。

```js
function p (x) {  //构造函数
    this.x = x;
}
p.prototype.backup = function () {  //原型方法，备份本地对象的数据到原型对象中
    for (var i in this) {
        p.prototype[i] = this[i];
    }
}
var p1 = new p (1);  //实例化对象
p1.backup;  //备份实例对象中的数据
p1.x = 10;  //改写本地对象的属性值
console.log(p1.x);  //返回10，说明属性值已经被改写
p1 = p.prototype;  //恢复备份
console.log(p1.x);  //返回1，说明对象的属性值已经被恢复
```

### 3.设置“只读”特性

利用原型还可以为对象属性设置“只读”特性，这在一定程序上可以避免对象内部被任意修改的问题。下面示例演示了如何根据平面上两点坐标来计算它们之间的距离。构造函数 p 用来设置定位坐标，当传递两个参数值时，会返回以参数为坐标值的点。如果省略参数则默认点为原点（0,0）。而在构造函数 1 中通过传递的两点坐标对象计算它们的距离。

```js
function p (x, y) {  //求坐标点构造函数
    if (x) this.x = x;  //初始x轴值
    if (y) this.y = y;  //初始y轴值
    p.prototype.x = 0;  //默认x轴坐标
    p.prototype.y = 0;  //默认y轴坐标
}
function l (a, b) {  //求两点距离构造函数
    var a = a;  //参数私有化
    var b = b;  //参数私有化
    var w = function () {  //计算x轴距离，返回对函数引用
        return Math.abs(a.x - b.x);
    }
    var h = function () {  //计算y轴距离，返回对函数引用
        return Math.abs(a.y - b.y);
    }
    this.length = function () {  //计算两点距离，调用私有方法w()和h()
        return Math.sqrt(w() * w() + h() * h());
    }
    this.b = function () {  //获取起点坐标对象
        return a;
    }
    this.e = function () {  //获取终点坐标对象
        return b;
    }
}
var p1 = new P (1, 2);  //实例化p构造函数，声明一个点
var p2 = new P (10, 20);  //实例化p构造函数，声明另一个点
var l1 = new l (p1, p2);  //实例化l构造函数，传递两个对象
console.log(l1.length());  //返回20.12461179749811，计算两点距离
l1.b().x = 50;  //不经意改动方法b()的一个属性为50
console.log(l1.length());  //返回43.86342439892262，说明影响两点距离值
```

在测试中会发现，如果无意间修改了构造函数 1 的方法 b() 或 e() 的值，则构造函数 1 中的 length() 方法的计算值也随之发生变化。这种动态效果对于需要动态跟踪两点坐标变化来说，是非常必要的。但是，这里并不需要当初始化实例之后，随意的被改动坐标值。毕竟方法 b() 和 e() 与参数 a 和 b 是没有多大联系的。

为了避免因为改动方法 b() 的属性 x 值会影响两点距离，可以在方法 b() 和 e() 中新建一个临时性的构造类，设置该类的原型为 a，然后实例化构造类并返回，这样就阻断了方法 b() 与私有变量 a 的直接联系，它们之间仅是值得传递，而不是对对象 a 的引用，从而避免因为方法 b() 的属性值变化而影响私有对象 a 的属性值。

```js
this.b = function () {  //方法b()
    function temp () {};  //临时构造类
    temp.prototype = a;  //把私有对象传递给临时构造类的原型对象
    return new temp();  //返回实例化对象，阻断直接返回a的引用关系
}
this.e = function () {  //方法e()
    function temp () {};  //临时构造类
    temp.prototype = a;  //把私有对象传递给临时构造类的原型对象
    return new temp();  //返回实例化对象，阻断直接返回a的引用关系
}
```

还有一种方法是在给私有变量 w 和 h 赋值时，不是赋值函数，而是函数调用表达式，这样私有变量 w 和 h 存储的时值类型数据，而不是对函数结构的引用，从而就不再受后期相关属性值的影响。

```js
function l (a, b) {  //求两点距离构造函数
    var a = a;  //参数私有化
    var b = b;  //参数私有化
    var w = function () {  //计算x轴距离，返回函数表达式的计算值
        return Math.abs(a.x - b.x);
    } ()
    var h = function () {  //计算y轴距离，返回函数表达式的计算值
        return Math.abs(a.y - b.y);
    } ()
    this.length = function () {  //计算两点距离，直接使用私有变量 w 和 h 来计算
        return Math.sqrt(w() * w() + h() * h());
    }
    this.b = function () {  //获取起点坐标
        return a;
    }
    this.e = function () {  //获取终点坐标
        return b;
    }
}
```

### 4.批量复制

利用原型进行批量复制。

```js
function f (x) {  //构造函数
    this.x = x;  //声明私有属性
}
var a = [];  //声明数组
for (var i = 0; i < 100; i ++) {  //使用for循环结构批量复制构造类f的同一个实例
    a[i] = new f (10);  //把实例分别存入数组
}
```

上面代码演示了如何复制 100 次同一个实例对象。这种做法本无可非议，但是如果要在枸杞修改数组中每个实例对象时，就会非常麻烦。现在可以尝试使用原型来进行批量复制操作。

```js
function f (x) {  //构造函数
    this.x = x;  //声明私有属性
}
var a = [];  //声明数组
function temp () {}  //定义一个临时的空构造类temp
temp.prototype = new f (10);  //实例化，并传递给构造类temp的原型对象
for (var i = 0; i < 100; i ++) {  //使用for复制临时构造类temp的同一个实例
    a[i] = new temp();  //把实例分别存入数组
}
```

把构造类 f 的实例存储在临时构造类的原型对象中，然后通过临时构造类 temp 实例来传递复制的值。这样，要想修改数组的值，只需要修改类 f 的原型即可，从而避免逐一修改数组中每个元素。

## **几种特殊记忆的**

1. `Function.__ptoto__`是什么？

```js
console.log(Function.__proto__ === Function.prototype) // true
```

1. `Function.prototype`是什么类型？

```js
console.log(typeof Function.prototype) // function
```

> `Function.prototype`是唯一一个`typeof XXX.prototype`为`function`的prototype，其它的构造器的prototype都是一个对象。

1. 那么`Function.prototype.__proto__`是什么？

```js
console.log(Function.prototype.__proto__ === Object.prototype) // true
```

1. `Object.prototype.__proto__`是什么？

```js
console.log(Object.prototype.__proto__) // null
```

这已经是原型链的顶端了，指向null

# JS的7种继承方式

**前言：**

面向对象编程很重要的一个方面，就是对象的继承。**A 对象通过继承 B 对象，就能直接拥有 B 对象的所有属性和方法**。这对于代码的复用是非常有用的。大部分面向对象的编程语言，都是通过“类”（class）实现对象的继承。传统上，JavaScript 语言的继承不通过 class(ES6 引入了class 语法)，而是通过“原型对象”（prototype）实现。

**ES5继承**

构造函数、原型和实例的关系：每一个构造函数都有一个原型对象，每一个原型对象都有一个指向构造函数的指针，而每一个实例都包含一个指向原型对象的内部指针。

**1、原型链实现继承**

基本思想：利用原型让一个引用类型继承另一个引用类型的属性和方法，即让原型对象等于另一个类型的实例。**子类型的原型为父类型的一个实例对象。**

```
function Parent () {
    this.names = ['one', 'two'];
}
function Child () {
 

}
Child.prototype = new Parent();
var child1 = new Child();
console.log(child1.names); // ["one", "two"]
child1.names.push('three');
console.log(child1.names); // ["one", "two", "three"]
var child2 = new Child();
console.log(child2.names); // ["one", "two", "three"]
```

这种方式实现的本质是通过将子类的原型指向了父类的实例，所以**子类的实例就可以通过__proto__访问到 Student.prototype 也就是Person的实例，这样就可以访问到父类的私有方法，然后再通过__proto__指向父类的prototype就可以获得到父类原型上的方法**。于是做到了将父类的私有、公有方法和属性都当做子类的公有属性。

**优点：**

- 父类新增原型方法/原型属性，子类都能访问到；
- 简单，易于实现。

**缺点**：

- 无法实现多继承;
- 来自原型对象的所有属性被所有实例共享;
- 创建子类实例时，无法向父类构造函数传参。

**2.借用构造函数(经典继承)**

这种方式关键在于:**在子类型构造函数中通用call()调用父类型构造函数**。

```
//例子一
function Parent () {
    this.names = ['one', 'two'];
}
function Child () {
    Parent.call(this);
}
var child1 = new Child();
child1.names.push('three');
console.log(child1.names); // ["one", "two", "three"]
var child2 = new Child();
console.log(child2.names); // ["one", "two"]

//例子二
function Parent (name) {
    this.name = name;
}
function Child (name) {
    Parent.call(this, name);
}
var child1 = new Child('one');
console.log(child1.name); // one
var child2 = new Child('two');
console.log(child2.name); // two
```

**优点：**

- 解决了原型链继承中子类实例共享父类引用属性的问题
- 创建子类实例时，可以向父类传递参数
- 可以实现多继承(call多个父类对象)

**缺点**：

- 实例并不是父类的实例，只是子类的实例
- 只能继承父类的实例属性和方法，不能继承原型属性和方法
- 无法实现函数复用，每个子类都有父类实例函数的副本，影响性能

**3、组合继承（ 原型链+借用构造函数** ）

```
function Parent (name) {
    this.name = name;
    this.colors = ['red', 'blue', 'green'];
}
Parent.prototype.getName = function () {
    console.log(this.name)
;
}
function Child (name, age) {
    Parent.call(this, name);
    this.age = age;
}
Child.prototype = new Parent();
Child.prototype.constructor = Child;
var child1 = new Child('one', '18');
child1.colors.push('black');
console.log(child1.name); // one
console.log(child1.age); // 18
console.log(child1.colors); // ["red", "blue", "green", "black"]
var child2 = new Child('two', '20');
console.log(child2.name); // two
console.log(child2.age); // 20
console.log(child2.colors); // ["red", "blue", "green"]
```

这种方式融合原型链继承和构造函数的优点，是 JavaScript 中最常用的继承模式。不过也存在缺点就是无论在什么情况下，都会调用两次构造函数：一次是在创建子类型原型的时候，另一次是在子类型构造函数的内部，子类型最终会包含父类型对象的全部实例属性，但我们不得不在调用子类构造函数时重写这些属性。

**优点**：

- 可以继承实例属性/方法，也可以继承原型属性/方法
- 不存在引用属性共享问题
- 可传参
- 函数可复用

**缺点**：

- 调用了两次父类构造函数，生成了两份实例

4.原型式继承

不用严格意义上的构造函数，借助原型可以根据已有的对象创建新对象，还不必因此创建自定义类型，因此最初有如下函数：

```
function createObj(o) {
    function F(){}
    F.prototype = o;
    return new F();
}
```

从本质上讲，createObj()对传入其中的对象执行了一次浅复制。

```
function createObj(o) {
    function F(){}
    F.prototype = o;
    return new F();
}
var person = {
    name: 'one',
    friends: ['two', 'three']
}
var person1 = createObj(person);
var person2 = createObj(person);
person1.name = 'person1';
console.log(person2.name); // one
person1.friends.push('four');
console.log(person2.friends); // [ 'two', 'three', 'four' ]
```

ES5新增Object.create规范了原型式继承，接收两个参数，一个用作新对象原型的对象和（可选的）一个为新对象定义额外属性的对象，在传入一个参数的情况下，Object.create()和createObj()行为相同。

```
var person = {
    name:'one',
    friendes:['two', 'three']
};
var person1 = Object.create(person,{
    name:{
        value:"four"
    }
});
//用这种方法指定的任何属性都会覆盖掉原型对象上的同名属性
console.log(person1.name);  // four
person.friendes.push('four');
console.log(person1.friendes);  // [ 'two', 'three', 'four' ]
```

**缺点：**

- 包含引用类型的属性值始终都会共享相应的值，这点跟原型链继承一样。

5.寄生式继承

寄生式继承是与原型式继承紧密相关的一种思路，它创造一个仅用于封装继承过程的函数，在函数内部以某种方式增强对象，最后再返回对象。

```
function createObj (o) {
    var clone = Object.create(o);
    clone.sayHi = function () {
        console.log('hi');
    }
    return clone;
}
```

**缺点：**

- 跟借用构造函数模式一样，每次创建对象都会创建一遍方法，会因为做不到函数复用而降低效率。

6. 寄生组合式继承

通过借用构造函数来继承属性，通过原型链的混成形式来继承方法，不必为了指定子类型的原型而调用超类型的构造函数，只需要超类型的一个副本。本质上，就是使用寄生式继承来继承超类型的原型，然后再将结果指定给子类型的原型。

```
function Parent (name) {
    this.name = name;
    this.colors = ['red', 'blue', 'green'];
}
Parent.prototype.getName = function () {
    console.log(this.name)
}
function Child (name, age) {
    Parent.call(this, name);
    this.age = age;
}
// 关键的三步
var F = function () {};
F.prototype = Parent.prototype;
Child.prototype = new F();

var child1 = new Child('one', '18');
console.log(child1);
//Parent { name: 'one', colors: [ 'red', 'blue', 'green' ], age: '18' }
```

最后我们封装一下这个继承方法：

```
function object(o) {
    function F() {}
    F.prototype = o;
    return new F();
}
function prototype(child, parent) {
    var prototype = object(parent.prototype);
    prototype.constructor = child;
    child.prototype = prototype;
}
// 当我们使用的时候：
prototype(Child, Parent);
```

这种方式的高效率体现它只调用了一次 Parent 构造函数，并且因此避免了在 Parent.prototype 上面创建不必要的、多余的属性。与此同时，原型链还能保持不变；因此，还能够正常使用 instanceof 和 isPrototypeOf。开发人员普遍认为寄生组合式继承是引用类型最理想的继承范式。

**ES6继承**

7.ES6中class 的继承

ES6中引入了class关键字，class可以通过extends关键字实现继承，还可以通过static关键字定义类的静态方法,这比 ES5 的通过修改原型链实现继承，要清晰和方便很多。

ES5 的继承，实质是先创造子类的实例对象this，然后再将父类的方法添加到this上面（Parent.apply(this)）。ES6 的继承机制完全不同，实质是先将父类实例对象的属性和方法，加到this上面（所以必须先调用super方法），然后再用子类的构造函数修改this。

**需要注意的是，class关键字只是原型的语法糖，JavaScript继承仍然是基于原型实现的**。

```
class Parent {
    //调用类的构造方法
    constructor(name, age) {
        this.name = name
        this.age = age
    }
    //定义一般的方法
    showName() {
        console.log("调用父类的方法")
        console.log(this.name, this.age);
    }
}
let p1 = new  Parent('one', 36)
console.log(p1) // Parent { name: 'one', age: 36 }

//定义一个子类
class Child extends Parent {
    constructor(name, age, salary) {
        super(name, age)//通过super调用父类的构造方法
        this.salary = salary
    }
    showName() {//在子类自身定义方法
        console.log("调用子类的方法")
        console.log(this.name, this.age, this.salary); 
    }
}
let s1 = new Child('two', 32, 28000)
console.log(s1)  // Child { name: 'two', age: 32, salary: 28000 }
s1.showName()
// 调用子类的方法
// two 32 28000
```

**优点**：

- 语法简单易懂,操作更方便

**缺点**：

- 并不是所有的浏览器都支持class关键字