# Public Route Table

resource "aws_route_table" "publicRT" {
  vpc_id = aws_vpc.wordpress_vpc.id

  route {
    cidr_block = "10.0.0.0/16"
    gateway_id = "local"
  }

    route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.WPig.id
  }

  tags = {
    Name = "publicRT"
  }
  
}

# Private Route Table

resource "aws_route_table" "priavteRT" {
  vpc_id = aws_vpc.wordpress_vpc.id

  route {
    cidr_block = "10.0.0.0/16"
    gateway_id = "local"
  }

  tags = {
    Name = "publicRT"
  }
  
}