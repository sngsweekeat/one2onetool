#!/usr/bin/env bash
yum update -y
docker build --tag praqma/native-scons:latest --file ${PWD}/Dockerfile ${PWD}
docker build -t new-prod-testing ${PWD}/Dockerfile
docker run -d -p 8089:3000 -t new-prod-testing