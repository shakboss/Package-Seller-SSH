#!/bin/bash
#date january 2022
#instalasi Websocket
#SSH Webcoket

#nginx 69 to 443 HTTPS
wget -O /usr/local/bin/ws-nginx https://raw.githubusercontent.com/shakboss/Package-Seller-SSH/main/ssh%20websocket/ws-nginx.sh && chmod +x /usr/local/bin/ws-nginx-tls
wget -O /etc/systemd/system/ws-nginx.service https://raw.githubusercontent.com/shakboss/Package-Seller-SSH/main/ssh%20websocket/ws-nginx.service && chmod +x  /etc/systemd/system/ws-nginx.service
systemctl daemon-reload
systemctl enable ws-nginx
systemctl restart ws-nginx

# OpenSSH Websocket
#port 200 (OpenSSH) to 2082 (HTTP Websocket)
cd
wget -O /usr/local/bin/ws-openssh https://raw.githubusercontent.com/shakboss/Package-Seller-SSH/main/ssh%20websocket/ws-openssh.sh && chmod +x /usr/local/bin/ws-openssh
wget -O /etc/systemd/system/ws-openssh.service https://raw.githubusercontent.com/shakboss/Package-Seller-SSH/main/ssh%20websocket/ws-openssh.service && chmod +x /etc/systemd/system/ws-openssh.service

systemctl daemon-reload
systemctl enable ws-openssh.service
systemctl restart ws-openssh.service

# Dropbear WebSocket
#port 109 ( Dropbear) to 8880 (HTTPS Websocket)
cd
wget -O /usr/local/bin/ws-dropbear https://raw.githubusercontent.com/shakboss/Package-Seller-SSH/main/ssh%20websocket/ws-dropbear.sh && chmod +x /usr/local/bin/ws-dropbear
wget -O /etc/systemd/system/ws-dropbear.service https://raw.githubusercontent.com/shakboss/Package-Seller-SSH/main/ssh%20websocket/ws-dropbear.service && chmod +x /etc/systemd/system/ws-dropbear.service
#reboot service
systemctl daemon-reload
systemctl enable ws-dropbear.service
systemctl start ws-dropbear.service
systemctl restart ws-dropbear.service
clear
