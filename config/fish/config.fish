set fish_greeting
set -Uq fisher_path; or set -U fisher_path $HOME/.config/fisher
set -gx DOTFILES $HOME/dotfiles

set -gx VISUAL nvim
set -gx EDITOR nvim
set -gx PAGER cat
set -gx NOTES_DIRECTORY $HOME/Dropbox/notes

set -gx MYWORKSPACE $HOME/Workspaces
set -gx GOPATH $HOME/go
set -gx VIRTUALFISH_HOME $HOME/python_venvs

set -gx GOTO_DB $HOME/.config/goto
set -gx FZF_DEFAULT_COMMAND 'rg --files --hidden --follow -g !.git'

# private configs
for f in $DOTFILES/config/fish/private_conf.d/*;
  source $f
end
set -gax fish_function_path $DOTFILES/config/fish/private_functions
set -gax fish_complete_path $DOTFILES/config/fish/private_completions

# binary search path
fish_add_path -gaP $GOPATH/bin
fish_add_path -gaP $HOME/.cargo/bin
fish_add_path -gaP $HOME/.gem/ruby/2.6.0/bin
fish_add_path -gaP $HOME/.yarn/bin
fish_add_path -gaP $HOME/.pub-cache/bin
fish_add_path -gaP $DOTFILES/scripts

# terminal prompt
starship init fish | source
