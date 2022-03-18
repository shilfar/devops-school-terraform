output "List_vpcs" {
  value = data.aws_vpcs.List_vpcs.ids
}

output "List_subnets" {
  value = data.aws_subnets.List_subnets.ids
}

output "List_sg" {
  value = data.aws_security_groups.List_sg.ids
}
