Task 1 -

Create a VPC, 2 Availability Zone, 4 Subnets (2 public subnet and 2 private subnet) and 2 route tables.

For public subnets allow traffic from Internet, and for private subnets only ssh port should be open.

Create Security Group also for the future instances in the subnets.

This infrastructure must be created using Terraform with static code

Kindly submit this task ASAP.



terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.80.0"
    }
  }
}

provider "aws" {
    region = "us-east-1"
}

resource "aws_vpc" "vpc" {
  cidr_block       = "10.0.0.0/20"
  instance_tenancy = "default"

  tags = {
    Name = "task1"
  }
}
resource "aws_subnet" "pub-subnet1" {
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = "us-east-1a"

  tags = {
    Name = "public_sub1"
  }
}
resource "aws_subnet" "pub-subnet2" {
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = "10.0.2.0/24"
  availability_zone = "us-east-1b"

  tags = {
    Name = "public_sub2"
  }
}
resource "aws_subnet" "pvt-subnet1" {
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = "10.0.3.0/24"
  availability_zone = "us-east-1a"
  tags = {
    Name = "private_sub1"
  }
}
resource "aws_subnet" "pvt-subnet2" {
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = "10.0.4.0/24"
  availability_zone = "us-east-1b"

  tags = {
    Name = "private_sub2"
  }
}

resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = "IG_task1"
  }
}

resource "aws_route_table" "pub-RT" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }

  tags = {
    Name = "public_routeTable"
  }
}
resource "aws_route_table_association" "public_sub1" {
  subnet_id      = aws_subnet.pub-subnet1.id
  route_table_id = aws_route_table.pub-RT.id
}

resource "aws_route_table_association" "public_sub2" {
  subnet_id      = aws_subnet.pub-subnet2.id
  route_table_id = aws_route_table.pub-RT.id
}

resource "aws_nat_gateway" "NAT" {
  connectivity_type = "private"
  subnet_id         = aws_subnet.pub-subnet1.id
}

resource "aws_route_table" "pvt-RT" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.NAT.id
  }

  tags = {
    Name = "private_routeTable"
  }
}

resource "aws_route_table_association" "private_sub1" {
  subnet_id      = aws_subnet.pvt-subnet1.id
  route_table_id = aws_route_table.pvt-RT.id
}
resource "aws_route_table_association" "private_sub2" {
  subnet_id      = aws_subnet.pvt-subnet2.id
  route_table_id = aws_route_table.pvt-RT.id
}

resource "aws_security_group" "public_sg" {
  vpc_id = aws_vpc.vpc.id
  name   = "public_sg"

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "public_security_group"
  }
}

resource "aws_security_group" "private_sg" {
  vpc_id = aws_vpc.vpc.id
  name   = "private_sg"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "private_security_group"
  }
}
