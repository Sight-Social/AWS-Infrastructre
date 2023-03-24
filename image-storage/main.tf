terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }

  required_version = ">= 1.2.0"
}

provider "aws" {
  region = "us-east-1"
}

resource "aws_s3_bucket" "sight_images_348234723742" {
  bucket = "sight-image-bucket-323"

  tags = {
    Name        = "Sight Image Bucket"
    Environment = "Dev"
  }
}

resource "aws_s3_bucket_cors_configuration" "example" {
  bucket = aws_s3_bucket.sight_images_348234723742.id

  cors_rule {
    allowed_headers = ["*"]
    allowed_methods = ["PUT", "POST", "GET"]
    allowed_origins = ["https://s3-website-test.hashicorp.com", "http://localhost:3001"]
    expose_headers  = ["ETag"]
    max_age_seconds = 3000
  }

  cors_rule {
    allowed_methods = ["GET"]
    allowed_origins = ["*"]
  }
}

resource "aws_s3_bucket_acl" "example" {
  bucket = aws_s3_bucket.sight_images_348234723742.id
  acl    = "public-read"
}

resource "aws_s3_bucket_public_access_block" "example" {
  bucket = aws_s3_bucket.sight_images_348234723742.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}


resource "aws_s3_bucket_policy" "allow_public_images_read" {
  bucket = aws_s3_bucket.sight_images_348234723742.id
  policy = data.aws_iam_policy_document.allow_public_images_read.json
}

data "aws_iam_policy_document" "allow_public_images_read" {
  statement {
    principals {
      type        = "AWS"
      identifiers = ["*"]
    }

    actions = [
      "s3:GetObject",
      "s3:ListBucket",
    ]

    resources = [
      aws_s3_bucket.sight_images_348234723742.arn,
      "${aws_s3_bucket.sight_images_348234723742.arn}/*",
    ]
  }
}

