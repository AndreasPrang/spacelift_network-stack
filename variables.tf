variable "ami_id" {
  description   = "The AMI ID to use for the instance"
  type          = string
  default       = "ami-0592c673f0b1e7665"
}

variable "instance_type" {
  description   = "The type of instance to create"
  type          = string
  default       = "t2.micro"
}