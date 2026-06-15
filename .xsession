#!/bin/env bash

# gnome-keyring is started + unlocked by gnome-keyring.service (pulled in by
# i3-session.target), not here -- it must be unlocked at launch, so start and
# unlock cannot be split (see scripts/startkeyring.sh).
export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/gcr/ssh"
# Secret Service clients find the daemon over D-Bus and do NOT need this, but
# the gnome-keyring PKCS#11 module (and `gnome-keyring-daemon --start/--replace`)
# locate the control socket via GNOME_KEYRING_CONTROL. The daemon takes no
# --control-directory, so it uses the default $XDG_RUNTIME_DIR/keyring.
export GNOME_KEYRING_CONTROL="$XDG_RUNTIME_DIR/keyring"

# Feed the session environment into BOTH the systemd user manager and the
# D-Bus activation environment, so services activated later (e.g.
# xdg-desktop-portal, polybar@.service) inherit DISPLAY/XAUTHORITY and the
# desktop name. `--systemd` forwards these into the systemd --user manager too
# (equivalent to `systemctl --user import-environment`), so a single call covers
# both managers -- no separate import-environment needed.
dbus-update-activation-environment --systemd DISPLAY XAUTHORITY XDG_CURRENT_DESKTOP XDG_SESSION_TYPE GNOME_KEYRING_CONTROL

export GTK_IM_MODULE=fcitx
export QT_IM_MODULE=fcitx
export XMODIFIERS=@im=fcitx
export QT4_IM_MODULE=fcitx
export CLUTTER_IM_MODULE=fcitx

# Apply the xrandr layout (external primary + internal off when docked, see
# scripts/setupmonitor.sh). polybar no longer needs a MONITOR env from here --
# launch-polybar.sh enumerates the live outputs itself, so the bars follow
# whatever this leaves active.
source $HOME/dotfiles/scripts/setupmonitor.sh

if lsusb | grep -i akko; then
  # In case of dump-keyboard. Using software to swap capslock and control
  setxkbmap -layout us -option ctrl:swapcaps
fi

# vi: ft=bash
