set -gx PYENV_ROOT $HOME/.pyenv
fish_add_path -gaP $PYENV_ROOT/bin

pyenv init --path | source
pyenv init - | source
