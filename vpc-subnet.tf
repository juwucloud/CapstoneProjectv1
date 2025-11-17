# Create VPC 

resource "aws_vpc" "wordpress_vpc" {
  cidr_block            = "10.0.0.0/16"
  enable_dns_support    = true
  enable_dns_hostnames  = true
  tags = {
    Name = "wordpress_vpc"
  }
}

# Create 2 Public and 2 Private Subnets for high availability

resource "aws_subnet" "public_subnet_1" {
  vpc_id                    = aws_vpc.wordpress_vpc.id
  cidr_block                = "10.0.0.0/24"
  availability_zone         = "us-west-2a"
  map_public_ip_on_launch   = true
  tags = {
    Name = "public_subnet_wordpress_1"
  }
}
resource "aws_subnet" "private_subnet_1" {
  vpc_id                    = aws_vpc.wordpress_vpc.id
  cidr_block                = "10.0.1.0/24"
  availability_zone         = "us-west-2a"
  map_public_ip_on_launch   = false
  tags = {
    Name = "private_subnet_wordpress_1"
  }
}
resource "aws_subnet" "public_subnet_2" {
  vpc_id                    = aws_vpc.wordpress_vpc.id
  cidr_block                = "10.0.2.0/24"
  availability_zone         = "us-west-2b"
  map_public_ip_on_launch   = true
  tags = {
    Name = "public_subnet_wordpress_2"
  }
}
resource "aws_subnet" "private_subnet_2" {
  vpc_id                    = aws_vpc.wordpress_vpc.id
  cidr_block                = "10.0.3.0/24"
  availability_zone         = "us-west-2b"
  map_public_ip_on_launch   = false
  tags = {
    Name = "private_subnet_wordpress_2"
  }
}