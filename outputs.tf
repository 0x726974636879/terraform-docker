output "image_id" {
  value = [for e in module.image : e.image_id]
}

output "application_access" {
  value = module.container
}
