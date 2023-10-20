variable "boot_wait" {
  type        = string
}

variable "disk_size" {
  type        = string
}

variable "guest_additions_mode" {
  type        = string
  default     = "disable"
}

variable "guest_os_type" {
  type        = string
  default     = "Debian_64"
}

variable "headless" {
  type        = string
  default     = "true"
}

variable "http_directory" {
  type        = string
  default     = "http"
}

variable "iso_checksum" {
  type        = string
}

variable "iso_url" {
  type        = string
}

variable "shutdown_command" {
  type        = string
  default     = "sudo -S /sbin/shutdown -hP now"
}

variable "pwd" {
  type        = string
}

variable "ssh_timeout" {
  type        = string 
}

variable "user" {
  type        = string 
}

variable "vm_name" {
  type        = string 
}

