locals {
  subnet_cidrs = cidrsubnets(aws_vpc.my-vpc.cidr_block, 8, 8, 8, 8)
  public_subnets = {
    public_subnet_1 = {
        cidr = local.subnet_cidrs[0]
        az = "ap-south-2a"
    }

    public_subnet_2 = {
        cidr = local.subnet_cidrs[1]
        az = "ap-south-2b"
    }
  }

  private_subnets = {
    private_subnet_1 = {
        cidr = local.subnet_cidrs[2]
        az = "ap-south-2a"
    }

    private_subnet_2 = {
        cidr = local.subnet_cidrs[3]
        az = "ap-south-2b"
    }
  }
}

#VPC
resource "aws_vpc" "my-vpc" {
    cidr_block = var.cidr_block

    enable_dns_support = true
    enable_dns_hostnames = true
  
}

# Public subnet

resource "aws_subnet" "Public" {
    for_each = local.public_subnets
    vpc_id = aws_vpc.my-vpc.id
    cidr_block = each.value.cidr
    availability_zone = each.value.az

    tags = {
      Name = var.project_name
    }
}

#Private Subnet

resource "aws_subnet" "private" {
    for_each = local.private_subnets
    vpc_id = aws_vpc.my-vpc.id
    cidr_block = each.value.cidr
    availability_zone = each.value.az

    tags = {
        Name = var.project_name
    }
}


#Internet GateWay

resource "aws_internet_gateway" "my_igw" {
    vpc_id = aws_vpc.my-vpc.id

    tags = {
        Name = var.project_name
    }
}


#Nat Gateway

resource "aws_eip" "my_eip" {
    for_each = local.public_subnets
    domain = "vpc"
}

resource "aws_nat_gateway" "my_nat_gw" {
    for_each = aws_subnet.Public

    allocation_id = aws_eip.my_eip[each.key].id
    subnet_id = each.value.id

    tags = {
        Name = var.project_name
    }
}

# Route Table
resource "aws_route_table" "public_route_table" {
    for_each = aws_subnet.Public
    vpc_id = aws_vpc.my-vpc.id
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.my_igw.vpc_id
    }
}

resource "aws_route_table" "private_route_table" {
    for_each = aws_subnet.private
    vpc_id = aws_vpc.my-vpc.id
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_nat_gateway.my_nat_gw.id
    }  
}

resource "aws_route_table_association" "public_RTA" {
    for_each = aws_subnet.Public
    subnet_id = each.value.id
    route_table_id = aws_route_table.public_RTA[each.key].id
}

resource "aws_route_table_association" "private_RTA" {
    for_each = aws_subnet.private
    subnet_id = each.value.id
    route_table_id = aws_route_table.private_RTA[each_keyc].id
}


# Security Group
resource "aws_security_group" "vpc_sg" {
    vpc_id = aws_vpc.my-vpc.id
    name = var.aws_security_group_name

    ingress {
        from_port = 80
        to_port = 80
        protocol = "HTTP"
        cidr_blocks = ["0.0.0.0/0"]
    }

    ingress {
        from_port = 443
        to_port = 443
        protocol = "HTTPS"
        cidr_blocks = ["0.0.0.0/0"]
    }

    egress {
        from_port = 0
        to_port = 0
        protocol = -1
        cidr_blocks = ["0.0.0.0/0"]
    }
}
