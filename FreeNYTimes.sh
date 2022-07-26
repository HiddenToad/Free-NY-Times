#!/bin/bash


url=$(osascript -e 'tell application "System events"
try 
set visible of application process  "Terminal" to false
end try
end
display dialog "Enter link to get: " default answer "" with title "Input Link"
set link to the text returned of the result
return link') 

EXITCODE=$?


if [ $EXITCODE -ne "0" ];
then
    killall Terminal
else
    curl $url > temp.html
    EXITCODE=$?
    if [ $EXITCODE -ne "0" ];
    then
        osascript -e 'display dialog "The inputted link was not valid." buttons {"OK"} with title "Invalid Link"'
        rm temp.html
    else
        open temp.html
        sleep 2
        rm temp.html
    fi
fi

killall Terminal


