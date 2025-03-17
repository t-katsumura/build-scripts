INCLUDED += hugo # Basename of this makefile.
.DEFAULT_GOAL := hugo-help # Basename + "-help"
################################################################################
define hugo.mk
REQUIREMENTS:
  - hugo : `hugo` command must be available.
  - go          : `go` command must be available for `hugo-install`.

TARGETS:
  - hugo-help    : show help message.
  - hugo-install : install hugo using `go install`.
  - hugo         : run hugo command with given args.
  - hugo-run     : run vulnerability check.

VARIABLES [default value]:
  - HUGO_CMD     : hugo binary path. (Default "$(GOBIN)hugo")
  - HUGO_VERSION : hugo version to install. (Default "latest")
  - HUGO_TARGET  : target of vulnerability check. (Default "./...")
  - HUGO_OPTION  : hugo command line option. (Default "")

REFERENCES:
  - https://pkg.go.dev/golang.org/x/vuln/cmd/hugo
  - https://go.dev/doc/tutorial/hugo
endef
################################################################################


HUGO_CMD ?= $(GOBIN)hugo
HUGO_VERSION ?= latest
HUGO_TARGET ?= ./...
HUGO_OPTION ?= 


##### ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ #####
##                                                                            ##
#  Usage: `make hugo-help`                                              #
#  Description: Show help message.                                             #
#                                                                              #
.PHONY: hugo-help
hugo-help:
	$(info $(hugo.mk))
	@echo ""
#______________________________________________________________________________#


##### ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ #####
##                                                                            ##
#  Usage: `make hugo-install`                                           #
#  Description: Install hugo using `go install`.                        #
#                                                                              #
.PHONY: hugo-install
hugo-install:
ifeq ("hugo-install","$(MAKECMDGOALS)")
	go install "golang.org/x/vuln/cmd/hugo@$(HUGO_VERSION)"
else
ifeq (,$(shell which $(HUGO_CMD) 2>/dev/null))
	go install "golang.org/x/vuln/cmd/hugo@$(HUGO_VERSION)"
endif
endif
#______________________________________________________________________________#


##### ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ #####
##                                                                            ##
#  Usage: `make hugo ARGS=""`                                           #
#  Description: Run govulcheck with given arguments.                           #
#  Examples:                                                                   #
#    make hugo ARGS="-version"                                          #
#    make hugo ARGS="-help"                                             #
#                                                                              #
.PHONY: hugo
hugo: hugo-install
	$(HUGO_CMD) $(ARGS)
#______________________________________________________________________________#


##### ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ #####
##                                                                            ##
#  Usage: `make hugo-run`                                               #
#  Description: Run vulnerability check.                                       #
#                                                                              #
.PHONY: hugo-run
hugo-run: hugo-install
	$(HUGO_CMD) $(HUGO_OPTION) $(HUGO_TARGET)
#______________________________________________________________________________#
