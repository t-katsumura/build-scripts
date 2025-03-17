INCLUDED += golangci-lint # Basename of this makefile.
.DEFAULT_GOAL := golangci-lint-help # Basename + "-help"

GOLANGCI_LINT_CMD ?= $(GOBIN)golangci-lint
GOLANGCI_LINT_VERSION ?= latest
GOLANGCI_LINT_TARGET ?= ./...
GOLANGCI_LINT_OPTION ?= 

################################################################################
define golangci-lint.mk
REQUIREMENTS:
  - golangci-lint : `golangci-lint` command must be available.
  - go            : `go` command must be available for `golangci-lint-install`.

TARGETS:
  - golangci-lint-help    : show help message.
  - golangci-lint-install : install golangci-lint using `go install`.
  - golangci-lint         : run golangci-lint command with given args.
  - golangci-lint-run     : run lint.

VARIABLES [default value]:
  - GOLANGCI_LINT_CMD     : golangci-lint binary path. (Default "$(GOBIN)golangci-lint")
  - GOLANGCI_LINT_VERSION : golangci-lint version to install. (Default "latest")
  - GOLANGCI_LINT_TARGET  : lint target. (Default "./...")
  - GOLANGCI_LINT_OPTION  : command line option for lint. (Default "")

REFERENCES:
  - https://github.com/golangci/golangci-lint
  - https://golangci-lint.run/
endef
################################################################################


##### ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ #####
##                                                                            ##
#  Usage: `make golangci-lint-help`                                            #
#  Description: Show help message.                                             #
#                                                                              #
.PHONY: golangci-lint-help
golangci-lint-help:
	$(info $(golangci-lint.mk))
	@echo ""
#______________________________________________________________________________#


##### ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ #####
##                                                                            ##
#  Usage: `make golangci-lint-install`                                         #
#  Description: Install golangci-lint using `go install`.                      #
#                                                                              #
.PHONY: golangci-lint-install
golangci-lint-install:
ifeq ("golangci-lint-install","$(MAKECMDGOALS)")
	go install "github.com/golangci/golangci-lint/cmd/golangci-lint@$(GOLANGCI_LINT_VERSION)"
else
ifeq (,$(shell which $(GOLANGCI_LINT_CMD) 2>/dev/null))
	go install "github.com/golangci/golangci-lint/cmd/golangci-lint@$(GOLANGCI_LINT_VERSION)"
endif
endif
#______________________________________________________________________________#


##### ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ #####
##                                                                            ##
#  Usage: `make golangci-lint ARGS=""`                                         #
#  Description: Run golangci-lint with given arguments.                        #
#  Examples:                                                                   #
#    make golangci-lint ARGS="--version"                                       #
#    make golangci-lint ARGS="--help"                                          #
#                                                                              #
.PHONY: golangci-lint
golangci-lint: golangci-lint-install
	$(GOLANGCI_LINT_CMD) $(ARGS)
#______________________________________________________________________________#


##### ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ #####
##                                                                            ##
#  Usage: `make golangci-lint-run`                                             #
#  Description: `Run golangci-lint for the specified targets.`                 #
#                                                                              #
.PHONY: golangci-lint-run
golangci-lint-run: golangci-lint-install
	$(GOLANGCI_LINT_CMD) run $(GOLANGCI_LINT_OPTION) $(GOLANGCI_LINT_TARGET)
#______________________________________________________________________________#
