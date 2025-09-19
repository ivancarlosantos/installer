#!/bin/bash

curl -fsSL https://raw.githubusercontent.com/ivancarlosantos/installer/refs/heads/master/progress_bar_spinner.sh | bash
sleep 3

echo "OS Release!"
curl -fsSL https://raw.githubusercontent.com/ivancarlosantos/installer/refs/heads/master/release.sh | bash
sleep 5

echo "Criar Rede/Network Docker"
docker network create --driver bridge app-video-max
sleep 5

echo "Create installer folder"
sleep 2
mkdir environment-installer
sleep 2

echo "Download batchshell file image api-video-max"
sleep 3
cd environment-installer && curl -O https://raw.githubusercontent.com/ivancarlosantos/installer/refs/heads/master/prometheus.yml && curl -O https://raw.githubusercontent.com/ivancarlosantos/installer/refs/heads/master/promtail-config.yaml && curl -O https://raw.githubusercontent.com/ivancarlosantos/installer/refs/heads/master/loki-config.yml && curl -O https://raw.githubusercontent.com/ivancarlosantos/installer/refs/heads/master/image.c && curl -O https://raw.githubusercontent.com/ivancarlosantos/installer/refs/heads/master/image.sh && chmod +x image.sh
sleep 3
echo "Download image file Successfully"
sleep 3
curl -fsSL https://raw.githubusercontent.com/ivancarlosantos/installer/refs/heads/master/progress_bar_spinner.sh | bash

echo "Portainer"
docker run -d -p 9000:9000 --name portainer --network app-video-max --restart=always -v /var/run/docker.sock:/var/run/docker.sock portainer/portainer-ce:lts
sleep 5
curl -fsSL https://raw.githubusercontent.com/ivancarlosantos/installer/refs/heads/master/progress_bar_spinner.sh | bash

echo "Instalar Promtail"
docker run --name promtail --network app-video-max -d -v $(pwd):/mnt/config -v /var/log:/var/log --link loki grafana/promtail:3.0.0 -config.file=/mnt/config/promtail-config.yaml
sleep 5
curl -fsSL https://raw.githubusercontent.com/ivancarlosantos/installer/refs/heads/master/progress_bar_spinner.sh | bash

echo "Instalar Grafana"
docker run --name grafana --network app-video-max -d -p 7000:3000 --link loki grafana/grafana
sleep 5
curl -fsSL https://raw.githubusercontent.com/ivancarlosantos/installer/refs/heads/master/progress_bar_spinner.sh | bash

echo "Instalar Plugin Grafana-Loki"
docker plugin install grafana/loki-docker-driver:latest --alias loki --grant-all-permissions
sleep 5
curl -fsSL https://raw.githubusercontent.com/ivancarlosantos/installer/refs/heads/master/progress_bar_spinner.sh | bash

echo "Instalar Prometheus"
docker run --name prometheus --network app-video-max -d -p 9090:9090 -v $(pwd)/prometheus.yml:/etc/prometheus/prometheus.yml prom/prometheus:v3.2.1
sleep 5
curl -fsSL https://raw.githubusercontent.com/ivancarlosantos/installer/refs/heads/master/progress_bar_spinner.sh | bash

echo "Instalar Cadvisor"
docker run --name cadvisor --network app-video-max -d -p 8083:8080 -v /:/rootfs:ro -v /var/run:/var/run:ro -v /sys:/sys:ro -v /var/lib/docker/:/var/lib/docker:ro -v /dev/disk/:/dev/disk:ro gcr.io/cadvisor/cadvisor:latest
sleep 5
curl -fsSL https://raw.githubusercontent.com/ivancarlosantos/installer/refs/heads/master/progress_bar_spinner.sh | bash

echo "Instalar Uptime Kuma"
docker run --name uptime-kuma --network app-video-max --restart=always -d -p 3001:3001 -v uptime-kuma:/app/data -v /var/run/docker.sock:/var/run/docker.sock louislam/uptime-kuma:1
sleep 3
curl -fsSL https://raw.githubusercontent.com/ivancarlosantos/installer/refs/heads/master/progress_bar_spinner.sh | bash

echo "Instalar RabbitMQ"
docker run --name rabbitmq --hostname rabbit-host --network app-video-max -d -p 5672:5672 -p 15672:15672 rabbitmq:4.0-management-alpine
sleep 5
curl -fsSL https://raw.githubusercontent.com/ivancarlosantos/installer/refs/heads/master/progress_bar_spinner.sh | bash

echo "Instalar Postgres"
docker run --name postgres --network app-video-max -d -p 5432:5432 -e POSTGRES_PASSWORD='12345' -e POSTGRES_USER='postgres' -e POSTGRES_DB='video-max' postgres:15
sleep 5
curl -fsSL https://raw.githubusercontent.com/ivancarlosantos/installer/refs/heads/master/progress_bar_spinner.sh | bash

echo "PGAdmin"
docker run --name pgadmin --network app-video-max -d -p 15432:80 -e PGADMIN_DEFAULT_EMAIL='video-max@mail.com.br' -e PGADMIN_DEFAULT_PASSWORD='video-max@mail.com.br' dpage/pgadmin4:latest
sleep 5
curl -fsSL https://raw.githubusercontent.com/ivancarlosantos/installer/refs/heads/master/progress_bar_spinner.sh | bash

echo "Video Max"
docker run --name video-max --network app-video-max -d -p 8080:8080 -e DB_URL='jdbc:postgresql://postgres:5432/video-max' -e DB_USERNAME='postgres' -e DB_PASSWORD='12345' -e RABBITMQ_HOST='rabbit-host' devmenorzera/video-max:latest
sleep 5
curl -fsSL https://raw.githubusercontent.com/ivancarlosantos/installer/refs/heads/master/progress_bar_spinner.sh | bash

echo "Update User Plan"
docker run --name user-plan --network app-video-max -d -p 8081:8081 -e DB_URL='jdbc:postgresql://postgres:5432/video-max' -e DB_USERNAME='postgres' -e DB_PASSWORD='12345' -e RABBITMQ_HOST='rabbit-host' devmenorzera/user-plan:latest
sleep 5
curl -fsSL https://raw.githubusercontent.com/ivancarlosantos/installer/refs/heads/master/progress_bar_spinner.sh | bash
