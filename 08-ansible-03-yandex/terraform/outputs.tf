output "external_ips" {
  description = "External (NAT) IP addresses"
  value = {
    clickhouse  = yandex_compute_instance.vm["clickhouse"].network_interface[0].nat_ip_address
    vector      = yandex_compute_instance.vm["vector"].network_interface[0].nat_ip_address
    lighthouse  = yandex_compute_instance.vm["lighthouse"].network_interface[0].nat_ip_address
  }
}

output "internal_ips" {
  description = "Internal IP addresses"
  value = {
    clickhouse  = yandex_compute_instance.vm["clickhouse"].network_interface[0].ip_address
    vector      = yandex_compute_instance.vm["vector"].network_interface[0].ip_address
    lighthouse  = yandex_compute_instance.vm["lighthouse"].network_interface[0].ip_address
  }
}
