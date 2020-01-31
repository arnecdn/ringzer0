#!/bin/bash
. script_challenge_function.sh

RINGZER0_URL_CHALLENGE="https://ringzer0ctf.com/challenges/121"

while getopts 's:' c
do
  case $c in
    s) SESSIONID=$OPTARG ;;
    h|?) usage "$RINGZER0_URL_CHALLENGE";;
  esac
done

GET_CHALLENGE=$(curl -sb PHPSESSID=$SESSIONID $RINGZER0_URL_CHALLENGE)

RECEIVED_HEX=$(parse_content_between_tags "$GET_CHALLENGE" "---- BEGIN SHELLCODE -----" "----- END SHELLCODE -----")
#echo -e -n $RECEIVED_HEX > ch121.bin

#RECEIVED_HEX="\xeb\x4d\x5e\x66\x83\xec\x0c\x48\x89\xe0\x48\x31\xc9\x68\x8e\x6a\xdf\x91\x48\x89\xcf\x80\xc1\x0c\x40\x8a\x3e\x40\xf6\xd7\x40\x88\x38\x48\xff\xc6\x68\xd6\x09\xe0\xcf\x48\xff\xc0\xe2\xea\x2c\x0c\x48\x89\xc6\x68\x9f\xa9\x07\x08\x48\x31\xc0\x48\x89\xc7\x04\x01\x48\x89\xc2\x80\xc2\x0b\x0f\x05\x48\x31\xc0\x04\x3c\x0f\x05\xe8\xae\xff\xff\xff\xce\x8f\x92\x99\xac\xaa\x85\xa9\xbd\xb6\xbb\x96\x65\x64\xdb\xca\x7d\x9b\x68\xd9\xf3\x12\xc3\x5b\x52\x41\x4e\x44\x53\x54\x52\x32\x5d"
#echo -e -n $RECEIVED_HEX

UTF_8_HEX=$(echo -e -n $RECEIVED_HEX )
#echo $UTF_8_HEX

function decode() {
    python3 - <<END
# -*- coding: utf-8 -*-

sc = "$1".replace('\\x', '').decode('hex')
#hx = sc[0x54:0x54+0x0c].encode('hex')
#print(''.join(chr(int(x,16) ^ 0xff) for x in re.findall('..', hx)))
END
}

decode "$RECEIVED_HEX"

#exec -c < ch121.bin

#echo "Sender $ANSWER"
#GET_CHALLENGE=$(curl -sb PHPSESSID=$SESSIONID $RINGZER0_URL_CHALLENGE/$ANSWER)
#echo $GET_CHALLENGE
