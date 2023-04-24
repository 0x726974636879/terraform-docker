resource "docker_volume" "volume" {
  count = var.volume_count
  name  = "${var.volume_name}_${count.index}_volume"

  lifecycle {
    prevent_destroy = false
  }

  provisioner "local-exec" {
    when       = destroy
    command    = "mkdir ${path.cwd}/volume_backup"
    on_failure = continue
  }

  provisioner "local-exec" {
    when       = destroy
    command    = "sudo tar -czvf ${path.cwd}/volume_backup/${self.name}.tar.gz ${self.mountpoint}/"
    on_failure = fail
  }
}