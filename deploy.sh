#!/usr/bin/env sh

# 确保脚本抛出遇到的错误
set -e

git add .
git commit -m "🔥 cs61a hw03 q3"

# * 🚀 完结：整节课做完。
# * 💥 大更新：大更新代表完成某个 lab 或者昨晚一部分作业等。
# * 🔥 小更新：小更新代表添加部分内容，修改某些细节等。


git push -f git@github.com:weijiew/codestep.git master

# 生成静态文件
npm run docs:build

# 进入生成的文件夹
cd docs/.vuepress/dist

git init
git add -A
git commit -m 'deploy'

# 如果发布到 https://<USERNAME>.github.io/<REPO>
git push -f git@github.com:weijiew/codestep.git master:gh-pages

cd -