#!/bin/bash

# 交互式获取用户输入
read -p "请输入开始时间（格式：YYYY-MM-DD HH:mm:ss）: " start_time
read -p "请输入结束时间（格式：YYYY-MM-DD HH:mm:ss）: " end_time
read -p "请输入要保存的文件名（不包含路径和扩展名）: " output_filename

# 验证日期格式
date_pattern="^[0-9]{4}-[0-9]{2}-[0-9]{2} [0-9]{2}:[0-9]{2}:[0-9]{2}$"

if ! [[ $start_time =~ $date_pattern ]] || ! [[ $end_time =~ $date_pattern ]]; then
    echo "错误：日期格式无效，请使用正确的格式（例如：2024-03-06 08:25:00）。"
    exit 1
fi

# 输出文件名
output_file="${output_filename}_${start_time}_${end_time}.log"

# 提取日志并保存到新文件
awk -v start="$start_time" -v end="$end_time" '$1" "$2 >= start && $1" "$2 <= end' sys-all1.log > "$output_file"

echo "已提取指定时间段的日志，并保存到文件：$output_file"
