#!/bin/bash

echo "Create Production Environment Machine\n"
sleep 4
apt-get update -y
sleep 3
echo "Update Successfully!\n"
sleep 5

echo "OS Release!\n"
curl -fsSL https://raw.githubusercontent.com/ivancarlosantos/installer/refs/heads/master/release.sh | bash

sleep 5

echo "gcc Installer\n"
curl -fsSL https://raw.githubusercontent.com/ivancarlosantos/installer/refs/heads/master/gcc.sh | bash
sleep 3

echo "Java Installer\n"
curl -fsSL https://raw.githubusercontent.com/ivancarlosantos/installer/refs/heads/master/java.sh | bash
sleep 3

echo "Install doctl"
sleep 2
sudo snap install doctl
sleep 3

echo "create root config file\n"
sleep 2
mkdir /root/.config
sleep 3

echo "create docker config file\n"
sleep 2
mkdir /root/.docker
sleep 3

echo "Install Nginx\n"
sleep 3
apt-get install nginx -y
sleep 3
echo "nginx install successfully\n"
sleep 5

echo 'Docker Installer\n'
sleep 2
curl -fsSL https://raw.githubusercontent.com/ivancarlosantos/installer/refs/heads/master/docker.sh | bash
sleep 2

echo 'Version Verify\n'
sleep 2
curl -fsSL https://raw.githubusercontent.com/ivancarlosantos/installer/refs/heads/master/version.sh | bash
sleep 2

echo "Create installer folder\n"
sleep 2
mkdir environment-installer
sleep 2

echo "Download batchshell file image api-powerkr\n"
sleep 3
cd environment-installer && curl -O https://raw.githubusercontent.com/ivancarlosantos/installer/refs/heads/master/image.c && curl -O https://raw.githubusercontent.com/ivancarlosantos/installer/refs/heads/master/image.sh && chmod +x image.sh 
sleep 3
echo "Download image file Successfully\n"
sleep 3

echo "Installing the Metrics Agent\n"
sleep 3
curl -sSL https://repos.insights.digitalocean.com/install.sh | sh
sleep 3
echo "Installing the Metrics Agent Successfully\n"
sleep 2

echo "Update Machine\n"
sleep 4
apt-get update -y
sleep 3
echo "Update Successfully\n"