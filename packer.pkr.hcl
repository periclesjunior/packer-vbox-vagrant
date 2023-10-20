packer {
  required_version = ">= 1.7.0, < 2.0.0"
  required_plugins {
    virtualbox = {
      version = ">= 1.0.0, < 2.0.0"
      source  = "github.com/hashicorp/virtualbox"
    }
  }
}

locals {
  timestamp = regex_replace(timestamp(), "[- TZ:]", "")
}

source "virtualbox-iso" "debian" {
  boot_command          = [
                            "<esc><wait><wait>",
                            "install ", 
                            "auto=true ", 
                            "priority=critical ", 
                            "debconf/frontend=noninteractive ", 
                            "url=http://{{ .HTTPIP }}:{{ .HTTPPort }}/preseed.cfg ",
                            "<enter>"
                          ]
  boot_wait             = var.boot_wait
  disk_size             = var.disk_size
  guest_additions_mode	= var.guest_additions_mode
  guest_os_type         = var.guest_os_type
  headless              = var.headless
  http_directory        = var.http_directory
  iso_checksum          = var.iso_checksum
  iso_url               = var.iso_url
  shutdown_command      = "echo '${var.pwd}' | ${var.shutdown_command}"
  ssh_password          = var.pwd
  ssh_timeout           = var.ssh_timeout
  ssh_username          = var.user
  vboxmanage            = [
                            ["modifyvm", "{{.Name}}", "--memory", "1024"], 
                            ["modifyvm", "{{.Name}}", "--cpus", "1"], 
                            ["modifyvm", "{{.Name}}", "--nat-localhostreachable1", "on"]                      
                          ]
  vm_name               = var.vm_name
}

build {
  sources = [ "source.virtualbox-iso.debian"]

  provisioner "shell" {
    scripts = ["scripts/bootstrap.sh"]
  }

}
