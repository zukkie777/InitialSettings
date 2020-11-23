#!/bin/bash
InputErrorIPAddress=`bash ip_check.sh $2`
InputErrorGateWayAddress=`bash ip_check.sh $4`
InputErrorNameServer1=`bash ip_check.sh $5`
InputErrorNameServer2=`bash ip_check.sh $6`
InputErrorNameServer3=`bash ip_check.sh $7` 
#if test -n "$InputErrorIPAddress" ; then
if test -n "$InputErrorIPAddress" -o -n "$InputErrorGateWayAddress" -o -n InputErrorNameServer1 ; then
	echo "$InputErrorIPAddress"
	echo "$InputErrorGateWayAddress"
	echo "$InputErrorNameServer1"
#fi	
#if  test -n "$6" -a -n "$InputErrorNameServer2" -o -n "$7" -a -n "$InputErrorNameServer3"  ; then
#if  ( test -n "$6" && test -n "$InputErrorNameServer2" ) || ( test -n "$7" && test -n "$InputErrorNameServer3" )  ; then
#	echo "$InputErrorNameServer2"
	#echo "$InputErrorNameServer3"
if  ( test -n "$6" && test -n "$InputErrorNameServer2" )  ; then
	echo "$InputErrorNameServer2"
fi
if  ( test -n "$7" && test -n "$InputErrorNameServer3" )  ; then
	echo "$InputErrorNameServer3"
fi


IPAddress=$2
SubnetMasks=$3
# サブネットマスクをプレフィックス標記用の変換テーブル
Prefix=`grep "$3"  ConvertNetmasks.tbl |cut -f 1`
GateWayAddress=$4
NameServer1=$5

if  test -z "$Prefix"   ; then
	echo "[入力値エラー] $3 は適切な入力値ではありません。システム管理者に確認し正しい値を入力して下さい。"
	exit

fi
fi	
fi

if  test -n "$6" ; then
	NameServer2=,$6
fi

if  test -n "$7" ; then
	NameServer3=,$7
fi

if test "$1" = "DHCP" ; then
	echo "cp 00-installer-config.yaml /etc/netplan/."
	echo "netplan --debug generate"
	echo "netplan apply"
elif test "$1" = "FIXED-IP" ; then
	echo "------------------------"
	echo "  "
	echo "  "
	echo "  "
	## NetworkAddress
	#echo "$2"
	#
	## IPAddress
	#echo "$2"
	echo IPAddress: `echo "$IPAddress"`
	#echo "IPAddress" echo "$IPAddress"
	#echo "$IPAddress"
	#
	## SubnetMasks
	echo SubnetMasks: `echo "$SubnetMasks"`
	#echo "$SubnetMasks"
	#
	# Prefix
	echo Prefix: `echo "$Prefix"` 	
	#echo "$Prefix"	
	#
	# GateWayAddress
	echo GateWayAddress: `echo "$GateWayAddress"`
	#echo "$4"
	#echo "$GateWayAddress"
	#
	# NameServers
	echo "NameServers:" `echo "$NameServer1"``echo "$NameServer2"``echo "$NameServer3"`
	#echo "$NameServer1"
	#echo "$NameServer2"
	#echo "$NameServer3"
	echo "------------------------"
	echo "  "
	echo "  "
	echo "  "
	
echo "	network:"	>99_config.yaml
echo "	  version: 2"	>>99_config.yaml
echo "	  renderer: networkd" >>99_config.yaml
echo "	  ethernets:"	>>99_config.yaml
echo "	    eno1:"       >>99_config.yaml
echo "	    dhcp4: false" >>99_config.yaml
echo "	    dhcp6: false" >>99_config.yaml
echo "	    addresses: [$IPAddress$Prefix]" >>99_config.yaml
echo "	    gateway4: $GateWayAddress" >>99_config.yaml
echo "	    nameservers:"			>>99_config.yaml
echo "	      addresses: [$NameServer1$NameServer2$NameServer3]" >>99_config.yaml
# excute change network address
	echo "cp 99_config.yaml /etc/netplan/."
	echo "netplan --debug generate"
	echo "netplan apply"

else
	echo "INPUT ERROR!"	
fi
