provider "aws" {}

resource "aws_instance" "ec2_instance" {
  ami = var.ami_id
  count = var.vm_count
  instance_type = var.inst_type
  key_name = var.keypair_name
  subnet_id = var.subnet_id
  private_ip = join(".", concat(slice(split(".", var.private_ip_start), 0,3), list(element(split(".", var.private_ip_start), 3) + count.index)))
  vpc_security_group_ids = [var.vpc_security_group_id]
  associate_public_ip_address = var.public
  tags = {
    Name = join("_", concat(list(var.vm_name), list(count.index + 1)))
  }
}

