pwd := $(shell pwd)

pkg := cfnex

build.dir := $(pwd)/.build

linux.bin := cfnex

.PHONY: build
build:
	go build -o $(build.dir)/$(linux.bin) $(pkg)

.PHONY: format
format:
	go fmt ./...

.PHONY: clean
clean:
	rm -rf $(build.dir)

