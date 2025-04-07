#!/bin/bash

# executado limpeza do cache, dentries e inodes

echo 'Para limpar o Cache/Buffer de RAM:'
sleep 2
sync; echo 1 > /proc/sys/vm/drop_caches
sleep 3

echo 'Para limpar Dentries e inodes:'
sleep 2
sync; echo 2 > /proc/sys/vm/drop_caches
sleep 3

echo 'Para limpar tudo: Cache/Buffer, Dentries e Inodes:'
sleep 2
sync; echo 3 > /proc/sys/vm/drop_caches
sleep 3

echo 'Para limpar o espaço em disco consumido pela SWAP:'
sleep 2
swapoff -a && swapon -a
sleep 3

echo 'Processo de clean cache realizado com sucesso\n'