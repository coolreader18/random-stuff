set -e

git clone https://github.com/coolreader18/random-stuff --depth=1 ~/.random-stuff
cd ~/.random-stuff/
./setup.sh

if [ "$BINS" ]; then
  for bin in $BINS; do
    make install-"$bin"
  done
else
  make install
fi