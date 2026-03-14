variable "cidr_block" {
    type = string
    description = "CIDR block required for VPC" 
  
}

variable "project_name" {
    type = string
    description = "Project name"
  
}

variable "aws_security_group_name" {
    type = string
    description = "VPC SG name"
  
}