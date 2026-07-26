#!/bin/bash

sleep 3

echo "=============================================="
echo "🚀 INICIANDO DOWNLOAD DA BASE DE DADOS"
echo "=============================================="

sleep 3
curl -fsSL https://raw.githubusercontent.com/ivancarlosantos/installer/refs/heads/master/progress_bar_spinner.sh | bash

sleep 2

echo "===================================================="
echo "🚀 CONSTRUINDO REDE PARA CONEXÃO DOS CONTAINERS"
echo "===================================================="

sleep 3
echo ' '
docker network create --driver bridge aula_net

sleep 3

echo "==========================================================="
echo "🚀 BAIXANDO AS IMAGENS DO BANCO POSTGRES E SGBG PGADMIN"
echo "==========================================================="

sleep 2

echo ' '
echo "==========================================================="
echo "🚀 BAIXANDO IMAGEM DO BANCO POSTGRES"
echo "==========================================================="
docker run --name='database-aula' --network='aula_net' -d -p 5433:5433 -e POSTGRES_PASSWORD='aula' -e POSTGRES_USER='aula' -e POSTGRES_DB='database_aula' postgres:15
sleep 10

curl -fsSL https://raw.githubusercontent.com/ivancarlosantos/installer/refs/heads/master/progress_bar_spinner.sh | bash

sleep 2
echo ' '
echo "==========================================================="
echo "🚀 BAIXANDO AS IMAGEM SGBG PGADMIN"
echo "==========================================================="
docker run --name='sgbd-pgadmin' --network='aula_net' -d -p 15432:80 -e PGADMIN_DEFAULT_EMAIL='aula@aula.com' -e PGADMIN_DEFAULT_PASSWORD='aula@aula.com' dpage/pgadmin4:latest
sleep 5

curl -fsSL https://raw.githubusercontent.com/ivancarlosantos/installer/refs/heads/master/progress_bar_spinner.sh | bash
echo ' '
echo "================================================="
echo "🎉 TODOS OS CONTAINERS EXECUTADOS COM SUCESSO"
echo "================================================="
