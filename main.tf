provider "aws" {
  region = var.aws_region
}

# Define VPC
resource "aws_vpc" "primary_vpc" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "Primary VPC"
  }
}

# Define Subnets within the VPC
resource "aws_subnet" "primary_subnet" {
  count                   = 2
  vpc_id                  = aws_vpc.primary_vpc.id
  cidr_block              = "10.0.${count.index}.0/24"
  availability_zone       = element(data.aws_availability_zones.available.names, count.index)
  map_public_ip_on_launch = true

  tags = {
    Name = "Primary Subnet ${count.index + 1}"
  }
}

# Data source for availability zones
data "aws_availability_zones" "available" {}
