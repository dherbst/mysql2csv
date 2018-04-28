GITSHA := $(shell git rev-parse --short HEAD)
LDFLAGS := "-X mysql2csv.gitsha=${GITSHA} -X mysql2csv.version=1.0.0"

GOOS ?= darwin
GOLANG = golang:1.10

all: pull build test

clean:
	rm -rf bin/*


pull:
	docker pull $(GOLANG)

build:
	mkdir -p bin
	docker run --rm -i -e GOPATH=/project -v ${PWD}:/project -w /project $(GOLANG) bash -c "make build-in-container"

build-in-container: src/mysql2csv/cmd/mysql2csv.go
	GOOS=${GOOS} GOPATH=${PWD} go build -ldflags ${LDFLAGS} -o bin/mysql2csv src/mysql2csv/cmd/mysql2csv.go
	GOPATH=${PWD} go vet mysql2csv

test:
	docker run --rm -i -e GOPATH=/project -v ${PWD}:/project -w /project $(GOLANG) bash -c "make test-in-container"

test-in-container:
	GOPATH=${PWD} go test -ldflags ${LDFLAGS} mysql2csv
