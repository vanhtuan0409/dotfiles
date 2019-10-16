# List directory contents
alias lsa='ls -lah'
alias l='ls -lah'
alias ll='ls -lh'
alias la='ls -lAh'

function remember_pwd() {
  emulate -L zsh
  pwd > /tmp/whereami
}

chpwd_functions=(${chpwd_functions[@]} "remember_pwd")
