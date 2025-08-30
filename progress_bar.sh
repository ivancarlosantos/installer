#!/bin/bash

# Define o tamanho da barra de progresso
bar_size=20

# Simula um processo que dura 10 segundos
for ((i = 0; i <= 100; i++)); do
  # Calcula o número de blocos preenchidos na barra
  filled_blocks=$((i * bar_size / 100))
  
  # Calcula o número de blocos vazios na barra
  empty_blocks=$((bar_size - filled_blocks))
  
  # Cria a barra de progresso
  progress_bar=$(echo "%${filled_blocks}s" | tr ' ' '#')
  progress_bar+=$(echo "%${empty_blocks}s" | tr ' ' '-')

  # Exibe a barra de progresso e a porcentagem
  echo "\r[${progress_bar}] ${i}%%"

  # Simula um tempo de carregamento
  sleep 0.1
done

echo "\nCarregamento concluído!\n"
