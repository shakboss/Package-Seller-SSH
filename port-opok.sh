#!/bin/bash
# Path: Package-Seller-SSH\port-opok.sh
sed -i '/Port 22/a Port 3128' /etc/ssh/sshd_config
#service
service ssh restart
service sshd restart
service disable squid
service disable squid3
service stop squid
service stop squid3
