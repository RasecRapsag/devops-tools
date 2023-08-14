KEYMAPOPTS="${ keyboard_layout } ${ keyboard_variant }"
HOSTNAMEOPTS="-n ${hostname}"
DEVDOPTS="mdev"
INTERFACESOPTS="auto lo
iface lo inet loopback

auto eth0
iface eth0 inet dhcp
    hostname ${hostname}
"
%{ if length(dns_servers) > 0 ~}
DNSOPTS="-n ${join(" ", dns_servers)}"
%{ endif ~}
TIMEZONEOPTS="-z ${ timezone }"
PROXYOPTS="none"
APKREPOSOPTS="-1 -c"
SSHDOPTS="-c openssh"
NTPOPTS="-c chrony"
DISKOPTS="-s 0 -m sys /dev/sda"