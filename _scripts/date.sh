#!/usr/bin/env bash

set -o errexit
set -o nounset
set -o pipefail

# Return sortable datetime.
#
# Usages:
#   log::stack $1
# Args:
#   $1 [number ]
function date::sortable() {
	date "+%Y%m%d-%H%M%S"
}
