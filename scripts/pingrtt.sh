#!/bin/sh

HOST=google.com

if ! ping=$(ping -n -c 1 -W 1 $HOST 2> /dev/null); then
    echo ""
else
    rtt=$(echo "$ping" | sed -rn 's/.*time=([0-9]{1,})\.?[0-9]{0,} ms.*/\1/p')
    echo "  $rtt ms"
fi
