INCLUDED += go-build # Basename of this makefile.
.DEFAULT_GOAL := go-build-help # Basename + "-help"
################################################################################
define go-build.mk
REQUIREMENTS:
  - go : `go` command must be available.

TARGETS:
  - go-build-help : show help message.
  - go-build      : build binary.

VARIABLES [default value]:
  - GO_BUILD_TARGET  : go build target. (Default is all directories in ./cmd/)
  - GO_BUILD_OUTPUT  : binary output directory. (Default "_output/bin/$(GOOS)-$(GOARCH)/")
  - GO_BUILD_FLAGS   : go build flags (Default "-trimpath")
  - GO_BUILD_TAGS    : tags passed to the -tags. (Default "netgo,osusergo")
  - GO_BUILD_LDFLAGS : flags passed to the -ldflags. (Default "-w -s -extldflags '-static'")
  - GO_BUILD_GCFLAGS : flags passed to the -gcflags. (Default "")
  - GO_BUILD_EXTRAS  : extra build options. (Default "")

REFERENCES:
  - https://pkg.go.dev/cmd/go
  - https://pkg.go.dev/go/build
  - https://pkg.go.dev/internal/platform
  - https://go.dev/wiki/#platform-specific-information
endef
################################################################################


export CGO_ENABLED ?= 0

export GOOS ?= $(shell go env GOOS)
ifeq ($(GOOS),)
GOOS = $(shell go env GOOS)
endif

export GOARCH ?= $(shell go env GOARCH)
ifeq ($(GOARCH),)
GOARCH = $(shell go env GOARCH)
endif

OS_ARCH := $(GOOS)-$(GOARCH)
ifeq ($(GOARCH),arm)
OS_ARCH := $(GOOS)-$(GOARCH)$(GOARM)
endif

GO_BUILD_TARGET ?= $(shell ls -d ./cmd/* 2>/dev/null)
GO_BUILD_OUTPUT ?= _output/bin/$(OS_ARCH)/
GO_BUILD_FLAGS ?= -trimpath
GO_BUILD_TAGS ?= netgo,osusergo
GO_BUILD_LDFLAGS ?= -w -s -extldflags '-static'
GO_BUILD_GCFLAGS ?=
GO_BUILD_EXTRAS ?=


##### ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ #####
##                                                                            ##
#  Usage: `make go-build-help`                                                 #
#  Description: Show help message.                                             #
#                                                                              #
.PHONY: go-build-help
go-build-help:
	$(info $(go-build.mk))
	@echo ""
#______________________________________________________________________________#


##### ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ #####
##                                                                            ##
#  Usage: `make go-build`                                                      #
#  Description: Build go binaries.                                             #
#  Examples:                                                                   #
#    make go-build                                                             #
#    make go-build GO_BUILD_TARGET=./cmd/foo                                   #
#    make go-build GOOS=windows                                                #
#    make go-build GOOS=windows GOARCH=arm64                                   #
#    make go-build CGO_ENABLED=1 GOOS=windows GOARCH=arm64                     #
#                                                                              #
GO_BUILD_CMD := go build 
GO_BUILD_CMD += $(GO_BUILD_FLAGS)
GO_BUILD_CMD += -tags="$(GO_BUILD_TAGS)"
GO_BUILD_CMD += -ldflags="$(GO_BUILD_LDFLAGS)"
GO_BUILD_CMD += -gcflags="$(GO_BUILD_GCFLAGS)"
GO_BUILD_CMD += $(GO_BUILD_EXTRAS)
GO_BUILD_CMD += -o $(GO_BUILD_OUTPUT)

.PHONY: go-build
go-build:
	$(info INFO: GOOS=$(GOOS) GOARCH=$(GOARCH) CGO_ENABLED=$(CGO_ENABLED))
	$(info INFO: Output binaries in $(GO_BUILD_OUTPUT))
	@for target in $(GO_BUILD_TARGET); do \
	echo "INFO: Building $$target"; \
	$(GO_BUILD_CMD) $$target; \
	done
#______________________________________________________________________________#
