#!/usr/bin/env bash

case "$1" in
  raw-lock)
    betterlockscreen -l blur
    ;;
  lock)
    loginctl lock-session
    ;;
  logout)
    # Stop the graphical session first so services bound to it
    # (PartOf=graphical-session.target, e.g. xdg-desktop-portal) shut down
    # cleanly while X is still up, then exit i3. reboot/shutdown skip this
    # because systemd tears down the whole user manager on its own.
    systemctl --user stop graphical-session.target
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
