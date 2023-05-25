module "vpc_flow_logs" {
  source                        = "../vpc_flowlogs"
  log_type                      = "cloudwatch"
  log_destination_arn           = []
  bucket_name                   = [""]
  aws_cloudwatch_log_group_name = var.aws_cloudwatch_log_group_name
  cloudwatch_log_kms_alias      = "alias/cloudwatch_vpc_log" 
  s3_log_kms_alias              = "alias/s3_vpc_log"
  policy_cloudwatch = templatefile("${path.module}/cloudwatch_kms_policy.json",
    {
      account_num = data.aws_caller_identity.current.account_id
    
    }, )

  policy_s3 = templatefile("${path.module}/s3_kms_policy.json",
    {
      account_num = data.aws_caller_identity.current.account_id
  }, )
}





