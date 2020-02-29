output "output_map" {
  value = {
    container_name = lookup(var.config, "container_name", var.defaults["container_name"])
    container_image = lookup(
      var.config,
      "container_image",
      var.defaults["container_image"],
    )
    container_memory = lookup(
      var.config,
      "container_memory",
      var.defaults["container_memory"],
    )
    container_cpu = lookup(var.config, "container_cpu", var.defaults["container_cpu"])
    aws_region    = lookup(var.config, "aws_region", var.defaults["aws_region"])
    aws_route53_map_public_ip = lookup(
      var.config,
      "aws_route53_map_public_ip",
      var.defaults["aws_route53_map_public_ip"],
    )
    aws_route53_private_zone = lookup(
      var.config,
      "aws_route53_private_zone",
      var.defaults["aws_route53_private_zone"],
    )
    aws_route53_zone = lookup(
      var.config,
      "aws_route53_zone",
      var.defaults["aws_route53_zone"],
    )
    aws_route53_record = lookup(
      var.config,
      "aws_route53_record",
      var.defaults["aws_route53_record"],
    )
    aws_logs_region = var.cw["region"]
    aws_logs_group  = var.cw["group"]
    aws_logs_stream_prefix = lookup(
      var.config,
      "aws_logs_stream_prefix",
      var.defaults["aws_logs_stream_prefix"],
    )
    vpn_ipsec_psk = lookup(var.config, "vpn_ipsec_psk", random_id.credentials[0].hex)
    vpn_username  = lookup(var.config, "vpn_username", random_id.credentials[1].hex)
    vpn_password  = lookup(var.config, "vpn_password", random_id.credentials[2].hex)
  }
}

