#!/bin/bash

# Função com spinner animado
progress_bar_spinner() {
    local current=$1
    local total=$2
    local width=${3:-50}
    
    local percent=$((current * 100 / total))
    local filled=$((width * current / total))
    
    # Caracteres do spinner
    local spinner=('⠋' '⠙' '⠹' '⠸' '⠼' '⠴' '⠦' '⠧' '⠇' '⠏')
    local spin_index=$((current % 10))
    
    local bar=""
    for ((i=0; i<width; i++)); do
        if [ $i -lt $filled ]; then
            bar="${bar}▓"
        else
            bar="${bar}░"
        fi
    done
    
    printf "\r%s [%s] %3d%%" "${spinner[$spin_index]}" "$bar" "$percent"
    
    if [ $current -eq $total ]; then
        printf "\r✓ [%s] %3d%%\n" "$bar" "$percent"
    fi
}

for i in {1..75}; do
    progress_bar_spinner $i 75
    sleep 0.03
done