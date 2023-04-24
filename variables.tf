variable "container_image_name" {
  type = map(map(string))
  default = {
    nodered = {
      dev  = "nodered/node-red:latest"
      prod = "nodered/node-red:1.3.7-minimal"
    }
    influxdb = {
      dev  = "quay.io/influxdb/influxdb:v2.0.2"
      prod = "quay.io/influxdb/influxdb:v2.0.2"
    }
    graphana = {
      dev  = "grafana/grafana-oss:latest"
      prod = "grafana/grafana-oss:8.2.0"
    }
  }
}

variable "int_port" {
  type = map(number)

  validation {
    condition     = var.int_port["nodered"] == 1880
    error_message = "Variable int_port must be 1880."
  }

  validation {
    condition     = var.int_port["influxdb"] == 8086
    error_message = "Variable int_port must be 8086."
  }

  validation {
    condition     = var.int_port["graphana"] == 3000
    error_message = "Variable int_port must be 3000."
  }
}

variable "ext_port" {
  type = map(map(list(number)))

  # Nodered
  validation {
    condition     = min(var.ext_port["nodered"]["dev"]...) >= 1980 && max(var.ext_port["nodered"]["dev"]...) < 3100
    error_message = "Variable ext_port must be in range 1980 - 3099."
  }

  validation {
    condition     = min(var.ext_port["nodered"]["prod"]...) >= 1880 && max(var.ext_port["nodered"]["prod"]...) < 1980
    error_message = "Variable ext_port must be in range 1880 - 1979."
  }

  # influxDb
  validation {
    condition     = min(var.ext_port["influxdb"]["dev"]...) >= 8186 && max(var.ext_port["influxdb"]["dev"]...) <= 65535
    error_message = "Variable ext_port must be in range 8186 - 65535."
  }

  validation {
    condition     = min(var.ext_port["influxdb"]["prod"]...) >= 8086 && max(var.ext_port["influxdb"]["prod"]...) < 8186
    error_message = "Variable ext_port must be in range 8086 - 8185."
  }

  # graphana
  validation {
    condition     = min(var.ext_port["graphana"]["dev"]...) >= 3100 && max(var.ext_port["graphana"]["dev"]...) <= 8085
    error_message = "Variable ext_port must be in range 3100 - 1881."
  }

  validation {
    condition     = min(var.ext_port["graphana"]["prod"]...) >= 3000 && max(var.ext_port["graphana"]["prod"]...) < 3100
    error_message = "Variable ext_port must be in range 3000 - 3100."
  }
}
