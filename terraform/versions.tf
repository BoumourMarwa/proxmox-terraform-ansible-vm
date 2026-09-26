terraform {
  required_providers {
    proxmox = {
      source  = "Telmate/proxmox"
      version = "3.0.2-rc10"
    }
    macaddress = {
      source  = "ivoronin/macaddress"
      version = "0.3.2"
    }
    opnsense = {
      source  = "browningluke/opnsense"
      version = "~> 0.11"
    }
  }
}

provider "proxmox" {
  pm_api_url          = "https://192.168.122.40:8006/api2/json"
  pm_api_token_id     = "terraform@pve!tfprov"
  pm_api_token_secret = var.pm_token_secret
  pm_tls_insecure     = true
}

provider "opnsense" {
  uri            = "https://192.168.122.150"
  api_key        = var.opnsense_api_key
  api_secret     = var.opnsense_api_secret
  allow_insecure = true
}
