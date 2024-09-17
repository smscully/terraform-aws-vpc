variable "environment_name" {
  type    = string
  default = "Project001"
}

variable "name" {
  type = string
}

variable "vpc_id" {
  type = string
}

variable "cidr_block" {
  type    = string
  default = "0.0.0.0/0"
}

variable "gateway_id" {
  type = string
}

variable "nat_gateway_id" {
  type = string
}

variable "subnet_id" {
  type = string
}
