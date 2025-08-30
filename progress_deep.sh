#!/bin/bash

# Função para exibir a barra de progresso
progress_bar() {
    local duration=${1:-10}  # Duração padrão de 10 segundos
    local max_width=50       # Largura máxima da barra
    local increment=$((100 / max_width))
    local current=0
    local percent=0
    
    echo "Iniciando processo..."
    echo ""
    
    while [ $current -lt 100 ]; do
        # Calcula a porcentagem atual
        percent=$current
        if [ $percent -gt 100 ]; then
            percent=100
        fi
        
        # Calcula quantos caracteres # mostrar
        local filled=$((current * max_width / 100))
        if [ $filled -gt $max_width ]; then
            filled=$max_width
        fi
        
        # Cria a barra
        local bar="["
        for ((i=0; i<filled; i++)); do
            bar+="#"
        done
        
        for ((i=filled; i<max_width; i++)); do
            bar+=" "
        done
        bar+="]"
        
        # Exibe a barra com porcentagem
        printf "\r%s %3d%%" "$bar" "$percent"
        
        # Incrementa o progresso
        sleep "$duration"
        current=$((current + increment))
    done
    
    # Completa a barra
    printf "\r["
    for ((i=0; i<max_width; i++)); do
        printf "#"
    done
    printf "] 100%%\n"
    echo "Processo concluído!"
}

# Função alternativa com tempo personalizado
custom_progress() {
    local total_steps=$1
    local current_step=0
    
    echo "Processando $total_steps itens..."
    echo ""
    
    while [ $current_step -le $total_steps ]; do
        local percent=$((current_step * 100 / total_steps))
        local width=50
        local filled=$((percent * width / 100))
        
        # Barra de progresso
        bar="["
        for ((i=0; i<filled; i++)); do
            bar+="="
        done
        
        for ((i=filled; i<width; i++)); do
            bar+=" "
        done
        bar+="]"
        
        # Atualiza a linha
        printf "\r%s %d/%d (%3d%%)" "$bar" "$current_step" "$total_steps" "$percent"
        
        # Simula algum processamento
        sleep 0.1
        
        current_step=$((current_step + 1))
    done
    
    printf "\nConcluído!\n"
}

# Função com cores (se suportado)
colored_progress() {
    local total=100
    local current=0
    
    echo -e "Processo com cores:"
    echo ""
    
    while [ $current -le $total ]; do
        local percent=$current
        local width=30
        
        # Barra colorida
        printf "\r\e[32m[\e[0m"  # Verde para abertura
        
        # Parte preenchida (verde)
        local filled=$((current * width / 100))
        for ((i=0; i<filled; i++)); do
            printf "\e[42m \e[0m"  # Fundo verde
        done
        
        # Parte vazia (cinza)
        for ((i=filled; i<width; i++)); do
            printf "\e[47m \e[0m"  # Fundo cinza
        done
        
        printf "\e[32m]\e[0m \e[1m%3d%%\e[0m" "$percent"  # Negrito para porcentagem
        
        sleep 0.05
        current=$((current + 2))
    done
    
    printf "\nFinalizado!\n"
}

# Menu principal
echo "Escolha o tipo de barra de progresso:"
echo "1) Barra simples (10 segundos)"
echo "2) Barra com contador"
echo "3) Barra colorida"
echo -n "Sua escolha: "
read choice

case $choice in
    1)
        progress_bar 0.1  # Mais rápido para demonstração
        ;;
    2)
        custom_progress 50
        ;;
    3)
        colored_progress
        ;;
    *)
        echo "Usando barra padrão..."
        progress_bar 0.1
        ;;
esac