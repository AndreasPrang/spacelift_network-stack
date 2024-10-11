provider "aws" {
    region = "eu-central-1"
}

// Public VPC
resource "aws_vpc" "public_vpc" {
    cidr_block = "10.0.0.0/16"
}

resource "aws_subnet" "public_subnet" {
    vpc_id                  = aws_vpc.public_vpc.id
    cidr_block              = var.public_subnet_cidr_block
    availability_zone       = "eu-central-1a"
    map_public_ip_on_launch = true
}

resource "aws_internet_gateway" "public_gateway" {
    vpc_id = aws_vpc.public_vpc.id
}

resource "aws_route_table" "public_route_table" {
    vpc_id = aws_vpc.public_vpc.id
}

resource "aws_route" "public_route" {
    route_table_id         = aws_route_table.public_route_table.id
    destination_cidr_block = "0.0.0.0/0"
    gateway_id             = aws_internet_gateway.public_gateway.id
}

resource "aws_route_table_association" "public_subnet_association" {
    subnet_id      = aws_subnet.public_subnet.id
    route_table_id = aws_route_table.public_route_table.id
}
resource "aws_security_group" "public_sg" {
    name        = "public_sg"
    description = "Security group for public VPC"

    vpc_id = aws_vpc.public_vpc.id

    ingress {
        from_port   = 0
        to_port     = 65535
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    egress {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
}