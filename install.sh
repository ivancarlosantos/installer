#!/bin/bash

echo "Update Development Machine"
sleep 4
apt update -y && apt upgrade -y curl
sleep 3

echo "Update Successfully"

sleep 5

echo "Java Installer"
sleep 3
add-apt-repository ppa:linuxuprising/java -y
sleep 3

echo "Update and Upgrade"
apt update -y && apt upgrade -y
sleep 3

echo "Bind Java Installer version v17"
sleep 3
apt-get install oracle-java17-installer oracle-java17-set-default

sleep 3

echo Install Maven
sleep 3
apt-get install maven
sleep 3
echo "maven install successfully"

sleep 5

echo "Install Nginx"
sleep 3
apt-get install nginx
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

echo "Docker Installed successfully"
