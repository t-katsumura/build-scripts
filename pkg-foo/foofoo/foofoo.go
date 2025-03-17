package foofoo

import "os"

// Multiply returns x * y.
func Multiply(x, y int) int {
	return x * y
}

// readFile returns the content of given file.
func readFile(path string) (string, error) {
	b, err := os.ReadFile(path)
	if err != nil {
		return "", err
	}
	return string(b), nil
}
