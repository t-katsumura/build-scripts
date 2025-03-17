INCLUDED += govulncheck # Basename of this makefile.
.DEFAULT_GOAL := govulncheck-help # Basename + "-help"
################################################################################
define govulncheck.mk
REQUIREMENTS:
  - govulncheck : `govulncheck` command must be available.
  - go          : `go` command must be available for `govulncheck-install`.

TARGETS:
  - govulncheck-help    : show help message.
  - govulncheck-install : install govulncheck using `go install`.
  - govulncheck         : run govulncheck command with given args.
  - govulncheck-run     : run vulnerability check.

VARIABLES [default value]:
  - GOVULNCHECK_CMD     : govulncheck binary path. (Default "$(GOBIN)govulncheck")
  - GOVULNCHECK_VERSION : govulncheck version to install. (Default "latest")
  - GOVULNCHECK_TARGET  : target of vulnerability check. (Default "./...")
  - GOVULNCHECK_OPTION  : govulncheck command line option. (Default "")

REFERENCES:
  - https://pkg.go.dev/golang.org/x/vuln/cmd/govulncheck
  - https://go.dev/doc/tutorial/govulncheck
endef
################################################################################


GOVULNCHECK_CMD ?= $(GOBIN)govulncheck
GOVULNCHECK_VERSION ?= latest
GOVULNCHECK_TARGET ?= ./...
GOVULNCHECK_OPTION ?= 


##### ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ #####
##                                                                            ##
#  Usage: `make govulncheck-help`                                              #
#  Description: Show help message.                                             #
#                                                                              #
.PHONY: govulncheck-help
govulncheck-help:
	$(info $(govulncheck.mk))
	@echo ""
#______________________________________________________________________________#


##### ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ #####
##                                                                            ##
#  Usage: `make govulncheck-install`                                           #
#  Description: Install govulncheck using `go install`.                        #
#                                                                              #
.PHONY: govulncheck-install
govulncheck-install:
ifeq ("govulncheck-install","$(MAKECMDGOALS)")
	go install "golang.org/x/vuln/cmd/govulncheck@$(GOVULNCHECK_VERSION)"
else
ifeq (,$(shell which $(GOVULNCHECK_CMD) 2>/dev/null))
	go install "golang.org/x/vuln/cmd/govulncheck@$(GOVULNCHECK_VERSION)"
endif
endif
#______________________________________________________________________________#


##### ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ #####
##                                                                            ##
#  Usage: `make govulncheck ARGS=""`                                           #
#  Description: Run govulcheck with given arguments.                           #
#  Examples:                                                                   #
#    make govulncheck ARGS="-version"                                          #
#    make govulncheck ARGS="-help"                                             #
#                                                                              #
.PHONY: govulncheck
govulncheck: govulncheck-install
	$(GOVULNCHECK_CMD) $(ARGS)
#______________________________________________________________________________#


##### ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ #####
##                                                                            ##
#  Usage: `make govulncheck-run`                                               #
#  Description: Run vulnerability check.                                       #
#                                                                              #
.PHONY: govulncheck-run
govulncheck-run: govulncheck-install
	$(GOVULNCHECK_CMD) $(GOVULNCHECK_OPTION) $(GOVULNCHECK_TARGET)
#______________________________________________________________________________#
