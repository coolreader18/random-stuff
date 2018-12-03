errecho() {
  >&2 echo $@
}

show_help() {
  "${1:-echo}" 'Usage: names (flood|rand) <game pin> <name list>'
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
        errecho "Missing parameters"
        show_help errecho
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
    show_help errecho
    exit 1
  ;;
  *)
    errecho "Invalid option"
    show_help errecho
    exit 1
  ;;
esac