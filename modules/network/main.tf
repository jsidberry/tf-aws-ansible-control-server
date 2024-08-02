resource "aws_vpc" "ansible_vpc" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name    = "AnsibleVPC"
    project = "ansibleControlServer"
  }
}

resource "aws_subnet" "ansible_subnet" {
  vpc_id                  = aws_vpc.ansible_vpc.id
  cidr_block              = "10.0.1.0/24"
  map_public_ip_on_launch = true

  tags = {
    Name    = "AnsibleSubnet"
    project = "ansibleControlServer"
  }
}

resource "aws_internet_gateway" "ansible_gw" {
  vpc_id = aws_vpc.ansible_vpc.id

  tags = {
    Name    = "AnsibleIGW"
    project = "ansibleControlServer"
  }
}

resource "aws_route_table" "ansible_route_table" {
  vpc_id = aws_vpc.ansible_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.ansible_gw.id
  }

  tags = {
    Name    = "AnsibleRouteTable"
    project = "ansibleControlServer"
  }
}

resource "aws_route_table_association" "a" {
  subnet_id      = aws_subnet.ansible_subnet.id
  route_table_id = aws_route_table.ansible_route_table.id
}

resource "aws_security_group" "ansible_sg" {
  name        = "ansible_sg"
  description = "Security Group for Ansible Control Server"
  vpc_id      = aws_vpc.ansible_vpc.id

  ingress {
    from_port = 22
    to_port   = 22
    protocol  = "tcp"
    # cidr_blocks = ["0.0.0.0/0"]
    cidr_blocks = [var.subnet_cidr_block]
  }

  ingress {
    from_port = 3000
    to_port   = 3000
    protocol  = "tcp"
    # cidr_blocks = ["0.0.0.0/0"]
    cidr_blocks = [var.subnet_cidr_block]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name    = "AnsibleSecurityGroup"
    project = "ansibleControlServer"
  }
}
