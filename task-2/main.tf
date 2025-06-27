resource "aws_vpc" "main_vpc" {
  cidr_block = var.main_cidr_block

  tags = {
    Name = "main_vpc"
  }
}

resource "aws_subnet" "public_subnet_A" {
  vpc_id            = aws_vpc.main_vpc.id
  count = length(var.public_subnet_A_cidr)
  cidr_block = var.public_subnet_A_cidr[count.index]
  availability_zone       = var.availability_zone["eu-north-1a"]
}

resource "aws_subnet" "public_subnet_B" {
  vpc_id = aws_vpc.main_vpc.id
  count = length(var.public_subnet_B_cidr)
  cidr_block = var.public_subnet_B_cidr[count.index]
  availability_zone = var.availability_zone["eu-north-1b"]
}

resource "aws_internet_gateway" "gateway" {
    vpc_id = aws_vpc.main_vpc.id
}

resource "aws_route_table" "route_table" {
    vpc_id = aws_vpc.main_vpc.id

    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.gateway.id
    }
}

resource "aws_route_table_association" "public_subnet_A_association" {
    count = length(aws_subnet.public_subnet_A)
    subnet_id      = aws_subnet.public_subnet_A[count.index].id
    route_table_id = aws_route_table.route_table.id
}

resource "aws_route_table_association" "public_subnet_B_association" {
    count          = length(aws_subnet.public_subnet_B)
    subnet_id      = aws_subnet.public_subnet_B[count.index].id
    route_table_id = aws_route_table.route_table.id
}
