INCLUDED += shfmt # Basename of this makefile.
.DEFAULT_GOAL := shfmt-help # Basename + "-help"
################################################################################
define shfmt.mk
REQUIREMENTS:
  - shfmt : `shfmt` command must be available.
  - go    : `go` command must be available for `shfmt-install`.

TARGETS:
  - shfmt-help    : show help message.
  - shfmt         : run shfmt command with given args.
  - shfmt-install : install shfmt using `go install`.
  - shfmt-run     : run shfmt to format.

VARIABLES [default value]:
  - SHFMT_CMD     : shfmt binary path. (Default "$(GOBIN)shfmt")
  - SHFMT_VERSION : shfmt version to install. (Default "latest")
  - SHFMT_TARGET  : target of shell format. (Default "./")
  - SHFMT_OPTION  : shfmt command line option. (Default "--diff --write")

REFERENCES:
  - https://github.com/mvdan/sh
  - https://marketplace.visualstudio.com/items?itemName=mkhl.shfmt
  - https://marketplace.visualstudio.com/items?itemName=foxundermoon.shell-format
endef
################################################################################


SHFMT_CMD ?= $(GOBIN)shfmt
SHFMT_VERSION ?= latest
SHFMT_TARGET ?= ./
SHFMT_OPTION ?= --diff --write


##### ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ #####
##                                                                            ##
#  Usage: `make shfmt-help`                                                    #
#  Description: Show help message.                                             #
#                                                                              #
.PHONY: shfmt-help
shfmt-help:
	$(info $(shfmt.mk))
	@echo ""
#______________________________________________________________________________#


##### ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ #####
##                                                                            ##
#  Usage: `make shfmt-install`                                                 #
#  Description: Install shfmt using `go install`.                              #
#                                                                              #
.PHONY: shfmt-install
shfmt-install:
ifeq ("shfmt-install","$(MAKECMDGOALS)")
	go install "mvdan.cc/sh/v3/cmd/shfmt@$(SHFMT_VERSION)"
else
ifeq (,$(shell which $(SHFMT_CMD) 2>/dev/null))
	go install "mvdan.cc/sh/v3/cmd/shfmt@$(SHFMT_VERSION)"
endif
endif
#______________________________________________________________________________#


##### ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ #####
##                                                                            ##
#  Usage: `make shfmt ARGS=""`                                                 #
#  Description: Run shfmt with given arguments.                                #
#  Examples:                                                                   #
#    make shfmt ARGS="--version"                                               #
#    make shfmt ARGS="--help"                                                  #
#                                                                              #
.PHONY: shfmt
shfmt: shfmt-install
	$(SHFMT_CMD) $(ARGS)
#______________________________________________________________________________#


##### ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ #####
##                                                                            ##
#  Usage: `make shfmt-run`                                                     #
#  Description: Run shfmt for the specified targets.                           #
#                                                                              #
.PHONY: shfmt-run
shfmt-run: shfmt-install
	$(SHFMT_CMD) $(SHFMT_OPTION) $(SHFMT_TARGET)
#______________________________________________________________________________#
