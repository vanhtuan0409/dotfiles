# Setup Environment variables
export SSH_KEY_PATH="$HOME/.ssh/rsa_id"
export VISUAL="vim"
export EDITOR="vim"
export NOTES_DIRECTORY="$HOME/Dropbox/notes"
export ANTIBODY_HOME="$(antibody home)"
export ZSH_CACHE_DIR="$HOME/.cache/zsh"
export DOTFILES=$HOME/dotfiles
export MYWORKSPACE=$HOME/Workspace
export GOPATH=$HOME/go
export GOBIN=$GOPATH/bin
export RUSTBIN=$HOME/.cargo/bin
if [[ -z $TMUX ]]; then
  export PATH=$DOTFILES/scripts:$GOBIN:$RUSTBIN:/usr/local/go/bin:$PATH
fi
export MYVIMRC=$HOME/.vimrc
export GARENA_HOME=$HOME/.garena
export ANSIBLE_VAULT_PASSWORD_FILE=$GARENA_HOME/ansible/foody_ansible_vault
export FOODY_WORKSPACE=$MYWORKSPACE/foody
export KUBEHOME=$HOME/.kube
export KUBECONFIG="$KUBEHOME/config"
for f in `ls $KUBEHOME | grep config.`
do
  export KUBECONFIG="$KUBECONFIG:$KUBEHOME/$f"
done
export RANGER_LOAD_DEFAULT_RC=FALSE

# Setup TTY
stty -ixon
bindkey -e

# Setup plugins
fpath=($DOTFILES/zsh/completion $fpath)

# source <($HOME/plugins.sh)
source <(antibody init)

# Suggestion
antibody bundle robbyrussell/oh-my-zsh kind:fpath path:plugins/httpie
antibody bundle robbyrussell/oh-my-zsh kind:fpath path:plugins/cargo
antibody bundle robbyrussell/oh-my-zsh kind:fpath path:plugins/docker-compose
autoload -Uz compaudit compinit && compinit

# Plugins
antibody bundle robbyrussell/oh-my-zsh path:lib/clipboard.zsh
antibody bundle robbyrussell/oh-my-zsh path:lib/completion.zsh
antibody bundle robbyrussell/oh-my-zsh path:lib/git.zsh
antibody bundle robbyrussell/oh-my-zsh path:lib/history.zsh
antibody bundle robbyrussell/oh-my-zsh path:lib/spectrum.zsh
antibody bundle robbyrussell/oh-my-zsh path:lib/theme-and-appearance.zsh
antibody bundle robbyrussell/oh-my-zsh path:plugins/kubectl
antibody bundle robbyrussell/oh-my-zsh path:plugins/minikube
antibody bundle zsh-users/zsh-autosuggestions
antibody bundle Tarrasch/zsh-bd
antibody bundle iridakos/goto

# Import personal lib
for lib_file ($DOTFILES/zsh/lib/*.zsh); do
  source $lib_file
done

# Source other configuration
source $DOTFILES/themes/tuanvuong.zsh-theme
if [ $TILIX_ID ] || [ $VTE_VERSION ]; then
  source /etc/profile.d/vte.sh
fi
if [ -f $HOME/.iterm2_shell_integration.zsh ]; then
  source $HOME/.iterm2_shell_integration.zsh
fi
if [ -f $HOME/.fzf.zsh ]; then
  source $HOME/.fzf.zsh
fi

# Tmux intergration
if [ "$TMUX" = "" ]; then tmux; fi
