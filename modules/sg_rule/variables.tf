variable "security_group_id" {
  type = string
}

variable "cidr_ipv4" {
  type    = string
  default = "Project001"
}

variable "referenced_security_group_id" {
  type = string
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
  type = bool
}

variable "egress" {
  type = bool
}
