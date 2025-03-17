INCLUDED += drawio # Basename of this makefile.
.DEFAULT_GOAL := drawio-help # Basename + "-help"
################################################################################
define drawio.mk
REQUIREMENTS:
  - drawio : `drawio` command must be available.

TARGETS:
  - drawio-help : show help message.
  - drawio      : run drawio command with given args.
  - drawio-jpg  : convert *.drawio to *.jpg.
  - drawio-png  : convert *.drawio to *.png.
  - drawio-svg  : convert *.drawio to *.svg.

VARIABLES [default value]:
  - DRAWIO_CMD        : drawio binary path. (Default "drawio")
  - DRAWIO_TARGET     : target of spell check. (Default is all *.drawio files)
  - DRAWIO_OPTION_JPG : drawio command line option for jpg. (Default "--quality 100")
  - DRAWIO_OPTION_PNG : drawio command line option for png. (Default "--transparent")
  - DRAWIO_OPTION_SVG : drawio command line option for svg. (Default "")
  - DRAWIO_OPTION_PDF : drawio command line option for pdf. (Default "--crop")

REFERENCES:
  - https://github.com/jgraph/drawio-desktop
  - https://www.drawio.com/
  - https://marketplace.visualstudio.com/items?itemName=hediet.vscode-drawio
endef
################################################################################


DRAWIO_CMD ?= drawio
DRAWIO_TARGET ?= $(shell find . -type f -name '*.drawio' 2>/dev/null)
DRAWIO_OPTION_JPG ?= --quality 100
DRAWIO_OPTION_PNG ?= --transparent
DRAWIO_OPTION_SVG ?=
DRAWIO_OPTION_PDF ?= --crop


##### ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ #####
##                                                                            ##
#  Usage: `make drawio-help`                                                   #
#  Description: Show help message.                                             #
#                                                                              #
.PHONY: drawio-help
drawio-help:
	$(info $(drawio.mk))
	@echo ""
#______________________________________________________________________________#


##### ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ #####
##                                                                            ##
#  Usage: `make drawio ARGS=""`                                                #
#  Description: Run drawio with given arguments.                               #
#  Examples:                                                                   #
#    make drawio ARGS="--version"                                              #
#    make drawio ARGS="--help"                                                 #
#                                                                              #
.PHONY: drawio
drawio:
	$(DRAWIO_CMD) $(ARGS)
#______________________________________________________________________________#


##### ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ #####
##                                                                            ##
#  Usage: `make drawio-jpg`                                                    #
#  Description: Export drawio as jpg.                                          #
#                                                                              #
.PHONY: drawio-jpg
drawio-jpg:
	@for target in $(DRAWIO_TARGET); do \
	$(DRAWIO_CMD) --export --format jpg $(DRAWIO_OPTION_JPG) $$target; \
	done
#______________________________________________________________________________#


##### ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ #####
##                                                                            ##
#  Usage: `make drawio-png`                                                    #
#  Description: Export drawio as png.                                          #
#                                                                              #
.PHONY: drawio-png
drawio-png:
	@for target in $(DRAWIO_TARGET); do \
	$(DRAWIO_CMD) --export --format png $(DRAWIO_OPTION_PNG) $$target; \
	done
#______________________________________________________________________________#


##### ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ #####
##                                                                            ##
#  Usage: `make drawio-svg`                                                    #
#  Description: Export drawio as svg.                                          #
#                                                                              #
.PHONY: drawio-svg
drawio-svg:
	@for target in $(DRAWIO_TARGET); do \
	$(DRAWIO_CMD) --export --format svg $(DRAWIO_OPTION_SVG) $$target; \
	done
#______________________________________________________________________________#


##### ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ #####
##                                                                            ##
#  Usage: `make drawio-pdf`                                                    #
#  Description: Export drawio as pdf.                                          #
#                                                                              #
.PHONY: drawio-pdf
drawio-pdf:
	@for target in $(DRAWIO_TARGET); do \
	$(DRAWIO_CMD) --export --format pdf $(DRAWIO_OPTION_PDF) $$target; \
	done
#______________________________________________________________________________#
