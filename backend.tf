terraform {
  backend "s3" {
    bucket         = "terraform-statefile-ranjith"
    key            = "terraform/terraform.tfstate"
    region         = "us-west-2"
    dynamodb_table = "terraform_state"
  }
}