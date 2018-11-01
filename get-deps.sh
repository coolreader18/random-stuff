deps=$(bash scripts/"$1".sh --deps)
if [ "$?" -eq 0 ]; then
  echo "$deps"
fi