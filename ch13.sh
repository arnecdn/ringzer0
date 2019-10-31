#!/bin/bash
RINGZER0_URL="https://ringzer0ctf.com/login"
LOGIN_FORM="\"username=arnecdn&password=test124\""
LOGIN_HTTP_CONTENTTYPE=""
LOGIN=$(curl -s --cookie-jar ./cookie-jar.txt $RINGZER0_URL/login)
LOGIN_POST="curl -s -cookie cookie-jar.txt -d $LOGIN_FORM -X POST $RINGZER0_URL/login"
LOGIN_POST=${LOGIN_POST##*<form role=\"form\" action=\"\" method=\"post\">}
LOGIN_POST=${LOGIN_POST%%</form>*}
echo $LOGIN_POST
#echo $response | sed -n '/<body>/,/<\/body>/{ /body>/d; p }'
#sed -n ''