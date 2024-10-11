provider "aws" {
    region = "eu-central-1"
}

module "public_vpc" {
    source = "./public_vpc"
}

resource "aws_instance" "AndreasPrang" {
    ami             = var.ami_id
    instance_type   = var.instance_type
    subnet_id       = module.public_vpc.subnet_id
}
