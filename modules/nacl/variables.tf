variable "environment_name" {
  type = string
}

variable "name" {
  type = string
}

variable "subnet_ids" {
  type = list(any)
}

variable "vpc_id" {
  type = string
}
