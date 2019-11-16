resource "random_id" "vpn" {
  byte_length = 2
}

resource "random_id" "credentials" {
  count       = 3
  byte_length = 8
}

# ECS

resource "aws_ecs_service" "vpn" {
  name            = "vpn-${random_id.vpn.hex}"
  cluster         = "${var.cluster["id"]}"
  task_definition = "${aws_ecs_task_definition.service_task.family}"
  desired_count   = 1

  lifecycle {
    ignore_changes = ["desired_count"]
  }

  ordered_placement_strategy {
    type  = "binpack"
    field = "cpu"
  }
}

resource "aws_ecs_task_definition" "service_task" {
  family                = "vpn-${random_id.vpn.hex}"
  container_definitions = "${data.template_file.service_task.rendered}"

  volume {
    name      = "modules"
    host_path = "/lib/modules"
  }
}

data "template_file" "service_task" {
  template = "${file("${path.module}/templates/service_task.json")}"

  vars = {
    container_name   = "${lookup(var.config, "container_name", lookup(var.defaults, "container_name"))}"
    container_image  = "${lookup(var.config, "container_image", lookup(var.defaults, "container_image"))}"
    container_memory = "${lookup(var.config, "container_memory", lookup(var.defaults, "container_memory"))}"
    container_cpu    = "${lookup(var.config, "container_cpu", lookup(var.defaults, "container_cpu"))}"

    aws_region = "${lookup(var.config, "aws_region", lookup(var.defaults, "aws_region"))}"

    aws_route53_map_public_ip = "${lookup(var.config, "aws_route53_map_public_ip", lookup(var.defaults, "aws_route53_map_public_ip"))}"
    aws_route53_private_zone  = "${lookup(var.config, "aws_route53_private_zone", lookup(var.defaults, "aws_route53_private_zone"))}"
    aws_route53_zone          = "${lookup(var.config, "aws_route53_zone", lookup(var.defaults, "aws_route53_zone"))}"
    aws_route53_record        = "${lookup(var.config, "aws_route53_record", lookup(var.defaults, "aws_route53_record"))}"

    aws_logs_region        = "${lookup(var.cw, "region", lookup(var.config, "aws_region", lookup(var.defaults, "aws_region")) )}"
    aws_logs_group         = "${lookup(var.cw, "group")}"
    aws_logs_stream_prefix = "${lookup(var.config, "aws_logs_stream_prefix", lookup(var.defaults, "aws_logs_stream_prefix"))}"

    vpn_ipsec_psk = "${lookup(var.config, "vpn_ipsec_psk", random_id.credentials.0.hex)}"
    vpn_username  = "${lookup(var.config, "vpn_username", random_id.credentials.1.hex)}"
    vpn_password  = "${lookup(var.config, "vpn_password", random_id.credentials.2.hex)}"
  }
}
