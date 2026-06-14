#!/usr/bin/env bash

case "$1" in
  raw-lock)
    betterlockscreen -l blur
    ;;
  lock)
    loginctl lock-session
    ;;
  logout)
    # Stop the i3 session target first, then exit i3. Stopping it releases the
    # BindsTo on graphical-session.target, which then self-stops (it is
    # StopWhenUnneeded=yes) and cascades shutdown to services bound to it
    # (PartOf=graphical-session.target, e.g. xdg-desktop-portal) while X is
    # still up. reboot/shutdown skip this because systemd tears down the whole
    # user manager on its own.
    systemctl --user stop i3-session.target
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
