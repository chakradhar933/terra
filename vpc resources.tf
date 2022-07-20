resource "aws_vpc" "vpc" {
  cidr_block       = "192.168.0.0/16"
  instance_tenancy = "default"
 enable_dns_support     = "true"
 enable_dns_hostnames   = "true"

  tags = {
    Name = "edstem-vpc"
  }
}

resource "aws_subnet" "Pub" {
  vpc_id     = aws_vpc.vpc.id
  cidr_block = "192.168.1.0/24"

  tags = {
    Name = "Public"
  }
}


resource "aws_subnet" "pri" {
  vpc_id     = aws_vpc.vpc.id
  cidr_block = "192.168.3.0/24"

  tags = {
    Name = "pri"
  }
}
