set -gx UV_MANAGED_PYTHON true

alias pip "uv pip"
fish_add_path -g (dirname (uv python find))
