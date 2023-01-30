---
title: ElementUI入门.md
date: 2022-09-12 07:33:16
categories:
- D_框架和类库
toc: true # 是否启用内容索引
---

# 常用问题

**elementui编译打包后图标乱码**

因为 sass-loader 会检查运行环境的模式，给 dart-sass 传入 `{ outputStyle: "compressed" }`。
dart-sass 在这时会使用 BOM 而不是输出 `@charset`。

如果是通过 @vue/cli 搭建的环境，因为有 cssnano 处理压缩，所以可以给 vue.config.js 传入 sassOptions 避免 compressed。

```
//vue.config.js
module.exports = { 
  css: {
    loaderOptions: {
      sass: {
        sassOptions: { outputStyle: "expanded" }
      }
    }
  }
}
```



