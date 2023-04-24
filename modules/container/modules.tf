module "volume" {
  source       = "./volume"
  count        = var.count_in
  volume_count = length(var.volumes)
  volume_name  = "${var.container_name}_${random_string.random[count.index].result}_${terraform.workspace}"
}
