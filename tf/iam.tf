/* terraform base policy */
resource "aws_iam_role_policy" "app_policy" {
  name   = "app-base-policy"
  policy = "${file("${path.module}/policies/app-policy.json")}"
  role   = "${aws_iam_role.app_role.id}"
}

/**
 * IAM profile to be used in auto-scaling launch configuration.
 */
resource "aws_iam_instance_profile" "app" {
  path = "/"
  role = "${aws_iam_role.app_role.name}"
}

/* ecs iam role and policies */
resource "aws_iam_role" "app_role" {
  name               = "app-role"
  assume_role_policy = "${file("${path.module}/policies/app-role.json")}"
}
