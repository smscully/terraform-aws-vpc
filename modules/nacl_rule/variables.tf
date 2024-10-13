variable "network_acl_id" {
  type = string
}

variable "rule_number" {
  type = string
}

variable "egress" {
  type    = bool
  default = false
}

variable "protocol" {
  type    = string
  default = "tcp"
}

variable "rule_action" {
  type    = string
  default = "allow"
}

variable "cidr_block" {
  type = string
}

variable "from_port" {
  type = number
}

variable "to_port" {
  type = number
}
