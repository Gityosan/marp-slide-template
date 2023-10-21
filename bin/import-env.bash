#!/usr/bin/bash

env_file=${1:-".env"}

for kv in $(< $env_file)
do
  if [[ "$kv" = ^\s*$ ]] || [[ "$kv" =~ ^# ]]; then
    continue
  fi
  export $kv
done