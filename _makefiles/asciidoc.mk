INCLUDED += asciidoc # Basename of this makefile.
.DEFAULT_GOAL := asciidoc-help # Basename + "-help"
################################################################################
define asciidoc.mk
REQUIREMENTS:
  - asciidoctor       : `asciidoctor` command must be available for `make asciidoc-html`.
  - asciidoctor-pdf   : `asciidoctor-pdf` command must be available for `make asciidoc-pdf`.
  - asciidoctor-epub3 : `asciidoctor-epub3` command must be available for `make asciidoc-epub`.

TARGETS:
  - asciidoc-help : show help message.
  - asciidoc      : run asciidoctor command with given args.
  - asciidoc-html : export adoc as html.
  - asciidoc-pdf  : export adoc as pdf.
  - asciidoc-epub : export adoc as epub.

VARIABLES [default value]:
  - ASCIIDOC_CMD      : asciidoctor binary path. (Default "asciidoctor")
  - ASCIIDOC_CMD_PDF  : asciidoctor-pdf binary path. (Default "asciidoctor-pdf")
  - ASCIIDOC_CMD_EPUB : asciidoctor-epub3 binary path. (Default "asciidoctor-epub3")
  - ASCIIDOC_TARGET   : target of asciidoc. (Default is all "index.adoc" files)
  - ASCIIDOC_OPTION   : asciidoctor command line option. (Default "")
  - ASCIIDOC_ATTRS    : "--attribute" options. (Default "")
  - ASCIIDOC_REQS     : "--require" options. (Default "asciidoctor-diagram asciidoctor-lists")

REFERENCES:
  - https://asciidoc.org/
	- https://docs.asciidoctor.org/
	- https://asciidoctor.org/docs/extensions/
  - https://marketplace.visualstudio.com/items?itemName=asciidoctor.asciidoctor-vscode
endef
################################################################################


ASCIIDOC_CMD ?= asciidoctor
ASCIIDOC_CMD_PDF ?= asciidoctor-pdf
ASCIIDOC_CMD_EPUB ?= asciidoctor-epub3
ASCIIDOC_TARGET ?= $(shell find . -type f -name 'index.adoc' 2>/dev/null)
ASCIIDOC_OPTION ?=
ASCIIDOC_ATTRS ?=
ASCIIDOC_ATTRS := $(addprefix --attribute=,$(ASCIIDOC_ATTRS))
ASCIIDOC_REQS ?= asciidoctor-diagram asciidoctor-lists
ASCIIDOC_REQS := $(addprefix --require=,$(ASCIIDOC_REQS))


##### ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ #####
##                                                                            ##
#  Usage: `make asciidoc-help`                                                   #
#  Description: Show help message.                                             #
#                                                                              #
.PHONY: asciidoc-help
asciidoc-help:
	$(info $(asciidoc.mk))
	@echo ""
#______________________________________________________________________________#


##### ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ #####
##                                                                            ##
#  Usage: `make asciidoc ARGS=""`                                              #
#  Description: Run asciidoctor with given arguments.                          #
#  Examples:                                                                   #
#    make asciidoc ARGS="--version"                                            #
#    make asciidoc ARGS="--help"                                               #
#                                                                              #
.PHONY: asciidoc
asciidoc:
	$(ASCIIDOC_CMD) $(ARGS)
#______________________________________________________________________________#


##### ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ #####
##                                                                            ##
#  Usage: `make asciidoc-html`                                                 #
#  Description: Export asciidoc as html.                                       #
#                                                                              #
.PHONY: asciidoc-html
asciidoc-html:
	$(ASCIIDOC_CMD) $(ASCIIDOC_OPTION) $(ASCIIDOC_ATTRS) $(ASCIIDOC_REQS) $(ASCIIDOC_TARGET)
#______________________________________________________________________________#


##### ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ #####
##                                                                            ##
#  Usage: `make asciidoc-pdf`                                                  #
#  Description: Export asciidoc as pdf.                                        #
#                                                                              #
.PHONY: asciidoc-pdf
asciidoc-pdf:
	$(ASCIIDOC_CMD_PDF) $(ASCIIDOC_OPTION) $(ASCIIDOC_ATTRS) $(ASCIIDOC_REQS) $(ASCIIDOC_TARGET)
#______________________________________________________________________________#


##### ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ #####
##                                                                            ##
#  Usage: `make asciidoc-epub`                                                 #
#  Description: Export asciidoc as epub.                                       #
#                                                                              #
.PHONY: asciidoc-epub
asciidoc-epub:
	$(ASCIIDOC_CMD_EPUB) $(ASCIIDOC_OPTION) $(ASCIIDOC_ATTRS) $(ASCIIDOC_REQS) $(ASCIIDOC_TARGET)
#______________________________________________________________________________#
