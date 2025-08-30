#!/bin/bash
# Função alternativa com cores
progress_bar_colored() {
    local current=$1
    local total=$2
    local width=${3:-50}
    
    local percent=$((current * 100 / total))
    local filled=$((width * current / total))
    
    # Cores ANSI
    local GREEN='\033[0;32m'
    local GRAY='\033[0;37m'
    local NC='\033[0m' # No Color
    
    printf "\r["
    
    # Parte preenchida (verde)
    printf "${GREEN}"
    for ((i=0; i<filled; i++)); do
        printf "="
    done
    
    # Parte vazia (cinza)
    printf "${GRAY}"
    for ((i=filled; i<width; i++)); do
        printf "-"
    done
    printf "${NC}"
    
    printf "] %3d%%" "$percent"
    
    if [ $current -eq $total ]; then
        echo
    fi
}

echo -e "\n=== Exemplo 2: Barra de Progresso Colorida ==="
for i in {0..50}; do
    progress_bar_colored $((i*2)) 100
    sleep 0.04
done