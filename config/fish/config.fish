set fish_greeting
set -Uq fisher_path; or set -U fisher_path $HOME/.config/fisher
set -Uq nvm_default_version; or set -U nvm_default_version v16.16.0
set -gx DOTFILES $HOME/dotfiles

set -gx VISUAL nvim
set -gx EDITOR nvim
set -gx PAGER cat
set -gx NOTES_DIRECTORY $HOME/Dropbox/notes

set -gx MYWORKSPACE $HOME/Workspaces
set -gx GOPATH $HOME/go
set -gx GOROOT /usr/lib/go
set -gx GOBIN $GOPATH/bin
set -gx VIRTUALFISH_HOME $HOME/python_venvs

set -gx GOTO_DB $HOME/.config/goto
set -gx FZF_DEFAULT_COMMAND 'rg --files --hidden --follow -g !.git'
set -gx OP_CACHE true
set -gx FDB_NETWORK_OPTION_EXTERNAL_CLIENT_LIBRARY /usr/lib/libfdb_c.so:/usr/lib/libfdb_c.so.6.3.15

for namespace in "_anduin" "_homelab"
  source $DOTFILES/config/fish/$namespace/conf.d/*
  set -gax fish_function_path $DOTFILES/config/fish/$namespace/functions
  set -gax fish_complete_path $DOTFILES/config/fish/$namespace/completions
end

# binary search path
fish_add_path -gaP $GOPATH/bin
fish_add_path -gaP $HOME/.cargo/bin
fish_add_path -gaP $HOME/.gem/ruby/2.6.0/bin
fish_add_path -gaP $HOME/.yarn/bin
fish_add_path -gaP $HOME/.pub-cache/bin
fish_add_path -gaP $DOTFILES/scripts
fish_add_path -gaP $HOME/.local/share/coursier/bin

# terminal prompt
starship init fish | source
