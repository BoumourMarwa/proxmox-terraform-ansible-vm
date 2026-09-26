resource "proxmox_vm_qemu" "vm1" {
  name        = "debian-auto-01"
  target_node = "pve"
  clone       = "debian"

  os_type = "cloud-init"
  bios    = "ovmf"
  agent   = 1
  scsihw  = "virtio-scsi-pci"

  cores   = 2
  sockets = 1
  memory  = 2048

  boot = "order=scsi0"

  disks {
    scsi {
      scsi0 {
        disk {
          storage = "local-lvm"
          size    = "40G"
          discard = true
        }
      }
      scsi1 {
        cloudinit {
          storage = "local-lvm"
        }
      }
    }
  }

  efidisk {
    storage = "local-lvm"
    efitype = "4m"
  }

  serial {
    id   = 0
    type = "socket"
  }

  vga {
    type = "serial0"
  }

  network {
    id      = 0
    model   = "virtio"
    bridge  = "vmbr1"
    macaddr = upper(macaddress.vm1.address)
  }

  ipconfig0 = "ip=dhcp"
  ciuser    = "root"
  sshkeys = <<-EOF
ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPqAhExouMJ7nna2z1bjyACTpchxL0rop5Y/Lbc/U5Mm user@debian
EOF


}
