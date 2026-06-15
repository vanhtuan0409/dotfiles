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
