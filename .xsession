source $HOME/.secretvars

eval $($HOME/dotfiles/scripts/startkeyring.sh)
export SSH_AUTH_SOCK=/run/user/1000/gcr/ssh

export GTK_IM_MODULE=ibus
export QT_IM_MODULE=ibus
export XMODIFIERS=@im=ibus
export QT4_IM_MODULE=ibus
export CLUTTER_IM_MODULE=ibus

source $HOME/dotfiles/scripts/setupmonitor.sh

xinput set-button-map 13 1 1 3

# vi: ft=bash
