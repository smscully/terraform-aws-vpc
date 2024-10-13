variable "environment_name" {
  type = string
}

variable "name" {
  type = string
}

variable "vpc_id" {
  type = string
}

variable "availability_zone" {
  type    = string
  default = "0"
}

variable "cidr_block" {
  type = string
}

variable "map_public_ip_on_launch" {
  type    = bool
  default = false
}
