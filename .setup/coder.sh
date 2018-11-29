apt install make bison

curl -sSL https://github.com/moovweb/gvm/raw/master/binscripts/gvm-installer | bash

. ~/.gvm/scripts/gvm

if [[ ! $GO_VERSION ]]; then
	GO_VERSION=go1.10
fi

gvm install "$GO_VERSION" -B

update-alternatives --install /usr/bin/go go ~/.gvm/gos/$GO_VERSION/bin/go 1
