#!/bin/bash
# Script auto create trial user SSH
# yg akan expired dalam hitungan menit/jam

IP=$(wget -qO- ipv4.icanhazip.com)
domain=$(cat /etc/v2ray/domain)
Login=trial-`</dev/urandom tr -dc X-Z0-9 | head -c4`
Pass=`</dev/urandom tr -dc a-f0-9 | head -c10`
useradd -s /bin/false -M $Login && echo -e "$Pass\n$Pass\n"|passwd $Login &> /dev/null
echo -e ""
echo -e "Akun otomatis mati setelah 10 menit sejak akun di buat"
echo -e "Thank You For Using Our Services"
echo -e "SSH Account Info"
echo -e "Username: $Login"
echo -e "Password: $Pass"
echo -e "==============================="
echo -e "Domain         : $domain"
echo -e "Host           : $IP"
echo -e "OpenSSH        : 22"
echo -e "Dropbear       : 109, 143"
echo -e "SSL/TLS        :443, 222"
echo -e "Port Suid      : 3128"
echo -e "Port HTTP WS   : 2082, 8880"
echo -e "Port HTTPS WS  : 443"
echo -e "badvpn         : 7100-7300"
echo -e "==============================="
echo -e "PAYLOAD"                                                          
echo -e "GET / HTTP/1.1[crlf]Host: $domain[crlf]Connection: Keep-Alive[crlf]User-Agent: [ua][crlf]Upgrade: websocket[crlf][crlf]"
echo -e ""
sleep 600 && killall -u $Login && userdel -f $Login && minggat | grep $Login | awk {'print$2'} | sed 's/.$//' | sed 's/^....//' > /tmp/logout && PID=`cat /tmp/logout` && killall -9 $PID &> /dev/null &
