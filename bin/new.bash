#!/usr/bin/bash

# 入力ファイルと出力ファイルの指定
input_file="markdown/template.md"

if [ "$1" != "" ]; then
  output_file="markdown/$1.md"
else
  output_file="markdown/$(uuidgen | cut -c1-2,25-36 | tr "[:upper:]" "[:lower:]").md"
fi

# YMLフロントマター内のコメントを削除する処理
in_front_matter=false

while IFS= read -r line; do
  if [[ "$line" =~ ^---$ ]]; then
    if [ "$in_front_matter" = true ]; then
        in_front_matter=false
    else
        in_front_matter=true
    fi
  elif [[ "$in_front_matter" = true ]]; then
    line=$(echo "$line" | sed 's/#[^"]*$//')
    if [[ "$line" =~ title ]]; then
      line=$(echo "$line" | sed -e "s/title: .*/title: '$1'/")
    fi
  fi
  echo "$line" >> "$output_file"
done < "$input_file"

