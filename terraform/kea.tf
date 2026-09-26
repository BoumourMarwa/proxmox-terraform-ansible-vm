resource "opnsense_kea_subnet" "lan" {
  subnet          = "10.0.0.0/24"
  description     = "LAN - vmbr1"
  match_client_id = false
  routers         = ["10.0.0.1"]
  dns_servers     = ["10.0.0.1"]
}

resource "opnsense_kea_reservation" "vm1" {
  subnet_id   = opnsense_kea_subnet.lan.id
  ip_address  = "10.0.0.5"
  mac_address = upper(macaddress.vm1.address)
  hostname    = "debian-auto-01"
  description = "VM créée par terraform"
}
