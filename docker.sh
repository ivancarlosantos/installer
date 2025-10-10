#!/bin/bash

echo "Docker & Docker Compose Installer"
sleep 3

echo "Install certificates"
sleep 3
curl -fsSL https://raw.githubusercontent.com/ivancarlosantos/installer/refs/heads/master/progress_bar_spinner.sh | bash 
apt-get install ca-certificates
sleep 3

echo "Install Docker"
sleep 3
curl -fsSL https://raw.githubusercontent.com/ivancarlosantos/installer/refs/heads/master/progress_bar_spinner.sh | bash
curl -ssL https://get.docker.com | sh
sleep 3

echo "add group Docker"
sleep 3
groupadd docker
sleep 3

echo "add user to group Docker"
sleep 3
usermod -aG docker $USER
sleep 3
curl -fsSL https://raw.githubusercontent.com/ivancarlosantos/installer/refs/heads/master/progress_bar_colored.sh | bash
sleep 2
echo "Docker Installed successfully"
sleep 3

echo "Docker Compose Installer"
sleep 3
mkdir -p ~/.docker/cli-plugins/
sleep 3
curl -SL https://github.com/docker/compose/releases/download/v2.3.3/docker-compose-linux-x86_64 -o ~/.docker/cli-plugins/docker-compose
sleep 3
chmod +x ~/.docker/cli-plugins/docker-compose
sleep 3
curl -fsSL https://raw.githubusercontent.com/ivancarlosantos/installer/refs/heads/master/progress_bar_spinner.sh | bash
sleep 2
echo "Docker Compose Installed Successfully"
sleep 3

echo 'Docker Version'
sleep 2
docker -v
sleep 2

echo 'Docker Compose Version'
sleep 2
docker compose version
sleep 2

echo "Update Machine"
sleep 3
curl -fsSL https://raw.githubusercontent.com/ivancarlosantos/installer/refs/heads/master/progress_bar_colored.sh | bash
sleep 2
apt-get update -y && apt-get upgrade -y
sleep 3
echo "Installer Successfully!!"
