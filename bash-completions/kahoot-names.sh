_kahoot_names() {
	case ${#COMP_WORDS[@]} in
	  2)
	    COMPREPLY=(
	      $(compgen -W "flood rand" "${COMP_WORDS[1]}")
	    )
	  ;;
	  4)
	    local namesdir=${KAHOOT_NAMES_DIR:-~/.kh-names}
	    COMPREPLY=(
	    	$(cd "$namesdir" && compgen -f "${COMP_WORDS[3]}")
	    )
	esac
}

complete -F _kahoot_names kahoot-names
