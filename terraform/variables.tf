variable "prefix" {
  description = "project prefix"
  default = "sample"
}

variable "location" {
  description = "AWS region"
  default = "us-west-2"
}

variable "server_admin" {
  description = "Server admin user"
}

variable "ssh_key_path" {
  description = "Server admin public key"
}

variable "ami" {
  description = "AMI to use."
  type = string
  default = "ami-01f398167e3bba7a0"
}
