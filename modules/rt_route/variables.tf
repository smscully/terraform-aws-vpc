variable "route_table_id" {
  type = string
}

variable "destination_cidr_block" {
  type    = string
  default = "0.0.0.0/0"
}

variable "gateway_id" {
  type    = string
  default = null
}

variable "nat_gateway_id" {
  type    = string
  default = null
}
