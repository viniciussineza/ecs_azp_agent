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

resource "aws_ecr_repository" "devops_repository" {
  name                 = "devopsecr"
  image_tag_mutability = "MUTABLE"
  tags = {
    Name = "devops-ecr"
  }
}
