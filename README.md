# tf-aws-ansible-control-server
Builds EC2 instance used as an Ansible Control Server. 
The control server is in a secure teardown VPC and Subnet.

Usage is to spin up an Ansible control-server, execute some command or work on a project and then tear it down.

This is basic idea of cattle infrastructure. 

Add a `terraform.tfvars` file with the CIDR IP address of your local host from which you will connect to the remote control host. Example: `subnet_cidr_block = "XXX.12.34.XXX/32"`


*Requirements:*
* must know how to initiate, validate, plan, execute and destroy Terraform configurations.
* must know how to use Ansible basic commands, understand a best-practice of the backend structure for vars, group_vars, modules, etc.