INCLUDED += clang-format # Basename of this makefile.
.DEFAULT_GOAL := clang-format-help # Basename + "-help"
################################################################################
define clang-format.mk
REQUIREMENTS:
  - clang-format : `clang-format` command must be available.

TARGETS:
  - clang-format-help : show help message.
  - clang-format      : run clang-format command with given args.
  - clang-format-run  : run formatting.

VARIABLES [default value]:
  - CLANG_FORMAT_CMD    : clang-format binary path. (Default "clang-format")
  - CLANG_FORMAT_TARGET : format target files. (Default "")
  - CLANG_FORMAT_OPTION : clang-format lint command line option. (Default "")

REFERENCES:
  - https://clang.llvm.org/docs/ClangFormat.html
  - https://clang.llvm.org/docs/ClangFormatStyleOptions.html
  - https://marketplace.visualstudio.com/items?itemName=xaver.clang-format
endef
################################################################################


CLANG_FORMAT_CMD ?= clang-format
CLANG_FORMAT_VERSION ?= latest
CLANG_FORMAT_TARGET ?=
CLANG_FORMAT_OPTION ?=


##### ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ #####
##                                                                            ##
#  Usage: `make clang-format-help`                                             #
#  Description: Show help message.                                             #
#                                                                              #
.PHONY: clang-format-help
clang-format-help:
	$(info $(clang-format.mk))
	@echo ""
#______________________________________________________________________________#


##### ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ #####
##                                                                            ##
#  Usage: `make clang-format ARGS=""`                                          #
#  Description: Run clang-format with given arguments.                         #
#  Examples:                                                                   #
#    make clang-format ARGS="--version"                                        #
#    make clang-format ARGS="--help"                                           #
#    make clang-format ARGS=" --style=Google --dump-config"                    #
#    make clang-format ARGS=" --style=llvm --dump-config"                      #
#                                                                              #
.PHONY: clang-format
clang-format:
	$(CLANG_FORMAT_CMD) $(ARGS)
#______________________________________________________________________________#


##### ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ #####
##                                                                            ##
#  Usage: `make clang-format-run`                                              #
#  Description: Run formatting.                                                #
#                                                                              #
.PHONY: clang-format-run
clang-format-run:
	$(CLANG_FORMAT_CMD) $(CLANG_FORMAT_OPTION) $(CLANG_FORMAT_TARGET)
#______________________________________________________________________________#
