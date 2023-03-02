#!/bin/bash
if (( $# > 4 )); then
    echo "Error 1: 4 parameters are required";
    exit 1;
elif [[ $# < 4 ]]; then
    echo "Error 2: 4 parameters are required";
    exit 2;
elif [[ $1 == $2 ]] || [[ $3 == $4 ]]; then
    echo "Error 3: The font and background colors of the same column should not match";
    exit 3;
fi

for param in $@; do
    if [[ ! $param =~ ^[0-9]+$ ]]; then
        echo "Error 4: The param must be a number";
        exit 4;
    elif (( $param < 1 )) | (( $param > 6 )); then
        echo "Error 5: The param must be in 1..6 integer range";
        exit 5;
    fi
done

COLOR[1]='\033[0;37m';  # white
COLOR[2]='\033[0;31m';  # red
COLOR[3]='\033[0;32m';  # green
COLOR[4]='\033[0;34m';  # blue
COLOR[5]='\033[0;35m';  # purple
COLOR[6]='\033[0;30m';  # black
BACK_COLOR[1]='\033[47m';  # white
BACK_COLOR[2]='\033[41m';  # red
BACK_COLOR[3]='\033[42m';  # green
BACK_COLOR[4]='\033[44m';  # blue
BACK_COLOR[5]='\033[45m';  # purple
BACK_COLOR[6]='\033[40m';  # black
RES='\033[0m';         # Reset color

echo -e  "${COLOR[$2]}${BACK_COLOR[$1]} HOSTNAME ${RES} = ${COLOR[$4]}${BACK_COLOR[$3]} $(cat /etc/hostname)${RES}"
echo -e  "${COLOR[$2]}${BACK_COLOR[$1]} TIMEZONE ${RES} = ${COLOR[$4]}${BACK_COLOR[$3]} $(cat /etc/timezone) UTC $(date +" %:::z")${RES}"
echo -e  "${COLOR[$2]}${BACK_COLOR[$1]} USER ${RES} = ${COLOR[$4]}${BACK_COLOR[$3]} $USER ${RES}"
echo -e  "${COLOR[$2]}${BACK_COLOR[$1]} OS ${RES} = ${COLOR[$4]}${BACK_COLOR[$3]} $(cat /etc/issue | awk '{print $1 $2}')${RES}"
echo -e  "${COLOR[$2]}${BACK_COLOR[$1]} DATE ${RES} = ${COLOR[$4]}${BACK_COLOR[$3]} "$(date +"%d %B %Y %T")"${RES}"
echo -e  "${COLOR[$2]}${BACK_COLOR[$1]} UPTIME ${RES} = ${COLOR[$4]}${BACK_COLOR[$3]} "$(uptime -p | awk '{print $2" "$3}')"${RES}"
echo -e  "${COLOR[$2]}${BACK_COLOR[$1]} UPTIME_SEC ${RES} = ${COLOR[$4]}${BACK_COLOR[$3]} "$(cat /proc/uptime | awk '{print int ($1) " seconds"}')"${RES}"
echo -e  "${COLOR[$2]}${BACK_COLOR[$1]} IP ${RES} = ${COLOR[$4]}${BACK_COLOR[$3]} $( hostname -I | awk '{print $1 }' )${RES}"
echo -e  "${COLOR[$2]}${BACK_COLOR[$1]} MASK ${RES} = ${COLOR[$4]}${BACK_COLOR[$3]} $( ifconfig | awk '{ if (NR==2) print $4}')${RES}"
echo -e  "${COLOR[$2]}${BACK_COLOR[$1]} GATEWAY ${RES} = ${COLOR[$4]}${BACK_COLOR[$3]} $( ip n | awk '{if (NR==1) print $1 }')${RES}"
echo -e  "${COLOR[$2]}${BACK_COLOR[$1]} RAM_TOTAL ${RES} = ${COLOR[$4]}${BACK_COLOR[$3]} "$(free --mebi | awk '/Mem:/{printf "%.3f GB", $2/1024}')"${RES}"
echo -e  "${COLOR[$2]}${BACK_COLOR[$1]} RAM_USED ${RES} = ${COLOR[$4]}${BACK_COLOR[$3]} "$(free --mebi | awk '/Mem:/{printf "%.3f GB", $3/1024}')"${RES}"
echo -e  "${COLOR[$2]}${BACK_COLOR[$1]} RAM_FREE ${RES} = ${COLOR[$4]}${BACK_COLOR[$3]} "$(free -m | awk '/Mem/{printf "%.3f GB", $4/1024}')"${RES}"
echo -e  "${COLOR[$2]}${BACK_COLOR[$1]} SPACE_ROOT ${RES} = ${COLOR[$4]}${BACK_COLOR[$3]} "$(df /root/ | awk '/\/$/ {printf "%.2f MB", $2/1024}')"${RES}"
echo -e  "${COLOR[$2]}${BACK_COLOR[$1]} SPACE_ROOT_USED ${RES} = ${COLOR[$4]}${BACK_COLOR[$3]} "$(df /root/ | awk '/\/$/ {printf "%.2f MB", $3/1024}')"${RES}"
echo -e  "${COLOR[$2]}${BACK_COLOR[$1]} SPACE_ROOT_FREE ${RES} = ${COLOR[$4]}${BACK_COLOR[$3]} "$(df /root/ | awk '/\/$/ {printf "%.2f MB", $4/1024}')"${RES}"
