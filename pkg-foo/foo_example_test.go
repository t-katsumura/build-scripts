package foo_test

import (
	"fmt"

	foo "github.com/t-katsumura/build-scripts/pkg-foo"
)

func ExampleAdd() {
	x, y := 1, 2
	sum := foo.Add(x, y)
	fmt.Println(sum)
	// Output:
	// 3
}
