resource "aws_key_pair" "my_key_pair" {
  key_name   = var.key_name
  public_key = file("/home/my-key-pair.pub")
  
}


resource "aws_instance" "my_instance" {
  ami           = var.ami_id
  instance_type = var.instance_type
  subnet_id = var.aws_subnet.private_subnet.id
  key_name = var.key_name
  #allocate_public_ip = false
  security_groups = [aws_security_group.my_security_group.id]
  root_block_device {
    volume_size = var.volume_size
    volume_type = var.volume_type
  }

  tags = {
    Name = var.instance_name
  }
}


