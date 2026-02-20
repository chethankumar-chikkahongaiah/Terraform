variable "instance_name" {
  description = "The name of the EC2 instance"
  type        = string
  default = "demo-ec2-instance"
}

variable "ami_id" {
  description = "The AMI ID to use for the EC2 instance"
  type        = string
  default     = "ami-0c55b159cbfafe1f0" # Amazon Linux 2 AMI
}

variable "instance_type" {
  description = "The instance type for the EC2 instance"
  type        = string
  default     = "t2.micro"
}

variable "key_name" {
  description = "The name of the key pair to use for SSH access"
  type        = string
  default     = "my-key-pair"
}

variable "volume_size" {
  description = "The size of the root EBS volume in GB"
  type        = number
  default     = 8
}

variable "volume_type" {
  description = "The type of the root EBS volume"
  type        = string
  default     = "gp2"
}