#!/bin/bash

echo "Instalando gcc"
sleep 3
apt-get install gcc -y
sleep 3
gcc --version
sleep 3
echo "gcc installed successfully"