INCLUDED += prettier # Basename of this makefile.
.DEFAULT_GOAL := prettier-help # Basename + "-help"
################################################################################
define prettier.mk
REQUIREMENTS:
  - prettier : `prettier` command must be available.
  - npm      : `npm` command must be available for `prettier-install`.

TARGETS:
  - prettier-help    : show help message.
  - prettier-install : install prettier using `npm -g`.
  - prettier         : run prettier command with given args.
  - prettier-run     : run prettier.

VARIABLES [default value]:
  - PRETTIER_CMD     : prettier binary path. (Default "prettier")
  - PRETTIER_VERSION : prettier version to install. (Default "latest")
  - PRETTIER_TARGET  : target of prettier. (Default "**/*.{md,yaml,yml,json,xml,toml,js,jsx,ts,html,css}")
  - PRETTIER_OPTION  : prettier command line option. (Default "--write")

REFERENCES:
  - https://prettier.io/
  - https://github.com/prettier/prettier
  - https://www.npmjs.com/package/prettier
  - https://marketplace.visualstudio.com/items?itemName=esbenp.prettier-vscode
endef
################################################################################


PRETTIER_CMD ?= prettier
PRETTIER_VERSION ?= latest
PRETTIER_TARGET ?= "**/*.{md,yaml,yml,json,xml,toml,js,jsx,ts,html,css}"
PRETTIER_OPTION ?= --write


##### ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ #####
##                                                                            ##
#  Usage: `make prettier-help`                                                 #
#  Description: Show help message.                                             #
#                                                                              #
.PHONY: prettier-help
prettier-help:
	$(info $(prettier.mk))
	@echo ""
#______________________________________________________________________________#


##### ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ #####
##                                                                            ##
#  Usage: `make prettier-install`                                              #
#  Description: Install prettier using `npm -g`.                               #
#                                                                              #
.PHONY: prettier-install
prettier-install:
ifeq ("prettier-install","$(MAKECMDGOALS)")
	npm install -g "prettier@$(PRETTIER_VERSION)"
else
ifeq (,$(shell which $(PRETTIER_CMD) 2>/dev/null))
	npm install -g "prettier@$(PRETTIER_VERSION)"
endif
endif
#______________________________________________________________________________#


##### ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ #####
##                                                                            ##
#  Usage: `make prettier ARGS=""`                                              #
#  Description: Run prettier with given arguments.                             #
#  Examples:                                                                   #
#    make prettier ARGS="--version"                                            #
#    make prettier ARGS="--help"                                               #
#                                                                              #
.PHONY: prettier
prettier: prettier-install
	$(PRETTIER_CMD) $(ARGS)
#______________________________________________________________________________#


##### ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ #####
##                                                                            ##
#  Usage: `make prettier-run`                                                  #
#  Description: Run prettier.                                                  #
#                                                                              #
.PHONY: prettier-run
prettier-run: prettier-install
	$(PRETTIER_CMD) $(PRETTIER_OPTION) $(PRETTIER_TARGET)
#______________________________________________________________________________#
