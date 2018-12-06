err() {
  >&2 $@
}

show_help() {
  echo 'Usage: names (flood|rand) <game pin> <name list>'
}

case $1 in
  --deps)
    echo "kahoot-flood kahoot-rand"
  ;;
  --lists)
    ls "$SRC_DIR"/kahoot-names
  ;;
  flood|rand)
    case "$#" in
      1|2)
        err echo "Missing parameters"
        err show_help
        exit 1
      ;;
    esac
    list="$SRC_DIR/kahoot-names/$3"
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
    err show_help
    exit 1
  ;;
  *)
    err echo "Invalid option"
    err show_help err
    exit 1
  ;;
esac