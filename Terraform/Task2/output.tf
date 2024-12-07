output "bucket_name" {
  value = aws_s3_bucket.bucket.bucket
  description = "The name of the S3 bucket"
}

output "bucket_arn" {
  value = aws_s3_bucket.bucket.arn
  description = "The ARN of the S3 bucket"
}

output "Policy_Attached" {
  description = "Policy attached to user"
  value = data.aws_iam_policy_document.iam_policy.json
}
output "user_arn" {
  description = "Policy attached to user"
  value = aws_iam_user.user_task.arn
}
