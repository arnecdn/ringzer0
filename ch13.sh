#!/bin/bash
usage()
{
  echo "Usage: $0 [-s <PHPSESSID>]"
  exit 2
}

while getopts 's:' c
do
  case $c in
    s) SESSIONID=$OPTARG ;;
    h|?) usage ;;
  esac
done

RINGZER0_URL="https://ringzer0ctf.com"

GET_CHALLENGE=$(curl -sb PHPSESSID=$SESSIONID $RINGZER0_URL/challenges/13)
GET_CHALLENGE=$(echo $GET_CHALLENGE| sed -e 's/\r//g' -e 's/<br \/>//g')
GET_CHALLENGE=${GET_CHALLENGE##*----- BEGIN MESSAGE -----}
GET_CHALLENGE=${GET_CHALLENGE%%----- END MESSAGE -----*}

echo $GET_CHALLENGE
#echo $response | sed -n '/<body>/,/<\/body>/{ /body>/d; p }'
#sed -n ''