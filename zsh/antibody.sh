antibody_completions() {
  antibody bundle robbyrussell/oh-my-zsh kind:fpath path:plugins/httpie
  antibody bundle robbyrussell/oh-my-zsh kind:fpath path:plugins/cargo
  antibody bundle robbyrussell/oh-my-zsh kind:fpath path:plugins/docker-compose
}

antibody_plugins() {
  antibody bundle robbyrussell/oh-my-zsh path:lib/clipboard.zsh
  antibody bundle robbyrussell/oh-my-zsh path:lib/completion.zsh
  antibody bundle robbyrussell/oh-my-zsh path:lib/git.zsh
  antibody bundle robbyrussell/oh-my-zsh path:lib/history.zsh
  antibody bundle robbyrussell/oh-my-zsh path:lib/spectrum.zsh
  antibody bundle robbyrussell/oh-my-zsh path:lib/theme-and-appearance.zsh
  antibody bundle zsh-users/zsh-autosuggestions
  antibody bundle Tarrasch/zsh-bd
  antibody bundle iridakos/goto
}

zsh_init() {
  autoload -Uz compaudit compinit && compinit
}

antibody_reload() {
  antibody_completions > $ANTIBODY_CACHE_FILE
  echo "zsh_init" >> $ANTIBODY_CACHE_FILE
  antibody_plugins >> $ANTIBODY_CACHE_FILE
}
