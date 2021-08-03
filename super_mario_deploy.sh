#!/bin/bash

aws_region=$(aws configure get default.region)
if [[ $? != 0 ]]
  then
    echo "Something wrong while getting aws default region, now exiting..."
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
if [[ $? != 0 ]]
  then
    echo "Something wrong while executing terraform apply, now exiting..."
    exit 1
fi

GAME_URL=(aws elb describe-load-balancers --load-balancer-names sm-alb \
                                          --region ${aws_region} \
                                          --query LoadBalancerDescriptions[*].DNSName \
                                          --output text)
if [[ $? != 0 ]]
  then
    echo "Something wrong while getting game URL, now exiting..."
    exit 1
fi


echo "You can play Super Mario with the URL below"
echo "##########################################################"
echo "###http://${GAME_URL}###"
echo "##########################################################"
