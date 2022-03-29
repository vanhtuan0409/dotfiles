#!/usr/bin/env bash

case "$1" in
  raw-lock)
    betterlockscreen -l blur & sleep 5 && xset dpms force off
    ;;
  lock)
    loginctl lock-session
    ;;
  logout)
    i3-msg exit
    ;;
  suspend)
    systemctl suspend
    ;;
  hibernate)
    systemctl hibernate
    ;;
  reboot)
    systemctl reboot
    ;;
  shutdown)
    systemctl poweroff
    ;;
  *)
    echo "Usage: $0 {lock|logout|suspend|hibernate|reboot|shutdown}"
    exit 2
esac

exit 0
