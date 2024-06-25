data "aws_vpc" "vpc" {
  filter {
    name   = "tags:Name"
    values = ["devops-vpc"]
  }
}

data "aws_internet_gateway" "internet_gateway" {
  filter {
    name   = "tags:Name"
    values = ["devops-igw"]
  }
}

data "aws_subnet" "public_01" {
  filter {
    name   = "tags:Name"
    values = ["devops-public-01"]
  }
}

data "aws_subnet" "public_02" {
  filter {
    name   = "tags:Name"
    values = ["devops-public-02"]
  }
}
