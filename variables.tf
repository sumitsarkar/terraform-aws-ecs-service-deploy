variable "region" {
  default = "eu-west-1"
}

variable "environment" {
  description = "Name of the environment."
}

variable "vpc_id" {
  default = "ID of the AWS VPC"
}

variable "service_name" {
  default = "Name of the service."
}

variable "cluster_name" {
  default = "Name of the AWS ECS Cluster"
}

variable "alb_listener_rule_arns" {
  default     = []
  type        = "list"
  description = "List of the Listener ARNS from an ALB"
}

variable "rule_type" {
  description = "Must be one of path-pattern for path based routing or host-header for host based routing.."
}

variable "rule_value" {
  default = "The path pattern or host header pattern to match."
}

variable "rule_priority" {
  default = "Priority of the rule."
}

# Scaling related variables
variable "min_count" {
  default     = 1
  description = "Minimum number of tasks that should be running in the service."
}

variable "max_count" {
  default     = 3
  description = "Maximum number of tasks that can run in the service."
}

variable "desired_count" {
  default     = 2
  description = "Number of instances of tasks that should be running in the service."
}

variable "healthy_threshold" {
  default     = 3
  description = "Number of times the healthcheck should pass to mark the task as Healthy."
}

variable "healthcheck_interval" {
  default     = "30"
  description = "Number of seconds after which the ALB should query for the health of the service."
}

variable "healthcheck_protocol" {
  default = "HTTP"
}

variable "health_check_path" {
  description = "The path the ALB should query to check the health status."
}

variable "service_port" {
  description = "Port that is exposed on the container."
}

variable "cpu" {
  description = "Number of CPU units to assign to this task."
}

variable "memory" {
  description = "Memory in MegaBytes to assign to this task."
}

variable "log_group" {
  description = "Name of the Cloudwatch log group to which tasks will write logs to."
}

variable "image_url" {
  description = "URL to the image. or <FAMILY>:<TAG>"
}
