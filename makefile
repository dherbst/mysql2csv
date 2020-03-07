GITSHA := $(shell git rev-parse --short HEAD)
GITTAG := $(shell git tag | tail -1 | tr -d v)
LDFLAGS := "-X github.com/dherbst/mysql2csv.gitsha=${GITSHA} -X github.com/dherbst/mysql2csv.version=${GITTAG}"
GOOS ?= $(shell uname | tr [:upper:] [:lower:])
GOLANG = golang:1.14

all: pull lint sec build test install

clean:
	rm -rf bin/*

pull:
	docker pull $(GOLANG)

lint:
	docker run -i --rm -v ${PWD}:/go/src/github.com/dherbst/mysql2csv -w /go/src/github.com/dherbst/mysql2csv ${GOLANG} make lint-in-container

lint-in-container:
	go get -u golang.org/x/lint/golint
	golint github.com/dherbst/mysql2csv
	golint github.com/dherbst/mysql2csv/cmd/mysql2csv/...

sec:
	docker run -it --rm -v ${PWD}:/go/src/github.com/dherbst/mysql2csv -w /go/src/github.com/dherbst/mysql2csv ${GOLANG} make sec-in-container

sec-in-container:
	go get -u github.com/securego/gosec/cmd/gosec
	gosec .

build:
	mkdir -p bin
	docker run --rm -i -e GOOS=${GOOS} -v ${PWD}:/go/src/github.com/dherbst/mysql2csv -w /go/src/github.com/dherbst/mysql2csv $(GOLANG) bash -c "make build-in-container"

build-in-container:
	go vet github.com/dherbst/mysql2csv
	GOOS=${GOOS} go build -ldflags ${LDFLAGS} -o bin/mysql2csv cmd/mysql2csv/*.go

test:
	docker run --rm -i -v ${PWD}:/go/src/github.com/dherbst/mysql2csv -w /go/src/github.com/dherbst/mysql2csv $(GOLANG) bash -c "make test-in-container"

test-in-container:
	go test -ldflags ${LDFLAGS} -coverprofile=coverage.out github.com/dherbst/mysql2csv
	go tool cover -html=coverage.out -o coverage.html

install:
	mkdir -p ~/bin
	cp bin/mysql2csv ~/bin
