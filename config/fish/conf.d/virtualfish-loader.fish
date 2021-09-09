set -g VIRTUALFISH_VERSION 2.5.4
set -g VIRTUALFISH_PYTHON_EXEC $HOME/.local/pipx/venvs/virtualfish/bin/python
source $HOME/.local/pipx/venvs/virtualfish/lib/python3.9/site-packages/virtualfish/virtual.fish
emit virtualfish_did_setup_plugins
