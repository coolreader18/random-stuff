.PHONY: kahoot-hack

OUTDIR = build

kahoots = $(patsubst kahoot-hack/kahoot-%,%,$(wildcard kahoot-hack/kahoot-*))

all: kahoot-hack

.godeps:
	go get -v -d ./...
	touch .godeps

kahoot-hack: $(patsubst %,$(OUTDIR)/kahoot-%,$(kahoots))

$(OUTDIR)/kahoot-%: kahoot-hack/kahoot-%/main.go .godeps
	go build -o $@ $<
