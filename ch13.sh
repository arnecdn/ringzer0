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
GET_CHALLENGE=${GET_CHALLENGE##*----- BEGIN MESSAGE ----- }
GET_CHALLENGE=${GET_CHALLENGE%% ----- END MESSAGE -----*}
#echo $GET_CHALLENGE

function hash() {
    python3 - <<END
import hashlib

print(hashlib.sha512("$GET_CHALLENGE".encode('utf-8')).hexdigest())
END
}

GET_CHALLENGE_WITH_HASH=$(curl -sb PHPSESSID=$SESSIONID $RINGZER0_URL/challenges/13/$(hash))
echo $GET_CHALLENGE_WITH_HASH