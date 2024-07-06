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

resource "aws_security_group" "devops_security_group" {
  name   = "devops-security-group"
  vpc_id = data.aws_vpc.vpc.id
  tags = {
    Name = "devops-security-group"
  }
}

resource "aws_security_group_rule" "ingress_01" {
  type              = "ingress"
  to_port           = 0
  from_port         = 0
  protocol          = -1
  self              = true
  security_group_id = aws_security_group.devops_security_group.id
}

resource "aws_security_group_rule" "egress" {
  type              = "egress"
  to_port           = 0
  from_port         = 0
  protocol          = -1
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.devops_security_group.id
}
