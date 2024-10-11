provider "aws" {
    region = "eu-central-1"
}

module "public_vpc" {
    source = "./public_vpc"
}

resource "aws_instance" "AndreasPrang" {
    ami           = var.ami_id
    instance_type = var.instance_type
}
