variable "network_acl_id" {
  type    = string
}

variable "rule_number" {
  type = string
}

variable "egress" {
  type = bool
}

variable "protocol" {
  type = string
}

variable "rule_action" {
  type = string
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
