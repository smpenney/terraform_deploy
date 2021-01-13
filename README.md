# BlueCat Deployment via Terraform

## Purpose
Deploy BlueCat Address Manager, DNS/DHCP Server, Gateway, and test client to AWS instance using Terraform

## Pre-Requisites
1. Terraform must be installed on your workstation
2. You must have admin access to an AWS account
3. A license file for the BAM and BDDS must be acquired

## Usage:

1. Initialize the Terraform state by running:  `terraform init`
   * This must be done from the root of the script repository
2. In `${path.root}/variables.tf` input the names of your AWS keypair (`keypair`) and the name of the key file you have downloaded for use (`keypair_file`):
3. In `${path.root}/vpc.tf` and `${path.root}/main.tf` setup any necessary configuration parameters for your VPC, paying particular attention to:
    *  Network parameters such as `cidr_block` and `private_ip` (if using)
    *  Changes needed to security groups - the examples provided remove all restrictions on access, which is not recommended beyond basic testing
4. In the `files` folder:
   *  Update `bam_license.txt` with the license key and id you received from BlueCat
   *  Update `bdds_license.txt` with the license key and id you received from BlueCat
   *  Update `credentials` with your AWS profile credentials
5. Run `terraform plan` to see the actions Terraform will take to deploy your infrastructure.  Verify that these changes are correct before proceeding.
6. When ready to deploy, execute `terraform apply`, review the actions once again, and confirm.
7. When deployment is complete information about the envrionment created will be displayed.
    * The BAM console and Gateway console can be accessed using the public IP returned by `terraform apply`
    * Gateway will be deployed without custom workflows such as BlueCat Cloud Discovery & Visibility - please contact BlueCat for access.
8. When testing is complete execute `terraform destroy` to clean up the AWS environment

## Getting Help:
For help with any content in this repsitory please contact BlueCat via the BlueCat Labs GitHub page.