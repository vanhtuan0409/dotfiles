set fish_greeting

set -gx VISUAL nvim
set -gx EDITOR nvim
set -gx PAGER cat
set -gx DOTFILES $HOME/dotfiles
set -gx NOTES_DIRECTORY $HOME/Dropbox/notes

set -gx MYWORKSPACE $HOME/Workspaces
set -gx GOPATH $HOME/go
set -gx FOODY_WORKSPACE $MYWORKSPACE/foody
set -gx FOODY_K8S_WORKSPACE $FOODY_WORKSPACE/devops_kubernetes

set -gx GARENA_HOME $HOME/.garena
for f in $GARENA_HOME/fish_vars/*;
  source $f
end
set -gx ANSIBLE_VAULT_PASSWORD_FILE $GARENA_HOME/ansible/foody_ansible_vault

set -gx FZF_DEFAULT_OPTS '--bind alt-a:select-all,alt-d:deselect-all'
set -gx FZF_DEFAULT_COMMAND 'rg --files --hidden --follow -g "!.git"'

set -gx GOTO_DB $HOME/.config/goto

fish_add_path -gaP $GOPATH/bin
fish_add_path -gaP $HOME/.cargo/bin
fish_add_path -gaP $HOME/.gem/ruby/2.6.0/bin
fish_add_path -gaP $HOME/.yarn/bin
fish_add_path -gaP $HOME/.pub-cache/bin
fish_add_path -gaP $DOTFILES/scripts

starship init fish | source
