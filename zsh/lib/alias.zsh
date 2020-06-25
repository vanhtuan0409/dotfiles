alias vim="nvim"
alias zshconfig="vim $HOME/.zshrc"
alias zshalias="vim $DOTFILES/zsh/lib/alias.zsh"
alias zshreload="source $HOME/.zshrc"
alias zshplugins="vim $ANTIBODY_PLUGINS_FILE"
alias vimconfig="vim $HOME/.vimrc"
alias vimbundles="vim $HOME/.vimrc.bundles"
alias vimkeybindings="vim $HOME/.vimrc.keybindings"
alias kscontext="kubectl config use-context"
alias gitdiscard="git reset --hard && git clean -fd"
alias epoch="date +%s"
alias cat="bat"
alias ls="exa"
alias g="goto"
alias r="bash $DOTFILES/scripts/rand.sh"
alias grep="rg"
alias publicip="dig +short myip.opendns.com @resolver1.opendns.com"
# alias for notes https://github.com/pimterry/notes
alias n="notes"
alias open="xdg-open"
alias vifm="vifm -f && xargs --no-run-if-empty --arg-file ~/.config/vifm/vimfiles -d '\n' xdg-open"
alias nnn="PAGER=less nnn"
