provider "aws" {
  shared_credentials_file = "${path.root}/files/credentials"
  profile = "default"
  region = "us-east-2"
}

module "BDDS" {
  providers             = { aws = aws }
  source 		            = "./modules/bluecat_bdds"
  vm_name               = "BDDS"
  # ami_id                = "ami-08473ad4d3a27a193"  # 9.1.0 us-east-2
  ami_id                = "ami-07dd6017347739e96"  # 9.2.0 us-east-2
  instance_type         = "t2.large"
  subnet_id             = aws_subnet.main.id
  private_ip            = "10.10.1.30"
  vpc_security_group_id = aws_security_group.allow_all.id
  key_pair_name         = var.keypair
  pem_file              = var.keypair_file
  public                = true
  cloud_config          = file("./files/bdds_license.txt")
}

module "BAM" {
  providers             = { aws = aws }
  source 		            = "./modules/bluecat_bam"
  vm_name               = "BAM"
  # ami_id                = "ami-0a786e0f5243d329e"  # 9.1.0 us-east-2
  ami_id                = "ami-0df5936aade2e8704"  # 9.2.0 us-east-2
  instance_type         = "c4.xlarge"
  subnet_id             = aws_subnet.main.id
  private_ip            = "10.10.1.20"
  vpc_security_group_id = aws_security_group.allow_all.id
  key_pair_name         = var.keypair
  pem_file              = var.keypair_file
  public                = true
  cloud_config          = file("./files/bam_license.txt")
}

module "Gateway" {
  providers             = { aws = aws }
  source 		            = "./modules/bluecat_gateway"
  vm_name               = "Gateway_Server"
  ami_id                = "ami-01237fce26136c8cc"
  inst_type             = "t2.micro"
  keypair_name          = var.keypair
  pem_file              = var.keypair_file
  subnet_id             = aws_subnet.main.id
  private_ip            = "10.10.1.50"
  vpc_security_group_id = aws_security_group.allow_all.id
  public                = true
  
  bam_ip                = module.BAM.nic1_ip_address
  username              = "ubuntu"
}

module "Client" {
  providers             = { aws = aws }
  source 		            = "./modules/linux_client"
  vm_count              = 1
  vm_name               = "Test_Client"
  ami_id                = "ami-01237fce26136c8cc"
  inst_type             = "t2.micro"
  keypair_name          = var.keypair
  pem_file              = var.keypair_file
  subnet_id             = aws_subnet.main.id
  private_ip_start      = "10.10.1.10"
  vpc_security_group_id = aws_security_group.allow_all.id
  public                = true
}
