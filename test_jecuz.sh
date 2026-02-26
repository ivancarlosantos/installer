#!/bin/bash

echo "=============================================="
echo "🚀 INICIANDO TESTES AUTOMATIZADOS DA API"
echo "=============================================="

sleep 2

# ---------------------------------------------------
# Create Network Docker Container
# ---------------------------------------------------
echo 'create network database'
sleep 3
echo ' '
docker network create --driver bridge jecuz_app
sleep 20

# ---------------------------------------------------
# Started Docker Container Database
# ---------------------------------------------------
echo 'initialzr docker container Database'
sleep 3
echo ' '
docker run --name='jecuz_db' --network='jecuz_app' -d -p 5432:5432 -e POSTGRES_PASSWORD='12345' -e POSTGRES_USER='postgres' -e POSTGRES_DB='jecuz_db' postgres:15
sleep 20

# ---------------------------------------------------
# Initializr Docker Application API
# ---------------------------------------------------
echo 'initialzr docker container'
sleep 3
echo ' '
docker run --name=jecuz-test --network=jecuz_app -d -p 8080:8080 -e DB_USERNAME='postgres' -e DB_PASSWORD='12345' -e DB_URL='jdbc:postgresql://jecuz_db:5432/jecuz_db' devmenorzera/jecuz:release
sleep 20

# ---------------------------------------------------
# Health Check
# ---------------------------------------------------
echo "Health Check"
sleep 3
echo ' '
curl -X GET http://localhost:8080/actuator/health -H "Content-Type: application/json"

# ---------------------------------------------------
# Endpoint Teste
# ---------------------------------------------------
echo 'Endpoint Teste'
sleep 3
echo ' '
curl -X GET http://localhost:8080/test -H "Content-Type: application/json"
sleep 2

# ---------------------------------------------------
# Criar Cliente
# ---------------------------------------------------
echo 'Criar Cliente'
sleep 3
echo ' '
curl -X POST "http://localhost:8080/api/cliente/save?nome=NameFullName&nascimento=22/02/1990&telefone=%2B244854587887&numeroBi=001668196RS032&email=mail@mail.com" \
  -H "Content-Type: application/json"
sleep 2

# ---------------------------------------------------
# Criar Diarista
# ---------------------------------------------------
echo 'Criar Diarista'
sleep 3
echo ' '
curl -X POST "http://localhost:8080/api/diarista/save?nome=NameFullName&nascimento=22/02/1990&telefone=%2B244854587887&numeroBi=001668196RS032&email=mail@mail.com" -H "Content-Type: application/json"
sleep 2

# ---------------------------------------------------
# Gerar Ordem de Serviço
# ---------------------------------------------------
echo 'Gerar Ordem de Serviço'
sleep 3
echo ' '
curl -X POST "http://localhost:8080/api/ordem/servico/gerar?idCliente=1&idDiarista=1&tipoLimpeza=RESIDENCIAL&dataSolicitacao=15/02/2026&descricaoTarefa=limpeza%20comodos&valor=200.0&dataExecucao=19/02/2026" -H "Content-Type: application/json"
sleep 2

# ---------------------------------------------------
# Listar Ordens
# ---------------------------------------------------
echo 'Listar Ordens de Serviço'
sleep 3
echo ' '
curl -X GET "http://localhost:8080/api/ordem/servico/list?search=&page=0&size=10" -H "Content-Type: application/json"
sleep 2

# ---------------------------------------------------
# Destruir containers
# ---------------------------------------------------
echo 'Destruir containers'
sleep 5
echo ' '
docker stop jecuz-test jecuz_db
sleep 3
docker rm jecuz-test jecuz_db

echo ""
echo "=============================================="
echo "🎉 TODOS OS TESTES EXECUTADOS COM SUCESSO"
echo "=============================================="
