#!/bin/env bash

# use to automatically unlock keyring with password stored in a file
# in case dont want the keyring password to be empty
# or using fprintd
echo -n $(cat $HOME/.config/keyringpass) | /usr/bin/gnome-keyring-daemon --daemonize --components=gpg,pkcs11,secrets,ssh --unlock
