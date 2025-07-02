resource "aws_instance" "example" {
  ami                         = data.aws_ami.amazon_linux_2.id
  instance_type               = "t2.micro"
  subnet_id                   = data.aws_subnet.default.id
  vpc_security_group_ids      = [aws_security_group.ssh.id]
  associate_public_ip_address = true

  tags = {
    Name = "example-ec2-instance"
  }wrethgtr
}

# Data source to get the latest Amazon Linux 2 AMI
# This will automatically select the latest version for the region

data "aws_ami" "amazon_linux_2" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }
}

# Data source to get the default VPC

data "aws_vpc" "default" {
  default = true
}

# Data source to get the default subnet in the default VPC (first one)

data "aws_subnet" "default" {
  default_for_az = true
  vpc_id         = data.aws_vpc.default.id
}
