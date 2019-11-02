usage(){
  echo "Usage: $0 [-s <PHPSESSID>] Solves CTF challenge $1"
  exit 2
}

function parse_message(){
    challenge_response=$(echo $1 | sed -e 's/\r//g' -e 's/<br \/>//g')
    challenge_response=${challenge_response##*----- BEGIN MESSAGE ----- }
    challenge_response=${challenge_response%% ----- END MESSAGE -----*}
    echo $challenge_response
}


function parse_flag(){
    flag=$(echo $1| sed -e 's/\r//g' -e 's/<br \/>//g')
    flag=${flag##*<div class=\"alert alert-info\">}
    flag=${flag%%</div>*}
    echo $flag
}


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
