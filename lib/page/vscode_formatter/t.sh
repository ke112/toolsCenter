#!/bin/bash
CURRENT_DIR=$(
    cd $(dirname $0)
    pwd
)
cd $CURRENT_DIR
IFS=$'\n'   #IFS=$'\n' 的作用就是临时修改 IFS,使其只包含换行符,这样可以遍历字符串变量的每一行,而不是每个单词。
leftSpace=0 #统一的左缩进的空格数
t2='转换后.txt'
rm -rf $t2
touch $t2

function mulHandler() {
    newline=$(echo ${newline//\"/\\\"}) #把字符串里边所有的"前都加上反斜线\"
    if [[ $j == 1 ]]; then
        echo "\"描述\": {" >>$t2
        echo "  \"prefix\": \"快捷键\"," >>$t2
        echo "  \"body\": [" >>$t2
        echo "    \"$newline"\"\, >>$t2
    else
        echo "    \"$newline"\"\, >>$t2
    fi
}
function simpleHandler() {
    echo "$newline" >>$t2
}
for line in $1; do
    let j=++i
    # echo $j #从1开始打印
    if [[ "$line" != "" ]]; then
        #每行的空格数
        current=$(echo "$line" | awk '{str=length($0); sub(/^[ ]*/,"",$0); print str-length($0);}')
        cha=$(($current - $leftSpace))
        # echo $j '当前 '$current '左边统一空格 '$leftSpace '差值 '$cha
        if [[ $j == 1 ]]; then
            newline=${line:$current} #第一行缩进到最左侧即可
        elif [[ $j == 2 ]]; then
            leftSpace=$(($current - 2)) #第二行缩进到最左侧2个空格
            newline=${line:$leftSpace}  #拿到公共的缩进空格数
        else
            if [[ $current < $leftSpace ]]; then #仅防下边会比公共的缩进还小的行
                leftSpace=$current               #这种情况缩进到最左侧即可
            fi
            newline=${line:$leftSpace}
        fi

        if [[ $2 == 2 ]]; then
            simpleHandler #简单的代码缩进格式化
        else
            mulHandler #处理dart.json代码块配置
        fi
    else
        echo "" >>$t2
    fi
done

if [[ $2 != 2 ]]; then
    echo "  ]," >>$t2
    echo "}," >>$t2
fi

content=$(cat $t2)

function print_content() {
    content=$1
    echo "$content"
}

print_content "$content"
