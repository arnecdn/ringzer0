#!/bin/bash
. script_challenge_function.sh

RINGZER0_URL_CHALLENGE="https://ringzer0ctf.com/challenges/32"

while getopts 's:' c
do
  case $c in
    s) SESSIONID=$OPTARG ;;
    h|?) usage "$RINGZER0_URL_CHALLENGE";;
  esac
done

function hash() {
    python3 - <<END
import hashlib

print(hashlib.sha512("$1".encode('utf-8')).hexdigest())
END
}

function bin_to_number() {
python3 - <<END
import binascii
n = int("$1".replace(' ', ''), 2)
print(n)
END
}

GET_CHALLENGE=$(curl -sb PHPSESSID=$SESSIONID $RINGZER0_URL_CHALLENGE)
CHALLENGE_MESSAGE=$(parse_message "$GET_CHALLENGE")
#echo $CHALLENGE_MESSAGE

DECIMAL_NUMBER=${CHALLENGE_MESSAGE%+*}
#echo $DECIMAL_NUMBER

HEX_NUMBER=${CHALLENGE_MESSAGE#*+}
HEX_NUMBER=${HEX_NUMBER%-*}
#echo $(($HEX_NUMBER))

BIN_NUMBER=${CHALLENGE_MESSAGE#*-}
BIN_NUMBER=${BIN_NUMBER%=*}
BIN_NUMBER=$(bin_to_number "$BIN_NUMBER")
#echo $BIN_NUMBER

ANSWER=$(($DECIMAL_NUMBER + $HEX_NUMBER - $BIN_NUMBER))
GET_CHALLENGE_WITH_HASH=$(curl -sb PHPSESSID=$SESSIONID $RINGZER0_URL_CHALLENGE/$ANSWER)
CHALENGE_FLAG=$(parse_flag "$GET_CHALLENGE_WITH_HASH")
echo $CHALENGE_FLAG