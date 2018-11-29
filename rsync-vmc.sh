#!/bin/bash

i=$1
e=$2

LOG_DIR_PATH="/home/kirat/Documents/Bangalore"

logging() {
echo "please enter a Bay name"
read bayname
mkdir ${LOG_DIR_PATH}/$bayname
LOG="${LOG_DIR_PATH}/$bayname"
}

test() {        
	        echo "ip end-"$i
		ping 192.168.1.$i -c 1 > /dev/null  
		RC=$?
		if [ "$RC" -eq 0 ]; then 
		   	echo "Ping successful for $i, rsyncing now :)"
			
			RCX=$(ssh pi@192.168.1.$i -o StrictHostKeyChecking=no "hostname")
			rsync -az  pi@192.168.1.$i:/home/pi/vmc.txt  ${LOG_DIR_PATH}/$bayname/$RCX.txt  -e "ssh -o StrictHostKeyChecking=no"
			echo "rync done!"

		elif  [ "$RC" -eq 1 ]; then
		echo "*** WARNING *** Ping Unsuccessful for $i, make sure the ip exists"
	
		fi
}

email() {
	rf=$?
	echo $rf
	if [ "$rf" -eq 0  ]; then
	   echo "Sending email"
       	   echo "Processing tar"
	   cd /home/kirat/Documents/Bangalore
	   tar cvzf $bayname.tar.gz $bayname
	   printf "Please check for the enclosed files !" | mutt -s "$bayname vmc.txt" -a test/$bayname.tar.gz -- kirat@vyoma-media.in
        fi
}

logging

while :
do
  test
  i=`expr $i + 1`
  if [ $i -gt $e ]; then
     i="250" && test
     email
     exit  
  fi
done


# end
