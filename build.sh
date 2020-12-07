#!/bin/bash

set -e
set -x

trap 'alert' ERR

##########
# All these variables are ideally defined in the CI tool (Jenkins, GitHub etc)
##########
CI_REGISTRY_USER="quattro1982"
DOCKER_REGISTRY="registry.hub.docker.com"
WORKING_DIR="~/one2onetool/"
CI_REPOSITORY="devops"
AWS_DEFAULT_REGION="ap-southeast-1"
AWS_FARGATE_CLUSTER_NAME="devops-test"
AWS_FARGATE_SERVICE_NAME="devops-test"
AWS_FARGATE_COUNT=1

function alert() {
  recipient="build-alert@test.com"
  echo "Sending Alert mail"
#  sendmail "$recipient" <<EOF
#subject: Alert - Build Failure
#from: Build Server
#EOF
}

function increment_version {
  # Currently we are only incrementing major versions for simplicity
  APP_VERSION=`cat package.json | jq '.version' | tr -d '"' | perl -ne '/(^\d+.*?)\.(\d+.*?)\.(\d+.*)/ and print "@{[$1+1]}.$2.$3"'`
  # Increment version using npm
  npm --no-git-tag-version version $APP_VERSION
  # OR npm version major | npm version minor
}

#function install_deps() {
#  # Install dependencies
#  # sudo yum install -y yum-utils jq
#  # sudo yum-config-manager \
#  #  --add-repo \
#  #  https://download.docker.com/linux/centos/docker-ce.repo
#
#  # sudo yum install docker-ce docker-ce-cli containerd.io
#  # sudo curl -Lo /usr/local/bin/ecs-cli https://amazon-ecs-cli.s3.amazonaws.com/ecs-cli-linux-amd64-latest
#  # sudo chmod +x /usr/local/bin/ecs-cli
#  # ecs-cli --version
#}

function isfailed(){
  retval=$?
  echo "return code is $retval"
  if [ $retval -ne 0 ]; then
    echo "Build Failure"
    alert
    exit 1
  fi
}

function test() {
  git pull #Pull latest
  # install dependencies

  npm install
  # Run tests
  npm test
  isfailed
}

function build(){
  # Assume docker packages have been installed
  # Will not include the password to docker hub
  IMAGE_NAME=$CI_REGISTRY_USER/$CI_REPOSITORY:$DOCKER_TAG
  echo "Data file for $BRANCH_NAME is $DATA_FILE"
  cat ./dockerhub_password.txt | docker login -u $CI_REGISTRY_USER --password-stdin $DOCKER_REGISTRY
  docker build --build-arg QNDATA=$DATA_FILE -t $CI_REGISTRY_USER/$CI_REPOSITORY:$DOCKER_TAG .
  docker push $IMAGE_NAME
  docker image prune -f
}

function deploy() {
  # Assume CLI has been installed and AWS Environment set up for ECS & Fargate
  cat aws/fargate/$BRANCH_NAME.json | jq --arg imgname "$IMAGE_NAME" '.containerDefinitions[0].image=$imgname' > /tmp/task-def.json

  TASK_DEFINITION=`aws ecs register-task-definition --cli-input-json file:///tmp/task-def.json`
  NEW_TASK_DEFINITION=`echo $TASK_DEFINITION | jq '.[] | .taskDefinitionArn' | cut -d '/' -f 2 | tr -d '"'`
  echo $NEW_TASK_DEFINITION

  # Assume service already exists, so we only need to update the task definitions for the service
  SERVICE=`aws ecs update-service --cluster $AWS_FARGATE_CLUSTER_NAME --service $AWS_FARGATE_SERVICE_NAME-$BRANCH_NAME --task-definition $NEW_TASK_DEFINITION --desired-count $AWS_FARGATE_COUNT`

}

# Get Version from package.json
increment_version
echo "New app version is $APP_VERSION"

# Get Current Branch name
BRANCH_NAME=`git branch --show-current`
echo "Running on branch $BRANCH_NAME"

if [ $BRANCH_NAME == "staging" ] ; then
  echo "Running on staging branch"
  DATA_FILE="Questions-test.json"
  DOCKER_TAG=$APP_VERSION-$BRANCH_NAME

elif [ $BRANCH_NAME == "release" ] ; then
  echo "Running on $BRANCH_NAME branch"
  DATA_FILE="Questions.json"
  DOCKER_TAG="latest"
else
  echo "Incorrect Build Branch"
  exit 1
fi

test
build
deploy

echo "Build done"

exit 0




