#!/bin/bash

echo "> Begin install brew..."
which -s brew
if [[ $? != 0 ]] ; then
    # Install Homebrew
    ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
    echo "- Install brew formulas"
    if [ -f brew.txt ]; then
        xargs brew install < brew.txt
    fi
fi
echo "> Done. Have fun!"

