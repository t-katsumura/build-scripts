package foo_test

import (
	"testing"

	foo "github.com/t-katsumura/build-scripts/pkg-foo"
)

func TestAdd(t *testing.T) {
	if foo.Add(1, 2) != 3 {
		t.Error("fail")
	}
}

func TestSub(t *testing.T) {
	if foo.Sub(1, 2) != -1 {
		t.Error("fail")
	}
}

func TestReadFile(t *testing.T) {
	s, err := foo.ReadFile("testdata/data.txt")
	if err != nil {
		t.Error(err)
	}
	if s != "foo" {
		t.Error("fail")
	}
}
