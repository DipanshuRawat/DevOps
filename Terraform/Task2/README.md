Task 2-

Task-02: AWS S3 Bucket and IAM User Creation Using Terraform

Create an S3 Bucket:

Use Terraform to create an S3 bucket in AWS.

Enable versioning for the S3 bucket.

Add tags to the S3 bucket for identification and organization (e.g., Name, Environment).

Create an IAM User and Policy:

Use Terraform to create an IAM user.

Create an IAM policy that grants the IAM user the necessary permissions to access and manage the S3 bucket. This could include permissions like s3:ListBucket, s3:GetObject, s3:PutObject, etc.

Attach the created IAM policy to the IAM user.

Attach IAM User to the S3 Bucket:

Attach the IAM user to the S3 bucket by assigning the created policy to the user, allowing them to interact with the bucket based on the defined permissions.
