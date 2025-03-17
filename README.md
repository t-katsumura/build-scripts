# scripts

## [Make Scripts](_Makefile)

### Lint

| Target   | Type                | Tool                                        | Notes                                       |
| :------- | :------------------ | :------------------------------------------ | :------------------------------------------ |
| Go       | lint                | [golangci-lint](_Makefile/golangci-lint.mk) |                                             |
| Go       | license check       | [go-licenses](_Makefile/go-licenses.mk)     |                                             |
| Go       | vulnerability check | [govulncheck](_Makefile/govulncheck.mk)     |                                             |
| Shell    | lint                | [shellcheck](_Makefile/shellcheck.mk)       |                                             |
| Markdown | lint                | [markdownlint](_Makefile/markdownlint.mk)   |                                             |
| \*       | spell check         | [cSpell](_Makefile/cspell.mk)               |                                             |
| \*       | spell check         | [misspell](_Makefile/misspell.mk)           | misspell is also available in golangci-lint |

proto clang
Dockerfile hadolint
K8s Manifest KubeLinter/kube-score

- vulnerability trivy

https://github.com/hadolint/hadolint
https://docs.kubelinter.io/
https://github.com/zegl/kube-score
https://github.com/mrtazz/checkmake

### Format

| Target     | Tool                              | Notes |
| ---------- | --------------------------------- | ----- |
| Go         | [go fmt](_Makefile/go.mk)         |       |
| Shell      | [shfmt](_Makefile/shfmt.mk)       |       |
| Markdown   | [prettier](_Makefile/prettier.mk) |       |
| YAML       | [prettier](_Makefile/prettier.mk) |       |
| JSON       | [prettier](_Makefile/prettier.mk) |       |
| TOML       | [prettier](_Makefile/prettier.mk) |       |
| XML        | [prettier](_Makefile/prettier.mk) |       |
| JavaScript | [prettier](_Makefile/prettier.mk) |       |
| HTML       | [prettier](_Makefile/prettier.mk) |       |
| CSS        | [prettier](_Makefile/prettier.mk) |       |

proto clang
https://github.com/mvdan/sh

### Build

| Target       | Tool                                   | Notes |
| ------------ | -------------------------------------- | ----- |
| Go Binary    | [go build](_Makefile/go-build.mk)      |       |
| Go Container | [docker/ko](_Makefile/go-container.mk) |       |
| Go SBOM      | [trivy](_Makefile/sbom.mk)             |       |

mdbook
pandoc
ascii-doctor

### Test

| Target   | Tool                            | Notes |
| -------- | ------------------------------- | ----- |
| Go Tests | [go test](_Makefile/go-test.mk) |       |

## VSCode Extensions

- [Go in Visual Studio Code](https://code.visualstudio.com/docs/languages/go)
- [Go](https://marketplace.visualstudio.com/items?itemName=golang.go)
- [Prettier - Code formatter](https://marketplace.visualstudio.com/items?itemName=esbenp.prettier-vscode)
- [Code Spell Checker](https://marketplace.visualstudio.com/items?itemName=streetsidesoftware.code-spell-checker)
- [markdownlint](https://marketplace.visualstudio.com/items?itemName=DavidAnson.vscode-markdownlint)
- [ShellCheck](https://marketplace.visualstudio.com/items?itemName=timonwong.shellcheck)
- [trivy](https://marketplace.visualstudio.com/items?itemName=AquaSecurityOfficial.trivy-official)
- [shfmt](https://marketplace.visualstudio.com/items?itemName=mkhl.shfmt)
- [shell-format](https://marketplace.visualstudio.com/items?itemName=foxundermoon.shell-format)
- [clang-format](https://marketplace.visualstudio.com/items?itemName=xaver.clang-format)
- [proto-lint](https://marketplace.visualstudio.com/items?itemName=Plex.vscode-protolint)
