#!/bin/bash

echo "Write aws region for deployment..."
read aws_region

if [[ ${aws_region} != *-*-[1-9] ]]
  then
    echo " Please write valid aws region!!!"
    exit 1
fi

cd ./packer/

packer build -var "region=${aws_region}" superMarioImageTemplate.json
if [[ $? != 0 ]]
  then
    echo "Something wrong while executing packer build, now exiting..."
    exit 1
fi

cd ../terraform/

terraform init -var "aws_region=${aws_region}"
if [[ $? != 0 ]]
  then
    echo "Something wrong while executing terraform init, now exiting..."
    exit 1
fi

terraform plan -var "aws_region=${aws_region}"
if [[ $? != 0 ]]
  then
    echo "Something wrong while executing terraform plan, now exiting..."
    exit 1
fi
terraform apply -auto-approve -var "aws_region=${aws_region}"