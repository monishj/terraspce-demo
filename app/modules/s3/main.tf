module "s3_bucket" {
  source = "terraform-aws-modules/s3-bucket/aws"

  bucket = var.bucket_name
  acl    = var.acl

  control_object_ownership = var.control_object_ownership
  object_ownership         = var.object_ownership

  versioning = {
    enabled = var.versioning
  }

  lifecycle_rule = [
    {
      id      = "test-lifecycle-rule"
      enabled = var.lifecycle_enable
      prefix  = "logs/"

      transitions = [
        {
          days          = 30
          storage_class = "STANDARD_IA"
        }
      ]

      expiration = {
        days = 365
      }
    }
  ]
}


# resource "aws_s3_bucket_lifecycle_configuration" "example" {
#   bucket = module.s3_bucket.s3_bucket_id

#   rule {
#     id      = "example-lifecycle-rule"
#     enabled = var.lifecycle_enable

#     transition {
#       days          = 30
#       storage_class = "STANDARD_IA"
#     }

#     transition {
#       days          = 60
#       storage_class = "GLACIER"
#     }
#     expiration {
#       days = 90
#     }
#   }
# }