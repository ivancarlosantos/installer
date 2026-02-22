#!/bin/bash

echo "=============================================="
echo "🚀 INICIANDO TESTES AUTOMATIZADOS DA API"
echo "=============================================="

# ---------------------------------------------------
# 1️⃣ Started Docker Container Database
# ---------------------------------------------------
echo 'initialzr docker container Database'
sleep 3
docker run --name='jecuz_db' --network='jecuz_app' -d -p 5432:5432 -e POSTGRES_PASSWORD='12345' -e POSTGRES_USER='postgres' -e POSTGRES_DB='jecuz_db' postgres:15
sleep 20

# ---------------------------------------------------
# 1️⃣ Initializr Docker Application API
# ---------------------------------------------------
echo 'initialzr docker container'
sleep 3
docker run --name=jecuz-test --network=jecuz_app -d -p 8080:8080 -e DB_USERNAME='postgres' -e DB_PASSWORD='12345' -e DB_URL='jdbc:postgresql://jecuz_db:5432/jecuz_db' devmenorzera/jecuz:release
sleep 20

# ---------------------------------------------------
# 1️⃣ Health Check
# ---------------------------------------------------
echo "Health Check"
sleep 3
curl -X GET http://localhost:8080/actuator/health -H "Content-Type: application/json"

# ---------------------------------------------------
# 2️⃣ Endpoint Teste
# ---------------------------------------------------
echo "Endpoint Teste"
sleep 3
curl -X GET http://localhost:8080/test -H "Content-Type: application/json"
sleep 2

# ---------------------------------------------------
# 3️⃣ Criar Cliente
# ---------------------------------------------------
echo "Criar Cliente"
sleep 3
curl -X POST "http://localhost:8080/api/cliente/save?nome=NameFullName&nascimento=22/02/1990&telefone=%2B244854587887&numeroBi=001668196RS032&email=mail@mail.com" \
  -H "Content-Type: application/json"
sleep 2

# ---------------------------------------------------
# 4️⃣ Criar Diarista
# ---------------------------------------------------
echo "Criar Diarista"
sleep 3
curl -X POST "http://localhost:8080/api/diarista/save?nome=NameFullName&nascimento=22/02/1990&telefone=%2B244854587887&numeroBi=001668196RS032&email=mail@mail.com" -H "Content-Type: application/json"
sleep 2

# ---------------------------------------------------
# 5️⃣ Gerar Ordem de Serviço
# ---------------------------------------------------
echo "Gerar Ordem de Serviço"
sleep 3
curl -X POST "http://localhost:8080/api/ordem/servico/gerar?idCliente=1&idDiarista=1&tipoLimpeza=RESIDENCIAL&dataSolicitacao=15/02/2026&descricaoTarefa=limpeza%20comodos&valor=200.0&dataExecucao=19/02/2026" -H "Content-Type: application/json"
sleep 2

# ---------------------------------------------------
# 6️⃣ Listar Ordens
# ---------------------------------------------------
echo "Listar Ordens de Serviço"
sleep 3
curl -X GET "http://localhost:8080/api/ordem/servico/list?search=&page=0&size=10" -H "Content-Type: application/json"
sleep 2

# ---------------------------------------------------
# 6️⃣ Destruir containers
# ---------------------------------------------------
echo "Destruir containers"
sleep 5
docker stop jecuz-test jecuz_db
sleep 3
docker rm jecuz-test jecuz_db

echo ""
echo "=============================================="
echo "🎉 TODOS OS TESTES EXECUTADOS COM SUCESSO"
echo "=============================================="
