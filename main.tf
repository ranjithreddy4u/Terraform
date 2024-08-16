locals {
  vpc_settings = {
    "us-west-2" = {
      vpc_cidr            = "10.0.0.0/16"
      azs                 = ["us-west-2a", "us-west-2b", "us-west-2c"]
      public_subnet_cidrs = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
      private_subnet_cidrs = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]
    }
    "us-east-1" = {
      vpc_cidr            = "10.1.0.0/16"
      azs                 = ["us-east-1a", "us-east-1b", "us-east-1c"]
      public_subnet_cidrs = ["10.1.1.0/24", "10.1.2.0/24", "10.1.3.0/24"]
      private_subnet_cidrs = ["10.1.101.0/24", "10.1.102.0/24", "10.1.103.0/24"]
    }
  }
  environment     = "dev"       # Set this to your environment, e.g., "dev", "staging", "prod"
  jira_id = "JIRA-1234"  # Replace with your actual Jira ID
  application_name="k8s_scdf" # Application Name
  
}

# Dynamically select the configuration based on the chosen region
module "vpc" {
  source            = "./modules/VPC"
  vpc_cidr          = local.vpc_settings[var.region].vpc_cidr
  vpc_name          = "${var.region}-vpc"
  azs               = local.vpc_settings[var.region].azs
  public_subnet_cidrs  = local.vpc_settings[var.region].public_subnet_cidrs
  private_subnet_cidrs = local.vpc_settings[var.region].private_subnet_cidrs
  tags = {
    Environment     = local.environment
    Jira_Id = local.jira_id
    Application_Name=local.application_name
  }
}

module "sg" {
  source = "./modules/SG"
  vpc_id = module.vpc.vpc_id
}


module "s3" {
  source            = "./modules/S3"
}

module "dynamodb" {
  source            = "./modules/DynamoDB"
}

module "iam" {
  source            = "./modules/IAM"
}

