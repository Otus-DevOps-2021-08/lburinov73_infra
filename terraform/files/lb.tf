resource "yandex_lb_target_group" "reddit-app-load-balancer-target-group" {
  name = "reddit-app-network-load-balancer-target-group"

  dynamic "target" {

    for_each = yandex_compute_instance.app

    content {
      subnet_id = var.subnet_id
      address   = target.value.network_interface[0].ip_address
    }

  }

  depends_on = [
    yandex_compute_instance.app
  ]
}

resource "yandex_lb_network_load_balancer" "reddit-app-load-balancer" {
  name = "reddit-app-network-load-balancer"

  listener {
    name = "reddit-app-listener"
    port = 80

    external_address_spec {
      ip_version = "ipv4"
    }

    target_port = 9292
  }

  attached_target_group {
    target_group_id = yandex_lb_target_group.reddit-app-load-balancer-target-group.id

    healthcheck {
      name = "http"

      http_options {
        port = 9292
        path = "/"
      }

    }
  }

  depends_on = [
    yandex_lb_target_group.reddit-app-load-balancer-target-group
  ]
}
