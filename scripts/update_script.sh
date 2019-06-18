#!/bin/bash
if [ ! -f /var/log/update_script.log ];
then
	touch /var/log/update_script.log
	chmod 777 /var/log/update_script.log
fi
date >> /var/log/update_script.log
apt update >> /var/log/update_script.log
apt upgrade -y >> /var/log/update_script.log
echo $'\n' >> /var/log/update_script.log
