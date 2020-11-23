#!/bin/bash

function ConfirmExecution() {
   echo "スクリプトを実行しますか？y/n"
   read input

   if [ -z $input ] ; then
     ConfirmExecution
   elif [ $input = 'y' ] ; then
	echo "スクリプトを実行します。"
   else
	echo "スクリプトを終了します。"
	exit 1
   fi
}

ConfirmExecution

echo "Helloworld!"
