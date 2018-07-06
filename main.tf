provider "aws" {
  region = "${var.region}"
}

module "ecs_service" {
  source                 = "git::https://github.com/sumitsarkar/terraform-aws-ecs-ec2-web-service?ref=v0.1.0-alpha"
  environment            = "${var.environment}"
  vpc_id                 = "${var.vpc_id}"
  service_name           = "${var.service_name}"
  container_name         = "${var.service_name}"
  cluster_name           = "${var.cluster_name}"
  task_definition_arn    = "${module.task_definition.task_definition_arn}"
  alb_listener_rule_arns = "${var.alb_listener_rule_arns}"
  rule_type              = "${var.rule_type}"
  rule_value             = "${var.rule_value}"
  rule_priority          = "${var.rule_priority}"

  port = "${var.service_port}"

  min_count         = "${var.min_count}"
  max_count         = "${var.max_count}"
  desired_count     = "${var.desired_count}"
  health_check_path = "${var.health_check_path}"
}

module "task_definition" {
  source        = "git::https://github.com/sumitsarkar/terraform-aws-ecs-task-definition?ref=v0.1.0-alpha"
  service_name  = "${var.service_name}"
  environment   = "${var.environment}"
  service_image = "${var.image_url}"
  cpu           = "${var.cpu}"
  memory        = "${var.memory}"
  log_group     = "${var.log_group}"
  service_port  = "${var.service_port}"
  task_role_arn = "${aws_iam_role.test_role.arn}"
}

resource "aws_cloudwatch_log_group" "service_log_group" {
  name = "${var.log_group}"
  tags {
    Environment = "${var.environment}"
    Service     = "${var.service_name}"
  }
}