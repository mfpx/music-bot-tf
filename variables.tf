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

variable "token" {
  description = "Bot token"
  type        = string
}

variable "permissions" {
  description = "Bot permissions"
  type        = string
}

variable "application_id" {
  description = "Bot application id"
  type        = string
}

variable "client_id" {
  description = "Bot client id"
  type        = string
}