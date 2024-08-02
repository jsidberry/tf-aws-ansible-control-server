output "ec2_public_ip" {
  value = module.compute.host_instance.public_ip
}