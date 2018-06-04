#!/usr/bin/env bash
sudo yum update -y
sudo yum install -y docker  ## AWS ec2 Linux machine supports
sudo service docker start
sudo usermod -a -G docker ec2-user

docker build --tag praqma/native-scons:latest --file ${PWD}/Dockerfile ${PWD}
docker build -t new-prod-testing ${PWD}/Dockerfile
docker run -d -p 8089:3000 -t new-prod-testing