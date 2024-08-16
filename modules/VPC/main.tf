# Create the VPC
resource "aws_vpc" "main" {
  cidr_block           = var.vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags = merge({
    Name = var.vpc_name
  }, var.tags)
}

# Create an Internet Gateway
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id

  tags = merge({
    Name = "${var.vpc_name}-igw"
  }, var.tags)
}

# Create Elastic IP for the NAT Gateway
resource "aws_eip" "nat" {
  tags = merge({
    Name = "${var.vpc_name}-eip"
  }, var.tags)
}

# Create a  NAT Gateway
resource "aws_nat_gateway" "nat" {
  allocation_id = aws_eip.nat.id
  subnet_id     = aws_subnet.public[0].id  # Use the first public subnet

  tags = merge({
    Name = "${var.vpc_name}-nat"
  }, var.tags)
  
}

# Create public subnets in each availability zone
resource "aws_subnet" "public" {
  count = length(var.azs)

  vpc_id            = aws_vpc.main.id
  cidr_block        = var.public_subnet_cidrs[count.index]
  availability_zone = var.azs[count.index]
  map_public_ip_on_launch = true

  tags = merge({
    Name = "${var.vpc_name}-public-subnet-${count.index + 1}"
  }, var.tags)
}

# Create private subnets in each availability zone
resource "aws_subnet" "private" {
  count = length(var.azs)

  vpc_id            = aws_vpc.main.id
  cidr_block        = var.private_subnet_cidrs[count.index]
  availability_zone = var.azs[count.index]

  tags = merge({
    Name = "${var.vpc_name}-private-subnet-${count.index + 1}"
  }, var.tags)
}

# Create a public route table
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = merge({
    Name = "${var.vpc_name}-public-rt"
  }, var.tags)
}

# Associate public subnets with the public route table
resource "aws_route_table_association" "public" {
  count = length(aws_subnet.public)

  subnet_id      = aws_subnet.public[count.index].id
  route_table_id = aws_route_table.public.id
}

# Create a private route table
resource "aws_route_table" "private" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat.id
  }

  tags = merge({
    Name = "${var.vpc_name}-private-rt"
  }, var.tags)
}

# Associate private subnets with the private route table
resource "aws_route_table_association" "private" {
  count = length(aws_subnet.private)

  subnet_id      = aws_subnet.private[count.index].id
  route_table_id = aws_route_table.private.id
}
