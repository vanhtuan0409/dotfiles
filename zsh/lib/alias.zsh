alias vim="nvim"
alias zshconfig="vim $HOME/.zshrc"
alias zshalias="vim $DOTFILES/zsh/lib/alias.zsh"
alias zshreload="source $HOME/.zshrc"
alias zshplugins="vim $ANTIBODY_PLUGINS_FILE"
alias vimconfig="vim $HOME/.vimrc"
alias vimbundles="vim $HOME/.vimrc.bundles"
alias vimkeybindings="vim $HOME/.vimrc.keybindings"
alias tmuxconfig="vim $HOME/.tmux.conf"
alias kscontext="kubectl config use-context"
alias gitdiscard="git reset --hard && git clean -fd"
alias epoch="date +%s"
alias g="goto"
alias r="ranger"
alias grep="rg"
alias publicip="dig +short myip.opendns.com @resolver1.opendns.com"
alias 1pass="op_cache | fzf | xargs -I {} op_cache -p {}"
# alias for notes https://github.com/pimterry/notes
alias n="notes"
alias open="xdg-open"
alias vifm="vifm -f && xargs --no-run-if-empty --arg-file ~/.config/vifm/vimfiles -d '\n' xdg-open"
alias jump="cd \`fzf | xargs dirname 2> /dev/null || pwd\`"
alias fvim="nvim \`fzf\`"
