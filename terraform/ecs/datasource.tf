data "aws_iam_role" "ecs_role" {
  name = "ecsTaskExecutionRole"
}

data "aws_ecr_repository" "devopsecr" {
  name = "devopsecr"
}

data "aws_ecr_image" "azpagent" {
  repository_name = data.aws_ecr_repository.devopsecr.name
  image_tag       = "azpagent0.1"
}

data "aws_subnet" "public_subnet_01" {
  filter {
    name = "tag:Name"
    values = ["devops-public-01"]
  }
}

data "aws_subnet" "public_subnet_02" {
  filter {
    name = "tag:Name"
    values = ["devops-public-02"]
  }
}

data "aws_security_group" "devops_security_group" {
  name = "devops-security-group"
}
