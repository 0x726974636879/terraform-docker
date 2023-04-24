resource "random_string" "random" {
  count   = var.count_in
  length  = 6
  upper   = false
  special = false
}

resource "docker_container" "container" {
  depends_on = [module.volume]
  count      = var.count_in
  name       = join("_", [var.container_name, random_string.random[count.index].result, terraform.workspace])
  image      = var.image_id

  ports {
    internal = var.int_port
    external = var.ext_port[count.index]
  }

  dynamic "volumes" {
    for_each = var.volumes
    content {
      container_path = volumes.value["container_path"]
      volume_name    = module.volume[count.index].volume_name[volumes.key]
    }
  }

  provisioner "local-exec" {
    when       = create
    command    = "echo '${self.name}: ${self.network_data[0].ip_address}:${self.ports[0].external}' >> ${path.cwd}/../containers.txt"
    on_failure = fail
  }

  provisioner "local-exec" {
    when       = destroy
    command    = "rm -f ${path.cwd}/../containers.txt && echo 'containers.txt DELETED'"
    on_failure = continue
  }
}
