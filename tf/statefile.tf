terraform {
  backend "s3" {
    region     = "eu-west-1"
    bucket     = "alan.planet9.statefiles-pipeline-v2"
    key        = "tf_statefiles/hello-world/dev.tfstate"
    acl        = "private"
    encrypt    = true
    lock_table = "alan.planet9.statefiles-pipeline-v2-lock"
  }
}

# Setup the region here
provider "aws" {
  region = "${var.region}"
}

# We want the account ID in the statefile for other resources
data "aws_caller_identity" "current" {}
