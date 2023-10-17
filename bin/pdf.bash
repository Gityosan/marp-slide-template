#!/usr/bash

# 引数の数をチェックし、引数が1つでない場合はエラーメッセージを出力して終了
if [ "$#" -ne 1 ]; then
  echo "Usage: $0 <file>"
  echo "argument count is not correct"
  exit 1
fi

while IFS= read -r line; do
  if [[ $line =~ title:[[:space:]]*[\'\"]([^\'\"]+)[\'\"] ]]; then
    title="${BASH_REMATCH[1]}"
    echo "Extracted Title: $title"
    break
  fi
done < "$1"

if [ -n "$title" ]; then
  npx marp "$1" -o "pdf/$title.pdf"
else
  # パスからファイル名を取得
  file_name="${1##*/}"
  title="${file_name%.*}"
  npx marp "$1" -o "pdf/$title.pdf"
fi