#!/bin/bash

download_simulation() {
    local file_size=1048576  # 1MB em bytes
    local chunk_size=10240   # 10KB por vez
    local downloaded=0
    
    echo "Baixando arquivo.zip (1 MB)..."
    
    while [ $downloaded -lt $file_size ]; do
        downloaded=$((downloaded + chunk_size))
        if [ $downloaded -gt $file_size ]; then
            downloaded=$file_size
        fi
        
        # Calcula KB baixados e total
        local kb_down=$((downloaded / 1024))
        local kb_total=$((file_size / 1024))
        
        # Barra de progresso
        local percent=$((downloaded * 100 / file_size))
        local width=40
        local filled=$((width * percent / 100))
        
        printf "\r["
        printf "%${filled}s" | tr ' ' '='
        printf "%$((width - filled))s" | tr ' ' '-'
        printf "] %3d%% (%d KB / %d KB)" $percent $kb_down $kb_total
        
        sleep 0.05
    done
    
    echo -e "\n✓ Download concluído!"
}

download_simulation

echo -e "\n=== Exemplo 6: Múltiplas Tarefas ==="
tasks=("Inicializando" "Conectando ao servidor" "Baixando dados" "Processando" "Finalizando")

for task_idx in ${!tasks[@]}; do
    echo -e "\n${tasks[$task_idx]}..."
    for i in {1..20}; do
        progress_bar $i 20 30
        sleep 0.05
    done
done