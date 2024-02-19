package dependencyinjection

import (
	"bytes"
	"testing"
)

func TestGreet(t *testing.T) {
	buffer := bytes.Buffer{}
	Greet(&buffer, "Charlie")

	actual := buffer.String()
	expected := "Hello, Charlie"

	if actual != expected {
		t.Errorf("expected: %s\n, actual: %s", expected, actual)
	}
}