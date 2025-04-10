#!/bin/bash

echo "Java Installer\n"
sleep 3
add-apt-repository ppa:linuxuprising/java -y
sleep 3

echo "Bind Java Installer version v17\n"
sleep 3
apt-get install oracle-java17-installer oracle-java17-set-default
sleep 3