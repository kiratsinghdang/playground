#!/bin/bash

#################################################
# Debug Information
#
# usage bash debug+.sh <starting ip> <end ip>
# eg: bash debug+.sh 201 210
##################################################

i=$1
e=$2

LOG_DIR_PATH="/home/kirat/Desktop/Bangalore-alpha-Cert"

logging() {
	echo "please enter a log name"
	read name
	touch ${LOG_DIR_PATH}/$name
	LOG="${LOG_DIR_PATH}/$name"
	echo "start logging $name" | tee -a ${LOG}
}

test() {
	
	ping 192.168.1.$i -c 1 > /dev/null
	RC=$?
  	if [ $RC -eq 0 ]; then 
	echo "@@@@@@@@@@@@@" | tee -a ${LOG}
	echo -e "$i reachable" | tee -a ${LOG}
	echo "@@@@@@@@@@@@@"
        echo "" | tee -a ${LOG}
 
ssh -o StrictHostKeyChecking=no pi@192.168.1.$i  -i ~/VMC-Releases/vmc-1.7.8/keys/vmc-key.pem "echo '*****Monit Summary*****' && echo '' && sudo monit summary && echo '' && echo '*****Pi Config*****' && echo '' && cat base_config.conf && echo'' && echo '*******DEBUG INFO********' && sudo sh /home/pi/scripts/debug.sh " | tee -a ${LOG}

	elif [ $RC -eq 1 ]; then
		echo "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"| tee -a ${LOG}
		echo "*****$i Unreachable / Doesn't exist*****" | tee -a ${LOG}
		echo "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"| tee -a ${LOG}
		echo ""
fi
}

logging

while : 
do
test
i=`expr $i + 1` 
if [ $i -gt $e ]; then
i="250" && test
exit 
fi 
done

# end

