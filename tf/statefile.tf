terraform {
  backend "s3" {
    region     = "eu-west-1"
    bucket     = "my.bucket.unique.id"
    key        = "tf_statefiles/hello-world/dev.tfstate"
    acl        = "private"
    encrypt    = true
    lock_table = "my.bucket.unique.id-lock"
  }
}

# Setup the region here
provider "aws" {
  region = "${var.region}"
}

# We want the account ID in the statefile for other resources
data "aws_caller_identity" "current" {}
