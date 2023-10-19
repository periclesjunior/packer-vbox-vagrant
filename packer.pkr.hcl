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
  boot_command      = [ "<esc><wait><wait>", "install ", "auto=true ", "priority=critical ", "debconf/frontend=noninteractive ", "url=http://{{ .HTTPIP }}:{{ .HTTPPort }}/preseed.cfg ", "<enter>"]
  boot_wait         = "10s"
  disk_size         = "31000"
  guest_additions_mode	= "disable"
  guest_os_type     = "Debian_64"
  headless          = "true"
  http_directory    = "http"
  iso_checksum      = "sha256:23ab444503069d9ef681e3028016250289a33cc7bab079259b73100daee0af66"
  iso_url           = "https://cdimage.debian.org/debian-cd/current/amd64/iso-cd/debian-12.2.0-amd64-netinst.iso"
  shutdown_command  = "echo 'vagrant'|sudo -S /sbin/shutdown -hP now"
  ssh_password      = "vagrant"
  ssh_timeout       = "10000s"
  ssh_username      = "vagrant"
  vboxmanage        = [["modifyvm", "{{.Name}}", "--memory", "1024"], ["modifyvm", "{{.Name}}", "--cpus", "1"], ["modifyvm", "{{.Name}}", "--nat-localhostreachable1", "on"]]
  vm_name           = "vm-debian12"
}

build {
  sources = [ "source.virtualbox-iso.debian"]
}
