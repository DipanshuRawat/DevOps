resource "aws_s3_bucket" "bucket" {
  bucket = var.bucket_name

  tags = {
    Name        = var.tag_name
    Environment = var.env_name
  }
}
resource "aws_s3_bucket_versioning" "versioning_bucket" {
  bucket = aws_s3_bucket.bucket.id
  versioning_configuration {
    status = var.status
  }
}
resource "aws_iam_user" "user_task" {
  name = var.iam_user_name
  path = "/system/"
}
resource "aws_iam_access_key" "user_task" {
  user = aws_iam_user.user_task.name
}
data "aws_iam_policy_document" "iam_policy" {
  statement {
    effect  = "Allow"
    actions = var.policy
    resources = [
      "arn:aws:s3:::${aws_s3_bucket.bucket.bucket}",
      "arn:aws:s3:::${aws_s3_bucket.bucket.bucket}/*"
    ]
  }
}
resource "aws_iam_user_policy" "iam_policy" {
  name   = var.policy_name
  user   = aws_iam_user.user_task.name
  policy = data.aws_iam_policy_document.iam_policy.json
}
