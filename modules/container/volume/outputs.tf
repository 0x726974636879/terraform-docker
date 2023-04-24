output "volume_name" {
  value = [for e in docker_volume.volume : e.name]
}