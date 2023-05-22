variable "log_type" {
  default = "s3"
  type    = string
}



variable "log_destination_arn" {
  default = []
  type    = list(string)
}



variable "bucket_name" {
  default = ["test-flowlogs-bucket-199923838"]
  type    = list(string)
}


variable "aws_cloudwatch_log_group_name" {
  default = ["vpc_flow_log"]
  type    = list(string)
}