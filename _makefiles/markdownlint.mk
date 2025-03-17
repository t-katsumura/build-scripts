INCLUDED += markdownlint # Basename of this makefile.
.DEFAULT_GOAL := markdownlint-help # Basename + "-help"
################################################################################
define markdownlint.mk
REQUIREMENTS:
  - markdownlint : `markdownlint` command must be available.
  - npm          : `npm` command must be available for `markdownlint-install`.

TARGETS:
  - markdownlint-help    : show help message.
  - markdownlint-install : install markdownlint using `npm -g` command.
  - markdownlint         : run markdownlint command with given args.
  - markdownlint-run     : run lint.

VARIABLES [default value]:
  - MARKDOWNLINT_CMD     : markdownlint binary path. (Default "markdownlint")
  - MARKDOWNLINT_VERSION : markdownlint version to install. (Default "latest")
  - MARKDOWNLINT_TARGET  : target of lint. (Default "./")
  - MARKDOWNLINT_OPTION  : markdownlint command line option. (Default "--quiet")

REFERENCES:
  - https://markdownlint.org/
  - https://markdownlint.org/docs/installation/
  - https://marketplace.visualstudio.com/items?itemName=streetsidesoftware.code-spell-checker
endef
################################################################################


MARKDOWNLINT_CMD ?= markdownlint
MARKDOWNLINT_VERSION ?= latest
MARKDOWNLINT_TARGET ?= ./
MARKDOWNLINT_OPTION ?=


##### ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ #####
##                                                                            ##
#  Usage: `make markdownlint-help`                                             #
#  Description: Show help message.                                             #
#                                                                              #
.PHONY: markdownlint-help
markdownlint-help:
	$(info $(markdownlint.mk))
	@echo ""
#______________________________________________________________________________#


##### ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ #####
##                                                                            ##
#  Usage: `make markdownlint-install`                                          #
#  Description: Install markdownlint using `npm -g`.                           #
#                                                                              #
.PHONY: markdownlint-install
markdownlint-install:
ifeq ("markdownlint-install","$(MAKECMDGOALS)")
	npm install -g "markdownlint@$(MARKDOWNLINT_VERSION)"
else
ifeq (,$(shell which $(MARKDOWNLINT_CMD) 2>/dev/null))
	npm install -g "markdownlint@$(MARKDOWNLINT_VERSION)"
endif
endif
#______________________________________________________________________________#


##### ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ #####
##                                                                            ##
#  Usage: `make markdownlint ARGS=""`                                          #
#  Description: Run markdownlint with given arguments.                         #
#  Examples:                                                                   #
#    make markdownlint ARGS="--version"                                        #
#    make markdownlint ARGS="--help"                                           #
#                                                                              #
.PHONY: markdownlint
markdownlint: markdownlint-install
	$(MARKDOWNLINT_CMD) $(ARGS)
#______________________________________________________________________________#


##### ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ #####
##                                                                            ##
#  Usage: `make markdownlint-run`                                              #
#  Description: Run markdownlint for the specified targets.                    #
#                                                                              #
.PHONY: markdownlint-run
markdownlint-run: markdownlint-install
	$(MARKDOWNLINT_CMD) $(MARKDOWNLINT_OPTION) $(MARKDOWNLINT_TARGET)
#______________________________________________________________________________#
