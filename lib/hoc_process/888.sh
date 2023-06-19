#!/bin/bash
#--------------------------------------------
# 使用介绍 ： 在项目git的目录下,自动提交代码的脚本 2022.4.14
# 使用方式 ： sh 3.sh /user/xxx/shop_app 代码日志
#--------------------------------------------

cd $1
pwd
git stash
git pull
git stash pop
if [ -z "$2" ]; then
    echo '代码拉取完成,没有文字,不提交'
else
    git add --all
    git commit -m $2
    git push
    echo '代码提交完成'
fi
