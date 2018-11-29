#!/bin/bash

LOG_PATH="$1"
WHERE="$2"
WHAT="$3"

cd ${LOG_PATH}
if [ "${WHERE}" = "Ka" ]
then
	LOGS='Ka*'
elif [ "${WHERE}" = "Dl" ]
then
	LOGS='Dl*'
elif [ "${WHERE}" = "Mh" ]
then
        LOGS='Mh*'
else
	echo "Station/Region name didn't match defined names in my list."
	exit 1
fi
# fgrep -R "${WHAT}" ${LOGS} |cut -d" " -f7 |sort -u 
for state in `ls -1tr |grep ${WHERE}*`
do
	echo "Searching HOSTNAME: ${state}"
	fgrep -i -R "${WHAT}" `find ${state} -type f -printf '%T@ %p\n' | sort -n | tail -5 | cut -f2- -d" "` 2>/dev/null|cut -d" " -f7 |sort -u 
	test ${PIPESTATUS[0]} -eq 0
	RC=$?
	if [ "$RC" = "0" ]
		then
			echo "Ad found in PlayAd Logs."
		exit 0
	else
			echo "Ad not found in PlayAd Logs. Checking in Content Update logs."
			cd ${LOG_PATH}/content_update_log
			for contentstate in `ls -tr ${WHERE}*`
do
	fgrep -i -R "${WHAT}" `find ${contentstate} -type f -printf '%T@ %p\n' | sort -n | tail -5 | cut -f2- -d" "` 2>/dev/null|grep -v deleting
		RCC=$?
		if [ "$RCC" = "0" ]
	then
			echo "Ad found in content list, now checking XML file."
			cd ${LOG_PATH}/playlist_xml/
			for state in `ls -tr |grep ${WHERE}*`
			do
                        		print $state
                                        # cd $state
					# fgrep -i -R "${WHAT}" `ls -tr *.xml |tail -2`
					RCX=$?
					if [ "$RCX" = "0" ]
					then
						echo "Found ad in XML"
					else
						echo "File not present in playAd, content or XML file."
					fi
				done
			else
				echo "No such ad in Content or Playlist."
				exit 1
			fi
		done
	fi
done
