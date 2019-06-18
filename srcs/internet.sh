#!/bin/bash
static_ip()
{
INTERFACE=$(ip route | grep default | awk '{print $5}')
CHECKFILE=$(cat /etc/network/interfaces | grep $INTERFACE | grep dhcp | awk '{print $2}')
if [ "$INTERFACE" != "$CHECKFILE" ]
then
	echo "\e[31mError with /etc/network/interfaces file. There is no file/interface or configuration was done before.\e[0m"
	exit
fi
while true
	do
	echo "\e[32mEnter ip-address for interface $INTERFACE.(standart=10.0.2.4): \e[0m"
	read IPADDR
	echo "\e[32mEnter ip-address for netmask.(recomended 255.255.255.252): \e[0m"
	read NETMASK
	echo "\e[32mEnter ip-address for gateway.(recomended 10.0.2.2 for oracle VM): \e[0m"
	read GATEWAY
	echo "\e[32mEnter ip-address for DNS.(f.e 8.8.8.8): \e[0m"
	read DNS
	read -p "Is this correct?
interface: $INTERFACE.
address $IPADDR
netmask $NETMASK
gateway $GATEWAY
dns-nameserver $DNS:  " YN
	case $YN in
	[yY]* ) break;;
	[nN]* ) echo -e "\e[32mDo you want enter another parameters?  \e[0m"
		read yn
		case $yn in
		[yY]* ) continue;;
		[nN]* )  exit;;
		esac;;
	esac done
sed -i.bak "/iface $INTERFACE inet dhcp/d" /etc/network/interfaces
echo "iface $INTERFACE inet static\naddress $IPADDR\nnetmask $NETMASK\ngateway $GATEWAY\ndns-nameserver $DNS/" > /etc/network/interfaces.d/$INTERFACE

echo "\e[32static ip successfully configuratede\e[0m"
}
