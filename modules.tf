module "image" {
  source     = "./modules/image"
  for_each   = local.deployment
  image_name = each.value.image
}

module "container" {
  source         = "./modules/container"
  for_each       = local.deployment
  count_in       = each.value.container_count
  image_id       = module.image[each.key].image_id
  container_name = each.key
  int_port       = each.value.int_port
  ext_port       = each.value.ext_port
  volumes        = each.value.volumes
}
