#to create a VPC (search terraform vpc aws)
resource "aws_vpc" "tf_vpc" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"
  tags = {
    Name = var.vpc_name
  }
}

#to create subnets associated with vpc
resource "aws_subnet" "private" {
  vpc_id     = aws_vpc.tf_vpc.id
  cidr_block = "10.0.0.0/24"
  tags = {
    Name = var.private_subnet_name
  }
}
resource "aws_subnet" "public" {
  vpc_id     = aws_vpc.tf_vpc.id
  cidr_block = "10.0.1.0/24"
  tags = {
    Name = var.public_subnet_name
  }
}

#to create igw and nat gw for route tables
resource "aws_internet_gateway" "igw" {
  tags = {
    Name = var.igw
  }
}
resource "aws_nat_gateway" "nat_gw" {
  connectivity_type = "private"
  subnet_id = aws_subnet.private.id
}

#to create route table for vpc
resource "aws_route_table" "private_route_table" {
  vpc_id = aws_vpc.tf_vpc.id
  route {
    cidr_block = "10.0.0.0/24"
    gateway_id = aws_nat_gateway.nat_gw.id
  }
  tags = {
    Name = var.private_route_table
  }
}
resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.tf_vpc.id
  route {
    cidr_block = "10.1.0.0/24"
    gateway_id = aws_internet_gateway.igw.id
  }
  tags = {
    Name = var.public_route_table
  }
}

#to associate subnets with route table
resource "aws_route_table_association" "private" {
  subnet_id      = aws_subnet.private.id
  route_table_id = aws_route_table.private_route_table.id
}
resource "aws_route_table_association" "public" {
  subnet_id      = aws_subnet.public.id
  route_table_id = aws_route_table.public_route_table.id
}
