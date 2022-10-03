# use this in case gnome-keyring can be automatically unlocked when logged in
# usually not compatible with autologin flow like fprintd
# eval $(/usr/bin/gnome-keyring-daemon --start)

source $HOME/.secretvars

eval $($HOME/dotfiles/scripts/startkeyring.sh)
export SSH_AUTH_SOCK=$HOME/.1password/agent.sock

export GTK_IM_MODULE=ibus
export QT_IM_MODULE=ibus
export XMODIFIERS=@im=ibus
export QT4_IM_MODULE=ibus
export CLUTTER_IM_MODULE=ibus

export QT_AUTO_SCREEN_SCALE_FACTOR=1

INTERNAL_MONITOR=eDP-1
EXTERNAL_MONITOR=DP-1-0

xrandr --dpi 142
xrandr --output $INTERNAL_MONITOR --primary --mode 1920x1080 --pos 0x0 --rotate normal
xrandr --output $EXTERNAL_MONITOR --auto --mode 1920x1080 --same-as $INTERNAL_MONITOR

xinput set-button-map 13 1 1 3

# vi: ft=bash
