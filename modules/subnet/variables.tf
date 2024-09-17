variable "environment_name" {
  type    = string
  default = "Project001"
}

variable "name" {
  type    = string
  default = "Subnet_01"
}

variable "vpc_id" {
  type = string
}

variable "availability_zone" {
  type    = string
  default = "0"
}

variable "cidr_block" {
  type    = string
  default = "10.0.10.0/16"
}

variable "map_public_ip_on_launch" {
  type    = bool
  default = false
}
