.DEFAULT_GOAL := build-linux

pwd := $(shell pwd)

pkg := cfnex

linux.bin   := cfnex
windows.bin := cfnex.exe
darwin.bin  := $(linux.bin)

build.dir          := $(pwd)/.build
build.linux.dir    := $(build.dir)/linux
build.linux.file   := $(build.linux.dir)/$(linux.bin)
build.windows.dir  := $(build.dir)/windows
build.windows.file := $(build.windows.dir)/$(windows.bin)
build.darwin.dir   := $(build.dir)/darwin
build.darwin.file  := $(build.darwin.dir)/$(darwin.bin)

dist.dir              := $(pwd)/.dist
dist.linux.filename   := $(pkg)-$(VERSION).linux-amd64.tar.gz
dist.linux.file       := $(dist.dir)/$(dist.linux.filename)
dist.windows.filename := $(pkg)-$(VERSION).windows-amd64.zip
dist.windows.file     := $(dist.dir)/$(dist.windows.filename)
dist.darwin.filename  := $(pkg)-$(VERSION).darwin-amd64.tar.gz
dist.darwin.file      := $(dist.dir)/$(dist.darwin.filename)

.PHONY: build
build: build-linux build-windows build-darwin

.PHONY: build-linux
build-linux:
	GOOS=linux GOARCH=amd64 go build -o $(build.linux.file) $(pkg)

.PHONY: build-windows
build-windows:
	GOOS=windows GOARCH=amd64 go build -o $(build.windows.file) $(pkg)

.PHONY: build-darwin
build-darwin:
	GOOS=darwin GOARCH=amd64 go build -o $(build.darwin.file) $(pkg)

.PHONY: dist
dist: dist-linux dist-windows dist-darwin

.PHONY: dist-linux
dist-linux: get-version
	@mkdir -p $(dist.dir)
	tar cfz $(dist.linux.file) -C $(build.linux.dir) $(linux.bin)

.PHONY: dist-windows
dist-windows: get-version
	@mkdir -p $(dist.dir)
	cd $(dist.dir) && zip $(dist.windows.filename) $(build.windows.file)

.PHONY: dist-darwin
dist-darwin: get-version
	@mkdir -p $(dist.dir)
	tar cfz $(dist.darwin.file) -C $(build.darwin.dir) $(darwin.bin)

.PHONY: format
format:
	go fmt ./...

.PHONY: clean
clean:
	rm -rf $(build.dir)

.PHONY: get-version
get-version:
ifndef VERSION
	@echo "Provide a VERSION to continue."; exit 1
endif
