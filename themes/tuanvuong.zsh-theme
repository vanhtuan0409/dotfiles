# Based on the great ys theme (http://ysmood.org/wp/2013/03/my-ys-terminal-theme/)

# Directory info.
local current_dir='${PWD/#$HOME/~}'

GRUVBOX_COLOR="%{$terminfo[bold]$FG[130]%}"

# VCS
YS_VCS_PROMPT_SUFFIX="%{$reset_color%}"
YS_VCS_PROMPT_DIRTY=" %{$fg[red]%}✖"
YS_VCS_PROMPT_CLEAN=" %{$fg[green]%}●"

# Git info.
local git_info='$(git_prompt_info)'
ZSH_THEME_GIT_PROMPT_PREFIX=" %{$fg[cyan]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="$YS_VCS_PROMPT_SUFFIX"
ZSH_THEME_GIT_PROMPT_DIRTY="$YS_VCS_PROMPT_DIRTY"
ZSH_THEME_GIT_PROMPT_CLEAN="$YS_VCS_PROMPT_CLEAN"

PROMPT=" %{$fg[cyan]%}[%D{%K:%M:%S}]%{$reset_color%} \
$GRUVBOX_COLOR${current_dir}%{$reset_color%}\
${git_info}
%{$fg[white]%}▶ %{$reset_color%}"
RPROMPT='$GRUVBOX_COLOR$ZSH_KUBECTL_PROMPT%{$reset_color%}'

# Reload timestamp every 1 second
TMOUT=1
TRAPALRM() { 
  case "$WIDGET" in
    expand-or-complete|self-insert|up-line-or-beginning-search|down-line-or-beginning-search|backward-delete-char|.history-incremental-search-backward|.history-incremental-search-forward)
      :
      ;;
    *)
      zle reset-prompt
      ;;
  esac
}
