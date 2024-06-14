resource "aws_vpc" "vpc1" {
  cidr_block = var.aws_vpc_cidr
  tags = { 
    Name = "terraform-vpc"
  }
}

resource "aws_subnet" "subnet1" {
  vpc_id = aws_vpc.vpc1.id 
  cidr_block = var.aws_subnet_network[0]
  availability_zone = "ap-south-1a"
  tags = { 
    Name = "terraform-subnet-1"
  }

}

resource "aws_subnet" "subnet2" {
  vpc_id = aws_vpc.vpc1.id 
  cidr_block = var.aws_subnet_network[1]
  availability_zone = "ap-south-1b"
  tags = { 
    Name = "terraform-subnet-2"
  }

}

resource "aws_internet_gateway" "igw" {
   vpc_id = aws_vpc.vpc1.id 
   tags = { 
    Name = "terraform-igw"
   }
}

resource "aws_route_table" "public-rt" {
  vpc_id = aws_vpc.vpc1.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
tags = {
    Name = "terraform-route-public"
}
}

resource "aws_route_table_association" "subnet1assosiate" {
  subnet_id      = aws_subnet.subnet1.id
  route_table_id = aws_route_table.public-rt.id
}