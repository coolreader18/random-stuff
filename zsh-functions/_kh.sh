#compdef kh

local args=(
  '1:cmd:{
    local kahoots=(
      $(echo ${(k)commands} | tr " " "\\n" | sed "/^kahoot-/{s/^kahoot-//;p};d")
    );
    compadd $kahoots
  }'
  '*::arguments:{
    words[1]=kahoot-$words[1]
    $_comps[$words[1]]
  }'
)

# echo "$args[1]"

_arguments $args


