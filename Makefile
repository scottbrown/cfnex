pwd := $(shell pwd)

pkg := cfnex

build.dir := $(pwd)/.build

linux.bin := cfnex

build:
	go build -o $(build.dir)/$(linux.bin) $(pkg)

format:
	go fmt ./...

clean:
	rm -rf $(build.dir)

