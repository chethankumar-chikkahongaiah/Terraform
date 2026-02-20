variable "vpc_cidr_block" {
  description = "The CIDR block for the VPC"
  type        = string
  default = "10.0.0.0/16"
}

variable "vpc_name" {
  description = "The name of the VPC"
  type        = string
  default = "my-vpc"
}

variable "project_name" {
  description = "The name of the project"
  type        = string
  default = "my-project"
}

variable "public_subnet_cidr_block" {
  description = "The CIDR block for the public subnet"
  type        = string
  default = "10.0.1.0/24"
  
}

variable "availability_zone" {
  description = "The availability zone for the public subnet"
  type        = string
  default = "us-east-1a"
}

variable "private_subnet_cidr_block" {
  description = "The CIDR block for the private subnet"
  type        = string
  default = "10.0.2.0/24"
}



