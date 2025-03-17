INCLUDED += shellcheck # Basename of this makefile.
.DEFAULT_GOAL := shellcheck-help # Basename + "-help"
################################################################################
define shellcheck.mk
REQUIREMENTS:
  - shellcheck : `shellcheck` command must be available.

TARGETS:
  - shellcheck-help : show help message.
  - shellcheck      : run shellcheck command with given args.
  - shellcheck-run  : run checks.

VARIABLES [default value]:
  - SHELLCHECK_CMD     : shellcheck binary path. (Default "shellcheck")
  - SHELLCHECK_TARGET  : target of spell check. (Default is all *.sh files)
  - SHELLCHECK_OPTION  : shellcheck command line option. (Default "")

REFERENCES:
  - https://github.com/koalaman/shellcheck
  - https://www.shellcheck.net/
  - hhttps://marketplace.visualstudio.com/items?itemName=timonwong.shellcheck
endef
################################################################################


SHELLCHECK_CMD ?= shellcheck
SHELLCHECK_TARGET ?= $(shell find . -type f -name '*.sh' 2>/dev/null)
SHELLCHECK_OPTION ?=


##### ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ #####
##                                                                            ##
#  Usage: `make shellcheck-help`                                               #
#  Description: Show help message.                                             #
#                                                                              #
.PHONY: shellcheck-help
shellcheck-help:
	$(info $(shellcheck.mk))
	@echo ""
#______________________________________________________________________________#


##### ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ #####
##                                                                            ##
#  Usage: ` make shellcheck ARGS=""`                                           #
#  Description: Run shellcheck with given arguments.                           #
#  Examples:                                                                   #
#    make shellcheck ARGS="--version"                                          #
#    make shellcheck ARGS="--help"                                             #
#                                                                              #
.PHONY: shellcheck
shellcheck:
	$(SHELLCHECK_CMD) $(ARGS)
#______________________________________________________________________________#


##### ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ #####
##                                                                            ##
#  Usage: `make shellcheck-run`                                                #
#  Description: Run shellcheck for the specified target.                       #
#                                                                              #
.PHONY: shellcheck-run
shellcheck-run:
	$(SHELLCHECK_CMD) $(SHELLCHECK_OPTION) $(SHELLCHECK_TARGET)
#______________________________________________________________________________#
