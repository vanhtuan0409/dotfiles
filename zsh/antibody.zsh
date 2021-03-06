_antibody_load() {
  antibody bundle $@ >> $ANTIBODY_CACHE_FILE
}

_antibody_plugins() {
  local _zsh_init="""
autoload -Uz compaudit compinit
# Avoid checking zcompdump every time
for dump in ~/.zcompdump(N.mh+24); do
  compinit
done

compinit -C
  """

  echo "" > $ANTIBODY_CACHE_FILE
  _antibody_load robbyrussell/oh-my-zsh kind:fpath path:plugins/cargo
  _antibody_load robbyrussell/oh-my-zsh kind:fpath path:plugins/terraform
  echo "$_zsh_init" >> $ANTIBODY_CACHE_FILE
  _antibody_load robbyrussell/oh-my-zsh path:lib/clipboard.zsh
  _antibody_load robbyrussell/oh-my-zsh path:lib/completion.zsh
  _antibody_load robbyrussell/oh-my-zsh path:lib/git.zsh
  _antibody_load robbyrussell/oh-my-zsh path:lib/history.zsh
  _antibody_load robbyrussell/oh-my-zsh path:lib/spectrum.zsh
  _antibody_load robbyrussell/oh-my-zsh path:lib/theme-and-appearance.zsh
  _antibody_load zsh-users/zsh-autosuggestions path:zsh-autosuggestions.zsh
  _antibody_load Tarrasch/zsh-bd path:bd.zsh
  _antibody_load iridakos/goto path:goto.sh
  _antibody_load superbrothers/zsh-kubectl-prompt path:kubectl.zsh
}

antibody_refresh() {
  rm -rf $ANTIBODY_CACHE_FILE
  rm -rf ~/.zcompdump
  _antibody_plugins
}
