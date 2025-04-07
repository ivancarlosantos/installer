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

echo "Install Maven\n"
sleep 3
apt-get install maven -y
sleep 3
echo "maven install successfully\n"
sleep 5

echo "Java Installer\n"
sleep 3
add-apt-repository ppa:linuxuprising/java -y
sleep 3

echo "Bind Java Installer version v17\n"
sleep 3
apt-get install oracle-java17-installer oracle-java17-set-default
sleep 3

echo "Install Nginx\n"
sleep 3
apt-get install nginx -y
sleep 3
echo "nginx install successfully\n"
sleep 5

echo "Install NodeJs\n"
sleep 3
apt-get install nodejs npm -y 
sleep 3
echo "NodeJs install successfully"
sleep 5

echo "Install npm\n"
sleep 3
apt-get install npm -y
sleep 3
echo "npm install successfully\n"
sleep 5

echo "Install pm2\n"
sleep 3
apt-get npm install -g pm2
sleep 3
echo "pm2 install successfully\n"
sleep 5

echo "Install pnpm\n"
sleep 3
apt-get
sleep 3
echo "pnpm install successfully\n"
sleep 5

echo "Install certificates\n"
sleep 3
apt-get install ca-certificates curl
sleep 3

echo "Install Docker\n"
sleep 3
curl -ssL https://get.docker.com | sh
sleep 3

echo "add group Docker\n"
sleep 3
groupadd docker
sleep 3

echo "add user to group Docker\n"
sleep 3
usermod -aG docker $USER
sleep 3
echo "Docker Installed successfully\n"
sleep 3

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
cd environment-installer && curl -O https://raw.githubusercontent.com/ivancarlosantos/installer/refs/heads/master/image.c && curl -O https://raw.githubusercontent.com/ivancarlosantos/installer/refs/heads/master/image.sh 
sleep 3
echo "Download image file Successfully\n"
sleep 3

echo "Update Machine\n"
sleep 4
apt-get update -y
sleep 3
echo "Update Successfully\n"
