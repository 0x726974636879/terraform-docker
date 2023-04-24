locals {
  deployment = {
    nodered = {
      container_count = length(var.ext_port["nodered"][terraform.workspace])
      image           = var.container_image_name["nodered"][terraform.workspace]
      int_port        = var.int_port["nodered"]
      ext_port        = var.ext_port["nodered"][terraform.workspace]
      volumes = [
        { container_path = "/data" }
      ]
    }
    influxdb = {
      container_count = length(var.ext_port["influxdb"][terraform.workspace])
      image           = var.container_image_name["influxdb"][terraform.workspace]
      int_port        = var.int_port["influxdb"]
      ext_port        = var.ext_port["influxdb"][terraform.workspace]
      container_path  = "/var/lib/influxdb"
      volumes = [
        { container_path = "/var/lib/influxdb" }
      ]
    }
    graphana = {
      container_count = length(var.ext_port["graphana"][terraform.workspace])
      image           = var.container_image_name["graphana"][terraform.workspace]
      int_port        = var.int_port["graphana"]
      ext_port        = var.ext_port["graphana"][terraform.workspace]
      volumes = [
        { container_path = "/var/lib/graphana" },
        { container_path = "/etc/graphana" }
      ]
    }
  }
}