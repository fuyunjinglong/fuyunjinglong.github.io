---
title: 拖拽方案
date: 2022-05-10 06:33:16
categories:
- B_JS
toc: true # 是否启用内容索引
---

# 张鑫旭极简JS拖拽

[原文](https://gitee.com/zhangxinxu/zxx-drag)

**语法**

```
lwDrag (eleBar, options);
```

 **参数说明**

- eleBar

  Element，必需，表示可以触发拖拽的元素。

- options

  Object，可选参数。

**可选参数**

options 为可选参数，支持下面这些：

- target

  Element，表示移动的目标元素，默认就是 eleBar 元素。

- bounding

  Object | Element，拖拽范围，如果参数是对象，需要是下面这样的格式：`{    left: 0,    top: 0,    bottom: 0,    right: 0 } `其中，无论是 left, right 还是 top, bottom 值均是相对于浏览器窗口左边缘和上边缘计算的。如果参数是 DOM 元素，则被限制的拖拽范围就是这个元素。默认值是 window，表示限制范围是整个浏览器窗口。

- edgeLock

  Boolean，表示是否开启边缘范围限制。

- onMove

  Function，拖拽进行中触发，支持两个参数，分别是拖拽目标元素的 left 和 top 定位值。

- onEnd

  Function，拖拽结束的时候触发

**使用说明**

1. 引入资源

```
<script src="./lwDrag.js"></script>
```

​	2.执行绑定

```
<script>
    lxDrag(bar, {
        target: box
    });
</script>
```



```
lwDrag.js
/*!
 * @description 简单的拖拽效果，兼容 IE 和 移动端，带边界判断
 * 相关内容：https://www.zhangxinxu.com/wordpress/?p=683
 * @author zhangxinxu(.com)
 * @create 2021-12-03
 * @license MIT
**/

/**
 * @param {Element} eleBar 拖拽触发元素
 * @param {Object} options 可选参数
 * @returns 
 */
var lwDrag = function (eleBar, options) {
    if (!eleBar) {
        return;
    }
    // 默认数据
    var defaults = {
        target: eleBar,
        bounding: window,
        edgeLock: true,
        onMove: function () {},
        onEnd: function () {}
    };

    options = options || {};

    var params = {};
    for (var key in defaults) {
        if (typeof options[key] != 'undefined') {
            params[key] = options[key];
        } else {
            params[key] = defaults[key];
        }
    }

    // 拖拽元素
    var eleTarget = params.target;
    // 限制范围
    var bounding = params.bounding;
    var objBounding = bounding;

    // 事件类型处理
    var objEventType = {
        start: 'mousedown',
        move: 'mousemove',
        end: 'mouseup'
    };

    if ('ontouchstart' in document) {
        objEventType = {
            start: 'touchstart',
            move: 'touchmove',
            end: 'touchend'
        };
    }

    // 坐标存储数据
    var store = {};
    eleBar.addEventListener(objEventType.start, function (event) {
        // IE 拖拽可能拖不动的处理,
        // 如果不考虑 IE 浏览器，pointerdown pointermove更好！
        if (!window.WeakMap || typeof document.msHidden != 'undefined') {
            event.preventDefault();
        }
        // 兼顾移动端
        if (event.touches && event.touches.length) {
            event = event.touches[0];
        }
        store.y = event.pageY;
        store.x = event.pageX;
        store.isMoving = true;
        store.top = parseFloat(getComputedStyle(eleTarget).top) || 0;
        store.left = parseFloat(getComputedStyle(eleTarget).left) || 0;

        if (params.edgeLock === true && bounding) {
            if (bounding === window) {
                objBounding = {
                    left: 0,
                    top: 0,
                    bottom: innerHeight,
                    right: Math.min(innerWidth, document.documentElement.clientWidth)
                };
            } else if (bounding.tagName) {
                objBounding = bounding.getBoundingClientRect();
            }

            // 拖拽元素的 bounding 位置
            var objBoundingTarget = eleTarget.getBoundingClientRect();

            // 可移动范围
            store.range = {
                y: [objBounding.top - objBoundingTarget.top, objBounding.bottom - objBoundingTarget.bottom],
                x: [objBounding.left - objBoundingTarget.left, objBounding.right - objBoundingTarget.right]
            };
        }
    });
    document.addEventListener(objEventType.move, function (event) {
        if (store.isMoving) {
            event.preventDefault();
            // 兼顾移动端
            if (event.touches && event.touches.length) {
                event = event.touches[0];
            }            

            var distanceY = event.pageY - store.y;
            var distanceX = event.pageX - store.x;
            
            // 边界的判断与chuli
            if (params.edgeLock === true && bounding) {
                var minX= Math.min.apply(null, store.range.x);
                var maxX = Math.max.apply(null, store.range.x);
                var minY= Math.min.apply(null, store.range.y);
                var maxY = Math.max.apply(null, store.range.y);

                if (distanceX < minX) {
                    distanceX = minX;
                } else if (distanceX > maxX) {
                    distanceX = maxX;
                }

                if (distanceY < minY) {
                    distanceY = minY;
                } else if (distanceY > maxY) {
                    distanceY = maxY;
                }
            }
            
            var top = store.top + distanceY;
            var left = store.left + distanceX;

            eleTarget.style.top = top + 'px';
            eleTarget.style.left = left + 'px';

            // 回调
            params.onMove(left, top);
        }
    }, {
        passive: false
    });
    document.addEventListener(objEventType.end, function () {
        if (store.isMoving) {
            store.isMoving = false;

            params.onEnd();
        }            
    });
};
```

```
demo.html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>zxxDrag 拖拽演示页面</title>
    <style>
        .box{position:absolute; left:10px; top:50px; padding:5px; background:#f0f3f9; font-size:14px; box-shadow:2px 2px 4px #666666;}
        .main{border:1px solid #a0b3d6; background:white;}
        .bar{line-height:2; background:#beceeb; border-bottom:1px solid #a0b3d6; padding: 0 10px; cursor:move;}
        .content{width:420px; height:250px; padding:10px; max-width: calc(100vw - 60px); background-color: #fff;}
        
        .heading{margin-top:90vh;}
        .container{outline:1px solid; max-width: 414px; height: 300px; background-color: #f5f5f5; position: relative;}
        .target{width: 100px; height: 100px; background-color: #a0b3d6; opacity: .9; position: absolute;}
        .target:active{opacity: 1;}
    </style>
</head>
<body>
    <div id="box" class="box">
        <div class="main">
            <div id="bar" class="bar">拖拽</div>
            <div class="content">
                内容……
            </div>
        </div>
    </div>

    <h3 class="heading">内部拖拽</h3>
    <div id="container" class="container">
        <div id="target" class="target"></div>
    </div>


    <script src="./zxxDrag.js"></script>
    <script>
        zxxDrag(bar, {
            target: box
        });

        zxxDrag(target, {
            bounding: container
        });
    </script>
</body>
</html>
```

# 原生实现拖拽

## Mouse事件实现拖拽

在h5之前，原生实现拖拽是根据`Mouse事件来实现的`，需要用到以下这三个事件`mousedown`,`mouseup`,`mousemove`

- mousedown 事件在指针设备按钮按下时触发。
- mouseup事件在指针设备按钮抬起时触发。
- 当指针设备( 通常指鼠标 )在元素上移动时, mousemove 事件被触发。

### JavaScript三大家族

![](/img/js三大家族.png)

实现代码

[原文](https://juejin.cn/post/6844904158273765384#heading-1)

```
<!DOCTYPE html><html lang="en"><head>    <meta charset="UTF-8">    <meta name="viewport" content="width=device-width, initial-scale=1.0">    <title>Document</title></head><body>    <img id="ball" src="https://js.cx/clipart/ball.svg" alt="">    <script>       const ball=document.querySelector("#ball")       ball.onmousedown = function(event) {       let shiftX = event.clientX - ball.getBoundingClientRect().left;       let shiftY = event.clientY - ball.getBoundingClientRect().top;        ball.style.position = 'absolute';        ball.style.zIndex = 1000;        document.body.append(ball);        moveAt(event.pageX, event.pageY);        // 移动现在位于坐标 (pageX, pageY) 上的球        // 将初始的偏移考虑在内        function moveAt(pageX, pageY) {        ball.style.left = pageX - shiftX + 'px';        ball.style.top = pageY - shiftY + 'px';        }        function onMouseMove(event) {        moveAt(event.pageX, event.pageY);        }        // 在 mousemove 事件上移动球        document.addEventListener('mousemove', onMouseMove);        // 放下球，并移除不需要的处理程序        ball.onmouseup = function() {        document.removeEventListener('mousemove', onMouseMove);        ball.onmouseup = null;        };        };        ball.ondragstart = function() {        return false;    };    </script></body></html>
```

## HTML 拖放（Drag and Drop）

HTML 的 drag & drop 使用了 `DOM event model` 以及从`mouse events` `继承而`来的 `drag events` 。一个典型的`drag`操作是这样开始的：用户用鼠标选中一个可拖动的（draggable）元素，移动鼠标到一个可放置的（droppable）元素，然后释放鼠标。 在操作期间，会触发一些事件类型，有一些事件类型可能会被多次触发（比如drag 和 dragover 事件类型）

<img src="/img/image-20220510073421629.png" alt="image-20220510073421629" style="zoom: 80%;" />

- drag: 拖拽源
- drop：拖拽源最终放置的目标
- DataTransfer 对象：退拽对象用来传递的媒介，使用一般为Event.dataTransfer。
- draggable 属性：就是标签元素要设置draggable=true
- ondragstart 事件：当拖拽元素开始被拖拽的时候触发的事件，此事件作用在被拖曳元素上
- ondragenter 事件：当拖曳元素进入目标元素的时候触发的事件，此事件作用在目标元素上
- ondragover 事件：拖拽元素在目标元素上移动的时候触发的事件，此事件作用在目标元素上
- ondrop 事件：被拖拽的元素在目标元素上同时鼠标放开触发的事件，此事件作用在目标元素上
- ondragend 事件：当拖拽完成后触发的事件，此事件作用在被拖曳元素上
- Event.preventDefault()方法：阻止默认的些事件方法等执行。在ondragover中一定要执行preventDefault()，否则ondrop事件不会被触发。另外，如果是从其他应用软件或是文件中拖东西进来，尤其是图片的时候，默认的动作是显示这个图片或是相关信息，并不是真的执行drop。此时需要用用document的ondragover事件把它直接干掉。
  Event.effectAllowed 属性：就是拖拽的效果。

```
<!DOCTYPE html><html lang="en">  <head>    <meta charset="UTF-8" />    <meta      name="viewport"      content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0"    />    <meta http-equiv="X-UA-Compatible" content="ie=edge" />    <title>Document</title>    <style>      body {        font: 16px Arial, Helvetica, sans-serif;      }      li {        width:200px;        height: 40px;        text-align: center;        line-height: 40px;        border:1px dashed #cccccc;         cursor: pointer;        user-select: none;        background-color: white;        list-style: none;      }      .more {        border-top: 1px dotted rgb(196, 196, 196);        font-size: 12px;        padding-top: 10px;      }      .more,      .more a {        color: rgb(96, 96, 96);      }    </style>  </head>  <body>    <ul>      <li        draggable="true"        ondragend="dragEnd()"        ondragover="dragOver(event)"        ondragstart="dragStart(event)"      >        Apples      </li>      <li        draggable="true"        ondragend="dragEnd()"        ondragover="dragOver(event)"        ondragstart="dragStart(event)"      >        Oranges      </li>      <li        draggable="true"        ondragend="dragEnd()"        ondragover="dragOver(event)"        ondragstart="dragStart(event)"      >        Bananas      </li>      <li        draggable="true"        ondragend="dragEnd()"        ondragover="dragOver(event)"        ondragstart="dragStart(event)"      >        Strawberries      </li>    </ul>    <script>      var selected;      const li = document.createElement("li");      function dragOver(e) {        // 向前拖拽 向后拖拽        // 拖动目标(drop)是不是在拖拽源(drag)的前面        if (isBefore(selected, e.target)){                    e.target.parentNode.insertBefore(selected, e.target);        }else {e.target.parentNode.insertBefore(selected, e.target.nextSibling);}      }      function dragEnd() {        selected = null;      }      function dragStart(e) {        selected = e.target;        console.log(selected)      }      function isBefore(el1, el2) {        var cur;        if (el2.parentNode === el1.parentNode) {          for (cur = el1.previousSibling; cur; cur = cur.previousSibling) {            if (cur === el2) return true;          }        } else return false;      }    </script>  </body></html>
```

