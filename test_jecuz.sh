#!/bin/bash

echo "SmokeTest Jecuz URL"
sleep 3

echo "Required actuator"
sleep 3
curl http://localhost:8080/actuator 
sleep 2

echo "Required health"
sleep 3
curl http://localhost:8080/actuator/health 
sleep 2

echo "Required health"
sleep 3
curl http://localhost:8080/actuator/health 
sleep 2

echo "Required health"
sleep 3
curl http://localhost:8080/actuator/health 
sleep 2

echo "Required health"
sleep 3
curl http://localhost:8080/actuator/health 
sleep 2

echo "SmokeTest Successfully!!"
