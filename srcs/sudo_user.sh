#!/bin/bash

sudo_user()
{
echo "\e[32mEnter user's name. This user will be add to sudo. \e[0m"
read USER
USERCHECK=$(cat /etc/passwd | grep $USER | cut -d ":" -f 1)
if [ "$USER" != "$USERCHECK" ]
	then
while true; do
	echo "\e[32mThere is no $USER user yet. Do you wan to create it \e[0m"
	read YN
	case $YN in
	[Yy]* ) adduser $USER && break  ;;
	[Nn]* ) exit ;;
	* ) echo "\e[31menter yes or no\e[0m" ;;
	esac done
fi
while true; do
	echo "\e[32mDo you want to add $USER to sudo? \e[0m"
	read YN
	case $YN in
	[Yy]* ) usermod -aG sudo $USER && break  ;;
	[Nn]* ) exit ;;
	* ) echo "\e[31menter yes or no\e[0m" ;;
esac done

echo "\e[32muser $USER add to sudo\e[0m"
}
