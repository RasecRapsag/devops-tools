#
# Build definition to create Vm template
#
build {
    name    = "ubuntu-focal"
    sources = [
        "source.file.user-data",
        "source.proxmox-iso.ubuntu-focal",
    ]

    # Provisioning the template for integration in Proxmox
    provisioner "shell" {
        scripts = [ "scripts/config.sh" ]
    }

    # Remove CD-ROM
    post-processor "shell-local" {
        inline = [ "ssh ${var.proxmox_host} sudo qm set ${var.template_id} --delete ide2" ]
        only   = [ "proxmox-iso.ubuntu-focal" ]
    }
}