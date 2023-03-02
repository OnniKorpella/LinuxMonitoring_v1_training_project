#!/bin/bash

read -p "Save in file? Y/n " input
if [ $input = y ] || [ $input = Y ]
then 
file="$(date +'%d_%m_%y_%H_%M_%S.status')"

foo () {
echo "HOSTNAME = $(cat /etc/hostname)"
echo "TIMEZONE = $(cat /etc/timezone) UTC $(date +" %:::z")"
echo "USER = $USER"
echo "OS = $(cat /etc/issue | awk '{print $1 $2}')"
echo "DATE = "$(date +"%d %B %Y %T")""
echo "UPTIME = "$(uptime -p | awk '{print $2" "$3}')""
echo "UPTIME_SEC = "$(cat /proc/uptime | awk '{print int ($1) " seconds"}')""
echo "IP = $( hostname -I | awk '{print $1 }' )"
echo "MASK = $( ifconfig | awk '{ if (NR==2) print $4}' )"
echo "GATEWAY = $( ip n | awk '{if (NR==1) print $1 }' )"
echo "RAM_TOTAL = "$(free --mebi | awk '{if (NR==2) printf "%.3f GB", $2 / 1024}')""
echo "RAM_USED = "$(free --mebi | awk '{if (NR==2) printf "%.3f GB", $3 / 1024}')""
echo "RAM_FREE = "$(free -k | awk '{if (NR==2) printf "%.2f MB", $4 / 1024 }')""
echo "SPACE_ROOT = "$(df /root/ | awk '{if (NR == 2) printf "%.2f MB", $2/1024}')""
echo "SPACE_ROOT_USED = "$(df /root/ | awk '{if (NR == 2) printf "%.2f MB", $3/1024}')""
echo "SPACE_ROOT_FREE = "$(df /root/ | awk '{if (NR == 2) printf "%.2f MB", $4/1024}')""
}

foo > "$file"
echo "File created"
else
    echo "File not created"
fi 
