#!/bin/bash

# Função com informações adicionais
progress_bar_detailed() {
    local current=$1
    local total=$2
    local task_name=${3:-"Processando"}
    local width=40
    
    local percent=$((current * 100 / total))
    local filled=$((width * current / total))
    
    local bar=""
    for ((i=0; i<width; i++)); do
        if [ $i -lt $filled ]; then
            bar="${bar}#"
        else
            bar="${bar}-"
        fi
    done
    
    # Tempo estimado (exemplo simplificado)
    local elapsed=$SECONDS
    if [ $current -gt 0 ]; then
        local eta=$(((total - current) * elapsed / current))
        printf "\r%s: [%s] %3d%% (%d/%d) ETA: %ds  " \
               "$task_name" "$bar" "$percent" "$current" "$total" "$eta"
    else
        printf "\r%s: [%s] %3d%% (%d/%d)  " \
               "$task_name" "$bar" "$percent" "$current" "$total"
    fi
    
    if [ $current -eq $total ]; then
        echo
    fi
}

SECONDS=0  # Reset timer
total_files=30
for i in $(seq 1 $total_files); do
    progress_bar_detailed $i $total_files "Baixando arquivos"
    sleep 0.1
done