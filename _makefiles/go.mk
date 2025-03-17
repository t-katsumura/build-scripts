INCLUDED += go # Basename of this makefile.
.DEFAULT_GOAL := go-help # Basename + "-help"

GO_CMD ?= go
# go vet envs.
GO_VET_TARGET ?= ./...
GO_VET_OPTION ?=
# go fmt envs.
GO_FMT_TARGET ?= ./...
GO_FMT_OPTION ?=


################################################################################
define go.mk
REQUIREMENTS:
  - go : `go` command must be available.

TARGETS:
  - go-help : show help message.
  - go      : run go command with given args.
  - go-vet  : run `go vet`.
  - go-fmt  : run `go fmt`.

VARIABLES [default value]:
  - GO_CMD         : go command. [go]
  - GO_VET_TARGET  : go vet target. [./...]
  - GO_VET_OPTION  : go vet command line option. []
  - GO_FMT_TARGET  : go fmt target. [./...]
  - GO_FMT_OPTION  : go fmt command line option. []

REFERENCES:
  - https://pkg.go.dev/cmd/vet
  - https://pkg.go.dev/cmd/gofmt
  - https://go.dev/blog/gofmt

PROJECT STRUCTURE:
  /                  |-- Go project
  ├─ scripts/        |-- Git submodule
  │  └─ _makefiles/  |
  │     └─ go.mk     |
  ├─ Makefile        |-- include scripts/_makefiles/go.mk
  ├─ go.mod          |
  └─ go.sum          |
endef
################################################################################


##### ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ #####
##                                                                            ##
#                                                                              #
.PHONY: go-help-usage
go-help-usage:
	# Usage : make go-help
	# Exec  : -
	# Desc  : Show help message.
	# Examples:
	#   - make go-help

.PHONY: go-help
go-help:
	$(info $(go.mk))
	@echo ""
#______________________________________________________________________________#


##### ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ #####
##                                                                            ##
#                                                                              #
.PHONY: go-usage
go-usage:
	# Usage : make go ARGS=""
	# Exec  : $$(GO_CMD) $$(ARGS)
	# Desc  : Run go with given arguments.
	# Examples:
	#   - make go ARGS="version"
	#   - make go ARGS="help"

.PHONY: go
go:
	$(GO_CMD) $(ARGS)
#______________________________________________________________________________#


##### ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ #####
##                                                                            ##
#                                                                              #
.PHONY: go-vet-usage
go-vet-usage:
	# Usage : make go-vet ARGS=""
	# Exec  : $$(GO_CMD) vet $$(ARGS) $$(GO_VET_OPTION) $$(GO_VET_TARGET)
	# Desc  : Run go vet for the specified targets.
	#         Run `go tool vet help` or `go help vet` to show help.
	# Examples:
	#   - make go-vet
	#   - make go-vet ARGS=""

.PHONY: go-vet
go-vet:
	$(GO_CMD) vet $(ARGS) $(GO_VET_OPTION) $(GO_VET_TARGET)
#______________________________________________________________________________#


##### ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ #####
##                                                                            ##
#                                                                              #
.PHONY: go-fmt-usage
go-fmt-usage:
	# Usage : make go-fmt ARGS=""
	# Exec  : $$(GO_CMD) fmt $$(ARGS) $$(GO_FMT_OPTION) $$(GO_FMT_TARGET)
	# Desc  : Run go fmt for the specified targets.
	#         Run `go help fmt` to show help.
	# Examples:
	#   - make go-fmt
	#   - make go-fmt ARGS=""

.PHONY: go-fmt
go-fmt:
	$(GO_CMD) fmt $(ARGS) $(GO_FMT_OPTION) $(GO_FMT_TARGET)
#______________________________________________________________________________#
