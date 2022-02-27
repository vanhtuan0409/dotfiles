eval $(/usr/bin/gnome-keyring-daemon --start --components=gpg,pkcs11,secrets,ssh)
export GNOME_KEYRING_CONTROL GNOME_KEYRING_PID GPG_AGENT_INFO SSH_AUTH_SOCK

export GTK_IM_MODULE=ibus
export QT_IM_MODULE=ibus
export QT_AUTO_SCREEN_SCALE_FACTOR=1
export XMODIFIERS=@im=ibus
export QT4_IM_MODULE=ibus
export CLUTTER_IM_MODULE=ibus

xrandr --dpi 140
xrandr --output eDP1 --primary --mode 1920x1080 --pos 0x0 --rotate normal
