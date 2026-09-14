---
title: 多端_桌面端
date: 2004-03-01 06:33:16
categories:
  - B_中级
toc: true # 是否启用内容索引
---

# 大纲

**参考**

> - [Electron+TS+Vue3](https://www.bilibili.com/video/BV13BopYvEHc/?spm_id_from=333.337.search-card.all.click&vd_source=bd4c7d99d71adf64d6e88c65370e0247)
> - [禹神：一小时快速上手 Electron](https://www.bilibili.com/video/BV1sE421N7M5/?spm_id_from=333.337.search-card.all.click&vd_source=bd4c7d99d71adf64d6e88c65370e0247)
> - [Electron 入门到精通](https://www.bilibili.com/video/BV1xd4y1J7dB/?spm_id_from=333.337.search-card.all.click&vd_source=bd4c7d99d71adf64d6e88c65370e0247)

# 初级

## Electron是什么

**一、定义**

> Electron 是一个使用 Web 技术构建跨平台桌面应用的框架，由 GitHub 开源（前身是 Atom Editor 的 shell）。

**二、底层原理**

底层可以概括为三层：

> - **Chromium**：提供渲染引擎，负责界面绘制，支持所有现代 Web 特性；
> - **Node.js**：提供系统能力，比如文件读写、网络、调用操作系统 API；
> - **原生 API 适配层**：Electron 自己封装的一层，把不同操作系统（Windows/macOS/Linux）的原生能力（窗口、托盘、对话框、菜单）统一成一套 JS API。

**三、优缺点**

> - 优点：一套代码跑三端，前端技术栈零成本迁移
> - 缺点：每个应用都内嵌一个完整 Chromium，所以内存和包体积偏大

## 主进程和渲染进程

**一、定义**

通俗理解：主进程像“管家”，渲染进程像“一个个住户”，住户之间不能直接串门，有事要经过管家中转——这句话自然引出后面的 IPC 通信话题。

> - **主进程**：一个 Electron 应用**有且只有一个**主进程，它是应用的入口。职责包括：创建和管理窗口（`BrowserWindow`）、管理应用生命周期（`app` 模块）、访问所有 Node.js API 和操作系统原生 API（托盘、菜单、对话框）。
> - **渲染进程**：每个 `BrowserWindow` 对应一个独立的渲染进程。职责就是渲染页面、跑前端逻辑。它默认运行在沙箱中，**出于安全考虑不开放 Node.js 能力**（`nodeIntegration: false`）。

## 应用的入口文件

**一、定义**

> 入口在 `package.json` 的 `main` 字段指定，比如 `"main": "dist/main/index.js"`。Electron 启动时先加载这个文件，进入主进程；主进程在 `app.on('ready')` 之后才能创建窗口。

工程化实践：一般项目会把主进程代码和渲染进程代码分开打包（主进程用 rollup/esbuild，渲染进程用 webpack/vite），`main` 指向的是构建产物而不是源码。

## 应用生命周期事件

**一、定义**

> - `ready`：初始化完成，**只有在这个事件之后才能创建窗口**；
> - `window-all-closed`：所有窗口关闭后触发。注意平台差异——macOS 上应用通常保持运行（点 dock 图标可重新激活），Windows/Linux 上一般直接 `app.quit()`；
> - `activate`：macOS 特有，点击 Dock 图标且无窗口时触发，通常在这里重建窗口；
> - `before-quit` → `will-quit` → `quit`：退出流程的三个阶段，`before-quit` 适合做保存数据的兜底逻辑，`quit` 之后进程就结束了。

**加分点**：主动提到 `window-all-closed` 的跨平台分支处理，这是真实项目中一定会写的代码：

```js
app.on('window-all-closed', () => {
  if (process.platform !== 'darwin') app.quit()
})
```

## 创建基础窗口

**一、最常用的配置项**

> - `width` / `height`：尺寸；
> - `show: false`：**先创建不显示**，配合 `ready-to-show` 事件再 `show()`，避免白屏——这是高频考点，一定要提；
> - `frame: false` / `titleBarStyle`：自定义标题栏；
> - `webPreferences`：安全相关配置，`preload` 脚本路径、`nodeIntegration`、`contextIsolation` 都在这里设置。

**二、代码**

```js
const win = new BrowserWindow({
  width: 1200,
  height: 800,
  show: false,
  webPreferences: {
    preload: path.join(__dirname, 'preload.js'),
    contextIsolation: true,
    nodeIntegration: false,
  },
})

win.once('ready-to-show', () => win.show())
win.loadFile('index.html')
```

## `preload.js` 是什么

**一、定义**

> preload 是一个在**渲染进程中、但在页面内容加载之前**运行的脚本。它的定位是“桥梁”：渲染进程本身没有 Node 能力，preload 有**部分**受控的 Node 能力，它可以把需要的功能通过 `contextBridge` 暴露给页面使用。

**二、解决的三个问题**

> 1. 安全问题——页面代码拿不到完整的 Node API，只能用 preload 明确暴露的白名单 API；
> 2. 能力问题——渲染进程需要读文件、调系统接口时有了合法通道；
> 3. 解耦问题——前端代码不直接依赖 Electron 特有 API，方便同一套代码复用到 Web 端。

## 实现文件选择框和消息弹窗

**一、定义**

`dialog` 是主进程模块，常用方法：

> - `dialog.showOpenDialog()`：文件/目录选择，返回选中的路径数组；
> - `dialog.showSaveDialog()`：另存为；
> - `dialog.showMessageBox()`：原生消息框，支持按钮、图标、勾选项；
> - `dialog.showMessageBoxSync()`：同步版本，会阻塞，慎用。

**二、实践**

举一个典型场景：前端点“导出”→ IPC 到主进程 → `showSaveDialog` 拿路径 → 写文件 → 返回结果。

> - 一是这些方法都是**主进程**的，渲染进程要用必须走 IPC；
> - 二是现代 API 都返回 Promise（旧版 callback 风格已废弃）。

## 渲染进程无法直接访问 Node.js API

**一、定义**

> 渲染进程本质上就是跑着一个 Chromium 页面，页面上加载的任何 JS（包括第三方脚本、被 XSS 注入的脚本）都有执行权。如果开放 `nodeIntegration`，恶意脚本就能直接：

```js
require('child_process').exec('rm -rf /')  // 远程代码执行 RCE
require('fs').unlinkSync(...)              // 删文件
```

所以 Electron 从 v5 开始把 `nodeIntegration` 默认改为 `false`，渲染进程运行在沙箱里。需要系统能力就走 preload + `contextBridge` 的白名单通道。答题时主动说出 "RCE（远程代码执行）”这个术语，表明你理解的是风险本质而不只是配置项。

## Electron 和 NW.js 

**一、定义**

两者都是“Chromium + Node"的混合框架，核心差异有三点：

> 1. **进程模型不同**：NW.js 里每个页面可以直接获得 Node 上下文，没有明确的主进程概念；Electron 有严格的 主/渲染 进程分离和 IPC 机制，安全边界更清晰；
> 2. **安全默认值不同**：Electron 默认关闭 Node 集成，NW.js 历史上默认开放；
> 3. **生态和维护**：Electron 由 GitHub/Microsoft 维护，VS Code、Slack、Figma、飞书、钉钉都在用，社区和工具链（builder、updater、Sentry 集成）远比 NW.js 成熟。

###  Electron 支持的URL协议

**一、定义**

> - 加载本地文件：`win.loadFile('index.html')`，底层走 `file://` 协议，注意打包后路径要基于 `__dirname` 或 `app.getAppPath()` 拼接；
> - 加载远程地址：`win.loadURL('https://xxx.com')`，适合“套壳”型应用 ；
> - **自定义协议**：用 `protocol.registerFileProtocol`（新版是 `protocol.handle`）注册如 `app://`，配合 SPA 的 history 路由可以避免 `file://` 下相对路径和路由问题，**生产环境打包（尤其是 asar + hash 路由）的最佳实践**。

加分点：提一句自定义协议还能配合 `standard: true` 让其支持 fetch、Service Worker 等 Web 特性。

# 中级

## `ipcRenderer.send`、`ipcRenderer.invoke`、`ipcMain.handle`

**一、定义**

> IPC 三种通信模式的辨析

**二、具体解析**

**1.单向发送：`ipcRenderer.send` + `ipcMain.on`**

> 渲染进程发消息给主进程，不关心返回值。适合“通知型”场景，比如上报埋点、打开开发者工具。返回值需要主进程再 `webContents.send` 回来，流程绕。

**2.双向异步：`ipcRenderer.invoke` + `ipcMain.handle`（推荐）**

> invoke 返回 Promise，直接拿到主进程的处理结果，是现代 Electron 的标准写法：

```js
// preload
contextBridge.exposeInMainWorld('api', {
  readFile: (p) => ipcRenderer.invoke('read-file', p),
})

// main
ipcMain.handle('read-file', async (e, p) => {
  return await fs.promises.readFile(p, 'utf-8')
})
```

**3.主进程主动推送：`webContents.send` + `ipcRenderer.on`**

> 主进程 → 渲染进程的推送，适合事件订阅型场景：下载进度、系统通知、后端长连接消息转发到窗口。

**加分点**：总结一句话——“请求-响应用 invoke，事件通知用 send/on，主进程推送用 webContents.send"

## `contextBridge`是什么

**一、定义**

> 旧时代很多应用直接在渲染进程开 `nodeIntegration`，页面里就能 `require('fs')`。一旦页面加载了远程内容或被 XSS，恶意脚本就拥有了系统级权限（RCE）。

**二、具体解析**

> **`contextIsolation: true`（默认开启）**：把 preload 脚本和页面 JS 隔离在**两个独立的 JS 上下文**里。页面代码改写原型链、篡改全局对象都影响不到 preload，反之亦然。
>
> **`contextBridge.exposeInMainWorld`**：在隔离的前提下，由 preload 显式地向页面暴露一个受控的 API 对象：

```js
// preload.js
contextBridge.exposeInMainWorld('desktop', {
  saveFile: (content) => ipcRenderer.invoke('save-file', content),
})
// 页面里只能用 window.desktop.saveFile()，拿不到 ipcRenderer 本身
```

**关键原则**：暴露的是“能力”而不是“原语”——比如暴露 `saveFile(content)` 这个具体方法，而不是把 `ipcRenderer` 整个对象交给页面。否则页面就能用你的通道发任意 IPC 消息，隔离形同虚设。

## 渲染进程通信

**一、定义**

> 渲染进程是相互隔离的，没有直接的通信 API。

**二、三种方式**

**1.主进程中转（最常用）**

> 窗口 A 发消息到主进程，主进程拿到目标窗口的 `webContents` 再转发给窗口 B。实现简单、便于在主进程做权限控制和消息审计。

**2.`MessagePort`（`MessageChannelMain`）**

> 主进程创建一对 port，分别分发给两个窗口，之后两个窗口**直连通信**，不再经过主进程。适合高频、大数据量传输（port 走结构化克隆但不经过主进程中转，性能更好）。

**3.`localStorage` / `BroadcastChannel`**

> 仅同源窗口可用，简单但能力弱，只适合状态同步类的小数据。

**加分点**：说清楚为什么不建议“能直连就直连”——主进程中转虽然多一跳，但它是天然的消息总线，便于统一做路由、日志、权限管理，架构上更可维护。

## 主进程通信渲染进程

**一、定义**

> 核心 API 是 `webContents.send(channel, ...args)`

**二、代码**

典型场景：下载进度、自动更新状态、系统主题变化（`nativeTheme`）、托盘点击事件转发。

```
// main
mainWindow.webContents.send('download-progress', { id, percent })

// preload
contextBridge.exposeInMainWorld('desktop', {
  onDownloadProgress: (cb) => {
    ipcRenderer.on('download-progress', (_e, data) => cb(data))
  },
})
```

**三、进阶**

> 1. 窗口可能已被销毁，send 前要判断 `win.isDestroyed()`；
> 2. 建议在 preload 里封装成订阅函数（如上），并返回一个取消订阅函数，避免页面组件卸载后监听器泄漏。

## 实现单实例锁

**一、定义**

> 用 `app.requestSingleInstanceLock()`

**二、代码**

```js
const gotTheLock = app.requestSingleInstanceLock()
if (!gotTheLock) {
  app.quit()  // 拿不到锁说明已有实例在运行，直接退出
} else {
  app.on('second-instance', () => {
    // 用户再次启动时，把已有窗口拉到前台
    if (mainWindow) {
      if (mainWindow.isMinimized()) mainWindow.restore()
      mainWindow.focus()
    }
  })
}
```

**三、原理**

> 操作系统层面创建全局锁（Windows 上是命名互斥量），第一个实例拿到锁，后续实例拿锁失败。`second-instance` 事件还会带上启动参数，可以做“点击协议链接唤起已有实例”的功能（配合 `setAsDefaultProtocolClient` 注册自定义协议）。

## `electron-builder` 和 `electron-forge` 

**一、定义**

**electron-forge**

> - Electron 官方出品，与 Electron 版本同步维护；
> - 配置基于 webpack/vite 模板，开发体验好（`forge start`）；
> - 打包能力相对基础，适合中小型项目。

**electron-builder**

> - 社区最流行，功能更全：内置自动更新（配合 electron-updater）、多平台目标（nsis / dmg / AppImage / snap）、代码签名、差量更新；
> - 配置集中在 `package.json` 或 `electron-builder.yml`，声明式；
> - 对原生模块（`asarUnpack`、按平台重建）的处理更成熟。

**二、技术选型**

> 需要成熟的多平台分发 + 自动更新，选 electron-builder（目前工业界主流）；新项目想要官方长期支持和更现代的开发体验，可以评估 forge。

## Electron自动更新

**一、定义**

> **基本流程**（以 electron-updater 为例）
>
> 1. 应用启动后（或定时）调用 `autoUpdater.checkForUpdates()`，请求更新服务器上的 `latest.yml`（记录最新版本号和文件哈希）；
> 2. 与本地版本比对，有新版则下载安装包；
> 3. 下载完成发出 `update-downloaded` 事件，UI 提示用户重启；
> 4. 调用 `autoUpdater.quitAndInstall()`，退出并安装新版本。

**二、代码**

```js
autoUpdater.checkForUpdates()
autoUpdater.on('update-downloaded', () => {
  dialog.showMessageBox({ message: '新版本已就绪，是否重启安装？' })
    .then(() => autoUpdater.quitAndInstall())
})
```

**三、进阶**

> - 差量更新：electron-updater 在 Windows 的 nsis 目标下支持 blockmap 差量下载，只下载变更块，大幅节省流量；
> - 平台差异：macOS 必须代码签名才能更新，否则签名校验失败；Linux 上 AppImage 支持替换更新；
> - 服务端方案：可以自建静态文件服务（最简），也可以用 GitHub Releases、Hazel、或商用方案如 Electron Auto Update 服务。

## 实现系统托盘、全局快捷键和无边框窗口

**一、托盘**

注意：Tray 实例要挂到全局变量，否则会被 GC 回收导致托盘消失——这是个经典坑。

```js
const tray = new Tray(icon)
tray.setToolTip('我的应用')
tray.setContextMenu(Menu.buildFromTemplate([
  { label: '显示主窗口', click: () => win.show() },
  { label: '退出', click: () => app.quit() },
]))
tray.on('click', () => win.isVisible() ? win.hide() : win.show())
```

**二、全局快捷键**

> `globalShortcut.register('CommandOrControl+Shift+X', callback)`，是**系统级**的，应用失焦也生效，注册失败要处理返回值；退出时 `globalShortcut.unregisterAll()`。

**三、无边框窗口**

`frame: false` 去掉系统标题栏，然后：

> - 拖拽区域：CSS 里加 `-webkit-app-region: drag`，按钮加 `no-drag`；
> - 最小化/最大化/关闭：用 `win.minimize()` 等 API 自己实现一套窗口控制按钮；
> - macOS 可用 `titleBarStyle: 'hiddenInset'` 保留交通灯按钮，体验更好。

## 常见安全风险

 Electron 官方安全清单：

> 1. **关闭 `nodeIntegration`**：防止页面直接获得 Node 能力（RCE 风险）；
> 2. **开启 `contextIsolation`**：隔离 preload 和页面上下文；
> 3. **开启 `sandbox: true`**：渲染进程沙箱化，即使被攻破也拿不到系统能力；
> 4. **禁用 `webSecurity: false`**：这个开关绝不能为了绕跨域而打开，等于裸奔；
> 5. **不加载远程内容**：如果必须加载（如内嵌网页），用 `<webview>` 隔离或单独的无 Node 沙箱窗口，并配置 CSP（Content-Security-Policy）；
> 6. **校验窗口导航**：监听 `webContents.on('will-navigate')` 和 `setWindowOpenHandler`，禁止页面任意跳转到未知 URL（防止点击劫持把窗口导航到钓鱼页）；
> 7. **IPC 输入校验**：`ipcMain.handle` 收到的参数来自渲染进程，**不可信**，路径、命令类参数必须校验（比如防止传 `../../etc/passwd` 做路径穿越）；
> 8. **限制 `ipcRenderer` 暴露面**：contextBridge 只暴露具名方法，不暴露原语对象。

# 高级

## 内存过高

一、定义

> 先说内存高的**结构性原因**：每个 Electron 应用都内嵌一个完整 Chromium，主进程 + 每个渲染进程 + GPU 进程 + Utility 进程，一启动就是几百 MB 的基础盘，这不是“泄漏”而是架构成本。

**二、优化手段**

比如“我们把多窗口架构改成 BrowserView 单窗口后，内存从 600MB 降到 250MB"，体现实战经验。

**1.进程层**

> - 能单窗口就不要多窗口；需要多视图时用 `BrowserView` / `WebContentsView` 复用一个窗口的容器，而不是开多个 `BrowserWindow`；
> - 隐藏窗口不等于释放内存，长时间不用的视图可以 `webContents.setBackgroundThrottling` 降频，或干脆销毁重建；
> - v28+ 可以用 `webContents.forcefullyCrashRenderer()` / 挂起策略回收僵尸渲染进程。

**2.渲染层**

> - 长列表用虚拟滚动，DOM 节点控制在几千以内；
> - 及时解绑事件监听器、清理定时器，尤其 IPC 监听器（`ipcRenderer.removeAllListeners`）；
> - 图片资源按需加载、及时 `src` 置空释放解码后的位图内存。

**3.排查工具**

> - 主进程：`process.memoryUsage()` 定时采样上报；
> - 渲染进程：Chrome DevTools 的 Memory 面板做堆快照对比（三次快照法定位增长对象）；
> - Electron 自带的 `process.getProcessMemoryInfo()` 可以看各子进程分别占多少。

## 白屏问题

**一、定义**

> 白屏的根因：窗口 `show()` 之后渲染进程还要加载 HTML → 执行 JS → 发请求 → 渲染完成，这段时间用户看到的就是白屏。

**二、优化手段**

**衡量指标**：用 `app.on('ready')` 和 `did-finish-load` 的时间差、以及 `webContents.on('did-finish-load')` 时间戳上报，建立启动耗时的监控基线。

**1.窗口层优化（最立竿见影）**

> - `show: false` + 监听 `ready-to-show` 再显示——窗口首次绘制完成才出现，用户感知不到白屏；
> - 白屏兜底：给 `BrowserWindow` 设置 `backgroundColor`（用品牌底色代替纯白），即使慢也不刺眼。

**2.加载层优化**

> - 渲染资源走本地而不是远程 URL，远程 HTML 首屏完全取决于网络；
> - 渲染层代码做路由懒加载 + 代码分割，首屏只加载必要 chunk；
> - 主进程避免在启动阶段做同步 IO（同步读配置、同步校验都推迟到 `did-finish-load` 之后）；
> - V8 快照 / 字节码预编译可以减少 JS 解析时间（引出下一题）。

**3.时序优化**

> - 非核心能力（自动更新检查、崩溃上报初始化、数据同步）全部延后到首帧之后异步执行；
> - 主进程窗口创建和渲染进程资源加载是并行的，尽量让 `app.ready` 到窗口显示的关键路径上只做必要的事。

## V8 snapshots(快照)机制

**一、原理**

> V8 执行 JS 分几步——解析源码生成 AST → 编译为字节码 → 解释执行/优化。对于一大段“启动时就要初始化”的代码，每次冷启动都重复解析编译，很浪费时间。

**二、V8 snapshot 的思路**

> **把某个时刻堆内存的完整状态（对象、上下文、编译结果）序列化到文件，下次启动直接反序列化恢复堆**，跳过解析和编译阶段。

**三、在 Electron 中的应用**

> 1. **Electron 自身已经内置**：Electron 的启动快照让它内部初始化更快，这部分不用你做；
> 2. **业务代码可用 `node --snapshot-blob` / `v8.startupSnapshot` API**：把主进程的模块初始化代码做成快照，在 `buildSnapshot` 阶段执行一次初始化，运行时直接恢复；
> 3. **字节码预编译**（相关方案）：用 `bytenode` 把 JS 编译成 V8 字节码（`.jsc`），启动时省去源码解析，同时兼做源码保护。

**四、局限**

> 快照不适合包含 I/O 副作用或依赖运行时环境的代码；快照文件会增大包体积；跨 V8 版本不兼容，升级 Electron 需要重新生成。能主动讲清“快照 ≠ 加密”这一点很加分。

## ASAR 归档文件

**一、定义**

> ASAR 是 Electron 自定义的归档格式（类似 tar），把整个应用源码打成一个 `.asar` 文件，随应用分发。

**二、原理**

> 它不是压缩格式，本质是一个**带索引的拼接文件**——文件头部是 JSON 格式的目录索引（记录每个文件的偏移量和大小），后面依次拼接所有文件内容。运行时 Electron 给 Node 的 `fs` 模块打了补丁：当路径指向 `.asar` 内部时，拦截 `readFile`/`exists` 等调用，按索引从大文件中切片读取，让代码“感觉”自己在一个正常目录里。

**三、安全局限（关键点）**

> 1. **ASAR 是明文的，不是加密**：`npx asar extract app.asar ./src` 一行命令就能完整解出全部源码——所以它解决的是“打包分发”问题，不解决“代码保护”问题；
> 2. **可被篡改**：攻击者解包、修改、重新打包后，应用照样运行；
> 3. 缓解手段：
>    - `EnableEmbeddedAsarIntegrityValidation`（macOS/Windows 支持）：启动时校验 ASAR 的哈希，被篡改则拒绝运行；
>    - 配合代码签名，让篡改后的包无法通过系统签名验证；
>    - 真正的源码保护要用 V8 字节码（引出第 8 题）。

## 大文件传输

**一、定义**

> IPC 跨进程传数据走 Chromium 的 Mojo 机制，JS 对象需要经过**结构化克隆序列化 → 跨进程传输 → 反序列化**。

**二、问题**

对于大对象，这条链路的代价是三重的：

> 1. 序列化和反序列化各产生一份临时大对象，堆内存瞬间翻倍；
> 2. 主进程是单线程的，大序列化会阻塞主进程事件循环，**拖慢所有窗口**；
> 3. GC 压力陡增，频繁 Full GC 导致全局卡顿。多个窗口高频传大数据时，就是所谓的“IPC 风暴"，最终可能 OOM。

**三、优化方案**

> 1. **不传内容，传引用**：文件类数据只通过 IPC 传**路径**，主进程直接用 Node fs 读写，这是最重要的一条；
> 2. **传 Buffer/TypedArray 而不是 JSON**：二进制数据序列化开销远小于 JSON 字符串；
> 3. **高频小数据合并**：进度条类消息不要每次 tick 都发，做节流合并（比如 100ms 聚合一次）；
> 4. 大数据绕过 IPC：
>    - 共享内存：`SharedArrayBuffer` 配合 `MessagePort` 可实现近零拷贝传输；
>    - 本地中转：主进程把大数据写到临时文件 / 本地 HTTP 服务，渲染进程自己去读；
> 5. **Web Worker 处理**：渲染进程收到数据后的解析工作放到 Worker，不阻塞 UI 线程。

## 集成原生模块

**一、定义**

原生模块（如 better-sqlite3）

> Electron 内置的 Node 版本和你系统装的 Node **版本不一致，ABI（二进制接口）不同**。用 npm 直接装的原生模块（C++ 编译的 `.node` 文件）是按系统 Node 的 ABI 编译的，放进 Electron 里直接 require 会报 “NODE_MODULE_VERSION mismatch”。

**标准解决流程**

> 1. 安装 `@electron/rebuild`；
> 2. 执行 `electron-rebuild -f -w better-sqlite3`，针对 Electron 的 ABI 重新编译该模块；
> 3. 打包时注意：`.node` 二进制文件**不能进 asar**（asar 里无法被 dlopen 加载），要用 `asarUnpack` 配置解压到 `app.asar.unpacked`；
> 4. CI 多平台构建时，需要在对应平台的机器/容器上编译（mac 需要 Xcode、win 需要 VS Build Tools、linux 需要 gcc），或使用 `prebuild` 预编译产物。

**二、N-API 的优势（核心加分点）**

> - 旧方案（NAN）直接绑定 V8 内部 API，V8 一升级就崩，所以必须针对每个 Electron 版本重编；
> - **N-API 是 Node 官方提供的稳定 ABI 层**，原生模块面向 N-API 编译后，**与具体的 V8/Node 版本解耦**——只要 Node 大版本兼容，无需重编，Electron 升级成本低得多；
> - 选择原生库时优先选基于 N-API / node-addon-api 的实现，这是工程选型的关键判断。

## 渲染进程崩溃排查

**一、定义**

> - **JS 层异常**：渲染进程未捕获的 Promise rejection / 抛错，页面白屏但进程还在；
> - **进程级崩溃**：渲染进程真挂了（原生模块崩溃、OOM、GPU 问题），窗口完全失去响应。

**二、监控与兜底方案**

**1.渲染进程异常捕获**

```js
window.addEventListener('error', handler)
window.addEventListener('unhandledrejection', handler)
```

**2.主进程感知渲染进程崩溃**

```js
win.webContents.on('render-process-gone', (e, details) => {
  // details.reason: crashed / oom / killed...
  report(details)
  // 兜底：提示用户并 reload，或重建窗口
})
win.webContents.on('unresponsive', () => { /* 卡死上报 */ })
```

**3.系统级崩溃上报**

> `crashReporter.start({ submitURL })`，它基于 Chromium 的 Crashpad/Breakpad，能捕获 Native 层崩溃并生成 minidump 上传。

**4.接入 Sentry**

> Electron 有官方 SDK（`@sentry/electron`），同时覆盖主进程、渲染进程和 native crash 三层，能拿到崩溃时的 breadcrumbs 和堆栈。

**5.自愈策略**

> `render-process-gone` 后按 `reason` 分级处理——普通 crashed 直接 `reload()`；连续崩溃（如 3 次）则清缓存或降级到安全模式。能说出“自愈 + 崩溃率看板”这套完整思路，就是生产级答案。

## 应用源码保护

**一、定义**

> Electron 应用是“源码分发”模式，即使打包了 asar，用户机器上就躺着全部代码，需要防两类人——普通用户解包看代码、攻击者篡改重打包（破解 license）。

**二、保护手段**

没有银弹，实战是“字节码 + 混淆 + 原生模块关键逻辑 + fuses”的组合拳，安全级别按商业价值定投入。

**1.ASAR + 完整性校验**：只防篡改不防阅读

**2.V8 字节码**

> - **原理**：用 `bytenode` 等工具把 JS 源码预编译成 V8 字节码（`.jsc`），分发字节码而删除源码。字节码是 V8 的中间表示，逆向难度远高于明文 JS，且运行时跳过解析、加载更快；
> - **局限**（要主动说）：字节码**不是加密**，逆向工具可以还原出可读性较差的等效代码；**与 V8 版本强绑定**，Electron 每次升级 V8 都要重新编译；不支持 eval/new Function 类动态执行。

**3.其他加固手段**

> - 代码混淆（javascript-obfuscator）对关键业务逻辑增加逆向成本；
> - 主进程侧做 license 校验的核心逻辑（密钥永远不下发到渲染层）；
> - 敏感计算放原生模块（C++ 编译成 `.node`，逆向成本最高）；
> - 开启 Electron fuses（如 `RunAsNode` 关闭）防止攻击者用自定义 Node 入口绕过你的逻辑。

## 打包体积优化

**一、定义**

> Electron 应用 = 你的业务代码 + **一整个 Chromium + Node.js 运行时**。光运行时解压后就 200MB 左右（每个平台一份），这是架构性成本，任何“轻量 Electron”说法都改变不了这个下限。

**二、优化手段**

> 1. **用 electron-builder 的默认行为**：它只打包 `dependencies`，devDependencies 自动排除——所以构建工具、类型库必须放 devDependencies，这是最常见的“胖包”原因；
> 2. **文件粒度裁剪**：`files` 配置只打包必要的构建产物，排除 sourcemap、测试文件、文档；
> 3. **按平台裁剪原生模块**：`npm rebuild` + 平台过滤，别把三平台的 `.node` 都打进去；
> 4. **排除不必要的二进制**：如 `electron-builder` 的 `asarUnpack` 滥用、重复的 icon 资源；
> 5. **压缩选项**：`compression: maximum`（牺牲打包时间换体积）、nsis 用 LZMA 压缩，安装包可小 30%+；
> 6. **渲染层做包体分析**：`webpack-bundle-analyzer` 找出大依赖，做按需引入和代码分割；
> 7. **激进方案**：裁剪 Chromium 本身（Electron 源码级定制，去掉不需要的特性和多语言资源），收益大但维护成本极高，只有大团队做得起——能说出这条及其代价，说明你对方案边界有清醒认识。

## 设计支持多窗口、多主题、可离线的桌面端架构

**一、可复用的框架**

决策的原则——“主进程管状态、渲染进程管视图、IPC 协议类型化、数据单点写”

**1.进程职责分层**

> - **主进程 = 状态与系统的唯一可信源**：窗口管理、生命周期、系统能力（托盘/通知/文件）、数据持久化的统一入口；
> - **渲染进程 = 纯 UI**：每个窗口是一个独立 SPA，不直接接触系统资源，一切能力通过 preload 暴露的白名单 API；
> - **公共逻辑层**：业务核心逻辑抽成与平台无关的包（不依赖 electron），主进程和渲染进程都能引用，同时保证这套逻辑可以复用到 Web 版。

 **2.IPC 架构**

> 设计一个统一的 **IPC 路由层**——主进程注册带命名空间的 handler（如 `db:query`、`file:save`），统一做参数校验、日志、错误码规范；preload 按模块封装 `exposeInMainWorld`，渲染层看到的是一组类型安全的 API（用 TypeScript 定义共享的 IPC 协议类型，主/渲染两端共用一份类型文件）。

**3.多窗口策略**

> 主窗口承载主要业务，弹窗类场景评估用 `BrowserWindow` 还是 `BrowserView`/同窗口内路由（省内存）；窗口间通信统一走主进程消息总线，主进程做路由和权限控制；窗口关闭时走统一的清理协议（注销 IPC 监听、上报状态）。

**4.数据与离线**

> - 结构化数据用 SQLite（better-sqlite3，主进程独占读写，渲染进程只能通过 IPC 查询——避免多进程并发写库的锁问题）；
> - 离线优先：渲染层用本地缓存 + 队列化写操作，网络恢复后同步；Service Worker 缓存静态资源；
> - 数据同步冲突用时间戳/版本号做 last-write-wins 或 CRDT，按业务定。

**5.主题与配置**

> 跟随系统主题监听主进程 `nativeTheme` 事件广播到所有窗口；用户主题存 SQLite/本地配置文件，主进程启动时下发，保证多窗口主题一致。
