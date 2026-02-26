data "yandex_compute_image" "ubuntu" {
  family = var.vm_image_family
}

locals {
  hosts = {
    clickhouse = {
      name = "clickhouse"
    }
    vector = {
      name = "vector"
    }
    lighthouse = {
      name = "lighthouse"
    }
  }

  ssh_key = "${var.vm_user}:${trimspace(file(var.ssh_public_key_path))}"
}

resource "yandex_compute_instance" "vm" {
  for_each = local.hosts

  name        = "netology-${each.value.name}"
  platform_id = var.vm_platform_id

  resources {
    cores         = var.vm_resources.cores
    memory        = var.vm_resources.memory
    core_fraction = var.vm_resources.core_fraction
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.id
      size     = 15
      type     = "network-hdd"
    }
  }

  network_interface {
    subnet_id = var.subnet_id
    nat       = true
  }

  metadata = {
    ssh-keys = local.ssh_key
  }
}

# --- Generate Ansible inventory automatically ---

locals {
  inventory_path = "${path.module}/../ansible/inventory/prod.yml"
}

resource "local_file" "ansible_inventory" {
  filename = local.inventory_path
  content = templatefile("${path.module}/templates/prod.yml.tftpl", {
    user = var.vm_user
    ch   = yandex_compute_instance.vm["clickhouse"].network_interface[0].nat_ip_address
    vec  = yandex_compute_instance.vm["vector"].network_interface[0].nat_ip_address
    lh   = yandex_compute_instance.vm["lighthouse"].network_interface[0].nat_ip_address
  })
}
