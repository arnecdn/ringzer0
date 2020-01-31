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

GENERATED_CHECKSUM="1"
RECEIVED_CHECKSUM="0"

while [[ $GENERATED_CHECKSUM != $RECEIVED_CHECKSUM ]]; do
  GET_CHALLENGE=$(curl -sb PHPSESSID=$SESSIONID $RINGZER0_URL_CHALLENGE)

  RECEIVED_CHECKSUM=$(parse_content_between_tags "$GET_CHALLENGE" "---- BEGIN Checksum -----" "----- END Checksum -----")
  echo "Mottatt sjekksum:  $RECEIVED_CHECKSUM"  

  ELF_MESSAGE=$(parse_content_between_tags "$GET_CHALLENGE" "----- BEGIN Elf Message -----" "----- End Elf Message -----")
  DECODED_ELF_MESSAGE=$(printf $ELF_MESSAGE | base64 -d) 

  GENERATED_CHECKSUM=$(echo $ELF_MESSAGE | openssl dgst -md5 | sed -e 's/(stdin)=//g' -e 's/ //g')
  echo "Generert sjekksum: $GENERATED_CHECKSUM"
  
done

if [[ $GENERATED_CHECKSUM = $RECEIVED_CHECKSUM ]]; then
  echo "Riktig shekksum:   $RECEIVED_CHECKSUM"
fi


#echo $ELF_CHECKSUM

#CHALENGE_FLAG=$(parse_flag "$GET_CHALLENGE_WITH_CRACKED_HASH")
#echo $CHALENGE_FLAG
