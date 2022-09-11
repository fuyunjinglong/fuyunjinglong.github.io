---
title: C_axios技巧
date: 2022-05-04 06:33:16
categories:
- C_框架及工具
toc: true # 是否启用内容索引
---

# 1.基本使用

1. 安装axios `npm install axios --save`

```
import axios from 'axios'
//创建axios的一个实例 
var instance = axios.create({
    baseURL:'http://localhost:8080/',//接口统一域名
    timeout: 6000                                                       //设置超时
})
 
 
//------------------- 一、请求拦截器 忽略
instance.interceptors.request.use(function (config) {
 
    return config;
}, function (error) {
    // 对请求错误做些什么
    
    return Promise.reject(error);
});
 
//----------------- 二、响应拦截器 忽略
instance.interceptors.response.use(function (response) {
    
    return response.data;
}, function (error) {
    // 对响应错误做点什么
    console.log('拦截器报错');
    return Promise.reject(error);
});
 
/**
 * 使用es6的export default导出了一个函数，导出的函数代替axios去帮我们请求数据，
 * 函数的参数及返回值如下：
 * @param {String} method  请求的方法：get、post、delete、put
 * @param {String} url     请求的url:
 * @param {Object} data    请求的参数
 * @returns {Promise}     返回一个promise对象，其实就相当于axios请求数据的返回值
 */
export default function (method, url, data = null) {
    method = method.toLowerCase();
    if (method == 'post') {
        return instance.post(url, data)
    } else if (method == 'get') {
        return instance.get(url, { params: data })
    } else if (method == 'delete') {
        return instance.delete(url, { params: data })
    }else if(method == 'put'){
        return instance.put(url,data)
    }else{
        console.error('未知的method'+method)
        return false
    }
}
```

取消请求

```
// 方式一
const CancelToken = axios.CancelToken;
const source = CancelToken.source();

axios.get('xxxx', {
  cancelToken: source.token
})
// 取消请求 (请求原因是可选的)
source.cancel('主动取消请求');

// 方式二
const CancelToken = axios.CancelToken;
let cancel;

axios.get('xxxx', {
  cancelToken: new CancelToken(function executor(c) {
    cancel = c;
  })
});
cancel('主动取消请求');
```

# 2.axios是什么

axios是一个基于[promise](https://so.csdn.net/so/search?q=promise&spm=1001.2101.3001.7020)的http库，可以用在浏览器和node.js的环境中；本质上也是对原生xhr的封装，只不过它是promise的实现版本，符合最新的ES规范。

特性：

- 从浏览器中创建 XMLHttpRequests，或者从 node.js创建 http 请求。即axios可以在浏览器上和服务器上都可以发起请求。axios还是属于xhr，因此需要实现一个ajax或基于http
- 支持 Promise API
- 拦截请求和响应转换请求数据和响应数据
- 取消请求
- 自动转换JSON 数据
- 客户端支持防御 XSRF

**缺点**
1.不支持jsonp,需要自己封装
2.基于xhr实现，所以无法在service worker,web worker中使用

# 3.实现简易的axios

Axios构造函数，核心代码为request

```
class Axios {
    constructor() {

    }
    request(config) {
        return new Promise(resolve => {
            const {url = '', method = 'get', data = {}} = config;
            // 发送ajax请求
            const xhr = new XMLHttpRequest();
            xhr.open(method, url, true);
            xhr.onload = function() {
                console.log(xhr.responseText)
                resolve(xhr.responseText);
            }
            xhr.send(data);
        })
    }
}
```

导出axios实例

```
// 最终导出axios的方法，即实例的request方法
function CreateAxiosFn() {
    let axios = new Axios();
    let req = axios.request.bind(axios);
    return req;
}
// 得到最后的全局变量axios
let axios = CreateAxiosFn();

module.exports = function bind(fn, thisArg) {
  return function wrap() {
    var args = new Array(arguments.length);
    for (var i = 0; i < args.length; i++) {
      args[i] = arguments[i];
    }
    return fn.apply(thisArg, args);
  };
};
```

实现下axios.method()

```
// 定义get,post...方法，挂在到Axios原型上
const methodsArr = ['get', 'delete', 'head', 'options', 'put', 'patch', 'post'];
methodsArr.forEach(met => {
    Axios.prototype[met] = function() {
        console.log('执行'+met+'方法');
        // 处理单个方法
        if (['get', 'delete', 'head', 'options'].includes(met)) { // 2个参数(url[, config])
            return this.request({
                method: met,
                url: arguments[0],
                ...arguments[1] || {}
            })
        } else { // 3个参数(url[,data[,config]])
            return this.request({
                method: met,
                url: arguments[0],
                data: arguments[1] || {},
                ...arguments[2] || {}
            })
        }
    }
})
```

将`Axios.prototype`上的方法搬运到`request`上

```
工具类，实现将b方法混入到a，并且修改this指向
const utils = {
  extend(a,b, context) {
    for(let key in b) {
      if (b.hasOwnProperty(key)) {
        if (typeof b[key] === 'function') {
          a[key] = b[key].bind(context);
        } else {
          a[key] = b[key]
        }
      }
    }
  }
}
```

修改导出的方法

```
function CreateAxiosFn() {
  let axios = new Axios();
  let req = axios.request.bind(axios);
  // 增加代码
  utils.extend(req, Axios.prototype, axios)
  return req;
}
```

构建拦截器的构造函数

```
class InterceptorsManage {
  constructor() {
    this.handlers = [];
  }

  use(fullfield, rejected) {
    this.handlers.push({
      fullfield,
      rejected
    })
  }
}
```

实现`axios.interceptors.response.use`和`axios.interceptors.request.use`

```
class Axios {
    constructor() {
        // 新增代码
        this.interceptors = {
            request: new InterceptorsManage,
            response: new InterceptorsManage
        }
    }
    request(config) {
   ...
    }
}
```

把`Axios`上的方法和属性搬到`request`

- 将b的属性内容复制给a
- 此时将Axios原型上的方法复制到req中
- 最后把axios实例复制给req形成一个真正的req

```
function CreateAxiosFn() {
  let axios = new Axios();
  // req 绑定axios的默认数据 req，最后返回函数。即将Axios原型方法上的request方法绑定在context的上下文中
  let req = axios.request.bind(axios);
  // 混入方法，复制Axios的原型到扩展到实例中，即处理axios的request方法，使之拥有get,post...方法
  utils.extend(req, Axios.prototype, axios)
  // 将Axios的属性扩展到实例上
  utils.extend(req, axios)
  return req;
}
```

现在`request`也有了`interceptors`对象，在发送请求的时候，会先获取`request`拦截器的`handlers`的方法来执行。

首先将执行`ajax`的请求封装成一个方法

```
request(config) {
    this.sendAjax(config)
}
sendAjax(config){
    return new Promise(resolve => {
        const {url = '', method = 'get', data = {}} = config;
        // 发送ajax请求
        console.log(config);
        const xhr = new XMLHttpRequest();
        xhr.open(method, url, true);
        xhr.onload = function() {
            console.log(xhr.responseText)
            resolve(xhr.responseText);
        };
        xhr.send(data);
    })
}
```

封装`handlers`中的回调

```
request(config) {
    // 拦截器和请求组装队列
    let chain = [this.sendAjax.bind(this), undefined] // 成对出现的，失败回调暂时不处理

    // 请求拦截
    this.interceptors.request.handlers.forEach(interceptor => {
        chain.unshift(interceptor.fullfield, interceptor.rejected)
    })

    // 响应拦截
    this.interceptors.response.handlers.forEach(interceptor => {
        chain.push(interceptor.fullfield, interceptor.rejected)
    })

    // 执行队列，每次执行一对，并给promise赋最新的值
    let promise = Promise.resolve(config);
    while(chain.length > 0) {
        promise = promise.then(chain.shift(), chain.shift())
    }
    return promise;
}
```

完毕

# 4.**源码分析**

axios的配置共分为3种，全局配置、实例配置、请求配置；这三个配置和我们进行的操作息息相关

![image-20220504114715258](/img/image-20220504114715258.png)

<img src="/img/image-20220504113824868.png" alt="image-20220504113824868" style="zoom:67%;" />

实现入口文件为`axios.js`

- 合并请求配置和实例配置
- 规整化请求方法信息
- 收集请求拦截器和响应拦截器
- 进行发送请求
- 返回当前的promise

![image-20220504145413457](/img/image-20220504145413457.png)

![image-20220504114520526](/img/image-20220504114520526.png)

```
function createInstance(defaultConfig) {
  var context = new Axios(defaultConfig);

  // instance指向了request方法，且上下文指向context，所以可以直接以 instance(option) 方式调用 
  // Axios.prototype.request 内对第一个参数的数据类型判断，使我们能够以 instance(url, option) 方式调用
  var instance = bind(Axios.prototype.request, context);

  // 把Axios.prototype上的方法扩展到instance对象上，
  // 并指定上下文为context，这样执行Axios原型链上的方法时，this会指向context
  utils.extend(instance, Axios.prototype, context);

  // Copy context to instance
  // 把context对象上的自身属性和方法扩展到instance上
  // 注：因为extend内部使用的forEach方法对对象做for in 遍历时，只遍历对象本身的属性，而不会遍历原型链上的属性
  // 这样，instance 就有了  defaults、interceptors 属性。
  utils.extend(instance, context);
  return instance;
}

// Create the default instance to be exported 创建一个由默认配置生成的axios实例
var axios = createInstance(defaults);

// Factory for creating new instances 扩展axios.create工厂函数，内部也是 createInstance
axios.create = function create(instanceConfig) {
  return createInstance(mergeConfig(axios.defaults, instanceConfig));
};

// Expose all/spread
axios.all = function all(promises) {
  return Promise.all(promises);
};

axios.spread = function spread(callback) {
  return function wrap(arr) {
    return callback.apply(null, arr);
  };
};
module.exports = axios;
```

主要核心是 `Axios.prototype.request`

```
Axios.prototype.request = function request(config) {
  // Allow for axios('example/url'[, config]) a la fetch API
  // 判断 config 参数是否是 字符串，如果是则认为第一个参数是 URL，第二个参数是真正的config
  if (typeof config === 'string') {
    config = arguments[1] || {};
    // 把 url 放置到 config 对象中，便于之后的 mergeConfig
    config.url = arguments[0];
  } else {
    // 如果 config 参数是否是 字符串，则整体都当做config
    config = config || {};
  }
  // 合并默认配置和传入的配置
  config = mergeConfig(this.defaults, config);
  // 设置请求方法
  config.method = config.method ? config.method.toLowerCase() : 'get';
  /*
    something... 此部分会在后续拦截器单独讲述
  */
};

// 在 Axios 原型上挂载 'delete', 'get', 'head', 'options' 且不传参的请求方法，实现内部也是 request
utils.forEach(['delete', 'get', 'head', 'options'], function forEachMethodNoData(method) {
  Axios.prototype[method] = function(url, config) {
    return this.request(utils.merge(config || {}, {
      method: method,
      url: url
    }));
  };
});

// 在 Axios 原型上挂载 'post', 'put', 'patch' 且传参的请求方法，实现内部同样也是 request
utils.forEach(['post', 'put', 'patch'], function forEachMethodWithData(method) {
  Axios.prototype[method] = function(url, data, config) {
    return this.request(utils.merge(config || {}, {
      method: method,
      url: url,
      data: data
    }));
  };
});
```

从源码中，可以看到优先级：默认配置对象`default` < `method:get` < `Axios`的实例属性`this.default` < `request`参数。

**配置合并主要在/lib/core/mergeConfig.js**中进行，mergeConfig中主要涉及到三个主要key值的合并；

- valueFromConfig2Keys 是在请求的时候要进行添加的项目内容
- mergeDeepPropertiesKeys 需要神拷贝的key,比如headers、proxy等（主要是对象）
- defaultToConfig2Keys 浅拷贝字符串

合并的规则如下：

- 进行key遍历，如果config2中某个key存在内容，则取config2的内容
- 三个key遍历完成后，进行属性的合并，因为config2中有些属性是我们自己自定义设置的，将自定义的设置增加到config中

重点看看`request`方法

```
Axios.prototype.request = function request(config) {
  /*
    先是 mergeConfig ... 等，不再阐述
  */
  // Hook up interceptors middleware 创建拦截器链. dispatchRequest 是重中之重，后续重点
  var chain = [dispatchRequest, undefined];

  // push各个拦截器方法 注意：interceptor.fulfilled 或 interceptor.rejected 是可能为undefined
  this.interceptors.request.forEach(function unshiftRequestInterceptors(interceptor) {
    // 请求拦截器逆序 注意此处的 forEach 是自定义的拦截器的forEach方法
    chain.unshift(interceptor.fulfilled, interceptor.rejected);
  });

  this.interceptors.response.forEach(function pushResponseInterceptors(interceptor) {
    // 响应拦截器顺序 注意此处的 forEach 是自定义的拦截器的forEach方法
    chain.push(interceptor.fulfilled, interceptor.rejected);
  });

  // 初始化一个promise对象，状态为resolved，接收到的参数为已经处理合并过的config对象
  var promise = Promise.resolve(config);

  // 循环拦截器的链
  while (chain.length) {
    promise = promise.then(chain.shift(), chain.shift()); // 每一次向外弹出拦截器
  }
  // 返回 promise
  return promise;
};
```

`InterceptorManager`构造函数

```
// 拦截器的初始化 其实就是一组钩子函数
function InterceptorManager() {
  this.handlers = [];
}

// 调用拦截器实例的use时就是往钩子函数中push方法
InterceptorManager.prototype.use = function use(fulfilled, rejected) {
  this.handlers.push({
    fulfilled: fulfilled,
    rejected: rejected
  });
  return this.handlers.length - 1;
};

// 拦截器是可以取消的，根据use的时候返回的ID，把某一个拦截器方法置为null
// 不能用 splice 或者 slice 的原因是 删除之后 id 就会变化，导致之后的顺序或者是操作不可控
InterceptorManager.prototype.eject = function eject(id) {
  if (this.handlers[id]) {
    this.handlers[id] = null;
  }
};

// 这就是在 Axios的request方法中 中循环拦截器的方法 forEach 循环执行钩子函数
InterceptorManager.prototype.forEach = function forEach(fn) {
  utils.forEach(this.handlers, function forEachHandler(h) {
    if (h !== null) {
      fn(h);
    }
  });
}
```

请求拦截器方法是被 `unshift`到拦截器中，响应拦截器是被`push`到拦截器中的。最终它们会拼接上一个叫`dispatchRequest`的方法被后续的 `promise` 顺序执行。

**axios是如何实现取消请求**的，实现文件在CancelToken.js

```
function CancelToken(executor) {
  if (typeof executor !== 'function') {
    throw new TypeError('executor must be a function.');
  }
  // 在 CancelToken 上定义一个 pending 状态的 promise ，将 resolve 回调赋值给外部变量 resolvePromise
  var resolvePromise;
  this.promise = new Promise(function promiseExecutor(resolve) {
    resolvePromise = resolve;
  });

  var token = this;
  // 立即执行 传入的 executor函数，将真实的 cancel 方法通过参数传递出去。
  // 一旦调用就执行 resolvePromise 即前面的 promise 的 resolve，就更改promise的状态为 resolve。
  // 那么xhr中定义的 CancelToken.promise.then方法就会执行, 从而xhr内部会取消请求
  executor(function cancel(message) {
    // 判断请求是否已经取消过，避免多次执行
    if (token.reason) {
      return;
    }
    token.reason = new Cancel(message);
    resolvePromise(token.reason);
  });
}

CancelToken.source = function source() {
  // source 方法就是返回了一个 CancelToken 实例，与直接使用 new CancelToken 是一样的操作
  var cancel;
  var token = new CancelToken(function executor(c) {
    cancel = c;
  });
  // 返回创建的 CancelToken 实例以及取消方法
  return {
    token: token,
    cancel: cancel
  };
};
```

实际上取消请求的操作是在 `xhr.js` 中也有响应的配合的

```
if (config.cancelToken) {
    config.cancelToken.promise.then(function onCanceled(cancel) {
        if (!request) {
            return;
        }
        // 取消请求
        request.abort();
        reject(cancel);
    });
}
```

# 5.Fetch网络请求及xhr、ajax、axios

## 1.Fetch是什么

`fetch()`是 XMLHttpRequest 的升级版，用于在 JavaScript 脚本里面发出 HTTP 请求。

fetch与xmlHttpRequest区别：

（1）`fetch()`使用 Promise，不使用回调函数，因此大大简化了写法，写起来更简洁。

（2）`fetch()`采用模块化设计，API 分散在多个对象上（Response 对象、Request 对象、Headers 对象），更合理一些；相比之下，XMLHttpRequest 的 API 设计并不是很好，输入、输出、状态都在同一个接口管理，容易写出非常混乱的代码。

（3）`fetch()`通过数据流（Stream 对象）处理数据，可以分块读取，有利于提高网站性能表现，减少内存占用，对于请求大文件或者网速慢的场景相当有用。XMLHTTPRequest 对象不支持数据流，所有的数据必须放在缓存里，不支持分块读取，必须等待全部拿到后，再一次性吐出来。

**Fetch致命的两个问题**

- 返回值被promise包裹了2层

- 对IE的兼容性很不友好

## 2.常用写法

```js
fetch('https://api.github.com/users/ruanyf')
  .then(response => response.json())
  .then(json => console.log(json))
  .catch(err => console.log('Request Failed', err));
```

```js
async function getJSON() {
  let url = 'https://api.github.com/users/ruanyf';
  try {
    let response = await fetch(url);
    return await response.json();
  } catch (error) {
    console.log('Request Failed', error);
  }
}
```

## 3.fetch完整配置参数

```js
const response = fetch(url, {
  method: "GET",
  headers: {
    "Content-Type": "text/plain;charset=UTF-8"
  },
  body: undefined,
  referrer: "about:client",
  referrerPolicy: "no-referrer-when-downgrade",
  mode: "cors", 
  credentials: "same-origin",
  cache: "default",
  redirect: "follow",
  integrity: "",
  keepalive: false,
  signal: undefined
});
```

**cache**

`cache`属性指定如何处理缓存。可能的取值如下：

> - `default`：默认值，先在缓存里面寻找匹配的请求。
> - `no-store`：直接请求远程服务器，并且不更新缓存。
> - `reload`：直接请求远程服务器，并且更新缓存。
> - `no-cache`：将服务器资源跟本地缓存进行比较，有新的版本才使用服务器资源，否则使用缓存。
> - `force-cache`：缓存优先，只有不存在缓存的情况下，才请求远程服务器。
> - `only-if-cached`：只检查缓存，如果缓存里面不存在，将返回504错误。

**mode**

`mode`属性指定请求的模式。可能的取值如下：

> - `cors`：默认值，允许跨域请求。
> - `same-origin`：只允许同源请求。
> - `no-cors`：请求方法只限于 GET、POST 和 HEAD，并且只能使用有限的几个简单标头，不能添加跨域的复杂标头，相当于提交表单所能发出的请求。

**credentials**

`credentials`属性指定是否发送 Cookie。可能的取值如下：

> - `same-origin`：默认值，同源请求时发送 Cookie，跨域请求时不发送。
> - `include`：不管同源请求，还是跨域请求，一律发送 Cookie。
> - `omit`：一律不发送。

**signal**

`signal`属性指定一个 AbortSignal 实例，用于取消`fetch()`请求，详见下一节。

**keepalive**

`keepalive`属性用于页面卸载时，告诉浏览器在后台保持连接，继续发送数据。

一个典型的场景就是，用户离开网页时，脚本向服务器提交一些用户行为的统计信息。这时，如果不用`keepalive`属性，数据可能无法发送，因为浏览器已经把页面卸载了。

> ```js
> window.onunload = function() {
> fetch('/analytics', {
> method: 'POST',
> body: "statistics",
> keepalive: true
> });
> };
> ```

## 4.取消网络请求

首先新建 AbortController 实例，然后发送`fetch()`请求，配置对象的`signal`属性必须指定接收 AbortController 实例发送的信号`controller.signal`。

`controller.abort()`方法用于发出取消信号。这时会触发`abort`事件，这个事件可以监听，也可以通过`controller.signal.aborted`属性判断取消信号是否已经发出。

```js
let controller = new AbortController();
setTimeout(() => controller.abort(), 1000);

try {
  let response = await fetch('/long-operation', {
    signal: controller.signal
  });
} catch(err) {
  if (err.name == 'AbortError') {
    console.log('Aborted!');
  } else {
    throw err;
  }
}
```

## 5.fetch与xhr、ajax、axios比较

**XMLHttpRequest对象**

现代浏览器，最开始与服务器交换数据，都是通过XMLHttpRequest对象。它可以使用JSON、XML、HTML和text文本等格式发送和接收数据。

优点：

> 1. 不重新加载页面的情况下更新网页
> 2. 在页面已加载后从服务器请求/接收数据
> 3. 在后台向服务器发送数据。

缺点：

> 1. 使用起来也比较繁琐，需要设置很多值。
> 2. 早期的IE浏览器有自己的实现，这样需要写兼容代码。

 **jQuery ajax**

为了更快捷的操作DOM，并且规避一些浏览器兼容问题，产生了`jQuery`。它里面的`AJAX`请求也兼容了各浏览器，可以有简单易用的方法`$.get`，`$.post`。简单点说，就是对`XMLHttpRequest`对象的封装。

优点：

> 1. 对原生`XHR`的封装，做了兼容处理，简化了使用。
> 2. 增加了对`JSONP`的支持，可以简单处理部分跨域。

缺点：

> 1. 如果有多个请求，并且有依赖关系的话，容易形成回调地狱。
> 2. 本身是针对MVC的编程，不符合现在前端MVVM的浪潮。
> 3. ajax是jQuery中的一个方法。如果只是要使用ajax却要引入整个jQuery非常的不合理。

**axios**

`Axios`是一个基于`promise`的`HTTP`库，可以用在浏览器和 `node.js` 中。它本质也是对原生`XMLHttpRequest`的封装，只不过它是Promise的实现版本，符合最新的ES规范。

优点：

> 1. 从浏览器中创建`XMLHttpRequests`
> 2. 从 `node.js` 创建 `http` 请求
> 3. 支持 `Promise` API
> 4. 拦截请求和响应
> 5. 转换请求数据和响应数据
> 6. 取消请求
> 7. 自动转换 `JSON` 数据
> 8. 客户端支持防御 `XSRF`

缺点：

> 1. 只持现代代浏览器.

**fetch**

`Fetch API`提供了一个 `JavaScript` 接口，用于访问和操作`HTTP`管道的部分，例如请求和响应。它还提供了一个全局`fetch()`方法，该方法提供了一种简单，合理的方式来跨网络异步获取资源。
`fetch`是低层次的API，代替`XHR`，可以轻松处理各种格式，非文本化格式。可以很容易的被其他技术使用，例如`Service Workers`。但是想要很好的使用`fetch`，需要做一些封装处理。

优点：

> 在配置中，添加`mode： 'no-cors'`就可以跨域了

缺点：

> 1. `fetch`只对网络请求报错，对`400`，`500`都当做成功的请求，需要封装去处理
> 2. `fetch`默认不会带`cookie`，需要添加配置项。
> 3. `fetch`不支持`abort`，不支持超时控制，使用`setTimeout`及`Promise.reject`的实现超时控制并不能阻止请求过程继续在后台运行，造成了流量的浪费。
> 4. `fetch`没有办法原生监测请求的进度，而`XHR`可以。
> 5. 不能直接传递`JavaScript`对象作为参数
> 6. 需要自己判断返回值类型，并执行响应获取返回值的方法
> 7. 获取返回值方法只能调用一次，不能多次调用
> 8. 无法正常的捕获异常
> 9. 老版浏览器不会默认携带`cookie`
> 10. 不支持`jsonp`

注意：

> 请注意，`fetch`规范与`jQuery.ajax()`主要有两种方式的不同，牢记：
>
> -. 当接收到一个代表错误的 `HTTP 状态码`时，从 `fetch()`返回的 `Promise` **不会被标记为 reject**， 即使该 HTTP 响应的状态码是 `404` 或 `500`。相反，它会将 `Promise 状态`标记为 `resolve` （但是会将 `resolve`的返回值的 `ok` 属性设置为 `false` ），仅当网络故障时或请求被阻止时，才会标记为 `reject`。
>
> -. 默认情况下，`fetch` **不会从服务端发送或接收任何 cookies**, 如果站点依赖于用户 `session`，则会导致未经认证的请求（要发送 `cookies`，必须设置 `credentials` 选项）。

## 参考

[阮一峰—fetch API](https://www.ruanyifeng.com/blog/2020/12/fetch-tutorial.html)