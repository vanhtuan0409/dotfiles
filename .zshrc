# Path to your oh-my-zsh installation.
export ANTIBODY_HOME="$(antibody home)"
export ZSH=$ANTIBODY_HOME/https-COLON--SLASH--SLASH-github.com-SLASH-robbyrussell-SLASH-oh-my-zsh
export DOTFILES=$HOME/dotfiles
export MYWORKSPACE=$HOME/Workspace
export GOPATH=$HOME/go
export GOBIN=$GOPATH/bin
if [[ -z $TMUX ]]; then
  export PATH=$GOBIN:/usr/local/go/bin:$PATH
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

# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-zsh is loaded.
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
# ZSH_THEME="tuanvuong"

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

source <(antibody init)
antibody bundle robbyrussell/oh-my-zsh
antibody bundle robbyrussell/oh-my-zsh path:plugins/docker
antibody bundle robbyrussell/oh-my-zsh path:plugins/docker-compose
antibody bundle robbyrussell/oh-my-zsh path:plugins/kubectl
antibody bundle robbyrussell/oh-my-zsh path:plugins/vagrant
antibody bundle zsh-users/zsh-autosuggestions
antibody bundle Tarrasch/zsh-bd
antibody bundle iridakos/goto
antibody bundle pimterry/notes kind:fpath

compinit -i

# Source other configuration
source $DOTFILES/themes/tuanvuong.zsh-theme
if [ -f ~/.zshrc.alias ]; then
  source ~/.zshrc.alias
fi
if [ -f ~/.zshrc.functions ]; then
  source ~/.zshrc.functions
fi
if [ $TILIX_ID ] || [ $VTE_VERSION ]; then
  source /etc/profile.d/vte.sh
fi

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

export VISUAL="vim"
export EDITOR='code'
# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
export SSH_KEY_PATH="~/.ssh/rsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
stty -ixon
if [ "$TMUX" = "" ]; then tmux; fi
bindkey -e
