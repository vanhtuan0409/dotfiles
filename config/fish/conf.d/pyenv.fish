set -Uq PYENV_ROOT; or set -Ux PYENV_ROOT $HOME/.pyenv
fish_add_path -gaP $PYENV_ROOT/bin

pyenv init - fish | source
