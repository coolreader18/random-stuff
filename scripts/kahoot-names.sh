case $1 in
  --deps)
    echo "kahoot-flood kahoot-rand"
  ;;
  flood|rand)
    
    kahoot-$1 "$2" "kahoot-names/$3"
  ;;
  *)
    echo "Invalid option"
    exit 1
  ;;
esac