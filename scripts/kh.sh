case  $1 in
  --deps)
    for dep in $BINS; do
      if [[ $dep = kahoot-* ]]; then
        echo $dep
      fi
    done
  ;;
  "")
    echo Options:
    for exe in $(compgen -c | grep ^kahoot-); do
      $exe 2>&1 >/dev/null | sed 's/^[ \t]*//;s/^Usage: //'
    done
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