#!/bin/bash

# include
		. ./srcs/sudo_user.sh
		. ./srcs/internet.sh
		. ./srcs/ssh_configure.sh
		. ./srcs/ssh_keys.sh

apt update && apt upgrade -y
apt install net-tools vim sudo ufw fail2ban knockd -y

# add user to sudo.

while true; do
	echo "\e[32mDo you want add user to sudo? \e[0m"
	read YN
	case $YN in
	[Yy]* ) sudo_user ; break  ;;
	[Nn]* ) break ;;
	* ) echo "\e[31menter yes or no\e[0m" ;;
esac done

# change dhcp to static ip.

while true; do
	echo "\e[32mDo you want to configure static ip address? \e[0m"
	read YN
	case $YN in
	[Yy]* ) static_ip ; break  ;;
	[Nn]* ) break ;;
	* ) echo "\e[31menter yes or no\e[0m" ;;
esac done

# change ssh port, remove root-user from ssh.

while true; do
	echo "\e[32mDo you want to configure ssh-service? \e[0m"
	read YN
	case $YN in
	[Yy]* ) script_ssh ; break  ;;
	[Nn]* ) break ;;
	* ) echo "\e[31menter yes or no\e[0m" ;;
esac done

# add ssh-acess with publickeys.

while true; do
	echo "\e[32mDo you want to configure ssh-publickeys for user? \e[0m"
	read YN
	case $YN in
	[Yy]* ) ssh_keys ; break  ;;
	[Nn]* ) break ;;
	* ) echo "\e[31menter yes or no\e[0m" ;;
esac done
