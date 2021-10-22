resource "yandex_compute_instance" "app" {
  name = "${var.environment}-reddit-app"
  labels = {
    tags = "reddit-app"
  }

  resources {
    cores         = var.res_cores
    memory        = var.res_memory
    core_fraction = var.res_core_fraction
  }

  boot_disk {
    initialize_params {
      image_id = var.app_disk_image
    }
  }

  network_interface {
    subnet_id = var.subnet_id
    nat       = true
  }

  metadata = {
    ssh-keys = "ubuntu:${file(var.public_key_path)}"
  }


#  connection {
#    type        = "ssh"
#    host        = yandex_compute_instance.app.network_interface.0.nat_ip_address
#    user        = "ubuntu"
#    agent       = false
#    private_key = file(var.private_key_path)
#  }

#  provisioner "file" {
#    content     = templatefile("${path.module}/files/puma.service", { DATABASE_URL = var.database_url })
#    destination = "/tmp/puma.service"
#  }

#  provisioner "remote-exec" {
#    script = "${path.module}/files/deploy.sh"
#  }
}
