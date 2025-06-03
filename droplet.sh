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

echo 'portainer'
sleep 2
curl -L https://downloads.portainer.io/ce2-18/portainer-agent-stack.yml -o portainer-agent-stack.yml
sleep 2
