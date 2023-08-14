#!/bin/sh
#
# Configurações do template
#
echo "Alpine template..." && sleep 2

# Instalação de pacotes
apk update
apk add --no-cache sudo python3
apk add --no-cache cloud-init cloud-utils-growpart e2fsprogs-extra

# Configuração cloud-init
echo 'isofs' > /etc/modules-load.d/isofs.conf
chmod -x /etc/modules-load.d/isofs.conf
setup-cloud-init
echo 'datasource_list: [ NoCloud, ConfigDrive, None ]' > /etc/cloud/cloud.cfg.d/99_pve.cfg
chmod 644 /etc/cloud/cloud.cfg.d/99_pve.cfg

# Limpando template
shred -u /etc/ssh/*_key /etc/ssh/*_key.pub
unset HISTFILE; rm -rf /root/.*history
rm -f /root/setup.sh
rm -f /root/.ssh/authorized_keys

# Configuração ssh
sed -r -i "s/^#?PermitRootLogin.*/PermitRootLogin no/g" /etc/ssh/sshd_config
sed -r -i "s/^PasswordAuthentication.*/PasswordAuthentication yes/g" /etc/ssh/sshd_config

# Desabilitando root
sudo passwd -d root
sudo passwd -l root
