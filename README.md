# tf-aws-ansible-control-server
Builds EC2 instance used as an Ansible Control Server. 
The control server is in a secure teardown VPC and Subnet.

Usage is to spin up an Ansible control-server, execute some command or work on a project and then tear it down.
This is basic idea of cattle infrastructure. 
