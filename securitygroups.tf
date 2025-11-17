# SSH - Security Group
resource "aws_security_group" "ssh_sg" {
  name        = "SSH Security Group"
  vpc_id      = aws_vpc.capstone_vpc.id
  description = "Allow SSH access to EC2 instances"
}

resource "aws_vpc_security_group_ingress_rule" "ssh_sg_inbound_rule" {
  security_group_id = aws_security_group.ssh_sg.id

  cidr_ipv4   = "0.0.0.0/0"
  from_port   = 22
  ip_protocol = "tcp"
  to_port     = 22
  description = "Allow SSH access to EC2 instances"
}

resource "aws_vpc_security_group_egress_rule" "ssh_sg_outbound_rule" {
  security_group_id = aws_security_group.ssh_sg.id

  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1" # means "to all ports"
}

# HTTP - Security Group
resource "aws_security_group" "http_sg" {
  name        = "HTTP Security Group"
  vpc_id      = aws_vpc.capstone_vpc.id
  description = "Allow HTTP access to EC2 instances"
}

resource "aws_vpc_security_group_ingress_rule" "http_sg_inbound_rule" {
  security_group_id = aws_security_group.http_sg.id

  cidr_ipv4   = "0.0.0.0/0"
  from_port   = 80
  ip_protocol = "tcp"
  to_port     = 80
  description = "Allow HTTP access to EC2 instances"
}

resource "aws_vpc_security_group_egress_rule" "http_sg_outbound_rule" {
  security_group_id = aws_security_group.http_sg.id

  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1" # means "to all ports"
}
