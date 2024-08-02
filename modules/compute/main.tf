data "aws_ami" "ubuntu" {
  most_recent = true
  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }
  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
  owners = ["099720109477"] # Canonical
}

resource "aws_instance" "ansible_control" {
  ami                         = data.aws_ami.ubuntu.id # "ami-0b8b44ec9a8f90422" 
  instance_type               = "t2.micro"
  key_name                    = "Ohio" # aws_key_pair.ansible_keypair.key_name
  subnet_id                   = var.subnet_id # aws_subnet.ansible_subnet.id
  vpc_security_group_ids      = [var.security_group] # [aws_security_group.ansible_sg.id]
  associate_public_ip_address = true

  #   root_block_device {
  #     volume_type = "gp2"
  #     volume_size = 30  // 30 GB of block storage
  #   }

  user_data = file("./install.sh")

  tags = {
    Name    = "AnsibleControlServer"
    project = "ansibleControlServer"
  }
}

resource "aws_eip" "ansible_eip" {
  instance = aws_instance.ansible_control.id
  domain   = "vpc"

  tags = {
    Name    = "AnsibleEIP"
    project = "ansibleControlServer"
  }
}

