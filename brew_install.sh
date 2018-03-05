which -s brew
if [[ $? != 0 ]] ; then
    # Install Homebrew
    ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
    if [ -f brew.txt ]; then
        xargs brew install < brew.txt
    fi
fi

