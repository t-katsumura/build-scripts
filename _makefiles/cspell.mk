INCLUDED += cspell # Basename of this makefile.
.DEFAULT_GOAL := cspell-help # Basename + "-help"
################################################################################
define cspell.mk
REQUIREMENTS:
  - cspell : `cspell` command must be available.
  - npm    : `npm` command must be available for `cspell-install`.

TARGETS:
  - cspell-help    : show help message.
  - cspell-install : install cspell using `npm -g`.
  - cspell         : run cspell command with given args.
  - cspell-run     : run spell check.

VARIABLES [default value]:
  - CSPELL_CMD     : cspell binary path. (Default "cspell")
  - CSPELL_VERSION : cspell version to install. (Default "latest")
  - CSPELL_TARGET  : target of spell check. (Default "./")
  - CSPELL_OPTION  : cspell lint command line option. (Default "--quiet")

REFERENCES:
  - https://cspell.org/
  - https://cspell.org/docs/installation/
  - https://marketplace.visualstudio.com/items?itemName=streetsidesoftware.code-spell-checker
endef
################################################################################


CSPELL_CMD ?= cspell
CSPELL_VERSION ?= latest
CSPELL_TARGET ?= ./
CSPELL_OPTION ?= --quiet


##### ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ #####
##                                                                            ##
#  Usage: `make cspell-help`                                                   #
#  Description: Show help message.                                             #
#                                                                              #
.PHONY: cspell-help
cspell-help:
	$(info $(cspell.mk))
	@echo ""
#______________________________________________________________________________#


##### ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ #####
##                                                                            ##
#  Usage: `make cspell-install`                                                #
#  Description: Install cspell using `npm -g`.                                 #
#                                                                              #
.PHONY: cspell-install
cspell-install:
ifeq ("cspell-install","$(MAKECMDGOALS)")
	npm install -g "cspell@$(CSPELL_VERSION)"
else
ifeq (,$(shell which $(CSPELL_CMD) 2>/dev/null))
	npm install -g "cspell@$(CSPELL_VERSION)"
endif
endif
#______________________________________________________________________________#


##### ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ #####
##                                                                            ##
#  Usage: `make cspell ARGS=""`                                                #
#  Description: Run cspell with given arguments.                               #
#  Examples:                                                                   #
#    make cspell ARGS="--version"                                              #
#    make cspell ARGS="--help"                                                 #
#                                                                              #
.PHONY: cspell
cspell: cspell-install
	$(CSPELL_CMD) $(ARGS)
#______________________________________________________________________________#


##### ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ #####
##                                                                            ##
#  Usage: `make cspell-run`                                                    #
#  Description: Run spell check.                                               #
#                                                                              #
.PHONY: cspell-run
cspell-run: cspell-install
	$(CSPELL_CMD) lint $(CSPELL_OPTION) $(CSPELL_TARGET)
#______________________________________________________________________________#
