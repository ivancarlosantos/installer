#!/bin/bash

# Barra de progresso simples
for i in {0..100..5}; do
    # Calcula a barra (20 caracteres de largura)
    filled=$((i / 5))
    empty=$((20 - filled))
    
    # Constrói a barra
    bar="["
    for ((j=0; j<filled; j++)); do
        bar+="#"
    done
    for ((j=0; j<empty; j++)); do
        bar+=" "
    done
    bar+="]"
    
    # Exibe
    echo "\r%s %d%%" "$bar" "$i"
    sleep 0.1
done

echo ""  # Nova linha no final
