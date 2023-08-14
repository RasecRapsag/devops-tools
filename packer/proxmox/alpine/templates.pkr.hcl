source "file" "answers" {
    content = templatefile("${path.root}/templates/answers.pkrtpl.hcl", {
        keyboard_layout  = var.keyboard_layout
        keyboard_variant = var.keyboard_variant
        hostname         = var.hostname
        timezone         = var.timezone
        dns_servers      = var.dns_servers
    })
    target  = "${path.root}/http/answers"
}
