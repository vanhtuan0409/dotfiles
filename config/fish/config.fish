set fish_greeting
set -Uq fisher_path; or set -U fisher_path $HOME/.config/fisher
set -Uq nvm_default_version; or set -U nvm_default_version v22.14.0
set -gx DOTFILES $HOME/dotfiles

set -gx VISUAL nvim
set -gx EDITOR nvim
set -gx PAGER cat

set -gx MYWORKSPACE $HOME/Workspaces
set -gx GOPATH $HOME/go
set -gx GOROOT /usr/lib/go
set -gx GOBIN $GOPATH/bin

set -gx GOTO_DB $HOME/.config/goto
set -gx FZF_DEFAULT_COMMAND 'rg --files --hidden --follow -g !.git'

# binary search path
fish_add_path -gaP $GOPATH/bin
fish_add_path -gaP $HOME/.local/bin
fish_add_path -gaP $HOME/.cargo/bin
fish_add_path -gaP $HOME/.gem/ruby/2.6.0/bin
fish_add_path -gaP $HOME/.yarn/bin
fish_add_path -gaP $HOME/.pub-cache/bin
fish_add_path -gaP $DOTFILES/scripts
fish_add_path -gaP $HOME/.local/share/coursier/bin
fish_add_path -gaP $HOME/Workspaces/anduin/cue/dist

for namespace in "_private" "_anduin"
  for file in $DOTFILES/config/fish/$namespace/conf.d/*
    source $file
  end
  set -ga fish_function_path $DOTFILES/config/fish/$namespace/functions
  set -ga fish_complete_path $DOTFILES/config/fish/$namespace/completions
end

if status is-interactive
  # terminal prompt
  starship init fish | source
end
