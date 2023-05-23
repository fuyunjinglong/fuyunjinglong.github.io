---
title: 文件上传-拖拽
date: 2022-05-22 07:33:16
categories:
- B_JS
toc: true # 是否启用内容索引
---

# 文件上传-思路

## 前端

核心是`利用 Blob.prototype.slice` 方法，和数组的 slice 方法相似，文件的 slice 方法可以返回`原文件的某个切片`

> 预先定义好单个切片大小，将文件切分为一个个切片，然后借助 http 的可并发性，同时上传多个切片。这样从原本传一个大文件，变成了`并发`传多个小的文件切片，可以大大减少上传时间.
>
> 由于是并发，传输到服务端的顺序可能会发生变化，因此我们还需要给每个切片记录顺序

## 服务端

服务端负责接受前端传输的切片，并在接收到所有切片后`合并`所有切片

这里又引伸出两个问题

1. 何时合并切片，即切片什么时候传输完成
2. 如何合并切片

第一个问题需要前端配合，前端在每个切片中都携带切片最大数量的信息，当服务端接受到这个数量的切片时自动合并。或者也可以额外发一个请求，主动通知服务端进行切片的合并

第二个问题，具体如何合并切片呢？这里可以使用 Nodejs 的 读写流（readStream/writeStream），将所有切片的流传输到最终文件的流里

`talk is cheap,show me the code`，接着我们用代码实现上面的思路

# 文件上传-案例

[字节跳动-请你实现一个大文件上传和断点续传](https://juejin.cn/post/6844904046436843527#heading-2)

[Vue 大文件上传和断点续传](https://juejin.cn/post/6977555547570569223#heading-3)

## 前端部分

### 上传控件

首先创建选择文件的控件并监听 change 事件，另外就是上传按钮

```js
<template>
   <div>
    <input type="file" @change="handleFileChange" />
    <el-button @click="handleUpload">upload</el-button>
  </div>
</template>

<script>
export default {
  data: () => ({
    container: {
      file: null
    }
  }),
  methods: {
     handleFileChange(e) {
      const [file] = e.target.files;
      if (!file) return;
      Object.assign(this.$data, this.$options.data());
      this.container.file = file;
    },
    async handleUpload() {}
  }
};
</script>
复制代码
```

### 请求逻辑

考虑到通用性，这里没有用第三方的请求库，而是用原生 XMLHttpRequest 做一层简单的封装来发请求

```js
request({
      url,
      method = "post",
      data,
      headers = {},
      requestList
    }) {
      return new Promise(resolve => {
        const xhr = new XMLHttpRequest();
        xhr.open(method, url);
        Object.keys(headers).forEach(key =>
          xhr.setRequestHeader(key, headers[key])
        );
        xhr.send(data);
        xhr.onload = e => {
          resolve({
            data: e.target.response
          });
        };
      });
    }
复制代码
```

### 上传切片

接着实现比较重要的上传功能，上传需要做两件事

- 对文件进行切片
- 将切片传输给服务端

```diff
<template>
  <div>
    <input type="file" @change="handleFileChange" />
    <el-button @click="handleUpload">上传</el-button>
  </div>
</template>

<script>
+ // 切片大小
+ // the chunk size
+ const SIZE = 10 * 1024 * 1024; 

export default {
  data: () => ({
    container: {
      file: null
    }，
+   data: []
  }),
  methods: {
    request() {},
    handleFileChange() {},
+    // 生成文件切片
+    createFileChunk(file, size = SIZE) {
+     const fileChunkList = [];
+      let cur = 0;
+      while (cur < file.size) {
+        fileChunkList.push({ file: file.slice(cur, cur + size) });
+        cur += size;
+      }
+      return fileChunkList;
+    },
+   // 上传切片
+    async uploadChunks() {
+      const requestList = this.data
+        .map(({ chunk，hash }) => {
+          const formData = new FormData();
+          formData.append("chunk", chunk);
+          formData.append("hash", hash);
+          formData.append("filename", this.container.file.name);
+          return { formData };
+        })
+        .map(({ formData }) =>
+          this.request({
+            url: "http://localhost:3000",
+            data: formData
+          })
+        );
+      // 并发请求
+      await Promise.all(requestList); 
+    },
+    async handleUpload() {
+      if (!this.container.file) return;
+      const fileChunkList = this.createFileChunk(this.container.file);
+      this.data = fileChunkList.map(({ file }，index) => ({
+        chunk: file,
+        // 文件名 + 数组下标
+        hash: this.container.file.name + "-" + index
+      }));
+      await this.uploadChunks();
+    }
  }
};
</script>
复制代码
```

当点击上传按钮时，调用 `createFileChunk` 将文件切片，切片数量通过文件大小控制，这里设置 10MB，也就是说一个 100 MB 的文件会被分成 10 个 10MB 的切片

createFileChunk 内使用 while 循环和 slice 方法将切片放入 `fileChunkList` 数组中返回

在生成文件切片时，需要给每个切片一个标识作为 hash，这里暂时使用`文件名 + 下标`，这样后端可以知道当前切片是第几个切片，用于之后的合并切片

随后调用 `uploadChunks` 上传所有的文件切片，将文件切片，切片 hash，以及文件名放入 formData 中，再调用上一步的 `request` 函数返回一个 proimise，最后调用 Promise.all 并发上传所有的切片

### 发送合并请求

使用整体思路中提到的第二种合并切片的方式，即前端主动通知服务端进行合并

前端发送额外的合并请求，服务端接受到请求时合并切片

```diff
<template>
  <div>
    <input type="file" @change="handleFileChange" />
    <el-button @click="handleUpload">upload</el-button>
  </div>
</template>

<script>
export default {
  data: () => ({
    container: {
      file: null
    },
    data: []
  }),
  methods: {
    request() {},
    handleFileChange() {},
    createFileChunk() {},
    async uploadChunks() {
      const requestList = this.data
        .map(({ chunk，hash }) => {
          const formData = new FormData();
          formData.append("chunk", chunk);
          formData.append("hash", hash);
          formData.append("filename", this.container.file.name);
          return { formData };
        })
        .map(({ formData }) =>
          this.request({
            url: "http://localhost:3000",
            data: formData
          })
        );
      await Promise.all(requestList);
+     // 合并切片
+     await this.mergeRequest();
    },
+    async mergeRequest() {
+      await this.request({
+        url: "http://localhost:3000/merge",
+        headers: {
+          "content-type": "application/json"
+        },
+        data: JSON.stringify({
+          filename: this.container.file.name
+        })
+      });
+    },    
    async handleUpload() {}
  }
};
</script>
复制代码
```

## 服务端部分

使用 http 模块搭建一个简单服务端

```js
const http = require("http");
const server = http.createServer();

server.on("request", async (req, res) => {
  res.setHeader("Access-Control-Allow-Origin", "*");
  res.setHeader("Access-Control-Allow-Headers", "*");
  if (req.method === "OPTIONS") {
    res.status = 200;
    res.end();
    return;
  }
});

server.listen(3000, () => console.log("listening port 3000"));
复制代码
```

### 接受切片

使用 [`multiparty`](https://link.juejin.cn?target=https%3A%2F%2Fwww.npmjs.com%2Fpackage%2Fmultiparty) 处理前端传来的 formData

在 multiparty.parse 的回调中，files 参数保存了 formData 中文件，fields 参数保存了 formData 中非文件的字段

```diff
const http = require("http");
const path = require("path");
+ const fse = require("fs-extra");
+ const multiparty = require("multiparty");

const server = http.createServer();
+ // 大文件存储目录
+ const UPLOAD_DIR = path.resolve(__dirname, "..", "target");

server.on("request", async (req, res) => {
  res.setHeader("Access-Control-Allow-Origin", "*");
  res.setHeader("Access-Control-Allow-Headers", "*");
  if (req.method === "OPTIONS") {
    res.status = 200;
    res.end();
    return;
  }

+  const multipart = new multiparty.Form();

+  multipart.parse(req, async (err, fields, files) => {
+    if (err) {
+      return;
+    }
+    const [chunk] = files.chunk;
+    const [hash] = fields.hash;
+    const [filename] = fields.filename;
+    // 创建临时文件夹用于临时存储 chunk
+    // 添加 chunkDir 前缀与文件名做区分
+    const chunkDir = path.resolve(UPLOAD_DIR, 'chunkDir' + filename);

+    if (!fse.existsSync(chunkDir)) {
+      await fse.mkdirs(chunkDir);
+    }

+    // fs-extra 的 rename 方法 windows 平台会有权限问题
+    // @see https://github.com/meteor/meteor/issues/7852#issuecomment-255767835
+    await fse.move(chunk.path, `${chunkDir}/${hash}`);
+    res.end("received file chunk");
+  });
});

server.listen(3000, () => console.log("listening port 3000"));
```

<img src="/img/image-20220522182440401.png" alt="image-20220522182440401" style="zoom:80%;" />

查看 multiparty 处理后的 chunk 对象，path 是存储临时文件的路径，size 是临时文件大小，在 multiparty 文档中提到可以使用 fs.rename（这里换成了 fs.remove, 因为 fs-extra 的 rename 方法在 windows 平台[存在权限问题](https://link.juejin.cn?target=https%3A%2F%2Fgithub.com%2Fmeteor%2Fmeteor%2Fissues%2F7852%23issuecomment-255767835)）

在接受文件切片时，需要先创建临时存储切片的文件夹，以 chunkDir 作为前缀，文件名作为后缀

由于前端在发送每个切片时额外携带了唯一值 hash，所以以 hash 作为文件名，将切片从临时路径移动切片文件夹中，最后的结果如下

<img src="/img/image-20220522182510130.png" alt="image-20220522182510130" style="zoom:67%;" />

### 合并切片

在接收到前端发送的合并请求后，服务端将文件夹下的所有切片进行合并

```diff
const http = require("http");
const path = require("path");
const fse = require("fs-extra");

const server = http.createServer();
const UPLOAD_DIR = path.resolve(__dirname, "..", "target");

+ const resolvePost = req =>
+   new Promise(resolve => {
+     let chunk = "";
+     req.on("data", data => {
+       chunk += data;
+     });
+     req.on("end", () => {
+       resolve(JSON.parse(chunk));
+     });
+   });

+ // 写入文件流
+ const pipeStream = (path, writeStream) =>
+  new Promise(resolve => {
+    const readStream = fse.createReadStream(path);
+    readStream.on("end", () => {
+      fse.unlinkSync(path);
+      resolve();
+    });
+    readStream.pipe(writeStream);
+  });

// 合并切片
+ const mergeFileChunk = async (filePath, filename, size) => {
+   const chunkDir = path.resolve(UPLOAD_DIR, 'chunkDir' + filename);
+   const chunkPaths = await fse.readdir(chunkDir);
+   // 根据切片下标进行排序
+   // 否则直接读取目录的获得的顺序会错乱
+   chunkPaths.sort((a, b) => a.split("-")[1] - b.split("-")[1]);
+   // 并发写入文件
+   await Promise.all(
+     chunkPaths.map((chunkPath, index) =>
+       pipeStream(
+         path.resolve(chunkDir, chunkPath),
+         // 根据 size 在指定位置创建可写流
+         fse.createWriteStream(filePath, {
+           start: index * size,
+         })
+       )
+     )
+  );
+  // 合并后删除保存切片的目录
+  fse.rmdirSync(chunkDir);
+};

server.on("request", async (req, res) => {
  res.setHeader("Access-Control-Allow-Origin", "*");
  res.setHeader("Access-Control-Allow-Headers", "*");
  if (req.method === "OPTIONS") {
    res.status = 200;
    res.end();
    return;
  }

+   if (req.url === "/merge") {
+     const data = await resolvePost(req);
+     const { filename,size } = data;
+     const filePath = path.resolve(UPLOAD_DIR, `${filename}`);
+     await mergeFileChunk(filePath, filename);
+     res.end(
+       JSON.stringify({
+         code: 0,
+         message: "file merged success"
+       })
+     );
+   }

});

server.listen(3000, () => console.log("listening port 3000"));
复制代码
```

由于前端在发送合并请求时会携带文件名，服务端根据文件名可以找到上一步创建的切片文件夹

接着使用 fs.createWriteStream 创建一个可写流，可写流文件名就是上传时的文件名

随后遍历整个切片文件夹，将切片通过 fs.createReadStream 创建可读流，传输合并到目标文件中

值得注意的是每次可读流都会传输到可写流的指定位置，这是通过 createWriteStream 的第二个参数 start 控制的，目的是能够并发合并多个可读流至可写流中，这样即使并发时流的顺序不同，也能传输到正确的位置

所以还需要让前端在请求的时候提供之前设定好的 size 给服务端，服务端根据 size 指定可读流的起始位置

```diff
   async mergeRequest() {
      await this.request({
        url: "http://localhost:3000/merge",
        headers: {
          "content-type": "application/json"
        },
        data: JSON.stringify({
+         size: SIZE,
          filename: this.container.file.name
        })
      });
    },
```

<img src="/img/image-20220522182539526.png" alt="image-20220522182539526" style="zoom:67%;" />

其实也可以等上一个切片合并完后再合并下个切片，这样就不需要指定位置，但传输速度会降低，所以使用了并发合并的手段

接着只要保证每次合并完成后删除这个切片，等所有切片都合并完毕后最后删除切片文件夹即可

<img src="/img/image-20220522182559674.png" alt="image-20220522182559674" style="zoom:67%;" />

至此一个简单的大文件上传就完成了，接下来我们再此基础上扩展一些额外的功能

## 显示上传进度条

上传进度分两种，一个是每个切片的上传进度，另一个是整个文件的上传进度，而整个文件的上传进度是基于每个切片上传进度计算而来，所以我们先实现单个切片的进度条

### 单个切片进度条

XMLHttpRequest 原生支持上传进度的监听，只需要监听 upload.onprogress 即可，我们在原来的 request 基础上传入 onProgress 参数，给 XMLHttpRequest 注册监听事件

```diff
 // xhr
    request({
      url,
      method = "post",
      data,
      headers = {},
+     onProgress = e => e,
      requestList
    }) {
      return new Promise(resolve => {
        const xhr = new XMLHttpRequest();
+       xhr.upload.onprogress = onProgress;
        xhr.open(method, url);
        Object.keys(headers).forEach(key =>
          xhr.setRequestHeader(key, headers[key])
        );
        xhr.send(data);
        xhr.onload = e => {
          resolve({
            data: e.target.response
          });
        };
      });
    }
复制代码
```

由于每个切片都需要触发独立的监听事件，所以需要一个工厂函数，根据传入的切片返回不同的监听函数

在原先的前端上传逻辑中新增监听函数部分

```diff
    // 上传切片，同时过滤已上传的切片
    async uploadChunks(uploadedList = []) {
      const requestList = this.data
+       .map(({ chunk,hash,index }) => {
          const formData = new FormData();
          formData.append("chunk", chunk);
          formData.append("hash", hash);
          formData.append("filename", this.container.file.name);
+         return { formData,index };
        })
+       .map(({ formData,index }) =>
          this.request({
            url: "http://localhost:3000",
            data: formData，
+           onProgress: this.createProgressHandler(this.data[index]),
          })
        );
      await Promise.all(requestList);
      await this.mergeRequest();
    },
    async handleUpload() {
      if (!this.container.file) return;
      const fileChunkList = this.createFileChunk(this.container.file);
      this.data = fileChunkList.map(({ file }，index) => ({
        chunk: file,
+       index,
        hash: this.container.file.name + "-" + index
+       percentage:0
      }));
      await this.uploadChunks();
    }    
+   createProgressHandler(item) {
+      return e => {
+        item.percentage = parseInt(String((e.loaded / e.total) * 100));
+      };
+   }
复制代码
```

每个切片在上传时都会通过监听函数更新 data 数组对应元素的 percentage 属性，之后把将 data 数组放到视图中展示即可

### 总进度条

将每个切片已上传的部分累加，除以整个文件的大小，就能得出当前文件的上传进度，所以这里使用 Vue 的计算属性

```js
  computed: {
       uploadPercentage() {
          if (!this.container.file || !this.data.length) return 0;
          const loaded = this.data
            .map(item => item.size * item.percentage)
            .reduce((acc, cur) => acc + cur);
          return parseInt((loaded / this.container.file.size).toFixed(2));
        }
 }
复制代码
```

## 断点续传

断点续传的原理在于前端/服务端需要`记住`已上传的切片，这样下次上传就可以跳过之前已上传的部分，有两种方案实现记忆的功能

- 前端使用 localStorage 记录已上传的切片 hash
- 服务端保存已上传的切片 hash，前端每次上传前向服务端获取已上传的切片

第一种是前端的解决方案，第二种是服务端，而前端方案有一个缺陷，如果换了个浏览器就失去了记忆的效果，所以这里选后者

### 生成 hash

无论是前端还是服务端，都必须要生成文件和切片的 hash，`之前我们使用文件名 + 切片下标作为切片 hash`，这样做文件名一旦修改就失去了效果，而事实上只要文件内容不变，hash 就不应该变化，所以正确的做法是`根据文件内容生成 hash`，所以我们修改一下 hash 的生成规则

> webpack 的产物 contenthash 也是基于这个思路实现的

这里用到另一个库 [`spark-md5`](https://link.juejin.cn?target=https%3A%2F%2Fwww.npmjs.com%2Fpackage%2Fspark-md5)，它可以根据文件内容计算出文件的 hash 值

另外考虑到如果上传一个超大文件，读取文件内容计算 hash 是非常耗费时间的，并且会`引起 UI 的阻塞`，导致页面假死状态，所以我们使用 web-worker 在 worker 线程计算 hash，这样用户仍可以在主界面正常的交互

由于实例化 web-worker 时，参数是一个 js 文件路径且不能跨域，所以我们单独创建一个 hash.js 文件放在 public 目录下，另外在 worker 中也是不允许访问 dom 的，但它提供了`importScripts` 函数用于导入外部脚本，通过它导入 spark-md5

```js
// /public/hash.js

// 导入脚本
self.importScripts("/spark-md5.min.js");

// 生成文件 hash
self.onmessage = e => {
  const { fileChunkList } = e.data;
  const spark = new self.SparkMD5.ArrayBuffer();
  let percentage = 0;
  let count = 0;
  const loadNext = index => {
    const reader = new FileReader();
    reader.readAsArrayBuffer(fileChunkList[index].file);
    reader.onload = e => {
      count++;
      spark.append(e.target.result);
      if (count === fileChunkList.length) {
        self.postMessage({
          percentage: 100,
          hash: spark.end()
        });
        self.close();
      } else {
        percentage += 100 / fileChunkList.length;
        self.postMessage({
          percentage
        });
        // calculate recursively
        loadNext(count);
      }
    };
  };
  loadNext(0);
};
复制代码
```

在 worker 线程中，接受文件切片 fileChunkList，利用 fileReader 读取每个切片的 ArrayBuffer 并不断传入 spark-md5 中，每计算完一个切片通过 postMessage 向主线程发送一个进度事件，全部完成后将最终的 hash 发送给主线程

> spark-md5 文档中要求传入所有切片并算出 hash 值，不能直接将整个文件放入计算，否则即使不同文件也会有相同的 hash

接着编写主线程与 worker 线程通讯的逻辑

```diff
+    // 生成文件 hash（web-worker）
+    calculateHash(fileChunkList) {
+      return new Promise(resolve => {
+        // 添加 worker 属性
+        this.container.worker = new Worker("/hash.js");
+        this.container.worker.postMessage({ fileChunkList });
+        this.container.worker.onmessage = e => {
+          const { percentage, hash } = e.data;
+          this.hashPercentage = percentage;
+          if (hash) {
+            resolve(hash);
+          }
+        };
+      });
    },
    async handleUpload() {
      if (!this.container.file) return;
      const fileChunkList = this.createFileChunk(this.container.file);
+     this.container.hash = await this.calculateHash(fileChunkList);
      this.data = fileChunkList.map(({ file }，index) => ({
+       fileHash: this.container.hash,
        chunk: file,
        hash: this.container.file.name + "-" + index,
        percentage:0
      }));
      await this.uploadChunks();
    }   
复制代码
```

主线程使用 `postMessage` 给 worker 线程传入所有切片 fileChunkList，并监听 worker 线程发出的 postMessage 事件拿到文件 hash

加上显示计算 hash 的进度条，看起来像这样

![image-20220513233036099](https://p3-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/56ab0d35c22b45bf8109632f4fb12f04~tplv-k3u1fbpfcp-zoom-in-crop-mark:1304:0:0:0.awebp)

至此前端需要将之前用文件名作为 hash 的地方改写为 worker 返回的 hash

<img src="/img/image-20220522182712441.png" alt="image-20220522182712441" style="zoom: 80%;" />

服务端则使用固定前缀 + hash 作为切片文件夹名，hash + 下标作为切片名，hash + 扩展名作为文件名

<img src="/img/image-20220522182735515.png" alt="image-20220522182735515" style="zoom: 67%;" />

<img src="/img/image-20220522182802518.png" alt="image-20220522182802518" style="zoom:67%;" />

### 文件秒传

在实现断点续传前先简单介绍一下文件秒传

所谓的文件秒传，即在服务端已经存在了上传的资源，所以当用户`再次上传`时会直接提示上传成功

文件秒传需要依赖上一步生成的 hash，即在`上传前`，先计算出文件 hash，并把 hash 发送给服务端进行验证，由于 hash 的唯一性，所以一旦服务端能找到 hash 相同的文件，则直接返回上传成功的信息即可

```diff
+    async verifyUpload(filename, fileHash) {
+       const { data } = await this.request({
+         url: "http://localhost:3000/verify",
+         headers: {
+           "content-type": "application/json"
+         },
+         data: JSON.stringify({
+           filename,
+           fileHash
+         })
+       });
+       return JSON.parse(data);
+     },
   async handleUpload() {
      if (!this.container.file) return;
      const fileChunkList = this.createFileChunk(this.container.file);
      this.container.hash = await this.calculateHash(fileChunkList);
+     const { shouldUpload } = await this.verifyUpload(
+       this.container.file.name,
+       this.container.hash
+     );
+     if (!shouldUpload) {
+       this.$message.success("skip upload：file upload success");
+       return;
+    }
     this.data = fileChunkList.map(({ file }, index) => ({
        fileHash: this.container.hash,
        index,
        hash: this.container.hash + "-" + index,
        chunk: file,
        percentage: 0
      }));
      await this.uploadChunks();
    }   
复制代码
```

秒传其实就是给用户看的障眼法，实质上根本没有上传

<img src="/img/image-20220522182832356.png" alt="image-20220522182832356" style="zoom: 80%;" />

服务端的逻辑非常简单，新增一个验证接口，验证文件是否存在即可

```diff
+ // 提取后缀名
+ const extractExt = filename =>
+  filename.slice(filename.lastIndexOf("."), filename.length);
const UPLOAD_DIR = path.resolve(__dirname, "..", "target");

const resolvePost = req =>
  new Promise(resolve => {
    let chunk = "";
    req.on("data", data => {
      chunk += data;
    });
    req.on("end", () => {
      resolve(JSON.parse(chunk));
    });
  });

server.on("request", async (req, res) => {
  if (req.url === "/verify") {
+    const data = await resolvePost(req);
+    const { fileHash, filename } = data;
+    const ext = extractExt(filename);
+    const filePath = path.resolve(UPLOAD_DIR, `${fileHash}${ext}`);
+    if (fse.existsSync(filePath)) {
+      res.end(
+        JSON.stringify({
+          shouldUpload: false
+        })
+      );
+    } else {
+      res.end(
+        JSON.stringify({
+          shouldUpload: true
+        })
+      );
+    }
  }
});

server.listen(3000, () => console.log("listening port 3000"));
复制代码
```

### 暂停上传

讲完了生成 hash 和文件秒传，回到断点续传

断点续传顾名思义即断点 + 续传，所以我们第一步先实现“断点”，也就是暂停上传

原理是使用 XMLHttpRequest 的 `abort` 方法，可以取消一个 xhr 请求的发送，为此我们需要将上传每个切片的 xhr 对象保存起来，我们再改造一下 request 方法

```diff
   request({
      url,
      method = "post",
      data,
      headers = {},
      onProgress = e => e,
+     requestList
    }) {
      return new Promise(resolve => {
        const xhr = new XMLHttpRequest();
        xhr.upload.onprogress = onProgress;
        xhr.open(method, url);
        Object.keys(headers).forEach(key =>
          xhr.setRequestHeader(key, headers[key])
        );
        xhr.send(data);
        xhr.onload = e => {
+          // 将请求成功的 xhr 从列表中删除
+          if (requestList) {
+            const xhrIndex = requestList.findIndex(item => item === xhr);
+            requestList.splice(xhrIndex, 1);
+          }
          resolve({
            data: e.target.response
          });
        };
+        // 暴露当前 xhr 给外部
+        requestList?.push(xhr);
      });
    },
复制代码
```

这样在上传切片时传入 requestList 数组作为参数，request 方法就会将所有的 xhr 保存在数组中了

<img src="/img/image-20220522182911367.png" alt="image-20220522182911367" style="zoom: 25%;" />

每当一个切片上传成功时，将对应的 xhr 从 requestList 中删除，所以 requestList 中只保存`正在上传切片的 xhr`

之后新建一个暂停按钮，当点击按钮时，调用保存在 requestList 中 xhr 的 abort 方法，即取消并清空所有正在上传的切片

```
 handlePause() {
    this.requestList.forEach(xhr => xhr?.abort());
    this.requestList = [];
}
复制代码
```

点击暂停按钮可以看到 xhr 都被取消了

<img src="/img/image-20220522182945865.png" alt="image-20220522182945865" style="zoom:67%;" />

### 恢复上传

之前在介绍断点续传的时提到使用第二种服务端存储的方式实现续传

由于当文件切片上传后，服务端会建立一个文件夹存储所有上传的切片，所以每次前端上传前可以调用一个接口，服务端将已上传的切片的切片名返回，前端再跳过这些已经上传切片，这样就实现了“续传”的效果

而这个接口可以和之前秒传的验证接口合并，前端每次上传前发送一个验证的请求，返回两种结果

- 服务端已存在该文件，不需要再次上传
- 服务端不存在该文件或者已上传部分文件切片，通知前端进行上传，并把**已上传**的文件切片返回给前端

所以我们改造一下之前文件秒传的服务端验证接口

```diff
const extractExt = filename =>
  filename.slice(filename.lastIndexOf("."), filename.length);
const UPLOAD_DIR = path.resolve(__dirname, "..", "target");

const resolvePost = req =>
  new Promise(resolve => {
    let chunk = "";
    req.on("data", data => {
      chunk += data;
    });
    req.on("end", () => {
      resolve(JSON.parse(chunk));
    });
  });
  
+ // 返回已上传的所有切片名
+ const createUploadedList = async fileHash =>
+   fse.existsSync(path.resolve(UPLOAD_DIR, fileHash))
+    ? await fse.readdir(path.resolve(UPLOAD_DIR, fileHash))
+    : [];

server.on("request", async (req, res) => {
  if (req.url === "/verify") {
    const data = await resolvePost(req);
    const { fileHash, filename } = data;
    const ext = extractExt(filename);
    const filePath = path.resolve(UPLOAD_DIR, `${fileHash}${ext}`);
    if (fse.existsSync(filePath)) {
      res.end(
        JSON.stringify({
          shouldUpload: false
        })
      );
    } else {
      res.end(
        JSON.stringify({
          shouldUpload: true，
+         uploadedList: await createUploadedList(fileHash)
        })
      );
    }
  }
});

server.listen(3000, () => console.log("listening port 3000"));
复制代码
```

接着回到前端，前端有两个地方需要调用验证的接口

- 点击上传时，检查是否需要上传和已上传的切片
- 点击暂停后的恢复上传，返回已上传的切片

新增恢复按钮并改造原来上传切片的逻辑

```diff
<template>
  <div id="app">
      <input
        type="file"
        @change="handleFileChange"
      />
       <el-button @click="handleUpload">upload</el-button>
       <el-button @click="handlePause" v-if="isPaused">pause</el-button>
+      <el-button @click="handleResume" v-else>resume</el-button>
      //...
    </div>
</template>

+   async handleResume() {
+      const { uploadedList } = await this.verifyUpload(
+        this.container.file.name,
+        this.container.hash
+      );
+      await this.uploadChunks(uploadedList);
    },
    async handleUpload() {
      if (!this.container.file) return;
      const fileChunkList = this.createFileChunk(this.container.file);
      this.container.hash = await this.calculateHash(fileChunkList);
+     const { shouldUpload, uploadedList } = await this.verifyUpload(
+       this.container.file.name,
+       this.container.hash
+     );
+     if (!shouldUpload) {
+       this.$message.success("skip upload：file upload success");
+       return;
+     }
      this.data = fileChunkList.map(({ file }, index) => ({
        fileHash: this.container.hash,
        index,
        hash: this.container.hash + "-" + index,
        chunk: file，
        percentage: 0
      }));
+      await this.uploadChunks(uploadedList);
    },
    // 上传切片，同时过滤已上传的切片
+   async uploadChunks(uploadedList = []) {
      const requestList = this.data
+       .filter(({ hash }) => !uploadedList.includes(hash))
        .map(({ chunk, hash, index }) => {
          const formData = new FormData();
          formData.append("chunk", chunk);
          formData.append("hash", hash);
          formData.append("filename", this.container.file.name);
          formData.append("fileHash", this.container.hash);
          return { formData, index };
        })
        .map(({ formData, index }) =>
          this.request({
            url: "http://localhost:3000",
            data: formData,
            onProgress: this.createProgressHandler(this.data[index]),
            requestList: this.requestList
          })
        );
      await Promise.all(requestList);
+     // 之前上传的切片数量 + 本次上传的切片数量 = 所有切片数量时合并切片
+     if (uploadedList.length + requestList.length === this.data.length) {
         await this.mergeRequest();
+     }
    }
复制代码
```

![image-20220513234956206](https://p3-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/8c0ddc6950a547329a47b22122f7eb66~tplv-k3u1fbpfcp-zoom-in-crop-mark:1304:0:0:0.awebp)

这里给原来上传切片的函数新增 uploadedList 参数，即上图中服务端返回的切片名列表，通过 filter 过滤掉已上传的切片，并且由于新增了已上传的部分，所以之前合并接口的触发条件做了一些改动

到这里断点续传的功能基本完成了

### 进度条改进

虽然实现了断点续传，但还需要修改一下进度条的显示规则，否则在暂停上传/接收到已上传切片时的进度条会出现偏差

#### 单个切片进度条

由于在点击上传/恢复上传时，会调用验证接口返回已上传的切片，所以需要将已上传切片的进度变成 100%

```diff
   async handleUpload() {
      if (!this.container.file) return;
      const fileChunkList = this.createFileChunk(this.container.file);
      this.container.hash = await this.calculateHash(fileChunkList);
      const { shouldUpload, uploadedList } = await this.verifyUpload(
        this.container.file.name,
        this.container.hash
      );
      if (!shouldUpload) {
        this.$message.success("skip upload：file upload success");
        return;
      }
      this.data = fileChunkList.map(({ file }, index) => ({
        fileHash: this.container.hash,
        index,
        hash: this.container.hash + "-" + index,
        chunk: file,
+       percentage: uploadedList.includes(index) ? 100 : 0
      }));
      await this.uploadChunks(uploadedList);
    },
复制代码
```

uploadedList 会返回已上传的切片，在遍历所有切片时判断当前切片是否在已上传列表里即可

#### 总进度条

之前说到总进度条是一个计算属性，根据所有切片的上传进度计算而来，这就遇到了一个问题

<img src="/img/image-20220522183024960.png" alt="image-20220522183024960" style="zoom:80%;" />

点击暂停会取消并清空切片的 xhr 请求，此时如果已经上传了一部分，就会发现文件进度条有`倒退`的现象



<img src="/img/image-20220522183045426.png" alt="image-20220522183045426" style="zoom:80%;" />

当点击恢复时，由于重新创建了 xhr 导致切片进度清零，所以总进度条就会倒退

解决方案是创建一个“假”的进度条，这个假进度条基于文件进度条，但只会停止和增加，然后给用户展示这个假的进度条

这里我们使用 Vue 的监听属性

```diff
  data: () => ({
+    fakeUploadPercentage: 0
  }),
  computed: {
    uploadPercentage() {
      if (!this.container.file || !this.data.length) return 0;
      const loaded = this.data
        .map(item => item.size * item.percentage)
        .reduce((acc, cur) => acc + cur);
      return parseInt((loaded / this.container.file.size).toFixed(2));
    }
  },  
  watch: {
+    uploadPercentage(now) {
+      if (now > this.fakeUploadPercentage) {
+        this.fakeUploadPercentage = now;
+      }
    }
  },
复制代码
```

当 uploadPercentage 即真的文件进度条增加时，fakeUploadPercentage 也增加，一旦文件进度条后退，假的进度条只需停止即可

至此一个大文件上传 + 断点续传的解决方案就完成了

# 文件上传-总结

大文件上传

- 前端上传大文件时使用 Blob.prototype.slice 将文件切片，并发上传多个切片，最后发送一个合并的请求通知服务端合并切片
- 服务端接收切片并存储，收到合并请求后使用流将切片合并到最终文件
- 原生 XMLHttpRequest 的 upload.onprogress 对切片上传进度的监听
- 使用 Vue 计算属性根据每个切片的进度算出整个文件的上传进度

断点续传

- 使用 spark-md5 根据文件内容算出文件 hash
- 通过 hash 可以判断服务端是否已经上传该文件，从而直接提示用户上传成功（秒传）
- 通过 XMLHttpRequest 的 abort 方法暂停切片的上传
- 上传前服务端返回已经上传的切片名，前端跳过这些切片的上传

# 拖拽-张鑫旭极简JS

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

# 拖拽-原生实现

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

