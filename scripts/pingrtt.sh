#!/bin/sh

HOST=google.com

if ! ping=$(ping -n -c 1 -W 1 $HOST 2> /dev/null); then
    echo ""
else
    rtt=$(echo "$ping" | sed -rn 's/.*time=([0-9]{1,})\.?[0-9]{0,} ms.*/\1/p')

    if [ "$rtt" -lt 50 ]; then
        icon="%{F#3cb703}  "
    elif [ "$rtt" -lt 150 ]; then
        icon="%{F#f9dd04}  "
    else
        icon="%{F#d60606}  "
    fi

    echo "$icon $rtt ms%{F-}"
fi
