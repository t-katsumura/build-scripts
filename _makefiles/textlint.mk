INCLUDED += textlint # Basename of this makefile.
.DEFAULT_GOAL := textlint-help # Basename + "-help"
################################################################################
define textlint.mk
REQUIREMENTS:
  - textlint : `textlint` command must be available.
  - npm      : `npm` command must be available for `textlint-install`.

TARGETS:
  - textlint-help    : show help message.
  - textlint-install : install textlint using `npm -g`.
  - textlint         : run textlint command with given args.
  - textlint-run     : run textlint.

VARIABLES [default value]:
  - TEXTLINT_CMD      : textlint binary path. (Default "textlint")
  - TEXTLINT_VERSION  : textlint version to install. (Default "latest")
  - TEXTLINT_PACKAGES : additional packages that will be installed with textlint. (Default "")
  - TEXTLINT_TARGET   : target of linting. (Default "./")
  - TEXTLINT_OPTION   : textlint command line option. (Default "")

REFERENCES:
  - https://github.com/textlint/textlint
  - https://textlint.github.io/
  - https://marketplace.visualstudio.com/items?itemName=taichi.vscode-textlint
endef
################################################################################


TEXTLINT_CMD ?= textlint
TEXTLINT_VERSION ?= latest
TEXTLINT_PACKAGES ?=
TEXTLINT_TARGET ?= "./"
TEXTLINT_OPTION ?=


##### ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ #####
##                                                                            ##
#  Usage: `make textlint-help`                                                 #
#  Description: Show help message.                                             #
#                                                                              #
.PHONY: textlint-help
textlint-help:
	$(info $(textlint.mk))
	@echo ""
#______________________________________________________________________________#


##### ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ #####
##                                                                            ##
#  Usage: `make textlint-install`                                              #
#  Description: Install textlint using `npm -g`.                               #
#                                                                              #
.PHONY: textlint-install
textlint-install:
ifeq ("textlint-install","$(MAKECMDGOALS)")
	npm install -g "textlint@$(TEXTLINT_VERSION)" $(TEXTLINT_PACKAGES)
else
ifeq (,$(shell which $(TEXTLINT_CMD) 2>/dev/null))
	npm install -g "textlint@$(TEXTLINT_VERSION)" $(TEXTLINT_PACKAGES)
endif
endif
#______________________________________________________________________________#


##### ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ #####
##                                                                            ##
#  Usage: `make textlint ARGS=""`                                              #
#  Description: Run textlint with given arguments.                             #
#  Examples:                                                                   #
#    make textlint ARGS="--version"                                            #
#    make textlint ARGS="--help"                                               #
#                                                                              #
.PHONY: textlint
textlint: textlint-install
	$(TEXTLINT_CMD) $(ARGS)
#______________________________________________________________________________#


##### ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ #####
##                                                                            ##
#  Usage: `make textlint-run`                                                  #
#  Description: Run linting.                                                   #
#                                                                              #
.PHONY: textlint-run
textlint-run: textlint-install
	$(TEXTLINT_CMD) $(TEXTLINT_OPTION) $(TEXTLINT_TARGET)
#______________________________________________________________________________#
