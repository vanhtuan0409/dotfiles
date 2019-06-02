if [[ "$ZPROF" = true ]]; then
  zmodload zsh/zprof
fi

# Setup Environment variables
export SSH_KEY_PATH="$HOME/.ssh/rsa_id"
export VISUAL="vim"
export EDITOR="vim"
export NOTES_DIRECTORY="$HOME/Dropbox/notes"
export ANTIBODY_HOME="$(antibody home)"
export ANTIBODY_CACHE_FILE="$HOME/.cache/antibody_cache.sh"
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
source $DOTFILES/zsh/antibody.sh
fpath=($DOTFILES/zsh/completion $fpath)
if [ ! -f $ANTIBODY_CACHE_FILE ]; then
  antibody_reload
fi
source $ANTIBODY_CACHE_FILE

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

if [[ "$ZPROF" = true ]]; then
  zprof
fi
