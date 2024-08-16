# VPC CIDR block
variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
}

# VPC name
variable "vpc_name" {
  description = "Name for the VPC"
  type        = string
}

# Public subnet CIDR blocks
variable "public_subnet_cidrs" {
  description = "List of CIDR blocks for public subnets"
  type        = list(string)
}

# Private subnet CIDR blocks
variable "private_subnet_cidrs" {
  description = "List of CIDR blocks for private subnets"
  type        = list(string)
}

# Availability Zones
variable "azs" {
  description = "List of availability zones"
  type        = list(string)
}

# Additional Tags
variable "tags" {
  description = "A map of tags to add to all resources"
  type        = map(string)
  default     = {}
}




