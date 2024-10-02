terraform {
  required_version = ">= 1.0.0"

  required_providers {
    local = {
      source = "hashicorp/local"
      version = "2.5.2"
    }
  }

  backend "local" {
    path = "state/terraform.tfstate"
  }
}

variable "string" {
  type = string
  description = "var String"
  default = "default string"
}

variable "number" {
  type = number
  description = "var Number"
  default = 123
}

variable "boolean" {
  type = bool
  description = "var Bool"
  default = true
}

variable "list" {
  default = [
    "a",
    "b",
    "c"
  ]
}

output "list_index_0" {
  value = var.list.0
}

output "list_all" {
  value = [
    for v in var.list:
         upper(v)
  ]
}

variable "map" {
  default = {
    key1 = 1
    key2 = 2
  }
}

variable "set" {
  type = set(string)
  default = [
      "a",
      "b",
      "c"
  ]
}

variable "object" {
  type = object({name=string, age=number})
  default = {
    name = "John"
    age = 30
  }
}

variable "tuple" {
  type = tuple([string, number, bool])
  default = ["John", 30, false]
}

variable "ingress_rules" {
  type = list(object({
    port = number,
    description = optional(string),
    protocol = optional(string, "tcp")
  }))

  default = [
    {
      port = 80
      description = "HTTP"
    },
    {
      port = 443
      description = "HTTPS"
    },
    {
      port = 53,
      protocol = "udp"
    }
  ]
}

output "ingress_rules" {
  value = var.ingress_rules
}

resource "local_file" "abc" {
  content  = "lifecycle - step 5"
  filename = "${path.module}/abc.txt"
}

resource "local_file" "def" {
  content  = "456"
  filename = "${path.module}/def.txt"
}

output "step5_content" {
  value = local_file.abc.id
}