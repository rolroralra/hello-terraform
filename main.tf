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

variable "my_password" {
  sensitive = true
}

resource "local_file" "abc" {
  content  = var.my_password
  filename = "${path.module}/abc.txt"
}

resource "local_file" "def" {
  content  = "456"
  filename = "${path.module}/def.txt"
}

output "file_id" {
  value = local_file.abc.id
}

output "file_absolute_path" {
  value = abspath(local_file.abc.filename)
}