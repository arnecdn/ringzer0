#!/bin/bash
usage()
{
  echo "Usage: $0 [-s <PHPSESSID>] Solves CTF challenge https://ringzer0ctf.com/challenges/14"
  exit 2
}

while getopts 's:' c
do
  case $c in
    s) SESSIONID=$OPTARG ;;
    h|?) usage ;;
  esac
done

RINGZER0_URL_CHALLENGE="https://ringzer0ctf.com/challenges/14"

GET_CHALLENGE=$(curl -sb PHPSESSID=$SESSIONID $RINGZER0_URL_CHALLENGE)
GET_CHALLENGE=$(echo $GET_CHALLENGE| sed -e 's/\r//g' -e 's/<br \/>//g')
GET_CHALLENGE=${GET_CHALLENGE##*----- BEGIN MESSAGE ----- }
GET_CHALLENGE=${GET_CHALLENGE%% ----- END MESSAGE -----*}
#echo $GET_CHALLENGE

function hash() {
    python3 - <<END
import hashlib
import binascii
n = int("$GET_CHALLENGE".replace(' ', ''), 2)
sha512text = n.to_bytes((n.bit_length() + 7) // 8, 'big').decode()

print(hashlib.sha512(sha512text.encode('utf-8')).hexdigest())
END
}

GET_CHALLENGE_WITH_HASH=$(curl -sb PHPSESSID=$SESSIONID $RINGZER0_URL_CHALLENGE/$(hash))
GET_CHALLENGE_WITH_HASH=${GET_CHALLENGE_WITH_HASH##*<div class=\"alert alert-info\">}
GET_CHALLENGE_WITH_HASH=${GET_CHALLENGE_WITH_HASH%%</div>*}

echo $GET_CHALLENGE_WITH_HASH