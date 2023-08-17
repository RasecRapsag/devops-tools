#
# Build definition to create Vm template
#
build {
    name    = "debian-bookworm"
    sources = [
        "source.file.preseed",
        "source.proxmox-iso.debian-bookworm",
    ]

    # Provisioning the template for integration in Proxmox
    provisioner "shell" {
        scripts = [ "scripts/config.sh" ]
    }

    # Remove CD-ROM
    post-processor "shell-local" {
        inline = [ "ssh ${var.proxmox_host} sudo qm set ${var.template_id} --delete ide2" ]
        only   = [ "proxmox-iso.debian-bookworm" ]
    }
}