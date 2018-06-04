devlier.sh

#!/usr/bin/env bash
. secret_values.sh

echo 'Now...'
echo 'Visit http://localhost:3000 to see your Node.js/React application in action.'
echo '(This is why you specified the "args ''-p 3000:3000''" parameter when you'
echo 'created your initial Pipeline as a Jenkinsfile.)'

export DOCKER_ID_USER="jsingamsetty" ##docker user id
export DOCKER_PASSWORD="docker_password"  ##docker password.
docker login -u="$DOCKER_USERNAME" -p="$DOCKER_PASSWORD"

docker images
docker build -t $new-image ${PWD}/Dockerfile
docker run -d -p 8089:3000 -t $new-image
docker push $DOCKER_ID_USER/$new-image

##Deploying to AWS free tier for supporting Ansible 
grep -i "Amazon Linux" /etc/os-release | head -1

if [ $? -ne 0 ];
	then
		curl "https://bootstrap.pypa.io/get-pip.py" -o "get-pip.py"
		python get-pip.py --user
		export PATH="$PATH:$HOME/bin:/root/.local/bin"
		pip install awscli --user 
fi 

aws ec2 describe-instances --aws-access-key  $aws_access_key --aws-secret-key $aws_secret_key
aws ec2 authorize-security-group-ingress --group-name devops-sg --protocol tcp --port 22 --cidr 0.0.0.0/0
aws ec2 create-key-pair --key-name devops-key --query '<keypath>' --output text > devenv-key.pem
chmod 400 devenv-key.pem

Instance_ID=`aws ec2 run-instances --image-id ami-7d95b612 --subnet-id subnet-xxxxxxxx --security-group-ids sg-b018ced5 --count 1 --instance-type t2.micro --key-name devenv-key --query 'Instances[0].InstanceId'`
wait 60
Public_IpAddress=`aws ec2 describe-instances --instance-ids $Instance_ID --query 'Reservations[0].Instances[0].PublicIpAddress'`

ssh -i devenv-key.pem user@$Public_IpAddress 'docker pull $DOCKER_ID_USER/$new-image;docker build -t $new-prod-testing ${PWD}/Dockerfile;docker run -d -p 8089:3000 -t $new-prod-testing'



