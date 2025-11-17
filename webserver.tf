

# EC2 Webserver Instance in us-west-2a
resource "aws_instance" "WebserverInstance" {
    ami                     = var.webserver_ami
    instance_type           = var.instance_type
    availability_zone       = var.aws_availability_zone_a
    vpc_security_group_ids  = [
        aws_security_group.ssh_sg.id, 
        aws_security_group.http_sg.id
    ]
    subnet_id = aws_subnet.public_subnet_1.id

    # worpress + mariadb + php
    user_data = file("${path.module}/userdata-ec2-wordpress.sh")

    tags = {
        Name = "Wordpress_Webserver"
    }
  
}