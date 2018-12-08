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
	@mkdir -p $(KAHOOT_NAMES_DIR)
	cp $< $(KAHOOT_NAMES_DIR)

# completions stuff

BASH_COMPLETIONS_DIR = \
  $(shell command -v pkg-config 2>&1 >/dev/null \
	  && pkg-config bash-completion --variable=completionsdir \
		|| echo 'install_pkg-config_and_bash-completion_or_set_BASH_COMPLETIONS_DIR' )


bash_completions = $(patsubst bash-completions/%.sh,%,$(wildcard bash-completions/*))

.PHONY: install-bash-completions
install-bash-completions: $(addprefix $(BASH_COMPLETIONS_DIR)/,$(bash_completions))

$(addprefix $(BASH_COMPLETIONS_DIR)/,$(bash_completions)): \
    $(BASH_COMPLETIONS_DIR)/%: bash-completions/%.sh
	@mkdir -p $(BASH_COMPLETIONS_DIR)
	if [ -L $< ]; then ln -s $(patsubst %.sh,%,$(shell readlink $<)) $@; else cp $< $@; fi

ZSH_FUNCTIONS_DIR = $(PREFIX)/local/share/zsh/site-functions

zsh_functions = $(patsubst zsh-functions/%.sh,%,$(wildcard zsh-functions/*))

install-zsh-functions: $(addprefix $(ZSH_FUNCTIONS_DIR)/,$(zsh_functions))

$(addprefix $(ZSH_FUNCTIONS_DIR)/,$(zsh_functions)): \
    $(ZSH_FUNCTIONS_DIR)/%: zsh-functions/%.sh
	@mkdir -p $(ZSH_FUNCTIONS_DIR)
	cp $< $@
