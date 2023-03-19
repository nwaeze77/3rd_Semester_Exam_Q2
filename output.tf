output "node_addresses" {
  value = ["${aws_instance.node.*.public_dns}"]
}

output "master_address" {
  value = aws_instance.master.public_dns
}

output "sock_shop_address" {
  value = aws_elb.my-elb.dns_name
}