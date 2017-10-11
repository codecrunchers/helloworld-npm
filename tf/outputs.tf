output "app_box_private_ip" {
  value = "${aws_instance.node_box.private_ip}"
}
