#!/usr/bin/env bash

set -o errexit
set -o nounset
set -o pipefail

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd -P)"
SCRIPT_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd -P)"

# Import libraries.
source "${SCRIPT_ROOT}/lib/log.sh"
source "${SCRIPT_ROOT}/lib/date.sh"

# Trap signals.
trap 'echo "SIGHUP signal trapped." && log::stacktrace 0' SIGHUP
trap 'echo "SIGINT signal trapped." && log::stacktrace 0' SIGINT
trap 'echo "SIGQUIT signal trapped." && log::stacktrace 0' SIGQUIT
trap 'echo "SIGSEGV signal trapped." && log::stacktrace 0' SIGSEGV
trap 'echo "SIGTERM signal trapped." && log::stacktrace 0' SIGTERM
