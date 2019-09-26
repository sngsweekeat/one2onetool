#!/usr/bin/env bash
yum update -y
yum -y install docker ; /sbin/service docker start ; docker info ## AWS AMI ami-7d95b612
docker build --tag praqma/native-scons:latest --file ${PWD}/Dockerfile ${PWD}