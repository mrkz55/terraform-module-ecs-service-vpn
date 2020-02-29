variable "name" {
}

variable "env" {
  default = "test"
}

variable "vpc" {
  type = map(string)
}

variable "alb" {
  type = map(string)
}

variable "cluster" {
  type = map(string)
}

variable "cw" {
  type    = map(string)
  default = {}
}

variable "config" {
  type    = map(string)
  default = {}
}

variable "defaults" {
  type = map(string)

  default = {
    container_name            = "vpn"
    container_image           = "hwdsl2/ipsec-vpn-server"
    container_memory          = 128
    container_cpu             = 128
    aws_region                = "us-west-2"
    aws_route53_map_public_ip = true
    aws_route53_private_zone  = false
    aws_route53_zone          = ""
    aws_route53_record        = ""
    aws_logs_stream_prefix    = "vpn"
    vpn_daemon_enable         = false
  }
}

