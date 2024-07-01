#!/bin/bash

echo "Aloitetaan:"

# Define variables
REPO_URL="https://github.com/Lohkocapital/awsinit.git"
AWS_REGION="eu-west-1"
AWS_ACCESS_KEY_ID="your-access-key-id"
AWS_SECRET_ACCESS_KEY="your-secret-access-key"

echo $REPO_URL
echo $REPO_DIR
echo $AWS_REGION
echo $AWS_ACCESS_KEY_ID
echo $AWS_SECRET_ACCESS_KEY


git -v
git pull $REPO_URL
echo "GIT: Valmis"

echo "PYTHON: "
python3 pyinsert.py

echo "AWS:"
aws configure list
aws ec2 describe-instances --filters "Name=instance-state-name,Values=running" --query "Reservations[*].Instances[*].{Instance:InstanceId,Type:InstanceType,State:State.Name,Name:Tags[?Key=='Name']|[0].Value}" --output table

echo "TERRAFORM:"
terraform version

# if ! command_exists git; then
#   echo "Error: git is not installed."
#   exit 1
# fi


# terraform init
terraform apply
echo "TERRAFORM: Valmis"
aws ec2 describe-instances --filters "Name=instance-state-name,Values=running" --query "Reservations[*].Instances[*].{Instance:InstanceId,Type:InstanceType,State:State.Name,Name:Tags[?Key=='Name']|[0].Value}" --output table
echo "Loppu"
