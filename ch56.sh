#!/bin/bash
. script_challenge_function.sh

RINGZER0_URL_CHALLENGE="https://ringzer0ctf.com/challenges/56"

while getopts 's:' c
do
  case $c in
    s) SESSIONID=$OPTARG ;;
    h|?) usage "$RINGZER0_URL_CHALLENGE";;
  esac
done

GET_CHALLENGE=$(curl -sb PHPSESSID=$SESSIONID $RINGZER0_URL_CHALLENGE)
CHALLENGE_HASH=$(parse_hash "$GET_CHALLENGE")
#echo $CHALLENGE_HASH

GET_CRACKED_SHA1=$(curl -s -X GET https://hashtoolkit.com/reverse-sha1-hash/$CHALLENGE_HASH)
#echo $GET_CRACKED_SHA1

#GET_CHALLENGE_WITH_HASH=$(curl -sb PHPSESSID=$SESSIONID $RINGZER0_URL_CHALLENGE/$ANSWER)
CRACKED_SHA1=$(parse_content_between_tags "$GET_CRACKED_SHA1" "Hashes for: <code>" "</code>")


GET_CHALLENGE_WITH_CRACKED_HASH=$(curl -sb PHPSESSID=$SESSIONID $RINGZER0_URL_CHALLENGE/$CRACKED_SHA1)
#echo $GET_CHALLENGE_WITH_CRACKED_HASH

CHALENGE_FLAG=$(parse_flag "$GET_CHALLENGE_WITH_CRACKED_HASH")
echo $CHALENGE_FLAG
