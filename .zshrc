# Setup Environment variables
export SSH_KEY_PATH="$HOME/.ssh/rsa_id"
export VISUAL="vim"
export EDITOR='code'
export ANTIBODY_HOME="$(antibody home)"
export ZSH_CACHE_DIR="$HOME/.cache/zsh"
export DOTFILES=$HOME/dotfiles
export MYWORKSPACE=$HOME/Workspace
export GOPATH=$HOME/go
export GOBIN=$GOPATH/bin
if [[ -z $TMUX ]]; then
  export PATH=$DOTFILES/scripts:$GOBIN:/usr/local/go/bin:$PATH
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

# Setup TTY
stty -ixon
bindkey -e

# Setup plugins
autoload -U compaudit compinit
compinit -u -C -d "$HOME/.zcompdump"

source <(antibody init)
antibody bundle robbyrussell/oh-my-zsh path:lib/clipboard.zsh
antibody bundle robbyrussell/oh-my-zsh path:lib/completion.zsh
antibody bundle robbyrussell/oh-my-zsh path:lib/git.zsh
antibody bundle robbyrussell/oh-my-zsh path:lib/spectrum.zsh
antibody bundle robbyrussell/oh-my-zsh path:lib/theme-and-appearance.zsh
antibody bundle robbyrussell/oh-my-zsh path:plugins/docker
antibody bundle robbyrussell/oh-my-zsh path:plugins/docker-compose
antibody bundle robbyrussell/oh-my-zsh path:plugins/kubectl
antibody bundle robbyrussell/oh-my-zsh path:plugins/vagrant
antibody bundle zsh-users/zsh-autosuggestions
antibody bundle Tarrasch/zsh-bd
antibody bundle iridakos/goto
antibody bundle pimterry/notes kind:fpath

# Import personal lib
for lib_file ($DOTFILES/zsh/lib/*.zsh); do
  echo $lib_file
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
