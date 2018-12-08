_kahoot_std() {
  if [[ ${#COMP_WORDS[@]} = 3 ]]; then
    COMPREPLY=($(compgen -f ${COMP_WORDS[2]}))
  fi
}

complete -F _kahoot_std kahoot-flood kahoot-rand
