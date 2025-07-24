#!/bin/bash

echo "OS Release!\n"
curl -fsSL https://raw.githubusercontent.com/ivancarlosantos/installer/refs/heads/master/release.sh | bash
sleep 5

echo "Criar Rede/Network Docker\n"
docker network create --driver bridge app-prime-max
sleep 5

echo "Create installer folder\n"
sleep 2
mkdir environment-installer
sleep 2

echo "Download batchshell file image api-prime-max\n"
sleep 3
cd environment-installer && curl -O https://raw.githubusercontent.com/ivancarlosantos/installer/refs/heads/master/prometheus.yml && curl -O https://raw.githubusercontent.com/ivancarlosantos/installer/refs/heads/master/promtail-config.yaml && curl -O https://raw.githubusercontent.com/ivancarlosantos/installer/refs/heads/master/loki-config.yml && curl -O https://raw.githubusercontent.com/ivancarlosantos/installer/refs/heads/master/image.c && curl -O https://raw.githubusercontent.com/ivancarlosantos/installer/refs/heads/master/image.sh && chmod +x image.sh
sleep 3
echo "Download image file Successfully\n"
sleep 3

echo "Instalar Loki"
docker run --name loki --network app-prime-max -d -v $(pwd):/mnt/config -p 3100:3100 grafana/loki:3.0.0 -config.file=/mnt/config/loki-config.yaml
sleep 5

echo "Instalar Promtail"
docker run --name promtail --network app-prime-max -d -v $(pwd):/mnt/config -v /var/log:/var/log --link loki grafana/promtail:3.0.0 -config.file=/mnt/config/promtail-config.yaml
sleep 5

echo "Instalar Grafana"
docker run --name grafana --network app-prime-max -d -p 3001:3000 --link loki grafana/grafana
sleep 5

echo "Instalar Plugin Grafana-Loki"
docker plugin install grafana/loki-docker-driver:latest --alias loki --grant-all-permissions
sleep 5

echo "Instalar Prometheus"
docker run --name prometheus --network app-prime-max -d -p 9090:9090 -v $(pwd)/prometheus.yml:/etc/prometheus/prometheus.yml prom/prometheus:v3.2.1
sleep 5

echo "Instalar Cadvisor"
docker run --name cadvisor --network app-prime-max -d -p 8083:8080 -v /:/rootfs:ro -v /var/run:/var/run:ro -v /sys:/sys:ro -v /var/lib/docker/:/var/lib/docker:ro -v /dev/disk/:/dev/disk:ro gcr.io/cadvisor/cadvisor:latest
sleep 5
