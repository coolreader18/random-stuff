.PHONY: kahoot-hack .rm-godeps

OUTDIR = build
BINDIR = /usr/bin

kahoots = $(patsubst kahoot-hack/kahoot-%,%,$(wildcard kahoot-hack/kahoot-*))

export GODIR ?= ~/go

all: kahoot-hack

clean: .rm-godeps
	rm $(OUTDIR)/*

.godeps:
	go get -v -d ./...
	touch .godeps

.rm-godeps:
	rm -f .godeps

update-godeps: .rm-godeps .godeps

kahoot-hack: $(patsubst %,$(OUTDIR)/kahoot-%,$(kahoots))

$(OUTDIR)/kahoot-%: kahoot-hack/kahoot-%/*.go .godeps
	go build -o $@ kahoot-hack/kahoot-$*/main.go

.PHONY: install install-*

install: install-kahoots

install-kahoots: $(patsubst %,install-kahoot-%,$(kahoots))

install-%: $(OUTDIR)/%
	install -m 557 $< $(BINDIR)

.PHONY: uninstall uninstall-*

uninstall: uninstall-kahoots

uninstall-*: $(OUTDIR)/%
	rm -f $(BINDIR)/$<

uninstall-kahoots: $(patsubst %,uninstall-kahoot-%,$(kahoots))
