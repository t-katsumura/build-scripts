$(shell mkdir -p _bin/)
export GOBIN := $(CURDIR)/_bin/

ifneq (,$(wildcard .env.mk))
  include .env.mk
endif
ifneq (,$(wildcard .env))
  include .env
endif

include _makefiles/asciidoc.mk
include _makefiles/clang-format.mk
include _makefiles/cspell.mk
include _makefiles/drawio.mk
include _makefiles/go-build.mk
include _makefiles/go-licenses.mk
include _makefiles/go-test.mk
include _makefiles/go.mk
include _makefiles/golangci-lint.mk
include _makefiles/govulncheck.mk
include _makefiles/hugo.mk
include _makefiles/markdownlint.mk
include _makefiles/misspell.mk
include _makefiles/nfpm.mk
include _makefiles/prettier.mk
include _makefiles/protolint.mk
include _makefiles/scanoss.mk
include _makefiles/shellcheck.mk
include _makefiles/shfmt.mk
include _makefiles/textlint.mk
include _makefiles/trivy.mk
include _makefiles/util.mk
