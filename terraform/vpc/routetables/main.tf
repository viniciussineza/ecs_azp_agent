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

resource "aws_route_table" "devops_route_table" {
  vpc_id = data.aws_vpc.vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = data.aws_internet_gateway.internet_gateway.id
  }
  tags = {
    Name = "devops-public-route-table"
  }
}

resource "aws_route_table_association" "subnet_public_01" {
  route_table_id = aws_route_table.devops_route_table.id
  subnet_id      = data.aws_subnet.public_01.id
}

resource "aws_route_table_association" "subnet_public_02" {
  route_table_id = aws_route_table.devops_route_table.id
  subnet_id      = data.aws_subnet.public_02.id
}
