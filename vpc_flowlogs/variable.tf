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

variable "policy_cloudwatch" {
  type        = string
  default     = ""
  sensitive   = true
}

variable "policy_s3" {
  type        = string
  default     = ""
  sensitive   = true
}

variable "cloudwatch_log_kms_alias" {
  default = ""
  type    = string
  description = "The display name of the alias for cloudwatch_log_kms_alias. The name must start with the word `alias` followed by a forward slash."
}

variable "s3_log_kms_alias" {
  default = ""
  type    = string
  description = "The display name of the alias cloudwatch_log_kms_alias. The name must start with the word `alias` followed by a forward slash."
}