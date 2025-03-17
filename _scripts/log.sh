#!/usr/bin/env bash

set -o errexit
set -o nounset
set -o pipefail

# Print stacktrace.
#
# Usages:
#   log::stacktrace $1
# Args:
#   $1 [number ge 0] The number of stack frames to skip when printing.
function log::stacktrace() {
	local stack_skip=${1:-0}
	stack_skip=$((stack_skip + 1))
	if [[ ${#FUNCNAME[@]} -gt ${stack_skip} ]]; then
		echo "Call stack:" >&2
		local i
		for ((i = 1; i <= ${#FUNCNAME[@]} - stack_skip; i++)); do
			local frame_no=$((i - 1 + stack_skip))
			local source_file=${BASH_SOURCE[${frame_no}]}
			local source_lineno=${BASH_LINENO[$((frame_no - 1))]}
			local funcname=${FUNCNAME[${frame_no}]}
			echo "  ${i}: ${source_file}:${source_lineno} ${funcname}(...)" >&2
		done
	fi
}

# Print info log.
#
# Usages:
#   log::info $@
# Args:
#   $@ [array] Log messages.
function log::info() {
	timestamp=$(date +"[%Y-%m-%d %H:%M:%S]")
	echo "${timestamp}" "INFO" "$@"
}

# Print error log.
#
# Usages:
#   log::error $@
# Args:
#   $@ [array] Log messages.
function log::error() {
	timestamp=$(date +"[%Y-%m-%d %H:%M:%S]")
	echo "${timestamp}" "ERROR" "$@"
}
