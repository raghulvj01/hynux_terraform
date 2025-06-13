provider "aws" {
  region = var.aws_region
}

# 🔑 Upload local public key to AWS
resource "aws_key_pair" "hynux_key" {
  key_name   = var.key_pair_name
  public_key = file("${path.module}/${var.public_key_file}")
}

# 🔍 Get latest Debian 12 AMI
data "aws_ami" "debian" {
  most_recent = true

  filter {
    name   = "name"
    values = ["debian-12-amd64-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["136693071363"]  # Debian official AMI publisher
}

# 🌐 Create Security Group allowing SSH
resource "aws_security_group" "hynux_sg" {
  name        = "hynux-sg"
  description = "Allow SSH inbound"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # You may restrict this
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# 🔍 Default subnet
data "aws_subnet" "default" {
  default_for_az = true
  availability_zone = "${var.aws_region}a"
}

# 🖥️ Create EC2 instance
resource "aws_instance" "hynux" {
  ami                         = data.aws_ami.debian.id
  instance_type               = var.instance_type
  subnet_id                   = data.aws_subnet.default.id
  vpc_security_group_ids      = [aws_security_group.hynux_sg.id]
  key_name                    = aws_key_pair.hynux_key.key_name
  associate_public_ip_address = true

  root_block_device {
    volume_size = 20
    volume_type = "gp3"
  }

  tags = {
    Name = "hynux"
  }
}
