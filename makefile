GITSHA := $(shell git rev-parse --short HEAD)
LDFLAGS := "-X mysql2csv.gitsha=${GITSHA} -X mysql2csv.version=1.0.0"

all: build

build:
	docker run --rm -i -e GOPATH=/project -v ${PWD}:/project -w /project golang:1.8 bash -c "make build-in-container"

build-in-container: src/mysql2csv/cmd/mysql2csv.go
	GOPATH=${PWD} go build -ldflags ${LDFLAGS} -o mysql2csv src/mysql2csv/cmd/mysql2csv.go
