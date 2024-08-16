# Define variables for the region and other settings
variable "region" {
  description = "The AWS region to deploy resources"
  type        = string
  default     = "us-west-2"
}

variable "aws_access_key" {
  description = "AWS Access Key"
  type        = string
 
}

variable "aws_secret_key" {
  description = "AWS Secret Key"
  type        = string
}
