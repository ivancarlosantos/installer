#!/usr/bin/env bash

# Desenha uma barra de progresso de 0..100
# Uso: progress <porcentagem> [largura]
progress() {
  local pct=$1
  local width=${2:-50}

  (( pct < 0 ))  && pct=0
  (( pct > 100 )) && pct=100

  local fill=$(( pct * width / 100 ))
  local rest=$(( width - fill ))

  # monta as partes
  local bar_filled
  local bar_empty
  printf -v bar_filled "%*s" "$fill" ""
  printf -v bar_empty  "%*s" "$rest" ""

  bar_filled=${bar_filled// /#}   # substitui espaços por #
  bar_empty=${bar_empty// /-}     # substitui espaços por -

  printf "\r[%s%s] %3d%%" "$bar_filled" "$bar_empty" "$pct"
}

# Exemplo: simula um trabalho de 0 a 100%
for i in {0..100}; do
  progress "$i" 40
  sleep 0.03
done
printf "\n"
