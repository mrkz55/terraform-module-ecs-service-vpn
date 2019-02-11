variable "name" {}

variable "env" {
  default = "test"
}

variable "vpc" {
  type = "map"
}

variable "alb" {
  type = "map"
}

variable "cluster" {
  type = "map"
}

variable "cw" {
  type    = "map"
  default = {}
}

variable "config" {
  type    = "map"
  default = {}
}

variable "defaults" {
  type = "map"

  default = {
    container_name   = "vpn"
    container_image  = "hwdsl2/ipsec-vpn-server"
    container_memory = 128
    container_cpu    = 128

    aws_region = "us-west-2"

    aws_route53_map_public_ip = true
    aws_route53_private_zone  = false
    aws_route53_zone          = ""
    aws_route53_record        = ""

    aws_logs_stream_prefix = "vpn"

    vpn_daemon_enable = false
  }
}
