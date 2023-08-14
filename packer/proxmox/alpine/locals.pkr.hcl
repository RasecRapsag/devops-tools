#
# Locals variables
#
locals {
    proxmox_api_url = join("", [
            "https://", var.proxmox_host, ":", 
            var.proxmox_port, "/api2/json"
    ])
    use_iso_file = var.template_iso_file != null ? true : false
    root_passwd = uuidv4()
}
