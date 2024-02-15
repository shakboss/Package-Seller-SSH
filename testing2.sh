cat> /etc/xray/webcoket-https.json << END
{
  "log": {
      "access": "/var/log/xray/trojan.log",
      "loglevel": "info"
  },
  "inbounds": [
    {
      "port": 2096,
      "protocol": "trojan",
      "tag": "TROJANTCP",
      "settings": {
        "clients": [
          {
            "password": "eef46d87-ae46-d801-e0d4-6c87ae46d801",
            "flow": "xtls-rprx-direct",
            "email": "trojan.ket-yt.xyz_VLESS_XTLS/TLS-direct_TCP"
          }
        ],
        "decryption": "none",
        "fallbacks": [
          {
            "alpn": "h2",
            "dest": 31302,
            "xver": 0
          },
          {
            "path": "/",
            "dest": 600,
            "xver": 1
          }
        ]
      },
      "streamSettings": {
        "network": "tcp",
        "security": "none"
      }
    }
  ],
  "outbounds": [
      {
          "protocol": "freedom",
          "tag": "direct"
      }
  ]
}
END
#ntls
cat> /etc/systemd/system/sebcoket-https.service << END
[Unit]
Description=Xray Service
Documentation=https://github.com/xtls
After=network.target nss-lookup.target

[Service]
User=nobody
CapabilityBoundingSet=CAP_NET_ADMIN CAP_NET_BIND_SERVICE
AmbientCapabilities=CAP_NET_ADMIN CAP_NET_BIND_SERVICE
NoNewPrivileges=true
ExecStart=/usr/local/bin/xray run -config /etc/xray/webcoket-https.json
Restart=on-failure
RestartPreventExitStatus=23
LimitNPROC=10000
LimitNOFILE=1000000

[Install]
WantedBy=multi-user.target
END
#enable systemd
systemctl enable webcoket-https
systemctl start webcoket-https
systemctl restart webcoket-https

#nginx  44 to 600 to Nginx 2096 HTTP
wget -O /usr/local/bin/ws-nginxhttp https://raw.githubusercontent.com/shakboss/Package-Seller-SSH/main/ssh%20websocket/ws-drophttps.sh && chmod +x /usr/local/bin/ws-nginxhttp
wget -O /etc/systemd/system/ws-nginxhttp.service https://raw.githubusercontent.com/shakboss/Package-Seller-SSH/main/ssh%20websocket/ws-drophttps.service && chmod +x  /etc/systemd/system/ws-nginxhttp.service
systemctl daemon-reload
systemctl enable ws-nginxhttp
systemctl restart ws-nginxhttp
