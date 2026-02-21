#!/bin/bash

echo "SmokeTest Jecuz URL"
sleep 3

echo "Required health"
sleep 3
curl http://localhost:8080/actuator/health 
sleep 2

echo "Application URL Test"
sleep 3
curl http://localhost:8080/test 
sleep 2

echo "SmokeTest Successfully!!"
