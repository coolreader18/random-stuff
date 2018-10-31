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

kahootbins = $(patsubst %,$(OUTDIR)/kahoot-%,$(kahoots))

kahoot-hack: $(kahootbins)

$(filter $(OUTDIR)/%,$(kahootbins)): $(OUTDIR)/%: $(wildcard kahoot-hack/%/*.go) .godeps
	go build -o $@ kahoot-hack/$*/main.go

allbins = $(kahootbins)

.PHONY: install install-*

install: install-kahoots

install-kahoots: $(patsubst %,install-kahoot-%,$(kahoots))

install-$(allbins): install-%: $(OUTDIR)/%
	install -m 557 $< $(BINDIR)

.PHONY: uninstall uninstall-*

uninstall: uninstall-kahoots

uninstall-kahoots: $(patsubst %,uninstall-kahoot-%,$(kahoots))

uninstall-$(allbins): uninstall-%:
	rm -f $(BINDIR)/$*
