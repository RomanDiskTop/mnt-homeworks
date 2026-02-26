variable "cloud_id" {
  type        = string
}

variable "folder_id" {
  type        = string
}

variable "default_zone" {
  type        = string
  default     = "ru-central1-a"
}

variable "service_account_key_file" {
  type        = string
}

variable "ssh_public_key_path" {
  type        = string
}

variable "subnet_cidr" {
  type        = string
  default     = "10.10.0.0/24"
}

variable "vm_platform_id" {
  type        = string
  default     = "standard-v2"
}

variable "vm_resources" {

  type = object({
    cores         = number
    memory        = number
    core_fraction = number
  })
  default = {
    cores         = 2
    memory        = 2
    core_fraction = 20
  }
}

variable "vm_image_family" {
  type        = string
  default     = "ubuntu-2204-lts"
}

variable "vm_user" {
  type        = string
  default     = "ubuntu"
}
variable "subnet_id" {
  type        = string
  description = "ru-central1-a"
}