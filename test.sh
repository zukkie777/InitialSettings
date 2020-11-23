#!/bin/sh

 

echo "へい、いらっしゃい、何にしましょ？"
read menu

 

if [ $menu = "マグロ" ]; then
	    echo "わるいね～。"$menu"は売り切れちゃったよ。"
    else
	        echo "あいよ～。"$menu"お待ち！"
fi
