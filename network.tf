resource "aws_vpc" "test_vpc" {
    cidr_block = "10.2.0.0/16"

    tags = {
        Name = "test_vpc"
        dev = "true"
    }
}

resource "aws_subnet" "test_subnet" {
    vpc_id = aws_vpc.test_vpc.id
    cidr_block = "10.2.1.0/24"
    availability_zone = "ap-south-1a"
    map_public_ip_on_launch = true

    tags = {
      Name = "test_subnet"
      dev = "true"
    }
}

resource "aws_network_interface" "test_primary_nic" {
  subnet_id = aws_subnet.test_subnet.id
  security_groups = [aws_security_group.public_access_sg.id]
  

  tags = {
    Name = "primary nic"
    dev = "true"
  }
}

resource "aws_security_group" "public_access_sg" {
  name = "test_sg"
  description = "Allows full access"
  vpc_id = aws_vpc.test_vpc.id

  tags = {
    Name = "test_sg"
    dev = "true"
  }
}

resource "aws_security_group_rule" "allow_all_inbound" {
  security_group_id = aws_security_group.public_access_sg.id
  from_port = 0
  to_port = 0
  cidr_blocks = ["0.0.0.0/0"]
  protocol = "-1"
  type = "ingress"
}

resource "aws_security_group_rule" "allow_all_outbound" {
  security_group_id = aws_security_group.public_access_sg.id
  from_port = 22
  to_port = 22
  cidr_blocks = ["0.0.0.0/0"]
  protocol = "-1"
  type = "egress"
}

resource "aws_internet_gateway" "test_igw" {
  vpc_id = aws_vpc.test_vpc.id

  tags = {
    Name = "test_igw"
    dev = "true"
  }
}

resource "aws_route_table" "test_route_table" {
  vpc_id = aws_vpc.test_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.test_igw.id
  }
}

resource "aws_route_table_association" "test_rt_association" {
  subnet_id = aws_subnet.test_subnet.id
  route_table_id = aws_route_table.test_route_table.id
}