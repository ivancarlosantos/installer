#!/bin/bash

echo "Install Nginx\n"
sleep 3
apt-get install nginx -y
sleep 3
echo "Nginx Install Successfully\n"
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

echo 'Docker Version\n'
sleep 2
docker -v
sleep 2

echo "Update Machine\n"
sleep 4
apt-get update -y
sleep 3
echo "Update Successfully!!"