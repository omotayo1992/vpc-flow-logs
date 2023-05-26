resource "aws_flow_log" "example" {
  count           = var.log_type == "cloudwatch" ? 1 : 0
  iam_role_arn    = aws_iam_role.example[count.index].arn
  log_destination = length(var.log_destination_arn) > 0 ? var.log_destination_arn[count.index] : aws_cloudwatch_log_group.example[count.index].arn
  traffic_type    = "ALL"
  vpc_id          = data.aws_vpc.selected.id
}

resource "aws_cloudwatch_log_group" "example" {
  count = var.log_type == "cloudwatch" && length(var.log_destination_arn) == 0 ? 1 : 0
  name  = var.aws_cloudwatch_log_group_name[count.index]
  kms_key_id = aws_kms_key.this_cloudwatch[count.index].arn 
}

resource "aws_kms_key" "this_cloudwatch" {
  count = var.log_type == "cloudwatch" && length(var.log_destination_arn) == 0 ? 1 : 0
  policy = var.policy_cloudwatch
}

resource "aws_kms_alias" "this" {
  count = var.log_type == "cloudwatch" && length(var.log_destination_arn) == 0 ? 1 : 0
  name          = var.cloudwatch_log_kms_alias
  target_key_id = aws_kms_key.this_cloudwatch[count.index].key_id
}


resource "aws_iam_role" "example" {
  count = var.log_type == "cloudwatch" ? 1 : 0
  name  = "example"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "",
      "Effect": "Allow",
      "Principal": {
        "Service": "vpc-flow-logs.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}

resource "aws_iam_role_policy" "example" {
  count = var.log_type == "cloudwatch" ? 1 : 0
  name  = "example"
  role  = aws_iam_role.example[count.index].name

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "logs:CreateLogGroup",
        "logs:CreateLogStream",
        "logs:PutLogEvents",
        "logs:DescribeLogGroups",
        "logs:DescribeLogStreams"
      ],
      "Effect": "Allow",
      "Resource": "*"
    }
  ]
}
EOF
}


resource "aws_flow_log" "example_s3" {
  count                = var.log_type == "s3" ? 1 : 0
  log_destination      = length(var.log_destination_arn) > 0 ? var.log_destination_arn[count.index] : aws_s3_bucket.example[count.index].arn
  log_destination_type = "s3"
  traffic_type         = "ALL"
  vpc_id               = data.aws_vpc.selected.id
}

resource "aws_s3_bucket" "example" {
  count  = var.log_type == "s3"  && length(var.log_destination_arn) == 0 ?  1 : 0 
  bucket = var.bucket_name
}



resource "aws_kms_key" "mykey" {
  count  = var.log_type == "s3"  && length(var.log_destination_arn) == 0 ?  1 : 0 
  policy = var.policy_s3
  }

resource "aws_kms_alias" "this_s3" {
  count  = var.log_type == "s3"  && length(var.log_destination_arn) == 0 ?  1 : 0 
  name          = var.s3_log_kms_alias
  target_key_id = aws_kms_key.mykey[count.index].key_id
}


resource "aws_s3_bucket_server_side_encryption_configuration" "example" {
  count  = var.log_type == "s3"  && length(var.log_destination_arn) == 0 ?  1 : 0 
  bucket = aws_s3_bucket.example[count.index].id

  rule {
    apply_server_side_encryption_by_default {
      kms_master_key_id = aws_kms_key.mykey[count.index].key_id
      sse_algorithm     = "aws:kms"
    }
  }
}
