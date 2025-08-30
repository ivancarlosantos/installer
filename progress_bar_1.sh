#!/usr/bin/env bash
GREEN="\033[32m"
RESET="\033[0m"

progress_color() {
  local pct=$1 width=${2:-50}
  (( pct<0 )) && pct=0
  (( pct>100 )) && pct=100
  local fill=$(( pct * width / 100 ))
  local rest=$(( width - fill ))
  local filled empty
  printf -v filled "%*s" "$fill" ""; filled=${filled// /#}
  printf -v empty  "%*s" "$rest" ""; empty=${empty// /-}
  printf "\r[${GREEN}%s${RESET}%s] %3d%%" "$filled" "$empty" "$pct"
}

for i in {0..100}; do
  progress_color "$i" 50
  sleep 0.02
done
printf "\n"
