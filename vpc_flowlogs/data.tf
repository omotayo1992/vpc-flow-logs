data "aws_vpc" "selected" {
  id = "vpc-0c70d80bd94d48caa"
}

data "aws_caller_identity" "current" {}