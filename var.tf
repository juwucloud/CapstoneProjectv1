variable "region_us_west_2" {
  type        = string
  description = "value for the region"
  default     = "us-west-2"
}

variable "aws_availability_zone_a" {
  type        = string
  description = "value for the availability zone"
  default     = "us-west-2a"
}

variable "aws_availability_zone_b" {
  type        = string
  description = "value for the availability zone"
  default     = "us-west-2b"
}

variable "aws_instance_type_t3micro" {
  type        = string
  description = "value for the instance type"
  default     = "t3.micro"
}

variable "webserver_ami" {
    type = string
    description = "Basic linux 2023 kernel-6.1 AMI"
    default = "ami-04f9aa2b7c7091927"
  
}

variable "instance_type" {
    type = string
    description = "t3.micro instance"
    default = "t3.micro"
  
}