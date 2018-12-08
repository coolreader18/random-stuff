PREFIX ?= /usr
OUTDIR ?= build
BINDIR ?= $(PREFIX)/bin

targets = kahoot scripts

all: $(targets)

clean:
	rm -f $(allbuilds)

# bin definitions

kahootbins = $(patsubst kahoot-hack/%,%,$(wildcard kahoot-hack/kahoot-*))

scriptsbins = $(patsubst scripts/%.sh,%,$(wildcard scripts/*))

include generic.mk

# recipes

get_deps = deps="$$$$(BINS="$$(allbins)" bash scripts/"$$*".sh --deps 2>/dev/null)" && echo $$$$deps

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

# kahoot names stuff

homedir = $(shell [ "$$SUDOUSER" ] && echo /home/"$$SUDOUSER" || echo ~)

KAHOOT_NAMES_DIR ?= $(homedir)/.kh-names

install: install-kh-names

khnames = $(patsubst kahoot-names/%,%,$(wildcard kahoot-names/*))

khnames_in_dir = $(addprefix $(KAHOOT_NAMES_DIR)/,$(khnames))

install-kh-names: $(khnames_in_dir)

$(khnames_in_dir): $(KAHOOT_NAMES_DIR)/%: kahoot-names/%
	@mkdir -p $(KH_NAMES_DIR)
	cp $< $(KH_NAMES_DIR)

# completions stuff

BASH_COMPLETIONS_DIR = $(shell pkg-config bash-completion --variable=completionsdir)

completions = $(wildcard bash-completions/*.bash-completion)

install: install-bash-completions

install-bash-completions: $(homedir)/.bash_completion/random-stuff

$(homedir)/.bash_completion/random-stuff: random-stuff.bash-completion
	@mkdir -p $(homedir)/.bash_completion
	cp $< $@
