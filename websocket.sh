#!/bin/bash
#date january 2022
#instalasi Websocket

# OpenSSH Websocket
#port 200 (OpenSSH) to 80 (HTTP Websocket)
cd
wget -O /usr/local/bin/ws-openssh https://raw.githubusercontent.com/hidessh99/Package-Seller-SSH/main/ssh%20websocket/ws-openssh.sh && chmod +x /usr/local/bin/ws-openssh
wget -O /etc/systemd/system/ws-openssh.service https://raw.githubusercontent.com/hidessh99/Package-Seller-SSH/main/ssh%20websocket/ws-openssh.service && chmod +x /etc/systemd/system/ws-openssh.service

systemctl daemon-reload
systemctl enable ws-openssh.service
systemctl start ws-openssh.service
systemctl restart ws-openssh.service

clear

# Dropbear WebSocket
#port 69 ( Dropbear) to 8880 (HTTPS Websocket)
cd
wget -O /usr/local/bin/ws-dropbear https://raw.githubusercontent.com/hidessh99/Package-Seller-SSH/main/ssh%20websocket/ws-dropbear.sh && chmod +x /usr/local/bin/ws-dropbear
wget -O /etc/systemd/system/ws-dropbear.service https://raw.githubusercontent.com/hidessh99/Package-Seller-SSH/main/ssh%20websocket/ws-dropbear.service && chmod +x /etc/systemd/system/ws-dropbear.service
#reboot service
systemctl daemon-reload
systemctl enable ws-dropbear.service
systemctl start ws-dropbear.service
systemctl restart ws-dropbear.service
clear

# OpenVPN WebSocket
#port 1194 ( Dropbear) to 2086 (HTTP Websocket)
#wget -O /usr/local/bin/edu-proxyovpn https://gitlab.com/hidessh/baru/-/raw/main/websocket-python/baru/ovpn.py && chmod +x /usr/local/bin/edu-proxyovpn
#wget -O /etc/systemd/system/edu-proxyovpn.service https://gitlab.com/hidessh/baru/-/raw/main/websocket-python/baru/ovpn.service && chmod +x /etc/systemd/system/edu-proxyovpn.service
#reboot service
#systemctl daemon-reload
#systemctl enable edu-proxyovpn.service
#systemctl start edu-proxyovpn.service
#systemctl restart edu-proxyovpn.service
#clear


# Dropbear WebSocket
#port 1194 ( Dropbear) to 2086 (HTTP Websocket)
wget -O /usr/local/bin/edu-tls https://gitlab.com/hidessh/baru/-/raw/main/websocket-python/ws-tls.py && chmod +x /usr/local/bin/edu-tls
wget -O /etc/systemd/system/edu-tls.service https://gitlab.com/hidessh/baru/-/raw/main/websocket-python/ws-tls.service && chmod +x /etc/systemd/system/edu-tls.service
#reboot service
systemctl daemon-reload
systemctl enable edu-tls
systemctl start edu-tls
systemctl restart edu-tls
clear

cd
#wget -O /usr/local/bin/ws-tls https://raw.githubusercontent.com/hidessh99/projectku/main/websocket/ws-tls && chmod +x /usr/local/bin/ws-tls
#wget -O /etc/systemd/system/ws-tls.service https://raw.githubusercontent.com/hidessh99/projectku/main/websocket/ws-tls.service && chmod +x  /etc/systemd/system/ws-tls.service

#systemctl daemon-reload
#systemctl enable ws-tls
#systemctl restart ws-tls


wget -O /usr/local/bin/ws-nginx https://raw.githubusercontent.com/hidessh99/Package-Seller-SSH/main/ssh%20websocket/ws-nginx.sh && chmod +x /usr/local/bin/ws-nginx-tls
wget -O /etc/systemd/system/ws-nginx.service https://raw.githubusercontent.com/hidessh99/Package-Seller-SSH/main/ssh%20websocket/ws-nginx.service && chmod +x  /etc/systemd/system/ws-nginx.service

#systemctl daemon-reload
#systemctl enable ws-nginx
#systemctl restart ws-nginx

