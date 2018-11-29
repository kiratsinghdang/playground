#!/bin/bash

X=($(ssh etomer@storage-2.vyoma-media.com -p 2222 -i ~/.ssh/server-key.pem "cat /opt/TEST_SCRIPT/playlist/Bengaluru-ddis/*/*.config | sort -u"))

#z=($(cat /opt/content-update/Bengaluru-ddis/*/*.config |grep -v "^$" | sort -u ))

Y=($(cat /opt/content-update/Bengaluru/*/*.config | grep -v "^$" | sort -u))

Array3=()
 for i in "${X[@]}"; do
     skip=
     for j in "${Y[@]}"; do
         [[ $i == $j ]] && { skip=1; break; }
     done
     [[ -n $skip ]] || Array3+=("$i")
 done
#declare -p Array3

if [[ -z ${Array3[@]} ]];
then
	echo "Everything is in sync"
else
	echo "Not Found Locally :"
	echo "${Array3[@]}" |sed "s/ /\n/g"
fi
