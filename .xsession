#!/bin/env bash

source $HOME/.secretvars

eval $($HOME/dotfiles/scripts/startkeyring.sh)
export SSH_AUTH_SOCK=/run/user/1000/gcr/ssh

# Identify the desktop so apps (flameshot, xdg-desktop-portal) pick the
# right X11 backend instead of falling back to a missing portal service.
export XDG_CURRENT_DESKTOP=i3

# Feed the session environment into BOTH the systemd user manager and the
# D-Bus activation environment, so services activated later (e.g.
# xdg-desktop-portal) inherit DISPLAY/XAUTHORITY and the desktop name.
# Must run after XDG_CURRENT_DESKTOP is exported above.
if command -v dbus-update-activation-environment >/dev/null 2>&1; then
    dbus-update-activation-environment --systemd DISPLAY XAUTHORITY XDG_CURRENT_DESKTOP
fi

export GTK_IM_MODULE=fcitx
export QT_IM_MODULE=fcitx
export XMODIFIERS=@im=fcitx
export QT4_IM_MODULE=fcitx
export CLUTTER_IM_MODULE=fcitx

source $HOME/dotfiles/scripts/setupmonitor.sh

# Hand the resolved primary monitor to the systemd user manager so the
# polybar@.service units (started via i3-session.target) can target it. The
# user manager is a separate process tree and does not inherit PRIMARY_MONITOR
# from this shell the way i3-launched processes do.
systemctl --user set-environment MONITOR="$PRIMARY_MONITOR"

if lsusb | grep -i akko; then
  # In case of dump-keyboard. Using software to swap capslock and control
  setxkbmap -layout us -option ctrl:swapcaps
fi

# vi: ft=bash
