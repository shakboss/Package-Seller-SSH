#!/bin/bash
#date january 2022
# created bye hidessh.com
# belajar bersama 1

cd

echo -n > /var/log/daemon.log
echo -n > /var/log/daemon.log.*
echo -n > /var/log/daemon.log.*.gz

echo -n > /var/log/syslog
echo -n > /var/log/syslog.*
echo -n > /var/log/syslog.*.gz
echo -n > /var/log/btmp

echo -n > /var/log/auth.log
echo -n > /var/log/auth.log.*
echo -n > /var/log/auth.log.*.gz

echo -n > /var/log/fail2ban.log
echo -n > /var/log/fail2ban.log.*
echo -n > /var/log/fail2ban.log.*.gz

echo -n > /var/log/messages
echo -n > /var/log/messages.*
echo -n > /var/log/messages.*.gz

echo -n > /var/log/lastlog

echo -n > /var/log/kern.log
echo -n > /var/log/kern.log.*
echo -n > /var/log/kern.log.*.gz

echo -n > /var/log/wtmp

echo -n > /var/log/nginx/access.log
echo -n > /var/log/nginx/access.log.*
echo -n > /var/log/nginx/error.log
echo -n > /var/log/nginx/access.log.*

echo -n > /var/log/cloud-init.log
echo -n > /var/log/waagent.log