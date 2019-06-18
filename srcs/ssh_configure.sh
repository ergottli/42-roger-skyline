#!/bin/bash

script_ssh()
{
CHECKSSHPORT=$(cat /etc/ssh/sshd_config | grep "Port " | awk '{print $2}')
echo  "\e[32mcurrent ssh-port is $CHECKSSHPORT\e[0m"
while true; do
	echo  "\e[32mWhat number of port do you want use with SSH? \e[0m"
	read PORT
	CHECKSSHPORT=$(lsof -i :$PORT -P | cut -d":" -f 2 | awk '{print $1}' | uniq | tail -1)
	if [ "$PORT" = "$CHECKSSHPORT" ]
	then
		echo  "\e[31m$PORT in currently use, enter another one!\e[0m"
	else
		break
	fi
done

sed -i.bak -e "s/^.*Port .*$/Port $PORT/" /etc/ssh/sshd_config

CHECKSSHPORT=$(cat /etc/ssh/sshd_config | grep "Port " | awk '{print $2}')
if [ "$PORT" != "$CHECKSSHPORT" ]
		then
		echo "\e[31mError with SSH-port assignment!\e[0m"
		while true; do
		read -p "Do yo want to return the previous values? " YN
		case $YN in
		[Yy]* ) mv /etc/ssh/sshd_config.bak /etc/ssh/sshd_config && exit ;;
		[Nn]* ) exit ;;
		* ) echo "\e[31menter yes or no\e[0m" ;;
		esac done
fi

service ssh restart && sleep 5
CHECKSSHPORT=$(lsof -i :$PORT -P | cut -d":" -f 2 | awk '{print $1}' | uniq | tail -1)
if [ "$PORT" != "$CHECKSSHPORT" ]
	then
	echo "\e[31mError with SSH-port assignment!\e[0m"
	while true; do
	read -p "Do yo want to return the previous values? " YN
	case $YN in
	[Yy]* ) mv /etc/ssh/sshd_config.bak /etc/ssh/sshd_config && exit ;;
	[Nn]* ) exit ;;
	* ) echo "\e[31menter yes or no\e[0m" ;;
	esac done
fi

sed -i -e "/PermitRootLogin/ s/ .*/ no/" -e '/PermitRootLogin/ s/^#//' /etc/ssh/sshd_config
PERMROOT=$(cat /etc/ssh/sshd_config | grep PermitRootLogin)
if [ "$PERMROOT" != "PermitRootLogin no" ]
	then
	echo "\e[31mError with root access rights\e[0m"
	while true; do
	read -p "Do yo want to return the previous values? " YN
	case $YN in
	[Yy]* ) mv /etc/ssh/sshd_config.bak /etc/ssh/sshd_config && exit ;;
	[Nn]* ) exit ;;
	* ) echo "\e[31menter yes or no\e[0m" ;;
	esac done
fi
echo "\e[32mYour SSH-port is $PORT. SSH-connection for ROOT disabled\e[0m"
}
