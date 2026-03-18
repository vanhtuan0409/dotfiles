#!/bin/env bash

source $HOME/.secretvars

eval $($HOME/dotfiles/scripts/startkeyring.sh)
export SSH_AUTH_SOCK=/run/user/1000/gcr/ssh

export GTK_IM_MODULE=fcitx
export QT_IM_MODULE=fcitx
export XMODIFIERS=@im=fcitx
export QT4_IM_MODULE=fcitx
export CLUTTER_IM_MODULE=fcitx

source $HOME/dotfiles/scripts/setupmonitor.sh

if lsusb | grep -i akko; then
  # In case of dump-keyboard. Using software to swap capslock and control
  setxkbmap -layout us -option ctrl:swapcaps
fi

# vi: ft=bash
