provider "aws" {
  region  = "ap-southeast-2"
  profile = "terraform"
}

resource "aws_vpc" "Main" {
  cidr_block       = "172.100.0.0/16"
  instance_tenancy = "default"
}

resource "aws_internet_gateway" "IGW" {
  vpc_id = aws_vpc.Main.id
}

resource "aws_subnet" "publicsubnets" {
  vpc_id     = aws_vpc.Main.id
  cidr_block = "172.100.31.0/24"
}

resource "aws_route_table" "PublicRT" {
  vpc_id = aws_vpc.Main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.IGW.id
  }
}

resource "aws_route_table_association" "PublicRTassociation" {
  subnet_id      = aws_subnet.publicsubnets.id
  route_table_id = aws_route_table.PublicRT.id
}
