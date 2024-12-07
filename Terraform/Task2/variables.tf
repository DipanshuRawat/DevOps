variable "region" {
  type        = string
  default     = "us-east-1"
  description = "enter the region name"
}
variable "bucket_name" {
  type        = string
  default     = "batch28-task2-buckets3"
  description = "enter your bucket name"
}
variable "tag_name" {
  type        = string
  default     = "aayush"
  description = "enter your bucket tag name"
}
variable "env_name" {
  type        = string
  default     = "testing"
  description = "enter your bucket Environment name"
}
variable "status" {
  type        = string
  default     = "Enabled"
  description = "description"
}
variable "iam_user_name" {
  type    = string
  default = "ninja"
  description = "Name of the IAM user"
}
variable "policy" {
  type    = list(string)
  default = ["s3:ListBucket", "s3:GetObject", "s3:PutObject"]
  description = "IAM user policy"
}
variable "policy_name" {
  type    = string
  default = "customuserpolicy"
  description = "policy name"
}
