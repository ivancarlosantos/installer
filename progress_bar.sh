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

# ========== EXEMPLOS DE USO ==========

echo "=== Exemplo 1: Barra de Progresso Simples ==="
for i in {1..100}; do
    progress_bar $i 100
    sleep 0.02
done

echo -e "\n=== Exemplo 2: Barra de Progresso Colorida ==="
for i in {0..50}; do
    progress_bar_colored $((i*2)) 100
    sleep 0.04
done

echo -e "\n=== Exemplo 3: Barra com Spinner Animado ==="
for i in {1..75}; do
    progress_bar_spinner $i 75
    sleep 0.03
done

echo -e "\n=== Exemplo 4: Barra com Informações Detalhadas ==="
SECONDS=0  # Reset timer
total_files=30
for i in $(seq 1 $total_files); do
    progress_bar_detailed $i $total_files "Baixando arquivos"
    sleep 0.1
done

echo -e "\n=== Exemplo 5: Simulação de Download ==="
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

echo -e "\n✅ Todas as tarefas concluídas!"
