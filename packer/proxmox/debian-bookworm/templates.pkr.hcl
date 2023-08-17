source "file" "preseed" {
    content = templatefile("${path.root}/templates/preseed.pkrtpl.hcl", {
        locale          = var.locale
        keyboard_keymap = var.keyboard_keymap
        timezone        = var.timezone
        root_password   = local.root_passwd
    })
    target  = "${path.root}/http/preseed.cfg"
}
