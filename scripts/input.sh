input=$(ibus engine)

case $input in
  xkb:us::eng)
    echo "en"
    ;;
  Unikey)
    echo "vi"
    ;;
esac
