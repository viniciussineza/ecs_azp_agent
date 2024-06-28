terraform {
  required_version = "~>1.7"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.56"
    }
  }
}

provider "aws" {
  region                   = "us-east-1"
  profile                  = "inframanager"
  shared_credentials_files = ["~/.aws/credentials"]
}

resource "aws_vpc" "vpc" {
  cidr_block = "10.1.1.0/26"
  tags = {
    Name = "devops-vpc"
  }
}

resource "aws_subnet" "public_01" {
  cidr_block = "10.1.1.0/28"
  vpc_id     = aws_vpc.vpc.id
  tags = {
    Name = "devops-public-01"
  }
}

resource "aws_subnet" "public_02" {
  cidr_block = "10.1.1.16/28"
  vpc_id     = aws_vpc.vpc.id
  tags = {
    Name = "devops-public-02"
  }
}

resource "aws_internet_gateway" "internet_gateway" {
  vpc_id = aws_vpc.vpc.id
  tags = {
    Name = "devops-igw"
  }
}
