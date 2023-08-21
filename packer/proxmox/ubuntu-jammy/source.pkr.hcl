#
# Ubuntu 22.04
# ---
# Packer Template to create Ubuntu (Jammy) on Proxmox
#
source "proxmox-iso" "ubuntu-jammy" {

    # Proxmox connextion settings
    proxmox_url               = "${local.proxmox_api_url}"
    username                  = "${var.proxmox_api_token_id}"
    token                     = "${var.proxmox_api_token_secret}"
    insecure_skip_tls_verify  = "${var.proxmox_insecure_skip_tls_verify}"

    # Proxmox node settings
    node                      = "${var.proxmox_node}"
    pool                      = "${var.proxmox_pool}"

    # Template general settings
    template_name             = "${var.template_name}"
    template_description      = "${var.template_description}"
    vm_id                     = "${var.template_id}"

    # Template OS settings
    iso_file                  = local.use_iso_file ? "${var.template_iso_storage_pool}:iso/${var.template_iso_file}" : null
    iso_url                   = local.use_iso_file ? null : var.template_iso_url
    iso_checksum              = "${var.template_iso_checksum}"
    iso_storage_pool          = "${var.template_iso_storage_pool}"
    unmount_iso               = true
    qemu_agent                = true

    # Template system settings
    sockets                   = "${var.template_sockets}"
    cores                     = "${var.template_cores}"
    cpu_type                  = "${var.template_cpu_type}"
    memory                    = "${var.template_memory}"
    os                        = "l26"

    # Template disk settings
    scsi_controller           = "virtio-scsi-pci"
    
    disks {
        type         = "${var.template_disk_type}"
        disk_size    = "${var.template_disk_size}"
        format       = "${var.template_disk_format}"
        storage_pool = "${var.template_disk_storage_pool}"
        cache_mode   = "${var.template_disk_cache_mode}"
    }

    # Template network settings
    network_adapters {
        model        = "${var.template_network_model}"
        bridge       = "${var.template_network_bridge}"
        firewall     = "false"
    }

    # Cloud-init settings
    cloud_init                = true
    cloud_init_storage_pool   = "${var.cloud_init_storage_pool}"

    # Packer boot commands
    http_directory            = "http"
    boot                      = "c"
    boot_wait                 = "5s"
    boot_command              = [
        "<esc><wait>",
        "e<wait>",
        "<down><down><down><end>",
        "<bs><bs><bs><bs><wait>",
        " ipv6.disable=1 autoinstall ds=nocloud-net\\;s=http://{{ .HTTPIP }}:{{ .HTTPPort }}/ ---<wait>",
        "<f10><wait>"
    ]

    # Ssh settings
    ssh_username              = "ubuntu"
    ssh_password              = "${local.user_passwd}"
    ssh_timeout               = "20m"
    ssh_handshake_attempts    = 100
    ssh_private_key_file      = null
    ssh_clear_authorized_keys = true
    ssh_agent_auth            = false
}
