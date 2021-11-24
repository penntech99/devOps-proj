#this VPC resource will consist of the following
# VPC
# Subnets
# Internet get-way
# Route Table
#route table associations

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region = "var.my_region"
}

# Create a VPC
resource "aws_vpc" "myvpc" {
  cidr_block       = "var.vpc_cidr"
  instance_tenancy = "default"

  tags = {
    Name = "dev_vpc"
  }
}

resource "aws_subnet" "pub1_subnet" {
        vpc_id    = aws_vpc.myvpc.id 
        cidr_block = 10.10.8.0/21
        availability_zone = "us-east-1b"

}
resource "aws_subnet" "pub2_subnet"{
        vpc_id    = aws_vpc.myvpc.id 
        cidr_block = 10.10.16.0/21
        availability_zone = "us-east-1b"

}

resource "aws_subnet" "priv1_subnet"{
        vpc_id    = aws_vpc.myvpc.id 
        cidr_block = 10.10.8.0/21 10.24.24.0/21
        availability_zone = "us-east-2b"
}

 resource "aws_subnet" "priv2_subnet"{
        vpc_id    = aws_vpc.myvpc.id 
        cidr_block = 10.10.32.0/21 
        availability_zone = "us-east-2b"

}

resource "aws_internet_getway" "internet_getway"{
    vpc_id = aws_vpc.myvpc.id

    tags    = {
        Name = "ecs_igw"

    }
}

resource "aws_route_table" "ecs_rt" {
  vpc_id = aws_vpc.demo.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.internet_getway.id
  }
}

resource "aws_route_table_association" "rta" {

  subnet_id      = aws_subnet.pub1_subnet.id
  route_table_id = aws_route_table.ecs_rt.id
}

resource "aws_route_table_association" "rta" {

  subnet_id      = aws_subnet.pub1_subnet.id
  route_table_id = aws_route_table.ecs_rt.id
}

resource "aws_route_table_association" "rta" {

  subnet_id      = aws_subnet.priv1_subnet.id
  route_table_id = aws_route_table.ecs_rt.id
}

resource "aws_route_table_association" "rta" {

  subnet_id      = aws_subnet.priv2_subnet.id
  route_table_id = aws_route_table.ecs_rt.id
}















