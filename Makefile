.PHONY: kahoot-hack .rm-godeps

OUTDIR = build

kahoots = $(patsubst kahoot-hack/kahoot-%,%,$(wildcard kahoot-hack/kahoot-*))

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

$(OUTDIR)/kahoot-%: kahoot-hack/kahoot-%/main.go .godeps
	go build -o $@ $<
