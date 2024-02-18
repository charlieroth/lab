package iteration

import (
	"fmt"
	"testing"
)

func ExampleRepeat() {
	fmt.Println(Repeat("a", 5))
	// Output: aaaaa
}

func TestRepeat(t *testing.T) {
	t.Run("repeats the character 'a' 5 times", func(t *testing.T) {
		actual := Repeat("a", 5)
		expected := "aaaaa"

		if actual != expected {
			t.Errorf("expected %s\nactual %s", expected, actual)
		}
	})

	t.Run("repeats the character 'a' 0 times", func(t *testing.T) {
		actual := Repeat("a", 0)
		expected := ""

		if actual != expected {
			t.Errorf("expected %s\nactual %s", expected, actual)
		}
	})
}

func BenchmarkRepeat(b *testing.B) {
	for range b.N {
		Repeat("a", 5)
	}
}
