#!/bin/bash

usage()
{
  echo "Usage: $0 [-s <PHPSESSID>] Starts scripts"
  exit 2
}

title="Select challenge"
prompt="Pick an option:"
options=("A" "B" "C")

echo "$title"
PS3="$prompt "
select opt in "${options[@]}" "Quit"; do 
  
    case "$REPLY" in

    1 ) echo "You picked $opt which is option $REPLY";;
    2 ) echo "You picked $opt which is option $REPLY";;
    3 ) echo "You picked $opt which is option $REPLY";;

    $(( ${#options[@]}+1 )) ) echo "Goodbye!"; break;;
    *) echo "Invalid option. Try another one.";clear;continue;;

    esac

done
