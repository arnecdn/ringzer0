usage(){
  echo "Usage: $0 [-s <PHPSESSID>] Solves CTF challenge $1"
  exit 2
}

function parse_hash(){
    echo $(parse_content_between_tags "$1" "----- BEGIN HASH ----- " "----- END HASH -----")
}

function parse_message(){
    echo $(parse_content_between_tags "$1" "----- BEGIN MESSAGE ----- " "----- END MESSAGE -----")
}

function parse_flag(){
    echo $(parse_content_between_tags "$1" "<div class=\"alert alert-info\">" "</div>")
}

function parse_content_between_tags(){
    content=$(echo $1| sed -e 's/\r//g' -e 's/<br \/>//g')
    content=${content##*$2}
    content=${content%%$3*}
    echo $content
}

function sha512_encode() {
    python3 - <<END
import hashlib
print(hashlib.sha512("$1".encode('utf-8')).hexdigest())
END
}

function bin_to_number() {
python3 - <<END
import binascii
print(int("$1".replace(' ', ''), 2))
END
}
