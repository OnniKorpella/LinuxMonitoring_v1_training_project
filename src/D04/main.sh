#!/bin/bash
. def.conf
COLOR[1]='\033[0;37m';     # white
COLOR[2]='\033[0;31m';     # red
COLOR[3]='\033[0;32m';     # green
COLOR[4]='\033[0;34m';     # blue
COLOR[5]='\033[0;35m';     # purple
COLOR[6]='\033[0;30m';     # black
BACK_COLOR[1]='\033[47m';  # white
BACK_COLOR[2]='\033[41m';  # red
BACK_COLOR[3]='\033[42m';  # green
BACK_COLOR[4]='\033[44m';  # blue
BACK_COLOR[5]='\033[45m';  # purple
BACK_COLOR[6]='\033[40m';  # black
RES='\033[0m';             # Reset color

if [[ $column1_background = 'default' ]] || [[ -z $column1_background ]]; then
  column1_background=5
fi
if [[ $column1_font_color = 'default' ]] || [[ -z $column1_font_color ]]; then
  column1_font_color=3
fi
if [[ $column2_background = 'default' ]] || [[ -z $column2_background ]]; then
  column2_background=6
fi
if [[ $column2_font_color = 'default' ]] || [[ -z $column2_font_color ]]; then
  column2_font_color=4
fi

COLOR_1=${COLOR[$column1_font_color]}
BACK_1=${BACK_COLOR[$column1_background]}
COLOR_2=${COLOR[$column2_font_color]}
BACK_2=${BACK_COLOR[$column2_background]}

echo -e "${COLOR_1}${BACK_1} HOSTNAME        = ${COLOR_2}${BACK_2} $(cat /etc/hostname)${RES}"
echo -e "${COLOR_1}${BACK_1} TIMEZONE        = ${COLOR_2}${BACK_2} $(cat /etc/timezone) UTC $(date +" %:::z")${RES}"
echo -e "${COLOR_1}${BACK_1} USER            = ${COLOR_2}${BACK_2} $USER ${RES}"
echo -e "${COLOR_1}${BACK_1} OS              = ${COLOR_2}${BACK_2} $(cat /etc/issue | awk '{print $1 $2}')${RES}"
echo -e "${COLOR_1}${BACK_1} DATE            = ${COLOR_2}${BACK_2} "$(date +"%d %B %Y %T")"${RES}"
echo -e "${COLOR_1}${BACK_1} UPTIME          = ${COLOR_2}${BACK_2} "$(uptime -p | awk '{print $2" "$3}')"${RES}"
echo -e "${COLOR_1}${BACK_1} UPTIME_SEC      = ${COLOR_2}${BACK_2} "$(cat /proc/uptime | awk '{print int ($1) " seconds"}')"${RES}"
echo -e "${COLOR_1}${BACK_1} IP              = ${COLOR_2}${BACK_2} $( hostname -I | awk '{print $1 }' )${RES}"
echo -e "${COLOR_1}${BACK_1} MASK            = ${COLOR_2}${BACK_2} $( ifconfig | awk '{ if (NR==2) print $4}')${RES}"
echo -e "${COLOR_1}${BACK_1} GATEWAY         = ${COLOR_2}${BACK_2} $( ip n | awk '{if (NR==1) print $1 }')${RES}"
echo -e "${COLOR_1}${BACK_1} RAM_TOTAL       = ${COLOR_2}${BACK_2} "$(free --mebi | awk '/Mem:/{printf "%.3f GB", $2/1024}')"${RES}"
echo -e "${COLOR_1}${BACK_1} RAM_USED        = ${COLOR_2}${BACK_2} "$(free --mebi | awk '/Mem:/{printf "%.3f GB", $3/1024}')"${RES}"
echo -e "${COLOR_1}${BACK_1} RAM_FREE        = ${COLOR_2}${BACK_2} "$(free -m | awk '/Mem/{printf "%.3f GB", $4/1024}')"${RES}"
echo -e "${COLOR_1}${BACK_1} SPACE_ROOT      = ${COLOR_2}${BACK_2} "$(df /root/ | awk '/\/$/ {printf "%.2f MB", $2/1024}')"${RES}"
echo -e "${COLOR_1}${BACK_1} SPACE_ROOT_USED = ${COLOR_2}${BACK_2} "$(df /root/ | awk '/\/$/ {printf "%.2f MB", $3/1024}')"${RES}"
echo -e "${COLOR_1}${BACK_1} SPACE_ROOT_FREE = ${COLOR_2}${BACK_2} "$(df /root/ | awk '/\/$/ {printf "%.2f MB", $4/1024}')"${RES}"

set_color () {
  local color='';
  if   [[ $1 == 1 ]]; then color='white';
  elif [[ $1 == 2 ]]; then color='red';
  elif [[ $1 == 3 ]]; then color='green';
  elif [[ $1 == 4 ]]; then color='blue';
  elif [[ $1 == 5 ]]; then color='purple';
  elif [[ $1 == 6 ]]; then color='black';
  fi
  echo $color;
}

color_1=$(set_color $column1_background);
color_2=$(set_color $column1_font_color);
color_3=$(set_color $column2_background);
color_4=$(set_color $column2_font_color);

echo -en "\n"

echo -en "\n"
if [[  $column1_background == 5 ]]; then
  echo "Column 1 background = default ($color_1)"
  else
  echo "Column 1 background = $column1_background ($color_1)"
fi
if [[ $column1_font_color = 3 ]]; then
  echo "Column 1 font color = default ($color_2)"
  else
  echo "Column 1 font color = $column1_font_color ($color_2)"
fi
if [[ $column2_background = 6 ]]; then
  echo "Column 2 background = default ($color_3)"
  else
  echo "Column 2 background = $column2_background ($color_3)"
fi
if [[ $column2_font_color = 4 ]]; then
  echo "Column 2 font color = default ($color_4)"
  else
  echo "Column 2 font color = $column2_font_color ($color_4)"
fi
