#!/bin/sh
#
# Configurações do template
#
echo "Ubuntu Focal Fossa template..." && sleep 2

# Instalação de pacotes
sudo apt update
sudo apt -y install cloud-init cloud-guest-utils
sudo apt -y autoremove --purge
sudo apt -y clean
sudo apt -y autoclean

# Configuração cloud-init
while [ ! -f /var/lib/cloud/instance/boot-finished ]; do echo 'Waiting for cloud-init...'; sleep 1; done
sudo rm -f /etc/cloud/cloud.cfg.d/subiquity-disable-cloudinit-networking.cfg
echo "datasource_list: [ConfigDrive, NoCloud]" | sudo tee /etc/cloud/cloud.cfg.d/99-pve.cfg

# Limpando template
sudo shred -u /etc/ssh/*_key /etc/ssh/*_key.pub
sudo rm -f /etc/cloud/cloud.cfg.d/99-installer.cfg
rm -rf /home/ubuntu/.ssh/authorized_keys
rm -rf /home/ubuntu/.*history
sudo truncate -s 0 /etc/machine-id
sudo cloud-init clean
sudo sync

# Configuração ssh
sudo sed -r -i "s/^#?PermitRootLogin.*/PermitRootLogin no/g" /etc/ssh/sshd_config
sudo sed -r -i "s/^#?PasswordAuthentication.*/PasswordAuthentication yes/g" /etc/ssh/sshd_config
