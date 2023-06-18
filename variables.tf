variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "eu-west-2"
}

variable "container_name" {
  type = string
  description = "Container name"
  default = "lucio-bot"
}