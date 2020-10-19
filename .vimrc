for f in glob('$DOTFILES/vim/*.vim', 0, 1)
  execute 'source' f
endfor
