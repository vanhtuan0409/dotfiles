antibody_load() {
  antibody bundle $@ >> $ANTIBODY_CACHE_FILE
}

antibody_plugins() {
  echo "" > $ANTIBODY_CACHE_FILE
  antibody_load robbyrussell/oh-my-zsh kind:fpath path:plugins/cargo
  echo "zsh_init" >> $ANTIBODY_CACHE_FILE
  antibody_load robbyrussell/oh-my-zsh path:lib/clipboard.zsh
  antibody_load robbyrussell/oh-my-zsh path:lib/completion.zsh
  antibody_load robbyrussell/oh-my-zsh path:lib/git.zsh
  antibody_load robbyrussell/oh-my-zsh path:lib/history.zsh
  antibody_load robbyrussell/oh-my-zsh path:lib/spectrum.zsh
  antibody_load robbyrussell/oh-my-zsh path:lib/theme-and-appearance.zsh
  antibody_load zsh-users/zsh-autosuggestions
  antibody_load Tarrasch/zsh-bd
  antibody_load iridakos/goto
  antibody_load superbrothers/zsh-kubectl-prompt
}

zsh_init() {
  autoload -Uz compaudit compinit
  # Avoid checking zcompdump every time
  for dump in ~/.zcompdump(N.mh+24); do
    compinit
  done

  compinit -C
}

antibody_refresh() {
  rm -rf $ANTIBODY_CACHE_FILE
  rm -rf ~/.zcompdump
  antibody_plugins
}
