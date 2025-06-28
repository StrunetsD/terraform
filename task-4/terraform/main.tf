resource "aws_vpc" "main_vpc_task4" {
    cidr_block = var.cidr_block_vpc

    tags = {
        Name = var.vpc_name
    }
}

resource "aws_subnet" "main_public_subnet_task4" {
    vpc_id            = aws_vpc.main_vpc_task4.id
    cidr_block        = var.public_subnet_A_cidr
    availability_zone = var.availability_zone["az1"]
    map_public_ip_on_launch = true
}

resource "aws_internet_gateway" "main_internet_gateway_task4" {
    vpc_id = aws_vpc.main_vpc_task4.id
}

resource "aws_route_table" "main_route_table_task4" {
    vpc_id = aws_vpc.main_vpc_task4.id
}

resource "aws_route" "main_route_task4" {   
    route_table_id         = aws_route_table.main_route_table_task4.id
    destination_cidr_block = var.destination_cidr_block
    gateway_id = aws_internet_gateway.main_internet_gateway_task4.id
}
resource "aws_route_table_association" "main_route_table_association_task4" {
    subnet_id      = aws_subnet.main_public_subnet_task4.id
    route_table_id         = aws_route_table.main_route_table_task4.id
}

resource "aws_security_group" "security_group" {
    name        = var.security_group_name
    description = "Main security group for the VPC"
    vpc_id      = aws_vpc.main_vpc_task4.id
    
    ingress {
        description = "SSH from VPC"
        from_port   = var.from_port_security_group
        to_port     = var.to_port_security_group
        protocol    = var.protocol_security_group
        cidr_blocks = var.cidr_blocks_security_group
    }

    ingress {
        description = "HTTP from VPC"
        from_port   = var.from_port_http_security_group
        to_port     = var.to_port_http_security_group
        protocol    = var.protocol_http_security_group
        cidr_blocks = var.cidr_blocks_http_security_group
    }

    egress {
        description = "Allow all outbound traffic"
        from_port   = var.from_port_outbound_security_group
        to_port     = var.to_port_outbound_security_group
        protocol    = var.protocol_outbound_security_group
        cidr_blocks = var.cidr_blocks_outbound_security_group
    }

    tags = {
        Name = var.security_group_name
    }
}


resource "aws_key_pair" "ansible_key_task4" {
  key_name   = "ansible_key_task4" 
  public_key = file("~/.ssh/id_rsa.pub") 
}

resource "aws_instance" "web_server" {
    ami          = data.aws_ami.amazon_linux_2023.id
    instance_type = "t3.micro"
    subnet_id = aws_subnet.main_public_subnet_task4.id  
    vpc_security_group_ids = [aws_security_group.security_group.id]
    key_name = aws_key_pair.ansible_key_task4.key_name

    tags = {
      Name = "web-server"
      Role = "nginx"
    }
}