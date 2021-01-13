variable "vm_name" {}
variable "vm_count" { default = 1 }
variable "ami_id" {}
variable "inst_type" {}
variable "keypair_name" {}
variable "subnet_id" {}
variable "private_ip_start" { description = "Enter the private IP of the first instance.\nAll subsequent instances will increment this address."}
variable "vpc_security_group_id" {}
variable "pem_file" {}
variable "public" { default = false }
