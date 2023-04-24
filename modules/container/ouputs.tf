# output "container_ip_port" {
#   value = [for e in docker_container.container[*] : join(":", [e.network_data[0].ip_address, e.ports[0].external])]
# }

# output "container_name" {
#   value = [for e in docker_container.container[*] : e.name]
# }

output "apps" {
  value = {
    for e in docker_container.container[*] : e.name => "${e.network_data[0].ip_address}:${e.ports[0].external}"
  }
}

output "volume_name" {
  value = [for e in module.volume : e.volume_name]
}