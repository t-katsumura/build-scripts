INCLUDED += trivy # Basename of this makefile.
.DEFAULT_GOAL := trivy-help # Basename + "-help"
################################################################################
define trivy.mk
REQUIREMENTS:
  - trivy : `trivy` command must be available.
  - go    : `go` command must be available for `trivy-install`.

TARGETS:
  - trivy-help    : show help message.
  - trivy         : run trivy command with given args.
  - trivy-install : install trivy using `go install`.
  - trivy-sbom    : generate sbom.

VARIABLES [default value]:
  - TRIVY_CMD          : trivy binary path. (Default "$(GOBIN)trivy")
  - TRIVY_VERSION      : trivy version to install. (Default "latest")
  - TRIVY_SBOM_TARGET  : sbom target modules. (Default "./")
  - TRIVY_SBOM_OPTION  : command line option for trivy. (Default "--license-full")
	- TRIVY_SBOM_FORMAT  : sbom output format. (Default "cyclonedx")
	- TRIVY_SBOM_OUTPUT  : sbom output file path. (Default "_output/sbom.json")

REFERENCES:
  - https://github.com/aquasecurity/trivy
  - https://trivy.dev/latest/docs/target/filesystem/
endef
################################################################################


TRIVY_CMD ?= $(GOBIN)trivy
TRIVY_VERSION ?= latest
TRIVY_SBOM_TARGET ?= ./
TRIVY_SBOM_OPTION ?= --license-full
TRIVY_SBOM_FORMAT ?= cyclonedx
TRIVY_SBOM_OUTPUT ?= _output/sbom.json


##### ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ #####
##                                                                            ##
#  Usage: `make trivy-help`                                                    #
#  Description: Show help message.                                             #
#                                                                              #
.PHONY: trivy-help
trivy-help:
	$(info $(trivy.mk))
	@echo ""
#______________________________________________________________________________#


##### ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ #####
##                                                                            ##
#  Usage: `make trivy-install`                                                 #
#  Description: Install trivy using `go install`.                              #
#                                                                              #
.PHONY: trivy-install
trivy-install:
ifeq ("trivy-install","$(MAKECMDGOALS)")
	go install "github.com/aquasecurity/trivy/cmd/trivy@$(TRIVY_VERSION)"
else
ifeq (,$(shell which $(TRIVY_CMD) 2>/dev/null))
	go install "github.com/aquasecurity/trivy/cmd/trivy@$(TRIVY_VERSION)"
endif
endif
#______________________________________________________________________________#


##### ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ #####
##                                                                            ##
#  Usage: `make trivy ARGS=""`                                                 #
#  Description: Run trivy with given arguments.                                #
#  Examples:                                                                   #
#    make trivy ARGS="--version"                                               #
#    make trivy ARGS="--help"                                                  #
#    make trivy ARGS="filesystem --help"                                       #
#                                                                              #
.PHONY: trivy
trivy: trivy-install
	$(TRIVY_CMD) $(ARGS)
#______________________________________________________________________________#


##### ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ #####
##                                                                            ##
#  Usage: `make trivy-sbom`                                                    #
#  Description: Generate sbom file using trivy.                                #
#                                                                              #
.PHONY: trivy-sbom
trivy-sbom: trivy-install
	@mkdir -p $(dir $(TRIVY_SBOM_OUTPUT))
	$(TRIVY_CMD) filesystem -f $(TRIVY_SBOM_FORMAT) -o $(TRIVY_SBOM_OUTPUT) \
	$(SBOM_TRIVY_OPTION) $(TRIVY_SBOM_TARGET)
#______________________________________________________________________________#
