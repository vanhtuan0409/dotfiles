# use this in case gnome-keyring can be automatically unlocked when logged in
# usually not compatible with autologin flow like fprintd
#eval $(/usr/bin/gnome-keyring-daemon --start)

source $HOME/.secretvars

eval $($HOME/dotfiles/scripts/startkeyring.sh)
export SSH_AUTH_SOCK

export GTK_IM_MODULE=ibus
export QT_IM_MODULE=ibus
export QT_AUTO_SCREEN_SCALE_FACTOR=1
export XMODIFIERS=@im=ibus
export QT4_IM_MODULE=ibus
export CLUTTER_IM_MODULE=ibus

xrandr --dpi 140
xrandr --output eDP1 --primary --mode 1920x1080 --pos 0x0 --rotate normal
