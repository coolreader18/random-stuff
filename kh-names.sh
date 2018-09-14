#!/usr/bin/env bash
cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null
case $1 in
  flood|rand)
    exe=build/kahoot-$1
    if [[ ! -f build/kahoot-$1 ]]; then
      make $exe
    fi
    $exe $2 kahoot-names/$3
  ;;
  *)
    echo "Invalid option"
  ;;
esac