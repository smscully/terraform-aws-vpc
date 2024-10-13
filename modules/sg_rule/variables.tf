variable "security_group_id" {
  type = string
}

variable "cidr_ipv4" {
  type    = string
  default = null
}

variable "referenced_security_group_id" {
  type    = string
  default = null
}

variable "from_port" {
  type = string
}

variable "to_port" {
  type = string
}

variable "ip_protocol" {
  type = string
}

variable "ingress" {
  type    = bool
  default = false
}

variable "egress" {
  type    = bool
  default = false
}
