# create local private key 
resource "tls_private_key" "wp_ssh" {
    algorithm = "RSA"
    rsa_bits  = 4096
}

# public key to aws
resource "aws_key_pair" "wp_key" {
    key_name   = "wp_key"
    public_key = tls_private_key.wp_ssh.public_key_openssh
}

# safe private key locally 
resource "local_file" "wp_private_key" {
    filename = pathexpand("~/Downloads/wp_key.pem")
    content  = tls_private_key.wp_ssh.private_key_pem
    file_permission = "0400"
}