OUTDIR ?= build
BINDIR ?= /usr/bin

targets = kahoot scripts

all: $(targets)

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
	echo 'SRC_DIR="$(realpath .)"' >> $@
	echo 'SRC_FILE="$<"' >> $@
	cat $< >> $@
	chmod +x $@

$(kahootbuilds): $(OUTDIR)/%: $(wildcard kahoot-hack/%/*.go)
	@go get -d ./kahoot-hack/$*/...
	go build -o $@ kahoot-hack/$*/main.go
