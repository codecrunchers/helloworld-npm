data "terraform_remote_state" "infrastructure" {
  backend = "s3"

  config = {
    region = "eu-west-1"
    bucket = "my.bucket.unique.id"
    key    = "tf_statefiles/dev.tfstate"
    acl    = "private"
  }
}
