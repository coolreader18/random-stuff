.PHONY: kahoot-hack

OUTDIR = build

kahoots = $(patsubst kahoot-hack/kahoot-%,%,$(wildcard kahoot-hack/kahoot-*))

all: kahoot-hack

go-deps:
	go get -v -d ./...

khs = $(patsubst %,$(OUTDIR)/kahoot-%,$(kahoots))
kahoot-hack: go-deps $(khs)

$(OUTDIR)/kahoot-%: kahoot-hack/kahoot-%/main.go
	go build -o $@ $<