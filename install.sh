#!/bin/bash

echo "Create Production Environment Machine"
sleep 4
apt-get update -y
sleep 3
echo "Update Successfully"
sleep 5

echo "OS Release"
curl -fsSL https://raw.githubusercontent.com/ivancarlosantos/installer/refs/heads/master/release.sh | bash

sleep 5

echo "gcc Installer"
curl -fsSL https://raw.githubusercontent.com/ivancarlosantos/installer/refs/heads/master/gcc.sh | bash
sleep 3

echo "Install Maven"
sleep 3
apt-get install maven -y
sleep 3
echo "maven install successfully"
sleep 5

echo "Java Installer"
sleep 3
add-apt-repository ppa:linuxuprising/java -y
sleep 3

echo "Bind Java Installer version v17"
sleep 3
apt-get install oracle-java17-installer oracle-java17-set-default
sleep 3

echo "Install Nginx"
sleep 3
apt-get install nginx -y
sleep 3
echo "nginx install successfully"
sleep 5

echo "Install certificates"
sleep 3
apt-get install ca-certificates curl
sleep 3

echo "Install Docker"
sleep 3
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
echo "Docker Installed successfully"
sleep 3

echo 'Version Verify'
sleep 2
curl -fsSL https://raw.githubusercontent.com/ivancarlosantos/installer/refs/heads/master/version.sh | bash
sleep 2

echo "Create installer folder"
sleep 2
mkdir environment-installer
sleep 2

echo "Download batchshell file image api-powerkr"
sleep 3
cd environment-installer && curl -O https://raw.githubusercontent.com/ivancarlosantos/installer/refs/heads/master/image.c && curl -O https://raw.githubusercontent.com/ivancarlosantos/installer/refs/heads/master/image.sh 
sleep 3
echo "Download image file Successfully"
sleep 3

echo "Update Machine"
sleep 4
apt-get update -y
sleep 3
echo "Update Successfully"
