# superMario_on_AWS
Super Mario automated deployment in AWS

**<p1>Requirements:</p1>**
* packer
* terraform
* ansible
* aws-cli

**<p1>How to deploy:</p1>**

In th main folder execute the shell script named `super_mario_deploy.sh`.

After deployment the script will return you the URL 
to play the game in your browser.

Thats all!

**<p1>How the project works</p1>**

_Packer Part :_

Packer is deploying the instance with Ubuntu image from AWS AMIs
With Ansible all necessary software are being installed on the instance,
after Super Mario docker image is being downloaded and installed on instance
Packer is finishing the job by creating image from existing instance, and
deleting all the resources that has been created.

_Terraform part:_

Terraform is taking AMI created by packer and 
creating 2 instances(master/replica) with all necessary resources
Terraform is creating ALB(application load balancer) and configuring it 
to for the 2 instances deployed earlier


