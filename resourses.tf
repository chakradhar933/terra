resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = "IGW"
  }
}


resource "aws_eip" "ip" {
  vpc      = true
}

resource "aws_nat_gateway" "ngw" {
  allocation_id = aws_eip.ip.id
  subnet_id     = aws_subnet.pri.id

  tags = {
    Name = "NGW"
  }
}

resource "aws_route_table" "rt1" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

 tags = {
    Name = "Custom"
  }
}

resource "aws_route_table" "rt2" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.ngw.id
  }

 tags = {
    Name = "Main"
  }
}

resource "aws_route_table_association" "as_1" {
  subnet_id      = aws_subnet.Pub.id
  route_table_id = aws_route_table.rt1.id
}

resource "aws_route_table_association" "as_2" {
  subnet_id      = aws_subnet.pri.id
  route_table_id = aws_route_table.rt2.id
}
