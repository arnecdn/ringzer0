
function parse_message(){
    challenge_response=$(echo $1 | sed -e 's/\r//g' -e 's/<br \/>//g')
    challenge_response=${challenge_response##*----- BEGIN MESSAGE ----- }
    challenge_response=${challenge_response%% ----- END MESSAGE -----*}
    echo $challenge_response
}

usage(){
  echo "Usage: $0 [-s <PHPSESSID>] Solves CTF challenge $1"
  exit 2
}

function parse_flag(){
    flag=$(echo $1| sed -e 's/\r//g' -e 's/<br \/>//g')
    flag=${flag##*<div class=\"alert alert-info\">}
    flag=${flag%%</div>*}
    echo $flag
}