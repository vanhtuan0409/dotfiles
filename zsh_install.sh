#!/bin/bash
CURRENT_DATE=$(date +%s)
config_files=(".zshrc" ".zshrc.alias" ".zshrc.functions")
echo "> Begin install zsh..."

# Install oh my zsh if not installed
if [ "$SHELL" != "/bin/zsh" ]; then
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

    # Copy zsh config
    for i in ${config_files[@]}; do
        if [ -f ~/$i ]; then
            mv ~/$i ~/$i.$CURRENT_DATE
        echo "- Backup file $i to $i.$CURRENT_DATE"
        fi

        ln -s $(pwd)/$i ~/$i
        echo "- Use symlink to install file $i"
    done

    echo "> Done. Have fun!"
fi

