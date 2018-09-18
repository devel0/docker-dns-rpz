#!/bin/bash

if [ ! -e /root/initialized ]; then
	if [ -e /root/it-admin-root ]; then
		echo "set ssh service"
		sed -i 's/PermitRootLogin prohibit-password/PermitRootLogin yes/g' /etc/ssh/sshd_config

		echo "setup root pass"
		echo "root:`cat /root/it-admin-root`" | chpasswd
	fi

	touch /root/initialized
fi

echo "nameserver 127.0.0.1" > /etc/resolv.conf
echo "search my.local" >> /etc/resolv.conf

\rm -f /var/run/dhcpd.pid

service rsyslog start
service bind9 start
#service ssh start

tail -f /var/log/syslog

$1
