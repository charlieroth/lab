package helloworld

import "testing"

func TestHello(t *testing.T) {
	t.Run("saying hello to people", func(t *testing.T) {
		actual, err := Hello("Charlie", "")
		if err != nil {
			t.Error(err)
			return
		}

		expected := "Hello, Charlie"
		if actual != expected {
			t.Errorf("expected %s, actual %s", expected, actual)
		}
	})

	t.Run("say 'Hello, world' when an empty string is supplied", func(t *testing.T) {
		actual, err := Hello("", "")
		if err != nil {
			t.Error(err)
			return
		}

		expected := "Hello, world"
		if actual != expected {
			t.Errorf("expected %s, actual %s", expected, actual)
		}
	})

	t.Run("in Spanish", func(t *testing.T) {
		actual, err := Hello("Carlos", "Spanish")
		if err != nil {
			t.Error(err)
			return
		}

		expected := "Hola, Carlos"
		if actual != expected {
			t.Errorf("expected %s, actual %s", expected, actual)
		}
	})

	t.Run("in French", func(t *testing.T) {
		actual, err := Hello("Charlie", "French")
		if err != nil {
			t.Error(err)
			return
		}

		expected := "Bonjour, Charlie"
		if actual != expected {
			t.Errorf("expected %s, actual %s", expected, actual)
		}
	})
}
