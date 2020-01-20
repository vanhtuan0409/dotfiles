eval $(/usr/bin/gnome-keyring-daemon --start --components=gpg,pkcs11,secrets,ssh)
export GNOME_KEYRING_CONTROL GNOME_KEYRING_PID GPG_AGENT_INFO SSH_AUTH_SOCK
export QT_IM_MODULE=ibus

xrandr --output eDP-1 --mode 1600x900
setxkbmap -option altwin:swap_lalt_lwin
