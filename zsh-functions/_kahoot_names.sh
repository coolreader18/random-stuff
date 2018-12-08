#compdef kahoot-names

local args=(
  '1:cmd:((
    flood\:"Flood the game"
    rand\:"Flood the game and have the bots pick random answers"
  ))'
  '3:list:{
    local namesdir=${KAHOOT_NAMES_DIR:-~/.kh-names}
    _files -W "$namesdir"
  }'
  '--help'
)

_arguments $args
