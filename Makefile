OUTDIR = build
BINDIR = /usr/bin

targets = kahoot scripts

all: $(targets)

# Go stuff

.PHONY: .rm-godeps update-godeps

export GODIR ?= ~/go

clean: .rm-godeps
	rm -f $(allbuilds)

.godeps:
	go get -v -d ./...
	touch .godeps

.rm-godeps:
	rm -f .godeps

update-godeps: .rm-godeps .godeps

# bin definitions

kahootbins = $(patsubst kahoot-hack/%,%,$(wildcard kahoot-hack/kahoot-*))

scriptsbins = $(patsubst scripts/%.sh,%,$(wildcard scripts/*))

include generic.mk

# recipes

get_deps = deps="$$$$(bash scripts/"$$*".sh --deps 2>/dev/null)" && echo $$$$deps

.SECONDEXPANSION:
$(scriptsbuilds): $(OUTDIR)/%: $(addsuffix .sh,scripts/%) \
		$$(addprefix $$(OUTDIR)/,$$(shell $(get_deps)))
	echo '#!/usr/bin/env bash' > $@
	echo 'PATH="$$PATH":"$(realpath $(OUTDIR))"' >> $@
	cat $< >> $@
	chmod +x $@

$(kahootbuilds): $(OUTDIR)/%: $(wildcard kahoot-hack/%/*.go) .godeps
	go build -o $@ kahoot-hack/$*/main.go
