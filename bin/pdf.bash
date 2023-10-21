#!/usr/bin/bash

# 引数の数をチェックし、引数が3つ以上場合はエラーメッセージを出力して終了
if [ "$#" -ge 3 ]; then
  echo "Usage: $0 <file_path> [-d]"
  echo "Argument count is not correct."
  exit 1
fi

# -d(deepL)オプションが指定されているかチェック
d_option_set=false
while getopts ":d" opt; do
  case $opt in
    d)
      d_option_set=true
      ;;
    \?)
      echo "Invalid option: -$OPTARG" >&2
      exit 1
      ;;
  esac
done

# titleを抽出
while IFS= read -r line; do
  if [[ $line =~ title:[[:space:]]*[\'\"]([^\'\"]+)[\'\"] ]]; then
    title="${BASH_REMATCH[1]}"
    echo "✨  Extracted Title: $title"
    break
  fi
done < "$1"

# titleが空ならパスからファイル名を取得
if [ -z "$title" ]; then
  file_name="${1##*/}"
  title="${file_name%.*}"
fi

# titleに全角文字が含まれているかチェック
if echo "$title" | perl -C -ne 'exit(1) unless /[^\x00-\x7F｡-ﾟ]/'; then
  blue=$(tput setaf 4)
  reset=$(tput sgr0)
  echo "${blue}info${reset} Full-width characters are included in the title."
  echo "${blue}info${reset} If you want to upload this file to SlideShare, please change the title to half-width characters."
  echo "${blue}info${reset} To assist with this, we recommend using the -d option."
fi

# deepL apiを叩いてタイトルを翻訳
if [ "$d_option_set" = true ]; then
  source import-env.bash .env
  if [ -n "$DEEPL_API_KEY" ] && [ -n "$DEEPL_API_URL" ]; then
    response=$(curl -X POST "${DEEPL_API_URL}" \
    --header "Authorization: DeepL-Auth-Key ${DEEPL_API_KEY}" \
    --data-urlencode "text=${title}" \
    --data-urlencode 'target_lang=EN')
    title=$(echo $response | awk -F'"text":"' '{print $2}' | awk -F'"' '{print $1}' | sed 's/\.$//')
  else
    red=$(tput setaf 1)
    reset=$(tput sgr0)
    echo "${red}error${reset} -d option is set, but DeepL API Key or URL is not set."
    exit 1
  fi
fi

npx marp "$1" -o "pdf/$title.pdf" --allow-local-files