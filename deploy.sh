# 部署github page脚本
#!/usr/bin/env sh

# 确保脚本抛出遇到的错误
 set -e

# 生成静态文件
# npm run docs:build

# 进入生成的文件夹
cd docs/.vuepress/dist

# 如果是发布到自定义域名
# echo 'www.example.com' > CNAME

git init

 # 如果发布到 https://<USERNAME>.github.io
git remote add origin git@github.com:fuyunjinglong/fuyunjinglong.github.io.git

# 如果发布到 https://<USERNAME>.github.io/<REPO>
# git remote add git@github.com:<USERNAME>/<REPO>.git main

git branch -M vuePressPage
git checkout vuePressPage
git add .
git commit -m '初始阿古博客'
git push -u origin vuePressPage

cd -