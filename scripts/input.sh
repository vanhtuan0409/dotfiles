input=$(ibus engine)

case $input in
  xkb:us::eng)
    echo "en"
    ;;
  Bamboo)
    echo "vi"
    ;;
esac
