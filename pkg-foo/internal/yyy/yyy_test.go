package yyy_test

import (
	"testing"

	"github.com/t-katsumura/build-scripts/pkg-foo/internal/yyy"
)

func TestFuncYYY(t *testing.T) {
	if yyy.FuncYYY() != "yyy" {
		t.Error("fail")
	}
}
