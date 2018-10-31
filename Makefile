.PHONY: kahoot-hack .rm-godeps

OUTDIR = build
BINDIR = /usr/bin

kahootbins = $(patsubst kahoot-hack/kahoot-%,%,$(wildcard kahoot-hack/kahoot-*))

export GODIR ?= ~/go

targets = kahoot-hack

all: $(targets)

clean: .rm-godeps
	rm $(OUTDIR)/*

.godeps:
	go get -v -d ./...
	touch .godeps

.rm-godeps:
	rm -f .godeps

update-godeps: .rm-godeps .godeps

kahootbuilds = $(addprefix $(OUTDIR)/kahoot-,$(kahoots))

kahoot-hack: $(kahootbuilds)

$(kahootbuilds): $(OUTDIR)/%: $(wildcard kahoot-hack/%/*.go) .godeps
	go build -o $@ kahoot-hack/$*/main.go

allbins = $(kahootbins)

.PHONY: install install-*

install: $(addprefix install-,$(targets))

install-kahoot-hack: $(addprefix install-kahoot-,$(kahoots))

$(addprefix install-,$(allbins)): install-%: $(OUTDIR)/%
	install -m 557 $< $(BINDIR)

.PHONY: uninstall uninstall-*

uninstall: $(addprefix uninstall-,$(targets))

uninstall-kahoot-hack: $(addprefix uninstall-kahoot-,$(kahoots))

$(addprefix uninstall-,$(allbins)): uninstall-%:
	rm -f $(BINDIR)/$*
