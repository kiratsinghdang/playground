#!/bin/bash

LOG_DIR_PATH="/home/kirat/Desktop/updated-stations"

		echo "please enter a log name"
		read name
	        touch ${LOG_DIR_PATH}/$name
		LOG="${LOG_DIR_PATH}/$name"
		echo "start logging $name" | tee -a ${LOG}

		ssh pi@192.168.1.250 -i ~/.ssh/vmc-key.pem -o StrictHostKeyChecking=no "rm scripts/playlist_update.sh"
	if [ "$?" == "0" ]; then
	
		echo "Deleted playlist_update.sh from pi sripts" | tee -a ${LOG}

      rsync -avzP ~/Downloads/playlist_update.sh pi@192.168.1.250:/scripts -e "ssh -i ~/.ssh/vmc-key.pem -o StrictHostKeyChecking=no" | tee -a ${LOG}

 		     echo "Done."

	     else
		echo "Please check the connection to 250" | tee -a ${LOG}
		rm "${LOG_DIR_PATH}/$name"
		echo "Deleted the generated file $name" | tee -a ${LOG}
	fi
