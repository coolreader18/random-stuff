apt install make
curl https://dl.google.com/go/go1.11.linux-amd64.tar.gz | tar -xzC /usr/local
update-alternatives --install /usr/bin/go go /usr/local/go/bin/go 1
