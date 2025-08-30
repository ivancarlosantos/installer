#!/bin/bash

# Função para desenhar a barra de progresso
progress_bar() {
    local current=$1
    local total=$2
    local width=${3:-50}  # Largura da barra (padrão: 50 caracteres)
    
    # Calcula a porcentagem
    local percent=$((current * 100 / total))
    
    # Calcula quantos caracteres preencher
    local filled=$((width * current / total))
    
    # Cria a barra
    local bar=""
    for ((i=0; i<width; i++)); do
        if [ $i -lt $filled ]; then
            bar="${bar}█"
        else
            bar="${bar}░"
        fi
    done
    
    # Imprime a barra com porcentagem
    printf "\r[%s] %3d%%" "$bar" "$percent"
    
    # Se chegou a 100%, adiciona nova linha
    if [ $current -eq $total ]; then
        echo
    fi
}

echo "=== Exemplo 1: Barra de Progresso Simples ==="
for i in {1..100}; do
    progress_bar $i 100
    sleep 0.02
done