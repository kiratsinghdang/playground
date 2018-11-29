#!/bin/bash

name="$2"
image_path="$1"
		echo "Please enter the first partition"
		read "partition1"
		umount /dev/"$partition1"
		echo "Please enter the second partition"
		read "partition2"
		umount /dev/"$partition2"
	#	RCX=$?
	#	if [ "$RCX" -eq 0 ];
	#	then
		sudo dd bs=8M if=$1 of=/dev/$2 status=progress conv=fsync
	#	fi
		exit

# end
