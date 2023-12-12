# use this in case gnome-keyring can be automatically unlocked when logged in
# usually not compatible with autologin flow like fprintd
# eval $(/usr/bin/gnome-keyring-daemon --start)

source $HOME/.secretvars

eval $($HOME/dotfiles/scripts/startkeyring.sh)
export SSH_AUTH_SOCK

export GTK_IM_MODULE=ibus
export QT_IM_MODULE=ibus
export XMODIFIERS=@im=ibus
export QT4_IM_MODULE=ibus
export CLUTTER_IM_MODULE=ibus

source $HOME/dotfiles/scripts/setupmonitor.sh

xinput set-button-map 13 1 1 3

# vi: ft=bash
