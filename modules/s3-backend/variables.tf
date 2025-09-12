variable "bucket_name" {
  type        = string
  description = "S3 bucket for Terraform state"
}

variable "region" {
  type        = string
  description = "AWS region"
}

variable "dynamodb_table" {
  type        = string
  description = "DynamoDB table name for TF locks"
}
