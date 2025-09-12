variable "region" {
  description = "AWS region to deploy resources"
  type        = string
  default     = "us-east-2"
}

variable "name" {
  type        = string
  description = "Name prefix for resources"
  default     = "lesson-7"
}
