#!/bin/bash

set -e

echo '\nSmokeTest Jecuz URL\n'
sleep 3

echo '\nRequired health\n'
sleep 3
curl http://localhost:8080/actuator/health 
sleep 2

echo 'Application URL Test\n'
sleep 3
curl http://localhost:8080/test 
sleep 2

echo 'SmokeTest Successfully!!\n'
