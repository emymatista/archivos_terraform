terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

resource "aws_s3_bucket" "bucket" {
  bucket = "emyma2"

  tags = {
    Name = "My bucket"
  }
}

/*
resource "aws_s3_object" "file" {
  bucket = aws_s3_bucket.bucket.id
  key    = "index.html"
  source = "C:/Users/emyma/OneDrive/Documentos/web_practices/Vue.js/frontend_project/dist/index.html"
}
*/

resource "aws_s3_object" "example" {
  for_each = fileset("C:/Users/emyma/OneDrive/Documentos/web_practices/Vue.js/frontend_project/dist", "**")

  bucket = "emyma2"
  key    = each.key
  source = "C:/Users/emyma/OneDrive/Documentos/web_practices/Vue.js/frontend_project/dist/${each.key}"

  etag = filemd5("C:/Users/emyma/OneDrive/Documentos/web_practices/Vue.js/frontend_project/dist/${each.key}")
}

resource "aws_s3_bucket_public_access_block" "example" {
  bucket = aws_s3_bucket.bucket.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}
