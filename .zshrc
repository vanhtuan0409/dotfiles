if [[ "$ZPROF" = true ]]; then
  zmodload zsh/zprof
fi

# Setup Environment variables
export VISUAL="nvim"
export EDITOR="nvim"
export DOTFILES=$HOME/dotfiles
export NOTES_DIRECTORY="$HOME/Dropbox/notes"
export ANTIBODY_HOME="$(antibody home)"
export ANTIBODY_CACHE_FILE="$HOME/.cache/antibody_cache.sh"
export ANTIBODY_PLUGINS_FILE="$DOTFILES/zsh/antibody.sh"
export ZSH_CACHE_DIR="$HOME/.cache/zsh"
export MYWORKSPACE=$HOME/Workspaces
export GOPATH=$HOME/go
export GOBIN=$GOPATH/bin
export RUSTBIN=$HOME/.cargo/bin
export GEMBIN=$HOME/.gem/ruby/2.6.0/bin
if [[ -z $TMUX ]]; then
  export PATH=$DOTFILES/scripts:$GOBIN:$RUSTBIN:$GEMBIN:/usr/local/go/bin:$PATH
fi
export GARENA_HOME=$HOME/.garena
export ANSIBLE_VAULT_PASSWORD_FILE=$GARENA_HOME/ansible/foody_ansible_vault
export FOODY_WORKSPACE=$MYWORKSPACE/foody
export FOODY_K8S_WORKSPACE=$FOODY_WORKSPACE/devops_kubernetes
export KUBEHOME=$HOME/.kube
export KUBECONFIG="$KUBEHOME/config"

# Load all kubeconfig
for f in `ls $KUBEHOME | grep config.`
do
  export KUBECONFIG="$KUBECONFIG:$KUBEHOME/$f"
done
export RANGER_LOAD_DEFAULT_RC=FALSE

# Load all private variables
for f in `ls $GARENA_HOME/vars`
do
  source "$GARENA_HOME/vars/$f"
done

# Setup TTY
stty -ixon
bindkey -e

# Setup plugins
source $ANTIBODY_PLUGINS_FILE
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
if [ -f $HOME/.local/bin/aws_zsh_completer.sh ]; then
  source $HOME/.local/bin/aws_zsh_completer.sh
fi

# Tmux intergration
# if [ "$TMUX" = "" ]; then tmux; fi

if [[ "$ZPROF" = true ]]; then
  zprof
fi
