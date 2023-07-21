#!/bin/bash

# 指定目录
dir=$1
type=$2
remove=$3
output_dir="images"
cd $dir
rm -rf $output_dir

if [ $3 != 1 ]; then
    mkdir -p "$output_dir"
fi

for file in $dir/*{.HEIC,.heic}; do
    filename=$(basename "${file%.*}.$type")
    pathname="$output_dir/$filename"
    if [ $3 == 1 ]; then
        pathname="$filename"
    fi
    if [ $type == 'jpg' ]; then
        sips -s format jpeg $file --out $pathname
    else
        sips -s format $type $file --out $pathname
    fi
    if [ $3 == 1 ]; then
        rm "$file"
    fi
done

echo "转换完成"
