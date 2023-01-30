---
title: NodeJS入门
date: 2022-05-14 07:33:16
categories:
- H_工程和热点
toc: true # 是否启用内容索引
---

# 1.NodeJS事件循环机制

## 什么是事件循环

事件循环是指Node.js执行非阻塞I/O操作，尽管JavaScript是单线程的,但由于大多数内核都是多线程的，`Node.js`会尽可能将操作装载到系统内核。因此它们可以处理在后台执行的多个操作。当其中一个操作完成时，内核会告诉`Node.js`，以便`Node.js`可以将相应的回调添加到轮询队列中以最终执行。

当Node.js启动时会初始化`event loop`, 每一个`event loop`都会包含按如下顺序六个循环阶段：

<img src="/img/image-20220514232847337.png" alt="image-20220514232847337" style="zoom:67%;" />

1. **`timers` 阶段**: 这个阶段执行 `setTimeout(callback)` 和 `setInterval(callback)` 预定的 callback;

2. **`I/O callbacks` 阶段**: 此阶段执行某些系统操作的回调，例如TCP错误的类型。 例如，如果TCP套接字在尝试连接时收到 ECONNREFUSED，则某些* nix系统希望等待报告错误。 这将操作将等待在==I/O回调阶段==执行;

3. **`idle, prepare` 阶段**: 仅node内部使用;

4. **`poll` 阶段**: 获取新的I/O事件, 例如操作读取文件等等，适当的条件下node将阻塞在这里;

5. **`check` 阶段**: 执行 `setImmediate()` 设定的callbacks;

6. **`close callbacks` 阶段**: 比如 `socket.on(‘close’, callback)` 的callback会在这个阶段执行;

## 事件循环详解

<img src="/img/image-20220514232936132.png" alt="image-20220514232936132" style="zoom:67%;" />

上图从左到右，从上到下，Node.js 被分为了四层，分别是 `应用层`、`V8引擎层`、`Node API层` 和 `LIBUV层`。

- 应用层：   即 JavaScript 交互层，常见的就是 Node.js 的模块，比如 http，fs
- V8引擎层：  即利用 V8 引擎来解析JavaScript 语法，进而和下层 API 交互
- NodeAPI层：  为上层模块提供系统调用，一般是由 C 语言来实现，和操作系统进行交互 。
- LIBUV层： 是跨平台的底层封装，实现了 事件循环、文件操作等，是 Node.js 实现异步的核心

## 每个循环阶段内容详解

**`timers`阶段** 

一个timer指定一个下限时间而不是准确时间，在达到这个下限时间后执行回调。在指定时间过后，timers会尽可能早地执行回调，但系统调度或者其它回调的执行可能会延迟它们。

- 注意：技术上来说，poll 阶段控制 timers 什么时候执行。
- 注意：这个下限时间有个范围：[1, 2147483647]，如果设定的时间不在这个范围，将被设置为1。

**`I/O callbacks`阶段**

这个阶段执行一些系统操作的回调。比如TCP错误，如一个TCP socket在想要连接时收到ECONNREFUSED, 类unix系统会等待以报告错误，这就会放到 I/O callbacks 阶段的队列执行. 名字会让人误解为执行I/O回调处理程序, 实际上I/O回调会由poll阶段处理.

**`poll`阶段**

有两个主要功能：

（1）执行下限时间已经达到的timers的回调

（2）然后处理 poll 队列里的事件。 当event loop进入 poll 阶段，并且 没有设定的 timers（there are no timers scheduled），会发生下面两件事之一：

如果 poll 队列不空，event loop会遍历队列并同步执行回调，直到队列清空或执行的回调数到达系统上限；

如果 poll 队列为空，则发生以下两件事之一：

- 如果代码已经被setImmediate()设定了回调, event loop将结束 poll 阶段进入 check 阶段来执行 check 队列（里面的回调 callback）。
- 如果代码没有被setImmediate()设定回调，event loop将阻塞在该阶段等待回调被加入 poll 队列，并立即执行。

但是，当event loop进入 poll 阶段，并且 有设定的timers，一旦 poll 队列为空（poll 阶段空闲状态）： event loop将检查timers,如果有1个或多个timers的下限时间已经到达，event loop将绕回 timers 阶段，并执行 timer 队列。

**`check`阶段** 

这个阶段允许在 poll 阶段结束后立即执行回调。如果 poll 阶段空闲，并且有被setImmediate()设定的回调，event loop会转到 check 阶段而不是继续等待。

setImmediate() 实际上是一个特殊的timer，跑在event loop中一个独立的阶段。它使用`libuv`的API 来设定在 poll 阶段结束后立即执行回调。

通常上来讲，随着代码执行，event loop终将进入 poll 阶段，在这个阶段等待 incoming connection, request 等等。但是，只要有被setImmediate()设定了回调，一旦 poll 阶段空闲，那么程序将结束 poll 阶段并进入 check 阶段，而不是继续等待 poll 事件们 （poll events）

**`close callbacks` 阶段**

如果一个 socket 或 handle 被突然关掉（比如 socket.destroy()），close事件将在这个阶段被触发，否则将通过process.nextTick()触发

伪代码演示流程：

```
// 事件循环本身相当于一个死循环，当代码开始执行的时候，事件循环就已经启动了
// 然后顺序调用不同阶段的方法
while(true){
// timer阶段
	timer()
// I/O callbacks阶段
	IO()
// idle阶段
	IDLE()
// poll阶段
	poll()
// check阶段
	check()
// close阶段
	close()
}
// 在一次循环中，当事件循环进入到某一阶段，加入进入到check阶段，突然timer阶段的事件就绪，也会等到当前这次循环结束，再去执行对应的timer阶段的回调函数 
// 下面看这里例子
const fs = require('fs')

// timers阶段
const startTime = Date.now();
setTimeout(() => {
    const endTime = Date.now()
    console.log(`timers: ${endTime - startTime}`)
}, 1000)

// poll阶段(等待新的事件出现)
const readFileStart =  Date.now();
fs.readFile('./Demo.txt', (err, data) => {
    if (err) throw err
    let endTime = Date.now()
    // 获取文件读取的时间
    console.log(`read time: ${endTime - readFileStart}`)
    // 通过while循环将fs回调强制阻塞5000s
    while(endTime - readFileStart < 5000){
        endTime = Date.now()
    }
})
// check阶段
setImmediate(() => {
    console.log('check阶段')
})
/*控制台打印
check阶段
read time: 9
timers: 5008
通过上述结果进行分析，
1.代码执行到定时器setTimeOut，目前timers阶段对应的事件列表为空，在1000s后才会放入事件
2.事件循环进入到poll阶段，开始不断的轮询监听事件
3.fs模块异步执行，根据文件大小，可能执行时间长短不同，这里我使用的小文件，事件大概在9s左右
4.setImmediate执行，poll阶段暂时未监测到事件，发现有setImmediate函数，跳转到check阶段执行check阶段事件（打印check阶段），第一次时间循环结束，开始下一轮事件循环
5.因为时间仍未到定时器截止时间，所以事件循环有一次进入到poll阶段，进行轮询
6.读取文件完毕，fs产生了一个事件进入到poll阶段的事件队列，此时事件队列准备执行callback，所以会打印（read time: 9），人工阻塞了5s，虽然此时timer定时器事件已经被添加，但是因为这一阶段的事件循环为完成，所以不会被执行，（如果这里是死循环，那么定时器代码永远无法执行）
7.fs回调阻塞5s后，当前事件循环结束，进入到下一轮事件循环，发现timer事件队列有事件，所以开始执行 打印timers: 5008

ps：
1.将定时器延迟时间改为5ms的时候，小于文件读取时间，那么就会先监听到timers阶段有事件进入，从而进入到timers阶段执行，执行完毕继续进行事件循环
check阶段
timers: 6
read time: 5008
2.将定时器事件设置为0ms，会在进入到poll阶段的时候发现timers阶段已经有callback，那么会直接执行，然后执行完毕在下一阶段循环，执行check阶段，poll队列的回调函数
timers: 2
check阶段
read time: 7
 */
```

**案例0**

```
setImmediate(function(){
  console.log("setImmediate");
  setImmediate(function(){
    console.log("嵌套setImmediate");
  });
  process.nextTick(function(){
    console.log("nextTick");
  })
});

/* 
	C:\Users\92809\Desktop\node_test>node test.js
	setImmediate
	nextTick
	嵌套setImmediate
*/
```

解析：

事件循环`check`阶段执行回调函数输出`setImmediate`，之后输出`nextTick`。嵌套的`setImmediate`在下一个事件循环的`check`阶段执行回调输出嵌套的`setImmediate`。

**案例1**

```
async function async1(){
    console.log('async1 start')
    await async2()
    console.log('async1 end')
  }
async function async2(){
    console.log('async2')
}
console.log('script start')
setTimeout(function(){
    console.log('setTimeout0') 
},0)  
setTimeout(function(){
    console.log('setTimeout3') 
},3)  
setImmediate(() => console.log('setImmediate'));
process.nextTick(() => console.log('nextTick'));
async1();
new Promise(function(resolve){
    console.log('promise1')
    resolve();
    console.log('promise2')
}).then(function(){
    console.log('promise3')
})
console.log('script end')

```

结果：

```
C:\Users\92809\Desktop\node_test>node test.js
script start
async1 start
async2
promise1
promise2
script end
nextTick
promise3
async1 end
setTimeout0
setTimeout3
setImmediate
```

