#!/bin/bash
# このスクリプトの使用方法を表示
# 引数にファイルが付与されない場合はUsage表示
if [ $# -ne 1 ]; then
	  echo " "
  echo "Usage:# bash $0 input.csv"
	  echo " "
	  echo "1)スクリプト実行時は必要項目を記入したCSVファイルを引数に与えて下さい "
	  echo "     引数に付与するCSVファイル名は任意のファイル名で構いません "
	  echo " "
	  echo "2)CSVファイルの記入内容は以下として下さい。 "
	  echo " "
	  echo "   第1引数 (必須): DHCP or FIXED-IP のいずれかを入力して下さい。 "
	  echo "     ＊DHCP入力時は以降項目の入力は不要です。"
	  echo "   第2引数 (必須): 固定IPアドレスを入力して下さい "
	  echo "   第3引数 (必須): サブネットマスクを入力して下さい"
	  echo "   第4引数 (必須): ゲートウェイアドレスを入力して下さい"
	  echo "   第5引数 (必須): DNS1台目のアドレスを入力して下さい"
	  echo "   第6引数 (任意): DNS2台目のアドレスを入力して下さい"
	  echo "   第7引数 (任意): DNS3台目のアドレスを入力して下さい"
	  echo "   第8引数 (任意): 1つ目のドメインを入力して下さい"
	  echo "   第9引数 (任意): 2つ目のドメインを入力して下さい"
	  echo "   第10引数(任意): 3つ目のドメインを入力して下さい"

	    exit 1
	   
    else
#	      echo "eeyan"
while read row; do
	            item1=`echo ${row} | cut -d , -f 1`
		    item2=`echo ${row} | cut -d , -f 2`
		    item3=`echo ${row} | cut -d , -f 3`
		    item4=`echo ${row} | cut -d , -f 4`
		    item5=`echo ${row} | cut -d , -f 5`
		    item6=`echo ${row} | cut -d , -f 6`
		    item7=`echo ${row} | cut -d , -f 7`
		    item8=`echo ${row} | cut -d , -f 8`
		    item9=`echo ${row} | cut -d , -f 9`
		    item10=`echo ${row} | cut -d , -f 10`
		    
if  test -e *.log ; then
    rm *.log
fi


# DHCP設定への変更用スクリプト
if test "${item1}" = "DHCP" ; then
	echo "ネットワーク設定は以下の内容に変更します。"
	echo "--------------------------------------------"
	echo "IPアドレスは自働取得設定に変更します。"
	#echo "cp 00-installer-config.yaml /etc/netplan/."
	#cp 00-installer-config.yaml /etc/netplan/."
	#echo "netplan --debug generate"
	#netplan --debug generate
	#echo "netplan apply"
	#netplan apply
	  echo "    " >error.log 
	  echo "    " >>error.log 
	  echo "    " >>error.log 
	  echo "ネットワークの設定変更が完了しました。" >>error.log 
	  echo "IPアドレスは自働取得設定に変更しました。" >>error.log 
	  echo "    " >>error.log 
	  echo "    " >>error.log 
	  echo "    " >>error.log 
	cat error.log
	exit

elif test "${item1}" = "FIXED-IP" ; then
IPAddress=${item2}
SubnetMasks=${item3}

# サブネットマスク=>プレフィックス標記への変換テーブル
Prefix=`grep "${item3}"  ConvertNetmasks.tbl |cut -f 1`
GateWayAddress=${item4}
NameServer1=${item5}

# error.logの生成
bash ip_check.sh ${item2}  >error.log

# サブネットマスクの入力値チェック
if  test -z "$Prefix"   ; then
	echo "${item3} は適切なサブネットマスクではありません。" >>error.log 
fi
# IPアドレスの入力値チェック
bash ip_check.sh ${item4}  >>error.log
bash ip_check.sh ${item5}  >>error.log
if  test -n "${item6}" ; then
   bash ip_check.sh ${item6}  >>error.log
fi
if  test -n "${item7}" ; then
   bash ip_check.sh ${item7}  >>error.log 
fi

# DNSサーバアドレス用変換(任意値)
if  test -n "${item6}" ; then
	NameServer2=", ${item6}"
fi
if  test -n "${item7}" ; then
	NameServer3=", ${item7}"
fi
# Domain用変換(任意値）
if  test -n "${item8}" ; then
	Domain1=${item8}
fi
if  test -n "${item9}" ; then
	Domain2=,${item9}
fi
if  test -n "${item10}" ; then
	Domain3=,${item10}
fi

# error.log存在する場合は標準出力後処理停止
if  test -s error.log ; then
    cat error.log
    exit 1
fi
	echo "    "
	echo "    "
	echo "    "
	echo "ネットーワーク設定は以下の内容に変更します。"
	echo "--------------------------------------------"
	## NetworkAddress
	#echo "${item2}"
	#
	## IPAddress
	#echo "${item2}"
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
	#echo "${item4}"
	#echo "$GateWayAddress"
	#
	# NameServers
	echo "NameServers:" `echo "$NameServer1"``echo "$NameServer2"``echo "$NameServer3"`
	#echo "$NameServer1"
	#echo "$NameServer2"
	#echo "$NameServer3"
	# Domain
	echo "Domain:" `echo "$Domain1"``echo "$Domain2"``echo "$Domain3"`
	echo "--------------------------------------------"
	echo "  "
	echo "  "
	echo "  "
#	
# 固定IPアドレス設定変更用YAMLファイル生成 	
echo "network:"	>99_config.yaml
echo "   version: 2"	>>99_config.yaml
echo "   renderer: networkd" >>99_config.yaml
echo "   ethernets:"	>>99_config.yaml
echo "     eno1:"       >>99_config.yaml
echo "        dhcp4: false" >>99_config.yaml
echo "        dhcp6: false" >>99_config.yaml
echo "        addresses: [$IPAddress$Prefix]" >>99_config.yaml
echo "        gateway4: $GateWayAddress" >>99_config.yaml
echo "        nameservers:"			>>99_config.yaml
echo "          search: [$Domain1$Domain2$Domain3]"  >>99_config.yaml
echo "          addresses: [$NameServer1$NameServer2$NameServer3]" >>99_config.yaml
#
# ネットワーク設定変更用スクリプト
	echo "cp 99_config.yaml /etc/netplan/."
	cp 99_config.yaml /etc/netplan/.
	#echo "netplan --debug generate" >&  netplan-generate.log
	netplan --debug generate >&  netplan-generate.log
	grep Invalid netplan-generate.log > err.netplan-generate.log
	if test -s err.netplan-generate.log ; then
		echo "不正な設定ファイルが生成された為,処理を停止しました。" >error.log 
		exit
	else
	  echo "netplan apply"
	  netplan apply
	  sleep 5
	  cp /run/systemd/resolve/resolv.conf /etc/resolv.conf >&   error.log
	  cp /run/systemd/resolve/resolv.conf /etc/systemd/resolve.conf >&   error.log
	  cp /run/systemd/network/10-netplan-eno1.network /etc/systemd/network >& error.log


	  echo "    " >>error.log 
	  echo "    " >>error.log 
	  echo "    " >>error.log 
	  echo "ネットワークの設定変更が完了しました。" >>error.log 
	  echo "IPアドレスは以下の固定IPアドレス設定に変更しました。" >>error.log 
	  echo "----------------------------------------------------" >>error.log 
	  echo IPAddress: `echo "$IPAddress"` >>error.log
	  echo SubnetMasks: `echo "$SubnetMasks" `>>error.log
	  echo GateWayAddress: `echo "$GateWayAddress"` >>error.log
	  echo "NameServers:" `echo "$NameServer1"``echo "$NameServer2"``echo "$NameServer3"` >>error.log
	  echo "Domain:" `echo "$Domain1"``echo "$Domain2"``echo "$Domain3"` >>error.log
	  echo "    " >>error.log 
	  echo "    " >>error.log 
	  echo "    " >>error.log 
	  cat error.log
        fi


else
	echo "INPUT ERROR!"	
fi
done < $1 

fi
