#cloud-config
autoinstall:
  version: 1
  locale: ${ locale }
  keyboard:
    layout: ${ keyboard_layout }
    variant: ${ keyboard_variant }
  ssh:
    install-server: true
    allow-pw: true
    ssh_quiet_keygen: true
    allow_public_ssh_keys: true
  #early-commands:
  #  - systemctl stop ssh
  #late-commands:
  #  - systemctl start ssh
  packages:
    - qemu-guest-agent
    - sudo
  storage:
    layout:
      name: direct
    swap:
      size: 0
  user-data:
    package_upgrade: true
    disable_root: true
    timezone: ${ timezone }
    users:
      - name: ubuntu
        groups: [adm, sudo]
        lock-passwd: false
        sudo: ALL=(ALL) NOPASSWD:ALL
        shell: /bin/bash
        passwd: ${ user_passwd }
