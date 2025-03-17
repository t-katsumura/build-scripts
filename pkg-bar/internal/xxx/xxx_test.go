package xxx_test

import (
	"testing"

	"github.com/t-katsumura/build-scripts/pkg-bar/internal/xxx"
)

func TestFuncXXX(t *testing.T) {
	if xxx.FuncXXX() != "xxx" {
		t.Error("fail")
	}
}
