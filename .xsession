eval $(/usr/bin/gnome-keyring-daemon --start --components=gpg,pkcs11,secrets,ssh)
export GNOME_KEYRING_CONTROL GNOME_KEYRING_PID GPG_AGENT_INFO SSH_AUTH_SOCK
export QT_IM_MODULE=ibus

xrandr --output eDP-1 --primary --mode 1600x900 --pos 0x0 --rotate normal
xrandr --output HDMI-1 --mode 1920x1080 --right-of eDP-1 --rotate normal
xrandr --output DP-1 --mode 1920x1080 --right-of HDMI-1 --rotate normal

xset s off
xset -dpms
