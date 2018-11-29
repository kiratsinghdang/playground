#!/bin/bash -x
# 
# script for search strings in config file.


        echo "Which folder do you want to search ?"
        echo "Enter 1 for Bengaluru"
        echo "Enter 2 for Mumbai"
        echo "Enter 3 for Hyderabad"
        echo "Enter 4 for Delhi"
        read choice
          if [ $choice -eq "1" ] || [ "$choice" == "Bengaluru" ]; then
             output=$(ag "$1" /opt/content-update/Bengaluru -i --ignore *~)
             stat=$?
          elif [ $choice -eq "2" ] || [ $choice == "Mumbai" ]; then
             output=$(ag "$1" /opt/content-update/Mumbai -i --ignore *~)
             stat=$?
          elif [ $choice -eq "3" ] || [ $choice == "Hyderabad" ]; then
             output=$(ag "$1" /opt/content-update/Hyderabad -i --ignore *~)
             stat=$?
          elif [ $choice -eq "4" ] || [ $choice == "Delhi" ]; then
             output=$(ag "$1" /opt/content-update/Delhi -i --ignore *~)
             stat=$?
          fi

        if [ ! -z "$output" ]; then
           for i in $output
           do
             echo $i
           done
        else
       echo "Does not exist, please verify"
        fi

#end
