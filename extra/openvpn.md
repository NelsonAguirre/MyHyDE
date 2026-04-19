# Proton openvon

## Pre

Dependencias: paru -S openvpn openvpn-update-systemd-resolved

sudo wget "https://raw.githubusercontent.com/ProtonVPN/scripts/master/update-resolv-conf.sh" -O "/etc/openvpn/update-resolv-conf"
sudo chmod +x /etc/openvpn/update-resolv-conf

## Ejecutar

sudo systemctl start systemd-resolved.service

sudo openvpn --config ~/Documents/openvpn/ca-free-11.protonvpn.tcp.ovpn --script-security 2
