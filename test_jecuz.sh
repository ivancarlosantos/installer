#!/bin/bash

BASE_URL=http://localhost:8080

echo "=============================================="
echo "🚀 INICIANDO TESTES AUTOMATIZADOS DA API"
echo "=============================================="

function call_api() {
  DESCRIPTION=$1
  REQUEST=$2

  echo ""
  echo "➡️  $DESCRIPTION"
  echo "----------------------------------------------"

  RESPONSE=$(eval $REQUEST -w "\n%{http_code}")
  HTTP_BODY=$(echo "$RESPONSE" | sed '$d')
  HTTP_STATUS=$(echo "$RESPONSE" | tail -n1)

  echo "Status: $HTTP_STATUS"
  echo "Response:"
  echo "$HTTP_BODY"

  if [[ "$HTTP_STATUS" -ge 200 && "$HTTP_STATUS" -lt 300 ]]; then
    echo "✅ SUCESSO"
  else
    echo "❌ ERRO - Abortando execução"
    exit 1
  fi
}

# ---------------------------------------------------
# 1️⃣ Initlizr Docker Container
# ---------------------------------------------------
echo 'initialzr docker container'
sleep 3
docker run --name=jecuz-test --network=jecuz_app -d -p 8080:8080 -e DB_USERNAME='postgres' -e DB_PASSWORD='12345' -e DB_URL='jdbc:postgresql://postgres:5432/jecuz_db' devmenorzera/jecuz:release
sleep 5

# ---------------------------------------------------
# 1️⃣ Health Check
# ---------------------------------------------------
call_api "Health Check" \
curl -s -X GET $BASE_URL/actuator/health

# ---------------------------------------------------
# 2️⃣ Endpoint Teste
# ---------------------------------------------------
call_api "Endpoint Teste" \
curl -s -X GET $BASE_URL/test

# ---------------------------------------------------
# 3️⃣ Criar Cliente
# ---------------------------------------------------
call_api "Criar Cliente" \
curl -s -X POST \"$BASE_URL/api/cliente/save?nome=NameFullName&nascimento=22/02/1990&telefone=%2B244854587887&numeroBi=001668196RS032&email=mail@mail.com

# ---------------------------------------------------
# 4️⃣ Criar Diarista
# ---------------------------------------------------
call_api "Criar Diarista" \
curl -s -X POST \"$BASE_URL/api/diarista/save?nome=NameFullName&nascimento=22/02/1990&telefone=%2B244854587878&numeroBi=001668196TQ032&email=mail@mail.com

# ---------------------------------------------------
# 5️⃣ Gerar Ordem de Serviço
# ---------------------------------------------------
call_api "Gerar Ordem de Serviço" \
curl -s -X POST \"$BASE_URL/api/ordem/servico/gerar?idCliente=1&idDiarista=1&tipoLimpeza=RESIDENCIAL&dataSolicitacao=15/02/2026&descricaoTarefa=limpeza%20comodos&valor=200.0&dataExecucao=19/02/2026

# ---------------------------------------------------
# 6️⃣ Listar Ordens
# ---------------------------------------------------
call_api "Listar Ordens de Serviço" \
curl -s -X GET \"$BASE_URL/api/ordem/servico/list?search=&page=0&size=10

echo ""
echo "=============================================="
echo "🎉 TODOS OS TESTES EXECUTADOS COM SUCESSO"
echo "=============================================="
