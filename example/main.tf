module "vpc_flow_logs" {
  source = "../vpc_flowlogs"
  log_type = "cloudwatch"
  log_destination_arn = []
  bucket_name = [""]
  aws_cloudwatch_log_group_name = ["aws_cloudwatch_log_group_name"]
}