#!/bin/bash
CURRENT_DATE=$(date +%s)
config_files=(".vimrc" ".vimrc.bundles" ".zshrc" ".zshrc.alias" ".zshrc.functions")
echo "> Begin install dotfiles..."

for i in ${config_files[@]}; do
    if [ -f ~/$i ]; then
        mv ~/$i ~/$i.$CURRENT_DATE
	echo "- Backup file $i to $i.$CURRENT_DATE"
    fi

    ln -s $(pwd)/$i ~/$i
    echo "- Use symlink to install file $i"
done

echo "> Done. Have fun!"
