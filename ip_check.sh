#!/bin/bash

IP=$1
IP_CHECK=$(echo ${IP} | egrep "^(([1-9]?[0-9]|1[0-9]{2}|2[0-4][0-9]|25[0-5])\.){3}([1-9]?[0-9]|1[0-9]{2}|2[0-4][0-9]|25[0-5])$")

if [ ! "${IP_CHECK}" ] ; then
	    #echo [ERROR] ${IP} is not IP Address.
	    #echo  以下の[入力値エラー発生により処理を中断しました。 システム管理者に確認し正しい値を入力して下さい。
	    echo  ${IP} は適切なIPアドレスではありません。
	        exit 1
fi

exit 0
