# Random Stuff

A collection of stuff to play around with.

## Installing

### Use the install script

```sh
curl https://github.com/coolreader18/random-stuff/raw/master/install.sh -sSLf | sudo sh
```

Some environment variables the install script understands:
- BINDIR: the directory everything will be installed to.
- BINS: a space separated string of the binaries to install. e.g, "kahoot-flood kahoot-names"

### Manually install

1. Clone the repository: `git clone https://github.com/coolreader18/random-stuff/`
1. Ensure necessary dependencies are installed: go, GNU make. For some platforms, you can run `./setup.sh`.
1. Run `sudo make install` to install, or just `make` to build to the `build` directory.

## License
This project is licensed under the MIT license; see the [LICENSE](LICENSE) file for more details. Projects
included via submodules are licensed under their own licenses, viewable in their own individual source trees.
