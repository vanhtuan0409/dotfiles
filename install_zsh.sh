#!/bin/bash
CURRENT_DATE=$(date +%s)
config_files=(".zshrc" ".zshrc.alias" ".zshrc.functions")
echo "> Begin install zsh..."

# Install oh my zsh if not installed
if [ "$SHELL" != "/bin/zsh" ]; then
    curl -sL git.io/antibody | sh -s

    # Copy zsh config
    for i in ${config_files[@]}; do
        if [ -f ~/$i ]; then
            mv ~/$i ~/$i.$CURRENT_DATE
        echo "- Backup file $i to $i.$CURRENT_DATE"
        fi

        ln -s $(pwd)/$i ~/$i
        echo "- Use symlink to install file $i"
    done
fi
echo "> Done. Have fun!"

