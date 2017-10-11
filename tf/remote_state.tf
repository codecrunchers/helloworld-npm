data "terraform_remote_state" "infrastructure" {
  backend = "s3"

  config = {
    region = "eu-west-1"
    bucket = "alan.planet9.statefiles-pipeline-v2"
    key    = "tf_statefiles/dev.tfstate"
    acl    = "private"
  }
}
