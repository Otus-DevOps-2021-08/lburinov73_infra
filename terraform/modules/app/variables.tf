variable public_key_path {
  description = "Path to the public key used for ssh access"
}
variable app_disk_image {
  description = "Disk image for reddit app"
  default     = "reddit-app-base"
}
variable subnet_id {
  description = "Subnets for modules"
}
variable res_cores {
  description = "CPU cores for the instance"
  default     = 2
}
variable res_memory {
  description = "Memory size in GB"
  default     = 2
}
variable res_core_fraction {
  description = "Baseline performance for a core as a percent"
  default     = 5
}
variable database_url {
  description = "ip:port of db instance"
}
