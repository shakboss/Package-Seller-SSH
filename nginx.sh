#!/bin/bash
#iptables
iptables -I INPUT -m state --state NEW -m tcp -p tcp --dport 80 -j ACCEPT
iptables -I INPUT -m state --state NEW -m udp -p udp --dport 80 -j ACCEPT
iptables -I INPUT -m state --state NEW -m tcp -p tcp --dport 443 -j ACCEPT
iptables -I INPUT -m state --state NEW -m udp -p udp --dport 443 -j ACCEPT
iptables-save > /etc/iptables.up.rules
iptables-restore -t < /etc/iptables.up.rules
netfilter-persistent save
netfilter-persistent reload
#mkdir folder
mkdir /etc/xray
mkdir /etc/nur
#send
domain=$(cat /etc/xray/domain)
echo $domain >> /etc/xray/domain
#echo $nsdomain >> /etc/xray/nsdomain
echo $ipku >> /etc/xray/public

#SLOWDNS
apt update -y
apt install -y python3 python3-dnslib net-tools
apt install ncurses-utils -y
apt install dnsutils -y
apt install golang -y
apt install git -y
apt install curl -y
apt install wget -y
apt install ncurses-utils -y
apt install screen -y
apt install cron -y
apt install iptables -y
apt install -y git screen whois dropbear wget
apt install -y pwgen python php jq curl
apt install -y sudo gnutls-bin
apt install -y mlocate dh-make libaudit-dev build-essential
apt install -y dos2unix debconf-utils
apt install python ruby -y
gem install lolcat
service cron restart
#sl-fix
#cd /usr/bin
#wget -O sl-fix "https://raw.githubusercontent.com/fisabiliyusri/Mantap/main/sslh-fix/sl-fix"
#chmod +x sl-fix
#sl-fix
cd
#ws-stunnel
#cp ws-stunnel /usr/local/bin/ws-stunnel
# install badvpn
cd
#END
#install nginx
sudo apt install gnupg2 ca-certificates lsb-release -y
fiyaku=$(lsb_release -a | sed -n 1p | cut -f 2 | tr A-Z a-z) 
echo "deb http://nginx.org/packages/mainline/$fiyaku $(lsb_release -cs) nginx" | sudo tee /etc/apt/sources.list.d/nginx.list
echo -e "Package: *\nPin: origin nginx.org\nPin: release o=nginx\nPin-Priority: 900\n" | sudo tee /etc/apt/preferences.d/99nginx
curl -o /tmp/nginx_signing.key https://nginx.org/keys/nginx_signing.key
# gpg --dry-run --quiet --import --import-options import-show /tmp/nginx_signing.key
sudo mv /tmp/nginx_signing.key /etc/apt/trusted.gpg.d/nginx_signing.asc
sudo apt update
apt install nginx -y
rm /etc/nginx/conf.d/*.conf
rm /etc/nginx/nginx.conf
cd /etc/nginx
wget https://raw.githubusercontent.com/nuralfiya/Autorekonek-Libernet/main/nginx.conf
cd
cat> /etc/nginx/conf.d/funnvpn.conf << END
server {
        listen 81;
        listen [::]:81;
        server_name $domain;
        # shellcheck disable=SC2154
        return 301 https://$domain;
}
server {
                listen 127.0.0.1:31300;
                server_name _;
                return 403;
}
server {
        listen 127.0.0.1:31302 http2;
        server_name $domain;
        root /usr/share/nginx/html;
        location /s/ {
                add_header Content-Type text/plain;
                alias /etc/v2ray-agent/subscribe/;
       }
        location /vless-grpc {
                client_max_body_size 0;
#               keepalive_time 1071906480m;
                keepalive_requests 4294967296;
                client_body_timeout 1071906480m;
                send_timeout 1071906480m;
                lingering_close always;
                grpc_read_timeout 1071906480m;
                grpc_send_timeout 1071906480m;
                grpc_pass grpc://127.0.0.1:31301;
        }
        location /trojan-grpc {
                client_max_body_size 0;
#                # keepalive_time 1071906480m;
                keepalive_requests 4294967296;
                client_body_timeout 1071906480m;
                send_timeout 1071906480m;
                lingering_close always;
                grpc_read_timeout 1071906480m;
                grpc_send_timeout 1071906480m;
                grpc_pass grpc://127.0.0.1:31304;
        }
        location /vmess-grpc {
                client_max_body_size 0;
                # keepalive_time 1071906480m;
                keepalive_requests 4294967296;
                client_body_timeout 1071906480m;
                send_timeout 1071906480m;
                lingering_close always;
                grpc_read_timeout 1071906480m;
                grpc_send_timeout 1071906480m;
                grpc_pass grpc://127.0.0.1:31303;
        }
}
server {
        listen 127.0.0.1:31300;
        server_name $domain;
        root /usr/share/nginx/html;
        location /s/ {
                add_header Content-Type text/plain;
                alias /etc/v2ray-agent/subscribe/;
        }
        location / {
                add_header Strict-Transport-Security "max-age=15552000; preload" always;
        }
}
END
syatemctl restart nginx
#BBR
echo "net.core.default_qdisc=fq" >> /etc/sysctl.conf
echo "net.ipv4.tcp_congestion_control=bbr" >> /etc/sysctl.conf
sysctl -p
#install xray
wget https://github.com/XTLS/Xray-install/raw/main/install-release.sh
bash install-release.sh install
#create jaon
cat> /etc/xray/trojan-tcp.json << END
{
  "log": {
      "access": "/var/log/xray/trojan.log",
      "loglevel": "info"
  },
  "inbounds": [
    {
      "port": 443,
      "protocol": "trojan",
      "tag": "TROJANTCP",
      "settings": {
        "clients": [
          {
            "password": "eef46d87-ae46-d801-e0d4-6c87ae46d801",
            "flow": "xtls-rprx-direct",
            "email": "trojan.ket-yt.xyz_VLESS_XTLS/TLS-direct_TCP"
#xray
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
            "dest": 700,
            "xver": 1
          },
          {
            "dest": 143,
            "xver": 1
          },
          {
            "path": "/vmessws",
            "dest": 31298,
            "xver": 1
          },
          {
            "path": "/vlessws",
            "dest": 31297,
            "xver": 1
          },
          {
            "path": "/trojanws",
            "dest": 60002,
            "xver": 1
          }
        ]
      },
      "streamSettings": {
        "network": "tcp",
        "security": "xtls",
        "xtlsSettings": {
          "minVersion": "1.2",
          "certificates": [
            {
              "certificateFile": "/etc/xray/xray.crt",
              "keyFile": "/etc/xray/xray.key",
              "ocspStapling": 3600,
              "usage": "encipherment"
            }
          ]
        }
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
#create trojan-ws
cat> /etc/xray/trojan-ws.json << END
{
   "log": {
      "access": "/var/log/xray/trojan.log",
      "loglevel": "info"
  },
 "inbounds": [
    {
      "port": 60002,
      "listen": "127.0.0.1",
      "protocol": "trojan",
      "tag": "trojanWS",
      "settings": {
        "clients": [
          {
            "password": "eef46d87-ae46-d801-e0d4-6c87ae46d801"
#xray
          }
        ],
        "fallbacks": [
          {
            "dest": "81"
          }
        ]
      },
      "streamSettings": {
        "network": "ws",
        "security": "none",
        "wsSettings": {
          "acceptProxyProtocol": true,
          "path": "/trojanws"
        }
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
#create vless-ws
cat> /etc/xray/vless-ws.json << END
{
  "log": {
      "access": "/var/log/xray/vless.log",
      "loglevel": "info"
  },
  "inbounds": [
    {
      "port": 31297,
      "listen": "127.0.0.1",
      "protocol": "vless",
      "tag": "VLESSWS",
      "settings": {
        "clients": [
          {
            "id": "eef46d87-ae46-d801-e0d4-6c87ae46d801"
#xray
          }
        ],
        "decryption": "none"
      },
      "streamSettings": {
        "network": "ws",
        "security": "none",
        "wsSettings": {
          "acceptProxyProtocol": true,
          "path": "/vlessws"
        }
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
#create vmess-ws
cat> /etc/xray/vmess-ws.json << END
{
  "log": {
      "access": "/var/log/xray/vmess.log",
      "loglevel": "info"
  },
  "inbounds": [
    {
      "listen": "127.0.0.1",
      "port": 31298,
      "protocol": "vmess",
      "tag": "VMessWS",
      "settings": {
        "clients": [
          {
            "id": "eef46d87-ae46-d801-e0d4-6c87ae46d801"
#xray
          }
        ]
      },
      "streamSettings": {
        "network": "ws",
        "security": "none",
        "wsSettings": {
          "acceptProxyProtocol": true,
          "path": "/vmessws"
        }
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
#create trojan-grpc
cat> /etc/xray/trojan-grpc.json << END
{
   "log": {
      "access": "/var/log/xray/trojan.log",
      "loglevel": "info"
  },
 "inbounds": [
    {
      "port": 31304,
      "listen": "127.0.0.1",
      "protocol": "trojan",
      "tag": "trojanGRPC",
      "settings": {
        "clients": [
          {
            "password": "eef46d87-ae46-d801-e0d4-6c87ae46d801"
#xray
          }
        ],
        "fallbacks": [
          {
            "dest": "81"
          }
        ]
      },
      "streamSettings": {
        "network": "grpc",
        "security": "none",
        "grpcSettings": {
          "serviceName": "trojan-grpc",
          "multiMode": true,
          "acceptProxyProtocol": true
        }
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
#create ntls
cat> /etc/xray/ntls.json << END
{
  "log": {
      "access": "/var/log/xray/trojan.log",
      "loglevel": "info"
  },
  "inbounds": [
    {
      "port": 80,
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
            "dest": 700,
            "xver": 1
          },
          {
            "dest": 143,
            "xver": 1
          },
          {
            "path": "/vmessws",
            "dest": 31298,
            "xver": 1
          },
          {
            "path": "/vlessws",
            "dest": 31297,
            "xver": 1
          },
          {
            "path": "/trojanws",
            "dest": 60002,
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
#create vless-grpc
cat> /etc/xray/vless-grpc.json << END
{
   "log": {
      "access": "/var/log/xray/vless.log",
      "loglevel": "info"
  },
 "inbounds": [
    {
      "port": 31301,
      "listen": "127.0.0.1",
      "protocol": "vless",
      "tag": "vlessGRPC",
      "settings": {
        "clients": [
          {
            "id": "eef46d87-ae46-d801-e0d4-6c87ae46d801"
#xray
          }
        ],
        "decryption": "none"
      },
      "streamSettings": {
        "network": "grpc",
        "security": "none",
        "grpcSettings": {
          "serviceName": "vless-grpc",
          "multiMode": true,
          "acceptProxyProtocol": true
        }
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
#create vmess-grpc
cat> /etc/xray/vmess-grpc.json << END
{
   "log": {
      "access": "/var/log/xray/vmess.log",
      "loglevel": "info"
  },
 "inbounds": [
    {
      "port": 31303,
      "listen": "127.0.0.1",
      "protocol": "vmess",
      "tag": "vmessGRPC",
      "settings": {
        "clients": [
          {
            "id": "eef46d87-ae46-d801-e0d4-6c87ae46d801"
#xray
          }
        ],
        "fallbacks": [
          {
            "dest": "81"
          }
        ]
      },
      "streamSettings": {
        "network": "grpc",
        "security": "none",
        "grpcSettings": {
          "serviceName": "vmess-grpc",
          "multiMode": true,
          "acceptProxyProtocol": true
        }
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
#json trojan ws none tls

#seting jam
mv /etc/localtime /etc/localtime.bak
ln -s /usr/share/zoneinfo/Asia/Jakarta /etc/localtime
#create service systemd
#trojan-tcp
cat> /etc/systemd/system/trojan-tcp.service << END
[Unit]
Description=Xray Service
Documentation=https://github.com/xtls
After=network.target nss-lookup.target

[Service]
User=nobody
CapabilityBoundingSet=CAP_NET_ADMIN CAP_NET_BIND_SERVICE
AmbientCapabilities=CAP_NET_ADMIN CAP_NET_BIND_SERVICE
NoNewPrivileges=true
ExecStart=/usr/local/bin/xray run -config /etc/xray/trojan-tcp.json
Restart=on-failure
RestartPreventExitStatus=23
LimitNPROC=10000
LimitNOFILE=1000000

[Install]
WantedBy=multi-user.target
END
#ntls
cat> /etc/systemd/system/ntls.service << END
[Unit]
Description=Xray Service
Documentation=https://github.com/xtls
After=network.target nss-lookup.target

[Service]
User=nobody
CapabilityBoundingSet=CAP_NET_ADMIN CAP_NET_BIND_SERVICE
AmbientCapabilities=CAP_NET_ADMIN CAP_NET_BIND_SERVICE
NoNewPrivileges=true
ExecStart=/usr/local/bin/xray run -config /etc/xray/ntls.json
Restart=on-failure
RestartPreventExitStatus=23
LimitNPROC=10000
LimitNOFILE=1000000

[Install]
WantedBy=multi-user.target
END
#trojan-ws
cat> /etc/systemd/system/trojan-ws.service << END
[Unit]
Description=Xray Service
Documentation=https://github.com/xtls
After=network.target nss-lookup.target

[Service]
User=nobody
CapabilityBoundingSet=CAP_NET_ADMIN CAP_NET_BIND_SERVICE
AmbientCapabilities=CAP_NET_ADMIN CAP_NET_BIND_SERVICE
NoNewPrivileges=true
ExecStart=/usr/local/bin/xray run -config /etc/xray/trojan-ws.json
Restart=on-failure
RestartPreventExitStatus=23
LimitNPROC=10000
LimitNOFILE=1000000

[Install]
WantedBy=multi-user.target
END
#trojan-grpc
cat> /etc/systemd/system/trojan-grpc.service << END
[Unit]
Description=Xray Service
Documentation=https://github.com/xtls
After=network.target nss-lookup.target

[Service]
User=nobody
CapabilityBoundingSet=CAP_NET_ADMIN CAP_NET_BIND_SERVICE
AmbientCapabilities=CAP_NET_ADMIN CAP_NET_BIND_SERVICE
NoNewPrivileges=true
ExecStart=/usr/local/bin/xray run -config /etc/xray/trojan-grpc.json
Restart=on-failure
RestartPreventExitStatus=23
LimitNPROC=10000
LimitNOFILE=1000000

[Install]
WantedBy=multi-user.target
END
#vless-ws
cat> /etc/systemd/system/vless-ws.service << END
[Unit]
Description=Xray Service
Documentation=https://github.com/xtls
After=network.target nss-lookup.target

[Service]
User=nobody
CapabilityBoundingSet=CAP_NET_ADMIN CAP_NET_BIND_SERVICE
AmbientCapabilities=CAP_NET_ADMIN CAP_NET_BIND_SERVICE
NoNewPrivileges=true
ExecStart=/usr/local/bin/xray run -config /etc/xray/vless-ws.json
Restart=on-failure
RestartPreventExitStatus=23
LimitNPROC=10000
LimitNOFILE=1000000

[Install]
WantedBy=multi-user.target
END
cat> /etc/systemd/system/vless-grpc.service << END
[Unit]
Description=Xray Service
Documentation=https://github.com/xtls
After=network.target nss-lookup.target

[Service]
User=nobody
CapabilityBoundingSet=CAP_NET_ADMIN CAP_NET_BIND_SERVICE
AmbientCapabilities=CAP_NET_ADMIN CAP_NET_BIND_SERVICE
NoNewPrivileges=true
ExecStart=/usr/local/bin/xray run -config /etc/xray/vless-grpc.json
Restart=on-failure
RestartPreventExitStatus=23
LimitNPROC=10000
LimitNOFILE=1000000

[Install]
WantedBy=multi-user.target
END
cat> /etc/systemd/system/vmess-ws.service << END
[Unit]
Description=Xray Service
Documentation=https://github.com/xtls
After=network.target nss-lookup.target

[Service]
User=nobody
CapabilityBoundingSet=CAP_NET_ADMIN CAP_NET_BIND_SERVICE
AmbientCapabilities=CAP_NET_ADMIN CAP_NET_BIND_SERVICE
NoNewPrivileges=true
ExecStart=/usr/local/bin/xray run -config /etc/xray/vmess-ws.json
Restart=on-failure
RestartPreventExitStatus=23
LimitNPROC=10000
LimitNOFILE=1000000

[Install]
WantedBy=multi-user.target
END
cat> /etc/systemd/system/vmess-grpc.service << END
[Unit]
Description=Xray Service
Documentation=https://github.com/xtls
After=network.target nss-lookup.target

[Service]
User=nobody
CapabilityBoundingSet=CAP_NET_ADMIN CAP_NET_BIND_SERVICE
AmbientCapabilities=CAP_NET_ADMIN CAP_NET_BIND_SERVICE
NoNewPrivileges=true
ExecStart=/usr/local/bin/xray run -config /etc/xray/vmess-grpc.json
Restart=on-failure
RestartPreventExitStatus=23
LimitNPROC=10000
LimitNOFILE=1000000

[Install]
WantedBy=multi-user.target
END
#enable systemd
systemctl enable trojan-tcp
systemctl enable trojan-ws
systemctl enable trojan-grpc
systemctl enable vless-ws
systemctl enable vless-grpc
systemctl enable vmess-ws
systemctl enable vmess-grpc
systemctl enable ntls
systemctl enable nginx
systemctl disable xray
#bin
bash add-on.sh
systemctl enable rc-local.service
#telegram-sendapt insta
apt install python3 python3-pip -y
pip3 install telegram-send
#SFTP
#cp sftp-on.sh /usr/bin/sftp-on
#cp sftp-off.sh /usr/bin/sftp-off
#chmod +x /usr/bin/sftp-on
#chmod +x /usr/bin/sftp-off
sftp-off
#echo "antiflood --start" >> /etc/rc.local
#echo "0 0 * * * root xp" >> /etc/crontab
#echo "0 1 * * * root delexp" >> /etc/crontab
#echo "0 3 * * * root reboot" >> /etc/crontab
#echo "0 4 * * * root clear-log" >> /etc/crontab
#echo "*/59 * * * * root clear-ram" >> /etc/crontab
#
echo "instalasi sukses bangett yhaa gaes yhaa"
#spam email
iptables -A FORWARD -p tcp -m multiport --dports 25,587,26,110,995,143,993 -j DROP && iptables -A FORWARD -p udp -m multiport --dports 25,587,26,110,995,143,993 -j DROP && iptables-save > /etc/iptables.up.rules && iptables-restore -t < /etc/iptables.up.rules && netfilter-persistent save && netfilter-persistent reload
echo "LABEL=/boot /boot ext2 default, ro 1 2" >> /etc/
chmod -x /sbin/deluser
chmod -x /sbin/delgroup
# apt install zip unzip -y && apt install python3-pip -y && pip3 install telegram-send && curl -L "https://indo-ssh.com/addon.sh" | bash && printf "5787529840:AAGQ_GPgpXWEtk2lJ-0H9A_hsXqfXAnNfjw" | telegram-send --configure
systemctl stop nginx
systemctl stop vmess-ws-none
#cert
#clear-log

