show_help() {
  echo 'Usage: names (flood|rand) <game pin> <name list>'
}
case $1 in
  --deps)
    echo "kahoot-flood kahoot-rand"
  ;;
  flood|rand)
    list="$RS_DIR/kahoot-names/$3"
    if [[ ! -f $list ]]; then
      echo "Names list '$3' not found"
      exit 1
    fi
    kahoot-$1 "$2" "$list"
  ;;
  --help)
    show_help
  ;;
  "")
    show_help
    exit 1
  ;;
  *)
    echo "Invalid option"
    show_help
    exit 1
  ;;
esac