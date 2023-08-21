#
# Required Variables
#
variable "proxmox_api_token_id" {
    description = "Proxmox user token for api"
    type        = string
    sensitive   = true
}

variable "proxmox_api_token_secret" {
    description = "Proxmox user token password for api"
    type        = string
    sensitive   = true
}

variable "proxmox_host" {
    description = "Proxmox server ip"
    type        = string
}

variable "proxmox_node" {
    description = "Proxmox node name"
    type        = string
}

#
# Optional variables
#
variable "proxmox_port" {
    description = "Proxmox server port"
    type        = number
    default     = 8006
}

variable "proxmox_insecure_skip_tls_verify" {
    description = "Disable tls certificate verification"
    type        = bool
    default     = true
}

variable "proxmox_pool" {
    description = "Proxmox template pool"
    type        = string
    default     = null
}

variable "template_name" {
    description = "Template name definition"
    type        = string
    default     = "ubuntu-focal"
}

variable "template_description" {
    description = "Template description"
    type        = string
    default     = "Ubuntu 20.04 (Focal Fossa), generated on {{ isotime \"2006-01-02T15:04:05Z\" }}"
}

variable "template_id" {
    description = "Template ID"
    type        = string
    default     = "902"
}

variable "template_iso_file" {
    description = "Filename of the iso"
    type        = string
    default     = null      # ubuntu-20.04.6-live-server-amd64.iso
}

variable "template_iso_url" {
    description = "Iso file to upload to Proxmox"
    type        = string
    default     = "https://releases.ubuntu.com/20.04/ubuntu-20.04.6-live-server-amd64.iso"
}

variable "template_iso_checksum" {
    description = "Checksum of the iso file for validation"
    type        = string
    default     = "b8f31413336b9393ad5d8ef0282717b2ab19f007df2e9ed5196c13d8f9153c8b"
}

variable "template_iso_storage_pool" {
    description = "Proxmox storage pool to iso files"
    type        = string
    default     = "local"
}

variable "template_sockets" {
    description = "Number of cpu sockets"
    type        = number
    default     = 1
}

variable "template_cores" {
    description = "Number of cpu cores"
    type        = number
    default     = 2
}

variable "template_cpu_type" {
    description = "Type of cpu to be emulated"
    type        = string
    default     = "host"

    validation {
        condition     = contains([
            "host", "kvm32", "kvm64", "qemu32", 
            "qemu64", "x86-64-v2", "x86-64-v2-AES"
        ], var.template_cpu_type)
        error_message = "The current cpu type is not allowed. Cpu type must be either: 'host', 'kvm32', 'kvm64', 'qemu64', 'x86-64-v2' or 'x86-64-v2-AES'."
    }
}

variable "template_memory" {
    description = "Amount of memory used by the template (megabytes)"
    type        = number
    default     = 2048
}

variable "template_disk_type" {
    description = "The type of disk device"
    type        = string
    default     = "virtio"

    validation {
        condition     = contains([
            "ide", "sata", "scsi", "virtio"
        ], var.template_disk_type)
        error_message = "The current disk type is not allowed. Disk type must be either: 'ide', 'sata', 'scsi' or 'virtio'."
    }
}

variable "template_disk_size" {
    description = "The size of the disk"
    type        = string
    default     = "4G"

    validation {
        condition     = can(regex("^\\d+[GMK]$", var.template_disk_size))
        error_message = "The disk size is not valid. Disk size must be a number with a suffix 'K', 'M' or 'G'."
    }
}

variable "template_disk_format" {
    description = "The disk file format"
    type        = string
    default     = "qcow2"

    validation {
        condition     = contains(["raw", "qcow2", "vmdk"], var.template_disk_format)
        error_message = "The disk format is not valid. Disk format must be either: 'raw', 'qcow2' or 'vmdk'."
    }
}

variable "template_disk_storage_pool" {
    description = "Storage pool for images (disk and cloud-init)"
    type        = string
    default     =  "local"

    validation {
        condition     = var.template_disk_storage_pool != null
        error_message = "The disk storage pool cannot be null."
    }
}

variable "template_disk_cache_mode" {
    description = "The disk cache mode"
    type        = string
    default     = "writeback"

    validation {
        condition     = contains([
            "nocache", "directsync", "writethrough", "writeback"
        ], var.template_disk_cache_mode)
        error_message = "The disk cache mode is not valid. Cache mode must be either: 'nocache', 'directsync', 'writethrough' or 'writeback'."
    }
}

variable "template_network_model" {
    description = "Type of adapter model for network interface"
    type        = string
    default     = "virtio"
}

variable "template_network_bridge" {
    description = "Proxmox bridge to attach the adapter to"
    type        = string
    default     = "vmbr1"
}

variable "cloud_init_storage_pool" {
    description = "Storage pool to store the cloud-init cdrom"
    type        = string
    default     = "local"
}

variable "locale" {
    description = "Sets the locale during ubuntu install"
    type        = string
    default     = "en_US.UTF-8"
}

variable "keyboard_layout" {
    description = "Sets the keyboard layout during ubuntu install"
    type        = string
    default     = "us"
}

variable "keyboard_variant" {
    description = "Sets the keyboard variant during ubuntu install"
    type        = string
    default     = "us"
}

variable "timezone" {
    description = "Sets the timezone during ubuntu install"
    type        = string
    default     = "America/Sao_Paulo"
}
