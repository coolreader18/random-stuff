_kh() {
  if [[ ${#COMP_WORDS[@]} = 2 ]]; then
    local cmds=$(compgen -c kahoot- | sed 's/^kahoot-//')
      COMPREPLY=($(compgen -W "$cmds" "${COMP_WORDS[1]}"))
  else
    COMP_WORDS[1]=kahoot-${COMP_WORDS[1]}
    _command_offset 1
  fi
}

complete -F _kh kh
