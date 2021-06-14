if [[ "$ZPROF" = true ]]; then
  zmodload zsh/zprof
fi

# Setup Environment variables
export VISUAL="nvim"
export EDITOR="nvim"
export PAGER="cat"
export DOTFILES=$HOME/dotfiles
export NOTES_DIRECTORY="$HOME/Dropbox/notes"
export ANTIBODY_CACHE_FILE="$HOME/.cache/antibody_cache.sh"
export ANTIBODY_PLUGINS_FILE="$DOTFILES/zsh/antibody.zsh"
export ZSH_CACHE_DIR="$HOME/.cache/zsh"
export MYWORKSPACE=$HOME/Workspaces
export GOPATH=$HOME/go
export GOBIN=$GOPATH/bin
export RUSTBIN=$HOME/.cargo/bin
export GEMBIN=$HOME/.gem/ruby/2.6.0/bin
export YARNBIN=$HOME/.yarn/bin
export PUBBIN=$HOME/.pub-cache/bin
if [[ -z $TMUX ]]; then
  export PATH=$DOTFILES/scripts:$GOBIN:$RUSTBIN:$GEMBIN:$YARNBIN:$PUBBIN:/usr/local/go/bin:$PATH
fi
export GARENA_HOME=$HOME/.garena
export ANSIBLE_VAULT_PASSWORD_FILE=$GARENA_HOME/ansible/foody_ansible_vault
export FOODY_WORKSPACE=$MYWORKSPACE/foody
export FOODY_K8S_WORKSPACE=$FOODY_WORKSPACE/devops_kubernetes
export NNN_OPTS="ecHx"
export RANGER_LOAD_DEFAULT_RC=FALSE
export FZF_DEFAULT_OPTS='--bind alt-a:select-all,alt-d:deselect-all'
export FZF_DEFAULT_COMMAND='rg --files --hidden --follow -g "!.git"'

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
  _antibody_plugins
fi
source $ANTIBODY_CACHE_FILE

# Import personal lib
for lib_file ($DOTFILES/zsh/lib/*.zsh); do
  source $lib_file
done

# Source other configuration
# source $DOTFILES/themes/tuanvuong.zsh-theme
eval "$(starship init zsh)"

if [[ "$ZPROF" = true ]]; then
  zprof
fi

