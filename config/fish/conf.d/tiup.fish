fish_add_path -gaP $HOME/.tiup/bin

for comp in tidb tikv pd playground
  fish_add_path -gaP (dirname (tiup --binary $comp))
end
