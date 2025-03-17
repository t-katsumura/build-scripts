
##### ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ #####
##                                                                            ##
#  Usage: `make list-makefiles`                                                #
#  Description: List all loaded makefiles.                                     #
#                                                                              #
.PHONY: list-makefiles
list-makefiles:
	@for target in $(MAKEFILE_LIST); do \
	echo "> $$target loaded."; \
	done
#______________________________________________________________________________#


##### ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ #####
##                                                                            ##
#  Usage: `make list-helps`                                                    #
#  Description: List all available help targets.                               #
#                                                                              #
.PHONY: help helps list-helps
help helps list-helps:
	@for target in $(INCLUDED); do \
	echo "- \`make $$target-help\` for the $$target.mk."; \
	done
#______________________________________________________________________________#
