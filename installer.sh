#!/bin/bash

echo "OS Release!\n"
curl -fsSL https://raw.githubusercontent.com/ivancarlosantos/installer/refs/heads/master/release.sh | bash
sleep 5

echo "Create installer folder\n"
sleep 2
mkdir environment-installer
sleep 2

echo "Download batchshell file image api-powerkr\n"
sleep 3
cd environment-installer && curl -O https://raw.githubusercontent.com/ivancarlosantos/installer/refs/heads/master/prometheus.yml && curl -O https://raw.githubusercontent.com/ivancarlosantos/installer/refs/heads/master/promtail-config.yaml && curl -O https://raw.githubusercontent.com/ivancarlosantos/installer/refs/heads/master/loki-config.yml && curl -O https://raw.githubusercontent.com/ivancarlosantos/installer/refs/heads/master/image.c && curl -O https://raw.githubusercontent.com/ivancarlosantos/installer/refs/heads/master/image.sh && chmod +x image.sh
sleep 3
echo "Download image file Successfully\n"
sleep 3
