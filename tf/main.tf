resource "aws_instance" "node_box" {
  instance_type               = "t2.micro"
  ami                         = "ami-ebd02392"
  availability_zone           = "eu-west-1a"
  key_name                    = "pipeline-ecs"
  associate_public_ip_address = false
  key_name                    = "${var.key_name}"
  vpc_security_group_ids      = ["${aws_security_group.web_server.id}"]
  subnet_id                   = "${data.terraform_remote_state.infrastructure.private_subnet_ids[0]}"
  user_data                   = "${data.template_file.user_data.rendered}"

  tags = {
    Name       = "AppBoxNode1"
    ServerRole = "WebServer"
  }

  iam_instance_profile = "${aws_iam_instance_profile.app.name}"
}

data "template_file" "user_data" {
  template = "${file("${path.module}/templates/userdata.tpl")}"
}
