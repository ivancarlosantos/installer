#!/bin/bash

sleep 2

echo 'Update & Upgrade Droplet'
sleep 2
apt-get update -y & apt-get upgrade -y
sleep 2

echo 'gcc'
sleep 2
curl -fsSL https://raw.githubusercontent.com/ivancarlosantos/installer/refs/heads/master/gcc.sh | sh
sleep 2

echo 'Docker'
sleep 2
curl -fsSL https://raw.githubusercontent.com/ivancarlosantos/installer/refs/heads/master/docker.sh | sh
sleep 2

echo 'create npm_public network'
sleep 3
docker network create --driver overlay npm_public
sleep 2

echo 'create environment directory'
sleep 2
mkdir environment-installer
sleep 2
cd environment-installer && curl -O https://raw.githubusercontent.com/ivancarlosantos/installer/refs/heads/master/image.c && curl -O https://raw.githubusercontent.com/ivancarlosantos/installer/refs/heads/master/image.sh && chmod +x image.sh
sleep 2

echo 'portainer'
sleep 2
cd environment-installer && curl -L https://downloads.portainer.io/ce2-18/portainer-agent-stack.yml -o portainer-agent-stack.yml && docker stack deploy -c portainer-agent-stack.yml portainer
sleep 2

echo 'Environment Installer Successfully'
