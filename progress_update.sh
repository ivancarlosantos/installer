#!/usr/bin/env bash

shopt -s nullglob
files=(input/*.txt)
total=${#files[@]}
done_count=0

progress() {
  local pct=$1 width=${2:-40}
  (( pct < 0 ))  && pct=0
  (( pct > 100 )) && pct=100
  local fill=$(( pct * width / 100 ))
  local rest=$(( width - fill ))
  local filled empty
  printf -v filled "%*s" "$fill" ""; filled=${filled// /#}
  printf -v empty  "%*s" "$rest" ""; empty=${empty// /-}
  printf "\r[%s%s] %3d%% (%d/%d)" "$filled" "$empty" "$pct" "$done_count" "$total"
}

for f in "${files[@]}"; do
  # ... faça algo com "$f" ...
  sleep 0.05
  ((done_count++))
  pct=$(( done_count * 100 / total ))
  progress "$pct" 50
done
printf "\nConcluído!\n"