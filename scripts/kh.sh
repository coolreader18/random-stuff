err() {
  >&2 $@
}

get_kahoots() {
	grep ^kahoot-
}

show_usages() {
	for exe in $(compgen -c kahoot- | sort | uniq); do
	  $exe 2>&1 | \
      sed 's/Usage://;s/^[ \t]*//;s/^/kh /'
	done
}

case  $1 in
  --deps)
    echo $BINS | tr ' ' '\n' | get_kahoots
  ;;
  --help)
    echo Usage:
    show_usages
  ;;
  "")
    err echo Usage:
    err show_usages
    exit 1
  ;;
  *)
    exe=kahoot-$1
    shift
    if command -v $exe >/dev/null; then
      $exe $@
    else
      echo Invalid command >&2
      exit 1
    fi
  ;;
esac