resource "aws_internet_gateway" "WPig" {
  vpc_id = aws_vpc.wordpress_vpc

  tags = {
    Name = "WPig"
  }
}