source "file" "user-data" {
    content = templatefile("${path.root}/templates/user-data.pkrtpl.hcl", {
        locale           = var.locale
        keyboard_layout  = var.keyboard_layout
        timezone         = var.timezone
        user_passwd    = bcrypt(local.user_passwd)
    })
    target  = "${path.root}/http/user-data"
}
