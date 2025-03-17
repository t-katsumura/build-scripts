INCLUDED += protolint # Basename of this makefile.
.DEFAULT_GOAL := protolint-help # Basename + "-help"
################################################################################
define protolint.mk
REQUIREMENTS:
  - protolint : `protolint` command must be available.
  - go        : `go` command must be available for `protolint-install`.

TARGETS:
  - protolint-help    : show help message.
  - protolint         : run protolint command with given args.
  - protolint-install : install protolint using `go install`.
  - protolint-run     : run protolint.

VARIABLES [default value]:
  - PROTOLINT_CMD     : protolint binary path. (Default "$(GOBIN)protolint")
  - PROTOLINT_VERSION : protolint version to install. (Default "latest")
  - PROTOLINT_TARGET  : target of lint. (Default "./")
  - PROTOLINT_OPTION  : protolint command line option. (Default "")

REFERENCES:
  - https://github.com/yoheimuta/protolint
  - https://marketplace.visualstudio.com/items?itemName=Plex.vscode-protolint
endef
################################################################################


PROTOLINT_CMD ?= $(GOBIN)protolint
PROTOLINT_VERSION ?= latest
PROTOLINT_TARGET ?= ./
PROTOLINT_OPTION ?=


##### ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ #####
##                                                                            ##
#  Usage: `make protolint-help`                                                #
#  Description: Show help message.                                             #
#                                                                              #
.PHONY: protolint-help
protolint-help:
	$(info $(protolint.mk))
	@echo ""
#______________________________________________________________________________#


##### ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ #####
##                                                                            ##
#  Usage: `make protolint-install`                                             #
#  Description: Install protolint using `go install`.                          #
#                                                                              #
.PHONY: protolint-install
protolint-install:
ifeq ("protolint-install","$(MAKECMDGOALS)")
	go install "github.com/yoheimuta/protolint/cmd/protolint@$(PROTOLINT_VERSION)"
else
ifeq (,$(shell which $(PROTOLINT_CMD) 2>/dev/null))
	go install "github.com/yoheimuta/protolint/cmd/protolint@$(PROTOLINT_VERSION)"
endif
endif
#______________________________________________________________________________#


##### ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ #####
##                                                                            ##
#  Usage: `make protolint ARGS=""`                                             #
#  Description: Run protolint with given arguments.                            #
#  Examples:                                                                   #
#    make protolint ARGS="--help"                                              #
#                                                                              #
.PHONY: protolint
protolint: protolint-install
	$(PROTOLINT_CMD) $(ARGS)
#______________________________________________________________________________#


##### ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ #####
##                                                                            ##
#  Usage: `make protolint-run`                                                 #
#  Description: Run protolint for the specified targets.                       #
#                                                                              #
.PHONY: protolint-run
protolint-run: protolint-install
	$(PROTOLINT_CMD) $(PROTOLINT_OPTION) $(PROTOLINT_TARGET)
#______________________________________________________________________________#
