#!/bin/bash
. script_challenge_function.sh

RINGZER0_URL_CHALLENGE="https://ringzer0ctf.com/challenges/15"

while getopts 's:' c
do
  case $c in
    s) SESSIONID=$OPTARG ;;
    h|?) usage "$RINGZER0_URL_CHALLENGE";;
  esac
done

GET_CHALLENGE=$(curl -sb PHPSESSID=$SESSIONID $RINGZER0_URL_CHALLENGE)

ELF_MESSAGE=$(parse_content_between_tags "$GET_CHALLENGE" "----- BEGIN Elf Message -----" "----- End Elf Message -----")
DECODED_ELF_MESSAGE=$(echo $ELF_MESSAGE | base64 -d) 
echo $DECODED_ELF_MESSAGE

ELF_CHECKSUM=$(parse_content_between_tags "$GET_CHALLENGE" "---- BEGIN Checksum -----" "----- END Checksum -----")
#echo $ELF_CHECKSUM

#CHALENGE_FLAG=$(parse_flag "$GET_CHALLENGE_WITH_CRACKED_HASH")
#echo $CHALENGE_FLAG
