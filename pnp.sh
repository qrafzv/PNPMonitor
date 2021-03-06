#!/bin/bash
PATH=/usr/local/bin:/usr/local/sbin:~/bin:/usr/bin:/bin:/usr/sbin:/sbin
url=http://www.ontarioimmigration.ca/en/pnp/OI_PNPNEW.html
tempdir=~/Library/Caches/scripts
temp=$tempdir/pnp
if [ ! -d "$tempdir" ];then
    echo "Initialize Finish, Monitoring Start..."|terminal-notifier -title "Dont Panic"
    mkdir -p $tempdir
fi
if [[ $(date +"%T") = "10:00"* ]];then
    echo "I will always love you"|terminal-notifier -title "Don't Panic"
fi
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null && pwd )"

modified=$(curl -s --compressed  http://www.ontarioimmigration.ca/en/pnp/OI_PNPNEW.html | egrep -o  -A2 '<p class=\"right\">.*$' | tr '\n' ' ' |sed 's/.*Last\ Modified: \(.*\)<.*>/\1/g')
if [[ -f "$temp" && "$modified" != "$(cat $temp)" && "$modified" != "" ]];then
    notimsg=$(cat $temp)"=>"$modified  
    echo $notimsg|terminal-notifier  -title 'Atten' -open $url
    osascript "$DIR/email-notifier.scpt" 
#else
   # echo $modified|terminal-notifier -title 'Calm Down' -open $url
fi
if [[ "$modified" != "" ]]; then
printf %s "$modified" > $temp
fi
