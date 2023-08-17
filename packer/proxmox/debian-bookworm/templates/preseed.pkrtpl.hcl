# Localization
d-i debian-installer/locale string ${ locale }

# Keyboard
d-i console-setup/ask_detect boolean false
d-i keyboard-configuration/xkb-keymap select ${ keyboard_keymap }

# Clock and time zone setup
d-i clock-setup/utc boolean true
d-i clock-setup/utc-auto boolean true
d-i time/zone string ${ timezone }
d-i clock-setup/ntp boolean true

# Mirror settings
d-i mirror/country string manual
d-i mirror/http/directory string /debian
d-i mirror/http/hostname string httpredir.debian.org
d-i mirror/http/proxy string

# Partitioning
d-i partman-auto/method string regular
d-i partman-basicfilesystems/no_swap boolean false
d-i partman-auto/expert_recipe string                     \
      boot-root ::                                        \
          1024 1024 100% xfs                              \
                  method{ format } format{ }              \
                  use_filesystem{ } filesystem{ xfs }     \
                  mountpoint{ / }                         \
          .
d-i partman/choose_partition select finish
d-i partman/confirm boolean true
d-i partman/confirm_nooverwrite boolean true
d-i partman/confirm_write_new_label boolean true

# To define root password
d-i passwd/root-login boolean true
d-i passwd/root-password-again password ${ root_password }
d-i passwd/root-password password ${ root_password }
d-i passwd/make-user boolean false

# Package selection and update
tasksel tasksel/first multiselect ssh-server
d-i base-installer/kernel/override-image string linux-server
d-i pkgsel/update-policy select none
d-i pkgsel/upgrade select full-upgrade

# Include Additional Software
d-i pkgsel/include string qemu-guest-agent

# Boot loader installation
d-i grub-installer/only_debian boolean true
d-i grub-installer/bootdev string /dev/vda

# Finishing up the installation
d-i preseed/late_command string \
  in-target sh -c 'sed -i "s/^#PermitRootLogin.*\$/PermitRootLogin yes/g" /etc/ssh/sshd_config'

d-i debian-installer/splash boolean false
d-i finish-install/reboot_in_progress note