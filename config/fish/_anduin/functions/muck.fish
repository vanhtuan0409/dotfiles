function muck
  if ! test -f millw
    echo "no millw file"
    return 1
  end

  ./millw --disable-ticker -j 4 $argv
end
