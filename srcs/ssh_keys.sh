#!/bin/bash/
ssh_keys()
{
while true; do
	echo "\e[32menter username for ssh-publickeys\e[0m"
	read USER
	USERCHECK=$(cat /etc/passwd | grep $USER | cut -d ":" -f 1)
	if [ "$USER" != "$USERCHECK" ]
		then
		echo "\e[32mThere is no $USER user yet. Do you wan to create it? [y/n] \e[0m"
		read YN
		case $YN in
		[Yy]* ) adduser $USER ;;
		[Nn]* ) continue ;;
		* ) echo "\e[31menter yes or no\e[0m" ;;
	esac fi
	USERCHECK=$(sudo getent group | grep $USER | cut -d ":" -f 1)
	if [ "$USER" != "$USERCHECK" ]
	then
		echo "\e[32muser $USER not a sudo member. Do you wan to add user $USER to sudoers? [y/n] \e[0m"
		read YN
		case $YN in
		[Yy]* ) adduser $USER sudo ;;
		[Nn]* ) break ;;
		* ) echo "\e[31menter yes or no\e[0m" ;;
esac fi done

while true; do
	echo "\e[32Do you want to take publickey from file? [y/n]\e[0m"
	read YN
	case $YN in
	[Yy]* ) cp ./srcs/.ssh_key /home/$USER/.ssh/authorized_key ;;
	[Nn]* ) ;;
	echo "\e[32Do you want enter publickey manualy? [y/n]\e[0m"
	case $YN in
	[Yy*] ) 
		echo "\e[32m
}
